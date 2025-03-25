# JAVA Application RUM-APM-LOG Linked Analysis

---

## Use Case Introduction

The most important source of revenue for enterprises is business, and nowadays, the majority of businesses are supported by corresponding IT systems. Therefore, ensuring the stability of a company's business ultimately comes down to ensuring the reliability of internal IT systems. When the business system experiences abnormalities or failures, it often requires coordination among colleagues from various departments such as business, application development, and operations, dealing with issues like **cross-platform, cross-department, and cross-disciplinary domains**, which can be **time-consuming and labor-intensive**.

To address this problem, an already mature approach in the industry involves not only monitoring infrastructure but also deeply monitoring the application layer and log layer. Through **RUM+APM+LOG**, unified management of the entire business system’s core **front-end and back-end applications and logs** is achieved. Advanced monitoring systems can further integrate these three types of data via key fields to achieve **linked analysis**, thereby improving the efficiency of relevant staff and ensuring smooth system operation.

- APM: Application Performance Monitoring
- RUM: Real User Monitoring
- LOG: Logs

Currently, **<<< custom_key.brand_name >>>** has the capability to do this. This article uses Ruoyi Office System as a demo to explain how to connect RUM+APM+LOG monitoring and how to use <<< custom_key.brand_name >>> for linked analysis.

## Install DataKit

### 1 Copy Installation Command

Register and log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>), select "Integration" - "DataKit", choose the installation command suitable for your environment, and copy it.

![image](../images/java-rum-apm-log/1.png)

### 2 Install DataKit on the Server

![image](../images/java-rum-apm-log/2.png)

### 3 Check DataKit Status

Execute the command `systemctl status datakit`

![image](../images/java-rum-apm-log/3.png)

### 4 View Data

After installing DataKit, it will default collect the following content, which can be viewed directly in 「<<< custom_key.brand_name >>>」 - 「Infrastructure」 - 「HOST」.

| Collector Name | Description                                                   |
| -------------- | ------------------------------------------------------------- |
| cpu            | Collects CPU usage statistics                                 |
| disk           | Collects disk usage                                          |
| diskio         | Collects disk IO information                                  |
| mem            | Collects memory usage                                         |
| swap           | Collects Swap memory usage                                    |
| system         | Collects operating system load                                |
| net            | Collects network traffic                                      |
| host_process   | Collects resident processes (alive for more than 10 minutes)  |
| hostobject     | Collects basic host information (such as OS and hardware info)|
| docker         | Collects container objects and container logs                 |

By selecting different integration input names, you can view corresponding monitoring views. Below the monitoring views, you can also check other data such as logs, processes, containers, etc.

![image](../images/java-rum-apm-log/4.png)

## RUM

> For detailed steps, refer to the document [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Copy JS Code

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>), select 「Synthetic Tests」 - 「Create」 - 「Web」 - Load Type as 「Synchronous Loading」

![image](../images/java-rum-apm-log/5.png)

### 2 Embed JS

Paste the JS code into the head section of the front-end page `/usr/local/ruoyi/dist/index.html`.

```javascript
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'appid_9c7fd257fd824300ba70f7e6d3f5083e',
      datakitOrigin: 'http://112.124.52.73:9529',
      env: 'dev',
      version: '1.0',
      trackInteractions: true,
      traceType: 'ddtrace',
      allowedTracingOrigins: ['http://112.124.52.73']
    })
</script>
```

![image](../images/java-rum-apm-log/6.png)

Parameter Explanation:

- **datakitOrigin**: The data transmission address. In production environments, if configured as a domain name, the domain request can be forwarded to any server running datakit on port 9529. If the frontend traffic is too high, an SLB can be added between the domain and the datakit server. Frontend JS sends data to the SLB, which forwards the requests to multiple servers running datakit on port 9529. Multiple datakits handle RUM data; due to frontend request reuse, session data won't be interrupted, nor will it affect the display of RUM data.
- **allowedTracingOrigins**: Achieves linkage between frontend and backend (APM and RUM). This scenario works when RUM is deployed on the frontend and APM on the backend. Here, you should fill in the domain names (for production) or IPs (for testing) of the backend application servers that interact with the frontend pages. **Use Case**: If a frontend user access is slow due to backend code logic anomalies, you can jump directly from the RUM slow request data to the APM data to view the backend code invocation details and determine the root cause of slowness. **Principle**: When users access the frontend application, the frontend application calls resources and requests, triggering rum-js performance data collection. Rum-js generates a trace-id written in the request_header. When the request reaches the backend, the ddtrace reads this trace_id and records it in its own trace data, thus enabling linked analysis of application performance monitoring and real-user monitoring data through the same trace_id.
- **env**: Mandatory, the environment the application belongs to, either test or product or other fields.
- **version**: Mandatory, the version number of the application.
- **trackInteractions**: User behavior statistics, such as button clicks, form submissions, etc.

