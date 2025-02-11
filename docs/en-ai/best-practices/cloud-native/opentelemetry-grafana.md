# OpenTelemetry to Grafana

---

[Previous](./opentelemetry-elk.md) In the previous article, we primarily introduced and demonstrated observability based on traditional open-source components of OpenTelemetry. With the popularity of observability in recent years, Grafana has also ventured into the observability industry.

### Concepts

> OTEL
>  
> OTEL is short for OpenTelemetry, a CNCF observability project aimed at providing standardized solutions in the observability domain. It addresses standardization issues related to data models, collection, processing, and export of observability data, offering services independent of third-party vendors.
>  
> OpenTelemetry is a collection of standards and tools designed to manage observability data such as Traces, Metrics, Logs, etc. (new types of observability data may emerge in the future). It is currently an industry standard.


> Tempo
>  
> Grafana Tempo is an open-source, easy-to-use, and scalable distributed tracing backend. Tempo is cost-effective, requiring only object storage to run and deeply integrates with Grafana, Prometheus, and Loki. Tempo can work with any open-source tracing protocol, including Jaeger, Zipkin, and OpenTelemetry.
>  
> The Tempo project was initiated by Grafana Labs in 2020 and announced in October at Grafana ObservabilityCON. Tempo is released under the AGPLv3 license.

> Loki
>  
> Loki is the latest open-source project from the Grafana Labs team, a horizontally scalable, highly available, multi-tenant log aggregation system. Its design is very cost-effective and easy to operate because it does not index log content but rather indexes a set of labels for each log stream. Inspired by Prometheus, the official introduction is: Like Prometheus, but for logs, similar to Prometheus' logging system.

### Architecture
![1653382087(1).png](../images/opentelemetry-grafana-1.png)

Execution Flow:

1. OTEL collects and outputs Trace data from Springboot applications and tags corresponding logs with Traceid and Spanid labels.
2. Tempo collects and processes OTEL data and stores it locally. Tempo Query is the retrieval backend service for Tempo.
3. Loki collects log data from Springboot applications.
4. Grafana Dashboard is used to display and view Tempo trace data and log data.

### Installation and Configuration

#### 1. Configure `docker-compose.yaml`

```yaml
version: '3.3'

services:
    server:
        image: registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-server:latest
        container_name: springboot_server
        ports:
            - 8080:8080
        environment:
            - OTEL_EXPORTER=otlp_span,prometheus
            - OTEL_EXPORTER_OTLP_ENDPOINT=http://tempo:55680
            - OTEL_EXPORTER_OTLP_INSECURE=true
            - OTEL_RESOURCE_ATTRIBUTES=service.name=springboot-server
            - JAVA_OPTS=-javaagent:/opentelemetry-javaagent.jar
        logging:
            driver: loki
            options:
                loki-url: 'http://localhost:3100/api/prom/push'
    loki:
        image: grafana/loki:2.2.0
        container_name: loki
        command: -config.file=/etc/loki/local-config.yaml
        ports:
            - "3100:3100"
        logging:
            driver: loki
            options:
                loki-url: 'http://localhost:3100/api/prom/push'
    tempo:
        image: grafana/tempo:0.6.0
        container_name: tempo
        command: ["--target=all", "--storage.trace.backend=local", "--storage.trace.local.path=/var/tempo", "--auth.enabled=false"]
        ports:
            - 8081:80
            - 55680:55680
    tempo-query:
        image: grafana/tempo-query:0.6.0
        container_name: tempo-query
        #command: ["--grpc-storage-plugin.configuration-file=/etc/tempo-query.yaml"]
        environment:
            - BACKEND=tempo:80
        volumes:
            - ./etc/tempo-query.yaml:/etc/tempo-query.yaml
        ports:
            - "16686:16686"  # jaeger-ui
        depends_on:
            - tempo
        logging:
            driver: loki
            options:
                loki-url: 'http://localhost:3100/api/prom/push'
    grafana:
        image: grafana/grafana:7.3.7
        container_name: grafana
        volumes:
            - ./config/grafana:/etc/grafana/provisioning/datasources
        environment:
            - GF_AUTH_ANONYMOUS_ENABLED=true
            - GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
            - GF_AUTH_DISABLE_LOGIN_FORM=true
        ports:
            - "3000:3000"
        logging:
            driver: loki
            options:
                loki-url: 'http://localhost:3100/api/prom/push'                
```

