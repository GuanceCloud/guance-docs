# Logback Socket Log Collection Best Practices

---

## Introduction

For a company, the <<< custom_key.brand_name >>> workspace will collect logs from multiple applications, and distinguishing which Service these logs come from is a pain point we encounter. Next, we will explore together how to use Pipelines to add Service tags to logs, in order to distinguish log sources. <br /> DataKit has many ways to collect logs. This article focuses on collecting logs through Socket in Java Springboot applications, transmitting logs to DataKit via Logback's Socket. First, operations staff enable the Socket collector in DataKit and restart DataKit. Then developers add an Appender in the application's logback-spring.xml file and declare springProperty, which is used to write the Service name into the logs when starting the jar. Then developers start the jar, passing the Service name that needs to be written into the logs into the application. Finally, developers log into <<< custom_key.brand_name >>>, create a new Pipeline under the Pipeline tag in the log module, specifying the Source of the Socket collector enabled by the operations staff. This way, logs will be distinguished by Tags. <br /> The solution provided below will implement this feature from both the developer's and operations staff's perspectives.

## Solution

### Operations Staff

#### Linux Environment

##### 1 Enable Collector

Log into the Linux server where DataKit is deployed and create a new logging-socket.conf file.

```
cd /usr/local/datakit/conf.d/log
vi logging-socket.conf
```

The content of the logging-socket.conf file is as follows:

```toml
      [[inputs.logging]]
        # only two protocols are supported: TCP and UDP
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

##### 2 Restart DataKit 

```shell
systemctl restart datakit
```

#### Kubernetes Environment

Log into [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), 【Integration】->【Datakit】->【Kubernetes】, follow the instructions to install DataKit. You will need to modify the datakit.yaml used for deployment. The steps involve creating a logging-socket.conf file and mounting it into DataKit.

##### 1 Add ConfigMap Configuration

```yaml
    logging-socket.conf: |-
      [[inputs.logging]]
        # only two protocols are supported: TCP and UDP
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

##### 2 Mount logging-socket.conf

```yaml
        - mountPath: /usr/local/datakit/conf.d/log/logging-socket.conf
          name: datakit-conf
          subPath: logging-socket.conf
```

##### 3 Restart DataKit 

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

#### Parameter Explanation

- sockets: Protocol ports.
- ignore: File path filtering, using glob rules. Files matching any filter condition will not be collected.
- source: Data source.
- service: Additional tagging, if empty, defaults to $source.
- pipeline: Script path definition when using pipelines.
- character_encoding: Encoding selection.
- multiline_match: Multiline matching.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes (e.g., text colors in standard output). Value can be true or false.

### Developers

#### 1 Add Dependencies

Add the following dependencies to the project's pom.xml:

```xml
<dependency>
    <groupId>net.logstash.logback</groupId>
    <artifactId>logstash-logback-encoder</artifactId>
    <version>4.9</version>
</dependency>
```

#### 2 Add Appender to Log Configuration

In this step, we define the DataKit address, Socket port, Service, and Source as external parameters. In the project’s logback-spring.xml file, add an Appender and define datakitHostIP, datakitSocketPort, datakitSource, and datakitService, whose values are passed in externally through guangce.datakit.host_ip, guangce.datakit.socket_port, guangce.datakit.source, and guangce.datakit.service.

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

#### 3 Configure Default Values

Add the following configuration in the application.yml file; these default parameters will be passed into Logback.

```yaml
guangce:
  datakit:
    host_ip: 127.0.0.1  # datakit address
    socket_port: 9542   # datakit socket port
    #source: mySource   # If not opened, it will use the source defined by the socket collector
    #service: myService # If not opened, it will use the service defined by the socket collector
```

#### 4 Run Application

##### 1 Linux Environment

Execute the following command to start the application; if no parameters are passed, it will use the default values in application.yml.

```shell
java -jar pay-service-1.0-SNAPSHOT.jar --guangce.datakit.host_ip=172.26.0.231 --guangce.datakit.socket_port=9542 --guangce.datakit.source=pay-socket-source --guangce.datakit.service=pay-socket-service
```

##### 2 Kubernetes Environment

Add PARAMS in Dockerfile to receive external parameters.

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

Write the pay-deployment.yaml deployment file, add the PARAMS environment variable here, and pass in the values of guangce.datakit.host_ip, guangce.datakit.socket_port, guangce.datakit.source, and guangce.datakit.service. If they are not passed, the default values will be used.

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

#### 5 Configure Pipeline

Since the logs output by the Socker Appender are in JSON format, DataKit needs to use a Pipeline to extract the JSON string. Since source and service are default Tags, set_tag needs to be used.

Log into [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), 【Logs】->【Pipelines】, click 【Create Pipeline】, select the source name socketdefault defined when the operations staff enabled the Socket collector. Define the parsing rules as follows:

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

After testing with a log sample and confirming it passes, click 【Save】. Note that the parsing rules here correspond to the pattern added in the logback-spring.xml file.

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

Access the application interface to generate application logs. Log into [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/) and navigate to 【Logs】->【Data Collection】-> Select pay-socket-source to view log details. Here you can see that the source and service have been replaced by the external parameters passed in.

![image](../images/logback-socket/1.png)

![image](../images/logback-socket/2.png)