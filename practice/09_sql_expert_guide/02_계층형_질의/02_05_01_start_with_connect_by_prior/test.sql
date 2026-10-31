-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 7 AS test_passed
FROM emp_hierarchy
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr;
