---
title: '华为云 DDS'
tags: 
  - 华为云
summary: '采集华为云 DDS 指标数据'
__int_icon: 'icon/huawei_dds'
dashboard:
  - desc: '华为云 DDS 内置视图'
    path: 'dashboard/zh/huawei_dds/'

monitor:
  - desc: '华为云 DDS 监控器'
    path: 'monitor/zh/huawei_dds/'
---

采集 华为云 DDS 指标数据

## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/)

> 推荐部署GSE版

### 安装脚本

> 提示：请提前准备好符合要求的华为云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步华为云 DDS 监控数据，我们安装对应的采集脚本:

- **guance_huaweicloud_dds**: 采集 DDS 监控指标数据
- **guance_huaweicloud_dds_slowlog**: 采集 DDS 慢日志数据

点击【安装】后，输入相应的参数：华为云 AK、华为云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

脚本安装完后，在 Func 中「开发」里找到脚本「<<< custom_key.brand_name >>>集成（华为云-DDS采集）」/「<<< custom_key.brand_name >>>集成 (华为云-DDS慢查询日志采集) 」，展开修改脚本，找 collector_configs 和 monitor_configs 分别编辑下面 region_projects中的内容，将地域和 Project ID,更改为实际的地域和 Project ID，再点击保存发布。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。

### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 - 资源目录」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据
4. 在<<< custom_key.brand_name >>>，「日志」查看是否有对应慢日志数据

## 指标 {#metric}

