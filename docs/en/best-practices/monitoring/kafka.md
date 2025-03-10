# Best Practices for Observability with Kafka

---

## Overview 

Kafka is a distributed messaging queue based on the publish-subscribe model, developed by LinkedIn. It is a real-time data processing system that can scale horizontally. Like middleware such as RabbitMQ and RocketMQ, Kafka has several key features:

- Asynchronous processing 
- Service decoupling 
- Traffic shaping 

The following diagram illustrates an example of asynchronous processing.

![image.png](../images/kafka-1.png)

## Architecture

As shown in the diagram below, a Kafka architecture includes multiple Producers, Consumers, Brokers, and a Zookeeper cluster.

![image.png](../images/kafka-2.png)

- **Zookeeper**: Manages cluster configurations for the Kafka cluster. It elects Leaders and handles rebalancing when Consumer Groups change.
- **Broker**: Message handling nodes; each node is a Broker, and a Kafka cluster consists of one or more Brokers. A message can be distributed across multiple Brokers.
- **Producer**: Responsible for publishing messages to Brokers.
- **Consumer**: Reads messages from Brokers.
- **Consumer Group**: Each Consumer belongs to a specific Consumer Group, which can be named. If no name is specified, it defaults to a default group. A message can be sent to multiple Groups, but within a Group, only one Consumer can consume the message.

Kafka categorizes messages, and every message sent to the cluster must specify a Topic. A Topic represents a class of messages, logically considered as a Queue. Each message produced by a Producer must specify a Topic, and Consumers will pull messages from the corresponding Broker based on the subscribed Topic. Each Topic contains one or more Partitions, and each Partition corresponds to a folder storing the Partition's data and index files. Messages within each Partition are ordered. A Topic can be divided into one or more Partitions, with multiple replicas of each Partition distributed across different Brokers. Replicas have a leader-follower relationship: the Leader provides services externally (interacting with client programs), while Followers passively synchronize with the Leader and do not interact with external clients. The multi-replica mechanism enables automatic failover, ensuring service availability even if a Broker fails, thereby enhancing disaster recovery capabilities.

As shown in the figure below, the Kafka cluster has 4 Brokers, and a certain Topic has three partitions. Assuming the replication factor is set to 3, each partition will have one Leader and two Follower replicas.

![image.png](../images/kafka-3.png)

Partition replicas reside on different Brokers, and Producers and Consumers only interact with Leader replicas, while Follower replicas are responsible for synchronizing messages. When a Leader replica fails, a new Leader is elected from the Follower replicas to provide services.<br /> Below are some important terms related to Kafka's multi-replica mechanism.

- **AR (Assigned Replicas)**: All replicas of a partition are collectively referred to as AR.
- **ISR (In-Sync Replicas)**: The ISR consists of the Leader replica and all Follower replicas that maintain synchronization with the Leader (including the Leader itself).
- **OSR (Out-of-Sync Replicas)**: OSR comprises all Follower replicas that do not maintain synchronization with the Leader.

First, producers send messages to the Leader replica, and then Follower replicas pull messages from the Leader for synchronization. At any given moment, messages in all replicas may not be identical, meaning that during synchronization, Followers may lag behind the Leader to some extent. This relationship can be expressed as: AR = ISR + OSR.<br /> The Leader maintains and tracks the lag state of all Follower replicas in the ISR set. When a Follower lags too much or fails, the Leader removes it from the ISR set. Conversely, if a Follower in the OSR set catches up with the Leader, the Leader moves it from the OSR set to the ISR set. Generally, when a Leader fails, only Followers in the ISR set are eligible to be elected as new Leaders, while Followers in the OSR set are not (though this behavior can be changed via configuration).

## Key Metrics for Monitoring Kafka

Next, we introduce detailed information about Kafka metrics.

#### UnderReplicatedPartitions

UnderReplicatedPartitions indicates the number of partitions in an unsynchronized state, i.e., the number of partitions with failed replicas. An abnormal value is non-zero. In a well-functioning cluster, the number of synchronized replicas (ISR) should equal the total number of replicas. A non-zero value indicates the number of partitions where the Leader on a Broker does not have fully synchronized replicas in the ISR. Possible issues include:

