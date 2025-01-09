---
title     : 'RocketMQ'
summary   : '采集 RocketMQ 相关指标信息'
__int_icon: 'icon/rocketmq'
dashboard :
  - desc  : 'RocketMQ 监控视图'
    path  : 'dashboard/zh/rocketmq'
monitor   :
  - desc  : 'RocketMQ 检测库'
    path  : 'monitor/zh/rocketmq'
---

<!-- markdownlint-disable MD025 -->
# RocketMQ
<!-- markdownlint-enable -->

RocketMQ 指标展示，包括生产者 TPS/消息大小、消费者 TPS/消息大小、消息堆积、topic 信息等


## 安装配置 {#config}

说明：示例 Linux 版本为 CentOS Linux release 7.8.2003 (Core)，Windows 版本请修改对应的配置文件

- 操作系统支持：Linux / Windows

- 服务器安装 `rocketmq-exporter`

### 安装 exporter

- 拉取 `rocketmq-exporter`

```shell
git clone https://github.com/apache/rocketmq-exporter.git
```

- 进入安装目录

```shell
cd rocketmq-exporter/
```

- 构建安装包 (2选1即可)

（1）构建 jar 包方式  

```shell
mvn clean install
```

构建完成，进入 target 目录

```shell
cd target
```

启动 jar 包 (替换命令行中 `nameserverip` 地址)

```shell
nohup java -jar target/rocketmq-exporter-0.0.2-SNAPSHOT.jar --rocketmq.config.namesrvAddr=nameserverip:9876 &
```

（2）构建 Docker 镜像方式

```shell
mvn package -Dmaven.test.skip=true docker:build
```

使用镜像启动 Docker (替换命令行中 `nameserverip` 地址)

```shell
docker run -d --net="host" --name rocketmq-exporter -p 5557:5557 docker.io/rocketmq-exporter --rocketmq.config.namesrvAddr=nameserverip:9876
```

- 测试 `rocketmq-exporter` 是否正常

```shell
curl http://127.0.0.1:5557/metrics
```

### 指标采集

- 开启 DataKit Prometheus 插件，复制 sample 文件

```shell
cd /usr/local/datakit/conf.d/prom
cp prom.conf.sample prom.conf
```

- 修改配置文件 `prom.conf`

主要参数说明

- urls：exporter 地址，建议填写内网地址，远程采集可使用公网
- ignore_req_err：忽略对 url 的请求错误
- source：采集器别名
- metrics_types：默认只采集 counter 和 gauge 类型的指标
- interval：采集频率

```toml
[[inputs.prom]]
  urls = ["http://127.0.0.1:5557/metrics"]
  ignore_req_err = false
  source = "prom"
# metric_types 需要选择空，rocketmq-exporter 没有指定数据类型
  metric_types = []
  interval = "60s"
```


重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)

## 指标 {#metric}

| 指标 | 描述 | 数据类型 |
| --- | --- | --- |
| `rocketmq_broker_tps` | broker每秒生产消息数量 | int |
| `rocketmq_broker_qps` | broker每秒消费消息数量 | int |
| `rocketmq_producer_tps` | 某个topic每秒生产的消息数量 | int |
| `rocketmq_producer_put_size` | 某个topic每秒生产的消息大小(字节) | int |
| `rocketmq_producer_offset` | 某个topic的生产消息的进度 | int |
| `rocketmq_consumer_tps` | 某个消费组每秒消费的消息数量 | int |
| `rocketmq_consumer_get_size` | 某个消费组每秒消费的消息大小(字节) | int |
| `rocketmq_consumer_offset` | 某个消费组的消费消息的进度 | int |
| `rocketmq_group_get_latency_by_storetime` | 某个消费组的消费延时时间 | int |
| `rocketmq_group_diff` | 消息堆积量 | int |


## 进一步阅读 {#doc}

[RocketMQ Exporter Git 代码](https://github.com/apache/rocketmq-exporter)


