-- [9장. 옵티마이저와 힌트]
-- 9.4.1 옵티마이저 힌트 (JOIN_ORDER, INDEX, NO_INDEX) 제어 (p.412)
-- @engine: mysql
--
-- 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
-- ==============================================================================

-- Step 1: opt_users 와 opt_orders 간의 내부 조인 쿼리를 작성합니다.
-- Step 2: /*+ JOIN_ORDER(u, o) INDEX(u idx_level) */ 힌트로 u를 선행 테이블로, idx_level 인덱스를 타도록 유도합니다.

