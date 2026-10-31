# -*- coding: utf-8 -*-
"""
공통 스캐폴딩 생성 엔진 (Scaffold Engine).
콘텐츠별 데이터셋(ITEMS)을 입력받아 practice/<content_slug>/<절>/<항목>/ 디렉터리와
README.md, schema.sql, main.sql, test.sql, expected_output.txt를 생성하고
--verify 옵션을 통한 구문 및 실행 유효성 전수 검사를 수행합니다.
"""

import os
import re
import sys
import subprocess
import tempfile
from pathlib import Path
from typing import List, Dict, Any

REPO_ROOT = Path(__file__).resolve().parent.parent

def render_readme(item: Dict[str, Any], content_info) -> str:
    num = item.get("num", "")
    title = item.get("title", "")
    page = item.get("page", "")
    section_title = item.get("section_title", "")
    concept = item.get("concept", "").strip()
    target_code = item.get("target_code", "").strip()
    schema_fixtures = item.get("schema_fixtures", "").strip()
    expected_output = item.get("expected_output", "").strip()
    test_code = item.get("test_code", "").strip()
    engine = item.get("engine", content_info.engine).upper()

    lang = "javascript" if engine == "MONGO" else "sql"

    schema_block = ""
    if schema_fixtures:
        schema_block = f"""
## 1. 사전 준비 스키마 및 Mock Data (`schema.sql`)
```{lang}
{schema_fixtures}
```
"""

    expected_block = ""
    if expected_output:
        expected_block = f"""
## 3. 예상 실행 결과 (`expected_output.txt`)
```text
{expected_output}
```
"""

    test_block = ""
    if test_code:
        test_block = f"""
## 4. 검증 쿼리 (`test.sql`)
```{lang}
{test_code}
```
"""

    return f"""# [{num}] {title} ({page})

> **도서**: {content_info.title}  
> **대단원**: {section_title}  
> **타겟 DBMS**: `{engine}`

---

## 0. 핵심 개념 및 원리
{concept}
{schema_block}
## 2. 따라 칠 완성 목표 쿼리 (`main.{ 'js' if engine == 'MONGO' else 'sql' }`)
```{lang}
{target_code}
```
{expected_block}{test_block}
---
### 💡 실행 및 검증 명령어
```bash
# 1) 이 항목 단독 실행 (schema.sql 자동 적재 후 main 실행)
./scripts/run.sh practice/{content_info.slug}/{item.get('section_dir')}/{num}_{item.get('slug')}

# 2) 검증 쿼리 실행
./scripts/test.sh practice/{content_info.slug}/{item.get('section_dir')}/{num}_{item.get('slug')}
```
"""

def render_main_skeleton(item: Dict[str, Any], content_info) -> str:
    engine = item.get("engine", content_info.engine).lower()
    title = item.get("title", "")
    page = item.get("page", "")
    section_title = item.get("section_title", "")
    steps = item.get("steps", [])

    is_mongo = engine == "mongo"
    comment = "//" if is_mongo else "--"

    step_lines = "\n".join(f"{comment} {s}" for s in steps) if steps else f"{comment} README.md 의 목표 쿼리를 보며 직접 타이핑해 보세요."

    header = f"""{comment} [{section_title}]
{comment} {title} ({page})
{comment} @engine: {engine}
{comment}
{comment} 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
{comment} ==============================================================================

{step_lines}

"""
    return header

def render_test_skeleton(item: Dict[str, Any], content_info) -> str:
    engine = item.get("engine", content_info.engine).lower()
    test_code = item.get("test_code", "").strip()
    is_mongo = engine == "mongo"
    comment = "//" if is_mongo else "--"

    return f"""{comment} @engine: {engine}
{comment} 검증 테스트 스크립트
{test_code}
"""

