-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS staff_members (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30) NOT NULL,
    dept_id INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

INSERT INTO staff_members VALUES
(1, 'Alice', 10, 6000.00),
(2, 'Bob', 10, 7500.00),
(3, 'Charlie', 20, 5000.00),
(4, 'David', 20, 8000.00),
(5, 'Eva', 20, 8000.00)
ON DUPLICATE KEY UPDATE salary=VALUES(salary);
