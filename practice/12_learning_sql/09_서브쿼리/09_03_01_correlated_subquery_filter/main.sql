-- [9장. 서브쿼리 (Subqueries)]
-- 9.3 상관 서브쿼리(Correlated Subquery)를 이용한 부서별 최고 급여 사원 필터링 (p.164)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: 외부 쿼리에서 staff_members s 테이블을 참조합니다.
-- Step 2: WHERE s.salary = (SELECT MAX(...) WHERE sub.dept_id = s.dept_id) 로 상관 관계를 연결합니다.
-- Step 3: 부서별 최고 급여자가 정상 추출되는지 확인합니다.

