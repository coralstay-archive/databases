-- [6장. DML 튜닝]
-- 6.1.6 MERGE 문을 활용한 효율적인 INSERT/UPDATE 일괄 처리 (p.430)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: customer_target 을 타겟으로, customer_source 를 소스로 지정합니다.
-- Step 2: ON (t.cust_id = s.cust_id) 매칭 조건을 작성합니다.
-- Step 3: MATCHED 일 때 UPDATE, NOT MATCHED 일 때 INSERT 절을 정의합니다.

