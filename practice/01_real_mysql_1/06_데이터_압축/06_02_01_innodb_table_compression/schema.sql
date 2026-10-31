-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS compressed_log (
    log_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    log_data TEXT,
    created_at DATETIME
) ENGINE=InnoDB ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8;

INSERT INTO compressed_log (log_data, created_at) VALUES 
('MySQL 8.0 InnoDB Compressed Table Test Payload Data...', NOW());
