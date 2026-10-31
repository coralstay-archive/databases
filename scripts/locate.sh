#!/usr/bin/env bash
# 실습 파일의 도서명, 몇 장, 몇 절, 몇 문단/항목을 출력하는 네비게이터
# (handcrafted-cpp 파이프라인 Step 1 표준 구현)
#
# 사용법:
#   ./scripts/locate.sh practice/01_real_mysql_1/08_인덱스/08_03_01_b_tree_range_scan
#   ./scripts/locate.sh "인덱스"                 # 키워드로 검색하여 위치 찾기
#   ./scripts/locate.sh --tree                  # 18권 전 도서 마스터 목차 트리 보기
set -euo pipefail
cd "$(dirname "$0")/.."

if [ -x "/opt/homebrew/bin/python3" ]; then
  PYTHON_BIN="/opt/homebrew/bin/python3"
elif [ -x "/usr/bin/python3" ]; then
  PYTHON_BIN="/usr/bin/python3"
else
  PYTHON_BIN="python3"
fi

exec "$PYTHON_BIN" "scripts/locate.py" "$@"
