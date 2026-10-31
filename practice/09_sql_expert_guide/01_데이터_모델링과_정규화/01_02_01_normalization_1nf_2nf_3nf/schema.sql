-- @engine: oracle
-- [사전 준비 스키마 및 Mock Data]
-- [3차 정규화가 완료된 정규형 테이블 구조]
CREATE TABLE student_major (
    major_id VARCHAR2(10) PRIMARY KEY,
    major_name VARCHAR2(30),
    dept_head VARCHAR2(20)
);

CREATE TABLE student_profile (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(20),
    major_id VARCHAR2(10) REFERENCES student_major(major_id)
);

INSERT INTO student_major VALUES ('CS', '컴퓨터공학과', '이교수');
INSERT INTO student_major VALUES ('EE', '전자공학과', '박교수');

INSERT INTO student_profile VALUES (2026001, '김민수', 'CS');
INSERT INTO student_profile VALUES (2026002, '이지은', 'CS');
INSERT INTO student_profile VALUES (2026003, '박도현', 'EE');
COMMIT;
