-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE member_ranks (
    mem_id NUMBER PRIMARY KEY,
    mem_grade VARCHAR2(10),
    points NUMBER
);

INSERT INTO member_ranks VALUES (1, 'GOLD', 1000);
INSERT INTO member_ranks VALUES (2, 'GOLD', 1500);
INSERT INTO member_ranks VALUES (3, 'SILVER', 500);
INSERT INTO member_ranks VALUES (4, 'BRONZE', 100);
COMMIT;
