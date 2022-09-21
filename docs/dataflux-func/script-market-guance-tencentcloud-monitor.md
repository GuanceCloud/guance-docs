# 采集器「腾讯云-云监控」配置手册
---


阅读本文前，请先阅读：

- [观测云集成 - 基本操作](/dataflux-func/script-market-guance-integration)

> 提示：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包

> 提示 2：采集腾讯云云监控数据前，必须先配置对应产品的自定义对象采集器。

## 1. 配置结构

本采集器配置结构如下：

| 字段                    | 类型 | 是否必须 | 说明                                                                                                                                   |
| ----------------------- | ---- | -------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `Regions`               | List | 必须     | 所需采集的云监控地域列表                                                                                                               |
| `regions[#]`            | str  | 必须     | 地域 ID 如：`ap-shanghai`<br>总表见附录                                                                                                |
| `targets`               | list | 必须     | 云监控采集对象配置列表<br>相同命名空间的多个配置之间逻辑关系为「且」                                                                   |
| `targets[#].namespace`  | str  | 必须     | 所需采集的云监控命名空间。如：`QCE/CVM`总表见附录                                                                                      |
| `targets[#].metrics`    | list | 必须     | 所需采集的云监控指标名列表<br>总表见附录                                                                                               |
| `targets[#].metrics[#]` | str  | 必须     | 指标名模式，支持`"NOT"`、通配符方式匹配<br>正常情况下，多个之间逻辑关系为「或」 包含`"NOT"`标记时，多个之间逻辑关系为「且」。 详见下文 |

## 2. 配置示例

### 指定特定指标

采集`QCE/CVM`中名称为`WanOuttraffic`、`WanOutpkg`的 2 个指标

```python
tencentcloud_monitor_configs = {
    'regions': ['ap-shanghai'],
    'targets': [
        {
            'namespace': 'QCE/CVM',
            'metrics'  : ['WanOuttraffic', 'WanOutpkg'],
        }
    ]
}
```

### 通配符匹配指标

指标名可以使用`*`通配符来匹配。

本例中以下指标会被采集：

- 名称为`WanOutpkg`的指标

- 名称以`Wan`开头的指标

- 名称以`Outpkg`结尾的指标

- 名称中包含`Out`的指标

```python
tencentcloud_monitor_configs = {
    'regions': ['ap-shanghai'],
    'targets': [
        {
            'namespace': 'QCE/CVM',
            'metrics'  : ['WanOutpkg', 'Wan*', '*Outpkg', '*Out*']
        }
    ]
}
```

### 剔除部分指标

在开头添加`"NOT"`标记表示去除后面的指标。

本例中以下指标【不会】被采集：

- 名称为`WanOutpkg`的指标

- 名称以`Wan`开头的指标

- 名称以`Outpkg`结尾的指标

- 名称中包含`Out`的指标

```python
tencentcloud_monitor_configs = {
    'regions': ['ap-shanghai'],
    'targets': [
        {
            'namespace': 'QCE/CVM',
            'metrics'  : ['NOT', 'WanOutpkg', 'Wan*', '*Outpkg', '*Out*']
        }
    ]
}
```

### 多重过滤指定所需指标

相同的命名空间可以指定多次，从上到下依次按照指标名进行过滤。

本例中，相当于对指标名进行了如下过滤步骤：

1. 选择所有名称中包含`Out`的指标

1. 在上一步结果中，去除名称为`WanOutpkg`的指标

```python
tencentcloud_monitor_configs = {
    'regions': ['ap-shanghai'],
    'targets': [
        {
            'namespace': 'QCE/CVM',
            'metrics'  : ['*Out*']
        },
        {
            'namespace': 'QCE/CVM',
            'metrics'  : ['NOT', 'WanOutpkg']
        }
    ]
}
```

## 3. 数据采集说明

### 云产品配置信息

