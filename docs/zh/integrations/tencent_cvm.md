---
title: '腾讯云 CVM'
tags: 
  - 腾讯云
summary: '使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/tencent_cvm'
dashboard:

  - desc: '腾讯云 CVM 内置视图'
    path: 'dashboard/zh/tencent_cvm'

monitor:
  - desc: '腾讯云 CVM 监控器'
    path: 'monitor/zh/tencent_cvm'

---


<!-- markdownlint-disable MD025 -->
# 腾讯云 CVM
<!-- markdownlint-enable -->
使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 CVM 的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-CVM采集）」(ID：`guance_tencentcloud_cvm`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。


我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/6843){:target="_blank"}

### CPU 监控

| 指标英文名      | 指标中文名           | 说明                                                         | 单位 | 维度         | 统计粒度                      |
| --------------- | -------------------- | ------------------------------------------------------------ | ---- | ------------ | ----------------------------- |
| `CpuUsage`      | CPU 利用率           | 机器运行期间实时占用的 CPU 百分比                            | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `CpuLoadavg`    | CPU 一分钟平均负载   | 1分钟内正在使用和等待使用 CPU 的平均任务数（Windows 机器无此指标） | -    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `Cpuloadavg5m`  | CPU 五分钟平均负载   | 5分钟内正在使用和等待使用 CPU 的平均任务数（Windows 机器无此指标） | -    | `InstanceId` | 60s、300s、3600s              |
| `Cpuloadavg15m` | CPU 十五分钟平均负载 | 15分钟内正在使用和等待使用 CPU  的平均任务数（Windows 机器无此指标） | -    | `InstanceId` | 60s、300s、3600s              |
| `BaseCpuUsage`  | 基础 CPU 使用率      | 基础 CPU 使用率通过宿主机采集上报，无须安装监控组件即可查看数据，子机高负载情况下仍可持续采集上报数据 | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |

### GPU 监控

| 指标英文名    | 指标中文名     | 说明                                       | 单位 | 维度         | 统计粒度                          |
| ------------- | -------------- | ------------------------------------------ | ---- | ------------ | --------------------------------- |
| `GpuMemTotal` | GPU 内存总量   | GPU 内存总量                               | MB   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuMemUsage` | GPU 内存使用率 | GPU 内存使用率                             | %    | `InstanceId` | 10s、60s、300s、3600s、86400s     |
| `GpuMemUsed`  | GPU 内存使用量 | 评估负载对显存占用                         | MB   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowDraw`  | GPU 功耗使用量 | GPU 功耗使用量                             | W    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowLimit` | GPU 功耗总量   | GPU 功耗总量                               | W    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuPowUsage` | GPU 功耗使用率 | GPU 功耗使用率                             | %    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuTemp`     | GPU 温度       | 评估 GPU 散热状态                          | °C   | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |
| `GpuUtil`     | GPU 使用率     | 评估负载所消耗的计算能力，非空闲状态百分比 | %    | `InstanceId` | 10s、 60s、 300s、 3600s、 86400s |

### 网络监控

| 指标英文名      | 指标中文名                   | 说明                                                         | 单位  | 维度         | 统计粒度                      |
| --------------- | ---------------------------- | ------------------------------------------------------------ | ----- | ------------ | ----------------------------- |
| `LanOuttraffic` | 内网出带宽                   | 内网网卡的平均每秒出流量                                     | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanIntraffic`  | 内网入带宽                   | 内网网卡的平均每秒入流量                                     | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanOutpkg`     | 内网出包量                   | 内网网卡的平均每秒出包量                                     | 个/秒 | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `LanInpkg`      | 内网入包量                   | 内网网卡的平均每秒入包量                                     | 个/秒 | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanOuttraffic` | 外网出带宽                   | 外网平均每秒出流量速率，最小粒度数据为10秒总流量/10秒计算得出，该数据为 EIP+CLB+CVM 的外网出/入带宽总和 | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanIntraffic`  | 外网入带宽                   | 外网平均每秒入流量速率，最小粒度数据为10秒总流量/10秒计算得出，该数据为 EIP+CLB+CVM 的外网出/入带宽总和 | Mbps  | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanOutpkg`     | 外网出包量                   | 外网网卡的平均每秒出包量                                     | 个/秒 | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `WanInpkg`      | 外网入包量                   | 外网网卡的平均每秒入包量                                     | 个/秒 | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `AccOuttraffic` | 外网出流量                   | 外网网卡的平均每秒出流量                                     | MB    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `TcpCurrEstab`  | TCP 连接数                   | 处于 ESTABLISHED 状态的 TCP 连接数量                         | 个    | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `TimeOffset`    | 子机 utc 时间和 ntp 时间差值 | 子机 utc 时间和 ntp 时间差值                                 | 秒    | `InstanceId` | 60s、300s、3600s、86400s      |

