# Distributed Tracing (APM) Best Practices

---

## Prerequisites

Account Registration: Visit the official website [https://www.guance.com/](https://auth.guance.com/login/pwd) to register an account, and log in using your registered account/password.

![image](../images/apm/1.png)

### Install DataKit

#### Obtain Installation Command

Click on the [**Integration**] module, select [**DataKit**], and choose the appropriate installation command based on your operating system and system type.

![image](../images/apm/2.png)

#### Execute Installation

Copy the DataKit installation command and run it directly on the server that needs to be monitored.

- Installation directory: `/usr/local/datakit/`
- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

After DataKit installation is complete, common Linux host plugins are enabled by default. You can view them in DF —— Infrastructure —— Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk I/O usage of the host |
| mem | Collects memory usage of the host |
| swap | Collects Swap memory usage |
| system | Collects host OS load |
| net | Collects network traffic of the host |
| host_process | Collects a list of long-running (survived for more than 10 minutes) processes on the host |
| hostobject | Collects basic information about the host (such as OS info, hardware info, etc.) |
| docker | Collects container objects and container logs on the host |

Click on the [**Infrastructure**] module to view a list of all hosts with installed DataKit and their basic information, such as hostname, CPU, memory, etc.

![image](../images/apm/3.png)

Clicking on [**Hostname**] allows you to view detailed system information for that host, integration runtime status (all installed plugins on this host), and built-in views (host).

![image](../images/apm/4.png)

Clicking on [**Integration Runtime Status**] and selecting any plugin name [**View Monitoring View**] will show you the built-in view for that plugin.

![image](../images/apm/5.png)

---

### Viewing APM Monitoring Scenarios

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view:

![image](../images/apm/6.png)

---

## Introduction to Distributed Tracing (APM)

**APM** stands for **Application Performance Management**, which is a monitoring technology that has evolved with the development of the internet. It was initially created to solve application performance bottlenecks caused by high concurrency and large traffic from internet users. From the perspective of developers and operations teams, APM makes the layered invocation logic of applications transparent, allowing for quick fault localization within enterprises, reducing MTTR (Mean Time To Repair), and thus enhancing overall user experience. Fundamentally, APM differs significantly from NPM (side-channel monitoring) and logging in terms of deployment methods and use cases. APM's deployment method is often intrusive (bytecode injection or AOP), while logging and NPM do not require intrusions into user code. APM is mainly used by R&D and operations teams to view the overall operational status and health of the system, external API calls, database calls, and even finer-grained code and method call resource consumption or anomalies. NPM is primarily used for analyzing delays and packet loss in network links, packet capture and analysis, without involving specific application code performance analysis. Logs are more focused on handling known issues and business logs, and do not involve specific code quality analysis.

Explanation of key terms related to distributed tracing:

| Keyword | Explanation |
| --- | --- |
| Service | Also known as `service_name`, customizable when adding Trace monitoring |
| Resource | Refers to the entry point of a request in the Application for processing an independent access request |
| Duration | The response time, from the moment the Application receives the request until it returns the response |
| Status | Divided into OK and ERROR, including error rate and error count |
| Span | A single operation method call throughout its lifecycle forms a Trace link, which consists of multiple Span units |

DF officially supports all APM monitoring tools that support the Opentracing protocol, such as the popular Skywalking, Zipkin, Jaeger, Ddtrace, etc. The specific connection method remains consistent with the original open-source monitoring tools, i.e., adding or introducing relevant monitoring files (e.g., introducing a Jar package in Java). Afterward, enabling the corresponding inputs in datakit will send the trace data to the DF platform. This data can also be correlated with logs, metrics, and infrastructure data for comprehensive monitoring and maintenance, improving troubleshooting efficiency.

## Configuration Related to Distributed Tracing (APM) Collection

### Enable Tracing Inputs in datakit.conf

```shell
###########--------Linux Environment---------##########
$ cd /usr/local/datakit/conf.d/

###########--------Windows Environment-------##########
$ C:\Program Files\datakit\conf.d


## Use different conf files for different monitoring tools; if only one tool is used, simply copy and enable the corresponding conf file. In this article, ddtrace is used.

#############----------Skywalking----------###########
$ cd /traceSkywalking
$ cp traceSkywalking.conf.sample traceSkywalking.conf
#############----------Skywalking----------###########

#############------------Jaeger------------###########
$ cd /traceJaeger
$ cp traceJaeger.conf.sample traceJaeger.conf
#############------------Jaeger------------###########

#############------------Zipkin------------###########
$ cd /traceZipkin
$ cp traceZipkin.conf.sample traceZipkin.conf
#############------------Zipkin------------###########

#############------------Ddtrace------------###########
$ cd /ddtrace
$ cp ddtrace.conf.sample ddtrace.conf
#############------------Ddtrace------------###########

## After copying the file, enter vim editing mode and uncomment the inputs
## Example: ddtrace    Tags-related comments can be enabled as needed, adding business or other related tags

$ vim ddtrace.conf

$ [inputs.ddtrace]
$         path = "/v0.4/traces"
$ #       [inputs.ddtrace.tags]
$ #               tag1 = "tomcat"
$ #               tag2 = "tag2"
$ #               tag3 = "tag3"

$ wq!

## Restart datakit 
###########--------Linux Environment---------##########
$ datakit --restart

###########--------Windows Environment---------##########
## Right-click — Task Manager — Services — datakit — Restart
```

![image](../images/apm/7.png)

![image](../images/apm/8.png)

---

### Steps for Application Integration with Distributed Tracing (APM) {#ddtrace}

ddtrace probe download links:

- Python: [https://github.com/DataDog/dd-trace-py](https://github.com/DataDog/dd-trace-py)
- Golang: [https://github.com/DataDog/dd-trace-go](https://github.com/DataDog/dd-trace-go)
- NodeJS: [https://github.com/DataDog/dd-trace-js](https://github.com/DataDog/dd-trace-js)
- PHP: [https://github.com/DataDog/dd-trace-php](https://github.com/DataDog/dd-trace-php)
- Ruby: [https://github.com/DataDog/dd-trace-rb](https://github.com/DataDog/dd-trace-rb)
- C# (dotnet): [https://github.com/DataDog/dd-trace-dotnet](https://github.com/DataDog/dd-trace-dotnet)
- C++: [https://github.com/DataDog/dd-opentracing-cpp](https://github.com/DataDog/dd-opentracing-cpp)
- Java: [https://github.com/DataDog/dd-trace-java](https://github.com/DataDog/dd-trace-java)

Explanation of ddtrace environment variables (startup parameters):

```java
Ddd.env: Custom environment type (optional)
Ddd.service.name: Custom application name (required) If data still does not display after configuring this, try removing the name.
Ddd.agent.port: Data upload port (default 9529) (required)
Ddd.version: Application version (optional)
Ddd.trace.sample.rate: Set sampling rate (default full sampling) (optional)
Ddd.service.mapping: For Redis, MySQL, etc., called by the current application, this parameter can add aliases to distinguish between components called by other applications (optional)
Ddd.host: Data transmission target IP, default localhost (optional)
```

For specific configurations, refer to the [Datadog Official Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers)

#### Java (ddtrace) Integration:

1. Download [[ddtrace-agent](https://repo1.maven.org/maven2/com/datadoghq/dd-java-agent/)], recommended version 0.80.0

![image](../images/apm/9.png)

Place it in the same directory level as the application environment<br /> (**For versions 1.6 and above of datakit, ddtrace-java-agent is already embedded by default in datakit, located at: `/usr/local/datakit/data/`**)<br />2. Add ddtrace.jar startup parameters to the existing application startup script, filling in the following fields `-javaagent:/xxx/ddtrace.jar -Ddd.env=xxx -Ddd.service.name=xxx -Ddd.agent.port=xxx` where `xxx` must be filled in.

---

##### Tomcat Integration

Add ddtrace startup parameters in catalina.sh and restart tomcat. Replace `xxx` in the code snippet with absolute paths.

```shell
$ cd /xxx/tomcat/bin
$ vim catalina.sh

$ CATALINA_OPTS="$CATALINA_OPTS -javaagent:/xxx/ddtrace.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

$ wq!

## Restart tomcat
$ ./bin/startup.sh
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named mall-admin.

---

##### Microservices Integration

Directly add ddtrace startup parameters to the startup script and restart the application. Replace `xxx` in the code snippet with absolute paths.

```shell
## Original startup script:
$ nohup java -jar mall-admin.jar &

## Startup script with added ddtrace startup parameters, execute command to restart the application:
$ nohup java -javaagent:/xxx/dd-java-agent-0.72.0.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar &
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named mall-admin.

---

##### Docker Integration

There are multiple ways to integrate in a Docker environment. Two examples are shown below:<br />1. Modify Dockerfile and rebuild the image **Replace `xxx` in the code snippet with absolute paths**

```shell
$ vim Dockerfile

## Add ddteace-agent path in Dockerfile, `xxx` refers to the absolute path
$ ADD dd-java-agent-0.75.0.jar /xxx/
$ ENTRYPOINT ["java","-javaagent:/xxx/dd-java-agent-0.75.0.jar","-Ddd.service.name=mall-admin","-Ddd.version=v1","-Ddd.env=product","-Ddd.agent.port=9529","-Ddd.agent.host=172.16.0.198","-jar", “-Dspring.profiles.active=prod","/mall-admin-1.0-SNAPSHOT.jar"]
$ wq!
```

![image](../images/apm/10.png)

```shell
## build & run
$ docker build -t mall/mall-admin:v1 .  [ “.” must be added]

## docker run
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1
```

2. Without modifying Dockerfile, override the original startup command with startup parameters (may not apply in some scenarios)

```shell
## Original startup command
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1

## Startup command including ddtrace, need to check the jar startup command in the Dockerfile
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1 java -javaagent:/wx/dd-java-agent-0.75.0.jar -Ddd.service.name=mall-admin -Ddd.version=v1 -Ddd.env=product -Ddd.agent.port=9529 -Ddd.agent.host=172.16.0.198 -jar -Dspring.profiles.active=prod /mall-admin-1.0-SNAPSHOT.jar

## Note: After adding java –javaagent, add -jar your app name.jar after the startup script
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service with the specified `serveice.name`.

---

#### C# (dotnet-ddtrace) Integration

##### IIS Hosting Environment Integration:

Note: [[dotnet-agent download link](https://github.com/DataDog/dd-trace-dotnet/releases/)] , download x86, arm64, or other versions based on requirements.

1. **Add Server Environment Variables**

```
## Right-click This PC — Properties — Advanced System Settings — Environment Variables
## Create new system variable — input as follows

DD_TRACE_AGENT_URL=http://localhost:9529    (required)
DD_ENV=   e.g., test      (optional)
DD_SERVICE=   e.g., myappname     (required)
DD_VERSION=   e.g., 1.0     (optional)
DD_TRACE_SERVICE_MAPPING=  e.g., mysql:main-mysql-db    (optional)

## TRACE_AGENT_URL is the data upload IP plus port, set to http://localhost:9529, not recommended to change
## ENV is the system environment, set according to needs, such as pro or test
## SERVICE sets the application name displayed on the df platform, set to specific service name
## VERSION is the version number, set according to needs
## TRACE_SERVICE_MAPPING renames services to differentiate components called by other business systems on the df platform. Accepts mappings of service names to be renamed and the names to use, format `[from-key]:[to-name]`
   Note: `[from-key]` content should be standard fields like mysql, redis, mongodb, oracle, do not customize
   Example: TRACE_SERVICE_MAPPING=mysql:main-mysql-db
            TRACE_SERVICE_MAPPING=mongodb:offsite-mongodb-service

```

![image](../images/apm/11.png)

2. **Install ddtrace-agent**

Run the dotnet-agent installer with administrator privileges, click Next until installation is successful.

![image](../images/apm/12.png)

3. **Execute the following commands in PowerShell to restart IIS**

```shell
## Stop IIS service
net stop /y was

## Start IIS service
net start w3svc
```

Log in to the df platform and view the corresponding servicename application in the Application Performance Monitoring module.

---

#### Python (ddtrace) Integration

[[Python Deployment Guide](/integrations/ddtrace-python)]

---

#### .NET Core (ddtrace) Integration

Note: [[dotnet.core-agent download link](https://github.com/DataDog/dd-trace-dotnet/releases/)] , .NET Tracer currently supports .NET Core 2.1, 3.1, and .NET 5 application tracing.

1. **Run the following commands to install .net core-agent based on the environment**

```shell
Debian or Ubuntu
sudo dpkg -i ./datadog-dotnet-apm_<TRACER_VERSION>_amd64.deb && /opt/datadog/createLogPath.sh

CentOS or Fedora
sudo rpm -Uvh datadog-dotnet-apm<TRACER_VERSION>-1.x86_64.rpm && /opt/datadog/createLogPath.sh

Alpine or other musl-based distributions
sudo tar -xzf -C /opt/datadog datadog-dotnet-apm<TRACER_VERSION>-musl.tar.gz && sh /opt/datadog/createLogPath.sh

Other distributions
sudo tar -xzf -C /opt/datadog datadog-dotnet-apm<TRACER_VERSION>-tar.gz && /opt/datadog/createLogPath.sh
```

2. **Add Application Environment Variables**

Add the following configurations to the configured environment variables of the application. Note that the service name needs to be modified as per actual requirements.

```shell
export CORECLR_ENABLE_PROFILING=1
export CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
export DD_INTEGRATIONS=/opt/datadog/integrations.json
export DD_DOTNET_TRACER_HOME=/opt/datadog
export DD_TRACE_AGENT_URL=http://localhost:9529
export DD_SERVICE=service_test
export CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
```

3. **Restart the Application**

---

### Q&A

#### Relationship Between Agent and Jar Package Location

The ddtrace-agent startup parameters must be placed before the `-jar` in the java application startup command. The final form should be `java -javaagent -jar`.

```shell
## Original startup script:
$ java -jar mall-admin.jar

## Startup script with added ddtrace startup parameters, execute command to restart the application:
$ java -javaagent:/xxx/dd-java-agent-0.72.0.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar
```

#### tomcat-catalina.sh Parameter Configuration

Add ddtrace startup parameters in catalina.sh and restart tomcat. Replace `xxx` in the code snippet with absolute paths. Ensure that the CATALINA_OPTS configuration is read by the application startup script in catalina.sh, otherwise, the application will start normally without starting the ddtrace-agent.

```shell
$ cd /xxx/tomcat/bin
$ vim catalina.sh

$ CATALINA_OPTS="$CATALINA_OPTS -javaagent:/xxx/ddtrace.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

$ wq!

## Restart tomcat
$ ./bin/startup.sh
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named mall-admin.