| 产品名称         | 命名空间 (Namespace) | 维度 (Dimension)             | 说明                                                         |
| ---------------- | -------------------- | ---------------------------- | ------------------------------------------------------------ |
| 云服务器         | `QCE/CVM`            | `InstanceId`                 | `vm_uuid`、`vmUuid`、 `uuid`、`InstanceId` 统一识别为对象数据中的 `InstanceId` |
| 云数据库 Mysql   | `QCE/CDB`            | `InstanceId`、`InstanceType` |                                                              |
| 对象存储监控     | `QCE/COS`            | `BucketName`                 |                                                              |
| 公网负载均衡监控 | `QCE/LB_PUBLIC`      | `vip`                        | 对象数据中的` Address `字段被识别为`vip`                     |
| 内网负载均衡监控 | `QCE/LB_PRIVATE`     | `vip`、`vpcId`               |                                                              |
| 云数据库 Redis   | `QCE/REDIS_MEM`      | `InstanceId`                 | 目前仅支持 Redis 实例监控，暂不支持节点监控                  |
| 云数据库 MongoDB | `QCE/CMONGO`         | `InstanceId`                 | 目前仅支持 MongoDB 实例监控，暂不支持副本集、节点监控        |

### 监控指标配置信息

*注意：目前采集器只支持采集实例级别的指标，建议用户按照各命名空间对应的指标名配置*

#### QCE/CVM