配置华为云 DDS 指标, 可以通过配置的方式采集更多的指标 [华为云 DDS 指标详情](https://support.huaweicloud.com/usermanual-dds/dds_03_0026.html){:target="_blank"}

| **指标ID**            |          **指标名称**   | **指标含义** | **取值范围**      | **测量对象** | **监控周期（原始指标）** |
| ---- | :----: | ------ | ------ | ---- | ---- |
| `mongo001_command_ps`            |   command执行频率    | 该指标用于统计平均每秒command语句在节点上执行次数，以次数/秒为单位。单位：Executions/s   | ≥ 0 Executions/s  | 文档数据库实例 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点 | 1分钟 5秒                   |
| `mongo002_delete_ps`            |   delete语句执行频率   | 该指标用于统计平均每秒delete语句在节点上执行次数。单位：Executions/s            | ≥ 0 Executions/s         | 文档数据库实例 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点 | 1分钟 5秒              |
| `mongo003_insert_ps`            |    insert语句执行频率  | 该指标用于统计平均每秒insert语句在节点上执行次数，以次数/秒为单位。单位：Executions/s | ≥ 0 Executions/s    | 文档数据库实例 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟 5秒              |
| `mongo004_query_ps`             |    query语句执行频率    | 该指标用于统计平均每秒query语句在节点上执行次数。单位：Executions/s | ≥ 0 Executions/s  | 文档数据库实例 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点 | 1分钟 5秒                 |
| `mongo006_getmore_ps`           |      update语句执行频率      | 该指标用于统计平均每秒update语句在节点上执行次数。单位：Executions/s   | 0 Executions/s      | 文档数据库实例 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点       | 1分钟 5秒                    |
| `mongo007_chunk_num1`           |     分片一的chunk数    | 该指标用于统计分片一的chunk个数。 单位：counts                           | 0~64 Counts       | 文档数据库集群实例   | 1分钟 5秒                    |
| `mongo007_chunk_num2`       |      分片二的chunk数      | 该指标用于统计分片二的chunk个数。 单位：counts           | 0~64 Counts       | 文档数据库集群实例       | 1分钟 5秒                    |
| `mongo007_chunk_num3`         |   分片三的chunk数    | 该指标用于统计分片三的chunk个数。 单位：counts           | 0~64 Counts | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num4`          |  分片四的chunk数  | 该指标用于统计分片四的chunk个数。 单位：counts           | 0~64 Counts | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num5`          |  分片五的chunk数  | 该指标用于统计分片五的chunk个数。 单位：counts          | 0~64 Counts | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num6`           |  分片六的chunk数   | 该指标用于统计分片六的chunk个数。 单位：counts          | 0~64 Counts   | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num7`          |  分片七的chunk数  | 该指标用于统计分片七的chunk个数。 单位：counts          | 0~64 Counts | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num8`         | 分片八的chunk数  | 该指标用于统计分片八的chunk个数。 单位：counts          | 0~64 Counts | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num9`        |    分片九的chunk数    | 该指标用于统计分片九的chunk个数。 单位：counts         | 0~64 Counts   | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num10`     | 分片十的chunk数 | 该指标用于统计分片十的chunk个数。 单位：counts            | 0~64 Counts      | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num11`       |       分片十一的chunk数       | 该指标用于统计分片十一的chunk个数。 单位：counts           | 0~64 Counts       | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_chunk_num12`        |       分片十二的chunk数       | 该指标用于统计分片十二的chunk个数。 单位：counts            | 0~64 Counts       | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo008_connections` |     实例当前活动连接数     | 该指标用于统计试图连接到DDS实例的总连接数。 单位：Counts                   | 0~200 Counts | 文档数据库实例      | 1分钟 5秒                    |
| `mongo009_migFail_num` |       过去一天块迁移的失败次数       | 该指标用于统计过去一天中块迁移失败的次数。 单位：Counts/s                       | ≥ 0 Counts/s | 文档数据库集群实例 | 1分钟 5秒                    |
| `mongo007_connections`     |     当前活动连接数     | 该指标用于统计试图连接到DDS实例节点的总连接数。 单位：Counts                   | 0~200 Counts | 文档数据库实例 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟 5秒                    |
| `mongo007_connections_usage`    |     当前活动连接数百分比     | 该指标用于统计试图连接到实例节点的连接数占可用连接数百分比。 单位：%                   | 0~100% | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟 5秒                    |
| `mongo008_mem_resident`       |    驻留内存    | 该指标用于统计当前驻留内存的大小。 单位：MB               | ≥ 0 MB   | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo009_mem_virtual`     |   虚拟内存   | 该指标用于统计当前虚拟内存的大小。 单位：MB                   | ≥ 0 MB   | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo010_regular_asserts_ps`     |   常规断言频率   | 该指标用于统计常规断言频率。 单位：Executions/s             | ≥ 0 Executions/s   | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo011_warning_asserts_ps`        |      警告频率      | 该指标用于统计警告频率。 单位：Executions/s           | ≥ 0 Executions/s   | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo012_msg_asserts_ps`       |       消息断言频率       | 该指标用于统计消息断言频率。 单位：Executions/s             | ≥ 0 Executions/s   | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo013_user_asserts_ps`       |    用户断言频率    | 该指标用于统计用户断言频率。 单位：Executions/s           | ≥ 0 Executions/s   | 文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo014_queues_total`    |    等待锁的操作    | 该指标用于统计当前等待锁的操作数。  单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo015_queues_readers`    |    等待读锁的操作数    | 该指标用于统计当前等待读锁的操作数。  单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo016_queues_writers`    |    等待写锁的操作数    | 该指标用于统计当前等待写锁的操作数。  单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo017_page_faults`    |    缺页错误数    | 该指标用于统计当前节点上的缺页错误数。  单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo018_porfling_num`    |    慢查询数    | 该指标用于统计当前节点上的前5分钟到当前时间点的慢查询总数。  单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo019_cursors_open`    |    当前维护游标数    | 该指标用于统计当前节点上的维护游标数。 单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo020_cursors_timeOut`    |    服务超时游标数    | 该指标用于统计当前节点上的服务超时游标数。  单位：Counts       | ≥ 0 Counts   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo021_wt_cahe_usage`    |    内存中数据量（WiredTiger引擎）    | 该指标用于统计当前内存中数据量（WiredTiger引擎）。  单位：MB       | ≥ 0 MB   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo022_wt_cahe_dirty`    |    内存中脏数据量（WiredTiger引擎）    | 该指标用于统计当前内存中脏数据量（WiredTiger引擎）。  单位：MB       | ≥ 0 MB   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo023_wInto_wtCache`    |    写入WiredTiger内存的频率    | 该指标用于统计当前内存中写入频率（WiredTiger引擎）。  单位：≥ Bytes/s      | ≥ 0 Bytes/s   |     文档数据库实例下的主节点 文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo024_wFrom_wtCache`    |    从WiredTiger内存写入磁盘频率    | 该指标用于统计当前内存写入磁盘频率（WiredTiger引擎）。  单位：Bytes/s       | ≥ 0 Bytes/s   |     文档数据库实例下的主节点 | 1分钟                    |
| `mongo025_repl_oplog_win`    |    主节点的Oplog中可用时间    | 该指标用于统计当前实例下的主节点的Oplog中可用时间。  单位：Hours       | ≥ 0 Hours   |    文档数据库实例下的备节点的节点 | 1分钟                    |
| `mongo025_repl_headroom`    |   主备Oplog重叠时长    | 该指标用于统计实例下的主节点和Secondary节点之间Oplog重叠时长。  单位：Seconds       | ≥ 0 Seconds   |     文档数据库实例下的备节点 | 1分钟                    |
| `mongo026_repl_lag`    |    主备延时    | 该指标用于统计实例下的主节点和Secondary节点之间的复制延时。  单位： Seconds      |≥ 0 Seconds   |     文档数据库实例下的备节点 | 1分钟                    |
| `mongo027_repl_command_ps`    |    备节点复制的command执行频率    | 该指标用于统计平均每秒Secondary节点复制的command语句执行次数。  单位：Executions/s      | ≥ 0 Executions/s   |     文档数据库实例下的备节点 | 1分钟                    |
| `mongo028_repl_update_ps`    |    备节点复制的update语句执行频率    | 该指标用于统计平均每秒Secondary节点复制的update语句执行次数。  单位：Executions/s       | ≥ 0 Executions/s   |   文档数据库实例下的备节点   | 1分钟                    |
| `mongo029_repl_delete_ps`    |    备节点复制的delete语句执    | 该指标用于统计平均每秒Secondary节点复制的delete语句执行次数。  单位：Executions/s       | ≥ 0 Executions/s   |   文档数据库实例下的备节点   | 1分钟                    |
| `mongo030_repl_insert_ps`    |    备节点复制的insert语句执行频率    | 该指标用于统计平均每秒Secondary节点复制的insert语句执行次数。  单位：Executions/s       | ≥ 0 Executions/s   |   文档数据库实例下的备节点   | 1分钟                    |
| `mongo031_cpu_usage`         |    CPU使用率    | 该指标用于统计测量对象的CPU利用率。    单位：%       | 0~100%   |   文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo032_mem_usage`    |    内存使用率    | 该指标用于统计测量对象的内存利用率。        单位：%       | 0~100%   |   文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo033_bytes_out`    |    网络输出吞吐量    | 该指标用于统计平均每秒从测量对象的所有网络适配器输出的流量。  单位：Bytes/s       | ≥ 0 Bytes/s   |   文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                      |
| `mongo034_bytes_in`    |    网络输入吞吐量    | 该指标用于统计平均每秒从测量对象的所有网络适配器输入的流量。   单位：Bytes/s       | ≥ 0 Bytes/s   |   文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo035_disk_usage`    |    磁盘利用率    | 该指标用于统计测量对象的磁盘利用率。   单位：%       | 0~100%   |   文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo036_iops`    |    IOPS    | 该指标用于统计当前实例节点，单位时间内系统处理的I/O请求数量（平均值）。  单位：Counts       | ≥ 0 Counts/s   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo037_read_throughput`    |    硬盘读吞吐量    | 硬盘平均每秒读字节数。  单位：Bytes/s       | ≥ 0 Bytes/s   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo038_write_throughput`    |   硬盘写吞吐量    | 硬盘平均每秒写字节数。   单位：Bytes/s      | ≥ 0 Bytes/s   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo039_avg_disk_sec_per_read`    |    硬盘读耗时    | 该指标用于统计某段时间平均每次读取硬盘所耗时间。   单位：Seconds       | ≥ 0 Seconds   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo040_avg_disk_sec_per_write`    |    硬盘写耗时    | 该指标用于统计某段时间平均每次写入硬盘所耗时间。   单位：Seconds       | ≥ 0 Seconds   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo042_disk_total_size`    |    磁盘总大小    | 该指标用于统计测量对象的磁盘总大小。   单位：GB      | 0~1000 GB   |   文档数据库集群实例下的dds mongos节点 文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo043_disk_used_size`    |   磁盘使用量    | 该指标用于统计测量对象的磁盘已使用总大小。   单位：GB      | 0~1000 GB   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo044_swap_usage`    |    SWAP利用率    | 交换内存SWAP使用率百分数。          单位：%       | 0~100%   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo050_top_total_time`    |    集合花费的总时间    | Mongotop-total time指标，集合操作花费的时间总和。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo051_top_read_time`    |    集合读花费的总时间    | Mongotop-read time指标，集合读操作花费的时间总和。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo052_top_write_time`    |    集合写花费的总时间    | Mongotop-write time指标，集合写操作花费的时间总和。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo053_wt_flushes_status`    |    周期Checkpoint的触发次数    | WiredTiger一个轮询间隔期间checkpoint的触发次数，记录周期内发生的次数单位。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo054_wt_cache_used_percent`    |    Wiredtiger使用中的缓存百分比    | Wiredtiger使用中的缓存大小百分数。   单位：%       | 0~100%   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo055_wt_cache_dirty_percent`    |    Wiredtiger脏数据的缓存百分比    | Wiredtiger脏数据的缓存大小百分数。   单位：%       | 0~100%   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo070_rocks_active_memtable`    |    memtable中的数据大小    | 采集当前活动memtable中的数据大小。   单位：GB       | 0~100 GB   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo071_rocks_oplogcf_active_memtable`    |    oplogcf上memtable中的数据大小    | 采集当前用于oplogcf上活动memtable中的数据大小。   单位：GB       | 0~100GB   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo072_rocks_all_memtable`    |    memtable和immutable-mem中的总数据大小    | 采集当前memtable和immutable-mem中的总数据大小。   单位：GB       | 0~100GB   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo073_rocks_oplogcf_all_memtable`    |    oplogcf上memtable和immutable-mem中的总数据大小    | 采集当前用于oplogcf上memtable和immutable-mem中的总数据大小。   单位：GB       | 0~100GB   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo074_rocks_snapshots`    |    未释放的snapshot的数量    | 采集当前未释放的snapshot的数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo075_rocks_oplogcf_snapshots`    |    oplogcf上未释放的snapshot的数量    |   采集当前oplogcf上未释放的snapshot的数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo076_rocks_live_versions`    |    活动的版本数量    | 采集当前活动的版本数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo077_rocks_oplogcf_live_versions`    |    oplogcf上活动的版本数量    | 采集当前oplogcf上活动的版本数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo078_rocks_block_cache`    |    驻留在blockcache中的数据大小    | 采集当前驻留在blockcache中的数据大小。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo079_rocks_background_errors`    |    后台累积错误数量    | 采集记录后台累积错误数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo080_rocks_oplogcf_background_errors`    |    oplogcf上后台累积错误数量    | 采集记录oplogcf上后台累积错误数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo081_rocks_conflict_bytes_usage`    |    事务写写冲突处理缓冲区使用率    | 采集事务写中写冲突处理缓冲区使用率。   单位：%       | 0~100%   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo082_rocks_uncommitted_keys`    |    未提交的key的数量    | 采集当前未提交的key的数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo083_rocks_committed_keys`    |    提交的key的数量    | 采集当前已提交的key的数量。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo084_rocks_alive_txn`    |    活跃事务链表的长度    | 采集记录活跃事务链表的长度   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo085_rocks_read_queue`    |    读队列的长度    | 采集当前读队列的长度。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo086_rocks_commit_queue`    |    提交队列的长度    | 采集当前提交队列的长度。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo087_rocks_ct_write_out`    |    已使用并发写事务数    | 采集当前已使用并发写事务数   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo088_rocks_ct_write_available`    |    剩余可用并发写事务数    | 采集当前剩余可用并发写事务数。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo089_rocks_ct_read_out`    |    已使用并发读    | 采集当前已使用并发读事务数。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo090_rocks_ct_read_available`    |    剩余可用并发读事务数     | 采集当前剩余可用并发读事务数。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例下的主节点 文档数据库实例下的备节点   | 1分钟                    |
| `mongo091_active_session_count`    |    周期活跃会话数    | 该指标用于统计自上次刷新周期以来Mongo实例在内存中缓存的所有活跃本地会话的数目。   单位：Counts       | ≥ 0 Counts   |  文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点    | 1分钟                    |
| `mongo092_rx_errors`    |    接收报文错误率    | 该指标用于统计监控周期内接收报文中错误报文数量与全部接收报文比值。   单位：%      | 0～100%   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo093_rx_dropped`    |    接收报文丢包率    | 该指标用于监控周期内统计接收报文中丢失报文数量与全部接收报文比值。   单位：%       | 0～100%   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo094_tx_errors`    |    发送报文错误率    | 该指标用于监控周期内统计发送报文中错误报文数量与全部发送报文比值。   单位：%       | 0～100%   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo095_tx_dropped`    |    发送报文丢包率    | 该指标用于监控周期内统计发送报文中丢失报文数量与全部发送报文比值。   单位：%       | 0～100%   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo096_retrans_segs`    |    重传包数目    | 该指标用于监控周期内统计重传包数目。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo097_retrans_rate`    |    重传比例    | 该指标用于监控周期内统计重传包比例。   单位：%       | 0～100%   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo098_out_rsts_nums`    |    发送RST数目    | 该指标用于监控周期内统计RST数目。   单位：Counts       | ≥ 0 Counts   |   文档数据库实例   | 1分钟 5秒                   |
| `mongo099_read_time_average`    |    读命令耗时平均值    | 该指标为单个节点的读命令耗时平均值。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo100_read_time_p99`    |    读命令p99耗时    | 该指标为单个节点的读命令p99耗时。   单位：Milliseconds      | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo101_read_time_p999`    |    读命令p999耗时    | 该指标为单个节点的读命令p999耗时。   单位：Milliseconds      | ≥ 0 Milliseconds  |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo102_write_time_average`    |    写命令耗时平均值    | 该指标为单个节点的写命令耗时平均值。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo103_write_time_p99`    |    写命令p99耗时    | 该指标为单个节点的写命令p99耗时。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo104_write_time_p999`    |    写命令p999耗时    | 该指标为单个节点的写命令p999耗时。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo105_command_time_average`    |    command耗时平均值    | 该指标为单个节点的节点command的耗时平均值。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo106_command_time_p99`    |    command p99耗时    | 该指标为单个节点的command耗时p99耗时。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo107_command_time_p999`    |    command p999耗时    | 该指标为单个节点的command耗时p999耗时。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo108_txn_time_average`    |    事务耗时平均值    | 该指标为单个节点的节点事务耗时平均值。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo109_txn_time_p99`    |    事务p99耗时    | 该指标为单个节点的事务p99耗时。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |
| `mongo110_txn_time_p999`    |    事务p999耗时    | 该指标为单个节点的事务p999耗时。   单位：Milliseconds       | ≥ 0 Milliseconds   |   文档数据库实例 文档数据库副本集实例下的只读节点 文档数据库实例下的主节点 文档数据库实例下的备节点 文档数据库实例下的隐藏节点   | 1分钟                   |

## 对象 {#object}

数据正常同步后，可以在<<< custom_key.brand_name >>>的「基础设施 - 资源目录」中查看数据。

```json
{
  "measurement": "huaweicloud_dds",
  "tags": {
    "RegionId"              : "cn-south-1",
    "project_id"            : "756ada1aa17e4049b2a16ea41912e52d",
    "enterprise_project_id" : "",
    "instance_id"           : "16b35ebaba1c44c39d9c24bae742ca97in02",
    "instance_name"         : "dds-3ed3",
    "status"                : "normal"
  },
  "fields": {
    "engine"            : "wiredTiger",
    "db_user_name"      : "rwuser",
    "mode"              : "",
    "pay_mode"          : "0",
    "port"              : "8635",
    "security_group_id" : "7aa51dbf-xxxx-xxxx-xxxx-dad3c4828b58",
    "ssl"               : "1",
    "vpc_id"            : "674e9b42-xxxx-xxxx-xxxx-5abcc565b961",
    "backup_strategy"   : "{实例 JSON 数据}",
    "datastore"         : "{实例 JSON 数据}",
    "groups"            : "[{实例 JSON 数据}]",
    "create_time"       : "2024-10-29T03:28:46",
    "update_time"       : "2024-11-04T13:21:35"
  }
}
```

> *注意：`tags`、`fields`中的字段可能会随后续更新有所变动*
>
> 提示 1：`tags.instance_id`值为实例 ID，作为唯一识别
>
> 提示 2：
>
> - `fields.message`
> - `fields.backup_strategy`
> - `fields.datastore`
> - `fields.groups`
> - `fields.actions`
