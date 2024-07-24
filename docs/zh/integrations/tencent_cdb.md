---
title: '腾讯云 CDB'
tags: 
  - 腾讯云
summary: '使用脚本市场中「官方脚本市场」系列脚本包把云监控 云资产的数据同步到观测云'
__int_icon: 'icon/tencent_cdb'
dashboard:

  - desc: '腾讯云 CDB 内置视图'
    path: 'dashboard/zh/tencent_cdb'

monitor:
  - desc: '腾讯云 CDB 监控器'
    path: 'monitor/zh/tencent_cdb'

---


<!-- markdownlint-disable MD025 -->
# 腾讯云 CDB
<!-- markdownlint-enable -->

使用脚本市场中「观测云云同步」系列脚本包把云监控 云资产的数据同步到观测云


## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的腾讯云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步腾讯云 CDB 的监控数据，我们安装对应的采集脚本：「观测云集成（腾讯云-CDB采集）」(ID：`guance_tencentcloud_cdb`)

点击【安装】后，输入相应的参数：腾讯云 AK、腾讯云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://func.guance.com/doc/script-market-guance-tencentcloud-monitor/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「基础设施 / 自定义」中查看是否存在资产信息
3. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好腾讯云-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [腾讯云云监控指标详情](https://cloud.tencent.com/document/product/248/45147){:target="_blank"}

### 资源监控

| 指标英文名      | 指标中文名   | 指标说明                                                     | 单位    | 维度                             | 统计粒度                       |
| --------------- | ------------ | ------------------------------------------------------------ | ------- | -------------------------------- | ------------------------------ |
| `BytesReceived` | 内网入流量   | 每秒接收的字节数                                             | 字节/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s   |
| `BytesSent`     | 内网出流量   | 每秒发送的字节数                                             | 字节/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `Capacity`      | 磁盘占用空间 | 包括 MySQL 数据目录和  `binlog、relaylog、undolog、errorlog、slowlog` 日志空间 | MB      | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `CpuUseRate`    | CPU 利用率   | 允许闲时超用，CPU 利用率可能大于100%                         | %       | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `IOPS`          | IOPS         | 每秒的输入输出量(或读写次数)                                 | 次/秒   | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `MemoryUse`     | 内存占用     | 允许闲时超用，实际内存占用可能大于购买规格                   | MB      | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `MemoryUseRate` | 内存利用率   | 允许闲时超用，内存利用率可能大于100%                         | %       | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `RealCapacity`  | 数据使用空间 | 仅包括 MySQL 数据目录，不含  `binlog、relaylog、undolog、errorlog、slowlog` 日志空间 | MB      | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |
| `VolumeRate`    | 磁盘利用率   | 磁盘使用空间/实例购买空间                                    | %       | InstanceId、InstanceType（选填） | 5s、 60s、 300s、3600s、86400s |

### 引擎监控（普通）- **MyISAM**

| 指标英文名        | 指标中文名            | 指标说明                    | 单位 | 维度                             | 统计粒度                         |
| ----------------- | --------------------- | --------------------------- | ---- | -------------------------------- | -------------------------------- |
| `KeyCacheHitRate` | **myisam** 缓存命中率 | **myisam** 引擎的缓存命中率 | %    | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `KeyCacheUseRate` | **myisam** 缓存使用率 | **myisam** 引擎的缓存使用率 | %    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s     |

### 引擎监控（普通）- **InnoDB**

| 指标英文名           | 指标中文名                   | 指标说明                               | 单位  | 维度                             | 统计粒度                         |
| -------------------- | ---------------------------- | -------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbCacheHitRate` | **innodb** 缓存命中率        | **Innodb** 引擎的缓存命中率            | %     | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s     |
| `InnodbCacheUseRate` | **innodb** 缓存使用率        | **Innodb** 引擎的缓存使用率            | %     | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbNumOpenFiles` | 当前 **InnoDB** 打开表的数量 | **Innodb** 引擎当前打开表的数量        | 个    | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbOsFileReads`  | **innodb** 读磁盘数量        | **Innodb** 引擎每秒读磁盘文件的次数    | 次/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbOsFileWrites` | **innodb** 写磁盘数量        | **Innodb** 引擎每秒写磁盘文件的次数    | 次/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbOsFsyncs`     | **innodbfsyn** 数量          | **Innodb** 引擎每秒调用 fsync 函数次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |

### 引擎监控（普通）- 连接

| 指标英文名          | 指标中文名     | 指标说明                                                     | 单位  | 维度                             | 统计粒度                     |
| ------------------- | -------------- | ------------------------------------------------------------ | ----- | -------------------------------- | ---------------------------- |
| `ConnectionUseRate` | 连接数利用率   | 当前打开连接数/最大连接数                                    | %     | InstanceId、InstanceType（选填） | 5s、10s、60s、300s、3600s    |
| `MaxConnections`    | 最大连接数     | 最大连接数                                                   | 个    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `Qps`               | 每秒执行操作数 | 数据库每秒执行的 SQL 数（含  insert、select、update、delete、replace），QPS 指标主要体现 TencentDB 实例的实际处理能力 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `ThreadsConnected`  | 当前连接数     | 当前打开的连接的数量                                         | 个    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `Tps`               | 每秒执行事务数 | 数据库每秒传输的事务处理个数                                 | 个/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（普通）- 访问

| 指标英文名    | 指标中文名 | 指标说明                                    | 单位  | 维度                             | 统计粒度                     |
| ------------- | ---------- | ------------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `ComDelete`   | 删除数     | 每秒删除数                                  | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `ComInsert`   | 插入数     | 每秒插入数                                  | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `ComReplace`  | 覆盖数     | 每秒覆盖数                                  | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、6400s  |
| `ComUpdate`   | 更新数     | 每秒更新数                                  | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `Queries`     | 总访问量   | 所有执行的 SQL 语句，包括 set，show 等      | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `QueryRate`   | 访问量占比 | 每秒执行操作数 QPS/推荐每秒操作数           | %     | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `SelectCount` | 查询数     | 每秒查询数                                  | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `SelectScan`  | 全表扫描数 | 执行全表搜索查询的数量                      | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `SlowQueries` | 慢查询数   | 查询时间超过 long_query_time 秒的查询的个数 | 个    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（普通）- 表

| 指标英文名       | 指标中文名     | 指标说明             | 单位  | 维度                             | 统计粒度                     |
| ---------------- | -------------- | -------------------- | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpTables` | 内存临时表数量 | 创建临时表的数量     | 个/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `TableLocksWaited` | 等待表锁次数   | 不能立即获得表锁次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `OpenedTables`   | 已经打开的表数 | 引擎已经打开的表的数量  | 个 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `TableLocksImmediate`| 立即释放的表锁数 | 引擎即将释放的表锁数  | 个 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（扩展）- **Tmp**

| 指标英文名             | 指标中文名     | 指标说明                 | 单位  | 维度                             | 统计粒度                     |
| ---------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `CreatedTmpDiskTables` | 磁盘临时表数量 | 每秒创建磁盘临时表的次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `CreatedTmpFiles`      | 临时文件数量   | 每秒创建临时文件的次数   | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（扩展）- **Key**

| 指标英文名         | 指标中文名             | 指标说明                                | 单位  | 维度                             | 统计粒度                     |
| ------------------ | ---------------------- | --------------------------------------- | ----- | -------------------------------- | ---------------------------- |
| `KeyBlocksUnused`  | 键缓存内未使用的块数量 | **myisam** 引擎未使用键缓存块的个数     | 个    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `KeyBlocksUsed`    | 键缓存内使用的块数量   | **myisam** 引擎已使用键缓存块的个数     | 个    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `KeyReadRequests`  | 键缓存读取数据块次数   | **myisam** 引擎每秒读取键缓存块的次数   | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `KeyReads`         | 硬盘读取数据块次数     | **myisam** 引擎每秒读取硬盘数据块的次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `KeyWriteRequests` | 数据块写入键缓冲次数   | **myisam** 引擎每秒写键缓存块的次数     | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `KeyWrites`        | 数据块写入磁盘次数     | **myisam** 引擎每秒写硬盘数据块的次数   | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（扩展）- **InnoDB Row**

| 指标英文名             | 指标中文名                          | 指标说明                            | 单位  | 维度                             | 统计粒度                         |
| ---------------------- | ----------------------------------- | ----------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbRowLockTimeAvg` | **InnoDB** 平均获取行锁时间（毫秒） | **Innodb** 引擎行锁定的平均时长     | ms    | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowLockWaits`   | **InnoDB** 等待行锁次数             | **Innodb** 引擎每秒等待行锁定的次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsDeleted`    | **InnoDB** 行删除量                 | **Innodb** 引擎每秒删除的行数       | 行/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsInserted`   | **InnoDB** 行插入量                 | **Innodb** 引擎每秒插入的行数       | 行/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsRead`       | **InnoDB** 行读取量                 | **Innodb** 引擎每秒读取的行数       | 行/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbRowsUpdated`    | **InnoDB** 行更新量                 | **Innodb** 引擎每秒更新的行数       | 行/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、86400s  |

### 引擎监控（扩展）- InnoDB Data

| 指标英文名          | 指标中文名          | 指标说明                                    | 单位    | 维度                             | 统计粒度                     |
| ------------------- | ------------------- | ------------------------------------------- | ------- | -------------------------------- | ---------------------------- |
| `InnodbDataRead`    | **InnoDB** 读取量   | **Innodb** 引擎每秒已经完成读取数据的字节数 | 字节/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `InnodbDataReads`   | **InnoDB** 总读取量 | **Innodb** 引擎每秒已经完成读取数据的次数   | 次/秒   | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `InnodbDataWrites`  | **InnoDB** 总写入量 | **Innodb** 引擎每秒已经完成写数据的次数     | 次/秒   | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `InnodbDataWritten` | **InnoDB** 写入量   | **Innodb** 引擎每秒已经完成写数据的字节数   | 字节/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（扩展）- **Handler**

| 指标英文名           | 指标中文名     | 指标说明                 | 单位  | 维度                             | 统计粒度                     |
| -------------------- | -------------- | ------------------------ | ----- | -------------------------------- | ---------------------------- |
| `HandlerCommit`      | 内部提交数     | 每秒事务提交的次数       | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `HandlerReadRndNext` | 读下一行请求数 | 每秒读取下一行的请求次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `HandlerRollback`    | 内部回滚数     | 每秒事务被回滚的次数     | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（扩展）- **Buff**

| 指标英文名                     | 指标中文名                  | 指标说明                                    | 单位  | 维度                             | 统计粒度                         |
| ------------------------------ | --------------------------- | ------------------------------------------- | ----- | -------------------------------- | -------------------------------- |
| `InnodbBufferPoolPagesFree`    | **InnoDB** 空页数           | **Innodb** 引擎内存空页个数                 | 个    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s             |
| `InnodbBufferPoolPagesTotal`   | **InnoDB** 总页数           | **Innodb** 引擎占用内存总页数               | 个    | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbBufferPoolReadRequests` | **Innodb** 缓冲池预读页次数 | **Innodb** 引擎每秒已经完成的逻辑读请求次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |
| `InnodbBufferPoolReads`        | **Innodb** 磁盘读页次数     | **Innodb** 引擎每秒已经完成的物理读请求次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、 60s、 300s、 3600s、 86400s |

### 引擎监控（扩展）- 其他

| 指标英文名    | 指标中文名 | 指标说明             | 单位  | 维度                             | 统计粒度                    |
| ------------- | ---------- | -------------------- | ----- | -------------------------------- | --------------------------- |
| `LogCapacity` | 日志使用量 | 引擎使用日志的数量   | MB    | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s        |
| `OpenFiles`   | 打开文件数 | 引擎打开的文件的数量 | 个/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600、86400s |

### 引擎监控（扩展）- 连接

| 指标英文名       | 指标中文名     | 指标说明                   | 单位 | 维度                             | 统计粒度                     |
| ---------------- | -------------- | -------------------------- | ---- | -------------------------------- | ---------------------------- |
| `ThreadsCreated` | 已创建的线程数 | 创建用来处理连接的线程数   | 个   | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `ThreadsRunning` | 运行的线程数   | 激活的（非睡眠状态）线程数 | 个   | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 引擎监控（扩展）- 访问

| 指标英文名    | 指标中文名 | 指标说明     | 单位  | 维度                             | 统计粒度                     |
| ------------- | ---------- | ------------ | ----- | -------------------------------- | ---------------------------- |
| `ComCommit`   | 提交数     | 每秒提交次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `ComRollback` | 回滚数     | 每秒回滚次数 | 次/秒 | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

### 数据库代理（Proxy）

| 指标英文名                | 指标中文名 | 单位 | 维度                     | 统计粒度                         |
| ------------------------- | ---------- | ---- | ------------------------ | -------------------------------- |
| `ProxyCpuUseRate`         | CPU 利用率 | %    | InstanceId、InstanceType | 5s、60s、300s、3600s、86400s     |
| `ProxyCurrentConnections` | 当前连接数 | 个   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyMemoryUseRate`      | 内存利用率 | %    | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyQueries`            | 请求数     | 个   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyRouteMaster`        | 写请求数   | 个   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyRouteSlave`         | 读请求数   | 个   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |
| `ProxyMemoryUse`          | 内存占用   | MB   | InstanceId、InstanceType | 5s、 60s、 300s、 3600s、 86400s |

### 部署监控（备机）

| 指标英文名                | 指标中文名   | 指标说明             | 单位                                | 维度                             | 统计粒度                     |
| ------------------------- | ------------ | -------------------- | ----------------------------------- | -------------------------------- | ---------------------------- |
| `MasterSlaveSyncDistance` | 主从延迟距离 | 主从 **binlog** 差距 | MB                                  | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `SecondsBehindMaster`     | 主从延迟时间 | 主从延迟时间         | 秒                                  | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `SlaveIoRunning`          | IO 线程状态  | IO 线程运行状态      | 状态值（0-Yes，1-No，2-Connecting） | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |
| `SlaveSqlRunning`         | SQL 线程状态 | SQL 线程运行状态     | 状态值（0-Yes，1-No）               | InstanceId、InstanceType（选填） | 5s、60s、300s、3600s、86400s |

## 对象 {#object}
采集到的腾讯云 CDB 对象数据结构, 可以从「基础设施-自定义」里看到对象数据

```json
{
  "measurement": "tencentcloud_cdb",
  "tags": {
    "name"         : "cdb-xxxxxxx",
    "RegionId"     : "ap-shanghai",
    "Region"       : "ap-shanghai",
    "InstanceId"   : "cdb-imxxxx",
    "InstanceName" : "smart_check_test",
    "InstanceType" : "1",
    "Zone"         : "ap-shanghai-3",
    "ZoneName"     : "",
    "DeviceType"   : "UNIVERSAL",
    "EngineVersion": "8.0",
    "Vip"          : "172.xx.x.9",
    "Status"       : "1",
    "ProtectMode"  : "0",
    "ProjectId"    : "0",
    "PayType"      : "1",
    "WanStatus"    : "0"
  },
  "fields": {
    "WanPort"     : 0,
    "Memory"      : 1000,
    "Volume"      : 25,
    "DeadlineTime": "0000-00-00 00:00:00",
    "CreateTime"  : "2022-04-27 15:18:06",
    "message"     : "{实例 JSON 数据}"
  }
}
```

## 日志 {#logging}

### 慢查询统计

#### 前提条件

> 提示 1 ：使用本采集器前，必须安装「观测云集成 Core 核心包」及其配套的第三方依赖包
>
> 提示 2：本脚本的代码运行依赖 CDB 实例对象采集，如果未配置 CDB 的自定义对象采集，慢日志脚本无法采集到慢日志数据

<!-- markdownlint-disable MD024 -->

#### 安装脚本

<!-- markdownlint-enable -->

在之前的基础上，需要再安装一个对应 **CDB慢查询统计日志采集的脚本**

在「管理 / 脚本市场」中点击并安装对应的脚本包：

- 「观测云集成（腾讯云-CDB慢查询日志采集）  」(ID：`guance_tencentcloud_cdb_slowlog`)

数据正常同步后，可以在观测云的「日志」中查看数据。

上报的数据示例如下：

```json
{
  "measurement": "tencentcloud_cdb_slow_log",
  "tags": {
    "name"          : "cdb-llxxxxx",
    "Database"      : "test",
    "UserHost"      : "9.xxx.xxx.122",
    "UserName"      : "root",
    "InstanceId"    : "cdb-lxxxxtk8",
    "DeviceType"    : "UNIVERSAL",
    "EngineVersion" : "8.0",
    "InstanceName"  : "cdbxxxxx",
    "InstanceType"  : "1",
    "PayType"       : "1",
    "ProjectId"     : "0",
    "ProtectMode"   : "0",
    "Region"        : "ap-shanghai",
    "RegionId"      : "ap-shanghai",
    "Status"        : "1",
    "Vip"           : "172.xx.xxx.15",
    "WanStatus"     : "0",
    "Zone"          : "ap-shanghai-3",
    "account_name"  : "脚本开发用 腾讯 Tencent 账号",
    "cloud_provider": "tencentcloud"
  },
  "fields": {
      "QueryTime"   : 3.000195,
      "SqlText"     : "select sleep(3)",
      "Timestamp"   : 1652933796,
      "LockTime"    : 0,
      "RowsExamined": 1,
      "RowsSent"    : 1,
      "SqlTemplate" : "select sleep(?);",
      "Md5"         : "26A15F1AE530F28F",
      "message"     : "{实例 JSON 数据}"
  }
}
```

部分参数说明如下

| 字段           | 类型    | 说明                 |
| :------------- | :------ | :------------------- |
| `QueryTime`    | float   | SQL 的执行时长（秒） |
| `Timestamp`    | integer | SQL 的执行时机       |
| `Md5`          | str     | SQL 语句的 MD5       |
| `LockTime`     | float   | 锁时长（秒）         |
| `RowsExamined` | integer | 扫描行数             |
| `RowsSent`     | integer | 结果集行数           |

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.name`值为实例 ID，作为唯一识别
>
> 提示 2：`fields.message`为 JSON 序列化后字符串
