-- ============================================================
-- MENTOR–MENTEE ACADEMIC MONITORING SYSTEM (MMAMS)
-- FILE 3: queries.sql — All Queries
-- By: Chetan (24040112009) and Akashh (24040112003)
-- ============================================================

USE mmams;

-- ============================================================
-- SECTION A: DESCRIBE ALL TABLES
-- ============================================================

DESC mentor;
DESC mentee;
DESC mentorship_assignment;
DESC meeting;
DESC progress_report;
DESC goal;
DESC action_item;
DESC intervention;

-- ============================================================
-- SECTION B: VIEW ALL TABLE DATA
-- ============================================================

SELECT * FROM mentor;
SELECT * FROM mentee;
SELECT * FROM mentorship_assignment;
SELECT * FROM meeting;
SELECT * FROM progress_report;
SELECT * FROM goal;
SELECT * FROM action_item;
SELECT * FROM intervention;

-- ============================================================
-- SECTION C: ANALYTICAL QUERIES
-- ============================================================

-- Q1: All mentees under a specific mentor (mentor_id = 1)
SELECT mt.name AS mentee_name, mt.current_gpa, ma.role, ma.status
FROM mentorship_assignment ma
JOIN mentee mt ON ma.mentee_id = mt.mentee_id
WHERE ma.mentor_id = 1;

-- Q2: Meeting history for a specific mentee (mentee_id = 1)
SELECT m.date, m.time, m.mode, m.summary
FROM meeting m
JOIN mentorship_assignment ma ON m.assignment_id = ma.assignment_id
WHERE ma.mentee_id = 1
ORDER BY m.date DESC;

-- Q3: High-risk mentees
SELECT mt.name, mt.university_id, pr.gpa, pr.attendance_percentage, pr.risk_level
FROM progress_report pr
JOIN mentee mt ON pr.mentee_id = mt.mentee_id
WHERE pr.risk_level = 'HIGH';

-- Q4: Total mentee count per mentor
SELECT mr.name AS mentor_name, COUNT(ma.mentee_id) AS total_mentees
FROM mentor mr
LEFT JOIN mentorship_assignment ma ON mr.mentor_id = ma.mentor_id AND ma.status = 'Active'
GROUP BY mr.mentor_id, mr.name;

-- Q5: All open action items with mentee name
SELECT ai.description, ai.assigned_to, ai.due_date, mt.name AS mentee_name
FROM action_item ai
JOIN meeting m ON ai.meeting_id = m.meeting_id
JOIN mentorship_assignment ma ON m.assignment_id = ma.assignment_id
JOIN mentee mt ON ma.mentee_id = mt.mentee_id
WHERE ai.status = 'OPEN';

-- Q6: Goals currently in progress
SELECT mt.name, g.title, g.target_date, g.status
FROM goal g
JOIN mentee mt ON g.mentee_id = mt.mentee_id
WHERE g.status = 'IN_PROGRESS';

-- Q7: All interventions for a specific mentee (mentee_id = 2)
SELECT i.type, i.description, i.scheduled_date, i.status, mr.name AS mentor_name
FROM intervention i
JOIN mentor mr ON i.mentor_id = mr.mentor_id
WHERE i.mentee_id = 2;

-- Q8: Average GPA of mentees per mentor
SELECT mr.name AS mentor_name, ROUND(AVG(pr.gpa), 2) AS avg_gpa
FROM progress_report pr
JOIN mentor mr ON pr.mentor_id = mr.mentor_id
GROUP BY mr.mentor_id, mr.name;

-- Q9: Mentees with attendance below 80%
SELECT mt.name, mt.university_id, pr.attendance_percentage
FROM progress_report pr
JOIN mentee mt ON pr.mentee_id = mt.mentee_id
WHERE pr.attendance_percentage < 80;

-- Q10: Full progress summary report (all mentees)
SELECT
    mt.name                AS mentee_name,
    mt.university_id,
    mr.name                AS mentor_name,
    pr.gpa,
    pr.attendance_percentage,
    pr.strengths,
    pr.weaknesses,
    pr.risk_level
FROM progress_report pr
JOIN mentee mt ON pr.mentee_id = mt.mentee_id
JOIN mentor mr ON pr.mentor_id = mr.mentor_id
ORDER BY pr.risk_level DESC, pr.gpa ASC;

-- Q11: Derived age of all mentees (age computed from date_of_birth)
SELECT name, date_of_birth,
    (YEAR(NOW()) - YEAR(date_of_birth)) AS age
FROM mentee;

-- Q12: Mentors who have not yet reached their max mentee capacity
SELECT mr.name, mr.max_mentees, COUNT(ma.mentee_id) AS current_mentees
FROM mentor mr
LEFT JOIN mentorship_assignment ma ON mr.mentor_id = ma.mentor_id AND ma.status = 'Active'
GROUP BY mr.mentor_id, mr.name, mr.max_mentees
HAVING COUNT(ma.mentee_id) < mr.max_mentees;
