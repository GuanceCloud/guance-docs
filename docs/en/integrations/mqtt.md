---
title     : 'MQTT'
summary   : 'Receive MQTT protocol data'
__int_icon: 'icon/mqtt'
---

MQTT (Message Queuing Telemetry Transport, message queue telemetry transport protocol) is a lightweight, publish/subscribe-based messaging transport protocol designed for low-bandwidth, high-latency, or unreliable network environments. It is widely used in the Internet of Things (IoT), mobile applications, and distributed systems to achieve efficient communication between devices. By reducing data transmission volume and simplifying communication processes, it ensures reliable message delivery while supporting multiple Quality of Service (QoS) levels to meet different business needs.

## Installation and Configuration {#config}

- [x] MQTT Broker

Guance supports receiving MQTT protocol data through Func.

### Install Func

We recommend enabling Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version

FUNC has already implemented integration with MQTT data sources. Follow these steps to connect:

- 1 Write Script

Write a script in Func to consume MQTT data.

```python
import json

@DFF.API('Message Handler')
def message_handler(topic, message):
    print(f"Received message: {message} on topic {topic}")
```

After writing the script, click the 【Publish】 button.

![Img](./imgs/mqtt-code.png)

- 2 Configure MQTT Connector

① Select type as `MQTT Broker (v5.0)`

② Fill in ID, host, port

③ Topic and corresponding script for topic consumption

④ Click test connectivity to ensure MQTT can connect normally

⑤ Click save to complete

![Img](./imgs/mqtt-func-config.png)