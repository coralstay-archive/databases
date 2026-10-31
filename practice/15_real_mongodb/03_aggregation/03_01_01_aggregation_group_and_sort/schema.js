// @engine: mongo
// [사전 준비 스키마 및 Mock Data]
db.orders.drop();
db.orders.insertMany([
    { _id: 1, cust_id: "abc1", status: "A", amount: 50 },
    { _id: 2, cust_id: "abc1", status: "A", amount: 100 },
    { _id: 3, cust_id: "xyz1", status: "A", amount: 75 },
    { _id: 4, cust_id: "xyz1", status: "D", amount: 25 },
    { _id: 5, cust_id: "abc1", status: "D", amount: 120 }
]);
