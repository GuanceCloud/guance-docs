
# Kafka
---

- DataKit 版本：1.4.5
- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

采集 Kafka 指标和日志上报到观测云，帮助你监控分析 Kafka 各种异常情况

![](imgs/input-kafka-1.png)

## 前置条件

安装或下载 [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.2/jolokia-jvm-1.6.2-agent.jar){:target="_blank"}。DataKit 安装目录下的 `data` 目录中已经有下载好的 Jolokia jar 包。 

Jolokia 是作为 Kafka 的 java agent，基于 HTTP 协议提供了一个使用 json 作为数据格式的外部接口，提供给 DataKit 使用。 Kafka 启动时，先配置 `KAFKA_OPTS` 环境变量：(port 可根据实际情况修改成可用端口）

```shell
export KAFKA_OPTS="$KAFKA_OPTS -javaagent:/usr/local/datakit/data/jolokia-jvm-agent.jar=host=*,port=8080"
```

另外，也可以单独启动 Jolokia，将其指向 Kafka 进程 PID：

```shell
java -jar </path/to/jolokia-jvm-agent.jar> --host 127.0.0.1 --port=8080 start <Kafka-PID>
```

在开启 Kafka 服务后，如需采集 Producer/Consumer/Connector 指标，则需分别为其配置 Jolokia。

参考 [KAFKA QUICKSTART](https://kafka.apache.org/quickstart){:target="_blank"} ，以 Producer 为例，先配置 `KAFKA_OPTS` 环境变量，示例如下：

```shell
export KAFKA_OPTS="-javaagent:/usr/local/datakit/data/jolokia-jvm-agent.jar=host=127.0.0.1,port=8090"
```

进入 Kafka 目录下启动一个 Producer：

```shell
bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092
```

复制出一个 kafka.conf 以开启多个 Kafka 采集器，并配置该 url：

```toml
  urls = ["http://localhost:8090/jolokia"]
```

并将采集 Producer 指标部分的字段去掉注释：

```toml
  # The following metrics are available on producer instances.  
  [[inputs.kafka.metric]]
    name       = "kafka_producer"
    mbean      = "kafka.producer:type=*,client-id=*"
    tag_keys   = ["client-id", "type"]
```

重启 Datakit，这时 Datakit 便可采集到 Producer 实例的指标。

## 配置

进入 DataKit 安装目录下的 `conf.d/db` 目录，复制 `kafka.conf.sample` 并命名为 `kafka.conf`。示例如下：

```toml

[[inputs.kafka]]
  # default_tag_prefix      = ""
  # default_field_prefix    = ""
  # default_field_separator = "."
  
  # username = ""
  # password = ""
  # response_timeout = "5s"
  
  ## Optional TLS config
  # tls_ca   = "/var/private/ca.pem"
  # tls_cert = "/var/private/client.pem"
  # tls_key  = "/var/private/client-key.pem"
  # insecure_skip_verify = false
  
  ## Monitor Interval
  # interval   = "60s"
  
  # Add agents URLs to query
  urls = ["http://localhost:8080/jolokia"]
  
  ## Add metrics to read
  [[inputs.kafka.metric]]
    name         = "kafka_controller"
    mbean        = "kafka.controller:name=*,type=*"
    field_prefix = "#1."
  
  [[inputs.kafka.metric]]
    name         = "kafka_replica_manager"
    mbean        = "kafka.server:name=*,type=ReplicaManager"
    field_prefix = "#1."

  [[inputs.kafka.metric]]
    name         = "kafka_zookeeper"
    mbean        = "kafka.server:type=ZooKeeperClientMetrics,name=*"
    field_prefix = "#1."
  
  [[inputs.kafka.metric]]
    name         = "kafka_purgatory"
    mbean        = "kafka.server:delayedOperation=*,name=*,type=DelayedOperationPurgatory"
    field_name   = "#1.#2"
  
  [[inputs.kafka.metric]]
    name     = "kafka_client"
    mbean    = "kafka.server:client-id=*,type=*"
    tag_keys = ["client-id", "type"]
  
  [[inputs.kafka.metric]]
    name         = "kafka_request"
    mbean        = "kafka.network:name=*,request=*,type=RequestMetrics"
    field_prefix = "#1."
    tag_keys     = ["request"]

  [[inputs.kafka.metric]]
    name         = "kafka_request_handler"
    mbean        = "kafka.server:type=KafkaRequestHandlerPool,name=*"
    field_prefix = "#1."

  [[inputs.kafka.metric]]
    name         = "kafka_network"
    mbean        = "kafka.network:type=*,name=*"
    field_name   = "#2"
    tag_keys     = ["type"]
  
  [[inputs.kafka.metric]]
    name         = "kafka_topics"
    mbean        = "kafka.server:name=*,type=BrokerTopicMetrics"
    field_prefix = "#1."
  
  [[inputs.kafka.metric]]
    name         = "kafka_topic"
    mbean        = "kafka.server:name=*,topic=*,type=BrokerTopicMetrics"
    field_prefix = "#1."
    tag_keys     = ["topic"]
  
  [[inputs.kafka.metric]]
    name       = "kafka_partition"
    mbean      = "kafka.log:name=*,partition=*,topic=*,type=Log"
    field_name = "#1"
    tag_keys   = ["topic", "partition"]

  [[inputs.kafka.metric]]
    name       = "kafka_log"
    mbean      = "kafka.log:type=*,name=*"
    field_name = "#2"
    tag_keys   = ["type"]
  
  [[inputs.kafka.metric]]
    name       = "kafka_partition"
    mbean      = "kafka.cluster:name=UnderReplicated,partition=*,topic=*,type=Partition"
    field_name = "UnderReplicatedPartitions"
    tag_keys   = ["topic", "partition"]

  # # The following metrics are available on consumer instances.
  # [[inputs.kafka.metric]]
  #   name       = "kafka_consumer"
  #   mbean      = "kafka.consumer:type=*,client-id=*"
  #   tag_keys   = ["client-id", "type"]

  # # The following metrics are available on producer instances.  
  # [[inputs.kafka.metric]]
  #   name       = "kafka_producer"
  #   mbean      = "kafka.producer:type=*,client-id=*"
  #   tag_keys   = ["client-id", "type"]

  # # The following metrics are available on connector instances.
  # [[inputs.kafka.metric]]
  #   name       = "kafka_connect"
  #   mbean      = "kafka.connect:type=*"
  #   tag_keys   = ["type"]
  
  # [[inputs.kafka.metric]]
  #   name       = "kafka_connect"
  #   mbean      = "kafka.connect:type=*,connector=*"
  #   tag_keys   = ["type", "connector"]

  # [[inputs.kafka.metric]]
  #   name       = "kafka_connect"
  #   mbean      = "kafka.connect:type=*,connector=*,task=*"
  #   tag_keys   = ["type", "connector", "task"]

  # [inputs.kafka.log]
  # files = []
  # #grok pipeline script path
  # pipeline = "kafka.p"
  
  [inputs.kafka.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

## 指标预览

![](imgs/input-kafka-2.png)

## 日志预览

![](imgs/input-kafka-3.png)

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.kafka.tags]` 指定其它标签：

``` toml
 [inputs.kafka.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `kafka_controller`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`ActiveControllerCount.Value`||int|count|
|`AutoLeaderBalanceRateAndTimeMs.50thPercentile`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.75thPercentile`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.95thPercentile`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.98thPercentile`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.999thPercentile`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.99thPercentile`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.Count`||int|count|
|`AutoLeaderBalanceRateAndTimeMs.EventType`||string|-|
|`AutoLeaderBalanceRateAndTimeMs.FifteenMinuteRate`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.FiveMinuteRate`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.LatencyUnit`||string|-|
|`AutoLeaderBalanceRateAndTimeMs.Max`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.Mean`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.MeanRate`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.Min`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.OneMinuteRate`||float|-|
|`AutoLeaderBalanceRateAndTimeMs.RateUnit`||string|-|
|`AutoLeaderBalanceRateAndTimeMs.StdDev`||float|-|
|`ControlledShutdownRateAndTimeMs.50thPercentile`||float|-|
|`ControlledShutdownRateAndTimeMs.75thPercentile`||float|-|
|`ControlledShutdownRateAndTimeMs.95thPercentile`||float|-|
|`ControlledShutdownRateAndTimeMs.98thPercentile`||float|-|
|`ControlledShutdownRateAndTimeMs.999thPercentile`||float|-|
|`ControlledShutdownRateAndTimeMs.99thPercentile`||float|-|
|`ControlledShutdownRateAndTimeMs.Count`||int|count|
|`ControlledShutdownRateAndTimeMs.EventType`||string|-|
|`ControlledShutdownRateAndTimeMs.FifteenMinuteRate`||float|-|
|`ControlledShutdownRateAndTimeMs.FiveMinuteRate`||float|-|
|`ControlledShutdownRateAndTimeMs.LatencyUnit`||string|-|
|`ControlledShutdownRateAndTimeMs.Max`||float|-|
|`ControlledShutdownRateAndTimeMs.Mean`||float|-|
|`ControlledShutdownRateAndTimeMs.MeanRate`||float|-|
|`ControlledShutdownRateAndTimeMs.Min`||float|-|
|`ControlledShutdownRateAndTimeMs.OneMinuteRate`||float|-|
|`ControlledShutdownRateAndTimeMs.RateUnit`||string|-|
|`ControlledShutdownRateAndTimeMs.StdDev`||float|-|
|`ControllerChangeRateAndTimeMs.50thPercentile`||float|-|
|`ControllerChangeRateAndTimeMs.75thPercentile`||float|-|
|`ControllerChangeRateAndTimeMs.95thPercentile`||float|-|
|`ControllerChangeRateAndTimeMs.98thPercentile`||float|-|
|`ControllerChangeRateAndTimeMs.999thPercentile`||float|-|
|`ControllerChangeRateAndTimeMs.99thPercentile`||float|-|
|`ControllerChangeRateAndTimeMs.Count`||int|count|
|`ControllerChangeRateAndTimeMs.EventType`||string|-|
|`ControllerChangeRateAndTimeMs.FifteenMinuteRate`||float|-|
|`ControllerChangeRateAndTimeMs.FiveMinuteRate`||float|-|
|`ControllerChangeRateAndTimeMs.LatencyUnit`||string|-|
|`ControllerChangeRateAndTimeMs.Max`||float|-|
|`ControllerChangeRateAndTimeMs.Mean`||float|-|
|`ControllerChangeRateAndTimeMs.MeanRate`||float|-|
|`ControllerChangeRateAndTimeMs.Min`||float|-|
|`ControllerChangeRateAndTimeMs.OneMinuteRate`||float|-|
|`ControllerChangeRateAndTimeMs.RateUnit`||string|-|
|`ControllerChangeRateAndTimeMs.StdDev`||float|-|
|`ControllerShutdownRateAndTimeMs.50thPercentile`||float|-|
|`ControllerShutdownRateAndTimeMs.75thPercentile`||float|-|
|`ControllerShutdownRateAndTimeMs.95thPercentile`||float|-|
|`ControllerShutdownRateAndTimeMs.98thPercentile`||float|-|
|`ControllerShutdownRateAndTimeMs.999thPercentile`||float|-|
|`ControllerShutdownRateAndTimeMs.99thPercentile`||float|-|
|`ControllerShutdownRateAndTimeMs.Count`||int|count|
|`ControllerShutdownRateAndTimeMs.EventType`||string|-|
|`ControllerShutdownRateAndTimeMs.FifteenMinuteRate`||float|-|
|`ControllerShutdownRateAndTimeMs.FiveMinuteRate`||float|-|
|`ControllerShutdownRateAndTimeMs.LatencyUnit`||string|-|
|`ControllerShutdownRateAndTimeMs.Max`||float|-|
|`ControllerShutdownRateAndTimeMs.Mean`||float|-|
|`ControllerShutdownRateAndTimeMs.MeanRate`||float|-|
|`ControllerShutdownRateAndTimeMs.Min`||float|-|
|`ControllerShutdownRateAndTimeMs.OneMinuteRate`||float|-|
|`ControllerShutdownRateAndTimeMs.RateUnit`||string|-|
|`ControllerShutdownRateAndTimeMs.StdDev`||float|-|
|`ControllerState.Value`||int|-|
|`EventQueueSize.Value`||int|-|
|`EventQueueTimeMs.50thPercentile`||float|-|
|`EventQueueTimeMs.75thPercentile`||float|-|
|`EventQueueTimeMs.95thPercentile`||float|-|
|`EventQueueTimeMs.98thPercentile`||float|-|
|`EventQueueTimeMs.999thPercentile`||float|-|
|`EventQueueTimeMs.99thPercentile`||float|-|
|`EventQueueTimeMs.Count`||int|count|
|`EventQueueTimeMs.EventType`||string|-|
|`EventQueueTimeMs.FifteenMinuteRate`||float|-|
|`EventQueueTimeMs.FiveMinuteRate`||float|-|
|`EventQueueTimeMs.LatencyUnit`||string|-|
|`EventQueueTimeMs.Max`||float|-|
|`EventQueueTimeMs.Mean`||float|-|
|`EventQueueTimeMs.MeanRate`||float|-|
|`EventQueueTimeMs.Min`||float|-|
|`EventQueueTimeMs.OneMinuteRate`||float|-|
|`EventQueueTimeMs.RateUnit`||string|-|
|`EventQueueTimeMs.StdDev`||float|-|
|`GlobalPartitionCount.Value`||int|count|
|`GlobalTopicCount.Value`||int|count|
|`IsrChangeRateAndTimeMs.50thPercentile`||float|-|
|`IsrChangeRateAndTimeMs.75thPercentile`||float|-|
|`IsrChangeRateAndTimeMs.95thPercentile`||float|-|
|`IsrChangeRateAndTimeMs.98thPercentile`||float|-|
|`IsrChangeRateAndTimeMs.999thPercentile`||float|-|
|`IsrChangeRateAndTimeMs.99thPercentile`||float|-|
|`IsrChangeRateAndTimeMs.Count`||int|count|
|`IsrChangeRateAndTimeMs.EventType`||string|-|
|`IsrChangeRateAndTimeMs.FifteenMinuteRate`||float|-|
|`IsrChangeRateAndTimeMs.FiveMinuteRate`||float|-|
|`IsrChangeRateAndTimeMs.LatencyUnit`||string|-|
|`IsrChangeRateAndTimeMs.Max`||float|-|
|`IsrChangeRateAndTimeMs.Mean`||float|-|
|`IsrChangeRateAndTimeMs.MeanRate`||float|-|
|`IsrChangeRateAndTimeMs.Min`||float|-|
|`IsrChangeRateAndTimeMs.OneMinuteRate`||float|-|
|`IsrChangeRateAndTimeMs.RateUnit`||string|-|
|`IsrChangeRateAndTimeMs.StdDev`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.50thPercentile`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.75thPercentile`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.95thPercentile`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.98thPercentile`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.999thPercentile`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.99thPercentile`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.Count`||int|count|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.EventType`||string|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.FifteenMinuteRate`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.FiveMinuteRate`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.LatencyUnit`||string|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.Max`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.Mean`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.MeanRate`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.Min`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.OneMinuteRate`||float|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.RateUnit`||string|-|
|`LeaderAndIsrResponseReceivedRateAndTimeMs.StdDev`||float|-|
|`LeaderElectionRateAndTimeMs.50thPercentile`||float|-|
|`LeaderElectionRateAndTimeMs.75thPercentile`||float|-|
|`LeaderElectionRateAndTimeMs.95thPercentile`||float|-|
|`LeaderElectionRateAndTimeMs.98thPercentile`||float|-|
|`LeaderElectionRateAndTimeMs.999thPercentile`||float|-|
|`LeaderElectionRateAndTimeMs.99thPercentile`||float|-|
|`LeaderElectionRateAndTimeMs.Count`||int|count|
|`LeaderElectionRateAndTimeMs.EventType`||string|-|
|`LeaderElectionRateAndTimeMs.FifteenMinuteRate`||float|-|
|`LeaderElectionRateAndTimeMs.FiveMinuteRate`||float|-|
|`LeaderElectionRateAndTimeMs.LatencyUnit`||string|-|
|`LeaderElectionRateAndTimeMs.Max`||float|-|
|`LeaderElectionRateAndTimeMs.Mean`||float|-|
|`LeaderElectionRateAndTimeMs.MeanRate`||float|-|
|`LeaderElectionRateAndTimeMs.Min`||float|-|
|`LeaderElectionRateAndTimeMs.OneMinuteRate`||float|-|
|`LeaderElectionRateAndTimeMs.RateUnit`||string|-|
|`LeaderElectionRateAndTimeMs.StdDev`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.50thPercentile`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.75thPercentile`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.95thPercentile`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.98thPercentile`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.999thPercentile`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.99thPercentile`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.Count`||int|count|
|`ListPartitionReassignmentRateAndTimeMs.EventType`||string|-|
|`ListPartitionReassignmentRateAndTimeMs.FifteenMinuteRate`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.FiveMinuteRate`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.LatencyUnit`||string|-|
|`ListPartitionReassignmentRateAndTimeMs.Max`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.Mean`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.MeanRate`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.Min`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.OneMinuteRate`||float|-|
|`ListPartitionReassignmentRateAndTimeMs.RateUnit`||string|-|
|`ListPartitionReassignmentRateAndTimeMs.StdDev`||float|-|
|`LogDirChangeRateAndTimeMs.50thPercentile`||float|-|
|`LogDirChangeRateAndTimeMs.75thPercentile`||float|-|
|`LogDirChangeRateAndTimeMs.95thPercentile`||float|-|
|`LogDirChangeRateAndTimeMs.98thPercentile`||float|-|
|`LogDirChangeRateAndTimeMs.999thPercentile`||float|-|
|`LogDirChangeRateAndTimeMs.99thPercentile`||float|-|
|`LogDirChangeRateAndTimeMs.Count`||int|count|
|`LogDirChangeRateAndTimeMs.EventType`||string|-|
|`LogDirChangeRateAndTimeMs.FifteenMinuteRate`||float|-|
|`LogDirChangeRateAndTimeMs.FiveMinuteRate`||float|-|
|`LogDirChangeRateAndTimeMs.LatencyUnit`||string|-|
|`LogDirChangeRateAndTimeMs.Max`||float|-|
|`LogDirChangeRateAndTimeMs.Mean`||float|-|
|`LogDirChangeRateAndTimeMs.MeanRate`||float|-|
|`LogDirChangeRateAndTimeMs.Min`||float|-|
|`LogDirChangeRateAndTimeMs.OneMinuteRate`||float|-|
|`LogDirChangeRateAndTimeMs.RateUnit`||string|-|
|`LogDirChangeRateAndTimeMs.StdDev`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.50thPercentile`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.75thPercentile`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.95thPercentile`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.98thPercentile`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.999thPercentile`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.99thPercentile`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.Count`||int|count|
|`ManualLeaderBalanceRateAndTimeMs.EventType`||string|-|
|`ManualLeaderBalanceRateAndTimeMs.FifteenMinuteRate`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.FiveMinuteRate`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.LatencyUnit`||string|-|
|`ManualLeaderBalanceRateAndTimeMs.Max`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.Mean`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.MeanRate`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.Min`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.OneMinuteRate`||float|-|
|`ManualLeaderBalanceRateAndTimeMs.RateUnit`||string|-|
|`ManualLeaderBalanceRateAndTimeMs.StdDev`||float|-|
|`OfflinePartitionsCount.Value`||int|count|
|`PartitionReassignmentRateAndTimeMs.50thPercentile`||float|-|
|`PartitionReassignmentRateAndTimeMs.75thPercentile`||float|-|
|`PartitionReassignmentRateAndTimeMs.95thPercentile`||float|-|
|`PartitionReassignmentRateAndTimeMs.98thPercentile`||float|-|
|`PartitionReassignmentRateAndTimeMs.999thPercentile`||float|-|
|`PartitionReassignmentRateAndTimeMs.99thPercentile`||float|-|
|`PartitionReassignmentRateAndTimeMs.Count`||int|count|
|`PartitionReassignmentRateAndTimeMs.EventType`||string|-|
|`PartitionReassignmentRateAndTimeMs.FifteenMinuteRate`||float|-|
|`PartitionReassignmentRateAndTimeMs.FiveMinuteRate`||float|-|
|`PartitionReassignmentRateAndTimeMs.LatencyUnit`||string|-|
|`PartitionReassignmentRateAndTimeMs.Max`||float|-|
|`PartitionReassignmentRateAndTimeMs.Mean`||float|-|
|`PartitionReassignmentRateAndTimeMs.MeanRate`||float|-|
|`PartitionReassignmentRateAndTimeMs.Min`||float|-|
|`PartitionReassignmentRateAndTimeMs.OneMinuteRate`||float|-|
|`PartitionReassignmentRateAndTimeMs.RateUnit`||string|-|
|`PartitionReassignmentRateAndTimeMs.StdDev`||float|-|
|`PreferredReplicaImbalanceCount.Value`||int|count|
|`ReplicasIneligibleToDeleteCount.Value`||int|count|
|`ReplicasToDeleteCount.Value`||int|count|
|`TopicChangeRateAndTimeMs.50thPercentile`||float|-|
|`TopicChangeRateAndTimeMs.75thPercentile`||float|-|
|`TopicChangeRateAndTimeMs.95thPercentile`||float|-|
|`TopicChangeRateAndTimeMs.98thPercentile`||float|-|
|`TopicChangeRateAndTimeMs.999thPercentile`||float|-|
|`TopicChangeRateAndTimeMs.99thPercentile`||float|-|
|`TopicChangeRateAndTimeMs.Count`||int|count|
|`TopicChangeRateAndTimeMs.EventType`||string|-|
|`TopicChangeRateAndTimeMs.FifteenMinuteRate`||float|-|
|`TopicChangeRateAndTimeMs.FiveMinuteRate`||float|-|
|`TopicChangeRateAndTimeMs.LatencyUnit`||string|-|
|`TopicChangeRateAndTimeMs.Max`||float|-|
|`TopicChangeRateAndTimeMs.Mean`||float|-|
|`TopicChangeRateAndTimeMs.MeanRate`||float|-|
|`TopicChangeRateAndTimeMs.Min`||float|-|
|`TopicChangeRateAndTimeMs.OneMinuteRate`||float|-|
|`TopicChangeRateAndTimeMs.RateUnit`||string|-|
|`TopicChangeRateAndTimeMs.StdDev`||float|-|
|`TopicDeletionRateAndTimeMs.50thPercentile`||float|-|
|`TopicDeletionRateAndTimeMs.75thPercentile`||float|-|
|`TopicDeletionRateAndTimeMs.95thPercentile`||float|-|
|`TopicDeletionRateAndTimeMs.98thPercentile`||float|-|
|`TopicDeletionRateAndTimeMs.999thPercentile`||float|-|
|`TopicDeletionRateAndTimeMs.99thPercentile`||float|-|
|`TopicDeletionRateAndTimeMs.Count`||int|count|
|`TopicDeletionRateAndTimeMs.EventType`||string|-|
|`TopicDeletionRateAndTimeMs.FifteenMinuteRate`||float|-|
|`TopicDeletionRateAndTimeMs.FiveMinuteRate`||float|-|
|`TopicDeletionRateAndTimeMs.LatencyUnit`||string|-|
|`TopicDeletionRateAndTimeMs.Max`||float|-|
|`TopicDeletionRateAndTimeMs.Mean`||float|-|
|`TopicDeletionRateAndTimeMs.MeanRate`||float|-|
|`TopicDeletionRateAndTimeMs.Min`||float|-|
|`TopicDeletionRateAndTimeMs.OneMinuteRate`||float|-|
|`TopicDeletionRateAndTimeMs.RateUnit`||string|-|
|`TopicDeletionRateAndTimeMs.StdDev`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.50thPercentile`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.75thPercentile`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.95thPercentile`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.98thPercentile`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.999thPercentile`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.99thPercentile`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.Count`||int|count|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.EventType`||string|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.FifteenMinuteRate`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.FiveMinuteRate`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.LatencyUnit`||string|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.Max`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.Mean`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.MeanRate`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.Min`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.OneMinuteRate`||float|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.RateUnit`||string|-|
|`TopicUncleanLeaderElectionEnableRateAndTimeMs.StdDev`||float|-|
|`TopicsIneligibleToDeleteCount.Value`||int|count|
|`TopicsToDeleteCount.Value`||int|count|
|`TotalQueueSize.Value`||int|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.50thPercentile`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.75thPercentile`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.95thPercentile`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.98thPercentile`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.999thPercentile`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.99thPercentile`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.Count`||int|count|
|`UncleanLeaderElectionEnableRateAndTimeMs.EventType`||string|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.FifteenMinuteRate`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.FiveMinuteRate`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.LatencyUnit`||string|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.Max`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.Mean`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.MeanRate`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.Min`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.OneMinuteRate`||float|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.RateUnit`||string|-|
|`UncleanLeaderElectionEnableRateAndTimeMs.StdDev`||float|-|
|`UncleanLeaderElectionsPerSec.50thPercentile`||float|-|
|`UncleanLeaderElectionsPerSec.75thPercentile`||float|-|
|`UncleanLeaderElectionsPerSec.95thPercentile`||float|-|
|`UncleanLeaderElectionsPerSec.98thPercentile`||float|-|
|`UncleanLeaderElectionsPerSec.999thPercentile`||float|-|
|`UncleanLeaderElectionsPerSec.99thPercentile`||float|-|
|`UncleanLeaderElectionsPerSec.Count`||int|count|
|`UncleanLeaderElectionsPerSec.EventType`||string|-|
|`UncleanLeaderElectionsPerSec.FifteenMinuteRate`||float|-|
|`UncleanLeaderElectionsPerSec.FiveMinuteRate`||float|-|
|`UncleanLeaderElectionsPerSec.LatencyUnit`||string|-|
|`UncleanLeaderElectionsPerSec.Max`||float|-|
|`UncleanLeaderElectionsPerSec.Mean`||float|-|
|`UncleanLeaderElectionsPerSec.MeanRate`||float|-|
|`UncleanLeaderElectionsPerSec.Min`||float|-|
|`UncleanLeaderElectionsPerSec.OneMinuteRate`||float|-|
|`UncleanLeaderElectionsPerSec.RateUnit`||string|-|
|`UncleanLeaderElectionsPerSec.StdDev`||float|-|
|`UpdateFeaturesRateAndTimeMs.50thPercentile`||float|-|
|`UpdateFeaturesRateAndTimeMs.75thPercentile`||float|-|
|`UpdateFeaturesRateAndTimeMs.95thPercentile`||float|-|
|`UpdateFeaturesRateAndTimeMs.98thPercentile`||float|-|
|`UpdateFeaturesRateAndTimeMs.999thPercentile`||float|-|
|`UpdateFeaturesRateAndTimeMs.99thPercentile`||float|-|
|`UpdateFeaturesRateAndTimeMs.Count`||int|count|
|`UpdateFeaturesRateAndTimeMs.EventType`||string|-|
|`UpdateFeaturesRateAndTimeMs.FifteenMinuteRate`||float|-|
|`UpdateFeaturesRateAndTimeMs.FiveMinuteRate`||float|-|
|`UpdateFeaturesRateAndTimeMs.LatencyUnit`||string|-|
|`UpdateFeaturesRateAndTimeMs.Max`||float|-|
|`UpdateFeaturesRateAndTimeMs.Mean`||float|-|
|`UpdateFeaturesRateAndTimeMs.MeanRate`||float|-|
|`UpdateFeaturesRateAndTimeMs.Min`||float|-|
|`UpdateFeaturesRateAndTimeMs.OneMinuteRate`||float|-|
|`UpdateFeaturesRateAndTimeMs.RateUnit`||string|-|
|`UpdateFeaturesRateAndTimeMs.StdDev`||float|-|



### `kafka_replica_manager`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`AtMinIsrPartitionCount.Value`||int|count|
|`FailedIsrUpdatesPerSec.Count`||int|count|
|`FailedIsrUpdatesPerSec.EventType`||string|-|
|`FailedIsrUpdatesPerSec.FifteenMinuteRate`||float|-|
|`FailedIsrUpdatesPerSec.FiveMinuteRate`||float|-|
|`FailedIsrUpdatesPerSec.MeanRate`||float|-|
|`FailedIsrUpdatesPerSec.OneMinuteRate`||float|-|
|`FailedIsrUpdatesPerSec.RateUnit`||string|-|
|`IsrExpandsPerSec.Count`||int|count|
|`IsrExpandsPerSec.EventType`||string|-|
|`IsrExpandsPerSec.FifteenMinuteRate`||float|-|
|`IsrExpandsPerSec.FiveMinuteRate`||float|-|
|`IsrExpandsPerSec.MeanRate`||float|-|
|`IsrExpandsPerSec.OneMinuteRate`||float|-|
|`IsrExpandsPerSec.RateUnit`||string|-|
|`IsrShrinksPerSec.Count`||int|count|
|`IsrShrinksPerSec.EventType`||string|-|
|`IsrShrinksPerSec.FifteenMinuteRate`||float|-|
|`IsrShrinksPerSec.FiveMinuteRate`||float|-|
|`IsrShrinksPerSec.MeanRate`||float|-|
|`IsrShrinksPerSec.OneMinuteRate`||float|-|
|`IsrShrinksPerSec.RateUnit`||string|-|
|`LeaderCount.Value`||int|count|
|`OfflineReplicaCount.Value`||int|count|
|`PartitionCount.Value`||int|count|
|`ReassigningPartitions.Value`||int|count|
|`UnderMinIsrPartitionCount.Value`||int|count|
|`UnderReplicatedPartitions.Value`||int|count|



### `kafka_purgatory`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`AlterAcls.NumDelayedOperations`||int|-|
|`AlterAcls.PurgatorySize`||int|-|
|`DeleteRecords.NumDelayedOperations`||int|-|
|`DeleteRecords.PurgatorySize`||int|-|
|`ElectLeader.NumDelayedOperations`||int|-|
|`ElectLeader.PurgatorySize`||int|-|
|`Fetch.NumDelayedOperations`||int|-|
|`Fetch.PurgatorySize`||int|-|
|`Heartbeat.NumDelayedOperations`||int|-|
|`Heartbeat.PurgatorySize`||int|-|
|`Produce.NumDelayedOperations`||int|-|
|`Produce.PurgatorySize`||int|-|
|`Rebalance.NumDelayedOperations`||int|-|
|`Rebalance.PurgatorySize`||int|-|
|`topic.NumDelayedOperations`||int|-|
|`topic.PurgatorySize`||int|-|



### `kafka_request`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`LocalTimeMs.50thPercentile`||float|ms|
|`LocalTimeMs.75thPercentile`||float|ms|
|`LocalTimeMs.95thPercentile`||float|ms|
|`LocalTimeMs.98thPercentile`||float|ms|
|`LocalTimeMs.999thPercentile`||float|ms|
|`LocalTimeMs.99thPercentile`||float|ms|
|`LocalTimeMs.Count`||int|count|
|`LocalTimeMs.Max`||float|ms|
|`LocalTimeMs.Mean`||float|ms|
|`LocalTimeMs.Min`||float|ms|
|`LocalTimeMs.StdDev`||float|ms|
|`RemoteTimeMs.50thPercentile`||float|ms|
|`RemoteTimeMs.75thPercentile`||float|ms|
|`RemoteTimeMs.95thPercentile`||float|ms|
|`RemoteTimeMs.98thPercentile`||float|ms|
|`RemoteTimeMs.999thPercentile`||float|ms|
|`RemoteTimeMs.99thPercentile`||float|ms|
|`RemoteTimeMs.Count`||int|count|
|`RemoteTimeMs.Max`||float|ms|
|`RemoteTimeMs.Mean`||float|ms|
|`RemoteTimeMs.Min`||float|ms|
|`RemoteTimeMs.StdDev`||float|ms|
|`RequestBytes.50thPercentile`||float|ms|
|`RequestBytes.75thPercentile`||float|ms|
|`RequestBytes.95thPercentile`||float|ms|
|`RequestBytes.98thPercentile`||float|ms|
|`RequestBytes.999thPercentile`||float|ms|
|`RequestBytes.99thPercentile`||float|ms|
|`RequestBytes.Count`||int|count|
|`RequestBytes.Max`||float|ms|
|`RequestBytes.Mean`||float|ms|
|`RequestBytes.Min`||float|ms|
|`RequestBytes.StdDev`||float|ms|
|`RequestQueueTimeMs.50thPercentile`||float|ms|
|`RequestQueueTimeMs.75thPercentile`||float|ms|
|`RequestQueueTimeMs.95thPercentile`||float|ms|
|`RequestQueueTimeMs.98thPercentile`||float|ms|
|`RequestQueueTimeMs.999thPercentile`||float|ms|
|`RequestQueueTimeMs.99thPercentile`||float|ms|
|`RequestQueueTimeMs.Count`||int|count|
|`RequestQueueTimeMs.Max`||float|ms|
|`RequestQueueTimeMs.Mean`||float|ms|
|`RequestQueueTimeMs.Min`||float|ms|
|`RequestQueueTimeMs.StdDev`||float|ms|
|`ResponseQueueTimeMs.50thPercentile`||float|ms|
|`ResponseQueueTimeMs.75thPercentile`||float|ms|
|`ResponseQueueTimeMs.95thPercentile`||float|ms|
|`ResponseQueueTimeMs.98thPercentile`||float|ms|
|`ResponseQueueTimeMs.999thPercentile`||float|ms|
|`ResponseQueueTimeMs.99thPercentile`||float|ms|
|`ResponseQueueTimeMs.Count`||int|count|
|`ResponseQueueTimeMs.Max`||float|ms|
|`ResponseQueueTimeMs.Mean`||float|ms|
|`ResponseQueueTimeMs.Min`||float|ms|
|`ResponseQueueTimeMs.StdDev`||float|ms|
|`ResponseSendTimeMs.50thPercentile`||float|ms|
|`ResponseSendTimeMs.75thPercentile`||float|ms|
|`ResponseSendTimeMs.95thPercentile`||float|ms|
|`ResponseSendTimeMs.98thPercentile`||float|ms|
|`ResponseSendTimeMs.999thPercentile`||float|ms|
|`ResponseSendTimeMs.99thPercentile`||float|ms|
|`ResponseSendTimeMs.Count`||int|count|
|`ResponseSendTimeMs.Max`||float|ms|
|`ResponseSendTimeMs.Mean`||float|ms|
|`ResponseSendTimeMs.Min`||float|ms|
|`ResponseSendTimeMs.StdDev`||float|ms|
|`ThrottleTimeMs.50thPercentile`||float|ms|
|`ThrottleTimeMs.75thPercentile`||float|ms|
|`ThrottleTimeMs.95thPercentile`||float|ms|
|`ThrottleTimeMs.98thPercentile`||float|ms|
|`ThrottleTimeMs.999thPercentile`||float|ms|
|`ThrottleTimeMs.99thPercentile`||float|ms|
|`ThrottleTimeMs.Count`||int|count|
|`ThrottleTimeMs.Max`||float|ms|
|`ThrottleTimeMs.Mean`||float|ms|
|`ThrottleTimeMs.Min`||float|ms|
|`ThrottleTimeMs.StdDev`||float|ms|
|`TotalTimeMs.50thPercentile`||float|ms|
|`TotalTimeMs.75thPercentile`||float|ms|
|`TotalTimeMs.95thPercentile`||float|ms|
|`TotalTimeMs.98thPercentile`||float|ms|
|`TotalTimeMs.999thPercentile`||float|ms|
|`TotalTimeMs.99thPercentile`||float|ms|
|`TotalTimeMs.Count`||int|count|
|`TotalTimeMs.Max`||float|ms|
|`TotalTimeMs.Mean`||float|ms|
|`TotalTimeMs.Min`||float|ms|
|`TotalTimeMs.StdDev`||float|ms|



### `kafka_topics`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`BytesInPerSec.Count`||int|count|
|`BytesInPerSec.EventType`||string|-|
|`BytesInPerSec.FifteenMinuteRate`||float|-|
|`BytesInPerSec.FiveMinuteRate`||float|-|
|`BytesInPerSec.MeanRate`||float|-|
|`BytesInPerSec.OneMinuteRate`||float|-|
|`BytesInPerSec.RateUnit`||string|-|
|`BytesOutPerSec.Count`||int|count|
|`BytesOutPerSec.EventType`||string|-|
|`BytesOutPerSec.FifteenMinuteRate`||float|-|
|`BytesOutPerSec.FiveMinuteRate`||float|-|
|`BytesOutPerSec.MeanRate`||float|-|
|`BytesOutPerSec.OneMinuteRate`||float|-|
|`BytesOutPerSec.RateUnit`||string|-|
|`BytesRejectedPerSec.Count`||int|count|
|`BytesRejectedPerSec.EventType`||string|-|
|`BytesRejectedPerSec.FifteenMinuteRate`||float|-|
|`BytesRejectedPerSec.FiveMinuteRate`||float|-|
|`BytesRejectedPerSec.MeanRate`||float|-|
|`BytesRejectedPerSec.OneMinuteRate`||float|-|
|`BytesRejectedPerSec.RateUnit`||string|-|
|`FailedFetchRequestsPerSec.Count`||int|count|
|`FailedFetchRequestsPerSec.EventType`||string|-|
|`FailedFetchRequestsPerSec.FifteenMinuteRate`||float|-|
|`FailedFetchRequestsPerSec.FiveMinuteRate`||float|-|
|`FailedFetchRequestsPerSec.MeanRate`||float|-|
|`FailedFetchRequestsPerSec.OneMinuteRate`||float|-|
|`FailedFetchRequestsPerSec.RateUnit`||string|-|
|`FailedProduceRequestsPerSec.Count`||int|count|
|`FailedProduceRequestsPerSec.EventType`||string|-|
|`FailedProduceRequestsPerSec.FifteenMinuteRate`||float|-|
|`FailedProduceRequestsPerSec.FiveMinuteRate`||float|-|
|`FailedProduceRequestsPerSec.MeanRate`||float|-|
|`FailedProduceRequestsPerSec.OneMinuteRate`||float|-|
|`FailedProduceRequestsPerSec.RateUnit`||string|-|
|`FetchMessageConversionsPerSec.Count`||int|count|
|`FetchMessageConversionsPerSec.EventType`||string|-|
|`FetchMessageConversionsPerSec.FifteenMinuteRate`||float|-|
|`FetchMessageConversionsPerSec.FiveMinuteRate`||float|-|
|`FetchMessageConversionsPerSec.MeanRate`||float|-|
|`FetchMessageConversionsPerSec.OneMinuteRate`||float|-|
|`FetchMessageConversionsPerSec.RateUnit`||string|-|
|`InvalidMagicNumberRecordsPerSec.Count`||int|count|
|`InvalidMagicNumberRecordsPerSec.EventType`||string|-|
|`InvalidMagicNumberRecordsPerSec.FifteenMinuteRate`||float|-|
|`InvalidMagicNumberRecordsPerSec.FiveMinuteRate`||float|-|
|`InvalidMagicNumberRecordsPerSec.MeanRate`||float|-|
|`InvalidMagicNumberRecordsPerSec.OneMinuteRate`||float|-|
|`InvalidMagicNumberRecordsPerSec.RateUnit`||string|-|
|`InvalidMessageCrcRecordsPerSec.Count`||int|count|
|`InvalidMessageCrcRecordsPerSec.EventType`||string|-|
|`InvalidMessageCrcRecordsPerSec.FifteenMinuteRate`||float|-|
|`InvalidMessageCrcRecordsPerSec.FiveMinuteRate`||float|-|
|`InvalidMessageCrcRecordsPerSec.MeanRate`||float|-|
|`InvalidMessageCrcRecordsPerSec.OneMinuteRate`||float|-|
|`InvalidMessageCrcRecordsPerSec.RateUnit`||string|-|
|`InvalidOffsetOrSequenceRecordsPerSec.Count`||int|count|
|`InvalidOffsetOrSequenceRecordsPerSec.EventType`||string|-|
|`InvalidOffsetOrSequenceRecordsPerSec.FifteenMinuteRate`||float|-|
|`InvalidOffsetOrSequenceRecordsPerSec.FiveMinuteRate`||float|-|
|`InvalidOffsetOrSequenceRecordsPerSec.MeanRate`||float|-|
|`InvalidOffsetOrSequenceRecordsPerSec.OneMinuteRate`||float|-|
|`InvalidOffsetOrSequenceRecordsPerSec.RateUnit`||string|-|
|`MessagesInPerSec.Count`||int|count|
|`MessagesInPerSec.EventType`||string|-|
|`MessagesInPerSec.FifteenMinuteRate`||float|-|
|`MessagesInPerSec.FiveMinuteRate`||float|-|
|`MessagesInPerSec.MeanRate`||float|-|
|`MessagesInPerSec.OneMinuteRate`||float|-|
|`MessagesInPerSec.RateUnit`||string|-|
|`NoKeyCompactedTopicRecordsPerSec.Count`||int|count|
|`NoKeyCompactedTopicRecordsPerSec.EventType`||string|-|
|`NoKeyCompactedTopicRecordsPerSec.FifteenMinuteRate`||float|-|
|`NoKeyCompactedTopicRecordsPerSec.FiveMinuteRate`||float|-|
|`NoKeyCompactedTopicRecordsPerSec.MeanRate`||float|-|
|`NoKeyCompactedTopicRecordsPerSec.OneMinuteRate`||float|-|
|`NoKeyCompactedTopicRecordsPerSec.RateUnit`||string|-|
|`ProduceMessageConversionsPerSec.Count`||int|count|
|`ProduceMessageConversionsPerSec.EventType`||string|-|
|`ProduceMessageConversionsPerSec.FifteenMinuteRate`||float|-|
|`ProduceMessageConversionsPerSec.FiveMinuteRate`||float|-|
|`ProduceMessageConversionsPerSec.MeanRate`||float|-|
|`ProduceMessageConversionsPerSec.OneMinuteRate`||float|-|
|`ProduceMessageConversionsPerSec.RateUnit`||string|-|
|`ReassignmentBytesInPerSec.Count`||int|count|
|`ReassignmentBytesInPerSec.EventType`||string|-|
|`ReassignmentBytesInPerSec.FifteenMinuteRate`||float|-|
|`ReassignmentBytesInPerSec.FiveMinuteRate`||float|-|
|`ReassignmentBytesInPerSec.MeanRate`||float|-|
|`ReassignmentBytesInPerSec.OneMinuteRate`||float|-|
|`ReassignmentBytesInPerSec.RateUnit`||string|-|
|`ReassignmentBytesOutPerSec.Count`||int|count|
|`ReassignmentBytesOutPerSec.EventType`||string|-|
|`ReassignmentBytesOutPerSec.FifteenMinuteRate`||float|-|
|`ReassignmentBytesOutPerSec.FiveMinuteRate`||float|-|
|`ReassignmentBytesOutPerSec.MeanRate`||float|-|
|`ReassignmentBytesOutPerSec.OneMinuteRate`||float|-|
|`ReassignmentBytesOutPerSec.RateUnit`||string|-|
|`ReplicationBytesInPerSec.Count`||int|count|
|`ReplicationBytesInPerSec.EventType`||string|-|
|`ReplicationBytesInPerSec.FifteenMinuteRate`||float|-|
|`ReplicationBytesInPerSec.FiveMinuteRate`||float|-|
|`ReplicationBytesInPerSec.MeanRate`||float|-|
|`ReplicationBytesInPerSec.OneMinuteRate`||float|-|
|`ReplicationBytesInPerSec.RateUnit`||string|-|
|`ReplicationBytesOutPerSec.Count`||int|count|
|`ReplicationBytesOutPerSec.EventType`||string|-|
|`ReplicationBytesOutPerSec.FifteenMinuteRate`||float|-|
|`ReplicationBytesOutPerSec.FiveMinuteRate`||float|-|
|`ReplicationBytesOutPerSec.MeanRate`||float|-|
|`ReplicationBytesOutPerSec.OneMinuteRate`||float|-|
|`ReplicationBytesOutPerSec.RateUnit`||string|-|
|`TotalFetchRequestsPerSec.Count`||int|count|
|`TotalFetchRequestsPerSec.EventType`||string|-|
|`TotalFetchRequestsPerSec.FifteenMinuteRate`||float|-|
|`TotalFetchRequestsPerSec.FiveMinuteRate`||float|-|
|`TotalFetchRequestsPerSec.MeanRate`||float|-|
|`TotalFetchRequestsPerSec.OneMinuteRate`||float|-|
|`TotalFetchRequestsPerSec.RateUnit`||string|-|
|`TotalProduceRequestsPerSec.Count`||int|count|
|`TotalProduceRequestsPerSec.EventType`||string|-|
|`TotalProduceRequestsPerSec.FifteenMinuteRate`||float|-|
|`TotalProduceRequestsPerSec.FiveMinuteRate`||float|-|
|`TotalProduceRequestsPerSec.MeanRate`||float|-|
|`TotalProduceRequestsPerSec.OneMinuteRate`||float|-|
|`TotalProduceRequestsPerSec.RateUnit`||string|-|



### `kafka_topic`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|
|`topic`|topic name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`BytesInPerSec.Count`||int|count|
|`BytesInPerSec.EventType`||string|-|
|`BytesInPerSec.FifteenMinuteRate`||float|-|
|`BytesInPerSec.FiveMinuteRate`||float|-|
|`BytesInPerSec.MeanRate`||float|-|
|`BytesInPerSec.OneMinuteRate`||float|-|
|`BytesInPerSec.RateUnit`||string|-|
|`BytesOutPerSec.Count`||int|count|
|`BytesOutPerSec.EventType`||string|-|
|`BytesOutPerSec.FifteenMinuteRate`||float|-|
|`BytesOutPerSec.FiveMinuteRate`||float|-|
|`BytesOutPerSec.MeanRate`||float|-|
|`BytesOutPerSec.OneMinuteRate`||float|-|
|`BytesOutPerSec.RateUnit`||string|-|
|`MessagesInPerSec.Count`||int|count|
|`MessagesInPerSec.EventType`||string|-|
|`MessagesInPerSec.FifteenMinuteRate`||float|-|
|`MessagesInPerSec.FiveMinuteRate`||float|-|
|`MessagesInPerSec.MeanRate`||float|-|
|`MessagesInPerSec.OneMinuteRate`||float|-|
|`MessagesInPerSec.RateUnit`||string|-|
|`TotalFetchRequestsPerSec.Count`||int|count|
|`TotalFetchRequestsPerSec.EventType`||string|-|
|`TotalFetchRequestsPerSec.FifteenMinuteRate`||float|-|
|`TotalFetchRequestsPerSec.FiveMinuteRate`||float|-|
|`TotalFetchRequestsPerSec.MeanRate`||float|-|
|`TotalFetchRequestsPerSec.OneMinuteRate`||float|-|
|`TotalFetchRequestsPerSec.RateUnit`||string|-|
|`TotalProduceRequestsPerSec.Count`||int|count|
|`TotalProduceRequestsPerSec.EventType`||string|-|
|`TotalProduceRequestsPerSec.FifteenMinuteRate`||float|-|
|`TotalProduceRequestsPerSec.FiveMinuteRate`||float|-|
|`TotalProduceRequestsPerSec.MeanRate`||float|-|
|`TotalProduceRequestsPerSec.OneMinuteRate`||float|-|
|`TotalProduceRequestsPerSec.RateUnit`||string|-|



### `kafka_partition`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|
|`partition`|partition number|
|`topic`|topic name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`LogEndOffset`||int|-|
|`LogStartOffset`||int|-|
|`NumLogSegments`||int|-|
|`Size`||int|-|
|`UnderReplicatedPartitions`||int|-|



### `kafka_zookeeper`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`ZooKeeperRequestLatencyMs.50thPercentile`||float|ms|
|`ZooKeeperRequestLatencyMs.75thPercentile`||float|ms|
|`ZooKeeperRequestLatencyMs.95thPercentile`||float|ms|
|`ZooKeeperRequestLatencyMs.98thPercentile`||float|ms|
|`ZooKeeperRequestLatencyMs.999thPercentile`||float|ms|
|`ZooKeeperRequestLatencyMs.99thPercentile`||float|ms|
|`ZooKeeperRequestLatencyMs.Count`||int|count|
|`ZooKeeperRequestLatencyMs.Max`||float|ms|
|`ZooKeeperRequestLatencyMs.Mean`||float|ms|
|`ZooKeeperRequestLatencyMs.Min`||float|ms|
|`ZooKeeperRequestLatencyMs.StdDev`||float|ms|



### `kafka_network`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|
|`type`|metric type|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`ControlPlaneExpiredConnectionsKilledCount`||int|count|
|`ExpiredConnectionsKilledCount`||int|count|
|`MemoryPoolAvailable`||int|count|
|`MemoryPoolUsed`||int|count|
|`NetworkProcessorAvgIdlePercent`||float|-|



### `kafka_log`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`jolokia_agent_url`|jolokia agent url path|
|`type`|metric type|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`DeadThreadCount`||int|count|
|`OfflineLogDirectoryCount`||int|count|
|`cleaner_recopy_percent`||float|-|
|`max_buffer_utilization_percent`||float|-|
|`max_clean_time_secs`||int|s|
|`max_compaction_delay_secs`||int|s|



### `kafka_consumer`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`client_id`|client id|
|`jolokia_agent_url`|jolokia agent url path|
|`type`|metric type|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`assigned_partitions`||int|count|
|`bytes_consumed_rate`||float|-|
|`bytes_consumed_total`||int|count|
|`commit_id`||string|-|
|`commit_rate`||float|-|
|`commit_total`||int|count|
|`connection_close_rate`||float|-|
|`connection_close_total`||int|count|
|`connection_count`||int|count|
|`connection_creation_rate`||float|-|
|`connection_creation_total`||int|count|
|`count`||int|count|
|`failed_authentication_rate`||float|-|
|`failed_authentication_total`||int|count|
|`failed_reauthentication_rate`||float|-|
|`failed_reauthentication_total`||int|count|
|`failed_rebalance_rate_per_hour`||float|-|
|`failed_rebalance_total`||float|-|
|`fetch_latency_avg`||float|-|
|`fetch_latency_max`||float|-|
|`fetch_rate`||float|-|
|`fetch_throttle_time_avg`||float|-|
|`fetch_throttle_time_max`||float|-|
|`fetch_total`||float|-|
|`heartbeat_rate`||float|-|
|`heartbeat_response_time_max`||float|-|
|`heartbeat_total`||int|count|
|`incoming_byte_rate`||float|-|
|`incoming_byte_total`||float|-|
|`io_ratio`||float|-|
|`io_time_ns_avg`||int|ns|
|`io_wait_ratio`||float|-|
|`io_wait_time_ns_avg`||int|ns|
|`io_waittime_total`||int|ns|
|`iotime_total`||int|count|
|`join_rate`||float|-|
|`join_total`||int|count|
|`last_heartbeat_seconds_ago`||float|-|
|`last_poll_seconds_ago`||int|count|
|`last_rebalance_seconds_ago`||float|-|
|`network_io_rate`||float|-|
|`network_io_total`||int|count|
|`outgoing_byte_rate`||float|-|
|`outgoing_byte_total`||float|-|
|`rebalance_latency_total`||int|count|
|`rebalance_rate_per_hour`||float|-|
|`rebalance_total`||int|count|
|`records_consumed_rate`||float|-|
|`records_consumed_total`||float|-|
|`request_rate`||float|-|
|`request_size_avg`||float|-|
|`request_size_max`||float|-|
|`request_total`||int|count|
|`response_rate`||float|-|
|`response_total`||int|count|
|`select_rate`||float|-|
|`select_total`||int|count|
|`start_time_ms`||int|msec|
|`successful_authentication_no_reauth_total`||int|count|
|`successful_authentication_rate`||float|-|
|`successful_authentication_total`||int|count|
|`successful_reauthentication_rate`||float|-|
|`successful_reauthentication_total`||int|count|
|`sync_rate`||float|-|
|`sync_total`||int|-|
|`version`||string|-|



### `kafka_producer`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`client_id`|client id|
|`jolokia_agent_url`|jolokia agent url path|
|`type`|metric type|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`batch_split_rate`||float|-|
|`batch_split_total`||int|-|
|`buffer_available_bytes`||int|-|
|`buffer_exhausted_rate`||float|-|
|`buffer_exhausted_total`||float|-|
|`buffer_total_bytes`||int|-|
|`bufferpool_wait_ratio`||float|-|
|`bufferpool_wait_time_total`||int|count|
|`commit_id`||string|-|
|`connection_close_rate`||float|-|
|`connection_close_total`||int|count|
|`connection_count`||int|count|
|`connection_creation_rate`||float|-|
|`connection_creation_total`||int|count|
|`count`||int|count|
|`failed_authentication_rate`||float|-|
|`failed_authentication_total`||int|count|
|`failed_reauthentication_rate`||float|-|
|`failed_reauthentication_total`||int|count|
|`incoming_byte_rate`||float|-|
|`incoming_byte_total`||int|-|
|`io_ratio`||float|-|
|`io_time_ns_avg`||float|ns|
|`io_wait_ratio`||float|-|
|`io_wait_time_ns_avg`||int|ns|
|`io_waittime_total`||int|ns|
|`iotime_total`||int|ns|
|`metadata_age`||float|-|
|`network_io_rate`||float|-|
|`network_io_total`||int|count|
|`outgoing_byte_rate`||float|-|
|`outgoing_byte_total`||int|count|
|`produce_throttle_time_avg`||int|ms|
|`produce_throttle_time_max`||int|ms|
|`record_error_rate`||float|-|
|`record_error_total`||int|-|
|`record_retry_rate`||float|-|
|`record_retry_total`||int|-|
|`record_send_rate`||float|-|
|`record_send_total`||int|count|
|`request_rate`||float|-|
|`request_size_avg`||float|-|
|`request_size_max`||int|-|
|`request_total`||int|count|
|`requests_in_flight`||int|count|
|`response_rate`||float|-|
|`response_total`||int|count|
|`select_rate`||float|-|
|`select_total`||int|count|
|`start_time_ms`||int|msec|
|`successful_authentication_no_reauth_total`||int|count|
|`successful_authentication_rate`||float|-|
|`successful_authentication_total`||int|count|
|`successful_reauthentication_rate`||float|-|
|`successful_reauthentication_total`||int|-|
|`version`||string|-|
|`waiting_threads`||int|count|



### `kafka_connect`

-  标签


| 标签名 | 描述    |
|  ----  | --------|
|`client_id`|client id|
|`connector`|connector|
|`jolokia_agent_url`|jolokia agent url path|
|`task`|task|
|`type`|metric type|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`batch_size_avg`||int|-|
|`batch_size_max`||int|-|
|`commit_id`||string|-|
|`connector_class`||string|-|
|`connector_count`||int|count|
|`connector_destroyed_task_count`||int|count|
|`connector_failed_task_count`||int|count|
|`connector_paused_task_count`||int|count|
|`connector_restarting_task_count`||int|count|
|`connector_running_task_count`||int|count|
|`connector_startup_attempts_total`||int|count|
|`connector_startup_failure_percentage`||float|-|
|`connector_startup_failure_total`||int|count|
|`connector_startup_success_percentage`||float|-|
|`connector_startup_success_total`||int|count|
|`connector_total_task_count`||int|count|
|`connector_type`||string|-|
|`connector_unassigned_task_count`||int|count|
|`connector_version`||string|-|
|`count`||int|count|
|`deadletterqueue_produce_failures`||int|count|
|`deadletterqueue_produce_requests`||int|count|
|`last_error_timestamp`|The epoch timestamp when this task last encountered an error in millisecond.|int|msec|
|`offset_commit_avg_time_ms`||float|ms|
|`offset_commit_completion_rate`||float|-|
|`offset_commit_completion_total`||int|count|
|`offset_commit_failure_percentage`||float|-|
|`offset_commit_max_time_ms`||float|ms|
|`offset_commit_seq_no`||int|-|
|`offset_commit_skip_rate`||float|-|
|`offset_commit_skip_total`||int|count|
|`offset_commit_success_percentage`||float|-|
|`partition_count`||int|count|
|`pause_ratio`||float|-|
|`put_batch_avg_time_ms`||float|ms|
|`put_batch_max_time_ms`||float|ms|
|`running_ratio`||float|-|
|`sink_record_active_count`||int|count|
|`sink_record_active_count_avg`||int|count|
|`sink_record_active_count_max`||int|count|
|`sink_record_read_rate`||float|-|
|`sink_record_read_total`||int|count|
|`sink_record_send_rate`||float|-|
|`sink_record_send_total`||int|count|
|`source_record_active_count`||int|count|
|`source_record_poll_rate`||float|-|
|`source_record_poll_total`||int|count|
|`source_record_write_rate`||float|-|
|`source_record_write_total`||int|count|
|`start_time_ms`||int|msec|
|`status`||string|-|
|`task_count`||int|count|
|`task_startup_attempts_total`||int|count|
|`task_startup_failure_percentage`||float|-|
|`task_startup_failure_total`||int|count|
|`task_startup_success_percentage`||float|-|
|`task_startup_success_total`||int|count|
|`total_errors_logged`||int|count|
|`total_record_errors`||int|count|
|`total_record_failures`||int|count|
|`total_records_skipped`||int|count|
|`total_retries`||int|count|
|`version`||string|-|




## 日志采集

如需采集 Kafka 的日志，可在 kafka.conf 中 将 `files` 打开，并写入 kafka 日志文件的绝对路径。比如：

```toml
[[inputs.kafka]]
  ...
  [inputs.kafka.log]
    files = ["/usr/local/var/log/kafka/error.log","/usr/local/var/log/kafka/kafka.log"]
```


开启日志采集以后，默认会产生日志来源（`source`）为 `kafka` 的日志。

>注意：必须将 DataKit 安装在 Kafka 所在主机才能采集 Kafka 日志

切割日志示例：

```
[2020-07-07 15:04:29,333] DEBUG Progress event: HTTP_REQUEST_COMPLETED_EVENT, bytes: 0 (io.confluent.connect.s3.storage.S3OutputStream:286)
```

切割后的字段列表如下：

| 字段名 | 字段值                                                 |
| ------ | ------------------------------------------------------ |
| msg    | Progress event: HTTP_REQUEST_COMPLETED_EVENT, bytes: 0 |
| name   | io.confluent.connect.s3.storage.S3OutputStream:286     |
| status | DEBUG                                                  |
| time   | 1594105469333000000                                    |

## 场景视图

<场景 - 新建场景 - kafka 监控场景>

## 异常检测

<异常检测库 - 新建检测库 - kafka 检测库>
