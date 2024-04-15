---
title: '阿里云 ECS'
summary: '阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。'
__int_icon: 'icon/aliyun_ecs'
dashboard:
  - desc: '阿里云 ECS 内置视图'
    path: 'dashboard/zh/aliyun_ecs/'

monitor:
  - desc: '阿里云 ECS 监控器'
    path: 'monitor/zh/aliyun_ecs/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 ECS
<!-- markdownlint-enable -->


阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ECS 云资源的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-ECS采集）」(ID：`guance_aliyun_ecs`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://cms.console.aliyun.com/metric-meta/acs_ecs_dashboard/ecs?spm=a2c4g.11186623.0.0.252476abTrNabN){:target="_blank"}

> 注意：需要在 Aliyun ECS 控制台安装监控插件

| Metric | Description                         | Type | Unit |
| ---- |-------------------------------------| :---:    | :----: |
|`CPUUtilization`| CPU使用率                              |float|%|
|`memory_usedutilization`| 内存使用率                               |float|%|
|`load_1m`| load.1m                             |float|count|
|`load_15m`| load.15m                            |float|count|
|`load_5m`| load.5m                             |float|count|
|`DiskReadBPS`| 所有磁盘读取BPS                           |float|bytes/s|
|`DiskWriteBPS`| 所有磁盘写入BPS                           |float|bytes/s|
|`DiskReadIOPS`| 所有磁盘每秒读取次数                          |float|Count/Second|
|`DiskWriteIOPS`| 所有磁盘每秒写入次数                          |float|Count/Second|
|`disk_readiops`| 磁盘每秒读取次数                            |float|Count/Second|
|`disk_writeiops`| 磁盘每秒写入次数                            |float|Count/Second|
|`diskusage_utilization`| `Host.diskusage.utilization`        |float|%|
|`fs_inodeutilization`| (Agent)fs.inode.utilization_device  |float|%|
|`GroupVPC_PublicIP_InternetInRate`| IP维度公网流入带宽                          |float|bits/s|
|`GroupVPC_PublicIP_InternetOutRate`| IP维度公网流出带宽                          |float|bits/s|
|`IntranetInRate`| 内网流入带宽                              |float|bits/s|
|`IntranetOutRate`| 内网流出带宽                              |float|bits/s|
|`concurrentConnections`| 同时连接数                               |float|count|
|`cpu_wait`| (Agent)cpu.wait                     |float|%|
|`cpu_user`| (Agent)cpu.user                     |float|%|
|`cpu_system`| (Agent)cpu.total                    |float|%|
|`memory_freeutilization`| (Agent)memory.free.utilization      |float|%|
|`disk_readbytes`| (Agent)disk.read.bytes_device       |float|bytes/s|
|`disk_writebytes`| (Agent)disk.write.bytes_device      |float|bytes/s|
|`networkin_rate`| (Agent)network.in.rate_device       |float|bits/s|
|`networkin_packages`| (Agent)network.in.packages_device   |float|Count/s|
|`net_tcpconnection`| (Agent)network.tcp.connection_state |float|Count|
|`memory_freespace`| (Agent)memory.free.space            |float|bytes|
|`memory_usedspace`| (Agent)memory.free.space            |float|bytes|
|`memory_totalspace`| (Agent)memory.total.space           |float|bytes|

## 对象 {#object}
采集到的阿里云 ECS 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "aliyun_ecs",
  "tags": {
    "name"                     : "i-xxxxx",
    "HostName"                 : "xxxxx",
    "InstanceName"             : "xxxxx",
    "InstanceId"               : "i-xxxxx",
    "RegionId"                 : "cn-hangzhou",
    "ZoneId"                   : "cn-hangzhou-a",
    "InstanceChargeType"       : "PrePaid",
    "InternetChargeType"       : "PayByTraffic",
    "OSType"                   : "linux",
    "PublicIpAddress_IpAddress": "['xxxx',]",
    "InstanceType"             : "ecs.c6.xlarge",
    "InstanceTypeFamily"       : "ecs.c6",
    "Status"                   : "Running"
  },
  "fields": {
    "CreationTime"           : "2022-01-01T00:00Z",
    "StartTime"              : "2022-01-02T00:00Z",
    "ExpiredTime"            : "2023-01-01T00:00Z",
    "disks"                  : "[ {关联磁盘 JSON 数据}, ... ]",
    "network_interfaces"     : "[ {关联网卡 JSON 数据}, ... ]",
    "instance_renew_attribute": "[ {自动续费 JSON 数据}, ...]",
    "instances_full_status"  : "[ {全状态信息 JSON 数据}, ...]",
    "OperationLocks"         : "[ {锁定原因 JSON 数据}, ...]",
    "Memory"                 : "8192",
    "Cpu"                    : "4",
    "InternetMaxBandwidthOut": "0",
    "InternetMinBandwidthIn" : "0",
    "AutoReleaseTime"        : "xxxx",
    "message"                : "{实例 JSON 数据}"
  }
}
```

