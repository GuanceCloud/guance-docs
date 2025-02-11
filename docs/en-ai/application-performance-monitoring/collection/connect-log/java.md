# Java Log Correlation with Trace Data
---

To correlate logs from a `Java` application with trace data, follow these steps:

1. Enable logging in the application;  
2. Enable [trace data collection](../../../integrations/ddtrace.md) in Datakit and configure the log parsing [Pipeline script](../../../pipeline/index.md), then start Datakit;  
3. Start the `Java` application.

## Maven Dependency for Logs

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

## Log Configuration File

```
  <!--Dataflux monitoring logs-->
    <appender name="ALL_DATAFLUX" class="ch.qos.logback.core.FileAppender">
        <file>${USER_HOME}/platform_dataflux.log</file>
        <encoder class="net.logstash.logback.encoder.LogstashEncoder" />
    </appender>
     <root level="INFO">
      <appender-ref ref="ALL_DATAFLUX" />
    </root>
```

## datakit logging.conf Configuration

Microservices example, mount log volumes as specified by operations:

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

## Starting the Java Application

Use the following command to start the Java application:

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

## Configuring Pipeline Script

The collected log format is as follows:

```shell
{"@timestamp":"2021-06-24T14:17:53.563+08:00","@version":1,"message":"<=> invoke action [CheckModule@saveDfBillToDbSchedule] take time : 72ms ","logger_name":"com.cloudcare.web.container.interceptor.LoggerInterceptor","thread_name":"qtp454424866-39","level":"DEBUG","level_value":10000,"HOSTNAME":"LAPTOP-IA9RA81K","request_host":"127.0.0.1:8106","action_name":"CheckModule@saveDfBillToDbSchedule","request_id":"60d423840fe1874814490456","request_remote_host":"192.168.241.1","response_error_code":"Worker.NotFound","dd.service":"billing","dd.env":"staging","dd.span_id":"5577585360079661786","dd.trace_id":"6724368348029357447","dd.version":"1.0","tags":["operation"]}
```

Log data needs to be parsed and transformed before it can be correlated with trace data. This can be achieved by configuring a Pipeline script. The script is as follows:

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

After processing with the Pipeline script, the data appears as follows. By using fields such as `trace_id` and `span_id`, the log data is correlated with the trace data.

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