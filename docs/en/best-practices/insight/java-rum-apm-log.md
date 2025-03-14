# JAVA Application RUM-APM-LOG Linked Analysis

---

## Introduction to Use Cases

For enterprises, the most important source of revenue is business operations, and nowadays, most enterprise businesses are supported by corresponding IT systems. Ensuring the stability of business operations translates internally into ensuring the stability of internal IT systems. When a business system experiences anomalies or failures, colleagues from various departments such as business, application development, and operations often need to coordinate to diagnose issues, facing challenges like **cross-platform, cross-departmental, and cross-disciplinary** problems, which can be **time-consuming and labor-intensive**.

To address this issue, a mature approach in the industry is to deeply monitor the application layer and log layer in addition to infrastructure monitoring. By using **RUM+APM+LOG**, it enables unified management of the core **front-end and back-end applications and logs** of the entire business system. Advanced monitoring solutions can also correlate these three data sources through key fields for **linked analysis**, thereby improving work efficiency and ensuring stable system operation.

- APM: Application Performance Monitoring
- RUM: Real User Monitoring
- LOG: Logs

Currently, **<<< custom_key.brand_name >>>** has this capability. This article uses the Ruoyi office system as a demo to illustrate how to integrate RUM+APM+LOG monitoring and how to perform linked analysis using <<< custom_key.brand_name >>>.

## Installing DataKit

### 1 Copy Installation Command

Register and log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>), choose 「Integration」 - 「DataKit」, select an installation command suitable for your environment, and copy it.

![image](../images/java-rum-apm-log/1.png)

### 2 Install DataKit on Server

![image](../images/java-rum-apm-log/2.png)

### 3 Check DataKit Status

Run the command `systemctl status datakit`

![image](../images/java-rum-apm-log/3.png)

### 4 View Data

After installing DataKit, it will default collect the following content. You can view related data directly in 「<<< custom_key.brand_name >>>」 - 「Infrastructure」 - 「Host」

| Collector Name | Description                                             |
| -------------- | ------------------------------------------------------- |
| cpu            | Collects host CPU usage                                 |
| disk           | Collects disk usage                                     |
| diskio         | Collects host disk IO                                   |
| mem            | Collects host memory usage                              |
| swap           | Collects Swap memory usage                              |
| system         | Collects host operating system load                     |
| net            | Collects host network traffic                           |
| host_process   | Collects resident processes (surviving over 10 minutes) |
| hostobject     | Collects basic host information (OS info, hardware info)|
| docker         | Collects container objects and container logs           |

By choosing different integration input names, you can view corresponding monitoring views. Below the monitoring view, you can also view other data such as logs, processes, containers, etc.

![image](../images/java-rum-apm-log/4.png)

## RUM

> For detailed steps, refer to the document [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Copy JS Code

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>), choose 「User Access Monitoring」 - 「Create Application」 - 「Web」 - Load Type choose 「Synchronous Loading」

![image](../images/java-rum-apm-log/5.png)

### 2 Embed JS

Paste the JS code in the head of the front-end page `/usr/local/ruoyi/dist/index.html`

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

- **datakitOrigin**: Data transmission address. In production environments, if configured with a domain name, requests can be forwarded to any server running datakit on port 9529. If frontend traffic is high, you can add a load balancer (SLB) between the domain name and the datakit server. The frontend JS sends data to the SLB, which then forwards the request to multiple servers running datakit on port 9529. Multiple datakits handle RUM data without interrupting session data due to frontend request reuse, thus not affecting RUM data presentation.
- **allowedTracingOrigins**: Enables linking between frontend (RUM) and backend (APM). This only works when RUM is deployed on the frontend and APM on the backend. Enter the domain names (production environment) or IPs (test environment) of backend application servers that interact with the frontend pages. **Use Case**: If a frontend user's access is slow due to backend code logic issues, you can jump from the RUM slow request data directly to APM data to check the backend code call situation during that period, identifying the root cause. **Implementation Principle**: When users access the frontend application, the frontend application calls resources and requests, triggering rum-js performance data collection. rum-js generates a trace-id and writes it into the request header. When the request reaches the backend, ddtrace reads this trace_id and records it in its own trace data, thus achieving linked analysis of application performance monitoring and user access monitoring data through the same trace_id.
- **env**: Required, specifies the environment the application belongs to, such as test or product or other fields.
- **version**: Required, specifies the version number of the application.
- **trackInteractions**: Tracks user interactions, such as button clicks, form submissions, etc.

### 3 Publish

Save, validate, and publish the page.

Open the browser and visit the target page. Use F12 developer tools to check if there are `rum`-related requests in the network requests, and ensure the status code is `200`.

![image](../images/java-rum-apm-log/7.png)

???+ warning

    If F12 developer tools show data cannot be reported and displays "port refused," you can use `telnet IP:9529` to verify if the port is open.<br/>
    If not, modify `/usr/local/datakit/conf.d/datakit.conf`, changing the first line `http_listen` to `0.0.0.0`;<br/>
    If still not working, check if the security group has opened port `9529`.

    ![image](../images/java-rum-apm-log/8.png)

