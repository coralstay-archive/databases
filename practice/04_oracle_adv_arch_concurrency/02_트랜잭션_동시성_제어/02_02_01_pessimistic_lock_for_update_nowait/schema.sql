-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE account_balance (
    acc_no VARCHAR2(10) PRIMARY KEY,
    owner_name VARCHAR2(20),
    balance NUMBER(12,2)
);

INSERT INTO account_balance VALUES ('ACC1001', '홍길동', 500000);
INSERT INTO account_balance VALUES ('ACC1002', '이순신', 1200000);
COMMIT;
