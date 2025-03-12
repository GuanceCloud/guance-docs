---
title: 'Aliyun PolarDB distributed2.0'
tags: 
  - Alibaba Cloud
summary: 'Aliyun PolarDB distributed2.0 displays metrics of the computing layer and storage nodes, including CPU usage, connection usage, disk usage, disk usage, memory usage, and network bandwidth.'
__int_icon: 'icon/aliyun_polardb_2.0'
dashboard:
  - desc: 'Aliyun PolarDB distributed2.0 dashboard'
    path: 'dashboard/zh/aliyun_polardb_2.0/'

monitor:
  - desc: 'Aliyun PolarDB distributed2.0 monitor'
    path: 'monitor/zh/aliyun_polardb_2.0/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun PolarDB distributed2.0
<!-- markdownlint-enable -->

Aliyun PolarDB distributed2.0 displays metrics of the computing layer and storage nodes, including CPU usage, connection usage, disk usage, disk usage, memory usage, and network bandwidth.

## Config {#config}

### Install Func

Recommend opening [ Integrations - Extension - DataFlux Func (Automata) ]: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip: Please prepare AWS AK that meets the requirements in advance (For simplicity's sake, you can directly grant the global read-only permission for CloudWatch `CloudWatchReadOnlyAccess`)

To synchronize the monitoring data of PolarDB distributed 2.0 cloud resources, we install the corresponding collection [ Guance Integration（Aliyun-PolarDB-X 1.0Collect）] (ID: `guance_aliyun_polardbx_2`)

Click [Install] and enter the corresponding parameters: Aliyun AK ID, Aliyun AK SECRET and Account Name.

Tap [Deploy startup Script],The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

Then, in the collection script, add the collector_Configs and cloudwatch_Change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in [Management / Crontab Config]. Click[Run],you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-2/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
After Configure Aliyun PolarDB distributed 2.0 monitoring, the default metric set is as follows. You can collect more metrics by configuring them

 [Aliyun PolarDB distributed 2.0 compute node metric details](https://cms.console.aliyun.com/metric-meta/acs_drds/polardb-x_v2){:target="_blank"}

 [Aliyun PolarDB distributed 2.0 storage node metric details](https://cms.console.aliyun.com/metric-meta/acs_drds/polardbx_v2_dn){:target="_blank"}

### Compute node index

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveConnectionsOfCN`| PolarDB-X Calculate the number of active connections at the layer |         Sum         |    count     |
|`CPUUsageOfCN`| PolarDB-X CPU usage at the computing layer |         Average         |    %     |
|`ConnectionsOfCN`| PolarDB-X Calculate the number of layer connections |         Sum         |    count    |
|`ErrorCountOfCN`| PolarDB-X Calculate the number of layer errors |         Sum         |    count/s     |
|`FullGcTimeOfCN`| PolarDB-X Full GC time |     Sum     |    nanoseconds     |
|`LogicRTOfCN`| PolarDB-X Calculates the logical response time of the layer      |         Average         |      μs       |
|`LogicRequestCountOfCN`| PolarDB-X Calculates the number of layer logical requests                   |     Sum     |     req/s    |
|`LogicSlowOfCN`| PolarDB-X Compute layer logic slow SQL              |     Sum     |     req/s       |
|`MemUsageOfCN`| PolarDB-X Computing layer memory usage                  |     Average     |      %       |
|`NetInOfCN`| PolarDB-X Computing layer network traffic (forward) |   Sum    |      B/s       |
|`NetOutOfCN`| PolarDB-X Computing layer network traffic (out) |         Sum         |      B/s       |

### Storage node specifications

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveSessionsOfDN`| PolarDB-X ActiveSessions of storage nodes  | Average         |    count     |
|`CPUUsageOfDN`| PolarDB-X CPU usage of the storage node |         Average         |    %     |
|`ConnUsageOfDN`| PolarDB-X Connection usage of storage nodes |         Average         |    %    |
|`DiskSizeOfDN`| PolarDB-X Disk usage of a storage node |         Average         |    Megabytes     |
|`DiskUsageOfDN`| PolarDB-X Disk usage of a storage node |     Average     |    %     |
|`IOPSUsageOfDN`| PolarDB-X Storage node IOPS usage    |         Average         |      %       |
|`IbufDirtyRatioOfDN`| PolarDB-X Percentage of BP dirty pages on a storage node                |     Average     |     %    |
|`IbufReadHitOfDN`| PolarDB-X BP read hit ratio of storage node                |     Average     |     %      |
|`IbufUseRatioOfDN`| PolarDB-X BP usage ratio of storage nodes                |     Average     |      %       |
|`LogDiskSizeOfDN`| PolarDB-X Storage node log disk usage |   Average    |      Megabytes      |
|`MemUsageOfDN`| PolarDB-X Memory usage of a storage node |         Average         |      %       |
|`NetworkInDN`| PolarDB-X Bandwidth of the storage node network |         Average         |     bits/s      |
|`NetworkOutDN`| PolarDB-X Outgoing bandwidth of the storage node network |         Average         |     bits/s     |
|`SlaveLagOfDN`| PolarDB-X The standby storage node library is delayed |         Average         |      seconds       |
|`SlowQueriesOfDN`| PolarDB-X Slow query number of storage nodes per second |         Average         |      countSecond       |
|`TempDiskTableCreatesOfDN`| PolarDB-X Number of temporary tables created by storage nodes per second |         Average         |    countSecond       |
|`ThreadsConnectedOfDN`| PolarDB-X Number of threads connected to a storage node |         Average         |      count      |
|`ThreadsRunningOfDN`| PolarDB-X Number of active threads on a storage node |         Average         |      count      |
|`TmpDiskSizeOfDN`| PolarDB-X Temporary disk usage of a storage node |         Average         |     Megabytes      |


## Object {#object}

The collected Aliyun PolarDB distributed 2.0  object data structure can be seen from the [ Infrastructure - Custom]  object data.

``` json
{
  "measurement": "aliyun_polardbx_2",
  "tags": {
    "ClassCode"             : "",
    "CommodityCode"         : "drds_polarxpost_public_cn",
    "DBInstanceName"        : "pxc-s-hzr1ch4n3icc3w",
    "DBType"                : "polarx",
    "DnNodeClassCode"       : "mysql.n2.medium.25",
    "Engine"                : "polarx",
    "Id"                    : "pxc-xdb-s-shzr1ch4n3icc3wbf04",
    "LockMode"              : "Unlock",
    "MinorVersion"          : "polarx-kernel_standard_xcluster-20230508",
    "Network"               : "VPC",
    "NodeClass"             : "mysql.n2.medium.25",
    "PayType"               : "Postpaid",
    "Series"                : "standard",
    "Status"                : "Running",
    "Type"                  : "ReadWrite",
    "VPCId"                 : "vpc-bp1uhj8mimgturv8c0gg6",
    "ZoneId"                : "cn-hangzhou-k;cn-hangzhou-k;cn-hangzhou-k",
    "name"                  : "pxc-xdb-s-shzr1ch4n3icc3wbf04"
  },
  "fields": {
    "CnNodeCount"           : 0,
    "CreateTime"            : "2023-08-16T06:57:41.000+0000",
    "Description"           : "",
    "DnNodeCount"           : 1,
    "ExpireTime"            : "2123-08-16T16:00:00.000+0000",
    "Expired"               : false,
    "NodeCount"             : 1,
    "ReadDBInstances"       : "[]",
    "ResourceGroupId"       : "rg-acfmv3ro3xnfwaa",
    "StorageUsed"           : 2343567360,
    "message"               : "{Instance json data}}",
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates*
> > Tip: tags.name value is the instance ID as a unique identification.
> > Tip 2: fields.message are JSON serialized strings.
