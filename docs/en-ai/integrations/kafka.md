---
title     : 'Kafka'
summary   : 'Collect Kafka Metrics Data'
tags:
  - 'Middleware'
  - 'Message Queue'
__int_icon      : 'icon/kafka'
dashboard :
  - desc  : 'Kafka'
    path  : 'dashboard/en/kafka'
monitor   :
  - desc  : 'Kafka'
    path  : 'monitor/en/kafka'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

Collect Kafka metrics and log data into Guance, helping you monitor and analyze various anomalies in Kafka.

## Configuration {#config}

### Prerequisites {#requirements}

Install or download [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.2/jolokia-jvm-1.6.2-agent.jar){:target="_blank"}. The Jolokia jar file is already downloaded under the `data` directory of the DataKit installation directory.

Jolokia acts as a Java agent for Kafka, providing an external interface that uses JSON as the data format over HTTP protocol for use by DataKit. When starting Kafka, configure the `KAFKA_OPTS` environment variable first (the port can be modified to an available port according to actual conditions):

```shell
export KAFKA_OPTS="$KAFKA_OPTS -javaagent:/usr/local/datakit/data/jolokia-jvm-agent.jar=host=*,port=8080"
```

Alternatively, you can start Jolokia separately and point it to the Kafka process PID:

```shell
java -jar </path/to/jolokia-jvm-agent.jar> --host 127.0.0.1 --port=8080 start <Kafka-PID>
```

<!-- markdownlint-disable MD046 -->

???+ attention

    Jolokia does not allow changing the port number during runtime. If you find that the `--port` command cannot change the port number, this is the reason.

    To modify the Jolokia port number, you must exit Jolokia and then restart it to succeed.

???+ tip

    The command to exit Jolokia is: `java -jar </path/to/jolokia-jvm-agent.jar> --quiet stop <Kafka-PID>`

    For more information on Jolokia commands, refer to [here](https://jolokia.org/reference/html/agents.html#jvm-agent){:target="_blank"}.

<!-- markdownlint-enable -->

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/db` directory under the DataKit installation directory, copy `kafka.conf.sample`, and rename it to `kafka.conf`. An example is shown below:
    
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

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector via [ConfigMap injection method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Metrics {#metric}

All collected data will append global election tags by default, or you can specify other tags in the configuration using `[inputs.kafka.tags]`:

``` toml
 [inputs.kafka.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `kafka_controller`

In Kafka cluster mode, a unique controller node will be elected, and only the controller node will receive valid metrics.

- Tags


| Tag | Description |
|  ----  | --------|
|`jolokia_agent_url`|Jolokia agent url path|

- Metrics List


| Metric | Description | Type | Unit |
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



- Tags


| Tag | Description |
|  ----  | --------|
|`jolokia_agent_url`|Jolokia agent url path|

- Metrics List


| Metric | Description | Type | Unit |
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
|`IsrExpandsPerSec.FifteenMinuteRate`||float|-