# OpenTelemetry to <<< custom_key.brand_name >>>

---

In the previous two articles, we demonstrated and introduced how to perform observability based on OpenTelemetry.

[OpenTelemetry to Jaeger, Grafana, ELK](./opentelemetry-elk.md)

As a classic observability architecture, different types of data are stored on different platforms, such as logs in ELK, traces in APM systems like Jaeger, and metrics in Prometheus with visualization through Grafana.

[OpenTelemetry to Grafana](./opentelemetry-grafana.md) 

The combination of Grafana Tempo and Loki allows us to intuitively see the log trace situation. However, the characteristics of Loki also determine that it cannot provide good log processing and analysis capabilities for large production systems. Log tracing is only part of observability; querying through log traces alone cannot solve most problems, especially in the era of microservices and cloud-native architectures where the diversity of issues requires comprehensive analysis from multiple aspects. For example, user access delays may not be due to program issues but could also result from other factors like current system network or CPU. In multi-cloud scenarios, Grafana cannot effectively support business development.

[<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>)

is a unified platform for collecting and managing various types of data including metrics, logs, APM, RUM, infrastructure, containers, middleware, and network performance. Using <<< custom_key.brand_name >>> allows for comprehensive observability of applications, not just between log traces. For more information about <<< custom_key.brand_name >>>, please refer to [Product Advantages](../../product-introduction/index.md).

DataKit acts as a gateway for <<< custom_key.brand_name >>>. To send data to <<< custom_key.brand_name >>>, you need to configure DataKit correctly, which offers several advantages:

1. In host environments, each host has one DataKit instance. Data is first sent to the local DataKit, cached, pre-processed, and then reported, reducing network jitter while providing edge processing capabilities, thus relieving pressure on backend data processing.
2. In Kubernetes environments, each node has a DataKit daemonset. By utilizing Kubernetes' local traffic mechanism, data from pods on each node is first sent to the local node's DataKit, reducing network jitter and adding pod and node labels to APM data, facilitating positioning in distributed environments.

Since DataKit accepts oltp protocol, it can bypass the collector and send data directly to DataKit, or the collector's exporter can be set to oltp (DataKit).

## Architecture
![image.png](../images/opentelemetry-guance-1.png)

There are still two options available for this architecture.

> DataKit collects logs in multiple ways. This best practice primarily uses the socket method for log collection. Springboot applications mainly use Logback-logstash to push logs to DataKit.

## Option One

1. Application server and client push metric and trace data to otel-collector via otlp-exporter.
2. Front-end app pushes trace information to otel-collector and accesses application service APIs.
3. Otel-collector collects and transforms data, then sends metric and trace data to DataKit via otlp-exporter.
4. Simultaneously, the application server and client push logs to DataKit.

### Exporter

Otel-collector is configured with one exporter: otlpExporter.

```yaml
  otlp:
    endpoint: "http://192.168.91.11:4319"
    tls:
      insecure: true
    compression: none # gzip not enabled
```

Parameter descriptions

> endpoint: "[http://192.168.91.11:4319](http://192.168.91.11:4319)" # Currently filled with the DataKit OpenTelemetry collector address, using GRPC protocol.
>
>tls.insecure : true # TLS security check disabled
>
>compression: none # gzip not enabled by default

Note

> All applications are deployed on the same machine with IP 192.168.91.11. If applications and some middleware are deployed separately, ensure you modify the corresponding IP. If using cloud servers, ensure related ports are open to avoid access failures.


## Option Two

Option Two essentially replaces otel-collector with DataKit.

Backend server and client start by modifying the `otel.exporter.otlp.endpoint` address to point directly to DataKit.

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
- DataKit version >=1.2.12

### Enabling OpenTelemetry Collector

Refer to [OpenTelemetry Collector Integration Documentation](../../integrations/opentelemetry.md).

#### Adjust the following parameters

[inputs.opentelemetry.grpc] parameter descriptions
	
- trace_enable：true 		# Enable grpc trace
- metric_enable： true 	    # Enable grpc metric
- addr: 0.0.0.0:4319 		    # Enable port

#### Restart DataKit

```shell
datakit service restart
```

### Enabling Log Collection

1. Enable the Logging plugin and copy the sample file

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

Parameter descriptions

- sockets # Configure socket information
- pipeline: log_socket.p # Log parsing

3. Configure pipeline

> cd pipeline
> vim log_socket.p

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

