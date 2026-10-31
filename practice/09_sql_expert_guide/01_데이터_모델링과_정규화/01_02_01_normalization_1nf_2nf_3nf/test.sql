-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 3 AS test_passed
FROM student_profile s
JOIN student_major m ON s.major_id = m.major_id;
