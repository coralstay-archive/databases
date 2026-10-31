-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE perf_benchmark (
    id NUMBER PRIMARY KEY,
    category VARCHAR2(10),
    val NUMBER
);

INSERT INTO perf_benchmark VALUES (1, 'A', 100);
INSERT INTO perf_benchmark VALUES (2, 'B', 200);
INSERT INTO perf_benchmark VALUES (3, 'A', 300);
INSERT INTO perf_benchmark VALUES (4, 'C', 400);
COMMIT;
