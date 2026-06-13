import { config } from "dotenv";
import { pool } from "./database/client.mjs";
config();

const main = () => {
  console.log("[ENVS]:", JSON.stringify(process.env));

  pool.query("SELECT NOW()", (err, res) => {
    if (err) {
      console.error("Connection error", err.stack);
    } else {
      console.log("Connected to PostgreSQL. Time:", res.rows[0].now);
    }
  });
};

main();
