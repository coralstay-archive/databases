-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS daily_sales (
    dt DATE PRIMARY KEY,
    orders INT,
    purchase_amount NUMERIC
);

TRUNCATE TABLE daily_sales;
INSERT INTO daily_sales VALUES
('2026-10-01', 12, 120000),
('2026-10-02', 15, 150000),
('2026-10-03', 18, 180000),
('2026-10-04', 10, 100000),
('2026-10-05', 14, 140000),
('2026-10-06', 20, 200000),
('2026-10-07', 22, 220000),
('2026-10-08', 25, 250000);
