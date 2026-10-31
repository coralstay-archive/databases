-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS bank_ledger (
    entry_id INT PRIMARY KEY,
    memo VARCHAR(50),
    amount INT
) ENGINE=InnoDB;

TRUNCATE TABLE bank_ledger;
