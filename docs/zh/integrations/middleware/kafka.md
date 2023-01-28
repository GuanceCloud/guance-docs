---
icon: integrations/kafka
---
# Kafka
---

## 视图预览

### 场景视图

Kafka 观测场景主要展示了 Kafka 的基础信息、topic 信息和性能信息。

![image](../imgs/input-kafka-1.png)

## 版本支持

操作系统支持：Linux

## 前置条件

- 服务器 <[安装 DataKit](../../datakit/datakit-install.md)>，安装完成后可使用 /usr/local/datakit/data/jolokia-jvm-agent.jar。也可以自行下载  [Jolokia](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-jvm/1.6.2/jolokia-jvm-1.6.2-agent.jar)。
- 服务器部署 Kafka。本示例使用单机版 Kafka 且与 DataKit 部署在一台服务器上。

## 安装部署

说明：示例 Kafka 版本为 kafka_2.12-2.2.0 (CentOS 7.9)，不同版本指标可能存在差异。

### 指标采集 (必选)

1、 开启 DataKit Kafka 采集器

登录服务器，执行如下命令。

```bash
cd /usr/local/datakit/conf.d/db
cp kafka.conf.sample kafka.conf
```

2、 修改 `kafka.conf` 配置文件

编辑 kafka.conf 文件，根据实际情况进行修改，比如想修改 jolokia 的指标上报端口，就需要修改 urls 参数中的 8080 端口为您指定的端口。本示例未做任何修改。

```bash
vi kafka.conf
```

参数说明

- default_tag_prefix：设置默认tag前缀(默认为空)
- default_field_prefix：设置默认field前缀(默认为空)
- default_field_separator：设置默认field分割(默认为".")
- username：要采集的 kafka 的用户名
- password：要采集的 kafka 的密码
- response_timeout：超时时间
- interval：采集指标频率
- urls：jolokia的地址

```yaml
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

3、 重启 DataKit (如果需要开启日志，请配置日志采集再重启)

```bash
systemctl restart datakit
```

4、 Kafka 开启 JMX

停止 Kafka，进入 Kafka 安装目录，编辑 bin 目录下的 kafka-server-start.sh 文件，增加如下内容。这里的 jolokia-jvm-agent.jar 可以换成下载的 jar。
host 后面是 DataKit 地址，由于部署在同一台服务器，这里使用了 127.0.0.1，port 指定的 8080 需要与 DataKit 开通 Kafka 采集器配置文件中的 urls 指定的端口对应。 

```bash
export KAFKA_JMX_OPTS="-javaagent:/usr/local/datakit/data/jolokia-jvm-agent.jar=host=127.0.0.1,port=8080"
```

![image](../imgs/input-kafka-6.png)

返回安装目录，执行命令启动 Kafka。

```bash
nohup ./bin/kafka-server-start.sh config/server.properties &  
```

注意在不重启 Kafka 的情况下，可以根据 Kafka 的 PID，使用如下命令进行指标采集。

```bash
java -jar /usr/local/datakit/data/jolokia-jvm-agent.jar --host 127.0.0.1 --port=8080 start <Kafka-PID>
```

5、 指标预览

![image](../imgs/input-kafka-3.jpg)

### 日志采集 (非必选)

1、 修改 `kafka.conf` 配置文件

参数说明

- files：日志文件路径 (通常填写访问日志和错误日志，日志文件在 Kafka 安装目录的 logs 目录下)
- pipeline：日志切割文件(已内置)，实际文件路径 /usr/local/datakit/pipeline/kafka.p
- 相关文档 <[DataFlux pipeline 文本数据处理](../../datakit/pipeline.md)>

```
[inputs.kafka.log]
  files = ["/usr/local/kafka/logs/server.log",
    "/usr/local/kafka/logs/controller.log"
  ]
```

2、 重启 DataKit (如果需要开启自定义标签，请配置插件标签再重启)

```
systemctl restart datakit
```

3、 日志预览

![image](../imgs/input-kafka-5.png)

### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Kafka 指标都会带有 host = "69.230.236.16" 的标签，这样在视图中主机名即是这个 IP，如不加此标签，默认主机名是服务器的名称。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>
- 
```
# 示例
  [inputs.kafka.tags]
    host = "69.230.236.16"
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

重启 DataKit

```
systemctl restart datakit
```

## 场景视图

<场景 - 新建仪表板 - 系统视图 - Kafka 监控视图>

## 检测库

暂无

## [指标详解](../../../datakit/kafka#measurements)


## 最佳实践

<[Kafka 可观测最佳实践](../../best-practices/monitoring/kafka)>

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>

