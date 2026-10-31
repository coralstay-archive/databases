-- @engine: multi
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;
