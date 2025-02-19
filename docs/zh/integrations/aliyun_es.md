---
title: '阿里云 ElasticSearch'
tags: 
  - 阿里云
summary: '阿里云 ElasticSearch 指标展示，包括集群状态、索引 QPS、 节点 CPU/内存/磁盘使用率等。'
__int_icon: 'icon/aliyun_es'
dashboard:
  - desc: '阿里云 ElasticSearch 内置视图'
    path: 'dashboard/zh/aliyun_es/'

monitor:
  - desc: '阿里云 ElasticSearch 监控器'
    path: 'monitor/zh/aliyun_elasticsearch/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 ElasticSearch
<!-- markdownlint-enable -->

阿里云 ElasticSearch 指标展示，包括集群状态、索引 QPS、 节点 CPU/内存/磁盘使用率等。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 ElasticSearch 云资源的监控数据，我们安装对应的采集脚本：「{{{ custom_key.brand_name }}}集成（阿里云-ElasticSearch采集）」(ID：`guance_aliyun_elasticsearch`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

> 如果要采集对应的日志，还要开启相应的日志采集脚本。如果要采集账单，要开启云账单采集脚本。

我们默认采集了一些配置, 具体见指标一栏

[配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-aliyun-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在{{{ custom_key.brand_name }}}平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在{{{ custom_key.brand_name }}}平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好阿里云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [阿里云云监控指标详情](https://help.aliyun.com/document_detail/163515.html){:target="_blank"}

| Metric Id                       |              Metric Name              | Dimensions              | Statistics      | Unit         |
| ---- | :----: | ---- | ---- | ---- |
| `ClusterAutoSnapshotLatestStatus` |               快照状态                | userId,clusterId        | Maximum         | value        |
| `ClusterIndexQPS`               |              集群写入QPS              | userId,clusterId        | Average         | Count/Second |
| `ClusterQueryQPS`               |              集群查询QPS              | userId,clusterId        | Average         | Count/Second |
| `ClusterStatus`                 |               集群状态                | userId,clusterId        | Value,Maximum   | value        |
| `NodeCPUUtilization`            |    elasticsearch实例节点CPU使用率     | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeDiskUtilization`           |    elasticsearch实例节点磁盘使用率    | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeHeapMemoryUtilization`     | elasticsearch实例节点HeapMemory使用率 | userId,clusterId,nodeIP | Average,Maximum | %            |
| `NodeLoad_1m`                   |              节点Load_1m              | userId,clusterId,nodeIP | Average         | value        |
| `NodeStatsDataDiskR`            |         每秒完成的读请求数量          | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsDataDiskRm`           |           每秒钟读取的大小            | userId,clusterId,nodeIP | Maximum         | MB/s         |
| `NodeStatsDataDiskUtil`         |                IOUtil                 | userId,clusterId,nodeIP | Maximum         | %            |
| `NodeStatsDataDiskW`            |         每秒完成的写请求数量          | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsDataDiskWm`           |           每秒钟写入的大小            | userId,clusterId,nodeIP | Maximum         | MB/s         |
| `NodeStatsExceptionLogCount`    |             Exception次数             | userId,clusterId,nodeIP | Maximum         | Count        |
| `NodeStatsFullGcCollectionCount` |              FullGc次数               | userId,clusterId,nodeIP | Maximum         | Count        |
| `NodeStatsNetworkinPackages`    |            节点网络流入包             | userId,clusterId,nodeIP | Maximum         | count        |
| `NodeStatsNetworkinRate` | 数据流入率 | userId,clusterId,nodeIP | Maximum | kB/s |
| `NodeStatsNetworkoutPackages` | 节点网络流出包 | userId,clusterId,nodeIP | Maximum | count |
| `NodeStatsNetworkoutRate` | 数据流出率 | userId,clusterId,nodeIP | Maximum | kB/s |
| `NodeStatsTcpEstablished` | 节点TCP链接数 | userId,clusterId,nodeIP | Maximum | count |

## 对象 {#object}

采集到的阿里云 ElasticSearch 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "aliyun_elasticsearch",
  "tags": {
    "RegionId"       : "cn-hangzhou",
    "esVersion"      : "7.4.0_with_X-Pack",
    "instanceId"     : "es-cn-xxxx",
    "name"           : "es-cn-xxxx",
    "paymentType"    : "prepaid",
    "resourceGroupId": "rg-acfm2l3p7xxxx",
    "serviceVpc"     : "True",
    "status"         : "active"
  },
  "fields": {
    "advancedDedicateMaster": false,
    "createdAt"             : "2021-04-07T06:10:50.527Z",
    "extendConfigs"         : "[ {集群扩展参数配置 JSON 数据}, ...]",
    "message"               : "{实例 JSON 数据}"
  }
}
```

## 日志 {#logging}

### 前提条件
> 提示1：使用本采集器前，必须安装「{{{ custom_key.brand_name }}}集成 Core 核心包」及其配套的第三方依赖包
> 提示2：本脚本的代码运行依赖 mongodb 实例对象采集，如果未配置 mongodb 的自定义对象采集，慢日志脚本无法采集到慢日志数据

<!-- markdownlint-disable MD024 -->

### 安装脚本

<!-- markdownlint-enable -->

在之前的基础上，需要再安装一个对应 **elasticsearch 日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「{{{ custom_key.brand_name }}}集成（阿里云-ElasticSearch采集）」(ID：`guance_aliyun_elasticsearch_log`)


### 数据上报格式
数据正常同步后，可以在{{{ custom_key.brand_name }}}的「基础设施-自定义对象」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "aliyun_elasticsearch_log",
  "tags": {
    "RegionId"       : "cn-hangzhou",
    "esVersion"      : "7.10.0_with_X-Pack",
    "host"           : "10.14.xxx.xxx",
    "instanceId"     : "es-cn-xxxx",
    "name"           : "es-cn-xxxx",
    "paymentType"    : "prepaid",
    "resourceGroupId": "rg-aekzkcwe4dxxxx",
    "serviceVpc"     : "True",
    "status"         : "active"
  },
  "fields": {
    "timestamp"        : 1684304299000,
    "contentCollection": "[ {日志详细信息 JSON 数据}, ...]",
    "message"          : "{实例 JSON 数据}"
  }
}

```

log_types（日志类型）赋值含义：

| 取值 | 说明 |
| ---- |---- |
| `INSTANCELOG` | 主日志 |
| `SEARCHSLOW` | searching慢日志 |
| `INDEXINGSLOW` | indexing慢日志 |
| `JVMLOG` | GC日志 |
| `ES_SEARCH_ACCESS_LOG` | ES访问日志 |
| `AUDIT` | 审计日志 |

> *注意：`tags`、`fields` 中的字段可能会随后续更新有所变动*
> 提示1：tags.name值为实例 ID，作为唯一识别
> 提示2：`fields.message` 为 JSON 序列化后字符串
