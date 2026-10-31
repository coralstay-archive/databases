-- [4장. 조인 튜닝]
-- 4.3 해시 조인 메커니즘과 대용량 Build Input 처리 (p.282)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: supplier 와 line_item 간의 조인 쿼리를 작성합니다.
-- Step 2: region = '수원' 조건으로 걸러진 supplier를 Build Input으로 지정하기 위해 LEADING(s) USE_HASH(l)을 부여합니다.

