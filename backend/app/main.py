from fastapi.middleware.cors import CORSMiddleware
from datetime import date, datetime
from decimal import Decimal
from typing import Optional

from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel, Field

from app.database import get_connection


app = FastAPI(
    title="Club and Chapter Management System",
    description="API for managing students, clubs, chapters, events, and related activities.",
    version="1.0.0",
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://127.0.0.1:5500",
        "http://localhost:5500",
        "http://127.0.0.1:5501",
        "http://localhost:5501",
    ],
    allow_credentials=False,
    allow_methods=["GET", "POST", "OPTIONS"],
    allow_headers=["Content-Type"],
)

# --------------------------------------------------
# DATABASE HELPERS
# --------------------------------------------------

def serialize_value(value):
    """Convert Oracle values into JSON-compatible values."""
    if isinstance(value, (datetime, date)):
        return value.isoformat()
    if isinstance(value, Decimal):
        return float(value)
    return value


def fetch_all(cursor):
    """Convert query results into a list of dictionaries."""
    columns = [column[0].lower() for column in cursor.description]
    return [
        {
            column: serialize_value(value)
            for column, value in zip(columns, row)
        }
        for row in cursor.fetchall()
    ]


def fetch_one(cursor):
    """Convert one query result into a dictionary."""
    row = cursor.fetchone()
    if row is None:
        return None

    columns = [column[0].lower() for column in cursor.description]
    return {
        column: serialize_value(value)
        for column, value in zip(columns, row)
    }


def run_query(query, params=None, fetch="all"):
    """Execute a read-only query and return its results."""
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(query, params or {})

            if fetch == "one":
                return fetch_one(cursor)

            return fetch_all(cursor)

    except Exception:
        # Keep database details out of public API responses.
        raise HTTPException(
            status_code=500,
            detail="A database operation failed.",
        )

    finally:
        if connection is not None:
            connection.close()


def run_insert(query, params, return_id=False):
    """Execute an INSERT and commit only after successful execution."""
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            if return_id:
                output_id = cursor.var(int)
                cursor.execute(
                    query,
                    {**params, "new_id": output_id},
                )
                created_id = output_id.getvalue()
            else:
                cursor.execute(query, params)
                created_id = None

        connection.commit()
        return created_id

    except Exception as error:
        if connection is not None:
            connection.rollback()

        error_text = str(error)

        if "ORA-00001" in error_text:
            raise HTTPException(
                status_code=409,
                detail="A record with a duplicate unique value already exists.",
            )

        if "ORA-02291" in error_text:
            raise HTTPException(
                status_code=400,
                detail="A referenced student, club, event, or other record does not exist.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to save the record.",
        )

    finally:
        if connection is not None:
            connection.close()


# --------------------------------------------------
# INPUT MODELS
# --------------------------------------------------

class ClubCreate(BaseModel):
    club_name: str = Field(min_length=1, max_length=100)
    description: Optional[str] = Field(default=None, max_length=500)
    category: Optional[str] = Field(default=None, max_length=50)
    date_established: Optional[date] = None
    status: Optional[str] = Field(default="Active", max_length=20)


class MembershipCreate(BaseModel):
    student_id: int
    club_id: int
    role_id: int
    join_date: date
    end_date: Optional[date] = None
    membership_status: str = Field(default="Active", max_length=20)


class EventCreate(BaseModel):
    event_name: str = Field(min_length=1, max_length=150)
    description: Optional[str] = Field(default=None, max_length=500)
    event_date: Optional[date] = None
    start_time: Optional[datetime] = None
    end_time: Optional[datetime] = None
    capacity: Optional[int] = Field(default=None, ge=1, le=999999)
    event_status: Optional[str] = Field(default="Planned", max_length=30)
    club_id: int
    venue_id: int


class RegistrationCreate(BaseModel):
    student_id: int
    event_id: int


