---
title     : 'MQTT'
summary   : '接收 MQTT 协议数据'
__int_icon: 'icon/mqtt'
---

MQTT（Message Queuing Telemetry Transport，消息队列遥测传输协议）是一种轻量级的、基于发布/订阅模式的消息传输协议，专为低带宽、高延迟或不可靠的网络环境设计，广泛应用于物联网（IoT）、移动应用和分布式系统中，用于实现设备之间的高效通信。它通过减少数据传输量和简化通信流程，确保消息的可靠传输，同时支持多种服务质量（QoS）等级，以满足不同的业务需求。

## 安装配置 {#config}

- [x] MQTT 代理（Broker）

观测云支持通过 Func 来接收 MQTT 协议的数据。

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署 GSE 版

FUNC 已经实现了 MQTT 数据源的对接，按照以下步骤接入即可

- 1 编写脚本

在 Func 上编写脚本，用于消费 MQTT 的数据

```python
import json

@DFF.API('Message Handler')
def message_handler(topic, message):
    print(f"Received message: {message} on topic {topic}")

```

编写完脚本后，点击【发布】按钮即可。

![Img](./imgs/mqtt-code.png)


- 2 配置 MQTT 连接器

①选择类型为`MQTT Broker (v5.0)`

②填写 ID、主机、端口

③主题以及对应主题消费的脚本

④点击测试连通性，确保 MQTT 可以正常链接

⑤点击保存即可

![Img](./imgs/mqtt-func-config.png)

