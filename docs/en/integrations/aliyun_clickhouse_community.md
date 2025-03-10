---
title: 'Alibaba Cloud ClickHouse Community Compatible Edition'
tags: 
  - Alibaba Cloud
summary: 'Display of Alibaba Cloud ClickHouse metrics, including service status, log traffic, operation counts, overall QPS, etc.'
__int_icon: 'icon/aliyun_clickhouse_community'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud ClickHouse'
    path: 'dashboard/en/aliyun_clickhouse_community/'

monitor:
  - desc: 'Alibaba Cloud ClickHouse monitor'
    path: 'monitor/en/aliyun_clickhouse_community/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud ClickHouse
<!-- markdownlint-enable -->

Display of Alibaba Cloud ClickHouse metrics, including service status, log traffic, operation counts, overall QPS, etc.

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize ClickHouse monitoring data, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-ClickHouse Community Compatible Edition)」(ID: `guance_aliyun_clickhouse_community`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, enable the corresponding log collection script. If you need to collect billing data, enable the cloud billing collection script.

We have collected some default configurations; for more details, see the Metrics section.

[Configure Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud Cloud Monitor, the default metric set is as follows. More metrics can be collected through configuration. [Alibaba Cloud Cloud Monitor Metric Details](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               | Metric Name             | Dimensions                         | Statistics | Unit         |
| ----------------------- | :---------------------- | :--------------------------------- | :--------- | :----------- |
| `clickhouse_cold_storage_data_cc`       | Cold Storage Usage   | `userId,clusterId,app,pod` | Byte      | Frequency    |
| `clickhouse_conn_usage_count_cc`        | Connection Count     | `userId,clusterId,app,pod` | Sum        | Frequency    |
| `clickhouse_cpu_utilization_cc`         | CPU Utilization      | `userId,clusterId,app,pod` | %         | Frequency    |
| `clickhouse_delayed_inserts_cc`         | Delayed Insert Count | `userId,clusterId,app,pod` | Count      | Count        |
| `clickhouse_disk_utilization_cc`        | Disk Utilization     | `userId,clusterId,app,pod` | %         | Lines        |
| `clickhouse_distributed_files_count_cc` | Distributed Files    | `userId,clusterId,app,pod` | Count      | Lines/Minute |
| `clickhouse_failed_insert_query_cc`     | Failed Insert Query  | `userId,clusterId,app,pod` | Count      | Count        |
| `clickhouse_failed_query_cc`            | Failed Query         | `userId,clusterId,app,pod` | Count      | Count        |
| `clickhouse_failed_select_query_cc`     | Failed Select Query  | `userId,clusterId,app,pod` | Count      | Count        |
| `clickhouse_http_conn_usage_count_cc`   | HTTP Connections     | `userId,clusterId,app,pod` | Count      | Count        |
| `clickhouse_memory_utilization_cc`      | Memory Utilization   | `userId,clusterId,app,pod` | %         | Bytes        |
| `clickhouse_network_rx_rate_cc`         | Network Ingress Rate | `userId,clusterId,app,pod` | bps        | bps          |
| `clickhouse_network_tx_rate_cc`         | Network Egress Rate  | `userId,clusterId,app,pod` | bps        | bps          |
| `clickhouse_qps_cc`                     | QPS                  | `userId,clusterId,app,pod` | Count      | Count        |