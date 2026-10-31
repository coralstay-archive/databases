-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
CREATE TABLE board_post (
    post_id NUMBER PRIMARY KEY,
    board_id NUMBER,
    reg_date DATE,
    title VARCHAR2(100)
);

CREATE INDEX idx_board_date ON board_post (board_id, reg_date DESC);

INSERT INTO board_post VALUES (1, 10, TO_DATE('2026-10-01', 'YYYY-MM-DD'), '공지사항 1');
INSERT INTO board_post VALUES (2, 10, TO_DATE('2026-10-05', 'YYYY-MM-DD'), '업데이트 안내');
INSERT INTO board_post VALUES (3, 10, TO_DATE('2026-10-15', 'YYYY-MM-DD'), '시스템 점검');
INSERT INTO board_post VALUES (4, 10, TO_DATE('2026-10-20', 'YYYY-MM-DD'), '신규 기능 출시');
INSERT INTO board_post VALUES (5, 20, TO_DATE('2026-10-22', 'YYYY-MM-DD'), '자유게시판 글');
COMMIT;
