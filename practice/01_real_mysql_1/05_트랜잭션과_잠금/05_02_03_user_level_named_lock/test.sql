-- @engine: mysql
-- 검증 테스트 스크립트
SELECT GET_LOCK('test_lock', 1) = 1 AS test_passed;
SELECT RELEASE_LOCK('test_lock');
