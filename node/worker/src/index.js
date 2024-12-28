import express from "express";
import { Worker } from "worker_threads";
import { availableMemory, cpuUsage } from "process";

const app = express();
const PORT = process.env.PORT || 3100;

app.get("/", (req, res, next) => {
  res.json({
    message: "Non blocking route",
  });
});

app.get("/blocking", (req, res) => {
  const worker = new Worker(new URL("worker.js", import.meta.url));
  worker.on("message", (data) => {
    res.json({
      message: `sum of 2_000_000 numbers is : ${data}`,
    });
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
