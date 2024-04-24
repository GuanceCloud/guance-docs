---
title: '阿里云 ClickHouse 社区兼容版'
tags: 
  - 阿里云
summary: '阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。'
__int_icon: 'icon/aliyun_clickhouse_community'
dashboard:
  - desc: '阿里云 ClickHouse 内置视图'
    path: 'dashboard/zh/aliyun_clickhouse_community/'

monitor:
  - desc: '阿里云 ClickHouse 监控器'
    path: 'monitor/zh/aliyun_clickhouse_community/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 ClickHouse
<!-- markdownlint-enable -->

阿里云 ClickHouse 指标展示，包括服务状态、日志流量、操作次数、总体 QPS 等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ClickHouse 的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-ClickHouse 社区兼容版)」(ID：`guance_aliyun_clickhouse_community`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏


[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id               |    Metric Name     |                  Dimensions                  | Statistics | Unit         |
| ---- | :---:    | :----: | ---- | ---- |
| `clickhouse_cold_storage_data_cc`       |   冷存使用量   | `userId,clusterId,app,pod` | Byte      | Frequency    |
| `clickhouse_conn_usage_count_cc`        | 连接数   |    `userId,clusterId,app,pod`       | Sum        | Frequency    |
| `clickhouse_cpu_utilization_cc`    |  CPU使用率  |      `userId,clusterId,app,pod`           | %      | Frequency    |
| `clickhouse_delayed_inserts_cc` |    延迟insert个数    |    `userId,clusterId,app,pod`    | Count    | Count       |
| `clickhouse_disk_utilization_cc`     | 磁盘使用率 |        `userId,clusterId,app,pod`           |  %         | Lines        |
| `clickhouse_distributed_files_count_cc`  |  分布式表文件个数  |    `userId,clusterId,app,pod`        | Count        | Lines/Minute |
| `clickhouse_failed_insert_query_cc`            |      失败Insert Query个数      |        `userId,clusterId,app,pod`        | Count      | Count        |
| `clickhouse_failed_query_cc`             |      失败 Query个数      |           `userId,clusterId,app,pod`           | Count        | Count        |
| `clickhouse_failed_select_query_cc`          |      失败Select Query个数      |        `userId,clusterId,app,pod`        | Count      | Count        |
| `clickhouse_http_conn_usage_count_cc`            |     HTTP连接个数      |           `userId,clusterId,app,pod`           | Count        | Count        |
| `clickhouse_memory_utilization_cc`               |    内存使用率    |           `userId,clusterId,app,pod`           | %        | bytes        |
| `clickhouse_network_rx_rate_cc`          | 网络吞吐流入速率 |      `userId,clusterId,app,pod`           | bps        | bps        |
| `clickhouse_network_tx_rate_cc`         | 网络吞吐流出速率 |        `userId,clusterId,app,pod`         | bps        | bps        |
| `clickhouse_qps_cc`                |      QPS       |         `userId,clusterId,app,pod`          | Count      | Count        |
