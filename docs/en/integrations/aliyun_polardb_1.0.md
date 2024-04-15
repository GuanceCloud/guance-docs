---
title: 'Aliyun  PolarDB 1.0'
summary: 'Aliyun PolarDB Distributed 1.0 displays metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.'   
__int_icon: 'icon/aliyun_polardb_1.0'
dashboard:
  - desc: 'Aliyun PolarDB Distributed 1.0 Monitoring View'
    path: 'dashboard/zh/aliyun_polardb_1.0/'

monitor:
  - desc: 'Aliyun PolarDB Distributed 1.0 Monitor'
    path: 'monitor/zh/aliyun_polardb_1.0/'
---

<!-- markdownlint-disable MD025 -->
# Aliyun  PolarDB 1.0
<!-- markdownlint-enable -->

Aliyun PolarDB Distributed 1.0 displays metrics including CPU utilization, memory utilization, network bandwidth, and disk IOPS.

## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Aliyun -PolarDB-X 1.0Collect）」(ID：`guance_aliyun_polardbx_1`)

Click "Install" and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap "Deploy startup Script"，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure Ali Cloud - PolarDB. The default metric set is as follows. You can collect more metrics by configuring them [Aliyun Monitor Metrics Details](https://cms.console.aliyun.com/metric-meta/acs_drds/drds){:target="_blank"}

| Metric | Description                                |       Statistics        |     Unit     |
| ---- |--------------------------------------------|:-----------------------:|:------------:|
|`LogicQPS`| Average number of logical requests per second |         Average         |    count     |
|`PhysicsQPS`| Average number of physical requests per second |         Average         |    count     |
|`NetworkInputTraffic`| Network input quantity                     |         Average         |    bit/s     |
|`NetworkOutputTraffic`| Network output                             |         Average         |    bit/s     |
|`ConnectionCount`| Number of connections                      |     Average,Maximum     |    count     |
|`MemoryUtilization`| Memory usage rate                          |         Average         |      %       |
|`CPUUtilization`| CPU usage rate                             |     Average,Maximum     |      %       |
|`cpu_usage`| Private RDS_ MySQL CPU utilization|     Average,Maximum     |      %       |
|`disk_usage`| Private RDS_ MySQL disk usage rate|     Average,Maximum     |      %       |
|`mem_usage`| Private RDS_ MySQL memory utilization|     Average,Maximum     |      %       |
|`iops_usage`| Private RDS_ MySQL IOPS utilization rate|         Average         |      %       |
|`input_traffic_ps`| Private RDS_ MySQL network inflow bandwidth|         Average         |    bits/s    |
|`output_traffic_ps`| Private RDS_ MySQL network outflow bandwidth|    Average              |  bits/s      |

## Object {#object}
The collected Aliyun PolarDB 1.0 object data structure can see the object data from 「Infrastructure-Custom」

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

