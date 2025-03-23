---
skip: 'not-searchable-on-index-page'
title: 'Datakit Trace Agent Performance Report'
---

The following tests were conducted in a real physical environment, and test tools were used to send saturated data.

> Physical Machine Parameters for Running Datakit

| CPU  | Memory | Bandwidth    |
| ---- | ------ | ------------ |
| 1 Core | 2G   | 100Mbps |

> Datakit Configuration Used

Default installation

> Test Tool Configuration Parameters (Sending Saturated Data)

| Threads Enabled | Requests per Thread | Number of Spans per Request |
| --------------- | ------------------- | ---------------------------- |
| 100             | 1000               | 10                           |

> Test Tool Download Links

- [DDTrace Test Tool](https://github.com/CodapeWild/dktrace-dd-agent/releases){:target="_blank"}
- [Jaeger Test Tool](https://github.com/CodapeWild/dktrace-jaeger-agent/releases){:target="_blank"}
- [OpenTelemetry Test Tool](https://github.com/CodapeWild/dktrace-otel-agent/releases){:target="_blank"}
- [Zipkin Test Tool](https://github.com/CodapeWild/dktrace-zipkin-agent/releases){:target="_blank"}

## DDTrace Performance Report {#ddtrace-performace}

Test API: `/v0.4/traces`

> Without enabling `ddtrace.threads` and without enabling `ddtrace.storage`

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 60.92  | 66.47   | 100.00      | 727.68              | 7.89                             | 14.96                |

> With `ddtrace.threads(buffer=100 threads=8)` enabled and with `ddtrace.storage(capacity=5120)` enabled

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 60.92  | 66.69   | 50.00       | 399.07              | 8.17                             | 18.98                |

## Jaeger Performance Report {#jaeger-performace}

Test API: `/apis/traces`

> Without enabling `jaeger.threads` and without enabling `jaeger.storage`

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 80.94  | 63.24   | 100.00      | 511.17              | 5.23                             | 24.90                |

> With `jaeger.threads(buffer=100 threads=8)` enabled and with `jaeger.storage(capacity=5120)` enabled

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 62.95  | 60.66   | 200.00      | 912.09              | 4.67                             | 1.37                 |

## OpenTelemetry Performance Report {#opentelemetry-performace}

Test API: `/otel/v1/traces`

> Without enabling `opentelemetry.threads` and without enabling `opentelemetry.storage`

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 65.99  | 67.72   | 100.00      | 262.07              | 2.68                             | 21.98                |

> With `opentelemetry.threads(buffer=100 threads=8)` enabled and with `opentelemetry.storage(capacity=5120)` enabled

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 52.94  | 47.26   | 50.00       | 130.99              | 2.68                             | 3.07                 |


## Zipkin Performance Report {#zipkin-performace}

Test API: `/api/v2/spans`

> Without enabling `zipkin.threads` and without enabling `zipkin.storage`

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 70.98  | 66.26   | 100.00      | 822.16              | 8.42                             | 37.01                |

> With `zipkin.threads(buffer=100 threads=8)` enabled and with `zipkin.storage(capacity=5120)` enabled

| CPU(%) | Mem(mb) | Requests(k) | Total Data Sent(mb) | Size of Each Request Packet(kb) | Interface Latency(ms) |
| ------ | ------- | ----------- | -------------------- | -------------------------------- | --------------------- |
| 59.97  | 51.88   | 50.00       | 410.51              | 8.41                             | 16.59                |