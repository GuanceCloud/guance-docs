# 洞见 MySQL

---

> 作者： 刘锐

数据库作为业务的顶梁柱，左右着应用架构及应用性能，应用服务性能可以通过对服务本身横向伸缩来解决，但是数据库的性能决定了应用的最终命脉，MySQL  作为数据库之王，几乎运用在各行各业。随着业务增量，不规范的使用 SQL、大量慢查询会将应用拖垮，所以观测它显得尤为重要。

## MySQL 集成

[MySQL 集成文档](../../integrations/mysql.md)

## MySQL 监控

主要从4个方面来全局查看 MySQL 相关指标信息

1. 概览
1. 活动用户信息
1. InnoDB
1. 锁信息

### 概览

概览部分主要是对 连接数、QPS、TPS、异常连接数、每秒无索引 join 查下次数、Schema 大小分布、慢查询、锁等待时长等维度对 MySQL 进行概览分析。
![image.png](../images/mysql/mysql-1.png)

### 活动用户信息

你关注过 MySQL connection 吗？先来看个 error

```shell
MySQL: ERROR 1040: Too many connections
```

我们知道 MySQL 连接允许长连接和短连接，其自身建立连接的过程存在较大开销，所以一般会采用长连接。但使用长连接后可能会占用内存增多，因为 MySQL 在执行查询过程中临时使用内存管理连接对象，这些连接对象资源只有在连接断开时才会释放。如果长连接累计很多将导致内存占用加大而被系统强制 KILL 而发生 MySQL 服务异常重启的现象。

针对长连接的这种情况需要定期断开，可以通过判断连接所占用内存大小来推测是否为持久性的长连接。另外可以在每次执行较大的操作后执行 `mysql_reset_connection` 来重新初始化后连接资源。

MySQL 连接通常是一个用户请求一个连接，如果请求操作长时间没有执行完毕，会造成连接堆积，并迅速消耗数据库的连接数。也就是说如果数据库中有长时间没有执行完毕的 SQL，它会一直占用着连接并不释放。而在此时应用的请求会一直不断的涌入数据库，造成数据库连接数被快速用完。

在云原生、微服务背景下，对数据库的 Connection 要求越来越高，所以 MySQL Connection 也容易成为应用的瓶颈，`Too many connections`会导致 MySQL 所在机器 CPU 爆满，同时也会导致应用因无法获取更多的 Connection 而使业务中断。实时监控它，可以让我们快速的找到数据库瓶颈。甚至可以找到每一个用户 Connection 相关细节，比如当前用户 Connection 数以及累计 Connection 数。

![image.png](../images/mysql/mysql-2.png)

同时我们也能够根据当前 Connection 对 MySQL 做出优化操作：

- 增加最大连接数
- 主从备份读写分离
- 业务拆分引入多个数据库实例
- 增减缓存减少查询
- 等等

### InnoDB

通过配置 mysql.conf 中`innodb=true` 参数来开启 InnoDB 指标采集

![image.png](../images/mysql/mysql-3.png)

### 锁信息

![image.png](../images/mysql/mysql-4.png)

## MySQL 慢查询

对于生产业务系统来说，慢查询也是一种故障和风险，一旦出现故障将会造成系统不可用影响到生产业务。当有大量慢查询并且 SQL 执行得越慢，消耗的 CPU 资源或 IO 资源也会越大，因此，要解决和避免这类故障，关注慢查询本身是关键。

目前有两种方式可以进行优化慢查询操作

> 1、通过开启 **slow log 慢查询日志**，收集慢查询日志，人为对慢查询 SQL 执行 explain。
> 
> 2、利用观测云 通过 MySQL 开启 dbm 采集数据库性能指标，同时会自动选取部分执行耗时较高的 SQL 语句，获取其执行计划，并采集实际执行过程中的各种性能指标。


## MySQL  slow log

### 广义慢查询

我们更多常见的都是狭义慢查询，即查询时间超过了既定的时间，比如默认超过 10s 没有返回结果的查询语句标记为慢查询。除了这个之外，有一些情况也是可能导致慢查询发生，所以也是可以标记为慢查询：

- 返回记录集比较大的。
- 频繁使用没有使用索引的查询

### 开启慢查询日志

以下配置是 MySQL  5.7 开启慢查询的方式

