---
title: 'Aliyun ClickHouse Community'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aliyun_clickhouse_community'
dashboard:
  - desc: 'Aliyun ClickHouse Monitoring View'
    path: 'dashboard/zh/aliyun_clickhouse_community/'

monitor:
  - desc: 'Aliyun ClickHouse Monitor'
    path: 'monitor/zh/aliyun_clickhouse_community/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun ClickHouse
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the Guance。


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ClickHouse cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -ClickHouse Community Compatible Version)」(ID：`guance_aliyun_clickhouse_community`)

Click "Install"  and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click [Run]，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Alibaba Cloud Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs){:target="_blank"}

> Tip：The monitoring plug-in needs to be installed on the Aliyun ClickHouse console


| Metric Id               |    Metric Name     |                  Dimensions                  | Statistics | Unit         |
| ---- | :---:    | :----: | ---- | ---- |
| `clickhouse_cold_storage_data_cc`       |   cold storage data   | `userId,clusterId,app,pod` | Byte      | Frequency    |
| `clickhouse_conn_usage_count_cc`        | connect count   |    `userId,clusterId,app,pod`       | Sum        | Frequency    |
| `clickhouse_cpu_utilization_cc`    |  CPU utilization  |      `userId,clusterId,app,pod`           | %      | Frequency    |
| `clickhouse_delayed_inserts_cc` |    delayed inserts    |    `userId,clusterId,app,pod`    | Count    | Count       |
| `clickhouse_disk_utilization_cc`     | Disk utilization |        `userId,clusterId,app,pod`           |  %         | Lines        |
| `clickhouse_distributed_files_count_cc`  |  distributed files count  |    `userId,clusterId,app,pod`        | Count        | Lines/Minute |
| `clickhouse_failed_insert_query_cc`            |      failed insert query     |        `userId,clusterId,app,pod`        | Count      | Count        |
| `clickhouse_failed_query_cc`             |      failed query      |           `userId,clusterId,app,pod`           | Count        | Count        |
| `clickhouse_failed_select_query_cc`          |      failed select query      |        `userId,clusterId,app,pod`        | Count      | Count        |
| `clickhouse_http_conn_usage_count_cc`            |     http conn usage count      |           `userId,clusterId,app,pod`           | Count        | Count        |
| `clickhouse_memory_utilization_cc`               |    memory utilization    |           `userId,clusterId,app,pod`           | %        | bytes        |
| `clickhouse_network_rx_rate_cc`          | network rx rate |      `userId,clusterId,app,pod`           | bps        | bps        |
| `clickhouse_network_tx_rate_cc`         | network tx rate |        `userId,clusterId,app,pod`         | bps        | bps        |
| `clickhouse_qps_cc`                |      QPS       |         `userId,clusterId,app,pod`          | Count      | Count        |
