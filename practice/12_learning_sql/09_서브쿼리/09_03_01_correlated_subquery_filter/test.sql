-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 3 AS test_passed
FROM staff_members s
WHERE s.salary = (
    SELECT MAX(sub.salary)
    FROM staff_members sub
    WHERE sub.dept_id = s.dept_id
);
