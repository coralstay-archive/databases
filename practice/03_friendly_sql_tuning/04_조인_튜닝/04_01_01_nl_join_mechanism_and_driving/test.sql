-- @engine: oracle
-- 검증 테스트 스크립트
SELECT COUNT(*) = 2 AS test_passed
FROM tbl_department d
JOIN tbl_employee e ON d.dept_id = e.dept_id
WHERE d.loc = '판교';
