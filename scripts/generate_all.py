#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Master Generator for All 18 Contents.
등록된 모든 도서/콘텐츠의 실습 스캐폴드를 일괄 생성하거나, --verify 옵션으로 전수 검증합니다.

사용법:
  python3 scripts/generate_all.py          # 18권 전 도서 스캐폴딩 생성
  python3 scripts/generate_all.py --verify # 18권 전 도서 모범 답안 쿼리 전수 검증
  python3 scripts/generate_all.py --force  # 기존 main.sql 강제 재생성
"""

import argparse
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent

def main():
    parser = argparse.ArgumentParser(description="Master generator/verifier for all 18 database contents")
    parser.add_argument("--force", action="store_true", help="기존 main.sql 파일도 강제로 덮어쓰기")
    parser.add_argument("--verify", action="store_true", help="모든 항목의 target_code 유효성 전수 검증")
    args, unknown = parser.parse_known_args()

    generators = sorted(list((REPO_ROOT / "scripts").glob("generate_content_*.py")))
    mode = "전수 검증" if args.verify else "스캐폴딩 생성"
    print(f"🚀 총 {len(generators)}개 도서 실습 트랙 {mode}을 시작합니다...\n")

    cmd_args = []
    if args.force:
        cmd_args.append("--force")
    if args.verify:
        cmd_args.append("--verify")

    failed_gens = []
    for gen in generators:
        res = subprocess.run([sys.executable, str(gen)] + cmd_args, cwd=str(REPO_ROOT))
        if res.returncode != 0:
            failed_gens.append(gen.name)

    if failed_gens:
        print(f"\n❌ 다음 생성기에서 오류가 발생했습니다: {', '.join(failed_gens)}", file=sys.stderr)
        sys.exit(1)

    print(f"\n✨ 18권 전 도서 실습 트랙 {mode}이 성공적으로 완료되었습니다!")

if __name__ == "__main__":
    main()

