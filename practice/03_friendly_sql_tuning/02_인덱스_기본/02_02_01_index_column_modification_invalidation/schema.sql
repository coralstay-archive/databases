-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE contracts_basic (
    contract_id NUMBER PRIMARY KEY,
    contract_no VARCHAR2(20),
    contract_date DATE,
    fee NUMBER
);

CREATE INDEX idx_contract_date ON contracts_basic (contract_date);

INSERT INTO contracts_basic VALUES (1, 'CN-2026-001', TO_DATE('2026-03-15', 'YYYY-MM-DD'), 50000);
INSERT INTO contracts_basic VALUES (2, 'CN-2026-002', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 80000);
INSERT INTO contracts_basic VALUES (3, 'CN-2025-099', TO_DATE('2025-11-10', 'YYYY-MM-DD'), 45000);
COMMIT;
