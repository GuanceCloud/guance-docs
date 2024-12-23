---
title: 'Volcengine NAS File Storage'
tags:
  - Volcengine
summary: 'Collect Volcengine NAS metric data'
__int_icon: 'icon/volcengine_nas'
dashboard:

  - desc: 'Volcengine NAS Built in View'
    path: 'dashboard/en/volcengine_nas'

monitor:
  - desc: 'Volcengine NAS Monitor'
    path: 'monitor/en/volcengine_nas'
---

Collect Volcengine NAS metric data

## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare `Volcenine`  AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of NAS cloud resources, we install the corresponding collection script：「Guance Integration（Volcengine NAS Collect）」(ID：`guance_volcengine_nas`)

Click【Install】and enter the corresponding parameters: Volcenine AK, Volcenine account name, Volcenine regions.

Tap 【Deploy startup Script】, The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script.

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click "Run"，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs.

### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task. In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure - Resource Catalog」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}

Configure the Volcengine NAS monitoring metric to collect more metrics through configuration [Volcengine NAS Extreme Type metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_FileNAS){:target="_blank"}and[Volcengine NAS Capacity Type metric Details](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_veFileNAS){:target="_blank"}

### Volcengine NAS Extreme Monitoring Metrics

|`MetricName` |`Subnamespace` | MetricName |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3 write bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4 write bandwidth | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | Total capacity information | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | Used capacity information | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | Total Inode Information | Count | ResourceID |
| `UsedInode` | `capacity` | Inode information has been used | Count | ResourceID |
| `StorageUtil` | `capacity` | Capacity usage | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode usage rate | Percent | ResourceID |
| `TotalConnection` | `connection` | Total connections | Count | ResourceID |
| `CurrentConnection` | `connection` | Current connections | Count | ResourceID |
| `ConnectionUtil` | `connection` | Connection usage rate | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3 read IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3 write IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 read IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 write IOPS| Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3ReadLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaQps` | `qps` | NFS metadata QPS | Count/Second | ResourceID |

### Volcengine NAS Capacity Monitoring Metrics

|`MetricName` |`Subnamespace` | MetricName |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3 write bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4 write bandwidth | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | Total capacity information | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | Used capacity information | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | Total Inode Information | Count | ResourceID |
| `UsedInode` | `capacity` | Inode information has been used | Count | ResourceID |
| `StorageUtil` | `capacity` | Capacity usage | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode usage rate | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3 read IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3 write IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 read IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4 write IOPS| Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv3ReadLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaLatency` | `bandwidth` | NFSv3 read bandwidth | Bytes/Second(SI) | ResourceID |
| `NfsMetaQps` | `qps` | NFS metadata QPS | Count/Second | ResourceID |

## Object  {#object}

The collected Volcengine NAS object data structure can see the object data from 「Infrastructure - Resource Catalog」

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
      "Capacity": "{JSON 数据}",
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

> *notice：`Tags` and `fields` may change with subsequent updates*
>
> note 1：`FileSystemType` is a file type that includes two types: Extreme and Capacity
>
