-- [5장. 트랜잭션과 잠금]
-- 5.2.3 네임드 락(Named Lock)을 활용한 분산 락 및 동시성 제어 (p.163)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: SELECT GET_LOCK('batch_process_lock', 5) 로 유저 레벨 잠금을 획득합니다.
-- Step 2: 작업 완료 후 SELECT RELEASE_LOCK('batch_process_lock') 으로 즉시 잠금을 반환합니다.

