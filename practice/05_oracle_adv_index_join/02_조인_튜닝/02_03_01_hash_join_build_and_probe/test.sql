-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM departments d
JOIN employees_large e ON d.dept_id = e.dept_id
WHERE d.dept_id = 10;
