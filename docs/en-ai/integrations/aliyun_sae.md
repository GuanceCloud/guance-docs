---
title: 'Alibaba Cloud SAE'
tags: 
  - Alibaba Cloud
summary: 'Collect metrics, logs, and trace information from Alibaba Cloud SAE (Serverless App Engine)'
__int_icon: 'icon/aliyun_sae'
dashboard:
  - desc: 'Alibaba Cloud SAE monitoring view'
    path: 'dashboard/en/aliyun_sae/'
monitor:
  - desc: 'Alibaba Cloud SAE monitor'
    path: 'monitor/en/aliyun_sae/'
---

<!-- markdownlint-disable MD025 -->
# Alibaba Cloud SAE
<!-- markdownlint-enable -->

Collect metrics, logs, and trace information from Alibaba Cloud SAE (Serverless App Engine).


## Configuration {#config}

Applications deployed on SAE can be integrated with tracing, metrics, and log data through the following process:

![img](./imgs/aliyun_sae_01.png)

- Applications report Trace data to DataKit via APM.
- Application log data is collected through KafkaMQ and then consumed by DataKit.
- Application container metrics are collected using Alibaba Cloud's monitoring API and reported to Guance via the Function platform (DataFlux Func).
- After DataKit collects the corresponding data, it processes and reports it to Guance.

Note: Deploying DataKit on SAE can save bandwidth.

### Create a DataKit Application

To create a DataKit application on SAE:

- Enter SAE, click Application List - Create Application.
- Fill in the application information:
    - Application Name
    - Select Namespace, create one if it does not exist
    - Select VPC, create one if it does not exist
    - Select Security Group: vswitch should match the NAT switch
    - Adjust instance count as needed
    - CPU 1 core, memory 1G
    - Click Next after completion
- Add Image: pubrepo.guance.com/datakit/datakit:1.31.0
- Add environment variables, configuration content as follows:

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

Configuration item descriptions:

1. ENV_DATAWAY: Required, the gateway address for reporting to Guance.
2. KAFKAMQ: Optional, KafkaMQ collector configuration, refer to: Kafka Collector Configuration File Introduction.
3. SPRINGBOOT_LOG_P: Optional, used with KAFKAMQ, log pipeline script for parsing logs from Kafka.
4. ENV_GLOBAL_HOST_TAGS: Required, global tags for collectors.
5. ENV_HTTP_LISTEN: Required, DataKit port, IP must be 0.0.0.0 otherwise other pods will not be able to access it.
6. ENV_DEFAULT_ENABLED_INPUTS: Required, default enabled collectors.

