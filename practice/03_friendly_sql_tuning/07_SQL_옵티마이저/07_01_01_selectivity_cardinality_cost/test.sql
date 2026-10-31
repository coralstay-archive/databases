-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM member_ranks
WHERE mem_grade = 'GOLD';
