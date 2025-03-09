---
title: 'Huawei Cloud ECS'
tags: 
  - Huawei Cloud
summary: 'Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/huawei_ecs'
dashboard:

  - desc: 'Built-in views for Huawei Cloud ECS'
    path: 'dashboard/en/huawei_ecs'

monitor:
  - desc: 'Huawei Cloud ECS Monitor'
    path: 'monitor/en/huawei_ecs'

---


<!-- markdownlint-disable MD025 -->
# Huawei Cloud ECS
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud ECS monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-ECS Collection)" (ID: `guance_huaweicloud_ecs`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK, Huawei Cloud account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-ECS Collection)" under "Development" in Func, expand and modify this script, find `collector_configs` and `monitor_configs`, and edit the content of `region_projects` below, changing the region and Project ID to the actual region and Project ID, then click Save and Publish.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

By default, we collect some configurations. For more details, see the metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding task has an automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Huawei Cloud Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Huawei Cloud Cloud Monitoring Metric Details](https://support.huaweicloud.com/usermanual-ecs/ecs_03_1003.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object (Dimension) | **Monitoring Period (Original Metric)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| cpu_usage                              | CPU Usage            | This metric measures the current CPU usage rate of the measurement object. Unit: percentage. | 0-100%    | Cloud Server         | 1 minute                                             |
| load_average1                              | 1-Minute Average Load    | This metric measures the average CPU load over the past 1 minute. | ≥ 0%          | Cloud Server         | 1 minute                                             |
| load_average5                      | 5-Minute Average Load    | This metric measures the average CPU load over the past 5 minutes. | ≥ 0%          | Cloud Server         | 1 minute                                             |
| load_average15                  | 15-Minute Average Load   | This metric measures the average CPU load over the past 15 minutes. | ≥ 0 Byte/s    | Cloud Server         | 1 minute                                             |
| mem_usedPercent                 | Memory Usage     | This metric measures the memory usage rate of the measurement object. Unit: percentage | 0-100% | Cloud Server         | 1 minute                                             |
| net_bitSent               | Incoming Bandwidth   | This metric measures the number of bits received by the network interface per second. Unit: bit/s | ≥ 0 bit/s | Cloud Server         | 1 minute                                             |
| net_bitRecv              | Outgoing Bandwidth       | This metric measures the number of bits sent by the network interface per second. Unit: bit/s | ≥ 0 bit/s | Cloud Server         | 1 minute                                            |
| net_packetSent    | Network Interface Packet Send Rate | This metric measures the number of packets sent by the network interface per second. Unit: Counts/s | ≥ 0 Counts/s | Cloud Server         | 1 minute                                             |
| net_packetRecv    | Network Interface Packet Receive Rate | This metric measures the number of packets received by the network interface per second. Unit: Counts/s | ≥ 0 Counts/s | Cloud Server         | 1 minute                                             |
| net_tcp_established | TCP ESTABLISHED | This metric measures the number of TCP connections in the ESTABLISHED state. Unit: Count | ≥ 0 | Cloud Server         | 1 minute                                             |
| net_tcp_total | TCP TOTAL | This metric measures the total number of TCP connections in all states. Unit: Count | ≥ 0 | Cloud Server         | 1 minute                                             |
| disk_usedPercent                | Disk Usage     | This metric measures the disk usage rate of the measurement object, in percentage. Calculation method: used storage / total storage. Unit: percentage | 0-100%     | Cloud Server - Mount Point | 1 minute                                             |
| disk_free               | Free Disk Space | This metric measures the remaining storage space on the disk. Unit: GB | ≥0 GB      | Cloud Server - Mount Point | 1 minute                                             |
| disk_ioUtils              | Disk I/O Usage | This metric measures the disk I/O usage rate. Unit: percentage | 0-100%     | Cloud Server - Disk Cloud Server - Mount Point | 1 minute                                             |
| disk_inodes_UsedPercent                    | **inode** Used Ratio | This metric measures the percentage of used inodes on the disk. Unit: percentage | 0-100%     | Cloud Server - Mount Point | 1 minute                                             |

## Objects {#object}

The structure of the collected Huawei Cloud ECS object data can be viewed under "Infrastructure - Custom"

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
    "description"                         : "{JSON data}",
    "addresses"                           : "{IP JSON data}",
    "os-extended-volumes:volumes_attached": "{JSON data}",
    "message"                             : "{Instance JSON data}"
  }
}
```

Explanation of some parameters:

| Parameter Name             | Description                   |
| :------------------- | :--------------------- |
| `resource_spec_code` | Resource specification               |
| `resource_type`      | Resource type corresponding to the cloud server |

`charging_mode` (Cloud server billing type) value meanings:

| Value | Description                                  |
| :--- | :------------------------------------ |
| `0`  | Pay-as-you-go (i.e., postPaid - pay after use)    |
| `1`  | Subscription (i.e., prePaid - prepaid) |
| `2`  | Spot instance billing                          |

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Note 1: The value of `tags.name` is the instance ID, used as a unique identifier.
>
> Note 2: The values and meanings of `status` can be found in the appendix on cloud server status.