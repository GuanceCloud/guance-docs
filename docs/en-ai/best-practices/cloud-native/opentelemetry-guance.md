# OpenTelemetry to Guance

---

In the previous two articles, we demonstrated and introduced how to achieve observability based on OpenTelemetry.

[OpenTelemetry to Jaeger, Grafana, ELK](./opentelemetry-elk.md)

As a classic observability architecture, different types of data are stored on different platforms, such as logs in ELK, traces in APM platforms like Jaeger, and metrics saved in Prometheus with visualization through Grafana.

[OpenTelemetry to Grafana](./opentelemetry-grafana.md) 

The combination of Grafana Tempo and Loki allows us to intuitively see the log trace situation. However, Loki's characteristics also determine that it cannot provide good log processing and analysis capabilities for large production systems. Log tracing is only part of observability; querying log traces alone cannot solve most problems, especially in the era of microservices and cloud-native architectures where the diversity of issues requires multi-faceted combined analysis. For example, user access delays may not necessarily be due to program issues but could also be caused by other factors such as current system network or CPU. In multi-cloud scenarios, Grafana cannot effectively support business development.

[Guance](https://www.guance.com)

is a unified collection and management platform for various types of data, including Metrics, log data, APM, RUM, infrastructure, containers, middleware, and network performance. Using Guance enables comprehensive observability of applications, not just between log traces. For more information about Guance, please refer to [Product Advantages](../../product-introduction/index.md).

DataKit is the gateway for Guance. To send data to Guance, DataKit must be correctly configured, offering the following advantages:

1. In a host environment, each host has one DataKit. Data is first sent to the local DataKit, cached, pre-processed, and then reported, mitigating network jitter while providing edge processing capabilities and alleviating backend data processing pressure.
2. In a k8s environment, each node has a DataKit daemonset. By leveraging k8s's local traffic mechanism, data from pods on each node is sent to the local node's DataKit, mitigating network jitter and adding pod and node labels to APM data, facilitating localization in distributed environments.

Since DataKit accepts OLTP protocol, it can bypass the collector and directly send data to DataKit, or the collector's exporter can be set to oltp (DataKit).

## Architecture
![image.png](../images/opentelemetry-guance-1.png)

There are still two solutions available for the architecture.

> DataKit collects logs in multiple ways. This best practice mainly involves collecting logs via socket. Springboot applications primarily use Logback-logstash to push logs to DataKit.

## Solution One

1. Application server and client push metric and trace data through otlp-exporter to otel-collector.
2. Front-app acts as the frontend link, pushing link information to otel-collector and accessing application service APIs.
3. Otel-collector collects and transforms the data, then transmits metric and trace data through otlp-exporter to DataKit.
4. Simultaneously, the application server and client push logs to DataKit.

### Exporter

Otel-collector is configured with one exporter: otlpExporter.

```yaml
  otlp:
    endpoint: "http://192.168.91.11:4319"
    tls:
      insecure: true
    compression: none # No gzip
```

Parameter Description

> endpoint: "[http://192.168.91.11:4319](http://192.168.91.11:4319)" # The current entry is the DataKit OpenTelemetry collector address, using GRPC protocol.
>
>tls.insecure : true # Disable TLS verification
>
>compression: none # No gzip, default enabled

Note

> All applications are deployed on the same machine with IP 192.168.91.11. If applications and some middleware are separately deployed, ensure the corresponding IP is modified. For cloud servers, ensure relevant ports are open to avoid access failures.


## Solution Two

Solution two essentially replaces otel-collector with DataKit.

When starting the backend server and client, modify the `otel.exporter.otlp.endpoint` address to point directly to DataKit.

> -Dotel.exporter.otlp.endpoint=http://192.168.91.11:4319

Frontend changes

```javascript
const otelExporter = new OTLPTraceExporter({
  // optional - url default value is http://localhost:55681/v1/traces
  url: 'http://192.168.91.11:9529/otel/v1/trace',
  headers: {},
});
```

## Installing and Configuring DataKit

### Installing DataKit

- <[Install DataKit](../../datakit/datakit-install.md)>

- DataKit version >= 1.2.12

### Enabling OpenTelemetry Collector

Refer to the [OpenTelemetry Collector Integration Documentation](../../integrations/opentelemetry.md).

#### Adjust the following parameters

[inputs.opentelemetry.grpc] Parameter Description
	
- trace_enable: true 		# Enable grpc trace
- metric_enable: true 	    # Enable grpc metric
- addr: 0.0.0.0:4319 		    # Port

#### Restart DataKit

```shell
datakit service restart
```

### Enabling Log Collection

1. Enable the Logging plugin and copy the Sample file

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample logging-socket-4560.conf
```

2. Modify logging-socket-4560.conf

```toml
[[inputs.logging]]
  ## required
#  logfiles = [
#    "/var/log/syslog",
#    "/var/log/message",
#  ]

  sockets = [
   "tcp://0.0.0.0:4560"
  ]

  ## glob filter
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "otel"

  ## add service tag, if it's empty, use $source.
  service = "otel"

  ## grok pipeline script path
  pipeline = "log_socket.p"

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  ## removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

Parameter Description

- sockets # Configure socket information
- pipeline: log_socket.p # Log parsing

3. Configure pipeline

> cd pipeline
> vim  log_socket.p

```toml
json(_,message,"message")
json(_,class,"class")
json(_,serverName,"service")
json(_,thread,"thread")
json(_,severity,"status")
json(_,traceId,"trace_id")
json(_,spanId,"span_id")
json(_,`@timestamp`,"time")
set_tag(service)
default_time(time)
```

4. Restart DataKit

```shell
datakit --restart
```

### Enabling Metric Collection

1. Enable the prom plugin and copy the Sample file

```shell
cd /usr/local/datakit/conf.d/prom
cp prom.conf.sample prom-otel.conf
```

2. Modify prom-otel.conf

```toml
[[inputs.prom]]
  ## Exporter URLs
  urls = ["http://127.0.0.1:8888/metrics"]

  ## Ignore request errors for URLs
  ignore_req_err = false

  ## Collector alias
  source = "prom"

  ## Data output source
  # Configure this to write collected data to a local file instead of sending it to the center
  # You can then use the command `datakit --prom-conf /path/to/this/conf` to debug the locally saved Mearsurement
  # If the URL is configured as a local file path, the --prom-conf command will prioritize debugging the data at the output path
  # output = "/abs/path/to/file"

  ## Maximum data size limit in bytes
  # Set a maximum data size limit when outputting data to a local file
  # If the data size exceeds this limit, the collected data will be discarded
  # The default maximum data size limit is set to 32MB
  # max_file_size = 0

  ## Filter metric types, options are counter, gauge, histogram, summary, untyped
  # By default, only counter and gauge type metrics are collected
  # If empty, no filtering is performed
  metric_types = []

  ## Filter metric names: metrics that match the conditions will be retained
  # Supports regex, multiple configurations can be made, i.e., meeting any one condition is sufficient
  # If empty, no filtering is performed, all metrics are retained
  # metric_name_filter = ["cpu"]

  ## Prefix for Mearsurement names
  # Configure this to add a prefix to the Mearsurement name
  measurement_prefix = ""

  ## Mearsurement name
  # By default, the Mearsurement name is split by underscores "_", with the first field as the Mearsurement name and the rest as the current metric name
  # If measurement_name is configured, the metric name will not be split
  # The final Mearsurement name will include the measurement_prefix prefix
  # measurement_name = "prom"

  ## Collection interval "ns", "us" (or "µs"), "ms", "s", "m", "h"
  interval = "10s"

  ## Filter tags, multiple tags can be configured
  # Matching tags will be ignored
  # tags_ignore = ["xxxx"]

  ## TLS configuration
  tls_open = false
  # tls_ca = "/tmp/ca.crt"
  # tls_cert = "/tmp/peer.crt"
  # tls_key = "/tmp/peer.key"

  ## Custom authentication method, currently only supports Bearer Token
  # Only one of token or token_file needs to be configured
  # [inputs.prom.auth]
  # type = "bearer_token"
  # token = "xxxxxxxx"
  # token_file = "/tmp/token"

  ## Custom Mearsurement name
  # Metrics containing the prefix prefix can be grouped into one Mearsurement
  # Custom Mearsurement name configuration takes precedence over measurement_name
  #[[inputs.prom.measurements]]
  #  prefix = "cpu_"
  #  name = "cpu"

  # [[inputs.prom.measurements]]
  # prefix = "mem_"
  # name = "mem"

  ## Rename prom data tag keys
	[inputs.prom.tags_rename]
		overwrite_exist_tags = false
		[inputs.prom.tags_rename.mapping]
			# tag1 = "new-name-1"
			# tag2 = "new-name-2"
			# tag3 = "new-name-3"

  ## Custom Tags
  [inputs.prom.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

Parameter Description

- urls # Otel-collector metric URL
- metric_types = []: Collect all metrics

3. Restart DataKit

```shell
datakit --restart
```

## Installing OpenTelemetry-Collector

### Source Code Address

[https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-to-guance](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-to-guance)

### Configure otel-collector-config.yaml

Add a new collector configuration with one receiver (otlp) and four exporters (prometheus, zipkin, jaeger, and elasticsearch).

```yaml
receivers:
  otlp:
    protocols:
      grpc:
      http:
        cors:
          allowed_origins:
            - http://*
            - https://*
exporters:
  otlp:
    endpoint: "http://192.168.91.11:4319"
    tls:
      insecure: true
    compression: none # No gzip

processors:
  batch:

extensions:
  health_check:
  pprof:
    endpoint: :1888
  zpages:
    endpoint: :55679

service:
  extensions: [pprof, zpages, health_check]
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlp]


