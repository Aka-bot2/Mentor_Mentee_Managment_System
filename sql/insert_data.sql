-- ============================================================
-- MENTOR–MENTEE ACADEMIC MONITORING SYSTEM (MMAMS)
-- FILE 2: insert_data.sql — Sample Data
-- By: Chetan (24040112009) and Akashh (24040112003)
-- ============================================================

USE mmams;

-- MENTORS
INSERT INTO mentor VALUES
(1, 'Dr. Priya Sharma',  'FEMALE', 'priya.sharma@uni.edu',  '9876543210', 'FACULTY', 'Computer Science', 10, 'Active'),
(2, 'Prof. Rajan Mehta', 'MALE',   'rajan.mehta@uni.edu',   '9123456780', 'FACULTY', 'Information Tech',  8, 'Active'),
(3, 'Arun Kumar',        'MALE',   'arun.kumar@uni.edu',    '9988776655', 'PEER',    'Computer Science',  5, 'Active');

-- MENTEES
INSERT INTO mentee VALUES
(1, '24040112001', 'Amit Verma',  'MALE',   '2005-06-15', 'amit.v@uni.edu',   '9001234567', 'B.Tech CSE', 2024, 1, 8.50, 'Active'),
(2, '24040112002', 'Sneha Patil', 'FEMALE', '2004-11-20', 'sneha.p@uni.edu',  '9007654321', 'B.Tech IT',  2024, 1, 7.80, 'Active'),
(3, '24040112003', 'Akashh',      'MALE',   '2005-03-10', 'akashh@uni.edu',   '9009876543', 'B.Tech CSE', 2024, 1, 9.10, 'Active'),
(4, '24040112009', 'Chetan',      'MALE',   '2005-07-22', 'chetan@uni.edu',   '9001122334', 'B.Tech CSE', 2024, 1, 8.75, 'Active');

-- MENTORSHIP ASSIGNMENTS
INSERT INTO mentorship_assignment (mentor_id, mentee_id, role, start_date, end_date, status) VALUES
(1, 1, 'PRIMARY',   '2024-08-01', NULL, 'Active'),
(1, 2, 'PRIMARY',   '2024-08-01', NULL, 'Active'),
(2, 3, 'PRIMARY',   '2024-08-01', NULL, 'Active'),
(2, 4, 'PRIMARY',   '2024-08-01', NULL, 'Active'),
(3, 1, 'SECONDARY', '2024-09-01', NULL, 'Active');

-- MEETINGS
INSERT INTO meeting (assignment_id, date, time, mode, summary, next_meeting_date) VALUES
(1, '2024-09-05', '10:00:00', 'OFFLINE', 'Discussed semester goals and academic plan.',   '2024-10-05'),
(1, '2024-10-05', '10:00:00', 'ONLINE',  'Reviewed mid-term performance. GPA improved.', '2024-11-05'),
(3, '2024-09-10', '11:00:00', 'OFFLINE', 'Set research project milestones.',             '2024-10-10');

-- PROGRESS REPORTS
INSERT INTO progress_report (mentee_id, mentor_id, report_date, gpa, attendance_percentage, strengths, weaknesses, risk_level) VALUES
(1, 1, '2024-10-15', 8.50, 85.00, 'Analytical thinking, problem solving', 'Time management',        'LOW'),
(2, 1, '2024-10-15', 7.80, 78.00, 'Communication skills',                 'Mathematics, attendance', 'MEDIUM'),
(3, 2, '2024-10-15', 9.10, 92.00, 'Research aptitude, coding',            'Presentation skills',     'LOW'),
(4, 2, '2024-10-15', 8.75, 88.00, 'Database design, teamwork',            'Algorithms',              'LOW');

-- GOALS
INSERT INTO goal (mentee_id, title, description, target_date, status) VALUES
(1, 'Improve DSA Skills',    'Complete 100 DSA problems on LeetCode.',              '2024-12-31', 'IN_PROGRESS'),
(2, 'Raise Attendance',      'Maintain attendance above 85% this semester.',        '2024-11-30', 'IN_PROGRESS'),
(3, 'Complete Mini Project', 'Build a full-stack web app as mini project.',         '2024-12-15', 'NOT_STARTED'),
(4, 'DBMS Assignment',       'Complete and submit DBMS project with full queries.', '2024-11-20', 'COMPLETED');

-- ACTION ITEMS
INSERT INTO action_item (meeting_id, description, assigned_to, due_date, status) VALUES
(1, 'Submit academic plan document.',      'MENTEE', '2024-09-15', 'COMPLETED'),
(1, 'Review mentee academic plan.',        'MENTOR', '2024-09-20', 'COMPLETED'),
(2, 'Practice 20 DSA problems per week.',  'MENTEE', '2024-11-01', 'OPEN'),
(3, 'Finalize project topic.',             'MENTEE', '2024-09-20', 'COMPLETED');

-- INTERVENTIONS
INSERT INTO intervention (mentee_id, mentor_id, type, description, scheduled_date, status) VALUES
(2, 1, 'Tutoring',   'Extra math sessions to improve performance.', '2024-10-20', 'COMPLETED'),
(2, 1, 'Counseling', 'Discuss stress management and study habits.', '2024-11-01', 'PLANNED');
