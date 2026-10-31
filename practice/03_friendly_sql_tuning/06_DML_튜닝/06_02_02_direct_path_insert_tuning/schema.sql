-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE sales_archive (
    sale_id NUMBER PRIMARY KEY,
    amount NUMBER,
    sale_date DATE
);

CREATE TABLE sales_staging (
    sale_id NUMBER,
    amount NUMBER,
    sale_date DATE
);

INSERT INTO sales_staging VALUES (101, 15000, SYSDATE);
INSERT INTO sales_staging VALUES (102, 25000, SYSDATE);
COMMIT;
