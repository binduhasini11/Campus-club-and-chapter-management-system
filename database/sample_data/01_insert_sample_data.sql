-- CAMPUS CLUB AND CHAPTER MANAGEMENT SYSTEM
-- SAMPLE DATA: STUDENT


INSERT INTO STUDENT
    (student_id, student_name, email, phone, department, year_of_study)
VALUES
    (101, 'Bindu Hasini', 'bindu.hasini@example.com', '9876500001', 'CSE', 2);

INSERT INTO STUDENT
    (student_id, student_name, email, phone, department, year_of_study)
VALUES
    (102, 'Ashwitha', 'ashwitha@example.com', '9876500002', 'CSE', 2);

INSERT INTO STUDENT
    (student_id, student_name, email, phone, department, year_of_study)
VALUES
    (103, 'Anushka Shivram', 'anushka.shivram@example.com', '9876500003', 'CSE', 2);

INSERT INTO STUDENT
    (student_id, student_name, email, phone, department, year_of_study)
VALUES
    (104, 'Shreenidhi', 'hreenidhi@example.com', '9876500004', 'CSE', 2);

INSERT INTO STUDENT
    (student_id, student_name, email, phone, department, year_of_study)
VALUES
    (105, 'Diya Reddy', 'diya.reddy@example.com', '9876500005', 'ECE', 2);

INSERT INTO STUDENT
    (student_id, student_name, email, phone, department, year_of_study)
VALUES
    (106, 'Rohan Kumar', 'rohan.kumar@example.com', '9876500006', 'IT', 3);

COMMIT;


-- SAMPLE DATA: CLUB
INSERT INTO CLUB
    (club_id, club_name, description, category, date_established, status)
VALUES
    (201, 'CodeCraft', 'Technical club for coding and software development', 'Technical', DATE '2023-08-15', 'Active');

INSERT INTO CLUB
    (club_id, club_name, description, category, date_established, status)
VALUES
    (202, 'Pixel Society', 'Club for graphic design, photography, and digital art', 'Arts', DATE '2022-09-10', 'Active');

INSERT INTO CLUB
    (club_id, club_name, description, category, date_established, status)
VALUES
    (203, 'EcoSphere', 'Club promoting sustainability and environmental awareness', 'Environmental', DATE '2023-01-20', 'Active');

INSERT INTO CLUB
    (club_id, club_name, description, category, date_established, status)
VALUES
    (204, 'Innovators Hub', 'Club encouraging innovation, research, and entrepreneurship', 'Innovation', DATE '2024-02-05', 'Active');

COMMIT;