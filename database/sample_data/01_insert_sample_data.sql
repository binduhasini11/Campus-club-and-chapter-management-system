-- Campus Club and Chapter Management System
-- Reconstructed from the actual SQL*Plus outputs supplied by the project team.
-- This script is intended for a CLEAN/EMPTY schema only.
-- Do NOT run against the currently populated database: primary-key duplicates will occur.
-- CLUB_ID 205 is preserved exactly as stored ("string" values).
-- Check foreign-key constraints/triggers before running in a fresh schema.

SET DEFINE OFF;
SET SERVEROUTPUT ON;

-- =========================================================
-- 1. STUDENT (30 records)
-- =========================================================
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (101, 'Bindu Hasini', 'bindu.hasini@example.com', '9876500001', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (102, 'Ashwitha', 'ashwitha@example.com', '9876500002', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (103, 'Anushka Shivram', 'anushka.shivram@example.com', '9876500003', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (104, 'Shreenidhi', 'shreenidhi@example.com', '9876500004', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (105, 'Diya Reddy', 'diya.reddy@example.com', '9876500005', 'ECE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (106, 'Rohan Kumar', 'rohan.kumar@example.com', '9876500006', 'IT', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (107, 'Aarav Sharma', 'aarav.sharma@example.com', '9000000107', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (108, 'Aditi Nair', 'aditi.nair@example.com', '9000000108', 'ECE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (109, 'Arjun Reddy', 'arjun.reddy@example.com', '9000000109', 'CSE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (110, 'Ananya Iyer', 'ananya.iyer@example.com', '9000000110', 'IT', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (111, 'Karthik Menon', 'karthik.menon@example.com', '9000000111', 'CSE', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (112, 'Meera Krishnan', 'meera.krishnan@example.com', '9000000112', 'ECE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (113, 'Rahul Verma', 'rahul.verma@example.com', '9000000113', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (114, 'Sneha Rao', 'sneha.rao@example.com', '9000000114', 'IT', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (115, 'Aditya Kumar', 'aditya.kumar@example.com', '9000000115', 'EEE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (116, 'Priya Menon', 'priya.menon@example.com', '9000000116', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (117, 'Vikram Singh', 'vikram.singh@example.com', '9000000117', 'ECE', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (118, 'Ishita Das', 'ishita.das@example.com', '9000000118', 'CSE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (119, 'Rohan Patel', 'rohan.patel@example.com', '9000000119', 'IT', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (120, 'Kavya Srinivasan', 'kavya.srinivasan@example.com', '9000000120', 'CSE', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (121, 'Nikhil Joshi', 'nikhil.joshi@example.com', '9000000121', 'ECE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (122, 'Diya Shah', 'diya.shah@example.com', '9000000122', 'CSE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (123, 'Sanjay Kumar', 'sanjay.kumar@example.com', '9000000123', 'IT', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (124, 'Pooja Ramesh', 'pooja.ramesh@example.com', '9000000124', 'CSE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (125, 'Varun Anand', 'varun.anand@example.com', '9000000125', 'EEE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (126, 'Nandini Rao', 'nandini.rao@example.com', '9000000126', 'CSE', 3);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (127, 'Harish Babu', 'harish.babu@example.com', '9000000127', 'ECE', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (128, 'Sakshi Gupta', 'sakshi.gupta@example.com', '9000000128', 'CSE', 1);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (129, 'Pranav Mohan', 'pranav.mohan@example.com', '9000000129', 'IT', 2);
INSERT INTO STUDENT (student_id, student_name, email, phone, department, year_of_study)
VALUES (130, 'Tanvi Kapoor', 'tanvi.kapoor@example.com', '9000000130', 'CSE', 3);

-- =========================================================
-- 2. CLUB, ROLE, CHAPTER
-- =========================================================
INSERT INTO CLUB (club_id, club_name, description, category, date_established, status)
VALUES (201, 'CodeCraft', 'Technical club for coding and software development', 'Technical', DATE '2023-08-15', 'Active');
INSERT INTO CLUB (club_id, club_name, description, category, date_established, status)
VALUES (202, 'Pixel Society', 'Club for graphic design, photography, and digital art', 'Arts', DATE '2022-09-10', 'Active');
INSERT INTO CLUB (club_id, club_name, description, category, date_established, status)
VALUES (203, 'EcoSphere', 'Club promoting sustainability and environmental awareness', 'Environmental', DATE '2023-01-20', 'Active');
INSERT INTO CLUB (club_id, club_name, description, category, date_established, status)
VALUES (204, 'Innovators Hub', 'Club encouraging innovation, research, and entrepreneurship', 'Innovation', DATE '2024-02-05', 'Active');
INSERT INTO CLUB (club_id, club_name, description, category, date_established, status)
VALUES (205, 'string', 'string', 'string', DATE '2026-10-11', 'Active');

INSERT INTO ROLE (role_id, role_name, description)
VALUES (301, 'President', 'Leads the club and oversees its activities');
INSERT INTO ROLE (role_id, role_name, description)
VALUES (302, 'Vice President', 'Assists the president and coordinates operations');
INSERT INTO ROLE (role_id, role_name, description)
VALUES (303, 'Secretary', 'Maintains records and manages club documentation');
INSERT INTO ROLE (role_id, role_name, description)
VALUES (304, 'Member', 'Participates in club activities and events');

INSERT INTO CHAPTER (chapter_id, chapter_name, faculty_coordinator, established_date, club_id)
VALUES (401, 'Programming Chapter', 'Dr. Meera Krishnan', DATE '2024-01-10', 201);
INSERT INTO CHAPTER (chapter_id, chapter_name, faculty_coordinator, established_date, club_id)
VALUES (402, 'Digital Arts Chapter', 'Prof. Arjun Rao', DATE '2024-03-15', 202);
INSERT INTO CHAPTER (chapter_id, chapter_name, faculty_coordinator, established_date, club_id)
VALUES (403, 'Sustainability Chapter', 'Dr. Kavitha Menon', DATE '2024-06-20', 203);

-- =========================================================
-- 3. VENUE and EVENT
-- =========================================================
INSERT INTO VENUE (venue_id, venue_name, location, capacity, venue_type)
VALUES (601, 'Main Auditorium', 'Academic Block', 500, 'Auditorium');
INSERT INTO VENUE (venue_id, venue_name, location, capacity, venue_type)
VALUES (602, 'Seminar Hall A', 'Technology Tower', 150, 'Seminar Hall');
INSERT INTO VENUE (venue_id, venue_name, location, capacity, venue_type)
VALUES (603, 'Innovation Lab', 'Research Block', 80, 'Laboratory');
INSERT INTO VENUE (venue_id, venue_name, location, capacity, venue_type)
VALUES (604, 'Open Air Theatre', 'Central Campus', 300, 'Outdoor');

INSERT INTO EVENT (event_id, event_name, description, event_date, start_time, end_time, capacity, event_status, club_id, venue_id)
VALUES (701, 'CodeFest 2026', 'Coding competition and programming challenges',
        DATE '2026-11-10', TIMESTAMP '2026-11-10 09:00:00', TIMESTAMP '2026-11-10 17:00:00', 200, 'Upcoming', 201, 601);
INSERT INTO EVENT (event_id, event_name, description, event_date, start_time, end_time, capacity, event_status, club_id, venue_id)
VALUES (702, 'Digital Art Workshop', 'Workshop on digital illustration and design',
        DATE '2026-11-15', TIMESTAMP '2026-11-15 10:00:00', TIMESTAMP '2026-11-15 13:00:00', 100, 'Upcoming', 202, 602);
INSERT INTO EVENT (event_id, event_name, description, event_date, start_time, end_time, capacity, event_status, club_id, venue_id)
VALUES (703, 'Green Campus Drive', 'Environmental awareness and sustainability activity',
        DATE '2026-11-20', TIMESTAMP '2026-11-20 08:00:00', TIMESTAMP '2026-11-20 12:00:00', 150, 'Upcoming', 203, 604);
INSERT INTO EVENT (event_id, event_name, description, event_date, start_time, end_time, capacity, event_status, club_id, venue_id)
VALUES (704, 'Innovation Showcase', 'Student innovation and project exhibition',
        DATE '2026-11-25', TIMESTAMP '2026-11-25 09:30:00', TIMESTAMP '2026-11-25 16:00:00', 70, 'Upcoming', 204, 603);

-- =========================================================
-- 4. MEMBERSHIP (exact 70 records from supplied query output)
-- =========================================================
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (501,101,201,301,DATE '2026-01-10',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (502,102,201,304,DATE '2026-01-12',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (503,103,202,303,DATE '2026-01-15',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (504,104,203,304,DATE '2026-01-18',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (505,105,204,302,DATE '2026-01-20',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (506,106,201,304,DATE '2026-01-22',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (507,107,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (508,107,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (509,107,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (510,108,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (511,108,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (512,109,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (513,109,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (514,109,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (515,110,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (516,110,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (517,110,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (518,111,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (519,111,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (520,112,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (521,112,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (522,112,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (523,113,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (524,113,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (525,113,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (526,114,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (527,114,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (528,115,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (529,115,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (530,115,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (531,116,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (532,116,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (533,116,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (534,117,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (535,117,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (536,118,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (537,118,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (538,118,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (539,119,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (540,119,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (541,119,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (542,120,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (543,120,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (544,121,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (545,121,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (546,121,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (547,122,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (548,122,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (549,122,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (550,123,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (551,123,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (552,124,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (553,124,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (554,124,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (555,125,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (556,125,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (557,125,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (558,126,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (559,126,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (560,127,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (561,127,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (562,127,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (563,128,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (564,128,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (565,128,204,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (566,129,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (567,129,203,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (568,130,201,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (569,130,202,304,DATE '2026-08-01',NULL,'Active');
INSERT INTO MEMBERSHIP (membership_id, student_id, club_id, role_id, join_date, end_date, membership_status) VALUES (570,130,204,304,DATE '2026-08-01',NULL,'Active');

-- =========================================================
-- 5. REGISTRATION (exact 6 records)
-- =========================================================
INSERT INTO REGISTRATION (registration_id, student_id, event_id, registration_date, registration_status)
VALUES (801, 101, 701, DATE '2026-10-01', 'Registered');
INSERT INTO REGISTRATION (registration_id, student_id, event_id, registration_date, registration_status)
VALUES (802, 102, 701, DATE '2026-10-02', 'Registered');
INSERT INTO REGISTRATION (registration_id, student_id, event_id, registration_date, registration_status)
VALUES (803, 103, 702, DATE '2026-10-03', 'Registered');
INSERT INTO REGISTRATION (registration_id, student_id, event_id, registration_date, registration_status)
VALUES (804, 104, 703, DATE '2026-10-04', 'Registered');
INSERT INTO REGISTRATION (registration_id, student_id, event_id, registration_date, registration_status)
VALUES (805, 105, 704, DATE '2026-10-05', 'Registered');
INSERT INTO REGISTRATION (registration_id, student_id, event_id, registration_date, registration_status)
VALUES (806, 106, 701, DATE '2026-10-06', 'Registered');

-- =========================================================
-- 6. ATTENDANCE
-- =========================================================
INSERT INTO ATTENDANCE (attendance_id, registration_id, attendance_status, check_in_time)
VALUES (901, 801, 'Present', TIMESTAMP '2026-11-10 09:05:00');
INSERT INTO ATTENDANCE (attendance_id, registration_id, attendance_status, check_in_time)
VALUES (902, 802, 'Present', TIMESTAMP '2026-11-10 09:15:00');
INSERT INTO ATTENDANCE (attendance_id, registration_id, attendance_status, check_in_time)
VALUES (903, 803, 'Present', TIMESTAMP '2026-11-15 10:10:00');
INSERT INTO ATTENDANCE (attendance_id, registration_id, attendance_status, check_in_time)
VALUES (904, 804, 'Absent', NULL);

-- =========================================================
-- 7. FEEDBACK
-- =========================================================
INSERT INTO FEEDBACK (feedback_id, student_id, event_id, rating, comments, feedback_date)
VALUES (1001, 101, 701, 5, 'Excellent event with informative sessions', DATE '2026-11-10');
INSERT INTO FEEDBACK (feedback_id, student_id, event_id, rating, comments, feedback_date)
VALUES (1002, 102, 701, 4, 'Well organized and engaging', DATE '2026-11-10');
INSERT INTO FEEDBACK (feedback_id, student_id, event_id, rating, comments, feedback_date)
VALUES (1003, 103, 702, 5, 'Enjoyed the creative activities', DATE '2026-11-15');
INSERT INTO FEEDBACK (feedback_id, student_id, event_id, rating, comments, feedback_date)
VALUES (1004, 105, 704, 4, 'Interesting presentations', DATE '2026-11-20');

-- =========================================================
-- 8. RESOURCE and RESOURCE_BOOKING
-- =========================================================
INSERT INTO "RESOURCE" (resource_id, resource_name, resource_type, quantity_available, condition_status)
VALUES (1101, 'Projector', 'Electronics', 5, 'Good');
INSERT INTO "RESOURCE" (resource_id, resource_name, resource_type, quantity_available, condition_status)
VALUES (1102, 'Laptop', 'Electronics', 10, 'Good');
INSERT INTO "RESOURCE" (resource_id, resource_name, resource_type, quantity_available, condition_status)
VALUES (1103, 'Microphone', 'Audio Equipment', 8, 'Good');
INSERT INTO "RESOURCE" (resource_id, resource_name, resource_type, quantity_available, condition_status)
VALUES (1104, 'Folding Chairs', 'Furniture', 100, 'Good');

INSERT INTO RESOURCE_BOOKING (booking_id, resource_id, event_id, quantity, booking_start, booking_end, booking_status)
VALUES (1201, 1101, 701, 2, TIMESTAMP '2026-11-10 08:00:00', TIMESTAMP '2026-11-10 17:00:00', 'Approved');
INSERT INTO RESOURCE_BOOKING (booking_id, resource_id, event_id, quantity, booking_start, booking_end, booking_status)
VALUES (1202, 1102, 701, 3, TIMESTAMP '2026-11-10 08:00:00', TIMESTAMP '2026-11-10 17:00:00', 'Approved');
INSERT INTO RESOURCE_BOOKING (booking_id, resource_id, event_id, quantity, booking_start, booking_end, booking_status)
VALUES (1203, 1103, 702, 2, TIMESTAMP '2026-11-15 09:00:00', TIMESTAMP '2026-11-15 16:00:00', 'Approved');
INSERT INTO RESOURCE_BOOKING (booking_id, resource_id, event_id, quantity, booking_start, booking_end, booking_status)
VALUES (1204, 1104, 703, 30, TIMESTAMP '2026-11-18 08:00:00', TIMESTAMP '2026-11-18 15:00:00', 'Pending');

-- =========================================================
-- 9. BUDGET and EXPENSE
-- =========================================================
INSERT INTO BUDGET (budget_id, club_id, academic_year, allocated_amount, remaining_amount)
VALUES (1301, 201, '2026-2027', 100000, 75000);
INSERT INTO BUDGET (budget_id, club_id, academic_year, allocated_amount, remaining_amount)
VALUES (1302, 202, '2026-2027', 60000, 45000);
INSERT INTO BUDGET (budget_id, club_id, academic_year, allocated_amount, remaining_amount)
VALUES (1303, 203, '2026-2027', 50000, 35000);
INSERT INTO BUDGET (budget_id, club_id, academic_year, allocated_amount, remaining_amount)
VALUES (1304, 204, '2026-2027', 80000, 60000);

INSERT INTO EXPENSE (expense_id, budget_id, event_id, expense_date, amount, description)
VALUES (1401, 1301, 701, DATE '2026-11-10', 15000, 'Venue and equipment expenses');
INSERT INTO EXPENSE (expense_id, budget_id, event_id, expense_date, amount, description)
VALUES (1402, 1301, 701, DATE '2026-11-10', 8000, 'Promotional materials');
INSERT INTO EXPENSE (expense_id, budget_id, event_id, expense_date, amount, description)
VALUES (1403, 1302, 702, DATE '2026-11-15', 5000, 'Art supplies and materials');
INSERT INTO EXPENSE (expense_id, budget_id, event_id, expense_date, amount, description)
VALUES (1404, 1303, 703, DATE '2026-11-18', 7000, 'Planting materials and supplies');

-- =========================================================
-- 10. SPONSOR and SPONSORSHIP
-- =========================================================
INSERT INTO SPONSOR (sponsor_id, sponsor_name, contact_person, email, phone)
VALUES (1501, 'TechNova Solutions', 'Rahul Sharma', 'contact@technova.example', '9876510001');
INSERT INTO SPONSOR (sponsor_id, sponsor_name, contact_person, email, phone)
VALUES (1502, 'Creative Minds Studio', 'Priya Nair', 'info@creativeminds.example', '9876510002');
INSERT INTO SPONSOR (sponsor_id, sponsor_name, contact_person, email, phone)
VALUES (1503, 'Green Earth Foundation', 'Arun Kumar', 'support@greenearth.example', '9876510003');
INSERT INTO SPONSOR (sponsor_id, sponsor_name, contact_person, email, phone)
VALUES (1504, 'FutureWorks Innovations', 'Neha Rao', 'hello@futureworks.example', '9876510004');

INSERT INTO SPONSORSHIP (sponsorship_id, sponsor_id, club_id, event_id, amount, sponsorship_date)
VALUES (1601, 1501, 201, 701, 25000, DATE '2026-10-01');
INSERT INTO SPONSORSHIP (sponsorship_id, sponsor_id, club_id, event_id, amount, sponsorship_date)
VALUES (1602, 1502, 202, 702, 15000, DATE '2026-10-05');
INSERT INTO SPONSORSHIP (sponsorship_id, sponsor_id, club_id, event_id, amount, sponsorship_date)
VALUES (1603, 1503, 203, 703, 20000, DATE '2026-10-08');
INSERT INTO SPONSORSHIP (sponsorship_id, sponsor_id, club_id, event_id, amount, sponsorship_date)
VALUES (1604, 1504, 204, 704, 30000, DATE '2026-10-10');

COMMIT;

-- Expected counts after running in a fresh, compatible schema:
-- STUDENT 30, CLUB 5, CHAPTER 3, ROLE 4, MEMBERSHIP 70,
-- VENUE 4, EVENT 4, REGISTRATION 6, ATTENDANCE 4, FEEDBACK 4,
-- RESOURCE 4, RESOURCE_BOOKING 4, BUDGET 4, EXPENSE 4,
-- SPONSOR 4, SPONSORSHIP 4.
