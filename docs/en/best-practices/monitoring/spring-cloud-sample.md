# From 0 to 1 Utilizing <<< custom_key.brand_name >>> to Build Observability for Springcloud Services

---

## Overview of the Business System in This Project:

**This case uses a simulated enterprise internal office system, building observability from scratch using <<< custom_key.brand_name >>>.**

**The observability built in this example is based on a single-machine JAR package application.**

**Project open-source address: [https://gitee.com/y_project/RuoYi-Cloud](https://gitee.com/y_project/RuoYi-Cloud)**  

**Project demo address: [http://demo.ruoyi.vip/login](http://demo.ruoyi.vip/login)**  

**System Introduction**:

This system is an open-source backend management system and also a Java EE enterprise-level rapid development platform based on various classic technology combinations (Spring Boot, Apache Shiro, MyBatis, Thymeleaf, Bootstrap, etc.).  
It includes numerous built-in modules such as department management, role users, menu and button authorization, data permissions, system parameters, log management, notifications announcements, etc., with the main purpose of allowing developers to focus on business logic, reducing technical difficulty, thus saving labor costs, shortening project cycles, and improving software security quality.  
This project can be used for all Web applications, such as website management backends, website member centers, CMS, CRM, OA, etc., while supporting deep customization, enabling enterprises to create more powerful systems. All front-end and back-end code after encapsulation is very concise and easy to use, with a low probability of errors.  
It also supports mobile client access.


**Project Functional Modules:**

- User Management: Users are system operators; this function mainly completes system user configuration.
- Department Management: Configures the organizational structure of the system (company, department, group), with tree structure display supporting data permissions.
- Position Management: Configures the positions held by system users.
- Menu Management: Configures system menus, operation permissions, button permission identifiers, etc.
- Role Management: Allocates role menu permissions and sets data range permissions for roles by organization.
- Dictionary Management: Maintains frequently used relatively fixed data within the system.
- Parameter Management: Dynamically configures commonly used parameters.
- Notifications Announcements: Maintains information release and updates for system notifications.
- Operation Logs: Records and queries normal system operation logs; records and queries abnormal information logs.
- Login Logs: Queries login logs including login anomalies.
- Online Users: Monitors the status of active users currently in the system.
- Scheduled Tasks: Manages (add, modify, delete) tasks online including execution result logs.
- Code Generation: Generates front-end and back-end code (java, html, xml, sql) supporting CRUD downloads.
- System Interfaces: Automatically generates related API interface documentation based on business code.
- Service Monitoring: Monitors CPU, memory, disk, stack, and other relevant information about the current system.
- Cache Monitoring: Performs cache queries, views, clears, and other operations.
- Online Builder: Dragging form elements generates corresponding HTML code.


**Technologies involved in the office system:**

| Technology                | Version              | <<< custom_key.brand_name >>> Inputs Required for Observability                 |
| ------------------- | ----------------- | ------------------------------------------ |
| SpringBoot          | 2.3.7.RELEASE     | ddtrace                                    |
| SpringCloud         | Hoxton.SR9        | ddtrace                                    |
| SpringCloud Alibaba | 2.2.5.RELEASE     | ddtrace                                    |
| Nginx               | 1.16.1            | nginx                                      |
| Mysql               | 5.7.17            | mysql                                      |
| Redis               | 3.2.12            | redis                                      |
| Vue                 | 2.6.0             | rum                                        |
| Java                | OpenJDK 1.8.0_292 | Statsd or jolokia<br /> (This example uses statsd) |


**Architecture of the Office System:**

- Web pages: Hosted in Nginx
- Registration Center: Nacos
- Gateway: Gateway
- Service Modules: Auth, System
- Database: Mysql
- Cache: Redis

*Note: In this demo, all service modules are deployed on the same server, using different ports for accessing services.*

![image](../images/spring-cloud-sample/1.png)

## <<< custom_key.brand_name >>> Introduction:

**Introduction:** [<<< custom_key.brand_name >>> Official Introduction]

<<< custom_key.brand_name >>> is a cloud service platform designed to solve the problem of building **full-chain observability** for every complete application in the era of cloud computing and cloud-native environments, fundamentally differing from traditional monitoring systems.

Traditional monitoring systems are often single-domain monitoring systems, similar to many silos established internally in enterprises, such as APMs, RUMs, logs, NPMs, Zabbix, etc., which are all isolated monitoring systems for applications, logs, infrastructure, etc. The phenomenon is that silos abound, and the isolation of monitoring systems also leads to the isolation of monitoring data, creating data islands within enterprises. Often during issue troubleshooting within enterprises, it requires cross-departmental and cross-platform efforts, consuming a large amount of manpower and resources for anomaly localization.

The concept of **observability** involves making the IT systems carrying business systems observable through a complete system, including three major components: metrics, logs, and tracing. It achieves unified data collection, storage, querying, and presentation, and associates all observable data—metrics, traces, and logs—to realize full observability of the IT system.

<<< custom_key.brand_name >>> is an observability solution developed based on this philosophy, dedicated to enhancing the quality of IT services within enterprises and improving end-user experience.

**<<< custom_key.brand_name >>> Data Flow:**

![image](../images/spring-cloud-sample/2.png)

*Note: DQL is a specialized QL language developed by Dataflux for associated querying of es and influxdb data.*

## Installing Datakit:

1. Log in to <<< custom_key.studio_main_site >>>
2. Create a new workspace
3. Choose integration —— datakit —— select the installation command suitable for your environment and copy it
4. Install datakit on the server
5. Execute `service datakit status` (or `systemctl status datakit`) to check the datakit status
![image](../images/spring-cloud-sample/3.png)
![image](../images/spring-cloud-sample/4.png)
![image](../images/spring-cloud-sample/5.png)

**After Datakit is installed, it will default to collecting the following content, which can be viewed directly in Dataflux —— Infrastructure —— Hosts**

**By selecting different integration input names, you can view corresponding monitoring views, and below the monitoring views, you can also view other data, such as logs, processes, containers, etc.**

| Collector Name   | Description                                                 |
| ------------ | ---------------------------------------------------- |
| cpu          | Collects host CPU usage                              |
| disk         | Collects disk usage                                  |
| diskio       | Collects host disk IO conditions                      |
| mem          | Collects host memory usage                            |
| swap         | Collects Swap memory usage                            |
| system       | Collects host operating system load                   |
| net          | Collects host network traffic conditions               |
| host_process | Collects resident processes on the host <br />(alive for over 10 minutes)      |
| hostobject   | Collects basic host information <br />(such as OS information, hardware information, etc.) |
| docker       | Collects possible container objects and container logs on the host                  |


![image](../images/spring-cloud-sample/6.png)

## Enabling Specific Inputs:

| Involved Component | Input Enabled | Input Directory                     | Related Metrics                                   |
| -------- | ------------ | ---------------------------------- | ------------------------------------------ |
| Nginx    | √            | •/usr/local/datakit/conf.d/nginx   | Request information, logs, request duration, etc.                 |
| Mysql    | √            | •/usr/local/datakit/conf.d/db      | Connections, QPS, read/write conditions, slow queries              |
| Redis    | √            | •/usr/local/datakit/conf.d/db      | Connections, CPU consumption, memory consumption, hit rate, loss rate |
| JVM      | √            | •/usr/local/datakit/conf.d/statsd  | Heap memory, GC times, GC duration                    |
| APM      | √            | •/usr/local/datakit/conf.d/ddtrace | Response time, error counts, error rates                 |
| RUM      | Default Enabled   | ——                                 | uv/pv, LCP, FID, CLS, JavaScript errors               |

**Note:**

| RUM Metrics Explanation                   | Description                                                            | Target Value    |
| ----------------------------- | --------------------------------------------------------------- | --------- |
| LCP(Largest Contentful Paint) | Calculates how long it takes to load the largest content element within the visible web area. | Less than 2.5s  |
| FID(First Input Delay)        | Calculates the delay time when the user first interacts with the webpage. | Less than 100ms |
| CLS(Cumulative Layout Shift)  | Calculates whether the webpage content moves due to dynamic loading during page loading; 0 indicates no change. | Less than 0.1   |

### Nginx:

Refer to the document <[Nginx Observability Best Practices](../../best-practices/monitoring/nginx.md)> for detailed steps.
<br />Prerequisite: First, check if the **http_stub_status_module** module of nginx is enabled. **If the module is already installed, skip step 1 directly.**

![image](../images/spring-cloud-sample/7.png)

1. Install the with-http_stub_status_module module (Linux):  
Enabling this module requires recompiling nginx. The specific command is as follows:  
**`./configure --with-http_stub_status_module`**  
The query method for the configure file location is:  
**`find /| grep configure |grep nginx`**      

```shell
$ find /| grep configure |grep nginx
  
$ cd /usr/local/src/nginx-1.20.0/
$ ./configure --with-http_stub_status_module
```  

![image](../images/spring-cloud-sample/8.png)  

2. Add the nginx_status location forwarding in nginx.conf  

```shell
$ cd /etc/nginx   
   ## The nginx path depends on the actual situation
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

3. Modify nginx's inputs in Datakit  

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
        files = ["/var/log/nginx/access.log","/var/log/nginx /error.log"]

# Restart datakit after saving the file    
$ service datakit restart
```  

![image](../images/spring-cloud-sample/9.png)  

**Verify the data: `curl 127.0.0.1/nginx_status`**  

![image](../images/spring-cloud-sample/10.png)

4. Create an Nginx view on the <<< custom_key.brand_name >>> platform and check the data  
**Creation steps refer to [Create Scenarios and Views](#IVN7h)**  
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create Nginx)**  
**View Example (Through this view, you can quickly check Nginx-related metrics and log information to determine the health state of Nginx):**  

![image](../images/spring-cloud-sample/11.png)

![image](../images/spring-cloud-sample/12.png)

### Mysql:

Refer to the document <[Mysql DataKit Integration](../../integrations/mysql.md)> for detailed steps.

```shell
# Log into mysql 
$ mysql -uroot -p  
# Enter password: Solution****

# Create a monitoring account
$ CREATE USER 'datakit'@'localhost' IDENTIFIED BY 'Datakit_1234';

# Grant monitoring account privileges
$ grant process,select,replication client on *.* to 'datakit'@'%' identified by 'Datakit_1234';

# Refresh privileges
flush privileges;
```

##### 1. Modify mysql's inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp mysql.conf.sample mysql.conf
$ vim mysql.conf

# Modify the following content 
## It is recommended to create a custom read-only account for mysql
[[inputs.mysql]]
     user ="datakit"
     pass ="Datakit_1234"

# Restart datakit after saving the file    
$ service datakit restart
```

![image](../images/spring-cloud-sample/13.png)

##### 2. Create a Mysql view on the <<< custom_key.brand_name >>> platform and check the data

**Creation steps refer to [Create Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create Mysql)**
**View Example (Through this view, you can quickly check Mysql-related metrics and log information to determine the health state of Mysql):**

![image](../images/spring-cloud-sample/14.png)

![image](../images/spring-cloud-sample/15.png)

### Redis:

Refer to the document <[Redis DataKit Integration](../../integrations/redis.md)> for detailed steps.

##### 1. Modify redis's inputs in Datakit

```shell
$ cd /usr/local/datakit/conf.d/db/
$ cp redis.conf.sample redis.conf
$ vim redis.conf

# Modify the following content
## It is recommended to create a custom read-only account for redis
[[inputs.redis]]
     pass ="Solution******"
# Note: Uncomment the pass line before modifying #
[inputs.redis.log]
    files = ["/var/log/redis/redis.log"]

# Restart datakit after saving the file    
$ service datakit restart
```

![image](../images/spring-cloud-sample/16.png)

##### 2. Create a Redis view on the <<< custom_key.brand_name >>> platform and check the data

**Creation steps refer to [Create Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create Redis)**
**View Example (Through this view, you can quickly check Redis-related metrics and log information to determine the health state of Redis):**

![image](../images/spring-cloud-sample/17.png)

![image](../images/spring-cloud-sample/18.png)

### JVM:

Refer to the document <[jvm DataKit Integration](../../integrations/jvm.md)> for detailed steps.

##### 1. Modify JVM's inputs in Datakit

**By default, there is no need to modify JVM's inputs; just generate the conf file.**

```shell
$ cd /usr/local/datakit/conf.d/statsd/
$ cp statsd.conf.sample ddtrace-jvm-statsd.conf 
$ vim ddtrace-jvm-statsd.conf

# No modification required by default
```

##### 2. Modify the java application startup script

**Since JVM and APM both use ddtrace-agent for data collection, refer to the APM-related content [APM] for the application startup script.**

##### 3. Create a JVM view on the <<< custom_key.brand_name >>> platform and check the data

**Creation steps refer to [Create Scenarios and Views](#IVN7h)**
**Steps: Scenario —> New Scenario —> New Blank Scenario —> System View (Create JVM)**
**View Example (Through this view, you can quickly check JVM-related metrics and log information to determine the JVM's health state):**

![image](../images/spring-cloud-sample/19.png)

### APM (Application Performance Monitoring):

Refer to the document [Distributed Tracing (APM) Best Practices](../../best-practices/monitoring/apm.md) for detailed steps.
**<<< custom_key.brand_name >>> supports multiple APM tools that support the opentracing protocol, such as ddtrace, skywalking, zipkin, jaejer, etc. This example uses ddtrace to achieve observability in APM.**

##### 1. Modify APM (ddtrace) inputs in Datakit

**By default, there is no need to modify JVM's inputs; just generate the conf file.**

```shell
$ cd /usr/local/datakit/conf.d/ddtrace/
$ cp ddtrace.conf.sample ddtrace.conf
$ vim ddtrace.conf

# No modification required by default
```

##### 2. Modify the java application startup script

APM observability requires adding an agent to the java application. This agent, when accompanying the application startup, collects performance data related to internal method calls, SQL calls, external system calls, etc., through bytecode injection techniques, thereby achieving observability of the application system's code quality.

```shell
# Original application startup script
$ cd /usr/local/ruoyi/
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 
$ nohup java -Dfile.encoding=utf-8   -jar ruoyi-modules-system.jar > logs/system.log  2>&1 &
```

Kill the original application startup process and add the ddtrace parameter, then restart the application. Refer to the image below for specific termination methods:

![image](../images/spring-cloud-sample/20.png)

```shell
# Application startup script with ddtrace-agent added

$ cd /usr/local/ruoyi/

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-gateway -Ddd.service.mapping=redis:redis_ruoyi -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000  -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-gateway.jar > logs/gateway.log  2>&1 &

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar  -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-auth -Ddd.service.mapping=redis:redis_ruoyi -Ddd.env=staging -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-auth.jar > logs/auth.log  2>&1 & 

$ nohup java -Dfile.encoding=utf-8 -javaagent:dd-java-agent-0.80.0.jar -XX:FlightRecorderOptions=stackdepth=256 -Ddd.logs.injection=true -Ddd.service.name=ruoyi-modules-system -Ddd.service.mapping=redis:redis_ruoyi,mysql:mysql_ruoyi -Ddd.env=dev -Ddd.agent.port=9529 -Ddd.jmxfetch.enabled=true -Ddd.jmxfetch.check-period=1000 -Ddd.jmxfetch.statsd.port=8125 -Ddd.version=1.0 -jar ruoyi-modules-system.jar > logs/system.log  2>&1 & 
```

**If APM-related data is not seen on the <<< custom_key.brand_name >>> platform, check the datakit logs**
**cat /var/log/datakit/gin.log**  
Normal logs:

![image](../images/spring-cloud-sample/21.png)

Error logs:

![image](../images/spring-cloud-sample/22.png)

**Such errors require modifying** /usr/local/datakit/con.d/ddtrace/ddtrace.conf to match the following image  
**Ensure that the path in the ddtrace.conf configuration matches the path in the datakit/gin.log logs**

![image](../images/spring-cloud-sample/23.png)

**Explanations of ddtrace-related environment variables (startup parameters):**

- Ddd.env: Custom environment type, optional.
- Ddd.tags: Custom application tags, optional.
- Ddd.service.name: Custom application name, mandatory.
- Ddd.agent.port: Data upload port (default 9529), mandatory.
- Ddd.version: Application version, optional.
- Ddd.trace.sample.rate: Set sampling rate (default is full sampling), optional. If sampling is needed, set a number between 0~1, e.g., 0.6, meaning 60% sampling.
- Ddd.service.mapping: Current application calls to redis, mysql, etc., can add aliases via this parameter to distinguish them from other application calls, optional, applicable scenarios: For example, projects A and B both call mysql, calling mysql-a and mysql-b respectively. Without adding mapping configurations, on the <<< custom_key.brand_name >>> platform, it would show that projects A and B called the same mysql database named mysql. If mapping configurations are added, configured as mysql-a and mysql-b, then on the <<< custom_key.brand_name >>> platform, it would show project A calling mysql-a and project B calling mysql-b.
- Ddd.agent.host: Data transmission target IP, default is local machine localhost, optional.

##### 3. View APM data on the <<< custom_key.brand_name >>> platform

**APM (Application Performance Monitoring) is a default built-in module in <<< custom_key.brand_name >>>, no need to create scenarios or views to view it.**  
**Path: <<< custom_key.brand_name >>> Platform —— Application Performance Monitoring**  
**View Example: (Through this view, you can quickly check application call situations, topology diagrams, exception data, and other APM-related data)**

![image](../images/spring-cloud-sample/24.png)

![image](../images/spring-cloud-sample/25.png)

![image](../images/spring-cloud-sample/26.png)

### RUM (Real User Monitoring):

Refer to the document [[User Access (RUM) Observability Best Practices](web.md)] for detailed steps.

##### 1. Log into the Dataflux platform

##### 2. Select User Access Monitoring —— New Application —— Choose Web Type —— Synchronous Loading

![image](../images/spring-cloud-sample/27.png)

##### 3. Integrate <<< custom_key.brand_name >>> RUM observability JS file in the frontend index.html page

```shell
$ cd /usr/local/ruoyi/dist/

// Remember to back up
$ cp index.html index.html.bkd

// Add df-js in index.html
// Copy the JS content from the DF platform and place it before the </head> tag in index.html, then save the file, as shown below

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
      allowedTracingOrigins:["xxx.xxx.xxx.xxx"]
      })
