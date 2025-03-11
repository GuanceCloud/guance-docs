# Associated with Java
---

The `Java` application log associates trace data through the following steps:

1. Open log in application;
2. Datakit starts [trace data collection](../../../integrations/ddtrace.md) and configures the [Pipeline script](../../../management/overall-pipeline.md) for log cutting and then start Datakit;
3. Start the `Java` application.

## Log Maven Import

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

## Log Profile

```
  <!--dataflux monitoring log-->
    <appender name="ALL_DATAFLUX" class="ch.qos.logback.core.FileAppender">
        <file>${USER_HOME}/platform_dataflux.log</file>
        <encoder class="net.logstash.logback.encoder.LogstashEncoder" />
    </appender>
     <root level="INFO">
      <appender-ref ref="ALL_DATAFLUX" />
    </root>
```

## Datakit Logging.conf Config

Microservice Example: for Path, find Devops to mount Log volumes.

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

## Open Java Application

Open the Java application with the following command:

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
## Configure the Pipeline Script

The collected log format is as follows:

```shell
{"@timestamp":"2021-06-24T14:17:53.563+08:00","@version":1,"message":"<=> invoke action [CheckModule@saveDfBillToDbSchedule] take time : 72ms ","logger_name":"com.cloudcare.web.container.interceptor.LoggerInterceptor","thread_name":"qtp454424866-39","level":"DEBUG","level_value":10000,"HOSTNAME":"LAPTOP-IA9RA81K","request_host":"127.0.0.1:8106","action_name":"CheckModule@saveDfBillToDbSchedule","request_id":"60d423840fe1874814490456","request_remote_host":"192.168.241.1","response_error_code":"Worker.NotFound","dd.service":"billing","dd.env":"staging","dd.span_id":"5577585360079661786","dd.trace_id":"6724368348029357447","dd.version":"1.0","tags":["operation"]}
```

Log data also needs to be cut and converted before it can be associated with trace data, which can be realized by configuring Pipeline script as follows:

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

The data cut by the Pipeline script is as follows, and the log data is associated with the trace data through field information such as `trace_id` and `span_id`.

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
