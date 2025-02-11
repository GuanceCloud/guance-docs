# Several Ways to Collect Logs in Kubernetes Clusters

---

## Introduction

For enterprise application systems, logs are of critical importance, especially in a Kubernetes environment where log collection becomes more complex. Therefore, DataKit provides robust support for log collection, accommodating multiple environments and technology stacks. The following sections will provide a detailed explanation of how to use DataKit for log collection.

## Prerequisites

Log in to [Guance](https://console.guance.com/), navigate to 【Integration】->【Datakit】->【Kubernetes】, and follow the instructions to install DataKit in your Kubernetes cluster. The `datakit.yaml` file used for deployment will be referenced in subsequent operations.

## Advanced DataKit Configuration

### 1 Setting Log Levels

By default, DataKit's log level is set to Info. If you need to change it to Debug, add an environment variable in the `datakit.yaml` file.
	
```yaml
        - name: ENV_LOG_LEVEL
          value: debug
```

### 2 Configuring Log Output

By default, DataKit outputs logs to `/var/log/datakit/gin.log` and `/var/log/datakit/log`. If you do not want to generate log files inside the container, add the following environment variables in the `datakit.yaml` file.

```yaml
    - name: ENV_LOG
      value: stdout
    - name: ENV_GIN_LOG
      value: stdout     
```
You can view DataKit-generated logs using the `kubectl` command with the POD name.

```shell
kubectl logs datakit-2fnrz -n datakit # 
```

**Note**: After setting `ENV_LOG_LEVEL` to `debug`, a large volume of logs will be generated. It is not recommended to set `ENV_LOG` to `stdout` in this case.

## Log Collection

### 1 Collecting stdout Logs 

#### 1.1 Full Collection of stdout Logs

DataKit can collect logs output to stdout from containers. By default, the container collector is enabled when deploying DataKit using `datakit.yaml`.

```yaml
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container
```

This creates the configuration file `/usr/local/datakit/conf.d/container/container.conf` within the DataKit container. By default, it collects all stdout logs except those from images starting with `pubrepo.jiagouyun.com/datakit/logfwd`.

```toml
  container_include_log = []  # equivalent to image:*
  container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*"]
```

#### 1.2 Customized stdout Log Collection

To better distinguish log sources, add tags and specify log slicing pipeline files. This requires customizing the deployment YAML file by adding annotations.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: log-demo-service
  labels:
    app: log-demo-service
spec:
  replicas: 1
  selector:
    matchLabels:
      app: log-demo-service
  template:
    metadata:
      labels:
        app: log-demo-service
      annotations:
        # Add the following section
        datakit/logs: |
          [
            {
              "source": "pod-logging-testing-demo",
              "service": "pod-logging-testing-demo",
              "pipeline": "pod-logging-demo.p",
              "multiline_match": "^\\d{4}-\\d{2}-\\d{2}"
            }
          ]
```

Annotations Parameter Explanation:

- source: Data source
- service: Tag identifier
- pipeline: Pipeline script name
- ignore_status: 
- multiline_match: Regular expression to match a line of log, e.g., lines starting with a date (like 2021-11-26) are considered one log entry, while subsequent lines without this date are part of the previous log.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes, such as text colors in standard output.

#### 1.3 Not Collecting Container stdout Logs

If the container collector is enabled, it will automatically collect logs output to stdout. To prevent collecting certain logs, you can use the following methods.

##### 1.3.1 Disable stdout Log Collection for a POD

Add annotations to the deployment YAML file and set `disable` to `true`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:

...

spec:
  ...
  template:
    metadata:      
      annotations:
        ## Add the following content
        datakit/logs: |
          [
            {
              "disable": true  
            }
          ]
```

##### 1.3.2 Redirect Standard Output

If stdout log collection is enabled and the container also outputs logs to stdout, but you do not want to modify either, you can change the startup command to redirect standard output.

```shell
java ${JAVA_OPTS}   -jar ${jar} ${PARAMS}  2>&1 > /dev/null
```

##### 1.3.3 Using Container Collector Filtering

For better control over stdout log collection, consider rewriting the `container.conf` file using a ConfigMap to define `container.conf`, modifying `container_include_log` and `container_exclude_log` values, and mounting it to DataKit. Modify `datakit.yaml` as follows:

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### container
    container.conf: |-  
      [inputs.container]
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = true

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = []
        container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false

        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
```

```yaml
        volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
```

- `container_include` and `container_exclude` must start with `image`, formatted as `"image:<glob pattern>"`, indicating that the glob pattern applies to container images.
- [Glob Pattern](https://en.wikipedia.org/wiki/Glob_(programming)) is a lightweight regular expression supporting `*` and `?` for basic matching.

For example, if you only want to collect logs from images containing `log-order` but not `log-pay`, configure as follows.

```bash
        container_include_log = ["image:*log-order*"]
        container_exclude_log = ["image:*log-pay*"]
```

**Note**: If a POD has stdout log collection enabled, avoid using `logfwd` or socket log collection to prevent duplicate log collection.

### 2 logfwd Collection

This method uses the Sidecar pattern for log collection, leveraging shared storage within the same POD to allow logfwd to read business container logs and send them to DataKit. For specific usage, refer to the [Best Practices for Pod Log Collection](../pod-log) Solution 2.

### 3 Socket Collection

DataKit opens a Socket port, such as 9542, to which logs are pushed. Java's log4j and logback support log pushing. Below is an example of implementing socket log collection with SpringBoot integrated with Logback.

#### 3.1 Adding Appender

Add a socket Appender in the `logback-spring.xml` file.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<configuration scan="true" scanPeriod="60 seconds" debug="false">
    <springProperty scope="context" name="dkSocketHost" source="datakit.socket.host" />
    <springProperty scope="context" name="dkSocketPort" source="datakit.socket.port" />
    <contextName>logback</contextName>

    <!-- Root log directory -->
    <property name="log.path" value="./logs"/>
    <!-- Log output format -->
    <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] -  - %msg%n" />

    <!-- Print logs to console -->
    <appender name="Console" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>${log.pattern}</pattern>
        </encoder>
    </appender>
    ... 
    <!-- Add the following Socket appender --> 
    <appender name="socket" class="net.logstash.logback.appender.LogstashTcpSocketAppender">
        <!-- datakit host: logsocket_port -->
        <destination>${dkSocketHost}:${dkSocketPort}</destination>
        <!-- Log output encoding -->
        <encoder class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder">
            <providers>
                <timestamp>
                    <timeZone>UTC+8</timeZone>
                </timestamp>
                <pattern>
                    <pattern>
                        {
                        "severity": "%level",
                        "appName": "${logName:-}",
                        "trace": "%X{dd.trace_id:-}",
                        "span": "%X{dd.span_id:-}",
                        "pid": "${PID:-}",
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
        <appender-ref ref="file_info"/>
        <appender-ref ref="socket" />
    </root>
</configuration>
```

#### 3.2 Adding Configuration

Add the configuration in the `application.yml` file of the SpringBoot project.

```toml
datakit:
  socket:
    host: 120.26.218.200  # 
    port: 9542
```

#### 3.3 Adding Dependencies

Add dependencies in the `pom.xml` file of the SpringBoot project.

```xml
<dependency>
    <groupId>net.logstash.logback</groupId>
    <artifactId>logstash-logback-encoder</artifactId>
    <version>4.9</version>
</dependency>
```

#### 3.4 Adding logging-socket.conf File to DataKit

In the `datakit.yaml` file of DataKit:

```yaml
        volumeMounts:  # Add the following three lines here
        - mountPath: /usr/local/datakit/conf.d/log/logging-socket.conf
          name: datakit-conf
          subPath: logging-socket.conf
          
---           
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:       
    logging-socket.conf: |-
      [[inputs.logging]]
        # Only two protocols are supported: TCP and UDP
        sockets = [
          "tcp://0.0.0.0:9542",
        #"udp://0.0.0.0:9531",                  
        ]
        ignore = [""]
        source = "demo-socket-service"
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

For more information on Socket log collection, refer to the [Best Practices for logback Socket Log Collection](../logback-socket).

### 4 File Log Collection

On Linux hosts, DataKit collects logs by copying the `logging.conf` file and modifying the `logfiles` value in the `logging.conf` file to the absolute path of the log.

```shell
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample  logging.conf
```

In a Kubernetes environment, first mount the log directory `/data/app/logs/demo-system` of the Pod to the host's `/var/log/k8s/demo-system`, then deploy DataKit using DaemonSet and mount the `/var/log/k8s/demo-system` directory. This allows DataKit to collect the log file `/rootfs/var/log/k8s/demo-system/info.log` from the host.

```yaml
        volumeMounts:
        - name: app-log
          mountPath: /data/app/logs/demo-system
          
      ...
    
      volumes:   
      - name: app-log
        hostPath:
          path: /var/log/k8s/demo-system
```

```yaml
        volumeMounts:  # Add the following three lines here
        - mountPath: /usr/local/datakit/conf.d/log/logging.conf
          name: datakit-conf
          subPath: logging.conf
          
---           
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:           
    #### logging
    logging.conf: |-
        [[inputs.logging]]
          ## required
          logfiles = [
            "/rootfs/var/log/k8s/demo-system/info.log",
          ]

          ## glob filter
          ignore = [""]

          ## your logging source, if it's empty, use 'default'
          source = "k8s-demo-system-log"

          ## add service tag, if it's empty, use $source.
          #service = "k8s-demo-system-log"

          ## grok pipeline script path
          pipeline = ""
          ## optional status:
          ##   "emerg","alert","critical","error","warning","info","debug","OK"
          ignore_status = []

          ## optional encodings:
          ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
          character_encoding = ""

          ## The pattern should be a regexp. Note the use of '''this regexp'''
          ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
          multiline_match = '''^\d{4}-\d{2}-\d{2}'''

          [inputs.logging.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value" 
```

**Note**: Since Guance already collects and persists logs, there is no need to persist logs to the host disk in a Kubernetes environment. Therefore, this collection method is not recommended.

## Pipeline

[Pipeline](pipeline) is primarily used to parse unstructured text data or extract information from structured text (such as JSON). For logs, it mainly extracts log generation time, log level, etc. Note that logs collected via Socket are in JSON format and need to be parsed before searching by keyword. For more details on Pipeline usage, see the articles below.

- [Best Practices for Pod Log Collection](../pod-log)
- [Best Practices for logback Socket Log Collection](../logback-socket)
- [RUM-APM-LOG Joint Analysis for Kubernetes Applications](../k8s-rum-apm-log)

## Anomaly Detection

When logs contain anomalies that significantly impact applications, using Guance's log anomaly detection feature and configuring alerts can promptly notify the monitoring objects. Guance supports email, DingTalk, SMS, Enterprise WeChat, Feishu, and other notification methods. Below is an example using email for alerts.

### 1 Creating Notification Targets

Log in to [Guance](https://console.guance.com/), navigate to 【Management】->【Notification Targets Management】->【Create New Notification Target】, select Email Group, and input the name and email address.<br />

![image](../images/k8s-logs/1.png)	

### 2 Creating a Monitor

Click 【Monitoring】->【Create New Monitor】->【Log Monitoring】.<br />

![image](../images/k8s-logs/2.png)	

Input the rule name; `log_fwd_demo` is the source configured during log collection, and `error` is the content included in the log. `host_ip` is a log label that can be used in event content to output the specific label value. Set the trigger condition to 1, and the title and content will be sent via email. Click 【Save】 after filling out the form.<br />

![image](../images/k8s-logs/3.png)	

![image](../images/k8s-logs/4.png)	

### 3 Configuring Alerts

In the 【Monitors】interface, click on the newly created monitor and then click 【Alert Configuration】.<br />

![image](../images/k8s-logs/5.png)	

Select the email group created in step 1 as the alert notification target, choose the alert silence duration, and click 【Confirm】.<br />

![image](../images/k8s-logs/6.png)	

### 4 Triggering Alerts

When the application generates error logs, you will receive a notification email.

![image](../images/k8s-logs/7.png)