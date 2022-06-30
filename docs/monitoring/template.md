# 模板
---

## 概述

观测云内置多种开箱即用的监控模板，支持通过「+ 从模板新建」一键创建主机、Docker、Elasticsearch、Redis、阿里云 RDS、阿里云 SLB、Flink 监控。成功新建模板后，即自动添加对应的官方监控器至当前工作空间。

**注意：**新建模板前需在主机上 [安装 DataKit ](../datakit/datakit-install.md) ，并开启配置相关采集器，否则模板对应的监控器无法产生告警事件。

## 新建模板

在「监控器」中，选择「+ 从模板新建」，即可添加指定官方监控模板至当前空间。目前支持主机、Docker、Elasticsearch、Redis、阿里云 RDS、阿里云 SLB、Flink 监控模板，无需手动配置，开箱即用。

![](img/2.monitor_sample_1.png)

## 模板列表

观测云已提供官方监控模板，包括主机、Docker、Elasticsearch、Redis、阿里云 RDS、阿里云 SLB、Flink 监控模板等。

| **模板（分组）** | **监控器** |
| --- | --- |
| 主机检测库 | 主机 CPU IOwait 过高<br>主机文件系统剩余 inode 过低<br>主机内存 Swap 使用率过高<br>主机剩余磁盘空间过低<br>主机 CPU 平均负载过高<br>主机内存小于 100M<br>主机 CPU 使用率过高<br>主机内存使用率过高 |
| Docker 检测库 | Docker 容器 CPU 使用率过高<br>Docker 容器内存使用率过高<Docker 容器状态检测> |
| Elasticsearch 检测库 | Elasticsearch 平均 JVM 堆内存的使用量过高<br>Elasticsearch 搜索查询负载异常<br>Elasticsearch 合并索引线程池中被拒绝的线程数异常增加<br>Elasticsearch 转换索引线程池中被拒绝的线程数异常增加<br>Elasticsearch 搜索线程池中被拒绝的线程数异常增加<br>Elasticsearch 合并线程池中被拒绝的线程数异常增加<br>Elasticsearch 集群状态异常<br>Elasticsearch 平均 CPU 使用率 过高<br>Elasticsearch 查询拒绝率过高 |
| Redis 检测库 | Redis 等待阻塞命令的客户端连接数异常增加 |
| 阿里云 RDS Mysql 检测库 | 阿里云 RDS Mysql 每秒慢查询数过高<br>阿里云 RDS Mysql 磁盘使用率过高<br>阿里云 RDS Mysql IOPS 使用率过高<br>阿里云 RDS Mysql 连接数使用率过高<br>阿里云 RDS Mysql 内存使用率过高<br>阿里云 RDS Mysql CPU 使用率过高 |
| 阿里云 SLB 检测库 | 阿里云 SLB 实例 QPS 使用率过高<br>阿里云 SLB 后端 ECS 异常 |
| Flink 监控 | 输出缓冲池中的所有缓冲区已满<br>TaskManager 堆内存不足 |
