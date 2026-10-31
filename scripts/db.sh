#!/usr/bin/env bash
# ==============================================================================
# Database Container Manager (OrbStack & Podman Native Support)
# OrbStack 및 Podman(podman compose / podman-compose)을 기본 지원하며,
# 활성화된 컨테이너 런타임 엔진을 자동 감지하여 4대 DBMS를 구동합니다.
#
# 사용법:
#   ./scripts/db.sh up [서비스명...]    # 전체 또는 특정 DB 컨테이너 시작
#   ./scripts/db.sh down               # 모든 DB 컨테이너 중지
#   ./scripts/db.sh status             # 실행 상태 및 포트 확인
#   ./scripts/db.sh logs [서비스명]     # 컨테이너 로그 출력
#   ./scripts/db.sh cli <엔진명>       # 해당 DB의 대화형 CLI 접속 (mysql, postgres, mongo, oracle)
#   ./scripts/db.sh orb [start|stop|status]          # macOS OrbStack 가상화 관리
#   ./scripts/db.sh machine [start|stop|status|init] # macOS Podman 머신 관리
# ==============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."

# macOS 환경변수 PATH 보정 (OrbStack & Homebrew 경로 포함)
export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.orbstack/bin:$PATH"

ENGINE=""
COMPOSE_CMD=()

# 1. 런타임 엔진 감지 (OrbStack > Podman > Docker 순서)
detect_engine() {
    # 1-1. OrbStack 감지 (orbctl 실행 중이거나 Docker가 OrbStack 소켓에 바인딩된 경우)
    if command -v orbctl >/dev/null 2>&1; then
        local orb_st
        orb_st=$(orbctl status 2>/dev/null || echo "Stopped")
        if [[ "$orb_st" == *"Running"* ]] || docker info 2>/dev/null | grep -qi "orbstack"; then
            ENGINE="orbstack (docker compose)"
            COMPOSE_CMD=(docker compose)
            return 0
        fi
    fi

    # 1-2. Podman 감지
    if command -v podman >/dev/null 2>&1; then
        if podman compose version >/dev/null 2>&1; then
            ENGINE="podman compose"
            COMPOSE_CMD=(podman compose)
            return 0
        elif command -v podman-compose >/dev/null 2>&1; then
            ENGINE="podman-compose"
            COMPOSE_CMD=(podman-compose)
            return 0
        else
            ENGINE="podman (machine/cli)"
            COMPOSE_CMD=(podman compose)
            return 0
        fi
    fi

    # 1-3. 일반 Docker 감지
    if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
        ENGINE="docker compose"
        COMPOSE_CMD=(docker compose)
        return 0
    fi

    # 1-4. 엔진 설치는 되어 있으나 데몬이 정지된 경우 감지
    if command -v orbctl >/dev/null 2>&1; then
        ENGINE="orbstack (정지됨: ./scripts/db.sh orb start 필요)"
        COMPOSE_CMD=(docker compose)
    elif command -v podman >/dev/null 2>&1; then
        ENGINE="podman (머신 정지됨: ./scripts/db.sh machine start 필요)"
        COMPOSE_CMD=(podman compose)
    elif command -v docker >/dev/null 2>&1; then
        ENGINE="docker (데몬 정지됨)"
        COMPOSE_CMD=(docker compose)
    else
        ENGINE="none"
    fi
}

detect_engine

CMD="${1:-help}"
shift || true

ensure_engine() {
    if [ "$ENGINE" = "none" ]; then
        echo "======================================================================"
        echo " ❌ [오류] OrbStack 또는 Podman 컨테이너 런타임을 찾을 수 없습니다."
        echo "======================================================================"
        echo " macOS 권장 설치 옵션:"
        echo "  [옵션 A: OrbStack - 초경량·고속 배터리 친화적 권장]"
        echo "    brew install orbstack"
        echo "    orbctl start"
        echo ""
        echo "  [옵션 B: Podman - OCI 오픈소스 루트리스 컨테이너]"
        echo "    brew install podman podman-compose"
        echo "    ./scripts/db.sh machine init"
        echo "    ./scripts/db.sh machine start"
        echo "======================================================================"
        exit 1
    fi
}

