---
title: 'HUAWEI ECS'
summary: 'Use the「Guance Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the observation cloud.'
__int_icon: 'icon/huawei_ecs'
dashboard:

  - desc: 'HUAWEI CLOUD ECS Monitoring View'
    path: 'dashboard/zh/huawei_ecs'

monitor:
  - desc: 'HUAWEI CLOUD ECS Monitor'
    path: 'monitor/zh/huawei_ecs'

---


<!-- markdownlint-disable MD025 -->
# HUAWEI CLOUD ECS
<!-- markdownlint-enable -->

Use the「Guance Synchronization」series script package in the script market to monitor the cloud ,The data of the cloud asset is synchronized to the observation cloud.

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to  [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### Installation script

> Tip：Please prepare HUAWEI CLOUD AK that meets the requirements in advance（For simplicity's sake,You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of  HUAWEI CLOUD OBS cloud resources, we install the corresponding collection script：「Guance Integration（HUAWEI CLOUD-ECS Collect）」(ID：`guance_huaweicloud_ecs`)

Click 【Install】 and enter the corresponding parameters: HUAWEI CLOUD AK, HUAWEI CLOUD account name.

tap【Deploy startup Script】,The system automatically creates `Startup` script sets,And automatically configure the corresponding startup script.

After the script is installed,Find the script in「Development」in Func「Guance Integration（HUAWEI CLOUD-ECS Collect）」,Expand to modify this script,find `collector_configs`and`monitor_configs`Edit the content in`region_projects`,Change the locale and Project ID to the actual locale and Project ID,Click Save Publish again.

In addition, the corresponding automatic trigger configuration is displayed in「Management / Crontab Config」.tap【Run】,It can be executed immediately once, without waiting for a periodic time.After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-huaweicloud-ces/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the observation cloud platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure HUAWEI CLOUD - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [HUAWEI CLOUD Monitor Metrics Details](https://support.huaweicloud.com/usermanual-ecs/ecs_03_1003.html){:target="_blank"}

| Metric ID                           | Index name                  | Metric meaning                                                                             | Value range      | Measurement object (dimension) | Monitoring cycle (raw metrics) |
| -------------------------------- |-----------------------|----------------------------------------------------------------------------------| ------------- | ---------------- | -------------------------------------------- |
| cpu_usage             | CPU usage             | This metric measures the CPU usage of a measurement object. Unit: percentage. | 0-100%    | Cloud server       | 1 min                                       |
| load_average1         | Average load in 1 minute | Measures the average CPU load of a measurement object in the past 1 minute.      | ≥ 0%          | Cloud server         | 1 min                                      |
| load_average5        | Average load in 5 minute | Measures the average CPU load of a measurement object in the past 5 minute.      | ≥ 0%          | Cloud server         | 1 min                                       |
| load_average15        | Average load in 15 minute | Measures the average CPU load of a measurement object in the past 15 minute.     | ≥ 0 Byte/s    | Cloud server         | 1 min                                        |
| mem_usedPercent       | Memory usage     | This metric measures the memory usage of a measurement object. Unit: percentage                                                        | 0-100% | Cloud server         | 1 min                                        |
| net_bitSent           | Access bandwidth     | Measures the number of bits received by a measurement object's NIC per second. Unit: bit/s                                                 | ≥ 0 bit/s | Cloud server         | 1 min                                       |
| net_bitRecv           | Outbound bandwidth   | Measures the number of bits sent per second by a measurement object's NIC. Unit: bit/s                                               | ≥ 0 bit/s | Cloud server         | 1 min                                       |
| net_packetSent    | Nic packet sending rate   | Indicates the number of packets sent by a measurement object's network adapter per second. Unit: Counts/s                                            | ≥ 0 Counts/s | Cloud server         | 1 min                                        |
| net_packetRecv    | Nic packet receiving rate | Indicates the number of packets received by a network adapter of a measurement object per second. Unit: Counts/s                                         | ≥ 0 Counts/s | Cloud server         | 1 min                                        |
| net_tcp_established | TCP ESTABLISHED       | This metric measures the number of TCP connections in the ESTABLISHED state of the measurement object. Unit: Count                              | ≥ 0 | Cloud server         | 1 min                                        |
| net_tcp_total | TCP TOTAL             | Measure the total number of TCP connections in all states of a measurement object. Unit: Count                                             | ≥ 0 | Cloud server          | 1 min                                        |
| disk_usedPercent           | Disk usage                 | The disk usage of a measurement object is measured in percentage. Used disk storage capacity/Total disk storage capacity. Unit: percentage                            | 0-100%     | Cloud server - Mount point | 1 min                                        |
| disk_free             | Remaining disk storage capacity              | This measurement entity measures the free storage space of the disk of a measurement object. Unit: GB                                               | ≥0 GB      | Cloud server - Mount point| 1 min                                        |
| disk_ioUtils          | Disk I/O usage              | This metric measures the disk I/O usage of a measurement object. Unit: percentage                                                     | 0-100%     | Cloud server - Disk Cloud server - Mount point | 1 min                                        |
| **disk_inodesUsedPercent**                | inode used percentage            | This measurement entity measures the inode usage of disks on a measurement object. Unit: percentage                                            | 0-100%     | Cloud server - Mount point | 1 min                                        |

## Object {#object}

The collected HUAWEI CLOUD ECS object data structure can see the object data from 「Infrastructure-Custom」

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
    "addresses"                           : "{IPJSON data}",
    "os-extended-volumes:volumes_attached": "{JSON data}",
    "message"                             : "{Instance JSON data}"
  }
}
```

Some parameters are described as follows：

| Parameter name             | Instructions             |
| :------------------- |:-------------------------|
| `resource_spec_code` | Resource specification   |
| `resource_type`      | Resource type of the ECS |

charging_mode(ECS payment type) Specifies the value：

| value | Instructions                                  |
| :--- | :------------------------------------ |
| `0`  | Pay on demand (postPaid)    |
| `1`  | prePaid (Prepaid) |
| `2`  | Bid instance charging                         |

> *notice：`tags`、`fields`The fields in this section may change with subsequent updates*
>
> Tips 1：`tags.name`The value is the instance ID for unique identification
>
> Tips 2：`status`For details about the value range and meanings, see Appendix Cloud Server Status
