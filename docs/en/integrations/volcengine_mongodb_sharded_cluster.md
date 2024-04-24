---
title: 'Volcengine MongoDB Sharded Cluster'
tags: 
  - `Volcengine`
summary: 'Volcengine MongoDB Sharded Cluster metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc.'
__int_icon: 'icon/volcengine_mongodb'
dashboard:
  - desc: 'Volcengine Sharded Cluster'
    path: 'dashboard/zh/volcengine_mongodb_sharded_cluster/'
---

<!-- markdownlint-disable MD025 -->
# `Volcengine` MongoDB Sharded Cluster
<!-- markdownlint-enable -->


`Volcengine` MongoDB Sharded Cluster metrics display,including CPU usage, memory usage, number of connections, latency, OPS, etc.


## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation script


> Tip：Please prepare `Volcengine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of **ECS** cloud resources, we install the corresponding collection script：「Guance Integration（`Volcengine` -**MongoDB Sharded Cluster** Collect）」(ID：`guance_volcengine_mongodb_sharded_cluster`)

Click "Install" and enter the corresponding parameters: `Volcengine` AK, `Volcengine` account name.

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-volcengine-monitor/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists


## Metric  {#metric}
Configure `Volcengine` - MongoDB Sharded Cluster monitoring. The default metric set is as follows. You can collect more metrics by configuring them [`Volcengine` MongoDB Replica Monitor Metrics Details](https://console.volcengine.com/cloud_monitor/metricDoc?tabKey=metric&namespace=VCM_MongoDB_Sharded_Cluster){:target="_blank"}


| Metric | Description                          | Unit |
| ---- |-------------------------------------| :----: |
|`CpuUtil` |CPU Usage|Percent|
|`MemUtil` |Mem Usage|Percent|
|`TotalDiskUtil` | Disk Usage |Percent|
|`CurrConn` | Current connections |Count|
|`DataDiskUsage`|Data disk usage|Bytes(SI)|
|`ReplicationDelay`|Main backup delay| Second |
|`GetmoreOperationPerSec`| GetMORE operations per second | Count/Second |
|`QueryOperationPerSec`|Query operations per second| Count/Second |
|`DeleteOperationPerSec`| Delete operations per second | Count/Second |
|`InsertOperationPerSec`| Insert operations per second | Count/Second|
|`UpdateOperationPerSec`| Update operations per second | Count/Second|
|`CommandOperationPerSec`|Command operations per second| Count/Second|

## Object  {#object}
The collected `Volcengine` Cloud **MongoDB** object data structure can see the object data from 「Infrastructure-Custom」

``` json
  {
    "category": "custom_object",
    "fields": {
      "NodeSpec": "rds.mysql.d1.n.1c1g",
      "TimeZone": "UTC +08:00",
      ...
    },
    "measurement": "volcengine_mongodb_replica_set",
    "tags": {
      "AllowListVersion": "initial",
      "DBEngineVersion": "MongoDB_5_7",
      "InstanceId": "mysql-xxx",
      "InstanceName": "mysql-xxx",
      "InstanceStatus": "Running",
      "InstanceType": "DoubleNode",
      "LowerCaseTableNames": "1",
      "NodeNumber": "2",
      "ProjectName": "default",
      "RegionId": "cn-beijing",
      "StorageSpace": "20",
      "StorageType": "LocalSSD",
      "SubnetId": "subnet-xxx",
      "VpcId": "vpc-xxx",
      "ZoneId": "cn-beijing-a",
      "name": "mysql-xxx"
    }
  }

```

