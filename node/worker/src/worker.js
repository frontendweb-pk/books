import { parentPort } from "worker_threads";

let sum = 0;
const VALUE = 2_000_000_000;
for (let i = 0; i < VALUE; i++) {
  sum += i;
}

parentPort.postMessage(sum);
