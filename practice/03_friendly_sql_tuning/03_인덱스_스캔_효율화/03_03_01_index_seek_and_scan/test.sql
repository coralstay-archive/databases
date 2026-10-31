-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) AS cnt
FROM emp_tune
WHERE deptno = 30 AND sal >= 1500;
-- 1건 (ALLEN) 반환 검증
