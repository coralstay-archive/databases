#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
scripts/snippets.py
Database & SQL Snippet Manager.
practice/ 및 SQL-docs/ 디렉터리 내에서 @snippet 태그가 붙은 쿼리, 인덱스 힌트, 함수, DDL 패턴을
추출·검색·문서화하고 사람의 단위 검증(Human Verification) 이력과 타임스탬프를 관리하는 도구.
(handcrafted-cpp 파이프라인 규격 100% 계승)

사용법:
  ./scripts/snippets.sh                  # 등록된 모든 SQL 스니펫 출력
  ./scripts/snippets.sh <키워드>         # 키워드로 검색 (인덱스, 힌트, CTE 등)
  ./scripts/snippets.sh --list           # 요약 목록만 보기
  ./scripts/snippets.sh --status         # 사람 검증 상태 대시보드 요약 (VERIFIED / PENDING / OUTDATED)
  ./scripts/snippets.sh --verify <제목>  # 사람이 직접 검증 완료 승인 및 해시 영구 박제
  ./scripts/snippets.sh --export         # tips/snippets.md 로 마크다운 문서 및 검증 대시보드 내보내기
  ./scripts/snippets.sh --export-blog    # tips/posts/ 에 기술 블로그 포스트 개별 생성
"""

import argparse
import datetime
import hashlib
import json
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple

REPO_ROOT = Path(__file__).resolve().parent.parent
TIPS_DIR = REPO_ROOT / "tips"
REGISTRY_REL_PATH = TIPS_DIR / "snippets_registry.json"
POSTS_DIR = TIPS_DIR / "posts"

sys.path.insert(0, str(REPO_ROOT / "scripts"))
try:
    import locate
except ImportError:
    locate = None

SNIPPET_TAG_RE = re.compile(
    r'(?:--|//|/\*)\s*@snippet(?:\s*\((?P<arg>(?:[^()\\]|\\.|"[^"]*"|\'[^\']*\')*)\))?'
)


@dataclass
class SqlSnippet:
    rel_path: str
    abs_path: str
    line_num: int
    title: str
    engine: str
    code: str

    @property
    def code_hash(self) -> str:
        return hashlib.sha256(self.code.strip().encode("utf-8")).hexdigest()[:12]

    @property
    def symbol(self) -> str:
        return self.title


def load_registry() -> Dict[str, Any]:
    """검증 레지스트리 JSON을 로드합니다."""
    if not REGISTRY_REL_PATH.exists():
        return {}
    try:
        return json.loads(REGISTRY_REL_PATH.read_text(encoding="utf-8"))
    except Exception:
        return {}


def save_registry(data: Dict[str, Any]):
    """검증 레지스트리 JSON을 저장합니다."""
    TIPS_DIR.mkdir(parents=True, exist_ok=True)
    REGISTRY_REL_PATH.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")


def parse_snippets_from_file(file_path: Path) -> List[SqlSnippet]:
    snippets = []
    try:
        lines = file_path.read_text(encoding="utf-8", errors="ignore").splitlines()
    except Exception:
        return []

    file_engine = "SQL"
    for line in lines[:15]:
        m_eng = re.search(r"@engine:\s*([a-zA-Z0-9_]+)", line)
        if m_eng:
            file_engine = m_eng.group(1).upper()
            break

    i = 0
    while i < len(lines):
        line = lines[i]
        m = SNIPPET_TAG_RE.search(line)
        if m:
            arg = m.group("arg") or ""
            title = arg.strip(' "\'').strip() or "SQL Snippet"
            start_line = i + 1

            code_lines = []
            j = i + 1
            while j < len(lines):
                cur = lines[j]
                if SNIPPET_TAG_RE.search(cur):
                    break
                code_lines.append(cur)
                if cur.rstrip().endswith(";") and len(code_lines) >= 1:
                    j += 1
                    break
                j += 1

            code = "\n".join(code_lines).strip()
            if code:
                snippets.append(
                    SqlSnippet(
                        rel_path=str(file_path.relative_to(REPO_ROOT)),
                        abs_path=str(file_path.resolve()),
                        line_num=start_line,
                        title=title,
                        engine=file_engine,
                        code=code,
                    )
                )
            i = j
        else:
            i += 1

    return snippets


def collect_all_snippets() -> List[SqlSnippet]:
    all_snippets = []
    scan_dirs = [REPO_ROOT / "practice", REPO_ROOT / "SQL-docs"]
    seen_hashes: Set[str] = set()

    for sdir in scan_dirs:
        if not sdir.exists():
            continue
        for ext in ("*.sql", "*.js", "*.md"):
            for f in sdir.rglob(ext):
                # README.md 와 main.sql 이 중복 스니펫을 가질 수 있으므로 main.sql 우선 수집
                parsed = parse_snippets_from_file(f)
                for snip in parsed:
                    key = f"{snip.title}:{snip.code_hash}"
                    if key not in seen_hashes:
                        seen_hashes.add(key)
                        all_snippets.append(snip)
    return all_snippets


def get_status_info(snip: SqlSnippet, reg: Dict[str, Any]) -> Tuple[str, str, Optional[Dict[str, Any]]]:
    """스니펫의 검증 상태(VERIFIED, PENDING_REVIEW, OUTDATED)를 반환합니다."""
    entry = reg.get(snip.symbol)
    if not entry:
        return "PENDING_REVIEW", "🟡 미검증 (Pending)", None

    if entry.get("code_hash") == snip.code_hash:
        return "VERIFIED", "🟢 사람 검증 완료 (Verified)", entry
    else:
        return "OUTDATED", "🔴 코드 수정 감지 (Outdated)", entry


def show_status():
    """스니펫 검증 상태 대시보드를 터미널에 출력합니다."""
    snippets = collect_all_snippets()
    reg = load_registry()

    verified_count = 0
    pending_count = 0
    outdated_count = 0

    print("==============================================================================")
    print(" 🛡️  Databases & SQL 스니펫 사람 검증(Human Verification) 대시보드")
    print("==============================================================================")

    for snip in snippets:
        code, label, entry = get_status_info(snip, reg)
        if code == "VERIFIED":
            verified_count += 1
            rev = entry.get("reviewer", "Unknown") if entry else ""
            ts = entry.get("verified_at", "") if entry else ""
            print(f" {label} : {snip.title} (검증자: {rev}, {ts})")
        elif code == "OUTDATED":
            outdated_count += 1
            print(f" {label} : {snip.title} (기존 해시 불일치: 재검증 필요)")
        else:
            pending_count += 1
            print(f" {label} : {snip.title}")

    total = len(snippets)
    rate = (verified_count / total * 100) if total > 0 else 0.0
    print("------------------------------------------------------------------------------")
    print(f" 📊 요약: 총 {total}개 중 🟢 검증완료 {verified_count}개 | 🟡 대기 {pending_count}개 | 🔴 변조 {outdated_count}개 ({rate:.1f}%)")
    print("==============================================================================")


def verify_snippet(target_query: str, reviewer: str = "Admin", notes: str = "실행 및 실행계획 검증 완료"):
    """스니펫을 사람이 직접 검증 완료 승인하고 영구 해시를 박제합니다."""
    snippets = collect_all_snippets()
    reg = load_registry()

    matched = [s for s in snippets if target_query.lower() in s.title.lower()]
    if not matched:
        print(f"❌ 검색어 '{target_query}' 에 일치하는 스니펫을 찾을 수 없습니다.")
        sys.exit(1)

    now_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S KST")
    for s in matched:
        reg[s.symbol] = {
            "symbol": s.symbol,
            "title": s.title,
            "code_hash": s.code_hash,
            "verified_at": now_str,
            "reviewer": reviewer,
            "notes": notes,
            "rel_path": s.rel_path,
        }
        print(f"✅ [승인 완료] {s.title}")
        print(f"   • 해시: {s.code_hash} | 검증자: {reviewer} | 일시: {now_str}")

    save_registry(reg)
    print(f"\n✨ 총 {len(matched)}개 스니펫이 성공적으로 검증 등록되었습니다. (tips/snippets_registry.json)")


def export_markdown(snippets: List[SqlSnippet], out_path: Path):
    """tips/snippets.md 로 마크다운 사전 및 검증 대시보드를 생성합니다."""
    reg = load_registry()
    lines = [
        "# 📚 Databases & SQL 핵심 쿼리 및 튜닝 스니펫 사전 (tips/snippets.md)",
        "",
        "> 💡 **본 문서는 18권 도서 실습 및 7대 DB 공식 레퍼런스에서 자동 추출된 검증된 모범 SQL/NoSQL 스니펫 사전입니다.**",
        f"> **자동 갱신 일시**: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')} | **총 수록 스니펫**: {len(snippets)}개",
        "",
        "---",
        "",
        "## 🛡️ 검증 상태 요약",
        "",
        "| 상태 | 기호 | 설명 |",
        "| :--- | :---: | :--- |",
        "| **VERIFIED** | 🟢 | 사람이 실행 결과 및 실행 계획(EXPLAIN)을 검증 승인 완료한 코드 |",
        "| **PENDING_REVIEW** | 🟡 | 자동 추출되었으나 아직 사람 검증 서명이 완료되지 않은 코드 |",
        "| **OUTDATED** | 🔴 | 검증 승인 이후 원본 코드가 수정되어 SHA-256 해시가 불일치하는 코드 |",
        "",
        "---",
        "",
        "## 📑 스니펫 색인 목록",
        "",
        "| 번호 | 상태 | 스니펫 명칭 | 대상 엔진 | 원천 소스 위치 |",
        "| :---: | :---: | :--- | :---: | :--- |",
    ]

    for idx, s in enumerate(snippets, 1):
        code, label, _ = get_status_info(s, reg)
        badge = "🟢" if code == "VERIFIED" else ("🔴" if code == "OUTDATED" else "🟡")
        slug_anchor = re.sub(r"[^a-zA-Z0-9가-힣]+", "-", s.title.lower()).strip("-")
        lines.append(f"| {idx} | {badge} | [{s.title}](#{slug_anchor}) | `{s.engine}` | [`{s.rel_path}`]({s.rel_path}#L{s.line_num}) |")

    lines.extend(["", "---", "", "## 💡 상세 스니펫 코드 본문", ""])

    for idx, s in enumerate(snippets, 1):
        code, label, entry = get_status_info(s, reg)
        badge = "🟢 `VERIFIED`" if code == "VERIFIED" else ("🔴 `OUTDATED`" if code == "OUTDATED" else "🟡 `PENDING_REVIEW`")
        meta_extra = ""
        if entry:
            meta_extra = f" (검증자: {entry.get('reviewer', '-')}, {entry.get('verified_at', '-')})"

        # locate 역색인으로 콘텐츠/도서 정보 획득
        content_desc = "SQL 실습"
        if locate:
            try:
                item_info = locate.parse_item_info(REPO_ROOT / s.rel_path)
                content_desc = f"{item_info.get('content', item_info.get('book', ''))} ({item_info['chapter']})"
            except Exception:
                pass

        lang = "sql" if s.engine.lower() != "mongo" else "javascript"
        lines.extend([
            f"### {idx}. {s.title}",
            "",
            f"* **검증 상태**: {badge}{meta_extra}",
            f"* **도서 출처**: {content_desc}",
            f"* **타겟 DBMS**: `{s.engine}`",
            f"* **파일 위치**: [`{s.rel_path}:{s.line_num}`]({s.rel_path}#L{s.line_num})",
            f"* **코드 해시**: `{s.code_hash}`",
            "",
            f"```{lang}",
            s.code,
            "```",
            "",
            "---",
            "",
        ])

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines), encoding="utf-8")
    print(f"✨ [내보내기 완료] 총 {len(snippets)}개 스니펫이 마크다운 문서로 저장되었습니다: {out_path}")


def export_blog_posts(snippets: List[SqlSnippet]):
    """tips/posts/ 에 GitHub Pages / Jekyll 호환 기술 블로그 포스트를 개별 발행합니다."""
    POSTS_DIR.mkdir(parents=True, exist_ok=True)
    reg = load_registry()

    for idx, s in enumerate(snippets, 1):
        code, label, entry = get_status_info(s, reg)
        slug_title = re.sub(r"[^a-zA-Z0-9가-힣]+", "_", s.title).strip("_")
        post_file = POSTS_DIR / f"{idx:03d}_{slug_title}.md"

        content_desc = "Databases & SQL Track"
        if locate:
            try:
                item_info = locate.parse_item_info(REPO_ROOT / s.rel_path)
                content_desc = f"{item_info.get('content', item_info.get('book', ''))} - {item_info['chapter']}"
            except Exception:
                pass

        lang = "sql" if s.engine.lower() != "mongo" else "javascript"
        content = f"""---
