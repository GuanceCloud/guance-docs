---
skip: 'not-searchable-on-index-page'
title: 'DataKit Metrics Performance Test Report'
---

## Test Environment Parameters

- CPU (4 cores): Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
- Memory: 12 GB
    - 4GiB DIMM DDR4 Synchronous 2133 MHz (0.5 ns)
    - 8GiB DIMM DDR4 Synchronous 2133 MHz (0.5 ns)
- Operating System: Ubuntu 22.04 LTS
- DataKit: 1.14.1-3-gf792e9d

## Metrics Testing Results

|  /   | Default Collector Enabled  | Default Collector + 1 MySQL Collector Enabled  | Default Collector + 100 MySQL Collectors Enabled  |
|  ----  | ----  | ----  | ----  |
| Average CPU Usage  | 0.43%    | 0.38%    | 11.99% |
| Average Memory Usage   | 22.91 MB | 21.22 MB | 42.19 MB |
| Uploaded Bytes   | 150 K | 300 K | 3 M |

## CPU Usage Changes

Collection Time: 10 min

<!-- markdownlint-disable MD024 -->

### Default Collector Enabled

![mp-1-cpu](imgs/mp-1-cpu.png)

### Default Collector + 1 MySQL Collector Enabled

![mp-2-cpu](imgs/mp-2-cpu.png)

### Default Collector + 100 MySQL Collectors Enabled

![mp-3-cpu](imgs/mp-3-cpu.png)

## Memory Usage Changes

Collection Time: 10 min

### Default Collector Enabled

![mp-1-mem](imgs/mp-1-mem.png)

### Default Collector + 1 MySQL Collector Enabled

![mp-2-mem](imgs/mp-2-mem.png)

### Default Collector + 100 MySQL Collectors Enabled

![mp-3-mem](imgs/mp-3-mem.png)

## Uploaded Bytes Changes

Collection Time: 10 min

### Default Collector Enabled

![mp-1-upload](imgs/mp-1-upload.png)

### Default Collector + 1 MySQL Collector Enabled

![mp-2-upload](imgs/mp-2-upload.png)

### Default Collector + 100 MySQL Collectors Enabled

![mp-3-upload](imgs/mp-3-upload.png)

<!-- markdownlint-enable -->

## Other Test Results

- [Datakit Trace Agent Performance Report](./datakit-trace-performance.md){:target="_blank"}
- [DataKit Log Collector Performance Test](./logging-pipeline-bench.md){:target="_blank"}