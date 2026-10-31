-- [10장. 실행 계획 상세]
-- 10.2 EXPLAIN ANALYZE를 이용한 실제 실행 시간 및 비용 측정 (p.42)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: orders 테이블에 customer_id 와 order_date 범위 조건을 적용하는 SELECT 쿼리를 작성합니다.
-- Step 2: EXPLAIN ANALYZE 키워드를 붙여 실제 소요 시간(actual time)과 반환 행 수(rows)를 분석합니다.

