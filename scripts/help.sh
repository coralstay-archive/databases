#!/usr/bin/env bash
set -euo pipefail

cat << 'EOF'
======================================================================
 🛠️  Databases & SQL 통합 치트시트 (Podman & stoneCpp 학습법)
======================================================================

🔄 [학습자의 7단계 실습 사이클 (stoneCpp 클론 타이핑 워크플로우)]
   [1] 탐색 (Select)      : practice/<도서>/<단원>/<절> 폴더로 이동
   [2] 이해 (Understand)  : README.md 의 이론 해설과 schema.sql DDL/Mock Data 정독
   [3] 필사 (Clone-Type)  : main.sql 의 단계별 주석 가이드를 보며 쿼리 직접 타이핑
   [4] 실행 (Run & Check) : ./scripts/run.sh <경로> 실행 후 터미널 출력과 예상 결과 대조
   [5] 검증 (Assert)      : ./scripts/test.sh <경로> 로 단언 쿼리(test_passed: 1) 검증
   [6] 실험 (Experiment)  : 인덱스 무효화, 힌트 변경 후 실행계획(EXPLAIN) 변화 분석
   [7] 축적 (Archive)     : -- @snippet("설명") 달고 ./scripts/snippets.sh --export

----------------------------------------------------------------------
1. 컨테이너 인프라 관리 (Podman Compose)
   # 최초 1회 설치 및 머신 초기화 (macOS)
   brew install podman podman-compose
   ./scripts/db.sh machine init       # Podman VM 초기화 (2 CPU, 4GB RAM, 50GB Disk)
   ./scripts/db.sh machine start      # Podman VM 가동

   # 컨테이너 제어
   ./scripts/db.sh up                 # MySQL, PostgreSQL, MongoDB, Oracle 시작
   ./scripts/db.sh down               # 컨테이너 종료
   ./scripts/db.sh status             # 실행 상태 및 포트 점검
   ./scripts/db.sh cli mysql          # MySQL 대화형 CLI 접속 (practice/practice)
   ./scripts/db.sh cli postgres       # PostgreSQL psql 접속 (postgres/root)
   ./scripts/db.sh cli mongo          # MongoDB mongosh 접속 (root/root)
   ./scripts/db.sh cli oracle         # Oracle sqlplus 접속 (practice/practice)

----------------------------------------------------------------------
2. 단일 실습 항목 즉시 실행 (schema.sql 자동 적재 후 main.sql 실행)
   ./scripts/run.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan
   ./scripts/run.sh practice/03_friendly_sql_tuning/03_인덱스_스캔_효율화/03_03_01_index_seek_and_scan
   ./scripts/run.sh practice/10_practical_sql/05_수학과_통계_함수/05_02_01_aggregate_and_window_functions
   ./scripts/run.sh practice/13_sql_cookbook/03_다중_테이블_작업/03_05_01_outer_join_and_coalesce
   ./scripts/run.sh practice/15_real_mongodb/03_aggregation/03_01_01_aggregation_group_and_sort

----------------------------------------------------------------------
3. 단일 및 전체 실습 항목 단위 검증 실행 (test.sql 단언 검증)
   ./scripts/test.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan
   ./scripts/test_all.sh              # 18개 전 도서 실습 항목(57개) 일괄 테스트 검증

----------------------------------------------------------------------
4. @snippet 태그 추출 · 검색 · 마크다운 레퍼런스 내보내기
   ./scripts/snippets.sh              # 등록된 모든 스니펫 코드 전체 출력
   ./scripts/snippets.sh "인덱스"      # 키워드 검색 (인덱스, CTE, 힌트 등)
   ./scripts/snippets.sh --list       # 요약 목록만 보기
   ./scripts/snippets.sh --export     # tips/sql_snippets.md 마크다운 문서로 자동 저장

----------------------------------------------------------------------
5. 18권 도서 실습 스캐폴딩 생성 및 전수 구문 검증
   python3 scripts/generate_all.py          # 18권 전 도서 스캐폴딩 일괄 생성 (기존 작성 main.sql 보존)
   python3 scripts/generate_all.py --verify # 18권 전 도서 모범 쿼리 전수 유효성 검증 (100% PASS)
   python3 scripts/generate_content_01.py --verify # 개별 도서 모범 쿼리 유효성 검증

----------------------------------------------------------------------
6. 도서 목차 OCR 및 텍스트 자동 추출 (macOS Apple Vision OCR)
   ./scripts/ocr_pdf contents/친절한-SQL-튜닝.pdf /tmp/ocr_out 1 20

======================================================================
📖 핵심 문서 안내
 • tips/cheatsheet.md         : [치트시트] 일상 학습용 전용 명령어·7단계 사이클·단축키
 • README.md                  : 프로젝트 전체 개요, 18권 트랙 분류표, 퀵스타트
 • PROJECT_STRUCTURE.md       : stoneCpp 아키텍처 사상 계승 명세서, 폴더별 설계 의도
 • DATABASE_SYSTEMS.md        : 7대 DBMS 환경 설정, 포트/계정, SQL 방언 비교 매트릭스
 • tips/sql_tuning_pragmatic.md : 3단계 인덱스 튜닝, 조인 튜닝, 실행 계획 분석 가이드
 • tips/sql_snippets.md       : 57개 핵심 SQL/NoSQL 모범 스니펫 사전
======================================================================
EOF
