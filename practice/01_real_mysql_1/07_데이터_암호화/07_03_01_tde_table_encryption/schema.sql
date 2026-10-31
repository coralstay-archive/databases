-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS secure_card_info (
    card_id INT PRIMARY KEY,
    card_hash VARCHAR(64) NOT NULL
) ENGINE=InnoDB;

INSERT INTO secure_card_info VALUES (1, '9f83cf7b8...hash');
