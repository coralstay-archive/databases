-- [12장. 트랜잭션 (Transactions)]
-- 12.3 세이브포인트(SAVEPOINT)를 활용한 트랜잭션 부분 롤백 (p.230)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: START TRANSACTION 후 1차 정상 데이터를 삽입하고 SAVEPOINT step1_complete 를 선언합니다.
-- Step 2: 2차 오류 데이터를 삽입한 후 ROLLBACK TO SAVEPOINT step1_complete 로 부분 취소합니다.
-- Step 3: 3차 정상 데이터를 삽입하고 최종 COMMIT 을 수행합니다.

