// @engine: mongo
// 검증 테스트 스크립트
const res = db.customers.aggregate([
    { $lookup: { from: "purchases", localField: "_id", foreignField: "cust_id", as: "order_history" } }
]).toArray();
print("Test Passed: " + (res.length === 2 && res[1].order_history.length === 2));
