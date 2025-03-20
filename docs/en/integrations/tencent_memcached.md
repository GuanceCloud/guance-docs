---
title: 'Tencent Cloud Memcached'
tags: 
  - Tencent Cloud
summary: 'Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/tencent_memcached'
dashboard:

  - desc: 'Tencent Cloud Memcached built-in views'
    path: 'dashboard/en/tencent_memcached'

monitor:
  - desc: 'Tencent Cloud Memcached monitors'
    path: 'monitor/en/tencent_memcached'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Memcached
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Memcached cloud resources, we install the corresponding collection script: "Guance Integration (Tencent Cloud-Memcached Collection)" (ID: `guance_tencentcloud_memcached`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Start Script】, the system will automatically create a `Startup` script set and automatically configure the corresponding start script.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

We default to collecting some configurations, for details see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-memcached/){:target="_blank"}

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

After configuring Tencent Cloud - Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration [Tencent Cloud Cloud Monitoring Metrics Details](https://cloud.tencent.com/document/product/248/62458){:target="_blank"}


| Metric English Name      | Meaning           |   Unit  | Dimensions                 |
| --------------- | ---------------------- |  ----- |--------------------|
| `allocsize`       | Allocated capacity space            |  MBytes    | InstanceName (Instance Name) |
| `usedsize`         | Used capacity space            |  MBytes    |InstanceName (Instance Name)      |
| `get`       | Number of GET commands executed per second           |   Count/s   | InstanceName (Instance Name)     |
| `set`       | Number of SET commands executed per second           | Count/s   | InstanceName (Instance Name)     |
| `delete`        | Number of DELETE commands executed per second        |   Count/s   | InstanceName (Instance Name)     |
| `error`       | Error commands           |       Count/s   | InstanceName (Instance Name)     |
| `latency`      | Average access latency       |  ms   | InstanceName (Instance Name)    |
| `qps`           | Total number of requests         |    Count/s | InstanceName (Instance Name)     |

## Objects {#object}

The collected Tencent Cloud Memcached object data structure can be viewed from "Infrastructure - Custom"

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