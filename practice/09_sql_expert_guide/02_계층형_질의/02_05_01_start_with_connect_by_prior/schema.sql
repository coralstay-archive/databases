-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE emp_hierarchy (
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2(20),
    job VARCHAR2(20),
    mgr NUMBER
);

INSERT INTO emp_hierarchy VALUES (7839, 'KING', 'PRESIDENT', NULL);
INSERT INTO emp_hierarchy VALUES (7566, 'JONES', 'MANAGER', 7839);
INSERT INTO emp_hierarchy VALUES (7698, 'BLAKE', 'MANAGER', 7839);
INSERT INTO emp_hierarchy VALUES (7782, 'CLARK', 'MANAGER', 7839);
INSERT INTO emp_hierarchy VALUES (7788, 'SCOTT', 'ANALYST', 7566);
INSERT INTO emp_hierarchy VALUES (7902, 'FORD', 'ANALYST', 7566);
INSERT INTO emp_hierarchy VALUES (7369, 'SMITH', 'CLERK', 7902);
COMMIT;
