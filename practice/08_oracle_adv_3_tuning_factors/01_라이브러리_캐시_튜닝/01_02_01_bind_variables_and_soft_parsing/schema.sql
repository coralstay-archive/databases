-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE member_profiles (
    member_id NUMBER PRIMARY KEY,
    member_email VARCHAR2(50),
    level_code VARCHAR2(2)
);

INSERT INTO member_profiles VALUES (101, 'user1@example.com', 'A');
INSERT INTO member_profiles VALUES (102, 'user2@example.com', 'B');
INSERT INTO member_profiles VALUES (103, 'user3@example.com', 'A');
COMMIT;
