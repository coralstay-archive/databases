-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed
FROM dept_emp
WHERE dept_no = 'd001' AND emp_no >= 10002;
