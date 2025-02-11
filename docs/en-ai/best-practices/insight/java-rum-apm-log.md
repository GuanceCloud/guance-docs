# JAVA Application RUM-APM-LOG Linked Analysis

---

## Introduction to Application Scenarios

For enterprises, the most important source of revenue is business operations, and in today's environment, the majority of business operations are supported by corresponding IT systems. Ensuring the stability of business operations essentially means ensuring the stability of internal IT systems within the enterprise. When a business system experiences anomalies or failures, it often requires coordination among colleagues from multiple departments such as business, application development, and operations to diagnose the issue. This process can involve **cross-platform, cross-departmental, and cross-disciplinary** challenges, making it **time-consuming and labor-intensive**.

To address this problem, a mature approach in the industry is to implement deep monitoring at the application layer and log layer in addition to infrastructure monitoring. By using **RUM+APM+LOG**, this method enables unified management of the core **front-end and back-end applications and logs** of the entire business system. Advanced monitoring solutions can also correlate data from these three areas through key fields, enabling **linked analysis** to improve work efficiency and ensure stable system operation.

- APM: Application Performance Monitoring (APM)
- RUM: Real User Monitoring (RUM)
- LOG: Logs

Currently, **Guance** has this capability. This article uses the Ruoyi office system as a demo to explain how to integrate RUM+APM+LOG monitoring and how to use Guance for linked analysis.

## Installing DataKit

### 1 Copy Installation Commands

