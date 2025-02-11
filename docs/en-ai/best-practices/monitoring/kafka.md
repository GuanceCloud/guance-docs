# Kafka Observability Best Practices

---

## Overview 

Kafka is a distributed messaging queue based on the publish-subscribe model developed by LinkedIn. It is a real-time data processing system that can scale horizontally. Like middleware such as RabbitMQ and RocketMQ, Kafka has several key features:

- Asynchronous Processing 
- Service Decoupling 
- Traffic Shaving 

The following image illustrates asynchronous processing.

![image.png](../images/kafka-1.png)

## Architecture

As shown in the diagram below, a Kafka architecture includes multiple Producers, Consumers, Brokers, and a Zookeeper cluster.

![image.png](../images/kafka-2.png)

- **Zookeeper**: Manages cluster configurations for the Kafka cluster, elects Leaders, and handles rebalancing when Consumer Groups change.
- **Broker**: Message handling nodes in the messaging middleware; each node is a Broker, and a Kafka cluster consists of one or more Brokers. Messages can be distributed across multiple Brokers.
- **Producer**: Responsible for publishing messages to Brokers.
- **Consumer**: Reads messages from Brokers.
- **Consumer Group**: Each Consumer belongs to a specific Consumer Group, which can be named. If not specified, it belongs to the default Group. A message can be sent to multiple Groups, but only one Consumer within a Group can consume the message.

Kafka categorizes messages, and every message sent to the cluster must specify a Topic. A Topic represents a class of messages logically considered as a Queue. Each message produced by a Producer must specify a Topic, and Consumers will pull messages from the corresponding Broker based on the subscribed Topic. Each Topic contains one or more Partitions, where a Partition corresponds to a folder storing the Partition's data and index files. Messages within a Partition are ordered. A Topic can be divided into one or more Partitions, with multiple replicas of each Partition distributed across different Brokers. Replicas of a partition have a leader-follower relationship, with the Leader providing external services and Followers synchronizing with the Leader passively. This multi-replica mechanism ensures automatic failover in case of broker failure, enhancing disaster recovery capabilities.

As shown in the figure below, a Kafka cluster has 4 Brokers, and a certain Topic has three partitions. Assuming the replication factor is set to 3, each partition will have one Leader and two Follower replicas.

![image.png](../images/kafka-3.png)

Partition replicas reside on different Brokers, with producers and consumers interacting only with Leader replicas while Follower replicas handle message synchronization. When a Leader replica fails, a new Leader is elected from the Follower replicas to provide service.<br /> Below are some important terms related to Kafka's multi-replica mechanism.

- **AR (Assigned Replicas)**: All replicas of a partition are collectively referred to as AR.
- **ISR (In-Sync Replicas)**: The ISR comprises the Leader replica and all Follower replicas that maintain a certain level of synchronization (including the Leader itself).
- **OSR (Out-of-Sync Replicas)**: OSR includes all Follower replicas that do not maintain a certain level of synchronization with the Leader.

Initially, producers send messages to the Leader replica, and then Follower replicas pull messages from the Leader for synchronization. At any given time, the messages in all replicas may not be identical, meaning there can be a lag between Followers and the Leader during synchronization. Thus, the relationship among AR, ISR, and OSR is: AR = ISR + OSR.<br /> The Leader maintains and tracks the lag state of all Follower replicas in the ISR set. If a Follower lags too much or fails, it is removed from the ISR set. Conversely, if a Follower in the OSR set catches up to the Leader, it can be moved back to the ISR set. Generally, only Followers in the ISR set are eligible to be elected as new Leaders when the current Leader fails, while Followers in the OSR set do not have this opportunity (though this behavior can be changed via configuration).

## Key Metrics for Monitoring Kafka

Next, we introduce detailed information about Kafka metrics.

#### UnderReplicatedPartitions

UnderReplicatedPartitions indicates the number of partitions not fully synchronized, i.e., partitions with failed replicas. In a well-functioning cluster, the number of in-sync replicas (ISR) should equal the total number of replicas. A non-zero value indicates the number of partitions on a Broker where the Leader does not have fully synchronized replicas in the ISR. Possible issues include:

