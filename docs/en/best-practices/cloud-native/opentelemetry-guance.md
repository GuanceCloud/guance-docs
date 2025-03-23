# OpenTelemetry to <<< custom_key.brand_name >>>

---

In the previous two articles, we demonstrated and introduced how to conduct observability based on OpenTelemetry.

[OpenTelemetry to Jaeger, Grafana, ELK](./opentelemetry-elk.md)

As a classic observability architecture, different types of data are stored on different platforms, such as logs in ELK, traces in Jaeger-like APMs, and metrics saved in Prometheus with visualization through Grafana.

[OpenTelemetry to Grafana](./opentelemetry-grafana.md) 

The combination of Grafana Tempo and Loki allows us to intuitively see the log trace situation. However, Loki's characteristics also determine that it cannot provide good log processing and analysis capabilities for large production systems. Log tracing is only part of observability, and merely querying log traces cannot solve most problems, especially in the era of microservices and cloud-native architecture where the diversity of issues requires us to analyze from multiple aspects. For example, user access delays may not necessarily be program-related but could also be due to other comprehensive factors like the current system network or CPU. In multi-cloud user scenarios, Grafana cannot effectively support business development.

[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>)

is a unified collection and management platform for various types of data including Metrics data, LOG data, APM, RUM, infrastructure, CONTAINERS, MIDDLEWARE, NETWORK performance, etc. Using <<< custom_key.brand_name >>> enables us to observe applications comprehensively rather than just between log traces. For more <<< custom_key.brand_name >>> information, please refer to [Product Advantages](../../product-introduction/index.md).

DataKit is the gateway preceding <<< custom_key.brand_name >>>. To send data to <<< custom_key.brand_name >>>, DataKit needs to be correctly configured, and using DataKit offers the following advantages:

1. In a HOST environment, each host has one DataKit instance. Data is first sent to the local DataKit, cached, preprocessed, and then reported, avoiding network fluctuations while providing edge processing capabilities, thereby relieving pressure on backend data processing.

2. In a k8 environment, each node has a DataKit daemonset. By utilizing k8s' local traffic mechanism, data from each pod on the node is sent to the local node’s DataKit, avoiding network fluctuations while adding pod and node tags to APM data, facilitating positioning in distributed environments.

Since DataKit accepts oltp protocol, it can bypass the collector and directly send data to DataKit or set the collector's exporter to oltp (DataKit).

## Architecture
![image.png](../images/opentelemetry-guance-1.png)

There are still two solutions available for selection in the architecture.

> Datakit collects logs in multiple ways; this best practice mainly involves collecting logs via the socket method. Springboot applications primarily use Logback-logstash to push logs to DataKit.

## Solution One

1. Application server and client push metric and trace data through otlp-exporter to otel-collector.
2. Front-end app acts as the front-end chain, pushing chain information to otel-collector and accessing application service APIs.
3. Otel-collector collects and transforms the data, then transmits metric and trace data through otlp-exporter to DataKit.
4. Simultaneously, the application server and client push logs to DataKit.

### Exporter

Otel-collector is configured with 1 exporter: otlpExporter.

```yaml
  otlp:
    endpoint: "http://192.168.91.11:4319"
    tls:
      insecure: true
    compression: none # gzip disabled
```

Parameter Description

> endpoint: "[http://192.168.91.11:4319](http://192.168.91.11:4319)" # Currently filled with the DataKit OpenTelemetry collector address, using GRPC protocol.
>
>tls.insecure : true # Disable TLS security verification
>
>compression: none # Gzip disabled by default

Note

> All applications are deployed on the same machine, with an IP of 192.168.91.11. If applications and some middleware are separately deployed, remember to modify the corresponding IPs. If it's a cloud server, ensure relevant ports are open to avoid access failures.


## Solution Two

Solution Two essentially replaces otel-collector with DataKit directly.

When starting back-end servers and clients, modify the `otel.exporter.otlp.endpoint` address to point directly to DataKit.

> -Dotel.exporter.otlp.endpoint=http://192.168.91.11:4319

Front-end changes

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

Refer to the [OpenTelemetry Collector Integration Document](../../integrations/opentelemetry.md).

#### Adjust the Following Parameters

[inputs.opentelemetry.grpc] Parameter Description

- trace_enable: true 	# Enable grpc trace
- metric_enable: true 	# Enable grpc metric
- addr: 0.0.0.0:4319 	# Enable port

#### Restart DataKit

```shell
datakit service restart
```

### Enabling Log Collection

1. Enable Logging plugin, copy Sample file

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

3. Configure Pipeline

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

