-- @engine: postgres
-- 검증 테스트 스크립트
SELECT COUNT(*) = 3 AS test_passed
FROM (SELECT user_id FROM customer_orders GROUP BY user_id);
