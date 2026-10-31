-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 3 AS test_passed
FROM (
    SELECT pay_id FROM payment_card
    UNION ALL
    SELECT pay_id FROM payment_bank
);
