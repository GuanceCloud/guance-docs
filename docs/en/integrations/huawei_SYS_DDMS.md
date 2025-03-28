---
title: 'Huawei Cloud DDM'
tags: 
  - Huawei Cloud
summary: 'The Huawei Cloud DDM monitoring view displays metrics including message throughput, latency, concurrent connections, and reliability. These Metrics reflect the performance and reliability of DDMS when handling large-scale messaging and real-time data streams.'
__int_icon: 'icon/huaweiyun_SYS_DDMS'
dashboard:
  - desc: 'Huawei Cloud DDM Monitoring View'
    path: 'dashboard/en/huaweiyun_SYS_DDMS/'
monitor:
  - desc: 'Huawei Cloud DDM Monitoring View'
    path: 'monitor/en/huaweiyun_SYS_DDMS/'
---

<!-- markdownlint-disable MD025 -->

# Huawei Cloud DDM
<!-- markdownlint-enable -->

'Huawei Cloud DDM Monitoring View displays Metrics including message throughput, latency, concurrent connections, and reliability. These Metrics reflect the performance and reliability of DDMS when handling large-scale messaging and real-time data streams.'


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of Huawei Cloud `DDM`, we install the corresponding collection script: <<< custom_key.brand_name >>> Integration (Huawei Cloud- `SYS.DDMS` collection) (ID: `startup__guance_huaweicloud_ddm`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud Project ID.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a while, you can check the execution task records and corresponding logs.

We collect some configurations by default, details are shown in the Metrics section.



### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud - Cloud Monitoring, the default Measurement set is as follows, and more Metrics can be collected through configuration.

| Metric Id                | Metric Name      | Dimensions        | Statistics      | Unit     |
| ---- | ---- | ---- | ---- | ---- |
| ddm_active_connections_average | Average number of active connections | userId,instanceId | Average,Maximum | Count |
| ddm_bytes_in_average | Average bytes received per second | userId,instanceId | Average,Maximum | Bytes/second |
| ddm_bytes_out_average | Average bytes sent per second | userId,instanceId | Average,Maximum | Bytes/second |
| ddm_cpu_util_average | Average CPU utilization | userId,instanceId | Average,Maximum | Percentage |
| ddm_qps_average | Average queries per second | userId,instanceId | Average,Maximum | Queries/second |
| ddm_node_status_alarm_code_average | Average node status alarm code | userId,instanceId | Average,Maximum | Count |
| ddm_write_count_average | Average write operations per second | userId,instanceId | Average,Maximum | Operations/second |
| ddm_rt_avg_average | Average response time | userId,instanceId | Average,Maximum | ms |



## Objects {#object}

The object data structure of Huawei Cloud **SYS.DDMS** collected can be seen in "Infrastructure - Custom".

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