# 🛠️ Databases & SQL 빠른 명령어 치트시트 (tips/cheatsheet.md)

> 💡 본 문서는 일상 학습 시 터미널 옆에 띄워두고 즉각 참조할 수 있는 핵심 명령어, 7단계 학습 사이클, Podman 컨테이너 제어, 주요 DB 접속 URL 및 튜닝 치트키를 모아둔 전용 치트시트입니다.

---

## 🔄 1. 학습자의 7단계 실습 사이클 (stoneCpp 워크플로우)

```mermaid
flowchart LR
    S1["[1] 탐색<br/>(Select)"] --> S2["[2] 이해<br/>(README)"]
    S2 --> S3["[3] 필사<br/>(main.sql)"]
    S3 --> S4["[4] 실행<br/>(run.sh)"]
    S4 --> S5["[5] 검증<br/>(test.sh)"]
    S5 --> S6["[6] 실험<br/>(EXPLAIN)"]
    S6 --> S7["[7] 축적<br/>(snippets.sh)"]
```

| 단계 | 수행 작업 | 핵심 명령어 / 액션 |
| :--- | :--- | :--- |
| [1] 탐색 (Select) | 오늘 공부할 도서 및 절 폴더로 이동 | `cd practice/<도서>/<대단원>/<절>` |
| [2] 이해 (Understand) | 핵심 이론과 사전 준비 스키마 구조 정독 | `README.md` (0장 이론, 1장 `schema.sql`) |
| [3] 필사 (Clone-Typing) | 단계별 주석 가이드를 보며 쿼리 직접 타이핑 | `main.sql` (`-- Step 1: ...` 주석 아래 작성) |
| [4] 실행 (Run & Compare)| DDL 자동 적재 후 쿼리 즉시 실행 및 결과 대조 | `./scripts/run.sh <실습_폴더_경로>` |
| [5] 검증 (Assert) | 단언 쿼리(`test_passed: 1`) 단위 테스트 검증 | `./scripts/test.sh <실습_폴더_경로>` |
| [6] 실험 (Experiment) | 인덱스 무효화, 힌트 변경 후 실행계획(`EXPLAIN`) 관찰 | `EXPLAIN FORMAT=TREE` / `EXPLAIN PLAN` |
| [7] 축적 (Archive) | 나만의 핵심 패턴 스니펫 태깅 및 사전 갱신 | `-- @snippet("설명")` 달고 `./scripts/snippets.sh --export` |

---

## 🦭 2. Podman 컨테이너 인프라 관리

### ① 최초 1회 설치 및 머신 초기화 (macOS)
```bash
# 1. Podman 및 Podman Compose 설치 (Homebrew)
brew install podman podman-compose

# 2. Podman 가상 머신 초기화 (2 CPU, 4GB RAM, 50GB Disk)
./scripts/db.sh machine init

# 3. Podman 가상 머신 시작
./scripts/db.sh machine start
```

### ② 컨테이너 라이프사이클 제어
```bash
./scripts/db.sh up                 # 4대 DB(MySQL, PostgreSQL, MongoDB, Oracle) 백그라운드 시작
./scripts/db.sh down               # 모든 컨테이너 안전 종료
./scripts/db.sh status             # 실행 상태, 컨테이너 ID 및 포트 점검
./scripts/db.sh logs [서비스]      # 로그 실시간 스트리밍 (예: ./scripts/db.sh logs mysql)
```

### ③ 대화형 DB CLI 원클릭 접속
```bash
./scripts/db.sh cli mysql          # MySQL 대화형 CLI 접속 (practice / practice)
./scripts/db.sh cli postgres       # PostgreSQL psql 접속 (postgres / root)
./scripts/db.sh cli mongo          # MongoDB mongosh 접속 (root / root)
./scripts/db.sh cli oracle         # Oracle sqlplus 접속 (practice / practice)
```

---

## 🚀 3. 실습 실행 및 결과 대조 (`run.sh`)

`schema.sql`의 DDL 및 Mock Data를 엔진에 먼저 적재한 후 `main.sql`을 실행하여 ASCII 표로 출력합니다:

```bash
# [MySQL] Real MySQL 8.0 (1권) B-Tree 인덱스 레인지 스캔
./scripts/run.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan

# [오라클] 친절한 SQL 튜닝 인덱스 탐색 및 스캔
./scripts/run.sh practice/03_friendly_sql_tuning/03_인덱스_스캔_효율화/03_03_01_index_seek_and_scan

# [PostgreSQL] 실용 SQL 윈도우 및 집계 함수
./scripts/run.sh practice/10_practical_sql/05_수학과_통계_함수/05_02_01_aggregate_and_window_functions

# [경량 인메모리] SQL Cookbook 한 테이블에만 존재하는 행 찾기 (SQLite 즉시 실행)
./scripts/run.sh practice/13_sql_cookbook/03_다중_테이블_작업/03_05_01_outer_join_and_coalesce

# [MongoDB] Real MongoDB Aggregation 파이프라인 그룹핑 및 정렬
./scripts/run.sh practice/15_real_mongodb/03_aggregation/03_01_01_aggregation_group_and_sort
```

---

## 🧪 4. 단위 검증 및 일괄 테스트 (`test.sh` & `test_all.sh`)

```bash
# 1. 단일 실습 항목 검증 (test.sql 단언 쿼리 실행)
./scripts/test.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan
./scripts/test.sh practice/13_sql_cookbook/03_다중_테이블_작업/03_05_01_outer_join_and_coalesce

# 2. 18권 전 도서 실습 항목(총 57개) 일괄 테스트 검증
./scripts/test_all.sh
```

---

## 🔍 5. SQL 스니펫 검색 및 사전 내보내기 (`snippets.sh`)

