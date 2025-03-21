---
title: '阿里云 SAE'
tags: 
  - 阿里云
summary: '采集阿里云 SAE（Serverless App Engine）的指标、日志、链路信息'
__int_icon: 'icon/aliyun_sae'
dashboard:
  - desc: '阿里云 SAE 监控视图'
    path: 'dashboard/zh/aliyun_sae/'
monitor:
  - desc: '阿里云 SAE 监控器'
    path: 'monitor/zh/aliyun_sae/'
---

<!-- markdownlint-disable MD025 -->
# 阿里云 SAE
<!-- markdownlint-enable -->

采集阿里云 SAE（Serverless App Engine）的指标、日志、链路信息。


## 配置 {#config}

部署在 SAE 上的应用可以通过以下流程来接入链路、指标、日志数据，具体流程如下：

![img](./imgs/aliyun_sae_01.png)

- 应用通过接入 APM 上报 Trace 数据到 DataKit
- 应用的日志数据可以通过 KafkaMQ 收集后，通过 DataKit 进行消费
- 应用容器的指标数据利用阿里云的监控 API 并通过 Function 平台（DataFlux.f(x)）进行采集后上报到<<< custom_key.brand_name >>>
- DataKit 收集到对应的数据后统一处理并上报到<<< custom_key.brand_name >>>上

需要注意：在 SAE 上部署 DataKit，可以节省带宽。

### 创建 DataKit 应用

在 SAE 上创建 DataKit 应用

- 进入 SAE，点击应用列表 - 创建应用。
- 填写应用信息
    - 应用名称
    - 选择命名空间，如果没有，则创建一个
    - 选择 vpc，如果没有，则创建一个
    - 选择安全组： vswitch 要与 NAT 的交换机匹配
    - 实例数按需调整
    - CPU 1 core、内存1G
    - 完成后点击下一步
- 添加镜像：pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit:1.31.0
- 添加环境变量，配置项内容如下：

```json
{
  "ENV_DATAWAY": "https://openway.<<< custom_key.brand_main_domain >>>?token=tkn_xxx",
  "KAFKAMQ": "# {\"version\": \"1.22.7-1510\", \"desc\": \"do NOT edit this line\"}\n\n[[inputs.kafkamq]]\n  # addrs = [\"alikafka-serverless-cn-8ex3y7ciq02-1000.alikafka.aliyuncs.com:9093\",\"alikafka-serverless-cn-8ex3y7ciq02-2000.alikafka.aliyuncs.com:9093\",\"alikafka-serverless-cn-8ex3y7ciq02-3000.alikafka.aliyuncs.com:9093\"]\n  addrs = [\"alikafka-serverless-cn-8ex3y7ciq02-1000-vpc.alikafka.aliyuncs.com:9092\",\"alikafka-serverless-cn-8ex3y7ciq02-2000-vpc.alikafka.aliyuncs.com:9092\",\"alikafka-serverless-cn-8ex3y7ciq02-3000-vpc.alikafka.aliyuncs.com:9092\"]\n  # your kafka version:0.8.2 ~ 3.2.0\n  kafka_version = \"3.3.1\"\n  group_id = \"datakit-group\"\n  # consumer group partition assignment strategy (range, roundrobin, sticky)\n  assignor = \"roundrobin\"\n\n  ## kafka tls config\n   tls_enable = false\n\n  ## -1:Offset Newest, -2:Offset Oldest\n  offsets=-1\n\n\n  ## user custom message with PL script.\n  [inputs.kafkamq.custom]\n    #spilt_json_body = true\n    ## spilt_topic_map determines whether to enable log splitting for specific topic based on the values in the spilt_topic_map[topic].\n    #[inputs.kafkamq.custom.spilt_topic_map]\n     # \"log_topic\"=true\n     # \"log01\"=false\n    [inputs.kafkamq.custom.log_topic_map]\n      \"springboot-server_log\"=\"springboot_log.p\"\n    #[inputs.kafkamq.custom.metric_topic_map]\n    #  \"metric_topic\"=\"metric.p\"\n    #  \"metric01\"=\"rum_apm.p\"\n    #[inputs.kafkamq.custom.rum_topic_map]\n    #  \"rum_topic\"=\"rum_01.p\"\n    #  \"rum_02\"=\"rum_02.p\"\n",
  "SPRINGBOOT_LOG_P": "abc = load_json(_)\n\nadd_key(file, abc[\"file\"])\n\nadd_key(message, abc[\"message\"])\nadd_key(host, abc[\"host\"])\nmsg = abc[\"message\"]\ngrok(msg, \"%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\\\[%{NOTSPACE:method_name},%{NUMBER:line}\\\\] %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}\")\n\nadd_key(topic, abc[\"topic\"])\n\ndefault_time(time,\"Asia/Shanghai\")",
  "ENV_GLOBAL_HOST_TAGS": "host=__datakit_hostname,host_ip=__datakit_ip",
  "ENV_HTTP_LISTEN": "0.0.0.0:9529",
  "ENV_DEFAULT_ENABLED_INPUTS": "dk,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace,statsd,profile"
}
```