### 3 Publish

Save, validate, and publish the page.

Open the browser and visit the target page. Use F12 Developer Tools to check whether there are `rum` related requests in the page network requests and whether the status code is `200`.

![image](../images/java-rum-apm-log/7.png)

???+ warning

    If the Developer Tools show that data cannot be reported and the port is refused, you can `telnet IP:9529` to verify whether the port is accessible.<br/>
    If it is inaccessible, modify `/usr/local/datakit/conf.d/datakit.conf`, changing the first line `http_listen` to `0.0.0.0`;<br/>
    If still inaccessible, check if the security group has opened port `9529`.

    ![image](../images/java-rum-apm-log/8.png)

### 4 View RUM Data

In 「Synthetic Tests」, you can view RUM-related data.

![image](../images/java-rum-apm-log/9.png)

## APM

> For detailed steps, refer to the document [Distributed Tracing (APM) Best Practices](../monitoring/apm.md)

<<< custom_key.brand_name >>> supports APM integration methods including ddtrace, SkyWalking, Zipkin, Jaeger, and other tools supporting the OpenTracing protocol. This example demonstrates achieving observability in APM using **ddtrace**.

### 1 Modify Inputs

Modify the APM (ddtrace) inputs in DataKit.

By default, there is no need to modify jvm inputs; simply copying the generated conf file is sufficient.

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# Default modification not required
```

### 2 Modify Java Application Startup Script

For APM observability, a Java agent needs to be added to the Java application. This agent, when accompanying the application startup, achieves bytecode injection to collect performance data related to internal method calls, SQL calls, external system calls, etc., thereby enabling observability of the application system's code quality.

```shell
# Original application startup script
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-auth.jar > logs/auth.log  2>&1 &
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &

——————————————————————————————————————————————————————————————————————————————————————————

# Modified application startup script with ddtrace-agent
$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000  -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar  -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &
```

**Explanation of ddtrace-related environment variables (startup parameters):**

- Ddd.env: Custom environment type, optional.
- Ddd.tags: Custom application tags, optional.
- Ddd.service.name: Custom application name, mandatory.
- Ddd.agent.port: Data upload port (default 9529), mandatory.
- Ddd.version: Application version, optional.
- Ddd.trace.sample.rate: Set sampling rate (default full sampling), optional. If sampling is needed, set a number between 0~1, e.g., 0.6 means 60% sampling.
- Ddd.service.mapping: Redis, MySQL, etc., called by the current application can be given aliases via this parameter to distinguish them from those called by other applications, optional. Use case: If both Project A and Project B call MySQL, specifically mysql-a and mysql-b, without adding mapping configuration, on the df platform, it would show both projects calling the same database named mysql. With mapping configurations like mysql-a and mysql-b, the df platform will show Project A calling mysql-a and Project B calling mysql-b.
- Ddd.agent.host: Data transmission target IP, default localhost, optional.

### 3 View APM Data

APM is a default built-in module in <<< custom_key.brand_name >>>, and no scene or view creation is required to view it.

View Example:<br/>
Through this view, you can quickly check application invocation situations, topology maps, exception data, and other APM-related data.

![image](../images/java-rum-apm-log/10.png)

![image](../images/java-rum-apm-log/11.png)

Issue tracking in the call chain:<br/>
You can troubleshoot interface and database problems.

![image](../images/java-rum-apm-log/12.png)

## LOG

### 1 Standard Log Collection

Examples: Nginx, MySQL, Redis, etc.

By enabling various built-in inputs in DataKit, you can directly start collecting related logs, such as [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [Containers](../../integrations/container/docker.md), [ES](../../integrations/datastorage/elasticsearch.md).

**Example: Nginx**

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify the log path to the correct nginx path
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline refers to grok statements mainly used for text log splitting. DataKit has built-in various pipelines including nginx, mysql, etc. The default directory for pipelines is /usr/local/datakit/pipeline/, and here there is no need to modify the pipeline path, as DataKit automatically reads it by default.
```

