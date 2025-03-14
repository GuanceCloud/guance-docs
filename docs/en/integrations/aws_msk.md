---
title: 'AWS MSK'
tags: 
  - AWS
summary: 'Use script packages from the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_msk'
dashboard:

  - desc: 'Built-in views for AWS MSK'
    path: 'dashboard/en/aws_msk'

monitor:
  - desc: 'AWS MSK monitors'
    path: 'monitor/en/aws_msk'

---

<!-- markdownlint-disable MD025 -->
# AWS MSK
<!-- markdownlint-enable -->

Amazon Managed Streaming for Apache Kafka (Amazon MSK) is a fully managed service that allows you to build and run applications that process streaming data using Apache Kafka.

Use script packages from the Script Market series of "Guance Cloud Sync" to synchronize cloud monitoring and cloud asset data to Guance.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permissions `ReadOnlyAccess`)

To synchronize MSK monitoring data, install the corresponding collection script: "Guance Integration (AWS-Managed Streaming for Kafka Collection)" (ID: `guance_aws_kafka`)

After clicking [Install], enter the required parameters: Amazon AK, Amazon account name.

Click [Deploy Startup Script], and the system will automatically create a `Startup` script set and configure the corresponding startup scripts.

Additionally, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click [Execute] to immediately execute it once without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


