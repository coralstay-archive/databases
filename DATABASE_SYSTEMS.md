# 🧭 7대 데이터베이스 시스템 및 SQL 표준 매핑 인덱스 (Database Systems Index)

> ⚙️ **이 문서는 본 저장소에서 지원하는 7대 데이터베이스(MySQL, PostgreSQL, Oracle, MongoDB, SQLite, DuckDB, MSSQL)의 런타임 환경, 접속 정보, 공식 문서 위치, SQL 표준 호환성 매트릭스를 단일 진실 공급원(SSOT)으로 정의한 색인 명세서입니다.**

---

## 1. 런타임 환경 및 컨테이너 접속 명세

| DBMS | 역할 / 분류 | 실행 환경 | 호스트 포트 | 기본 계정 | 비밀번호 | 기본 데이터베이스 (SID/PDB) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **MySQL 8.4 LTS** | 오픈소스 웹 표준 RDBMS | Podman / Compose (`mysql`) | `13306` | `practice` | `practice` | `practice_db` |
| **PostgreSQL 17** | 표준 준수율 최고 오픈소스 RDBMS | Podman / Compose (`postgres`) | `15432` | `postgres` | `root` | `practice_db` |
| **Oracle 23ai Free** | 엔터프라이즈 대표 RDBMS | Podman / Compose (`oracle`) | `11521` | `practice` | `practice` | `FREEPDB1` |
| **MongoDB 7.0** | NoSQL 도큐먼트 표준 | Podman / Compose (`mongo`) | `27017` | `root` | `root` | `practice_db` |
| **SQLite 3.54** | 경량 인메모리 / 파일 OLTP | 로컬 네이티브 / Python | N/A | N/A | N/A | `:memory:` (또는 `.db` 파일) |
| **DuckDB** | 고속 컬럼 지향 OLAP | 로컬 네이티브 / Python | N/A | N/A | N/A | `:memory:` (또는 `.duckdb` 파일) |
| **MS SQL Server** | 엔터프라이즈 T-SQL RDBMS | 레퍼런스 문서 중심 | `1433` | `sa` | `YourPassword123` | `master` |

---

## 2. 공식 문서 아카이브 매핑 (`SQL-docs/`)

인터넷 연결이 없는 환경에서도 로컬에서 즉시 공식 레퍼런스를 참조할 수 있도록 원문 문서가 보관되어 있습니다.

* **Oracle Database**:
  * SQL 언어 레퍼런스: [`SQL-docs/oracle/oracle-sql-language-reference.pdf`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/oracle/oracle-sql-language-reference.pdf)
  * 데이터베이스 핵심 개념: [`SQL-docs/oracle/oracle-19c-database-concepts.pdf`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/oracle/oracle-19c-database-concepts.pdf)
* **MySQL 8.4 LTS**:
  * 공식 레퍼런스 매뉴얼 전체: [`SQL-docs/mysql/mysql-8.4-refman-a4.pdf`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/mysql/mysql-8.4-refman-a4.pdf)
* **PostgreSQL 17**:
  * 공식 전체 문서: [`SQL-docs/postgresql/postgresql-17-A4.pdf`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/postgresql/postgresql-17-A4.pdf)
* **SQLite 3**:
  * 오프라인 HTML/CSS 문서 전체: [`SQL-docs/sqlite/`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/sqlite)
* **DuckDB**:
  * 개요: [`SQL-docs/duckdb/00-duckdb-overview-llms.txt`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/duckdb/00-duckdb-overview-llms.txt)
  * Friendly SQL 가이드: [`SQL-docs/duckdb/02-friendly-sql.md`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/duckdb/02-friendly-sql.md)
  * PostgreSQL 호환성: [`SQL-docs/duckdb/03-postgresql-compatibility.md`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/duckdb/03-postgresql-compatibility.md)
* **MongoDB**:
  * SQL to MongoDB 매핑: [`SQL-docs/mongodb/01-sql-to-mongodb-mapping.txt`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/mongodb/01-sql-to-mongodb-mapping.txt)
  * Aggregation 파이프라인 비교: [`SQL-docs/mongodb/02-sql-aggregation-comparison.txt`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/mongodb/02-sql-aggregation-comparison.txt)
* **MS SQL Server (T-SQL)**:
  * T-SQL 언어 레퍼런스: [`SQL-docs/mssql/01-t-sql-language-reference.md`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/mssql/01-t-sql-language-reference.md)
  * 쿼리 및 연산자: [`SQL-docs/mssql/02-t-sql-queries.md`](file:///Users/flynn_macpro/githubs/databases/SQL-docs/mssql/02-t-sql-queries.md)

---

## 3. 핵심 SQL 문법 및 방언(Dialect) 상호 비교 매트릭스

| 문법 항목 | ANSI/ISO 표준 SQL | MySQL 8.0+ | PostgreSQL 17 | Oracle (19c/21c/23ai) | SQLite / DuckDB |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Top-N / 페이징** | `FETCH FIRST n ROWS ONLY` | `LIMIT n OFFSET m` | `LIMIT n OFFSET m` / `FETCH FIRST` | `ROWNUM <= n` / `FETCH FIRST` (12c+) | `LIMIT n OFFSET m` |
| **계층형 쿼리** | `WITH RECURSIVE` | `WITH RECURSIVE` (8.0+) | `WITH RECURSIVE` | `START WITH ... CONNECT BY PRIOR` / `WITH` | `WITH RECURSIVE` |
| **Upsert (삽입/갱신)** | `MERGE INTO ...` | `ON DUPLICATE KEY UPDATE` | `ON CONFLICT (...) DO UPDATE` | `MERGE INTO ...` | `ON CONFLICT (...) DO UPDATE` |
| **문자열 결합** | `col1 \|\| col2` | `CONCAT(col1, col2)` | `col1 \|\| col2` | `col1 \|\| col2` | `col1 \|\| col2` |
| **NULL 치환 함수** | `COALESCE(val, alt)` | `IFNULL(val, alt)` / `COALESCE` | `COALESCE(val, alt)` | `NVL(val, alt)` / `COALESCE` | `IFNULL` / `COALESCE` |
| **실행 계획 확인** | EXPLAIN (표준 비권고) | `EXPLAIN FORMAT=TREE` / `EXPLAIN ANALYZE` | `EXPLAIN (ANALYZE, BUFFERS)` | `EXPLAIN PLAN FOR` + `DBMS_XPLAN` | `EXPLAIN QUERY PLAN` |
| **정규식 함수** | 표준 미지정 | `REGEXP_LIKE` | `~`, `REGEXP_MATCHES` | `REGEXP_LIKE`, `REGEXP_SUBSTR` | `REGEXP` 연산자 |

---

## 4. 원클릭 CLI 접속 치트시트

```bash
# 1. MySQL 대화형 CLI 접속
./scripts/db.sh cli mysql
# (컨테이너 내부 직접 접속: Podman Compose)
podman compose exec -it mysql mysql -u practice -ppractice practice_db

# 2. PostgreSQL psql 접속
./scripts/db.sh cli postgres
# (컨테이너 내부 직접 접속: Podman Compose)
podman compose exec -it postgres psql -U postgres -d practice_db

# 3. Oracle sqlplus 접속
./scripts/db.sh cli oracle
# (컨테이너 내부 직접 접속: Podman Compose)
podman compose exec -it oracle sqlplus practice/practice@//localhost:1521/FREEPDB1

# 4. MongoDB mongosh 접속
./scripts/db.sh cli mongo
# (컨테이너 내부 직접 접속: Podman Compose)
podman compose exec -it mongo mongosh -u root -p root practice_db
```
