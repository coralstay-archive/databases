-- [11장. 조건부 로직 (Conditional Logic)]
-- 11.2 CASE 표현식을 활용한 행을 열로 변환하는 피벗(Pivot) 집계 (p.212)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: quarterly_sales 테이블에서 rep_name 으로 그룹화합니다.
-- Step 2: SUM(CASE WHEN quarter_num = 1 THEN sales_amount ELSE 0 END) 로 분기별 열 피벗을 구현합니다.

