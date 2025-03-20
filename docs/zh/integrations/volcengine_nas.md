---
title: '火山引擎 NAS 文件存储'
tags: 
  - 火山引擎
summary: '采集火山引擎 NAS 指标数据'
__int_icon: 'icon/volcengine_nas'
dashboard:

  - desc: '火山引擎 NAS 内置视图'
    path: 'dashboard/zh/volcengine_nas'
monitor:
  - desc: '火山引擎 NAS 监控器'
    path: 'monitor/zh/volcengine_nas'
---

采集火山引擎 NAS 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

> 提示：请提前准备好符合要求的火山引擎 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 NAS 云资源的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（火山引擎-NAS采集）」(ID：`guance_volcengine_nas`)

点击【安装】后，输入相应的参数：火山引擎 AK、火山引擎账户名、地域Regions。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}

配置火山引擎 NAS 监控指标，可以通过配置的方式采集更多的指标 [火山引擎 NAS 极速型指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_FileNAS){:target="_blank"}和[火山引擎 NAS 容量型指标详情](https://console.volcengine.com/cloud_monitor/docs?namespace=VCM_veFileNAS)

### 火山引擎 NAS 极速型监控指标

|`MetricName` |`Subnamespace` |指标名称 |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3写带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4写带宽 | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | 总容量信息 | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | 已用容量信息 | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | 总Inode信息 | Count | ResourceID |
| `UsedInode` | `capacity` | 已用Inode信息 | Count | ResourceID |
| `StorageUtil` | `capacity` | 容量使用率 | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode使用率 | Percent | ResourceID |
| `TotalConnection` | `connection` | 总连接数 | Count | ResourceID |
| `CurrentConnection` | `connection` | 当前连接数 | Count | ResourceID |
| `ConnectionUtil` | `connection` | 连接数使用率 | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3读IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3写IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4读IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4写IOPS| Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv3ReadLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `NfsMetaLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `NfsMetaQps` | `qps` | NFS元数据QPS | Count/Second | ResourceID |

### 火山引擎 NAS 容量型监控指标

|`MetricName` |`Subnamespace` |指标名称 |MetricUnit | Dimension|
| ----------- |---------------| :----: |:--------: |:-------: |
| `Nfsv3ReadBandwidth` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadBandwidth` | `bandwidth` | NFSv4读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv3WriteBandwidth` | `bandwidth` | NFSv3写带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteBandwidth` | `bandwidth` | NFSv4写带宽 | Bytes/Second(SI) | ResourceID |
| `TotalStorage` | `capacity` | 总容量信息 | Mebibytes | ResourceID |
| `UsedStorage` | `capacity` | 已用容量信息 | Mebibytes | ResourceID |
| `TotalInode` | `capacity` | 总Inode信息 | Count | ResourceID |
| `UsedInode` | `capacity` | 已用Inode信息 | Count | ResourceID |
| `StorageUtil` | `capacity` | 容量使用率 | Percent | ResourceID |
| `InodeUtil` | `capacity` | Inode使用率 | Percent | ResourceID |
| `Nfsv3ReadIops` | `iops` | NFSv3读IOPS | Count/Second | ResourceID |
| `Nfsv3WriteIops` | `iops` | NFSv3写IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4读IOPS | Count/Second | ResourceID |
| `Nfsv3ReadBandwidth` | `iops` | NFSv4写IOPS| Count/Second | ResourceID |
| `Nfsv3WriteLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv3ReadLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4ReadLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `Nfsv4WriteLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `NfsMetaLatency` | `bandwidth` | NFSv3读带宽 | Bytes/Second(SI) | ResourceID |
| `NfsMetaQps` | `qps` | NFS元数据QPS | Count/Second | ResourceID |

## 对象 {#object}

采集到的火山引擎 NAS 对象数据结构, 可以从「基础设施 - 资源目录」里看到对象数据

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

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`FileSystemType`为文件类型，包括Extreme和Capacity两种类型
>
