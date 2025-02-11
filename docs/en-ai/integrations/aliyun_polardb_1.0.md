---
title: 'Alibaba Cloud PolarDB Distributed 1.0'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Distributed 1.0 displays metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Built-in views for Alibaba Cloud PolarDB Distributed 1.0'
    path: 'dashboard/en/aliyun_polardb_1.0/'

monitor:
  - desc: 'Monitors for Alibaba Cloud PolarDB Distributed 1.0'
    path: 'monitor/en/aliyun_polardb_1.0/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Distributed 1.0
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Distributed 1.0 displays metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from Alibaba Cloud PolarDB Distributed 1.0, install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB-X 1.0 Collection)」(ID: `guance_aliyun_polardbx_1`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Once enabled, you can see the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then check the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}

### Verification

1. Confirm in 「Management / Automatic Trigger Configuration」that the corresponding tasks have the appropriate automatic trigger configurations. You can also view task records and logs to check for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, verify if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data is present.

## Metrics {#metric}
After configuring Alibaba Cloud PolarDB Distributed 1.0, the default metric set is as follows. You can collect more metrics by configuring them further [Alibaba Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_drds/drds){:target="_blank"}


| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`LogicQPS`| Average logical requests per second|         Average         |    count     |
|`PhysicsQPS`| Average physical requests per second|         Average         |    count     |
|`NetworkInputTraffic`| Network input traffic|         Average         |    bit/s     |
|`NetworkOutputTraffic`| Network output traffic|         Average         |    bit/s     |
|`ConnectionCount`| Number of connections|     Average,Maximum     |    count     |
|`MemoryUtilization`| Memory usage rate      |         Average         |      %       |
|`CPUUtilization`| CPU usage rate                    |     Average,Maximum     |      %       |
|`cpu_usage`| Private RDS_MySQL CPU utilization                   |     Average,Maximum     |      %       |
|`disk_usage`| Private RDS_MySQL disk usage rate                   |     Average,Maximum     |      %       |
|`mem_usage`| Private RDS_MySQL memory utilization|     Average,Maximum     |      %       |
|`iops_usage`| Private RDS_MySQL IOPS utilization|         Average         |      %       |
|`input_traffic_ps`| Private RDS_MySQL inbound network bandwidth |         Average         |    bits/s    |
|`output_traffic_ps`| Private RDS_MySQL outbound network bandwidth|    Average              |  bits/s      |


## Objects {#object}
The collected Alibaba Cloud PolarDB Distributed 1.0 object data structure can be viewed in 「Infrastructure - Custom」

``` json
{
  "measurement": "aliyun_polardbx_1",
  "tags": {
    "account_name"                     : "Aliyun",
    "class"                            : "aliyun_polardbx_1",
    "Description"                      : "xxxxx",
    "DrdsInstanceId"                   : "xxxxx",
    "RegionId"                         : "cn-hangzhou",
    "name"                             : "xxxxx",
    "NetworkType"                      : "CLASSIC",
    "OrderInstanceId"                  : "xxxxx",
    "ProductVersion"                   : "V1",
    "Status"                           : "RUN",
    "Type"                             : "PRIVATE",
  }
}
```