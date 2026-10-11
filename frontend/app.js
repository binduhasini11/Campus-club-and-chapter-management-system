const API_BASE = "http://127.0.0.1:8000";

const pageTitles = {
    dashboard: "Dashboard",
    students: "Students",
    clubs: "Clubs",
    chapters: "Chapters",
    memberships: "Memberships",
    events: "Events",
    registrations: "Registrations",
    attendance: "Attendance",
    feedback: "Feedback",
    resources: "Resources",
    finance: "Finance & Sponsorships"
};

let cachedData = {};

function escapeHtml(value) {
    return String(value ?? "")
        .replaceAll("&", "&amp;")
        .replaceAll("<", "&lt;")
        .replaceAll(">", "&gt;")
        .replaceAll('"', "&quot;")
        .replaceAll("'", "&#039;");
}

function displayValue(value) {
    return value === null || value === undefined || value === ""
        ? "—"
        : escapeHtml(value);
}

function notify(message, type = "success") {
    const element = document.getElementById("notification");

    element.textContent = message;
    element.className = `notification ${type}`;

    window.scrollTo({ top: 0, behavior: "smooth" });

    setTimeout(() => {
        element.className = "notification hidden";
    }, 4500);
}

async function apiRequest(path, options = {}) {
    let response;

    try {
        response = await fetch(`${API_BASE}${path}`, {
            ...options,
            headers: {
                ...(options.body ? {
                    "Content-Type": "application/json"
                } : {}),
                ...options.headers
            }
        });
    } catch {
        throw new Error(
            "Cannot connect to the backend. Check whether FastAPI is running."
        );
    }

    const result = await response.json().catch(() => ({}));

    if (!response.ok) {
        const detail = result.detail;

        const message = Array.isArray(detail)
            ? detail.map(item => item.msg).join(", ")
            : detail || "The request failed.";

        throw new Error(message);
    }

    return result;
}

async function getData(path, key) {
    const result = await apiRequest(path);
    const rows = result[key] || [];

    cachedData[key] = rows;

    return rows;
}

function renderTable(containerId, rows, columns) {
    const container = document.getElementById(containerId);

    if (!container) return;

    if (!rows || rows.length === 0) {
        container.innerHTML =
            '<div class="empty-message">No records available.</div>';
        return;
    }

    const headings = columns.map(column =>
        `<th>${escapeHtml(column.label)}</th>`
    ).join("");

    const body = rows.map(row => `
        <tr>
            ${columns.map(column => `
                <td>${displayValue(row[column.key])}</td>
            `).join("")}
        </tr>
    `).join("");

    container.innerHTML = `
        <table>
            <thead><tr>${headings}</tr></thead>
            <tbody>${body}</tbody>
        </table>
    `;
}

function setOptions(elementId, rows, valueKey, labelFunction, placeholder) {
    const select = document.getElementById(elementId);

    if (!select) return;

    const previousValue = select.value;

    select.innerHTML = `
        <option value="">${escapeHtml(placeholder)}</option>
        ${rows.map(row => `
            <option value="${escapeHtml(row[valueKey])}">
                ${escapeHtml(labelFunction(row))}
            </option>
        `).join("")}
    `;

    if (rows.some(row => String(row[valueKey]) === previousValue)) {
        select.value = previousValue;
    }
}

async function loadDashboard() {
    const [summary, events] = await Promise.all([
        apiRequest("/dashboard"),
        getData("/events", "events")
    ]);

    document.getElementById("stat-students").textContent =
        summary.students;

    document.getElementById("stat-clubs").textContent =
        summary.clubs;

    document.getElementById("stat-chapters").textContent =
        summary.chapters;

    document.getElementById("stat-events").textContent =
        summary.events;

    document.getElementById("stat-memberships").textContent =
        summary.memberships;

    document.getElementById("stat-registrations").textContent =
        summary.registrations;

    renderTable("dashboard-events", events, [
        { key: "event_name", label: "Event" },
        { key: "club_name", label: "Club" },
        { key: "event_date", label: "Date" },
        { key: "venue_name", label: "Venue" },
        { key: "event_status", label: "Status" }
    ]);
}

