-- @engine: mysql
-- 검증 테스트 스크립트
SELECT balance = 6000 AS test_passed FROM wallet WHERE user_id = 1;