case "$CMD" in
  up)
    ensure_engine
    echo "🚀 [$ENGINE] Starting database containers via: ${COMPOSE_CMD[*]} up -d"
    "${COMPOSE_CMD[@]}" up -d "$@"
    echo "✅ Databases started. Run './scripts/db.sh status' to verify."
    ;;
  down)
    ensure_engine
    echo "🛑 [$ENGINE] Stopping database containers..."
    "${COMPOSE_CMD[@]}" down
    echo "✅ Databases stopped."
    ;;
  status|ps)
    ensure_engine
    echo "📊 [$ENGINE] Container Status:"
    "${COMPOSE_CMD[@]}" ps
    ;;
  logs)
    ensure_engine
    "${COMPOSE_CMD[@]}" logs -f "$@"
    ;;
  orb)
    if ! command -v orbctl >/dev/null 2>&1; then
        echo "❌ OrbStack CLI(orbctl)가 설치되어 있지 않습니다. (brew install orbstack)" >&2
        exit 1
    fi
    SUB_CMD="${1:-status}"
    case "$SUB_CMD" in
      start)
        echo "🚀 Starting OrbStack..."
        orbctl start
        ;;
      stop)
        echo "🛑 Stopping OrbStack..."
        orbctl stop
        ;;
      status)
        orbctl status
        ;;
      restart)
        echo "🔄 Restarting OrbStack..."
        orbctl restart
        ;;
      *)
        echo "사용법: ./scripts/db.sh orb [start|stop|status|restart]"
        ;;
    esac
    ;;
  machine)
    if ! command -v podman >/dev/null 2>&1; then
        echo "❌ podman CLI가 설치되어 있지 않습니다. (brew install podman podman-compose)" >&2
        exit 1
    fi
    SUB_CMD="${1:-status}"
    case "$SUB_CMD" in
      start)
        echo "🚀 Starting Podman Machine..."
        podman machine start
        ;;
      stop)
        echo "🛑 Stopping Podman Machine..."
        podman machine stop
        ;;
      status|list)
        podman machine list
        ;;
      init)
        echo "⚙️ Initializing Podman Machine (CPUs: 2, RAM: 4096MB, Disk: 50GB)..."
        podman machine init --cpus 2 --memory 4096 --disk-size 50
        ;;
      *)
        echo "사용법: ./scripts/db.sh machine [start|stop|status|init]"
        ;;
    esac
    ;;
  cli)
    ensure_engine
    TARGET="${1:-}"
    if [ -z "$TARGET" ]; then
      echo "사용법: $0 cli <mysql|postgres|mongo|oracle>" >&2
      exit 1
    fi

    case "$TARGET" in
      mysql)
        "${COMPOSE_CMD[@]}" exec -it mysql mysql -u practice -ppractice practice_db
        ;;
      postgres|pg)
        "${COMPOSE_CMD[@]}" exec -it postgres psql -U postgres -d practice_db
        ;;
      mongo|mongodb)
        "${COMPOSE_CMD[@]}" exec -it mongo mongosh -u root -p root practice_db
        ;;
      oracle)
        "${COMPOSE_CMD[@]}" exec -it oracle sqlplus practice/practice@//localhost:1521/FREEPDB1
        ;;
      *)
        echo "알 수 없는 대상: $TARGET (mysql, postgres, mongo, oracle 중 선택)" >&2
        exit 1
        ;;
    esac
    ;;
  *)
    echo "======================================================================"
    echo " 🦭 Database Container Management Tool (OrbStack & Podman Native)"
    echo "======================================================================"
    echo " 감지된 엔진: $ENGINE"
    echo "----------------------------------------------------------------------"
    echo " ./scripts/db.sh up [서비스...]     # 컨테이너 시작 (mysql, postgres, mongo, oracle)"
    echo " ./scripts/db.sh down              # 컨테이너 종료"
    echo " ./scripts/db.sh status            # 실행 상태 확인"
    echo " ./scripts/db.sh logs [서비스]      # 로그 모니터링"
    echo " ./scripts/db.sh cli <엔진명>       # 대화형 DB CLI 셸 접속"
    echo " ./scripts/db.sh orb <명령>        # macOS OrbStack 관리 (start/stop/status/restart)"
    echo " ./scripts/db.sh machine <명령>    # macOS Podman Machine 관리 (start/stop/status/init)"
    echo "======================================================================"
    ;;
esac
