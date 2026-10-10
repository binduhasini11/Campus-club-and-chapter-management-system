-- ============================================================
-- CAMPUS CLUB AND CHAPTER MANAGEMENT SYSTEM
-- File: 01_basic_queries.sql
-- Purpose: Basic SQL queries and reports
-- Database: Oracle Database 26ai Free
-- ============================================================


-- QUERY 1: Display students and their club memberships
-- Demonstrates: INNER JOIN across four tables

SELECT
    s.student_id,
    s.student_name,
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
    ON m.role_id = r.role_id
ORDER BY s.student_id;


-- QUERY 2: Display events with their clubs and venues
-- Demonstrates: Multiple INNER JOINs

SELECT
    e.event_id,
    e.event_name,
    c.club_name,
    v.venue_name,
    v.location,
    e.event_date,
    e.capacity,
    e.event_status
FROM EVENT e
JOIN CLUB c
    ON e.club_id = c.club_id
JOIN VENUE v
    ON e.venue_id = v.venue_id
ORDER BY e.event_date;


-- QUERY 3: Display event registrations and attendance
-- Demonstrates: LEFT JOIN to include registrations
-- even when no attendance record exists

SELECT
    s.student_id,
    s.student_name,
    e.event_name,
    r.registration_status,
    a.attendance_status,
    a.check_in_time
FROM STUDENT s
JOIN REGISTRATION r
    ON s.student_id = r.student_id
JOIN EVENT e
    ON r.event_id = e.event_id
LEFT JOIN ATTENDANCE a
    ON r.registration_id = a.registration_id
ORDER BY e.event_id, s.student_id;


-- QUERY 4: Compare club budgets with recorded expenses
-- Demonstrates: LEFT JOIN, SUM, NVL, GROUP BY

SELECT
    c.club_name,
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
    c.club_name,
    b.academic_year,
    b.allocated_amount,
    b.remaining_amount
ORDER BY c.club_name;


-- QUERY 5: Display feedback submitted for each event
-- Demonstrates: INNER JOIN across three tables

SELECT
    e.event_id,
    e.event_name,
    s.student_name,
    f.rating,
    f.comments,
    f.feedback_date
FROM EVENT e
JOIN FEEDBACK f
    ON e.event_id = f.event_id
JOIN STUDENT s
    ON f.student_id = s.student_id
ORDER BY e.event_id, f.rating DESC;


-- QUERY 6: Calculate average ratings for all events
-- Demonstrates: COUNT, AVG, ROUND, LEFT JOIN, GROUP BY

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
    e.event_name
ORDER BY average_rating DESC NULLS LAST;


-- QUERY 7: Display sponsorship details
-- Demonstrates: Joining sponsorship, sponsor, club and event

SELECT
    s.sponsor_name,
    c.club_name,
    e.event_name,
    sp.amount AS sponsorship_amount,
    sp.sponsorship_date
FROM SPONSORSHIP sp
JOIN SPONSOR s
    ON sp.sponsor_id = s.sponsor_id
JOIN CLUB c
    ON sp.club_id = c.club_id
JOIN EVENT e
    ON sp.event_id = e.event_id
ORDER BY sp.amount DESC;


-- QUERY 8: Display resource bookings for events
-- Demonstrates: Joins involving the quoted RESOURCE table

SELECT
    rb.booking_id,
    res.resource_name,
    e.event_name,
    rb.quantity,
    rb.booking_start,
    rb.booking_end,
    rb.booking_status
FROM RESOURCE_BOOKING rb
JOIN "RESOURCE" res
    ON rb.resource_id = res.resource_id
JOIN EVENT e
    ON rb.event_id = e.event_id
ORDER BY e.event_id, res.resource_name;


-- QUERY 9: Count memberships in each club
-- Demonstrates: COUNT, LEFT JOIN, GROUP BY

SELECT
    c.club_id,
    c.club_name,
    COUNT(m.membership_id) AS total_memberships
FROM CLUB c
LEFT JOIN MEMBERSHIP m
    ON c.club_id = m.club_id
GROUP BY
    c.club_id,
    c.club_name
ORDER BY total_memberships DESC, c.club_name;


-- QUERY 10: Find registered students with no attendance
-- or students marked absent
-- Demonstrates: LEFT JOIN, WHERE with OR and IS NULL

SELECT
    s.student_id,
    s.student_name,
    e.event_name,
    a.attendance_status
FROM STUDENT s
JOIN REGISTRATION r
    ON s.student_id = r.student_id
JOIN EVENT e
    ON r.event_id = e.event_id
LEFT JOIN ATTENDANCE a
    ON r.registration_id = a.registration_id
WHERE a.attendance_id IS NULL
   OR a.attendance_status = 'Absent'
ORDER BY s.student_id;


-- QUERY 11: Calculate available capacity for each event
-- Demonstrates: COUNT, GROUP BY and arithmetic expressions

SELECT
    e.event_id,
    e.event_name,
    e.capacity,
    COUNT(r.registration_id) AS registered_students,
    e.capacity - COUNT(r.registration_id) AS available_capacity
FROM EVENT e
LEFT JOIN REGISTRATION r
    ON e.event_id = r.event_id
GROUP BY
    e.event_id,
    e.event_name,
    e.capacity
ORDER BY e.event_id;


-- QUERY 12: Calculate total sponsorship received by each club
-- Demonstrates: SUM, COUNT, NVL, LEFT JOIN, GROUP BY

SELECT
    c.club_id,
    c.club_name,
    COUNT(sp.sponsorship_id) AS sponsorship_count,
    NVL(SUM(sp.amount), 0) AS total_sponsorship
FROM CLUB c
LEFT JOIN SPONSORSHIP sp
    ON c.club_id = sp.club_id
GROUP BY
    c.club_id,
    c.club_name
ORDER BY total_sponsorship DESC;


-- QUERY 13: Find students who gave a rating of 5
-- Demonstrates: INNER JOIN and WHERE filtering

SELECT
    s.student_id,
    s.student_name,
    e.event_name,
    f.rating,
    f.comments
FROM FEEDBACK f
JOIN STUDENT s
    ON f.student_id = s.student_id
JOIN EVENT e
    ON f.event_id = e.event_id
WHERE f.rating = 5
ORDER BY e.event_name;