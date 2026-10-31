-- [8장. 인덱스]
-- 8.3.1 B-Tree 인덱스 키 검색 및 레인지 스캔 (p.232)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: employees 테이블에 대해 last_name 범위 조건을 부여하는 SELECT 문을 작성합니다.
-- Step 2: EXPLAIN FORMAT=TREE 를 통해 idx_name 인덱스에 대한 'Index range scan'이 유도되는지 확인합니다.

