-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM (
    SELECT post_id, title
    FROM board_post
    WHERE board_id = 10
    ORDER BY reg_date DESC
)
WHERE ROWNUM <= 2;
