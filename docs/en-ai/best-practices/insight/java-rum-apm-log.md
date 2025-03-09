# JAVA Application RUM-APM-LOG Joint Analysis

---

## Introduction to Use Cases

For enterprises, the most important source of revenue is business operations, and in today's environment, most business operations are supported by corresponding IT systems. Therefore, ensuring the stability of business operations translates into ensuring the stability of internal IT systems within the enterprise. When a business system encounters anomalies or failures, it often requires coordination among colleagues from various departments such as business, application development, and operations for troubleshooting. This process involves **cross-platform, cross-departmental, and cross-domain** challenges, making it both time-consuming and labor-intensive.

To address this issue, the industry has developed a mature approach: in addition to monitoring infrastructure, deeply monitor the application layer and log layer. By using **RUM+APM+LOG**, achieve unified management of the core **frontend and backend applications, logs** of the entire business system. Advanced monitoring systems can even link these three types of data through key fields, enabling **joint analysis** to improve work efficiency and ensure smooth system operation.

- APM: Application Performance Monitoring (APM) - Application performance monitoring
- RUM: Real User Monitoring (RUM) - Real user experience monitoring
- LOG: Logs

Currently, **<<< custom_key.brand_name >>>** has this capability. This article uses the Ruoyi office system as a demo to explain how to integrate RUM+APM+LOG monitoring and perform joint analysis using <<< custom_key.brand_name >>>.

## Installing DataKit

### 1 Copy Installation Command

