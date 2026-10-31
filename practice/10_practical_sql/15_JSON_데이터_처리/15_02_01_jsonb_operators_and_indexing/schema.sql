-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS user_events (
    event_id SERIAL PRIMARY KEY,
    user_id INT,
    payload JSONB
);

TRUNCATE TABLE user_events;
INSERT INTO user_events (user_id, payload) VALUES
(101, '{"action": "login", "device": {"os": "macOS", "browser": "Chrome"}}'),
(102, '{"action": "checkout", "amount": 95000, "items": ["book", "coffee"]}'),
(103, '{"action": "login", "device": {"os": "Linux", "browser": "Firefox"}}');

CREATE INDEX IF NOT EXISTS idx_events_payload ON user_events USING GIN (payload);
