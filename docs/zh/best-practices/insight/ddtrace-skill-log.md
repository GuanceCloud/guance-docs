# ddtrace log 关联

---

???+ attention

    **当前案例使用 ddtrace 版本`0.114.0`（最新版本）进行测试**

## 前置条件

- 开启 [DataKit ddtrace 采集器](/integrations/ddtrace/)
- 准备 Shell

  ```shell
  java -javaagent:D:/ddtrace/dd-java-agent-0.114.0.jar \
  -Ddd.service.name=ddtrace-server \
  -Ddd.agent.port=9529 \
  -jar springboot-ddtrace-server.jar
  ```

> **注意：**<br/>- trace 与 log 关联，都是通过 MDC 方式进行埋点。<br/>
    - 此处不需要 jar 包依赖，由 ddtrace-agent 对 MDC 进行埋点操作。

## 安装部署

以 `logback-spring.xml` 为例

### 1 logback-spring.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="30 seconds">
    <!-- 部分参数需要来源于properties文件 -->
    <springProperty scope="context" name="logName" source="spring.application.name" defaultValue="localhost.log"/>
    <!-- 配置后可以动态修改日志级别-->
    <jmxConfigurator />
    <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />

    <!-- %m输出的信息,%p日志级别,%t线程名,%d日期,%c类的全名,,,, -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/${logName}/${logName}.log</file>    <!-- 使用方法 -->
        <append>true</append>
        <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <fileNamePattern>logs/${logName}/${logName}-%d{yyyy-MM-dd}.log.%i</fileNamePattern>
            <maxFileSize>64MB</maxFileSize>
            <maxHistory>30</maxHistory>
            <totalSizeCap>1GB</totalSizeCap>
        </rollingPolicy>
        <encoder>
            <pattern>${log.pattern}</pattern>
            <charset>UTF-8</charset>
        </encoder>
    </appender>

    <!-- 只打印error级别的内容 -->
    <logger name="com.netflix" level="ERROR" />
    <logger name="net.sf.json" level="ERROR" />
    <logger name="org.springframework" level="ERROR" />
    <logger name="springfox" level="ERROR" />

    <!-- sql 打印 配置-->
    <logger name="com.github.pagehelper.mapper" level="DEBUG" />
    <logger name="org.apache.ibatis" level="DEBUG" />

    <root level="info">
        <appender-ref ref="STDOUT" />
        <appender-ref ref="FILE" />
    </root>
</configuration>
```

主要是通过 pattern 配置日志格式

```
%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n
```

```java
2022-06-10 17:07:45.257 [main] INFO  o.a.c.c.StandardEngine - [log,173] ddtrace-server   - Starting Servlet engine: [Apache Tomcat/9.0.56]
2022-06-10 17:07:45.369 [main] INFO  o.a.c.c.C.[.[.[/] - [log,173] ddtrace-server   - Initializing Spring embedded WebApplicationContext
2022-06-10 17:07:45.758 [main] INFO  o.a.c.h.Http11NioProtocol - [log,173] ddtrace-server   - Starting ProtocolHandler ["http-nio-8080"]
2022-06-10 17:07:45.786 [main] INFO  c.z.o.d.DdtraceApplication - [logStarted,61] ddtrace-server   - Started DdtraceApplication in 2.268 seconds (JVM running for 5.472)
2022-06-10 17:09:01.493 [http-nio-8080-exec-1] INFO  o.a.c.c.C.[.[.[/] - [log,173] ddtrace-server 5983174698688502665 5075189911231446778 - Initializing Spring DispatcherServlet 'dispatcherServlet'
2022-06-10 17:09:01.550 [http-nio-8080-exec-1] INFO  c.z.o.d.c.IndexController - [gateway,48] ddtrace-server 5983174698688502665 7355870844984555943 - this is tag
2022-06-10 17:09:01.625 [http-nio-8080-exec-3] INFO  c.z.o.d.c.IndexController - [auth,69] ddtrace-server 5983174698688502665 7209299453959523135 - this is auth
2022-06-10 17:09:01.631 [http-nio-8080-exec-4] INFO  c.z.o.d.c.IndexController - [billing,77] ddtrace-server 5983174698688502665 9179949003735674110 - this is method3,null
```

### 2 DataKit 采集日志

上述日志输出到文本后，DataKit 可以从文本文件里面读取日志信息并上报到观测云。

#### 2.1 开启日志采集器

```toml
# {"version": "1.2.18", "desc": "do NOT edit this line"}

[[inputs.logging]]
  ## required
  logfiles = [
    "D:/code_zy/observable-demo/logs/ddtrace-server/*.log",
  ]
  # only two protocols are supported:TCP and UDP
  # sockets = [
  #	 "tcp://0.0.0.0:9530",
  #	 "udp://0.0.0.0:9531",
  # ]
  ## glob filteer
  ignore = [""]

  ## your logging source, if it's empty, use 'default'
  source = "ddtrace-server"

  ## add service tag, if it's empty, use $source.
  service = "ddtrace-server"

  ## grok pipeline script name
  pipeline = "log-ddtrace.p"

  ## optional status:
  ##   "emerg","alert","critical","error","warning","info","debug","OK"
  ignore_status = []

  ## optional encodings:
  ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
  character_encoding = ""

  ## datakit read text from Files or Socket , default max_textline is 32k
  ## If your log text line exceeds 32Kb, please configure the length of your text,
  ## but the maximum length cannot exceed 32Mb
  # maximum_length = 32766

  ## The pattern should be a regexp. Note the use of '''this regexp'''
  ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
  # multiline_match = '''^\S'''

  ## removes ANSI escape codes from text strings
  remove_ansi_escape_codes = false

  ## if file is inactive, it is ignored
  ## time units are "ms", "s", "m", "h"
  ignore_dead_log = "10m"

  [inputs.logging.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"

```

#### 2.2 配置 Pipeline

目的是为了将日志进行切割，将一些关键的字段作为 tag，用于过滤、筛选和数据分析。

```toml
#日志样式
#2022-06-10 17:09:01.625 [http-nio-8080-exec-3] INFO  c.z.o.d.c.IndexController - [auth,69] ddtrace-server 5983174698688502665 7209299453959523135 - this is auth

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time,"Asia/Shanghai")

```

切割后的日志，已经产生了很多 tag

![image.png](../images/ddtrace-skill-11.png)

> 观测云也支持其他的日志方式采集，比如 socket，更多日志采集可参考：[日志](/best-practices/cloud-native/k8s-logs/)

### 3 效果展示

当我们从日志里面把 `traceId` 和 `spanId` 切出来后，观测云上可以直接从日志关联到对应的链路信息，实现了日志链路的互通行为。

![guance-log.gif](../images/ddtrace-skill-12.gif)

## 参考文档

<[demo 源码地址](https://github.com/lrwh/observable-demo/tree/main/springboot-ddtrace-server)>

[ddtrace 启动参数](/integrations/ddtrace-java/#start-options)
