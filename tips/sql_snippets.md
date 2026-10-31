# 📚 Database & SQL 핵심 스니펫 모음집 (Cheat Sheet)

> 이 문서는 `./scripts/snippets.sh --export` 명령에 의해 자동 생성되었습니다.
> 총 수록 스니펫: 57개

## 📑 목차

1. [오라클 바인드 변수 선언 및 소프트 파싱 유도 쿼리 (`SQL`)](#snippet-30) - `practice/08_oracle_adv_3_tuning_factors/01_라이브러리_캐시_튜닝/01_02_01_bind_variables_and_soft_parsing/README.md:30`
2. [SQL 전문가 가이드: ROLLUP 및 GROUPING 함수를 이용한 지점별/상품별 다차원 소계 (`SQL`)](#snippet-31) - `practice/09_sql_expert_guide/02_고급_그룹함수와_윈도우/02_07_01_rollup_cube_and_grouping/README.md:31`
3. [SQL 전문가 가이드: 제3정규형 테이블 간 참조 조인 쿼리 (`SQL`)](#snippet-41) - `practice/09_sql_expert_guide/01_데이터_모델링과_정규화/01_02_01_normalization_1nf_2nf_3nf/README.md:41`
4. [오라클 표준 계층형 질의 (START WITH CONNECT BY PRIOR 및 LEVEL 들여쓰기) (`SQL`)](#snippet-37) - `practice/09_sql_expert_guide/02_계층형_질의/02_05_01_start_with_connect_by_prior/README.md:37`
5. [5대 DB 공통: 한 테이블에만 존재하는 행 조회 (Anti-Join 패턴) (`SQL`)](#snippet-40) - `practice/13_sql_cookbook/03_다중_테이블_작업/03_05_01_outer_join_and_coalesce/README.md:40`
6. [MongoDB $lookup 스테이지를 이용한 컬렉션 간 Left Outer Join 집계 (`SQL`)](#snippet-34) - `practice/15_real_mongodb/06_다중컬렉션_조인_lookup/06_04_01_aggregation_lookup_left_outer_join/README.md:34`
7. [MongoDB Aggregation 파이프라인 ($match -> $group -> $sort) (`SQL`)](#snippet-29) - `practice/15_real_mongodb/03_aggregation/03_01_01_aggregation_group_and_sort/README.md:29`
8. [MongoDB $addToSet 을 이용한 중복 없는 배열 스킬 추가 (`SQL`)](#snippet-27) - `practice/15_real_mongodb/04_CRUD_배열연산/04_02_01_atomic_array_update_operators/README.md:27`
9. [PostgreSQL 윈도우 함수를 이용한 학교별 급여 순위 및 평균 대비 차이 계산 (`SQL`)](#snippet-37) - `practice/10_practical_sql/05_수학과_통계_함수/05_02_01_aggregate_and_window_functions/README.md:37`
10. [PostgreSQL 표준 WITH RECURSIVE 를 이용한 계층 트리 탐색 (`SQL`)](#snippet-32) - `practice/10_practical_sql/12_고급_쿼리와_CTE/12_02_01_recursive_cte_hierarchy/README.md:32`
11. [PostgreSQL JSONB 추출(->>) 및 포함 연산자(@>) 검색 (`SQL`)](#snippet-34) - `practice/10_practical_sql/15_JSON_데이터_처리/15_02_01_jsonb_operators_and_indexing/README.md:34`
12. [MySQL SAVEPOINT 를 이용한 트랜잭션 부분 롤백 시뮬레이션 (`SQL`)](#snippet-28) - `practice/12_learning_sql/12_트랜잭션/12_03_01_savepoint_and_partial_rollback/README.md:28`
13. [MySQL CASE 표현식을 이용한 분기별 매출 피벗(Pivot) 집계 (`SQL`)](#snippet-33) - `practice/12_learning_sql/11_조건부_로직/11_02_01_case_expression_pivot/README.md:33`
14. [MySQL 상관 서브쿼리를 이용한 부서별 최고 급여 수령자 추출 (`SQL`)](#snippet-34) - `practice/12_learning_sql/09_서브쿼리/09_03_01_correlated_subquery_filter/README.md:34`
15. [오라클 INDEX RANGE SCAN 및 실행계획 확인 (친절한 SQL 튜닝) (`SQL`)](#snippet-36) - `practice/03_friendly_sql_tuning/03_인덱스_스캔_효율화/03_03_01_index_seek_and_scan/README.md:36`
16. [BETWEEN을 IN-List 전환하여 INLIST ITERATOR 유도 (I/O 최소화) (`SQL`)](#snippet-33) - `practice/03_friendly_sql_tuning/03_인덱스_스캔_효율화/03_03_06_between_to_inlist_transformation/README.md:33`
17. [친절한 SQL 튜닝: Hash Join 및 작은 집합의 Build Input 유도 (USE_HASH) (`SQL`)](#snippet-40) - `practice/03_friendly_sql_tuning/04_조인_튜닝/04_03_01_hash_join_build_probe_optimization/README.md:40`
18. [친절한 SQL 튜닝: Nested Loops 조인 제어 (LEADING + USE_NL + INDEX) (`SQL`)](#snippet-44) - `practice/03_friendly_sql_tuning/04_조인_튜닝/04_01_01_nl_join_mechanism_and_driving/README.md:44`
19. [친절한 SQL 튜닝: FULL 힌트를 이용한 Multiblock I/O 시퀀셜 스캔 유도 (`SQL`)](#snippet-31) - `practice/03_friendly_sql_tuning/01_SQL_처리과정과_IO/01_03_01_block_io_and_access_methods/README.md:31`
20. [친절한 SQL 튜닝: SQL 최적화 및 기본 실행계획 확인 (`SQL`)](#snippet-31) - `practice/03_friendly_sql_tuning/01_SQL_처리과정과_IO/01_01_01_sql_parsing_and_optimization/README.md:31`
21. [친절한 SQL 튜닝: 바인드 변수를 활용한 라이브러리 캐시 소프트 파싱 (`SQL`)](#snippet-32) - `practice/03_friendly_sql_tuning/01_SQL_처리과정과_IO/01_02_01_soft_parsing_vs_hard_parsing/README.md:32`
22. [친절한 SQL 튜닝: 옵티마이저 예상 카디널리티(Rows) 확인 (`SQL`)](#snippet-31) - `practice/03_friendly_sql_tuning/07_SQL_옵티마이저/07_01_01_selectivity_cardinality_cost/README.md:31`
23. [친절한 SQL 튜닝: 대용량 적재 가속화를 위한 Direct Path Insert (APPEND 힌트) (`SQL`)](#snippet-35) - `practice/03_friendly_sql_tuning/06_DML_튜닝/06_02_02_direct_path_insert_tuning/README.md:35`
24. [친절한 SQL 튜닝: 단일 스캔으로 처리하는 MERGE INTO 구문 (`SQL`)](#snippet-37) - `practice/03_friendly_sql_tuning/06_DML_튜닝/06_01_06_merge_statement_upsert/README.md:37`
25. [친절한 SQL 튜닝: Index Skip Scan 유도 힌트 (선두 컬럼 조건 누락 시) (`SQL`)](#snippet-34) - `practice/03_friendly_sql_tuning/02_인덱스_기본/02_03_04_index_skip_scan_mechanism/README.md:34`
26. [친절한 SQL 튜닝: 컬럼 원형 보존을 통한 Index Range Scan 유도 (`SQL`)](#snippet-33) - `practice/03_friendly_sql_tuning/02_인덱스_기본/02_02_01_index_column_modification_invalidation/README.md:33`
27. [친절한 SQL 튜닝: DBMS_XPLAN 패키지의 Predicate 정보 확인 (`SQL`)](#snippet-30) - `practice/03_friendly_sql_tuning/08_부록_SQL_분석도구/08_04_01_dbms_xplan_advanced_options/README.md:30`
28. [친절한 SQL 튜닝: Top-N STOPKEY 소트 생략 페이징 패턴 (`SQL`)](#snippet-34) - `practice/03_friendly_sql_tuning/05_소트_튜닝/05_03_02_top_n_query_count_stopkey/README.md:34`
29. [친절한 SQL 튜닝: UNION ALL 을 활용한 SORT UNIQUE 연산 생략 (`SQL`)](#snippet-35) - `practice/03_friendly_sql_tuning/05_소트_튜닝/05_02_01_union_vs_union_all_sort_elimination/README.md:35`
30. [MySQL 8.0 역할(Role) 확인 및 권한 조회 (`SQL`)](#snippet-21) - `practice/01_real_mysql_1/03_사용자_및_권한/03_05_01_role_based_access_control/README.md:21`
31. [MySQL TDE 암호화 옵션 확인 (`SQL`)](#snippet-26) - `practice/01_real_mysql_1/07_데이터_암호화/07_03_01_tde_table_encryption/README.md:26`
32. [MySQL 8.0 표준 옵티마이저 힌트 (JOIN_ORDER 및 INDEX 지정) (`SQL`)](#snippet-37) - `practice/01_real_mysql_1/09_옵티마이저와_힌트/09_04_01_optimizer_hints_join_order/README.md:37`
33. [MySQL 네임드 락(GET_LOCK / RELEASE_LOCK)을 이용한 동시성 제어 (`SQL`)](#snippet-22) - `practice/01_real_mysql_1/05_트랜잭션과_잠금/05_02_03_user_level_named_lock/README.md:22`
34. [B-Tree 인덱스 레인지 스캔 및 실행계획 분석 (`SQL`)](#snippet-34) - `practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan/README.md:34`
35. [커버링 인덱스(Using index) 최적화 쿼리 (`SQL`)](#snippet-33) - `practice/01_real_mysql_1/08_인덱스/08_03_04_covering_index_optimization/README.md:33`
36. [다중 컬럼 인덱스 선두 컬럼 조건에 따른 Index Range Scan vs Full Scan (`SQL`)](#snippet-33) - `practice/01_real_mysql_1/08_인덱스/08_03_02_composite_index_leading_column/README.md:33`
37. [MySQL InnoDB MVCC 언두 로그 기반 일관된 읽기 시뮬레이션 (`SQL`)](#snippet-28) - `practice/01_real_mysql_1/04_아키텍처/04_02_03_innodb_mvcc_consistent_read/README.md:28`
38. [MySQL 8.0 SET PERSIST 를 이용한 시스템 변수 동적/영구 설정 (`SQL`)](#snippet-21) - `practice/01_real_mysql_1/02_설치와_설정/02_04_05_set_persist_system_variables/README.md:21`
39. [MySQL 8.0 버전 및 글로벌 상태 변수 확인 (`SQL`)](#snippet-20) - `practice/01_real_mysql_1/01_소개/01_01_01_mysql_version_and_features/README.md:20`
40. [MySQL InnoDB 테이블 압축(ROW_FORMAT=COMPRESSED) 상태 점검 (`SQL`)](#snippet-27) - `practice/01_real_mysql_1/06_데이터_압축/06_02_01_innodb_table_compression/README.md:27`
41. [오라클 서브쿼리 Unnesting 및 HASH SEMI JOIN 유도 (UNNEST 힌트) (`SQL`)](#snippet-40) - `practice/07_oracle_adv_optimizer_rewrite/02_쿼리_변환/02_01_01_subquery_unnesting/README.md:40`
42. [SQLP 실전: 소량 집합을 드라이빙으로 삼는 고성능 Nested Loops 조인 유도 (`SQL`)](#snippet-42) - `practice/17_sqlp_1/03_인덱스_조인_실전튜닝/03_02_01_nl_join_driving_table_optimization/README.md:42`
43. [SQLD 단골 기출: GROUP BY, HAVING 절 및 NVL을 적용한 실결제금액 집계 (`SQL`)](#snippet-33) - `practice/16_sqld_500/02_SQL_활용_기출/02_04_01_group_by_having_and_null_logic/README.md:33`
44. [오라클 대용량 배치 적재: Direct Path Insert (/*+ APPEND */) 패턴 (`SQL`)](#snippet-38) - `practice/18_sqlp_2/05_배치_고급튜닝/05_01_01_direct_path_insert_append_hint/README.md:38`
45. [오라클 Hash Join 및 Build Input 제어 (USE_HASH + LEADING) (`SQL`)](#snippet-40) - `practice/05_oracle_adv_index_join/02_조인_튜닝/02_03_01_hash_join_build_and_probe/README.md:40`
46. [MySQL 8.0 EXPLAIN ANALYZE 실행 계획 및 실제 수행 시간 프로파일링 (`SQL`)](#snippet-32) - `practice/02_real_mysql_2/10_실행_계획/10_02_01_explain_analyze_execution_time/README.md:32`
47. [MySQL 8.0 GTID 및 복제 관련 글로벌 시스템 변수 점검 (`SQL`)](#snippet-20) - `practice/02_real_mysql_2/15_복제_Replication/15_02_01_gtid_based_replication_status/README.md:20`
48. [MySQL 레인지 파티션 프루닝(Partition Pruning) 검증 (`SQL`)](#snippet-37) - `practice/02_real_mysql_2/12_파티션/12_02_01_range_partition_pruning/README.md:37`
49. [MySQL 스토어드 프로시저 트랜잭션 핸들러 및 원자적 잔액 갱신 (`SQL`)](#snippet-26) - `practice/02_real_mysql_2/13_스토어드_프로그램/13_02_01_stored_procedure_and_transaction/README.md:26`
50. [MySQL 8.0 서브쿼리 세미 조인(Semi-Join) 최적화 및 FirstMatch 분석 (`SQL`)](#snippet-34) - `practice/02_real_mysql_2/11_쿼리_작성_및_최적화/11_03_01_subquery_semi_join_optimization/README.md:34`
51. [SQL 안티패턴 해법: 교차 테이블(Junction Table)을 이용한 고속 태그 검색 (`SQL`)](#snippet-45) - `practice/14_sql_antipatterns/01_무단횡단_Jaywalking/01_01_01_jaywalking_to_intersection_table/README.md:45`
52. [SQL 안티패턴 해법: NULL 안전 비교 (IS DISTINCT FROM / COALESCE) (`SQL`)](#snippet-33) - `practice/14_sql_antipatterns/13_공포의_알수없음_NULL/13_01_01_null_safe_comparison_coalesce/README.md:33`
53. [SQL 안티패턴 해법: 폐쇄 테이블(Closure Table)을 이용한 1번 글의 모든 후손 댓글 조회 (`SQL`)](#snippet-46) - `practice/14_sql_antipatterns/02_순진한_트리_Naive_Trees/02_01_01_closure_table_hierarchical_solution/README.md:46`
54. [오라클 소트 생략 및 Top-N STOPKEY 페이징 쿼리 패턴 (`SQL`)](#snippet-35) - `practice/06_oracle_adv_sort_partition/01_소트_튜닝/01_03_01_top_n_sort_order_by_stopkey/README.md:35`
55. [오라클 무한 대기 방지 비관적 락: SELECT FOR UPDATE NOWAIT (`SQL`)](#snippet-29) - `practice/04_oracle_adv_arch_concurrency/02_트랜잭션_동시성_제어/02_02_01_pessimistic_lock_for_update_nowait/README.md:29`
56. [PostgreSQL 윈도우 프레임 절을 이용한 일별 누적매출 및 7일 이동평균 (`SQL`)](#snippet-36) - `practice/11_sql_recipes_data_analysis/04_매출_분석/04_02_01_cumulative_sales_and_moving_average/README.md:36`
57. [PostgreSQL RFM 고객 세그먼테이션 지표 집계 쿼리 (`SQL`)](#snippet-36) - `practice/11_sql_recipes_data_analysis/05_사용자_분석/05_04_01_user_rfm_scoring_analysis/README.md:36`

---

### 1. 오라클 바인드 변수 선언 및 소프트 파싱 유도 쿼리 (`SQL`)
- 출처: `practice/08_oracle_adv_3_tuning_factors/01_라이브러리_캐시_튜닝/01_02_01_bind_variables_and_soft_parsing/README.md:30`
```sql
VARIABLE b_level VARCHAR2(2);
```

### 2. SQL 전문가 가이드: ROLLUP 및 GROUPING 함수를 이용한 지점별/상품별 다차원 소계 (`SQL`)
- 출처: `practice/09_sql_expert_guide/02_고급_그룹함수와_윈도우/02_07_01_rollup_cube_and_grouping/README.md:31`
```sql
SELECT 
    CASE WHEN GROUPING(branch_name) = 1 THEN '전체 지점' ELSE branch_name END AS branch,
    CASE WHEN GROUPING(product_cat) = 1 THEN '지점 소계' ELSE product_cat END AS category,
    SUM(revenue) AS total_revenue,
    GROUPING(branch_name) AS g_branch,
    GROUPING(product_cat) AS g_cat
FROM branch_revenue
GROUP BY ROLLUP(branch_name, product_cat);
```

### 3. SQL 전문가 가이드: 제3정규형 테이블 간 참조 조인 쿼리 (`SQL`)
- 출처: `practice/09_sql_expert_guide/01_데이터_모델링과_정규화/01_02_01_normalization_1nf_2nf_3nf/README.md:41`
```sql
SELECT s.student_id, s.student_name, m.major_name, m.dept_head
FROM student_profile s
JOIN student_major m ON s.major_id = m.major_id
ORDER BY s.student_id;
```

### 4. 오라클 표준 계층형 질의 (START WITH CONNECT BY PRIOR 및 LEVEL 들여쓰기) (`SQL`)
- 출처: `practice/09_sql_expert_guide/02_계층형_질의/02_05_01_start_with_connect_by_prior/README.md:37`
```sql
SELECT 
    LEVEL,
    LPAD(' ', (LEVEL - 1) * 3) || ename AS emp_tree,
    empno,
    mgr,
    CONNECT_BY_ISLEAF AS is_leaf,
    SYS_CONNECT_BY_PATH(ename, '/') AS path_str
FROM emp_hierarchy
START WITH mgr IS NULL
CONNECT BY PRIOR empno = mgr
ORDER SIBLINGS BY ename;
```

### 5. 5대 DB 공통: 한 테이블에만 존재하는 행 조회 (Anti-Join 패턴) (`SQL`)
- 출처: `practice/13_sql_cookbook/03_다중_테이블_작업/03_05_01_outer_join_and_coalesce/README.md:40`
```sql
SELECT d.deptno, d.dname
FROM dept d
LEFT OUTER JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;
```

### 6. MongoDB $lookup 스테이지를 이용한 컬렉션 간 Left Outer Join 집계 (`SQL`)
- 출처: `practice/15_real_mongodb/06_다중컬렉션_조인_lookup/06_04_01_aggregation_lookup_left_outer_join/README.md:34`
```sql
db.customers.aggregate([
    {
        $lookup: {
            from: "purchases",
            localField: "_id",
            foreignField: "cust_id",
            as: "order_history"
        }
    },
    { $sort: { _id: 1 } }
]);
```

### 7. MongoDB Aggregation 파이프라인 ($match -> $group -> $sort) (`SQL`)
- 출처: `practice/15_real_mongodb/03_aggregation/03_01_01_aggregation_group_and_sort/README.md:29`
```sql
db.orders.aggregate([
    { $match: { status: "A" } },
    { $group: { _id: "$cust_id", total: { $sum: "$amount" }, count: { $sum: 1 } } },
    { $sort: { total: -1 } }
]);
```

### 8. MongoDB $addToSet 을 이용한 중복 없는 배열 스킬 추가 (`SQL`)
- 출처: `practice/15_real_mongodb/04_CRUD_배열연산/04_02_01_atomic_array_update_operators/README.md:27`
```sql
db.users.updateOne(
    { _id: 1 },
    { $addToSet: { skills: "MongoDB" } }
);
```

### 9. PostgreSQL 윈도우 함수를 이용한 학교별 급여 순위 및 평균 대비 차이 계산 (`SQL`)
- 출처: `practice/10_practical_sql/05_수학과_통계_함수/05_02_01_aggregate_and_window_functions/README.md:37`
```sql
SELECT 
    school,
    first_name,
    last_name,
    salary,
    RANK() OVER (PARTITION BY school ORDER BY salary DESC) AS school_rank,
    ROUND(AVG(salary) OVER (PARTITION BY school), 2) AS school_avg_sal,
    salary - ROUND(AVG(salary) OVER (PARTITION BY school), 2) AS diff_from_avg
FROM teachers
ORDER BY school, school_rank;
```

### 10. PostgreSQL 표준 WITH RECURSIVE 를 이용한 계층 트리 탐색 (`SQL`)
- 출처: `practice/10_practical_sql/12_고급_쿼리와_CTE/12_02_01_recursive_cte_hierarchy/README.md:32`
```sql
WITH RECURSIVE emp_tree AS (
    -- 1. Anchor member (루트 노드)
    SELECT emp_id, name, manager_id, 1 AS depth, CAST(name AS VARCHAR(255)) AS full_path
    FROM org_chart
    WHERE manager_id IS NULL

    UNION ALL

    -- 2. Recursive member (자식 노드 탐색)
    SELECT c.emp_id, c.name, c.manager_id, p.depth + 1, CAST(p.full_path || ' -> ' || c.name AS VARCHAR(255))
    FROM org_chart c
    JOIN emp_tree p ON c.manager_id = p.emp_id
)
SELECT depth, name, full_path
FROM emp_tree
ORDER BY depth, emp_id;
```

### 11. PostgreSQL JSONB 추출(->>) 및 포함 연산자(@>) 검색 (`SQL`)
- 출처: `practice/10_practical_sql/15_JSON_데이터_처리/15_02_01_jsonb_operators_and_indexing/README.md:34`
```sql
SELECT 
    event_id,
    user_id,
    payload->>'action' AS action,
    payload->'device'->>'os' AS client_os
FROM user_events
WHERE payload @> '{"action": "login"}';
```

### 12. MySQL SAVEPOINT 를 이용한 트랜잭션 부분 롤백 시뮬레이션 (`SQL`)
- 출처: `practice/12_learning_sql/12_트랜잭션/12_03_01_savepoint_and_partial_rollback/README.md:28`
```sql
START TRANSACTION;
```

### 13. MySQL CASE 표현식을 이용한 분기별 매출 피벗(Pivot) 집계 (`SQL`)
- 출처: `practice/12_learning_sql/11_조건부_로직/11_02_01_case_expression_pivot/README.md:33`
```sql
SELECT 
    rep_name,
    SUM(CASE WHEN quarter_num = 1 THEN sales_amount ELSE 0 END) AS Q1_Sales,
    SUM(CASE WHEN quarter_num = 2 THEN sales_amount ELSE 0 END) AS Q2_Sales,
    SUM(sales_amount) AS Total_Sales
FROM quarterly_sales
GROUP BY rep_name
ORDER BY rep_name;
```

### 14. MySQL 상관 서브쿼리를 이용한 부서별 최고 급여 수령자 추출 (`SQL`)
- 출처: `practice/12_learning_sql/09_서브쿼리/09_03_01_correlated_subquery_filter/README.md:34`
```sql
SELECT s.dept_id, s.emp_name, s.salary
FROM staff_members s
WHERE s.salary = (
    SELECT MAX(sub.salary)
    FROM staff_members sub
    WHERE sub.dept_id = s.dept_id
)
ORDER BY s.dept_id, s.emp_name;
```

### 15. 오라클 INDEX RANGE SCAN 및 실행계획 확인 (친절한 SQL 튜닝) (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/03_인덱스_스캔_효율화/03_03_01_index_seek_and_scan/README.md:36`
```sql
EXPLAIN PLAN FOR
SELECT /*+ INDEX(e idx_emp_dept_sal) */ empno, ename, sal
FROM emp_tune e
WHERE deptno = 30 AND sal >= 1500;
```

### 16. BETWEEN을 IN-List 전환하여 INLIST ITERATOR 유도 (I/O 최소화) (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/03_인덱스_스캔_효율화/03_03_06_between_to_inlist_transformation/README.md:33`
```sql
EXPLAIN PLAN FOR
SELECT /*+ INDEX(s idx_sales_media_date) */ sale_id, media_code, amount
FROM online_sales s
WHERE media_code IN ('01', '02')
  AND sale_date = '20261020';
```

### 17. 친절한 SQL 튜닝: Hash Join 및 작은 집합의 Build Input 유도 (USE_HASH) (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/04_조인_튜닝/04_03_01_hash_join_build_probe_optimization/README.md:40`
```sql
EXPLAIN PLAN FOR
SELECT /*+ LEADING(s) USE_HASH(l) */
    s.supp_name, l.qty, l.price
FROM supplier s
JOIN line_item l ON s.supp_id = l.supp_id
WHERE s.region = '수원';
```

### 18. 친절한 SQL 튜닝: Nested Loops 조인 제어 (LEADING + USE_NL + INDEX) (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/04_조인_튜닝/04_01_01_nl_join_mechanism_and_driving/README.md:44`
```sql
EXPLAIN PLAN FOR
SELECT /*+ LEADING(d) USE_NL(e) INDEX(e idx_emp_dept) */
    d.dept_name, d.loc, e.emp_name, e.salary
FROM tbl_department d
JOIN tbl_employee e ON d.dept_id = e.dept_id
WHERE d.loc = '판교';
```

### 19. 친절한 SQL 튜닝: FULL 힌트를 이용한 Multiblock I/O 시퀀셜 스캔 유도 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/01_SQL_처리과정과_IO/01_03_01_block_io_and_access_methods/README.md:31`
```sql
EXPLAIN PLAN FOR
SELECT /*+ FULL(p) */ category, SUM(val)
FROM perf_benchmark p
GROUP BY category;
```

### 20. 친절한 SQL 튜닝: SQL 최적화 및 기본 실행계획 확인 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/01_SQL_처리과정과_IO/01_01_01_sql_parsing_and_optimization/README.md:31`
```sql
EXPLAIN PLAN FOR
SELECT cust_id, cust_name, credit_limit
FROM customer_info
WHERE credit_limit >= 5000000;
```

### 21. 친절한 SQL 튜닝: 바인드 변수를 활용한 라이브러리 캐시 소프트 파싱 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/01_SQL_처리과정과_IO/01_02_01_soft_parsing_vs_hard_parsing/README.md:32`
```sql
VARIABLE v_user VARCHAR2(20);
```

### 22. 친절한 SQL 튜닝: 옵티마이저 예상 카디널리티(Rows) 확인 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/07_SQL_옵티마이저/07_01_01_selectivity_cardinality_cost/README.md:31`
```sql
EXPLAIN PLAN FOR
SELECT mem_id, points
FROM member_ranks
WHERE mem_grade = 'GOLD';
```

### 23. 친절한 SQL 튜닝: 대용량 적재 가속화를 위한 Direct Path Insert (APPEND 힌트) (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/06_DML_튜닝/06_02_02_direct_path_insert_tuning/README.md:35`
```sql
INSERT /*+ APPEND */ INTO sales_archive (sale_id, amount, sale_date)
SELECT sale_id, amount, sale_date
FROM sales_staging;
```

### 24. 친절한 SQL 튜닝: 단일 스캔으로 처리하는 MERGE INTO 구문 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/06_DML_튜닝/06_01_06_merge_statement_upsert/README.md:37`
```sql
MERGE INTO customer_target t
USING customer_source s
ON (t.cust_id = s.cust_id)
WHEN MATCHED THEN
    UPDATE SET t.points = s.new_points
WHEN NOT MATCHED THEN
    INSERT (cust_id, cust_name, points)
    VALUES (s.cust_id, s.cust_name, s.new_points);
```

### 25. 친절한 SQL 튜닝: Index Skip Scan 유도 힌트 (선두 컬럼 조건 누락 시) (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/02_인덱스_기본/02_03_04_index_skip_scan_mechanism/README.md:34`
```sql
EXPLAIN PLAN FOR
SELECT /*+ INDEX_SS(e idx_emp_gender_sal) */ emp_id, gender, salary
FROM employee_skip e
WHERE salary >= 8000;
```

### 26. 친절한 SQL 튜닝: 컬럼 원형 보존을 통한 Index Range Scan 유도 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/02_인덱스_기본/02_02_01_index_column_modification_invalidation/README.md:33`
```sql
-- 안티패턴: WHERE TO_CHAR(contract_date, 'YYYY') = '2026' (인덱스 무효화)
-- 최적화: 컬럼 원형을 보존하고 우변 상수 범위를 지정
EXPLAIN PLAN FOR
SELECT /*+ INDEX(c idx_contract_date) */ contract_id, contract_no, fee
FROM contracts_basic c
WHERE contract_date >= TO_DATE('2026-01-01', 'YYYY-MM-DD')
  AND contract_date <  TO_DATE('2027-01-01', 'YYYY-MM-DD');
```

### 27. 친절한 SQL 튜닝: DBMS_XPLAN 패키지의 Predicate 정보 확인 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/08_부록_SQL_분석도구/08_04_01_dbms_xplan_advanced_options/README.md:30`
```sql
EXPLAIN PLAN FOR
SELECT /*+ INDEX(a idx_audit_user) */ audit_id, event_type
FROM account_audit a
WHERE user_no = 1001;
```

### 28. 친절한 SQL 튜닝: Top-N STOPKEY 소트 생략 페이징 패턴 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/05_소트_튜닝/05_03_02_top_n_query_count_stopkey/README.md:34`
```sql
EXPLAIN PLAN FOR
SELECT *
FROM (
    SELECT /*+ INDEX(n idx_notice_cat_date) */ art_id, category_id, reg_date, title
    FROM notice_article n
    WHERE category_id = 10
    ORDER BY reg_date DESC
)
WHERE ROWNUM <= 2;
```

### 29. 친절한 SQL 튜닝: UNION ALL 을 활용한 SORT UNIQUE 연산 생략 (`SQL`)
- 출처: `practice/03_friendly_sql_tuning/05_소트_튜닝/05_02_01_union_vs_union_all_sort_elimination/README.md:35`
```sql
EXPLAIN PLAN FOR
SELECT pay_id, pay_amount, 'CARD' AS pay_type
FROM payment_card
WHERE pay_date >= TO_DATE('2026-10-01', 'YYYY-MM-DD')
UNION ALL
SELECT pay_id, pay_amount, 'BANK' AS pay_type
FROM payment_bank
WHERE pay_date >= TO_DATE('2026-10-01', 'YYYY-MM-DD');
```

### 30. MySQL 8.0 역할(Role) 확인 및 권한 조회 (`SQL`)
- 출처: `practice/01_real_mysql_1/03_사용자_및_권한/03_05_01_role_based_access_control/README.md:21`
```sql
SHOW GRANTS FOR r_analyst;
```

### 31. MySQL TDE 암호화 옵션 확인 (`SQL`)
- 출처: `practice/01_real_mysql_1/07_데이터_암호화/07_03_01_tde_table_encryption/README.md:26`
```sql
SHOW CREATE TABLE secure_card_info;
```

### 32. MySQL 8.0 표준 옵티마이저 힌트 (JOIN_ORDER 및 INDEX 지정) (`SQL`)
- 출처: `practice/01_real_mysql_1/09_옵티마이저와_힌트/09_04_01_optimizer_hints_join_order/README.md:37`
```sql
EXPLAIN FORMAT=TREE
SELECT /*+ JOIN_ORDER(u, o) INDEX(u idx_level) */
    u.name, o.amount
FROM opt_users u
JOIN opt_orders o ON u.user_id = o.user_id
WHERE u.level = 1;
```

### 33. MySQL 네임드 락(GET_LOCK / RELEASE_LOCK)을 이용한 동시성 제어 (`SQL`)
- 출처: `practice/01_real_mysql_1/05_트랜잭션과_잠금/05_02_03_user_level_named_lock/README.md:22`
```sql
-- 1. 'batch_process_lock' 이름으로 최대 5초간 락 획득 시도 (성공 시 1 반환)
SELECT GET_LOCK('batch_process_lock', 5) AS lock_acquired;
```

### 34. B-Tree 인덱스 레인지 스캔 및 실행계획 분석 (`SQL`)
- 출처: `practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan/README.md:34`
```sql
EXPLAIN FORMAT=TREE
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name BETWEEN 'Bamford' AND 'Facello';
```

### 35. 커버링 인덱스(Using index) 최적화 쿼리 (`SQL`)
- 출처: `practice/01_real_mysql_1/08_인덱스/08_03_04_covering_index_optimization/README.md:33`
```sql
EXPLAIN FORMAT=TREE
SELECT emp_no, salary
FROM salaries
WHERE emp_no = 10001 AND salary > 60000;
```

### 36. 다중 컬럼 인덱스 선두 컬럼 조건에 따른 Index Range Scan vs Full Scan (`SQL`)
- 출처: `practice/01_real_mysql_1/08_인덱스/08_03_02_composite_index_leading_column/README.md:33`
```sql
EXPLAIN FORMAT=TREE
SELECT emp_no, dept_no
FROM dept_emp
WHERE dept_no = 'd001' AND emp_no >= 10002;
```

### 37. MySQL InnoDB MVCC 언두 로그 기반 일관된 읽기 시뮬레이션 (`SQL`)
- 출처: `practice/01_real_mysql_1/04_아키텍처/04_02_03_innodb_mvcc_consistent_read/README.md:28`
```sql
-- 트랜잭션 시작 전 현재 데이터 확인
SELECT id, name, balance FROM member_account WHERE id = 1;
```

### 38. MySQL 8.0 SET PERSIST 를 이용한 시스템 변수 동적/영구 설정 (`SQL`)
- 출처: `practice/01_real_mysql_1/02_설치와_설정/02_04_05_set_persist_system_variables/README.md:21`
```sql
SHOW VARIABLES LIKE 'max_connections';
```

### 39. MySQL 8.0 버전 및 글로벌 상태 변수 확인 (`SQL`)
- 출처: `practice/01_real_mysql_1/01_소개/01_01_01_mysql_version_and_features/README.md:20`
```sql
SELECT VERSION() AS mysql_version, CURRENT_USER() AS session_user;
```

### 40. MySQL InnoDB 테이블 압축(ROW_FORMAT=COMPRESSED) 상태 점검 (`SQL`)
- 출처: `practice/01_real_mysql_1/06_데이터_압축/06_02_01_innodb_table_compression/README.md:27`
```sql
SELECT table_name, row_format, create_options
FROM information_schema.tables
WHERE table_schema = 'practice_db' AND table_name = 'compressed_log';
```

### 41. 오라클 서브쿼리 Unnesting 및 HASH SEMI JOIN 유도 (UNNEST 힌트) (`SQL`)
- 출처: `practice/07_oracle_adv_optimizer_rewrite/02_쿼리_변환/02_01_01_subquery_unnesting/README.md:40`
```sql
EXPLAIN PLAN FOR
SELECT /*+ UNNEST */ c.cust_id, c.cust_name
FROM customers c
WHERE c.city = '서울'
  AND EXISTS (
      SELECT 1 
      FROM contracts k 
      WHERE k.cust_id = c.cust_id AND k.contract_amount >= 3000000
  );
```

### 42. SQLP 실전: 소량 집합을 드라이빙으로 삼는 고성능 Nested Loops 조인 유도 (`SQL`)
- 출처: `practice/17_sqlp_1/03_인덱스_조인_실전튜닝/03_02_01_nl_join_driving_table_optimization/README.md:42`
```sql
EXPLAIN PLAN FOR
SELECT /*+ LEADING(c) USE_NL(o) INDEX(o idx_order_cust_date) */
    c.cust_id, c.cust_grade, o.order_id, o.order_amount
FROM customer_master c
JOIN order_history o ON c.cust_id = o.cust_id
WHERE c.cust_grade = 'VIP'
  AND o.order_date >= TO_DATE('2026-10-01', 'YYYY-MM-DD');
```

### 43. SQLD 단골 기출: GROUP BY, HAVING 절 및 NVL을 적용한 실결제금액 집계 (`SQL`)
- 출처: `practice/16_sqld_500/02_SQL_활용_기출/02_04_01_group_by_having_and_null_logic/README.md:33`
```sql
SELECT 
    cust_id,
    COUNT(*) AS order_cnt,
    SUM(order_amt - NVL(discount_amt, 0)) AS net_total
FROM exam_orders
GROUP BY cust_id
HAVING SUM(order_amt - NVL(discount_amt, 0)) >= 70000
ORDER BY net_total DESC;
```

### 44. 오라클 대용량 배치 적재: Direct Path Insert (/*+ APPEND */) 패턴 (`SQL`)
- 출처: `practice/18_sqlp_2/05_배치_고급튜닝/05_01_01_direct_path_insert_append_hint/README.md:38`
```sql
INSERT /*+ APPEND */ INTO target_history (log_id, log_type, log_msg, log_time)
SELECT log_id, log_type, log_msg, log_time
FROM source_staging;
```

### 45. 오라클 Hash Join 및 Build Input 제어 (USE_HASH + LEADING) (`SQL`)
- 출처: `practice/05_oracle_adv_index_join/02_조인_튜닝/02_03_01_hash_join_build_and_probe/README.md:40`
```sql
EXPLAIN PLAN FOR
SELECT /*+ LEADING(d) USE_HASH(e) */ 
    d.dept_name, e.emp_name, e.salary
FROM departments d
JOIN employees_large e ON d.dept_id = e.dept_id
WHERE d.dept_id = 10;
```

### 46. MySQL 8.0 EXPLAIN ANALYZE 실행 계획 및 실제 수행 시간 프로파일링 (`SQL`)
- 출처: `practice/02_real_mysql_2/10_실행_계획/10_02_01_explain_analyze_execution_time/README.md:32`
```sql
EXPLAIN ANALYZE
SELECT order_id, total_amount
FROM orders
WHERE customer_id = 101 AND order_date >= '2026-01-01';
```

### 47. MySQL 8.0 GTID 및 복제 관련 글로벌 시스템 변수 점검 (`SQL`)
- 출처: `practice/02_real_mysql_2/15_복제_Replication/15_02_01_gtid_based_replication_status/README.md:20`
```sql
SELECT @@GLOBAL.gtid_mode AS gtid_mode,
       @@GLOBAL.enforce_gtid_consistency AS enforce_gtid,
       @@GLOBAL.server_id AS server_id;
```

### 48. MySQL 레인지 파티션 프루닝(Partition Pruning) 검증 (`SQL`)
- 출처: `practice/02_real_mysql_2/12_파티션/12_02_01_range_partition_pruning/README.md:37`
```sql
EXPLAIN
SELECT id, sale_date, amount
FROM sales_history
WHERE sale_date BETWEEN '2026-01-01' AND '2026-12-31';
```

### 49. MySQL 스토어드 프로시저 트랜잭션 핸들러 및 원자적 잔액 갱신 (`SQL`)
- 출처: `practice/02_real_mysql_2/13_스토어드_프로그램/13_02_01_stored_procedure_and_transaction/README.md:26`
```sql
DROP PROCEDURE IF EXISTS sp_transfer_funds;
```

### 50. MySQL 8.0 서브쿼리 세미 조인(Semi-Join) 최적화 및 FirstMatch 분석 (`SQL`)
- 출처: `practice/02_real_mysql_2/11_쿼리_작성_및_최적화/11_03_01_subquery_semi_join_optimization/README.md:34`
```sql
EXPLAIN FORMAT=TREE
SELECT dept_id, dept_name
FROM store_departments d
WHERE dept_id IN (
    SELECT dept_id 
    FROM store_staff s 
    WHERE s.name LIKE 'Dev%'
);
```

### 51. SQL 안티패턴 해법: 교차 테이블(Junction Table)을 이용한 고속 태그 검색 (`SQL`)
- 출처: `practice/14_sql_antipatterns/01_무단횡단_Jaywalking/01_01_01_jaywalking_to_intersection_table/README.md:45`
```sql
SELECT b.bug_id, b.description, t.tag_name
FROM bugs b
JOIN bug_tags bt ON b.bug_id = bt.bug_id
JOIN tags t ON bt.tag_id = t.tag_id
WHERE t.tag_name = '긴급';
```

### 52. SQL 안티패턴 해법: NULL 안전 비교 (IS DISTINCT FROM / COALESCE) (`SQL`)
- 출처: `practice/14_sql_antipatterns/13_공포의_알수없음_NULL/13_01_01_null_safe_comparison_coalesce/README.md:33`
```sql
-- 0개가 아닌 상품(재고 미확인 NULL 포함)을 안전하게 조회
SELECT item_id, item_name, COALESCE(stock_qty, -1) AS effective_stock
FROM inventory_items
WHERE stock_qty IS DISTINCT FROM 0;
```

### 53. SQL 안티패턴 해법: 폐쇄 테이블(Closure Table)을 이용한 1번 글의 모든 후손 댓글 조회 (`SQL`)
- 출처: `practice/14_sql_antipatterns/02_순진한_트리_Naive_Trees/02_01_01_closure_table_hierarchical_solution/README.md:46`
```sql
SELECT c.comment_id, c.author, c.content, p.path_length
FROM comments c
JOIN comment_tree_paths p ON c.comment_id = p.descendant_id
WHERE p.ancestor_id = 1 AND p.path_length > 0
ORDER BY p.path_length;
```

### 54. 오라클 소트 생략 및 Top-N STOPKEY 페이징 쿼리 패턴 (`SQL`)
- 출처: `practice/06_oracle_adv_sort_partition/01_소트_튜닝/01_03_01_top_n_sort_order_by_stopkey/README.md:35`
```sql
EXPLAIN PLAN FOR
SELECT *
FROM (
    SELECT /*+ INDEX(b idx_board_date) */ post_id, title, reg_date
    FROM board_post b
    WHERE board_id = 10
    ORDER BY reg_date DESC
)
WHERE ROWNUM <= 2;
```

### 55. 오라클 무한 대기 방지 비관적 락: SELECT FOR UPDATE NOWAIT (`SQL`)
- 출처: `practice/04_oracle_adv_arch_concurrency/02_트랜잭션_동시성_제어/02_02_01_pessimistic_lock_for_update_nowait/README.md:29`
```sql
SELECT acc_no, owner_name, balance
FROM account_balance
WHERE acc_no = 'ACC1001'
FOR UPDATE NOWAIT;
```

### 56. PostgreSQL 윈도우 프레임 절을 이용한 일별 누적매출 및 7일 이동평균 (`SQL`)
- 출처: `practice/11_sql_recipes_data_analysis/04_매출_분석/04_02_01_cumulative_sales_and_moving_average/README.md:36`
```sql
SELECT 
    dt,
    purchase_amount,
    SUM(purchase_amount) OVER (
        ORDER BY dt 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cum_amount,
    ROUND(AVG(purchase_amount) OVER (
        ORDER BY dt 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_7d
FROM daily_sales
ORDER BY dt;
```

### 57. PostgreSQL RFM 고객 세그먼테이션 지표 집계 쿼리 (`SQL`)
- 출처: `practice/11_sql_recipes_data_analysis/05_사용자_분석/05_04_01_user_rfm_scoring_analysis/README.md:36`
```sql
SELECT 
    user_id,
    MAX(order_date) AS last_order_date,
    DATE '2026-10-24' - MAX(order_date) AS recency_days,
    COUNT(*) AS frequency,
    SUM(amount) AS monetary_total
FROM customer_orders
GROUP BY user_id
ORDER BY monetary_total DESC;
```
