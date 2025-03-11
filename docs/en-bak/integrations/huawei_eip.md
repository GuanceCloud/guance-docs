---
title: 'Huawei Cloud EIP'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud EIP metric data'
__int_icon: 'icon/huawei_eip'
dashboard:
  - desc: 'Huawei Cloud EIP Built in View'
    path: 'dashboard/en/huawei_eip/'

monitor:
  - desc: 'Huawei Cloud EIP Monitor'
    path: 'monitor/en/huawei_eip/'
---

Collect Huawei Cloud EIP metric data.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically,Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> Recommend deploying GSE (Game Server Engine) edition translation.

### Installation script

> Tip:Please prepare a Huawei Cloud AK that meets the requirements in advance (For simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of Huawei Cloud EIP, we install the corresponding collection script: 「Guance Cloud Integration (Huawei Cloud EIP Collection)」 (ID: `guance_huaweicloud_eip`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

Tap【Deploy startup Script】, the system automatically creates `Startup` script sets, and automatically configure the corresponding startup script.

After installing the script, find the script 「Guance Cloud Integration (Huawei Cloud EIP Collection)」 in the 「Development」 section of Func. Expand and modify the script, find collector_configs and monitor_configs, and edit the content in region_projects below. Change the region and Project ID to the actual region and Project ID, and then click save and publish.

In addition, in「Management / Automatic Trigger Configuration」 you can see the corresponding automatic trigger configuration. Click 【Execute】 to run it immediately, without waiting for the scheduled time. After a short moment, you can check the execution task records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the guance cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the guance cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Collect Huawei Cloud EIP metrics to collect more metrics through configuration [Huawei Cloud EIP Metric Details](https://support.huaweicloud.com/usermanual-vpc/vpc010012.html){:target="_blank)

| **MetricID** | **MetricName** | **MetricMeaning** | **ValueRange** | **Measurement object** | **Monitoring Period (Raw Metric)** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `upstream_bandwidth`            |   Outbound bandwidth    |This indicator is used to calculate the network speed of the test object's cloud platform (originally the upstream bandwidth). Unit: bits per second  | ≥ 0 bit/s  | Bandwidth or Elastic Public IP | 1 miniute |
| `downstream_bandwidth`            |   Network bandwidth    |This indicator is used to calculate the network speed of the test object entering the cloud platform (the original indicator was downlink bandwidth). Unit: bits per second  | ≥ 0 bit/s  | Bandwidth or Elastic Public IP | 1 miniute |
| `upstream_bandwidth_usage`            |   Outbound bandwidth utilization rate    |This indicator is used to measure the bandwidth utilization rate of the cloud platform of the measurement object, measured in percentage units. Outbound bandwidth utilization rate=Outbound bandwidth indicator/purchased bandwidth size   | 0-100%  | Bandwidth or Elastic Public IP | 1 miniute |
| `downstream_bandwidth_usage`            |   Network bandwidth utilization rate  |This indicator is used to calculate the bandwidth usage rate of the measured object on the cloud platform, measured in percentage units. Network bandwidth utilization rate=Network bandwidth indicator/purchased bandwidth size   | 0-100%  | Bandwidth or Elastic Public IP | 1 miniute |
| `up_stream`            |   Outbound traffic    |This indicator is used to calculate the accumulated network traffic of the test object on the cloud platform within one minute (the original indicator was upstream traffic). Unit: Byte | ≥ 0 bytes  | Bandwidth or Elastic Public IP | 1 miniute |
| `down_stream`            |   Network traffic    |This indicator is used to calculate the accumulated network traffic of the test object within one minute of entering the cloud platform (the original indicator was downlink traffic). Unit: Byte   | ≥ 0 bytes  | Bandwidth or Elastic Public IP | 1 miniute |

## Object {#object}

After normal data synchronization, the data can be viewed in the 「Infrastructure/Custom (Objects)」 section of the observation cloud.

```json
{
  "measurement": "huaweicloud_eip",
  "tags": {
    "RegionId"                : "cn-south-1",
    "project_id"              : "756ada1aa17e4049b2a16ea41912e52d",
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

> *Note: Fields in `tags` and `fields` may change with subsequent updates*
>
> Tip 1: The value of 'tags.eip_id' is the EIP ID, which serves as the unique identifier
>
> Tip 2：`Status` is the state corresponding to VPC
>
