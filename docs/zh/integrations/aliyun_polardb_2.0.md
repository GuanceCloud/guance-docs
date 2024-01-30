---
title: '阿里云 PolarDB 分布式 2.0'
summary: '阿里云 PolarDB 分布式 2.0 展示计算层和存储节点的指标，包括CPU利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。'
__int_icon: 'icon/aliyun_polardb'
dashboard:
  - desc: '阿里云 PolarDB 分布式 2.0 内置视图'
    path: 'dashboard/zh/aliyun_polardb_2.0/'

monitor:
  - desc: '阿里云 PolarDB 分布式 2.0 监控器'
    path: 'monitor/zh/aliyun_polardb_2.0/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 PolarDB 分布式2.0
<!-- markdownlint-enable -->

阿里云 PolarDB 分布式2.0 展示计算层和存储节点的指标，包括CPU利用率、连接使用率、磁盘使用量、磁盘使用率、内存利用率、网络带宽等。

## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 PolarDB 分布式2.0 的监控数据，我们安装对应的采集脚本：「观测云集成（阿里云-PolarDB-X 2.0采集）」(ID：`guance_aliyun_polardbx_2`)

点击【安装】后，输入相应的参数：阿里云 AK ID、阿里云 AK SECRET 和 Account Name。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-polardbx-1/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云 PolarDB 分布式 2.0 后,默认的指标集如下, 可以通过配置的方式采集更多的指标

 [阿里云云监控-云原生分布式数据库PolarDB-X 2.0 计算节点指标详情](https://cms.console.aliyun.com/metric-meta/acs_drds/polardb-x_v2){:target="_blank"}
 [阿里云云监控-云原生分布式数据库PolarDB-X 2.0 存储节点指标详情](https://cms.console.aliyun.com/metric-meta/acs_drds/polardbx_v2_dn){:target="_blank"}

### 计算节点指标

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveConnectionsOfCN`| PolarDB-X 计算层活跃连接数 |         Sum         |    count     |
|`CPUUsageOfCN`| PolarDB-X 计算层CPU使用率 |         Average         |    %     |
|`ConnectionsOfCN`| PolarDB-X 计算层连接数 |         Sum         |    count    |
|`ErrorCountOfCN`| PolarDB-X 计算层错误数 |         Sum         |    count/s     |
|`FullGcTimeOfCN`| PolarDB-X Full GC时间 |     Sum     |    nanoseconds     |
|`LogicRTOfCN`| PolarDB-X 计算层逻辑响应时间      |         Average         |      μs       |
|`LogicRequestCountOfCN`| PolarDB-X 计算层逻辑请求数                   |     Sum     |     req/s    |
|`LogicSlowOfCN`| PolarDB-X 计算层逻辑慢SQL                  |     Sum     |     req/s       |
|`MemUsageOfCN`| PolarDB-X 计算层内存使用率                  |     Average     |      %       |
|`NetInOfCN`| PolarDB-X 计算层网络流量（进） |   Sum    |      B/s       |
|`NetOutOfCN`| PolarDB-X 计算层网络流量（出）|         Sum         |      B/s       |

### 存储节点指标

| Metric | Description                  |       Statistics        |     Unit     |
| ---- |------------------------------|:-----------------------:|:------------:|
|`ActiveSessionsOfDN`| PolarDB-X 存储节点 ActiveSessions |         Average         |    count    |
|`CPUUsageOfDN`| PolarDB-X 存储节点CPU使用率 |         Average         |    %     |
|`ConnUsageOfDN`| PolarDB-X 存储节点连接使用率 |         Average         |    %    |
|`DiskSizeOfDN`| PolarDB-X 存储节点磁盘使用量 |         Average         |    Megabytes     |
|`DiskUsageOfDN`| PolarDB-X 存储节点磁盘使用率 |     Average     |    %     |
|`IOPSUsageOfDN`| PolarDB-X 存储节点 IOPS 使用率     |         Average         |      %       |
|`IbufDirtyRatioOfDN`| PolarDB-X 存储节点BP脏页百分率                   |     Average     |     %    |
|`IbufReadHitOfDN`| PolarDB-X 存储节点BP读命中率                  |     Average     |     %      |
|`IbufUseRatioOfDN`| PolarDB-X 存储节点BP利用率                  |     Average     |      %       |
|`LogDiskSizeOfDN`| PolarDB-X 存储节点日志磁盘使用量 |   Average    |      Megabytes      |
|`MemUsageOfDN`| PolarDB-X 存储节点内存使用率 |         Average         |      %       |
|`NetworkInDN`| PolarDB-X 存储节点网络流入带宽 |         Average         |     bits/s      |
|`NetworkOutDN`| PolarDB-X 存储节点网络流出带宽 |         Average         |     bits/s     |
|`SlaveLagOfDN`| PolarDB-X 存储节点备库延迟 |         Average         |      seconds       |
|`SlowQueriesOfDN`| PolarDB-X 存储节点每秒慢查询量 |         Average         |      countSecond       |
|`TempDiskTableCreatesOfDN`| PolarDB-X 存储节点每秒创建临时表数量 |         Average         |    countSecond       |
|`ThreadsConnectedOfDN`| PolarDB-X 存储节点线程连接数 |         Average         |      count      |
|`ThreadsRunningOfDN`| PolarDB-X 存储节点活跃线程数 |         Average         |      count      |
|`TmpDiskSizeOfDN`| PolarDB-X 存储节点临时磁盘使用量 |         Average         |     Megabytes      |


## 对象 {#object}
采集到的阿里云 PolarDB 分布式2.0 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

``` json
{
  "measurement": "aliyun_polardbx_2",
  "tags": {
    "ClassCode"             : "",
    "CommodityCode"         : "drds_polarxpost_public_cn",
    "DBInstanceName"        : "pxc-s-hzr1ch4n3icc3w",
    "DBType"                : "polarx",
    "DnNodeClassCode"       : "mysql.n2.medium.25",
    "Engine"                : "polarx",
    "Id"                    : "pxc-xdb-s-shzr1ch4n3icc3wbf04",
    "LockMode"              : "Unlock",
    "MinorVersion"          : "polarx-kernel_standard_xcluster-20230508",
    "Network"               : "VPC",
    "NodeClass"             : "mysql.n2.medium.25",
    "PayType"               : "Postpaid",
    "Series"                : "standard",
    "Status"                : "Running",
    "Type"                  : "ReadWrite",
    "VPCId"                 : "vpc-bp1uhj8mimgturv8c0gg6",
    "ZoneId"                : "cn-hangzhou-k;cn-hangzhou-k;cn-hangzhou-k",
    "name"                  : "pxc-xdb-s-shzr1ch4n3icc3wbf04"
  },
  "fields": {
    "CnNodeCount"           : 0,
    "CreateTime"            : "2023-08-16T06:57:41.000+0000",
    "Description"           : "",
    "DnNodeCount"           : 1,
    "ExpireTime"            : "2123-08-16T16:00:00.000+0000",
    "Expired"               : false,
    "NodeCount"             : 1,
    "ReadDBInstances"       : "[]",
    "ResourceGroupId"       : "rg-acfmv3ro3xnfwaa",
    "StorageUsed"           : 2343567360,
    "message"               : "{实例 json 数据}}",
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：tags.name值为实例 ID，作为唯一识别
>
> 提示 2：fields.message均为 JSON 序列化后字符串
