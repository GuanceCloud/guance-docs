# 官方监控器模板库
---


<<< custom_key.brand_name >>>提供多种开箱即用的监控模板，支持一键创建主机、Docker、Elasticsearch、Redis、阿里云 RDS、阿里云 SLB、Flink 等数十种监控模板。新建模板后，对应的官方监控器将自动添加到当前工作空间。

**注意**：新建模板前需在主机上[安装 DataKit](../../datakit/datakit-install.md)，并开启配置相关采集器，否则模板对应的监控器无法产生告警事件。

## 新建模板 {#create}

![](../img/monitor_template.png)

在监控器页面中，选择**从模板新建**，即可添加指定的官方监控模板。您可以选择单个或批量创建模板，无需手动配置，即可快速投入使用。

左侧为所有监控模版类型，右侧为模板类型下的所有检测规则。在当前页面，您可进行以下操作：

- 在左侧**检测库**中勾选特定检测库进行筛选；
- 分页查看检测规则，或在搜索栏中输入名称实时搜索；
- 多选右侧检测规则，批量创建监控；
- 创建成功后，返回监控器列表，点击打开某个监控器后，可编辑检测规则并保存。



<!--
## 模板列表

| **模板（分组）** | **监控器** |
| --- | --- |
| 主机检测库 | 主机 CPU IOwait 过高<br>主机文件系统剩余 inode 过低<br>主机内存 Swap 使用率过高<br>主机剩余磁盘空间过低<br>主机 CPU 平均负载过高<br>主机内存小于 100M<br>主机 CPU 使用率过高<br>主机内存使用率过高 |
| Docker 检测库 | Docker 容器 CPU 使用率过高<br>Docker 容器内存使用率过高<Docker 容器状态检测> |
| Elasticsearch 检测库 | Elasticsearch 平均 JVM 堆内存的使用量过高<br>Elasticsearch 搜索查询负载异常<br>Elasticsearch 合并索引线程池中被拒绝的线程数异常增加<br>Elasticsearch 转换索引线程池中被拒绝的线程数异常增加<br>Elasticsearch 搜索线程池中被拒绝的线程数异常增加<br>Elasticsearch 合并线程池中被拒绝的线程数异常增加<br>Elasticsearch 集群状态异常<br>Elasticsearch 平均 CPU 使用率 过高<br>Elasticsearch 查询拒绝率过高 |
| Redis 检测库 | Redis 等待阻塞命令的客户端连接数异常增加 |
| 阿里云 RDS Mysql 检测库 | 阿里云 RDS Mysql 每秒慢查询数过高<br>阿里云 RDS Mysql 磁盘使用率过高<br>阿里云 RDS Mysql IOPS 使用率过高<br>阿里云 RDS Mysql 连接数使用率过高<br>阿里云 RDS Mysql 内存使用率过高<br>阿里云 RDS Mysql CPU 使用率过高 |
| 阿里云 SLB 检测库 | 阿里云 SLB 实例 QPS 使用率过高<br>阿里云 SLB 后端 ECS 异常 |
| 阿里云 ECS 检测库 | 阿里云 ECS CPU 使用率过高<br>阿里云 ECS 内存使用率过高<br>阿里云 ECS 磁盘使用率过高<br>阿里云 ECS Inode 使用率过高<br>阿里云 ECS CPU 负载过高 |
| 阿里云 Elasticsearch 检测库 | 阿里云 Elasticsearch 实例节点 CPU 使用率过高<br>阿里云 Elasticsearch 实例节点内存使用率过高<br>阿里云 Elasticsearch 实例节点磁盘使用率过高<br>阿里云 Elasticsearch 实例节点 CPU 负载过高<br>阿里云 Elasticsearch 集群状态异常 |
| 阿里云 EIP 检测库 | 阿里云 EIP 网络流入带宽利用率过高<br>阿里云 EIP 网络流出带宽利用率过高 |
| 阿里云 MongoDB 副本集检测库 | 阿里云 MongoDB (副本集) CPU 使用率过高<br>阿里云 MongoDB (副本集) 连接数使用率过高<br>阿里云 MongoDB (副本集) 磁盘使用率过高<br>阿里云 MongoDB (副本集) IOPS 使用率过高<br>阿里云 MongoDB (副本集) 内存使用率过高 |
| 阿里云 Redis 标准版检测库 | 阿里云 Redis (标准版) CPU 使用率过高<br>阿里云 Redis (标准版) 内存使用率过高<br>阿里云 Redis (标准版) 连接数使用率过高<br>阿里云 Redis (标准版) QPS 使用率过高<br>阿里云 Redis (标准版) 平均响应时间过高<br>阿里云 Redis (标准版) 命中率过低 |
| Flink 监控 | 输出缓冲池中的所有缓冲区已满<br>TaskManager 堆内存不足 |
| Fluentd 检测库 | Fluentd 的 plugin 重试数过多<br>Fluentd 剩余缓冲区的可用空间 |
| Aerospike 检测库 | Aerospike 空间 Storage 剩余空间不足<br>Aerospike 空间 Memory 剩余空间不足 |
| Kubernetes 检测库 | Pod 状态异常<br>Pod 启动超时失败<br>Pod频繁重启<br>Job 执行失败 |
| Logstash 检测库 | Logstash 配置重新加载失败<br>Logstash Pipeline配置重新加载失败<br>Logstash Java 堆内存使用率过高 |
| PHP FPM 检测库 | PHP-FPM 请求等待队列过高<br>PHP-FPM 进程最大限制次数过多 |
| Ping 状态检测库 | 检测地址 Ping 不通<br>检测地址 Ping 丢包率过高<br>检测地址 Ping 响应时间过长 |
| Port 检测库 | 主机端口状态异常<br>主机端口响应时间过慢 |
| Procstat 检测库 | 主机进程状态异常 |
| RocketMQ 检测库 | RocketMQ 集群发送 tps 过高<br>RocketMQ 集群发送 tps 过低<br>RocketMQ 集群消费 tps 过高<br>RocketMQ 集群消费 tps 过低<br>RocketMQ 集群消费延迟过高<br>RocketMQ 集群消费堆积过高 |
| 腾讯云 CDB 检测库 | 腾讯云 CDB CPU 使用率过高<br>腾讯云 CDB 内存使用率过高<br>腾讯云 CDB 磁盘使用率过高<br>腾讯云 CDB 连接数使用率过高<br>腾讯云 CDB 主从延迟时间过高<br>腾讯云 CDB Slave IO 线程状态异常<br>腾讯云 CDB Slave SQL 线程状态异常<br>腾讯云 CDB 慢查询数过高 |
| 腾讯云 CLB Private 检测库 | 腾讯云 CLB Public 健康检查异常<br>腾讯云 CLB Public 入带宽利用率过高<br>腾讯云 CLB Public 出带宽利用率过高 |
| 腾讯云 CLB Public 检测库 | 腾讯云 CLB Private 入带宽利用率过高<br>腾讯云 CLB Private 出带宽利用率过高<br>腾讯云 CLB Private 健康检查异常 |
| 腾讯云 CVM 检测库 | 腾讯云 CVM CPU 负载过高<br>腾讯云 CVM CPU 使用率过高<br>腾讯云 CVM 内存使用率过高<br>腾讯云 CVM 磁盘使用率过高<br>腾讯云 CVM 系统时间偏差过高 |
| Zookeeper 检测库 | Zookeeper 堆积请求数过大<br>Zookeeper 平均响应延迟过高<br>Zookeeper 服务器宕机 |


-->