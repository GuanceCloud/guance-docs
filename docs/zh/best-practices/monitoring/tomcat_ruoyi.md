# Tomcat 下部署若依单体应用可观测最佳实践

基于[若依的单体应用](https://gitee.com/y_project/RuoYi/tree/master)来实现在外部 Tomcat 环境下可观测性最佳实践

## 实现目标


- [x] 采集指标信息
- [x] 采集链路信息
- [x] 采集日志信息
- [x] 采集 RUM 信息
- [x] 会话重放
    即用户访问前端的一系列过程的会话录制信息，包括点击某个按钮、操作界面、停留时间等，有助于客户真是意图、操作复现


## 版本信息

- [ ] Tomcat (9.0.81)
- [ ] Springboot(2.6.2)
- [ ] JDK (>=8) 
- [ ] DDTrace (>=1.0)

???+ info "特别说明"

    如果是 Springboot 项目，Tomcat 大版本需与 Springboot 内置的 Tomcat 大版本一致，否则可能会存在启动异常。


## 若依的单体应用

- 下载源码

[若依的单体应用](https://gitee.com/y_project/RuoYi/tree/master)

```shell
git clone https://gitee.com/y_project/RuoYi.git
```

- 移除内部 tomcat

调整项目根目录的 `pom.xml`

```xml
......
    <dependencyManagement>
        <dependencies>
        
            <!-- SpringBoot的依赖配置-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>2.5.15</version>
                <type>pom</type>
                <scope>import</scope>
                <!-- 移除内部 tomcat -->
                <exclusions>
	                <exclusion>
		                <artifactId>spring-boot-starter-tomcat</artifactId>
		                <groupId>org.springframework.boot</groupId>
	                </exclusion>
                </exclusions>
            </dependency>
......
```

- `war` 输出

调整 `ruoyi-admin` 模块下的 `pom.xml` 文件

```xml
<packaging>war</packaging>
```

- 调整日志

在 `ruoyi-admin/src/main/resources` 新增 `logback-spring.xml`，原文如下：

???- info "logback-spring.xml"

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <!-- 日志存放路径 -->
        <property name="log.path" value="/home/root/ruoyi/logs" />
        <!-- 日志输出格式 -->
        <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />

        <!-- 控制台输出 -->
        <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
        </appender>
        
        <!-- 系统日志输出 -->
        <appender name="file_info" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-info.log</file>
            <!-- 循环政策：基于时间创建日志文件 -->
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- 日志文件名格式 -->
                <fileNamePattern>${log.path}/sys-info.%d{yyyy-MM-dd}.log</fileNamePattern>
                <!-- 日志最大的历史 60天 -->
                <maxHistory>60</maxHistory>
            </rollingPolicy>
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
            <filter class="ch.qos.logback.classic.filter.LevelFilter">
                <!-- 过滤的级别 -->
                <level>INFO</level>
                <!-- 匹配时的操作：接收（记录） -->
                <onMatch>ACCEPT</onMatch>
                <!-- 不匹配时的操作：拒绝（不记录） -->
                <onMismatch>DENY</onMismatch>
            </filter>
        </appender>
        
        <appender name="file_error" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-error.log</file>
            <!-- 循环政策：基于时间创建日志文件 -->
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- 日志文件名格式 -->
                <fileNamePattern>${log.path}/sys-error.%d{yyyy-MM-dd}.log</fileNamePattern>
                <!-- 日志最大的历史 60天 -->
                <maxHistory>60</maxHistory>
            </rollingPolicy>
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
            <filter class="ch.qos.logback.classic.filter.LevelFilter">
                <!-- 过滤的级别 -->
                <level>ERROR</level>
                <!-- 匹配时的操作：接收（记录） -->
                <onMatch>ACCEPT</onMatch>
                <!-- 不匹配时的操作：拒绝（不记录） -->
                <onMismatch>DENY</onMismatch>
            </filter>
        </appender>
        
        <!-- 用户访问日志输出  -->
        <appender name="sys-user" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>${log.path}/sys-user.log</file>
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- 按天回滚 daily -->
                <fileNamePattern>${log.path}/sys-user.%d{yyyy-MM-dd}.log</fileNamePattern>
                <!-- 日志最大的历史 60天 -->
                <maxHistory>60</maxHistory>
            </rollingPolicy>
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
        </appender>
        
        <!-- 系统模块日志级别控制  -->
        <logger name="com.ruoyi" level="info" />
        <!-- Spring日志级别控制  -->
        <logger name="org.springframework" level="warn" />

        <root level="info">
            <appender-ref ref="console" />
        </root>
        
        <!--系统操作日志-->
        <root level="debug">
            <appender-ref ref="file_info" />
            <appender-ref ref="file_error" />
        </root>
        
        <!--系统用户操作日志-->
        <logger name="sys-user" level="info">
            <appender-ref ref="sys-user"/>
        </logger>
    </configuration> 
    ```

- 编译

进入项目根目录执行以下命令进行编译：

```shell
mvn clean package
```

如果没有安装 Maven，则需要先安装 Maven 再进行编译

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

- 安装 DataKit
- 开启采集器

### 安装 DataKit

参考 [DataKit 安装文档](/datakit/datakit-install/)

### DataKit 开启 DDTrace 采集器

**DDTrace 采集器**用于采集应用链路信息，参考[DDTrace 采集器](/integrations/ddtrace/)接入文档。

### DataKit 开启 Log 采集器

**Log 采集器**用于采集日志信息，参考[Log 采集器](/integrations/logging/)接入文档。

需要调整以下信息

```toml
 logfiles = [
    "/home/liurui/ruoyi/logs/*.log",
  ]
  ## Add service tag, if it's empty, use $source.
  service = "ruoyi"

  ## Grok pipeline script name.
  pipeline = "ruoyi.p"

```

- logfiles：需要采集的日志文件路径
- service: 服务名称
- `pipeline`： 日志解析


**Pipeline** 配置

**Pipeline** 用于数据治理，这里主要是将日志信息进行提取，以便与链路信息关联。

在 `datakit/pipeline/`目录下创建 `ruoyi.p` 文件，内容如下：

```shell
grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] %{DATA:service_name2} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time,"Asia/Shanghai")

