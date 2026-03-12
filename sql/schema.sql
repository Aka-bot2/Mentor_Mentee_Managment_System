-- ============================================================
-- MENTOR–MENTEE ACADEMIC MONITORING SYSTEM (MMAMS)
-- FILE 1: schema.sql — Database & Table Structure
-- By: Chetan (24040112009) and Akashh (24040112003)
-- ============================================================

DROP DATABASE IF EXISTS mmams;
CREATE DATABASE mmams;
USE mmams;

-- TABLE 1: mentor
CREATE TABLE mentor (
    mentor_id       INT          PRIMARY KEY NOT NULL,
    name            VARCHAR(60)  NOT NULL,
    gender          ENUM('MALE','FEMALE','OTHER') NOT NULL,
    email           VARCHAR(60)  UNIQUE NOT NULL,
    contact         VARCHAR(15)  CHECK(LENGTH(contact) = 10),
    mentor_type     ENUM('FACULTY','PEER') NOT NULL,
    department      VARCHAR(50)  NOT NULL,
    max_mentees     INT          CHECK(max_mentees > 0),
    status          VARCHAR(20)  NOT NULL
);

-- TABLE 2: mentee
-- NOTE: age is a derived attribute, computed in queries using (YEAR(NOW()) - YEAR(date_of_birth))
CREATE TABLE mentee (
    mentee_id           INT          PRIMARY KEY NOT NULL,
    university_id       VARCHAR(20)  UNIQUE NOT NULL,
    name                VARCHAR(60)  NOT NULL,
    gender              ENUM('MALE','FEMALE','OTHER') NOT NULL,
    date_of_birth       DATE         NOT NULL,
    email               VARCHAR(60)  UNIQUE NOT NULL,
    contact             VARCHAR(15)  NOT NULL,
    programme           VARCHAR(50)  NOT NULL,
    enrollment_year     YEAR         NOT NULL,
    current_semester    INT          CHECK(current_semester > 0),
    current_gpa         DECIMAL(3,2) CHECK(current_gpa BETWEEN 0 AND 10),
    status              VARCHAR(20)  NOT NULL
);

-- TABLE 3: mentorship_assignment
CREATE TABLE mentorship_assignment (
    assignment_id   INT  PRIMARY KEY AUTO_INCREMENT,
    mentor_id       INT  NOT NULL,
    mentee_id       INT  NOT NULL,
    role            ENUM('PRIMARY','SECONDARY') NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE,
    status          VARCHAR(20) NOT NULL,
    FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TABLE 4: meeting
CREATE TABLE meeting (
    meeting_id          INT  PRIMARY KEY AUTO_INCREMENT,
    assignment_id       INT  NOT NULL,
    date                DATE NOT NULL,
    time                TIME NOT NULL,
    mode                ENUM('ONLINE','OFFLINE') NOT NULL,
    summary             TEXT NOT NULL,
    next_meeting_date   DATE,
    FOREIGN KEY (assignment_id) REFERENCES mentorship_assignment(assignment_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TABLE 5: progress_report
CREATE TABLE progress_report (
    report_id               INT          PRIMARY KEY AUTO_INCREMENT,
    mentee_id               INT          NOT NULL,
    mentor_id               INT          NOT NULL,
    report_date             DATE         NOT NULL,
    gpa                     DECIMAL(3,2) CHECK(gpa BETWEEN 0 AND 10),
    attendance_percentage   DECIMAL(5,2) CHECK(attendance_percentage BETWEEN 0 AND 100),
    strengths               VARCHAR(100),
    weaknesses              VARCHAR(100),
    risk_level              ENUM('LOW','MEDIUM','HIGH') NOT NULL,
    FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TABLE 6: goal
CREATE TABLE goal (
    goal_id     INT          PRIMARY KEY AUTO_INCREMENT,
    mentee_id   INT          NOT NULL,
    title       VARCHAR(100) NOT NULL,
    description VARCHAR(200) NOT NULL,
    target_date DATE         NOT NULL,
    status      ENUM('NOT_STARTED','IN_PROGRESS','COMPLETED') NOT NULL,
    FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TABLE 7: action_item
CREATE TABLE action_item (
    action_id   INT          PRIMARY KEY AUTO_INCREMENT,
    meeting_id  INT          NOT NULL,
    description VARCHAR(200) NOT NULL,
    assigned_to ENUM('MENTOR','MENTEE') NOT NULL,
    due_date    DATE         NOT NULL,
    status      ENUM('OPEN','COMPLETED') NOT NULL,
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- TABLE 8: intervention
CREATE TABLE intervention (
    intervention_id INT          PRIMARY KEY AUTO_INCREMENT,
    mentee_id       INT          NOT NULL,
    mentor_id       INT          NOT NULL,
    type            VARCHAR(50)  NOT NULL,
    description     VARCHAR(200) NOT NULL,
    scheduled_date  DATE         NOT NULL,
    status          ENUM('PLANNED','COMPLETED') NOT NULL,
    FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
