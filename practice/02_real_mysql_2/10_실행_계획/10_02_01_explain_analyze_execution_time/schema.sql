-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    KEY idx_cust_date (customer_id, order_date)
) ENGINE=InnoDB;

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(101, '2026-01-01', 150.00),
(101, '2026-01-15', 200.00),
(102, '2026-02-01', 350.00),
(103, '2026-02-10', 90.00);
