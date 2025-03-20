---
title: 'AWS MSK'
tags: 
  - AWS
summary: 'Use the script market series of "<<< custom_key.brand_name >>> Cloud Sync" script packages to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>'
__int_icon: 'icon/aws_msk'
dashboard:

  - desc: 'AWS MSK built-in view'
    path: 'dashboard/en/aws_msk'

monitor:
  - desc: 'AWS MSK monitor'
    path: 'monitor/en/aws_msk'

---


<!-- markdownlint-disable MD025 -->
# AWS MSK
<!-- markdownlint-enable -->

Amazon Managed Streaming for Apache Kafka (Amazon MSK) is a fully managed service that allows you to build and run applications that process streaming data using Apache Kafka.

Use the script market series of "<<< custom_key.brand_name >>> Cloud Sync" script packages to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - hosted Func: all prerequisites will be automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### Install Script

> Note: Please prepare an Amazon AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`)

To synchronize MSK monitoring data, install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (AWS-Managed Streaming for Kafka Collection)" (ID: `guance_aws_kafka`)

After clicking 【Install】, enter the corresponding parameters: Amazon AK, Amazon account name.

Click 【Deploy Start Script】, and the system will automatically create a `Startup` script set, and automatically configure the corresponding start script.

In addition, you can see the corresponding automatic trigger configuration in the "Management / Automatic Trigger Configuration". Click 【Execute】 to immediately execute once without waiting for the regular time. After a while, you can check the execution task records and corresponding logs.



We default to collecting some configurations, for more details see the metrics section [Customize Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and at the same time, you can check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom", check if there is any asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration [Amazon Cloud Monitoring Metric Details](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#IOcredit){:target="_blank"}

### `DEFAULT` Level Monitoring

The metrics described in the table below are available at the `DEFAULT` monitoring level. These metrics are free.

| Metrics available at the `DEFAULT` monitoring level                            |                          |                                   |                                                              |
| :--------------------------------------------------------------------------- | :----------------------- | :-------------------------------- | :----------------------------------------------------------- |
| Name                                                                         | When visible            | Dimensions                        | Description                                                  |
| `ActiveControllerCount`                                                       | After the cluster enters the ACTIVE state. | Cluster name                      | There can only be one controller active per cluster at any given time. |
| `BurstBalance`                                                                | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Remaining balance of input/output burst credits for EBS volumes in the cluster. Use it to investigate latency or reduced throughput. `BurstBalance` is not reported for EBS volumes when the baseline performance exceeds the maximum burst performance. For more information, see [I/O Credits and Burst Performance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html#IOcredit){:target="_blank"} |
| `BytesInPerSec`                                                               | After creating topics.  | Cluster name, broker ID, topic     | Number of bytes received per second from clients. This metric applies to each broker and also to each topic. |
| `BytesOutPerSec`                                                              | After creating topics.  | Cluster name, broker ID, topic     | Number of bytes sent per second to clients. This metric applies to each broker and also to each topic. |
| `ClientConnectionCount`                                                        | After the cluster enters the ACTIVE state. | Cluster name, broker ID, client authentication | Number of authenticated active client connections.             |
| `ConnectionCount`                                                              | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of authenticated active connections, unauthenticated connections, and inter-broker connections. |
| `CPUCreditBalance`                                                            | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | This metric can help you monitor the CPU credit balance of brokers. If your CPU usage consistently exceeds 20% of the baseline utilization, you may deplete the CPU credit balance, which could negatively impact cluster performance. You can take steps to reduce the CPU load. For example, you can reduce the number of client requests or update the broker type to M5 broker type. |
| `CpuIdle`                                                                     | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of CPU idle time.                                 |
| `CpuIoWait`                                                                   | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of CPU idle time during pending disk operations.  |
| `CpuSystem`                                                                   | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of CPU in kernel space.                           |
| `CpuUser`                                                                     | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of CPU in user space.                             |
| `GlobalPartitionCount`                                                        | After the cluster enters the ACTIVE state. | Cluster name                      | Number of partitions across all topics in the cluster (excluding replicas). Since `GlobalPartitionCount` does not include replicas, the sum of `PartitionCount` values may be higher than GlobalPartitionCount when the replication factor of topics is greater than 1. |
| `GlobalTopicCount`                                                           | After the cluster enters the ACTIVE state. | Cluster name                      | Total number of topics across all brokers in the cluster.   |
| `EstimatedMaxTimeLag`                                                         | After consumer groups consume topics.      | Consumer group, topic              | Estimated time (in seconds) to exhaust `MaxOffsetLag`.       |
| `KafkaAppLogsDiskUsed`                                                       | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of disk space used for application logs.          |
| `KafkaDataLogsDiskUsed` (`Cluster Name, Broker ID` size)                     | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of disk space used for data logs.                |
| `KafkaDataLogsDiskUsed` (`Cluster Name` size)                               | After the cluster enters the ACTIVE state. | Cluster name                      | Percentage of disk space used for data logs.                |
| `LeaderCount`                                                                | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of partition leaders per broker, excluding replicas.  |
| `MaxOffsetLag`                                                               | After consumer groups consume topics.      | Consumer group, topic              | Maximum offset lag across all partitions in the topic.      |
| `MemoryBuffered`                                                             | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Size of buffered memory for the broker (in bytes).          |
| `MemoryCached`                                                               | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Size of cached memory for the broker (in bytes).           |
| `MemoryFree`                                                                 | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Amount of available memory for the broker (in bytes).      |
| `HeapMemoryAfterGC`                                                          | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of heap memory used after garbage collection relative to total heap memory. |
| `MemoryUsed`                                                                 | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Amount of memory being used by the broker (in bytes).     |
| `MessagesInPerSec`                                                           | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of messages ingested per second by the broker.      |
| `NetworkRxDropped`                                                           | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of dropped receive packets.                         |
| `NetworkRxErrors`                                                            | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of network receive errors for the broker.           |
| `NetworkRxPackets`                                                           | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of packets received by the broker.                 |
| `NetworkTxDropped`                                                           | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of dropped transmit packets.                        |
| `NetworkTxErrors`                                                            | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of network transmit errors for the broker.          |
| `NetworkTxPackets`                                                           | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of packets transmitted by the broker.               |
| `OfflinePartitionsCount`                                                     | After the cluster enters the ACTIVE state. | Cluster name                      | Total number of partitions in the cluster that are offline. |
| `PartitionCount`                                                             | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Total number of topic partitions per broker, including replicas. |
| `ProduceTotalTimeMsMean`                                                     | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Average produce time (in milliseconds).                     |
| `RequestBytesMean`                                                           | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Average number of request bytes for the broker.            |
| `RequestTime`                                                                | After applying request throttling.         | Cluster name, broker ID           | Average time spent by broker network and I/O threads processing requests (in milliseconds). |
| `RootDiskUsed`                                                               | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Percentage of root disk used by the broker.                |
| `SumOffsetLag`                                                               | After consumer groups consume topics.      | Consumer group, topic              | Aggregated offset lag across all partitions in the topic.   |
| `SwapFree`                                                                   | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Amount of swap memory available to the broker (in bytes). |
| `SwapUsed`                                                                   | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Amount of swap memory being used by the broker (in bytes). |
| `TrafficShaping`                                                             | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Advanced metric indicating the number of packets formed (dropped or queued) due to exceeding network allocation. PER_BROKER metrics provide more detailed information. |
| `UnderMinIsrPartitionCount`                                                  | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of under-minimum ISR partitions for the broker.     |
| `UnderReplicatedPartitions`                                                  | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Number of under-replicated partitions for the broker.      |
| `ZooKeeperRequestLatencyMsMean`                                              | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Average latency (in milliseconds) of Apache ZooKeeper requests from the broker. |
| `ZooKeeperSessionState`                                                      | After the cluster enters the ACTIVE state. | Cluster name, broker ID           | Connection state of the broker's ZooKeeper session, which may be one of the following states: NOT_CONNECTED: '0.0', Associated: '0.1', Connecting: '0.5', CONNECTEDREADONLY: '0.8', Connected: '1.0', Closed: '5.0', AUTH_FAILED: '10.0'. |

### `PER_BROKER` Level Monitoring

When setting the monitoring level to `PER_BROKER`, in addition to all `DEFAULT` level metrics, you will also obtain the metrics described in the table below. You need to pay for the metrics in this table, while the `DEFAULT` level metrics remain free. The metrics in this table have the following dimensions: Cluster name, broker ID.

| Additional metrics provided starting at the `PER_BROKER` monitoring level |                          |                                                              |
| :---------------------------------------------------------------------- | :----------------------- | :----------------------------------------------------------- |
| Name                                                                    | When visible            | Description                                                  |
| `BwInAllowanceExceeded`                                                 | After the cluster enters the ACTIVE state. | Number of packets formed due to inbound aggregated bandwidth exceeding the broker's maximum bandwidth. |
| `BwOutAllowanceExceeded`                                                | After the cluster enters the ACTIVE state. | Number of packets formed due to outbound aggregated bandwidth exceeding the broker's maximum bandwidth. |
| `ConnTrackAllowanceExceeded`                                            | After the cluster enters the ACTIVE state. | Number of packets formed due to connection tracking exceeding the broker's maximum value. Connection tracking is related to security groups, which track each established connection to ensure that return packets are transmitted as expected. |
| `ConnectionCloseRate`                                                    | After the cluster enters the ACTIVE state. | Number of connections closed per second per listener. This number is aggregated per listener and then filtered for the client listener. |
| `ConnectionCreationRate`                                                 | After the cluster enters the ACTIVE state. | Number of new connections established per second per listener. This number is aggregated per listener and then filtered for the client listener. |
| `CpuCreditUsage`                                                        | After the cluster enters the ACTIVE state. | This metric can help you monitor CPU credit usage on the instance. If your CPU usage consistently exceeds 20% of the baseline level, you may deplete the CPU credit balance, which could negatively impact cluster performance. You can monitor this metric and raise alerts to take corrective actions. |
| `FetchConsumerLocalTimeMsMean`                                          | After providing producer/consumer.        | Average time spent handling consumer requests at the leader (in milliseconds). |
| `FetchConsumerRequestQueueTimeMsMean`                                   | After providing producer/consumer.        | Average time consumer requests spend in the request queue (in milliseconds). |
| `FetchConsumerResponseQueueTimeMsMean`                                  | After providing producer/consumer.        | Average time consumer requests spend in the response queue (in milliseconds). |
| `FetchConsumerResponseSendTimeMsMean`                                   | After providing producer/consumer.        | Average time spent sending consumer responses (in milliseconds). |
| `FetchConsumerTotalTimeMsMean`                                          | After providing producer/consumer.        | Total average time spent by the consumer fetching data from the broker (in milliseconds). |
| `FetchFollowerLocalTimeMsMean`                                         | After providing producer/consumer.        | Average time spent handling follower requests at the leader (in milliseconds). |
| `FetchFollowerRequestQueueTimeMsMean`                                   | After providing producer/consumer.        | Average time follower requests spend in the request queue (in milliseconds). |
| `FetchFollowerResponseQueueTimeMsMean`                                  | After providing producer/consumer.        | Average time follower requests spend in the response queue (in milliseconds). |
| `FetchFollowerResponseSendTimeMsMean`                                   | After providing producer/consumer.        | Average time spent sending follower responses (in milliseconds). |
| `FetchFollowerTotalTimeMsMean`                                          | After providing producer/consumer.        | Total average time spent by the follower fetching data from the broker (in milliseconds). |
| `FetchMessageConversionsPerSec`                                         | After creating topics.                   | Number of message conversions fetched per second by the broker. |
| `FetchThrottleByteRate`                                                 | After applying bandwidth throttling.     | Number of throttled bytes per second.                     |
| `FetchThrottleQueueSize`                                                | After applying bandwidth throttling.     | Number of messages in the throttling queue.               |
| `FetchThrottleTime`                                                     | After applying bandwidth throttling.     | Average fetch throttling time (in milliseconds).           |
| `NetworkProcessorAvgIdlePercent`                                        | After the cluster enters the ACTIVE state. | Average percentage of time the network processor is idle.  |
| `PpsAllowanceExceeded`                                                  | After the cluster enters the ACTIVE state. | Number of packets formed due to bi-directional PPS exceeding the broker's maximum value. |
| `ProduceLocalTimeMsMean`                                                | After the cluster enters the ACTIVE state. | Average time leader spends handling requests (in milliseconds). |
| `ProduceMessageConversionsPerSec`                                       | After creating topics.                   | Number of message conversions produced per second by the broker. |
| `ProduceMessageConversionsTimeMsMean`                                   | After the cluster enters the ACTIVE state. | Average time spent converting message formats (in milliseconds). |
| `ProduceRequestQueueTimeMsMean`                                         | After the cluster enters the ACTIVE state. | Average time request messages spend in the queue (in milliseconds). |
| `ProduceResponseQueueTimeMsMean`                                        | After the cluster enters the ACTIVE state. | Average time response messages spend in the queue (in milliseconds). |
| `ProduceResponseSendTimeMsMean`                                         | After the cluster enters the ACTIVE state. | Average time spent sending response messages (in milliseconds). |
| `ProduceThrottleByteRate`                                               | After applying bandwidth throttling.     | Number of throttled bytes per second.                     |
| `ProduceThrottleQueueSize`                                              | After applying bandwidth throttling.     | Number of messages in the throttling queue.               |
| `ProduceThrottleTime`                                                   | After applying bandwidth throttling.     | Average produce throttling time (in milliseconds).         |
| `ProduceTotalTimeMsMean`                                                | After the cluster enters the ACTIVE state. | Average produce time (in milliseconds).                    |
| `RemoteBytesInPerSec`                                                   | After having producers/consumers.       | Total number of bytes transmitted from tiered storage in response to consumer fetches. This metric includes all topic partitions impacting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteBytesOutPerSec`                                                  | After having producers/consumers.       | Total number of bytes transmitted to tiered storage, including data from log segments, indexes, and other auxiliary files. This metric includes all topic partitions impacting upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteLogManagerTasksAvgIdlePercent`                                   | After the cluster enters the ACTIVE state. | Average percentage of time the remote log manager is idle. The remote log manager transfers data from the broker to tiered storage. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteLogReaderAvgIdlePercent`                                         | After the cluster enters the ACTIVE state. | Average percentage of time the remote log reader is idle. The remote log reader transfers data from remote storage to the broker in response to consumer fetches. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteLogReaderTaskQueueSize`                                          | After the cluster enters the ACTIVE state. | Number of tasks responsible for reading from tiered storage and waiting to be scheduled. Category: Internal Activity. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadErrorPerSec`                                                 | After the cluster enters the ACTIVE state. | Total error rate responding to read requests sent by the broker to tiered storage to retrieve data in response to consumer fetches. This metric includes all topic partitions impacting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadRequestsPerSec`                                              | After the cluster enters the ACTIVE state. | Total number of read requests sent by the broker to tiered storage to retrieve data in response to consumer fetches. This metric includes all topic partitions impacting downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteWriteErrorPerSec`                                                | After the cluster enters the ACTIVE state. | Total error rate responding to write requests sent by the broker to tiered storage to transfer data upstream. This metric includes all topic partitions impacting upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `ReplicationBytesInPerSec`                                               | After creating topics.                   | Number of bytes received per second from other brokers.    |
| `ReplicationBytesOutPerSec`                                              | After creating topics.                   | Number of bytes sent per second to other brokers.         |
| `RequestExemptFromThrottleTime`                                          | After applying request throttling.       | Average time spent by broker network and I/O threads processing requests exempt from throttling (in milliseconds). |
| `RequestHandlerAvgIdlePercent`                                           | After the cluster enters the ACTIVE state. | Average percentage of time request handler threads are idle. |
| `RequestThrottleQueueSize`                                               | After applying request throttling.       | Number of messages in the throttling queue.               |
| `RequestThrottleTime`                                                    | After applying request throttling.       | Average request throttling time (in milliseconds).         |
| `TcpConnections`                                                         | After the cluster enters the ACTIVE state. | Number of incoming and outgoing TCP segments with the SYN flag set. |
| `TotalTierBytesLag`                                                      | After creating topics.                   | Total number of bytes of data eligible for tiering on the broker but not yet transferred to tiered storage. These metrics indicate the efficiency of upstream data transfer. As the delay increases, the amount of data not present in tiered storage also increases. Category: Archive Delay. This is not a KIP-405 metric. |
| `TrafficBytes`                                                           | After the cluster enters the ACTIVE state. | Displays network traffic between clients (producers and consumers) and brokers in total bytes. Does not report traffic between brokers. |
| `VolumeQueueLength`                                                      | After the cluster enters the ACTIVE state. | Number of read and write operation requests waiting to complete during the specified time period. |
| `VolumeReadBytes`                                                        | After the cluster enters the ACTIVE state. | Number of bytes read during the specified time period.    |
| `VolumeReadOps`                                                          | After the cluster enters the ACTIVE state. | Number of read operations during the specified time period. |
| `VolumeTotalReadTime`                                                    | After the cluster enters the ACTIVE state. | Total number of seconds spent completing all read operations during the specified time period. |
| `VolumeTotalWriteTime`                                                   | After the cluster enters the ACTIVE state. | Total number of seconds spent completing all write operations during the specified time period. |
| `VolumeWriteBytes`                                                       | After the cluster enters the ACTIVE state. | Number of bytes written during the specified time period. |
| `VolumeWriteOps`                                                         | After the cluster enters the ACTIVE state. | Number of write operations during the specified time period. |

