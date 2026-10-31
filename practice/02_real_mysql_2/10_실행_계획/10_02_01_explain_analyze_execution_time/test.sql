-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM orders
WHERE customer_id = 101 AND order_date >= '2026-01-01';
