# Building Springcloud Service Observability from 0 to 1 with <<< custom_key.brand_name >>>

---

## Overview of the Business System in This Project:

**This case study uses a simulated enterprise internal office system, building its observability from scratch using <<< custom_key.brand_name >>>**

**The observability setup chosen for this project is based on a standalone JAR package application**

**Project open-source address: [https://gitee.com/y_project/RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud)**

**Project demo address: [http://demo.ruoyi.vip/login](http://demo.ruoyi.vip/login)**

**System Introduction**:

This system is an open-source backend management system and also a rapid development platform for Java EE enterprise applications, built on classic technology combinations (Spring Boot, Apache Shiro, MyBatis, Thymeleaf, Bootstrap, etc.). It includes numerous built-in modules such as department management, role-user, menu and button authorization, data permissions, system parameters, log management, notifications, and announcements. The main goal is to allow developers to focus on business logic, reducing technical complexity and saving human resources, shortening project cycles, and improving software security and quality. This project can be used for all web applications, such as website management backends, website member centers, CMS, CRM, OA, etc., while supporting deep customization, allowing enterprises to build more powerful systems. All frontend and backend code is encapsulated and easy to use, with a low probability of errors. Mobile client access is also supported.


**Project Feature Modules:**

- User Management: Configuration of system users.
- Department Management: Configuration of organizational structures (companies, departments, teams) with tree structure support and data permission settings.
- Position Management: Configuration of positions held by system users.
- Menu Management: Configuration of system menus, operation permissions, and button permission identifiers.
- Role Management: Allocation of menu permissions and setting role-based data scope permissions.
- Dictionary Management: Maintenance of frequently used fixed data in the system.
- Parameter Management: Dynamic configuration of common parameters.
- Notifications and Announcements: Maintenance of system information releases.
- Operation Logs: Recording and querying of normal operation logs; recording and querying of system exception logs.
- Login Logs: Querying login logs including abnormal logins.
- Online Users: Monitoring the status of active users in the system.
- Scheduled Tasks: Online operations (addition, modification, deletion) of scheduled tasks including execution result logs.
- Code Generation: Generation of front-end and back-end code (Java, HTML, XML, SQL) supporting CRUD downloads.
- System APIs: Automatic generation of API documentation based on business code.
- Service Monitoring: Monitoring CPU, memory, disk, stack, and other information of the current system.
- Cache Monitoring: Operations like querying, viewing, and clearing cache.
- Online Builder: Dragging form elements to generate corresponding HTML code.


**Technologies Involved in the Office System:**

| Technology                | Version              | <<< custom_key.brand_name >>> Observability Inputs Required                 |
| ------------------- | ----------------- | ------------------------------------------ |
| SpringBoot          | 2.3.7.RELEASE     | ddtrace                                    |
| SpringCloud         | Hoxton.SR9        | ddtrace                                    |
| SpringCloud Alibaba | 2.2.5.RELEASE     | ddtrace                                    |
| Nginx               | 1.16.1            | nginx                                      |
| Mysql               | 5.7.17            | mysql                                      |
| Redis               | 3.2.12            | redis                                      |
| Vue                 | 2.6.0             | rum                                        |
| Java                | OpenJDK 1.8.0_292 | Statsd or jolokia<br /> (statsd used in this example) |

**Office System Architecture:**

- Web Pages: Hosted in Nginx
- Registration Center: Nacos
- Gateway: Gateway
- Service Modules: Auth, System
- Database: MySQL
- Cache: Redis

*Note: This demo deploys all service modules on a single server, accessing services via different ports.*

![image](../images/spring-cloud-sample/1.png)

## <<< custom_key.brand_name >>> Overview:

**Overview:** [<<< custom_key.brand_name >>> Official Overview]

<<< custom_key.brand_name >>> is a cloud service platform designed to provide **full-stack observability** for every complete application in the era of cloud computing and cloud-native systems, fundamentally different from traditional monitoring systems.

Traditional monitoring systems are often domain-specific, similar to many isolated silos within enterprises, such as APM, RUM, logs, NPM, Zabbix, etc., each being a separate and fragmented monitoring system. These silos lead to data isolation within enterprises, causing significant challenges in cross-departmental and cross-platform issue diagnosis, consuming substantial human and material resources.

The concept of **observability** involves a comprehensive system that provides observability for IT infrastructure supporting business systems, encompassing metrics, logs, and trace components. It achieves unified data collection, storage, query, and presentation, and correlates all observability data (metrics, traces, logs), enabling complete observability of the IT system.

<<< custom_key.brand_name >>> is developed based on this philosophy, aiming to enhance the quality of internal IT services within enterprises and improve end-user experience.

**<<< custom_key.brand_name >>> Data Flow:**

![image](../images/spring-cloud-sample/2.png)

*Note: DQL is a specialized QL language developed by DataFlux for correlated queries of ES and InfluxDB data.*

## Installing Datakit:

1. Log in to console.guance.com
2. Create a new workspace
3. Select Integration — Datakit — Choose the installation command suitable for your environment and copy it
4. Install Datakit on the server
5. Execute `service datakit status` (or `systemctl status datakit`) to check the Datakit status
![image](../images/spring-cloud-sample/3.png)
![image](../images/spring-cloud-sample/4.png)
![image](../images/spring-cloud-sample/5.png)

**After installing Datakit, it defaults to collecting the following content, which can be viewed directly under DataFlux — Infrastructure — Hosts**

**Select different integration input names to view corresponding monitoring views. Below the monitoring view, you can also view other data such as logs, processes, containers, etc.**

| Collector Name   | Description                                                 |
| ------------ | ---------------------------------------------------- |
| cpu          | Collects host CPU usage                              |
| disk         | Collects disk usage                                  |
| diskio       | Collects host disk IO                                |
| mem          | Collects host memory usage                           |
| swap         | Collects Swap memory usage                           |
| system       | Collects host OS load                                |
| net          | Collects host network traffic                        |
| host_process | Collects resident processes (alive for over 10 minutes)      |
| hostobject   | Collects basic host information (OS, hardware info, etc.) |
| docker       | Collects container objects and container logs        |

![image](../images/spring-cloud-sample/6.png)

## Enabling Specific Inputs:

| Component Involved | Input to Enable | Directory of Input File                     | Relevant Metrics                                   |
| -------- | ------------ | ---------------------------------- | ------------------------------------------ |
| Nginx    | √            | •/usr/local/datakit/conf.d/nginx   | Request information, logs, request duration, etc. |
| MySQL    | √            | •/usr/local/datakit/conf.d/db      | Connections, QPS, read/write stats, slow queries |
| Redis    | √            | •/usr/local/datakit/conf.d/db      | Connections, CPU usage, memory usage, hit rate, loss rate |
| JVM      | √            | •/usr/local/datakit/conf.d/statsd  | Heap memory, GC count, GC time                    |
| APM      | √            | •/usr/local/datakit/conf.d/ddtrace | Response time, error count, error rate           |
| RUM      | Enabled by default   | ——                                 | UV/PV, LCP, FID, CLS, JS errors               |

**Note:**

| RUM Metric Explanation                   | Description                                                            | Target Value    |
| ----------------------------- | --------------------------------------------------------------- | --------- |
| LCP(Largest Contentful Paint) | Time taken to load the largest content element in the visible area of the webpage | Less than 2.5s  |
| FID(First Input Delay)        | Delay when the user first interacts with the webpage                               | Less than 100ms |
| CLS(Cumulative Layout Shift)  | Whether page layout changes due to dynamic loading, 0 means no change. | Less than 0.1   |

### Nginx:

For detailed steps, refer to the document <[Nginx Observability Best Practices](../../best-practices/monitoring/nginx.md)>
<br />Prerequisite: Check if the **http_stub_status_module** module is enabled in Nginx, **skip step 1 if already installed.**

![image](../images/spring-cloud-sample/7.png)

1. Install the http_stub_status_module (Linux):
To enable this module, recompile Nginx with the following command:
**`./configure --with-http_stub_status_module`**
Locate the configure file using:
**`find / | grep configure | grep nginx`**

```shell
$ find / | grep configure | grep nginx
  
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```

![image](../images/spring-cloud-sample/8.png)

2. Add the nginx_status location in nginx.conf

```shell
$ cd /etc/nginx   
   ## Adjust nginx path as needed
$ vim nginx.conf
```

```toml
$  server {
     listen 80;   
     server_name localhost;
     ## Port can be customized
     
      location /nginx_status {
          stub_status on;
          allow 127.0.0.1;
          deny all;
                             }
                             
          }
```

3. Modify the nginx inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

```

```toml
# Modify as follows
[[inputs.nginx]]
        url = "http://localhost/nginx_status"
[inputs.nginx.log]
        files = ["/var/log/nginx/access.log", "/var/log/nginx/error.log"]

# Save the file and restart Datakit    
$ service datakit restart
```

![image](../images/spring-cloud-sample/9.png)

**Verify data: `curl 127.0.0.1/nginx_status`**

![image](../images/spring-cloud-sample/10.png)

4. Create an Nginx view in the <<< custom_key.brand_name >>> platform and view data  
**Refer to [Creating Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create Nginx)**
**View Example (quickly check Nginx-related metrics and logs to determine Nginx health):**

![image](../images/spring-cloud-sample/11.png)

![image](../images/spring-cloud-sample/12.png)

### MySQL:

For detailed steps, refer to the document <[MySQL DataKit Integration](../../integrations/mysql.md)>

```shell
# Log in to MySQL 
$ mysql -uroot -p  
# Enter password: Solution****

# Create a monitoring account
$ CREATE USER 'datakit'@'localhost' IDENTIFIED BY 'Datakit_1234';

# Grant monitoring account privileges
$ GRANT PROCESS, SELECT, REPLICATION CLIENT ON *.* TO 'datakit'@'%' IDENTIFIED BY 'Datakit_1234';

# Refresh privileges
FLUSH PRIVILEGES;
```

##### 1. Modify MySQL inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp mysql.conf.sample mysql.conf
$ vim mysql.conf

# Modify as follows 
## It's recommended to create a read-only MySQL account
[[inputs.mysql]]
     user = "datakit"
     pass = "Datakit_1234"

# Save the file and restart Datakit    
$ service datakit restart
```

![image](../images/spring-cloud-sample/13.png)

##### 2. Create a MySQL view in the <<< custom_key.brand_name >>> platform and view data

**Refer to [Creating Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create MySQL)**
**View Example (quickly check MySQL-related metrics and logs to determine MySQL health):**

![image](../images/spring-cloud-sample/14.png)

![image](../images/spring-cloud-sample/15.png)

### Redis:

For detailed steps, refer to the document <[Redis DataKit Integration](../../integrations/redis.md)>

##### 1. Modify Redis inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp redis.conf.sample redis.conf
$ vim redis.conf

# Modify as follows
## It's recommended to create a read-only Redis account
[[inputs.redis]]
     pass = "Solution******"
# Note: Uncomment the pass line before modifying
[inputs.redis.log]
    files = ["/var/log/redis/redis.log"]

# Save the file and restart Datakit    
$ service datakit restart
```

![image](../images/spring-cloud-sample/16.png)

##### 2. Create a Redis view in the <<< custom_key.brand_name >>> platform and view data

**Refer to [Creating Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create Redis)**
**View Example (quickly check Redis-related metrics and logs to determine Redis health):**

![image](../images/spring-cloud-sample/17.png)

![image](../images/spring-cloud-sample/18.png)

### JVM:

For detailed steps, refer to the document <[JVM DataKit Integration](../../integrations/jvm.md)>

##### 1. Modify JVM inputs in Datakit

**By default, there is no need to modify JVM inputs; only copying the generated conf file is required**

```shell
$ cd /usr/local/datakit/conf.d/statsd/
$ cp statsd.conf.sample ddtrace-jvm-statsd.conf 
$ vim ddtrace-jvm-statsd.conf

# No modifications needed by default
```

##### 2. Modify the Java application startup script

**Since JVM and APM both rely on ddtrace-agent for data collection, see APM-related content [APM]**

##### 3. Create a JVM view in the <<< custom_key.brand_name >>> platform and view data

**Refer to [Creating Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create JVM)**
**View Example (quickly check JVM-related metrics and logs to determine JVM health):**

![image](../images/spring-cloud-sample/19.png)

### APM (Application Performance Monitoring):

For detailed steps, refer to the document [Distributed Tracing (APM) Best Practices](../../best-practices/monitoring/apm.md)  
**<<< custom_key.brand_name >>> supports multiple APM tools that adhere to the OpenTracing protocol, including ddtrace, SkyWalking, Zipkin, Jaeger, etc. This example uses ddtrace for APM observability.**

##### 1. Modify APM (ddtrace) inputs in Datakit

**By default, there is no need to modify JVM inputs; only copying the generated conf file is required**

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# No modifications needed by default
```

##### 2. Modify the Java application startup script

APM observability requires adding an agent to the Java application. This agent collects performance data during application startup through bytecode injection, capturing method calls, SQL calls, external system calls, etc., to monitor the quality of the application code.

```shell
# Original application startup scripts
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8 -jar ruoyi-gateway.jar > logs/gateway.log 2>&1 &
$ nohup java -Dfile.encoding=utf-8 -jar ruoyi-auth.jar > logs/auth.log 2>&1 &
$ nohup java -Dfile.encoding=utf-8 -jar ruoyi-modules-system.jar > logs/system.log 2>&1 &
```

Kill existing application startup processes and add ddtrace parameters before restarting the application. See the following image for details:

![image](../images/spring-cloud-sample/20.png)

```shell
# Application startup script with ddtrace-agent added

$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log 2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log 2>&1 & 

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log 2>&1 & 
```

**If APM data is not visible in the <<< custom_key.brand_name >>> platform, check the Datakit logs**
**cat /var/log/datakit/gin.log**  
Normal logs:

![image](../images/spring-cloud-sample/21.png)

Error logs:

![image](../images/spring-cloud-sample/22.png)

**Modify /usr/local/datakit/con.d/ddtrace/ddtrace.conf to match the following image**
**Ensure the path in ddtrace.conf matches the path in datakit/gin.log**

![image](../images/spring-cloud-sample/23.png)

**Explanation of ddtrace environment variables (start parameters):**

- Ddd.env: Custom environment type, optional.
- Ddd.tags: Custom application tags, optional.
- Ddd.service.name: Custom application name, required.
- Ddd.agent.port: Data upload port (default 9529), required.
- Ddd.version: Application version, optional.
- Ddd.trace.sample.rate: Set sampling rate (default full sample), optional, e.g., 0.6 for 60% sampling.
- Ddd.service.mapping: Add aliases for Redis, MySQL, etc., called by the current application, to distinguish them from those called by other applications, optional. For example, projects A and B call MySQL-a and MySQL-b respectively. Without mapping configuration, <<< custom_key.brand_name >>> will show both projects calling a database named MySQL. With mapping configured as MySQL-a and MySQL-b, <<< custom_key.brand_name >>> will show project A calling MySQL-a and project B calling MySQL-b.
- Ddd.agent.host: Data transmission target IP, default is localhost, optional.

##### 3. View APM Data in the <<< custom_key.brand_name >>> Platform

**APM (Application Performance Monitoring) is a default built-in module in <<< custom_key.brand_name >>>, requiring no scenario or view creation for viewing.**  
**Path: <<< custom_key.brand_name >>> platform — Application Performance Monitoring**  
**View Example: (quickly check application calls, topology, anomaly data, and other APM-related data)**

![image](../images/spring-cloud-sample/24.png)

![image](../images/spring-cloud-sample/25.png)

![image](../images/spring-cloud-sample/26.png)

### RUM (Real User Monitoring):

For detailed steps, refer to the document [[User Access (RUM) Observability Best Practices](web.md)]

##### 1. Log in to the Dataflux platform

##### 2. Choose User Access Monitoring —> New Application —> Select Web Type —> Synchronous Loading

![image](../images/spring-cloud-sample/27.png)

##### 3. Integrate <<< custom_key.brand_name >>> RUM observability JS file into the frontend index.html page

```shell
$ cd /usr/local/ruoyi/dist/

// Remember to back up
$ cp index.html index.html.bkd

// Add df-js to index.html before </head>, then save the file, example:

$ vim index.html
```

```javascript
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'xxxxxxxxxxxxxxxxxxxxxxxxxx',
      datakitOrigin: 'xxx.xxx.xxx.xxx:9529',
      env: 'test',
      version: '1.0.0',
      trackInteractions: true,
      allowedTracingOrigins: ["xxx.xxx.xxx.xxx"]
    })
</script></head> 

# Replace xxx with actual values as needed, refer to the following for detailed changes:
```

> **datakitOrigin**: Data transmission address, in production environments, if configured as a domain name, requests can be forwarded to any server running datakit-9529. If frontend traffic is high, consider adding a load balancer between the domain name and datakit servers. The load balancer must have port **9529** open and forward requests to multiple datakit-**9529** servers. Multiple datakit servers handle RUM data without session interruption.
>
> **trackInteractions**: User behavior collection configuration, enabling tracking of user actions on the frontend.
>
> **allowedTracingOrigins**: Configuration for connecting frontend (RUM) and backend (APM), fill in the domain names or IPs of backend servers interacting with the frontend.

**Notes:**

- **datakitOrigin**: Data transmission address. In production, if configured as a domain name, requests can be forwarded to any server running datakit-9529. If frontend traffic is high, consider adding a load balancer between the domain name and datakit servers. The load balancer must have port **9529** open and forward requests to multiple datakit-**9529** servers. Multiple datakit servers handle RUM data without session interruption.
- **allowedTracingOrigins**: Connects frontend (RUM) and backend (APM). Fill in the domain names (production) or IPs (testing) of backend servers interacting with the frontend. **Use Case**: Slow frontend visits caused by backend code issues can be traced via RUM data to APM data for root cause analysis.
- **env**: Required, environment of the application, e.g., test or product.
- **version**: Required, application version number.
- **trackInteractions**: Tracks user interactions, e.g., button clicks, form submissions.

![image](../images/spring-cloud-sample/30.png)

##### 4. Save, Verify, and Publish the Page

Open a browser to visit the target page and use F12 Developer Tools to check if there are related RUM requests with status code 200.

![image](../images/spring-cloud-sample/31.png)

**Note!!**: If F12 Developer Tools shows data not being reported and port refused, verify the port connectivity with `telnet IP:9529`. If blocked, modify `/usr/local/datakit/conf.d/datakit.conf` to change `http_listen` from `localhost` to `0.0.0.0`.

![image](../images/spring-cloud-sample/32.png)

##### 5. View RUM Data in User Access Monitoring

![image](../images/spring-cloud-sample/33.png)

##### 6. Demonstration of RUM and APM Data Correlation

Configuration method: [[Java Example](web.md#fpjkl)]

Use Case: Frontend and backend correlation, binding frontend request data with backend method execution performance data one-to-one, facilitating cross-team and cross-departmental issue localization. For instance, slow frontend visits due to backend service anomalies can be quickly diagnosed. Example:

![image](../images/spring-cloud-sample/34.png)

![image](../images/spring-cloud-sample/35.png)

![image](../images/spring-cloud-sample/36.png)

![image](../images/spring-cloud-sample/37.png)

### Security Checker:

**Security Checker Overview**: [<<< custom_key.brand_name >>> Official Overview]

Note: Currently only supports **Linux**
Detailed steps refer to the document [[Security Checker Installation and Configuration](/scheck/scheck-install/)]

##### 1. Install Security Checker

```shell
## Install
$ bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/security-checker/install.sh)"
## Or execute   sudo datakit --install scheck
## Update
$ bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/security-checker/install.sh) --upgrade"
## Start/Stop Commands
$ systemctl start/stop/restart/status scheck
## Or
$ service scheck start/stop/restart/status
## Installation directory  /usr/local/scheck
```

##### 2. Connect Security Checker to Datakit

Send Security Checker data to Datakit and then forward it to the Dataflux platform.

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

Detailed steps refer to the document [Log Collection](../../integrations/logging.md)

##### 1. Standard Log Collection (Nginx, MySQL, Redis, etc.)

Enable various built-in inputs in DataKit to collect logs directly, such as [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [Containers](../../integrations/container/index.md), [ES](../../integrations/datastorage/elasticsearch.md), etc.

**Example: Nginx**

```toml
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify log paths to correct Nginx paths
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline refers to grok statements for text log parsing. DataKit has built-in pipelines for Nginx, MySQL, etc., located in /usr/local/datakit/pipeline/. There's no need to modify the pipeline path; DataKit automatically reads it.
```

![image](../images/spring-cloud-sample/39.png)

**View Display:**

![image](../images/spring-cloud-sample/40.png)

![image](../images/spring-cloud-sample/41.png)

##### 2. Custom Log Collection (Application Logs, Business Logs, etc.)

**Example: Application Logs**

Pipeline (log grok parsing) [<<< custom_key.brand_name >>> Official Documentation]

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample logging.conf
$ vim logging.conf

## Modify log paths to correct application log paths

## source and service are required fields and can be set to the application name to differentiate log names

$  [inputs.nginx.log]
$    logfiles = [
      "/usr/local/ruoyi/logs/ruoyi-system/error.log",
      "/usr/local/ruoyi/logs/ruoyi-system/info.log",]
$    source = "ruoyi-system"
$    service = "ruoyi-system"
#    pipeline = "ruoyi-system.p"

## Pipeline refers to grok statements for text log parsing. If this configuration is not uncommented, DF platform will display raw log content. If filled, it will parse the log using the specified .p file, which needs to be manually written.
```

![image](../images/spring-cloud-sample/42.png)

```shell
$ cd /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

## Example:
# Log format 
#2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - Query user

## Example grok, copy the following content to ruoyi_system.p

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:level} \\s+%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time)
```

![image](../images/spring-cloud-sample/43.png)

**View Display:**

![image](../images/spring-cloud-sample/44.png)

![image](../images/spring-cloud-sample/45.png)

### Creating Nginx Log Anomaly Detection:

1. Open <<< custom_key.brand_name >>> platform -> Anomaly Detection Library -> New Detection Library -> Custom Monitoring
![image](../images/spring-cloud-sample/46.png)

2. Click on the newly created detection library name -> New Detection Rule -> New Log Detection
![image](../images/spring-cloud-sample/47.png)

3. Fill in specific detection rule content and save  
**Rule Name**: Nginx Log ERROR Count Exceeds Threshold Detection  
**Detection Metric**: As shown in the figure  
**Trigger Condition**: Result>=5  
**Event Name**: Nginx Log ERROR Count Exceeds Threshold Alert  
**Event Content**:
> Level: {status}  
> Host: {host}  
> Content: Too many log errors, error count is {{ Result }}
> Recommendation: Too many log errors indicate potential application issues; recommend checking the application health.  
> **Detection Frequency**: 1 minute

![image](../images/spring-cloud-sample/48.png)

### Verifying Anomaly Detection Mechanism:

1. Query ruoyi-gateway-related processes on the server and kill them
2. 
```shell
$ ps -ef | grep ruoyi-gateway
$ kill -9 xxxxx
```

![image](../images/spring-cloud-sample/49.png)

2. Visit the ruoyi website (refresh multiple times, at least 5 times)

![image](../images/spring-cloud-sample/50.png)

3. Check event-related content on the <<< custom_key.brand_name >>> platform

![image](../images/spring-cloud-sample/51.png)

![image](../images/spring-cloud-sample/52.png)

4. Check Nginx log-related content and relevant views

![image](../images/spring-cloud-sample/53.png)

![image](../images/spring-cloud-sample/54.png)

### Troubleshooting During Input Activation:

1. Check input error messages  
<<< custom_key.brand_name >>> uploads input status information to the <<< custom_key.brand_name >>> platform at regular intervals, which can be viewed under Infrastructure — Specific Host.  
**Example: Apache service down, input shows error**

![image](../images/spring-cloud-sample/55.png)
![image](../images/spring-cloud-sample/56.png)
![image](../images/spring-cloud-sample/57.png)

2. Check data reporting information  

**Method 1:**  
**Enter `curl 127.0.0.1:9529/monitor` in the browser or terminal to view**
![image](../images/spring-cloud-sample/58.png)  
**Method 2:**  
**Enter `curl 127.0.0.1:9529/stats` in the browser or terminal to view**
![image](../images/spring-cloud-sample/59.png)

3. Check Datakit logs  

**Datakit log directory: cd /var/log/datakit**
![image](../images/spring-cloud-sample/60.png)


### Creating Scenarios and Views:

#### Using System View Templates (Using Nginx as an Example)

1. **Scenario —> New Scenario**

![image](../images/spring-cloud-sample/61.png)

2. **New Blank Scenario**

![image](../images/spring-cloud-sample/62.png)

3. **Input Scenario Name —> Confirm**

![image](../images/spring-cloud-sample/63.png)

4. **System View —> Nginx View (Create)**

![image](../images/spring-cloud-sample/64.png)

5. **View Nginx View**

![image](../images/spring-cloud-sample/65.png)
![image](../images/spring-cloud-sample/66.png)

6. **Other**

*Other view creation methods are similar. For custom view content and layout requirements, you can create blank views and build them yourself.*


## Summary:

Thus, we have achieved comprehensive observability for the demo office system's chain, metrics, logs, and infrastructure.

<<< custom_key.brand_name >>> is user-friendly and convenient to manage, providing a unified view for all metrics, traces, and logs, all associated through the same tag (host). This makes it easy to achieve cascading on the platform, thus realizing overall IT system observability.

Finally, combining anomaly detection can achieve integrated system management, enhancing operational and development efficiency and IT decision-making capabilities!

The product is continuously improving, with more features and better usability, and a more aesthetically pleasing UI.

<<< custom_key.brand_name >>> aims to be the champion of observability!