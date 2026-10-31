-- [2과목 2장. SQL 활용 (그룹 함수 & 윈도우 함수)]
-- 2.7 고급 그룹 함수: ROLLUP, CUBE, GROUPING 함수를 이용한 다차원 소계 산출 (p.330)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: branch_revenue 테이블에서 branch_name, product_cat 에 대해 GROUP BY ROLLUP 을 적용합니다.
-- Step 2: GROUPING() 함수의 0/1 반환값을 CASE WHEN 으로 평가하여 소계 및 전체 지점 텍스트를 출력합니다.

