# Database System Project
## Club and Chapter Management System

### Project Overview

The **Campus Club and Chapter Management System** is a database management project designed to organize and manage student clubs, chapters, memberships, events, registrations, attendance, feedback, resources, budgets, expenses, and sponsorships.

The system uses a relational database to store related information systematically and maintain data integrity through primary keys, foreign keys, constraints, views, procedures, functions, and triggers.

### Objectives

- Maintain student, club, chapter, and membership information.
- Manage events, venues, registrations, and attendance.
- Store event feedback and ratings.
- Manage resources and event-related resource bookings.
- Track club budgets, expenses, and sponsorships.
- Implement SQL queries for retrieving useful information.
- Apply database integrity constraints and PL/SQL program units.
- Design a relational database that reduces unnecessary data redundancy.

### Technologies Used

- **Database:** Oracle Database 26ai Free
- **Query Language:** SQL
- **Procedural Language:** Oracle PL/SQL
- **Database Client:** SQL*Plus
- **Development Environment:** Visual Studio Code
- **Version Control:** Git and GitHub

### Database Design

The database consists of the following 16 entities:

| No. | Table | Purpose |
|---:|---|---|
| 1 | STUDENT | Stores student information |
| 2 | CLUB | Stores club details |
| 3 | CHAPTER | Stores chapter information associated with clubs |
| 4 | ROLE | Stores club membership roles |
| 5 | MEMBERSHIP | Records student memberships in clubs and assigned roles |
| 6 | EVENT | Stores event details |
| 7 | VENUE | Stores venue information |
| 8 | REGISTRATION | Records student registrations for events |
| 9 | ATTENDANCE | Stores event attendance records |
| 10 | FEEDBACK | Stores student feedback and event ratings |
| 11 | RESOURCE | Stores information about available resources |
| 12 | RESOURCE_BOOKING | Records resource bookings for events |
| 13 | BUDGET | Stores club budget allocations and remaining amounts |
| 14 | EXPENSE | Records expenses associated with budgets and events |
| 15 | SPONSOR | Stores sponsor information |
| 16 | SPONSORSHIP | Records sponsorship details for clubs and events |

### Database Features Implemented

#### SQL Queries

The project includes SQL queries demonstrating:

- Retrieving student membership details.
- Displaying events with their clubs and venues.
- Retrieving event registrations and attendance.
- Summarizing club budgets and expenses.
- Displaying event feedback and average ratings.
- Retrieving sponsorship and resource-booking details.
- Counting club memberships.
- Identifying absent or unrecorded attendance.
- Calculating available event capacity.
- Summarizing sponsorship amounts by club.

#### Views

The following database views have been created:

- `V_STUDENT_MEMBERSHIPS`
- `V_EVENT_DETAILS`
- `V_EVENT_ATTENDANCE`
- `V_CLUB_BUDGET_SUMMARY`
- `V_EVENT_FEEDBACK_SUMMARY`

These views simplify access to frequently required information by combining data from related tables.

#### Stored Procedures and Functions

The project includes the following PL/SQL program units:

| Name | Type | Purpose |
|---|---|---|
| `REGISTER_STUDENT_FOR_EVENT` | Procedure | Validates and registers a student for an event |
| `RECORD_EVENT_ATTENDANCE` | Procedure | Records or updates an event attendance status |
| `GET_CLUB_TOTAL_EXPENSES` | Function | Calculates the total recorded expenses for a club |
| `GET_EVENT_AVERAGE_RATING` | Function | Calculates the average feedback rating for an event |

#### Triggers and Integrity Validation

The following triggers have been implemented:

- `TRG_VALIDATE_FEEDBACK` — validates feedback ratings.
- `TRG_CHECK_REGISTRATION` — checks event capacity before a new registration.
- `TRG_VALIDATE_RESOURCE_BOOKING` — validates resource-booking quantities and booking time ranges.

Primary keys, foreign keys, unique constraints, check constraints, and other applicable database constraints help maintain data integrity.

### Repository Structure

```text
Campus-club-and-chapter-management-system/
│
├── README.md
│
├── database/
│   ├── schema/
│   │   └── 01_create_tables.sql
│   │
│   ├── sample_data/
│   │   └── 01_insert_sample_data.sql
│   │
│   ├── queries/
│   │   ├── 01_basic_queries.sql
│   │   └── 02_create_views.sql
│   │
│   ├── procedures/
│   │   └── 01_club_procedures.sql
│   │
│   └── triggers/
│       └── 01_validation_triggers.sql
│
├── backend/
├── frontend/
└── docs/
```


### Sample Data

Sample records have been inserted into the database to demonstrate the relationships between the tables and test the implemented SQL queries and PL/SQL program units.

The sample data covers students, clubs, chapters, memberships, events, venues, registrations, attendance, feedback, resources, bookings, budgets, expenses, sponsors, and sponsorships.

### How to Run the Database Scripts

**Prerequisites**

- Oracle Database 26ai Free installed and running.
- Access to the `FREEPDB1` pluggable database.
- An Oracle database user with the required privileges.
- SQL*Plus or another Oracle-compatible SQL client.

**Execution order**

Run the scripts in the following order when setting up a fresh database schema:

1. `database/schema/01_create_tables.sql`
2. `database/sample_data/01_insert_sample_data.sql`
3. `database/queries/01_basic_queries.sql`
4. `database/queries/02_create_views.sql`
5. `database/procedures/01_club_procedures.sql`
6. `database/triggers/01_validation_triggers.sql`

**Important:** These scripts create database objects and insert sample records. Do not rerun the schema or sample-data scripts against an already populated database without checking the existing objects and records first.


### Team

**Project:** Campus Club and Chapter Management System

**Course:** Database Systems (DBMS)

**Contributors**:
B BINDU HASINI

M ASHWITHA

SHREENIDHI A

ANUSHKA SHIVRAM K


---