```


### DataKit 开启 StatsD 采集器

**StatsD 采集器**用于采集指标信息，参考[StatsD 采集器](/integrations/statsd/)接入文档。

### DataKit 开启 RUM 采集器

**RUM 采集器**: RUM（Real User Monitor）采集器用于收集网页端或移动端上报的用户访问监测数据。参考[RUM 采集器](/integrations/rum/)接入文档。

### 重启 DataKit

[重启 DataKit](/datakit/datakit-service-how-to#manage-service)

## DDTrace

下载 [dd-trace-java](https://github.com/GuanceCloud/dd-trace-java/releases)，尽量下载最新版本

## 创建 RUM

1. 登陆[观测云](www.guance.com)
2. 选择`用户访问检测`，选择`应用列表`，点击`新建应用`
3. `应用名称`填写`ruoyi-admin`，`应用 ID`可以自定义，也可以点击`随机生成`按钮
4. `应用类型` 选择 `web`，右边 `SDK 配置`有几个类型，这里我们选择 `CDN 同步载入`，***复制对应的脚本内容，后续会用到***。
5. 点击`创建`按钮，完成创建。

## Tomcat 

### 下载 Tomcat

下载对应版本的 [Tomcat](https://tomcat.apache.org/download-90.cgi)

### 配置 DDTrace

在 Tomcat `bin` 目录下新增脚本`setenv.sh`文件

```
export CATALINA_OPTS="-javaagent:/home/root/agent/dd-java-agent-1.14.0-guance.jar \
                      -Ddd.tags=env:test \
                      -Ddd.jmxfetch.enabled=true \
                      -Ddd.jmxfetch.statsd.host=localhost \
                      -Ddd.jmxfetch.statsd.port=8125 \
                      -Ddd.jmxfetch.tomcat.enabled=true\
                      -Dlogging.config=classpath:logback-spring.xml"
```

- `javaagent`: 指定`ddtace`目录
- `Dlogging.config`: 指定应用的日志以 `logback`日志输出。如果应用内部使用的是log4j，指定对应的文件即可。

### 部署应用

将已经打包好的应用`RuoYi/ruoyi-admin/target/ruoyi-admin.war` 复制到 Tomcat 的 `webapps` 下

### 启动 Tomcat

执行 bin/startup.sh

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

### 加入 RUM

Tomcat 启动完成后，自动解压 `war`应用，进入到`/webapps/ruoyi-admin/WEB-INF/classes/templates`目录下，调整`include.html`，将上一步复制的脚本代码粘贴到 `head`。

```
<head th:fragment=header(title)>
...
<script src="https://static.guance.com/browser-sdk/v3/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'APP_ID',
      datakitOrigin: 'http://localhost:9529', // 协议（包括：//），域名（或IP地址）[和端口号]
      env: 'production',
      version: '1.0.0',
      service: 'browser',
      sessionSampleRate: 100,
      sessionReplaySampleRate: 70,
      trackInteractions: true,
      traceType: 'ddtrace', // 非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型
      allowedTracingOrigins: ['http://localhost:8080','http://localhost:8080/ruoyi-admin'],  // 非必填，允许注入trace采集器所需header头部的所有请求列表。可以是请求的origin，也可以是是正则
    });
    window.DATAFLUX_RUM && window.DATAFLUX_RUM.startSessionReplayRecording()
</script>
...
</head>
```

- applicationId：复制过来的就不需要调整。
- datakitOrigin: 用于接收 RUM 数据上报的 DataKit 地址
- allowedTracingOrigins： 与后端 APM 串联，前端调用 API 接口，会在对应的接口新增 Trace 所需的 Header 信息



## 效果

访问 `http://localhost:8080/ruoyi-admin`，默认用户名：`admin`，密码：`admin123`。

![Img](../images/tomcat_ruoyi_1.png)


### 日志

![Img](../images/tomcat_ruoyi_2.png)

进入日志详情，可以查看到当前日志对应的链路信息

![Img](../images/tomcat_ruoyi_3.png)

### 链路信息

![Img](../images/tomcat_ruoyi_4.png)

也可以通过链路查看日志和指标信息

![Img](../images/tomcat_ruoyi_5.png)


### 指标信息

![Img](../images/tomcat_ruoyi_6.png)

### RUM 看板

![Img](../images/tomcat_ruoyi_7.png)


### 会话重放

![Img](../images/tomcat_ruoyi_8.png)
