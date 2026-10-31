-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS customer_orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT,
    order_date DATE,
    amount INT
);

TRUNCATE TABLE customer_orders;
INSERT INTO customer_orders (user_id, order_date, amount) VALUES
(101, '2026-10-20', 150000),
(101, '2026-10-23', 80000),
(102, '2026-09-10', 50000),
(103, '2026-10-22', 450000),
(103, '2026-10-24', 320000);
