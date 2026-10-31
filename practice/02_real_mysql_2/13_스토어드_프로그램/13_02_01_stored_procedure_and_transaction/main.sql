-- [13장. 스토어드 프로그램]
-- 13.2 스토어드 프로시저와 트랜잭션 예외 처리 (DECLARE HANDLER) (p.248)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: DELIMITER 를 변경하고 DECLARE EXIT HANDLER FOR SQLEXCEPTION 블록을 정의합니다.
-- Step 2: START TRANSACTION 및 UPDATE, COMMIT 구문으로 원자적 프로시저를 생성하고 CALL 로 호출합니다.

