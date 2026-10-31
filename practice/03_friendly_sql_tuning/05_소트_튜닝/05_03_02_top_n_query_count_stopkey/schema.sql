-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE notice_article (
    art_id NUMBER PRIMARY KEY,
    category_id NUMBER,
    reg_date DATE,
    title VARCHAR2(100)
);

CREATE INDEX idx_notice_cat_date ON notice_article (category_id, reg_date DESC);

INSERT INTO notice_article VALUES (1, 10, TO_DATE('2026-10-01', 'YYYY-MM-DD'), '공지 1');
INSERT INTO notice_article VALUES (2, 10, TO_DATE('2026-10-05', 'YYYY-MM-DD'), '공지 2');
INSERT INTO notice_article VALUES (3, 10, TO_DATE('2026-10-15', 'YYYY-MM-DD'), '공지 3');
INSERT INTO notice_article VALUES (4, 10, TO_DATE('2026-10-20', 'YYYY-MM-DD'), '공지 4');
COMMIT;
