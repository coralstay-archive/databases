# 🏗️ Databases & SQL 프로젝트 구조 및 아키텍처 설계 명세서 (PROJECT_STRUCTURE.md)

> 📌 이 문서는 `~/githubs/stoneCpp`의 클론 타이핑·자동 스캐폴딩·단위 검증 아키텍처 철학을 계승하여 본 저장소의 모든 디렉터리와 파일의 존재 이유, 데이터 흐름, 설계 의도를 상세히 규정한 표준 명세서입니다.

---

## 1. 아키텍처 핵심 설계 원칙 (Core Architectural Principles)

본 프로젝트는 다음 5가지 핵심 원칙에 입각하여 설계되었습니다:

1. 단일 진실 공급원 (SSOT, Single Source of Truth)
   * 18권 도서의 고유 ID, 도서명, 슬러그, 타겟 DBMS, 원본 PDF 매핑 정보는 [`scripts/content_registry.py`](file:///Users/flynn_macpro/githubs/freeride/databases/scripts/content_registry.py) 한 곳에서만 관리합니다.
2. 선언적 메타데이터와 생성 엔진의 완전한 분리 (Separation of Concerns)
   * 각 도서의 장/절 목차, 개념, 스키마 픽스처, 완성 목표 쿼리는 `scripts/contentXX_data/` 모듈에 순수 파이썬 데이터로 선언하며, 생성 로직은 [`scripts/scaffold_engine.py`](file:///Users/flynn_macpro/githubs/freeride/databases/scripts/scaffold_engine.py)가 전담합니다.
3. 학습자 코드 보호 및 멱등성 (Idempotency & Non-destructive Scaffolding)
   * 스캐폴더를 반복 실행하더라도 학습자가 직접 작성 중인 `main.sql`은 절대 덮어쓰지 않고 보존합니다. (명시적인 `--force` 옵션 부여 시에만 백업 후 갱신)
4. 비어있는 코드의 완전한 자립 생성 (Self-Contained Executable Environment)
   * 교재 본문에 DDL이나 데이터가 생략되어 있어도, 스캐폴딩 엔진이 실행 가능한 최소 단위 DDL과 현실적인 Mock Data(`schema.sql`)를 자동 생성하여 모든 절이 즉시 실행(`run.sh`) 및 검증(`test.sh`) 가능합니다.
5. 체계적인 지식 자산화 및 다중 DBMS 색인화 (Knowledge Extraction & Dialect SSOT)
   * 주석에 명시된 `-- @snippet("설명")` 태그를 `snippets.sh`가 자동 수집하여 [`tips/sql_snippets.md`](file:///Users/flynn_macpro/githubs/databases/tips/sql_snippets.md)로 내보내며, 7대 DBMS의 버전, 포트, 접속 URL을 [`DATABASE_SYSTEMS.md`](file:///Users/flynn_macpro/githubs/databases/DATABASE_SYSTEMS.md)에서 단일 진실 공급원으로 관리합니다.

---

## 2. 전체 디렉터리 트리 (Visual Directory Tree)

```text
databases/
├── compose.yaml / docker-compose.yml  # 4대 주요 DBMS(MySQL, PG, Oracle, Mongo) OCI 컨테이너 정의 (Podman/Docker)
├── README.md                          # 전체 프로젝트 개요, 18권 트랙 분류표, 퀵스타트
├── PROJECT_STRUCTURE.md               # [본 문서] 아키텍처 및 트리별 상세 설계 명세서
├── DATABASE_SYSTEMS.md                # 7대 DBMS 공식 문서, 포트, 계정, 방언 비교 색인
├── .gitignore                         # 형상관리 제외 규칙 (/practice/, /contents/, /SQL-docs/, 캐시 등)
│
├── scripts/                           # 🛠️ 자동화 스크립트, 생성기 엔진, 런타임 툴체인
│   ├── content_registry.py            # 18권 도서 전체 메타데이터 레지스트리 (SSOT)
│   ├── scaffold_engine.py             # 스캐폴딩 템플릿 렌더링 및 --verify 유효성 검증 엔진
│   ├── runner_core.py                 # 다중 DBMS 스마트 디스패처 및 결과 서식화 코어 (Podman 우선)
│   ├── run.sh                         # 단일 실습 항목 즉시 실행기 (schema 자동 적재 후 main 실행)
│   ├── test.sh                        # 단일 실습 항목 검증기 (test.sql 실행 및 단언)
│   ├── test_all.sh                    # 전체 18개 트랙 실습 항목(57개) 일괄 테스트 러너
│   ├── db.sh                          # Podman 컨테이너 & VM 라이프사이클 관리 도구 (up/down/machine/cli)
│   ├── snippets.sh / snippets.py      # 실습 코드 내 @snippet 태그 추출 및 마크다운 내보내기
│   ├── help.sh                        # 대화형 CLI 치트시트 안내기
│   ├── ocr_pdf (.swift)               # macOS Vision 프레임워크 기반 PDF 고속 OCR 추출기
│   ├── generate_all.py                # 18권 전 도서 실습 스캐폴딩 일괄 생성/검증기
│   ├── generate_content_01.py ~ 18.py # 도서별 독립 스캐폴딩 생성기 (--force, --verify)
│   └── content01_data/ ~ content18_data/ # 18권 도서별 챕터 선언적 메타데이터 모듈
│
├── practice/                          # 🎯 [생성물/gitignore] 실제 학습자가 타이핑하고 실습하는 공간
│   ├── 01_real_mysql_1/               # Real MySQL 8.0 (1권) 트랙 (11개 실습)
│   ├── 02_real_mysql_2/               # Real MySQL 8.0 (2권) 트랙 (5개 실습)
│   ├── 03_friendly_sql_tuning/        # 친절한 SQL 튜닝 트랙 (15개 실습)
│   ├── 04_oracle_adv_arch_concurrency/# 오라클 성능 고도화: 아키텍처 및 동시성 제어
│   ├── 05_oracle_adv_index_join/      # 오라클 성능 고도화: 인덱스와 조인
│   ├── 06_oracle_adv_sort_partition/  # 오라클 성능 고도화: 소트튜닝과 파티션 병렬처리
│   ├── 07_oracle_adv_optimizer_rewrite/# 오라클 성능 고도화: 옵티마이저와 쿼리변환
│   ├── 08_oracle_adv_3_tuning_factors/# 오라클 성능 고도화: 데이터베이스 3대 튜닝요소
│   ├── 09_sql_expert_guide/           # SQL 전문가 가이드 (K-Data) (3개 실습)
│   ├── 10_practical_sql/              # 실용 SQL (Practical SQL) (3개 실습)
│   ├── 11_sql_recipes_data_analysis/  # 데이터 분석을 위한 SQL 레시피 (2개 실습)
│   ├── 12_learning_sql/               # 러닝 SQL (Learning SQL) (3개 실습)
│   ├── 13_sql_cookbook/               # SQL Cookbook (5대 DB 비교)
│   ├── 14_sql_antipatterns/           # SQL 안티패턴 (3개 실습)
│   ├── 15_real_mongodb/               # Real MongoDB (MQL & Aggregation) (3개 실습)
│   ├── 16_sqld_500/                   # SQL 개발자(SQLD) 기출문제 핵심 500제
│   ├── 17_sqlp_1/                     # SQLP 자격검정 실전문제 1
│   └── 18_sqlp_2/                     # SQLP 자격검정 실전문제 2
│
├── tips/                              # 💡 [버전관리] 치트시트, SQL 튜닝 방법론 및 핵심 스니펫 사전
│   ├── cheatsheet.md                  # [치트시트] 일상 학습용 전용 명령어·7단계 사이클·단축키 전용 문서
│   ├── sql_snippets.md                # 자동 추출된 57개의 핵심 SQL/NoSQL 모범 스니펫 사전
│   └── sql_tuning_pragmatic.md        # 인덱스·조인 튜닝 및 실행 계획 분석 실무 가이드
│
├── SQL-docs/                          # 📖 [참조자료/gitignore] 7대 DB 공식 매뉴얼 및 표준 가이드
│   ├── oracle/                        # Oracle SQL Reference & Concepts PDF
│   ├── mysql/                         # MySQL 8.4 LTS Reference Manual PDF
│   ├── postgresql/                    # PostgreSQL 17 공식 매뉴얼 PDF
│   ├── sqlite/                        # SQLite 공식 오프라인 문서 풀세트
│   ├── duckdb/                        # DuckDB Friendly SQL & PG 호환성 마크다운
│   ├── mongodb/                       # MongoDB SQL 매핑 및 집계 파이프라인
│   ├── mssql/                         # T-SQL 공식 매뉴얼 마크다운
│   └── standard-comparison/           # ANSI/ISO SQL 표준과 7대 DB 비교 가이드
│
└── contents/                          # 📚 [참조자료/gitignore] 개인 소장 18권 원문 전자책 PDF
```

---

## 3. 트리 노드별 상세 설계 의도 (Node-by-Node Architectural Intent)

### 3.1 루트 디렉터리 (Root Configuration)

| 파일 / 폴더 | 설계 의도 및 역할 | 다른 프로젝트 도입 시 참고 가이드 |
| :--- | :--- | :--- |
| `compose.yaml` / `docker-compose.yml` | • 로컬 OS에 DB 설치 없이 Podman(또는 Docker)을 통해 MySQL, PG, Mongo, Oracle 4대 컨테이너 즉시 구동<br/>• 독립된 포트 매핑(`13306`, `15432`, `27017`, `11521`) 및 볼륨 격리 | 다중 데이터베이스를 다룰 때는 호스트 기본 포트 충돌을 피하기 위해 10000번대 오프셋 포트를 할당할 것. |
| `PROJECT_STRUCTURE.md` | • 본 문서. 디렉터리의 물리적 구조뿐 아니라 "왜 이렇게 설계했는지" 의도와 규칙을 명시 | 팀원이나 AI 어시스턴트가 파일 위치를 임의로 변경하지 않도록 강력한 아키텍처 가드레일 역할을 수행. |
| `DATABASE_SYSTEMS.md` | • 7대 DBMS의 버전, 포트, 접속 URL, ANSI 표준 준수 여부 및 공식 문서 매핑<br/>• IDE를 거치지 않고도 각 DB 방언의 특징과 접속 정보를 즉시 확인 가능 | 다중 미들웨어/엔진 환경에서는 시스템 접속 정보와 스펙 문서를 반드시 단일 진실 공급원으로 색인화할 것. |
| `.gitignore` | • `contents/`(원문 PDF), `SQL-docs/`(대용량 매뉴얼), `practice/`(대량 생성 코드) 차단<br/>• 순수 설정 및 생성 엔진 코드만 Git으로 추적하여 저장소 용량을 초경량(수 MB) 유지 | 대량으로 자동 생성 가능한 산출물(Artifacts)은 절대 Git에 커밋하지 않고 생성 엔진만 추적할 것. |

---

### 3.2 `scripts/` (자동화 도구 및 툴체인 엔진)

저장소의 두뇌에 해당하는 디렉터리로, 모든 반복 작업을 완전 자동화합니다.

```mermaid
flowchart LR
    Data["content*_data/*.py<br/>(선언적 챕터 메타데이터)"] --> Generator["generate_content_*.py<br/>(스캐폴드 엔진)"]
    Generator --> Practice["practice/*<br/>(README + schema + main + test)"]
    Practice --> Runner["run.sh / test.sh<br/>(runner_core.py 디스패치)"]
```

* `runner_core.py` & `run.sh`:
  * 의도: 타겟 엔진 판별 및 스키마 자동 적재.
  * 실행 대상 폴더 내 `schema.sql`이 존재하면 먼저 DBMS로 전송하여 테이블과 데이터를 준비한 후 `main.sql`을 실행.
  * 파일 상단의 `-- @engine:` 태그 또는 경로를 분석하여 적절한 Podman 컨테이너(또는 로컬 SQLite/DuckDB)로 쿼리를 직결.
* `test.sh` & `test_all.sh`:
  * 의도: 단위 검증 파이프라인.
  * 각 실습 항목의 `test.sql`을 실행하여 반환 행 수나 단언 조건(`test_passed: 1`)이 만족되는지 0.1초 단위로 검증.
* `content01_data/` ~ `content18_data/`:
  * 의도: 데이터와 뷰(템플릿)의 완전한 분리.
  * 책의 제목, 절 번호, 페이지, 개념 해설, 사전 스키마(`schema_fixtures`), 완성 답안(`target_code`), 예상 출력, 스텝 주석을 파이썬 딕셔너리(`ITEMS = [...]`)로 완벽히 구조화.
* **`generate_content_*.py` & `generate_all.py`**:
  * 의도: 스캐폴드 멱등성(Idempotency) 및 유효성 전수 검증.
  * 사용자가 작성 중인 `main.sql`은 절대 덮어쓰지 않고 보존하며, `--force` 플래그 시에만 재생성.
  * `--verify` 옵션으로 18권 전 도서의 `target_code`와 `schema_fixtures`를 실제 엔진(또는 인메모리 파서)에 실행시켜 구문 오류를 전수 검사.

---

### 3.3 `practice/` (실습 및 학습 런타임 공간)

학습자가 매일 코드를 작성하고 실행 계획을 튜닝하는 실습 공간입니다.

* 표준 실습 항목 폴더 구성 (항목당 5개 파일 표준):
  ```text
  08_03_01_b_tree_range_scan/
  ├── README.md           # 개념 해설, 원서 출처(p.xx), 완성 목표 쿼리, 예상 실행 결과
  ├── schema.sql          # [자동생성] 사전 준비 테이블 DDL 및 샘플 INSERT 데이터
  ├── main.sql            # [학습자용] Step별 주석 가이드가 작성된 연습용 스켈레톤
  ├── test.sql            # [검증기] 결과 집합 단언 및 실행 계획 검증 쿼리
  └── expected_output.txt # 터미널 예상 출력 서식
  ```
* 의도:
  1. `README.md`와 `schema.sql`만으로 외부 데이터베이스 도움 없이 즉시 실행 가능한 자기완비형(Self-contained) 구조.
  2. `main.sql`에서 단계별 가이드를 보며 쿼리를 직접 손으로 타이핑하는 Active Learning 유도.
  3. `test.sql`로 인덱스 스캔 여부나 건수 일치 여부를 즉시 피드백.

* 학습자의 표준 7단계 실습 사이클 (Learner Workflow):
  1. 탐색 (Select): 학습할 도서/절 폴더 선택
  2. 이해 (Understand): `README.md`의 이론과 `schema.sql` 테이블 구조 정독
  3. 필사 (Clone-Typing): `main.sql`에 주석 가이드를 보며 쿼리 직접 타이핑
  4. 실행 (Run): `./scripts/run.sh <경로>` 로 자동 스키마 주입 후 결과 대조
  5. 검증 (Test): `./scripts/test.sh <경로>` 로 단언 쿼리(`test_passed: 1`) 검증
  6. 실험 (Experiment): 인덱스 변형, 조인 힌트 변경 후 실행계획(`EXPLAIN`) 분석
  7. 축적 (Archive): `-- @snippet(...)` 태그 추가 및 `./scripts/snippets.sh --export` 저장

---

### 3.4 `tips/` (치트시트, 튜닝 가이드 및 핵심 스니펫 사전)

학습자가 일상 학습 중 즉시 참조하고 실무 쿼리 작성 시 활용할 수 있는 지식 베이스 허브입니다.

* `tips/cheatsheet.md`:
  * 의도: 일상 학습자가 터미널 옆에 띄워두고 바로 보고 따라 할 수 있는 단일 전용 치트시트.
  * 7단계 실습 사이클, Podman 제어, 주요 DB CLI 접속, 18권 대표 실습 명령어, SQL 튜닝 치트키를 초압축 집약.
* `tips/sql_snippets.md`:
  * 의도: 18권 실습 코드 내 `-- @snippet(...)` 태그를 `snippets.sh`가 자동 수집하여 구축한 57개 핵심 SQL/NoSQL 패턴 사전.
* `tips/sql_tuning_pragmatic.md`:
  * 의도: 3단계 인덱스 튜닝 원칙, 조인 튜닝, 실행 계획(`EXPLAIN`) 분석 실무 가이드.

---

## 4. 다른 도서 및 신규 트랙 확장 방법론 (Blueprint Guide)

새로운 도서나 새로운 데이터베이스(예: Redis, Neo4j, Snowflake)로 트랙을 확장할 때 다음 4단계를 따릅니다:

```text
[Step 1] scripts/content_registry.py 에 신규 도서 등록
  └── ID, 슬러그, 도서명, 타겟 DBMS, PDF 파일명, 설명 추가

[Step 2] scripts/contentXX_data/ 에 선언적 메타데이터 작성
  └── 챕터별 num, slug, title, concept, schema_fixtures, target_code, test_code 정의

[Step 3] scripts/generate_content_XX.py 생성
  └── scaffold_engine.py 의 scaffold_content() 및 verify_content() 바인딩

[Step 4] python3 scripts/generate_all.py --verify 로 전수 검증
  └── 신규 실습 디렉터리가 100% 정상 작동하는지 일괄 검증
```

이 표준 아키텍처를 따르면 18권 이상의 도서와 수만 줄의 SQL이 누적되더라도 프로젝트가 복잡해지지 않고, 언제나 명확하고 가벼운 저장소 상태를 유지할 수 있습니다.