class AttendanceCreate(BaseModel):
    registration_id: int
    attendance_status: str = Field(pattern=r"^(Present|Absent)$")


class FeedbackCreate(BaseModel):
    student_id: int
    event_id: int
    rating: int = Field(ge=1, le=5)
    comments: Optional[str] = Field(default=None, max_length=1000)


# --------------------------------------------------
# GENERAL
# --------------------------------------------------

@app.get("/")
def home():
    return {
        "message": "Club and Chapter Management System API is running."
    }


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.get("/dashboard")
def dashboard():
    """Return summary counts from the Oracle database."""
    query = """
        SELECT
            (SELECT COUNT(*) FROM STUDENT) AS students,
            (SELECT COUNT(*) FROM CLUB) AS clubs,
            (SELECT COUNT(*) FROM CHAPTER) AS chapters,
            (SELECT COUNT(*) FROM EVENT) AS events,
            (SELECT COUNT(*) FROM MEMBERSHIP) AS memberships,
            (SELECT COUNT(*) FROM REGISTRATION) AS registrations
        FROM DUAL
    """
    return run_query(query, fetch="one")


# --------------------------------------------------
# STUDENTS
# --------------------------------------------------

@app.get("/students")
def get_students():
    query = """
        SELECT student_id, student_name, email, phone,
               department, year_of_study
        FROM STUDENT
        ORDER BY student_id
    """
    return {"students": run_query(query)}


# --------------------------------------------------
# CLUBS AND CHAPTERS
# --------------------------------------------------

@app.get("/clubs")
def get_clubs():
    query = """
        SELECT club_id, club_name, description, category,
               date_established, status
        FROM CLUB
        ORDER BY club_id
    """
    return {"clubs": run_query(query)}


@app.post("/clubs", status_code=201)
def create_club(club: ClubCreate):
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT NVL(MAX(club_id), 200) + 1 FROM CLUB"
            )
            new_id = cursor.fetchone()[0]

            cursor.execute(
                """
                INSERT INTO CLUB (
                    club_id, club_name, description,
                    category, date_established, status
                )
                VALUES (
                    :club_id, :club_name, :description,
                    :category, :date_established, :status
                )
                """,
                {
                    "club_id": new_id,
                    "club_name": club.club_name.strip(),
                    "description": club.description,
                    "category": club.category,
                    "date_established": club.date_established,
                    "status": club.status,
                },
            )

        connection.commit()

        return {
            "message": "Club created successfully.",
            "club_id": new_id,
        }

    except Exception as error:
        if connection is not None:
            connection.rollback()

        if "ORA-00001" in str(error):
            raise HTTPException(
                status_code=409,
                detail="The club ID or club name already exists.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to create club.",
        )

    finally:
        if connection is not None:
            connection.close()


@app.get("/chapters")
def get_chapters():
    query = """
        SELECT ch.chapter_id, ch.chapter_name,
               ch.faculty_coordinator, ch.establishment_date,
               ch.club_id, c.club_name
        FROM CHAPTER ch
        LEFT JOIN CLUB c ON c.club_id = ch.club_id
        ORDER BY ch.chapter_id
    """
    return {"chapters": run_query(query)}


# --------------------------------------------------
# MEMBERSHIPS
# --------------------------------------------------

@app.get("/memberships")
def get_memberships():
    query = """
        SELECT m.membership_id, m.student_id, s.student_name,
               m.club_id, c.club_name,
               m.role_id, r.role_name,
               m.join_date, m.end_date, m.membership_status
        FROM MEMBERSHIP m
        JOIN STUDENT s ON s.student_id = m.student_id
        JOIN CLUB c ON c.club_id = m.club_id
        JOIN ROLE r ON r.role_id = m.role_id
        ORDER BY m.membership_id
    """
    return {"memberships": run_query(query)}


