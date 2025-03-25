# Best Practices for Pod Log Collection

---

## Introduction

When using containerized deployment for microservices, the microservices run inside containers. A Pod consists of one or more tightly coupled containers and is the smallest scheduling unit in Kubernetes.

Regarding logs within Pods, this article lists three methods for collecting logs using DataKit.

## Method One

Enable the Logfwd collector in DataKit. Logfwd collects business container logs in Sidecar mode.

### 1 Enable the Logfwd Collector

If Kubernetes is not integrated with DataKit, please log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), "Integration" - "Datakit" - "Kubernetes", and integrate DataKit using the `datakit.yaml` file.

![image](../images/pod-log/1.png)

Below, modify the `datakit.yaml` file to mount the `logfwdserver.conf` file into DataKit's `/usr/local/datakit/conf.d/log/` directory.

Add the following configuration in the `datakit.yaml` file:

```yaml
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### logfwdserver
  logfwdserver.conf: |-
    [inputs.logfwdserver]
      ## logfwd receiver listens on address and port
      address = "0.0.0.0:9531"

      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
```

Add the following in the Daemonset resource:

```yaml
- mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
  name: datakit-conf
  subPath: logfwdserver.conf
```

### 2 Mount Pipeline

Modify the `datakit.yaml` file to mount the `pod-logging-demo.p` file into DataKit's `/usr/local/datakit/pipeline/` directory.

Add the following in the ConfigMap resource:

```toml
    pod-logging-demo.p: |-
        #Log format
        #2021-12-01 10:41:06.015 [http-nio-8090-exec-2] INFO  c.s.d.c.HealthController - [getPing,19] -  - Call ping interface
        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] -  - %{GREEDYDATA:msg}")


        default_time(time,"Asia/Shanghai")
```

Add the following in the Daemonset resource:

```yaml
- mountPath: /usr/local/datakit/pipeline/pod-logging-demo.p
  name: datakit-conf
  subPath: pod-logging-demo.p
```

> **Note:** If you do not need to use Pipeline for log splitting, this step can be ignored.

### 3 Restart Datakit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

### 4 Collect Logs via Logfwd Side

Deploy the Logfwd image and business image in the same Pod. Below, we use `log-demo-service:v1` as the business image, generating a `/data/app/logs/log.log` log file. Use logfwd to read the log file via shared storage and pass it to Datakit. Use `pod-logging-demo.p` to parse the logs and use dates for multi-line matching.

??? quote "Example of Related Configuration Files"

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: log-fwd-deployment
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: log-fwd-pod
      template:
        metadata:
          labels:
            app: log-fwd-pod
          annotations:
        spec:
          nodeName: k8s-node2
          containers:
            - name: log-fwd-container
              image: 172.16.0.238/df-demo/log-demo-service:v2
              ports:
                - containerPort: 8090
                  protocol: TCP
              volumeMounts:
                - mountPath: /data/app/logs
                  name: varlog
            - name: logfwd
              image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd:1.2.12
              env:
                - name: LOGFWD_DATAKIT_HOST
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: status.hostIP
                - name: LOGFWD_DATAKIT_PORT
                  value: "9531"
                - name: LOGFWD_ANNOTATION_DATAKIT_LOGS
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: metadata.annotations['datakit/logs']
                - name: LOGFWD_POD_NAME
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: metadata.name
                - name: LOGFWD_POD_NAMESPACE
                  valueFrom:
                    fieldRef:
                      apiVersion: v1
                      fieldPath: metadata.namespace
              volumeMounts:
                - mountPath: /var/log
                  name: varlog
                - mountPath: /opt/logfwd/config
                  name: logfwd-config
                  subPath: config
          restartPolicy: Always
          volumes:
            - name: varlog
              emptyDir: {}
            - configMap:
                name: logfwd-conf
              name: logfwd-config
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: logfwd-conf
    data:
      config: |
        [
            {            
                "loggings": [
                    {
                        "logfiles": ["/var/log/log.log"],
                        "source": "log_fwd_demo",                    
                        "pipeline": "pod-logging-demo.p",
                        "multiline_match": "^\\d{4}-\\d{2}-\\d{2}",
                        "tags": {
                            "flag": "tag1"
                        }
                    }
                ]
            }
        ]
    ```

Explanation of logfwd-conf parameters:

- logfiles: List of log files.
- ignore: File path filtering, using glob rules. Any file that matches will not be collected.
- source: Data source.
- service: Add new tag markers; if empty, defaults to $source.
- pipeline: Define script path when using pipelines.
- character_encoding: Select encoding.
- multiline_match: Multi-line matching.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes, such as text colors in standard output, value is true or false.
- tags: Define labels in key-value pairs, optional.

Environment variable explanations:

- LOGFWD_DATAKIT_HOST: DataKit address.
- LOGFWD_DATAKIT_PORT: Logfwd port

```shell
kubectl apply -f log-fwd-deployment.yaml
```

### 5 View Logs

Log in to <<< custom_key.brand_name >>> - "Logs", search for data sources named log_fwd_demo.

![image](../images/pod-log/2.png)

![image](../images/pod-log/3.png)

## Method Two

DataKit collects logs by default from Pod outputs to Stdout. To specially handle log formats, Annotations are usually added to the yaml file of the Deployment controller used to deploy the Pod.

Below is an example of log collection for a Springboot microservice project. The jar package is `log-springboot-demo-1.0-SNAPSHOT.jar`, and logs are managed with Logback. Specific steps are as follows:

### 1 Write logback-spring.xml

??? quote "`logback-spring.xml`"

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>

    <configuration scan="true" scanPeriod="60 seconds" debug="false">
        <contextName>logback</contextName>

        <!-- Log root directory - - 
        <property name="log.root.dir" value="./logs"/>
        <!-- Log output format - - 
        <property name="log.pattern" value="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] -  - %msg%n" />

        <!-- Print logs to console - - 
        <appender name="Console" class="ch.qos.logback.core.ConsoleAppender">
            <encoder>
                <pattern>${log.pattern}</pattern>
            </encoder>
        </appender>

        <root level="INFO">
            <appender-ref ref="Console"/>
        </root>
    </configuration>
    ```

