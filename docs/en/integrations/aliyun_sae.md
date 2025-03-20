---
title: 'Alibaba Cloud SAE'
tags: 
  - Alibaba Cloud
summary: 'Collect Metrics, Logs, and Traces from Alibaba Cloud SAE (Serverless App Engine)'
__int_icon: 'icon/aliyun_sae'
dashboard:
  - desc: 'Alibaba Cloud SAE Monitoring View'
    path: 'dashboard/en/aliyun_sae/'
monitor:
  - desc: 'Alibaba Cloud SAE Monitor'
    path: 'monitor/en/aliyun_sae/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud SAE
<!-- markdownlint-enable -->

Collect metrics, logs, and traces from Alibaba Cloud SAE (Serverless App Engine).


## Configuration {#config}

Applications deployed on SAE can be integrated with trace, metric, and log data through the following process:

![img](./imgs/aliyun_sae_01.png)

- Applications send Trace data to DataKit by integrating APM.
- Application log data can be collected via KafkaMQ and then consumed by DataKit.
- Application container metrics are gathered using Alibaba Cloud's monitoring API and reported to Guance through the Function platform (DataFlux Func).
- After DataKit collects the corresponding data, it processes and reports it to Guance.

Note: Deploying DataKit on SAE can save bandwidth.

### Create a DataKit Application

Create a DataKit application on SAE:

- Go to SAE, click Application List - Create Application.
- Fill in the application information:
    - Application Name
    - Select a namespace; if none exists, create one.
    - Select VPC; if none exists, create one.
    - Select security group: vswitch must match NAT switch.
    - Adjust instance count as needed.
    - CPU 1 core, memory 1G.
    - After completion, click Next.
- Add image: pubrepo.guance.com/datakit/datakit:1.31.0
- Add environment variables with the following configuration:

```json
{
  "ENV_DATAWAY": "https://openway.guance.com?token=tkn_xxx",
  "KAFKAMQ": "# {\"version\": \"1.22.7-1510\", \"desc\": \"do NOT edit this line\"}\n\n[[inputs.kafkamq]]\n  # addrs = [\"alikafka-serverless-cn-8ex3y7ciq02-1000.alikafka.aliyuncs.com:9093\",\"alikafka-serverless-cn-8ex3y7ciq02-2000.alikafka.aliyuncs.com:9093\",\"alikafka-serverless-cn-8ex3y7ciq02-3000.alikafka.aliyuncs.com:9093\"]\n  addrs = [\"alikafka-serverless-cn-8ex3y7ciq02-1000-vpc.alikafka.aliyuncs.com:9092\",\"alikafka-serverless-cn-8ex3y7ciq02-2000-vpc.alikafka.aliyuncs.com:9092\",\"alikafka-serverless-cn-8ex3y7ciq02-3000-vpc.alikafka.aliyuncs.com:9092\"]\n  # your kafka version:0.8.2 ~ 3.2.0\n  kafka_version = \"3.3.1\"\n  group_id = \"datakit-group\"\n  # consumer group partition assignment strategy (range, roundrobin, sticky)\n  assignor = \"roundrobin\"\n\n  ## kafka tls config\n   tls_enable = false\n\n  ## -1:Offset Newest, -2:Offset Oldest\n  offsets=-1\n\n\n  ## user custom message with PL script.\n  [inputs.kafkamq.custom]\n    #spilt_json_body = true\n    ## spilt_topic_map determines whether to enable log splitting for specific topic based on the values in the spilt_topic_map[topic].\n    #[inputs.kafkamq.custom.spilt_topic_map]\n     # \"log_topic\"=true\n     # \"log01\"=false\n    [inputs.kafkamq.custom.log_topic_map]\n      \"springboot-server_log\"=\"springboot_log.p\"\n    #[inputs.kafkamq.custom.metric_topic_map]\n    #  \"metric_topic\"=\"metric.p\"\n    #  \"metric01\"=\"rum_apm.p\"\n    #[inputs.kafkamq.custom.rum_topic_map]\n    #  \"rum_topic\"=\"rum_01.p\"\n    #  \"rum_02\"=\"rum_02.p\"\n",
  "SPRINGBOOT_LOG_P": "abc = load_json(_)\n\nadd_key(file, abc[\"file\"])\n\nadd_key(message, abc[\"message\"])\nadd_key(host, abc[\"host\"])\nmsg = abc[\"message\"]\ngrok(msg, \"%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\\\[%{NOTSPACE:method_name},%{NUMBER:line}\\\\] %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}\")\n\nadd_key(topic, abc[\"topic\"])\n\ndefault_time(time,\"Asia/Shanghai\")",
  "ENV_GLOBAL_HOST_TAGS": "host=__datakit_hostname,host_ip=__datakit_ip",
  "ENV_HTTP_LISTEN": "0.0.0.0:9529",
  "ENV_DEFAULT_ENABLED_INPUTS": "dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace,statsd,profile"
}
```

