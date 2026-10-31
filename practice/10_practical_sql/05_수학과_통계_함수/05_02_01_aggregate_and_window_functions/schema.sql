-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS teachers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(25),
    last_name VARCHAR(50),
    school VARCHAR(50),
    hire_date DATE,
    salary NUMERIC
);

TRUNCATE TABLE teachers;
INSERT INTO teachers (first_name, last_name, school, hire_date, salary) VALUES
('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 56200),
('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 41400),
('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);
