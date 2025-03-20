---
title: 'Huawei Cloud ECS'
tags: 
  - Huawei Cloud
summary: 'Collect Huawei Cloud ECS monitoring Metrics'
__int_icon: 'icon/huawe_ecs'
dashboard:

  - desc: 'Huawei Cloud ECS built-in views'
    path: 'dashboard/en/huawei_ecs'

monitor:
  - desc: 'Huawei Cloud ECS monitor'
    path: 'monitor/en/huawei_ecs'

---

Collect Huawei Cloud ECS monitoring Metrics

## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Please prepare a Huawei Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize Huawei Cloud ECS monitoring data, we install the corresponding collection script: "Guance Integration (Huawei Cloud-ECS Collection)" (ID: `guance_huaweicloud_ecs`)

After clicking 【Install】, enter the corresponding parameters: Huawei Cloud AK and Huawei Cloud account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script.

After the script is installed, find the script "Guance Integration (Huawei Cloud-ECS Collection)" under "Development" in Func, unfold and modify this script. Find `collector_configs` and `monitor_configs` respectively and edit the content of `region_projects`. Change the region and Project ID to the actual region and Project ID, then click Save and Publish.

In addition, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and you can also check the corresponding task records and logs for any abnormalities.
2. On the Guance platform, under "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}

Configure Huawei Cloud ECS Metrics, more Metrics can be collected through configuration [Huawei Cloud ECS Metric Details](https://support.huaweicloud.com/usermanual-ecs/ecs_03_1003.html){:target="_blank"}

| Metric ID                                | Metric Name             | Metric Meaning                                                     | Value Range      | Measurement Object (Dimension) | **Monitoring Cycle (Raw Metric)** |
| ------------------------------------- | -------------------- | ------------------------------------------------------------ | ------------- | ---------------- | ------------------------------------------------- |
| cpu_usage                              | CPU Usage Rate            | This metric is used to statistically measure the current CPU usage rate of the object. Unit: percentage. | 0-100%    | Cloud Server         | 1 minute                                             |
| load_average1                              | 1-minute Average Load    | This metric is used to statistically measure the average CPU load of the object over the past 1 minute. | ≥ 0%          | Cloud Server         | 1 minute                                             |
| load_average5                      | 5-minute Average Load    | This metric is used to statistically measure the average CPU load of the object over the past 5 minutes. | ≥ 0%          | Cloud Server         | 1 minute                                             |
| load_average15                  | 15-minute Average Load   | This metric is used to statistically measure the average CPU load of the object over the past 15 minutes. | ≥ 0 Byte/s    | Cloud Server         | 1 minute                                             |
| mem_usedPercent                 | Memory Usage Rate     | This metric is used to statistically measure the memory usage rate of the object. Unit: percentage | 0-100% | Cloud Server         | 1 minute                                             |
| net_bitSent               | Inbound Bandwidth   | This metric is used to statistically measure the number of bits received per second by the network card of the object. Unit: bit/s | ≥ 0 bit/s | Cloud Server         | 1 minute                                             |
| net_bitRecv              | Outbound Bandwidth       | This metric is used to statistically measure the number of bits sent per second by the network card of the object. Unit: bit/s | ≥ 0 bit/s | Cloud Server         | 1 minute                                            |
| net_packetSent    | Network Card Packet Sending Rate | This metric is used to statistically measure the number of packets sent per second by the network card of the object. Unit: Counts/s | ≥ 0 Counts/s | Cloud Server         | 1 minute                                             |
| net_packetRecv    | Network Card Packet Receiving Rate | This metric is used to statistically measure the number of packets received per second by the network card of the object. Unit: Counts/s | ≥ 0 Counts/s | Cloud Server         | 1 minute                                             |
| net_tcp_established | TCP ESTABLISHED | This metric is used to statistically measure the number of TCP connections of the object in ESTABLISHED state. Unit: Count | ≥ 0 | Cloud Server         | 1 minute                                             |
| net_tcp_total | TCP TOTAL | This metric is used to statistically measure the total number of TCP connections of the object in all states. Unit: Count | ≥ 0 | Cloud Server         | 1 minute                                             |
| disk_usedPercent                | Disk Usage Rate     | This metric is used to statistically measure the disk usage rate of the object, in percentage. Calculation method: Used disk storage / Total disk storage. Unit: percentage | 0-100%     | Cloud Server - Mount Point | 1 minute                                             |
| disk_free               | Free Disk Storage | This metric is used to statistically measure the remaining storage space of the object's disk. Unit: GB | ≥0 GB      | Cloud Server - Mount Point | 1 minute                                             |
| disk_ioUtils              | Disk I/O Usage Rate | This metric is used to statistically measure the disk I/O usage rate of the object. Unit: percentage | 0-100%     | Cloud Server - Disk Cloud Server - Mount Point | 1 minute                                             |
| disk_inodes_UsedPercent                    | **inode** Usage Percentage | This metric is used to statistically measure the percentage of used inodes of the object's current disk. Unit: percentage | 0-100%     | Cloud Server - Mount Point | 1 minute                                             |

## Objects {#object}

The Huawei Cloud ECS object data structure collected can be seen under "Infrastructure - Resource Catalog"

``` json
{
  "measurement": "huaweicloud_ecs",
  "tags": {
    "RegionId"                   : "cn-north-4",
    "project_id"                 : "xxxxxxx",
    "enterprise_project_id"      : "0760xxxx-aec0-4838-a91a-28xxxxxxxx",
    "instance_id"               : "xxxxx",
    "instance_name"              : "ecs-3384",
    "status"                     : "ACTIVE"    
  },
  "fields": {
    "host_status"                         : "xxxxxxx",
    "charging_mode"                       : "0",
    "vpc_id"                              : "3dda7d4b-aec0-4838-a91a-28xxxxxxxx",
    "metadata_os_type"                    : "Linux",
    "os-extended-volumes:volumes_attached": "{JSON data}",
    "OS-EXT-AZ:availability_zone"         : "xxxxxxxx",
    "created"                             : "2022-06-16T10:13:24Z",
    "description"                         : "{JSON data}",
    "addresses"                           : "{IP JSON data}",
    "tags"                                : "xxxxxxxxx",
    "sys_tags"                            : "xxxxxxxx"
  }
}
```

Descriptions of some parameters are as follows:

| Parameter Name             | Description                   |
| :------------------- | :--------------------- |
| `resource_spec_code` | Resource specification               |
| `resource_type`      | Resource type corresponding to cloud server |

Meanings of charging_mode values (cloud server billing types):

| Value | Description                                  |
| :--- | :------------------------------------ |
| `0`  | Pay-as-you-go (i.e., postPaid - pay after service)    |
| `1`  | Subscription billing (i.e., prePaid - prepaid) |
| `2`  | Spot instance billing                          |

> *Note: The fields in `tags`, `fields` may change with subsequent updates.*
>
> Tip 1: The value of `tags.instance_id` is the instance ID, used as a unique identifier.
>
> Tip 2: The range of values for `status` and their corresponding meanings can be found in the appendix on cloud server statuses.