-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 3 AS test_passed
FROM (SELECT category FROM perf_benchmark GROUP BY category);