- A Broker has crashed.
- Disk failure or full disk causing replica offline, which can be identified by a non-zero OfflineLogDirectoryCount metric.
- Performance issues causing replicas to fall behind. This could happen due to frequent Full GC or excessive I/O overhead.

| Measurement | kafka_replica_manager |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| UnderReplicatedPartitions | Number of partitions in an unsynchronized state | int |
| UnderMinIsrPartitionCount | Number of partitions with fewer than the minimum ISR | int |

#### OfflineLogDirectoryCount

OfflineLogDirectoryCount indicates the number of offline log directories, with an abnormal value being non-zero. This metric should be monitored to check for any offline log directories.

| Measurement | kafka_log |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| OfflineLogDirectoryCount | Number of offline log directories | int |

#### IsrShrinksPerSec / IsrExpandsPerSec

The number of in-sync replicas (ISR) for any partition should remain stable unless you are expanding Broker nodes or deleting partitions. To ensure high availability, a Kafka cluster must maintain a minimum ISR count so that Followers can take over if a partition's Leader fails. Reasons for removing a replica from the ISR pool include a Follower's offset lagging far behind the Leader (configurable via `replica.lag.max.messages`) or a Follower losing contact with the Leader for some time (configurable via `replica.socket.timeout.ms`). If IsrShrinksPerSec (ISR shrinkage) increases without a corresponding increase in IsrExpandsPerSec (ISR expansion), attention and manual intervention are required.

| Measurement | kafka_replica_manager |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| IsrShrinksPerSec.Count | Number of ISR reductions | int |
| IsrShrinksPerSec.OneMinuteRate | Rate of ISR reductions | float |
| IsrExpandsPerSec.Count | Number of ISR expansions | int |
| IsrExpandsPerSec.OneMinuteRate | Rate of ISR expansions | float |

#### ActiveControllerCount

ActiveControllerCount indicates the number of active controllers, with an abnormal value being 0. In a Kafka cluster, the first started node automatically becomes the Controller, and there can only be one such node. Normally, this metric should be 1 on the Broker hosting the Controller and 0 on other Brokers. The Controller's responsibility is to maintain the list of partition Leaders and coordinate Leader changes when a Leader becomes unavailable. If necessary, a new Controller is randomly selected from the Broker pool by Zookeeper. Typically, this value should not exceed 1, but if it equals 0 for an extended period (<1), a clear warning should be issued. Therefore, this metric can be used for alerts.

| Measurement | kafka_controller |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| ActiveControllerCount.Value | Number of live Controllers | int |

#### OfflinePartitionsCount

OfflinePartitionsCount indicates the number of partitions without an active Leader, with an abnormal value being non-zero. Since all read/write operations occur only on Partition Leaders, any partition without an active Leader becomes completely unavailable, blocking consumers and producers until the Leader becomes available. This metric can be used for alerts.

| Measurement | kafka_controller |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| OfflinePartitionsCount.Value | Number of offline partitions | int |

#### LeaderElectionRateAndTimeMs

When a Partition Leader fails, a new Leader election is triggered. LeaderElectionRateAndTimeMs measures how many times per second Leader elections occur, indicating the election frequency.

| Measurement | kafka_controller |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| LeaderElectionRateAndTimeMs.Count | Number of Leader elections | int |
| LeaderElectionRateAndTimeMs.OneMinuteRate | Leader election rate | float |
| LeaderElectionRateAndTimeMs.50thPercentile | Median Leader election rate | float |
| LeaderElectionRateAndTimeMs.75thPercentile | 75th percentile Leader election rate | float |
| LeaderElectionRateAndTimeMs.99thPercentile | 99th percentile Leader election rate | float |

#### UncleanLeaderElectionsPerSec

When a Kafka Broker's partition Leader is unavailable, an unclean Leader election occurs, selecting a new Leader from the ISR set. Essentially, an unclean Leader election sacrifices consistency for availability. If there are no available replicas in the ISR, the election falls back to unsynchronized replicas, resulting in permanent data loss of messages from the previous Leader. An abnormal value for UncleanLeaderElectionsPerSec.Count is non-zero, indicating potential data loss, thus requiring alerts.


