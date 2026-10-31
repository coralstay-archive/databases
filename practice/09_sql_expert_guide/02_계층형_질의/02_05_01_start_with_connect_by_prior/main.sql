-- [2과목 2장 5절. 계층형 질의 (Hierarchical Query)]
-- 2.5.1 계층형 질의와 순방향/역방향 전개 (START WITH ~ CONNECT BY) (p.312)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: START WITH mgr IS NULL 조건으로 최고 관리자(KING)를 루트로 선언합니다.
-- Step 2: CONNECT BY PRIOR empno = mgr 로 순방향 계층 전개를 정의합니다.
-- Step 3: LEVEL 에 맞추어 LPAD 들여쓰기를 적용하고 ORDER SIBLINGS BY 로 정렬합니다.

