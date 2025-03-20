---
title: 'Huawei Cloud SYS.DDMS Monitoring View'
tags: 
  - Huawei Cloud
summary: 'The Huawei Cloud SYS.DDMS monitoring view displays indicators including message throughput, latency, concurrent connections, and reliability, which reflect the performance and reliability assurance of DDMS in handling large-scale message delivery and real-time data flow.'
__int_icon: 'icon/huaweiyun_SYS_DDMS'
dashboard:

  - desc: 'huaweiyun SYS.DDMS Dashboard'  
    path: 'dashboard/zh/huaweiyun_SYS_DDMS'

monitor:
  - desc: 'huaweiyun SYS.DDMS'
    path: 'monitor/zh/huaweiyun_SYS_DDMS'

---

<!-- markdownlint-disable MD025 -->
# Huawei Cloud `SYS.DDMS`
<!-- markdownlint-enable -->

The Huawei Cloud `SYS.DDMS` monitoring view displays indicators including message throughput, latency, concurrent connections, and reliability, which reflect the performance and reliability assurance of `DDMS` in handling large-scale message delivery and real-time data flow

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Installation script

> Tip：Please prepare Huawei Cloud AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data `SYS.DDMS`, install the corresponding data collection script: "Observation Cloud Integration (Huawei Cloud `SYS.DDMS`)" (ID: `startup__guance_huaweicloud_ddm`).

Click 【Install】 and enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click [Deploy Startup Scripts], the system will automatically create the `Startup` script set and automatically configure the corresponding startup scripts.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.


### Verify

1. Check whether the automatic triggering configuration exists for the corresponding task in "Management / Crontab Config". Additionally, you can review task records and logs to identify any exceptions.
2. On the <<< custom_key.brand_name >>> platform, go to "Infrastructure / Custom" to verify the presence of asset information.
3. Press "Metrics" on the <<< custom_key.brand_name >>> platform to confirm the availability of monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default indicator set is as follows, and more indicators can be collected through configuration

| Metric Id                      | Metric Name                    | Dimensions        | Statistics      | Unit     |
| -------------------- | ------------------- | ------------------------------------------------------- | ---- | ---------- |
| ddm_active_connections_average | Average number of active connections | userId,instanceId | Average,Maximum | Count |
| ddm_bytes_in_average | Average number of bytes received per second | userId,instanceId | Average,Maximum | Bytes/s |
| ddm_bytes_out_average | Average number of bytes sent per second | userId,instanceId | Average,Maximum | Bytes/s |
| ddm_cpu_util_average | Average CPU utilization | userId,instanceId | Average,Maximum | % |
| ddm_qps_average | The average query rate per second | userId,instanceId | Average,Maximum | Count/s |
| ddm_node_status_alarm_code_average | Average alarm code for node status | userId,instanceId | Average,Maximum | Count    |
| ddm_write_count_average | Average number of writes per second | userId,instanceId | Average,Maximum | Count/s |
| ddm_rt_avg_average | The average value of the average response time | userId,instanceId | Average,Maximum | ms |

## Objects {#object}

The collected Huawei Cloud `SYS.DDMS` object data structure can be viewed from "Infrastructure / Custom".

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

