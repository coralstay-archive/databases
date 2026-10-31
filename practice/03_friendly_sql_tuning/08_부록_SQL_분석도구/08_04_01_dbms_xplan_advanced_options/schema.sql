-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE account_audit (
    audit_id NUMBER PRIMARY KEY,
    user_no NUMBER,
    event_type VARCHAR2(20)
);

CREATE INDEX idx_audit_user ON account_audit (user_no);

INSERT INTO account_audit VALUES (1, 1001, 'LOGIN');
INSERT INTO account_audit VALUES (2, 1002, 'LOGOUT');
COMMIT;
