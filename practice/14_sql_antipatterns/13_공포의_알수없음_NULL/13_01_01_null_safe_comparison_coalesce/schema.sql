-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS inventory_items (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(30),
    stock_qty INT
);

TRUNCATE TABLE inventory_items;
INSERT INTO inventory_items (item_name, stock_qty) VALUES
('노트북', 10),
('마우스', 0),
('키보드', NULL); -- 재고 미확인(NULL)
