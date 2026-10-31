-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE emp_tune (
    empno NUMBER(4) PRIMARY KEY,
    ename VARCHAR2(20),
    deptno NUMBER(2),
    sal NUMBER(7,2),
    hiredate DATE
);

CREATE INDEX idx_emp_dept_sal ON emp_tune (deptno, sal);

INSERT INTO emp_tune VALUES (7369, 'SMITH', 20, 800, TO_DATE('1980-12-17', 'YYYY-MM-DD'));
INSERT INTO emp_tune VALUES (7499, 'ALLEN', 30, 1600, TO_DATE('1981-02-20', 'YYYY-MM-DD'));
INSERT INTO emp_tune VALUES (7521, 'WARD', 30, 1250, TO_DATE('1981-02-22', 'YYYY-MM-DD'));
INSERT INTO emp_tune VALUES (7566, 'JONES', 20, 2975, TO_DATE('1981-04-02', 'YYYY-MM-DD'));
INSERT INTO emp_tune VALUES (7654, 'MARTIN', 30, 1250, TO_DATE('1981-09-28', 'YYYY-MM-DD'));
COMMIT;
