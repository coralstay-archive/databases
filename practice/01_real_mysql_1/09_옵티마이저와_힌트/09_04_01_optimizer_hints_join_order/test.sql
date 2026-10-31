-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM opt_users u
JOIN opt_orders o ON u.user_id = o.user_id
WHERE u.level = 1;
