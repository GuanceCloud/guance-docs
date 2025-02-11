# Building Observability for a SpringCloud Service from 0 to 1 Using Guance

---

## Overview of the Project's Business System:

**This case study uses a simulated enterprise internal office system, building observability from scratch using Guance.**

**The observability setup chosen here is for a standalone JAR package application.**

**Project open-source address: [https://gitee.com/y_project/RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud)**

**Project demo address: [http://demo.ruoyi.vip/login](http://demo.ruoyi.vip/login)**

**System Introduction:**

This system is an open-source backend management system and also a Java EE enterprise-level rapid development platform based on various classic technology combinations (Spring Boot, Apache Shiro, MyBatis, Thymeleaf, Bootstrap, etc.). It includes modules such as department management, role and user management, menu and button authorization, data permissions, system parameters, log management, notifications, and announcements. The main purpose is to allow developers to focus on business logic, reduce technical complexity, save human resources, shorten project cycles, and improve software security and quality. This project can be used for all web applications, such as website management backends, member centers, CMS, CRM, OA, etc., and supports deep customization, allowing enterprises to build more powerful systems. All frontend and backend code is encapsulated to be simple and easy to use with a low error rate. Mobile client access is also supported.


**Project Functional Modules:**

- **User Management:** Configuration of system users.
- **Department Management:** Configuration of organizational structures (companies, departments, groups) with tree structure support and data permissions.
- **Position Management:** Configuration of roles assigned to users.
- **Menu Management:** Configuration of system menus, operation permissions, and button permission identifiers.
- **Role Management:** Role-based menu permission allocation and setting data scope permissions by organization.
- **Dictionary Management:** Maintenance of frequently used fixed data in the system.
- **Parameter Management:** Dynamic configuration of common parameters.
- **Notifications and Announcements:** Information release and maintenance for system notifications.
- **Operation Logs:** Recording and querying normal operation logs; recording and querying abnormal logs.
- **Login Logs:** Recording login attempts, including failed attempts.
- **Online Users:** Monitoring active user status in the system.
- **Scheduled Tasks:** Online task scheduling (add, modify, delete) including execution result logs.
- **Code Generation:** Generating front-end and back-end code (Java, HTML, XML, SQL) supporting CRUD downloads.
- **API Documentation:** Automatically generating API documentation based on business code.
- **Service Monitoring:** Monitoring CPU, memory, disk, stack, and other system information.
- **Cache Monitoring:** Querying, viewing, and clearing cache operations.
- **Online Builder:** Dragging form elements to generate corresponding HTML code.

**Technologies Involved in the Office System:**

| Technology          | Version            | Guance Inputs Required for Observability |
|---------------------|--------------------|------------------------------------------|
| SpringBoot           | 2.3.7.RELEASE      | ddtrace                                  |
| SpringCloud          | Hoxton.SR9         | ddtrace                                  |
| SpringCloud Alibaba  | 2.2.5.RELEASE      | ddtrace                                  |
| Nginx                | 1.16.1             | nginx                                    |
| MySQL                | 5.7.17             | mysql                                    |
| Redis                | 3.2.12             | redis                                    |
| Vue                  | 2.6.0              | rum                                      |
| Java                 | OpenJDK 1.8.0_292  | Statsd or jolokia<br />(this example uses statsd) |

**Office System Architecture:**

- Web Pages: Hosted in Nginx
- Registration Center: Nacos
- Gateway: Gateway
- Service Modules: Auth, System
- Database: MySQL
- Cache: Redis

*Note: In this demo, all service modules are deployed on the same server, using different ports for access.*

![image](../images/spring-cloud-sample/1.png)

## Introduction to Guance:

**Overview:** [Official Guance Introduction]

Guance is a cloud service platform designed to provide **full-stack observability** for every complete application in the era of cloud computing and cloud-native technologies, fundamentally different from traditional monitoring systems.

Traditional monitoring systems are often single-domain monitoring systems, similar to many isolated silos within an enterprise, such as APM, RUM, logs, NPM, Zabbix, etc., which are fragmented and isolated monitoring systems for applications, logs, infrastructure, etc. The result is a forest of silos, leading to data isolation within enterprises, making it difficult to correlate data across platforms and departments, requiring significant manpower and resources to locate issues.

**Observability** involves a comprehensive system for IT infrastructure that supports metrics, logs, and trace data collection, unified storage, querying, and visualization, correlating all observability data to achieve full-stack observability.

Guance is built on this concept, providing an observability solution aimed at improving internal IT service quality and enhancing end-user experience.

**Data Flow in Guance:**

![image](../images/spring-cloud-sample/2.png)

*Note: DQL is a specialized query language developed by DataFlux for querying data from Elasticsearch and InfluxDB.*

## Installing Datakit:

1. Log in to console.guance.com
2. Create a new workspace
3. Choose Integration —— Datakit —— Select suitable installation instructions for your environment and copy them
4. Install Datakit on the server
5. Run `service datakit status` (or `systemctl status datakit`) to check Datakit status

![image](../images/spring-cloud-sample/3.png)
![image](../images/spring-cloud-sample/4.png)
![image](../images/spring-cloud-sample/5.png)

**After installing Datakit, it will default to collecting the following data, which can be viewed under Dataflux —— Infrastructure —— Hosts.**

**By selecting different input names, you can view corresponding monitoring views, along with other data such as logs, processes, containers, etc.**

| Collector Name | Description                                               |
|----------------|-----------------------------------------------------------|
| cpu            | Collects host CPU usage                                    |
| disk           | Collects disk usage                                        |
| diskio         | Collects host disk I/O                                     |
| mem            | Collects host memory usage                                 |
| swap           | Collects Swap memory usage                                 |
| system         | Collects host OS load                                      |
| net            | Collects host network traffic                              |
| host_process   | Collects resident processes (surviving >10 minutes)        |
| hostobject     | Collects basic host information (OS info, hardware info)   |
| docker         | Collects container objects and container logs              |

![image](../images/spring-cloud-sample/6.png)

## Enabling Specific Inputs:

| Component | Input Enabled | Input Directory                     | Relevant Metrics                               |
|-----------|---------------|-------------------------------------|------------------------------------------------|
| Nginx     | √             | •/usr/local/datakit/conf.d/nginx    | Request info, logs, request duration, etc.     |
| MySQL     | √             | •/usr/local/datakit/conf.d/db       | Connections, QPS, read/write, slow queries     |
| Redis     | √             | •/usr/local/datakit/conf.d/db       | Connections, CPU, memory consumption, hit rate |
| JVM       | √             | •/usr/local/datakit/conf.d/statsd   | Heap memory, GC count, GC time                 |
| APM       | √             | •/usr/local/datakit/conf.d/ddtrace  | Response time, error count, error rate         |
| RUM       | Default Enabled | ——                                 | UV/PV, LCP, FID, CLS, JS errors                |

**Note:**

| RUM Metric Explanation | Description                                                                 | Target Value |
|------------------------|-----------------------------------------------------------------------------|--------------|
| LCP(Largest Contentful Paint) | Time taken to load the largest content element in the visible area of the webpage | <2.5s        |
| FID(First Input Delay)  | Delay time when the user first interacts with the webpage                   | <100ms       |
| CLS(Cumulative Layout Shift) | Measures layout shifts due to dynamic loading, 0 means no changes         | <0.1         |

### Nginx:

Refer to the document <[Nginx Observability Best Practices](../../best-practices/monitoring/nginx.md)>
<br />Prerequisite: Check if the **http_stub_status_module** module is enabled in Nginx, **skip step 1 if already installed.**

![image](../images/spring-cloud-sample/7.png)

1. Install the with-http_stub_status_module (Linux):
   To enable this module, recompile Nginx using the following command:
   **`./configure --with-http_stub_status_module`**
   Locate the configure file using:
   **`find /| grep configure |grep nginx`**

```shell
$ find /| grep configure |grep nginx
  
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```

![image](../images/spring-cloud-sample/8.png)

2. Add nginx_status location forwarding in nginx.conf

```shell
$ cd /etc/nginx   
   ## Adjust nginx path as needed
$ vim nginx.conf
```

```toml
$  server{
     listen 80;   
     server_name localhost;
     ## Port can be customized
     
      location /nginx_status {
          stub_status  on;
          allow 127.0.0.1;
          deny all;
                             }
                             
          }
```

3. Modify nginx inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim  nginx.conf

```

```toml
# Modify as follows
[[inputs.nginx]]
        url = http://localhost/nginx_status
[inputs.nginx.log]
        files = ["/var/log/nginx/access.log","/var/log/nginx /error.log"]

# Restart Datakit after saving the file    
$ service datakit restart
```

![image](../images/spring-cloud-sample/9.png)

**Verify data: `curl 127.0.0.1/nginx_status`**

![image](../images/spring-cloud-sample/10.png)

4. Create and view Nginx data in the Guance platform  
**Refer to [Creating Scenes and Views](#IVN7h)**
**Steps: Scene —> New Scene —> New Blank Scene —> System View (Create Nginx)**
**View Example (Quickly view Nginx-related metrics and logs to determine health):**

![image](../images/spring-cloud-sample/11.png)
![image](../images/spring-cloud-sample/12.png)

### MySQL:

Refer to the document <[MySQL DataKit Integration](../../integrations/mysql.md)>

```shell
# Log into MySQL 
$ mysql -uroot -p  
# Enter password: Solution****

# Create a monitoring user
$ CREATE USER 'datakit'@'localhost' IDENTIFIED BY 'Datakit_1234';

# Grant monitoring privileges
$ grant process,select,replication client on *.* to 'datakit'@'%' identified by 'Datakit_1234';

# Refresh privileges
flush privileges;
```

##### 1. Modify MySQL inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp mysql.conf.sample mysql.conf
$ vim mysql.conf

# Modify as follows 
## Suggest creating a custom read-only MySQL user
[[inputs.mysql]]
     user ="datakit"
     pass ="Datakit_1234“

# Restart Datakit after saving the file    
$ service datakit restart
```

![image](../images/spring-cloud-sample/13.png)

##### 2. Create and view MySQL data in the Guance platform

**Refer to [Creating Scenes and Views](#IVN7h)**
**Steps: Scene —> New Scene —> New Blank Scene —> System View (Create MySQL)**
**View Example (Quickly view MySQL-related metrics and logs to determine health):**

![image](../images/spring-cloud-sample/14.png)
![image](../images/spring-cloud-sample/15.png)

### Redis:

Refer to the document <[Redis DataKit Integration](../../integrations/redis.md)>

##### 1. Modify Redis inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp redis.conf.sample redis.conf
$ vim redis.conf

# Modify as follows
## Suggest creating a custom read-only Redis user
[[inputs.redis]]
     pass ="Solution******“
# Un-comment the pass line before modifying
[inputs.redis.log]
    files = ["/var/log/redis/redis.log"]

# Restart Datakit after saving the file    
$ service datakit restart
```

![image](../images/spring-cloud-sample/16.png)

##### 2. Create and view Redis data in the Guance platform

**Refer to [Creating Scenes and Views](#IVN7h)**
**Steps: Scene —> New Scene —> New Blank Scene —> System View (Create Redis)**
**View Example (Quickly view Redis-related metrics and logs to determine health):**

![image](../images/spring-cloud-sample/17.png)
![image](../images/spring-cloud-sample/18.png)

### JVM:

Refer to the document <[JVM DataKit Integration](../../integrations/jvm.md)>

##### 1. Modify JVM inputs in Datakit

**Default settings do not require modification; only need to copy and generate the conf file**

```shell
$ cd /usr/local/datakit/conf.d/statsd/
$ cp statsd.conf.sample ddtrace-jvm-statsd.conf 
$ vim ddtrace-jvm-statsd.conf

# No modification required by default
```

##### 2. Modify Java Application Startup Script

**### Since both JVM and APM use ddtrace-agent for data collection, refer to the APM section [APM] for details ###**

##### 3. Create and view JVM data in the Guance platform

**Refer to [Creating Scenes and Views](#IVN7h)**
**Steps: Scene —> New Scene —> New Blank Scene —> System View (Create JVM)**
**View Example (Quickly view JVM-related metrics and logs to determine health):**

![image](../images/spring-cloud-sample/19.png)

### APM (Application Performance Monitoring):

Refer to the document [Distributed Tracing (APM) Best Practices](../../best-practices/monitoring/apm.md)  
**Guance supports APM integrations via ddtrace, skywalking, zipkin, jaeger, and other opentracing-compatible tools. This example uses ddtrace for APM observability.**

##### 1. Modify APM (ddtrace) inputs in Datakit

**Default settings do not require modification; only need to copy and generate the conf file**

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# No modification required by default
```

##### 2. Modify Java Application Startup Script

To achieve APM observability, add an agent to the Java application. This agent collects performance data during application startup through bytecode injection, enabling observability of method calls, SQL calls, and external system calls.

```shell
# Original application startup script
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &
```

Kill existing application processes and add the ddtrace parameter, then restart the application. See the following figure for detailed steps:

![image](../images/spring-cloud-sample/20.png)

```shell
# Modified application startup script with ddtrace-agent

$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000  -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar  -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log  2>&1 & 
```

**If APM data does not appear in the Guance platform, check Datakit logs**
**cat /var/log/datakit/gin.log**  
Normal logs:

![image](../images/spring-cloud-sample/21.png)

Error logs:

![image](../images/spring-cloud-sample/22.png)

**For this error, modify** /usr/local/datakit/con.d/ddtrace/ddtrace.conf to match the following image  
**Ensure the path in ddtrace.conf matches the path in the datakit/gin.log**

![image](../images/spring-cloud-sample/23.png)

**Explanation of ddtrace Environment Variables (Startup Parameters):**

- Ddd.env: Custom environment type, optional.
- Ddd.tags: Custom application tags, optional.
- Ddd.service.name: Custom application name, required.
- Ddd.agent.port: Data upload port (default 9529), required.
- Ddd.version: Application version, optional.
- Ddd.trace.sample.rate: Set sampling rate (default is full sampling), optional. For sampling, set a value between 0~1, e.g., 0.6 for 60% sampling.
- Ddd.service.mapping: Map current application calls to Redis, MySQL, etc., for differentiation. Optional, useful when multiple projects call the same resource but need separate identification.
- Ddd.agent.host: Data transmission target IP, defaults to localhost, optional.

##### 3. View APM Data in the Guance Platform

**APM (Application Performance Monitoring) is a built-in module in Guance, accessible without creating scenes or views.**  
**Path: Guance Platform —— Application Performance Monitoring**  
**View Example: (Quickly view application calls, topology, anomalies, and other APM-related data)**

![image](../images/spring-cloud-sample/24.png)
![image](../images/spring-cloud-sample/25.png)
![image](../images/spring-cloud-sample/26.png)

### RUM (Real User Monitoring):

Refer to the document [[User Access (RUM) Observability Best Practices](web.md)]

##### 1. Log in to the DataFlux Platform

##### 2. Choose User Access Monitoring —— New Application —— Select Web Type —— Sync Load

![image](../images/spring-cloud-sample/27.png)

##### 3. Integrate Guance RUM observability JS file into the front-end index.html page

```shell
$ cd /usr/local/ruoyi/dist/

// Remember to backup
$ cp index.html index.html.bkd

// Add df-js to index.html
// Copy the JS content from the DF platform and place it before </head> in index.html, then save the file, as shown below

$ vim index.html
```

```javascript
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'xxxxxxxxxxxxxxxxxxxxxxxxxx',
      datakitOrigin: 'xxx.xxx.xxx.xxx:9529',
      env: 'test',
      version: '1.0.0',
      trackInteractions: true,
      allowedTracingOrigins:["xxx.xxx.xxx.xxx"]
      })
</script></head> 

# Replace xxx with actual values as needed, detailed changes are provided as follows:
```

> **datakitOrigin**: Data transmission address, in production environments, if configured as a domain, forward the domain request to any server with datakit-9529 port. If frontend traffic is high, consider adding an SLB layer between the domain and datakit servers. The frontend js sends data to the SLB, which forwards requests to multiple datakit-9529 servers. Multiple datakits handle RUM data without interrupting session data.
>
> **trackInteractions**: Enables user behavior tracking.
>
> **allowedTracingOrigins**: Connects frontend (RUM) and backend (APM) tracing. Fill in the domains/IPs of backend servers interacting with the frontend.

**Notes:**

- **datakitOrigin**: Data transmission address. In production environments, if configured as a domain, forward the domain request to any server with datakit-9529 port. If frontend traffic is high, consider adding an SLB layer between the domain and datakit servers. The frontend js sends data to the SLB, which forwards requests to multiple datakit-9529 servers. Multiple datakits handle RUM data without interrupting session data.

Example:

![image](../images/spring-cloud-sample/28.png)
![image](../images/spring-cloud-sample/29.png)

- **allowedTracingOrigins**: Connects frontend (RUM) and backend (APM) tracing. Fill in the domains/IPs of backend servers interacting with the frontend. **Use Case**: When frontend user access is slow due to backend code issues, RUM slow request data can directly link to APM data to identify the root cause. **Mechanism**: Frontend application triggers rum-js performance data collection, rum-js generates trace-id in request_header. Backend ddtrace reads this trace_id and records it in its own trace data, linking via the same trace_id.
- **env**: Required, application environment, e.g., test or product.
- **version**: Required, application version number.
- **trackInteractions**: Tracks user interactions like button clicks and form submissions.

![image](../images/spring-cloud-sample/30.png)

##### 4. Save, Verify, and Publish the Page

Open a browser and visit the target page, check the network requests via F12 developer tools to ensure RUM-related requests are present and status codes are 200.

![image](../images/spring-cloud-sample/31.png)

**Note**: If data cannot be reported and shows refused connection, use `telnet IP:9529` to verify the port. If blocked, modify `/usr/local/datakit/conf.d/datakit.conf` to change `http_listen` from `localhost` to `0.0.0.0`.

![image](../images/spring-cloud-sample/32.png)

##### 5. View RUM Data in User Access Monitoring

![image](../images/spring-cloud-sample/33.png)

##### 6. Demonstrating RUM and APM Integration

Configuration Method: [[Java Example](web.md#fpjkl)]

Use Case: Correlate frontend and backend data for easier issue localization. For example, if frontend user access is slow due to backend service issues, quickly cross-team and cross-departmental troubleshooting can be achieved.

![image](../images/spring-cloud-sample/34.png)
![image](../images/spring-cloud-sample/35.png)
![image](../images/spring-cloud-sample/36.png)
![image](../images/spring-cloud-sample/37.png)

### Security Checker:

**Security Checker Overview**: [Guance Official Documentation](/scheck)

Note: Currently supports **Linux** only.
Refer to the document [[Security Checker Installation and Configuration](/scheck/scheck-install/)]

##### 1. Install Security Checker

```shell
## Install
$ bash -c "$(curl https://static.guance.com/security-checker/install.sh)"
## Or execute   sudo datakit --install scheck
## Upgrade
$ bash -c "$(curl https://static.guance.com/security-checker/install.sh) --upgrade"
## Start/Stop Commands
$ systemctl start/stop/restart/status scheck
## Or
$ service scheck start/stop/restart/status
## Installation Directory  /usr/local/scheck
```

##### 2. Connect Security Checker to Datakit

Forward Security Checker data to Datakit, then to the DataFlux platform.

```shell
$ cd /usr/local/scheck/
$ vim scheck.conf
 
 
    # ##(required) directory contains script
    rule_dir='/usr/local/scheck/rules.d'

    # ##(required) output of the check result, support local file or remote http server
    # ##localfile: file:///your/file/path
    # ##remote:  http(s)://your.url
    output='http://127.0.0.1:9529/v1/write/security'


    # ##(optional)global cron, default is every 10 seconds
    #cron='*/10 * * * *'

    log='/usr/local/scheck/log'
    log_level='info'
    #disable_log=false
```

##### 3. View Security Checker Data

![image](../images/spring-cloud-sample/38.png)

### Logs:

Refer to the document [Log Collection](../../integrations/logging.md)

##### 1. Standard Log Collection (Nginx, MySQL, Redis, etc.)

Enable log collection through DataKit's built-in inputs for various services like [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [Containers](../../integrations/container/index.md), [ES](../../integrations/datastorage/elasticsearch.md), etc.

**Example: Nginx**

```toml
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify log paths to correct Nginx paths
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline is grok statements for text log parsing, DataKit has pre-built pipelines for Nginx, MySQL, etc. Default pipeline directory is /usr/local/datakit/pipeline/, no need to modify pipeline paths.
```

![image](../images/spring-cloud-sample/39.png)

**View Display:**

![image](../images/spring-cloud-sample/40.png)
![image](../images/spring-cloud-sample/41.png)

##### 2. Custom Log Collection (Application Logs, Business Logs, etc.)

**Example: Application Logs**

Pipeline (log grok parsing) [Guance Official Documentation](/datakit/pipeline/)

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample logging.conf
$ vim logging.conf

## Modify log paths to correct application log paths

## source and service are required fields, can use the application name to distinguish different log names

$  [inputs.nginx.log]
$    logfiles = [
      "/usr/local/ruoyi/logs/ruoyi-system/error.log",
      "/usr/local/ruoyi/logs/ruoyi-system/info.log",]
$    source = "ruoyi-system"
$    service = "ruoyi-system"
#    pipeline = "ruoyi-system.p"

## Pipeline is grok statements for text log parsing. If not specified, raw log content is displayed on the platform. If specified, logs are parsed according to the .p file, which needs to be manually written.
```

![image](../images/spring-cloud-sample/42.png)

```shell
$ cd /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

## Example:
# Log Format 
#2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - 查询用户

## Example grok, copy the following content to ruoyi_system.p

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:level} \\s+%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time)
```

![image](../images/spring-cloud-sample/43.png)

**View Display:**

![image](../images/spring-cloud-sample/44.png)
![image](../images/spring-cloud-sample/45.png)

### Creating Nginx Log Anomaly Detection:

1. Open the Guance platform —> Anomaly Detection Library —> New Detection Library —> Custom Monitoring
![image](../images/spring-cloud-sample/46.png)

2. Click on the newly created detection library name —> New Detection Rule —> New Log Detection
![image](../images/spring-cloud-sample/47.png)

3. Fill in the specific detection rule and save  
**Rule Name**: Nginx Log ERROR Count Exceeds Threshold  
**Detection Metric**: Refer to the diagram  
**Trigger Condition**: Result>=5  
**Event Name**: Nginx Log ERROR Count Exceeds Threshold Alert  
**Event Content**:
> Level: {status}  
> Host: {host}  
> Content: Too many ERROR logs, error count is {{ Result }}
> Recommendation: Too many ERROR logs indicate potential application issues; check application health.  
> **Detection Frequency**: 1 minute

![image](../images/spring-cloud-sample/48.png)

### Verifying Anomaly Detection Mechanism:

1. On the server, find and kill ruoyi-gateway related processes
2. 
```shell
$ ps -ef|grep ruoyi-gateway
$ kill -9 xxxxx
```

![image](../images/spring-cloud-sample/49.png)

2. Visit the ruoyi website (refresh multiple times, at least 5 times)

![image](../images/spring-cloud-sample/50.png)

3. Check event details on the Guance platform

![image](../images/spring-cloud-sample/51.png)
![image](../images/spring-cloud-sample/52.png)

4. Check Nginx log details and related views

![image](../images/spring-cloud-sample/53.png)
![image](../images/spring-cloud-sample/54.png)

### Troubleshooting During Input Enablement:

1. Check input error messages  
Guance uploads input status information to the platform periodically, view integration status under Infrastructure —— Specific Host.
**Example: Apache service down, input shows error**

![image](../images/spring-cloud-sample/55.png)
![image](../images/spring-cloud-sample/56.png)
![image](../images/spring-cloud-sample/57.png)

2. Check data reporting  

**Method 1:**  
**Run `curl 127.0.0.1:9529/monitor` in the browser or terminal**
![image](../images/spring-cloud-sample/58.png)  
**Method 2:**  
**Run `curl 127.0.0.1:9529/stats` in the browser or terminal**
![image](../images/spring-cloud-sample/59.png)

3. Check Datakit logs  

**Datakit log directory: cd /var/log/datakit**
![image](../images/spring-cloud-sample/60.png)


### Creating Scenes and Views:

#### Using System View Templates (Using Nginx as an Example)

1. **Scene —— New Scene**

![image](../images/spring-cloud-sample/61.png)

2. **New Blank Scene**

![image](../images/spring-cloud-sample/62.png)

3. **Enter Scene Name —— Confirm**

![image](../images/spring-cloud-sample/63.png)

4. **System View —— Create Nginx View**

![image](../images/spring-cloud-sample/64.png)

5. **View Nginx View**

![image](../images/spring-cloud-sample/65.png)
![image](../images/spring-cloud-sample/66.png)

6. **Other**

*Similar methods apply to other views. For custom view content and layout requirements, create a blank view and customize as needed.*

## Summary:

Thus, we have established observability for the demo office system's chain, metrics, logs, and infrastructure comprehensively.

Guance provides an overall good experience with easy configuration and management, offering a unified view for all metrics, traces, and logs, correlated by the same tag (host). This makes it easy to achieve cascading data association on the platform, thereby achieving overall IT system observability.

Combining anomaly detection further enables integrated system management, improving operational efficiency and IT decision-making capabilities.

The product continues to improve, with future features becoming more powerful, user-friendly, and aesthetically pleasing.

Guance aims to be the representative of observability!