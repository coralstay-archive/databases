-- [5장. SQL로 기본 수학과 통계 계산하기]
-- 5.2 집계 함수와 윈도우 함수 (OVER / PARTITION BY) (p.98)
-- @engine: postgres
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: teachers 테이블에서 school, 이름, salary 컬럼을 조회합니다.
-- Step 2: RANK() OVER (PARTITION BY school ORDER BY salary DESC) 로 학교 내 순위를 부여합니다.
-- Step 3: AVG() OVER (PARTITION BY school) 로 학교별 평균 급여를 산출하여 개인 급여와의 차이를 계산합니다.

