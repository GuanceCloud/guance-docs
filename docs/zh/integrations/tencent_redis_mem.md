---
title: '腾讯云 Redis'
summary: '腾讯云 Redis 指标展示，包括连接数、请求数、时延、慢查询等。'
__int_icon: 'icon/tencent_redis_mem'
dashboard:

  - desc: '腾讯云 Redis 内置视图'
    path: 'dashboard/zh/tencent_redis_mem'

monitor:
  - desc: '腾讯云 Redis 监控器'
    path: 'monitor/zh/tencent_redis_mem'

---

<!-- markdownlint-disable MD025 -->
# 腾讯云 Redis
<!-- markdownlint-enable -->


腾讯云 Redis 指标展示，包括连接数、请求数、时延、慢查询等。


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 腾讯云-Redis 的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-Redis采集）」(ID：`guance_tencentcloud_redis`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-redis/){:target="_blank"}



### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-Redis,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/49729){:target="_blank"}

### Redis 实例监控

| 指标英文名         | 指标中文名          | 指标说明                                                     | 单位  | 维度         | 统计粒度                         |
| ------------------ | ------------------- | ------------------------------------------------------------ | ----- | ------------ | -------------------------------- |
| `CpuUtil`          | CPU 使用率          | 平均 CPU 使用率                                              | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CpuMaxUtil`       | 节点最大 CPU 使用率 | 实例中节点（分片或者副本）最大 CPU 使用率                    | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `MemUsed`          | 内存使用量          | 实际使用内存容量，包含数据和缓存部分                         | MB    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `MemUtil`          | 内存使用率          | 实际使用内存和申请总内存之比                                 | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `MemMaxUtil`       | 节点最大内存使用率  | 实例中节点（分片或者副本）最大内存使用率                     | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Keys`             | Key 总个数          | 实例存储的总 Key 个数（一级 Key）                            | 个    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Expired`          | Key 过期数          | 时间窗内被淘汰的 Key 个数，对应 info 命令输出的 expired_keys | 个    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Evicted`          | Key 驱逐数          | 时间窗内被驱逐的 Key 个数，对应 info 命令输出的 evicted_keys | 个    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Connections`      | 连接数量            | 连接到实例的 TCP 连接数量                                    | 个    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `ConnectionsUtil`  | 连接使用率          | 实际 TCP 连接数量和最大连接数比                              | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `InFlow`           | 入流量              | 内网入流量                                                   | Mb/s  | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `InBandwidthUtil`  | 入流量使用率        | 内网入流量实际使用和最大流量比                               | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `InFlowLimit`      | 入流量限流触发      | 入流量触发限流的次数                                         | 次    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `OutFlow`          | 出流量              | 内网出流量                                                   | Mb/s  | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `OutBandwidthUtil` | 出流量使用率        | 内网出流量实际使用和最大流量比                               | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `OutFlowLimit`     | 出流量限流触发      | 出流量触发限流的次数                                         | 次    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyAvg`       | 平均执行时延        | Proxy 到 Redis Server 的执行时延平均值                       | ms    | `instanceid` | 5s、60s、300s、3600s、86400s     |
| `LatencyMax`       | 最大执行时延        | Proxy 到 Redis Server 的执行时延最大值                       | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyRead`      | 读平均时延          | Proxy 到 Redis Server 的读命令平均执行时延                   | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyWrite`     | 写平均时延          | Proxy 到 Redis Server 的写命令平均执行时延                   | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `LatencyOther`     | 其他命令平均时延    | Proxy 到 Redis Server 的读写命令之外的命令平均执行时延       | ms    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `Commands`         | 总请求              | QPS，命令执行次数                                            | 次/秒 | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdRead`          | 读请求              | 每秒读命令执行次数                                           | 次/秒 | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdWrite`         | 写请求              | 每秒写命令执行次数                                           | 次/秒 | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdOther`         | 其他请求            | 每秒读写命令之外的命令执行次数                               | 次/秒 | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdBigValue`      | 大 Value 请求       | 每秒请求命令大小超过32KB的执行次数                           | 次/秒 | `instanceid` | 5s、60s、300s、3600s、86400s     |
| `CmdKeyCount`      | Key 请求数          | 命令访问的 Key 个数                                          | 个/秒 | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdMget`          | **Mget** 请求数     | **Mget** 命令执行次数                                        | 个/秒 | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdSlow`          | 慢查询              | 执行时延大于 slowlog - log - slower - than 配置的命令次数    | 次    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdHits`          | 读请求命中          | 读请求 Key 存在的个数，对应 info 命令输出的 keyspace_hits 指标 | 次    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdMiss`          | 读请求Miss          | 读请求 Key 不存在的个数，对应 info 命令输出的 keyspace_misses 指标 | 次    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdErr`           | 执行错误            | 命令执行错误的次数，例如，命令不存在、参数错误等情况         | 次    | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |
| `CmdHitsRatio`     | 读请求命中率        | Key 命中 / (Key 命中 + KeyMiss)，该指标可以反应 Cache Miss 的情况 | %     | `instanceid` | 5s、 60s、 300s、 3600s、 86400s |





### 各维度对应参数总览

| 参数名称                         | 维度名称     | 维度解释               | 格式                                                         |
| -------------------------------- | ------------ | ---------------------- | ------------------------------------------------------------ |
| `Instances.N.Dimensions.0.Name`  | `instanceid` | 实例 ID 维度名称       | 输入 String 类型维度名称：**instanceid**                     |
| `Instances.N.Dimensions.0.Value` | `instanceid` | 实例具体 ID            | 输入实例的具体 Redis 实例 ID，例如：`tdsql-123456` 也可以是实例串号，例如：`crs-ifmymj41`，可通过 [查询 Redis 实例列表接口](https://cloud.tencent.com/document/api/239/20018){:target="_blank"} 查询 |
| `Instances.N.Dimensions.1.Name`  | `rnodeid`    | redis 节点 ID 维度名称 | 输入 String 类型维度名称：**rnodeid**                        |
| `Instances.N.Dimensions.1.Value` | `rnodeid`    | redis 具体节点 ID      | 输入 Redis 具体节点 ID，可以通过 [查询实例节点信息](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} 接口获取 |
| `Instances.N.Dimensions.1.Name`  | `pnodeid`    | proxy 节点 ID 维度名称 | 输入 String 类型维度名称：**pnodeid**                        |
| `Instances.N.Dimensions.1.Value` | `pnodeid`    | proxy 具体节点 ID      | 输入 proxy 具体节点 ID，可以通过 [查询实例节点信息](https://cloud.tencent.com/document/api/239/48603){:target="_blank"} 接口获取 |
| `Instances.N.Dimensions.1.Name`  | `command`    | 命令字维度名称         | 输入 String 类型维度名称：**command**                        |
| `Instances.N.Dimensions.1.Value` | `command`    | 具体命令字             | 输入具体命令字，例如：ping、get等                            |

### 入参说明

**查询云数据库 Redis 实例监控数据，入参取值如下：** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=实例的 ID`

