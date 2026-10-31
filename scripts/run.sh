#!/usr/bin/env bash
# ==============================================================================
# Database / SQL Runner
# 사용법:
#   ./scripts/run.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan
#   ./scripts/run.sh practice/13_sql_cookbook/03_다중_테이블_작업/03_05_01_outer_join_and_coalesce/main.sql
# ==============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."

if [ "$#" -lt 1 ]; then
  echo "사용법: $0 <폴더경로 또는 main.sql 경로>" >&2
  exit 1
fi

if [ -x "/opt/homebrew/bin/python3" ]; then
  PY="/opt/homebrew/bin/python3"
elif [ -x "/usr/bin/python3" ]; then
  PY="/usr/bin/python3"
else
  PY="python3"
fi

"$PY" scripts/runner_core.py "$1"
