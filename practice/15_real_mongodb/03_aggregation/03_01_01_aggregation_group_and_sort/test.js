// @engine: mongo
// 검증 테스트 스크립트
const res = db.orders.aggregate([
    { $match: { status: "A" } },
    { $group: { _id: "$cust_id", total: { $sum: "$amount" } } }
]).toArray();
print("Test Passed: " + (res.length === 2));
