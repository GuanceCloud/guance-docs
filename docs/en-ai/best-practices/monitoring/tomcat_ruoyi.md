# Best Practices for Deploying RuoYi Monolithic Application Observability on Tomcat

Based on the [RuoYi monolithic application](https://gitee.com/y_project/RuoYi/tree/master), this guide demonstrates best practices for observability in an external Tomcat environment.

## Objectives

- [x] Collect Metrics information
- [x] Collect trace information
- [x] Collect log information
- [x] Collect RUM information
- [x] Session replay
    This involves recording user interactions with the frontend, including button clicks, interface operations, dwell times, etc., which helps in understanding user intent and reproducing operations.

## Version Information

- [ ] Tomcat (9.0.81)
- [ ] Springboot (2.6.2)
- [ ] JDK (>=8) 
- [ ] DDTrace (>=1.0)

???+ info "Special Notes"

    If it is a Springboot project, the major version of Tomcat should match the major version of the embedded Tomcat in Springboot; otherwise, startup issues may occur.

## RuoYi Monolithic Application

- Download source code

[Link to RuoYi monolithic application](https://gitee.com/y_project/RuoYi/tree/master)

```shell
git clone https://gitee.com/y_project/RuoYi.git
```

- Remove internal Tomcat

Modify the `pom.xml` file at the root directory of the project:

```xml
......
<dependencyManagement>
    <dependencies>
        <!-- SpringBoot dependency configuration -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>2.5.15</version>
            <type>pom</type>
            <scope>import</scope>
            <!-- Remove internal Tomcat -->
            <exclusions>
                <exclusion>
                    <artifactId>spring-boot-starter-tomcat</artifactId>
                    <groupId>org.springframework.boot</groupId>
                </exclusion>
            </exclusions>
        </dependency>
......
```

- Output as `war`

Modify the `pom.xml` file under the `ruoyi-admin` module:

```xml
<packaging>war</packaging>
```

- Adjust logging

Add `logback-spring.xml` in `ruoyi-admin/src/main/resources`, with the following content:

???- info "logback-spring.xml"

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <!-- Log storage path -->
        <property name="log.path" value="/home/root/ruoyi/logs" />
        <!-- Log output format -->
        <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />

        <!-- Console output -->
        <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
        </appender>
        
        <!-- System log output -->
        <appender name="file_info" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-info.log</file>
            <!-- Rolling policy: create log files based on time -->
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- Log file name pattern -->
                <fileNamePattern>${log.path}/sys-info.%d{yyyy-MM-dd}.log</fileNamePattern>
                <!-- Maximum history of logs 60 days -->
                <maxHistory>60</maxHistory>
            </rollingPolicy>
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
            <filter class="ch.qos.logback.classic.filter.LevelFilter">
                <!-- Filter level -->
                <level>INFO</level>
                <!-- Action when matched: accept (log) -->
                <onMatch>ACCEPT</onMatch>
                <!-- Action when unmatched: deny (do not log) -->
                <onMismatch>DENY</onMismatch>
            </filter>
        </appender>
        
        <appender name="file_error" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-error.log</file>
            <!-- Rolling policy: create log files based on time -->
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- Log file name pattern -->
                <fileNamePattern>${log.path}/sys-error.%d{yyyy-MM-dd}.log</fileNamePattern>
                <!-- Maximum history of logs 60 days -->
                <maxHistory>60</maxHistory>
            </rollingPolicy>
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
            <filter class="ch.qos.logback.classic.filter.LevelFilter">
                <!-- Filter level -->
                <level>ERROR</level>
                <!-- Action when matched: accept (log) -->
                <onMatch>ACCEPT</onMatch>
                <!-- Action when unmatched: deny (do not log) -->
                <onMismatch>DENY</onMismatch>
            </filter>
        </appender>
        
        <!-- User access log output -->
        <appender name="sys-user" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-user.log</file>
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- Roll daily -->
                <fileNamePattern>${log.path}/sys-user.%d{yyyy-MM-dd}.log</fileNamePattern>
                <!-- Maximum history of logs 60 days -->
                <maxHistory>60</maxHistory>
            </rollingPolicy>
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
        </appender>
        
        <!-- System module log level control -->
        <logger name="com.ruoyi" level="info" />
        <!-- Spring log level control -->
        <logger name="org.springframework" level="warn" />

        <root level="info">
            <appender-ref ref="console" />
        </root>
        
        <!-- System operation logs -->
        <root level="debug">
            <appender-ref ref="file_info" />
            <appender-ref ref="file_error" />
        </root>
        
        <!-- System user operation logs -->
        <logger name="sys-user" level="info">
            <appender-ref ref="sys-user"/>
        </logger>
    </configuration> 
    ```

- Compile

Run the following command in the project's root directory to compile:

```shell
mvn clean package
```

If Maven is not installed, install Maven first before compiling.

```shell
[INFO] --- spring-boot:2.5.15:repackage (default) @ ruoyi-admin ---
[INFO] Replacing main artifact with repackaged archive
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary for ruoyi 4.7.7:
[INFO] 
[INFO] ruoyi .............................................. SUCCESS [  0.179 s]
[INFO] ruoyi-common ....................................... SUCCESS [  4.622 s]
[INFO] ruoyi-system ....................................... SUCCESS [  0.770 s]
[INFO] ruoyi-framework .................................... SUCCESS [  0.950 s]
[INFO] ruoyi-quartz ....................................... SUCCESS [  0.388 s]
[INFO] ruoyi-generator .................................... SUCCESS [  0.378 s]
[INFO] ruoyi-admin ........................................ SUCCESS [  4.554 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  12.287 s
[INFO] Finished at: 2023-10-13T16:30:12+08:00
[INFO] ------------------------------------------------------------------------
```

## DataKit

- Install DataKit
- Enable collectors

### Install DataKit

Refer to the [DataKit installation documentation](/datakit/datakit-install/)

### Enable DDTrace Collector in DataKit

The **DDTrace collector** is used to collect trace information from applications. Refer to the [DDTrace collector integration documentation](/integrations/ddtrace/).

### Enable Log Collector in DataKit

The **Log collector** is used to collect log information. Refer to the [Log collector integration documentation](/integrations/logging/).

Adjust the following settings:

```toml
logfiles = [
    "/home/liurui/ruoyi/logs/*.log",
]
## Add service tag, if it's empty, use $source.
service = "ruoyi"

## Grok pipeline script name.
pipeline = "ruoyi.p"
```

- `logfiles`: Path to the log files to be collected
- `service`: Service name
- `pipeline`: Log parsing

**Pipeline Configuration**

The **Pipeline** is used for data governance, primarily extracting log information to correlate with trace data.

Create a `ruoyi.p` file in the `datakit/pipeline/` directory with the following content:

```shell
grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service_name2} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time,"Asia/Shanghai")
```

### Enable StatsD Collector in DataKit

The **StatsD collector** is used to collect metrics information. Refer to the [StatsD collector integration documentation](/integrations/statsd/).

### Enable RUM Collector in DataKit

The **RUM collector**: RUM (Real User Monitor) collector is used to collect user visit monitoring data from web or mobile clients. Refer to the [RUM collector integration documentation](/integrations/rum/).

### Restart DataKit

[Restart DataKit](/datakit/datakit-service-how-to#manage-service)

## DDTrace

Download [dd-trace-java](https://github.com/GuanceCloud/dd-trace-java/releases), preferably the latest version.

## Create RUM

1. Log in to [<<< custom_key.brand_name >>>](https://www.guance.com)
2. Select `User Analysis`, choose `Application List`, and click `Create`
3. Fill in `Application Name` as `ruoyi-admin`, and customize or generate the `Application ID` using the `Random Generate` button
4. Choose `web` for `Application Type`. On the right side, select `CDN Synchronous Loading` for `SDK Configuration` and ***copy the corresponding script content for later use***.
5. Click the `Create` button to complete creation.

## Tomcat

### Download Tomcat

Download the corresponding version of [Tomcat](https://tomcat.apache.org/download-90.cgi)

### Configure DDTrace

Add a new script file `setenv.sh` in the Tomcat `bin` directory:

```
export CATALINA_OPTS="-javaagent:/home/root/agent/dd-java-agent-1.14.0-guance.jar \
                      -Ddd.tags=env:test \
                      -Ddd.jmxfetch.enabled=true \
                      -Ddd.jmxfetch.statsd.host=localhost \
                      -Ddd.jmxfetch.statsd.port=8125 \
                      -Ddd.jmxfetch.tomcat.enabled=true\
                      -Dlogging.config=classpath:logback-spring.xml"
```

- `javaagent`: Specifies the `ddtrace` agent directory
- `Dlogging.config`: Specifies the application's log output using `logback`. If the application uses log4j internally, specify the corresponding file.

### Deploy Application

Copy the packaged application `RuoYi/ruoyi-admin/target/ruoyi-admin.war` to the `webapps` directory of Tomcat.

### Start Tomcat

Execute `bin/startup.sh`

```shell
apache-tomcat-9.0.81/bin$ ./startup.sh 
Using CATALINA_BASE:   /home/root/middleware/apache-tomcat-9.0.81
Using CATALINA_HOME:   /home/root/middleware/apache-tomcat-9.0.81
Using CATALINA_TMPDIR: /home/root/middleware/apache-tomcat-9.0.81/temp
Using JRE_HOME:        /home/root/middleware/jdk/jdk-11.0.18
Using CLASSPATH:       /home/root/middleware/apache-tomcat-9.0.81/bin/bootstrap.jar:/home/root/middleware/apache-tomcat-9.0.81/bin/tomcat-juli.jar
Using CATALINA_OPTS:   -javaagent:/home/root/agent/dd-java-agent-1.14.0-guance.jar                       -Ddd.tags=env:test                       -Ddd.jmxfetch.enabled=true                       -Ddd.jmxfetch.statsd.host=localhost                       -Ddd.jmxfetch.statsd.port=8125                       -Ddd.jmxfetch.tomcat.enabled=true                      -Dlogging.config=classpath:logback-spring.xml
Tomcat started.
```

### Integrate RUM

After Tomcat starts, it automatically unzips the `war` application. Navigate to `/webapps/ruoyi-admin/WEB-INF/classes/templates` and modify `include.html`, pasting the previously copied script into the `head`.

```
<head th:fragment=header(title)>
...
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'APP_ID',
      datakitOrigin: 'http://localhost:9529', // Protocol (including: //), domain (or IP address)[and port number]
      env: 'production',
      version: '1.0.0',
      service: 'browser',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent
      allowedTracingOrigins: ['http://localhost:8080','http://localhost:8080/ruoyi-admin'],  // Optional, list of origins or regex patterns for injecting trace headers in API requests
    });
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
...
</head>
```

- `applicationId`: No need to change if copied correctly.
- `datakitOrigin`: Address of the DataKit receiving RUM data
- `allowedTracingOrigins`: To link with backend APM, frontend API calls will include necessary trace headers in the request.

## Results

Access `http://localhost:8080/ruoyi-admin`, default username: `admin`, password: `admin123`.

![Img](../images/tomcat_ruoyi_1.png)

### Logs

![Img](../images/tomcat_ruoyi_2.png)

In the log details, you can view the corresponding trace information.

![Img](../images/tomcat_ruoyi_3.png)

### Trace Information

![Img](../images/tomcat_ruoyi_4.png)

You can also view logs and metrics through traces.

![Img](../images/tomcat_ruoyi_5.png)

### Metrics Information

![Img](../images/tomcat_ruoyi_6.png)

### RUM Dashboard

![Img](../images/tomcat_ruoyi_7.png)

### Session Replay

![Img](../images/tomcat_ruoyi_8.png)