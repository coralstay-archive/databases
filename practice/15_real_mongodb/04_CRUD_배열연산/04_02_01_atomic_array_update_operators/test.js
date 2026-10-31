// @engine: mongo
// 검증 테스트 스크립트
const doc = db.users.findOne({ _id: 1 });
print("Test Passed: " + (doc.skills.length === 3 && doc.skills.includes("MongoDB")));
