-- ============================================================
-- CAMPUS CLUB AND CHAPTER MANAGEMENT SYSTEM
-- File: 01_validation_triggers.sql
-- Purpose: Validate data using database triggers
-- ============================================================


-- TRIGGER 1: Validate feedback ratings

CREATE OR REPLACE TRIGGER TRG_VALIDATE_FEEDBACK
BEFORE INSERT OR UPDATE OF rating
ON FEEDBACK
FOR EACH ROW
BEGIN
    IF :NEW.rating IS NOT NULL
       AND (:NEW.rating < 1 OR :NEW.rating > 5) THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'Feedback rating must be between 1 and 5.'
        );
    END IF;
END;
/
-- TRIGGER 2: Prevent registrations beyond event capacity

CREATE OR REPLACE TRIGGER TRG_CHECK_REGISTRATION
BEFORE INSERT
ON REGISTRATION
FOR EACH ROW
DECLARE
    v_capacity NUMBER;
    v_registration_count NUMBER;
BEGIN
    SELECT capacity
    INTO v_capacity
    FROM EVENT
    WHERE event_id = :NEW.event_id;

    SELECT COUNT(*)
    INTO v_registration_count
    FROM REGISTRATION
    WHERE event_id = :NEW.event_id
      AND registration_status = 'Registered';

    IF v_registration_count >= v_capacity THEN
        RAISE_APPLICATION_ERROR(
            -20011,
            'Registration failed: event has reached capacity.'
        );
    END IF;
END;
/

-- TRIGGER 3: Validate resource bookings

CREATE OR REPLACE TRIGGER TRG_VALIDATE_RESOURCE_BOOKING
BEFORE INSERT OR UPDATE
ON RESOURCE_BOOKING
FOR EACH ROW
BEGIN
    IF :NEW.quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20012,
            'Resource booking quantity must be greater than zero.'
        );
    END IF;

    IF :NEW.booking_start IS NOT NULL
       AND :NEW.booking_end IS NOT NULL
       AND :NEW.booking_end <= :NEW.booking_start THEN
        RAISE_APPLICATION_ERROR(
            -20013,
            'Booking end time must be later than booking start time.'
        );
    END IF;
END;
/