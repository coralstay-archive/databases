-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    PRIMARY KEY (dept_no, emp_no)
) ENGINE=InnoDB;

INSERT INTO dept_emp VALUES
(10001, 'd001', '1986-06-26', '9999-01-01'),
(10002, 'd001', '1985-11-21', '9999-01-01'),
(10003, 'd002', '1986-08-28', '9999-01-01')
ON DUPLICATE KEY UPDATE from_date=VALUES(from_date);
