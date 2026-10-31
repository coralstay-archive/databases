-- [3장. 인덱스 튜닝]
-- 3.3.1 인덱스 수직적 탐색과 수평적 스캔 (p.173)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: emp_tune 테이블에 대해 deptno 와 sal 조건절을 작성합니다.
-- Step 2: INDEX 힌트 /*+ INDEX(e idx_emp_dept_sal) */ 를 지정합니다.
-- Step 3: DBMS_XPLAN.DISPLAY 를 통해 INDEX RANGE SCAN 계획을 확인합니다.

