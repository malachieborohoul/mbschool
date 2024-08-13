const Pool = require("pg").Pool;
const pool = new Pool({
    user: process.env.PG_USER,
    // url: "postgres://uvlqydnyxdwlic:9799d89690fb279f9a0d1418b83a3f6d7d887fdb35ce7d82106b8fc1fc2684d1@ec2-44-205-177-160.compute-1.amazonaws.com:5432/d68rjs1nalccnl",
    host: process.env.PG_HOST,
    database: process.env.PG_DATABASE,
    password: process.env.PG_PASSWORD,
    port: process.env.PG_PORT,
});
module.exports = pool;