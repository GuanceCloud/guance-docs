# Logback Socket Log Collection Best Practices

---

## Introduction

For a company, the Guance workspace collects logs from multiple applications. Distinguishing which Service these logs originate from is a common challenge. In this guide, we will explore how to use Pipelines to add Service tags to logs, thereby distinguishing their sources.

DataKit supports various methods for log collection. This article focuses on collecting logs via Socket in Java Springboot applications, using Logback's Socket to send logs to DataKit. First, operations personnel enable the Socket collector in DataKit and restart it. Next, developers add an Appender to the `logback-spring.xml` file and declare `springProperty` to include the Service name in the logs when starting the JAR. Developers then start the JAR, passing the required Service name into the application. Finally, developers log into Guance and create a new Pipeline under the Logs module's Pipeline tab, specifying the Source of the Socket collector enabled by operations. This way, logs are tagged accordingly.

The following solution will be implemented from both development and operations perspectives.

## Solution

### Operations

#### Linux Environment

##### 1. Enable Collector

Log in to the Linux server where DataKit is deployed and create a `logging-socket.conf` file.

```shell
cd /usr/local/datakit/conf.d/log
vi logging-socket.conf
```

The content of the `logging-socket.conf` file is as follows:

```toml
[[inputs.logging]]
  # Only two protocols are supported: TCP and UDP
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

##### 2. Restart DataKit

```shell
systemctl restart datakit
```

#### Kubernetes Environment

Log in to [Guance](https://console.guance.com/), navigate to **Integration** -> **DataKit** -> **Kubernetes**, and follow the instructions to install DataKit. Modify the `datakit.yaml` used for deployment. The steps involve creating a `logging-socket.conf` file and mounting it to DataKit.

##### 1. Add Configuration to ConfigMap

```yaml
    logging-socket.conf: |-
      [[inputs.logging]]
        # Only two protocols are supported: TCP and UDP
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

##### 2. Mount `logging-socket.conf`

```yaml
        - mountPath: /usr/local/datakit/conf.d/log/logging-socket.conf
          name: datakit-conf
          subPath: logging-socket.conf
```

##### 3. Restart DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

#### Parameter Explanation

- `sockets`: Protocol ports.
- `ignore`: File path filtering using glob rules; files matching any filter condition will not be collected.
- `source`: Data source.
- `service`: Additional tag; if empty, defaults to `$source`.
- `pipeline`: Script path when using Pipeline.
- `character_encoding`: Character encoding selection.
- `multiline_match`: Multiline matching.
- `remove_ansi_escape_codes`: Whether to remove ANSI escape codes (e.g., text colors in standard output); values can be `true` or `false`.

### Development

#### 1. Add Dependencies

Add the following dependency to the project's `pom.xml`:

```xml
<dependency>
    <groupId>net.logstash.logback</groupId>
    <artifactId>logstash-logback-encoder</artifactId>
    <version>4.9</version>
</dependency>
```

#### 2. Add Appender to Log Configuration

In this step, we define DataKit's address, Socket port, Service, and Source as externally configurable parameters. Add an Appender to the `logback-spring.xml` file, defining `datakitHostIP`, `datakitSocketPort`, `datakitSource`, and `datakitService`, whose values are passed from external sources via `guangce.datakit.host_ip`, `guangce.datakit.socket_port`, `guangce.datakit.source`, and `guangce.datakit.service`.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration scan="true" scanPeriod="60 seconds" debug="false">
    <springProperty scope="context" name="datakitHostIP" source="guangce.datakit.host_ip" />
    <springProperty scope="context" name="datakitSocketPort" source="guangce.datakit.socket_port" />
    <springProperty scope="context" name="datakitSource" source="guangce.datakit.source" />
    <springProperty scope="context" name="datakitService" source="guangce.datakit.service" />

    <contextName>logback</contextName>

    <!-- Log root directory -->
    <property name="log.path" value="./logs/order"/>
    <!-- Log output format -->
    <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] -  - %msg%n" />

    <!-- Print logs to console -->
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

#### 3. Configure Defaults

Add the following configuration to the `application.yml` file. These default parameters will be passed to Logback.

```yaml
guangce:
  datakit:
    host_ip: 127.0.0.1  # DataKit address
    socket_port: 9542   # DataKit socket port
    #source: mySource   # If uncommented, this will override the source defined by the socket collector
    #service: myService # If uncommented, this will override the service defined by the socket collector
```

#### 4. Run Application

##### 1. Linux Environment

Execute the following command to start the application. If no parameters are provided, the defaults in `application.yml` will be used.

```shell
java -jar pay-service-1.0-SNAPSHOT.jar --guangce.datakit.host_ip=172.26.0.231 --guangce.datakit.socket_port=9542 --guangce.datakit.source=pay-socket-source --guangce.datakit.service=pay-socket-service
```

##### 2. Kubernetes Environment

Add `PARAMS` to the Dockerfile to receive external parameters.

```dockerfile
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

Write the `pay-deployment.yaml` deployment file, adding the `PARAMS` environment variable to pass `guangce.datakit.host_ip`, `guangce.datakit.socket_port`, `guangce.datakit.source`, and `guangce.datakit.service`. If not provided, the defaults will be used.

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

#### 5. Configure Pipeline

Since the Socker Appender outputs logs in JSON format, DataKit needs to use Pipeline to parse the JSON string. The `source` and `service` are default Tags, so `set_tag` is needed.

Log in to [Guance](https://console.guance.com/), go to **Logs** -> **Pipelines**, click **Create New Pipeline**, and select the `source` name defined when enabling the Socket collector (`socketdefault`). Define the parsing rules as follows:

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

After testing with a log sample and ensuring it passes, click **Save**. Note that the parsing rules should correspond to the pattern added in the `logback-spring.xml` file.

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

### View Log Files

Access the application's API to generate application logs. Log in to [Guance](https://console.guance.com/), go to **Logs** -> **Data Collection** -> select `pay-socket-source` to view detailed logs. Here you can see that `source` and `service` have been replaced by the external parameters.

![image](../images/logback-socket/1.png)

![image](../images/logback-socket/2.png)