const Pool = require("pg").Pool;
const connectionString = 'postgresql://postgres.rucakomgxanrjakyhrxs:[YOUR-PASSWORD]@aws-0-us-east-1.pooler.supabase.com:6543/postgres'
const pool = new Pool({
    user: "postgres.rucakomgxanrjakyhrxs",
    // url: "postgres://uvlqydnyxdwlic:9799d89690fb279f9a0d1418b83a3f6d7d887fdb35ce7d82106b8fc1fc2684d1@ec2-44-205-177-160.compute-1.amazonaws.com:5432/d68rjs1nalccnl",
    host: "aws-0-us-east-1.pooler.supabase.com",
    database: "postgres",
    password: "9@Q5j@VEGh7mbgt",
    port: 6543
});
module.exports = pool;