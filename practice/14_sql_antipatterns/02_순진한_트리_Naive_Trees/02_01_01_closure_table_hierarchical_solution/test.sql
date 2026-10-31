-- @engine: postgres
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM comments c
JOIN comment_tree_paths p ON c.comment_id = p.descendant_id
WHERE p.ancestor_id = 1 AND p.path_length > 0;
