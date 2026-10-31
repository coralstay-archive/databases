-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 7 AS test_passed
FROM (
    SELECT branch_name, product_cat
    FROM branch_revenue
    GROUP BY ROLLUP(branch_name, product_cat)
);
