---
title: 'Huawei Cloud EIP'
tags:
  - Huawei Cloud
summary: 'Collect Huawei Cloud EIP Metrics data'
__int_icon: 'icon/huawei_eip'
dashboard:
  - desc: 'Huawei Cloud EIP built-in view'
    path: 'dashboard/en/huawei_eip/'

monitor:
  - desc: 'Huawei Cloud EIP monitor'
    path: 'monitor/en/huawei_eip/'
---

Collect Huawei Cloud EIP Metrics data.

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/)

> We recommend deploying the GSE version.

### Install Script

> Note: Prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize Huawei Cloud EIP monitoring data, install the corresponding collection script: 「Guance Integration (Huawei Cloud-EIP Collection)」(ID: `guance_huaweicloud_eip`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once the script is installed, find the script 「Guance Integration (Huawei Cloud-EIP Collection)」under "Development" in Func, expand and modify this script, edit the contents of `region_projects` under `collector_configs` and `monitor_configs`, change the region and Project ID to the actual values, then click Save and Publish.

Additionally, view the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.

### Verification

1. Confirm the corresponding task exists under 「Management / Automatic Trigger Configuration」, and check the task records and logs for any anomalies.
2. In the Guance platform, check if asset information exists under 「Infrastructure / Custom」.
3. In the Guance platform, check if the corresponding monitoring data exists under 「Metrics」.

## Metrics {#metric}

You can collect more Huawei Cloud EIP metrics by configuring additional settings. Refer to the [Huawei Cloud EIP Metrics Details](https://support.huaweicloud.com/usermanual-vpc/vpc010012.html){:target="_blank"}

| **Metric ID** | **Metric Name** | **Metric Meaning** | **Value Range** | **Measurement Object** | **Monitoring Period (Original Metric)** |
| --- | --- | --- | --- | --- | --- |
| `upstream_bandwidth` | Outbound Bandwidth | This metric measures the network speed out of the cloud platform (original metric is upstream bandwidth). Unit: bits/second | ≥ 0 bit/s | Bandwidth or Elastic Public IP | 1 minute |
| `downstream_bandwidth` | Inbound Bandwidth | This metric measures the network speed into the cloud platform (original metric is downstream bandwidth). Unit: bits/second | ≥ 0 bit/s | Bandwidth or Elastic Public IP | 1 minute |
| `upstream_bandwidth_usage` | Outbound Bandwidth Usage | This metric measures the bandwidth usage rate out of the cloud platform, in percentage. Outbound Bandwidth Usage = Outbound Bandwidth Metric / Purchased Bandwidth Size | 0-100% | Bandwidth or Elastic Public IP | 1 minute |
| `downstream_bandwidth_usage` | Inbound Bandwidth Usage | This metric measures the bandwidth usage rate into the cloud platform, in percentage. Inbound Bandwidth Usage = Inbound Bandwidth Metric / Purchased Bandwidth Size | 0-100% | Bandwidth or Elastic Public IP | 1 minute |
| `up_stream` | Outbound Traffic | This metric measures the cumulative network traffic out of the cloud platform within one minute (original metric is upstream traffic). Unit: bytes | ≥ 0 bytes | Bandwidth or Elastic Public IP | 1 minute |
| `down_stream` | Inbound Traffic | This metric measures the cumulative network traffic into the cloud platform within one minute (original metric is downstream traffic). Unit: bytes | ≥ 0 bytes | Bandwidth or Elastic Public IP | 1 minute |

## Objects {#object}

After data synchronization is successful, you can view the data in the 「Infrastructure / Custom (Object)」section of Guance.

```json
{
  "measurement": "huaweicloud_eip",
  "tags": {
    "RegionId": "cn-south-1",
    "project_id": "756ada1aa17e4049b2a16ea41912e52d",
    "alias": "xxxxxx",
    "eip_id": "01fbb835-6b7f-41e9-842c-xxxxx0bc0s49e9",
    "eip_name": "xxxx",
    "public_ip_address": "123.xx.xx.210",
    "public_ipv6_address": "3773b058-5b4f-xxxx-9035-9bbd9964714a",
    "status": "DOWN",
    "associate_instance_type": "EVPN",
    "associate_instance_id": "053xxx-xxx-41xx-b24d-909ed9fcbfe1"
  },
  "fields": {
    "type": "EIP",
    "description": "VPN CREATE EIP",
    "created_at": "2024-11-09T15:28:46",
    "updated_at": "2024-11-11T08:15:58Z",
    "bandwidth": "{JSON data}",
    "tags": "[]"
  }
}
```

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.eip_id` is the EIP ID, used as a unique identifier.
>
> Tip 2: `status` refers to the status of the VPC.