配置项说明：

1. ENV_DATAWAY：必填，上报<<< custom_key.brand_name >>>的网关地址
2. KAFKAMQ： 非必填，kafkamq 采集器配置，具体内容参考：Kafka 采集器配置文件介绍
3. SPRINGBOOT_LOG_P：非必填，结合 KAFKAMQ 一起使用，日志 pipeline 脚本，用于切割来自 kafka 的日志数据
4. ENV_GLOBAL_HOST_TAGS： 必填，采集器全局 tag
5. ENV_HTTP_LISTEN：必填，Datakit 端口，ip必须是 0.0.0.0 否则其他 pod 会访问不到
6. ENV_DEFAULT_ENABLED_INPUTS： 必填，默认开启的采集器

更多内容参考[阿里云 SAE 应用引擎可观测性最佳实践](https://<<< custom_key.brand_main_domain >>>/learn/articles/SAE)

## 链路 {#tracing}

在阿里云 SAE 上部署应用，需要把 APM 引入到对应的容器当中：

- 可以将 APM 需要构建的包文件上传到 oss，或者将 APM 的构建包整合到应用的 Dockerfile 当中进行构建
- 启动加载，与常规环境下接入 APM 步骤一样。

更多内容参考[阿里云 SAE 应用引擎可观测性最佳实践](https://<<< custom_key.brand_main_domain >>>/learn/articles/SAE)

## 指标 {#metric}

### 安装 Func

推荐开通 <<< custom_key.brand_name >>>集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}



### 安装脚本

> 提示：请提前准备好符合要求的阿里云 AK（简单起见，可直接授予全局只读权限`ReadOnlyAccess`）

同步 SAE 的监控数据，我们安装对应的采集脚本：「<<< custom_key.brand_name >>>集成（阿里云-SAE-应用）」(ID：`guance_aliyun_sae_app`) 和 「<<< custom_key.brand_name >>>集成（阿里云-SAE-应用实例）」(ID：`guance_aliyun_sae_app_instance`)

点击【安装】后，输入相应的参数：阿里云 AK、阿里云账户名。

点击【部署启动脚本】，系统会自动创建 `Startup` 脚本集，并自动配置相应的启动脚本。

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在<<< custom_key.brand_name >>>，「基础设施 / 自定义」中查看是否存在资产信息
3. 在<<< custom_key.brand_name >>>，「指标」查看是否有对应监控数据

### 指标介绍

配置完阿里云-SAE 基础监控指标,默认的指标集如下, 可以通过配置的方式采集更多的指标 [SAE 基础监控指标详情](https://help.aliyun.com/zh/sae/serverless-app-engine-upgrade/user-guide/sae-2-microservices-sae-basic-monitoring-indicators?spm=5176.21213303.J_qCOwPWspKEuWcmp8qiZNQ.1.2a872f3dTrQiFH&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@2773772._.ID_help@@%E6%96%87%E6%A1%A3@@2773772-RL_acs~UND~serverless-LOC_llm-OR_ser-PAR1_213e38dc17286368694255187e16f5-V_3-RE_new4@@cardNew){:target="_blank"}

|指标 | 单位 | Dimensions | 描述 |
| -- | -- | -- |-- |
|`cpu_Average`|%|userId、appId|应用CPU|
|`diskIopsRead_Average`|Count/Second|userId、appId|应用磁盘IOPS读|
|`diskIopsWrite_Average`|Count/Second|userId、appId|应用磁盘IOPS写|
|`diskRead_Average`|Byte/Second|userId、appId|应用磁盘IO吞吐率读|
|`diskTotal_Average`|Kilobyte|userId、appId|应用磁盘总量|
|`diskUsed_Average`|Kilobyte|userId、appId|应用磁盘使用量|
|`diskWrite_Average`|Byte/Second|userId、appId|应用磁盘IO吞吐率写|
|`instanceId_memoryUsed_Average`|MB|userId、appId、instanceId|实例已使用内存|
|`instance_cpu_Average`|%|userId、appId、instanceId|实例CPU|
|`instance_diskIopsRead_Average`|Count/Second|userId、appId、instanceId|实例磁盘IOPS读|
|`instance_diskIopsWrite_Average`|Count/Second|userId、appId、instanceId|实例磁盘IOPS写|
|`instance_diskRead_Average`|Byte/Second|userId、appId、instanceId|实例磁盘IO吞吐率读|
|`instance_diskTotal_Average`|Kilobyte|userId、appId、instanceId|实例磁盘总量|
|`instance_diskUsed_Average`|Kilobyte|userId、appId、instanceId|实例磁盘使用量|
|`instance_diskWrite_Average`|Byte/Second|userId、appId、instanceId|实例磁盘IO吞吐率写|
|`instance_load_Average`|min|userId、appId、instanceId|实例平均负载|
|`instance_memoryTotal_Average`|MB|userId、appId、instanceId|实例总内存|
|`instance_memoryUsed_Average`|MB|userId、appId、instanceId|实例已使用内存|
|`instance_netRecv_Average`|Byte/Second|userId、appId、instanceId|实例接收字节|
|`instance_netRecvBytes_Average`|Byte|userId、appId、instanceId|实例总接收字节|
|`instance_netRecvDrop_Average`|Count/Second|userId、appId、instanceId|实例接收数据丢包|
|`instance_netRecvError_Average`|Count/Second|userId、appId、instanceId|实例接收错误数据包|
|`instance_netRecvPacket_Average`|Count/Second|userId、appId、instanceId|实例接收数据包|
|`instance_netTran_Average`|Byte/Second|userId、appId、instanceId|实例发送字节|
|`instance_netTranBytes_Average`|Byte|userId、appId、instanceId|实例总发送字节|
|`instance_netTranDrop_Average`|Count/Second|userId、appId、instanceId|实例发送数据丢包|
|`instance_netTranError_Average`|Count/Second|userId、appId、instanceId|实例发送错误数据包|
|`instance_netTranPacket_Average`|Count/Second|userId、appId、instanceId|实例发送数据包|
|`instance_tcpActiveConn_Average`|Count|userId、appId、instanceId|实例活跃TCP连接数|
|`instance_tcpInactiveConn_Average`|Count|userId、appId、instanceId|实例非活跃TCP连接数|
|`instance_tcpTotalConn_Average`|Count|userId、appId、instanceId|实例总TCP连接数|
|`load_Average`|min|userId、appId|应用平均负载|
|`memoryTotal_Average`|MB|userId、appId|应用总内存|
|`memoryUsed_Average`|MB|userId、appId|应用已使用内存|
|`netRecv_Average`|Byte/Second|userId、appId|应用接收字节|
|`netRecvBytes_Average`|Byte|userId、appId|应用总接收字节|
|`netRecvDrop_Average`|Count/Second|userId、appId|应用接收数据丢包|
|`netRecvError_Average`|Count/Second|userId、appId|应用接收错误数据包|
|`netRecvPacket_Average`|Count/Second|userId、appId|应用接收数据包|
|`netTran_Average`|Byte/Second|userId、appId|应用发送字节|
|`netTranBytes_Average`|Byte|userId、appId|应用总发送字节|
|`netTranDrop_Average`|Count/Second|userId、appId|应用发送数据丢包|
|`netTranError_Average`|Count/Second|userId、appId|应用发送错误数据包|
|`netTranPacket_Average`|Count/Second|userId、appId|应用发送数据包|
|`tcpActiveConn_Average`|Count|userId、appId|应用活跃TCP连接数|
|`tcpInactiveConn_Average`|Count|userId、appId|应用非活跃TCP连接数|
|`tcpTotalConn_Average`|Count|userId、appId|应用总TCP连接数|


## 日志 {#logging}

阿里云 SAE 提供了 Kakfa 方式将日志输出到<<< custom_key.brand_name >>>，流程如下：

- SAE 应用开启 Kafka 日志上报
- DataKit 开启 KafkaMQ 日志采集，采集应用 Kafka 日志上报 Topic

更详细步骤参考[阿里云 SAE 应用引擎可观测性最佳实践](https://<<< custom_key.brand_main_domain >>>/learn/articles/SAE)


