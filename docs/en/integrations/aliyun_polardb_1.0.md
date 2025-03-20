---
title: 'Alibaba Cloud PolarDB Distributed 1.0'
tags: 
  - Alibaba Cloud
summary: 'Alibaba Cloud PolarDB Distributed 1.0 Metrics include CPU utilization, memory utilization, network bandwidth, and disk IOPS.'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: 'Alibaba Cloud PolarDB Distributed 1.0 built-in views'
    path: 'dashboard/en/aliyun_polardb_1.0/'

monitor:
  - desc: 'Alibaba Cloud PolarDB Distributed 1.0 monitors'
    path: 'monitor/en/aliyun_polardb_1.0/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud PolarDB Distributed 1.0
<!-- markdownlint-enable -->

Alibaba Cloud PolarDB Distributed 1.0 Metrics include CPU utilization, memory utilization, network bandwidth, and disk IOPS.

## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Installation Script

> Note: Please prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant the global read-only permission `ReadOnlyAccess`).

To synchronize the monitoring data of PolarDB Distributed 1.0, we install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (Alibaba Cloud-PolarDB-X 1.0 Collection)" (ID: `guance_aliyun_polardbx_1`)

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK and Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

We collect some configurations by default. For details, see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs for any anomalies.
2. On the <<< custom_key.brand_name >>> platform, in "Infrastructure / Custom", check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Alibaba Cloud PolarDB Distributed 1.0, the default metric sets are as follows. You can collect more metrics through configuration [Alibaba Cloud Monitoring Metric Details](https://cms.console.aliyun.com/metric-meta/acs_drds/drds){:target="_blank"}


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
The collected Alibaba Cloud PolarDB Distributed 1.0 object data structure can be seen in the "Infrastructure-Custom" objects data.

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