# databases AI Pair-Programming Guidelines & Agent Memory

## 🎯 1. 프로젝트 목적 및 핵심 워크플로우

`databases`는 18개 데이터베이스 및 SQL 도서, 총 57개 이상의 실습 항목을 직접 손으로 빚어 타이핑하고(Handcrafted) 스키마를 자동 적재하여 즉시 실행·검증하는 데이터베이스 엔지니어링 실습 저장소입니다.

### 사용자 프롬프트 대응 원칙 (Memory Trigger)
사용자가 "어떻게 사용하지?", "어떻게 해야해?", "실습 순서 알려줘", "어떻게 실습해?" 와 같이 사용법이나 워크플로우를 질문하면, [PRACTICE_GUIDE.md](file:///Users/flynn_macpro/githubs/databases/PRACTICE_GUIDE.md)를 기반으로 다음 실전 폐쇄 루프 사이클(Closed-Loop Cycle)을 즉시 안내하세요:

1. 📖 1단계: 교안을 핀다 (어디를 펼칠까?)
   - `./scripts/locate.sh <키워드>` 로 어느 책 몇 장 몇 절 몇 페이지인지 실시간 색인 확인
   - `contents/` 또는 `SQL-docs/` 내 해당 도서 PDF나 실물 책의 해당 페이지 열람
2. ⌨️ 2단계: 타이핑을 한다 (어디에 어떻게 칠까?)
   - 항상 프로젝트 최상위 루트(`databases/`) 터미널 유지 (하위 폴더 이동 금지)
   - `practice/` 하위 해당 폴더의 `main.sql`을 열어 주석 스켈레톤 보며 직접 손으로 한 글자씩 코딩
3. ⚡ 3단계: 어떠어떠한 쉘들을 실행할까?
   - `./scripts/run.sh <경로>`: 단일 파일 0.1초 고속 단독 실행 및 터미널 ASCII 표 출력 대조 (`Tab` 키로 경로 자동완성)
   - `./scripts/test.sh <경로>`: 0.1초 Fast-path 정답 자동 검증 (`test_passed: 1` 확인)
   - `./scripts/db.sh cli <엔진>`: 헷갈리거나 에러 발생 시 해당 DBMS의 대화형 CLI 즉시 접속 (MySQL, PostgreSQL, Mongo, Oracle)
4. 🐞 3.5단계: 문제 발생 시 실행계획(`EXPLAIN`) 및 CLI 디버그
   - 실행 계획 확인: `EXPLAIN FORMAT=TREE` (MySQL), `EXPLAIN PLAN` (Oracle), `EXPLAIN (ANALYZE, BUFFERS)` (PostgreSQL)
5. 🏷️ 4단계: 좋은 코드는 스니펫으로 등록한다 (어디에 저장되나?)
   - 쿼리 위에 `-- @snippet("설명")` 태그 추가
   - `./scripts/snippets.sh --export` 로 내보내기 ➔ `tips/snippets.md` 및 `tips/snippets_registry.json`에 영구 저장 (도서 출처 자동 인용)
   - `./scripts/snippets.sh --export-blog` 로 내보내기 ➔ **`tips/posts/*.md`**에 GitHub Pages/Jekyll 호환 독립 포스트 개별 발행
6. 🔍 5단계: 사람이 검증했는지 안 했는지 확인하고 기록한다
   - `./scripts/snippets.sh --status`: 검증 상태 대시보드 조회 (🟢 `VERIFIED`, 🟡 `PENDING_REVIEW`, 🔴 `OUTDATED`)
   - `./scripts/snippets.sh --verify "<제목>" --reviewer "<이름>" --notes "<메모>"`: 사람이 직접 검증 완료 승인 및 KST 타임스탬프/해시 고정
   - 원본 코드가 1바이트라도 수정되면 SHA-256 해시 비교로 자동으로 🔴 `OUTDATED`로 격하되어 재검증을 유도

---

## 🛠️ 2. 주요 스크립트 툴체인 요약
- `./scripts/locate.sh <키워드/경로>`: 어느 책 몇 장 몇 절 몇 페이지인지 실시간 색인
- `./scripts/locate.sh --tree`: 18권 전 도서 마스터 목차 트리 출력
- `./scripts/run.sh <항목경로>`: 스키마 자동 주입 후 단일 쿼리 0.1초 실행 (Tab 자동완성 지원)
- `./scripts/test.sh <항목경로>`: 단일 쿼리 Fast-path 자동 채점 (`test_passed: 1` 검증)
- `./scripts/test_all.sh`: 18권 전 도서 57개 항목 일괄 테스트 러너
- `./scripts/db.sh`: OrbStack 및 Podman 컨테이너 라이프사이클 관리 도구 (up/down/orb/machine/cli)
- `./scripts/snippets.sh`: 스니펫 검색, 추출, 사람 검증, 도서 출처 인용 및 기술 블로그 포스트 발행
- `./scripts/generate_all.py --verify`: 18권 전 도서 실습 쿼리 유효성 전수 검증기
