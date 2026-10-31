-- @engine: postgres
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM inventory_items
WHERE stock_qty IS DISTINCT FROM 0;