@app.post("/memberships", status_code=201)
def create_membership(membership: MembershipCreate):
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT NVL(MAX(membership_id), 500) + 1 FROM MEMBERSHIP"
            )
            new_id = cursor.fetchone()[0]

            cursor.execute(
                """
                INSERT INTO MEMBERSHIP (
                    membership_id, student_id, club_id, role_id,
                    join_date, end_date, membership_status
                )
                VALUES (
                    :membership_id, :student_id, :club_id, :role_id,
                    :join_date, :end_date, :membership_status
                )
                """,
                {
                    "membership_id": new_id,
                    **membership.model_dump(),
                },
            )

        connection.commit()
        return {
            "message": "Membership created successfully.",
            "membership_id": new_id,
        }

    except Exception as error:
        if connection is not None:
            connection.rollback()

        if "ORA-02291" in str(error):
            raise HTTPException(
                status_code=400,
                detail="The student, club, or role does not exist.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to create membership.",
        )

    finally:
        if connection is not None:
            connection.close()


# --------------------------------------------------
# EVENTS
# --------------------------------------------------

@app.get("/events")
def get_events():
    query = """
        SELECT e.event_id, e.event_name, e.description,
               e.event_date, e.start_time, e.end_time,
               e.capacity, e.event_status,
               e.club_id, c.club_name,
               e.venue_id, v.venue_name, v.location
        FROM EVENT e
        JOIN CLUB c ON c.club_id = e.club_id
        JOIN VENUE v ON v.venue_id = e.venue_id
        ORDER BY e.event_id
    """
    return {"events": run_query(query)}


@app.post("/events", status_code=201)
def create_event(event: EventCreate):
    if (
        event.start_time is not None
        and event.end_time is not None
        and event.end_time <= event.start_time
    ):
        raise HTTPException(
            status_code=422,
            detail="Event end time must be after its start time.",
        )

    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT NVL(MAX(event_id), 700) + 1 FROM EVENT"
            )
            new_id = cursor.fetchone()[0]

            cursor.execute(
                """
                INSERT INTO EVENT (
                    event_id, event_name, description, event_date,
                    start_time, end_time, capacity, event_status,
                    club_id, venue_id
                )
                VALUES (
                    :event_id, :event_name, :description, :event_date,
                    :start_time, :end_time, :capacity, :event_status,
                    :club_id, :venue_id
                )
                """,
                {
                    "event_id": new_id,
                    **event.model_dump(),
                },
            )

        connection.commit()

        return {
            "message": "Event created successfully.",
            "event_id": new_id,
        }

    except Exception as error:
        if connection is not None:
            connection.rollback()

        if "ORA-02291" in str(error):
            raise HTTPException(
                status_code=400,
                detail="The selected club or venue does not exist.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to create event.",
        )

    finally:
        if connection is not None:
            connection.close()


# --------------------------------------------------
# REGISTRATIONS AND ATTENDANCE
# --------------------------------------------------

@app.get("/registrations")
def get_registrations():
    query = """
        SELECT r.registration_id, r.student_id, s.student_name,
               r.event_id, e.event_name,
               r.registration_date, r.registration_status
        FROM REGISTRATION r
        JOIN STUDENT s ON s.student_id = r.student_id
        JOIN EVENT e ON e.event_id = r.event_id
        ORDER BY r.registration_id
    """
    return {"registrations": run_query(query)}


