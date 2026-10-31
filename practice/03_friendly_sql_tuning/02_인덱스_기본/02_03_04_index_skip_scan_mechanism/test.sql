-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM employee_skip
WHERE salary >= 8000;
