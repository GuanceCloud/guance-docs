---
title: 'Alibaba Cloud ClickHouse Community-Compatible Edition'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud ClickHouse Metrics, including service status, log traffic, operation counts, total QPS, etc.'
__int_icon: 'icon/aliyun_clickhouse_community'
dashboard:
  - desc: 'Built-in Views for Alibaba Cloud ClickHouse'
    path: 'dashboard/en/aliyun_clickhouse_community/'

monitor:
  - desc: 'Alibaba Cloud ClickHouse Monitors'
    path: 'monitor/en/aliyun_clickhouse_community/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud ClickHouse
<!-- markdownlint-enable -->

Display of Alibaba Cloud ClickHouse Metrics, including service status, log traffic, operation counts, total QPS, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize ClickHouse monitoring data, we install the corresponding collection script: "Guance Integration (Alibaba Cloud-ClickHouse Community-Compatible Edition)" (ID: `guance_aliyun_clickhouse_community`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the corresponding log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.

We default to collecting some configurations; for more details, see the metrics section.


[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Alibaba Cloud Cloud Monitoring Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               |    Metric Name     |                  Dimensions                  | Statistics | Unit         |
| ---- | :---:    | :----: | ---- | ---- |
| `clickhouse_cold_storage_data_cc`       |   Cold Storage Usage   | `userId,clusterId,app,pod` | Byte      | Frequency    |
| `clickhouse_conn_usage_count_cc`        | Connection Count   |    `userId,clusterId,app,pod`       | Sum        | Frequency    |
| `clickhouse_cpu_utilization_cc`    |  CPU Utilization  |      `userId,clusterId,app,pod`           | %      | Frequency    |
| `clickhouse_delayed_inserts_cc` |    Delayed Insert Count    |    `userId,clusterId,app,pod`    | Count    | Count       |
| `clickhouse_disk_utilization_cc`     | Disk Utilization |        `userId,clusterId,app,pod`           |  %         | Lines        |
| `clickhouse_distributed_files_count_cc`  |  Distributed Table File Count  |    `userId,clusterId,app,pod`        | Count        | Lines/Minute |
| `clickhouse_failed_insert_query_cc`            |      Failed Insert Query Count      |        `userId,clusterId,app,pod`        | Count      | Count        |
| `clickhouse_failed_query_cc`             |      Failed Query Count      |           `userId,clusterId,app,pod`           | Count        | Count        |
| `clickhouse_failed_select_query_cc`          |      Failed Select Query Count      |        `userId,clusterId,app,pod`        | Count      | Count        |
| `clickhouse_http_conn_usage_count_cc`            |     HTTP Connection Count      |           `userId,clusterId,app,pod`           | Count        | Count        |
| `clickhouse_memory_utilization_cc`               |    Memory Utilization    |           `userId,clusterId,app,pod`           | %        | bytes        |
| `clickhouse_network_rx_rate_cc`          | Network Throughput Ingress Rate |      `userId,clusterId,app,pod`           | bps        | bps        |
| `clickhouse_network_tx_rate_cc`         | Network Throughput Egress Rate |        `userId,clusterId,app,pod`         | bps        | bps        |
| `clickhouse_qps_cc`                |      Queries Per Second       |         `userId,clusterId,app,pod`          | Count      | Count        |