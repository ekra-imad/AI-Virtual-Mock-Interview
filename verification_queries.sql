-- ============================================================================
-- AI Interview Platform - Database Verification Scripts (Phase T2)
-- ============================================================================
-- This file contains SQL queries to verify database correctness, state transitions,
-- scoring updates, history ordering, and foreign-key integrity after each API call.
-- ============================================================================

-- ============================================================================
-- 1. POST /api/auth/register & POST /api/auth/login
-- ============================================================================
-- Verification: Confirm user was inserted correctly with unique username and email.
SELECT 
    id AS user_id, 
    username, 
    email, 
    created_at 
FROM users 
WHERE username = 'testuser';

-- ============================================================================
-- 2. GET /api/roles
-- ============================================================================
-- Verification: Confirm predefined interview roles exist and are populated correctly.
SELECT 
    id AS role_id, 
    name, 
    description, 
    created_at 
FROM roles 
ORDER BY id ASC;


-- ============================================================================
-- 3. POST /api/interview/start
-- ============================================================================
-- Verification A: Confirm InterviewSession is created with status = 'IN_PROGRESS' 
-- and correct foreign-key relationships (user_id and role_id).
SELECT 
    s.id AS session_id,
    s.user_id,
    u.username,
    s.role_id,
    r.name AS role_name,
    s.status,
    s.total_score,
    s.created_at
FROM interview_sessions s
JOIN users u ON s.user_id = u.id
JOIN roles r ON s.role_id = r.id
WHERE s.user_id = 1 
ORDER BY s.created_at DESC 
LIMIT 1;

-- Verification B: Confirm the first question is retrieved correctly in ascending order of ID.
SELECT 
    q.id AS question_id,
    q.role_id,
    q.topic,
    q.difficulty,
    q.question_text,
    q.ideal_answer
FROM questions q
WHERE q.role_id = 1
ORDER BY q.id ASC
LIMIT 1;


-- ============================================================================
-- 4. POST /api/interview/answer (Iterative Submission & Session Completion)
-- ============================================================================
-- Verification A: Confirm AnswerEvaluation is stored correctly linked to session_id 
-- and question_id, preserving the user answer, similarity score, and remark.
SELECT 
    ae.id AS evaluation_id,
    ae.session_id,
    ae.question_id,
    q.question_text,
    ae.user_answer,
    ae.similarity_score,
    ae.remark,
    ae.evaluated_at
FROM answer_evaluations ae
JOIN questions q ON ae.question_id = q.id
WHERE ae.session_id = 1
ORDER BY ae.evaluated_at ASC;

-- Verification B: Confirm session status and total_score update (intermediate or completed).
SELECT 
    id AS session_id,
    user_id,
    role_id,
    status,
    total_score,
    created_at
FROM interview_sessions
WHERE id = 1;


-- ============================================================================
-- 5. GET /api/result/{sessionId}
-- ============================================================================
-- Verification: Confirm all evaluated questions, answers, ideal answers, and scores 
-- can be retrieved together for a given session with foreign key integrity.
SELECT 
    s.id AS session_id,
    u.username,
    r.name AS role_name,
    s.status,
    s.total_score,
    q.id AS question_id,
    q.question_text,
    q.ideal_answer,
    ae.user_answer,
    ae.similarity_score,
    ae.remark
FROM interview_sessions s
JOIN users u ON s.user_id = u.id
JOIN roles r ON s.role_id = r.id
JOIN answer_evaluations ae ON s.id = ae.session_id
JOIN questions q ON ae.question_id = q.id
WHERE s.id = 1;


-- ============================================================================
-- 6. GET /api/history/{userId}
-- ============================================================================
-- Verification: Confirm user history is retrieved with correct role names, total scores,
-- and ordered by newest first (`created_at DESC` or `id DESC`).
SELECT 
    s.id AS session_id,
    r.name AS role_name,
    s.status,
    s.total_score,
    s.created_at AS interview_date
FROM interview_sessions s
JOIN roles r ON s.role_id = r.id
WHERE s.user_id = 1
ORDER BY s.created_at DESC;


-- ============================================================================
-- 7. Foreign-Key Integrity & Constraint Verification Queries
-- ============================================================================
-- Verification A: Check that all questions correctly reference valid roles.
SELECT 
    q.id AS question_id,
    q.role_id,
    r.name AS role_name
FROM questions q
LEFT JOIN roles r ON q.role_id = r.id
WHERE r.id IS NULL; -- Should return 0 rows

-- Verification B: Check that all interview sessions reference valid users and roles.
SELECT 
    s.id AS session_id,
    s.user_id,
    s.role_id
FROM interview_sessions s
LEFT JOIN users u ON s.user_id = u.id
LEFT JOIN roles r ON s.role_id = r.id
WHERE u.id IS NULL OR r.id IS NULL; -- Should return 0 rows

-- Verification C: Check that all answer evaluations reference valid sessions and questions.
SELECT 
    ae.id AS evaluation_id,
    ae.session_id,
    ae.question_id
FROM answer_evaluations ae
LEFT JOIN interview_sessions s ON ae.session_id = s.id
LEFT JOIN questions q ON ae.question_id = q.id
WHERE s.id IS NULL OR q.id IS NULL; -- Should return 0 rows
