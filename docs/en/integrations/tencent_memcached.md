---
title: 'Tencent Cloud Memcached'
tags: 
  - Tencent Cloud
summary: 'Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud'
__int_icon: 'icon/tencent_memcached'
dashboard:

  - desc: 'Tencent Cloud Memcached Monitoring View'
    path: 'dashboard/zh/tencent_memcached'

monitor:
  - desc: 'Tencent Cloud Memcached Monitor'
    path: 'monitor/zh/tencent_memcached'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Memcached
<!-- markdownlint-enable -->

Use the 「Guance Synchronization」 series of script packages in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare Aliyun AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection script：「Guance Integration（Tencent Cloud - Memcached Collect）」(ID：`guance_tencentcloud_memcached`)

Click 【Install】 and enter the corresponding parameters: Aliyun AK, Aliyun account name.。

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

> If you want to collect logs, you must enable the corresponding log collection script. If you want to collect bills, start the cloud bill collection script.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-memcached/){:target="_blank"}

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure Tencent Cloud OSS monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Tencent Cloud Monitor Metrics Details](https://cloud.tencent.com/document/product/248/62458){:target="_blank"}


| Metric Name  | meaning                                 |   unit  | Dimension                 |
|-----------------|-----------------------------------------|  ----- |--------------------|
| `allocsize`     | Allocated capacity space                |  MBytes    | InstanceName(Instance Name) |
| `usedsize`      | Used capacity space                     |  MBytes    |InstanceName(Instance Name)）      |
| `get`           | GET command execution times per second  |   Count/s   | InstanceName(Instance Name)     |
| `set`           | SETT command execution times per second | Count/s   | InstanceName(Instance Name)     |
| `delete`        | Number of times the DELETE command is executed per second                        |   Count/s   | InstanceName(Instance Name)     |
| `error`         | bad command                                   |       Count/s   | InstanceName(Instance Name)    |
| `latency`       | Average access latency                                 |  ms   | InstanceName(Instance Name)   |
| `qps`           | Total number of requests                                  |    Count/s | InstanceName(Instance Name)     |
## Object {#object}

The collected Tencent Cloud Memcached object data structure can be seen from the "Infrastructure - Custom" object data

```json
{
  "measurement": "tencentcloud_memcached",
  "tags": {
    "account_name": "Tencent",
    "class": "tencentcloud_memcached",
    "cloud_provider": "tencentcloud",
    "InstanceId": "cmem-xxxxx",
    "InstanceName": "0829-mh-xxxxx",
    "name": "cmem-xxxxxxx",
    "RegionId": "ap-shanghai"
  }
}
```

> *Note: The fields in `tags` may change with subsequent updates*
