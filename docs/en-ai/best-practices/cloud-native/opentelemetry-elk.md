# OpenTelemetry to Jaeger, Grafana, and ELK

----

OpenTelemetry has many open-source combination options. We will introduce and demonstrate OpenTelemetry deployments under different technical architectures through three platforms:

> 1. [OpenTelemetry to Jaeger, Grafana, and ELK](./opentelemetry-elk.md)

> 2. [OpenTelemetry to Grafana](./opentelemetry-grafana.md)

> 3. [OpenTelemetry to Guance](./opentelemetry-guance.md)

## OpenTelemetry
OTEL is the abbreviation for OpenTelemetry, a CNCF observability project aimed at providing standardized solutions in the observability domain. It addresses standardization issues related to observable data models, collection, processing, and exporting, offering vendor-agnostic services.

OpenTelemetry is a set of standards and tools designed to manage observability data such as Traces, Metrics, Logs, etc. (new types of observability data may emerge in the future). It has become an industry standard.

## OTLP
OTLP (short for OpenTelemetry Protocol) is the native telemetry signal transmission protocol of OpenTelemetry. Although components in the OpenTelemetry project support protocols like Zipkin v2 or Jaeger Thrift, these are provided as third-party contributed libraries. Only OTLP is natively supported by OpenTelemetry. The data model definition of OTLP is based on ProtoBuf. If you need to implement a backend service that can collect OTLP telemetry data, you should understand its contents. Refer to the code repository: opentelemetry-proto ([https://github.com/open-telemetry/opentelemetry-proto](https://github.com/open-telemetry/opentelemetry-proto))

## OpenTelemetry-Collector

The OpenTelemetry Collector (hereinafter referred to as "otel-collector") provides a vendor-agnostic implementation for receiving, processing, and exporting telemetry data. It eliminates the need to run, operate, and maintain multiple agents/collectors to support sending open-source observability data formats (such as Jaeger, Prometheus, etc.) to one or more open-source or commercial backends. Additionally, the collector allows end-users to control their data. The collector is the default location where detection libraries export their telemetry data.

## OpenTelemetry-Java

The OpenTelemetry SDK developed in Java supports pushing data to various observation platforms via exporters.

## OpenTelemetry-JS

OpenTelemetry's front-end JS-based tracing solution.

## Architecture
![image.png](../images/opentelemetry-elk-1.png)
### Architecture Description
1. Application server and client push metric and trace data to otel-collector via otlp-exporter.

2. Front-app pushes trace information to otel-collector and accesses application service APIs.

3. Otel-collector collects and transforms data before pushing it to Jaeger, Zipkin.

4. Prometheus pulls data from otel-collector.

There are two methods for log submission:

Method One: Submit logs via OTLP

Application servers and clients push logs to otel-collector via otlp-exporter, which then exports them to Elasticsearch. Since OpenTelemetry log handling is not yet stable, it is recommended to handle logs separately, bypassing otel-collector. During testing, conflicts were found when configuring logs and metrics simultaneously, primarily on otel-collector. This issue awaits official fixes.

Method Two: Submit logs via Logback-logstash

Application servers and clients push logs to Logstash via Logback-logstash.

Otel-collector is configured with four exporters.
```yaml
  prometheus:
    endpoint: "0.0.0.0:8889"
    const_labels:
      label1: value1
  zipkin:
    endpoint: "http://otel_collector_zipkin:9411/api/v2/spans"
    format: proto
  jaeger:
    endpoint: otel_collector_jaeger:14250
    tls:
      insecure: true
  elasticsearch:
    endpoints: "http://192.168.0.17:9200"
```

> Note, all applications are deployed on the same machine with IP address 192.168.0.17. If applications and some middleware are deployed separately, make sure to modify the corresponding IPs. For cloud servers, ensure relevant ports are open to avoid access failures.

## Installation and Deployment

### Installing OpenTelemetry-Collector

#### Source Code Address

[https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-to-all](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-collector-to-all)

#### Configuring otel-collector-config.yaml

Add new collector configurations, including 1 receiver (otlp) and 4 exporters (prometheus, zipkin, jaeger, and elasticsearch).

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
  prometheus:
    endpoint: "0.0.0.0:8889"
    const_labels:
      label1: value1
  zipkin:
    endpoint: "http://otel_collector_zipkin:9411/api/v2/spans"
    format: proto

  jaeger:
    endpoint: otel_collector_jaeger:14250
    tls:
      insecure: true
  elasticsearch:
    endpoints: "http://192.168.0.17:9200"

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
      exporters: [zipkin, jaeger]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [prometheus]
    logs:
      receivers: [otlp]
      processors: [batch]
      exporters: [elasticsearch]
```

Install otel-collector using docker-compose
```yaml
version: '3.3'

services:
    jaeger:
        image: jaegertracing/all-in-one:1.29
        container_name: otel_collector_jaeger
        ports:
            - 16686:16686
            - 14250
            - 14268
    zipkin:
        image: openzipkin/zipkin:latest
        container_name: otel_collector_zipkin
        ports:
            - 9411:9411
    # Collector
    otel-collector:
        image: otel/opentelemetry-collector:0.50.0
        command: ["--config=/etc/otel-collector-config.yaml"]
        volumes:
            - ./otel-collector-config.yaml:/etc/otel-collector-config.yaml
        ports:
            - "1888:1888"   # pprof extension
            - "8888:8888"   # Prometheus metrics exposed by the collector
            - "8889:8889"   # Prometheus exporter metrics
            - "13133:13133" # health_check extension
            - "4317:4317"        # OTLP gRPC receiver
            - "4318:4318"        # OTLP http receiver
            - "55670:55679" # zpages extension
        depends_on:
            - jaeger
            - zipkin
    prometheus:
        container_name: prometheus
        image: prom/prometheus:latest
        volumes:
            - ./prometheus.yaml:/etc/prometheus/prometheus.yml
        ports:
            - "9090:9090"
    grafana:
        container_name: grafana
        image: grafana/grafana
        ports:
            - "3000:3000"
```
#### Configuring Prometheus
```yaml
scrape_configs:
  - job_name: 'otel-collector'
    scrape_interval: 10s
    static_configs:
      - targets: ['otel-collector:8889']
      - targets: ['otel-collector:8888']
```
#### Starting Containers

```yaml
docker-compose up -d
```

#### Checking Start Status

```yaml
docker-compose ps
```

![image.png](../images/opentelemetry-elk-2.png)

### Docker Installation of ELK

Using Docker to install ELK is simple and convenient. The relevant component versions are `7.16.2`.

#### Pulling Images

```shell
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.16.2
docker pull docker.elastic.co/logstash/logstash:7.16.2
docker pull docker.elastic.co/kibana/kibana:7.16.2
```
#### Configuring Directories

```shell
# Linux specific configuration
sysctl -w vm.max_map_count=262144
sysctl -p
# End of Linux configuration

mkdir -p ~/elk/elasticsearch/plugins
mkdir -p ~/elk/elasticsearch/data
mkdir -p ~/elk/logstash
chmod 777 ~/elk/elasticsearch/data
```

#### Logstash Configuration

```shell
input {
  tcp {
    mode => "server"
    host => "0.0.0.0"
    port => 4560
    codec => json_lines
  }
}
output {
  elasticsearch {
    hosts => "es:9200"
    index => "springboot-logstash-demo-%{+YYYY.MM.dd}"
  }
}
```
Input parameters explanation:

> tcp: TCP protocol.
> port: TCP port
> codec: JSON line parsing

#### Docker-compose Configuration

```shell
version: '3'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.16.2
    container_name: elasticsearch
    volumes:
      - ~/elk/elasticsearch/plugins:/usr/share/elasticsearch/plugins # Plugin file mounting
      - ~/elk/elasticsearch/data:/usr/share/elasticsearch/data # Data file mounting
    environment:
      - "cluster.name=elasticsearch" # Set cluster name to elasticsearch
      - "discovery.type=single-node" # Start in single node mode
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m" # Set JVM memory size
      - "ingest.geoip.downloader.enabled=false" # Disable automatic GeoIP2 database updates
    ports:
      - 9200:9200
  logstash:
    image: docker.elastic.co/logstash/logstash:7.16.2
    container_name: logstash
    volumes:
      - ~/elk/logstash/logstash.conf:/usr/share/logstash/pipeline/logstash.conf # Mount logstash configuration file
    depends_on:
      - elasticsearch # Start after elasticsearch
    links:
      - elasticsearch:es # Access elasticsearch service via es domain
    ports:
      - 4560:4560
  kibana:
    image: docker.elastic.co/kibana/kibana:7.16.2
    container_name: kibana
    depends_on:
      - elasticsearch # Start after elasticsearch
    links:
      - elasticsearch:es # Access elasticsearch service via es domain
    environment:
      - "elasticsearch.hosts=http://es:9200" # Set elasticsearch access address
    ports:
      - 5601:5601
```

#### Starting Containers

```yaml
docker-compose up -d
```

#### Checking Start Status

```yaml
docker-compose ps
```

![image.png](../images/opentelemetry-elk-3.png)

### Springboot Application Integration (APM)

#### Source Code Address

[https://github.com/lrwh/observable-demo/tree/main/springboot-server](https://github.com/lrwh/observable-demo/tree/main/springboot-server)

#### Starting Server

```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=server,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-server.jar --client=true
```

#### Starting Client

```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=client,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-client.jar
```

#### Parameter Explanation

otel.traces.exporter: otlp # Configure exporter type to otlp, default is otlp.

otel.exporter.otlp.endpoint: OTLP exporter endpoint (grpc)

otel.resource.attributes: Configure tags.

otel.metrics.exporter: otlp # Configure metrics exporter type, default is none.

otel.logs.exporter: otlp # Configure logs exporter type, default is none.

otel.propagators: Configure trace propagator.

Since OpenTelemetry log functionality is not mature and stable, it is not recommended for production use. Some bugs were encountered during testing, only suitable for learning.

### Springboot Application Integration (Log)

#### Method One: Submitting Logs via OTLP

Application server and client push logs to otel-collector via otlp-exporter, which then exports them to Elasticsearch.

##### Modify Startup Parameters

Add `-Dotel.logs.exporter=otlp` to the application startup parameters.
```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=server,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-server.jar --client=true
```
```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=client,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-client.jar
```
After starting, logs will be transmitted to otel-collector via the otlp protocol and exported to Elasticsearch by otel-collector.

#### Method Two: Submitting Logs via Logstash-logback

This involves uploading logs to Logstash using the socket method provided by Logstash-logback, requiring some adjustments to the code.

##### 1. Add Maven Dependency for Logstash-logback

```xml
<dependency>
  <groupId>net.logstash.logback</groupId>
  <artifactId>logstash-logback-encoder</artifactId>
  <version>7.0.1</version>
</dependency>
```
#### 2. Add logback-logstash.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="30 seconds">
    <!-- Some parameters come from properties files -->
    <springProperty scope="context" name="logName" source="spring.application.name" defaultValue="localhost.log"/>
    <!-- Dynamic log level modification -->
    <jmxConfigurator />
    <property name="log.pattern" value="%d{HH:mm:ss} [%thread] %-5level %logger{10} [traceId=%X{trace_id} spanId=%X{span_id} userId=%X{user-id}] %msg%n" />

    <springProperty scope="context" name="logstashHost" source="logstash.host" defaultValue="logstash"/>
    <springProperty scope="context" name="logstashPort" source="logstash.port" defaultValue="4560"/>
    <!-- Output pattern -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/${logName}/${logName}.log</file>
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
##### 3. Add application-logstash.yml

```yaml
logstash:
  host: localhost
  port: 4560
logging:
  config: classpath:logback-logstash.xml
```

##### 4. Rebuild Package

```shell
mvn clean package -DskipTests
```

##### 5. Start Service

```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=server,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-server.jar --client=true \
--spring.profiles.active=logstash \
--logstash.host=localhost \
--logstash.port=4560
```
```yaml
java -javaagent:opentelemetry-javaagent-1.13.1.jar \
-Dotel.traces.exporter=otlp \
-Dotel.exporter.otlp.endpoint=http://localhost:4350 \
-Dotel.resource.attributes=service.name=client,username=liu \
-Dotel.metrics.exporter=otlp \
-Dotel.logs.exporter=otlp \
-Dotel.propagators=b3 \
-jar springboot-client.jar \
--spring.profiles.active=logstash \
--logstash.host=localhost \
--logstash.port=4560
```

### JS Integration (RUM)

#### Source Code Address

[https://github.com/lrwh/observable-demo/tree/main/opentelemetry-js](https://github.com/lrwh/observable-demo/tree/main/opentelemetry-js)

#### Configure OTLPTraceExporter

```javascript
const otelExporter = new OTLPTraceExporter({
  // optional - url default value is http://localhost:55681/v1/traces
  url: 'http://192.168.91.11:4318/v1/traces',
  headers: {},
});
```

Here, the URL is the otlp reception address of otel-collector (HTTP protocol).

#### Configure server_name

```javascript
const providerWithZone = new WebTracerProvider({
      resource: new Resource({
        [SemanticResourceAttributes.SERVICE_NAME]: 'front-app',
      }),
    });
```

#### Install

```shell
npm install
```

#### Start

```shell
npm start
```
Default port `8090`

## APM and RUM Correlation

APM and RUM mainly correlate through header parameters. To maintain consistency, configure a unified Propagator. Here, RUM uses `B3`, so APM also needs to configure `B3`. Just add `-Dotel.propagators=b3` to the APM startup parameters.

## APM and Log Correlation

APM and Log correlation mainly involve embedding traceId and spanId in log points. Different log integration methods result in differences in embedding.

## UI Display

Generate trace information by accessing the frontend URL.

![image.png](../images/opentelemetry-elk-4.png)

### ELK Log Display

ELK stands for ElasticSearch, Logstash, and Kibana.

#### Submitting Logs via OTLP

![otel-log-es.gif](../images/opentelemetry-elk-5.gif)

Expanded log source part

```json
"_source": {
  "@timestamp": "2022-05-18T08:39:20.661000000Z",
  "Body": "this is method3,null",
  "Resource.container.id": "7478",
  "Resource.host.arch": "amd64",
  "Resource.host.name": "cluster-ecs07",
  "Resource.os.description": "Linux 3.10.0-1160.15.2.el7.x86_64",
  "Resource.os.type": "linux",
  "Resource.process.command_line": "/usr/java/jdk1.8.0_111/jre:bin:java -javaagent:opentelemetry-javaagent-1.13.1.jar -Dotel.traces.exporter=otlp -Dotel.exporter.otlp.endpoint=http://localhost:4350 -Dotel.resource.attributes=service.name=server,username=liu -Dotel.metrics.exporter=otlp -Dotel.logs.exporter=otlp -Dotel.propagators=b3",
  "Resource.process.executable.path": "/usr/java/jdk1.8.0_111/jre:bin:java",
  "Resource.process.pid": 5728,
  "Resource.process.runtime.description": "Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 25.111-b14",
  "Resource.process.runtime.name": "Java(TM) SE Runtime Environment",
  "Resource.process.runtime.version": "1.8.0_111-b14",
  "Resource.service.name": "server",
  "Resource.telemetry.auto.version": "1.13.1",
  "Resource.telemetry.sdk.language": "java",
  "Resource.telemetry.sdk.name": "opentelemetry",
  "Resource.telemetry.sdk.version": "1.13.0",
  "Resource.username": "liu",
  "SeverityNumber": 9,
  "SeverityText": "INFO",
  "SpanId": "bb890485f7b6ba05",
  "TraceFlags": 1,
  "TraceId": "b4841a6b3ec9aa93d7f002393a156ff5"
  },
```

Through the otlp protocol, traceId and spanId are automatically embedded in logs.

### Submitting Logs via Logstash-logback

![logtash-kibana.gif](../images/opentelemetry-elk-6.gif)

Expanded log source part

```json
  "_source": {
    "@timestamp": "2022-05-18T13:43:34.790Z",
    "port": 55630,
    "serverName": "otlp-server",
    "namespace": "k8sNamespace_IS_UNDEFINED",
    "message": "this is tag\n",
    "@version": "1",
    "severity": "INFO",
    "thread": "http-nio-8080-exec-1",
    "pid": "3975",
    "host": "gateway",
    "class": "c.z.o.server.controller.ServerController",
    "traceId": "a7360264491f074a1b852cfcabb10fdb",
    "spanId": "e4a8f1c4606ca598",
    "podName": "podName_IS_UNDEFINED"
  },
```

Through the Logstash-logback method, traceId and spanId need to be manually embedded.

### Prometheus & Grafana Metrics Display

![image.png](../images/opentelemetry-elk-7.png)

![image.png](../images/opentelemetry-elk-8.png)

### Jaeger, Zipkin Trace Display

![jaeger-ui.gif](../images/opentelemetry-elk-9.gif)

![zipkin-ui.gif](../images/opentelemetry-elk-10.gif)

[Next Article](./opentelemetry-grafana.md) will introduce how OpenTelemetry integrates with Grafana-related components for observability.