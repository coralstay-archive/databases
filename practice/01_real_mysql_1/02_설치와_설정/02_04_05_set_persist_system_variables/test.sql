-- @engine: mysql
-- 검증 테스트 스크립트
SELECT @@GLOBAL.max_connections > 0 AS test_passed;
