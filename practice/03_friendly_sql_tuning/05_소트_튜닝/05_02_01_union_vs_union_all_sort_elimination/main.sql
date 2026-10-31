-- [5장. 소트 튜닝]
-- 5.2.1 UNION(중복제거 소트) 대신 UNION ALL 을 활용한 소트 연산 제거 (p.343)
-- @engine: oracle
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: payment_card 와 payment_bank 조회 구문을 UNION 대신 UNION ALL 로 결합합니다.
-- Step 2: DBMS_XPLAN 결과에서 SORT UNIQUE 오퍼레이션이 발생하지 않고 즉시 UNION-ALL 로 전송되는지 확인합니다.