async function loadPageData(page) {
    const loaders = {
        students: async () => {
            const rows = await getData("/students", "students");

            renderTable("students-content", rows, [
                { key: "student_id", label: "Student ID" },
                { key: "student_name", label: "Name" },
                { key: "email", label: "Email" },
                { key: "phone", label: "Phone" },
                { key: "department", label: "Department" },
                { key: "year_of_study", label: "Year" }
            ]);
        },

        clubs: async () => {
            const rows = await getData("/clubs", "clubs");

            renderTable("clubs-content", rows, [
                { key: "club_id", label: "Club ID" },
                { key: "club_name", label: "Club Name" },
                { key: "category", label: "Category" },
                { key: "status", label: "Status" },
                { key: "date_established", label: "Established" },
                { key: "description", label: "Description" }
            ]);

            setOptions(
                "membership-club",
                rows,
                "club_id",
                row => `${row.club_name} (${row.club_id})`,
                "Select a club"
            );

            setOptions(
                "event-club",
                rows,
                "club_id",
                row => `${row.club_name} (${row.club_id})`,
                "Select a club"
            );
        },

        chapters: async () => {
            const rows = await getData("/chapters", "chapters");

            renderTable("chapters-content", rows, [
                { key: "chapter_id", label: "Chapter ID" },
                { key: "chapter_name", label: "Chapter Name" },
                { key: "club_name", label: "Club" },
                { key: "faculty_coordinator", label: "Faculty Coordinator" },
                { key: "establishment_date", label: "Established" }
            ]);
        },

        memberships: async () => {
            const rows = await getData("/memberships", "memberships");

            renderTable("memberships-content", rows, [
                { key: "membership_id", label: "Membership ID" },
                { key: "student_name", label: "Student" },
                { key: "club_name", label: "Club" },
                { key: "role_name", label: "Role" },
                { key: "join_date", label: "Join Date" },
                { key: "membership_status", label: "Status" }
            ]);
        },

        events: async () => {
            const rows = await getData("/events", "events");

            renderTable("events-content", rows, [
                { key: "event_id", label: "Event ID" },
                { key: "event_name", label: "Event" },
                { key: "club_name", label: "Club" },
                { key: "event_date", label: "Date" },
                { key: "venue_name", label: "Venue" },
                { key: "capacity", label: "Capacity" },
                { key: "event_status", label: "Status" }
            ]);

            setOptions(
                "registration-event",
                rows,
                "event_id",
                row => `${row.event_name} (${row.event_id})`,
                "Select an event"
            );

            setOptions(
                "feedback-event",
                rows,
                "event_id",
                row => `${row.event_name} (${row.event_id})`,
                "Select an event"
            );
        },

        registrations: async () => {
            const rows = await getData(
                "/registrations",
                "registrations"
            );

            renderTable("registrations-content", rows, [
                { key: "registration_id", label: "Registration ID" },
                { key: "student_name", label: "Student" },
                { key: "event_name", label: "Event" },
                { key: "registration_date", label: "Date" },
                { key: "registration_status", label: "Status" }
            ]);

            setOptions(
                "attendance-registration",
                rows,
                "registration_id",
                row => `${row.student_name} — ${row.event_name} (#${row.registration_id})`,
                "Select a registration"
            );
        },

        attendance: async () => {
            const rows = await getData("/attendance", "attendance");

            renderTable("attendance-content", rows, [
                { key: "attendance_id", label: "Attendance ID" },
                { key: "registration_id", label: "Registration ID" },
                { key: "student_name", label: "Student" },
                { key: "event_name", label: "Event" },
                { key: "attendance_status", label: "Status" },
                { key: "check_in_time", label: "Check-in Time" }
            ]);
        },

        feedback: async () => {
            const rows = await getData("/feedback", "feedback");

            renderTable("feedback-content", rows, [
                { key: "feedback_id", label: "Feedback ID" },
                { key: "student_name", label: "Student" },
                { key: "event_name", label: "Event" },
                { key: "rating", label: "Rating" },
                { key: "comments", label: "Comments" },
                { key: "feedback_date", label: "Date" }
            ]);
        },

        resources: async () => {
            const [resources, bookings] = await Promise.all([
                getData("/resources", "resources"),
                getData("/resource-bookings", "resource_bookings")
            ]);

            renderTable("resources-content", resources, [
                { key: "resource_id", label: "Resource ID" },
                { key: "resource_name", label: "Resource" },
                { key: "resource_type", label: "Type" },
                { key: "quantity_available", label: "Quantity" },
                { key: "condition_status", label: "Condition" }
            ]);

            renderTable("resource-bookings-content", bookings, [
                { key: "booking_id", label: "Booking ID" },
                { key: "resource_name", label: "Resource" },
                { key: "event_name", label: "Event" },
                { key: "quantity", label: "Quantity" },
                { key: "booking_start", label: "Start" },
                { key: "booking_end", label: "End" },
                { key: "booking_status", label: "Status" }
            ]);
        },

        finance: async () => {
            const [budgets, expenses, sponsors, sponsorships] =
                await Promise.all([
                    getData("/budgets", "budgets"),
                    getData("/expenses", "expenses"),
                    getData("/sponsors", "sponsors"),
                    getData("/sponsorships", "sponsorships")
                ]);

            renderTable("budgets-content", budgets, [
                { key: "budget_id", label: "Budget ID" },
                { key: "club_name", label: "Club" },
                { key: "academic_year", label: "Academic Year" },
                { key: "allocated_amount", label: "Allocated" },
                { key: "remaining_amount", label: "Remaining" }
            ]);

            renderTable("expenses-content", expenses, [
                { key: "expense_id", label: "Expense ID" },
                { key: "club_name", label: "Club" },
                { key: "event_name", label: "Event" },
                { key: "expense_date", label: "Date" },
                { key: "amount", label: "Amount" },
                { key: "description", label: "Description" }
            ]);

            renderTable("sponsors-content", sponsors, [
                { key: "sponsor_id", label: "Sponsor ID" },
                { key: "sponsor_name", label: "Sponsor" },
                { key: "contact_person", label: "Contact Person" },
                { key: "email", label: "Email" },
                { key: "phone", label: "Phone" }
            ]);

            renderTable("sponsorships-content", sponsorships, [
                { key: "sponsorship_id", label: "Sponsorship ID" },
                { key: "sponsor_name", label: "Sponsor" },
                { key: "club_name", label: "Club" },
                { key: "event_name", label: "Event" },
                { key: "amount", label: "Amount" },
                { key: "sponsorship_date", label: "Date" }
            ]);
        }
    };

    try {
        if (loaders[page]) {
            await loaders[page]();
        }
    } catch (error) {
        notify(error.message, "error");
    }
}