1. Enable the prom plugin and copy the sample file

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

  ## Source alias
  source = "prom"

  ## Output source for collected data
  # Configure this to write collected data to a local file instead of sending it to the center
  # You can then debug locally saved Metrics with the command `datakit --prom-conf /path/to/this/conf`
  # If URL is already configured as a local file path, the `--prom-conf` option will prioritize debugging output path data
  # output = "/abs/path/to/file"

  ## Maximum size limit for collected data in bytes
  # Set a maximum size limit for collected data when writing to a local file
  # If the size of the collected data exceeds this limit, the data will be discarded
  # Default maximum size limit is set to 32MB
  # max_file_size = 0

  ## Filter metric types, possible values are counter, gauge, histogram, summary, untyped
  # By default, only counter and gauge type metrics are collected
  # If empty, no filtering is applied
  metric_types = []

  ## Filter metric names: matching metrics will be retained
  # Supports regex, multiple configurations allowed, i.e., meeting any one condition suffices
  # If empty, no filtering is applied, all metrics are retained
  # metric_name_filter = ["cpu"]

  ## Prefix for measurement names
  # Configure this to add a prefix to measurement names
  measurement_prefix = ""

  ## Measurement name
  # By default, the measurement name is derived from the first segment of the metric name split by "_", with the remaining segments forming the metric name
  # If `measurement_name` is configured, no splitting of the metric name occurs
  # The final measurement name includes the `measurement_prefix` prefix
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

  ## Custom authentication method, currently supports Bearer Token
  # Only one of `token` and `token_file` needs to be configured
  # [inputs.prom.auth]
  # type = "bearer_token"
  # token = "xxxxxxxx"
  # token_file = "/tmp/token"

  ## Custom measurement names
  # Metrics containing the prefix `prefix` can be grouped into one measurement set
  # Custom measurement name configuration takes precedence over `measurement_name`
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

Parameter descriptions

- urls # otel-collector metrics URL
- metric_types = []: Collect all metrics

3. Restart DataKit

```shell
datakit --restart
```

## Installing OpenTelemetry-Collector

### Source Code Location

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
    compression: none # gzip not enabled

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

Install otel-collector using docker-compose

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

Mainly through the socket method provided by Logstash-logback to upload logs to Logstash, requiring some adjustments to the code.

### 1. Add Maven Dependency for Logstash-logback

```xml
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
    <!-- %m outputs message, %p log level, %t thread name, %d date, %c full class name,,,, -->
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

```yaml
logstash:
  host: localhost
  port: 4560
logging:
  config: classpath:logback-logstash.xml
```

### 4. Rebuild

```shell
mvn clean package -DskipTests
```

### 5. Start Service

```shell
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
```shell
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

### Source Code Location

[https://github.com/lrwh/observable-demo/tree/main/opentelemetry-js](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-js)

### Configure OTLPTraceExporter

```javascript
const otelExporter = new OTLPTraceExporter({
  // optional - url default value is http://localhost:55681/v1/traces
  url: 'http://192.168.91.11:4318/v1/traces',
  headers: {},
});
```

This URL is the otlp receiving address of otel-collector (HTTP protocol).

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

```shell
npm install
```

### Start

```shell
npm start
```

Default port `8090`

## APM and RUM Correlation

APM and RUM are mainly correlated through header parameters. To maintain consistency, a uniform propagator (`Propagator`) must be configured. Here, RUM uses `B3`, so APM also needs to configure `B3`. Just add `-Dotel.propagators=b3` to the APM startup parameters.

## APM and Log Correlation

APM and logs are mainly correlated through traceId and spanId embedded in log entries. Different log integration methods have varying embedding differences.

## <<< custom_key.brand_name >>>

By accessing the frontend URL, trace information is generated.

![image.png](../images/opentelemetry-guance-2.png)

### Log Viewer

![guance-log.gif](../images/opentelemetry-guance-4.gif)

### Trace (Application Performance Monitoring)

![guance-trace.gif](../images/opentelemetry-guance-5.gif)

### View Corresponding Logs from Trace

![guance-trace-log.gif](../images/opentelemetry-guance-6.gif)

### Application Metrics

Application metrics are stored in the `otel-service` measurement set.

![guance-metrics.gif](../images/opentelemetry-guance-7.png)

### Otelcol Metrics

![guance-otelcol-metrics.gif](../images/opentelemetry-guance-8.png)

### Otelcol Integrated View

![Otelcol Integrated View](../images/opentelemetry-guance-9.png)