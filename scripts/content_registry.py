# -*- coding: utf-8 -*-
"""
18권 데이터베이스 및 SQL 콘텐츠 전체 레지스트리 (Content Registry).
프로젝트 내 모든 도서/콘텐츠의 메타데이터, 타겟 DBMS, 트랙 분류, PDF 경로를 단일 진실 공급원(SSOT)으로 관리합니다.
"""

from dataclasses import dataclass
from typing import List, Optional

@dataclass
class ContentInfo:
    id: str                 # "01" ~ "18"
    slug: str               # 폴더명 접두사 (예: "01_real_mysql_1")
    title: str              # 도서 정식 명칭
    pdf_file: str           # contents/ 아래 PDF 파일명
    engine: str             # 기본 타겟 DBMS ("mysql", "oracle", "postgres", "duckdb", "sqlite", "mongo", "multi")
    track: str              # 트랙 분류
    description: str        # 도서 핵심 주제 및 특징
    container_service: str  # docker-compose 서비스명 ("mysql", "postgres", "oracle", "mongo", "none")

CONTENTS: List[ContentInfo] = [
    # Track 1: MySQL Core Track
    ContentInfo(
        id="01",
        slug="01_real_mysql_1",
        title="Real MySQL 8.0 (1권)",
        pdf_file="mysql8.0-1.pdf",
        engine="mysql",
        track="Track 1: MySQL Core",
        description="MySQL 8.0 아키텍처, InnoDB 스토리지 엔진, 트랜잭션과 잠금, 인덱스 내부 구조",
        container_service="mysql",
    ),
    ContentInfo(
        id="02",
        slug="02_real_mysql_2",
        title="Real MySQL 8.0 (2권)",
        pdf_file="mysql8.0-2.pdf",
        engine="mysql",
        track="Track 1: MySQL Core",
        description="쿼리 작성 및 최적화, EXPLAIN 실행 계획 분석, 파티션, 복제(Replication)",
        container_service="mysql",
    ),

    # Track 2: Oracle SQL & Advanced Tuning Track
    ContentInfo(
        id="03",
        slug="03_friendly_sql_tuning",
        title="친절한 SQL 튜닝",
        pdf_file="친절한-SQL-튜닝.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="SQL 파싱과 최적화, 인덱스 기본/확장 원리, 조인 튜닝(NL/Sort Merge/Hash), 소트 튜닝, CBO",
        container_service="oracle",
    ),
    ContentInfo(
        id="04",
        slug="04_oracle_adv_arch_concurrency",
        title="오라클 성능 고도화 원리와 해법: 아키텍처 및 트랜잭션 동시성 제어",
        pdf_file="오라클-성능-고도화-원리와-해법-아키텍처-및-트랜잭션-동시성제어.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="오라클 메모리/프로세스 구조, 래치(Latch)와 락(Enqueue), 트랜잭션 격리수준 및 동시성 제어",
        container_service="oracle",
    ),
    ContentInfo(
        id="05",
        slug="05_oracle_adv_index_join",
        title="오라클 성능 고도화 해법: 인덱스와 조인",
        pdf_file="오라클-성능-고도화-해법-인덱스와-조인.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="B*Tree 인덱스 스캔 효율화, 결합인덱스 설계, 클러스터링 팩터, 고급 조인 튜닝 기법",
        container_service="oracle",
    ),
    ContentInfo(
        id="06",
        slug="06_oracle_adv_sort_partition",
        title="오라클 성능 고도화 원리와 해법: 소트튜닝과 파티션 병렬처리",
        pdf_file="오라클-성능-고도화-원리와-해법-소트튜닝과-파티션-병렬처리.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="Sort Area 메모리 관리, 소트 생략 원리, 테이블/인덱스 파티셔닝 전략, PQ(병렬 처리) 최적화",
        container_service="oracle",
    ),
    ContentInfo(
        id="07",
        slug="07_oracle_adv_optimizer_rewrite",
        title="오라클 성능 고도화 원리와 해법: 옵티마이저와 쿼리변환",
        pdf_file="오라클-성능-고도화-원리와-해법-옵티마이저와-쿼리변환.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="비용 기반 옵티마이저(CBO) 원리, 서브쿼리 Unnesting, View Merging, 조건절 Push/Pull-down",
        container_service="oracle",
    ),
    ContentInfo(
        id="08",
        slug="08_oracle_adv_3_tuning_factors",
        title="오라클 성능 고도화: 데이터베이스 3대 튜닝요소",
        pdf_file="오라클-성능-고도화-데이터베이스-3대-튜닝요소.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="라이브러리 캐시 튜닝, 데이터베이스 I/O 튜닝, 대기 이벤트(Wait Event) 해소 전략",
        container_service="oracle",
    ),
    ContentInfo(
        id="09",
        slug="09_sql_expert_guide",
        title="SQL 전문가 가이드 (K-Data)",
        pdf_file="SQL-전문가-가이드.pdf",
        engine="oracle",
        track="Track 2: Oracle SQL & Advanced Tuning",
        description="국가공인 SQLD/SQLP 수험 표준서, 데이터 모델링의 이해, SQL 기본/활용, SQL 최적화 기본원리",
        container_service="oracle",
    ),

    # Track 3: PostgreSQL & Analytical SQL Track
    ContentInfo(
        id="10",
        slug="10_practical_sql",
        title="실용 SQL (Practical SQL)",
        pdf_file="실용-SQL.pdf",
        engine="postgres",
        track="Track 3: PostgreSQL & Analytics",
        description="PostgreSQL 표준 문법, 데이터 정제/가공, 통계 집계, 지리공간(PostGIS), JSONB 도큐먼트",
        container_service="postgres",
    ),
    ContentInfo(
        id="11",
        slug="11_sql_recipes_data_analysis",
        title="데이터 분석을 위한 SQL 레시피",
        pdf_file="데이터-분석을-위한-SQL-레시피.pdf",
        engine="postgres",
        track="Track 3: PostgreSQL & Analytics",
        description="비즈니스 로그 데이터 가공, 매출/코호트/LTV 분석, 시계열 데이터 처리, 윈도우 함수 실무",
        container_service="postgres",
    ),

    # Track 4: SQL Foundation & Multi-DB Patterns Track
    ContentInfo(
        id="12",
        slug="12_learning_sql",
        title="러닝 SQL (Learning SQL)",
        pdf_file="러닝-SQL.pdf",
        engine="mysql",
        track="Track 4: SQL Foundation & Multi-DB",
        description="ANSI/ISO SQL 표준 문법, 필터링, 조건부 로직, 서브쿼리, 조인, 트랜잭션 기초",
        container_service="mysql",
    ),
    ContentInfo(
        id="13",
        slug="13_sql_cookbook",
        title="SQL Cookbook (2nd Edition)",
        pdf_file="sql-cookbook.pdf",
        engine="multi",
        track="Track 4: SQL Foundation & Multi-DB",
        description="5대 RDBMS(MySQL, PostgreSQL, Oracle, SQL Server, SQLite) 쿼리 패턴 및 방언 상호 비교",
        container_service="postgres",
    ),
    ContentInfo(
        id="14",
        slug="14_sql_antipatterns",
        title="SQL 안티패턴 (SQL Antipatterns)",
        pdf_file="SQL-안티패턴.pdf",
        engine="postgres",
        track="Track 4: SQL Foundation & Multi-DB",
        description="논리/물리 데이터베이스 설계, 쿼리 작성, 애플리케이션 개발 안티패턴과 올바른 해법 솔루션",
        container_service="postgres",
    ),

    # Track 5: NoSQL & Document Database Track
    ContentInfo(
        id="15",
        slug="15_real_mongodb",
        title="Real MongoDB",
        pdf_file="real-mongoDB.pdf",
        engine="mongo",
        track="Track 5: NoSQL & Document Store",
        description="도큐먼트 모델링, MongoDB Query Language(MQL), Aggregation 파이프라인, WiredTiger 엔진, 복제/샤딩",
        container_service="mongo",
    ),

    # Track 6: Certification & Practice Exam Track
    ContentInfo(
        id="16",
        slug="16_sqld_500",
        title="SQL 개발자(SQLD) 기출문제 핵심 500제",
        pdf_file="SQL-개발자-기출문제-핵심-500제.pdf",
        engine="oracle",
        track="Track 6: Certification & Problem Solving",
        description="SQLD 단원별 핵심 기출문제, DDL/DML, GROUP BY/HAVING, 서브쿼리, 계층형 쿼리 집중 훈련",
        container_service="oracle",
    ),
    ContentInfo(
        id="17",
        slug="17_sqlp_1",
        title="SQLP 자격검정 실전문제 1",
        pdf_file="sqlp1.pdf",
        engine="oracle",
        track="Track 6: Certification & Problem Solving",
        description="SQLP 고급 서술형/튜닝 실전문제, 인덱스/조인 튜닝 심화, 실행계획 해석 및 SQL 재작성",
        container_service="oracle",
    ),
    ContentInfo(
        id="18",
        slug="18_sqlp_2",
        title="SQLP 자격검정 실전문제 2",
        pdf_file="sqlp2.pdf",
        engine="oracle",
        track="Track 6: Certification & Problem Solving",
        description="SQLP 모의고사, 파티션/병렬처리 튜닝, 대용량 배치 최적화, 잠금 및 동시성 문제 해결",
        container_service="oracle",
    ),
]