![image](../images/java-rum-apm-log/13.png)

**View Display:**

![image](../images/java-rum-apm-log/14.png)

![image](../images/java-rum-apm-log/15.png)

### 2 Custom Log Collection

Examples: Application logs, business logs, etc.

**Example: Application Logs**
Pipeline (log grok splitting) [**Official Documentation**](../../pipeline/use-pipeline/pipeline-quick-start.md)

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample system-logging.conf
$ vim system-logging.conf

## Modify the log path to the correct application log path
## Source and service are mandatory fields, which can directly use the application name to differentiate different log names

[[inputs.logging]]
  ## required
  logfiles = [
    "/usr/local/java/ruoyi/logs/ruoyi-system/info.log",
    "/usr/local/java/ruoyi/logs/ruoyi-system/error.log",
  ]

  ## glob filter
  ignore = [""]

  ## Your logging source, if empty, use 'default'
  source = "system-log"

  ## Add service tag, if empty, use $source.
  service = "system-log"

  ## Grok pipeline script path
  pipeline = "log_demo_system.p"

  ## Optional statuses:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## Optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  multiline_match = '''^\d{4}-\d{2}-\d{2}'''

  ## Removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false



## Pipeline refers to grok statements mainly used for text log splitting. If this configuration is not open, the raw log content will be displayed by default on the df platform. If filled, the corresponding logs will be split by grok. The .p file mentioned here must be manually created.
```

![image](../images/java-rum-apm-log/16.png)

```shell
$ /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - %{DATA:service1} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time)
```

![image](../images/java-rum-apm-log/17.png)

### 3 View Log Data

![image](../images/java-rum-apm-log/18.png)

## RUM and APM Data Linkage Demonstration

**Principle Introduction**: Users accessing the frontend application (already added RUM monitoring and configured the **allowedTracingOrigins** field), trigger rum-js performance data collection when the frontend application calls resources and requests. Rum-js generates a trace-id written in the request_header. When the request reaches the backend, the backend's ddtrace reads this trace_id and records it in its own trace data, thus achieving linked analysis of application performance monitoring and real-user monitoring data through the same trace_id.

**Use Case**: Frontend-backend association binds frontend request data with backend method execution performance data one-to-one, making it easier to locate issues related to frontend-backend associations. For example, if the frontend user login is slow because the backend service takes too long querying the database, you can quickly identify the issue across teams and departments through frontend-backend linked analysis, as shown below:

**Configuration Method**: [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Frontend RUM Data

![image](../images/java-rum-apm-log/19.png)

### 2 Jump to Backend APM Data

![image](../images/java-rum-apm-log/20.png)

![image](../images/java-rum-apm-log/21.png)

## APM and LOG Data Linkage Demonstration

### 1 Enable APM Monitoring

Refer to the APM part of [Kubernetes Application RUM-APM-LOG Linked Analysis](../cloud-native/k8s-rum-apm-log.md), no additional actions are required.

### 2 Modify Application Log Output Format

**This step requires developer involvement**, modify the application log output format file `logback/log4j`

![image](../images/java-rum-apm-log/22.png)

```xml
<!-- Log output format -->

<property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />
```

Save the xml file and re-publish the application.

### 3 Enable Log Monitoring

Example:

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp log.conf.sample ruoyi-system.conf
$ vim ruoyi-system.conf

## Modify the following content
## logfiles are absolute paths of application logs
## service and source are mandatory fields, convenient for searching on the df platform
## Pipeline can be set according to requirements. Pipeline is mainly used for log field splitting, and after splitting, log contents can be stored as metrics for visualization. There is no need to visualize trace-id related content, so splitting may not be necessary.
```

![image](../images/java-rum-apm-log/23.png)

### 4 APM & LOG Linked Analysis

- **Forward Association [APM —— Logs]**<br/>
  In APM trace data, search for `trace_id` directly in the log module below to view the corresponding application logs generated during this trace call.

![image](../images/java-rum-apm-log/24.png)

- **Reverse Association [Logs —— APM]**<br/>
  View abnormal logs, copy the `trace_id` from the logs, and search for this `trace_id` in the tracing page search box. You can find all trace and span data related to this id, and click to view.

![image](../images/java-rum-apm-log/25.png)

![image](../images/java-rum-apm-log/26.png)