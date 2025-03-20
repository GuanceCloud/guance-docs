---
title: 'Volcengine NAS File Storage'
tags: 
  - Volcengine
summary: 'Collecting Volcengine NAS Metrics data'
__int_icon: 'icon/volcengine_nas'
dashboard:

  - desc: 'Volcengine NAS built-in views'
    path: 'dashboard/en/volcengine_nas'
monitor:
  - desc: 'Volcengine NAS monitors'
    path: 'monitor/en/volcengine_nas'
---

Collecting Volcengine NAS Metrics data

## Configuration {#config}

### Installing Func

It is recommended to enable Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func manually, refer to [Manually Deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installing Script

> Note: Please prepare a Volcengine AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize the monitoring data of NAS cloud resources, we install the corresponding collection script: "Guance Integration (Volcengine-NAS Collection)" (ID: `guance_volcengine_nas`)

After clicking 【Install】, enter the corresponding parameters: Volcengine AK, Volcengine account name, Regions.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup script automatically.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. Wait a moment, and you can view the execution task records and corresponding logs.

### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs to check for any anomalies.
2. On the Guance platform, in "Infrastructure - Resource Catalog", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}

Configuring Volcengine NAS monitoring metrics allows you to collect more metrics through configuration. [Volcengine NAS Extreme Type Metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_FileNAS){:target="_blank"} and [Volcengine NAS Capacity Type Metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_veFileNAS)

### Volcengine NAS Extreme Type Monitoring Metrics

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | Total Capacity Information | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | Used Capacity Information | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | Total Inode Information | Count | ResourceID |
| `UsedInode` | `capacity` | Used Inode Information | Count | ResourceID |
| `StorageUtil` | `capacity` | Capacity Utilization | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode Utilization | Percent | ResourceID |
| `TotalConnection` | `connection` | Total Connections | Count | ResourceID |
| `CurrentConnection` | `connection` | Current Connections | Count | ResourceID |
| `ConnectionUtil` | `connection` | Connection Utilization | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3 Read IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3 Write IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 Read IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 Write IOPS | Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3ReadLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaQps` | `qps` | NFS Metadata QPS | Count/Second | ResourceID |

### Volcengine NAS Capacity Type Monitoring Metrics

|`MetricName` |`Subnamespace` |Metric Name |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4 Write Bandwidth | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | Total Capacity Information | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | Used Capacity Information | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | Total Inode Information | Count | ResourceID |
| `UsedInode` | `capacity` | Used Inode Information | Count | ResourceID |
| `StorageUtil` | `capacity` | Capacity Utilization | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode Utilization | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3 Read IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3 Write IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 Read IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 Write IOPS | Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3ReadLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaLatency` | `bandwidth` | NFSv3 Read Bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaQps` | `qps` | NFS Metadata QPS | Count/Second | ResourceID |

## Objects {#object}

The structure of the collected Volcengine NAS object data can be seen in "Infrastructure - Resource Catalog"

``` json
  {
    "measurement": "volcengine_nas",
    "tags": {
    "RegionId"        : "cn-guangzhou",
    "ProjectName"     : "default",
    "AccountId"       : "2102598xxxx",
    "FileSystemId"    : "enas-cngza0cfd219xxxxx ",
    "FileSystemName"  : "xxxxx",
    "FileSystemType"  : "Extreme",
    "Status"          : "Active"
    },
    "fileds": {
      "ZoneId": "cn-guangzhou-a",
      "Capacity": "{JSON data}",
      "StorageType": "Standard",
      "ChargeType": "PayAsYouGo",
      "Description": "xxxxxx",
      "Description": "xxxxxx",
      "CreateTime": "2024-12-16T02:43:11Z",
      "UpdateTime": "2024-12-16T06:33:36Z",
      "Tags": "[]"
    }
  }
```

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> Tip 1: `FileSystemType` refers to file types, including Extreme and Capacity types.
>