Register and log in to [<<< custom_key.brand_name >>>](https://console.guance.com), choose "Integration" - "DataKit", select the installation command suitable for your environment, and copy it.

![image](../images/java-rum-apm-log/1.png)

### 2 Install DataKit on the Server

![image](../images/java-rum-apm-log/2.png)

### 3 Query DataKit Status

Run the command `systemctl status datakit`

![image](../images/java-rum-apm-log/3.png)

### 4 View Data

After DataKit is installed, it will default to collecting the following content. You can view related data directly in 「<<< custom_key.brand_name >>>」 - 「Infrastructure」 - 「Host」

| Collector Name | Description                                             |
| -------------- | ------------------------------------------------------- |
| cpu            | Collects CPU usage statistics                           |
| disk           | Collects disk usage statistics                          |
| diskio         | Collects disk IO statistics                             |
| mem            | Collects memory usage statistics                        |
| swap           | Collects swap memory usage statistics                   |
| system         | Collects operating system load statistics               |
| net            | Collects network traffic statistics                     |
| host_process   | Collects resident processes (alive for more than 10min) |
| hostobject     | Collects basic host information (OS, hardware, etc.)    |
| docker         | Collects container objects and container logs          |

By selecting different integration input names, you can view corresponding monitoring views. Below the monitoring view, you can also view other data, such as logs, processes, containers, etc.

![image](../images/java-rum-apm-log/4.png)

## RUM

> Detailed steps refer to the document [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Copy JS Code

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com), choose "User Access Monitoring" - "Create Application" - "Web" - Load Type select "Synchronous Load"

![image](../images/java-rum-apm-log/5.png)

### 2 Embed JS

Paste the JS code into the head of the frontend page `/usr/local/ruoyi/dist/index.html`

```javascript
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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

- **datakitOrigin**: Data transmission address. In production environments, if configured with a domain name, it can forward requests to any server running datakit on port 9529. If front-end traffic is high, an SLB can be added between the domain name and the datakit server to distribute the load across multiple servers. Multiple datakits can handle RUM data without affecting session continuity or data display.
- **allowedTracingOrigins**: Enables correlation between frontend (RUM) and backend (APM). This only works when RUM is deployed on the frontend and APM on the backend. Enter the domain names (production) or IPs (test) of backend application servers that interact with the frontend. **Use Case**: Slow frontend access due to backend code issues can be diagnosed by jumping from RUM slow request data to APM data to check backend code execution. **Implementation Principle**: Frontend applications trigger rum-js performance data collection, which generates a trace-id written into the request header. The backend ddtrace reads this trace_id and records it in its own trace data, allowing correlation via the same trace_id.
- **env**: Required, application environment (test, product, or other).
- **version**: Required, application version number.
- **trackInteractions**: Tracks user interactions like button clicks and form submissions.

### 3 Publish

Save, verify, and publish the page

Open the browser and visit the target page. Use F12 Developer Tools to check if there are `rum`-related requests with a status code of `200`.

![image](../images/java-rum-apm-log/7.png)

???+ warning

    If F12 Developer Tools show data cannot be reported and displays refused connection, use `telnet IP:9529` to verify if the port is open.<br/>
    If not, modify `/usr/local/datakit/conf.d/datakit.conf` and change the first line `http_listen` to `0.0.0.0`;<br/>
    If still not working, check if the security group has opened port `9529`.

    ![image](../images/java-rum-apm-log/8.png)

### 4 View RUM Data

View RUM-related data in "User Access Monitoring"

![image](../images/java-rum-apm-log/9.png)

## APM

> Detailed steps refer to the document [Distributed Tracing (APM) Best Practices](../monitoring/apm.md)

<<< custom_key.brand_name >>> supports APM integration methods including ddtrace, SkyWalking, Zipkin, Jaeger, and other tools compatible with the OpenTracing protocol. This example uses **ddtrace** to achieve observability for APM.

### 1 Modify Inputs

Modify APM (ddtrace) inputs in DataKit

Default configuration does not require modifying JVM inputs; just generate and copy the conf file.

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# Default settings do not need modification
```

### 2 Modify Java Application Startup Script

APM observability requires adding an agent to the Java application. This agent collects performance data during application startup using bytecode injection technology, capturing method calls, SQL calls, external system calls, etc., to observe the quality of application code.

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
- Ddd.service.name: Custom application name, required.
- Ddd.agent.port: Data upload port (default 9529), required.
- Ddd.version: Application version, optional.
- Ddd.trace.sample.rate: Set sampling rate (default full sample), optional. For sampling, set a value between 0 and 1, e.g., 0.6 for 60% sampling.
- Ddd.service.mapping: Alias for redis, mysql, etc., used to distinguish between different applications calling the same service, optional. **Use Case**: Projects A and B call different MySQL instances (mysql-a, mysql-b). Without mapping, they would appear as the same MySQL instance on the platform. With mapping, they are distinguished as mysql-a and mysql-b.
- Ddd.agent.host: Target IP for data transmission, default localhost, optional.

### 3 View APM Data

APM is a built-in module in <<< custom_key.brand_name >>>, so no additional scene or view creation is needed to view data.

Example View:
This view allows quick inspection of application calls, topology diagrams, anomaly data, and other APM-related data.

![image](../images/java-rum-apm-log/10.png)

![image](../images/java-rum-apm-log/11.png)

Call chain problem tracking:
Can diagnose interface, database, and other issues.

![image](../images/java-rum-apm-log/12.png)

## LOG

### 1 Standard Log Collection

Examples: Nginx, MySQL, Redis, etc.

By enabling various built-in inputs in DataKit, you can start collecting logs directly, such as [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [Containers](../../integrations/container/docker.md), [Elasticsearch](../../integrations/datastorage/elasticsearch.md).

**Example: Nginx**

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify log path to the correct nginx path
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline is a grok statement mainly used for text log parsing. DataKit already includes various pipelines, including nginx, mysql, etc. The default directory is /usr/local/datakit/pipeline/, so there's no need to modify the pipeline path.
```

![image](../images/java-rum-apm-log/13.png)

**View Display:**

![image](../images/java-rum-apm-log/14.png)

![image](../images/java-rum-apm-log/15.png)

### 2 Custom Log Collection

Examples: Application logs, business logs, etc.

**Example: Application Logs**
Pipeline (log grok parsing) [**Official Documentation**](../../pipeline/use-pipeline/pipeline-quick-start.md)

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample system-logging.conf
$ vim system-logging.conf

## Modify log path to the correct application log path
## Source and service are required fields and can be named after the application to distinguish different log names

[[inputs.logging]]
  ## required
  logfiles = [
    "/usr/local/java/ruoyi/logs/ruoyi-system/info.log",
    "/usr/local/java/ruoyi/logs/ruoyi-system/error.log",
  ]

  ## glob filter
  ignore = [""]

  ## your logging source, if empty, use 'default'
  source = "system-log"

  ## add service tag, if empty, use $source.
  service = "system-log"

  ## grok pipeline script path
  pipeline = "log_demo_system.p"

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  multiline_match = '''^\d{4}-\d{2}-\d{2}'''

  ## removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false

## Pipeline is a grok statement used for text log parsing. If not specified, raw log content is displayed on the df platform. If specified, logs are parsed using grok. The .p file needs to be manually created.
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

## RUM and APM Data Correlation Demonstration

**Principle Explanation**: User visits the frontend application (with RUM monitoring and configured **allowedTracingOrigins** field). The frontend application triggers rum-js performance data collection, generating a trace-id written into the request header. The backend ddtrace reads this trace_id and records it in its trace data, enabling joint analysis of application performance monitoring and user access monitoring data through the same trace_id.

**Use Case**: Correlating frontend and backend, binding frontend requests and backend method execution performance data one-to-one, making it easier to locate cross-team and cross-departmental issues. For example, if frontend login is slow due to backend database query taking too long, joint analysis can quickly pinpoint the root cause across teams and departments. Example:

**Configuration Method**: [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Frontend RUM Data

![image](../images/java-rum-apm-log/19.png)

### 2 Navigate to Backend APM Data

![image](../images/java-rum-apm-log/20.png)

![image](../images/java-rum-apm-log/21.png)

## APM and LOG Data Correlation Demonstration

### 1 Enable APM Monitoring

Refer to [Kubernetes Application RUM-APM-LOG Joint Analysis](../cloud-native/k8s-rum-apm-log.md) APM section, no additional actions required.

### 2 Modify Application Log Output Format

**Developer involvement required** to modify the application log output format file `logback/log4j`

![image](../images/java-rum-apm-log/22.png)

```xml
<!-- Log output format -->

<property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />
```

Save the XML file and redeploy the application.

### 3 Enable Log Monitoring

Example:

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp log.conf.sample ruoyi-system.conf
$ vim ruoyi-system.conf

## Modify as shown below
## logfiles is the absolute path of the application log
## service and source are required fields for easy lookup on the df platform
## Pipeline can be set based on requirements, mainly used for log field parsing, parsed log content can be visualized as metrics. Trace-id related content does not need visualization, so it can be left unparsed.
```

![image](../images/java-rum-apm-log/23.png)

### 4 APM & LOG Correlation Analysis

- **Forward Correlation [APM —— Log]**<br/>
  In APM trace data, directly search for `trace_id` in the log module to view the application logs generated by this trace call.

![image](../images/java-rum-apm-log/24.png)

- **Reverse Correlation [Log —— APM]**<br/>
  View abnormal logs, copy the `trace_id`, and search for this `trace_id` in the trace tracking page. This retrieves all related trace and span data for the id, which can be viewed.

![image](../images/java-rum-apm-log/25.png)

![image](../images/java-rum-apm-log/26.png)