-- [6장. 데이터 압축]
-- 6.2.1 InnoDB 테이블 압축 및 KEY_BLOCK_SIZE 설정 (p.187)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: information_schema.tables 에서 compressed_log 의 ROW_FORMAT 과 CREATE_OPTIONS 를 확인합니다.

