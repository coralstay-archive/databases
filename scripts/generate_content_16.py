#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Generator for Content 16: SQL 개발자(SQLD) 기출문제 핵심 500제
-> practice/16_sqld_500/
"""

import argparse
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

from scripts.scaffold_engine import scaffold_content, verify_content
from scripts.content16_data import ITEMS

def main():
    parser = argparse.ArgumentParser(description="Generate practice scaffolds for Content 16")
    parser.add_argument("--force", action="store_true", help="기존 main.sql 파일도 강제로 덮어쓰기")
    parser.add_argument("--verify", action="store_true", help="target_code 유효성 전수 검증")
    args = parser.parse_args()

    if args.verify:
        verify_content("16", ITEMS)
    else:
        scaffold_content("16", ITEMS, force=args.force)

if __name__ == "__main__":
    main()
