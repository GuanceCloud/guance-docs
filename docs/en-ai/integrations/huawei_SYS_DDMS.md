---
title: 'Huawei Cloud DDM'
tags: 
  - Huawei Cloud
summary: 'The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of DDMS in handling large-scale message passing and real-time data streams.'
__int_icon: 'icon/huaweiyun_SYS_DDMS'
dashboard:
  - desc: 'Huawei Cloud DDM monitoring view'
    path: 'dashboard/en/huaweiyun_SYS_DDMS/'
monitor:
  - desc: 'Huawei Cloud DDM monitoring view'
    path: 'monitor/en/huaweiyun_SYS_DDMS/'
---

<!-- markdownlint-disable MD025 -->

# Huawei Cloud DDM
<!-- markdownlint-enable -->

'The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These metrics reflect the performance and reliability of DDMS in handling large-scale message passing and real-time data streams.'


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud `DDM` monitoring data, we install the corresponding collection script: Guance integration (Huawei Cloud - `SYS.DDMS` collection) (ID: `startup__guance_huaweicloud_ddm`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud project ID.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations; for more details, see the Metrics section.


### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. On the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration.

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ddm_active_connections_average | Average active connections | userId,instanceId | Average,Maximum | Count |
| ddm_bytes_in_average | Average bytes received per second | userId,instanceId | Average,Maximum | Bytes/second |
| ddm_bytes_out_average | Average bytes sent per second | userId,instanceId | Average,Maximum | Bytes/second |
| ddm_cpu_util_average | Average CPU utilization | userId,instanceId | Average,Maximum | Percentage |
| ddm_qps_average | Average queries per second | userId,instanceId | Average,Maximum | Times/second |
| ddm_node_status_alarm_code_average | Average node status alarm code | userId,instanceId | Average,Maximum | Count |
| ddm_write_count_average | Average writes per second | userId,instanceId | Average,Maximum | Times/second |
| ddm_rt_avg_average | Average response time | userId,instanceId | Average,Maximum | ms |


## Objects {#object}

The object data structure collected from Huawei Cloud **SYS.DDMS** can be viewed in 「Infrastructure - Custom」.

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