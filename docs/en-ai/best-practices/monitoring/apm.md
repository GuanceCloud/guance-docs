# Distributed Tracing (APM) Best Practices

---

## Prerequisites

Account Registration: Visit the official website [https://www.guance.com/](https://auth.guance.com/login/pwd) to register an account, and log in using your registered account/password.

![image](../images/apm/1.png)

### Install DataKit

#### Obtain Command

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
| diskio | Collects disk IO usage of the host |
| mem | Collects memory usage of the host |
| swap | Collects swap memory usage |
| system | Collects host OS load |
| net | Collects network traffic of the host |
| host_process | Collects a list of resident processes (those alive for more than 10 minutes) |
| hostobject | Collects basic host information (e.g., OS info, hardware info) |
| docker | Collects container objects and logs |

Click on the [**Infrastructure**] module to view all hosts with installed DataKit and their basic information, such as hostname, CPU, memory, etc.

![image](../images/apm/3.png)

Click on the [**Hostname**] to view detailed system information of the host, integration runtime status (all installed plugins), and built-in views (host).

![image](../images/apm/4.png)

Click on any plugin name under [**Integration Runtime Status**] [**View Monitoring View**] to see the built-in view of that plugin.

![image](../images/apm/5.png)

---

### View Distributed Tracing (APM) Monitoring Scenarios

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view:

![image](../images/apm/6.png)

---

## Introduction to Distributed Tracing (APM)

**APM** stands for **Application Performance Management**, which is a monitoring technology that evolved with the development of the internet. Initially designed to address application performance bottlenecks caused by high concurrency and large traffic volumes, APM provides transparency into the layered invocation logic of applications from both development and operations perspectives. This helps enterprises quickly locate faults, reduce MTTR (Mean Time To Repair), and enhance overall user experience. Fundamentally, APM differs significantly from NPM (sideband monitoring) and logging in terms of deployment methods and application scenarios. APM typically involves intrusive deployment methods (bytecode injection or AOP), while logging and NPM do not require changes to user code. APM is mainly used by developers and operators to monitor the overall system's operational state, health, external API calls, database calls, and even finer-grained code and method calls within the application. In contrast, NPM focuses on network link-side latency and packet loss analysis, and logging is more about handling known issues and business logs without involving specific code quality analysis.

Key terms related to distributed tracing:

| Keyword | Definition |
| --- | --- |
| Service | Also known as `service_name`, customizable when adding Trace monitoring |
| Resource | Refers to the request entry point in an application that handles an independent access request |
| Duration | Response time, from when the application receives the request to when it returns a response |
| Status | Divided into OK and ERROR, including error rate and error count |
| Span | A single operation method call represents a complete Trace chain, which consists of multiple Span units |

DF officially supports all APM monitoring tools that support the Opentracing protocol, such as popular tools like Skywalking, Zipkin, Jaeger, Ddtrace, etc. The integration method remains consistent with the original open-source monitoring tool, i.e., adding or importing relevant monitoring files (e.g., introducing a Jar package in Java). Afterward, enabling the corresponding inputs in DataKit will send the trace data to the DF platform. It can also be correlated with logs, metrics, and infrastructure data for comprehensive monitoring and operations, improving troubleshooting efficiency.

## Configuration for Distributed Tracing (APM) Collection

### Enable Tracing Inputs in `datakit.conf`

```shell
###########--------Linux Environment---------##########
$ cd /usr/local/datakit/conf.d/

###########--------Windows Environment-------##########
$ C:\Program Files\datakit\conf.d


## Use different conf files for different monitoring tools; if only one is used, copy and enable the corresponding conf file. This document uses ddtrace.

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

## After copying the file, enter edit mode with vim and uncomment the inputs section.
## Example: ddtrace    Uncomment tags as needed to add business-related or other labels.

$ vim ddtrace.conf

$ [inputs.ddtrace]
$         path = "/v0.4/traces"
$ #       [inputs.ddtrace.tags]
$ #               tag1 = "tomcat"
$ #               tag2 = "tag2"
$ #               tag3 = "tag3"

$ wq!

## Restart DataKit 
###########--------Linux Environment---------##########
$ datakit --restart

###########--------Windows Environment---------##########
## Right-click — Task Manager — Services — DataKit — Restart
```

![image](../images/apm/7.png)

![image](../images/apm/8.png)

---

### Steps for Application Integration with Distributed Tracing (APM) {#ddtrace}

Download ddtrace probe addresses:

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
DD_ENV: Custom environment type (optional)
DD_SERVICE_NAME: Custom application name (required) If this configuration still doesn't display data after setup, try removing the name.
DD_AGENT_PORT: Data upload port (default 9529) (required)
DD_VERSION: Application version (optional)
DD_TRACE_SAMPLE_RATE: Set sampling rate (default full sample) (optional)
DD_SERVICE_MAPPING: Add aliases for Redis, MySQL, etc., called by the current application to distinguish them from those called by other applications (optional)
DD_HOST: Target IP for data transmission, default is localhost (optional)
```

Refer to [Datadog Official Documentation](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers) for specific configurations.

#### Java (ddtrace) Integration:

1. Download [[ddtrace-agent](https://repo1.maven.org/maven2/com/datadoghq/dd-java-agent/)], recommended version 0.80.0

![image](../images/apm/9.png)

Place it in the same directory as the application environment.<br /> (**For versions 1.6 and above of DataKit, ddtrace-java-agent is already included in DataKit by default, located at: `/usr/local/datakit/data/`)<br />2. Add ddtrace.jar startup parameters to the existing application startup script, filling in the following fields: `-javaagent:/xxx/ddtrace.jar -Ddd.env=xxx -Ddd.service.name=xxx -Ddd.agent.port=xxx` where `xxx` needs to be filled in.

---

##### Tomcat Integration

Add ddtrace startup parameters to catalina.sh and restart Tomcat. Replace `xxx` in the code snippet with absolute paths.

```shell
$ cd /xxx/tomcat/bin
$ vim catalina.sh

$ CATALINA_OPTS="$CATALINA_OPTS -javaagent:/xxx/ddtrace.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

$ wq!

## Restart Tomcat
$ ./bin/startup.sh
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named `mall-admin`.

---

##### Microservices Integration

Add ddtrace startup parameters directly to the startup script and restart the application. Replace `xxx` in the code snippet with absolute paths.

```shell
## Original startup script:
$ nohup java -jar mall-admin.jar &

## Startup script with added ddtrace parameters, execute to restart the application:
$ nohup java -javaagent:/xxx/dd-java-agent-0.72.0.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar &
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named `mall-admin`.

---

##### Docker Integration

There are multiple ways to integrate in a Docker environment. Two examples are shown below:<br />1. Modify Dockerfile and rebuild (replace `xxx` in the code snippet with absolute paths)

```shell
$ vim Dockerfile

## Add ddteace-agent path in Dockerfile, `xxx` refers to the absolute path
$ ADD dd-java-agent-0.75.0.jar /xxx/
$ ENTRYPOINT ["java","-javaagent:/xxx/dd-java-agent-0.75.0.jar","-Ddd.service.name=mall-admin","-Ddd.version=v1","-Ddd.env=product","-Ddd.agent.port=9529","-Ddd.agent.host=172.16.0.198","-jar", “-Dspring.profiles.active=prod","/mall-admin-1.0-SNAPSHOT.jar"]
$ wq!
```

![image](../images/apm/10.png)

```shell
## Build & Run
$ docker build -t mall/mall-admin:v1 .  [ “.” must be added]

## Docker run
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1
```

2. Do not modify Dockerfile, override the original startup command with startup parameters (may not apply in some scenarios)

```shell
## Original startup command
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1

## Startup command with ddtrace, need to check the jar startup command in the Dockerfile
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1 java -javaagent:/wx/dd-java-agent-0.75.0.jar -Ddd.service.name=mall-admin -Ddd.version=v1 -Ddd.env=product -Ddd.agent.port=9529 -Ddd.agent.host=172.16.0.198 -jar -Dspring.profiles.active=prod /mall-admin-1.0-SNAPSHOT.jar

## Note: Add `-jar your app name.jar` after adding `java –javaagent`
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named `service.name`.

---

#### C# (dotnet-ddtrace) Integration

##### IIS Hosting Environment Integration:

Note: [[dotnet-agent download link](https://github.com/DataDog/dd-trace-dotnet/releases/)], choose x86, arm64, or other versions based on requirements.

1. **Add Server Environment Variables**

```
## Right-click This Computer — Properties — Advanced System Settings — Environment Variables
## Add new system variable — input the following content

DD_TRACE_AGENT_URL=http://localhost:9529    (required)
DD_ENV=   e.g., test      (optional)
DD_SERVICE=   e.g., myappname     (required)
DD_VERSION=   e.g., 1.0     (optional)
DD_TRACE_SERVICE_MAPPING=  e.g., mysql:main-mysql-db    (optional)

## TRACE_AGENT_URL is the data upload IP plus port, set to http://localhost:9529, do not change
## ENV is the system environment, can be set to pro or test or other as needed
## SERVICE sets the application name displayed on the df platform, can be set to a specific service name
## VERSION is the version number, can be set as needed
## TRACE_SERVICE_MAPPING renames services to distinguish components called by other business systems on the df platform. Accepts mappings of service names to rename, format `[from-key]:[to-name]`
   Note: `[from-key]` should be standard fields like mysql, redis, mongodb, oracle, do not customize these fields
   Example: TRACE_SERVICE_MAPPING=mysql:main-mysql-db
            TRACE_SERVICE_MAPPING=mongodb:offsite-mongodb-service
```

![image](../images/apm/11.png)

2. **Install ddtrace-agent**

Run the dotnet-agent installer with administrator privileges, click next until installation is successful.

![image](../images/apm/12.png)

3. **Restart IIS in PowerShell**

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

Note: [[dotnet.core-agent download link](https://github.com/DataDog/dd-trace-dotnet/releases/)], .NET Tracer currently supports application tracing on .NET Core 2.1, 3.1, and .NET 5.

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

Add the following configurations to the existing application environment variables. Here is an example; the actual service name needs to be modified.

```shell
export CORECLR_ENABLE_PROFILING=1
export CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
export DD_INTEGRATIONS=/opt/datadog/integrations.json
export DD_DOTNET_TRACER_HOME=/opt/datadog
export DD_TRACE_AGENT_URL=http://localhost:9529
export DD_SERVICE=service_test
export CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
```

3. **Restart Application**

---

### Q&A

#### Relationship Between Agent and Jar Package Position

The ddtrace-agent startup parameter must be placed before the `-jar` in the Java application startup command, resulting in `java -javaagent -jar`.

```shell
## Original startup script:
$ java -jar mall-admin.jar

## Startup script with added ddtrace parameters, execute to restart the application:
$ java -javaagent:/xxx/dd-java-agent-0.72.0.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar
```

#### Tomcat-catalina.sh Parameter Configuration

Add ddtrace startup parameters to catalina.sh and restart Tomcat. Replace `xxx` in the code snippet with absolute paths. Ensure that CATALINA_OPTS configurations are read by the application startup script in catalina.sh, otherwise, the application will start normally without starting ddtrace-agent.

```shell
$ cd /xxx/tomcat/bin
$ vim catalina.sh

$ CATALINA_OPTS="$CATALINA_OPTS -javaagent:/xxx/ddtrace.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

$ wq!

## Restart Tomcat
$ ./bin/startup.sh
```

Log in to [Guance](https://console.guance.com/) and enter the specific project space. Click on Application Performance Monitoring to view data for the service named `mall-admin`.