@app.post("/registrations", status_code=201)
def create_registration(registration: RegistrationCreate):
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT NVL(MAX(registration_id), 800) + 1
                FROM REGISTRATION
                """
            )
            new_id = cursor.fetchone()[0]

            cursor.execute(
                """
                INSERT INTO REGISTRATION (
                    registration_id, student_id, event_id,
                    registration_date, registration_status
                )
                VALUES (
                    :registration_id, :student_id, :event_id,
                    SYSDATE, 'Registered'
                )
                """,
                {
                    "registration_id": new_id,
                    **registration.model_dump(),
                },
            )

        connection.commit()

        return {
            "message": "Student registered successfully.",
            "registration_id": new_id,
        }

    except Exception as error:
        if connection is not None:
            connection.rollback()

        error_text = str(error)

        if "ORA-20011" in error_text:
            raise HTTPException(
                status_code=409,
                detail="The event has reached its registration capacity.",
            )

        if "ORA-02291" in error_text:
            raise HTTPException(
                status_code=400,
                detail="The student or event does not exist.",
            )

        if "ORA-00001" in error_text:
            raise HTTPException(
                status_code=409,
                detail="The registration ID already exists.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to register student.",
        )

    finally:
        if connection is not None:
            connection.close()


@app.get("/attendance")
def get_attendance():
    query = """
        SELECT a.attendance_id, a.registration_id,
               s.student_name, e.event_name,
               a.attendance_status, a.check_in_time
        FROM ATTENDANCE a
        JOIN REGISTRATION r ON r.registration_id = a.registration_id
        JOIN STUDENT s ON s.student_id = r.student_id
        JOIN EVENT e ON e.event_id = r.event_id
        ORDER BY a.attendance_id
    """
    return {"attendance": run_query(query)}


@app.post("/attendance", status_code=201)
def record_attendance(attendance: AttendanceCreate):
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT attendance_id
                FROM ATTENDANCE
                WHERE registration_id = :registration_id
                """,
                {"registration_id": attendance.registration_id},
            )
            existing = cursor.fetchone()

            if existing:
                cursor.execute(
                    """
                    UPDATE ATTENDANCE
                    SET attendance_status = :attendance_status,
                        check_in_time = CASE
                            WHEN :attendance_status = 'Present'
                            THEN SYSTIMESTAMP
                            ELSE NULL
                        END
                    WHERE registration_id = :registration_id
                    """,
                    {
                        **attendance.model_dump(),
                    },
                )
                attendance_id = existing[0]
            else:
                cursor.execute(
                    "SELECT NVL(MAX(attendance_id), 900) + 1 FROM ATTENDANCE"
                )
                attendance_id = cursor.fetchone()[0]

                cursor.execute(
                    """
                    INSERT INTO ATTENDANCE (
                        attendance_id, registration_id,
                        attendance_status, check_in_time
                    )
                    VALUES (
                        :attendance_id, :registration_id,
                        :attendance_status,
                        CASE
                            WHEN :attendance_status = 'Present'
                            THEN SYSTIMESTAMP
                            ELSE NULL
                        END
                    )
                    """,
                    {
                        "attendance_id": attendance_id,
                        **attendance.model_dump(),
                    },
                )

        connection.commit()

        return {
            "message": "Attendance saved successfully.",
            "attendance_id": attendance_id,
        }

    except Exception as error:
        if connection is not None:
            connection.rollback()

        if "ORA-02291" in str(error):
            raise HTTPException(
                status_code=400,
                detail="The registration does not exist.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to save attendance.",
        )

    finally:
        if connection is not None:
            connection.close()


# --------------------------------------------------
# FEEDBACK
# --------------------------------------------------

@app.get("/feedback")
def get_feedback():
    query = """
        SELECT f.feedback_id, f.student_id, s.student_name,
               f.event_id, e.event_name,
               f.rating, f.comments, f.feedback_date
        FROM FEEDBACK f
        JOIN STUDENT s ON s.student_id = f.student_id
        JOIN EVENT e ON e.event_id = f.event_id
        ORDER BY f.feedback_id
    """
    return {"feedback": run_query(query)}


