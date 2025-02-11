---
title: 'AWS MSK'
tags: 
  - AWS
summary: 'Use the script market "Guance Cloud Sync" series script package to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_msk'
dashboard:

  - desc: 'Built-in view for AWS MSK'
    path: 'dashboard/en/aws_msk'

monitor:
  - desc: 'Monitor for AWS MSK'
    path: 'monitor/en/aws_msk'

---

<!-- markdownlint-disable MD025 -->
# AWS MSK
<!-- markdownlint-enable -->

Amazon Managed Streaming for Apache Kafka (Amazon MSK) is a fully managed service that makes it easy to build and run applications that use Apache Kafka to process streaming data.

Use the "Guance Cloud Sync" series of script packages from the script market to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon AK in advance that meets the requirements (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize MSK monitoring data, install the corresponding collection script: "Guance Integration (AWS-Managed Streaming for Kafka Collection)" (ID: `guance_aws_kafka`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the startup scripts accordingly.

Additionally, you can see the corresponding automatic trigger configuration in "Management / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can check the execution task records and corresponding logs.


We default to collecting some configurations; for more details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have automatic trigger configurations, and check the task records and logs for any anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric sets are as follows. You can collect more metrics by configuration. See [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/zh_cn/msk/latest/developerguide/metrics-details.html){:target="_blank"}

### `DEFAULT` Level Monitoring

The metrics described in the table below are available at the `DEFAULT` monitoring level. These metrics are free.

| Metrics Available at the `DEFAULT` Monitoring Level |                           |                                 |                                                           |
| :-------------------------------------------------- | :------------------------ | :------------------------------ | :-------------------------------------------------------- |
| Name                                                | Visibility                | Dimensions                      | Description                                               |
| `ActiveControllerCount`                             | After the cluster enters ACTIVE state. | Cluster name                    | At any given time, only one controller can be active in each cluster. |
| `BurstBalance`                                      | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Remaining balance of input/output burst credits for EBS volumes in the cluster. Use it to investigate latency or reduced throughput. The `BurstBalance` is not reported for EBS volumes when the baseline performance exceeds the maximum burst performance. For more information, see [I/O Credits and Burst Performance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#IOcredit){:target="_blank"} |
| `BytesInPerSec`                                     | After topic creation.     | Cluster name, broker ID, topic   | Number of bytes received per second from clients. This metric applies to each broker and each topic. |
| `BytesOutPerSec`                                    | After topic creation.     | Cluster name, broker ID, topic   | Number of bytes sent to clients per second. This metric applies to each broker and each topic. |
| `ClientConnectionCount`                             | After the cluster enters ACTIVE state. | Cluster name, broker ID, client authentication | Number of authenticated active client connections. |
| `ConnectionCount`                                   | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of authenticated active connections, unauthenticated connections, and broker-to-broker connections. |
| `CPUCreditBalance`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | This metric helps monitor the CPU credit balance of brokers. If your CPU usage consistently exceeds 20% of the baseline utilization, you may deplete the CPU credit balance, which can negatively impact cluster performance. You can take measures to reduce CPU load, such as reducing the number of client requests or updating the broker type to M5. |
| `CpuIdle`                                           | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of CPU idle time. |
| `CpuIoWait`                                         | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of CPU idle time during pending disk operations. |
| `CpuSystem`                                         | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of CPU in kernel space. |
| `CpuUser`                                           | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of CPU in user space. |
| `GlobalPartitionCount`                              | After the cluster enters ACTIVE state. | Cluster name                    | Number of partitions across all topics in the cluster (excluding replicas). Since `GlobalPartitionCount` does not include replicas, the sum of `PartitionCount` values may be higher than the `GlobalPartitionCount` when the replication factor of topics is greater than 1. |
| `GlobalTopicCount`                                  | After the cluster enters ACTIVE state. | Cluster name                    | Total number of topics across all brokers in the cluster. |
| `EstimatedMaxTimeLag`                               | After consumer group consumes topics. | Consumer group, topic            | Estimated time (in seconds) to consume `MaxOffsetLag`. |
| `KafkaAppLogsDiskUsed`                              | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of disk space used for application logs. |
| `KafkaDataLogsDiskUsed` (`Cluster Name, Broker ID` size) | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of disk space used for data logs. |
| `KafkaDataLogsDiskUsed` (`Cluster Name` size)       | After the cluster enters ACTIVE state. | Cluster name                    | Percentage of disk space used for data logs. |
| `LeaderCount`                                       | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Total number of partition leaders per broker, excluding replicas. |
| `MaxOffsetLag`                                      | After consumer group consumes topics. | Consumer group, topic            | Maximum offset lag across all partitions in the topic. |
| `MemoryBuffered`                                    | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Size of buffered memory in bytes for the broker. |
| `MemoryCached`                                      | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Size of cached memory in bytes for the broker. |
| `MemoryFree`                                        | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Size of available memory in bytes for the broker. |
| `HeapMemoryAfterGC`                                 | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of heap memory used after garbage collection relative to total heap memory. |
| `MemoryUsed`                                        | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Size of memory in use by the broker in bytes. |
| `MessagesInPerSec`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of incoming messages per second for the broker. |
| `NetworkRxDropped`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of dropped receive packets. |
| `NetworkRxErrors`                                   | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of network receive errors for the broker. |
| `NetworkRxPackets`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of packets received by the broker. |
| `NetworkTxDropped`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of dropped transmit packets. |
| `NetworkTxErrors`                                   | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of network transmit errors for the broker. |
| `NetworkTxPackets`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of packets transmitted by the broker. |
| `OfflinePartitionsCount`                            | After the cluster enters ACTIVE state. | Cluster name                    | Total number of offline partitions in the cluster. |
| `PartitionCount`                                    | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Total number of topic partitions per broker, including replicas. |
| `ProduceTotalTimeMsMean`                            | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Average production time in milliseconds. |
| `RequestBytesMean`                                  | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Average number of request bytes for the broker. |
| `RequestTime`                                       | After applying request limits.        | Cluster name, broker ID          | Average time (in milliseconds) spent by the broker's network and I/O threads processing requests. |
| `RootDiskUsed`                                      | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Percentage of root disk used by the broker. |
| `SumOffsetLag`                                      | After consumer group consumes topics. | Consumer group, topic            | Aggregated offset lag across all partitions in the topic. |
| `SwapFree`                                          | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Size of swap memory available to the broker in bytes. |
| `SwapUsed`                                          | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Size of swap memory in use by the broker in bytes. |
| `TrafficShaping`                                    | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Advanced metric indicating the number of packets formed (dropped or queued) due to exceeding network allocation. PER_BROKER metrics provide more detailed information. |
| `UnderMinIsrPartitionCount`                         | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of under-replicated partitions for the broker. |
| `UnderReplicatedPartitions`                         | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Number of under-replicated partitions for the broker. |
| `ZooKeeperRequestLatencyMsMean`                     | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Average delay (in milliseconds) for Apache ZooKeeper requests from the broker. |
| `ZooKeeperSessionState`                             | After the cluster enters ACTIVE state. | Cluster name, broker ID          | Connection state of the broker's ZooKeeper session, which could be one of the following states: NOT_CONNECTED: '0.0', Associated: '0.1', Connecting: '0.5', CONNECTEDREADONLY: '0.8', Connected: '1.0', Closed: '5.0', AUTH_FAILED: '10.0'. |

### `PER_BROKER` Level Monitoring

When setting the monitoring level to `PER_BROKER`, in addition to all `DEFAULT` level metrics, you will also get the metrics described in the table below. You need to pay for the metrics in this table, while `DEFAULT` level metrics remain free. Metrics in this table have the following dimensions: Cluster name, broker ID.

| Additional Metrics Provided Starting at the `PER_BROKER` Monitoring Level |                          |                                                            |
| :------------------------------------------------------------------------- | :----------------------- | :---------------------------------------------------------- |
| Name                                                                       | Visibility               | Description                                                 |
| `BwInAllowanceExceeded`                                                    | After the cluster enters ACTIVE state. | Number of packets formed due to inbound aggregated bandwidth exceeding the broker's maximum bandwidth. |
| `BwOutAllowanceExceeded`                                                   | After the cluster enters ACTIVE state. | Number of packets formed due to outbound aggregated bandwidth exceeding the broker's maximum bandwidth. |
| `ConnTrackAllowanceExceeded`                                               | After the cluster enters ACTIVE state. | Number of packets formed due to connection tracking exceeding the broker's maximum value. Connection tracking is related to security groups, which track each established connection to ensure return packets are delivered as expected. |
| `ConnectionCloseRate`                                                      | After the cluster enters ACTIVE state. | Number of connections closed per second per listener. This number is aggregated per listener and then filtered for client listeners. |
| `ConnectionCreationRate`                                                   | After the cluster enters ACTIVE state. | Number of new connections established per second per listener. This number is aggregated per listener and then filtered for client listeners. |
| `CpuCreditUsage`                                                           | After the cluster enters ACTIVE state. | This metric helps monitor CPU credit usage on the instance. If your CPU usage consistently exceeds 20% of the baseline level, you may deplete the CPU credit balance, which can negatively impact cluster performance. You can monitor this metric and set alerts to take corrective actions. |
| `FetchConsumerLocalTimeMsMean`                                             | After providing creator/consumer.      | Average time (in milliseconds) spent processing consumer requests at the leader. |
| `FetchConsumerRequestQueueTimeMsMean`                                      | After providing creator/consumer.      | Average time (in milliseconds) consumer requests spend in the request queue. |
| `FetchConsumerResponseQueueTimeMsMean`                                     | After providing creator/consumer.      | Average time (in milliseconds) consumer requests spend in the response queue. |
| `FetchConsumerResponseSendTimeMsMean`                                      | After providing creator/consumer.      | Average time (in milliseconds) spent sending consumer responses. |
| `FetchConsumerTotalTimeMsMean`                                             | After providing creator/consumer.      | Total average time (in milliseconds) consumers spend extracting data from the broker. |
| `FetchFollowerLocalTimeMsMean`                                             | After providing creator/consumer.      | Average time (in milliseconds) spent processing follower requests at the leader. |
| `FetchFollowerRequestQueueTimeMsMean`                                      | After providing creator/consumer.      | Average time (in milliseconds) follower requests spend in the request queue. |
| `FetchFollowerResponseQueueTimeMsMean`                                     | After providing creator/consumer.      | Average time (in milliseconds) follower requests spend in the response queue. |
| `FetchFollowerResponseSendTimeMsMean`                                      | After providing creator/consumer.      | Average time (in milliseconds) spent sending follower responses. |
| `FetchFollowerTotalTimeMsMean`                                             | After providing creator/consumer.      | Total average time (in milliseconds) followers spend extracting data from the broker. |
| `FetchMessageConversionsPerSec`                                            | After topic creation.                 | Number of times per second the broker converts fetched messages. |
| `FetchThrottleByteRate`                                                    | After applying bandwidth limits.      | Number of throttled bytes per second. |
| `FetchThrottleQueueSize`                                                   | After applying bandwidth limits.      | Number of messages in the throttling queue. |
| `FetchThrottleTime`                                                        | After applying bandwidth limits.      | Average fetch throttling time (in milliseconds). |
| `NetworkProcessorAvgIdlePercent`                                           | After the cluster enters ACTIVE state. | Average percentage of time the network processor spends idle. |
| `PpsAllowanceExceeded`                                                     | After the cluster enters ACTIVE state. | Number of packets formed due to bidirectional PPS exceeding the broker's maximum value. |
| `ProduceLocalTimeMsMean`                                                   | After the cluster enters ACTIVE state. | Average time (in milliseconds) the leader spends processing requests. |
| `ProduceMessageConversionsPerSec`                                          | After topic creation.                 | Number of message conversions per second generated by the broker. |
| `ProduceMessageConversionsTimeMsMean`                                      | After the cluster enters ACTIVE state. | Average time (in milliseconds) spent converting message formats. |
| `ProduceRequestQueueTimeMsMean`                                            | After the cluster enters ACTIVE state. | Average time (in milliseconds) request messages spend in the queue. |
| `ProduceResponseQueueTimeMsMean`                                           | After the cluster enters ACTIVE state. | Average time (in milliseconds) response messages spend in the queue. |
| `ProduceResponseSendTimeMsMean`                                            | After the cluster enters ACTIVE state. | Average time (in milliseconds) spent sending response messages. |
| `ProduceThrottleByteRate`                                                  | After applying bandwidth limits.      | Number of throttled bytes per second. |
| `ProduceThrottleQueueSize`                                                 | After applying bandwidth limits.      | Number of messages in the throttling queue. |
| `ProduceThrottleTime`                                                      | After applying bandwidth limits.      | Average produce throttling time (in milliseconds). |
| `ProduceTotalTimeMsMean`                                                   | After the cluster enters ACTIVE state. | Average production time (in milliseconds). |
| `RemoteBytesInPerSec`                                                      | After producers/consumers exist.      | Total bytes transferred from tiered storage in response to consumer fetches. This metric includes all topic partitions affecting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteBytesOutPerSec                                                       | After producers/consumers exist.      | Total bytes transferred to tiered storage, including data from log segments, indexes, and other auxiliary files. This metric includes all topic partitions affecting upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteLogManagerTasksAvgIdlePercent                                        | After the cluster enters ACTIVE state. | Average percentage of time the remote log manager spends idle. The remote log manager transfers data from brokers to tiered storage. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteLogReaderAvgIdlePercent                                              | After the cluster enters ACTIVE state. | Average percentage of time the remote log reader spends idle. The remote log reader transfers data from remote storage to brokers in response to consumer fetches. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteLogReaderTaskQueueSize                                               | After the cluster enters ACTIVE state. | Number of tasks responsible for reading from tiered storage and waiting to be scheduled. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteReadErrorPerSec                                                      | After the cluster enters ACTIVE state. | Total error rate of read requests sent by the specified broker to tiered storage to retrieve data in response to consumer fetches. This metric includes all topic partitions affecting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteReadRequestsPerSec                                                   | After the cluster enters ACTIVE state. | Total number of read requests sent by the specified broker to tiered storage to retrieve data in response to consumer fetches. This metric includes all topic partitions affecting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteWriteErrorPerSec                                                     | After the cluster enters ACTIVE state. | Total error rate of write requests sent by the specified broker to tiered storage to send data upstream. This metric includes all topic partitions affecting upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `ReplicationBytesInPerSec`                                                 | After topic creation.                 | Number of bytes received per second from other brokers. |
| `ReplicationBytesOutPerSec`                                                | After topic creation.                 | Number of bytes sent per second to other brokers. |
| `RequestExemptFromThrottleTime`                                            | After applying request limits.        | Average time (in milliseconds) spent by the broker's network and I/O threads processing requests exempt from throttling. |
| `RequestHandlerAvgIdlePercent`                                             | After the cluster enters ACTIVE state. | Average percentage of time request handler threads spend idle. |
| `RequestThrottleQueueSize`                                                 | After applying request limits.        | Number of messages in the throttling queue. |
| `RequestThrottleTime`                                                      | After applying request limits.        | Average request throttling time (in milliseconds). |
| `TcpConnections`                                                           | After the cluster enters ACTIVE state. | Number of incoming and outgoing TCP segments with the SYN flag set. |
| TotalTierBytesLag                                                          | After topic creation.                 | Total bytes of data eligible for tiering but not yet transferred to tiered storage on the broker. These metrics show the efficiency of upstream data transfer. As lag increases, the amount of data not present in tiered storage also increases. Category: Archive Lag. This is not a KIP-405 metric. |
| `TrafficBytes`                                                             | After the cluster enters ACTIVE state. | Network traffic in total bytes between clients (producers and consumers) and brokers. Traffic between brokers is not reported. |
| `VolumeQueueLength`                                                        | After the cluster enters ACTIVE state. | Number of read and write operation requests waiting to complete within a specified period. |
| `VolumeReadBytes`                                                          | After the cluster enters ACTIVE state. | Number of bytes read within a specified period. |
| `VolumeReadOps`                                                            | After the cluster enters ACTIVE state. | Number of read operations within a specified period. |
| `VolumeTotalReadTime`                                                      | After the cluster enters ACTIVE state. | Total seconds spent completing all read operations within a specified period. |
| `VolumeTotalWriteTime`                                                     | After the cluster enters ACTIVE state. | Total seconds spent completing all write operations within a specified period. |
| `VolumeWriteBytes`                                                         | After the cluster enters ACTIVE state. | Number of bytes written within a specified period. |
| `VolumeWriteOps`                                                           | After the cluster enters ACTIVE state. | Number of write operations within a specified period. |

### `PER_TOPIC_PER_BROKER` Level Monitoring

When setting the monitoring level to `PER_TOPIC_PER_BROKER`, in addition to all metrics from `PER_BROKER` and DEFAULT levels, you will also get the metrics described in the table below. Only `DEFAULT` level metrics are free. Metrics in this table have the following dimensions: Cluster name, broker ID, topic.

Important: For Amazon MSK clusters using Apache Kafka 2.4.1 or later versions, the metrics in the table below will only appear after their values first become non-zero. For example, to see `BytesInPerSec`, one or more producers must first send data to the cluster.

| Additional Metrics Provided Starting at the `PER_TOPIC_PER_BROKER` Monitoring Level |                        |                                                            |
| :---------------------------------------------------------------------------------- | :---------------------- | :---------------------------------------------------------- |
| Name                                                                                | Visibility              | Description                                                 |
| `FetchMessageConversionsPerSec`                                                     | After topic creation.   | Number of fetched messages converted per second.            |
| `MessagesInPerSec`                                                                  | After topic creation.   | Number of messages received per second.                     |
| `ProduceMessageConversionsPerSec`                                                   | After topic creation.   | Number of produced message conversions per second.          |
| RemoteBytesInPerSec                                                                 | After topic creation and the topic is producing/consuming. | Number of bytes transferred from tiered storage in response to consumer fetches for the specified topic and broker. This metric includes all partitions in the topic affecting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteBytesOutPerSec                                                                | After topic creation and the topic is producing/consuming. | Number of bytes transferred to tiered storage for the specified topic and broker. This metric includes all partitions in the topic affecting the specified broker's upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteReadErrorPerSec                                                               | After topic creation and the topic is producing/consuming. | Error rate of read requests sent by the specified broker to tiered storage to retrieve data in response to consumer fetches for the specified topic. This metric includes all partitions in the topic affecting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteReadRequestsPerSec                                                            | After topic creation and the topic is producing/consuming. | Number of read requests sent by the specified broker to tiered storage to retrieve data in response to consumer fetches for the specified topic. This metric includes all partitions in the topic affecting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| RemoteWriteErrorPerSec                                                              | After topic creation and the topic is producing/consuming. | Error rate of write requests sent by the specified broker to tiered storage to send data upstream for the specified topic. This metric includes all partitions in the topic affecting the specified broker's upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |

### `PER_TOPIC_PER_PARTITION` Level Monitoring

When setting the monitoring level to `PER_TOPIC_PER_PARTITION`, in addition to all metrics from `PER_TOPIC_PER_BROKER`, `PER_BROKER`, and DEFAULT levels, you will also get the metrics described in the table below. Only `DEFAULT` level metrics are free. Metrics in this table have the following dimensions: Consumer group, topic, partition.

| Additional Metrics Provided Starting at the `PER_TOPIC_PER_PARTITION` Monitoring Level |                   |                                            |
| :------------------------------------------------------------------------------------- | :---------------- | :------------------------------------------ |
| Name                                                                                   | Visibility         | Description                                 |
| `EstimatedTimeLag`                                                                      | After consumer group consumes topics. | Estimated time (in seconds) to consume partition offset lag. |
| `OffsetLag`                                                                             | After consumer group consumes topics. | Partition-level consumer lag in offsets. |

## Objects {#object}

There is no object data for AWS MSK objects.