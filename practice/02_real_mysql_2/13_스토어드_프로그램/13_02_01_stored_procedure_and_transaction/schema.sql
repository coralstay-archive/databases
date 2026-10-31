-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS wallet (
    user_id INT PRIMARY KEY,
    balance INT
) ENGINE=InnoDB;

TRUNCATE TABLE wallet;
INSERT INTO wallet VALUES (1, 5000);
