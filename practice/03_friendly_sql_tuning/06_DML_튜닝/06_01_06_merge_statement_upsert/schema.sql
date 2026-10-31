-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE customer_target (
    cust_id NUMBER PRIMARY KEY,
    cust_name VARCHAR2(30),
    points NUMBER
);

CREATE TABLE customer_source (
    cust_id NUMBER,
    cust_name VARCHAR2(30),
    new_points NUMBER
);

INSERT INTO customer_target VALUES (1, '김철수', 100);
INSERT INTO customer_target VALUES (2, '이영희', 200);

INSERT INTO customer_source VALUES (2, '이영희', 350); -- UPDATE 대상
INSERT INTO customer_source VALUES (3, '박민수', 500); -- INSERT 대상
COMMIT;
