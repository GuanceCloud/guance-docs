---
title: 'Huawei Cloud EIP'
tags:
  - Huawei Cloud
summary: 'Collect Huawei Cloud EIP Metrics data'
__int_icon: 'icon/huawei_eip'
dashboard:
  - desc: 'Huawei Cloud EIP built-in views'
    path: 'dashboard/en/huawei_eip/'

monitor:
  - desc: 'Huawei Cloud EIP monitors'
    path: 'monitor/en/huawei_eip/'
---

Collect Huawei Cloud EIP Metrics data.

## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> It is recommended to deploy the GSE version

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud EIP monitoring data, we install the corresponding collection script: 「Guance Integration (Huawei Cloud-EIP Collection)」(ID: `guance_huaweicloud_eip`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script 「Guance Integration (Huawei Cloud-EIP Collection)」in the "Development" section of Func, expand and modify this script. Find `collector_configs` and `monitor_configs` respectively and edit the content under `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in the 「Management / Automatic Trigger Configuration」. Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」confirm whether the corresponding task has an automatic trigger configuration, and at the same time, you can view the corresponding task records and logs to check for any anomalies.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」check if there is asset information.
3. On the Guance platform, in 「Metrics」check if there are corresponding monitoring data.

## Metrics {#metric}

Collect Huawei Cloud EIP metrics, you can collect more metrics through configuration [Huawei Cloud EIP Metric Details](https://support.huaweicloud.com/usermanual-vpc/vpc010012.html){:target="_blank"}

|   **Metric ID**  |   **Metric Name**   |  **Metric Meaning** |  **Value Range**  | **Measurement Object** | **Monitoring Period (Original Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `upstream_bandwidth`            |   Outgoing Bandwidth    |This metric is used to count the network speed out of the cloud platform for the test object (the original metric is upstream bandwidth). Unit: bits/second   | ≥ 0 bit/s  | Bandwidth or Elastic Public IP | 1 minute             |
| `downstream_bandwidth`            |   Incoming Bandwidth    |This metric is used to count the network speed into the cloud platform for the test object (the original metric is downstream bandwidth). Unit: bits/second   | ≥ 0 bit/s  | Bandwidth or Elastic Public IP | 1 minute             |
| `upstream_bandwidth_usage`            |   Outgoing Bandwidth Usage    |This metric is used to count the bandwidth usage rate out of the cloud platform for the measurement object, in percentage units. Outgoing Bandwidth Usage = Outgoing Bandwidth Metric / Purchased Bandwidth Size   | 0-100%  | Bandwidth or Elastic Public IP | 1 minute             |
| `downstream_bandwidth_usage`            |   Incoming Bandwidth Usage   |This metric is used to count the bandwidth usage rate into the cloud platform for the measurement object, in percentage units. Incoming Bandwidth Usage = Incoming Bandwidth Metric / Purchased Bandwidth Size   | 0-100%  | Bandwidth or Elastic Public IP | 1 minute             |
| `up_stream`            |   Outgoing Traffic    |This metric is used to count the cumulative network traffic out of the cloud platform for the test object within one minute (the original metric is upstream traffic). Unit: bytes  | ≥ 0 bytes  | Bandwidth or Elastic Public IP    | 1 minute        |
| `down_stream`          |   Incoming Traffic    |This metric is used to count the cumulative network traffic into the cloud platform for the test object within one minute (the original metric is downstream traffic). Unit: bytes   | ≥ 0 bytes  | Bandwidth or Elastic Public IP | 1 minute            |

## Objects {#object}

After the data is synchronized normally, you can view the data in the 「Infrastructure - Resource Catalog」of Guance.

```json
{
  "measurement": "huaweicloud_eip",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17e4049b2a16ea41912e52d",
    "enterprise_project_id"   : "0824ss-xxxx-xxxx-xxxx-12334fedffg",
    "alias"                   : "xxxxxx",
    "eip_id"                  : "01fbb835-6b7f-41e9-842c-xxxxx0bc0s49e9",
    "eip_name"                : "xxxx",
    "public_ip_address"       : "123.xx.xx.210",
    "public_ipv6_address"     : "3773b058-5b4f-xxxx-9035-9bbd9964714a",
    "status"                  : "DOWN",
    "associate_instance_type" : "EVPN",
    "associate_instance_id"   : "053xxx-xxx-41xx-b24d-909ed9fcbfe1",
  },
  "fields": {
    "type"            : "EIP",
    "description"     : "VPN CREATE EIP",
    "created_at"      : "2024-11-09T15:28:46",
    "updated_at"      : "2024-11-11T08:15:58Z",
    "bandwidth"       : "{JSON data}",
    "tags"            : "[]"
  }
}
```

> *Note: The fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.eip_id` is the EIP ID, used as unique identification.
>
> Tip 2: `status` represents the status of the VPC.