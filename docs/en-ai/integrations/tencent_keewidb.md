---
title: 'Tencent Cloud KeeWiDB'
tags: 
  - Tencent Cloud
summary: 'Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc.'
__int_icon: 'icon/tencent_keewidb'
dashboard:

  - desc: 'Tencent Cloud KeeWiDB Built-in View'
    path: 'dashboard/en/tencent_keewidb'

monitor:
  - desc: 'Tencent Cloud KeeWiDB Monitor'
    path: 'monitor/en/tencent_keewidb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud KeeWiDB
<!-- markdownlint-enable -->


Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

Synchronize the monitoring data of Tencent Cloud KeeWiDB by installing the corresponding collection script:「Guance Integration (Tencent Cloud-KeeWiDB Collection)」(ID: `guance_tencentcloud_keewidb`)

Click 【Install】, then input the required parameters: Tencent Cloud AK and Tencent Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create the `Startup` script set and configure the corresponding startup script.

Additionally, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-keewidb/){:target="_blank"}


### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding tasks have been configured for automatic triggers and check the task records and logs for any anomalies.
2. On the Guance platform, under 「Infrastructure / Custom」check if there is asset information.
3. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud KeeWiDB, the default metric set is as follows. You can collect more metrics through configuration. [Tencent Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Tencent Cloud KeeWiDB Instance Monitoring

| Metric Name         | Metric Description       | Metric Explanation                                                     | Unit  | Dimensions                      | Statistical Granularity                         |
| ------------------ | ---------------- | ------------------------------------------------------------ | ----- | ------------------------- | -------------------------------- |
| `KeeCpuUtil`       | CPU Utilization       | CPU utilization of KeeWiDB nodes                                      | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| Connections        | Number of Connections         | Number of TCP connections to the instance                                      | Count    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| ConnectionsUtil    | Connection Utilization       | Percentage of actual TCP connections to maximum connections                            | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCommands        | Total Requests           | QPS, number of commands executed per second                                      | Times/Second | `instanceid`               | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdRead         | Read Requests           | Number of read commands executed per second                                           | Times/Second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdWrite        | Write Requests           | Number of write commands executed per second                                           | Times/Second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdOtherKee     | Other Requests         | Number of command executions other than read/write                                   | Count    | `instanceid`、`keewidbnodeid` | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdSlow         | Slow Queries           | Number of commands executed with latency greater than `slowlog` - log - slower - than    | Count    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| CmdErr             | Execution Errors         | Number of Proxy command execution errors per second, such as non-existent commands, parameter errors, etc. | Times/Second | `instanceid`               | 5s、 60s、 300s、 3600s、 86400s |
| `KeeKeyspaceHitUtil` | Cache Hit Rate       | The proportion of requested data found in the cache. Cache hit rate = cache hits / total requests | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeKeys            | Total Number of Keys        | Total number of keys stored in the instance (first-level keys)                            | Count    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeExpireKeys      | Expired Keys        | Number of keys evicted within the time window, corresponding to the expired_keys output of the info command | Count/Second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskUsed        | Disk Usage       | Used disk capacity                                           | MB    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskUtil        | Disk Utilization       | Percentage of used disk capacity to maximum capacity                           | %     | `instanceid`                | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskIops        | Disk IOPS Usage   | Number of disk I/O operations per second.                             | Times/Second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |

## Objects {#object}
The collected Tencent Cloud KeeWiDB object data structure can be seen in the 「Infrastructure-Custom」section.

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
    "InstanceNodeInfo": "{Instance Node Information}",
    "InstanceTitle"   : "Running",
    "Size"            : 1024,
    "message"         : "{Instance JSON Data}"
  }
}
```

Some parameter explanations are as follows

| Field          | Type | Explanation                                                         |
| :------------ | :--- | :----------------------------------------------------------- |
| `Status`      | str  | Current status of the instance. 0: Pending initialization. 1: Instance in process. 2: Instance running. -2: Instance isolated. -3: Instance pending deletion. |
| `ProductType` | str  | Product type. standalone ：Standard Edition. cluster ：Cluster Edition.          |
| `BillingMode` | str  | Billing mode. 0: Pay-as-you-go. 1: Monthly subscription.                       |
| `ProjectId`   | str  | Project ID                                                      |
| `NodeSet`     | str  | Detailed information about the instance's nodes. Note: This field may return null, indicating no valid value. |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Note 1: The value of `tags.name` is the instance ID, serving as a unique identifier.
> Note 2: `fields.message` is a JSON serialized string.