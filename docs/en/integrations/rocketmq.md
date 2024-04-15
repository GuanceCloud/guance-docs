---
title     : 'RocketMQ'
summary   : 'Collect RocketMQ related index information'
__int_icon: 'icon/rocketmq'
dashboard :
  - desc  : 'RocketMQ Monitoring View'
    path  : 'dashboard/zh/rocketmq'
monitor   :
  - desc  : 'RocketMQ Detection Library'
    path  : 'monitor/zh/rocketmq'
---


<!-- markdownlint-disable MD025 -->
# RocketMQ
<!-- markdownlint-enable -->

RocketMQ metric display, including producer TPS/message size, consumer TPS/message size, message stacking, topic information, etc.


## Configuration {#config}

Note: The example Linux version is CentOS Linux release 7.8.2003 (Core), Windows version please modify the corresponding configuration file

- Operating system support: Linux / Windows

- Server Installation `rocketmq-exporter`

### Install exporter

- Pull `rocketmq-exporter`

```shell
git clone https://github.com/apache/rocketmq-exporter.git
```

- Enter the installation directory

```shell
cd rocketmq-exporter/
```

- Build the installation package (2 choose 1)

(1) How to build jar packages

```shell
mvn clean install
```

Build complete, enter target directory

```shell
cd target
```

Launch jar package (replace `nameserverip` address on command line)

```shell
nohup java -jar target/rocketmq-exporter-0.0.2-SNAPSHOT.jar --rocketmq.config.namesrvAddr=nameserverip:9876 &
```

(2) Docker mirroring

```shell
mvn package -Dmaven.test.skip=true docker:build
```

Start Docker using mirroring (replace `nameserverip` address on command line)

```shell
docker run -d --net="host" --name rocketmq-exporter -p 5557:5557 docker.io/rocketmq-exporter --rocketmq.config.namesrvAddr=nameserverip:9876
```

- Test if `rocketmq-exporter` is normal

```shell
curl http://127.0.0.1:5557/metrics
```

### Metric Collection

- Open the DataKit Prometheus plug-in and copy the sample file

```shell
cd /usr/local/datakit/conf.d/prom
cp prom.conf.sample prom.conf
```

- Modify the configuration file `prom.conf`

Description of main parameters

- `urls`:exporter address, recommended to fill in Intranet address, remote collection can use public network
- `ignore_req_err`: Ignore request errors for URLs
- `source`: collector alias
- `metrics_types`: only counter and gauge type metrics are collected by default
- `interval`: acquisition frequency

```toml
[[inputs.prom]]
  urls = ["http://127.0.0.1:5557/metrics"]
  ignore_req_err = false
  source = "prom"
  metric_types = []
  interval = "60s"
```


Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

## Metric {#metric}

| Metric | Description | Data type|
| --- | --- | --- |
| `rocketmq_broker_tps`| broker produce message count | int |
| `rocketmq_broker_qps`| broker consume message count | int |
| `rocketmq_producer_tps`| topic produce message count | int |
| `rocketmq_producer_put_size`| topic produce message bytes | int |
| `rocketmq_producer_offset`| topic produce message offset | int |
| `rocketmq_consumer_tps`| topic consume message count | int |
| `rocketmq_consumer_get_size`| topic consume message bytes | int |
| `rocketmq_consumer_offset`| topic consume message offset | int |
| `rocketmq_group_get_latency_by_storetime`| The consumption delay time of a certain consumption group | int |
| `rocketmq_message_accumulati`| Message Stacking Volume | int |


## Doc {#doc}

[RocketMQ Exporter Git Code](https://github.com/apache/rocketmq-exporter )


