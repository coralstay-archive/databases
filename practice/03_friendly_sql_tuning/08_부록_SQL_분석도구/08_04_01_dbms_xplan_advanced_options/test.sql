-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed
FROM account_audit
WHERE user_no = 1001;
