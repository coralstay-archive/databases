-- @engine: postgres
-- 검증 테스트 스크립트
SELECT COUNT(*) = 8 AS test_passed
FROM daily_sales;
