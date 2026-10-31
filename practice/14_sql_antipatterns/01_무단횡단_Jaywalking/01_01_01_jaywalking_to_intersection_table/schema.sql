-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
-- [정규화된 올바른 스키마 설계]
CREATE TABLE IF NOT EXISTS bugs (
    bug_id SERIAL PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS tags (
    tag_id SERIAL PRIMARY KEY,
    tag_name VARCHAR(25) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS bug_tags (
    bug_id INT REFERENCES bugs(bug_id) ON DELETE CASCADE,
    tag_id INT REFERENCES tags(tag_id) ON DELETE CASCADE,
    PRIMARY KEY (bug_id, tag_id)
);

TRUNCATE TABLE bug_tags CASCADE;
TRUNCATE TABLE tags CASCADE;
TRUNCATE TABLE bugs CASCADE;

INSERT INTO bugs (bug_id, description) VALUES (1, '로그인 세션 만료 버그'), (2, '결제 모듈 타임아웃');
INSERT INTO tags (tag_id, tag_name) VALUES (1, '보안'), (2, '긴급'), (3, 'UI');

INSERT INTO bug_tags VALUES (1, 1), (1, 2), (2, 2);
