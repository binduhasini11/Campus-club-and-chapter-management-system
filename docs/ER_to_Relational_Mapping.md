# ER/EER Diagram to Relational Model Mapping
## Club and Chapter Management System

## 1. Introduction

The ER/EER model of the Club and Chapter Management System is
mapped into 16 relational tables.

Each table represents an entity or an associative entity.
Primary keys uniquely identify records, while foreign keys
establish relationships between related tables.

## 2. Relational Schema

Notation:
- PK: Primary Key
- FK: Foreign Key
- UQ: Unique constraint

### 1. STUDENT
STUDENT(
student_id PK,
student_name,
email UQ,
phone,
department,
year_of_study
)

### 2. CLUB
CLUB(
club_id PK,
club_name UQ,
description,
category,
date_established,
status
)

### 3. ROLE
ROLE(
role_id PK,
role_name UQ,
description
)

### 4. CHAPTER
CHAPTER(
chapter_id PK,
chapter_name,
faculty_coordinator,
establishment_date,
club_id FK → CLUB(club_id)
)

### 5. MEMBERSHIP
MEMBERSHIP(
membership_id PK,
student_id FK → STUDENT(student_id),
club_id FK → CLUB(club_id),
role_id FK → ROLE(role_id),
join_date,
end_date,
membership_status
)

### 6. VENUE
VENUE(
venue_id PK,
venue_name UQ,
location,
capacity,
venue_type
)

### 7. EVENT
EVENT(
event_id PK,
event_name,
description,
event_date,
start_time,
end_time,
capacity,
event_status,
club_id FK → CLUB(club_id),
venue_id FK → VENUE(venue_id)
)

### 8. REGISTRATION
REGISTRATION(
registration_id PK,
student_id FK → STUDENT(student_id),
event_id FK → EVENT(event_id),
registration_date,
registration_status
)

### 9. ATTENDANCE
ATTENDANCE(
attendance_id PK,
registration_id FK, UQ,
attendance_status,
check_in_time
)

### 10. FEEDBACK
FEEDBACK(
feedback_id PK,
student_id FK → STUDENT(student_id),
event_id FK → EVENT(event_id),
rating,
comments,
feedback_date
)

Constraint: rating must be between 1 and 5 when provided.

### 11. RESOURCE
RESOURCE(
resource_id PK,
resource_name,
resource_type,
quantity_available,
condition_status
)

### 12. RESOURCE_BOOKING
RESOURCE_BOOKING(
booking_id PK,
resource_id FK → RESOURCE(resource_id),
event_id FK → EVENT(event_id),
quantity,
booking_start,
booking_end,
booking_status
)

### 13. BUDGET
BUDGET(
budget_id PK,
club_id FK → CLUB(club_id),
academic_year,
allocated_amount,
remaining_amount
)

### 14. EXPENSE
EXPENSE(
expense_id PK,
budget_id FK → BUDGET(budget_id),
event_id FK → EVENT(event_id),
expense_date,
amount,
description
)

Note: event_id is an optional foreign key.

### 15. SPONSOR
SPONSOR(
sponsor_id PK,
sponsor_name,
contact_person,
email,
phone
)

### 16. SPONSORSHIP
SPONSORSHIP(
sponsorship_id PK,
sponsor_id FK → SPONSOR(sponsor_id),
club_id FK → CLUB(club_id),
event_id FK → EVENT(event_id),
amount,
sponsorship_date
)

## 3. Mapping of Relationships

| Relationship | Relational Mapping |
|---|---|
| CLUB — CHAPTER | club_id is an FK in CHAPTER |
| STUDENT — MEMBERSHIP | student_id is an FK in MEMBERSHIP |
| CLUB — MEMBERSHIP | club_id is an FK in MEMBERSHIP |
| ROLE — MEMBERSHIP | role_id is an FK in MEMBERSHIP |
| CLUB — EVENT | club_id is an FK in EVENT |
| VENUE — EVENT | venue_id is an FK in EVENT |
| STUDENT — REGISTRATION | student_id is an FK in REGISTRATION |
| EVENT — REGISTRATION | event_id is an FK in REGISTRATION |
| REGISTRATION — ATTENDANCE | registration_id is an FK and UNIQUE in ATTENDANCE |
| STUDENT — FEEDBACK | student_id is an FK in FEEDBACK |
| EVENT — FEEDBACK | event_id is an FK in FEEDBACK |
| EVENT — RESOURCE_BOOKING | event_id is an FK in RESOURCE_BOOKING |
| RESOURCE — RESOURCE_BOOKING | resource_id is an FK in RESOURCE_BOOKING |
| CLUB — BUDGET | club_id is an FK in BUDGET |
| BUDGET — EXPENSE | budget_id is an FK in EXPENSE |
| EVENT — EXPENSE | event_id is an optional FK in EXPENSE |
| SPONSOR — SPONSORSHIP | sponsor_id is an FK in SPONSORSHIP |
| CLUB — SPONSORSHIP | club_id is an FK in SPONSORSHIP |
| EVENT — SPONSORSHIP | event_id is an FK in SPONSORSHIP |

## 4. Mapping of Many-to-Many Relationships

### STUDENT — CLUB

A student can have memberships in multiple clubs, and a club
can have multiple students.

MEMBERSHIP represents this association and stores role,
joining date, ending date, and membership status.

### STUDENT — EVENT

A student can register for multiple events, and an event
can have multiple registrations.

REGISTRATION represents this association and stores
registration-specific information.

### EVENT — RESOURCE

An event can use multiple resources, and a resource can be
booked for multiple events.

RESOURCE_BOOKING represents this association and stores
booking-specific details.

### SPONSOR — CLUB/EVENT

SPONSORSHIP records a sponsor's association with a club
and an event, along with the sponsorship amount and date.

## 5. Integrity Constraints

The schema uses:
- Primary key constraints.
- Foreign key constraints.
- Unique constraints on selected attributes.
- NOT NULL constraints on required attributes.
- A CHECK constraint restricting feedback ratings to 1–5.

ATTENDANCE.registration_id is UNIQUE, allowing at most one
attendance record for each registration.

## 6. Conclusion

The relational model consists of 16 tables. Primary keys
identify records, foreign keys represent relationships, and
constraints help maintain data integrity.
Associative entities represent relationships and store
relationship-specific information.