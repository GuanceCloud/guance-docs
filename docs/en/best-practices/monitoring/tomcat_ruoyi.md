# Best Practices for Observability Deployment of RuoYi Monolithic Applications on Tomcat

Based on the [RuoYi monolithic application](https://gitee.com/y_project/RuoYi/tree/master), this document demonstrates best practices for observability in an external Tomcat environment.

## Implementation Goals


- [x] Collect Metrics information
- [x] Collect Trace information
- [x] Collect LOG information
- [x] Collect RUM information
- [x] SESSION REPLAY
    This refers to the recording of user sessions when accessing the frontend, including button clicks, interface operations, and dwell times. It helps in understanding customer intent and reproducing operations.


## Version Information

- [ ] Tomcat (9.0.81)
- [ ] Springboot (2.6.2)
- [ ] JDK (>=8) 
- [ ] DDTrace (>=1.0)

???+ info "Special Notes"

    For Springboot projects, the major version of Tomcat must align with the major version of the embedded Tomcat in Springboot; otherwise, there may be startup exceptions.


## RuoYi Monolithic Application

- Download Source Code

[RuoYi Monolithic Application](https://gitee.com/y_project/RuoYi/tree/master)

```shell
git clone https://gitee.com/y_project/RuoYi.git
```

- Remove Internal Tomcat

Adjust the `pom.xml` file in the project root directory:

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
                <!-- Remove internal tomcat -->
                <exclusions>
	                <exclusion>
		                <artifactId>spring-boot-starter-tomcat</artifactId>
		                <groupId>org.springframework.boot</groupId>
	                </exclusion>
                </exclusions>
            </dependency>
......
```

- `war` Output

Adjust the `pom.xml` file under the `ruoyi-admin` module:

```xml
<packaging>war</packaging>
```

- Adjust Logs

Add a new `logback-spring.xml` file in `ruoyi-admin/src/main/resources`. The original content is as follows:

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
                <!-- Log filename format -->
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
                <!-- Action when matched: accept (record) -->
                <onMatch>ACCEPT</onMatch>
                <!-- Action when unmatched: deny (do not record) -->
                <onMismatch>DENY</onMismatch>
            </filter>
        </appender>
        
        <appender name="file_error" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-error.log</file>
            <!-- Rolling policy: create log files based on time -->
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- Log filename format -->
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
                <!-- Action when matched: accept (record) -->
                <onMatch>ACCEPT</onMatch>
                <!-- Action when unmatched: deny (do not record) -->
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

Run the following command in the project root directory to compile:

```shell
mvn clean package
```

If Maven is not installed, you need to install Maven first before compiling.

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

Refer to the [DataKit Installation Documentation](/datakit/datakit-install/)

### Enable DDTrace Collector in DataKit

**DDTrace Collector**: Used to collect trace information from applications. Refer to the [DDTrace Collector](/integrations/ddtrace/) integration documentation.

### Enable Log Collector in DataKit

**Log Collector**: Used to collect log information. Refer to the [Log Collector](/integrations/logging/) integration documentation.

The following information needs to be adjusted:

```toml
 logfiles = [
    "/home/liurui/ruoyi/logs/*.log",
  ]
  ## Add service tag, if it's empty, use $source.
  service = "ruoyi"

  ## Grok pipeline script name.
  pipeline = "ruoyi.p"

```

- logfiles: Path to the log files that need to be collected
- service: Service name
- `pipeline`: Log parsing


**Pipeline** Configuration

**Pipeline** is used for data governance, primarily extracting log information here to associate with trace information.

Create a `ruoyi.p` file in the `datakit/pipeline/` directory with the following content:

```shell
grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service_name2} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time,"Asia/Shanghai")

```


### Enable StatsD Collector in DataKit

**StatsD Collector**: Used to collect metrics information. Refer to the [StatsD Collector](/integrations/statsd/) integration documentation.

### Enable RUM Collector in DataKit

**RUM Collector**: The RUM (Real User Monitor) collector is used to collect user monitoring data reported from web pages or mobile ends. Refer to the [RUM Collector](/integrations/rum/) integration documentation.

### Restart DataKit

[Restart DataKit](/datakit/datakit-service-how-to#manage-service)

## DDTrace

Download [dd-trace-java](https://github.com/GuanceCloud/dd-trace-java/releases), preferably the latest version.

## Create RUM

1. Login to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>)
2. Select `Synthetic Tests`, choose `Service List`, and click `Create`.
3. Fill in the `Application Name` as `ruoyi-admin`. The `Application ID` can be customized or generated randomly by clicking the `Random Generation` button.
4. Select `web` for `Application Type`. On the right side, there are several types of `SDK Configurations`. Here we select `CDN Synchronous Loading`. ***Copy the corresponding script content, which will be used later***.
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

- `javaagent`: Specifies the `ddtace` directory
- `Dlogging.config`: Specifies that the application's logs are output using `logback`. If the application internally uses log4j, specify the corresponding file.

### Deploy Application

Copy the packaged application `RuoYi/ruoyi-admin/target/ruoyi-admin.war` to the `webapps` directory of Tomcat.

### Start Tomcat

Execute bin/startup.sh

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

After starting Tomcat, the `war` application automatically unzips. Navigate to `/webapps/ruoyi-admin/WEB-INF/classes/templates`, adjust `include.html`, and paste the script code copied in the previous step into the `head`.

```
<head th:fragment=header(title)>
...
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'APP_ID',
      datakitOrigin: 'http://localhost:9529', // Protocol (including ://), domain (or IP address)[and port number]
      env: 'production',
      version: '1.0.0',
      service: 'browser',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // Optional, default is ddtrace. Currently supports ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent six types
      allowedTracingOrigins: ['http://localhost:8080','http://localhost:8080/ruoyi-admin'],  // Optional, allows all requests where headers needed for trace collection can be injected. Can be request origin or regex
    });
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
...
</head>
```

- applicationId: No adjustment needed if copied correctly.
- datakitOrigin: Address of DataKit receiving RUM data
- allowedTracingOrigins: Links front-end APM with API calls initiated by the front end, adding necessary Header information for Trace in the corresponding API interface



## Results

Access `http://localhost:8080/ruoyi-admin`, default username: `admin`, password: `admin123`.

![Img](../images/tomcat_ruoyi_1.png)


### Logs

![Img](../images/tomcat_ruoyi_2.png)

In the log details, you can view the associated trace information.

![Img](../images/tomcat_ruoyi_3.png)

### Trace Information

![Img](../images/tomcat_ruoyi_4.png)

You can also view log and metric information through traces.

![Img](../images/tomcat_ruoyi_5.png)


### Metrics Information

![Img](../images/tomcat_ruoyi_6.png)

### RUM Dashboard

![Img](../images/tomcat_ruoyi_7.png)


### Session Replay

![Img](../images/tomcat_ruoyi_8.png)