---
title: 'Huawei Cloud ECS'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_ecs'
dashboard:

  - desc: 'Built-in View for Huawei Cloud ECS'
    path: 'dashboard/en/huawei_ecs'

monitor:
  - desc: 'Huawei Cloud ECS Monitor'
    path: 'monitor/en/huawei_ecs'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud ECS
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages from the Script Market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from Huawei Cloud ECS, we install the corresponding collection script: "Guance Integration (Huawei Cloud-ECS Collection)" (ID: `guance_huaweicloud_ecs`)

Click 【Install】, then enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-ECS Collection)" under "Development" in Func, expand and modify this script, find `collector_configs` and `monitor_configs`, and edit the contents of `region_projects`. Change the region and Project ID to the actual ones, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a while, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see the Metrics section [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default Mearsurement sets are as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metrics Details](https://support.huaweicloud.com/usermanual-ecs/ecs_03_1003.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Description                                                     | Value Range      | Measurement Object (Dimension) | **Monitoring Period (Original Metric)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| cpu_usage                              | CPU Usage            | This metric measures the current CPU usage rate of the measurement object. Unit: Percentage. | 0-100%    | Cloud Server         | 1 minute                                             |
| load_average1                              | 1-Minute Average Load    | This metric measures the average CPU load over the past 1 minute of the measurement object. | ≥ 0%          | Cloud Server         | 1 minute                                             |
| load_average5                      | 5-Minute Average Load    | This metric measures the average CPU load over the past 5 minutes of the measurement object. | ≥ 0%          | Cloud Server         | 1 minute                                             |
| load_average15                  | 15-Minute Average Load   | This metric measures the average CPU load over the past 15 minutes of the measurement object. | ≥ 0 Byte/s    | Cloud Server         | 1 minute                                             |
| mem_usedPercent                 | Memory Usage     | This metric measures the memory usage rate of the measurement object. Unit: Percentage | 0-100% | Cloud Server         | 1 minute                                             |
| net_bitSent               | Incoming Bandwidth   | This metric measures the number of bits received per second by the network card of the measurement object. Unit: bit/s | ≥ 0 bit/s | Cloud Server         | 1 minute                                             |
| net_bitRecv              | Outgoing Bandwidth       | This metric measures the number of bits sent per second by the network card of the measurement object. Unit: bit/s | ≥ 0 bit/s | Cloud Server         | 1 minute                                            |
| net_packetSent    | Network Card Packet Send Rate | This metric measures the number of packets sent per second by the network card of the measurement object. Unit: Counts/s | ≥ 0 Counts/s | Cloud Server         | 1 minute                                             |
| net_packetRecv    | Network Card Packet Receive Rate | This metric measures the number of packets received per second by the network card of the measurement object. Unit: Counts/s | ≥ 0 Counts/s | Cloud Server         | 1 minute                                             |
| net_tcp_established | TCP ESTABLISHED | This metric measures the number of TCP connections in the ESTABLISHED state of the measurement object. Unit: Count | ≥ 0 | Cloud Server         | 1 minute                                             |
| net_tcp_total | TCP TOTAL | This metric measures the total number of TCP connections in all states of the measurement object. Unit: Count | ≥ 0 | Cloud Server         | 1 minute                                             |
| disk_usedPercent                | Disk Usage     | This metric measures the disk usage rate of the measurement object, in percentage. Calculation method: Used storage / Total storage. Unit: Percentage | 0-100%     | Cloud Server - Mount Point | 1 minute                                             |
| disk_free               | Free Disk Storage | This metric measures the remaining storage space of the disk of the measurement object. Unit: GB | ≥0 GB      | Cloud Server - Mount Point | 1 minute                                             |
| disk_ioUtils              | Disk I/O Usage | This metric measures the disk I/O usage rate of the measurement object. Unit: Percentage | 0-100%     | Cloud Server - Disk Cloud Server - Mount Point | 1 minute                                             |
| disk_inodes_UsedPercent                    | **inode** Usage Ratio | This metric measures the ratio of used inodes on the disk of the measurement object. Unit: Percentage | 0-100%     | Cloud Server - Mount Point | 1 minute                                             |

## Objects {#object}

The structure of collected Huawei Cloud ECS object data can be viewed in "Infrastructure - Custom"

``` json
{
  "measurement": "huaweicloud_ecs",
  "tags": {
    "name"                       : "xxxxx",
    "status"                     : "ACTIVE",
    "id"                         : "xxxxx",
    "OS-EXT-AZ:availability_zone": "cn-southeast-1",
    "project_id"                 : "xxxxxxx",
    "vpc_id"                     : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
    "instance_name"              : "ecs-3384",
    "charging_mode"              : "0",
    "resource_spec_code"         : "sn3.small.1.linux",
    "resource_type"              : "1",
    "metadata_os_type"           : "Linux",
    "RegionId"                   : "cn-north-4"
  },
  "fields": {
    "hostId"                              : "1e122315dac18163814b9e0d0fc6xxxxxx",
    "created"                             : "2022-06-16T10:13:24Z",
    "description"                         : "{JSON Data}",
    "addresses"                           : "{IP JSON Data}",
    "os-extended-volumes:volumes_attached": "{JSON Data}",
    "message"                             : "{Instance JSON Data}"
  }
}
```

Descriptions of some parameters are as follows:

| Parameter Name             | Description                   |
| :------------------- | :--------------------- |
| `resource_spec_code` | Resource Specification               |
| `resource_type`      | Resource Type of Cloud Server |

Values of `charging_mode` (Cloud Server Billing Mode):

| Value | Description                                  |
| :--- | :------------------------------------ |
| `0`  | Pay-as-you-go (i.e., postPaid - pay after use)    |
| `1`  | Subscription (i.e., prePaid - prepaid) |
| `2`  | Spot Instance Billing                          |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: The values and meanings of `status` are listed in the appendix of Cloud Server Status.