---
title     : 'RocketMQ'
summary   : 'Collect RocketMQ related Metrics information'
__int_icon: 'icon/rocketmq'
dashboard :
  - desc  : 'RocketMQ Monitoring View'
    path  : 'dashboard/en/rocketmq'
monitor   :
  - desc  : 'RocketMQ Detection Library'
    path  : 'monitor/en/rocketmq'
---

<!-- markdownlint-disable MD025 -->
# RocketMQ
<!-- markdownlint-enable -->

RocketMQ Metrics display, including producer TPS/message size, consumer TPS/message size, message backlog, topic information, etc.


## Installation and Configuration {#config}

Note: The example Linux version is CentOS Linux release 7.8.2003 (Core). For Windows versions, please modify the corresponding configuration files.

- Supported operating systems: Linux / Windows

- Install `rocketmq-exporter` on the server

### Install exporter

- Pull `rocketmq-exporter`

```shell
git clone https://github.com/apache/rocketmq-exporter.git
```

- Enter the installation directory

```shell
cd rocketmq-exporter/
```

- Build the installation package (choose either one)

(1) Build jar package method  

```shell
mvn clean install
```

After building, enter the target directory

```shell
cd target
```

Start the jar package (replace the `nameserverip` address in the command line)

```shell
nohup java -jar target/rocketmq-exporter-0.0.2-SNAPSHOT.jar --rocketmq.config.namesrvAddr=nameserverip:9876 &
```

(2) Build Docker image method

```shell
mvn package -Dmaven.test.skip=true docker:build
```

Start Docker using the image (replace the `nameserverip` address in the command line)

```shell
docker run -d --net="host" --name rocketmq-exporter -p 5557:5557 docker.io/rocketmq-exporter --rocketmq.config.namesrvAddr=nameserverip:9876
```

- Test if `rocketmq-exporter` is working properly

```shell
curl http://127.0.0.1:5557/metrics
```

### Metrics Collection

- Enable DataKit Prometheus plugin and copy the sample file

```shell
cd /usr/local/datakit/conf.d/prom
cp prom.conf.sample prom.conf
```

- Modify the configuration file `prom.conf`

Main parameter description:

- urls: Exporter addresses, it's recommended to use internal network addresses; public network can be used for remote collection.
- ignore_req_err: Ignore request errors for URLs.
- source: Collector alias.
- metrics_types: By default, only counter and gauge types of Metrics are collected.
- interval: Collection frequency.

```toml
[[inputs.prom]]
  urls = ["http://127.0.0.1:5557/metrics"]
  ignore_req_err = false
  source = "prom"
# metric_types needs to be empty as rocketmq-exporter does not specify data types
  metric_types = []
  interval = "60s"
```


Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metrics {#metric}

| Metric | Description | Data Type |
| --- | --- | --- |
| `rocketmq_broker_tps` | Number of messages produced per second by the broker | int |
| `rocketmq_broker_qps` | Number of messages consumed per second by the broker | int |
| `rocketmq_producer_tps` | Number of messages produced per second for a specific topic | int |
| `rocketmq_producer_put_size` | Message size (in bytes) produced per second for a specific topic | int |
| `rocketmq_producer_offset` | Progress of message production for a specific topic | int |
| `rocketmq_consumer_tps` | Number of messages consumed per second by a specific consumer group | int |
| `rocketmq_consumer_get_size` | Message size (in bytes) consumed per second by a specific consumer group | int |
| `rocketmq_consumer_offset` | Progress of message consumption by a specific consumer group | int |
| `rocketmq_group_get_latency_by_storetime` | Consumption delay time for a specific consumer group | int |
| `rocketmq_message_accumulati` | Message backlog quantity | int |


## Further Reading {#doc}

[RocketMQ Exporter Git Code](https://github.com/apache/rocketmq-exporter)