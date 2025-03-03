# Logback Socket 日志采集最佳实践

---

## 简介

对一个公司来说，{{{ custom_key.brand_name }}}的空间会收集到多个应用的日志，如何区分这些日志来源哪个 Service 是我们遇到的痛点。接下来我们将一起探索如何使用 Pipeline 给日志增加 Service 标签，用来区分日志来源。             <br />        DataKit 采集日志方式有很多，本文重点阐述 Java 的 Springboot 应用中通过 Socket 采集日志，通过Logback 的 Socket 把日志传到 DataKit 。首先由运维在 DataKit 中开启 Socket 采集器，重启 DataKit 。接下来由开发在应用的logback-spring.xml 文件增加 Appender ，并且声明 springProperty ，用来在启动 jar 的时候把Service 名写入到日志中。然后开发启动 jar，把需要写入日志的 Service 名传入应用。最后开发登录{{{ custom_key.brand_name }}}，在日志模块的 Pipeline 标签下面新建 Pipeline ，指定运维开通的 Socket 采集器的 Source 。这样日志就会被做成 Tag区分出来了。<br />        下面提供的解决方案，将会按照开发和运维的角度来共同实现这个功能。

## 解决方案

### 运维

#### Linux 环境

##### 1 开通采集器

登录部署了 DataKit 的 Linux 服务器， 新增 logging-socket.conf  文件。

```
cd /usr/local/datakit/conf.d/log
vi logging-socket.conf
```

logging-socket.conf 文件内容如下：

```toml
      [[inputs.logging]]
        # only two protocols are supported:TCP and UDP
        sockets = [
          "tcp://0.0.0.0:9542",
        #"udp://0.0.0.0:9531",                  
        ]
        ignore = [""]
        source = "socketdefault"
        service = ""
        pipeline = ""
        ignore_status = []
        character_encoding = ""
        # multiline_match = '''^\S'''
        remove_ansi_escape_codes = false

        [inputs.logging.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
```

##### 2 重启 DataKit 

```shell
systemctl restart datakit
```

#### Kubernetes 环境

