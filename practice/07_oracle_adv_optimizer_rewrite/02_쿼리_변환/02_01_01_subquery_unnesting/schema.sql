-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE customers (
    cust_id NUMBER PRIMARY KEY,
    cust_name VARCHAR2(30),
    city VARCHAR2(20)
);

CREATE TABLE contracts (
    contract_id NUMBER PRIMARY KEY,
    cust_id NUMBER,
    contract_amount NUMBER
);

INSERT INTO customers VALUES (1, '기업은행', '서울');
INSERT INTO customers VALUES (2, '국민은행', '서울');
INSERT INTO customers VALUES (3, '하나은행', '대전');

INSERT INTO contracts VALUES (101, 1, 5000000);
INSERT INTO contracts VALUES (102, 1, 3000000);
INSERT INTO contracts VALUES (103, 3, 2000000);
COMMIT;
