---
title: 'Alibaba Cloud PolarDB Distributed 1.0'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Distributed 1.0 displays Metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Built-in Views for Alibaba Cloud PolarDB Distributed 1.0'
    path: 'dashboard/en/aliyun_polardb_1.0/'

monitor:
  - desc: 'Monitors for Alibaba Cloud PolarDB Distributed 1.0'
    path: 'monitor/en/aliyun_polardb_1.0/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Distributed 1.0
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Distributed 1.0 displays Metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of PolarDB Distributed 1.0, we install the corresponding collection script: 「Guance Integration (Alibaba Cloud-PolarDB-X 1.0 Collection)」(ID: `guance_aliyun_polardbx_1`)

After clicking 【Install】, enter the required parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

By default, we collect some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}

### Verification

1. In 「Manage / Automatic Trigger Configuration」, confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs for any anomalies.
2. On the Guance platform, go to 「Infrastructure / Custom」 to check if asset information exists.
3. On the Guance platform, go to 「Metrics」 to check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud PolarDB Distributed 1.0, the default Measurement sets are as follows. More Metrics can be collected through configuration [Alibaba Cloud Monitoring Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_drds/drds){:target="_blank"}

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`LogicQPS`| Average logical requests per second|         Average         |    count     |
|`PhysicsQPS`| Average physical requests per second|         Average         |    count     |
|`NetworkInputTraffic`| Network input traffic|         Average         |    bit/s     |
|`NetworkOutputTraffic`| Network output traffic|         Average         |    bit/s     |
|`ConnectionCount`| Number of connections|     Average,Maximum     |    count     |
|`MemoryUtilization`| Memory usage      |         Average         |      %       |
|`CPUUtilization`| CPU usage                    |     Average,Maximum     |      %       |
|`cpu_usage`| Private RDS_MySQL CPU utilization                   |     Average,Maximum     |      %       |
|`disk_usage`| Private RDS_MySQL disk usage                   |     Average,Maximum     |      %       |
|`mem_usage`| Private RDS_MySQL memory utilization|     Average,Maximum     |      %       |
|`iops_usage`| Private RDS_MySQL IOPS utilization|         Average         |      %       |
|`input_traffic_ps`| Private RDS_MySQL inbound bandwidth |         Average         |    bits/s    |
|`output_traffic_ps`| Private RDS_MySQL outbound bandwidth|    Average              |  bits/s      |

## Objects {#object}
The object data structure of Alibaba Cloud PolarDB Distributed 1.0 can be viewed from 「Infrastructure-Custom」

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