- A Broker going down.
- Disk failures or full disks causing replicas to go offline, which can be verified by checking the OfflineLogDirectoryCount metric.
- Performance issues leading to delayed synchronization. Two scenarios could occur: first, a Follower process getting stuck without initiating sync requests to the Leader, e.g., due to frequent Full GC; second, a Follower process syncing too slowly to catch up with the Leader, e.g., due to high I/O overhead.

| Mearsurement | kafka_replica_manager |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| UnderReplicatedPartitions | Number of partitions in an unsynchronized state | int |
| UnderMinIsrPartitionCount | Number of partitions below minimum ISR | int |

#### OfflineLogDirectoryCount

OfflineLogDirectoryCount measures the number of offline log directories, with a non-zero value indicating issues. Monitoring this metric helps identify whether any log directories are offline.

| Mearsurement | kafka_log |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| OfflineLogDirectoryCount | Number of offline log directories | int |

#### IsrShrinksPerSec / IsrExpandsPerSec

The number of in-sync replicas (ISR) for any partition should remain stable unless expanding Broker nodes or deleting partitions. To ensure high availability, a Kafka cluster must maintain a minimum ISR count so that Followers can take over if a partition's Leader goes down. Reasons for removing a replica from the ISR pool include a Follower's offset falling significantly behind the Leader (configurable via `replica.lag.max.messages`) or losing contact with the Leader for some time (configurable via `replica.socket.timeout.ms`). An increase in IsrShrinksPerSec (ISR shrinkage) without a corresponding increase in IsrExpandsPerSec (ISR expansion) warrants attention and manual intervention.

| Mearsurement | kafka_replica_manager |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| IsrShrinksPerSec.Count | Number of ISR reductions | int |
| IsrShrinksPerSec.OneMinuteRate | Frequency of ISR reductions | float |
| IsrExpandsPerSec.Count | Number of ISR expansions | int |
| IsrExpandsPerSec.OneMinuteRate | Frequency of ISR expansions | float |

#### ActiveControllerCount

ActiveControllerCount measures the number of currently active controllers, with an abnormal value of 0. In a Kafka cluster, the first started node automatically becomes the Controller, and there can only be one such node. Normally, this metric should be 1 on the Broker hosting the Controller and 0 on other Brokers. The Controller manages the list of partition Leaders and coordinates Leader changes when necessary. If a new Controller needs to be selected, Zookeeper randomly picks one from the Broker pool. Typically, this value cannot exceed 1, but if it remains at 0 for a period, an alert should be triggered.

| Mearsurement | kafka_controller |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| ActiveControllerCount.Value | Number of active Controllers | int |

#### OfflinePartitionsCount

OfflinePartitionsCount measures the number of partitions without active Leaders, with an abnormal value of non-zero. Since all read/write operations occur only on Partition Leaders, any partition without an active Leader becomes completely unavailable, blocking producers and consumers until a Leader becomes available. This metric can be used for alerts.

| Mearsurement | kafka_controller |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| OfflinePartitionsCount.Value | Number of offline partitions | int |

#### LeaderElectionRateAndTimeMs

LeaderElectionRateAndTimeMs measures the frequency of Leader elections per second. When a Partition Leader fails, a new Leader election is triggered.

| Mearsurement | kafka_controller |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| LeaderElectionRateAndTimeMs.Count | Number of Leader elections | int |
| LeaderElectionRateAndTimeMs.OneMinuteRate | Frequency of Leader elections | float |
| LeaderElectionRateAndTimeMs.50thPercentile | Median Leader election time | float |
| LeaderElectionRateAndTimeMs.75thPercentile | 75th percentile Leader election time | float |
| LeaderElectionRateAndTimeMs.99thPercentile | 99th percentile Leader election time | float |

#### UncleanLeaderElectionsPerSec

UncleanLeaderElectionsPerSec measures unclean Leader elections when no in-sync replicas are available in the ISR set, leading to potential data loss. An abnormal value is non-zero, indicating data loss and necessitating alerts.

