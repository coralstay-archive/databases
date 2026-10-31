-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS quarterly_sales (
    rep_name VARCHAR(20),
    quarter_num INT,
    sales_amount INT
) ENGINE=InnoDB;

TRUNCATE TABLE quarterly_sales;
INSERT INTO quarterly_sales VALUES
('Kim', 1, 1500),
('Kim', 2, 2000),
('Lee', 1, 1800),
('Lee', 2, 1200);
