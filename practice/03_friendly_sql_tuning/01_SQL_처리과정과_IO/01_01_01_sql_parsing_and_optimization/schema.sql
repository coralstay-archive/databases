-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE customer_info (
    cust_id NUMBER PRIMARY KEY,
    cust_name VARCHAR2(30),
    join_date DATE,
    credit_limit NUMBER
);

INSERT INTO customer_info VALUES (1, '홍길동', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 5000000);
INSERT INTO customer_info VALUES (2, '이순신', TO_DATE('2025-06-15', 'YYYY-MM-DD'), 10000000);
INSERT INTO customer_info VALUES (3, '강감찬', TO_DATE('2026-03-20', 'YYYY-MM-DD'), 3000000);
COMMIT;
