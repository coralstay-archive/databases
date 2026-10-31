-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM contracts_basic
WHERE contract_date >= TO_DATE('2026-01-01', 'YYYY-MM-DD')
  AND contract_date <  TO_DATE('2027-01-01', 'YYYY-MM-DD');
