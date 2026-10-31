-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM quarterly_sales
GROUP BY rep_name;
