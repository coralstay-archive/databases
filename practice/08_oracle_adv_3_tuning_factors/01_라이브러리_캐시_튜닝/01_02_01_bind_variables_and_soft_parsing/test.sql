-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM member_profiles
WHERE level_code = 'A';
