---
title     : 'MQTT'
summary   : 'Receive MQTT protocol data'
__int_icon: 'icon/mqtt'
---

MQTT (Message Queuing Telemetry Transport, a messaging transport protocol based on the publish/subscribe model) is a lightweight messaging transfer protocol specifically designed for low-bandwidth, high-latency, or unreliable network environments. It is widely used in Internet of Things (IoT), mobile applications, and distributed systems to achieve efficient communication between devices. By reducing the amount of data transmitted and simplifying the communication process, it ensures reliable message transmission and supports multiple Quality of Service (QoS) levels to meet different business needs.

## Installation Configuration {#config}

- [x] MQTT Broker

<<< custom_key.brand_name >>> supports receiving MQTT protocol data through Func.

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version

FUNC has already implemented the connection with the MQTT data source. Follow these steps to integrate:

- 1. Write a script

Write a script in Func to consume MQTT data.

```python
import json

@DFF.API('Message Handler')
def message_handler(topic, message):
    print(f"Received message: {message} on topic {topic}")

```

After writing the script, click the 【Publish】 button.

![Img](./imgs/mqtt-code.png)


- 2. Configure the MQTT connector

① Select type as `MQTT Broker (v5.0)`

② Fill in the ID, host, and port

③ Topic and corresponding script for topic consumption

④ Click to test connectivity to ensure MQTT can connect properly

⑤ Click save when done

![Img](./imgs/mqtt-func-config.png)