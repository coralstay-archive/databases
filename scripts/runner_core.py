#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Database Universal Execution Engine (Podman Primary).
디렉터리 또는 SQL/JS 파일을 입력받아 적합한 DBMS로 라우팅하고 실행 결과를 서식화하여 출력합니다.
Podman(podman compose / podman-compose)을 기본 컨테이너 엔진으로 사용하며, Docker를 자동 폴백 지원합니다.
"""

import os
import re
import sys
import shutil
import subprocess
from pathlib import Path
from typing import List, Tuple

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))
from scripts.content_registry import get_content_by_path

def detect_engine(sql_path: Path) -> str:
    """SQL/JS 파일 내부 주석(@engine: ...) 또는 디렉터리 경로에서 타겟 DBMS를 판별합니다."""
    content = ""
    try:
        content = sql_path.read_text(encoding="utf-8", errors="ignore")
    except Exception:
        pass

    m = re.search(r"[@/][*-]?\s*@engine:\s*([a-zA-Z0-9_]+)", content)
    if m:
        return m.group(1).lower()

    # 경로 기반 감지
    rel_path = str(sql_path.resolve())
    content_info = get_content_by_path(rel_path)
    if content_info:
        return content_info.engine.lower()

    return "sqlite" # 기본 폴백

def get_compose_cmd() -> Tuple[List[str], str]:
    """OrbStack 및 Podman Compose 우선 탐색, 부재 시 Docker Compose 폴백."""
    # 1. OrbStack 감지 (초고속 네이티브 Docker 가상화)
    if shutil.which("orbctl"):
        try:
            res = subprocess.run(["orbctl", "status"], capture_output=True, text=True, timeout=2)
            if "Running" in res.stdout:
                return ["docker", "compose"], "orbstack"
        except Exception:
            pass

    # 2. 일반 Docker 데몬 실행 여부 확인
    if shutil.which("docker"):
        try:
            res = subprocess.run(["docker", "info"], capture_output=True, text=True, timeout=2)
            if res.returncode == 0:
                engine_name = "orbstack" if "orbstack" in res.stdout.lower() else "docker"
                return ["docker", "compose"], engine_name
        except Exception:
            pass

    # 3. Podman 감지
    if shutil.which("podman"):
        try:
            res = subprocess.run(["podman", "compose", "version"], capture_output=True, timeout=2)
            if res.returncode == 0:
                return ["podman", "compose"], "podman"
        except Exception:
            pass
        if shutil.which("podman-compose"):
            return ["podman-compose"], "podman"
        return ["podman", "compose"], "podman"

    return ["docker", "compose"], "docker"

def is_container_running(service_name: str) -> bool:
    compose_cmd, _ = get_compose_cmd()
    try:
        res = subprocess.run(
            compose_cmd + ["ps", "-q", service_name],
            cwd=str(REPO_ROOT),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=3,
        )
        return bool(res.stdout.strip())
    except Exception:
        return False

def run_query(target_path_str: str, is_test: bool = False):
    target = Path(target_path_str).resolve()
    if not target.exists():
        # practice/ 접두사 보정
        alt = REPO_ROOT / target_path_str
        if alt.exists():
            target = alt
        else:
            print(f"❌ 대상을 찾을 수 없습니다: {target_path_str}", file=sys.stderr)
            sys.exit(1)

    item_dir = target if target.is_dir() else target.parent

    # 실행할 파일 결정
    if is_test:
        main_sql = item_dir / "test.sql"
        if not main_sql.exists():
            main_sql = item_dir / "test.js"
    else:
        if target.is_file():
            main_sql = target
        else:
            main_sql = item_dir / "main.sql"
            if not main_sql.exists():
                main_sql = item_dir / "main.js"

    if not main_sql.exists():
        print(f"❌ 실행할 스크립트 파일이 없습니다: {main_sql}", file=sys.stderr)
        sys.exit(1)

    engine = detect_engine(main_sql)
    schema_sql = item_dir / ("schema.js" if engine == "mongo" else "schema.sql")
    compose_cmd, container_tool = get_compose_cmd()

    print(f"======================================================================")
    print(f" 🚀 Running: {main_sql.relative_to(REPO_ROOT)}")
    print(f" 🎯 Engine : {engine.upper()} | Container: {container_tool.upper()} | Mode: {'TEST' if is_test else 'EXECUTE'}")
    print(f"======================================================================")

    # 1. MongoDB 실행
    if engine == "mongo":
        if not is_container_running("mongo"):
            print("⚠️ MongoDB 컨테이너가 실행 중이 아닙니다. './scripts/db.sh up mongo' 를 실행하세요.", file=sys.stderr)
            sys.exit(1)

        combined_js = ""
        if schema_sql.exists():
            combined_js += schema_sql.read_text(encoding="utf-8") + "\n"
        combined_js += main_sql.read_text(encoding="utf-8")

        proc = subprocess.run(
            compose_cmd + ["exec", "-T", "mongo", "mongosh", "-u", "root", "-p", "root", "--quiet", "practice_db"],
            cwd=str(REPO_ROOT),
            input=combined_js,
            text=True,
            capture_output=True,
        )
        print(proc.stdout)
        if proc.stderr:
            print("⚠️ [STDERR]:", proc.stderr, file=sys.stderr)
        sys.exit(proc.returncode)

    # 2. MySQL 실행
    elif engine == "mysql":
        if not is_container_running("mysql"):
            print("⚠️ MySQL 컨테이너가 실행 중이 아닙니다. './scripts/db.sh up mysql' 를 실행하세요.", file=sys.stderr)
            sys.exit(1)

        combined_sql = ""
        if schema_sql.exists():
            combined_sql += schema_sql.read_text(encoding="utf-8") + "\n"
        combined_sql += main_sql.read_text(encoding="utf-8")

        proc = subprocess.run(
            compose_cmd + ["exec", "-T", "mysql", "mysql", "-u", "practice", "-ppractice", "--table", "practice_db"],
            cwd=str(REPO_ROOT),
            input=combined_sql,
            text=True,
            capture_output=True,
        )
        print(proc.stdout)
        if proc.stderr:
            print(proc.stderr, file=sys.stderr)
        sys.exit(proc.returncode)

    # 3. PostgreSQL 실행
    elif engine in ("postgres", "postgresql"):
        if not is_container_running("postgres"):
            print("⚠️ PostgreSQL 컨테이너가 실행 중이 아닙니다. './scripts/db.sh up postgres' 를 실행하세요.", file=sys.stderr)
            sys.exit(1)

        combined_sql = ""
        if schema_sql.exists():
            combined_sql += schema_sql.read_text(encoding="utf-8") + "\n"
        combined_sql += main_sql.read_text(encoding="utf-8")

        proc = subprocess.run(
            compose_cmd + ["exec", "-T", "postgres", "psql", "-U", "postgres", "-d", "practice_db"],
            cwd=str(REPO_ROOT),
            input=combined_sql,
            text=True,
            capture_output=True,
        )
        print(proc.stdout)
        if proc.stderr:
            print(proc.stderr, file=sys.stderr)
        sys.exit(proc.returncode)

    # 4. Oracle 실행
    elif engine == "oracle":
        if not is_container_running("oracle"):
            print("⚠️ Oracle 컨테이너가 실행 중이 아닙니다. './scripts/db.sh up oracle' 를 실행하세요.", file=sys.stderr)
            sys.exit(1)

        combined_sql = "SET PAGESIZE 100 LINESIZE 200 FEEDBACK ON ECHO ON;\n"
        if schema_sql.exists():
            combined_sql += schema_sql.read_text(encoding="utf-8") + "\n"
        combined_sql += main_sql.read_text(encoding="utf-8") + "\nEXIT;\n"

        proc = subprocess.run(
            compose_cmd + ["exec", "-T", "oracle", "sqlplus", "-s", "practice/practice@//localhost:1521/FREEPDB1"],
            cwd=str(REPO_ROOT),
            input=combined_sql,
            text=True,
            capture_output=True,
        )
        print(proc.stdout)
        if proc.stderr:
            print(proc.stderr, file=sys.stderr)
        sys.exit(proc.returncode)

    # 5. SQLite / 경량 로컬 실행 (도커/포드맨 불필요)
    elif engine in ("sqlite", "sqlite3", "multi"):
        import sqlite3
        conn = sqlite3.connect(":memory:")
        cursor = conn.cursor()

        if schema_sql.exists():
            try:
                cursor.executescript(schema_sql.read_text(encoding="utf-8"))
            except Exception as e:
                print(f"❌ [schema.sql 에러]: {e}", file=sys.stderr)

        sql_code = main_sql.read_text(encoding="utf-8")
        # 구문 단위 실행
        statements = [s.strip() for s in sql_code.split(";") if s.strip()]
        for stmt in statements:
            # 주석만 있는 경우 스킵
            clean_stmt = re.sub(r"--.*$", "", stmt, flags=re.MULTILINE).strip()
            if not clean_stmt:
                continue
            try:
                cursor.execute(clean_stmt)
                rows = cursor.fetchall()
                if cursor.description:
                    cols = [d[0] for d in cursor.description]
                    print(" | ".join(cols))
                    print("-" * (len(" | ".join(cols)) + 4))
                    for r in rows:
                        print(" | ".join(str(val) for val in r))
                    print(f"({len(rows)} rows selected)\n")
                else:
                    print(f"Query OK, {cursor.rowcount} rows affected\n")
            except Exception as e:
                print(f"❌ [Query 실행 에러]: {e}\nQuery: {clean_stmt}", file=sys.stderr)

        conn.close()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("사용법: runner_core.py <경로> [--test]")
        sys.exit(1)
    is_test_mode = "--test" in sys.argv
    path_arg = sys.argv[1]
    run_query(path_arg, is_test=is_test_mode)