登录[{{{ custom_key.brand_name }}}](https://console.guance.com/)，【集成】->【Datakit】-> 【Kubernetes】，请按照指引安装 DataKit ，其中部署使用的datakit.yaml 接下来需要做修改。步骤是创建 logging-socket.conf 文件，在挂载到 DataKit 中。

##### 1 ConfigMap 增加配置

```yaml
    logging-socket.conf: |-
      [[inputs.logging]]
        # only two protocols are supported:TCP and UDP
        sockets = [
          "tcp://0.0.0.0:9542",
        #"udp://0.0.0.0:9531",                  
        ]
        ignore = [""]
        source = "pay-socket-service"
        service = ""
        pipeline = ""
        ignore_status = []
        character_encoding = ""
        # multiline_match = '''^\S'''
        remove_ansi_escape_codes = false

        [inputs.logging.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
```

##### 2 挂载 logging-socket.conf

```yaml
        - mountPath: /usr/local/datakit/conf.d/log/logging-socket.conf
          name: datakit-conf
          subPath: logging-socket.conf
```

##### 3 重启 DataKit 

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

#### 参数说明

- sockets:  协议端口。
- ignore:  文件路径过滤，使用glob 规则，符合任意一条过滤条件将不会对该文件进行采集。
- source:   数据来源。
- service:  新增标记tag ，如果为空，则默认使用 $source 。
- pipeline:  使用pipeline 时，定义脚本路径。
- character_encoding:  选择编码。
- multiline_match:  多行匹配。
- remove_ansi_escape_codes:  是否删除 ANSI 转义码，例如标准输出的文本颜色等，值为 true 或 false。

### 开发

#### 1 添加依赖

在项目的 pom.xml 添加依赖如下内容：

```xml
<dependency>
    <groupId>net.logstash.logback</groupId>
    <artifactId>logstash-logback-encoder</artifactId>
    <version>4.9</version>
</dependency>
```

#### 2 日志配置添加 Appender

本步骤中我们把 DataKit 的地址、Socket 端口、Service 、Source 定义成外部可传入的参数。在项目的logback-spring.xml 文件中添加 Appender ，定义 datakitHostIP 、datakitSocketPort 、datakitSource 、datakitService ，值分别通过 guangce.datakit.host_ip 、guangce.datakit.socket_port 、guangce.datakit.source 、guangce.datakit.service 从外部传入。

```xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration scan="true" scanPeriod="60 seconds" debug="false">
    <springProperty scope="context" name="datakitHostIP" source="guangce.datakit.host_ip" />
    <springProperty scope="context" name="datakitSocketPort" source="guangce.datakit.socket_port" />
    <springProperty scope="context" name="datakitSource" source="guangce.datakit.source" />
    <springProperty scope="context" name="datakitService" source="guangce.datakit.service" />

    <contextName>logback</contextName>

    <!-- 日志根目录 -->
    <property name="log.path" value="./logs/order"/>
    <!-- 日志输出格式 -->
    <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] -  - %msg%n" />

    <!-- 打印日志到控制台 -->
    <appender name="Console" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
        </encoder>
    </appender>
    
    ...
    
    <appender name="socket" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
        <destination>${datakitHostIP:-}:${datakitSocketPort:-}</destination>
        <encoder class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder">
            <providers>
                <timestamp>
                    <timeZone>UTC+8</timeZone>
                </timestamp>
                <pattern>
                    <pattern>
                        {
                        "severity": "%level",
                        "source": "${datakitSource}",
                        "service": "${datakitService}",
                        "method": "%method",
                        "line": "%line",
                        "thread": "%thread",
                        "class": "%logger{40}",
                        "msg": "%message\n%exception"
                        }
                    </pattern>
                </pattern>
            </providers>
        </encoder>
    </appender>

    <root level="INFO">
        <appender-ref ref="Console"/>
        ...
        <appender-ref ref="socket" />
    </root>
</configuration>
```

#### 3 配置默认值

application.yml 文件中增加如下配置，这些默认参数将会传入到 Logback 中。

```yaml
guangce:
  datakit:
    host_ip: 127.0.0.1  # datakit地址
    socket_port: 9542   # datakit socket端口
    #source: mySource   # 如果不放开，将会使用socket采集器定义的source
    #service: myService # 如果不放开，将会使用socket采集器定义的service
```

#### 4 运行应用

##### 1 Linux环境

执行如下命令，启动应用，如果不传入参数，将会使用 application.yml 中默认值。

```shell
java -jar  pay-service-1.0-SNAPSHOT.jar --guangce.datakit.host_ip=172.26.0.231 --guangce.datakit.socket_port=9542 --guangce.datakit.source=pay-socket-source --guangce.datakit.service=pay-socket-service
```

##### 2 Kubernets环境

Dockerfile 中增加 PARAMS ，用来接收外部传入的参数。

```
FROM openjdk:8u292
RUN echo 'Asia/Shanghai' >/etc/timezone


ENV jar pay-service-1.0-SNAPSHOT.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar} ${PARAMS} 2>&1 > /dev/null"]
```

```shell
docker build -t 172.16.0.238/df-demo/istio-pay:v1 -f DockerfilePay .
docker push 172.16.0.238/df-demo/istio-pay:v1
```

编写部署 pay-deployment.yaml 文件，增加 PARAMS 环境变量，在这里传入 guangce.datakit.host_ip 、guangce.datakit.socket_port 、guangce.datakit.source 、guangce.datakit.service 值，如果不传将会使用默认值。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: istio-pay-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: istio-pay-pod
  template:
    metadata:
      labels:
        app: istio-pay-pod
    spec:
      containers:
      - env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: PARAMS
          value: "--guangce.datakit.host_ip=$(DD_AGENT_HOST) --guangce.datakit.socket_port=9542 --guangce.datakit.source=pay-socket-source --guangce.datakit.service=pay-socket-service"
     
        name: pay-container
        image: 172.16.0.238/df-demo/istio-pay:v1
        ports:
        - containerPort: 8091
          protocol: TCP
        resources:
          limits: 
            memory: 512Mi
          requests:
            memory: 256Mi

      restartPolicy: Always
      volumes:
      - emptyDir: {}
        name: datadir
```

```shell
kubectl apply -f pay-deployment.yaml
```

#### 5 配置 Pipeline

由于 Socker Appender 输出的日志是 json 格式，DataKit 需要使用 Pipeline 把 json 字符串切割出来，其中source 和 service 是默认的 Tag ，所以需要用到 set_tag 。<br />         登录[{{{ custom_key.brand_name }}}](https://console.guance.com/)，【日志】->【Pipelines】，点击【新建Pipeline】，选择运维开启 Socket 采集器时定义的source 名称 socketdefault 。定义解析规则如下：

```toml
        json(_,msg,"message")
        json(_,class,"class")
        json(_,thread,"thread")
        json(_,severity,"status")
        json(_,method,"method")
        json(_,line,"line")
        json(_,source,"source")
        json(_,service,"service")
        json(_,`@timestamp`,"time")
        set_tag(service)
        set_tag(source)
        default_time(time) 
```

使用日志样本测试通过后，点击【保存】。注意这里的解析规则与 logback-spring.xml 文件中添加 pattern 是对应的。

```toml
                    <pattern>
                        {
                        "severity": "%level",
                        "source": "${datakitSource}",
                        "service": "${datakitService}",
                        "method": "%method",
                        "line": "%line",
                        "thread": "%thread",
                        "class": "%logger{40}",
                        "msg": "%message\n%exception"
                        }
```

### 查看日志文件

访问应用的接口，生成应用日志。登录[{{{ custom_key.brand_name }}}](https://console.guance.com/)，【日志】->【数据采集】-> 选择 pay-socket-source 查看日志详情，这里可以看到 source 和 service 被外部传入的参数替代。

![image](../images/logback-socket/1.png)

![image](../images/logback-socket/2.png)