For more details, refer to [Best Practices for Observability of Alibaba Cloud SAE Application Engine](https://www.guance.com/learn/articles/SAE).

## Tracing {#tracing}

To deploy applications on Alibaba Cloud SAE and integrate APM into the corresponding containers:

- Upload the APM package file to OSS or integrate the APM build package into the application's Dockerfile for building.
- Start loading, follow the same steps as integrating APM in a regular environment.

For more details, refer to [Best Practices for Observability of Alibaba Cloud SAE Application Engine](https://www.guance.com/learn/articles/SAE).

## Metrics {#metric}

### Install Func

It is recommended to use the Guance integration - Extension - Managed Func: all prerequisites are automatically installed. Continue with the script installation.

If you deploy Func manually, refer to [Deploy Func Manually](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}.

### Installation Script

> Note: Prepare an Alibaba Cloud AK that meets the requirements in advance (for simplicity, you can directly grant global read-only permission `ReadOnlyAccess`).

To synchronize SAE monitoring data, install the corresponding collection scripts: 「Guance Integration (Alibaba Cloud-SAE-Application)」(ID: `guance_aliyun_sae_app`) and 「Guance Integration (Alibaba Cloud-SAE-Application Instance)」(ID: `guance_aliyun_sae_app_instance`).

Click 【Install】, then input the parameters: Alibaba Cloud AK, Alibaba Cloud account name.

Click 【Deploy Startup Script】, the system will automatically create the `Startup` script set and configure the startup scripts accordingly.

After enabling, you can see the corresponding automatic trigger configurations in 「Management / Automatic Trigger Configurations」. Click 【Execute】 to run immediately without waiting for scheduled time. Wait a moment, and you can check the execution task records and corresponding logs.

### Verification

1. Confirm in 「Management / Automatic Trigger Configurations」 whether the corresponding tasks have been configured and check the task records and logs for any anomalies.
2. In the Guance platform, under 「Infrastructure / Custom」, check if asset information exists.
3. In the Guance platform, under 「Metrics」, check if the corresponding monitoring data exists.

### Metric Description

After configuring the basic monitoring metrics for Alibaba Cloud SAE, the default metric set is as follows. You can collect more metrics through configuration. Refer to [Basic Monitoring Metrics Details for SAE](https://help.aliyun.com/zh/sae/serverless-app-engine-upgrade/user-guide/sae-2-microservices-sae-basic-monitoring-indicators?spm=5176.21213303.J_qCOwPWspKEuWcmp8qiZNQ.1.2a872f3dTrQiFH&scm=20140722.S_help@@文档@@2773772._.ID_help@@文档@@2773772-RL_acs~UND~serverless-LOC_llm-OR_ser-PAR1_213e38dc17286368694255187e16f5-V_3-RE_new4@@cardNew){:target="_blank"}

| Metric | Unit | Dimensions | Description |
| --- | --- | --- | --- |
| `cpu_Average` | % | userId, appId | Application CPU usage |
| `diskIopsRead_Average` | Count/Second | userId, appId | Application disk IOPS read |
| `diskIopsWrite_Average` | Count/Second | userId, appId | Application disk IOPS write |
| `diskRead_Average` | Byte/Second | userId, appId | Application disk IO throughput read |
| `diskTotal_Average` | Kilobyte | userId, appId | Application disk total size |
| `diskUsed_Average` | Kilobyte | userId, appId | Application disk used size |
| `diskWrite_Average` | Byte/Second | userId, appId | Application disk IO throughput write |
| `instanceId_memoryUsed_Average` | MB | userId, appId, instanceId | Instance used memory |
| `instance_cpu_Average` | % | userId, appId, instanceId | Instance CPU usage |
| `instance_diskIopsRead_Average` | Count/Second | userId, appId, instanceId | Instance disk IOPS read |
| `instance_diskIopsWrite_Average` | Count/Second | userId, appId, instanceId | Instance disk IOPS write |
| `instance_diskRead_Average` | Byte/Second | userId, appId, instanceId | Instance disk IO throughput read |
| `instance_diskTotal_Average` | Kilobyte | userId, appId, instanceId | Instance disk total size |
| `instance_diskUsed_Average` | Kilobyte | userId, appId, instanceId | Instance disk used size |
| `instance_diskWrite_Average` | Byte/Second | userId, appId, instanceId | Instance disk IO throughput write |
| `instance_load_Average` | min | userId, appId, instanceId | Instance average load |
| `instance_memoryTotal_Average` | MB | userId, appId, instanceId | Instance total memory |
| `instance_memoryUsed_Average` | MB | userId, appId, instanceId | Instance used memory |
| `instance_netRecv_Average` | Byte/Second | userId, appId, instanceId | Instance received bytes |
| `instance_netRecvBytes_Average` | Byte | userId, appId, instanceId | Instance total received bytes |
| `instance_netRecvDrop_Average` | Count/Second | userId, appId, instanceId | Instance received packet drops |
| `instance_netRecvError_Average` | Count/Second | userId, appId, instanceId | Instance received error packets |
| `instance_netRecvPacket_Average` | Count/Second | userId, appId, instanceId | Instance received packets |
| `instance_netTran_Average` | Byte/Second | userId, appId, instanceId | Instance transmitted bytes |
| `instance_netTranBytes_Average` | Byte | userId, appId, instanceId | Instance total transmitted bytes |
| `instance_netTranDrop_Average` | Count/Second | userId, appId, instanceId | Instance transmitted packet drops |
| `instance_netTranError_Average` | Count/Second | userId, appId, instanceId | Instance transmitted error packets |
| `instance_netTranPacket_Average` | Count/Second | userId, appId, instanceId | Instance transmitted packets |
| `instance_tcpActiveConn_Average` | Count | userId, appId, instanceId | Instance active TCP connections |
| `instance_tcpInactiveConn_Average` | Count | userId, appId, instanceId | Instance inactive TCP connections |
| `instance_tcpTotalConn_Average` | Count | userId, appId, instanceId | Instance total TCP connections |
| `load_Average` | min | userId, appId | Application average load |
| `memoryTotal_Average` | MB | userId, appId | Application total memory |
| `memoryUsed_Average` | MB | userId, appId | Application used memory |
| `netRecv_Average` | Byte/Second | userId, appId | Application received bytes |
| `netRecvBytes_Average` | Byte | userId, appId | Application total received bytes |
| `netRecvDrop_Average` | Count/Second | userId, appId | Application received packet drops |
| `netRecvError_Average` | Count/Second | userId, appId | Application received error packets |
| `netRecvPacket_Average` | Count/Second | userId, appId | Application received packets |
| `netTran_Average` | Byte/Second | userId, appId | Application transmitted bytes |
| `netTranBytes_Average` | Byte | userId, appId | Application total transmitted bytes |
| `netTranDrop_Average` | Count/Second | userId, appId | Application transmitted packet drops |
| `netTranError_Average` | Count/Second | userId, appId | Application transmitted error packets |
| `netTranPacket_Average` | Count/Second | userId, appId | Application transmitted packets |
| `tcpActiveConn_Average` | Count | userId, appId | Application active TCP connections |
| `tcpInactiveConn_Average` | Count | userId, appId | Application inactive TCP connections |
| `tcpTotalConn_Average` | Count | userId, appId | Application total TCP connections |

## Logs {#logging}

Alibaba Cloud SAE provides a Kafka method to output logs to the Guance platform, the process is as follows:

- Enable Kafka log reporting for SAE applications.
- DataKit enables KafkaMQ log collection, collecting logs from the application's Kafka Topic.

For more detailed steps, refer to [Best Practices for Observability of Alibaba Cloud SAE Application Engine](https://www.guance.com/learn/articles/SAE).