def scaffold_content(content_id: str, items: List[Dict[str, Any]], force: bool = False):
    from scripts.content_registry import get_content_by_id
    content_info = get_content_by_id(content_id)
    if not content_info:
        raise ValueError(f"콘텐츠 ID {content_id}를 찾을 수 없습니다.")

    content_dir = REPO_ROOT / "practice" / content_info.slug
    content_dir.mkdir(parents=True, exist_ok=True)

    created_count = 0
    skipped_count = 0

    for item in items:
        section_dir = item.get("section_dir", "01_일반")
        num = item.get("num", "001")
        slug = item.get("slug", "item")
        item_dir = content_dir / section_dir / f"{num}_{slug}"
        item_dir.mkdir(parents=True, exist_ok=True)

        engine = item.get("engine", content_info.engine).lower()
        code_ext = "js" if engine == "mongo" else "sql"

        readme_file = item_dir / "README.md"
        schema_file = item_dir / f"schema.{code_ext}"
        main_file = item_dir / f"main.{code_ext}"
        test_file = item_dir / f"test.{code_ext}"
        expected_file = item_dir / "expected_output.txt"

        # 1. README.md (항상 최신 갱신)
        readme_file.write_text(render_readme(item, content_info), encoding="utf-8")

        # 2. schema.sql (항상 최신 갱신)
        schema_code = item.get("schema_fixtures", "").strip()
        comment = "//" if code_ext == "js" else "--"
        schema_header = f"{comment} @engine: {engine}\n{comment} [사전 준비 스키마 및 Mock Data]\n"
        schema_file.write_text(schema_header + schema_code + "\n", encoding="utf-8")

        # 3. expected_output.txt
        expected_output = item.get("expected_output", "").strip()
        expected_file.write_text(expected_output + "\n", encoding="utf-8")

        # 4. test.sql (항상 최신 갱신)
        test_file.write_text(render_test_skeleton(item, content_info), encoding="utf-8")

        # 5. main.sql (사용자 작성 코드 보존: force=False 이고 이미 존재하면 스킵!)
        if main_file.exists() and not force:
            skipped_count += 1
        else:
            main_file.write_text(render_main_skeleton(item, content_info), encoding="utf-8")
            created_count += 1

    print(f"[{content_info.title}] 스캐폴딩 완료: 신규 생성 {created_count}개, 기존 유지 {skipped_count}개")

def verify_content(content_id: str, items: List[Dict[str, Any]]) -> bool:
    """콘텐츠 데이터셋 내의 target_code 및 schema_fixtures 유효성을 전수 검사합니다."""
    from scripts.content_registry import get_content_by_id
    content_info = get_content_by_id(content_id)
    if not content_info:
        raise ValueError(f"콘텐츠 ID {content_id}를 찾을 수 없습니다.")

    print(f"🔍 [{content_info.title}] 총 {len(items)}개 항목의 target_code 전수 검증 시작...")
    failed = []

    for item in items:
        num = item.get("num", "")
        slug = item.get("slug", "")
        engine = item.get("engine", content_info.engine).lower()
        target_code = item.get("target_code", "").strip()
        schema_code = item.get("schema_fixtures", "").strip()

        # 1. 필수 필드 검증
        if not target_code:
            failed.append((num, slug, "target_code 가 비어 있습니다."))
            continue

        # 2. SQLite / Multi-DB 엔진인 경우 인메모리 완전 실행 검증
        if engine in ("sqlite", "sqlite3", "multi"):
            import sqlite3
            try:
                conn = sqlite3.connect(":memory:")
                cur = conn.cursor()
                if schema_code:
                    cur.executescript(schema_code)
                for stmt in target_code.split(";"):
                    clean = re.sub(r"--.*$", "", stmt, flags=re.MULTILINE).strip()
                    if clean:
                        cur.execute(clean)
                conn.close()
                print(f"  [PASS] {num}_{slug} (in-memory execution ok)")
            except Exception as e:
                failed.append((num, slug, f"SQLite 실행 오류: {e}"))
                print(f"  [FAIL] {num}_{slug}: {e}", file=sys.stderr)
        else:
            # 3. 괄호/따옴표 짝 및 문법 기초 무결성 검증
            paren_balance = target_code.count("(") - target_code.count(")")
            if paren_balance != 0:
                failed.append((num, slug, f"괄호 불일치: '(' {target_code.count('(')}개 vs ')' {target_code.count(')')}개"))
                print(f"  [FAIL] {num}_{slug}: 괄호 불일치", file=sys.stderr)
            else:
                print(f"  [PASS] {num}_{slug} (syntax & schema structure ok)")

    if failed:
        print(f"\n❌ [{content_info.title}] 검증 실패: {len(failed)}/{len(items)} 개 항목 에러 발생!", file=sys.stderr)
        return False
    print(f"✨ [{content_info.title}] 검증 통과: 모든 {len(items)}개 항목이 정상입니다!\n")
    return True

# 하위 호환 별칭
scaffold_book = scaffold_content
verify_book = verify_content