**查询云数据库 Proxy 节点监控数据，入参取值如下：** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=实例的 ID &Instances.N.Dimensions.1.Name=pnodeid &Instances.N.Dimensions.1.Value=proxy 节点ID`

**查询云数据库 Redis 节点监控数据，入参取值如下：** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=实例的 ID &Instances.N.Dimensions.1.Name=rnodeid  &Instances.N.Dimensions.1.Value=Redis 节点ID`

**查询云数据库 Redis 时延指标（command 维度）监控数据，入参取值如下：** `&Namespace=QCE/REDIS_MEM &Instances.N.Dimensions.0.Name=instanceid &Instances.N.Dimensions.0.Value=实例的 ID &Instances.N.Dimensions.1.Name=command &Instances.N.Dimensions.1.Value=具体命令字`

## 对象 {#object}
采集到的腾讯云 Redis 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

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

## 日志 {#logging}

### 慢查询统计

#### 慢查询统计前提条件

> 提示 1：本脚本的代码运行依赖 Redis 实例对象采集，如果未配置 Redis 的自定义对象采集，慢日志脚本无法采集到慢日志数据

#### 慢查询统计安装脚本

在之前的基础上，需要再安装一个对应 **RDS 慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（腾讯云-Redis慢查询日志采集） 」(ID：`guance_tencentcloud_redis_slowlog`)

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

```json
{
    "measurement": "tencentcloud_redis_slow_log",
    "tags": {
        "BillingMode" : "0",
        "Client"      : "",
        "Engine"      : "Redis",
        "InstanceId"  : "crs-rha4zlon",
        "InstanceName": "crs-rha4zlon",
        "Node"        : "6d5d8cc6fxxxx",
        "Port"        : "6379",
        "ProductType" : "standalone",
        "ProjectId"   : "0",
        "RegionId"    : "ap-shanghai",
        "Status"      : "2",
        "Type"        : "8",
        "WanIp"       : "172.17.0.9",
        "ZoneId"      : "200002",
        "name"        : "crs-xxxx"
    },
    "fields": {
        "Command"    : "config",
        "CommandLine": "config get whitelist-ips",
        "Duration"   : 1,
        "ExecuteTime": "2022-07-22 18:00:28",
        "message"    : "{实例JSON数据}"
    }
}
```

部分参数说明如下

| 字段          | 类型    | 说明           |
| :------------ | :------ | :------------- |
| `Duration`    | Integer | 慢查询耗时     |
| `Client`      | String  | 客户端地址     |
| `Command`     | String  | 命令           |
| `CommandLine` | String  | 详细命令行信息 |
| `ExecuteTime` | String  | 执行时间       |
| `Node`        | String  | 1节点ID        |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
> 提示1：`tags.name`值为实例ID，作为唯一识别
> 提示2：`fields.message`为JSON序列化后字符串
