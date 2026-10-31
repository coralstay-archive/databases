-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE ROLE IF NOT EXISTS r_analyst;
GRANT SELECT ON practice_db.* TO r_analyst;
