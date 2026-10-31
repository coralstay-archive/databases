-- [5장. 사용자를 파악하기 위한 데이터 처리]
-- 5.4 RFM 분석: 최근성(Recency), 빈도(Frequency), 구매액(Monetary) 지표 산출 (p.178)
-- @engine: postgres
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: customer_orders 에서 user_id 별로 그룹화합니다.
-- Step 2: 기준일자(2026-10-24)와 MAX(order_date)의 차이로 Recency 일수를 산출합니다.
-- Step 3: COUNT(*) 로 Frequency를, SUM(amount) 로 Monetary 총액을 계산합니다.

