const { pool } = require("./database/client");

const main = () => {
  pool.query("SELECT NOW()", (err, res) => {
    if (err) {
      console.error("Connection error", err.stack);
    } else {
      console.log("Connected to PostgreSQL. Time:", res.rows[0].now);
    }
  });
};

main();
