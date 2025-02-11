---
title: 'VolcEngine NAS File Storage'
tags: 
  - VolcEngine
summary: 'Collecting VolcEngine NAS Metrics Data'
__int_icon: 'icon/volcengine_nas'
dashboard:

  - desc: 'Built-in View for VolcEngine NAS'
    path: 'dashboard/en/volcengine_nas'
monitor:
  - desc: 'VolcEngine NAS Monitor'
    path: 'monitor/en/volcengine_nas'
---

Collecting VolcEngine NAS Metrics Data

## Configuration {#config}

### Installing Func

We recommend enabling the Guance Integration - Expansion - Managed Func: All prerequisites are automatically installed. Please proceed with script installation.

If you choose to deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installing Script

> Note: Ensure you have prepared a VolcEngine AK that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize monitoring data from NAS cloud resources, install the corresponding collection script: 「Guance Integration (VolcEngine-NAS Collection)」(ID: `guance_volcengine_nas`)

After clicking 【Install】, enter the required parameters: VolcEngine AK, VolcEngine account name, and Regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once enabled, you can view the corresponding automatic trigger configuration in 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, and you can check the execution task records and corresponding logs.

### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding automatic trigger configuration exists for the task. You can also check the task records and logs to ensure there are no anomalies.
2. On the Guance platform, in 「Infrastructure - Resource Catalog」, check if the asset information exists.
3. On the Guance platform, in 「Metrics」, check if the corresponding monitoring data is available.

## Metrics {#metric}

Configure VolcEngine NAS monitoring metrics. You can collect more metrics through configuration [VolcEngine NAS Extreme Type Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_FileNAS){:target="_blank"} and [VolcEngine NAS Capacity Type Metrics Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_veFileNAS)

### VolcEngine NAS Extreme Type Monitoring Metrics

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
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
| `Nfsv3ReadLatency` | `latency` | NFSv3 Read Latency | Seconds | ResourceID |
| `Nfsv3WriteLatency` | `latency` | NFSv3 Write Latency | Seconds | ResourceID |
| `Nfsv4ReadLatency` | `latency` | NFSv4 Read Latency | Seconds | ResourceID |
| `Nfsv4WriteLatency` | `latency` | NFSv4 Write Latency | Seconds | ResourceID |
| `NfsMetaLatency` | `latency` | NFS Metadata Latency | Seconds | ResourceID |
| `NfsMetaQps` | `qps` | NFS Metadata QPS | Count/Second | ResourceID |

### VolcEngine NAS Capacity Type Monitoring Metrics

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
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
| `Nfsv3ReadLatency` | `latency` | NFSv3 Read Latency | Seconds | ResourceID |
| `Nfsv3WriteLatency` | `latency` | NFSv3 Write Latency | Seconds | ResourceID |
| `Nfsv4ReadLatency` | `latency` | NFSv4 Read Latency | Seconds | ResourceID |
| `Nfsv4WriteLatency` | `latency` | NFSv4 Write Latency | Seconds | ResourceID |
| `NfsMetaLatency` | `latency` | NFS Metadata Latency | Seconds | ResourceID |
| `NfsMetaQps` | `qps` | NFS Metadata QPS | Count/Second | ResourceID |

## Objects {#object}

The collected VolcEngine NAS object data structure can be viewed in 「Infrastructure - Resource Catalog」

``` json
  {
    "measurement": "volcengine_nas",
    "tags": {
      "RegionId"        : "cn-guangzhou",
      "ProjectName"     : "default",
      "AccountId"       : "2102598xxxx",
      "FileSystemId"    : "enas-cngza0cfd219xxxxx",
      "FileSystemName"  : "xxxxx",
      "FileSystemType"  : "Extreme",
      "Status"          : "Active"
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
> Note 1: `FileSystemType` indicates file types, including Extreme and Capacity types.
>
</input_content>