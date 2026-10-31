-- @engine: mysql
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS opt_users (
    user_id INT PRIMARY KEY,
    name VARCHAR(20),
    level INT,
    KEY idx_level (level)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS opt_orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    amount INT,
    KEY idx_user (user_id)
) ENGINE=InnoDB;

INSERT INTO opt_users VALUES (1, 'UserA', 1), (2, 'UserB', 2);
INSERT INTO opt_orders VALUES (101, 1, 5000), (102, 1, 3000);
