-- [13장. 공포의 알 수 없음 (Fear of the Unknown): 3값 논리와 NULL]
-- 13.1 NULL 과의 일반 비교 연산 오류(3값 논리)와 COALESCE / IS NOT DISTINCT FROM 해법 (p.210)
-- @engine: postgres
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: stock_qty IS DISTINCT FROM 0 구문으로 0이 아닌 항목(재고 10 및 NULL)을 모두 안전하게 추출합니다.
-- Step 2: COALESCE(stock_qty, -1) 로 화면 출력 시 미확인 값을 대체 표기합니다.

