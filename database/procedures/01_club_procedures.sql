-- ============================================================
-- CAMPUS CLUB AND CHAPTER MANAGEMENT SYSTEM
-- File: 01_club_procedures.sql
-- Purpose: Stored procedures and functions
-- ============================================================


-- PROCEDURE 1: Register a student for an event

CREATE OR REPLACE PROCEDURE REGISTER_STUDENT_FOR_EVENT (
    p_student_id IN NUMBER,
    p_event_id IN NUMBER
)
AS
    v_student_count NUMBER;
    v_event_count NUMBER;
    v_registration_count NUMBER;
    v_next_registration_id NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_student_count
    FROM STUDENT
    WHERE student_id = p_student_id;

    IF v_student_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Student does not exist.'
        );
    END IF;

    SELECT COUNT(*)
    INTO v_event_count
    FROM EVENT
    WHERE event_id = p_event_id;

    IF v_event_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Event does not exist.'
        );
    END IF;

    SELECT COUNT(*)
    INTO v_registration_count
    FROM REGISTRATION
    WHERE student_id = p_student_id
      AND event_id = p_event_id;

    IF v_registration_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Student is already registered for this event.'
        );
    END IF;

    SELECT NVL(MAX(registration_id), 800) + 1
    INTO v_next_registration_id
    FROM REGISTRATION;

    INSERT INTO REGISTRATION (
        registration_id,
        student_id,
        event_id,
        registration_date,
        registration_status
    )
    VALUES (
        v_next_registration_id,
        p_student_id,
        p_event_id,
        SYSDATE,
        'Registered'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Student registered successfully. Registration ID: '
        || v_next_registration_id
    );
END;
/
-- PROCEDURE 2: Record or update event attendance

CREATE OR REPLACE PROCEDURE RECORD_EVENT_ATTENDANCE (
    p_registration_id IN NUMBER,
    p_attendance_status IN VARCHAR2
)
AS
    v_registration_count NUMBER;
    v_attendance_count NUMBER;
BEGIN
    IF UPPER(p_attendance_status) NOT IN ('PRESENT', 'ABSENT') THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Attendance status must be Present or Absent.'
        );
    END IF;

    SELECT COUNT(*)
    INTO v_registration_count
    FROM REGISTRATION
    WHERE registration_id = p_registration_id;

    IF v_registration_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Registration does not exist.'
        );
    END IF;

    SELECT COUNT(*)
    INTO v_attendance_count
    FROM ATTENDANCE
    WHERE registration_id = p_registration_id;

    IF v_attendance_count > 0 THEN
        UPDATE ATTENDANCE
        SET attendance_status = INITCAP(p_attendance_status),
            check_in_time =
                CASE
                    WHEN UPPER(p_attendance_status) = 'PRESENT'
                    THEN SYSTIMESTAMP
                    ELSE NULL
                END
        WHERE registration_id = p_registration_id;
    ELSE
        INSERT INTO ATTENDANCE (
            attendance_id,
            registration_id,
            attendance_status,
            check_in_time
        )
        VALUES (
            (SELECT NVL(MAX(attendance_id), 900) + 1 FROM ATTENDANCE),
            p_registration_id,
            INITCAP(p_attendance_status),
            CASE
                WHEN UPPER(p_attendance_status) = 'PRESENT'
                THEN SYSTIMESTAMP
                ELSE NULL
            END
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Attendance recorded successfully.'
    );
END;
/

-- FUNCTION 1: Calculate total recorded expenses for a club

CREATE OR REPLACE FUNCTION GET_CLUB_TOTAL_EXPENSES (
    p_club_id IN NUMBER
)
RETURN NUMBER
AS
    v_total_expenses NUMBER;
BEGIN
    SELECT NVL(SUM(ex.amount), 0)
    INTO v_total_expenses
    FROM BUDGET b
    LEFT JOIN EXPENSE ex
        ON b.budget_id = ex.budget_id
    WHERE b.club_id = p_club_id;

    RETURN v_total_expenses;
END;
/

-- FUNCTION 2: Calculate average feedback rating for an event

CREATE OR REPLACE FUNCTION GET_EVENT_AVERAGE_RATING (
    p_event_id IN NUMBER
)
RETURN NUMBER
AS
    v_average_rating NUMBER;
BEGIN
    SELECT ROUND(AVG(rating), 2)
    INTO v_average_rating
    FROM FEEDBACK
    WHERE event_id = p_event_id;

    RETURN v_average_rating;
END;
/