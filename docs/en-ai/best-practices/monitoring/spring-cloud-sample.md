# Building Springcloud Service Observability from 0 to 1 Using <<< custom_key.brand_name >>>

---

## Overview of the Project's Business System:

**This case uses a simulated enterprise internal office system, building observability from scratch using <<< custom_key.brand_name >>>**

**The observability setup chosen here is for a standalone JAR application**

**Project open-source address: [https://gitee.com/y_project/RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud)**

**Project demo address: [http://demo.ruoyi.vip/login](http://demo.ruoyi.vip/login)**

**System Introduction**:

This system is an open-source backend management system and also a rapid development platform for Java EE enterprises based on numerous classic technology combinations (Spring Boot, Apache Shiro, MyBatis, Thymeleaf, Bootstrap, etc.). It includes many built-in modules such as department management, role users, menu and button authorization, data permissions, system parameters, log management, notifications, and announcements. The main purpose is to allow developers to focus on business logic, reduce technical difficulty, save manpower costs, shorten project cycles, and improve software security and quality.

This project can be used for all web applications, such as website management backends, member centers, CMS, CRM, OA, etc., while supporting deep customization. Enterprises can build more powerful systems. All frontend and backend code is well-packaged, making it easy to use with low error probability. Mobile client access is also supported.


**Project Functional Modules:**

- User Management: Users are system operators; this function mainly completes user configuration.
- Department Management: Configures organizational structures (companies, departments, groups) in a tree structure with data permission support.
- Position Management: Configures positions held by system users.
- Menu Management: Configures system menus, operation permissions, and button permission identifiers.
- Role Management: Assigns role-based menu permissions and sets data scope permissions by organization.
- Dictionary Management: Maintains frequently used fixed data within the system.
- Parameter Management: Dynamically configures commonly used parameters.
- Notifications: Manages information release and maintenance of system notifications.
- Operation Logs: Records and queries normal operation logs and system anomaly logs.
- Login Logs: Records login logs including anomalies.
- Online Users: Monitors active user status in the system.
- Scheduled Tasks: Manages task scheduling online (adding, modifying, deleting) including execution result logs.
- Code Generation: Generates front-end and back-end code (Java, HTML, XML, SQL) supporting CRUD downloads.
- API Documentation: Automatically generates related API documentation based on business code.
- Service Monitoring: Monitors current system CPU, memory, disk, stack, etc.
- Cache Monitoring: Performs cache queries, views, and clean-up operations.
- Online Builder: Generates corresponding HTML code by dragging form elements.


**Technologies Involved in the Office System:**

| Technology                | Version              | <<< custom_key.brand_name >>> Observability Inputs Required                 |
| ------------------- | ----------------- | ------------------------------------------ |
| SpringBoot          | 2.3.7.RELEASE     | ddtrace                                    |
| SpringCloud         | Hoxton.SR9        | ddtrace                                    |
| SpringCloud Alibaba | 2.2.5.RELEASE     | ddtrace                                    |
| Nginx               | 1.16.1            | nginx                                      |
| MySQL               | 5.7.17            | mysql                                      |
| Redis               | 3.2.12            | redis                                      |
| Vue                 | 2.6.0             | rum                                        |
| Java                | OpenJDK 1.8.0_292 | Statsd or jolokia<br /> (This example uses Statsd) |

**Office System Architecture:**

- Web Pages: Hosted in Nginx
- Registration Center: Nacos
- Gateway: Gateway
- Service Modules: Auth, System
- Database: MySQL
- Cache: Redis

*Note: This demo deploys all service modules on the same server, using different ports for service access.*

![image](../images/spring-cloud-sample/1.png)

## <<< custom_key.brand_name >>> Overview:

**Overview:** [<<< custom_key.brand_name >>> Official Overview]

<<< custom_key.brand_name >>> is a cloud service platform designed to build **full-stack observability** for each complete application in the era of cloud computing and cloud-native applications. It fundamentally differs from traditional monitoring systems.

Traditional monitoring systems are often single-domain monitoring systems, like many silos within an enterprise, such as APM, RUM, logs, NPM, Zabbix, etc., which are isolated and fragmented monitoring systems for applications, logs, infrastructure, etc. This leads to data silos within the enterprise, causing issues during troubleshooting that require cross-departmental and cross-platform efforts, consuming significant resources.

The concept of **observability** involves a comprehensive system to observe IT systems supporting business operations, encompassing metrics, logs, and tracing components. It achieves unified data collection, storage, querying, and visualization, correlating metrics, traces, and logs to provide complete IT system observability.

<<< custom_key.brand_name >>> is developed based on this philosophy, aiming to enhance the quality of internal IT services and improve end-user experience.

**<<< custom_key.brand_name >>> Data Flow:**

![image](../images/spring-cloud-sample/2.png)

*Note: DQL is a specialized query language developed by Dataflux for querying ES and InfluxDB data.*

## Installing Datakit:

1. Log in to console.guance.com
2. Create a new workspace
3. Choose Integrations —— Datakit —— Select suitable installation instructions for your environment and copy them
4. Install Datakit on the server
5. Execute `service datakit status` (or `systemctl status datakit`) to check Datakit status
![image](../images/spring-cloud-sample/3.png)
![image](../images/spring-cloud-sample/4.png)
![image](../images/spring-cloud-sample/5.png)

**After installing Datakit, it defaults to collecting the following content, which can be viewed directly in Dataflux —— Infrastructure —— Hosts**

**Select different integration input names to view corresponding monitoring views, and additional data such as logs, processes, containers, etc., can be viewed below the monitoring views.**

| Collector Name   | Description                                                 |
| ------------ | ---------------------------------------------------- |
| cpu          | Collects host CPU usage                              |
| disk         | Collects disk usage                                  |
| diskio       | Collects host disk I/O                               |
| mem          | Collects host memory usage                           |
| swap         | Collects Swap memory usage                           |
| system       | Collects host OS load                                |
| net          | Collects host network traffic                        |
| host_process | Collects resident processes (surviving over 10 minutes)      |
| hostobject   | Collects basic host information (OS info, hardware info, etc.) |
| docker       | Collects possible container objects and container logs                 |


![image](../images/spring-cloud-sample/6.png)

## Enabling Specific Inputs:

| Component Involved | Inputs Required | Input Directory                     | Related Metrics                                   |
| -------- | ------------ | ---------------------------------- | ------------------------------------------ |
| Nginx    | √            | •/usr/local/datakit/conf.d/nginx   | Request information, logs, request duration, etc.                 |
| MySQL    | √            | •/usr/local/datakit/conf.d/db      | Connection count, QPS, read/write status, slow queries              |
| Redis    | √            | •/usr/local/datakit/conf.d/db      | Connection count, CPU usage, memory usage, hit rate, loss rate |
| JVM      | √            | •/usr/local/datakit/conf.d/statsd  | Heap memory, GC frequency, GC time                    |
| APM      | √            | •/usr/local/datakit/conf.d/ddtrace | Response time, error count, error rate                 |
| RUM      | Default Enabled   | ——                                 | UV/PV, LCP, FID, CLS, JS errors               |

**Note:**

| RUM Metric Description                   | Description                                                            | Target Value    |
| ----------------------------- | --------------------------------------------------------------- | --------- |
| LCP(Largest Contentful Paint) | Measures the time it takes to load the largest content element within the visible area of the webpage. | Less than 2.5s  |
| FID(First Input Delay)        | Measures the delay when a user first interacts with the webpage. | Less than 100ms |
| CLS(Cumulative Layout Shift)  | Measures whether the page content shifts due to dynamic loading, 0 indicates no changes. | Less than 0.1   |

### Nginx:

Refer to the document <[Nginx Observability Best Practices](../../best-practices/monitoring/nginx.md)>
<br />Prerequisite: Check if the **http_stub_status_module** module is enabled in Nginx, **skip step 1 if already installed.**

![image](../images/spring-cloud-sample/7.png)

1. Install with-http_stub_status_module (Linux):  
Enabling this module requires recompiling Nginx. Use the following commands:
**`./configure --with-http_stub_status_module`**  
Find the configure file location:
**`find / | grep configure | grep nginx`**      

```shell
$ find / | grep configure | grep nginx
  
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```  

![image](../images/spring-cloud-sample/8.png)  

2. Add nginx_status location forwarding in nginx.conf  

```shell
$ cd /etc/nginx   
   ## Adjust the nginx path according to your actual situation
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
# Modify the following content
[[inputs.nginx]]
        url = http://localhost/nginx_status
[inputs.nginx.log]
        files = ["/var/log/nginx/access.log","/var/log/nginx/error.log"]

# Save the file and restart Datakit    
$ service datakit restart
```  

![image](../images/spring-cloud-sample/9.png)  

**Verify Data: `curl 127.0.0.1/nginx_status`**  

![image](../images/spring-cloud-sample/10.png)

4. Create an Nginx View in the <<< custom_key.brand_name >>> Platform and View Data  
**Creation steps refer to [Create Scenarios and Views](#IVN7h)**  
**Steps: Scenarios —— New Scenario —— New Blank Scenario —— System View (Create Nginx)**  
**View Example (through this view you can quickly check Nginx-related metrics and log information to determine the health status of Nginx):**  

![image](../images/spring-cloud-sample/11.png)

![image](../images/spring-cloud-sample/12.png)

### MySQL:

Refer to the document <[MySQL DataKit Integration](../../integrations/mysql.md)>

```shell
# Log into MySQL 
$ mysql -uroot -p  
# Enter password: Solution****

# Create a monitoring account
$ CREATE USER 'datakit'@'localhost' IDENTIFIED BY 'Datakit_1234';

# Grant monitoring account privileges
$ grant process,select,replication client on *.* to 'datakit'@'%' identified by 'Datakit_1234';

# Refresh privileges
flush privileges;
```

##### 1. Modify MySQL inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp mysql.conf.sample mysql.conf
$ vim mysql.conf

# Modify the following content 
## It is recommended to create a read-only MySQL account
[[inputs.mysql]]
     user ="datakit"
     pass ="Datakit_1234“

# Save the file and restart Datakit    
$ service datakit restart
```

![image](../images/spring-cloud-sample/13.png)

##### 2. Create a MySQL View in the <<< custom_key.brand_name >>> Platform and View Data

**Creation steps refer to [Create Scenarios and Views](#IVN7h)**
**Steps: Scenarios —— New Scenario —— New Blank Scenario —— System View (Create MySQL)**
**View Example (through this view you can quickly check MySQL-related metrics and log information to determine the health status of MySQL):**

![image](../images/spring-cloud-sample/14.png)

![image](../images/spring-cloud-sample/15.png)

### Redis:

Refer to the document <[Redis DataKit Integration](../../integrations/redis.md)>

##### 1. Modify Redis inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp redis.conf.sample redis.conf
$ vim redis.conf

# Modify the following content
## It is recommended to create a read-only Redis account
[[inputs.redis]]
     pass ="Solution******“
# Note: Uncomment the pass line before modifying
[inputs.redis.log]
    files = ["/var/log/redis/redis.log"]

# Save the file and restart Datakit    
$ service datakit restart
```

![image](../images/spring-cloud-sample/16.png)

##### 2. Create a Redis View in the <<< custom_key.brand_name >>> Platform and View Data

**Creation steps refer to [Create Scenarios and Views](#IVN7h)**
**Steps: Scenarios —— New Scenario —— New Blank Scenario —— System View (Create Redis)**
**View Example (through this view you can quickly check Redis-related metrics and log information to determine the health status of Redis):**

![image](../images/spring-cloud-sample/17.png)

![image](../images/spring-cloud-sample/18.png)

### JVM:

Refer to the document <[JVM DataKit Integration](../../integrations/jvm.md)>

##### 1. Modify JVM inputs in Datakit

**Default configuration does not need modification; only generate conf files**

```shell
$ cd /usr/local/datakit/conf.d/statsd/
$ cp statsd.conf.sample ddtrace-jvm-statsd.conf 
$ vim ddtrace-jvm-statsd.conf

# No default modifications required
```

##### 2. Modify Java Application Startup Script

**### Since JVM and APM both rely on ddtrace-agent for data collection, see APM-related content for the application startup script [APM] ###**

##### 3. Create a JVM View in the <<< custom_key.brand_name >>> Platform and View Data

**Creation steps refer to [Create Scenarios and Views](#IVN7h)**
**Steps: Scenarios —— New Scenario —— New Blank Scenario —— System View (Create JVM)**
**View Example (through this view you can quickly check JVM-related metrics and log information to determine the health status of JVM):**

![image](../images/spring-cloud-sample/19.png)

### APM (Application Performance Monitoring):

Refer to the document [Distributed Tracing (APM) Best Practices](../../best-practices/monitoring/apm.md)  
**<<< custom_key.brand_name >>> supports multiple APM tools compliant with the OpenTracing protocol, such as ddtrace, SkyWalking, Zipkin, Jaeger. This example uses ddtrace to achieve APM observability.**

##### 1. Modify APM (ddtrace) inputs in Datakit

**Default configuration does not need modification; only generate conf files**

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# No default modifications required
```

##### 2. Modify Java Application Startup Script

APM observability requires adding an agent to the Java application. This agent collects performance data through bytecode injection techniques, capturing method calls, SQL calls, external system calls, etc., thus enabling observability of application code quality.

```shell
# Original application startup script
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &
```

Kill existing application startup processes and add ddtrace parameters, then restart the application. Refer to the following image for kill methods:

![image](../images/spring-cloud-sample/20.png)

```shell
# Modified application startup script with ddtrace-agent

$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000  -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar  -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log  2>&1 & 
```

**If no APM data is seen in the <<< custom_key.brand_name >>> platform, check the Datakit logs**
**cat /var/log/datakit/gin.log**  
Normal logs:

![image](../images/spring-cloud-sample/21.png)

Error logs:

![image](../images/spring-cloud-sample/22.png)

**Modify** `/usr/local/datakit/con.d/ddtrace/ddtrace.conf` to match the paths shown in the images  
Ensure the path in `ddtrace.conf` matches the path in the `datakit/gin.log`.

![image](../images/spring-cloud-sample/23.png)

**Explanation of ddtrace Environment Variables (Startup Parameters):**

- `Ddd.env`: Custom environment type, optional.
- `Ddd.tags`: Custom application tags, optional.
- `Ddd.service.name`: Custom application name, required.
- `Ddd.agent.port`: Data upload port (default 9529), required.
- `Ddd.version`: Application version, optional.
- `Ddd.trace.sample.rate`: Set sampling rate (default is full sampling), optional, set between 0 and 1, e.g., 0.6 for 60% sampling.
- `Ddd.service.mapping`: Map current application calls to Redis, MySQL, etc., to distinguish them from other applications, optional. For example, projects A and B both call MySQL-a and MySQL-b respectively. Without mapping, they would appear as the same MySQL database in <<< custom_key.brand_name >>>. With mapping configured as MySQL-a and MySQL-b, they will appear correctly distinguished.
- `Ddd.agent.host`: Data transmission target IP, default is localhost, optional.

##### 3. View APM Data in <<< custom_key.brand_name >>> Platform

**APM (Application Performance Monitoring) is a built-in module in <<< custom_key.brand_name >>>, no need to create scenarios or views.**  
**Path: <<< custom_key.brand_name >>> Platform —— Application Performance Monitoring**  
**View Example: (Through this view you can quickly check application calls, topology maps, abnormal data, and other APM-related data)**

![image](../images/spring-cloud-sample/24.png)

![image](../images/spring-cloud-sample/25.png)

![image](../images/spring-cloud-sample/26.png)

### RUM (Real User Monitoring):

Refer to the document [[User Access (RUM) Observability Best Practices](web.md)]

##### 1. Log in to the Dataflux Platform

##### 2. Choose User Access Monitoring —— New Application —— Select Web Type —— Synchronous Load

![image](../images/spring-cloud-sample/27.png)

##### 3. Integrate <<< custom_key.brand_name >>> RUM Observability JS File in index.html Frontend Page

```shell
$ cd /usr/local/ruoyi/dist/

// Remember to backup
$ cp index.html index.html.bkd

// Add df-js in index.html before </head>, then save the file, as follows

$ vim index.html
```

```javascript
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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

# Replace xxx with actual values, detailed changes are as follows:
```

> **datakitOrigin**: Data transmission address, production environments should use domain names or SLB addresses, test environments should use internal IP addresses, corresponding to the datakit server's 9529 port.
>    
> **trackInteractions**: Configuration for user behavior collection, enables tracking of user actions on the page.
> 
> **allowedTracingOrigins**: Configuration to connect front-end (RUM) and back-end (APM), fill in the domain names or IPs of back-end servers interacting with the front-end page as needed.


**Notes:**

- **datakitOrigin**: Data transmission address. In production environments, if a domain name is configured, it can forward requests to any server with datakit running on port 9529. If front-end traffic is high, consider adding an SLB between the domain name and the datakit server. The SLB should open port **9529**, forwarding requests to multiple servers running datakit on port **9529**. Multiple datakits handle RUM data without affecting session data continuity or RUM data presentation.

Example:

![image](../images/spring-cloud-sample/28.png)

![image](../images/spring-cloud-sample/29.png)

- **allowedTracingOrigins**: Connects front-end (RUM) and back-end (APM). This scenario applies only when RUM is deployed on the front-end and APM on the back-end. Fill in the domain names (production) or IPs (test) of back-end servers interacting with the front-end page. **Use Case**: Slow front-end user access caused by back-end code issues can be traced through RUM slow request data to APM data to identify root causes. **Mechanism**: When users access the front-end application, rum-js captures resource and request performance data, generating a trace-id in the request header. The back-end ddtrace reads this trace_id and records it in its trace data, allowing correlation via the same trace-id.
- **env**: Required, specifies the environment (test or product or other).
- **version**: Required, specifies the application version.
- **trackInteractions**: Tracks user interactions such as button clicks and form submissions.

![image](../images/spring-cloud-sample/30.png)

##### 4. Save, Verify, and Publish the Page

Open a browser and visit the target page. Use F12 Developer Tools to check if there are RUM-related requests with a 200 status code.

![image](../images/spring-cloud-sample/31.png)

**Note!!**: If F12 Developer Tools show data cannot be reported and the port is refused, use `telnet IP:9529` to verify if the port is open. If not, modify `/usr/local/datakit/conf.d/datakit.conf` to change `http_listen` from `localhost` to `0.0.0.0`.

![image](../images/spring-cloud-sample/32.png)

##### 5. View RUM Data in User Access Monitoring

![image](../images/spring-cloud-sample/33.png)

##### 6. Demonstration of RUM and APM Data Correlation

Configuration method: [[Java Example](web.md#fpjkl)]

Use Case: Correlate front-end and back-end data to bind front-end requests with back-end method execution performance data, facilitating problem localization across teams and departments. For example, slow front-end user access due to back-end service issues can be quickly diagnosed. Example:

![image](../images/spring-cloud-sample/34.png)

![image](../images/spring-cloud-sample/35.png)

![image](../images/spring-cloud-sample/36.png)

![image](../images/spring-cloud-sample/37.png)

### Security Checker (Security Check):

**Security Checker Overview**: [<<< custom_key.brand_name >>> Official Overview](/scheck)]

Note: Currently supports only **Linux**
Refer to the document [[Security Checker Installation and Configuration](/scheck/scheck-install/)]

##### 1. Install Security Checker

```shell
## Install
$ bash -c "$(curl https://<<< custom_key.static_domain >>>/security-checker/install.sh)"
## Or execute   sudo datakit --install scheck
## Update
$ bash -c "$(curl https://<<< custom_key.static_domain >>>/security-checker/install.sh) --upgrade"
## Start/Stop Commands
$ systemctl start/stop/restart/status scheck
## Or
$ service scheck start/stop/restart/status
## Installation Directory  /usr/local/scheck
```

##### 2. Connect Security Checker to Datakit

Send Security Checker data to Datakit, then forward it to the Dataflux platform.

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

Enable various built-in inputs in DataKit to directly collect relevant logs, such as [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [Containers](../../integrations/container/index.md), [ES](../../integrations/datastorage/elasticsearch.md), etc.

**Example: Nginx**

```toml
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify log path to the correct Nginx path
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline is a Grok statement for text log parsing. DataKit has built-in pipelines for Nginx, MySQL, etc. The default pipeline directory is /usr/local/datakit/pipeline/, so there is no need to modify the pipeline path. DataKit automatically reads these pipelines.
```

![image](../images/spring-cloud-sample/39.png)

**View Display:**

![image](../images/spring-cloud-sample/40.png)

![image](../images/spring-cloud-sample/41.png)

##### 2. Custom Log Collection (Application Logs, Business Logs, etc.)

**Example: Application Logs**

Pipeline (log Grok parsing) [<<< custom_key.brand_name >>> Official Documentation](/datakit/pipeline/)

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample logging.conf
$ vim logging.conf

## Modify log path to the correct application log path

## source and service are required fields, can be directly named after the application to distinguish different log names

$  [inputs.nginx.log]
$    logfiles = [
      "/usr/local/ruoyi/logs/ruoyi-system/error.log",
      "/usr/local/ruoyi/logs/ruoyi-system/info.log",]
$    source = "ruoyi-system"
$    service = "ruoyi-system"
#    pipeline = "ruoyi-system.p"

## Pipeline is a Grok statement for text log parsing. If this configuration is not enabled, raw log content is displayed on the <<< custom_key.brand_name >>> platform. If filled, it performs Grok parsing on the specified log. Here, you need to manually write the .p file.
```

![image](../images/spring-cloud-sample/42.png)

```shell
$ cd /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

## Example:
# Log format 
#2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - Query user

## Example Grok, copy the following content to ruoyi_system.p

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:level} \\s+%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time)
```

![image](../images/spring-cloud-sample/43.png)

**View Display:**

![image](../images/spring-cloud-sample/44.png)

![image](../images/spring-cloud-sample/45.png)


### Creating Nginx Log Anomaly Detection:

1. Open <<< custom_key.brand_name >>> Platform —— Anomaly Detection Library —— New Detection Library —— Custom Monitoring
![image](../images/spring-cloud-sample/46.png)

2. Click on the newly created detection library name —— New Detection Rule —— New Log Detection
![image](../images/spring-cloud-sample/47.png)

3. Fill in specific detection rule details and save  
**Rule Name**: Nginx Log ERROR Count Exceeds Threshold  
**Detection Metric**: See figure  
**Trigger Condition**: Result>=5  
**Event Name**: Nginx Log ERROR Count Exceeds Threshold Alert  
**Event Content**:
> Level: {status}  
> Host: {host}  
> Content: Too many ERROR logs, number of errors is {{ Result }}
> Suggestion: Too many ERROR logs, the application may have issues, recommend checking the application health.  
> **Detection Frequency**: 1 minute

![image](../images/spring-cloud-sample/48.png)

### Verifying Anomaly Detection Mechanism:

1. Query and kill the ruoyi-gateway process on the server
2. 
```shell
$ ps -ef|grep ruoyi-gateway
$ kill -9 xxxxx
```

![image](../images/spring-cloud-sample/49.png)

2. Visit the ruoyi website (refresh multiple times, at least 5 times)

![image](../images/spring-cloud-sample/50.png)

3. View <<< custom_key.brand_name >>> Platform event details

![image](../images/spring-cloud-sample/51.png)

![image](../images/spring-cloud-sample/52.png)

4. View Nginx log details and related views

![image](../images/spring-cloud-sample/53.png)

![image](../images/spring-cloud-sample/54.png)

### Troubleshooting During Input Setup:

1. View Input Error Messages  
<<< custom_key.brand_name >>> uploads input status information to the <<< custom_key.brand_name >>> platform at certain intervals, which can be viewed directly under Infrastructure —— Specific Host.  
**Example: Apache service downtime, input shows errors**

![image](../images/spring-cloud-sample/55.png)
![image](../images/spring-cloud-sample/56.png)
![image](../images/spring-cloud-sample/57.png)

2. View Data Upload Information  

**Method 1:**  
**Input `curl 127.0.0.1:9529/monitor` in the browser or terminal to view**
![image](../images/spring-cloud-sample/58.png)  
**Method 2:**  
**Input `curl 127.0.0.1:9529/stats` in the browser or terminal to view**
![image](../images/spring-cloud-sample/59.png)

3. View Datakit Logs  

**Datakit log directory: cd /var/log/datakit**
![image](../images/spring-cloud-sample/60.png)


### Creating Scenarios and Views:

#### Using System View Templates (Using Nginx as an Example) ####

1. **Scenarios —— New Scenario**

![image](../images/spring-cloud-sample/61.png)

2. **New Blank Scenario**

![image](../images/spring-cloud-sample/62.png)

3. **Enter Scenario Name —— Confirm**

![image](../images/spring-cloud-sample/63.png)

4. **System View —— Nginx View (Create)**

![image](../images/spring-cloud-sample/64.png)

5. **View Nginx View**

![image](../images/spring-cloud-sample/65.png)
![image](../images/spring-cloud-sample/66.png)

6. **Other**

*Other view creation methods are similar. For custom view content and layout requirements, create a blank view and build it yourself.*

## Summary:

Thus, we have achieved comprehensive observability for the demo office system's chain, metrics, logs, and infrastructure.

<<< custom_key.brand_name >>> offers a convenient configuration and management experience, providing a unified view for all metrics, traces, and logs, correlated via a single tag (host). This allows for easy cascading within the platform, achieving overall IT system observability.

Finally, combining anomaly detection enables integrated system management, enhancing operational and development efficiency and improving IT decision-making capabilities!

This product is continuously improving, with future features becoming more powerful, user-friendly, and aesthetically pleasing.

<<< custom_key.brand_name >>> aims to be the spokesperson for observability!