- [云服务器监控指标](https://cloud.tencent.com/document/product/248/6843)

| 指标英文名 (MetricName) | 指标中文名                   |
| ----------------------- | ---------------------------- |
| WanInpkg                | 外网入包量                   |
| WanIntraffic            | 外网入带宽                   |
| WanOutpkg               | 外网出包量                   |
| WanOuttraffic           | 外网出带宽                   |
| AccOuttraffic           | 外网出流量                   |
| BaseCpuUsage            | 基础 CPU 使用率              |
| CpuLoadavg              | CPU 一分钟平均负载           |
| CPUUsage                | CPU 利用率                   |
| Cpuloadavg5m            | CPU 五分钟平均负载           |
| Cpuloadavg15m           | CPU 十五分钟平均负载         |
| CvmDiskUsage            | 磁盘利用率                   |
| LanInpkg                | 内网入包量                   |
| LanOutpkg               | 内网出包量                   |
| LanIntraffic            | 内网入带宽                   |
| LanOuttraffic           | 内网出带宽                   |
| MemUsage                | 内存利用率                   |
| MemUsed                 | 内存使用量                   |
| TcpCurrEstab            | TCP 连接数                   |
| TimeOffset              | 子机 utc 时间和 ntp 时间差值 |
| GpuMemTotal             | GPU 内存总量                 |
| GpuMemUsage             | GPU 内存使用率               |
| GpuMemUsed              | GPU 内存使用量               |
| GpuPowDraw              | GPU 功耗使用量               |
| GpuPowLimit             | GPU 功耗总量                 |
| GpuPowUsage             | GPU 功耗使用率               |
| GpuTemp                 | GPU 温度                     |
| GpuUtil                 | GPU 使用率                   |

#### QCE/CDB

- [云数据库 MySQL 监控指标](https://cloud.tencent.com/document/product/248/45147)

| 指标英文名 (MetricName)      | 指标中文名                      |
| ---------------------------- | ------------------------------- |
| BytesReceived                | 内网入流量                      |
| BytesSent                    | 内网出流量                      |
| Capacity                     | 磁盘占用空间                    |
| ComCommit                    | 提交数                          |
| ComDelete                    | 删除数                          |
| ComInsert                    | 插入数                          |
| ComReplace                   | 覆盖数                          |
| ComRollback                  | 回滚数                          |
| ComUpdate                    | 更新数                          |
| ConnectionUseRate            | 连接数利用率                    |
| CpuUseRate                   | CPU 利用率                      |
| CreatedTmpDiskTables         | 磁盘临时表数量                  |
| CreatedTmpFiles              | 临时文件数量                    |
| CreatedTmpTables             | 内存临时表数量                  |
| HandlerCommit                | 内部提交数                      |
| HandlerReadRndNext           | 读下一行请求数                  |
| HandlerRollback              | 内部回滚数                      |
| InnodbBufferPoolPagesFree    | InnoDB 空页数                   |
| InnodbBufferPoolPagesTotal   | InnoDB 总页数                   |
| InnodbBufferPoolReadRequests | innodb 缓冲池预读页次数         |
| InnodbBufferPoolReads        | innodb 磁盘读页次数             |
| InnodbCacheHitRate           | innodb 缓存命中率               |
| InnodbCacheUseRate           | innodb 缓存使用率               |
| InnodbDataReads              | InnoDB 总读取量                 |
| InnodbDataWrites             | InnoDB 总写入量                 |
| InnodbDataWritten            | InnoDB 写入量                   |
| InnodbNumOpenFiles           | 当前 InnoDB 打开表的数量        |
| InnodbOsFileReads            | innodb 读磁盘数量               |
| InnodbOsFileWrites           | innodb 写磁盘数量               |
| InnodbOsFsyncs               | innodbfsync 数量                |
| InnodbRowLockTimeAvg         | InnoDB 平均获取行锁时间（毫秒） |
| InnodbRowLockWaits           | InnoDB 等待行锁次数             |
| InnodbRowsDeleted            | InnoDB 行删除量                 |
| InnodbRowsInserted           | InnoDB 行插入量                 |
| InnodbRowsRead               | InnoDB 行读取量                 |
| InnodbRowsUpdated            | InnoDB 行更新量                 |
| IOPS                         | 每秒的输入输出量（或读写次数）  |
| KeyBlocksUnused              | 键缓存内未使用的块数量          |
| KeyBlocksUsed                | 键缓存内使用的块数量            |
| KeyCacheHitRate              | myisam 缓存命中率               |
| KeyCacheUseRate              | myisam 缓存使用率               |
| KeyReadRequests              | 键缓存读取数据块次数            |
| KeyReads                     | 硬盘读取数据块次数              |
| KeyWriteRequests             | 数据块写入键缓冲次数            |
| KeyWrites                    | 数据块写入磁盘次数              |
| LogCapacity                  | 日志使用量                      |
| MasterSlaveSyncDistance      | 主从延迟距离                    |
| MaxConnections               | 最大连接数                      |
| MemoryUseRate                | 内存利用率                      |
| MemoryUse                    | 内存占用                        |
| OpenFiles                    | 打开文件数                      |
| OpenedTables                 | 已经打开的表数                  |
| Qps                          | 每秒执行操作数                  |
| Queries                      | 总访问量                        |
| QueryRate                    | 访问量占比                      |
| RealCapacity                 | 磁盘使用空间                    |
| SecondsBehindMaster          | 主从延迟时间                    |
| SelectCount                  | 查询数                          |
| SelectScan                   | 全表扫描数                      |
| SlaveIoRunning               | IO 线程状态                     |
| SlaveSqlRunning              | SQL 线程状态                    |
| SlowQueries                  | 慢查询数                        |
| TableLocksImmediate          | 立即释放的表锁数                |
| TableLocksWaited             | 等待表锁次数                    |
| ThreadsConnected             | 当前连接数                      |
| ThreadsCreated               | 已创建的线程数                  |
| ThreadsRunning               | 运行的线程数                    |
| Tps                          | 每秒执行事务数                  |
| VolumeRate                   | 磁盘利用率                      |
| InnodbDataRead               | InnoDB 读取量                   |

#### QCE/COS

- [对象存储监控指标](https://cloud.tencent.com/document/product/248/45140)

| 指标英文名 (MetricName) | 指标中文名           |
| ----------------------- | -------------------- |
| StdReadRequests         | 标准存储读请求       |
| StdRetrieval            | 标准数据读取量       |
| StdWriteRequests        | 标准存储写请求       |
| IaRetrieval             | 低频数据读取量       |
| IaWriteRequests         | 低频存储写请求       |
| IaReadRequests          | 低频存储读请求       |
| NlWriteRequests         | Nl 写请求            |
| NlRetrieval             | Nl 取量              |
| CdnOriginTraffic        | CDN 回源流量         |
| InternetTraffic         | 外网下行流量         |
| InternalTraffic         | 内网下行流量         |
| InboundTraffic          | 外网、内网上传总流量 |

#### QCE/LB_PRIVATE

- [内网负载均衡监控指标](https://cloud.tencent.com/document/product/248/51899)

| 指标英文名 (MetricName) | 指标中文名                 |
| ----------------------- | -------------------------- |
| ClientConnum            | 客户端到 LB 的活跃连接数   |
| ClientInactiveConn      | 客户端到 LB 的非活跃连接数 |
| ClientConcurConn        | 客户端到 LB 的并发连接数   |
| ClientNewConn           | 客户端到 LB 的新建连接数   |
| ClientInpkg             | 客户端到 LB 的入包量       |
| ClientOutpkg            | 客户端到 LB 的出包量       |
| ClientAccIntraffic      | 客户端到 LB 的入流量       |
| ClientAccOuttraffic     | 客户端到 LB 的出流量       |
| ClientOuttraffic        | 客户端到 LB 的出带宽       |
| ClientIntraffic         | 客户端到 LB 的入带宽       |
| DropTotalConns          | 丢弃连接数                 |
| InDropBits              | 丢弃入带宽                 |
| OutDropBits             | 丢弃出带宽                 |
| InDropPkts              | 丢弃流入数据包             |
| OutDropPkts             | 丢弃流出数据包             |
| IntrafficVipRatio       | 入带宽利用率               |
| OuttrafficVipRatio      | 出带宽利用率               |
| UnhealthRsCount         | 健康检查异常数             |

#### QCE/LB_PUBLIC

- [公网负载均衡监控指标](https://cloud.tencent.com/document/product/248/51898)

| 指标英文名 (MetricName) | 指标中文名                       |
| ----------------------- | -------------------------------- |
| ClientConnum            | 客户端到 LB 的活跃连接数         |
| ClientInactiveConn      | 客户端到 LB 的非活跃连接数       |
| ClientConcurConn        | 客户端到 LB 的并发连接数         |
| ClientNewConn           | 客户端到 LB 的新建连接数         |
| ClientInpkg             | 客户端到 LB 的入包量             |
| ClientOutpkg            | 客户端到 LB 的出包量             |
| ClientAccIntraffic      | 客户端到 LB 的入流量             |
| ClientAccOuttraffic     | 客户端到 LB 的出流量             |
| ClientIntraffic         | 客户端到 LB 的入带宽             |
| ClientOuttraffic        | 客户端到 LB 的出带宽             |
| DropTotalConns          | 丢弃连接数                       |
| IntrafficVipRatio       | 公网入带宽利用率（未必有该指标） |
| InDropBits              | 丢弃入带宽                       |
| InDropPkts              | 丢弃流入数据包                   |
| OuttrafficVipRatio      | 公网出带宽利用率（未必有该指标） |
| OutDropBits             | 丢弃出带宽                       |
| OutDropPkts             | 丢弃流出数据包                   |
| UnhealthRsCount         | 健康检查异常数                   |

#### QCE/REDIS_MEM

- [云数据库 Redis 内存版监控指标（5 秒）](https://cloud.tencent.com/document/product/248/49729)

| 指标英文名 (MetricName) | 指标中文名          |
| ----------------------- | ------------------- |
| CpuUtil                 | CPU 使用率          |
| CpuMaxUtil              | 节点最大 CPU 使用率 |
| MemUsed                 | 内存使用量          |
| MemUtil                 | 内存使用率          |
| MemMaxUtil              | 节点最大内存使用率  |
| Keys                    | Key 总个数          |
| Expired                 | Key 过期数          |
| Evicted                 | Key 驱逐数          |
| Connections             | 连接数量            |
| ConnectionsUtil         | 连接使用率          |
| InFlow                  | 入流量              |
| InBandwidthUtil         | 入流量使用率        |
| InFlowLimit             | 入流量限流触发      |
| OutFlow                 | 出流量              |
| OutBandwidthUtil        | 出流量使用率        |
| OutFlowLimit            | 出流量限流触发      |
| LatencyAvg              | 平均执行时延        |
| LatencyMax              | 最大执行时延        |
| LatencyRead             | 读平均时延          |
| LatencyWrite            | 写平均时延          |
| LatencyOther            | 其他命令平均时延    |
| Commands                | 总请求              |
| CmdRead                 | 读请求              |
| CmdWrite                | 写请求              |
| CmdOther                | 其他请求            |
| CmdBigValue             | 大 Value 请求       |
| CmdKeyCount             | Key 请求数          |
| CmdMget                 | Mget 请求数         |
| CmdSlow                 | 慢查询              |
| CmdHits                 | 读请求命中          |
| CmdMiss                 | 读请求 Miss          |
| CmdErr                  | 执行错误            |
| CmdHitsRatio            | 读请求命中率        |

#### QCE/CMONGO

- [云数据库 MongoDB 监控指标](https://cloud.tencent.com/document/product/248/45104)

| 指标英文名 (MetricName) | 指标中文名                   |
| ----------------------- | ---------------------------- |
| Reads                   | 读取请求次数                 |
| Updates                 | 更新请求次数                 |
| Deletes                 | 删除请求次数                 |
| Counts                  | count 请求次数               |
| Success                 | 成功请求次数                 |
| Commands                | command 请求次数             |
| Qps                     | 每秒钟请求次数               |
| Delay10                 | 时延在 10 - 50 毫秒间请求次数  |
| Delay50                 | 时延在 50 - 100 毫秒间请求次数 |
| Delay100                | 时延在 100 毫秒以上请求次数    |
| ClusterConn             | 集群连接数                   |
| Connper                 | 连接使用率                   |
| ClusterDiskusage        | 磁盘使用率                   |

## 4. 数据上报格式

数据正常同步后，可以在观测云的「指标」中查看数据。

以如下采集器配置为例：

```python
tencentcloud_monitor_configs = {
    'regions': ['ap-shanghai'],
    'targets': [
        {
            'namespace': 'QCE/CVM',
            'metrics'  : ['WanOutpkg']
        }
    ]
}
```

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_QCE/CVM",
  "tags": {
    "InstanceId": "i-xxx"
  },
  "fields": {
    "WanOutpkg_max": 0.005
  }
}
```

> 提示：所有的指标值都会以`float`类型上报。
>
> 提示 2：本采集器采集了 QCE/CVM 命名空间 (Namespace) 下 WanOutpkg 指标数据，详情见 [数据采集说明](#3. 数据采集说明)表格。

## 5. 与自定义对象采集器联动

当同一个 DataFlux Func 中运行了其他自定义对象采集器（如： CVM ）时，本采集器会根据 [数据采集说明](#云产品配置信息)的维度信息补充字段。例如 CVM 根据云监控数据返回的`InstanceId`字段尝试匹配自定义对象中的`tags.name`字段。

由于需要先获知自定义对象信息才能在云监控采集器中进行联动，因此一般建议将云监控的采集器放置在列表末尾，如：

```python
# 创建采集器
collectors = [
    tencentcloud_cvm.DataCollector(account, common_tencentcloud_configs),
    tencentcloud_monitor.DataCollector(account, tencentcloud_monitor_configs) # 云监控采集器一般放在最末尾
]
```

当成功匹配后，会将所匹配的自定义对象 tags 中额外的字段加入到云监控数据的 tags 中，以此实现在使用实例名称筛选云监控的指标数据等效果。具体效果如下：

假设云监控采集到的原始数据如下：

```json
{
  "measurement": "tencentcloud_QCE/CVM",
  "tags": {
    "InstanceId": "i-xxx"
  },
  "fields": { "内容略" }
}
```

同时，腾讯云 CVM 采集器采集到的自定义对象数据如下：

```json
{
  "measurement": "tencentcloud_cvm",
  "tags": {
    "name"           : "i-xxx",
    "InstanceType"   : "c6g.xxx",
    "PlatformDetails": "xxx",
    "{其他字段略}"
  },
  "fields": { "内容略" }
}
```

那么，最终上报的云监控数据如下：

```json
{
  "measurement": "tencentcloud_QCE/CVM",
  "tags": {
    "name"            : "i-xxx",
    "InstanceId"		  : "i-xxx",   // 云监控原始字段
    "InstanceType"    : "c6g.xxx", // 来自自定义对象 CVM 的字段
    "PlatformDetails" : "xxx",     // 来自自定义对象 CVM 的字段
    "{其他字段略}"
  },
  "fields": { "内容略" }
}
```

## 注意事项

#### 触发任务抛错情况以及解决方法

1. `HTTPClientError: An HTTP Client raised an unhandled exception: SoftTimeLimitExceeded()`

   原因：任务执行时间过长 timeout。

   解决方法：

   - 适当加大对任务的 timeout 设置（如：`@DFF.API('执行采集', timeout=120, fixed_crontab="* * * * *")`，表示将任务的超时时间设置成 120 秒）。

2. `[TencentCloudSDKException] code:InvalidParameterValue message:cannot find metricName=xxx configure`

   原因：腾讯云不支持该指标的采集（会出现这种腾讯云文档里有该指标，实际却不支持的情况）

   解决方法：

   - 建议参考本文 [监控指标配置信息](#监控指标配置信息)，配置有效的指标名。

3. `[TencentCloudSDKException] code:InvalidParameterValue message: xxxxx does not belong to the developer ....`

   原因：采集某个账号下某个产品云监控数据时，该产品已经被释放了，造成接口抛错，可以忽视。

## X. 附录

### 腾讯云云监控

请参考腾讯云官方文档：

- [地域列表](https://cloud.tencent.com/document/api/248/30346#.E5.9C.B0.E5.9F.9F.E5.88.97.E8.A1.A8)
- [腾讯云的命名空间](https://cloud.tencent.com/document/api/248/44374?!editLang=%22qbk3vol)
- [监控指标](https://cloud.tencent.com/document/product/248/6843)
