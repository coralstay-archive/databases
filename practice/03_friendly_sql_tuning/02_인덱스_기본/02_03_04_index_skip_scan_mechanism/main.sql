-- [2장. 인덱스 기본]
-- 2.3.4 Index Skip Scan 활용: 선두 컬럼 조건 누락 시의 대안 (p.116)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: 결합 인덱스 (gender, salary)에서 선두 컬럼 gender 조건 없이 salary 조건만 작성합니다.
-- Step 2: INDEX_SS 힌트를 부여하여 Table Full Scan 대신 INDEX SKIP SCAN 오퍼레이션을 유도합니다.