CONTENT_MAP = {c.id: c for c in CONTENTS}
CONTENT_SLUG_MAP = {c.slug: c for c in CONTENTS}

def get_content_by_id(content_id: str) -> Optional[ContentInfo]:
    """콘텐츠 ID(예: '01')로 콘텐츠 정보를 조회합니다."""
    return CONTENT_MAP.get(content_id)

def get_content_by_slug(slug: str) -> Optional[ContentInfo]:
    """콘텐츠 슬러그(예: 01_real_mysql_1)로 콘텐츠 정보를 조회합니다."""
    return CONTENT_SLUG_MAP.get(slug)

def get_content_by_path(path: str) -> Optional[ContentInfo]:
    """경로(예: practice/01_real_mysql_1/...)에서 콘텐츠 정보를 추출합니다."""
    # content.slug 가 경로 세그먼트로 정확히 매칭되는지 확인 (예: practice/13_sql_cookbook/...)
    for content in CONTENTS:
        if f"/{content.slug}/" in path or path.endswith(f"/{content.slug}") or path.startswith(f"{content.slug}/"):
            return content
    # 폴더명만 들어온 경우 fallback
    for content in CONTENTS:
        if content.slug in path:
            return content
    return None

# 하위 호환 별칭 (Backward Compatibility Aliases)
BookInfo = ContentInfo
BOOKS = CONTENTS
BOOK_MAP = CONTENT_MAP
BOOK_SLUG_MAP = CONTENT_SLUG_MAP
get_book_by_id = get_content_by_id
get_book_by_slug = get_content_by_slug
get_book_by_path = get_content_by_path

