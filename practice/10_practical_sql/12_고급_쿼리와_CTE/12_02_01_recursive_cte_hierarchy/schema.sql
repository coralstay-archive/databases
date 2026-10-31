-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS org_chart (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30),
    manager_id INT
);

TRUNCATE TABLE org_chart;
INSERT INTO org_chart VALUES
(1, 'CEO 박대표', NULL),
(2, 'CTO 김이사', 1),
(3, 'CFO 이이사', 1),
(4, '백엔드팀장 최팀장', 2),
(5, '시니어개발자 정수석', 4);
