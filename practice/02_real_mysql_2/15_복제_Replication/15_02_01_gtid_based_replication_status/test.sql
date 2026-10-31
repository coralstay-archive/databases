-- @engine: mysql
-- 검증 테스트 스크립트
SELECT @@GLOBAL.server_id > 0 AS test_passed;