```

Install otel-collector via docker-compose

```yaml
version: '3.3'

services:
    # Collector
    otel-collector:
        image: otel/opentelemetry-collector-contrib:0.51.0
        command: ["--config=/etc/otel-collector-config.yaml"]
        volumes:
            - ./otel-collector-config.yaml:/etc/otel-collector-config.yaml
        ports:
            - "1888:1888"   # pprof extension
            - "8888:8888"   # Prometheus metrics exposed by the collector
            - "8889:8889"   # Prometheus exporter metrics
            - "13133:13133" # health_check extension
            - "4350:4317"        # OTLP gRPC receiver
            - "55670:55679" # zpages extension
            - "4318:4318"

```

### Start Container

```yaml
docker-compose up -d
```

### View Startup Status

```yaml
docker-compose ps
```

![image.png](../images/opentelemetry-guance-3.png)

## Springboot Application Integration (APM & Log)

Mainly through the socket method provided by Logstash-logback to upload logs to Logstash, requiring partial code adjustments.

### 1. Add Maven Dependency for Logstash-logback

```toml
<dependency>
  <groupId>net.logstash.logback</groupId>
  <artifactId>logstash-logback-encoder</artifactId>
  <version>7.0.1</version>
</dependency>
```

### 2. Add logback-logstash.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="30 seconds">
    <!-- Some parameters need to come from properties files -->
    <springProperty scope="context" name="logName" source="spring.application.name" defaultValue="localhost.log"/>
    <!-- Configuration allows dynamic modification of log levels -->
    <jmxConfigurator />
    <property name="log.pattern" value="%d{HH:mm:ss} [%thread] %-5level %logger{10} [traceId=%X{trace_id} spanId=%X{span_id} userId=%X{user-id}] %msg%n" />

    <springProperty scope="context" name="logstashHost" source="logstash.host" defaultValue="logstash"/>
    <springProperty scope="context" name="logstashPort" source="logstash.port" defaultValue="4560"/>
    <!-- %m outputs the message, %p the log level, %t the thread name, %d the date, %c the full class name,,,, -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/${logName}/${logName}.log</file>    <!-- Usage -->
        <append>true</append>
        <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>logs/${logName}/${logName}-%d{yyyy-MM-dd}.log.%i</fileNamePattern>
            <maxFileSize>64MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>1GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <!-- LOGSTASH output settings -->
    <appender name="LOGSTASH" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
        <!-- Configure LogStash service address -->
        <destination>${logstashHost}:${logstashPort}</destination>
        <!-- Log output encoding -->
        <encoder class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder">
            <providers>
                <timestamp>
                    <timeZone>UTC+8</timeZone>
                </timestamp>
                <pattern>
                    <pattern>
                        {
                        "podName":"${podName:-}",
                        "namespace":"${k8sNamespace:-}",
                        "severity": "%level",
                        "serverName": "${logName:-}",
                        "traceId": "%X{trace_id:-}",
                        "spanId": "%X{span_id:-}",
                        "pid": "${PID:-}",
                        "thread": "%thread",
                        "class": "%logger{40}",
                        "message": "%message\n%exception"
                        }
                    </pattern>
                </pattern>
            </providers>
        </encoder>
        <!-- Keep alive -->
        <keepAliveDuration>5 minutes</keepAliveDuration>
    </appender>

    <!-- Print only error-level content -->
    <logger name="net.sf.json" level="ERROR" />
    <logger name="org.springframework" level="ERROR" />

    <root level="info">
        <appender-ref ref="STDOUT"/>
        <appender-ref ref="LOGSTASH"/>
    </root>
</configuration>
```

