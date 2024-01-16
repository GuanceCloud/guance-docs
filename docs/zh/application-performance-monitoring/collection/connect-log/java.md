# Java 日志关联链路数据
---

`Java` 应用日志关联链路数据需经过如下步骤：

1. 应用中开启日志；  
2. Datakit 开启[链路数据采集](../../../integrations/ddtrace.md)，并配置日志切割的 [Pipeline 脚本](../../../management/overall-pipeline.md)，启动 Datakit；  
3. 启动 `Java` 应用。

## 日志 maven 导入

```
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.1.3</version>
</dependency>
<dependency>
    <groupId>net.logstash.logback</groupId>
    <artifactId>logstash-logback-encoder</artifactId>
    <version>4.5.1</version>
</dependency>
```

## 日志配置文件

```
  <!--dataflux监控日志-->
    <appender name="ALL_DATAFLUX" class="ch.qos.logback.core.FileAppender">
        <file>${USER_HOME}/platform_dataflux.log</file>
        <encoder class="net.logstash.logback.encoder.LogstashEncoder" />
    </appender>
     <root level="INFO">
      <appender-ref ref="ALL_DATAFLUX" />
    </root>
```

## datakit logging.conf 配置

微服务示例，路径找运维挂载日志卷：

```
[[inputs.logging]]
  logfiles = [
    "/rootfs/k8s/logdata/cf-platform-prod/adapter/platform_dataflux.log" 
  ]
  ignore = [""]
  source = "cc-adapter"
  service = "cc-adapter"
  pipeline = ""
  ignore_status = []
  character_encoding = ""
  match = '''^\S'''
  [inputs.logging.tags]

[[inputs.logging]]
  logfiles = [
    "/rootfs/k8s/logdata/cf-platform-prod/billing/platform_dataflux.log"
  ]
  ignore = [""]
  source = "cc-billing"
  service = "cc-billing"
  pipeline = ""
  ignore_status = []
  character_encoding = ""
  match = '''^\S'''
  [inputs.logging.tags]

[[inputs.logging]]
  logfiles = [
    "/rootfs/k8s/logdata/cf-platform-prod/security/platform_dataflux.log"
  ]
  ignore = [""]
  source = "cc-security"
  service = "cc-security"
  pipeline = ""
  ignore_status = []
  character_encoding = ""
  match = '''^\S'''
  [inputs.logging.tags]

[[inputs.logging]]
  logfiles = [
    "/rootfs/k8s/logdata/cf-platform-prod/misc/platform_dataflux.log"
  ]
  ignore = [""]
  source = "cc-misc"
  service = "cc-misc"
  pipeline = ""
  ignore_status = []
  character_encoding = ""
  match = '''^\S'''
  [inputs.logging.tags]

[[inputs.logging]]
  logfiles = [
    "/rootfs/k8s/logdata/cf-platform-prod/user/platform_dataflux.log"
  ]
  ignore = [""]
  source = "cc-user"
  service = "cc-user"
  pipeline = ""
  ignore_status = []
  character_encoding = ""
  match = '''^\S'''
  [inputs.logging.tags]
[[inputs.logging]]
  logfiles = [
    "/rootfs/k8s/logdata/cf-platform-prod/product/platform_dataflux.log"
  ]
  ignore = [""]
  source = "cc-product"
  service = "cc-product"
  pipeline = ""
  ignore_status = []
  character_encoding = ""
  match = '''^\S'''
  [inputs.logging.tags]
```

## 开启 Java 应用

通过如下命令开启 Java 应用：

```shell
java -javaagent:/your/path/dd-java-agent.jar \
-Ddd.logs.injection=true \
-Ddd.service.name=cbis-billing \
-Ddd.env=staging \
-Ddd.version=1.0 \
-Ddd.agent.host=127.0.0.1 \
-Ddd.agent.port=9529 \
-jar /your/path/app.jar
```
## 配置 Pipeline 脚本

采集到的日志格式如下：

```shell
{"@timestamp":"2021-06-24T14:17:53.563+08:00","@version":1,"message":"<=> invoke action [CheckModule@saveDfBillToDbSchedule] take time : 72ms ","logger_name":"com.cloudcare.web.container.interceptor.LoggerInterceptor","thread_name":"qtp454424866-39","level":"DEBUG","level_value":10000,"HOSTNAME":"LAPTOP-IA9RA81K","request_host":"127.0.0.1:8106","action_name":"CheckModule@saveDfBillToDbSchedule","request_id":"60d423840fe1874814490456","request_remote_host":"192.168.241.1","response_error_code":"Worker.NotFound","dd.service":"billing","dd.env":"staging","dd.span_id":"5577585360079661786","dd.trace_id":"6724368348029357447","dd.version":"1.0","tags":["operation"]}
```

日志数据同样需要经过切割转换后才能和链路数据进行关联，可以通过配置 Pipeline 脚本实现，脚本如下：

```
json(_, message)

json(_, `dd.service`, service)

json(_, `dd.env`, env)

json(_, `dd.version`, version)

json(_, `dd.trace_id`, trace_id)

json(_, `dd.span_id`, span_id)

json(_, `@timestamp`, time)

default_time(time)
```

经过 Pipeline 脚本切割处理后数据如下，通过 `trace_id`，`span_id` 等字段信息，日志数据即和链路数据关联起来。

```
{
    "env": "staging",
    "message": "\u003c=\u003e invoke action [CheckModule@saveDfBillToDbSchedule] take time : 72ms ",
    "service": "billing",
    "span_id": "5577585360079661786",
    "time": 1624515473563000000,
    "trace_id": "6724368348029357447",
    "version": "1.0"
}

```
