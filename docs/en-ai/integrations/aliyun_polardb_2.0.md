---
title: 'Alibaba Cloud PolarDB Distributed 2.0'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Distributed 2.0 displays metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage, disk utilization rate, memory utilization, network bandwidth, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud PolarDB Distributed 2.0'
    path: 'dashboard/en/aliyun_polardb_2.0/'

monitor:
  - desc: 'Monitors for Alibaba Cloud PolarDB Distributed 2.0'
    path: 'monitor/en/aliyun_polardb_2.0/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Distributed 2.0
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Distributed 2.0 displays metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage, disk utilization rate, memory utilization, network bandwidth, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): All prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from PolarDB Distributed 2.0, install the corresponding collection script: "Guance Integration (Alibaba Cloud-PolarDB-X 2.0 Collection)" (ID: `guance_aliyun_polardbx_2`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK ID, Alibaba Cloud AK SECRET, and Account Name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the startup script accordingly.

Once enabled, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}

### Verification

1. Confirm in "Management / Automatic Trigger Configuration" whether the corresponding tasks have been configured for automatic triggers, and check the task records and logs for any anomalies.
2. In the Guance platform, check under "Infrastructure / Custom" to see if asset information exists.
3. In the Guance platform, under "Metrics", check if the corresponding monitoring data exists.

## Metrics {#metric}
After configuring Alibaba Cloud PolarDB Distributed 2.0, the default metric sets are as follows. You can collect more metrics through configuration.

[Alibaba Cloud Monitoring - Native Distributed Database PolarDB-X 2.0 Compute Node Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_drds/polardb-x_v2){:target="_blank"}
[Alibaba Cloud Monitoring - Native Distributed Database PolarDB-X 2.0 Storage Node Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_drds/polardbx_v2_dn){:target="_blank"}

### Compute Node Metrics

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveConnectionsOfCN`| Active connections of PolarDB-X compute layer |         Sum         |    count     |
|`CPUUsageOfCN`| CPU usage of PolarDB-X compute layer |         Average         |    %     |
|`ConnectionsOfCN`| Number of connections of PolarDB-X compute layer |         Sum         |    count    |
|`ErrorCountOfCN`| Error count of PolarDB-X compute layer |         Sum         |    count/s     |
|`FullGcTimeOfCN`| Full GC time of PolarDB-X |     Sum     |    nanoseconds     |
|`LogicRTOfCN`| Logical response time of PolarDB-X compute layer      |         Average         |      μs       |
|`LogicRequestCountOfCN`| Logical request count of PolarDB-X compute layer                   |     Sum     |     req/s    |
|`LogicSlowOfCN`| Logical slow SQL count of PolarDB-X compute layer                  |     Sum     |     req/s       |
|`MemUsageOfCN`| Memory usage of PolarDB-X compute layer                  |     Average     |      %       |
|`NetInOfCN`| Network traffic (in) of PolarDB-X compute layer |   Sum    |      B/s       |
|`NetOutOfCN`| Network traffic (out) of PolarDB-X compute layer|         Sum         |      B/s       |

### Storage Node Metrics

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveSessionsOfDN`| Active sessions of PolarDB-X storage node |         Average         |    count    |
|`CPUUsageOfDN`| CPU usage of PolarDB-X storage node |         Average         |    %     |
|`ConnUsageOfDN`| Connection usage of PolarDB-X storage node |         Average         |    %    |
|`DiskSizeOfDN`| Disk usage of PolarDB-X storage node |         Average         |    Megabytes     |
|`DiskUsageOfDN`| Disk usage rate of PolarDB-X storage node |     Average     |    %     |
|`IOPSUsageOfDN`| IOPS usage rate of PolarDB-X storage node     |         Average         |      %       |
|`IbufDirtyRatioOfDN`| Buffer pool dirty page percentage of PolarDB-X storage node                   |     Average     |     %    |
|`IbufReadHitOfDN`| Buffer pool read hit rate of PolarDB-X storage node                  |     Average     |     %      |
|`IbufUseRatioOfDN`| Buffer pool usage rate of PolarDB-X storage node                  |     Average     |      %       |
|`LogDiskSizeOfDN`| Log disk usage of PolarDB-X storage node |   Average    |      Megabytes      |
|`MemUsageOfDN`| Memory usage of PolarDB-X storage node |         Average         |      %       |
|`NetworkInDN`| Network inbound bandwidth of PolarDB-X storage node |         Average         |     bits/s      |
|`NetworkOutDN`| Network outbound bandwidth of PolarDB-X storage node |         Average         |     bits/s     |
|`SlaveLagOfDN`| Replica delay of PolarDB-X storage node |         Average         |      seconds       |
|`SlowQueriesOfDN`| Slow query count per second of PolarDB-X storage node |         Average         |      countSecond       |
|`TempDiskTableCreatesOfDN`| Temporary table creation count per second of PolarDB-X storage node |         Average         |    countSecond       |
|`ThreadsConnectedOfDN`| Thread connection count of PolarDB-X storage node |         Average         |      count      |
|`ThreadsRunningOfDN`| Active thread count of PolarDB-X storage node |         Average         |      count      |
|`TmpDiskSizeOfDN`| Temporary disk usage of PolarDB-X storage node |         Average         |     Megabytes      |

## Objects {#object}
The object data structure collected from Alibaba Cloud PolarDB Distributed 2.0 can be viewed under "Infrastructure - Custom".

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
    "message"               : "{instance JSON data}}",
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of tags.name is the instance ID, used for unique identification.
>
> Tip 2: Fields.message are all JSON serialized strings.