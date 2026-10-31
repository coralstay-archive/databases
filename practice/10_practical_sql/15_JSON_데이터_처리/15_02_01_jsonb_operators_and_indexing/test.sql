-- @engine: postgres
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM user_events
WHERE payload @> '{"action": "login"}';