#### 2. Configure Grafana

After deploying the application, you can configure data sources in Grafana. New versions of Grafana support configuring data sources via YAML, making it convenient to preconfigure them.

```yaml
apiVersion: 1

deleteDatasources:
  - name: Prometheus
  - name: Tempo

datasources:
- name: Tempo
  type: tempo
  access: proxy
  orgId: 1
  url: http://tempo-query:16686
  basicAuth: false
  isDefault: false
  version: 1
  editable: false
  apiVersion: 1
  uid: tempo
- name: Loki
  type: loki
  access: proxy
  orgId: 1
  url: http://loki:3100
  basicAuth: false
  isDefault: false
  version: 1
  editable: false
  apiVersion: 1
  jsonData:
    derivedFields:
      - datasourceUid: tempo
        matcherRegex: (?:traceID|trace_id)=(\w+)
        name: TraceID
        url: $${__value.raw}
```

Loki parses logs to set URLs for matched traceids, enabling direct correlation queries between logs and traces, thus integrating log and trace information.

#### 3. Install Loki Docker Plugin
> _docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions_

#### 4. Start
> docker-compose up -d

#### 5. Check Startup Status
> docker-compose ps

![image.png](../images/opentelemetry-grafana-2.png)
#### 6. Access to Generate Trace and Log Information
> curl http://localhost:8080/gateway


### Observability

Through Grafana, input the filtering conditions for the application to retrieve corresponding log information. If the current log level is Error, Grafana highlights it in red for easy identification.

![image.png](../images/opentelemetry-grafana-3.png)

Clicking on the log entry allows you to view related tags. If the current log contains a traceid, Grafana automatically matches it to Tempo. Clicking the Tempo button redirects you to the detailed trace information for the current log. This facilitates quick problem localization.

![image.png](../images/opentelemetry-grafana-4.png)

Switch to the Tempo view to query trace details using the traceId.

![image.png](../images/opentelemetry-grafana-5.png)

### Extension

Tempo stores and retrieves traces, acting as a backend service. Tempo works alongside other tracing protocols like Jaeger, Zipkin, and OTEL. It is not considered a trace collector but rather a relay station where traces are aggregated from protocols such as Jaeger and Zipkin before being forwarded to Tempo.

As a new incubation product from Grafana-labs, Tempo is not yet mature. Issues encountered while using Tempo often require significant community support from the Grafana team, increasing communication overhead.

Loki, as a new log storage tool, has its own advantages and disadvantages:

Advantages

- Loki's architecture is very simple, using the same label indexing mechanism as Prometheus. These labels allow querying both log content and monitoring data, reducing the switching cost between different queries and significantly lowering the storage cost for log indexes.
- Compared to ELK, it is more cost-effective.
- It can be used with Grafana for log collection and visualization, enabling filtering and viewing of upstream and downstream data.

Disadvantages:

- The technology is relatively new, so the associated forums are not very active.
- Functionality is limited to log viewing and filtering, performing well in these areas but lacking in data processing and cleaning compared to ELK. Additionally, ELK can integrate various technologies for big data processing of logs, whereas Loki cannot.

The demo source code is available [here](https://github.com/lrwh/observable-demo/blob/main/opentelemetry-to-grafana).

[Next](./opentelemetry-guance.md) We will introduce and demonstrate OpenTelemetry-based observability on the Guance platform.