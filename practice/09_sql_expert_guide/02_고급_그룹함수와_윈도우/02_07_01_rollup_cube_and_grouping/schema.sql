-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE branch_revenue (
    branch_name VARCHAR2(20),
    product_cat VARCHAR2(20),
    revenue NUMBER
);

INSERT INTO branch_revenue VALUES ('강남점', '노트북', 500);
INSERT INTO branch_revenue VALUES ('강남점', '스마트폰', 800);
INSERT INTO branch_revenue VALUES ('판교점', '노트북', 600);
INSERT INTO branch_revenue VALUES ('판교점', '스마트폰', 700);
COMMIT;
