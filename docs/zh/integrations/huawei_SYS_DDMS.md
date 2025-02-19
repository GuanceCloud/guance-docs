---
title: '华为云 DDM'
tags: 
  - 华为云
summary: '华为云 DDM 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了DDMS在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。'
__int_icon: 'icon/huaweiyun_SYS_DDMS'
dashboard:
  - desc: '华为云 DDM 监控视图'
    path: 'dashboard/zh/huaweiyun_SYS_DDMS/'
monitor:
  - desc: '华为云 DDM 监控视图'
    path: 'monitor/zh/huaweiyun_SYS_DDMS/'
---

<!-- markdownlint-disable MD025 -->

# 华为云 DDM
<!-- markdownlint-enable -->

'华为云 DDM 监控视图展示指标包括消息吞吐量、延迟、并发连接数和可靠性，这些指标反映了DDMS在处理大规模消息传递和实时数据流时的性能表现和可靠性保证。'


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云`DDM` 的监控数据，我们安装对应的采集脚本：{{{ custom_key.brand_name }}}集成（华为云- `SYS.DDMS`采集）」(ID：`startup__guance_huaweicloud_ddm`)

点击【安装】后，输入相应的参数：华为云 AK、华为云项目ID。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏




### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好华为云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ddm_active_connections_average | 活跃连接数的平均值 | userId,instanceId | Average,Maximum | 个 |
| ddm_bytes_in_average | 平均每秒接收的字节数 | userId,instanceId | Average,Maximum | 字节/秒 |
| ddm_bytes_out_average | 平均每秒发送的字节数 | userId,instanceId | Average,Maximum | 字节/秒 |
| ddm_cpu_util_average | CPU 利用率的平均值 | userId,instanceId | Average,Maximum | 百分比 |
| ddm_qps_average | 每秒查询率的平均值 | userId,instanceId | Average,Maximum | 次/秒 |
| ddm_node_status_alarm_code_average | 节点状态的平均告警代码 | userId,instanceId | Average,Maximum | Count |
| ddm_write_count_average | 每秒平均写入次数 | userId,instanceId | Average,Maximum | 次/秒 |
| ddm_rt_avg_average | 平均响应时间的平均值 | userId,instanceId | Average,Maximum | ms |



## 对象 {#object}

采集到的华为云 **SYS.DDMS** 的对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
[
  {
    "category": "metric",
    "fields": {
      "ddm_active_connections_average": 1.0,
      "ddm_active_connections_max": 1.0,
      "ddm_active_connections_min": 1.0,
      "ddm_active_connections_sum": 1.0,
      "ddm_active_connections_variance": 0.0,
      "ddm_backend_connection_ratio_average": 0.0,
      "ddm_backend_connection_ratio_max": 0.0,
      "ddm_backend_connection_ratio_min": 0.0,
      "ddm_backend_connection_ratio_sum": 0.0,
      "ddm_backend_connection_ratio_variance": 0.0,
      "ddm_bytes_in_average": 2482.33,
      "ddm_bytes_in_max": 2482.33,
      "ddm_bytes_in_min": 2482.33,
      "ddm_bytes_in_sum": 2482.33,
      "ddm_bytes_in_variance": 0.0,
      "ddm_bytes_out_average": 3062.97,
      "ddm_bytes_out_max": 3062.97,
      "ddm_bytes_out_min": 3062.97,
      "ddm_bytes_out_sum": 3062.97,
      "ddm_bytes_out_variance": 0.0,
      "ddm_connection_util_average": 0.0,
      "ddm_connection_util_max": 0.0,
      "ddm_connection_util_min": 0.0,
      "ddm_connection_util_sum": 0.0,
      "ddm_connection_util_variance": 0.0,
      "ddm_connections_average": 0.0,
      "ddm_connections_max": 0.0,
      "ddm_connections_min": 0.0,
      "ddm_connections_sum": 0.0,
      "ddm_connections_variance": 0.0,
      "ddm_cpu_util_average": 0.64,
      "ddm_cpu_util_max": 0.64,
      "ddm_cpu_util_min": 0.64,
      "ddm_cpu_util_sum": 0.64,
      "ddm_cpu_util_variance": 0.0,
      "ddm_mem_util_average": 28.1,
      "ddm_mem_util_max": 28.1,
      "ddm_mem_util_min": 28.1,
      "ddm_mem_util_sum": 28.1,
      "ddm_mem_util_variance": 0.0,
      "ddm_node_status_alarm_code_average": 0.0,
      "ddm_node_status_alarm_code_max": 0.0,
      "ddm_node_status_alarm_code_min": 0.0,
      "ddm_node_status_alarm_code_sum": 0.0,
      "ddm_node_status_alarm_code_variance": 0.0,
      "ddm_qps_average": 1.0,
      "ddm_qps_max": 1.0,
      "ddm_qps_min": 1.0,
      "ddm_qps_sum": 1.0,
      "ddm_qps_variance": 0.0,
      "ddm_read_count_average": 0.0,
      "ddm_read_count_max": 0.0,
      "ddm_read_count_min": 0.0,
      "ddm_read_count_sum": 0.0,
      "ddm_read_count_variance": 0.0,
      "ddm_rt_avg_average": 0.0,
      "ddm_rt_avg_max": 0.0,
      "ddm_rt_avg_min": 0.0,
      "ddm_rt_avg_sum": 0.0,
      "ddm_rt_avg_variance": 0.0,
      "ddm_slow_log_average": 0.0,
      "ddm_slow_log_max": 0.0,
      "ddm_slow_log_min": 0.0,
      "ddm_slow_log_sum": 0.0,
      "ddm_slow_log_variance": 0.0,
      "ddm_write_count_average": 0.0,
      "ddm_write_count_max": 0.0,
      "ddm_write_count_min": 0.0,
      "ddm_write_count_sum": 0.0,
      "ddm_write_count_variance": 0.0
    },
    "measurement": "huaweicloud_SYS.DDMS",
    "tags": {
      "instance_id": "810159800cbd4b2f8c3c248abbbf59b7in09",
      "node_id": "0ab54e90c63543a1ab9ab57a80d5e6b1no09"
    },
    "timestamp": 1693472712
  }
]
```
