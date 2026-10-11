# Database System Project
## Club and Chapter Management System

## 1. Project Overview

The **Campus Club and Chapter Management System** is a Database Management System (DBMS) project designed to organize and manage student clubs, chapters, memberships, events, registrations, attendance, feedback, resources, budgets, expenses, and sponsorships.

The application provides a web-based interface connected to a FastAPI backend and an Oracle relational database. It demonstrates how database concepts can be applied to manage campus club activities systematically.

The database maintains relationships between different entities and supports data integrity through primary keys, foreign keys, unique constraints, check constraints, views, stored procedures, functions, and triggers.

## 2. Objectives

- Maintain student, club, chapter, and membership information.
- Manage events, venues, registrations, and attendance.
- Store event feedback and ratings.
- Manage resources and event-related resource bookings.
- Track club budgets, expenses, and sponsorships.
- Retrieve useful information through SQL queries.
- Implement database constraints to maintain data integrity.
- Use PL/SQL procedures, functions, and triggers.
- Develop a frontend interface connected to a backend API and Oracle database.
- Design a relational database that reduces unnecessary data redundancy.

## 3. Technologies Used

| Component | Technology |
|---|---|
| Database | Oracle Database 26ai Free |
| Query Language | SQL |
| Procedural Language | Oracle PL/SQL |
| Database Client | SQL*Plus |
| Backend | Python, FastAPI |
| Database Connectivity | Python `oracledb` driver |
| Frontend | HTML, CSS, JavaScript |
| API Documentation | FastAPI / Swagger UI |
| Development Environment | Visual Studio Code |
| Version Control | Git and GitHub |

## 4. Application Architecture

The application follows a three-layer architecture.

### Frontend
The frontend is developed using HTML, CSS, and JavaScript. It provides the interface through which users interact with the application.

### Backend
The backend is implemented using FastAPI. It exposes API endpoints, processes requests, validates input where implemented, and communicates with the Oracle database.

### Database
Oracle Database stores the application's records and maintains relationships and integrity constraints.

### Request Flow

```text
User
  |
  v
Frontend (HTML, CSS, JavaScript)
  |
  v
FastAPI Backend
  |
  v
Oracle Database
```

The frontend sends requests to the backend, which executes the required database operations and returns responses to the frontend.

## 5. Database Design

The database consists of 16 entities.

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

### Associative Entities

The following entities represent relationships between other entities:

- **MEMBERSHIP:** Connects students and clubs and records membership details.
- **REGISTRATION:** Connects students and events and records registration details.
- **RESOURCE_BOOKING:** Connects resources and events and records booking details.
- **SPONSORSHIP:** Records sponsorship relationships involving sponsors, clubs, and events.

These entities help represent many-to-many relationships in the relational model.

## 6. Database Features Implemented

### 6.1 SQL Queries

The project includes SQL queries demonstrating operations such as:

- Retrieving student membership details.
- Displaying events with their associated clubs and venues.
- Retrieving event registrations and attendance.
- Summarizing club budgets and expenses.
- Displaying event feedback and average ratings.
- Retrieving sponsorship and resource-booking details.
- Counting club memberships.
- Identifying absent or unrecorded attendance.
- Calculating available event capacity.
- Summarizing sponsorship amounts by club.

The queries demonstrate the retrieval and analysis of information stored across related tables.

### 6.2 Views

The following database views have been created:

- `V_STUDENT_MEMBERSHIPS`
- `V_EVENT_DETAILS`
- `V_EVENT_ATTENDANCE`
- `V_CLUB_BUDGET_SUMMARY`
- `V_EVENT_FEEDBACK_SUMMARY`

These views simplify access to frequently required information by combining data from related tables.

### 6.3 Stored Procedures and Functions

The project includes the following PL/SQL program units.

| Name | Type | Purpose |
|---|---|---|
| `REGISTER_STUDENT_FOR_EVENT` | Procedure | Validates and registers a student for an event |
| `RECORD_EVENT_ATTENDANCE` | Procedure | Records or updates an event attendance status |
| `GET_CLUB_TOTAL_EXPENSES` | Function | Calculates the total recorded expenses for a club |
| `GET_EVENT_AVERAGE_RATING` | Function | Calculates the average feedback rating for an event |

### 6.4 Triggers and Integrity Validation

The following triggers have been implemented:

- `TRG_VALIDATE_FEEDBACK` — validates feedback ratings.
- `TRG_CHECK_REGISTRATION` — checks event capacity before a new registration.
- `TRG_VALIDATE_RESOURCE_BOOKING` — validates resource-booking quantities and booking time ranges.

Primary keys, foreign keys, unique constraints, check constraints, and other applicable database constraints help maintain data integrity.

## 7. Repository Structure

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
│   ├── app/
│   │   ├── __init__.py
│   │   ├── database.py
│   │   └── main.py
│   ├── requirements.txt
│   └── .gitignore
│
├── frontend/
│   ├── index.html
│   ├── style.css
│   └── app.js
│
└── docs/
    ├── ER_to_Relational_Mapping.md
    └── Normalization.md