</script></head> 

# xxx needs to be modified according to the actual situation, detailed changes are referenced as follows:
```

> **datakitOrigin**: Datakit address (IP or domain name of the server where datakit is located). <<< custom_key.brand_name >>> RUM data flow: rum.js file ——> datakit ——> dataway ——><<< custom_key.brand_name >>> platform. If it is a production environment, set the IP to a domain name or SLB address. For test environments, fill in the internal IP, corresponding to the 9529 port of the datakit server.
>    
> **trackInteractions**: User behavior collection configuration item, can achieve page-side user operation behavior statistics.
> 
> **allowedTracingOrigins**: Frontend-backend (RUM and APM) connectivity configuration item, set as needed, fill in the domain name or IP corresponding to the backend server interacting with the frontend page here.


**Notes:**

- **datakitOrigin**: Data transmission address, in a production environment, if configured as a domain name, the domain name request can be forwarded to any specific server with the datakit-9529 port installed. If the frontend access volume is too large, a layer of SLB can be added between the domain name and the datakit server. The frontend js sends data to the SLB, and the SLB must open the **9529** port, forwarding requests to multiple servers with datakit-**9529** installed. Multiple datakits receive RUM data, due to frontend request reuse factors, session data will not be interrupted, nor will it affect the RUM data presentation.

Example:

![image](../images/spring-cloud-sample/28.png)

![image](../images/spring-cloud-sample/29.png)

- **allowedTracingOrigins**: Achieves frontend-backend (APM and RUM) connectivity. This scenario only works when RUM is deployed at the frontend and APM at the backend. Fill in the domain name (production environment) or IP (test environment) corresponding to the backend application server interacting with the frontend page here. **Use Case**: If the frontend user access is slow due to backend code logic anomalies, the slow request data from the frontend RUM can directly link to the APM data to check the backend code call situation, determining the root cause of slowness. **Implementation Principle**: When a user accesses the frontend application, the frontend application performs resource and request calls, triggering rum-js performance data collection. Rum-js generates a trace-id written in the request_header. When the request reaches the backend, the backend's ddtrace reads the trace_id and records it in its own trace data, thus achieving the association of application performance monitoring and user access monitoring data through the same trace_id.
- **env**: Mandatory, application environment, either test or product or another field.
- **version**: Mandatory, application version number.
- **trackInteractions**: User behavior statistics, such as button clicks, submitting information, etc.

![image](../images/spring-cloud-sample/30.png)

##### 4. Save, Verify, and Publish the Page

Open the browser and visit the target page. Check if there are related RUM requests in the network requests of the page via F12 Developer Tools, ensuring the status code is 200.

![image](../images/spring-cloud-sample/31.png)

**Note!!**: If the F12 Developer Tools discover that the data cannot be reported and shows port refused, verify the port accessibility via telnet IP:9529. If inaccessible, modify /usr/local/datakit/conf.d/datakit.conf to change http_listen's localhost to 0.0.0.0.

![image](../images/spring-cloud-sample/32.png)

##### 5. View RUM-related Data on User Access Monitoring

![image](../images/spring-cloud-sample/33.png)

##### 6. Demonstration of Data Connectivity Between RUM and APM

Configuration Method: [[Java Example](web.md#fpjkl)]

Use Case: Frontend-backend association, one-to-one binding of frontend requests and backend method execution performance data, making it easier to locate frontend-backend associated issues. For example, if the frontend user access is slow due to backend service call anomalies, problems can be quickly located across teams and departments, as shown below:

![image](../images/spring-cloud-sample/34.png)

![image](../images/spring-cloud-sample/35.png)

![image](../images/spring-cloud-sample/36.png)

![image](../images/spring-cloud-sample/37.png)

### Security Checker (Security Inspection):

**Security Checker Introduction**: [**[**<<< custom_key.brand_name >>> Official Introduction**](/scheck)**]

Note: Currently only supports **Linux**
Refer to the document [[Security Checker Installation and Configuration](/scheck/scheck-install/)] for detailed steps.

##### 1. Install Security Checker

```shell
## Installation
$ bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/security-checker/install.sh)"
## Or execute   sudo datakit --install scheck
## Update
$ bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/security-checker/install.sh) --upgrade"
## Start/Stop Commands
$ systemctl start/stop/restart/status scheck
## Or
$ service scheck start/stop/restart/status
## Installation Directory  /usr/local/scheck
```

##### 2. Connect Security Checker to Datakit

Send Security Checker data to datakit, then forward it to the dataflux platform.

```shell
$ cd /usr/local/scheck/
$ vim scheck.conf
 
 
    # ##(required) directory containing scripts
    rule_dir='/usr/local/scheck/rules.d'

    # ##(required) output of the check results, supports local files or remote HTTP servers
    # ##localfile: file:///your/file/path
    # ##remote:  http(s)://your.url
    output='http://127.0.0.1:9529/v1/write/security'


    # ##(optional) global cron, default is every 10 seconds
    #cron='*/10 * * * *'

    log='/usr/local/scheck/log'
    log_level='info'
    #disable_log=false

