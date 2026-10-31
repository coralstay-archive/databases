-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(30)
);

CREATE TABLE employees_large (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(30),
    dept_id NUMBER,
    salary NUMBER
);

INSERT INTO departments VALUES (10, '개발팀');
INSERT INTO departments VALUES (20, '인사팀');
INSERT INTO departments VALUES (30, '마케팅팀');

INSERT INTO employees_large VALUES (1, '김철수', 10, 5000);
INSERT INTO employees_large VALUES (2, '이영희', 10, 5500);
INSERT INTO employees_large VALUES (3, '박민수', 20, 4800);
COMMIT;
