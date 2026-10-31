-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM supplier s
JOIN line_item l ON s.supp_id = l.supp_id
WHERE s.region = '수원';
