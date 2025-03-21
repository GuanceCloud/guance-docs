---
title: 'Tencent Cloud KeeWiDB'
tags: 
  - Tencent Cloud
summary: 'Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc.'
__int_icon: 'icon/tencent_keewidb'
dashboard:

  - desc: 'Tencent Cloud KeeWiDB Built-in Views'
    path: 'dashboard/en/tencent_keewidb'

monitor:
  - desc: 'Tencent Cloud KeeWiDB Monitors'
    path: 'monitor/en/tencent_keewidb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud KeeWiDB
<!-- markdownlint-enable -->


Tencent Cloud KeeWiDB Metrics Display, including connections, requests, cache, keys, slow queries, etc.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Expansion - DataFlux Func (Automata): all prerequisites will be automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare the required Tencent Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Tencent Cloud KeeWiDB, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Tencent Cloud-KeeWiDB Collection)" (ID: `guance_tencentcloud_keewidb`).

After clicking 【Install】, input the corresponding parameters: Tencent Cloud AK and Tencent Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

In addition, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default collect some configurations, details see the metrics section [Configuration Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-keewidb/){:target="_blank"}



### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and you can check the corresponding task records and logs to check for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Tencent Cloud KeeWiDB, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Tencent Cloud KeeWiDB Instance Monitoring

| Metric English Name | Metric Chinese Name | Metric Description                                                     | Unit | Dimensions                      | Statistical Granularity                         |
| ------------------- | ------------------- | --------------------------------------------------------------------- | ---- | ------------------------------- | --------------------------------------------- |
| `KeeCpuUtil`        | CPU Usage          | KeeWiDB node CPU usage rate                                           | %    | `instanceid`                    | 5s, 60s, 300s, 3600s, 86400s                 |
| Connections         | Number of Connections | Number of TCP connections received by the instance                     | Count | `instanceid`                    | 5s, 60s, 300s, 3600s, 86400s                 |
| ConnectionsUtil     | Connection Utilization | Proportion of actual TCP connections to maximum connection count       | %    | `instanceid`                    | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeCommands         | Total Requests      | QPS, number of commands executed per second                           | Times/second | `instanceid`                   | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeCmdRead          | Read Requests       | Number of read commands executed per second                           | Times/second | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeCmdWrite         | Write Requests      | Number of write commands executed per second                          | Times/second | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeCmdOtherKee      | Other Requests      | Number of command executions other than read/write commands           | Count | `instanceid`, `keewidbnodeid` | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeCmdSlow          | Slow Queries       | Number of commands with execution latency greater than `slowlog` - log - slower - than configuration | Count | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| CmdErr              | Execution Errors    | Number of Proxy command execution errors per second, such as non-existent commands, parameter errors, etc. | Times/second | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| `KeeKeyspaceHitUtil` | Cache Hit Rate     | The proportion of requested data found in the cache when using the caching system. Cache hit rate = number of cache hits / total number of requests | %    | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeKeys             | Total Keys         | Total number of Keys stored in the instance (first-level Keys)          | Count | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeExpireKeys       | Expired Keys       | Number of Keys evicted within the time window, corresponding to the expired_keys output from the info command | Times/second | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeDiskUsed         | Disk Usage         | Amount of disk space already used                                     | MB   | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeDiskUtil         | Disk Usage Rate    | Proportion of disk space already used to maximum capacity              | %    | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |
| KeeDiskIops         | Disk IOPS Usage    | Number of input/output operations performed per second on the disk       | Times/second | `instanceid`                  | 5s, 60s, 300s, 3600s, 86400s                 |

## Objects {#object}
The collected Tencent Cloud KeeWiDB object data structure can be seen in "Infrastructure - Custom"

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

Part of the parameter descriptions are as follows

| Field          | Type | Description                                                         |
| :------------ | :--- | :------------------------------------------------------------------ |
| `Status`      | str  | Current status of the instance. 0: Pending initialization. 1: Instance in process. 2: Instance running. -2: Instance isolated. -3: Instance pending deletion. |
| `ProductType` | str  | Product type. standalone: Standard Edition. cluster: Cluster Edition. |
| `BillingMode` | str  | Billing mode. 0: Pay-as-you-go. 1: Prepaid.                         |
| `ProjectId`   | str  | Project ID                                                          |
| `NodeSet`     | str  | Detailed information about the instance nodes. Note: This field may return null, indicating that no valid value can be obtained. |

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
> Tip 1: The value of `tags.name` is the instance ID, which serves as a unique identifier.
> Tip 2: `fields.message` is a JSON serialized string.