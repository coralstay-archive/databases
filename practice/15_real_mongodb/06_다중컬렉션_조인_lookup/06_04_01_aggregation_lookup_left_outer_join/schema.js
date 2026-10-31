// @engine: mongo
// [사전 준비 스키마 및 Mock Data]
db.customers.drop();
db.purchases.drop();

db.customers.insertMany([
    { _id: 1, name: "박지성" },
    { _id: 2, name: "손흥민" }
]);

db.purchases.insertMany([
    { _id: 101, cust_id: 2, item: "축구화", price: 250000 },
    { _id: 102, cust_id: 2, item: "유니폼", price: 120000 }
]);
