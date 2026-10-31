-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS member_account (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    balance INT
) ENGINE=InnoDB;

TRUNCATE TABLE member_account;
INSERT INTO member_account VALUES (1, 'Alice', 1000);
