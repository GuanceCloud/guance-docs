---
title: 'AWS MSK'
tags: 
  - AWS
summary: '使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_msk'
dashboard:

  - desc: 'AWS MSK 内置视图'
    path: 'dashboard/zh/aws_msk'

monitor:
  - desc: 'AWS MSK 监控器'
    path: 'monitor/zh/aws_msk'

---


<!-- markdownlint-disable MD025 -->
# AWS MSK
<!-- markdownlint-enable -->

Amazon Managed Streaming for Apache Kafka（Amazon MSK）是一项完全托管式服务，通过够构建并运行使用 Apache Kafka 来处理串流数据的应用程序。

使用脚本市场中「<<< custom_key.brand_name >>>云同步」系列脚本包把云监控 云资产的数据同步到<<< custom_key.brand_name >>>


## 配置 {#config}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的亚马逊 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 MSK 的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（AWS-Managed Streaming for Kafka采集）」(ID：`guance_aws_kafka`)

点击【安装】后，输入相应的参数：亚马逊 AK、亚马逊账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

此外，在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。



我们默认采集了一些配置, 具体见指标一栏 [配置自定义云对象指标](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好亚马逊-云监控,默认的指标集如下, 可以通过配置的方式采集更多的指标 [亚马逊云监控指标详情](https://docs.aws.amazon.com/zh_cn/msk/latest/developerguide/metrics-details.html){:target="_blank"}

### `DEFAULT`液位监控

下表中描述的指标在 `DEFAULT` 监控级别可用。这些指标是免费的。

| `DEFAULT` 监控级别可用的指标                             |                            |                                   |                                                              |
| :------------------------------------------------------- | :------------------------- | :-------------------------------- | :----------------------------------------------------------- |
| 名称                                                     | 当可见时                   | Dimensions                        | 描述                                                         |
| `ActiveControllerCount`                                  | 在集群进入 ACTIVE 状态后。 | 集群名称                          | 在任何给定时间，每个集群只能有一个控制器处于活动状态。       |
| `BurstBalance`                                           | 在集群进入 ACTIVE 状态后。 | 集群名称、代理 ID                 | 集群中 EBS 卷的输入输出突发积分的剩余余额。使用它来调查延迟或吞吐量降低。`BurstBalance`当卷的基准性能高于最大突发性能时，不会为 EBS 卷报告。有关更多信息，请参阅 [I/O 积分和突发性能](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#IOcredit){:target="_blank"}。 |
| `BytesInPerSec`                                          | 在创建主题后。             | 集群名称、代理 ID、主题           | 每秒从客户端接收的字节数。该指标适用于每个经纪人，也适用于每个主题。 |
| `BytesOutPerSec`                                         | 在创建主题后。             | 集群名称、代理 ID、主题           | 每秒发送到客户端的字节数。该指标适用于每个经纪人，也适用于每个主题。 |
| `ClientConnectionCount`                                  | 在集群进入 ACTIVE 状态后。 | 集群名称、代理 ID、客户端身份验证 | 经过身份验证的活跃客户端连接的数量。                         |
| `ConnectionCount`                                        | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 经过身份验证的活跃连接、未经身份验证的连接和代理间连接的数量。 |
| `CPUCreditBalance`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 该指标可以帮助您监控经纪商的CPU积分余额。如果您的 CPU 使用率持续高于 20% 的基准利用率，则可能会耗尽 CPU 积分余额，这可能会对集群性能产生负面影响。您可以采取措施降低 CPU 负载。例如，您可以减少客户端请求的数量或将代理类型更新为 M5 代理类型。 |
| `CpuIdle`                                                | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | CPU 空闲时间百分比。                                         |
| `CpuIoWait`                                              | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 待处理磁盘操作期间 CPU 空闲时间的百分比。                    |
| `CpuSystem`                                              | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 内核空间中的 CPU 百分比。                                    |
| `CpuUser`                                                | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 用户空间中的 CPU 百分比。                                    |
| `GlobalPartitionCount`                                   | 在集群进入 ACTIVE 状态后。 | 集群名称                          | 集群中所有主题（不包括副本）的分区数量。由于`GlobalPartitionCount`不包括副本，因此`PartitionCount`值的总和可能高于GlobalPartitionCount主题的重复因子大于 1 时的值。 |
| `GlobalTopicCount`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称                          | 集群中所有代理的主题总数。                                   |
| `EstimatedMaxTimeLag`                                    | 消费群体消费主题后。       | 消费者团体，话题                  | 耗尽的估计时间（以秒为单位）`MaxOffsetLag`。                 |
| `KafkaAppLogsDiskUsed`                                   | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 用于应用程序日志的磁盘空间的百分比。                         |
| `KafkaDataLogsDiskUsed`（`Cluster Name, Broker ID`尺寸） | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 用于数据日志的磁盘空间的百分比。                             |
| `KafkaDataLogsDiskUsed`（`Cluster Name`尺寸）            | 在集群进入 ACTIVE 状态后。 | 集群名称                          | 用于数据日志的磁盘空间的百分比。                             |
| `LeaderCount`                                            | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 每个代理的分区领导者总数，不包括副本。                       |
| `MaxOffsetLag`                                           | 消费群体消费主题后。       | 消费者团体，话题                  | 主题中所有分区的最大偏移延迟。                               |
| `MemoryBuffered`                                         | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的缓冲内存大小（以字节为单位）。                         |
| `MemoryCached`                                           | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的缓存内存大小（以字节为单位）。                         |
| `MemoryFree`                                             | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 可供代理使用的可用内存大小（以字节为单位）。                 |
| `HeapMemoryAfterGC`                                      | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 垃圾回收后使用的堆内存占总堆内存的百分比。                   |
| `MemoryUsed`                                             | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理正在使用的内存大小（以字节为单位）。                     |
| `MessagesInPerSec`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理每秒传入消息数。                                         |
| `NetworkRxDropped`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 丢弃的接收包的数量。                                         |
| `NetworkRxErrors`                                        | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的网络接收错误数。                                       |
| `NetworkRxPackets`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理收到的数据包的数量。                                     |
| `NetworkTxDropped`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 丢弃的传输包的数量。                                         |
| `NetworkTxErrors`                                        | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的网络传输错误的数量。                                   |
| `NetworkTxPackets`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理传输的数据包的数量。                                     |
| `OfflinePartitionsCount`                                 | 在集群进入 ACTIVE 状态后。 | 集群名称                          | 集群中处于脱机状态的分区的总数。                             |
| `PartitionCount`                                         | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 每个代理的主题分区总数，包括副本。                           |
| `ProduceTotalTimeMsMean`                                 | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 平均生成时间（以毫秒为单位）。                               |
| `RequestBytesMean`                                       | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的请求字节的平均数量。                                   |
| `RequestTime`                                            | 在应用请求限制后。         | 集群名称，代理 ID                 | 代理网络和 I/O 线程处理请求所花费的平均时间（以毫秒为单位）。 |
| `RootDiskUsed`                                           | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理所使用的根磁盘的百分比。                                 |
| `SumOffsetLag`                                           | 消费群体消费主题后。       | 消费者团体，话题                  | 主题中所有分区的聚合偏移延迟。                               |
| `SwapFree`                                               | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 对代理可用的交换内存的大小（以字节为单位）。                 |
| `SwapUsed`                                               | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理正在使用的交换内存的大小（以字节为单位）。               |
| `TrafficShaping`                                         | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 高级指标，表示因超出网络分配而形成（丢弃或排队）的数据包数量。PER_BROKER 指标可提供更详细的信息。 |
| `UnderMinIsrPartitionCount`                              | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的未完全管理分区的数目。                                 |
| `UnderReplicatedPartitions`                              | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理的未完全复制分区的数目。                                 |
| `ZooKeeperRequestLatencyMsMean`                          | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 来自代理的 Apache ZooKeeper 请求的平均延迟（以毫秒为单位）。 |
| `ZooKeeperSessionState`                                  | 在集群进入 ACTIVE 状态后。 | 集群名称，代理 ID                 | 代理ZooKeeper会话的连接状态可能是以下状态之一：NOT_CONNECTED：'0.0'，关联：'0.1'，正在连接：'0.5'，CONNECTEDREADONLY：'0.8'，已连接：'1.0'，已关闭：'5.0'，AUTH_FAILED：'10.0'。 |

### `PER_BROKER`液位监控

在将监控级别设置为 `PER_BROKER` 时，除了所有 `DEFAULT` 级别指标之外，您还将获得下表中描述的指标。您需要为下表中的指标付费，而 `DEFAULT` 级别指标仍免费。此表中的指标具有以下维度：集群名称、代理 ID。

| 在 `PER_BROKER` 监控级别开始提供的其他指标 |                            |                                                              |
| :----------------------------------------- | :------------------------- | :----------------------------------------------------------- |
| 名称                                       | 当可见时                   | 描述                                                         |
| `BwInAllowanceExceeded`                    | 在集群进入 ACTIVE 状态后。 | 由于入站聚合带宽超过了代理的最大带宽而形成的数据包数量。     |
| `BwOutAllowanceExceeded`                   | 在集群进入 ACTIVE 状态后。 | 由于出站聚合带宽超过了代理的最大带宽而形成的数据包数量。     |
| `ConnTrackAllowanceExceeded`               | 在集群进入 ACTIVE 状态后。 | 由于连接跟踪超过了代理的最大值而形成的数据包数量。连接跟踪与安全组有关，安全组会跟踪建立的每个连接，以确保返回的数据包按预期传送。 |
| `ConnectionCloseRate`                      | 在集群进入 ACTIVE 状态后。 | 每个侦听器每秒关闭的连接数。此数字是按每个侦听器汇总的，然后针对客户端侦听器进行筛选。 |
| `ConnectionCreationRate`                   | 在集群进入 ACTIVE 状态后。 | 每个侦听器每秒建立的新连接数。此数字是按每个侦听器汇总的，然后针对客户端侦听器进行筛选。 |
| `CpuCreditUsage`                           | 在集群进入 ACTIVE 状态后。 | 此指标可以帮助您监控实例上的 CPU 积分使用情况。如果您的 CPU 使用率持续超过 20% 的基准水平，则可能会耗尽 CPU 积分余额，这可能会对集群性能产生负面影响。您可以监控该指标并发出警报，以采取纠正措施。 |
| `FetchConsumerLocalTimeMsMean`             | 在提供创建器/使用器后。    | 在领导处处理使用器请求所花费的平均时间（以毫秒为单位）。     |
| `FetchConsumerRequestQueueTimeMsMean`      | 在提供创建器/使用器后。    | 使用器请求在请求队列中等待的平均时间（以毫秒为单位）。       |
| `FetchConsumerResponseQueueTimeMsMean`     | 在提供创建器/使用器后。    | 使用器请求在响应队列中等待的平均时间（以毫秒为单位）。       |
| `FetchConsumerResponseSendTimeMsMean`      | 在提供创建器/使用器后。    | 使用器发送响应所花费的平均时间（以毫秒为单位）。             |
| `FetchConsumerTotalTimeMsMean`             | 在提供创建器/使用器后。    | 使用器从代理提取数据所花费的总平均时间（以毫秒为单位）。     |
| `FetchFollowerLocalTimeMsMean`             | 在提供创建器/使用器后。    | 在领导处处理跟踪器请求所花费的平均时间（以毫秒为单位）。     |
| `FetchFollowerRequestQueueTimeMsMean`      | 在提供创建器/使用器后。    | 跟踪器请求在请求队列中等待的平均时间（以毫秒为单位）。       |
| `FetchFollowerResponseQueueTimeMsMean`     | 在提供创建器/使用器后。    | 跟踪器请求在响应队列中等待的平均时间（以毫秒为单位）。       |
| `FetchFollowerResponseSendTimeMsMean`      | 在提供创建器/使用器后。    | 跟踪器发送响应所花费的平均时间（以毫秒为单位）。             |
| `FetchFollowerTotalTimeMsMean`             | 在提供创建器/使用器后。    | 跟踪器从代理提取数据所花费的总平均时间（以毫秒为单位）。     |
| `FetchMessageConversionsPerSec`            | 在创建主题后。             | 代理每秒提取消息转换的次数。                                 |
| `FetchThrottleByteRate`                    | 在应用带宽限制后。         | 每秒的限制字节数。                                           |
| `FetchThrottleQueueSize`                   | 在应用带宽限制后。         | 限制队列中的消息数。                                         |
| `FetchThrottleTime`                        | 在应用带宽限制后。         | 平均提取限制时间（以毫秒为单位）。                           |
| `NetworkProcessorAvgIdlePercent`           | 在集群进入 ACTIVE 状态后。 | 网络处理器处于空闲状态的时间的平均百分比。                   |
| `PpsAllowanceExceeded`                     | 在集群进入 ACTIVE 状态后。 | 由于双向 PPS 超过了代理的最大值而形成的数据包数量。          |
| `ProduceLocalTimeMsMean`                   | 在集群进入 ACTIVE 状态后。 | 领导者处理请求的平均时间（以毫秒为单位）。                   |
| `ProduceMessageConversionsPerSec`          | 在创建主题后。             | 代理每秒生成的消息转换数。                                   |
| `ProduceMessageConversionsTimeMsMean`      | 在集群进入 ACTIVE 状态后。 | 消息格式转换所花费的平均时间（以毫秒为单位）。               |
| `ProduceRequestQueueTimeMsMean`            | 在集群进入 ACTIVE 状态后。 | 请求消息在队列中所花费的平均时间（以毫秒为单位）。           |
| `ProduceResponseQueueTimeMsMean`           | 在集群进入 ACTIVE 状态后。 | 响应消息在队列中所花费的平均时间（以毫秒为单位）。           |
| `ProduceResponseSendTimeMsMean`            | 在集群进入 ACTIVE 状态后。 | 发送响应消息所花费的平均时间（以毫秒为单位）。               |
| `ProduceThrottleByteRate`                  | 在应用带宽限制后。         | 每秒的限制字节数。                                           |
| `ProduceThrottleQueueSize`                 | 在应用带宽限制后。         | 限制队列中的消息数。                                         |
| `ProduceThrottleTime`                      | 在应用带宽限制后。         | 平均生成限制时间（以毫秒为单位）。                           |
| `ProduceTotalTimeMsMean`                   | 在集群进入 ACTIVE 状态后。 | 平均生成时间（以毫秒为单位）。                               |
| `RemoteBytesInPerSec`                      | 在有生产者/消费者之后。    | 响应消费者提取而从分层存储传输的总字节数。该指标包括所有影响下游数据传输流量的主题分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteBytesOutPerSec                       | 在有生产者/消费者之后。    | 传输到分层存储的总字节数，包括来自日志段、索引和其他辅助文件的数据。该指标包括所有影响上游数据传输流量的主题分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteLogManagerTasksAvgIdlePercent        | 在集群进入 ACTIVE 状态后。 | 远程日志管理器闲置时间的平均百分比。远程日志管理器将数据从代理传输到分层存储。类别：内部活动。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteLogReaderAvgIdlePercent              | 在集群进入 ACTIVE 状态后。 | 远程日志读取器闲置时间的平均百分比。远程日志读取器将数据从远程存储传输到代理，以响应消费者提取。类别：内部活动。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteLogReaderTaskQueueSize               | 在集群进入 ACTIVE 状态后。 | 负责从分层存储读取并等待安排的任务数量。类别：内部活动。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteReadErrorPerSec                      | 在集群进入 ACTIVE 状态后。 | 响应指定代理发送到分层存储以检索数据以响应消费者提取的读取请求的总错误率。该指标包括所有影响下游数据传输流量的主题分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteReadRequestsPerSec                   | 在集群进入 ACTIVE 状态后。 | 指定代理发送到分层存储以检索数据以响应消费者提取的读取请求总数。该指标包括所有影响下游数据传输流量的主题分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteWriteErrorPerSec                     | 在集群进入 ACTIVE 状态后。 | 响应指定代理发送到分层存储以向上游传输数据的写入请求的总错误率。该指标包括所有影响上游数据传输流量的主题分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| `ReplicationBytesInPerSec`                 | 在创建主题后。             | 每秒从其他代理接收的字节数。                                 |
| `ReplicationBytesOutPerSec`                | 在创建主题后。             | 每秒发送给其他代理的字节数。                                 |
| `RequestExemptFromThrottleTime`            | 在应用请求限制后。         | 代理网络和 I/O 线程处理免受限制的请求所花费的平均时间（以毫秒为单位）。 |
| `RequestHandlerAvgIdlePercent`             | 在集群进入 ACTIVE 状态后。 | 请求处理程序线程处于空闲状态的时间的平均百分比。             |
| `RequestThrottleQueueSize`                 | 在应用请求限制后。         | 限制队列中的消息数。                                         |
| `RequestThrottleTime`                      | 在应用请求限制后。         | 平均请求限制时间（以毫秒为单位）。                           |
| `TcpConnections`                           | 在集群进入 ACTIVE 状态后。 | 显示设置了 SYN 标志的传入和传出 TCP 分段的数量。             |
| TotalTierBytesLag                          | 在创建主题后。             | 符合在代理上进行分层但尚未传输到分层存储的数据的总字节数。这些指标显示了上游数据传输的效率。随着延迟的增加，分层存储中不存在的数据量也会增加。类别：存档延迟。这不是 KIP-405 的指标。 |
| `TrafficBytes`                             | 在集群进入 ACTIVE 状态后。 | 以总字节为单位显示客户端（生产者和消费者）与经纪人之间的网络流量。未报告经纪人之间的流量。 |
| `VolumeQueueLength`                        | 在集群进入 ACTIVE 状态后。 | 在指定时间段内等待完成的读取和写入操作请求的数量。           |
| `VolumeReadBytes`                          | 在集群进入 ACTIVE 状态后。 | 在指定时间段内读取的字节数。                                 |
| `VolumeReadOps`                            | 在集群进入 ACTIVE 状态后。 | 指定时间段内的读取操作数。                                   |
| `VolumeTotalReadTime`                      | 在集群进入 ACTIVE 状态后。 | 在指定时间段内完成的所有读取操作所花费的总秒数。             |
| `VolumeTotalWriteTime`                     | 在集群进入 ACTIVE 状态后。 | 在指定时间段内完成的所有写入操作所花费的总秒数。             |
| `VolumeWriteBytes`                         | 在集群进入 ACTIVE 状态后。 | 在指定时间段内写入的字节数。                                 |
| `VolumeWriteOps`                           | 在集群进入 ACTIVE 状态后。 | 指定时间段内的写入操作数。                                   |

### `PER_TOPIC_PER_BROKER`液位监控

在将监控级别设置为 `PER_TOPIC_PER_BROKER` 时，除了 `PER_BROKER` 和 DEFAULT 级别的所有指标之外，您还将获得下表中描述的指标。仅 `DEFAULT` 级别指标是免费的。此表中的指标具有以下维度：集群名称、代理商 ID、主题。

重要: 对于使用 Apache Kafka 2.4.1 或更新版本的 Amazon MSK 集群，下表中的指标仅在其值首次变为非零后才会出现。例如，要查看 `BytesInPerSec`，一个或多个创建器必须先向集群发送数据。

| 在 `PER_TOPIC_PER_BROKER` 监控级别开始提供的其他指标 |                                           |                                                              |
| :--------------------------------------------------- | :---------------------------------------- | :----------------------------------------------------------- |
| 名称                                                 | 当可见时                                  | 描述                                                         |
| `FetchMessageConversionsPerSec`                      | 在创建主题后。                            | 每秒转换的已提取消息的数量。                                 |
| `MessagesInPerSec`                                   | 在创建主题后。                            | 每秒接收的消息的数量。                                       |
| `ProduceMessageConversionsPerSec`                    | 在创建主题后。                            | 已生成消息的每秒转换次数。                                   |
| RemoteBytesInPerSec                                  | 在您创建主题并且该主题正在产生/消耗之后。 | 响应消费者对指定主题和代理的提取而从分层存储传输的字节数。该指标包括该主题中所有影响指定代理上下游数据传输流量的分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteBytesOutPerSec                                 | 在您创建主题并且该主题正在产生/消耗之后。 | 为指定主题和代理传输到分层存储的字节数。该指标包括该主题中所有影响指定代理上游数据传输流量的分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteReadErrorPerSec                                | 在您创建主题并且该主题正在产生/消耗之后。 | 响应指定代理发送到分层存储以检索数据的读取请求的错误率，以响应消费者对指定主题的提取。该指标包括该主题中所有影响指定代理上下游数据传输流量的分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteReadRequestsPerSec                             | 在您创建主题并且该主题正在产生/消耗之后。 | 指定代理发送到分层存储以检索数据的读取请求的数量，以响应消费者对指定主题的提取。该指标包括该主题中所有影响指定代理上下游数据传输流量的分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |
| RemoteWriteErrorPerSec                               | 在您创建主题并且该主题正在产生/消耗之后。 | 响应指定代理发送到分层存储以向上游传输数据的写入请求的错误率。该指标包括该主题中所有影响指定代理上游数据传输流量的分区。类别：流量和错误率。这是一个 [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} 指标。 |

### `PER_TOPIC_PER_PARTITION`液位监控

将监控级别设置为时，除了来自`PER_TOPIC_PER_PARTITION`、和 DEFAULT 级别的所有指标外，您还将获得下表中描述的指标。`PER_TOPIC_PER_BROKER` `PER_BROKER`仅 `DEFAULT` 级别指标是免费的。此表中的指标具有以下维度：消费者组、主题、分区。

| 在 `PER_TOPIC_PER_PARTITION` 监控级别开始提供的其他指标 |                      |                                            |
| :------------------------------------------------------ | :------------------- | :----------------------------------------- |
| 名称                                                    | 当可见时             | 描述                                       |
| `EstimatedTimeLag`                                      | 消费群体消费主题后。 | 耗尽分区偏移延迟的估计时间（以秒为单位）。 |
| `OffsetLag`                                             | 消费群体消费主题后。 | 分区级使用者在偏移量方面滞后。             |

## 对象 {#object}

AWS MSK对象数据暂无
