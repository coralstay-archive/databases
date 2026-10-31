-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed
FROM sales_history
WHERE sale_date BETWEEN '2026-01-01' AND '2026-12-31';