```toml
#### slow log  慢查询日志 ####
slow_query_log = 1 ## 开启慢查询日志
slow_query_log_file = /var/log/mysql/slow.log ## 慢查询日志文件名称
long_query_time = 2 ##sql 语句超过2s就记录
# min_examined_row_limit = 100 ## sql执行中examined_row 取出数据必须大于100行才会记录
#log-queries-not-using-indexes ## 没有使用索引SQL的sql记录到慢查询
log_throttle_queries_not_using_indexes = 5 ## 限制每分钟记录没有使用索引Sql的次数 意思就是：一条sql语句一直在记录 记录太多了 占存储 一分钟只记录5次
log-slow-admin-statements = table ##记录管理的操作，例如alter | analyze talbe 命令
log_output = file ## 记录慢查询日志的格式 FILE|TABLE|NONE 默认是文件格式 TABLE 是以表的格式 不建议用table
log_timestamps = 'system' ## 慢日志记录的时间格式 采用系统的时间

```

这里记录了TOP 100的慢查询语句，需要查看更多慢查询，可以在日志查看器查看更多日志信息

![image.png](../images/mysql/mysql-5.png)

## MySQL dbm

数据库性能指标主要来源于 MySQL 的内置数据库 `performance_schema`, 该数据库提供了一个能够在运行时获取服务器内部执行情况的方法。通过该数据库，DataKit 能够采集历史查询语句的各种指标统计和查询语句的执行计划，以及其他相关性能指标。采集的性能指标数据保存为日志，source 分别为 `mysql_dbm_metric`, `mysql_dbm_sample `和 `mysql_dbm_activity`。

通过开启 dbm 可以直接采集到数据库性能指标数据，采集器配置参考：[MySQL](/datakit/mysql/#performance-schema)

```toml
[[inputs.mysql]]

# 开启数据库性能指标采集
dbm = true

...

# 监控指标配置
[inputs.mysql.dbm_metric]
  enabled = true

# 监控采样配置
[inputs.mysql.dbm_sample]
  enabled = true

# 等待事件采集
[inputs.mysql.dbm_activity]
  enabled = true   
...

```

### `mysql_dbm_metric` 视图

通过开启 `dbm` 采集上来的数据库性能指标，可以在视图上直观分析当前数据的性能：慢查询最大耗时、慢插入最大耗时、慢查询 SQL 执行次数、单条 SQL 最大执行次数（执行频率）、最长锁时间等。

![image.png](../images/mysql/mysql-6.png)

在视图 【**SQL 耗时 TOP 20 】,**根据查询时间倒排序，取出前20条 慢查询的 SQL ,也可以通过调整里面的参数来展示自己需要的 TOP N。

![image.png](../images/mysql/mysql-7.png)

### `mysql_dbm_activity` 视图

通过构建`mysql_dbm_activity` 视图，可以观测到当前 正在执行的 SQL 数、事件类型分布（当前事件属于CPU事件还是 User sleep 事件等）、事件状态分布（比如：Sending data、Creating sort index等）、事件Command Type 分布（如当前是 Query 还是 sleep ）以及事件列表。

#### 事件类型分布

指的是 Processing SQL 的事件类型

- CPU
- User sleep

![image.png](../images/mysql/mysql-8.png)

#### 事件状态分布

即当前 Processing SQL 的状态类型分布情况，状态类型主要有如下几种：

- init ：初始执行
- Sending data： 正在发送数据
- Creating sort index ： 正在创建排序索引
- freeing items：释放当前项目
- converting HEAP to MyISAM：将堆转换为MyISAM
- query end：查询完成
- Opening tables：正在打开表
- statistics：统计

![image.png](../images/mysql/mysql-9.png)

#### 事件Command Type 分布

即当前 Processing SQL 的 Command Type 分布情况，主要有以下几种类型：

- query : 查询，query 需要结合 `事件状态`一起分析
- sleep：休眠，还没有被调度
- daemon：以 daemon 方式运行

![image.png](../images/mysql/mysql-10.png)

#### 事件列表

事件 Top 100 ，即查询当前100条事件记录，包括事件id（processlist_id）、processlist_user(当前事件所属用户)、DB Host(事件主机)、SQL(执行事件语句)、process Host(事件发起主机)、事件类型、事件状态以及事件执行时间等。

![image.png](../images/mysql/mysql-11.png)

#### 根据 schema 来查看 process 事件走势
通过查看对应 schema 的事件走势，来分析当前 schema 的压力情况。

![image.png](../images/mysql/mysql-12.png)

## 视图模板
[MySQL 监控视图]

[MySQL Activity]

[MySQL dbm Metric]

[MySQL 慢查询]
