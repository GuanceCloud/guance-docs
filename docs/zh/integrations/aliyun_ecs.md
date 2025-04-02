---
title: '阿里云 ECS'
tags: 
  - 阿里云
  - 主机
summary: '阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。'
__int_icon: 'icon/aliyun_ecs'
dashboard:
  - desc: '阿里云 ECS 内置视图'
    path: 'dashboard/zh/aliyun_ecs/'

monitor:
  - desc: '阿里云 ECS 监控器'
    path: 'monitor/zh/aliyun_ecs/'

cloudCollector:
  desc: 'cloud collector'
  path: 'cloud-collector/zh/aliyun_ecs'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 ECS
<!-- markdownlint-enable -->


阿里云ECS的展示指标包括CPU利用率、内存利用率、网络带宽和磁盘IOPS，这些指标反映了ECS实例的计算、内存、网络和存储性能表现。

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func

如果自行部署 Func 参考[自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

### 开通脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

#### 托管版开通脚本

1. 登陆<<< custom_key.brand_name >>>控制台
2. 点击【管理】菜单，选择【云帐号管理】
3. 点击【添加云帐号】，选择【阿里云】，填写界面所需的信息，如之前已配置过云帐号信息，则忽略此步骤
4. 点击【测试】，测试成功后点击【保存】，如果测试失败，请检查相关配置信息是否正确，并重新测试
5. 点击【云帐号管理】列表上可以看到已添加的云账号，点击相应的云帐号，进入详情页
6. 点击云帐号详情页的【集成】按钮，在`未安装`列表下，找到`阿里云 ECS`，点击【安装】按钮，弹出安装界面安装即可。


#### 手动开通脚本

1. 登陆Func 控制台，点击【脚本市场】，进入官方脚本市场，搜索:`guance_aliyun_ecs`

2. 点击【安装】后，输入相应的参数：阿里云 AK ID 、AK Secret 及账户名。

3. 点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

4. 开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

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
