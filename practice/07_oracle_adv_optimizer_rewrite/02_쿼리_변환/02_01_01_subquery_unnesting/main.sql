-- [2장. 쿼리 변환 (Query Transformation)]
-- 2.1 서브쿼리 Unnesting과 세미 조인 (Semi Join) (p.145)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: EXISTS 서브쿼리를 사용하여 계약금액 300만 이상인 서울 고객을 조회합니다.
-- Step 2: UNNEST 힌트를 지정하여 Filter 대신 HASH JOIN SEMI 가 유도되는지 확인합니다.