Configuration details:

1. ENV_DATAWAY: Required, gateway address for reporting to Guance.
2. KAFKAMQ: Optional, kafkamq collector configuration, refer to: Kafka Collector Configuration File Introduction.
3. SPRINGBOOT_LOG_P: Optional, used together with KAFKAMQ, log pipeline script for splitting logs from Kafka.
4. ENV_GLOBAL_HOST_TAGS: Required, global tags for the collector.
5. ENV_HTTP_LISTEN: Required, DataKit port; IP must be 0.0.0.0, otherwise other pods will not be able to access it.
6. ENV_DEFAULT_ENABLED_INPUTS: Required, default enabled collectors.

For more details, refer to [Alibaba Cloud SAE Application Engine Observability Best Practices](https://www.guance.com/learn/articles/SAE).

## Tracing {#tracing}

To deploy applications on Alibaba Cloud SAE, you need to introduce APM into the corresponding containers:

- You can upload the package files required for building APM to OSS or integrate the APM build package into the Dockerfile of the application for construction.
- Start loading, similar to the steps of integrating APM under normal circumstances.

For more details, refer to [Alibaba Cloud SAE Application Engine Observability Best Practices](https://www.guance.com/learn/articles/SAE).

## Metrics {#metric}

### Install Func

It is recommended to activate Guance Integration - Expansion - Managed Func: All prerequisites will be automatically installed. Please continue with the script installation.

If deploying Func manually, refer to [Manually Deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}.

### Install Script

> Note: Prepare an appropriate Alibaba Cloud AK in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize SAE monitoring data, we install the corresponding collection scripts: «Guance Integration (Alibaba Cloud-SAE-Application)» (ID: `guance_aliyun_sae_app`) and «Guance Integration (Alibaba Cloud-SAE-Application Instance)» (ID: `guance_aliyun_sae_app_instance`).

After clicking 【Install】, enter the corresponding parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】 and the system will automatically create a `Startup` script set and configure the corresponding startup script.

Once activated, you can see the corresponding automatic trigger configuration under «Management / Automatic Trigger Configuration». Click 【Execute】 to run immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.


### Verification

1. Confirm in «Management / Automatic Trigger Configuration» whether the corresponding tasks have been configured with automatic triggers and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, under «Infrastructure / Custom», check if there are any asset information entries.
3. On the Guance platform, under «Metrics», check if there are any corresponding monitoring data entries.

### Metric Introduction

After configuring basic monitoring metrics for Alibaba Cloud-SAE, the default measurement set is as follows. More metrics can be collected through configuration: [SAE Basic Monitoring Metric Details](https://help.aliyun.com/zh/sae/serverless-app-engine-upgrade/user-guide/sae-2-microservices-sae-basic-monitoring-indicators?spm=5176.21213303.J_qCOwPWspKEuWcmp8qiZNQ.1.2a872f3dTrQiFH&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@2773772._.ID_help@@%E6%96%87%E6%A1%A3@@2773772-RL_acs~UND~serverless-LOC_llm-OR_ser-PAR1_213e38dc17286368694255187e16f5-V_3-RE_new4@@cardNew){:target="_blank"}

|Metric | Unit | Dimensions | Description |
| -- | -- | -- |-- |
|`cpu_Average`|%|userId、appId|Application CPU|
|`diskIopsRead_Average`|Count/Second|userId、appId|Application Disk IOPS Read|
|`diskIopsWrite_Average`|Count/Second|userId、appId|Application Disk IOPS Write|
|`diskRead_Average`|Byte/Second|userId、appId|Application Disk IO Throughput Read|
|`diskTotal_Average`|Kilobyte|userId、appId|Application Disk Total Capacity|
|`diskUsed_Average`|Kilobyte|userId、appId|Application Disk Usage|
|`diskWrite_Average`|Byte/Second|userId、appId|Application Disk IO Throughput Write|
|`instanceId_memoryUsed_Average`|MB|userId、appId、instanceId|Instance Memory Used|
|`instance_cpu_Average`|%|userId、appId、instanceId|Instance CPU|
|`instance_diskIopsRead_Average`|Count/Second|userId、appId、instanceId|Instance Disk IOPS Read|
|`instance_diskIopsWrite_Average`|Count/Second|userId、appId、instanceId|Instance Disk IOPS Write|
|`instance_diskRead_Average`|Byte/Second|userId、appId、instanceId|Instance Disk IO Throughput Read|
|`instance_diskTotal_Average`|Kilobyte|userId、appId、instanceId|Instance Disk Total Capacity|
|`instance_diskUsed_Average`|Kilobyte|userId、appId、instanceId|Instance Disk Usage|
|`instance_diskWrite_Average`|Byte/Second|userId、appId、instanceId|Instance Disk IO Throughput Write|
|`instance_load_Average`|min|userId、appId、instanceId|Instance Average Load|
|`instance_memoryTotal_Average`|MB|userId、appId、instanceId|Instance Total Memory|
|`instance_memoryUsed_Average`|MB|userId、appId、instanceId|Instance Memory Used|
|`instance_netRecv_Average`|Byte/Second|userId、appId、instanceId|Instance Received Bytes|
|`instance_netRecvBytes_Average`|Byte|userId、appId、instanceId|Instance Total Received Bytes|
|`instance_netRecvDrop_Average`|Count/Second|userId、appId、instanceId|Instance Received Packet Drops|
|`instance_netRecvError_Average`|Count/Second|userId、appId、instanceId|Instance Received Error Packets|
|`instance_netRecvPacket_Average`|Count/Second|userId、appId、instanceId|Instance Received Packets|
|`instance_netTran_Average`|Byte/Second|userId、appId、instanceId|Instance Sent Bytes|
|`instance_netTranBytes_Average`|Byte|userId、appId、instanceId|Instance Total Sent Bytes|
|`instance_netTranDrop_Average`|Count/Second|userId、appId、instanceId|Instance Sent Packet Drops|
|`instance_netTranError_Average`|Count/Second|userId、appId、instanceId|Instance Sent Error Packets|
|`instance_netTranPacket_Average`|Count/Second|userId、appId、instanceId|Instance Sent Packets|
|`instance_tcpActiveConn_Average`|Count|userId、appId、instanceId|Instance Active TCP Connections|
|`instance_tcpInactiveConn_Average`|Count|userId、appId、instanceId|Instance Inactive TCP Connections|
|`instance_tcpTotalConn_Average`|Count|userId、appId、instanceId|Instance Total TCP Connections|
|`load_Average`|min|userId、appId|Application Average Load|
|`memoryTotal_Average`|MB|userId、appId|Application Total Memory|
|`memoryUsed_Average`|MB|userId、appId|Application Memory Used|
|`netRecv_Average`|Byte/Second|userId、appId|Application Received Bytes|
|`netRecvBytes_Average`|Byte|userId、appId|Application Total Received Bytes|
|`netRecvDrop_Average`|Count/Second|userId、appId|Application Received Packet Drops|
|`netRecvError_Average`|Count/Second|userId、appId|Application Received Error Packets|
|`netRecvPacket_Average`|Count/Second|userId、appId|Application Received Packets|
|`netTran_Average`|Byte/Second|userId、appId|Application Sent Bytes|
|`netTranBytes_Average`|Byte|userId、appId|Application Total Sent Bytes|
|`netTranDrop_Average`|Count/Second|userId、appId|Application Sent Packet Drops|
|`netTranError_Average`|Count/Second|userId、appId|Application Sent Error Packets|
|`netTranPacket_Average`|Count/Second|userId、appId|Application Sent Packets|
|`tcpActiveConn_Average`|Count|userId、appId|Application Active TCP Connections|
|`tcpInactiveConn_Average`|Count|userId、appId|Application Inactive TCP Connections|
|`tcpTotalConn_Average`|Count|userId、appId|Application Total TCP Connections|

## Logs {#logging}

Alibaba Cloud SAE provides a way to output logs to the Guance platform via Kafka. The process is as follows:

- Enable Kafka log reporting for SAE applications.
- DataKit enables KafkaMQ log collection by collecting application Kafka log reporting topics.

For more detailed steps, refer to [Alibaba Cloud SAE Application Engine Observability Best Practices](https://www.guance.com/learn/articles/SAE).