### 3. Add application-logstash.yml

```yaml
logstash:
  host: localhost
  port: 4560
logging:
  config: classpath:logback-logstash.xml
```

### 4. Rebuild Package

```java
mvn clean package -DskipTests
```

### 5. Start Service

```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=server,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-server.jar --client=true \
--spring.profiles.active=logstash \
--logstash.host=192.168.91.11 \
--logstash.port=4560
```
```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=client,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-client.jar \
--spring.profiles.active=logstash \
--logstash.host=localhost \
--logstash.port=4560
```

## JS Integration (RUM)

### Source Code Address

[https://github.com/lrwh/observable-demo/tree/main/opentelemetry-js](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-js)

### Configure OTLPTraceExporter

```javascript
const otelExporter = new OTLPTraceExporter({
  // optional - url default value is http://localhost:55681/v1/traces
  url: 'http://192.168.91.11:4318/v1/traces',
  headers: {},
});
```

This URL is the OTLP receiving address of otel-collector (HTTP protocol).

### Configure server_name

```javascript
const providerWithZone = new WebTracerProvider({
      resource: new Resource({
        [SemanticResourceAttributes.SERVICE_NAME]: 'front-app',
      }),
    }
);
```

### Installation

```toml
npm install
```

### Start

```toml
npm start
```

Default port `8090`

## APM and RUM Correlation

APM and RUM are mainly associated through header parameters. To maintain consistency, a unified propagator (`Propagator`) needs to be configured. Since RUM uses `B3`, APM also needs to configure `B3`. Adding `-Dotel.propagators=b3` to the APM startup parameters suffices.

## APM and Log Correlation

APM and logs are mainly correlated through traceId and spanId in log instrumentation. Different log integration methods result in variations in instrumentation.

## Guance

By visiting the frontend URL, trace information is generated.

![image.png](../images/opentelemetry-guance-2.png)

### Log Explorer

![guance-log.gif](../images/opentelemetry-guance-4.gif)

### Trace (Application Performance Monitoring)

![guance-trace.gif](../images/opentelemetry-guance-5.gif)

### Viewing Corresponding Logs from Traces

![guance-trace-log.gif](../images/opentelemetry-guance-6.gif)

### Application Metrics

Application metrics are stored in the Mearsurement named `otel-service`.

![guance-metrics.gif](../images/opentelemetry-guance-7.png)

### Otelcol Metrics

![guance-otelcol-metrics.gif](../images/opentelemetry-guance-8.png)

### Otelcol Integrated View

![Otelcol Integrated View](../images/opentelemetry-guance-9.png)