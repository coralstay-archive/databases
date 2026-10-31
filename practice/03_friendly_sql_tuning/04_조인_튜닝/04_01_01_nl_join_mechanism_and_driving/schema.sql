-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE tbl_department (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(30),
    loc VARCHAR2(20)
);

CREATE TABLE tbl_employee (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(30),
    dept_id NUMBER,
    salary NUMBER
);

CREATE INDEX idx_emp_dept ON tbl_employee (dept_id);

INSERT INTO tbl_department VALUES (10, '재무팀', '서울');
INSERT INTO tbl_department VALUES (20, '개발팀', '판교');
INSERT INTO tbl_department VALUES (30, '영업팀', '부산');

INSERT INTO tbl_employee VALUES (101, '이민호', 20, 6000);
INSERT INTO tbl_employee VALUES (102, '박서준', 20, 6500);
INSERT INTO tbl_employee VALUES (103, '송중기', 10, 5000);
COMMIT;