async function loadDropdowns() {
    try {
        const [students, clubs, roles, venues] = await Promise.all([
            getData("/students", "students"),
            getData("/clubs", "clubs"),
            apiRequest("/roles").then(result => result.roles || []),
            apiRequest("/venues").then(result => result.venues || [])
        ]);

        setOptions(
            "membership-student",
            students,
            "student_id",
            row => `${row.student_name} (${row.student_id})`,
            "Select a student"
        );

        setOptions(
            "registration-student",
            students,
            "student_id",
            row => `${row.student_name} (${row.student_id})`,
            "Select a student"
        );

        setOptions(
            "feedback-student",
            students,
            "student_id",
            row => `${row.student_name} (${row.student_id})`,
            "Select a student"
        );

        setOptions(
            "membership-club",
            clubs,
            "club_id",
            row => `${row.club_name} (${row.club_id})`,
            "Select a club"
        );

        setOptions(
            "event-club",
            clubs,
            "club_id",
            row => `${row.club_name} (${row.club_id})`,
            "Select a club"
        );

        setOptions(
            "membership-role",
            roles,
            "role_id",
            row => `${row.role_name} (${row.role_id})`,
            "Select a role"
        );

        setOptions(
            "event-venue",
            venues,
            "venue_id",
            row => `${row.venue_name} (${row.venue_id})`,
            "Select a venue"
        );

    } catch (error) {
        notify(`Unable to load form options: ${error.message}`, "error");
    }
}

async function submitForm(event, endpoint, refreshPages, transform = data => data) {
    event.preventDefault();

    const form = event.currentTarget;
    const formData = new FormData(form);
    const data = Object.fromEntries(formData.entries());

    try {
        await apiRequest(endpoint, {
            method: "POST",
            body: JSON.stringify(transform(data))
        });

        form.reset();

        notify("Operation completed successfully.");

        await Promise.all(
            refreshPages.map(page => loadPageData(page))
        );

        await loadDashboard();
        await loadDropdowns();

    } catch (error) {
        notify(error.message, "error");
    }
}

function navigateTo(page) {
    document.querySelectorAll(".page").forEach(section => {
        section.classList.toggle("active", section.id === page);
    });

    document.querySelectorAll(".nav-item").forEach(button => {
        button.classList.toggle(
            "active",
            button.dataset.page === page
        );
    });

    document.getElementById("page-title").textContent =
        pageTitles[page] || "Dashboard";

    if (page === "dashboard") {
        loadDashboard().catch(error => notify(error.message, "error"));
    } else {
        loadPageData(page);
    }
}

document.querySelectorAll(".nav-item").forEach(button => {
    button.addEventListener("click", () => {
        navigateTo(button.dataset.page);
    });
});

document.getElementById("club-form").addEventListener("submit", event => {
    submitForm(event, "/clubs", ["clubs"]);
});

document.getElementById("membership-form").addEventListener("submit", event => {
    submitForm(event, "/memberships", ["memberships"]);
});

document.getElementById("event-form").addEventListener("submit", event => {
    submitForm(event, "/events", ["events"]);
});

document.getElementById("registration-form").addEventListener("submit", event => {
    submitForm(event, "/registrations", ["registrations"]);
});

document.getElementById("attendance-form").addEventListener("submit", event => {
    submitForm(event, "/attendance", ["attendance"]);
});

document.getElementById("feedback-form").addEventListener("submit", event => {
    submitForm(event, "/feedback", ["feedback"]);
});

async function checkConnection() {
    const text = document.getElementById("connection-text");
    const dot = document.querySelector(".status-dot");

    try {
        await apiRequest("/health");
        text.textContent = "Backend connected";
        dot.classList.add("online");
        dot.classList.remove("offline");
    } catch {
        text.textContent = "Backend disconnected";
        dot.classList.add("offline");
        dot.classList.remove("online");
    }
}

async function initializeApp() {
    await checkConnection();
    await loadDropdowns();

    try {
        await loadDashboard();
    } catch (error) {
        notify(error.message, "error");
    }
}

initializeApp();