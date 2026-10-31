-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM (
    SELECT art_id
    FROM notice_article
    WHERE category_id = 10
    ORDER BY reg_date DESC
)
WHERE ROWNUM <= 2;
