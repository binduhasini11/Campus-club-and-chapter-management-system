-- ============================================================
-- CAMPUS CLUB AND CHAPTER MANAGEMENT SYSTEM
-- File: 02_create_views.sql
-- Purpose: Create reusable database views
-- Database: Oracle Database 26ai Free
-- ============================================================


-- VIEW 1: Student Membership Details
-- Displays each student's club membership and role.

CREATE OR REPLACE VIEW V_STUDENT_MEMBERSHIPS AS
SELECT
    s.student_id,
    s.student_name,
    s.email,
    c.club_id,
    c.club_name,
    r.role_name,
    m.join_date,
    m.membership_status
FROM STUDENT s
JOIN MEMBERSHIP m
    ON s.student_id = m.student_id
JOIN CLUB c
    ON m.club_id = c.club_id
JOIN ROLE r
    ON m.role_id = r.role_id;


-- VIEW 2: Event Details
-- Displays event information along with club and venue details.

CREATE OR REPLACE VIEW V_EVENT_DETAILS AS
SELECT
    e.event_id,
    e.event_name,
    e.description,
    c.club_name,
    v.venue_name,
    v.location,
    e.event_date,
    e.start_time,
    e.end_time,
    e.capacity,
    e.event_status
FROM EVENT e
JOIN CLUB c
    ON e.club_id = c.club_id
JOIN VENUE v
    ON e.venue_id = v.venue_id;


-- VIEW 3: Event Attendance Details
-- Includes registered students even when attendance
-- has not yet been recorded.

CREATE OR REPLACE VIEW V_EVENT_ATTENDANCE AS
SELECT
    r.registration_id,
    s.student_id,
    s.student_name,
    e.event_id,
    e.event_name,
    r.registration_date,
    r.registration_status,
    a.attendance_status,
    a.check_in_time
FROM REGISTRATION r
JOIN STUDENT s
    ON r.student_id = s.student_id
JOIN EVENT e
    ON r.event_id = e.event_id
LEFT JOIN ATTENDANCE a
    ON r.registration_id = a.registration_id;


-- VIEW 4: Club Budget Summary
-- Displays allocated budgets, remaining budgets
-- and recorded expenses for each club budget.

CREATE OR REPLACE VIEW V_CLUB_BUDGET_SUMMARY AS
SELECT
    c.club_id,
    c.club_name,
    b.budget_id,
    b.academic_year,
    b.allocated_amount,
    b.remaining_amount,
    NVL(SUM(ex.amount), 0) AS total_expenses
FROM CLUB c
JOIN BUDGET b
    ON c.club_id = b.club_id
LEFT JOIN EXPENSE ex
    ON b.budget_id = ex.budget_id
GROUP BY
    c.club_id,
    c.club_name,
    b.budget_id,
    b.academic_year,
    b.allocated_amount,
    b.remaining_amount;


-- VIEW 5: Event Feedback Summary
-- Displays the number of feedback responses and
-- average rating for every event, including events
-- that have not received feedback.

CREATE OR REPLACE VIEW V_EVENT_FEEDBACK_SUMMARY AS
SELECT
    e.event_id,
    e.event_name,
    COUNT(f.feedback_id) AS total_feedback,
    ROUND(AVG(f.rating), 2) AS average_rating
FROM EVENT e
LEFT JOIN FEEDBACK f
    ON e.event_id = f.event_id
GROUP BY
    e.event_id,
    e.event_name;
