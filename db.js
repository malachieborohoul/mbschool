const Pool = require("pg").Pool;

const pool = new Pool({
    user: "postgres",
    // url: "postgres://uvlqydnyxdwlic:9799d89690fb279f9a0d1418b83a3f6d7d887fdb35ce7d82106b8fc1fc2684d1@ec2-44-205-177-160.compute-1.amazonaws.com:5432/d68rjs1nalccnl",
    host: "db.rucakomgxanrjakyhrxs.supabase.co",
    database: "postgres",
    password: "9@Q5j@VEGh7mbgt",
    port: 5432
});
module.exports = pool;