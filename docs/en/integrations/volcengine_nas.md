---
title: 'VolcEngine NAS File Storage'
tags: 
  - VolcEngine
summary: 'Collect VolcEngine NAS Metrics data'
__int_icon: 'icon/volcengine_nas'
dashboard:

  - desc: 'VolcEngine NAS built-in views'
    path: 'dashboard/en/volcengine_nas'
monitor:
  - desc: 'VolcEngine NAS Monitor'
    path: 'monitor/en/volcengine_nas'
---

Collect VolcEngine NAS Metrics data

## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

> Note: Prepare a VolcEngine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize monitoring data from NAS cloud resources, we install the corresponding collection script: "Guance Integration (VolcEngine-NAS Collection)" (ID: `guance_volcengine_nas`)

After clicking 【Install】, enter the required parameters: VolcEngine AK, VolcEngine account name, and Regions.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, then check the task execution records and corresponding logs.

### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding task has an automatic trigger configuration. You can also view the task records and log checks for any anomalies.
2. In the Guance platform, under "Infrastructure - Resource Catalog", check if asset information exists.
3. In the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

Configure VolcEngine NAS monitoring metrics. More metrics can be collected through configuration. Refer to [VolcEngine NAS Extreme Type Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_FileNAS){:target="_blank"} and [VolcEngine NAS Capacity Type Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_veFileNAS)

### VolcEngine NAS Extreme Type Monitoring Metrics

|`MetricName` |`Subnamespace` |Metric Name |Metric Unit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | Total Storage Information | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | Used Storage Information | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | Total Inode Information | Count | ResourceID |
| `UsedInode` | `capacity` | Used Inode Information | Count | ResourceID |
| `StorageUtil` | `capacity` | Storage Utilization | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode Utilization | Percent | ResourceID |
| `TotalConnection` | `connection` | Total Connections | Count | ResourceID |
| `CurrentConnection` | `connection` | Current Connections | Count | ResourceID |
| `ConnectionUtil` | `connection` | Connection Utilization | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3 Read IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3 Write IOPS | Count/Second | ResourceID |
| `Nfsv4ReadIops` | `iops` | NFSv4 Read IOPS | Count/Second | ResourceID |
| `Nfsv4WriteIops` | `iops` | NFSv4 Write IOPS | Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `latency` | NFSv3 Write Latency | Milliseconds | ResourceID |
| `Nfsv3ReadLatency` | `latency` | NFSv3 Read Latency | Milliseconds | ResourceID |
| `Nfsv4ReadLatency` | `latency` | NFSv4 Read Latency | Milliseconds | ResourceID |
| `Nfsv4WriteLatency` | `latency` | NFSv4 Write Latency | Milliseconds | ResourceID |
| `NfsMetaLatency` | `latency` | NFS Metadata Latency | Milliseconds | ResourceID |
| `NfsMetaQps` | `qps` | NFS Metadata QPS | Count/Second | ResourceID |

### VolcEngine NAS Capacity Type Monitoring Metrics

|`MetricName` |`Subnamespace` |Metric Name |Metric Unit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | Total Storage Information | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | Used Storage Information | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | Total Inode Information | Count | ResourceID |
| `UsedInode` | `capacity` | Used Inode Information | Count | ResourceID |
| `StorageUtil` | `capacity` | Storage Utilization | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode Utilization | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3 Read IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3 Write IOPS | Count/Second | ResourceID |
| `Nfsv4ReadIops` | `iops` | NFSv4 Read IOPS | Count/Second | ResourceID |
| `Nfsv4WriteIops` | `iops` | NFSv4 Write IOPS | Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `latency` | NFSv3 Write Latency | Milliseconds | ResourceID |
| `Nfsv3ReadLatency` | `latency` | NFSv3 Read Latency | Milliseconds | ResourceID |
| `Nfsv4ReadLatency` | `latency` | NFSv4 Read Latency | Milliseconds | ResourceID |
| `Nfsv4WriteLatency` | `latency` | NFSv4 Write Latency | Milliseconds | ResourceID |
| `NfsMetaLatency` | `latency` | NFS Metadata Latency | Milliseconds | ResourceID |
| `NfsMetaQps` | `qps` | NFS Metadata QPS | Count/Second | ResourceID |

## Objects {#object}

The structure of the VolcEngine NAS object data collected can be seen in "Infrastructure - Resource Catalog"

``` json
{
  "measurement": "volcengine_nas",
  "tags": {
    "RegionId": "cn-guangzhou",
    "ProjectName": "default",
    "AccountId": "2102598xxxx",
    "FileSystemId": "enas-cngza0cfd219xxxxx",
    "FileSystemName": "xxxxx",
    "FileSystemType": "Extreme",
    "Status": "Active"
  },
  "fields": {
    "ZoneId": "cn-guangzhou-a",
    "Capacity": "{JSON data}",
    "StorageType": "Standard",
    "ChargeType": "PayAsYouGo",
    "Description": "xxxxxx",
    "CreateTime": "2024-12-16T02:43:11Z",
    "UpdateTime": "2024-12-16T06:33:36Z",
    "Tags": "[]"
  }
}
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: `FileSystemType` indicates the file type, including Extreme and Capacity types.
>
</input_content>
<target_language>英语</target_language>
</input>

Please continue translating.
