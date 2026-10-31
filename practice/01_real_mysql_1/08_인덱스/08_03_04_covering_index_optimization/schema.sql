-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    KEY idx_emp_salary (emp_no, salary)
) ENGINE=InnoDB;

INSERT INTO salaries VALUES
(10001, 60117, '1986-06-26', '1987-06-26'),
(10001, 62102, '1987-06-26', '1988-06-25'),
(10002, 72527, '1996-08-03', '1997-08-03')
ON DUPLICATE KEY UPDATE salary=VALUES(salary);
