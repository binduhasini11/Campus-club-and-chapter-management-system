# Normalization
## Club and Chapter Management System

### 1. Objective

Normalization is the process of organizing relations in a database
to reduce unnecessary redundancy and prevent insertion, update,
and deletion anomalies.

The Club and Chapter Management System uses separate relations
for students, clubs, events, memberships, registrations, and other
entities to organize related information.

### 2. First Normal Form (1NF)

A relation is in First Normal Form when:
- Each attribute contains a single, atomic value.
- There are no repeating groups or multivalued attributes.
- Each record can be uniquely identified by a key.

#### Project Example: STUDENT

STUDENT(
student_id,
student_name,
email,
phone,
department,
year_of_study
)

Primary Key: student_id

Each student record stores individual student details.
The attributes represent individual values, and student_id
uniquely identifies each record.

Therefore, STUDENT satisfies the structural requirements
of 1NF, assuming each stored value is atomic.

### 3. Second Normal Form (2NF)

A relation is in Second Normal Form when:
- It is already in 1NF.
- No non-prime attribute is partially dependent on a proper
  subset of any candidate key.

A partial dependency can occur when a non-key attribute depends
on only part of a composite candidate key.

#### Project Example: MEMBERSHIP

MEMBERSHIP(
membership_id,
student_id,
club_id,
role_id,
join_date,
end_date,
membership_status
)

Primary Key: membership_id

Foreign Keys:
- student_id references STUDENT(student_id)
- club_id references CLUB(club_id)
- role_id references ROLE(role_id)

The MEMBERSHIP relation represents the association between
students and clubs and stores membership-specific information,
including the assigned role and membership dates.

The declared primary key is the single attribute membership_id.
Therefore, there cannot be a partial dependency on a proper
subset of this single-attribute primary key.

To establish full 2NF formally, all candidate keys and their
functional dependencies must also be considered.

### 4. Third Normal Form (3NF)

A relation is in Third Normal Form when:
- It is already in 2NF.
- For every non-trivial functional dependency X → A,
  either X is a superkey or A is a prime attribute.

In simple terms, non-key attributes should not depend
transitively on a key through another non-key attribute.

#### Project Example: EVENT and VENUE

EVENT(
event_id,
event_name,
description,
event_date,
start_time,
end_time,
capacity,
event_status,
club_id,
venue_id
)

Primary Key: event_id

Foreign Keys:
- club_id references CLUB(club_id)
- venue_id references VENUE(venue_id)

VENUE(
venue_id,
venue_name,
location,
capacity,
venue_type
)

Primary Key: venue_id

Venue-specific information is maintained in VENUE and referenced
by EVENT through venue_id. This avoids storing the venue's
descriptive information repeatedly in every event record.

This separation supports a normalized design. A formal 3NF
claim requires verification of the functional dependencies
within the relations.

### 5. Other Associative Relations

The schema includes the following associative relations:

- MEMBERSHIP represents the association between STUDENT and CLUB.
- REGISTRATION represents the association between STUDENT and EVENT.
- RESOURCE_BOOKING represents the association between RESOURCE and EVENT.
- SPONSORSHIP references SPONSOR, CLUB, and EVENT.

These relations store information specific to their respective
associations.

### 6. Conclusion

The database separates student, club, event, venue, resource,
budget, and sponsorship information into related tables.

Primary keys identify records, and foreign keys establish
relationships between tables.

The design reduces unnecessary duplication by keeping
information about distinct entities in separate relations.
Formal confirmation of 1NF, 2NF, and 3NF requires checking
the attributes, candidate keys, and functional dependencies
of the relations.