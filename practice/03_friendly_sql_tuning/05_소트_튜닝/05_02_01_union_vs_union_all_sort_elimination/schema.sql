-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE payment_card (
    pay_id NUMBER PRIMARY KEY,
    pay_amount NUMBER,
    pay_date DATE
);

CREATE TABLE payment_bank (
    pay_id NUMBER PRIMARY KEY,
    pay_amount NUMBER,
    pay_date DATE
);

INSERT INTO payment_card VALUES (1, 50000, TO_DATE('2026-10-01', 'YYYY-MM-DD'));
INSERT INTO payment_card VALUES (2, 70000, TO_DATE('2026-10-02', 'YYYY-MM-DD'));
INSERT INTO payment_bank VALUES (101, 120000, TO_DATE('2026-10-01', 'YYYY-MM-DD'));
COMMIT;
