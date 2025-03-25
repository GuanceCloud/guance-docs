# Distributed Tracing (APM) Best Practices

---

## Prerequisites

Account registration: Go to the official website [https://<<< custom_key.brand_main_domain >>>/](https://<<< custom_key.studio_main_site_auth >>>/login/pwd) to register an account, and log in using your registered account/password.

![image](../images/apm/1.png)

### Install Datakit

#### Get Command

Click on the [**Integration**] module, select [**DataKit**], and choose the appropriate installation command based on your operating system and system type.

![image](../images/apm/2.png)

#### Perform Installation

Copy the Datakit installation command and run it directly on the server that needs to be monitored.

- Installation directory /usr/local/datakit/
- Logs directory /var/log/datakit/
- Main configuration file /usr/local/datakit/conf.d/datakit.conf
- Plugin configuration directory /usr/local/datakit/conf.d/

After Datakit is installed, common plugins for Linux hosts are enabled by default. You can view them in DF —— Infrastructure —— Built-in Views.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk IO status of the host |
| mem | Collects memory usage of the host |
| swap | Collects Swap memory usage |
| system | Collects operating system load of the host |
| net | Collects network traffic of the host |
| host_process | Collects a list of resident processes (alive for more than 10 minutes) on the host |
| hostobject | Collects basic information about the host (such as OS information, hardware information, etc.) |
| docker | Collects possible container objects and container logs on the host |

Click on the [**Infrastructure**] module to view the list of all hosts with installed Datakits and their basic information, such as hostname, CPU, memory, etc.

![image](../images/apm/3.png)

Clicking on [**Hostname**] allows you to view detailed system information for that host, integration operation status (all installed plugins on this host), and built-in views (host).

![image](../images/apm/4.png)

Clicking on [**Integration Operation Status**] any plugin name [**View Monitoring View**] shows the built-in view for that plugin.

![image](../images/apm/5.png)

---

### View Tracing (APM) Monitoring Scenarios

Log in to [guance](https://<<< custom_key.studio_main_site >>>/) and enter the specific project space. Click on Application Performance Monitoring to view:

![image](../images/apm/6.png)

---

## Introduction to Tracing (APM)

**APM** stands for **_Application performance management (application performance management)_**, which is a monitoring technology that has emerged with the development of the Internet. Initially introduced to solve application performance bottlenecks caused by high concurrency and large traffic from an Internet user's perspective, APM makes the layered invocation logic of applications transparent from the developer and operations point of view. This enables internal enterprises to quickly locate faults, reduce MTTR (Mean time to repair, average fault repair time), and thus enhance overall user experience. Fundamentally, APM differs significantly from NPM (side-channel listening) and logs in terms of deployment methods and application scenarios. The deployment method of APM is often intrusive (bytecode injection or AOP), while logs and NPM are generally non-intrusive in user code. APM is mainly used by R&D and operations teams to view the overall operational status and health of the system, external API calls, database calls, and even finer-grained resource consumption or anomalies in code and method calls within the system itself, focusing on application-side system performance and stability assurance. NPM primarily focuses on delay and packet loss analysis in network links, without involving specific code performance analysis within applications. Logs are more oriented towards handling known issues and business logs, without analyzing specific code quality.

Definitions of key terms related to tracing:

| Keyword | Definition |
| --- | --- |
| Service | i.e., service_name, can be customized when adding Trace monitoring |
| Resource | Refers to the request entry point in the Application for processing a single independent access request |
| Duration | i.e., response time, the entire request process starts from when the Application receives the request and ends when the Application returns the response |
| Status | Status is divided into OK and ERROR, errors include error rate and error count |
| Span | A single operation method call throughout the process is the Trace chain, which consists of multiple Span units |

The DF official currently supports all APM monitoring tools that support the Opentracing protocol, such as popular ones like Skywalking, Zipkin, Jaeger, Ddtrace, etc. The specific connection method remains consistent with the original open-source monitoring tool connection methods, meaning that related monitoring files (e.g., introducing a Java Jar package) are added or imported into the original code. Then enabling the corresponding inputs in datakit will allow trace data to be sent to the DF platform. It can also be associated with logs, metrics, and infrastructure data for analysis, achieving integrated monitoring, operations, and development to improve overall troubleshooting efficiency.

## Tracing (APM) Collection Related Configurations

### Enable tracing inputs in datakit.conf

```shell
###########--------Linux environment---------##########
$ cd /usr/local/datakit/conf.d/

###########--------Windows environment-------##########
$ C:\Program Files\datakit\conf.d


## Different monitoring tools require enabling different conf files. If only one is adopted, simply copy and enable the corresponding conf file. In this article, we use ddtrace.

#############----------skywalking----------###########
$ cd /traceSkywalking
$ cp traceSkywalking.conf.sample traceSkywalking.conf
#############----------skywalking----------###########

#############------------jaeger------------###########
$ cd /traceJaeger
$ cp traceJaeger.conf.sample traceJaeger.conf
#############------------jaeger------------###########

#############------------zipkin------------###########
$ cd /traceZipkin
$ cp traceZipkin.conf.sample traceZipkin.conf
#############------------zipkin------------###########

#############------------ddtrace------------###########
$ cd /ddtrace
$ cp ddtrace.conf.sample ddtrace.conf
#############------------zipkin------------###########

## After copying the file, vim enters edit mode and uncomment the inputs.
## Example: ddtrace    tags-related comments can be enabled as needed, adding business or other related labels.

$ vim ddtrace.conf

$ [inputs.ddtrace]
$         path = "/v0.4/traces"
$ #       [inputs.ddtrace.tags]
$ #               tag1 = "tomcat"
$ #               tag2 = "tag2"
$ #               tag3 = "tag3"

$ wq!

## Restart datakit 
###########--------Linux environment---------##########
$ datakit --restart

###########--------Windows environment---------##########
## Right-click — Task Manager — Services — datakit — Restart
```

![image](../images/apm/7.png)

![image](../images/apm/8.png)

---

### Steps for Application Integration with Tracing (APM) {#ddtrace}

ddtrace probe download address

- Python: [https://github.com/DataDog/dd-trace-py](https://github.com/DataDog/dd-trace-py)
- Golang: [https://github.com/DataDog/dd-trace-go](https://github.com/DataDog/dd-trace-go)
- NodeJS: [https://github.com/DataDog/dd-trace-js](https://github.com/DataDog/dd-trace-js)
- PHP: [https://github.com/DataDog/dd-trace-php](https://github.com/DataDog/dd-trace-php)
- Ruby: [https://github.com/DataDog/dd-trace-rb](https://github.com/DataDog/dd-trace-rb)
- C# (dotnet): [https://github.com/DataDog/dd-trace-dotnet](https://github.com/DataDog/dd-trace-dotnet)
- C++: [https://github.com/DataDog/dd-opentracing-cpp](https://github.com/DataDog/dd-opentracing-cpp)
- Java: [https://github.com/DataDog/dd-trace-java](https://github.com/DataDog/dd-trace-java)

Explanation of ddtrace-related environment variables (startup parameters)

```java
Ddd.env: Custom environment type   (optional)
Ddd.service.name: Custom application name   (required)    If the data still does not display after configuring this setting, try removing the name.
Ddd.agent.port: Data upload port (default 9529) (required)
Ddd.version: Application version (optional)
Ddd.trace.sample.rate: Set sampling rate (default is full sample) (optional)
Ddd.service.mapping: For redis, mysql, etc., called by the current application, aliases can be added through this parameter to distinguish them from redis, mysql called by other applications (optional)
Ddd.host: Data transmission target IP, default is localhost (optional)
```

For specific configurations, refer to [Datadog Official](https://docs.datadoghq.com/tracing/setup_overview/setup/java?tab=containers)

#### Java (ddtrace) Integration:

1. Download [[ddtrace-agent](https://repo1.maven.org/maven2/com/datadoghq/dd-java-agent/)], recommended version 0.80.0

![image](../images/apm/9.png)

Place it in the same level directory as the application environment<br /> (**1.6 version of datakit onwards, ddtrace-java-agent is already embedded in datakit by default, directory: /usr/local/datakit/data/**)<br />2. Add ddtrace.jar startup parameters to the existing application startup script, filling in fields as follows -javaagent:/xxx/ddtrace.jar -Ddd.env=xxx -Ddd.service.name=xxx -Ddd.agent.port=xxx    where xxx content needs to be filled in.

---

##### Tomcat Integration

Add ddtrace startup parameters in catalina.sh, then restart tomcat. Replace xxx in the code snippet with absolute paths.

```shell
$ cd /xxx/tomcat/bin
$ vim catalina.sh

$ CATALINA_OPTS="$CATALINA_OPTS -javaagent:/xxx/ddtrace.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

$ wq!

## Restart tomcat
$ ./bin/startup.sh
```

Log in to [guance](https://<<< custom_key.studio_main_site >>>/) and enter the specific project space. Click on Application Performance Monitoring to view application data with the service name mall-admin.

---

##### Microservices Integration

Directly add ddtrace startup parameters to the startup script, then restart the application. Replace xxx in the code snippet with absolute paths.

```shell
## Original startup script:
$ nohup java -jar mall-admin.jar &

## Startup script after adding ddtrace startup parameters, execute the command to restart the application:
$ nohup java -javaagent:/xxx/dd-java-agent-0.72.0.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar &
```

Log in to [guance](https://<<< custom_key.studio_main_site >>>/) and enter the specific project space. Click on Application Performance Monitoring to view application data with the service name mall-admin.

---

##### Docker Integration

There are multiple ways to integrate in a Docker environment. Two examples are shown below:<br />1. Modify Dockerfile, repackage **Replace xxx in the code snippet with absolute paths**

```shell
$ vim Dockerfile

## Add ddteace-agent path in Dockerfile, xxx represents the absolute path
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

2. Do not modify Dockerfile, override the original startup command with startup parameters (may not apply in some scenarios)

```shell
## Original startup command
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1

## Startup command including ddtrace, need to check the jar package startup command in the dockerfile
$ docker run -p 8080:8080 --name mall-admin --link mysql:db --link redis:redis -v /etc/localtime:/etc/localtime -v /mydata/app/admin/logs:/var/logs -d mall/mall-admin:v1 java -javaagent:/wx/dd-java-agent-0.75.0.jar -Ddd.service.name=mall-admin -Ddd.version=v1 -Ddd.env=product -Ddd.agent.port=9529 -Ddd.agent.host=172.16.0.198 -jar -Dspring.profiles.active=prod /mall-admin-1.0-SNAPSHOT.jar

## Note: After adding java –javaagent, add -jar your app name.jar at the end of the startup script
```

Log in to [guance](https://<<< custom_key.studio_main_site >>>/) and enter the specific project space. Click on Application Performance Monitoring to view application data with the corresponding service.name.

---

#### C# (dotnet-ddtrace) Integration

##### IIS Hosting Environment Integration: 

Note: [[dotnet-agent download link](https://github.com/DataDog/dd-trace-dotnet/releases/)] , download x86, arm64, or other versions of the agent according to your needs.

1. **Add Server Environment Variables**

```
## Right-click This PC — Properties — Advanced System Settings — Environment Variables
## Add new system variable — Enter the following content

DD_TRACE_AGENT_URL=http://localhost:9529    (required)
DD_ENV=   Example test      (optional)
DD_SERVICE=   Example myappname     (required)
DD_VERSION=   Example 1.0     (optional)
DD_TRACE_SERVICE_MAPPING=  Example mysql:main-mysql-db    (optional)

## TRACE_AGENT_URL is the data upload IP plus port, fill in http://localhost:9529, do not recommend changing
## ENV is the system environment, set as pro or test or other content as needed
## SERVICE is the application name displayed on the df platform, set as the specific service name
## VERSION is the version number, set as needed
## TRACE_SERVICE_MAPPING renames services using the configuration, so they can be distinguished on the df platform when calling components from other business systems. Accepts mappings of service name keys to rename, and names to use, format [from-key]:[to-name]
   Note: [from-key] content is standard fields, such as mysql, redis, mongodb, oracle, do not customize changes
   Example: TRACE_SERVICE_MAPPING=mysql:main-mysql-db
         TRACE_SERVICE_MAPPING=mongodb:offsite-mongodb-service

```

![image](../images/apm/11.png)

2. **Install ddtrace-agent**

Run the dotnet-agent installer with administrator privileges, click next until installation is successful.

![image](../images/apm/12.png)

3. **Execute the following commands in PowerShell, restart IIS**

```shell
## Stop IIS service
net stop /y was

## Start IIS service
net start w3svc
```

Log in to the df platform in the application performance detection module to view the corresponding servicename application.

---

#### Python (ddtrace) Integration

[[Python Deployment Introduction](/integrations/ddtrace-python)]

---

#### .NET Core (ddtrace) Integration

Note: [[dotnet.core-agent download link](https://github.com/DataDog/dd-trace-dotnet/releases/)] , .NET Tracer currently supports application tracing on .NET Core 2.1, 3.1, and .NET 5.

1. **Run the following commands under different environments to install .net core-agent**

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

2. **Add application environment variables**

Add the following configurations to the environment variables already configured in the application
This is just for reference; the actual service name needs to be changed.

```shell
export CORECLR_ENABLE_PROFILING=1
export CORECLR_PROFILER_PATH=/opt/datadog/Datadog.Trace.ClrProfiler.Native.so
export DD_INTEGRATIONS=/opt/datadog/integrations.json
export DD_DOTNET_TRACER_HOME=/opt/datadog
export DD_TRACE_AGENT_URL=http://localhost:9529
export DD_SERVICE=service_test
export CORECLR_PROFILER={846F5F1C-F9AE-4B07-969E-05C26BC060D8}
```

3. **Restart the application**

---

### Q&A

#### Relationship between agent and jar package location

The ddtrace-agent startup parameter must be placed before -jar in the java application startup, resulting in the final form being java -javaagent -jar

```shell
## Original startup script:
$ java -jar mall-admin.jar

## Startup script after adding ddtrace startup parameters, execute the command to restart the application:
$ java -javaagent:/xxx/dd-java-agent-0.72.0.jar -Ddd.service.name=mall-admin -Ddd.agent.port=9529 -jar mall-admin.jar
```

#### tomcat-catalina.sh Parameter Configuration

Add ddtrace startup parameters in catalina.sh, then restart tomcat. Replace xxx in the code snippet with absolute paths.<br /> Ensure that CATALINA_OPTS related configurations are read by the application startup script in catalina.sh; otherwise, the application will start normally without starting ddtrace-agent.

```shell
$ cd /xxx/tomcat/bin
$ vim catalina.sh

$ CATALINA_OPTS="$CATALINA_OPTS -javaagent:/xxx/ddtrace.jar -Ddd.env=test -Ddd.service.name=demo001 -Ddd.agent.port=9529"; export CATALINA_OPTS

$ wq!

## Restart tomcat
$ ./bin/startup.sh
```

Log in to [guance](https://<<< custom_key.studio_main_site >>>/) and enter the specific project space. Click on Application Performance Monitoring to view application data with the service name mall-admin.