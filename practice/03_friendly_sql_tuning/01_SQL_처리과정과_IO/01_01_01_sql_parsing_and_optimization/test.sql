-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM customer_info
WHERE credit_limit >= 5000000;
