---
title: 'Tencent KeeWiDB'
tags: 
  - Tencent Cloud
summary: 'Tencent Cloud KeeWiDB metric display includes metrics such as connection count, requests, cache, keys, and slow queries.'
__int_icon: 'icon/tencent_keewidb'
dashboard:

  - desc: 'Tencent KeeWiDB Built-in Dashboard'
    path: 'dashboard/zh/tencent_keewidb'

monitor:
  - desc: 'Tencent KeeWiDB Monitor'
    path: 'monitor/zh/tencent_keewidb'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud KeeWiDB
<!-- markdownlint-enable -->


Tencent Cloud KeeWiDB metric display includes metrics such as connection count, requests, cache, keys, and slow queries.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Tencent AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of KeeWiDB, we install the corresponding collection script：「Guance Integration（Tencent Cloud-KeeWiDB Collect）」(ID：`guance_tencentcloud_keewidb`)

Click 【Install】 and enter the corresponding parameters: Tencent AK, Tencent account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configuring Custom Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-keewidb/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Tencent Cloud Redis monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}


| Metric English Name       | Metric Chinese Name          | Metric Description                                                     | Unit  | Dimension       | Granularity                         |
| ---------------- | ------------------- | ------------------------------------------------------------ | ----- | ---------- | -------------------------------- |
| `KeeCpuUtil`       | CPU usage rate.         | KeeWiDB node CPU usage rate.                                 | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| Connections        | Connection count.       | Number of TCP connections received by the instance.          | item             | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| ConnectionsUtil    | Connection usage rate.  | Ratio of actual TCP connections to the maximum connection count. | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCommands        | Total requests.         | QPS (Queries Per Second), the number of command executions per second. | times per second | `instanceid`               | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdRead         | Read requests.          | Number of read command executions per second.                | times per second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdWrite        | Write requests.         | Number of write command executions per second.               | times per second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdOtherKee     | Other requests.         | Number of command executions other than read and write commands. | item             | `instanceid`、`keewidbnodeid` | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdSlow         | Slow queries.           | Number of command executions with an execution delay greater than the configured `slowlog` - log - slower - than setting. | item             | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| CmdErr             | Execution errors.       | Number of Proxy command execution errors per second, such as command not found, parameter errors, and other similar situations. | times per second | `instanceid`               | 5s、 60s、 300s、 3600s、 86400s |
| `KeeKeyspaceHitUtil` | Cache hit rate.         | Cache hit rate refers to the proportion of requests in which the requested data is found in the cache system. Cache hit rate = Cache hit count / Total request count. | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeKeys            | Total number of keys.   | Total number of first-level keys stored in the instance.     | item             | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeExpireKeys      | Number of expired keys. | Number of keys evicted within a time window, corresponding to the "expired_keys" value in the output of the "info" command. | times per second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskUsed        | Disk usage.             | Disk capacity already in use.                                | MB    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskUtil        | Disk usage rate.        | Ratio of the disk capacity already in use to the maximum capacity. | %     | `instanceid`                | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskIops        | Disk IOPS usage.        | Number of input-output operations per second on the disk.    | times per second | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |


## Object {#object}
The data structure of collected Tencent Cloud Redis object can be viewed in 'Infrastructure - Custom' where object data is available

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
    "InstanceNodeInfo": "{Instance节点信息}",
    "InstanceTitle"   : "Running",
    "Size"            : 1024,
    "message"         : "{Instance JSON data}"
  }
}

```



Partial parameter explanations are as follows:

| Field          | Type    | Description           |
| :------------ | :------ | :------------- |
| `Status`      | str  | Instance current status. 0: Pending initialization. 1: Instance in progress. 2: Instance running. -2: Instance isolated. -3: Instance pending deletion. |
| `ProductType` | str  | Product types. "standalone": Standard version. "cluster": Cluster version.          |
| `BillingMode` | str  | Billing mode. 0: Pay-as-you-go. 1: Subscription (monthly/yearly).                      |
| `ProjectId`   | str  | Project ID.                                                    |
| `NodeSet`     | str  | Detailed information of instance nodes. Note: This field may return null, indicating no valid values. |

> *Note: The fields in tags and fields may change in subsequent updates*
> Hint 1: The value of tags.name is the instance ID, which serves as a unique identifier
> Hint 2: The value of fields.message is a JSON-serialized string
