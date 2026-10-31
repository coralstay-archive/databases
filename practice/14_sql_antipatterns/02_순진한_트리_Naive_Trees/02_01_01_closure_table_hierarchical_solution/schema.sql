-- @engine: postgres
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE IF NOT EXISTS comments (
    comment_id SERIAL PRIMARY KEY,
    author VARCHAR(30),
    content TEXT
);

CREATE TABLE IF NOT EXISTS comment_tree_paths (
    ancestor_id INT REFERENCES comments(comment_id),
    descendant_id INT REFERENCES comments(comment_id),
    path_length INT,
    PRIMARY KEY (ancestor_id, descendant_id)
);

TRUNCATE TABLE comment_tree_paths CASCADE;
TRUNCATE TABLE comments CASCADE;

INSERT INTO comments VALUES (1, 'Alice', '본문 글입니다.');
INSERT INTO comments VALUES (2, 'Bob', 'Alice 글에 대한 첫 번째 댓글');
INSERT INTO comments VALUES (3, 'Charlie', 'Bob 댓글에 대한 대댓글');

-- 자기 자신에 대한 거리 0 경로
INSERT INTO comment_tree_paths VALUES (1, 1, 0), (2, 2, 0), (3, 3, 0);
-- 조상-후손 관계 경로
INSERT INTO comment_tree_paths VALUES (1, 2, 1), (1, 3, 2), (2, 3, 1);
