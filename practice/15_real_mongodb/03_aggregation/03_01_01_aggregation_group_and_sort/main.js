// [3장. MongoDB 집계 파이프라인 (Aggregation Pipeline)]
// 3.1 Aggregation 파이프라인 기초 ($match, $group, $sort) (p.142)
// @engine: mongo
//
// 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
// ==============================================================================

// Step 1: db.orders 컬렉션에 대해 status 가 'A'인 문서만 $match 로 필터링합니다.
// Step 2: cust_id 필드로 $group 하여 total(amount 합산) 및 count 를 집계합니다.
// Step 3: total 내림차순(-1)으로 $sort 단계를 정의합니다.

