-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed
FROM customers c
WHERE c.city = '서울'
  AND EXISTS (
      SELECT 1 
      FROM contracts k 
      WHERE k.cust_id = c.cust_id AND k.contract_amount >= 3000000
  );
