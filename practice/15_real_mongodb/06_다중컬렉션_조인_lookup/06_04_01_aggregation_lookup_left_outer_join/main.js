// [6장. Aggregation 파이프라인 ($lookup 다중 컬렉션 조인)]
// 6.4 $lookup 스테이지를 활용한 컬렉션 간 Left Outer Join (p.182)
// @engine: mongo
//
// 같은 폴더의 README.md 에 정리된 개념과 완성 목표 쿼리를 참고하여 아래에 직접 타이핑하세요.
// ==============================================================================

// Step 1: db.customers 에 대해 $lookup 스테이지를 작성하고 purchases 컬렉션과 연결합니다.
// Step 2: _id 와 cust_id 를 매핑하여 order_history 배열로 임베딩된 결과를 확인합니다.

