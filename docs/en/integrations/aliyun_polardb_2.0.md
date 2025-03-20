---
title: 'Alibaba Cloud PolarDB Distributed 2.0'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Distributed 2.0 displays Metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage volume, disk usage rate, memory utilization, network bandwidth, etc.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Alibaba Cloud PolarDB Distributed 2.0 built-in views'
    path: 'dashboard/en/aliyun_polardb_2.0/'

monitor:
  - desc: 'Alibaba Cloud PolarDB Distributed 2.0 monitors'
    path: 'monitor/en/aliyun_polardb_2.0/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Distributed 2.0
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Distributed 2.0 displays Metrics for the compute layer and storage nodes, including CPU utilization, connection usage, disk usage volume, disk usage rate, memory utilization, network bandwidth, etc.

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data of PolarDB Distributed 2.0, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB-X 2.0 Collection)」(ID: `guance_aliyun_polardbx_2`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK ID, Alibaba Cloud AK SECRET, and Account Name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After it is enabled, you can see the corresponding automatic trigger configuration in 「Manage / Automatic Trigger Configuration」. Click 【Execute】to immediately execute once without waiting for the regular time. Wait for a moment, and you can view the execution task records and corresponding logs.

We have collected some configurations by default, details can be found in the Metrics section [Customize cloud object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}


### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under 「Infrastructure / Custom」check if there is any asset information.
3. On the Guance platform, under 「Metrics」check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud PolarDB Distributed 2.0, the default Measurement sets are as follows, and more Metrics can be collected through configuration.

[Alibaba Cloud Cloud Monitoring - Cloud Native Distributed Database PolarDB-X 2.0 Compute Node Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_drds/polardb-x_v2){:target="_blank"}
[Alibaba Cloud Cloud Monitoring - Cloud Native Distributed Database PolarDB-X 2.0 Storage Node Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_drds/polardbx_v2_dn){:target="_blank"}

### Compute Node Metrics

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveConnectionsOfCN`| PolarDB-X compute layer active connection count |         Sum         |    count     |
|`CPUUsageOfCN`| PolarDB-X compute layer CPU usage rate |         Average         |    %     |
|`ConnectionsOfCN`| PolarDB-X compute layer connection count |         Sum         |    count    |
|`ErrorCountOfCN`| PolarDB-X compute layer error count |         Sum         |    count/s     |
|`FullGcTimeOfCN`| PolarDB-X Full GC time |     Sum     |    nanoseconds     |
|`LogicRTOfCN`| PolarDB-X compute layer logical response time      |         Average         |      μs       |
|`LogicRequestCountOfCN`| PolarDB-X compute layer logical request count                   |     Sum     |     req/s    |
|`LogicSlowOfCN`| PolarDB-X compute layer logical slow SQL                  |     Sum     |     req/s       |
|`MemUsageOfCN`| PolarDB-X compute layer memory usage rate                  |     Average     |      %       |
|`NetInOfCN`| PolarDB-X compute layer network traffic (in) |   Sum    |      B/s       |
|`NetOutOfCN`| PolarDB-X compute layer network traffic (out)|         Sum         |      B/s       |

### Storage Node Metrics

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveSessionsOfDN`| PolarDB-X storage node ActiveSessions |         Average         |    count    |
|`CPUUsageOfDN`| PolarDB-X storage node CPU usage rate |         Average         |    %     |
|`ConnUsageOfDN`| PolarDB-X storage node connection usage rate |         Average         |    %    |
|`DiskSizeOfDN`| PolarDB-X storage node disk usage volume |         Average         |    Megabytes     |
|`DiskUsageOfDN`| PolarDB-X storage node disk usage rate |     Average     |    %     |
|`IOPSUsageOfDN`| PolarDB-X storage node IOPS usage rate     |         Average         |      %       |
|`IbufDirtyRatioOfDN`| PolarDB-X storage node BP dirty page percentage                   |     Average     |     %    |
|`IbufReadHitOfDN`| PolarDB-X storage node BP read hit rate                  |     Average     |     %      |
|`IbufUseRatioOfDN`| PolarDB-X storage node BP usage rate                  |     Average     |      %       |
|`LogDiskSizeOfDN`| PolarDB-X storage node log disk usage volume |   Average    |      Megabytes      |
|`MemUsageOfDN`| PolarDB-X storage node memory usage rate |         Average         |      %       |
|`NetworkInDN`| PolarDB-X storage node network inbound bandwidth |         Average         |     bits/s      |
|`NetworkOutDN`| PolarDB-X storage node network outbound bandwidth |         Average         |     bits/s     |
|`SlaveLagOfDN`| PolarDB-X storage node standby delay |         Average         |      seconds       |
|`SlowQueriesOfDN`| PolarDB-X storage node slow queries per second |         Average         |      countSecond       |
|`TempDiskTableCreatesOfDN`| PolarDB-X storage node temporary tables created per second |         Average         |    countSecond       |
|`ThreadsConnectedOfDN`| PolarDB-X storage node thread connections |         Average         |      count      |
|`ThreadsRunningOfDN`| PolarDB-X storage node active threads |         Average         |      count      |
|`TmpDiskSizeOfDN`| PolarDB-X storage node temporary disk usage volume |         Average         |     Megabytes      |


## Objects {#object}
The Alibaba Cloud PolarDB Distributed 2.0 object data structure collected can be viewed under 「Infrastructure - Custom」

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
    "message"               : "{instance json data}}",
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of tags.name is the instance ID, used as unique identification.
>
> Tip 2: The fields.message are all JSON serialized strings.