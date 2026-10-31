-- [2장. 조인 튜닝]
-- 2.3 해시 조인(Hash Join)과 Build Input / Probe Input 제어 (p.210)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: departments 와 employees_large 테이블 간의 내부 조인 쿼리를 작성합니다.
-- Step 2: LEADING(d) 와 USE_HASH(e) 힌트를 적용하여 작은 테이블인 departments가 Build Input이 되도록 유도합니다.
-- Step 3: DBMS_XPLAN 으로 HASH JOIN 계획을 확인합니다.