1. Enable prom plugin, copy Sample file

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

  ## Output source for collected data
  # Configuring this item can write collected data to a local file instead of sending it to the center
  # Later, you can debug locally saved Measurements using the command datakit --prom-conf /path/to/this/conf
  # If the URL is already configured as a local file path, --prom-conf will prioritize debugging output path data
  # output = "/abs/path/to/file"

  ## Upper limit for the size of collected data, in bytes
  # When outputting data to a local file, you can set an upper limit for the size of collected data
  # If the size of the collected data exceeds this limit, the collected data will be discarded
  # The default upper limit for the size of collected data is set to 32MB
  # max_file_size = 0

  ## Metric type filtering, optional values are counter, gauge, histogram, summary, untyped
  # By default, only counter and gauge type metrics are collected
  # If empty, no filtering is performed
  metric_types = []

  ## Metric name filtering: metrics that meet the conditions will be retained
  # Supports regex, multiple configurations can be made, i.e., satisfying any one condition is sufficient
  # If empty, no filtering is performed, all metrics are retained
  # metric_name_filter = ["cpu"]

  ## Measurement prefix
  # Configuring this item can add a prefix to the measurement name
  measurement_prefix = ""

  ## Measurement name
  # By default, the metric name will be split by underscores "_", with the first field after splitting as the measurement name and the remaining fields as the current metric name
  # If measurement_name is configured, the metric name will not be split
  # The final measurement name will have the measurement_prefix prefix added
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
  # token and token_file: only one needs to be configured
  # [inputs.prom.auth]
  # type = "bearer_token"
  # token = "xxxxxxxx"
  # token_file = "/tmp/token"

  ## Custom measurement names
  # Metrics containing the prefix prefix can be grouped into a class of measurements
  # Custom measurement name configuration takes precedence over the measurement_name configuration item
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

- urls # otel-collector metric URL
- metric_types = []: Collect all metrics

3. Restart DataKit

```shell
datakit --restart
```

## Installing OpenTelemetry-Collector

### Source Code Address

[https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-to-guance](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-to-guance)

### Configure otel-collector-config.yaml

Add collecter configuration, configure 1 receiver (otlp) and 4 exporters (prometheus, zipkin, jaeger, and elasticsearch).

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
    compression: none # gzip disabled

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

### Check Startup Status

```yaml
docker-compose ps
```

![image.png](../images/opentelemetry-guance-3.png)

## Springboot Application Integration (APM & Log)

Primarily using the socket method provided by Logstash-logback to upload logs to Logstash, requiring partial code adjustments.

### 1. Add Maven Dependency for Logstash-logback

```toml
<dependency>
  <groupId>net.logstash.logback</groupId>
  <artifactId>logstash-logback-encoder</artifactId>
  <version>7.0.1</version>
</dependency>
```

### 2. Add logback-logstash.xml

```java
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="30 seconds">
    <!-- Some parameters need to come from properties files -->
    <springProperty scope="context" name="logName" source="spring.application.name" defaultValue="localhost.log"/>
    <!-- After configuration, dynamic modification of log levels can be done -->
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
        <file>logs/${logName}/${logName}.log</file>    <!-- Usage Example -->
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
        <!-- Configure logStash service address -->
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
        <!-- Keep-alive -->
        <keepAliveDuration>5 minutes</keepAliveDuration>
    </appender>

    <!-- Only print error-level content -->
    <logger name="net.sf.json" level="ERROR" />
    <logger name="org.springframework" level="ERROR" />

    <root level="info">
        <appender-ref ref="STDOUT"/>
        <appender-ref ref="LOGSTASH"/>
    </root>
</configuration>
```

### 3. Add application-logstash.yml

```java
logstash:
  host: localhost
  port: 4560
logging:
  config: classpath:logback-logstash.xml
```

### 4. Repackage

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

This URL is the otlp receiving address of otel-collector (http protocol).

### Configure server_name

```javascript
const providerWithZone = new WebTracerProvider({
      resource: new Resource({
        [SemanticResourceAttributes.SERVICE_NAME]: 'front-app',
      }),
    }
);
```

### Install

```toml
npm install
```

### Start

```toml
npm start
```

Default port `8090`

## APM and RUM Correlation

APM and RUM are mainly associated through header parameters. To maintain consistency, a unified propagator (`Propagator`) needs to be configured. Here, RUM uses `B3`, so APM also needs to configure `B3`. This can be done by simply adding `-Dotel.propagators=b3` to the APM startup parameters.

## APM and Log Correlation

APM and Logs are mainly correlated through traceId and spanId embedded in log points. Differences exist depending on the method of log integration.

## <<< custom_key.brand_name >>>

By accessing the front-end URL, trace information is generated.

![image.png](../images/opentelemetry-guance-2.png)

### Log Explorer

![guance-log.gif](../images/opentelemetry-guance-4.gif)

### Trace (**Application Performance Monitoring**)

![guance-trace.gif](../images/opentelemetry-guance-5.gif)

### View Corresponding Logs from Traces

![guance-trace-log.gif](../images/opentelemetry-guance-6.gif)

### Application Metrics

All application Metrics are stored in the Measurement named `otel-service`.

![guance-metrics.gif](../images/opentelemetry-guance-7.png)

### Otelcol Metrics

![guance-otelcol-metrics.gif](../images/opentelemetry-guance-8.png)

### Otelcol Integrated View

![Otelcol Integrated View](../images/opentelemetry-guance-9.png)