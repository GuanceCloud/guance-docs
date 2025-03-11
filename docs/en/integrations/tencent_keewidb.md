---
title: 'Tencent Cloud KeeWiDB'
tags: 
  - Tencent Cloud
summary: 'Tencent Cloud KeeWiDB metrics display, including connections, requests, cache, keys, slow queries, etc.'
__int_icon: 'icon/tencent_keewidb'
dashboard:

  - desc: 'Tencent Cloud KeeWiDB built-in views'
    path: 'dashboard/en/tencent_keewidb'

monitor:
  - desc: 'Tencent Cloud KeeWiDB monitor'
    path: 'monitor/en/tencent_keewidb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud KeeWiDB
<!-- markdownlint-enable -->


Tencent Cloud KeeWiDB metrics display, including connections, requests, cache, keys, slow queries, etc.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only access `ReadOnlyAccess`)

Synchronize the monitoring data of Tencent Cloud KeeWiDB by installing the corresponding collection script:「Guance Integration (Tencent Cloud-KeeWiDB Collection)」(ID: `guance_tencentcloud_keewidb`)

Click 【Install】, then enter the required parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy and Start Script】. The system will automatically create a `Startup` script set and configure the startup script accordingly.

Additionally, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; see the metrics section for details [Customize cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-keewidb/){:target="_blank"}



### Verification

1. Confirm in 「Manage / Automatic Trigger Configuration」whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if there is asset information.
3. In the Guance platform, under 「Metrics」, check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud KeeWiDB, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Tencent Cloud KeeWiDB Instance Monitoring

| Metric Name        | Metric Description       | Explanation                                                     | Unit  | Dimensions                      | Statistical Granularity                         |
| ------------------ | ------------------------ | --------------------------------------------------------------- | ----- | ------------------------------- | ----------------------------------------------- |
| `KeeCpuUtil`       | CPU Utilization          | CPU utilization of KeeWiDB nodes                                | %     | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| Connections        | Connection Count         | Number of TCP connections to the instance                       | Count | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| ConnectionsUtil    | Connection Utilization   | Percentage of actual TCP connections to maximum connections     | %     | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeCommands        | Total Requests           | QPS, number of commands executed per second                     | Times/sec | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeCmdRead         | Read Requests            | Number of read commands executed per second                     | Times/sec | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeCmdWrite        | Write Requests           | Number of write commands executed per second                    | Times/sec | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeCmdOtherKee     | Other Requests           | Number of command executions outside read/write commands        | Count | `instanceid`、`keewidbnodeid`   | 5s、60s、300s、3600s、86400s                   |
| KeeCmdSlow         | Slow Queries             | Number of commands with execution latency greater than `slowlog-log-slower-than` configuration | Count | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| CmdErr             | Execution Errors         | Number of Proxy command execution errors per second, e.g., non-existent commands, parameter errors | Times/sec | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| `KeeKeyspaceHitUtil` | Cache Hit Rate          | Proportion of requested data found in the cache. Cache hit rate = cache hits / total requests | %     | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeKeys            | Total Keys               | Total number of keys stored in the instance (first-level keys)  | Count | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeExpireKeys      | Expired Keys             | Number of keys evicted within the time window, corresponding to the expired_keys output of the info command | Count/sec | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeDiskUsed        | Disk Usage               | Used disk capacity                                             | MB    | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeDiskUtil        | Disk Utilization         | Percentage of used disk capacity to maximum capacity            | %     | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |
| KeeDiskIops        | Disk IOPS Usage          | Number of disk input/output operations per second               | Times/sec | `instanceid`                    | 5s、60s、300s、3600s、86400s                   |

## Objects {#object}
The collected Tencent Cloud KeeWiDB object data structure can be viewed in 「Infrastructure-Custom」

```json
{
  "measurement": "tencentcloud_redis",
  "tags": {
    "name"        : "crs-xxxx",
    "BillingMode" : "0",
    "Engine"      : "Redis",
    "InstanceId"  : "crs-xxxx",
    "InstanceName": "solution",
    "Port"        : "6379",
    "ProductType" : "standalone",
    "ProjectId"   : "0",
    "RegionId"    : "ap-shanghai",
    "Status"      : "2",
    "Type"        : "6",
    "WanIp"       : "172.x.x.x",
    "ZoneId"      : "200002"
  },
  "fields": {
    "ClientLimits"    : "10000",
    "Createtime"      : "2022-07-14 13:54:14",
    "DeadlineTime"    : "0000-00-00 00:00:00",
    "InstanceNodeInfo": "{Instance node information}",
    "InstanceTitle"   : "Running",
    "Size"            : 1024,
    "message"         : "{Instance JSON data}"
  }
}
```

Some parameter explanations are as follows

| Field          | Type | Explanation                                                         |
| :------------ | :--- | :----------------------------------------------------------- |
| `Status`      | str  | Current status of the instance. 0: Pending initialization. 1: Instance in process. 2: Instance running. -2: Instance isolated. -3: Instance pending deletion. |
| `ProductType` | str  | Product type. standalone: Standard edition. cluster: Cluster edition. |
| `BillingMode` | str  | Billing mode. 0: Pay-as-you-go. 1: Prepaid. |
| `ProjectId`   | str  | Project ID |
| `NodeSet`     | str  | Detailed information of the instance nodes. Note: This field may return null, indicating no valid value. |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Tip 1: `tags.name` value is the instance ID, serving as unique identification.
> Tip 2: `fields.message` is a JSON serialized string.
