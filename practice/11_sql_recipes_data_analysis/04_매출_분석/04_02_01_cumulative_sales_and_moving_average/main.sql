-- [4장. 매출을 파악하기 위한 데이터 처리]
-- 4.2 누적 매출액과 7일 이동평균(Moving Average) 계산 (p.112)
-- @engine: postgres
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: daily_sales 테이블에서 dt 오름차순으로 정렬 기준을 수립합니다.
-- Step 2: SUM() OVER (ORDER BY dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 로 누적 매출을 구합니다.
-- Step 3: AVG() OVER (ORDER BY dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) 로 7일 이동평균을 산출합니다.

