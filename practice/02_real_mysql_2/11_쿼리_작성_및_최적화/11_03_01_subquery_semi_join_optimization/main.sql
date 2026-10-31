-- [11장. 쿼리 작성 및 최적화]
-- 11.3 서브쿼리 최적화: 세미 조인(Semi-Join)과 FirstMatch / Materialization (p.92)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: store_departments 와 IN (subquery) 조건의 세미 조인 쿼리를 작성합니다.
-- Step 2: EXPLAIN FORMAT=TREE 로 서브쿼리가 내부적으로 풀려 조인 최적화되는 구조를 점검합니다.

