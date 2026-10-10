SET ECHO ON
SET DEFINE OFF
WHENEVER SQLERROR EXIT SQL.SQLCODE

CREATE TABLE STUDENT (
    student_id       NUMBER(10) PRIMARY KEY,
    student_name     VARCHAR2(100) NOT NULL,
    email            VARCHAR2(100) UNIQUE NOT NULL,
    phone            VARCHAR2(15),
    department       VARCHAR2(100),
    year_of_study    NUMBER(1)
);
CREATE TABLE CLUB (
    club_id           NUMBER(10) PRIMARY KEY,
    club_name         VARCHAR2(100) UNIQUE NOT NULL,
    description       VARCHAR2(500),
    category          VARCHAR2(50),
    date_established  DATE,
    status            VARCHAR2(20)
);
CREATE TABLE ROLE (
    role_id       NUMBER(10) PRIMARY KEY,
    role_name     VARCHAR2(50) UNIQUE NOT NULL,
    description   VARCHAR2(300)
);
CREATE TABLE CHAPTER (
    chapter_id          NUMBER(10) PRIMARY KEY,
    chapter_name        VARCHAR2(100) NOT NULL,
    faculty_coordinator VARCHAR2(100),
    establishment_date  DATE,
    club_id             NUMBER(10),
    CONSTRAINT fk_chapter_club
        FOREIGN KEY (club_id)
        REFERENCES CLUB(club_id)
);
CREATE TABLE MEMBERSHIP (
    membership_id      NUMBER(10) PRIMARY KEY,
    student_id         NUMBER(10) NOT NULL,
    club_id            NUMBER(10) NOT NULL,
    role_id            NUMBER(10) NOT NULL,
    join_date          DATE NOT NULL,
    end_date           DATE,
    membership_status  VARCHAR2(20),

    CONSTRAINT fk_membership_student
        FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id),

    CONSTRAINT fk_membership_club
        FOREIGN KEY (club_id)
        REFERENCES CLUB(club_id),

    CONSTRAINT fk_membership_role
        FOREIGN KEY (role_id)
        REFERENCES ROLE(role_id)
);
CREATE TABLE VENUE (
    venue_id      NUMBER(10) PRIMARY KEY,
    venue_name    VARCHAR2(100) UNIQUE NOT NULL,
    location      VARCHAR2(200),
    capacity      NUMBER(6),
    venue_type    VARCHAR2(50)
);
CREATE TABLE EVENT (
    event_id       NUMBER(10) PRIMARY KEY,
    event_name     VARCHAR2(150) NOT NULL,
    description    VARCHAR2(500),
    event_date     DATE,
    start_time     TIMESTAMP,
    end_time       TIMESTAMP,
    capacity       NUMBER(6),
    event_status   VARCHAR2(30),
    club_id        NUMBER(10) NOT NULL,
    venue_id       NUMBER(10) NOT NULL,

    CONSTRAINT fk_event_club
        FOREIGN KEY (club_id)
        REFERENCES CLUB(club_id),

    CONSTRAINT fk_event_venue
        FOREIGN KEY (venue_id)
        REFERENCES VENUE(venue_id)
);
CREATE TABLE REGISTRATION (
    registration_id      NUMBER(10) PRIMARY KEY,
    student_id           NUMBER(10) NOT NULL,
    event_id             NUMBER(10) NOT NULL,
    registration_date    DATE NOT NULL,
    registration_status  VARCHAR2(30),

    CONSTRAINT fk_registration_student
        FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id),

    CONSTRAINT fk_registration_event
        FOREIGN KEY (event_id)
        REFERENCES EVENT(event_id)
);
CREATE TABLE ATTENDANCE (
    attendance_id      NUMBER(10) PRIMARY KEY,
    registration_id    NUMBER(10) NOT NULL UNIQUE,
    attendance_status  VARCHAR2(20),
    check_in_time      TIMESTAMP,

    CONSTRAINT fk_attendance_registration
        FOREIGN KEY (registration_id)
        REFERENCES REGISTRATION(registration_id)
);
CREATE TABLE FEEDBACK (
    feedback_id    NUMBER(10) PRIMARY KEY,
    student_id     NUMBER(10) NOT NULL,
    event_id       NUMBER(10) NOT NULL,
    rating         NUMBER(1),
    comments       VARCHAR2(1000),
    feedback_date  DATE,

    CONSTRAINT fk_feedback_student
        FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id),

    CONSTRAINT fk_feedback_event
        FOREIGN KEY (event_id)
        REFERENCES EVENT(event_id),

    CONSTRAINT chk_feedback_rating
        CHECK (rating BETWEEN 1 AND 5)
);
CREATE TABLE "RESOURCE" (
    resource_id         NUMBER(10) PRIMARY KEY,
    resource_name       VARCHAR2(100) NOT NULL,
    resource_type       VARCHAR2(50),
    quantity_available  NUMBER(6),
    condition_status    VARCHAR2(30)
);
CREATE TABLE RESOURCE_BOOKING (
    booking_id       NUMBER(10) PRIMARY KEY,
    resource_id      NUMBER(10) NOT NULL,
    event_id         NUMBER(10) NOT NULL,
    quantity         NUMBER(6) NOT NULL,
    booking_start    TIMESTAMP,
    booking_end      TIMESTAMP,
    booking_status   VARCHAR2(30),

    CONSTRAINT fk_booking_resource
        FOREIGN KEY (resource_id)
        REFERENCES "RESOURCE"(resource_id),

    CONSTRAINT fk_booking_event
        FOREIGN KEY (event_id)
        REFERENCES EVENT(event_id)
);
CREATE TABLE BUDGET (
    budget_id         NUMBER(10) PRIMARY KEY,
    club_id           NUMBER(10) NOT NULL,
    academic_year     VARCHAR2(20) NOT NULL,
    allocated_amount  NUMBER(12,2) NOT NULL,
    remaining_amount  NUMBER(12,2),

    CONSTRAINT fk_budget_club
        FOREIGN KEY (club_id)
        REFERENCES CLUB(club_id)
);
CREATE TABLE EXPENSE (
    expense_id    NUMBER(10) PRIMARY KEY,
    budget_id     NUMBER(10) NOT NULL,
    event_id      NUMBER(10),
    expense_date  DATE,
    amount        NUMBER(12,2) NOT NULL,
    description   VARCHAR2(500),

    CONSTRAINT fk_expense_budget
        FOREIGN KEY (budget_id)
        REFERENCES BUDGET(budget_id),

    CONSTRAINT fk_expense_event
        FOREIGN KEY (event_id)
        REFERENCES EVENT(event_id)
);
CREATE TABLE SPONSOR (
    sponsor_id      NUMBER(10) PRIMARY KEY,
    sponsor_name    VARCHAR2(150) NOT NULL,
    contact_person  VARCHAR2(100),
    email           VARCHAR2(100),
    phone           VARCHAR2(15)
);
CREATE TABLE SPONSORSHIP (
    sponsorship_id    NUMBER(10) PRIMARY KEY,
    sponsor_id        NUMBER(10) NOT NULL,
    club_id           NUMBER(10) NOT NULL,
    event_id          NUMBER(10) NOT NULL,
    amount            NUMBER(12,2),
    sponsorship_date  DATE,

    CONSTRAINT fk_sponsorship_sponsor
        FOREIGN KEY (sponsor_id)
        REFERENCES SPONSOR(sponsor_id),

    CONSTRAINT fk_sponsorship_club
        FOREIGN KEY (club_id)
        REFERENCES CLUB(club_id),

    CONSTRAINT fk_sponsorship_event
        FOREIGN KEY (event_id)
        REFERENCES EVENT(event_id)
);