-- [2장. 순진한 트리 (Naive Trees) 안티패턴과 폐쇄 테이블 (Closure Table) 해법]
-- 2.1 인접 목록(Adjacency List)의 한계를 극복하는 폐쇄 테이블(Closure Table) 설계 (p.50)
-- @engine: postgres
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: comments 와 comment_tree_paths 를 조인합니다.
-- Step 2: WHERE p.ancestor_id = 1 AND p.path_length > 0 조건으로 모든 하위 댓글을 계층 깊이순으로 추출합니다.