title: "{s.title}"
date: {datetime.date.today().isoformat()}
categories: [Database, SQL, {s.engine}]
tags: [{s.engine}, SQL_Tuning, Snippet]
status: "{code}"
code_hash: "{s.code_hash}"
---

# {s.title}

> **도서 출처**: {content_desc}  
> **타겟 DBMS**: `{s.engine}`  
> **검증 상태**: `{code}` (해시: `{s.code_hash}`)

---

## 1. 쿼리 및 스니펫 본문

```{lang}
{s.code}
```

---

## 2. 실행 및 검증 명령어

```bash
# 단독 실행
./scripts/run.sh {Path(s.rel_path).parent}

# 단위 검증 (test.sql)
./scripts/test.sh {Path(s.rel_path).parent}
```
"""
        post_file.write_text(content, encoding="utf-8")

    print(f"✨ [블로그 포스트 발행 완료] 총 {len(snippets)}개 포스트가 tips/posts/ 에 생성되었습니다.")


def main():
    parser = argparse.ArgumentParser(description="Database & SQL Snippet Manager")
    parser.add_argument("query", nargs="?", help="스니펫 검색어 (키워드)")
    parser.add_argument("--list", action="store_true", help="요약 목록만 출력")
    parser.add_argument("--status", action="store_true", help="사람 검증 상태 대시보드 출력")
    parser.add_argument("--verify", metavar="제목", help="사람 검증 승인 및 해시 박제")
    parser.add_argument("--reviewer", default="Admin", help="검증자 이름 (기본값: Admin)")
    parser.add_argument("--notes", default="실행 및 결과 검증 완료", help="검증 메모")
    parser.add_argument("--export", nargs="?", const=str(TIPS_DIR / "snippets.md"), help="tips/snippets.md 로 내보내기")
    parser.add_argument("--export-blog", action="store_true", help="tips/posts/ 에 블로그 포스트 개별 발행")

    args = parser.parse_args()

    if args.status:
        show_status()
        return

    if args.verify:
        verify_snippet(args.verify, reviewer=args.reviewer, notes=args.notes)
        return

    snippets = collect_all_snippets()

    if args.export:
        out_path = Path(args.export)
        export_markdown(snippets, out_path)
        return

    if args.export_blog:
        export_blog_posts(snippets)
        return

    if args.query:
        query_lower = args.query.lower()
        snippets = [s for s in snippets if query_lower in s.title.lower() or query_lower in s.code.lower() or query_lower in s.rel_path.lower()]
        if not snippets:
            print(f"❌ 검색어 '{args.query}' 에 일치하는 스니펫이 없습니다.")
            sys.exit(0)

    if args.list:
        print("==============================================================================")
        print(f" 📑 SQL 스니펫 목록 (총 {len(snippets)}개)")
        print("==============================================================================")
        for idx, s in enumerate(snippets, 1):
            print(f" [{idx:02d}] [{s.engine:7s}] {s.title} ({s.rel_path}:{s.line_num})")
        print("==============================================================================")
        return

    reg = load_registry()
    print("==============================================================================")
    print(f" 🔍 SQL 스니펫 상세 코드 (총 {len(snippets)}개)")
    print("==============================================================================")
    for idx, s in enumerate(snippets, 1):
        code, label, _ = get_status_info(s, reg)
        print(f"[{idx}/{len(snippets)}] {s.title} (Engine: {s.engine}, Status: {label})")
        print(f"📌 위치: {s.rel_path}:{s.line_num} | 해시: {s.code_hash}")
        print("------------------------------------------------------------------------------")
        print(s.code)
        print("==============================================================================\n")


if __name__ == "__main__":
    main()
