-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM salaries
WHERE emp_no = 10001 AND salary > 60000;
