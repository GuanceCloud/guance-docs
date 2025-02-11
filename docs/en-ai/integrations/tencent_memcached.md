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
  - desc: 'Tencent Cloud Memcached monitor'
    path: 'monitor/en/tencent_memcached'

---

<!-- markdownlint-disable MD025 -->
# Tencent Cloud Memcached
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare a Tencent Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize monitoring data for Memcached cloud resources, we install the corresponding collection script: "Guance Integration (Tencent Cloud-Memcached Collection)" (ID: `guance_tencentcloud_memcached`)

After clicking 【Install】, enter the corresponding parameters: Tencent Cloud AK, Tencent Cloud account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set and configure the corresponding start scripts.

Once enabled, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

We have collected some configurations by default; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-tencentcloud-memcached/){:target="_blank"}

### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

After configuring Tencent Cloud-Cloud Monitoring, the default metric set is as follows. You can collect more metrics through configuration. [Details of Tencent Cloud Cloud Monitoring Metrics](https://cloud.tencent.com/document/product/248/62458){:target="_blank"}

| Metric Name      | Meaning           | Unit  | Dimensions                 |
| --------------- | ---------------------- |  ----- |--------------------|
| `allocsize`       | Allocated capacity space            |  MBytes    | InstanceName (Instance Name) |
| `usedsize`         | Used capacity space            |  MBytes    | InstanceName (Instance Name)      |
| `get`       | Number of GET commands executed per second            |   Count/s   | InstanceName (Instance Name)     |
| `set`       | Number of SET commands executed per second            | Count/s   | InstanceName (Instance Name)     |
| `delete`        | Number of DELETE commands executed per second         |   Count/s   | InstanceName (Instance Name)     |
| `error`       | Number of error commands            |       Count/s   | InstanceName (Instance Name)     |
| `latency`      | Average access latency       |  ms   | InstanceName (Instance Name)    |
| `qps`           | Total number of requests         |    Count/s | InstanceName (Instance Name)     |

## Objects {#object}

The structure of the collected Tencent Cloud Memcached object data can be viewed under "Infrastructure - Custom"

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