By default, we collect some configurations. For details, see [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configurations. You can also check the task records and logs to ensure there are no anomalies.
2. On the Guance platform, under "Infrastructure / Custom", check if asset information exists.
3. On the Guance platform, under "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon CloudWatch, the default metric set is as follows. More metrics can be collected through configuration [Amazon CloudWatch Metrics Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#IOcredit){:target="_blank"}

### `DEFAULT` Level Monitoring

The metrics described in the table below are available at the `DEFAULT` monitoring level. These metrics are free.

| Metrics Available at `DEFAULT` Monitoring Level                             |                            |                                   |                                                              |
| :------------------------------------------------------- | :------------------------- | :-------------------------------- | :----------------------------------------------------------- |
| Name                                                     | When Visible               | Dimensions                        | Description                                                         |
| `ActiveControllerCount`                                  | After the cluster enters the ACTIVE state. | Cluster Name                          | At any given time, each cluster can only have one controller active.       |
| `BurstBalance`                                           | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Remaining balance of input/output burst credits for EBS volumes in the cluster. Use it to investigate latency or throughput reduction. `BurstBalance` is not reported for EBS volumes when the baseline performance exceeds maximum burst performance. For more information, see [I/O Credits and Burst Performance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#IOcredit){:target="_blank"} |
| `BytesInPerSec`                                          | After creating topics.             | Cluster Name, Broker ID, Topic           | Number of bytes received per second from clients. This metric applies to each broker and each topic. |
| `BytesOutPerSec`                                         | After creating topics.             | Cluster Name, Broker ID, Topic           | Number of bytes sent per second to clients. This metric applies to each broker and each topic. |
| `ClientConnectionCount`                                  | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID, Client Authentication | Number of authenticated active client connections.                         |
| `ConnectionCount`                                        | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of authenticated active connections, unauthenticated connections, and broker-to-broker connections. |
| `CPUCreditBalance`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | This metric helps monitor the CPU credit balance of brokers. If your CPU usage consistently exceeds 20% of the baseline utilization, you may deplete the CPU credit balance, which can negatively impact cluster performance. You can take actions to reduce CPU load. For example, you can reduce the number of client requests or update the broker type to M5. |
| `CpuIdle`                                                | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of CPU idle time.                                         |
| `CpuIoWait`                                              | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of CPU idle time during pending disk operations.                    |
| `CpuSystem`                                              | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of CPU in kernel space.                                    |
| `CpuUser`                                                | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of CPU in user space.                                    |
| `GlobalPartitionCount`                                   | After the cluster enters the ACTIVE state. | Cluster Name                          | Number of partitions across all topics in the cluster (excluding replicas). Since `GlobalPartitionCount` does not include replicas, the sum of `PartitionCount` values may exceed the `GlobalPartitionCount` value when the replication factor of topics is greater than 1. |
| `GlobalTopicCount`                                       | After the cluster enters the ACTIVE state. | Cluster Name                          | Total number of topics across all brokers in the cluster.                                   |
| `EstimatedMaxTimeLag`                                    | After consumer group consumes topics.       | Consumer Group, Topic                  | Estimated time (in seconds) to exhaust `MaxOffsetLag`.                 |
| `KafkaAppLogsDiskUsed`                                   | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of disk space used for application logs.                         |
| `KafkaDataLogsDiskUsed`（`Cluster Name, Broker ID` dimensions） | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of disk space used for data logs.                             |
| `KafkaDataLogsDiskUsed`（`Cluster Name` dimensions）            | After the cluster enters the ACTIVE state. | Cluster Name                          | Percentage of disk space used for data logs.                             |
| `LeaderCount`                                            | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Total number of partition leaders for each broker, excluding replicas.                       |
| `MaxOffsetLag`                                           | After consumer group consumes topics.       | Consumer Group, Topic                  | Maximum offset lag across all partitions in the topic.                               |
| `MemoryBuffered`                                         | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Size of buffered memory for the broker (in bytes).                         |
| `MemoryCached`                                           | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Size of cached memory for the broker (in bytes).                         |
| `MemoryFree`                                             | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Size of available memory for the broker (in bytes).                 |
| `HeapMemoryAfterGC`                                      | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of heap memory used after garbage collection relative to total heap memory.                   |
| `MemoryUsed`                                             | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Size of memory used by the broker (in bytes).                     |
| `MessagesInPerSec`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of incoming messages per second for the broker.                                         |
| `NetworkRxDropped`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of dropped receive packets.                                         |
| `NetworkRxErrors`                                        | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of network receive errors for the broker.                                       |
| `NetworkRxPackets`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of packets received by the broker.                                     |
| `NetworkTxDropped`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of dropped transmit packets.                                         |
| `NetworkTxErrors`                                        | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of network transmit errors for the broker.                                   |
| `NetworkTxPackets`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of packets transmitted by the broker.                                     |
| `OfflinePartitionsCount`                                 | After the cluster enters the ACTIVE state. | Cluster Name                          | Total number of partitions in the cluster that are offline.                             |
| `PartitionCount`                                         | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Total number of topic partitions for each broker, including replicas.                           |
| `ProduceTotalTimeMsMean`                                 | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Average production time (in milliseconds).                               |
| `RequestBytesMean`                                       | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Average number of request bytes for the broker.                                   |
| `RequestTime`                                            | After applying request limits.         | Cluster Name, Broker ID                 | Average time spent processing requests by the broker's network and I/O threads (in milliseconds). |
| `RootDiskUsed`                                           | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Percentage of root disk used by the broker.                                 |
| `SumOffsetLag`                                           | After consumer group consumes topics.       | Consumer Group, Topic                  | Aggregated offset lag across all partitions in the topic.                               |
| `SwapFree`                                               | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Size of swap memory available to the broker (in bytes).                 |
| `SwapUsed`                                               | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Size of swap memory used by the broker (in bytes).               |
| `TrafficShaping`                                         | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Advanced metric indicating the number of packets formed (dropped or queued) due to exceeding network allocation. PER_BROKER metrics provide more detailed information. |
| `UnderMinIsrPartitionCount`                              | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of partitions not fully managed by the broker.                                 |
| `UnderReplicatedPartitions`                              | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Number of partitions not fully replicated by the broker.                                 |
| `ZooKeeperRequestLatencyMsMean`                          | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Average delay (in milliseconds) of Apache ZooKeeper requests from the broker. |
| `ZooKeeperSessionState`                                  | After the cluster enters the ACTIVE state. | Cluster Name, Broker ID                 | Connection state of the broker's ZooKeeper session, which could be one of the following states: NOT_CONNECTED: '0.0', CONNECTING: '0.5', CONNECTEDREADONLY: '0.8', CONNECTED: '1.0', CLOSED: '5.0', AUTH_FAILED: '10.0'. |

### `PER_BROKER` Level Monitoring

When setting the monitoring level to `PER_BROKER`, in addition to all `DEFAULT` level metrics, you will also receive the metrics described in the table below. You need to pay for the metrics in this table, while `DEFAULT` level metrics remain free. Metrics in this table have the following dimensions: Cluster Name, Broker ID.

| Additional Metrics Provided Starting at `PER_BROKER` Monitoring Level |                            |                                                              |
| :----------------------------------------- | :------------------------- | :----------------------------------------------------------- |
| Name                                       | When Visible                   | Description                                                         |
| `BwInAllowanceExceeded`                    | After the cluster enters the ACTIVE state. | Number of packets formed due to inbound aggregated bandwidth exceeding the broker's maximum bandwidth.     |
| `BwOutAllowanceExceeded`                   | After the cluster enters the ACTIVE state. | Number of packets formed due to outbound aggregated bandwidth exceeding the broker's maximum bandwidth.     |
| `ConnTrackAllowanceExceeded`               | After the cluster enters the ACTIVE state. | Number of packets formed due to connection tracking exceeding the broker's maximum. Connection tracking is related to security groups, which track each established connection to ensure return packets are delivered as expected. |
| `ConnectionCloseRate`                      | After the cluster enters the ACTIVE state. | Number of connections closed per second for each listener. This number is aggregated for each listener and then filtered for client listeners. |
| `ConnectionCreationRate`                   | After the cluster enters the ACTIVE state. | Number of new connections established per second for each listener. This number is aggregated for each listener and then filtered for client listeners. |
| `CpuCreditUsage`                           | After the cluster enters the ACTIVE state. | This metric helps monitor CPU credit usage on the instance. If your CPU usage consistently exceeds 20% of the baseline level, you may deplete the CPU credit balance, which can negatively impact cluster performance. You can monitor this metric and issue alerts to take corrective actions. |
| `FetchConsumerLocalTimeMsMean`             | After providing creator/consumer.    | Average time (in milliseconds) spent processing consumer requests at the leader.     |
| `FetchConsumerRequestQueueTimeMsMean`      | After providing creator/consumer.    | Average time (in milliseconds) consumer requests spend in the request queue.       |
| `FetchConsumerResponseQueueTimeMsMean`     | After providing creator/consumer.    | Average time (in milliseconds) consumer requests spend in the response queue.       |
| `FetchConsumerResponseSendTimeMsMean`      | After providing creator/consumer.    | Average time (in milliseconds) spent sending consumer responses.             |
| `FetchConsumerTotalTimeMsMean`             | After providing creator/consumer.    | Total average time (in milliseconds) spent extracting data from the broker by the consumer.     |
| `FetchFollowerLocalTimeMsMean`             | After providing creator/consumer.    | Average time (in milliseconds) spent processing follower requests at the leader.     |
| `FetchFollowerRequestQueueTimeMsMean`      | After providing creator/consumer.    | Average time (in milliseconds) follower requests spend in the request queue.       |
| `FetchFollowerResponseQueueTimeMsMean`     | After providing creator/consumer.    | Average time (in milliseconds) follower requests spend in the response queue.       |
| `FetchFollowerResponseSendTimeMsMean`      | After providing creator/consumer.    | Average time (in milliseconds) spent sending follower responses.             |
| `FetchFollowerTotalTimeMsMean`             | After providing creator/consumer.    | Total average time (in milliseconds) spent extracting data from the broker by the follower.     |
| `FetchMessageConversionsPerSec`            | After creating topics.             | Number of message conversions fetched per second by the broker.                                 |
| `FetchThrottleByteRate`                    | After applying bandwidth limits.         | Restricted byte rate per second.                                           |
| `FetchThrottleQueueSize`                   | After applying bandwidth limits.         | Number of messages in the restriction queue.                                         |
| `FetchThrottleTime`                        | After applying bandwidth limits.         | Average fetch throttling time (in milliseconds).                           |
| `NetworkProcessorAvgIdlePercent`           | After the cluster enters the ACTIVE state. | Average percentage of time the network processor spends idle.                   |
| `PpsAllowanceExceeded`                     | After the cluster enters the ACTIVE state. | Number of packets formed due to bidirectional PPS exceeding the broker's maximum.          |
| `ProduceLocalTimeMsMean`                   | After the cluster enters the ACTIVE state. | Average time (in milliseconds) spent processing requests by the leader.                   |
| `ProduceMessageConversionsPerSec`          | After creating topics.             | Number of message conversions produced per second by the broker.                                   |
| `ProduceMessageConversionsTimeMsMean`      | After the cluster enters the ACTIVE state. | Average time (in milliseconds) spent converting message formats.               |
| `ProduceRequestQueueTimeMsMean`            | After the cluster enters the ACTIVE state. | Average time (in milliseconds) spent by request messages in the queue.           |
| `ProduceResponseQueueTimeMsMean`           | After the cluster enters the ACTIVE state. | Average time (in milliseconds) spent by response messages in the queue.           |
| `ProduceResponseSendTimeMsMean`            | After the cluster enters the ACTIVE state. | Average time (in milliseconds) spent sending response messages.               |
| `ProduceThrottleByteRate`                  | After applying bandwidth limits.         | Restricted byte rate per second.                                           |
| `ProduceThrottleQueueSize`                 | After applying bandwidth limits.         | Number of messages in the restriction queue.                                         |
| `ProduceThrottleTime`                      | After applying bandwidth limits.         | Average produce throttling time (in milliseconds).                           |
| `ProduceTotalTimeMsMean`                   | After the cluster enters the ACTIVE state. | Average production time (in milliseconds).                               |
| `RemoteBytesInPerSec`                      | After producers/consumers exist.    | Total bytes transferred from tiered storage in response to consumer fetches. This metric includes all partitions of topics affecting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteBytesOutPerSec`                     | After producers/consumers exist.    | Total bytes transmitted to tiered storage, including data from log segments, indexes, and other auxiliary files. This metric includes all partitions of topics affecting upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteLogManagerTasksAvgIdlePercent`      | After the cluster enters the ACTIVE state. | Average percentage of time the remote log manager spends idle. The remote log manager transfers data from brokers to tiered storage. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteLogReaderAvgIdlePercent`            | After the cluster enters the ACTIVE state. | Average percentage of time the remote log reader spends idle. The remote log reader transfers data from remote storage to brokers in response to consumer fetches. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteLogReaderTaskQueueSize`             | After the cluster enters the ACTIVE state. | Number of tasks responsible for reading from tiered storage and waiting to be scheduled. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadErrorPerSec`                    | After the cluster enters the ACTIVE state. | Total error rate of read requests sent by specified brokers to tiered storage to retrieve data in response to consumer fetches. This metric includes all partitions of topics affecting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadRequestsPerSec`                 | After the cluster enters the ACTIVE state. | Total number of read requests sent by specified brokers to tiered storage to retrieve data in response to consumer fetches. This metric includes all partitions of topics affecting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteWriteErrorPerSec`                   | After the cluster enters the ACTIVE state. | Total error rate of write requests sent by specified brokers to tiered storage to transfer data upstream. This metric includes all partitions of topics affecting upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `ReplicationBytesInPerSec`                 | After creating topics.             | Number of bytes received per second from other brokers.                                 |
| `ReplicationBytesOutPerSec`                | After creating topics.             | Number of bytes sent per second to other brokers.                                 |
| `RequestExemptFromThrottleTime`            | After applying request limits.         | Average time (in milliseconds) spent processing exempt requests by the broker's network and I/O threads. |
| `RequestHandlerAvgIdlePercent`             | After the cluster enters the ACTIVE state. | Average percentage of time request handler threads spend idle.             |
| `RequestThrottleQueueSize`                 | After applying request limits.         | Number of messages in the restriction queue.                                         |
| `RequestThrottleTime`                      | After applying request limits.         | Average request throttling time (in milliseconds).                           |
| `TcpConnections`                           | After the cluster enters the ACTIVE state. | Number of incoming and outgoing TCP segments with the SYN flag set.             |
| `TotalTierBytesLag`                        | After creating topics.             | Total number of bytes of data eligible for tiering but not yet transmitted to tiered storage on the broker. These metrics show the efficiency of upstream data transfer. As latency increases, the amount of data not present in tiered storage also increases. Category: Archive Lag. This is not a KIP-405 metric. |
| `TrafficBytes`                             | After the cluster enters the ACTIVE state. | Network traffic between clients (producers and consumers) and brokers, measured in total bytes. Traffic between brokers is not reported. |
| `VolumeQueueLength`                        | After the cluster enters the ACTIVE state. | Number of read and write operation requests waiting to complete within a specified time period.           |
| `VolumeReadBytes`                          | After the cluster enters the ACTIVE state. | Number of bytes read within a specified time period.                                 |
| `VolumeReadOps`                            | After the cluster enters the ACTIVE state. | Number of read operations within a specified time period.                                   |
| `VolumeTotalReadTime`                      | After the cluster enters the ACTIVE state. | Total seconds spent completing all read operations within a specified time period.             |
| `VolumeTotalWriteTime`                     | After the cluster enters the ACTIVE state. | Total seconds spent completing all write operations within a specified time period.             |
| `VolumeWriteBytes`                         | After the cluster enters the ACTIVE state. | Number of bytes written within a specified time period.                                 |
| `VolumeWriteOps`                           | After the cluster enters the ACTIVE state. | Number of write operations within a specified time period.                                   |

### `PER_TOPIC_PER_BROKER` Level Monitoring

When setting the monitoring level to `PER_TOPIC_PER_BROKER`, in addition to all `PER_BROKER` and DEFAULT level metrics, you will also receive the metrics described in the table below. Only `DEFAULT` level metrics are free. Metrics in this table have the following dimensions: Cluster Name, Broker ID, Topic.

Important: For Amazon MSK clusters using Apache Kafka 2.4.1 or later versions, the metrics in the table below only appear after their values first become non-zero. For example, to view `BytesInPerSec`, one or more producers must first send data to the cluster.

| Additional Metrics Provided Starting at `PER_TOPIC_PER_BROKER` Monitoring Level |                                           |                                                              |
| :--------------------------------------------------- | :---------------------------------------- | :----------------------------------------------------------- |
| Name                                                 | When Visible                                  | Description                                                         |
| `FetchMessageConversionsPerSec`                      | After creating topics.                            | Number of fetched messages converted per second.                                 |
| `MessagesInPerSec`                                   | After creating topics.                            | Number of messages received per second.                                       |
| `ProduceMessageConversionsPerSec`                    | After creating topics.                            | Number of message conversions produced per second.                                   |
| `RemoteBytesInPerSec`                                | After creating topics and they start producing/consuming. | Number of bytes transferred from tiered storage in response to consumer fetches for specified topics and brokers. This metric includes all partitions of the topic affecting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteBytesOutPerSec`                               | After creating topics and they start producing/consuming. | Number of bytes transmitted to tiered storage for specified topics and brokers. This metric includes all partitions of the topic affecting the specified broker's upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadErrorPerSec`                              | After creating topics and they start producing/consuming. | Error rate of read requests sent by specified brokers to tiered storage to retrieve data in response to consumer fetches for specified topics. This metric includes all partitions of the topic affecting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadRequestsPerSec`                           | After creating topics and they start producing/consuming. | Number of read requests sent by specified brokers to tiered storage to retrieve data in response to consumer fetches for specified topics. This metric includes all partitions of the topic affecting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteWriteErrorPerSec`                             | After creating topics and they start producing/consuming. | Error rate of write requests sent by specified brokers to tiered storage to transfer data upstream for specified topics. This metric includes all partitions of the topic affecting the specified broker's upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |

### `PER_TOPIC_PER_PARTITION` Level Monitoring

When setting the monitoring level to `PER_TOPIC_PER_PARTITION`, in addition to all metrics from `PER_TOPIC_PER_BROKER`, `PER_BROKER`, and DEFAULT levels, you will also receive the metrics described in the table below. Only `DEFAULT` level metrics are free. Metrics in this table have the following dimensions: Consumer Group, Topic, Partition.

| Additional Metrics Provided Starting at `PER_TOPIC_PER_PARTITION` Monitoring Level |                      |                                            |
| :------------------------------------------------------ | :------------------- | :----------------------------------------- |
| Name                                                    | When Visible             | Description                                       |
| `EstimatedTimeLag`                                      | After consumer group consumes topics. | Estimated time (in seconds) to exhaust partition offset lag. |
| `OffsetLag`                                             | After consumer group consumes topics. | Lag in offsets at the partition level for the consumer. |

## Objects {#object}

There is currently no object data for AWS MSK.
