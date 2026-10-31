# 🚀 실전 SQL 튜닝 및 인덱스 설계 실용 가이드 (Pragmatic SQL Tuning)

> 이 문서는 본 워크스페이스의 18권 도서(특히 *친절한 SQL 튜닝*, *Real MySQL*, *오라클 성능 고도화*, *SQL 안티패턴*)에서 다루는 실무 핵심 튜닝 원리와 방법론을 압축 정리한 가이드입니다.

---

## 1. 인덱스 튜닝 3단계 핵심 원칙

대부분의 RDBMS(Oracle, MySQL, PostgreSQL)에서 쿼리 성능 저하의 90% 이상은 불필요한 디스크 I/O(블록 읽기)에서 비롯됩니다. 이를 해결하는 3단계 접근법은 다음과 같습니다.

```mermaid
flowchart LR
    A["1단계: 인덱스 스캔 범위 최소화<br/>(선두 컬럼 등치 조건 + Index Seek)"] --> B["2단계: 테이블 랜덤 액세스 최소화<br/>(커버링 인덱스 / 클러스터링 팩터)"]
    B --> C["3단계: 소트 오퍼레이션 생략<br/>(인덱스 정렬 순서 활용 / Top-N STOPKEY)"]
```

### 1단계: 인덱스 스캔 범위 최소화 (Index Seek 최적화)
* 원리: B-Tree 인덱스는 복합 인덱스 구성 시 선행 컬럼 순으로 정렬됩니다.
* 규칙:
  * 결합 인덱스 `(A, B, C)`에서 `A`가 등치(`=`) 조건이어야만 `B`의 수직적 탐색(Index Seek)이 유효합니다.
  * 선행 컬럼에 `BETWEEN`, `LIKE 'ABC%'`, `>`, `<` 같은 범위 조건이 사용되면, 후행 컬럼은 스캔 범위를 줄이지 못하고 단순 필터(Filter) 조건으로 전락합니다.
  * 해결책: `BETWEEN`을 `IN ('값1', '값2')` 형태의 IN-List Iterator로 전환하거나, 인덱스 컬럼 순서를 `(등치조건 컬럼, 범위조건 컬럼)` 순으로 재설계합니다.

### 2단계: 테이블 랜덤 액세스 최소화 (Random I/O 제거)
* 원리: 인덱스 리프 노드에서 조건을 만족하는 레코드를 찾은 뒤, 실제 데이터 페이지를 읽어오기 위해 RowID/PK로 테이블을 단건씩 조회하는 작업이 가장 비쌉니다.
* 해결책:
  * 커버링 인덱스 (Covering Index): `SELECT`, `WHERE`, `ORDER BY`에 필요한 모든 컬럼을 인덱스에 포함시켜 테이블 방문 자체를 0회로 만듭니다. (MySQL `Using index`)
  * 클러스터링 팩터(Clustering Factor) 개선: 인덱스 정렬 순서와 물리적 테이블 행 정렬 순서를 일치시켜 버퍼 캐시 히트율을 극대화합니다.

### 3단계: 소트 오퍼레이션 생략 (Sort Operation Elision)
* 원리: 대량 데이터 정렬(`ORDER BY`)은 Sort Area 메모리를 초과할 경우 Temp Tablespace(디스크 임시 파일)를 사용하여 급격한 성능 저하를 유발합니다.
* 해결책:
  * 인덱스의 자체 정렬 속성을 활용하여 `ORDER BY` 절을 만족시킵니다.
  * `ROWNUM <= N` 또는 `LIMIT N`을 결합하여 정렬을 전혀 수행하지 않고 즉시 스캔을 멈추는 Top-N Stopkey (COUNT STOPKEY) 오퍼레이션을 유도합니다.

---

## 2. 조인 튜닝 3대 기법 비교 및 선택 기준

| 조인 방식 | 동작 메커니즘 | 주 사용 환경 및 장점 | 단점 및 병목 요인 | 핵심 힌트 |
| :--- | :--- | :--- | :--- | :--- |
| Nested Loops (NL) | 드라이빙 테이블의 각 행마다 이너 테이블 인덱스를 반복 탐색 | OLTP 소량 데이터 조회, 빠른 최초 응답(Partial Range Scan) | 대용량 조인 시 수많은 Random I/O 발생 | `/*+ USE_NL(b) LEADING(a) */` |
| Hash Join | 작은 집합(Build Input)으로 인메모리 해시 테이블 생성 후 큰 집합(Probe Input) 탐색 | 대용량 배치 및 데이터 분석 (OLAP), 인덱스 불필요 | 해시 테이블 메모리(PGA) 초과 시 Disk Hash Join 발생 | `/*+ USE_HASH(b) SWAP_JOIN_INPUTS(a) */` |
| Sort Merge Join | 양쪽 테이블을 조인 키 기준으로 각각 정렬 후 머지 | 대용량 비등치 조인(`>`, `>=`) 또는 Hash Join 메모리 부족 시 | 양쪽 집합의 대규모 정렬 부하 | `/*+ USE_MERGE(b) */` |

---

## 3. 실행 계획(Execution Plan) 분석 체크포인트

1. MySQL 8.0 (`EXPLAIN FORMAT=TREE` / `EXPLAIN ANALYZE`):
   * `-> Index range scan on ... using <index_name>`: 정상적인 인덱스 레인지 스캔
   * `-> Covering index range scan ...`: 커버링 인덱스 (최적)
   * `-> Table scan on ...`: 전체 테이블 풀 스캔 여부 점검
   * `actual time=0.01..0.05 rows=10 loops=1`: 실제 실행 시간 및 반환 건수 프로파일링
2. Oracle Database (`EXPLAIN PLAN` & `DBMS_XPLAN.DISPLAY`):
   * `INDEX UNIQUE SCAN`: PK/UK 단건 탐색 (비용 최소)
   * `INDEX RANGE SCAN`: 인덱스 범위 스캔
   * `TABLE ACCESS BY INDEX ROWID`: 테이블 랜덤 방문 발생 (Rows 건수 점검)
   * `COUNT STOPKEY`: Top-N 정렬 생략 성공
   * `HASH JOIN SEMI`: EXISTS 서브쿼리 Unnesting 성공

---

## 4. 자주 발생하는 SQL 안티패턴 체크리스트

* ❌ 인덱스 컬럼 가공: `WHERE SUBSTR(birth, 1, 4) = '2026'`  
  👉 ✔️ 해결: `WHERE birth >= '2026-01-01' AND birth < '2027-01-01'` (컬럼 원형 보존)
* ❌ 묵시적 형변환: `WHERE phone_num = 01012345678` (숫자 vs 문자 비교)  
  👉 ✔️ 해결: `WHERE phone_num = '01012345678'`
* ❌ Jaywalking (콤마 구분 문자열): `tags = '인덱스,튜닝,오라클'`  
  👉 ✔️ 해결: 1:N 교차 테이블(Junction Table)로 정규화
* ❌ OR 조건 남용: `WHERE deptno = 10 OR job = 'MANAGER'`  
  👉 ✔️ 해결: `UNION ALL` 또는 `LNNVL` 함수 활용으로 각각의 인덱스 결합 분할 유도
