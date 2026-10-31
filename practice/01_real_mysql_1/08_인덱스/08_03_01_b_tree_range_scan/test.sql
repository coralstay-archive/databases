-- @engine: mysql
-- 검증 테스트 스크립트
-- 검증: 조건에 부합하는 사원이 2명(Bamford, Facello)인지 단언
SELECT COUNT(*) = 2 AS test_passed
FROM employees
WHERE last_name BETWEEN 'Bamford' AND 'Facello';