Register and log in to [Guance](https://console.guance.com), select "Integration" - "DataKit", choose the installation command suitable for your environment, and copy it.

![image](../images/java-rum-apm-log/1.png)

### 2 Install DataKit on the Server

![image](../images/java-rum-apm-log/2.png)

### 3 Check DataKit Status

Run the command `systemctl status datakit`

![image](../images/java-rum-apm-log/3.png)

### 4 View Data

After installing DataKit, it will default to collecting the following content. You can view the relevant data directly in "Guance" - "Infrastructure" - "Host".

| Collector Name | Description                                                   |
| -------------- | ------------------------------------------------------------- |
| cpu            | Collects CPU usage of the host                                |
| disk           | Collects disk usage                                           |
| diskio         | Collects disk IO information of the host                      |
| mem            | Collects memory usage of the host                             |
| swap           | Collects Swap memory usage                                    |
| system         | Collects operating system load of the host                    |
| net            | Collects network traffic information of the host              |
| host_process   | Collects resident processes (surviving over 10 minutes)       |
| hostobject     | Collects basic host information (e.g., OS info, hardware info)|
| docker         | Collects container objects and container logs on the host     |

Select different integration input names to view corresponding monitoring views. Below the monitoring view, you can also view other data, such as logs, processes, containers, etc.

![image](../images/java-rum-apm-log/4.png)

## RUM

> For detailed steps, refer to the document [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Copy JS Code

Log in to [Guance](https://console.guance.com), select "User Access Monitoring" - "Create New Application" - "Web" - Load Type choose "Synchronous Load"

![image](../images/java-rum-apm-log/5.png)

### 2 Embed JS

Paste the JS code into the head section of the front-end page `/usr/local/ruoyi/dist/index.html`

```javascript
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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

- **datakitOrigin**: Data transmission address. In production environments, if configured with a domain name, requests can be forwarded to any server running DataKit on port 9529. If frontend traffic is high, an SLB can be added between the domain name and the DataKit server. The frontend JS sends data to the SLB, which forwards it to multiple servers running DataKit on port 9529. Multiple DataKit instances handle RUM data without interrupting session data due to frontend request reuse, thus not affecting RUM data presentation.
- **allowedTracingOrigins**: To link frontend (RUM) and backend (APM) data, this setting is effective only when RUM is deployed on the frontend and APM on the backend. Enter the domain names (production environment) or IPs (test environment) of backend application servers interacting with the frontend. **Use Case**: If frontend user access is slow due to backend code logic issues, you can jump from the frontend RUM slow request data to the APM data to check the backend code invocation during that request to determine the root cause. **Implementation Principle**: User accesses the frontend application, triggering resource and request calls, which rum-js collects performance data for. rum-js generates a trace-id written into the request_header. When the request reaches the backend, ddtrace reads this trace_id and records it in its trace data, thus linking RUM and APM data through the same trace_id.
- **env**: Required, specifies the environment (test, product, or custom).
- **version**: Required, specifies the application version.
- **trackInteractions**: Tracks user interactions like button clicks and form submissions.

### 3 Publish

Save, validate, and publish the page.

Open a browser to visit the target page and use F12 Developer Tools to check if there are `rum` related requests with a status code of `200`.

![image](../images/java-rum-apm-log/7.png)

???+ warning

    If F12 Developer Tools show data cannot be reported and the port is refused, you can use `telnet IP:9529` to verify if the port is open.<br/>
    If not, modify `/usr/local/datakit/conf.d/datakit.conf`, changing the first line's `http_listen` to `0.0.0.0`;<br/>
    If still not working, check if the security group has opened port `9529`.

    ![image](../images/java-rum-apm-log/8.png)

### 4 View RUM Data

View RUM-related data in "User Access Monitoring"

![image](../images/java-rum-apm-log/9.png)

## APM

> Detailed steps refer to the document [Distributed Tracing (APM) Best Practices](../monitoring/apm.md)

Guance supports various APM integration methods including ddtrace, SkyWalking, Zipkin, Jaeger, and other OpenTracing protocol-compatible APM tools. Here we demonstrate using **ddtrace** for observability in APM.

### 1 Modify Inputs

Modify the APM (ddtrace) inputs in DataKit.

By default, no changes are needed for jvm inputs; simply generate the conf file.

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# No modifications required by default
```

### 2 Modify Java Application Startup Script

APM observability requires adding an agent to the Java application. This agent, when started with the application, uses bytecode injection to collect performance data on internal method calls, SQL calls, external system calls, etc., thereby providing observability into the quality of the application code.

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

**Explanation of ddtrace Environment Variables (Startup Parameters):**

- Ddd.env: Custom environment type, optional.
- Ddd.tags: Custom application tags, optional.
- Ddd.service.name: Custom application name, required.
- Ddd.agent.port: Data upload port (default 9529), required.
- Ddd.version: Application version, optional.
- Ddd.trace.sample.rate: Set sampling rate (default is full sampling), optional. If sampling is needed, set a value between 0 and 1, e.g., 0.6 for 60% sampling.
- Ddd.service.mapping: Add aliases for redis, mysql, etc., called by the current application to distinguish them from those called by other applications, optional. Use case: Projects A and B both call mysql-a and mysql-b respectively. Without mapping configuration, they would appear as calling the same mysql database on the df platform. With mapping configuration, project A calls mysql-a and project B calls mysql-b.
- Ddd.agent.host: Data transmission target IP, default is localhost, optional.

### 3 View APM Data

APM is a built-in module in Guance, so no additional scene or view creation is required to view the data.

Example view:<br/>
This view allows quick inspection of application call situations, topology diagrams, exception data, and other APM-related data.

![image](../images/java-rum-apm-log/10.png)

![image](../images/java-rum-apm-log/11.png)

Problem tracking in call chains:<br/>
Can help diagnose issues with interfaces, databases, etc.

![image](../images/java-rum-apm-log/12.png)

## LOG

### 1 Standard Log Collection

Examples: Nginx, MySQL, Redis, etc.

By enabling various built-in inputs in DataKit, you can directly start log collection for services like [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [containers](../../integrations/container/docker.md), [ES](../../integrations/datastorage/elasticsearch.md), etc.

**Example: Nginx**

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify log path to the correct Nginx path
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline is the grok statement used for text log parsing. DataKit already includes various pipelines, including nginx and mysql. Default pipeline directory is /usr/local/datakit/pipeline/, no need to modify pipeline path here as DataKit reads it automatically.
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
## Source and service are required fields, can use application name to differentiate log names

[[inputs.logging]]
  ## required
  logfiles = [
    "/usr/local/java/ruoyi/logs/ruoyi-system/info.log",
    "/usr/local/java/ruoyi/logs/ruoyi-system/error.log",
  ]

  ## glob filter
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "system-log"

  ## add service tag, if it's empty, use $source.
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



## Pipeline is the grok statement used for text log parsing. If this configuration is not enabled, the original log text will be displayed on the df platform. If filled, it parses the corresponding log via grok. The .p file needs to be manually created.
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

**Principle Explanation**: When users access the frontend application (with RUM monitoring and **allowedTracingOrigins** configured), the frontend application triggers resource and request calls, which rum-js collects performance data for. rum-js generates a trace-id written into the request_header. When the request reaches the backend, ddtrace reads this trace_id and records it in its trace data, thus linking RUM and APM data for analysis.

**Use Case**: Frontend-backend correlation, binding frontend requests and backend method execution performance data one-to-one, facilitating easier identification of frontend-backend related issues. For example, if frontend user login is slow because backend service calls to query user data from the database take too long, you can quickly locate the issue across teams and departments through linked analysis. Example:

**Configuration Method**: [Web Application Monitoring (RUM) Best Practices](../monitoring/web.md)

### 1 Frontend RUM Data

![image](../images/java-rum-apm-log/19.png)

### 2 Jump to Backend APM Data

![image](../images/java-rum-apm-log/20.png)

![image](../images/java-rum-apm-log/21.png)

## APM and LOG Data Linkage Demonstration

### 1 Enable APM Monitoring

Refer to the [Kubernetes Application RUM-APM-LOG Linked Analysis](../cloud-native/k8s-rum-apm-log.md) APM section, no additional actions required.

### 2 Modify Application Log Output Format

**This step requires developer involvement**, modify the application log output format file `logback/log4j`

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
## Pipeline can be configured based on requirements, mainly used for log field parsing. Parsed log content can be stored as metrics for visualization. There's no need to parse trace-id related content for visualization.
```

![image](../images/java-rum-apm-log/23.png)

### 4 APM & LOG Linked Analysis

- **Forward Association [APM —— Log]**<br/>
  In the APM trace data, search for `trace_id` in the log module below to view the corresponding application logs generated by the trace.

![image](../images/java-rum-apm-log/24.png)

- **Reverse Association [Log —— APM]**<br/>
  View error logs, copy the `trace_id`, and search for it in the trace tracing page to find all related traces and span data. Click to view.

![image](../images/java-rum-apm-log/25.png)

![image](../images/java-rum-apm-log/26.png)