### 4 View RUM Data

View RUM-related data under 「User Access Monitoring」

![image](../images/java-rum-apm-log/9.png)

## APM

> For detailed steps, refer to the document [Distributed Tracing (APM) Best Practices](../monitoring/apm.md)

<<< custom_key.brand_name >>> supports APM integration methods including ddtrace, SkyWalking, Zipkin, Jaeger, and other OpenTracing protocol-supported APM tools. Here, we demonstrate observability using **ddtrace** for APM.

### 1 Modify Inputs

Modify APM (ddtrace) inputs in DataKit.

By default, no changes are needed for jvm inputs; just copy the generated conf file.

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# No modifications needed by default
```

### 2 Modify Java Application Startup Script

APM observability requires adding an agent to the Java application. This agent, when started with the application, uses bytecode injection to collect performance data on method calls, SQL calls, external system calls, etc., within the application, enabling observability of application code quality.

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
- Ddd.trace.sample.rate: Set sampling rate (default is full sampling), optional. If sampling is needed, set a value between 0 and 1, e.g., 0.6 for 60% sampling.
- Ddd.service.mapping: Add aliases for redis, mysql, etc., called by the current application to distinguish them from those called by other applications, optional. Use case: If projects A and B both call mysql but to different databases mysql-a and mysql-b, without adding mapping configuration, df platform will show both projects calling the same database named mysql. Adding mapping configurations as mysql-a and mysql-b will show project A calling mysql-a and project B calling mysql-b.
- Ddd.agent.host: Data transmission target IP, default is localhost, optional.

### 3 View APM Data

APM is a built-in module in <<< custom_key.brand_name >>>, so no additional scene or view creation is required for viewing.

Example view:<br/>
This view allows quick inspection of application call situations, topology diagrams, anomaly data, and other APM-related data.

![image](../images/java-rum-apm-log/10.png)

![image](../images/java-rum-apm-log/11.png)

Call chain problem tracking:<br/>
Can help diagnose interface and database issues.

![image](../images/java-rum-apm-log/12.png)

## LOG

### 1 Standard Log Collection

Examples: Nginx, MySQL, Redis, etc.

By enabling various built-in inputs in DataKit, you can directly start collecting relevant logs, such as [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [containers](../../integrations/container/docker.md), [ES](../../integrations/datastorage/elasticsearch.md).

**Example: Nginx**

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify log path to the correct nginx path
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline is grok statement mainly used for text log parsing. Datakit has built-in pipelines for nginx, mysql, etc., default directory is /usr/local/datakit/pipeline/, no need to modify pipeline path, datakit will automatically read it.
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
## Source and service are required fields, can use application name to distinguish different log names

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

  ## optional statuses:
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



## Pipeline is grok statement mainly used for text log parsing. If this configuration is not enabled, df platform will display raw log text. If filled, it will parse the corresponding log using grok. The .p file needs to be manually created.
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

## Demonstration of RUM and APM Data Linkage

**Principle Explanation**: When users access the frontend application (with RUM monitoring and configured **allowedTracingOrigins** field), the frontend application calls resources and requests, triggering rum-js performance data collection. rum-js generates a trace-id written in the request header. When the request reaches the backend, ddtrace reads this trace_id and records it in its own trace data, thus achieving linked analysis of application performance monitoring and user access monitoring data through the same trace_id.

**Use Case**: Correlating frontend and backend, binding frontend requests and backend method execution performance data one-to-one, making it easier to locate frontend-backend associated issues. For example, if frontend user login is slow due to backend service querying the database taking too long, linked analysis can quickly pinpoint the problem across teams and departments. Example below:

**Configuration Method**: [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Frontend RUM Data

![image](../images/java-rum-apm-log/19.png)

### 2 Navigate to Backend APM Data

![image](../images/java-rum-apm-log/20.png)

![image](../images/java-rum-apm-log/21.png)

## Demonstration of APM and LOG Data Linkage

### 1 Enable APM Monitoring

Refer to [Kubernetes Application RUM-APM-LOG Linked Analysis](../cloud-native/k8s-rum-apm-log.md) APM section, no additional actions required.

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

## Modify as shown in the image
## logfiles is the absolute path of the application log
## service and source are required fields for easy searching on df platform
## Pipeline can be set based on requirements, primarily used for log field parsing. Parsed log content can be stored as metrics for visualization. There's no need to parse trace-id related content for visualization.
```

![image](../images/java-rum-apm-log/23.png)

### 4 APM & LOG Linked Analysis

- **Forward Association [APM —— Log]**<br/>
  In APM trace data, directly search for `trace_id` in the log module below to view the application logs generated by this trace call.

![image](../images/java-rum-apm-log/24.png)

- **Reverse Association [Log —— APM]**<br/>
  View error logs, copy the `trace_id`, and search for this `trace_id` in the trace tracking page search box. This will retrieve all related trace and span data for that id. Click to view.

![image](../images/java-rum-apm-log/25.png)

![image](../images/java-rum-apm-log/26.png)