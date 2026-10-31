-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE employee_skip (
    emp_id NUMBER PRIMARY KEY,
    gender VARCHAR2(1),
    salary NUMBER
);

CREATE INDEX idx_emp_gender_sal ON employee_skip (gender, salary);

INSERT INTO employee_skip VALUES (1, 'M', 3000);
INSERT INTO employee_skip VALUES (2, 'M', 5000);
INSERT INTO employee_skip VALUES (3, 'M', 8000);
INSERT INTO employee_skip VALUES (4, 'F', 4000);
INSERT INTO employee_skip VALUES (5, 'F', 9000);
COMMIT;