| Measurement | kafka_controller |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| UncleanLeaderElectionsPerSec.Count | Number of unclean Leader elections | int |

#### TotalTimeMs

TotalTimeMs is the sum of four metrics:

- Queue: Time spent waiting in the request queue
- Local: Time taken by the leader to process the request
- Remote: Time waiting for follower responses (only when `requests.required.acks=-1`)
- Response: Time taken to send the reply

TotalTimeMs measures the server request response time. Under normal conditions, this metric remains stable with small fluctuations. Irregular data spikes indicate potential delays, which can be diagnosed by examining the individual queue, local, remote, and response values.

| Measurement | kafka_request |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| TotalTimeMs.Count | Total request response time | int |

#### PurgatorySize

PurgatorySize refers to a temporary holding area where produce and fetch requests wait until needed. Monitoring the size of purgatory helps identify latency root causes. For instance, an increase in fetch requests in purgatory can explain increased consumer fetch times.

| Measurement | kafka_purgatory |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| Fetch.PurgatorySize | Size of Fetch Purgatory | int |
| Produce.PurgatorySize | Size of Produce Purgatory | int |
| Rebalance.PurgatorySize | Size of Rebalance Purgatory | int |
| topic.PurgatorySize | Size of Topic Purgatory | int |
| ElectLeader.PurgatorySize | Size of Leader Election Purgatory | int |
| DeleteRecords.PurgatorySize | Size of Delete Records Purgatory | int |
| DeleteRecords.NumDelayedOperations | Number of delayed delete records | int |
| Heartbeat.NumDelayedOperations | Heartbeat monitoring | int |

#### BytesInPerSec / BytesOutPerSec

BytesInPerSec/BytesOutPerSec measure incoming and outgoing bytes. Disk throughput and network throughput can both become bottlenecks. If you are sending messages across data centers, have numerous Topics, or replicas are catching up to the Leader, network throughput can impact Kafka performance. These metrics help track network throughput on Brokers to identify bottlenecks.

| Measurement | kafka_topics |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| BytesInPerSec.Count | Incoming bytes per second | int |
| BytesInPerSec.OneMinuteRate | Incoming byte rate per second | float |
| BytesOutPerSec.Count | Outgoing bytes per second | int |
| BytesOutPerSec.OneMinuteRate | Outgoing byte rate per second | float |

#### RequestsPerSec

RequestsPerSec measures requests per second. Monitoring this metric provides real-time insight into producer and consumer request rates to ensure efficient Kafka communication. If this metric remains consistently high, consider increasing the number of producers or consumers to improve throughput and reduce unnecessary network overhead.

| Measurement | kafka_topics |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| TotalFetchRequestsPerSec.Count | Fetch requests per second | int |
| TotalProduceRequestsPerSec.Count | Producer write requests per second | int |
| FailedFetchRequestsPerSec.Count | Failed fetch requests per second | int |
| FailedProduceRequestsPerSec.Count | Failed produce requests per second | int |

#### Other Common Metrics

| Measurement | kafka_controller |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| GlobalTopicCount.Value | Total number of Topics in the cluster | int |
| GlobalPartitionCount.Value | Total number of Partitions | int |
| TotalQueueSize.Value | Total queue size | int |
| EventQueueSize.Value | Event queue size | int |

| Measurement | kafka_request |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| RequestQueueTimeMs.Count | Request queue time | int |
| ResponseSendTimeMs.Count | Response queue time | int |
| MessageConversionsTimeMs.Count | Message conversion time | int |

| Measurement | kafka_topics |  |
| --- | --- | --- |
| Metric | Description | Data Type |
| PartitionCount.Value | Number of Partitions | int |
| LeaderCount.Value | Number of Leaders | int |
| BytesRejectedPerSec.Count | Number of rejected Topic requests | int |

## Use Case View

Before using <<< custom_key.brand_name >>> to observe Kafka, you need to register a [<<< custom_key.brand_name >>> account](https://auth.guance.com/register?channel=Help_Documentation). After registration, log in to the <<< custom_key.brand_name >>> workspace. Then follow the <[Kafka Integration Documentation](/integrations/kafka/)> to implement Kafka observability.

![image.png](../images/kafka-4.png)