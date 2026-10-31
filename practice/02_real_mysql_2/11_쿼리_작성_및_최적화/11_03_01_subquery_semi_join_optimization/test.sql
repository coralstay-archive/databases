-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed
FROM store_departments d
WHERE dept_id IN (
    SELECT dept_id 
    FROM store_staff s 
    WHERE s.name LIKE 'Dev%'
);