| Mearsurement | kafka_controller |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| UncleanLeaderElectionsPerSec.Count | Number of unclean Leader elections | int |

#### TotalTimeMs

TotalTimeMs measures the sum of four metrics:

- Queue: Time spent waiting in the request queue
- Local: Time spent processing by the leader
- Remote: Time spent waiting for follower responses (only when `requests.required.acks=-1`)
- Response: Time spent sending replies

TotalTimeMs measures server request latency, which should be stable under normal conditions. Irregular fluctuations suggest potential delays, requiring investigation into the specific segments causing the delay.

| Mearsurement | kafka_request |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| TotalTimeMs.Count | Total request latency | int |

#### PurgatorySize

PurgatorySize refers to temporary storage areas for produce and fetch requests, waiting until they are needed. Monitoring purgatory size can help identify latency root causes. For example, an increase in fetch requests in purgatory can explain increased consumer fetch times.

| Mearsurement | kafka_purgatory |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| Fetch.PurgatorySize | Size of fetch purgatory | int |
| Produce.PurgatorySize | Size of produce purgatory | int |
| Rebalance.PurgatorySize | Size of rebalance purgatory | int |
| topic.PurgatorySize | Size of topic purgatory | int |
| ElectLeader.PurgatorySize | Size of leader election purgatory | int |
| DeleteRecords.PurgatorySize | Size of delete records purgatory | int |
| DeleteRecords.NumDelayedOperations | Number of delayed delete operations | int |
| Heartbeat.NumDelayedOperations | Heartbeat monitoring | int |

#### BytesInPerSec / BytesOutPerSec

BytesInPerSec/BytesOutPerSec measure incoming/outgoing bytes. Disk throughput and network throughput can both become bottlenecks. Network throughput can impact Kafka performance when sending messages across data centers, having many Topics, or catching up with Leaders. These metrics help track network throughput on Brokers to identify bottlenecks.

| Mearsurement | kafka_topics |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| BytesInPerSec.Count | Incoming bytes per second | int |
| BytesInPerSec.OneMinuteRate | Incoming byte rate per second | float |
| BytesOutPerSec.Count | Outgoing bytes per second | int |
| BytesOutPerSec.OneMinuteRate | Outgoing byte rate per second | float |

#### RequestsPerSec

RequestsPerSec measures the number of requests per second. Monitoring this metric provides real-time insights into producer and consumer request rates to ensure efficient Kafka communication. If this metric remains consistently high, consider increasing the number of producers or consumers to improve throughput and reduce unnecessary network overhead.

| Mearsurement | kafka_topics |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| TotalFetchRequestsPerSec.Count | Number of fetch requests per second | int |
| TotalProduceRequestsPerSec.Count | Number of produce requests per second | int |
| FailedFetchRequestsPerSec.Count | Number of failed fetch requests per second | int |
| FailedProduceRequestsPerSec.Count | Number of failed produce requests per second | int |

#### Other Common Metrics

| Mearsurement | kafka_controller |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| GlobalTopicCount.Value | Total number of Topics in the cluster | int |
| GlobalPartitionCount.Value | Total number of partitions | int |
| TotalQueueSize.Value | Total queue size | int |
| EventQueueSize.Value | Event queue size | int |

| Mearsurement | kafka_request |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| RequestQueueTimeMs.Count | Request queue time | int |
| ResponseSendTimeMs.Count | Response queue time | int |
| MessageConversionsTimeMs.Count | Message conversion time | int |

| Mearsurement | kafka_topics |  |
| --- | --- | --- |
| Metrics | Description | Data Type |
| PartitionCount.Value | Number of partitions | int |
| LeaderCount.Value | Number of Leaders | int |
| BytesRejectedPerSec.Count | Number of rejected Topic requests | int |

## Scenario Views

Before using Guance to monitor Kafka, you need to register a [Guance account](https://auth.guance.com/register?channel=Help Documentation). After registration, log in to your Guance workspace. Then follow the <[Kafka Integration Documentation](/integrations/kafka/)> to implement Kafka observability.

![image.png](../images/kafka-4.png)