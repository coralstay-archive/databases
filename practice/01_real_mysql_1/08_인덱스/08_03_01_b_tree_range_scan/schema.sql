-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS employees (
    emp_no INT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    KEY idx_name (last_name, first_name)
) ENGINE=InnoDB;

INSERT INTO employees VALUES
(10001, 'Georgi', 'Facello', '1986-06-26'),
(10002, 'Bezalel', 'Simmel', '1985-11-21'),
(10003, 'Parto', 'Bamford', '1986-08-28'),
(10004, 'Chirstian', 'Koblick', '1986-12-01')
ON DUPLICATE KEY UPDATE first_name=VALUES(first_name);
