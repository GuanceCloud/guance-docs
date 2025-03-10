---
title: 'AWS MSK'
tags: 
  - AWS
summary: 'AWS MSK metrics collection'
__int_icon: 'icon/aws_msk'
dashboard:
  - desc: 'AWS MSK'
    path: 'dashboard/en/aws_msk'

---


<!-- markdownlint-disable MD025 -->
# AWS MSK
<!-- markdownlint-enable -->

Amazon Managed Streaming for Apache Kafka (Amazon MSK) is a fully hosted service that allows for building and running applications that use Apache Kafka to handle streaming data.

Use the「Guance  Synchronization」series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip：Please prepare AWS AK that meets the requirements in advance（For simplicity's sake,，You can directly grant the global read-only permission`ReadOnlyAccess`）

To synchronize the monitoring data of AWS Kinesis cloud resources, we install the corresponding collection script: `ID:guance_aws_kafka`

Click 【Install】 and enter the corresponding parameters: AWS AK, AWS account name.

tap【Deploy startup Script】，The system automatically creates `Startup` script sets，And automatically configure the corresponding startup script。

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in「Management / Crontab Config」。Click【Run】，you can immediately execute once, without waiting for a regular time。After a while, you can view task execution records and corresponding logs。

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-kinesis/){:target="_blank"}


### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click 「Infrastructure / Custom」 to check whether asset information exists
3. On the Guance platform, press 「Metrics」 to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them [Amazon Managed Streaming for Kafka Collect](https://docs.aws.amazon.com/zh_cn/msk/latest/developerguide/metrics-details.html){:target="_blank"}

### Level：`DEFAULT`

|Name|When visible|Dimensions|Description|
| - | - | - | - |
|ActiveControllerCount|After the cluster gets to the ACTIVE state.|Cluster Name|Only one controller per cluster should be active at any given time.|
|`BurstBalance`|After the cluster gets to the ACTIVE state.|Cluster Name , Broker ID|The remaining balance of input-output burst credits for EBS volumes in the cluster. Use it to investigate latency or decreased throughput.<br/>`BurstBalance` is not reported for EBS volumes when the baseline performance of a volume is higher than the maximum burst performance. For more information, see I/O Credits and burst performance.|
|BytesInPerSec| After you create a topic.|Cluster Name, Broker ID, Topic|The number of bytes per second received from clients. This metric is available per broker and also per topic.|
|BytesOutPerSec|After you create a topic.|Cluster Name, Broker ID, Topic|The number of bytes per second sent to clients. This metric is available per broker and also per topic.|
|ClientConnectionCount|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID, Client Authentication|The number of active authenticated client connections.|
|ConnectionCount|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of active authenticated, unauthenticated, and inter-broker connections.|
|CPUCreditBalance|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of earned CPU credits that a broker has accrued since it was launched. Credits are accrued in the credit balance after they are earned, and removed from the credit balance when they are spent. If you run out of the CPU credit balance, it can have a negative impact on your cluster's performance. You can take steps to reduce CPU load. For example, you can reduce the number of client requests or update the broker type to an M5 broker type.|
|CpuIdle|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of CPU idle time.|
|CpuIoWait|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of CPU idle time during a pending disk operation.|
|CpuSystem|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of CPU in kernel space.|
|CpuUser|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of CPU in user space.|
|GlobalPartitionCount|After the cluster gets to the ACTIVE state.|Cluster Name|The number of partitions across all topics in the cluster, excluding replicas. Because GlobalPartitionCount doesn't include replicas, the sum of the PartitionCount values can be higher than GlobalPartitionCount if the replication factor for a topic is greater than 1.|
|GlobalTopicCount|After the cluster gets to the ACTIVE state.|Cluster Name|Total number of topics across all brokers in the cluster.|
|EstimatedMaxTimeLag|After consumer group consumes from a topic.|Consumer Group, Topic|Time estimate (in seconds) to drain MaxOffsetLag.|
|KafkaAppLogsDiskUsed|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of disk space used for application logs.|
|KafkaDataLogsDiskUsed (Cluster Name, Broker ID dimension)|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of disk space used for data logs.|
|KafkaDataLogsDiskUsed (Cluster Name dimension)|After the cluster gets to the ACTIVE state.|Cluster Name|The percentage of disk space used for data logs.|
|LeaderCount|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The total number of leaders of partitions per broker, not including replicas.|
|MaxOffsetLag|After consumer group consumes from a topic.|Consumer Group, Topic|The maximum offset lag across all partitions in a topic.|
| MemoryBuffered |After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID | The size in bytes of buffered memory for the broker.|
|MemoryCached|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The size in bytes of cached memory for the broker.|
|MemoryFree|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The size in bytes of memory that is free and available for the broker.|
|HeapMemoryAfterGC|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of total heap memory in use after garbage collection.|
|MemoryUsed|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The size in bytes of memory that is in use for the broker.|
|MessagesInPerSec|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of incoming messages per second for the broker.|
| NetworkRxDropped |After the cluster gets to the ACTIVE state.| Cluster Name, Broker ID | The number of dropped receive packages.|
|NetworkRxErrors|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of network receive errors for the broker.|
|NetworkRxPackets|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of packets received by the broker.|
|NetworkTxDropped|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of dropped transmit packages.|
|NetworkTxErrors|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of network transmit errors for the broker.|
|NetworkTxPackets|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of packets transmitted by the broker.|
|OfflinePartitionsCount|After the cluster gets to the ACTIVE state.|Cluster Name|Total number of partitions that are offline in the cluster.|
|PartitionCount|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The total number of topic partitions per broker, including replicas.|
|ProduceTotalTimeMsMean|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The mean produce time in milliseconds.|
|RequestBytesMean|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The mean number of request bytes for the broker.|
|RequestTime|After request throttling is applied.|Cluster Name, Broker ID|The average time in milliseconds spent in broker network and I/O threads to process requests.|
|RootDiskUsed|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The percentage of the root disk used by the broker.|
|SumOffsetLag|After consumer group consumes from a topic.|Consumer Group, Topic|The aggregated offset lag for all the partitions in a topic.|
|SwapFree|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The size in bytes of swap memory that is available for the broker.|
|SwapUsed|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The size in bytes of swap memory that is in use for the broker.|
|TrafficShaping|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|High-level metrics indicating the number of packets shaped (dropped or queued) due to exceeding network allocations. Finer detail is available with PER_BROKER metrics.|
|UnderMinIsrPartitionCount|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of under minIsr partitions for the broker.|
|UnderReplicatedPartitions|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The number of under-replicated partitions for the broker.|
|ZooKeeperRequestLatencyMsMean|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|The mean latency in milliseconds for Apache ZooKeeper requests from broker.|
|ZooKeeperSessionState|After the cluster gets to the ACTIVE state.|Cluster Name, Broker ID|Connection status of broker's ZooKeeper session which may be one of the following: NOT_CONNECTED: '0.0', ASSOCIATING: '0.1', CONNECTING: '0.5', CONNECTEDREADONLY: '0.8', CONNECTED: '1.0', CLOSED: '5.0', AUTH_FAILED: '10.0'.|


**Other levels of indicators refer to [official documents](https://docs.aws.amazon.com/msk/latest/developerguide/metrics-details.html)**
