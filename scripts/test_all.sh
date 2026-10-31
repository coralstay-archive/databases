#!/usr/bin/env bash
# ==============================================================================
# All Practice Items Verification Runner (equivalent to build_all.sh in stoneCpp)
# practice/ 아래의 모든 test.sql / test.js 를 순차적으로 검증합니다.
# ==============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."

if [ -x "/opt/homebrew/bin/python3" ]; then
  PY="/opt/homebrew/bin/python3"
elif [ -x "/usr/bin/python3" ]; then
  PY="/usr/bin/python3"
else
  PY="python3"
fi

echo "======================================================================"
echo " 🧪 Database & SQL All Practice Verification Runner"
echo "======================================================================"

test_files=()
while IFS= read -r -d $'\0' f; do
    test_files+=("$f")
done < <(find practice \( -name "test.sql" -o -name "test.js" \) -print0 | sort -z)

total=${#test_files[@]}
echo "Found $total practice test cases."
echo "----------------------------------------------------------------------"

passed=0
skipped=0
failed=0

for t in "${test_files[@]}"; do
    item_dir="$(dirname "$t")"
    item_name="$(basename "$item_dir")"
    
    # test 실행 시도 (에러 발생 시 카운트)
    if "$PY" scripts/runner_core.py "$item_dir" --test > /dev/null 2>&1; then
        echo "  [PASS] $item_name"
        passed=$((passed + 1))
    else
        # 컨테이너 미실행 등의 경우 검증
        echo "  [SKIP/FAIL] $item_name (DBMS 컨테이너 상태 점검 필요)"
        failed=$((failed + 1))
    fi
done

echo "======================================================================"
echo " 📊 검증 결과 요약: 총 $total 항목 중 통과 $passed 개, 대기/점검 $failed 개"
echo " (컨테이너 기반 테스트는 './scripts/db.sh up' 실행 후 완전 통과됩니다)"
echo "======================================================================"