### 内存监控

| 指标英文名 | 指标中文名 | 说明                                                         | 单位 | 维度         | 统计粒度                      |
| ---------- | ---------- | ------------------------------------------------------------ | ---- | ------------ | ----------------------------- |
| `MemUsed`  | 内存使用量 | 用户实际使用的内存量，不包括缓冲区与系统缓存占用的内存，总内存  - 可用内存（包括 buffers 与 cached）得到内存使用量数值，不包含 buffers和 cached | MB   | `InstanceId` | 10s、60s、300s、3600s、86400s |
| `MemUsage` | 内存利用率 | 用户实际内存使用率，不包括缓冲区与系统缓存占用的内存，除去缓存、buffer  和剩余，用户实际使用内存与总内存之比 | %    | `InstanceId` | 10s、60s、300s、3600s、86400s |

### 磁盘监控

| 指标英文名     | 指标中文名 | 说明                                     | 单位 | 维度         | 统计粒度  |
| -------------- | ---------- | ---------------------------------------- | ---- | ------------ | --------- |
| `CvmDiskUsage` | 磁盘利用率 | 磁盘已使用容量占总容量的百分比(所有磁盘) | %    | `InstanceId` | 60s、300s |

### **RDMA** 监控

| 指标英文名          | 指标中文名        | 指标说明（非必填） | 单位  | 维度         | 统计粒度                    |
| ------------------- | ----------------- | ------------------ | ----- | ------------ | --------------------------- |
| `RdmaIntraffic`     | RDMA 网卡接收带宽 | RDMA 网卡接收带宽  | Mbps  | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOuttraffic`    | RDMA 网卡发送带宽 | RDMA 网卡发送带宽  | Mbps  | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaInpkt`         | RDMA 网卡入包量   | RDMA 网卡入包量    | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOutpkt`        | RDMA 网卡出包量   | RDMA 网卡出包量    | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `CnpCount`          | CNP 统计量        | 拥塞通知报文统计   | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `EcnCount`          | ECN 统计量        | 显示拥塞通知统计   | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaPktDiscard`    | 端测丢包量        | 端测丢包量         | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaOutOfSequence` | 接收方乱序错误量  | 接收方乱序错误量   | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RdmaTimeoutCount`  | 发送方超时错误量  | 发送方超时错误量   | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `TxPfcCount`        | TX PFC 统计量     | TX PFC 统计量      | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |
| `RxPfcCount`        | RX PFC 统计量     | RX PFC 统计量      | 个/秒 | `InstanceId` | 60s、 300s、 3600s、 86400s |

## 对象 {#object}

采集到的腾讯云 CVM 对象数据结构, 可以从「基础设施-自定义」里看到对象数据。

```json
{
  "measurement": "tencentcloud_cvm",
  "tags": {
    "name"              : "ins-bahxxxx",
    "RegionId"          : "ap-shanghai",
    "Zone"              : "ap-shanghai-1",
    "InstanceId"        : "ins-bahxxxx",
    "InstanceChargeType": "POSTPAID_BY_HOUR",
    "InstanceType"      : "SA2.MEDIUM2",
    "OsName"            : "TencentOS Server 3.1 (TK4)"
  },
  "fields": {
    "CPU"               : 2,
    "Memory"            : 2,
    "InstanceState"     : "RUNNING",
    "PublicIpAddresses" : "{公网 IP 数据}",
    "PrivateIpAddresses": "{私网 IP 数据}",
    "SystemDisk"        : "{系统盘 JSON 数据}",
    "DataDisks"         : "{数据盘 JSON 数据}",
    "Placement"         : "{地区 JSON 数据}",
    "ExpiredTime"       : "2022-05-07T01:51:38Z",
    "message"           : "{实例 JSON 数据}"
  }
}
```