```

##### 3. View Security Checker-related Data

![image](../images/spring-cloud-sample/38.png)

### Logs:

Refer to the document [Log Collection](../../integrations/logging.md) for detailed steps.

##### 1. Standard Log Collection (Nginx, Mysql, Redis, etc.)

Enable various built-in inputs in DataKit to directly enable related log collection, such as [Nginx](../../integrations/nginx.md), [Redis](../../integrations/datastorage/redis.md), [Containers](../../integrations/container/index.md), [ES](../../integrations/datastorage/elasticsearch.md), etc.

**Example: Nginx**

```toml
$ cd /usr/local/datakit/conf.d/nginx/
$ cp nginx.conf.sample nginx.conf
$ vim nginx.conf

## Modify the log path to the correct nginx path
$ [inputs.nginx.log]
$     files = ["/usr/local/nginx/logs/access.log","/usr/local/nginx/logs/error.log"]
$     pipeline = "nginx.p"

## Pipeline refers to grok statements, mainly used for text log splitting. Datakit has built-in pipelines for nginx, mysql, etc. The default pipeline directory is /usr/local/datakit/pipeline/, so there is no need to modify the pipeline path. Datakit will automatically read it by default.
```

![image](../images/spring-cloud-sample/39.png)

**View Display:**

![image](../images/spring-cloud-sample/40.png)

![image](../images/spring-cloud-sample/41.png)

##### 2. Custom Log Collection (Application Logs, Business Logs, etc.)

**Example: Application Logs**

Pipeline (log grok splitting) [**[**<<< custom_key.brand_name >>> Official Documentation**](/datakit/pipeline/)**]

```shell
$ cd /usr/local/datakit/conf.d/log/
$ cp logging.conf.sample logging.conf
$ vim logging.conf

