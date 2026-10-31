-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed
FROM online_sales
WHERE media_code IN ('01', '02') AND sale_date = '20261020';
