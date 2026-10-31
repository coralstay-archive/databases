-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE supplier (
    supp_id NUMBER PRIMARY KEY,
    supp_name VARCHAR2(30),
    region VARCHAR2(10)
);

CREATE TABLE line_item (
    item_id NUMBER PRIMARY KEY,
    supp_id NUMBER,
    qty NUMBER,
    price NUMBER
);

INSERT INTO supplier VALUES (1, '삼성전자', '수원');
INSERT INTO supplier VALUES (2, 'SK하이닉스', '이천');

INSERT INTO line_item VALUES (1001, 1, 50, 100000);
INSERT INTO line_item VALUES (1002, 1, 30, 200000);
INSERT INTO line_item VALUES (1003, 2, 20, 150000);
COMMIT;
