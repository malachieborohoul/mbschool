const Pool = require("pg").Pool;

const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database: "mbschool",
    password: "sm-g532f",
    port: 5432
});
module.exports = pool;