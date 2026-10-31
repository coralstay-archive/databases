-- [부록. SQL 분석 도구]
-- 부록 4. DBMS_XPLAN 패키지를 이용한 실행 통계 및 Predicate 정보 분석 (p.542)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: account_audit 에 대해 인덱스 스캔 쿼리를 계획 테이블에 저장합니다.
-- Step 2: DBMS_XPLAN.DISPLAY의 TYPICAL 옵션으로 Predicate Information(access 조건)을 확인합니다.

