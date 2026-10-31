-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE online_sales (
    sale_id NUMBER PRIMARY KEY,
    media_code VARCHAR2(2),
    sale_date VARCHAR2(8),
    amount NUMBER
);

CREATE INDEX idx_sales_media_date ON online_sales (media_code, sale_date);

INSERT INTO online_sales VALUES (1, '01', '20261001', 50000);
INSERT INTO online_sales VALUES (2, '01', '20261020', 80000);
INSERT INTO online_sales VALUES (3, '02', '20261005', 30000);
INSERT INTO online_sales VALUES (4, '02', '20261023', 95000);
COMMIT;