## Modify the log path to the correct application log path

## Source and service are mandatory fields, can directly use the application name to distinguish different log names

$  [inputs.nginx.log]
$    logfiles = [
      "/usr/local/ruoyi/logs/ruoyi-system/error.log",
      "/usr/local/ruoyi/logs/ruoyi-system/info.log",]
$    source = "ruoyi-system"
$    service = "ruoyi-system"
#    pipeline = "ruoyi-system.p"

## Pipeline refers to grok statements, mainly used for text log splitting. If this configuration is not enabled, the default display on the DF platform shows the raw log content. If filled out, it will perform grok splitting on the corresponding logs. The .p file specified here needs to be manually written.
```

![image](../images/spring-cloud-sample/42.png)

```shell
$ cd /usr/local/datakit/pipeline/
$ vim ruoyi_system.p

## Example:
# Log format
#2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - Query users

## Example grok, copy the following content into ruoyi_system.p

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:level} \\s+%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time)
```

![image](../images/spring-cloud-sample/43.png)

**View Display:**

![image](../images/spring-cloud-sample/44.png)

![image](../images/spring-cloud-sample/45.png)


### Creating Nginx Log Anomaly Detection:

1. Open the <<< custom_key.brand_name >>> platform —> Anomaly Detection Library —> New Detection Library —> Custom Monitoring
![image](../images/spring-cloud-sample/46.png)

2. Click the newly created detection library name —> New Detection Rule —> New Log Detection
![image](../images/spring-cloud-sample/47.png)

3. Fill in the specific detection rule content and save  
**Rule Name**: Excessive Nginx Log ERROR Count Anomaly Detection  
**Detection Metric**: See figure  
**Trigger Condition**: Result>=5  
**Event Name**: Excessive Nginx Log ERROR Count Anomaly Alert  
**Event Content**:
> Level: {status}  
> Host: {host}  
> Content: Too many log ERRORs, count is {{ Result }}
> Recommendation: Too many log ERRORs, application may have anomalies, suggest checking the application health.  
> **Detection Frequency**: 1 minute

![image](../images/spring-cloud-sample/48.png)

### Verifying Anomaly Detection Mechanism:

1. Query the ruoyi-gateway related processes on the server and kill them
2. 
```shell
$ ps -ef|grep ruoyi-gateway
$ kill -9 xxxxx
```

![image](../images/spring-cloud-sample/49.png)

2. Visit the ruoyi website (can refresh multiple times, at least 5 times or more)

![image](../images/spring-cloud-sample/50.png)

3. Check the event-related content on the <<< custom_key.brand_name >>> platform

![image](../images/spring-cloud-sample/51.png)

![image](../images/spring-cloud-sample/52.png)

4. Check the related Nginx log content and related views

![image](../images/spring-cloud-sample/53.png)

![image](../images/spring-cloud-sample/54.png)

### Troubleshooting Methods During the Process of Enabling Inputs:

1. Check the input error messages  
<<< custom_key.brand_name >>> defaults to uploading the status information of inputs to the <<< custom_key.brand_name >>> platform at a certain frequency, which can be directly viewed under Infrastructure —— Specific Host to see the integration status.  
**Example: Apache service downtime, inputs showing errors**

![image](../images/spring-cloud-sample/55.png)
![image](../images/spring-cloud-sample/56.png)
![image](../images/spring-cloud-sample/57.png)

2. Check the data reporting information  

**Method 1:**  
**Enter `curl 127.0.0.1:9529/monitor` in the browser or console to view**
![image](../images/spring-cloud-sample/58.png)  
**Method 2:**  
**Enter `curl 127.0.0.1:9529/stats` in the browser or console to view**
![image](../images/spring-cloud-sample/59.png)

3. Check the datakit logs  

**Datakit log directory: cd /var/log/datakit**
![image](../images/spring-cloud-sample/60.png)


### Creating Scenarios and Views:

#### Using System View Templates to Create (Using Nginx as an Example) ###

1. **Scenario —— New Scenario**

![image](../images/spring-cloud-sample/61.png)

2. **New Blank Scenario**

![image](../images/spring-cloud-sample/62.png)

3. **Input Scenario Name —— Confirm**

![image](../images/spring-cloud-sample/63.png)

4. **System View —— Nginx View (Create)**

![image](../images/spring-cloud-sample/64.png)

5. **View Nginx View**

![image](../images/spring-cloud-sample/65.png![image](../images/spring-cloud-sample/66.png)

6. **Others**

  *The method for creating other views is similar. If there are custom view content and layout requirements, a blank view can be created for self-building.*

## Summary:

Thus, the chain, metrics, logs, and infrastructure of this demo office system have been comprehensively observed.

<<< custom_key.brand_name >>> overall trial shows convenient configuration, easy management, and also provides a unified viewing interface. All metrics, traces, and logs are associated through the same tag (host), making it very convenient to achieve cascading on the platform, thereby realizing the overall observability of the IT system.

Finally, combined with anomaly detection, it can realize the integrated management of the system, thereby improving operation and R&D efficiency and enhancing IT decision-making capabilities!

This product is continuously improving, and future features will become more powerful, easier to use, and the UI will become more beautiful.

<<< custom_key.brand_name >>> aims to be the spokesperson for observability!