@app.post("/feedback", status_code=201)
def create_feedback(feedback: FeedbackCreate):
    connection = None

    try:
        connection = get_connection()

        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT NVL(MAX(feedback_id), 1000) + 1 FROM FEEDBACK"
            )
            new_id = cursor.fetchone()[0]

            cursor.execute(
                """
                INSERT INTO FEEDBACK (
                    feedback_id, student_id, event_id,
                    rating, comments, feedback_date
                )
                VALUES (
                    :feedback_id, :student_id, :event_id,
                    :rating, :comments, SYSDATE
                )
                """,
                {
                    "feedback_id": new_id,
                    **feedback.model_dump(),
                },
            )

        connection.commit()

        return {
            "message": "Feedback submitted successfully.",
            "feedback_id": new_id,
        }

    except Exception as error:
        if connection is not None:
            connection.rollback()

        if "ORA-02291" in str(error):
            raise HTTPException(
                status_code=400,
                detail="The student or event does not exist.",
            )

        raise HTTPException(
            status_code=500,
            detail="Unable to submit feedback.",
        )

    finally:
        if connection is not None:
            connection.close()


# --------------------------------------------------
# RESOURCES AND RESOURCE BOOKINGS
# --------------------------------------------------

@app.get("/resources")
def get_resources():
    query = """
        SELECT resource_id, resource_name, resource_type,
               quantity_available, condition_status
        FROM "RESOURCE"
        ORDER BY resource_id
    """
    return {"resources": run_query(query)}


@app.get("/resource-bookings")
def get_resource_bookings():
    query = """
        SELECT rb.booking_id, rb.resource_id, r.resource_name,
               rb.event_id, e.event_name, rb.quantity,
               rb.booking_start, rb.booking_end, rb.booking_status
        FROM RESOURCE_BOOKING rb
        JOIN "RESOURCE" r ON r.resource_id = rb.resource_id
        JOIN EVENT e ON e.event_id = rb.event_id
        ORDER BY rb.booking_id
    """
    return {"resource_bookings": run_query(query)}


# --------------------------------------------------
# BUDGETS, EXPENSES AND SPONSORSHIPS
# --------------------------------------------------

@app.get("/budgets")
def get_budgets():
    query = """
        SELECT b.budget_id, b.club_id, c.club_name,
               b.academic_year, b.allocated_amount, b.remaining_amount
        FROM BUDGET b
        JOIN CLUB c ON c.club_id = b.club_id
        ORDER BY b.budget_id
    """
    return {"budgets": run_query(query)}


@app.get("/expenses")
def get_expenses():
    query = """
        SELECT ex.expense_id, ex.budget_id, b.club_id,
               c.club_name, ex.event_id, e.event_name,
               ex.expense_date, ex.amount, ex.description
        FROM EXPENSE ex
        JOIN BUDGET b ON b.budget_id = ex.budget_id
        JOIN CLUB c ON c.club_id = b.club_id
        LEFT JOIN EVENT e ON e.event_id = ex.event_id
        ORDER BY ex.expense_id
    """
    return {"expenses": run_query(query)}


@app.get("/sponsors")
def get_sponsors():
    query = """
        SELECT sponsor_id, sponsor_name, contact_person, email, phone
        FROM SPONSOR
        ORDER BY sponsor_id
    """
    return {"sponsors": run_query(query)}


@app.get("/sponsorships")
def get_sponsorships():
    query = """
        SELECT sp.sponsorship_id, sp.sponsor_id, s.sponsor_name,
               sp.club_id, c.club_name,
               sp.event_id, e.event_name,
               sp.amount, sp.sponsorship_date
        FROM SPONSORSHIP sp
        JOIN SPONSOR s ON s.sponsor_id = sp.sponsor_id
        JOIN CLUB c ON c.club_id = sp.club_id
        JOIN EVENT e ON e.event_id = sp.event_id
        ORDER BY sp.sponsorship_id
    """
    return {"sponsorships": run_query(query)}

@app.get("/roles")
def get_roles():
    query = """
        SELECT role_id, role_name, description
        FROM ROLE
        ORDER BY role_id
    """
    return {"roles": run_query(query)}


@app.get("/venues")
def get_venues():
    query = """
        SELECT venue_id, venue_name, location, capacity, venue_type
        FROM VENUE
        ORDER BY venue_id
    """
    return {"venues": run_query(query)}