### `PER_TOPIC_PER_BROKER` Level Monitoring

When setting the monitoring level to `PER_TOPIC_PER_BROKER`, in addition to all metrics from `PER_BROKER` and DEFAULT levels, you will also obtain the metrics described in the table below. Only `DEFAULT` level metrics are free. The metrics in this table have the following dimensions: Cluster name, broker ID, topic.

Important: For Amazon MSK clusters using Apache Kafka 2.4.1 or newer versions, the metrics in the table below will only appear after their values first become non-zero. For example, to see `BytesInPerSec`, one or more producers must first send data to the cluster.

| Additional metrics provided starting at the `PER_TOPIC_PER_BROKER` monitoring level |                                             |                                                              |
| :-------------------------------------------------------------------------------- | :------------------------------------------ | :----------------------------------------------------------- |
| Name                                                                               | When visible                                | Description                                                  |
| `FetchMessageConversionsPerSec`                                                    | After creating topics.                      | Number of converted fetched messages per second.             |
| `MessagesInPerSec`                                                                 | After creating topics.                      | Number of messages received per second.                     |
| `ProduceMessageConversionsPerSec`                                                  | After creating topics.                      | Number of produced message conversions per second.           |
| `RemoteBytesInPerSec`                                                              | After creating topics and they are producing/consuming. | Number of bytes transmitted from tiered storage in response to consumer fetches for the specified topic and broker. This metric includes all partitions in the topic impacting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteBytesOutPerSec`                                                             | After creating topics and they are producing/consuming. | Number of bytes transmitted to tiered storage for the specified topic and broker. This metric includes all partitions in the topic impacting the specified broker's upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadErrorPerSec`                                                            | After creating topics and they are producing/consuming. | Error rate responding to read requests sent by the specified broker to tiered storage to retrieve data in response to consumer fetches for the specified topic. This metric includes all partitions in the topic impacting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteReadRequestsPerSec`                                                         | After creating topics and they are producing/consuming. | Number of read requests sent by the specified broker to tiered storage to retrieve data in response to consumer fetches for the specified topic. This metric includes all partitions in the topic impacting the specified broker's upstream and downstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |
| `RemoteWriteErrorPerSec`                                                           | After creating topics and they are producing/consuming. | Error rate responding to write requests sent by the specified broker to tiered storage to transfer data upstream. This metric includes all partitions in the topic impacting the specified broker's upstream data transfer traffic. Category: Traffic and Error Rate. This is a [KIP-405](https://cwiki.apache.org/confluence/display/KAFKA/KIP-405%3A+Kafka+Tiered+Storage){:target="_blank"} metric. |

### `PER_TOPIC_PER_PARTITION` Level Monitoring

When setting the monitoring level to `PER_TOPIC_PER_PARTITION`, in addition to all metrics from `PER_TOPIC_PER_PARTITION`, `PER_TOPIC_PER_BROKER`, and DEFAULT levels, you will also obtain the metrics described in the table below. Only `DEFAULT` level metrics are free. The metrics in this table have the following dimensions: Consumer group, topic, partition.

| Additional metrics provided starting at the `PER_TOPIC_PER_PARTITION` monitoring level |                  |                                            |
| :------------------------------------------------------------------------------------ | :--------------- | :----------------------------------------- |
| Name                                                                                  | When visible     | Description                               |
| `EstimatedTimeLag`                                                                     | After consumer groups consume topics. | Estimated time (in seconds) to exhaust partition offset lag. |
| `OffsetLag`                                                                            | After consumer groups consume topics. | Lag of partition-level consumer in terms of offsets.         |

## Objects {#object}

No AWS MSK object data available