```bash
# 1. 등록된 모든 57개 스니펫 전체 조회
./scripts/snippets.sh

# 2. 키워드 검색 (인덱스, 힌트, CTE, 조인 등)
./scripts/snippets.sh "인덱스"
./scripts/snippets.sh "CTE"
./scripts/snippets.sh "조인"

# 3. 요약 목록만 간략히 보기
./scripts/snippets.sh --list

# 4. tips/sql_snippets.md 마크다운 파일로 전체 자동 내보내기
./scripts/snippets.sh --export
```

---

## ⚙️ 6. 스캐폴딩 일괄 생성 및 전수 구문 검증

```bash
# 1. 18권 전 도서 실습 스캐폴딩 일괄 생성 (기존 작성한 main.sql은 안전하게 보존)
python3 scripts/generate_all.py

# 2. 강제 덮어쓰기 재생성 (주의: main.sql 초기화)
python3 scripts/generate_all.py --force

# 3. 18권 전 도서 모범 쿼리 전수 유효성 검증 (Syntax & Schema Verification)
python3 scripts/generate_all.py --verify

# 4. 개별 도서만 유효성 검증
python3 scripts/generate_content_01.py --verify
python3 scripts/generate_content_03.py --verify
```

---

## 📌 7. 도서 목차 Apple Vision OCR 자동 추출

스캔된 전자책 PDF의 목차 페이지를 macOS 네이티브 Vision OCR 엔진으로 고속 텍스트 추출:

```bash
# 사용법: ./scripts/ocr_pdf <PDF파일경로> <출력폴더> <시작페이지> <끝페이지>
./scripts/ocr_pdf contents/친절한-SQL-튜닝.pdf /tmp/ocr_out 1 20
```

---

## 🧭 8. 7대 DBMS 접속 정보 및 포트 색인표

| DBMS | 런타임 환경 | 호스트 포트 | 기본 계정 | 비밀번호 | DB명 (SID/PDB) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| MySQL 8.4 LTS | Podman (`mysql`) | `13306` | `practice` | `practice` | `practice_db` |
| PostgreSQL 17 | Podman (`postgres`) | `15432` | `postgres` | `root` | `practice_db` |
| Oracle 23ai Free | Podman (`oracle`) | `11521` | `practice` | `practice` | `FREEPDB1` |
| MongoDB 7.0 | Podman (`mongo`) | `27017` | `root` | `root` | `practice_db` |
| SQLite 3.54 | 로컬 인메모리 / Python | N/A | N/A | N/A | `:memory:` |
| DuckDB | 로컬 인메모리 / Python | N/A | N/A | N/A | `:memory:` |
| MS SQL Server | 공식 레퍼런스 문서 중심 | `1433` | `sa` | `YourPassword123` | `master` |

---

## ⚡ 9. 실무 SQL 튜닝 핵심 치트키

### ① 실행 계획 확인 쿼리
* MySQL 8.0+: `EXPLAIN FORMAT=TREE SELECT ...;` 또는 `EXPLAIN ANALYZE SELECT ...;`
* Oracle: `EXPLAIN PLAN FOR SELECT ...;` ➔ `SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);`
* PostgreSQL: `EXPLAIN (ANALYZE, BUFFERS, TIMING) SELECT ...;`
* SQLite: `EXPLAIN QUERY PLAN SELECT ...;`

### ② 오라클 핵심 옵티마이저 힌트
* 인덱스 지정: `/*+ INDEX(테이블명 인덱스명) */`
* 인덱스 스킵 스캔: `/*+ INDEX_SS(테이블명 인덱스명) */`
* NL 조인 드라이빙 유도: `/*+ LEADING(드라이빙테이블) USE_NL(피조인테이블) */`
* 해시 조인 및 빌드 인풋: `/*+ LEADING(빌드테이블) USE_HASH(프로브테이블) SWAP_JOIN_INPUTS(빌드테이블) */`
* 소트 머지 조인: `/*+ USE_MERGE(피조인테이블) */`
* 다이렉트 패스 인서트: `INSERT /*+ APPEND */ INTO 대상테이블 SELECT ...;`

### ③ MySQL 8.0+ 핵심 옵티마이저 힌트
* 조인 순서 고정: `/*+ JOIN_ORDER(t1, t2, t3) */`
* 인덱스 강제 적용: `SELECT * FROM 테이블 FORCE INDEX (인덱스명) WHERE ...;`
* 서브쿼리 세미조인 전략: `/*+ SEMIJOIN(FIRSTMATCH) */`, `/*+ SEMIJOIN(DUPSWEEDOUT) */`

---

## 📖 저장소 상세 문서 안내

* [`README.md`](file:///Users/flynn_macpro/githubs/databases/README.md) : 프로젝트 개요, 18권 트랙 분류표, Podman 퀵스타트
* [`PROJECT_STRUCTURE.md`](file:///Users/flynn_macpro/githubs/databases/PROJECT_STRUCTURE.md) : stoneCpp 아키텍처 사상 계승 명세서, 노드별 설계 의도
* [`DATABASE_SYSTEMS.md`](file:///Users/flynn_macpro/githubs/databases/DATABASE_SYSTEMS.md) : 7대 DBMS 공식 문서, 포트, SQL 방언 비교 매트릭스
* [`tips/sql_tuning_pragmatic.md`](file:///Users/flynn_macpro/githubs/databases/tips/sql_tuning_pragmatic.md) : 실무 SQL 튜닝 및 인덱스 분석 기법 가이드
* [`tips/sql_snippets.md`](file:///Users/flynn_macpro/githubs/databases/tips/sql_snippets.md) : 57개 자동 추출 핵심 SQL/NoSQL 스니펫 사전
