-- [4장. 조인 튜닝]
-- 4.1 Nested Loops 조인 메커니즘과 드라이빙 테이블 선정 (p.255)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: tbl_department 와 tbl_employee 를 dept_id 로 조인합니다.
-- Step 2: 판교 지역 부서가 소량이므로 d를 드라이빙으로 삼도록 LEADING(d) USE_NL(e) 힌트를 적용합니다.
-- Step 3: DBMS_XPLAN 결과에서 NESTED LOOPS 오퍼레이션을 확인합니다.

