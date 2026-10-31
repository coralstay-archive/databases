// @engine: mongo
// [사전 준비 스키마 및 Mock Data]
db.users.drop();
db.users.insertOne({
    _id: 1,
    username: "coder_kim",
    skills: ["SQL", "Python"]
});
