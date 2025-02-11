---
title     : 'RocketMQ'
summary   : 'Collect RocketMQ related Metrics information'
__int_icon: 'icon/rocketmq'
dashboard :
  - desc  : 'RocketMQ monitoring View'
    path  : 'dashboard/en/rocketmq'
monitor   :
  - desc  : 'RocketMQ detection library'
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

- Navigate to the installation directory

```shell
cd rocketmq-exporter/
```

- Build the installation package (choose one of the two options)

(1) Build JAR file

```shell
mvn clean install
```

After building, navigate to the target directory

```shell
cd target
```

Start the JAR file (replace `nameserverip` with the actual address)

```shell
nohup java -jar target/rocketmq-exporter-0.0.2-SNAPSHOT.jar --rocketmq.config.namesrvAddr=nameserverip:9876 &
```

(2) Build Docker image

```shell
mvn package -Dmaven.test.skip=true docker:build
```

Run Docker using the image (replace `nameserverip` with the actual address)

```shell
docker run -d --net="host" --name rocketmq-exporter -p 5557:5557 docker.io/rocketmq-exporter --rocketmq.config.namesrvAddr=nameserverip:9876
```

- Test if `rocketmq-exporter` is running correctly

```shell
curl http://127.0.0.1:5557/metrics
```

### Metrics Collection

- Enable the DataKit Prometheus plugin and copy the sample file

```shell
cd /usr/local/datakit/conf.d/prom
cp prom.conf.sample prom.conf
```

- Modify the configuration file `prom.conf`

Key parameters explanation:

- urls: exporter address, it's recommended to use an internal network address; for remote collection, you can use a public IP
- ignore_req_err: ignore request errors to URLs
- source: collector alias
- metrics_types: by default, only collect counter and gauge types of Metrics
- interval: collection frequency

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
| `rocketmq_broker_tps` | Number of messages produced per second by broker | int |
| `rocketmq_broker_qps` | Number of messages consumed per second by broker | int |
| `rocketmq_producer_tps` | Number of messages produced per second for a specific topic | int |
| `rocketmq_producer_put_size` | Size of messages produced per second for a specific topic (bytes) | int |
| `rocketmq_producer_offset` | Progress of message production for a specific topic | int |
| `rocketmq_consumer_tps` | Number of messages consumed per second by a specific consumer group | int |
| `rocketmq_consumer_get_size` | Size of messages consumed per second by a specific consumer group (bytes) | int |
| `rocketmq_consumer_offset` | Progress of message consumption by a specific consumer group | int |
| `rocketmq_group_get_latency_by_storetime` | Consumption delay time for a specific consumer group | int |
| `rocketmq_group_diff` | Message backlog | int |

## Further Reading {#doc}

[RocketMQ Exporter Git Code](https://github.com/apache/rocketmq-exporter)