-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE login_history (
    log_id NUMBER PRIMARY KEY,
    user_id VARCHAR2(20),
    ip_addr VARCHAR2(15),
    login_time DATE
);

INSERT INTO login_history VALUES (1, 'user01', '192.168.0.10', SYSDATE);
INSERT INTO login_history VALUES (2, 'user02', '192.168.0.20', SYSDATE);
INSERT INTO login_history VALUES (3, 'user01', '192.168.0.10', SYSDATE);
COMMIT;
