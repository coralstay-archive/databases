-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS store_departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS store_staff (
    staff_id INT PRIMARY KEY,
    dept_id INT,
    name VARCHAR(30),
    KEY idx_dept (dept_id)
) ENGINE=InnoDB;

INSERT INTO store_departments VALUES (1, '경영'), (2, '기술'), (3, '영업');
INSERT INTO store_staff VALUES (101, 2, 'Dev1'), (102, 2, 'Dev2');
