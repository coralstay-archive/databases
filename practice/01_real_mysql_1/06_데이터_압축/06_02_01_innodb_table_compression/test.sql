-- @engine: mysql
-- 검증 테스트 스크립트
SELECT COUNT(*) = 1 AS test_passed 
FROM information_schema.tables 
WHERE table_name = 'compressed_log' AND row_format = 'Compressed';