```

## 8. Sample Data

Sample records have been inserted into the database to demonstrate the relationships between the tables and test the implemented SQL queries and PL/SQL program units.

The sample data covers students, clubs, chapters, memberships, events, venues, registrations, attendance, feedback, resources, bookings, budgets, expenses, sponsors, and sponsorships.

## 9. How to Set Up the Database

### Prerequisites

- Oracle Database 26ai Free installed and running.
- Access to the `FREEPDB1` pluggable database.
- An Oracle database user with the required privileges.
- SQL*Plus or another compatible Oracle SQL client.

### Database Setup

1. Start Oracle Database.
2. Connect to the `FREEPDB1` pluggable database using your configured Oracle database user.
3. Execute the database scripts in the following order when creating a fresh schema.

| Step | Script | Purpose |
|---:|---|---|
| 1 | `database/schema/01_create_tables.sql` | Creates the database tables and constraints |
| 2 | `database/sample_data/01_insert_sample_data.sql` | Inserts sample records |
| 3 | `database/queries/01_basic_queries.sql` | Executes the basic SQL queries |
| 4 | `database/queries/02_create_views.sql` | Creates the database views |
| 5 | `database/procedures/01_club_procedures.sql` | Creates the stored procedures and functions |
| 6 | `database/triggers/01_validation_triggers.sql` | Creates the validation triggers |

**Important:** The schema and sample-data scripts are intended for initial database setup. Do not rerun them against an already populated schema without checking the existing tables and records first.

The SQL query script is used to demonstrate database retrieval operations. If you are setting up the database for the first time, create the views, procedures, functions, and triggers before testing the corresponding functionality.

## 10. How to Run the Application Locally

Follow these steps to run the application on your own computer.

### Prerequisites

Install or configure:

- Python compatible with the project's dependencies.
- Oracle Database 26ai Free.
- Git.
- A modern web browser.
- Access to the `FREEPDB1` Oracle service.

Oracle Database must be running, and the required tables and database objects must already exist before using the application.

### Step 1: Clone the Repository

Open a terminal and execute:

```bash
git clone https://github.com/binduhasini11/Campus-club-and-chapter-management-system.git
cd Campus-club-and-chapter-management-system
```

### Step 2: Configure Oracle Database

Set up your Oracle database and execute the required SQL scripts as described in Section 9.

Use your own Oracle database username and password.

The application does not include database credentials in the repository.

### Step 3: Set Up the Backend

Navigate to the backend directory:

```bash
cd backend
```

Create a virtual environment:

```bash
python -m venv .venv
```

Activate the environment on Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

On macOS or Linux:

```bash
source .venv/bin/activate
```

Install the required Python packages:

```bash
python -m pip install -r requirements.txt
```

### Step 4: Configure Database Connectivity

Inside the `backend` directory, create a file named `.env`.

Add the following configuration:

```env
ORACLE_USER=your_oracle_username
ORACLE_PASSWORD=your_oracle_password
ORACLE_DSN=localhost:1521/FREEPDB1
```

Replace the example values with the credentials and connection details for your own Oracle database.

Do not upload the `.env` file to GitHub or share your database password.

### Step 5: Start the Backend Server

Make sure your terminal is still in the `backend` directory and the virtual environment is activated.

Run:

```bash
python -m uvicorn app.main:app --reload
```

The backend API will be available at:

`http://127.0.0.1:8000`

Interactive API documentation is available at:

`http://127.0.0.1:8000/docs`

Keep this terminal running while using the application.

### Step 6: Start the Frontend

Open a second terminal at the project root directory.

If the terminal is currently inside `backend`, return to the root:

```powershell
cd ..
```

Start a local HTTP server:

```bash
python -m http.server 5500
```

Open the following address in your browser:

`http://127.0.0.1:5500/frontend/`

Keep this terminal running while using the frontend.

### Step 7: Verify the Application

1. Confirm that Oracle Database is running.
2. Confirm that the FastAPI backend has started successfully.
3. Open the frontend in your browser.
4. Test the available application features.
5. Visit `http://127.0.0.1:8000/docs` to inspect and test the backend API endpoints.

The frontend must be configured to communicate with the correct backend address.

If the frontend cannot retrieve data, check the backend status, browser console, API URL configuration, and CORS settings.

## 11. API Documentation

FastAPI provides interactive API documentation that allows users to inspect available endpoints and send test requests.

When the backend is running locally, open:

`http://127.0.0.1:8000/docs`

The documentation lists the endpoints implemented by the backend and their supported request methods, parameters, and responses.

The available operations depend on the implemented endpoints.

## 12. Troubleshooting

| Issue | Possible Solution |
|---|---|
| Oracle connection fails | Verify that Oracle Database is running and that the username, password, and service name are correct. |
| Backend does not start | Activate the virtual environment and install the packages listed in `backend/requirements.txt`. |
| API cannot be reached | Confirm that the FastAPI server is running on port 8000. |
| Frontend cannot retrieve data | Check the API URL, backend status, browser console, and CORS configuration. |
| Port is already in use | Stop the process using the port or select another available port and update the corresponding configuration. |
| Database objects already exist | Check the existing schema before rerunning the database creation scripts. |

## 13. Security and Deployment Notes

- Database credentials are stored in a local `.env` file and should not be committed to GitHub.
- Each user must configure their own Oracle database connection.
- The application currently runs in a local development environment.
- The addresses `127.0.0.1:5500` and `127.0.0.1:8000` refer to services running on the user's own computer.
- Cloning the repository does not automatically install Oracle Database, create the database schema, or configure database connectivity.
- Public deployment requires hosting the frontend and backend and configuring secure access to a database accessible by the deployed backend.
- The development server commands in this README are intended for local testing and demonstration, not production deployment.

## 14. Documentation

Additional project documentation is available in the `docs/` directory:

- `ER_to_Relational_Mapping.md` — documents the mapping of the ER/EER design to relational tables.
- `Normalization.md` — describes the normalization concepts applied to the database design.

## 15. Team

**Project:** Campus Club and Chapter Management System

**Course:** Database Systems (DBMS)

**Contributors:**

- B BINDU HASINI
- M ASHWITHA
- SHREENIDHI A
- ANUSHKA SHIVRAM K

---

**Database System Project — Club and Chapter Management System**
