---
skip: 'not-searchable-on-index-page'
title: 'Datakit Metrics Performance Test Report'
---

## Test Environment Parameters {#env}

- CPU (4 cores): Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
- Memory: 12 GB
    - 4GiB DIMM DDR4 Synchronous 2133 MHz (0.5 ns)
    - 8GiB DIMM DDR4 Synchronous 2133 MHz (0.5 ns)
- Operating System: Ubuntu 22.04 LTS
- DataKit: 1.14.1-3-gf792e9d

## Metrics Testing Results {#result}

|  /   | Default Collector Enabled  | Default Collector Enabled + 1 MySQL Collector Enabled  | Default Collector Enabled + 100 MySQL Collectors Enabled  |
|  ----  | ----  | ----  | ----  |
| Average CPU Usage  | 0.43%    | 0.38%    | 11.99% |
| Average Memory Usage   | 22.91 MB | 21.22 MB | 42.19 MB |
| Uploaded Bytes   | 150 K | 300 K | 3 M |

## Changes in CPU Usage {#cpu}

Collection Time: 10 min

<!-- markdownlint-disable MD024 -->

- Default collector enabled

![mp-1-cpu](imgs/mp-1-cpu.png)

- Default collector enabled + 1 MySQL collector enabled

![mp-2-cpu](imgs/mp-2-cpu.png)

- Default collector enabled + 100 MySQL collectors enabled

![mp-3-cpu](imgs/mp-3-cpu.png)

## Changes in Memory Usage {#mem}

Collection Time: 10 min

- Default collector enabled

![mp-1-mem](imgs/mp-1-mem.png)

- Default collector enabled + 1 MySQL collector enabled

![mp-2-mem](imgs/mp-2-mem.png)

- Default collector enabled + 100 MySQL collectors enabled

![mp-3-mem](imgs/mp-3-mem.png)

## Changes in Uploaded Bytes {#upload-bytes}

Collection Time: 10 min

- Default collector enabled

![mp-1-upload](imgs/mp-1-upload.png)

- Default collector enabled + 1 MySQL collector enabled

![mp-2-upload](imgs/mp-2-upload.png)

- Default collector enabled + 100 MySQL collectors enabled

![mp-3-upload](imgs/mp-3-upload.png)

<!-- markdownlint-enable -->

## Other Test Results {#others}

- [Datakit Trace Agent Performance Report](./datakit-trace-performance.md){:target="_blank"}
- [DataKit Log Collector Performance Testing](./logging-pipeline-bench.md){:target="_blank"}