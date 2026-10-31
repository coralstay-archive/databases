-- @engine: postgres
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM bugs b
JOIN bug_tags bt ON b.bug_id = bt.bug_id
JOIN tags t ON bt.tag_id = t.tag_id
WHERE t.tag_name = '긴급';
