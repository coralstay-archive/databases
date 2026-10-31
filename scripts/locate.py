#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/locate.py
실습 파일의 정확한 도서명, 몇 장, 몇 절, 몇 문단(항목/스텝), 페이지 번호, 타겟 DBMS를
동적으로 파싱하여 터미널에 구조화된 카드 형태로 출력하는 위치 색인 네비게이터.
(handcrafted-cpp 파이프라인 규격 100% 계승)

사용법:
  ./scripts/locate.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan/main.sql
  ./scripts/locate.sh "인덱스"                 # 키워드로 검색하여 위치 찾기
  ./scripts/locate.sh --tree                  # 18권 전 도서 마스터 목차 트리 보기
  ./scripts/locate.sh --tree real_mysql       # 특정 도서 목차 트리 필터링
  ./scripts/locate.sh --json <경로>           # JSON 형식 출력
"""

import argparse
import json
import os
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

REPO_ROOT = Path(__file__).resolve().parent.parent
PRACTICE_DIR = REPO_ROOT / "practice"

sys.path.insert(0, str(REPO_ROOT / "scripts"))
try:
    from content_registry import CONTENTS, get_content_by_path, get_content_by_slug
except ImportError:
    CONTENTS = []
    get_content_by_path = lambda p: None
    get_content_by_slug = lambda s: None


def clean_frontmatter(text: str) -> str:
    """프론트매터 및 주석 헤더를 정리하고 본문 텍스트를 반환합니다."""
    text = re.sub(r"^\s*<!--.*?-->\s*", "", text, flags=re.DOTALL)
    text = re.sub(r"^\s*--\s*=+\s*\n\s*--\s*@file:.*?\n\s*--\s*=+.*?\n", "", text, flags=re.DOTALL)
    return text.strip()


def parse_item_info(target_path: Path) -> Dict[str, Any]:
    """주어진 파일 또는 디렉터리 경로의 장, 절, 문단, 페이지, 스니펫 정보를 파싱합니다."""
    abs_target = target_path.resolve()
    if abs_target.is_file():
        item_dir = abs_target.parent
        active_file = abs_target
    else:
        item_dir = abs_target
        active_file = item_dir / "main.sql"
        if not active_file.exists():
            for cand in item_dir.glob("*.sql"):
                active_file = cand
                break
        if not active_file.exists():
            for cand in item_dir.glob("*.js"):
                active_file = cand
                break
        if not active_file.exists():
            active_file = item_dir / "README.md"

    abs_practice = PRACTICE_DIR.resolve()
    try:
        rel = item_dir.relative_to(abs_practice)
        parts = rel.parts
    except ValueError:
        rel = item_dir
        parts = rel.parts

    content_info = get_content_by_path(str(item_dir))
    content_title = content_info.title if content_info else "데이터베이스 & SQL 트랙"
    pdf_name = content_info.pdf_file if content_info else "-"
    dbms_engine = content_info.engine.upper() if content_info else "SQL"
    container_svc = content_info.container_service if content_info else "local"

    chapter_str = "-"
    section_str = "-"
    item_str = item_dir.name
    page_str = ""
    snippet_str = ""
    summary_str = ""

    if len(parts) >= 2:
        ch_folder = parts[1]
        ch_clean = re.sub(r"^\d+_", "", ch_folder)
        chapter_str = f"{ch_clean}"

    if len(parts) >= 3:
        it_folder = parts[2]
        item_str = it_folder

    readme_file = item_dir / "README.md"
    if readme_file.exists():
        try:
            content = readme_file.read_text(encoding="utf-8", errors="ignore")
            # 1. Title 및 페이지 추출: # [08_03_01] 8.3 B-Tree 인덱스 스캔 방식: 레인지 스캔 (p.215)
            h1_match = re.search(r"^#\s+\[(.*?)\]\s+(.*?)(?:\s+\(p\.?(\d+)\))?$", content, re.MULTILINE)
            if h1_match:
                title_text = h1_match.group(2).strip()
                if h1_match.group(3):
                    page_str = f"p.{h1_match.group(3)}"
                item_str = title_text

            # 2. 대단원 추출: > **대단원**: 8장. 인덱스
            ch_match = re.search(r">\s*\*\*대단원\*\*:\s*(.+)$", content, re.MULTILINE)
            if ch_match:
                chapter_str = ch_match.group(1).strip()

            # 3. 타겟 DBMS 추출
            db_match = re.search(r">\s*\*\*타겟 DBMS\*\*:\s*`?([A-Za-z0-9_]+)`?", content, re.MULTILINE)
            if db_match:
                dbms_engine = db_match.group(1).strip()

            # 4. 핵심 요약 (0. 핵심 개념 및 원리 첫 줄)
            concept_match = re.search(r"## 0\.\s*핵심 개념 및 원리\s*\n+-\s*(.+)$", content, re.MULTILINE)
            if concept_match:
                summary_str = concept_match.group(1).strip()
        except Exception:
            pass

    # main.sql 에서 @snippet 태그 추출
    if active_file.exists() and active_file.is_file():
        try:
            code_text = active_file.read_text(encoding="utf-8", errors="ignore")
            snip_match = re.search(r'@snippet\s*\(\s*["\']([^"\']+)["\']\s*\)', code_text)
            if not snip_match and readme_file.exists():
                r_text = readme_file.read_text(encoding="utf-8", errors="ignore")
                snip_match = re.search(r'@snippet\s*\(\s*["\']([^"\']+)["\']\s*\)', r_text)
            if snip_match:
                snippet_str = snip_match.group(1).strip()
        except Exception:
            pass

    rel_path_str = f"practice/{rel.as_posix()}" if not str(rel).startswith("practice") else str(rel)

    return {
        "content": content_title,
        "book": content_title,
        "pdf": pdf_name,
        "chapter": chapter_str,
        "section": section_str,
        "paragraph": item_str,
        "page": page_str,
        "dbms": dbms_engine,
        "container": container_svc,
        "snippet": snippet_str,
        "summary": summary_str,
        "rel_path": rel_path_str,
        "run_cmd": f"./scripts/run.sh {rel_path_str}",
        "test_cmd": f"./scripts/test.sh {rel_path_str}",
    }


def format_card(info: Dict[str, Any]) -> str:
    """터미널에 직관적인 카드 형식으로 출력합니다."""
    lines = [
        "==============================================================================",
        f" 🧭 [실습 위치 색인] {Path(info['rel_path']).name}",
        "==============================================================================",
        f" • 원서 / 도서 : {info['content']}" + (f"  [contents/{info['pdf']}]" if info['pdf'] and info['pdf'] != '-' else ""),
        f" • 대단원      : {info['chapter']}",
        f" • 문단 / 절   : {info['paragraph']}" + (f"  [원서 {info['page']}]" if info['page'] else ""),
        f" • 타겟 DBMS   : {info['dbms']} (컨테이너: {info['container']})",
    ]
    if info["snippet"]:
        lines.append(f" • 핵심 스니펫 : {info['snippet']}")
    if info["summary"]:
        lines.append(f" • 핵심 요약   : {info['summary']}")
    lines.extend([
        "------------------------------------------------------------------------------",
        f" • 실행 명령어 : {info['run_cmd']}",
        f" • 검증 명령   : {info['test_cmd']}",
        "==============================================================================",
    ])
    return "\n".join(lines)


def search_items(query: str, limit: int = 20) -> List[Dict[str, Any]]:
    """키워드로 practice 디렉터리 하위 실습 항목을 검색합니다."""
    terms = [t.lower() for t in query.split() if t.strip()]
    matches = []

    for root, dirs, files in os.walk(PRACTICE_DIR):
        if "main.sql" in files or "main.js" in files or "README.md" in files:
            p = Path(root)
            posix_path = p.as_posix().lower()

            # 파일 내용 읽기
            file_texts = []
            for fn in ("main.sql", "main.js", "README.md"):
                fp = p / fn
                if fp.exists():
                    try:
                        file_texts.append(fp.read_text(encoding="utf-8", errors="ignore").lower())
                    except Exception:
                        pass
            combined_text = posix_path + " " + " ".join(file_texts)

            # 모든 검색어 토큰이 포함되어 있는지 확인
            if all(term in combined_text for term in terms):
                matches.append(parse_item_info(p))
                if len(matches) >= limit:
                    break

    return matches


def print_tree(filter_term: Optional[str] = None):
    """18권 전 도서의 마스터 목차 트리를 출력합니다."""
    print("==============================================================================")
    print(" 📚 Databases & SQL 18권 전 도서 마스터 목차 트리 (Master Table of Contents)")
    print("==============================================================================")

    if not PRACTICE_DIR.exists():
        print("⚠️ practice 디렉터리가 비어 있습니다. 'python3 scripts/generate_all.py' 로 생성하세요.")
        return

    content_folders = sorted([p for p in PRACTICE_DIR.iterdir() if p.is_dir() and not p.name.startswith(".")])
    for cf in content_folders:
        content_info = get_content_by_slug(cf.name)
        title = content_info.title if content_info else cf.name
        dbms = content_info.engine.upper() if content_info else "SQL"
        if filter_term and filter_term.lower() not in cf.name.lower() and filter_term.lower() not in title.lower():
            continue

        item_count = sum(1 for _ in cf.rglob("main.sql")) + sum(1 for _ in cf.rglob("main.js"))
        print(f"\n📁 [{cf.name}] {title} (타겟: {dbms}, 총 {item_count}개 실습)")
        for ch in sorted(cf.iterdir()):
            if not ch.is_dir() or ch.name.startswith("."):
                continue
            ch_items = sum(1 for _ in ch.rglob("main.sql")) + sum(1 for _ in ch.rglob("main.js"))
            print(f"  └── 📖 {ch.name} ({ch_items}개 절)")
    print("\n==============================================================================")


def main():
    parser = argparse.ArgumentParser(description="실습 파일의 도서명, 몇 장, 몇 절, 몇 문단/항목을 출력하는 네비게이터")
    parser.add_argument("target", nargs="?", help="조회할 파일/폴더 경로 또는 검색 키워드")
    parser.add_argument("--tree", nargs="?", const="ALL", help="목차 트리 출력 (옵션: 특정 도서명/슬러그)")
    parser.add_argument("--list", nargs="?", const="ALL", help="목차 트리 목록 출력 (--tree 별칭)")
    parser.add_argument("--json", action="store_true", help="결과를 JSON 형식으로 출력")

    args = parser.parse_args()

    tree_arg = args.tree or args.list
    if tree_arg:
        filter_val = None if tree_arg == "ALL" else tree_arg
        print_tree(filter_val)
        return

    if not args.target:
        parser.print_help()
        sys.exit(0)

    target_path = Path(args.target)
    if target_path.exists():
        info = parse_item_info(target_path)
        if args.json:
            print(json.dumps(info, ensure_ascii=False, indent=2))
        else:
            print(format_card(info))
        return

    # 키워드 검색 수행
    matches = search_items(args.target)
    if not matches:
        print(f"❌ 검색어 '{args.target}' 에 일치하는 실습 항목을 찾을 수 없습니다.")
        sys.exit(1)

    if args.json:
        print(json.dumps(matches, ensure_ascii=False, indent=2))
        return

    print(f"🔍 검색어 '{args.target}' 검색 결과: 총 {len(matches)}개 발견\n")
    for idx, m in enumerate(matches, 1):
        print(format_card(m))
        if idx < len(matches):
            print()


if __name__ == "__main__":
    main()