### 2 Build Image

Dockerfile is as follows:

```bash
FROM openjdk:8u292

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV jar log-springboot-demo-1.0-SNAPSHOT.jar

ENV workdir /data/app/
RUN mkdir -p ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar} "]
```

Build the image and upload it to the harbor repository:

```bash
 docker build -t <your-harbor>/log-demo-service:v1 .
 docker push <your-harbor>/log-demo-service:v1
```

### 3 Write pod-log-service.yaml File

??? quote "`pod-log-service.yaml`"

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: log-demo-service
      labels:
        app: log-demo-service
    spec:
      selector:
        app: log-demo-service
      ports:
        - protocol: TCP
          port: 8090
          nodePort: 30053
          targetPort: 8090
      type: NodePort
    ---
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
            datakit/logs: |
              [
                {
                  "source": "pod-logging-testing-demo",
                  "service": "pod-logging-testing-demo",
                  "pipeline": "pod-logging-demo.p",
                  "multiline_match": "^\\d{4}-\\d{2}-\\d{2}"
                }
              ]

        spec:
          containers:
            - env:
                - name: POD_NAME
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.name
              name: log-service
              image: <your-harbor>/log-demo-service:v1
              ports:
                - containerPort: 8090
                  protocol: TCP

          restartPolicy: Always
          volumes:
            - name: ddagent
              emptyDir: {}
    ```

Annotations parameter explanations:

- source: Data source
- service: Tag marker
- pipeline: Pipeline script path
- ignore_status:
- multiline_match: Regular expression to match one line of log, for example, in the example, lines starting with a date (e.g., 2021-11-26) are considered one line of log, and subsequent lines not starting with this date are considered part of the previous log line.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes, such as text colors in standard output

### 4 Configure Pipeline

Add the `pod-logging-demo.p` section in the ConfigMap resource of the `datakit-default.yaml` file.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  pod-logging-demo.p: |-
    #Log format
    #2021-12-01 10:41:06.015 [http-nio-8090-exec-2] INFO  c.s.d.c.HealthController - [getPing,19] -  - Call ping interface
    grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] -  - %{GREEDYDATA:msg}")

    default_time(time)
```

Mount `Pod-logging-demo.p` into DataKit

```yaml
- mountPath: /usr/local/datakit/pipeline/pod-logging-demo.p
  name: datakit-conf
  subPath: pod-logging-demo.p
```

### 5 View Logs

Execute the following command to deploy the Pod:

```bash
kubectl apply -f pod-log-service.yaml
```

Access the microservice:

```shell
curl localhost:30053/ping
```

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/) "Logs" module, input log-demo-service, successfully view the logs.

![image](../images/pod-log/4.png)

![image](../images/pod-log/5.png)

## Method Three

Pod mounts Volume, using the hostPath volume type, mounting the log file onto the host machine, then deploy DataKit using Daemonset, also mounting the hostPath type Volume, so DataKit can collect the log files within the Pod.