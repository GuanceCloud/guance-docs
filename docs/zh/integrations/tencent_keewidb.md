---
title: '腾讯云 KeeWiDB'
tags: 
  - 腾讯云
summary: '腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等'
__int_icon: 'icon/tencent_keewidb'
dashboard:

  - desc: '腾讯云 KeeWiDB 内置视图'
    path: 'dashboard/zh/tencent_keewidb'

monitor:
  - desc: '腾讯云 KeeWiDB 监控器'
    path: 'monitor/zh/tencent_keewidb'

---

<!-- markdownlint-disable MD025 -->
# 腾讯云 KeeWiDB
<!-- markdownlint-enable -->


腾讯云 KeeWiDB 指标展示，包括连接数、请求、缓存、key、慢查询等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 腾讯云 KeeWiDB 的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-KeeWiDB 采集）」(ID：`guance_tencentcloud_keewidb`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-keewidb/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云 KeeWiDB,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### 腾讯云 KeeWiDB 实例监控

| 指标英文名         | 指标中文名       | 指标说明                                                     | 单位  | 维度                      | 统计粒度                         |
| ------------------ | ---------------- | ------------------------------------------------------------ | ----- | ------------------------- | -------------------------------- |
| `KeeCpuUtil`       | CPU 使用率       | KeeWiDB 节点 CPU 使用率                                      | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| Connections        | 连接数量         | 接到实例的 TCP 连接数量                                      | 个    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| ConnectionsUtil    | 连接使用率       | 实际 TCP 连接数量和最大连接数占比                            | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCommands        | 总请求           | QPS，每秒命令执行的次数                                      | 次/秒 | `instanceid`               | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdRead         | 读请求           | 每秒读命令执行次数                                           | 次/秒 | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdWrite        | 写请求           | 每秒写命令执行次数                                           | 次/秒 | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdOtherKee     | 其他请求         | 读写命令之外的命令执行次数                                   | 个    | `instanceid`、`keewidbnodeid` | 5s、 60s、 300s、 3600s、 86400s |
| KeeCmdSlow         | 慢查询           | 执行时延大于 `slowlog` - log - slower - than 配置的命令次数    | 个    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| CmdErr             | 执行错误         | 每秒Proxy 命令执行错误的次数，例如，命令不存在、参数错误等情况 | 次/秒 | `instanceid`               | 5s、 60s、 300s、 3600s、 86400s |
| `KeeKeyspaceHitUtil` | 缓存命中率       | 指在使用缓存系统时，请求的数据在缓存中被找到的比例。缓存命中率 = 缓存命中次数 / 总请求数 | %     | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeKeys            | key总个数        | 实例存储的总 Key 个数（一级 Key）                            | 个    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeExpireKeys      | key过期数        | 时间窗内被淘汰的 Key 个数，对应 info 命令输出的 expired_keys | 个/秒 | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskUsed        | 硬盘使用量       | 硬盘已经使用的容量                                           | MB    | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskUtil        | 硬盘使用率       | 硬盘已经使用的容量与最大容量的占比                           | %     | `instanceid`                | 5s、 60s、 300s、 3600s、 86400s |
| KeeDiskIops        | 硬盘IOPS使用量   | 每秒硬盘进行输入输出操作的次数。                             | 次/秒 | `instanceid`              | 5s、 60s、 300s、 3600s、 86400s |

## 对象 {#object}
采集到的腾讯云 KeeWiDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_redis",
  "tags": {
    "name"        : "crs-xxxx",
    "BillingMode" : "0",
    "Engine"      : "Redis",
    "InstanceId"  : "crs-xxxx",
    "InstanceName": "solution",
    "Port"        : "6379",
    "ProductType" : "standalone",
    "ProjectId"   : "0",
    "RegionId"    : "ap-shanghai",
    "Status"      : "2",
    "Type"        : "6",
    "WanIp"       : "172.x.x.x",
    "ZoneId"      : "200002"
  },
  "fields": {
    "ClientLimits"    : "10000",
    "Createtime"      : "2022-07-14 13:54:14",
    "DeadlineTime"    : "0000-00-00 00:00:00",
    "InstanceNodeInfo": "{实例节点信息}",
    "InstanceTitle"   : "运行中",
    "Size"            : 1024,
    "message"         : "{实例 JSON 数据}"
  }
}
```

部分参数说明如下

| 字段          | 类型 | 说明                                                         |
| :------------ | :--- | :----------------------------------------------------------- |
| `Status`      | str  | 实例当前状态。0：待初始化。 1：实例在流程中。 2：实例运行中。 -2：实例已隔离。 -3：实例待删除。 |
| `ProductType` | str  | 产品类型。 standalone ：标准版。 cluster ：集群版。          |
| `BillingMode` | str  | 计费模式。 0：按量计费。 1：包年包月。                       |
| `ProjectId`   | str  | 项目 ID                                                      |
| `NodeSet`     | str  | 实例的节点详细信息。 注意：此字段可能返回 null，表示取不到有效值。 |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
> 提示1：`tags.name`值为实例ID，作为唯一识别
> 提示2：`fields.message`为JSON序列化后字符串
