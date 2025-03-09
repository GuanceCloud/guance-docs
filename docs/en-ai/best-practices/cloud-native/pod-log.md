# Best Practices for Pod Log Collection

---

## Preface

When deploying microservices using containerization, the microservices run inside containers. A Pod is composed of one or a group of tightly coupled containers and is the smallest scheduling unit in Kubernetes.

This article lists three methods for collecting logs from Pods using DataKit.

## Solution One

DataKit enables the Logfwd collector, which collects business container logs in Sidecar mode.

### 1 Enable the Logfwd Collector

If Kubernetes is not integrated with DataKit, please log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), go to "Integration" - "Datakit" - "Kubernetes", and use the `datakit.yaml` file to integrate DataKit.

![image](../images/pod-log/1.png)

Modify the `datakit.yaml` file to mount the `logfwdserver.conf` file to DataKit's `/usr/local/datakit/conf.d/log/` directory.

Add the following configuration to `datakit.yaml`:

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
      ## Logfwd receiver listening address and port
      address = "0.0.0.0:9531"

      [inputs.logfwdserver.tags]
      # some_tag = "some_value"
      # more_tag = "some_other_value"
```

Add the following to the DaemonSet resource:

```yaml
- mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
  name: datakit-conf
  subPath: logfwdserver.conf
```

### 2 Mount Pipeline

Modify the `datakit.yaml` file to mount the `pod-logging-demo.p` file to DataKit's `/usr/local/datakit/pipeline/` directory.

Add the following to the ConfigMap resource:

```toml
    pod-logging-demo.p: |-
        # Log format
        #2021-12-01 10:41:06.015 [http-nio-8090-exec-2] INFO  c.s.d.c.HealthController - [getPing,19] -  - Call ping interface
        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] -  - %{GREEDYDATA:msg}")


        default_time(time,"Asia/Shanghai")
```

Add the following to the DaemonSet resource:

```yaml
- mountPath: /usr/local/datakit/pipeline/pod-logging-demo.p
  name: datakit-conf
  subPath: pod-logging-demo.p
```

> **Note:** If you do not need to use Pipeline for log parsing, this step can be skipped.

### 3 Restart DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

### 4 Collect Logs with Logfwd Sidecar

Deploy the Logfwd image and the business image in the same Pod. Below, we use `log-demo-service:v1` as the business image, generating a `/data/app/logs/log.log` log file. Use Logfwd to read the log file via shared storage and send it to DataKit. Use `pod-logging-demo.p` to parse the log and match multiple lines using dates.

??? quote "Sample Configuration Files"

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
              image: pubrepo.jiagouyun.com/datakit/logfwd:1.2.12
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

Parameters explanation for `logfwd-conf`:

- logfiles: List of log files.
- ignore: File path filter using glob rules; files matching any condition will not be collected.
- source: Data source.
- service: Additional tag, defaults to `$source` if empty.
- pipeline: Script path when using Pipeline.
- character_encoding: Character encoding selection.
- multiline_match: Multi-line matching.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes (e.g., text color in standard output); values are true or false.
- tags: Define tags in key-value pairs; optional.

Environment variable explanations:

- LOGFWD_DATAKIT_HOST: DataKit address.
- LOGFWD_DATAKIT_PORT: Logfwd port.

```shell
kubectl apply -f log-fwd-deployment.yaml
```

### 5 View Logs

Log in to <<< custom_key.brand_name >>> - "Logs", search for `log_fwd_demo`.

![image](../images/pod-log/2.png)

![image](../images/pod-log/3.png)

## Solution Two

DataKit collects logs output to Stdout by default. To handle log formats specially, Annotations are often added to the Deployment controller's YAML file when deploying Pods.

Below is an example of log collection for a Springboot microservice project, with the jar package being `log-springboot-demo-1.0-SNAPSHOT.jar`, and logs using Logback. The specific steps are as follows:

### 1 Write `logback-spring.xml`

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

Dockerfile as follows:

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

Build the image and push it to the Harbor repository:

```bash
 docker build -t <your-harbor>/log-demo-service:v1 .
 docker push <your-harbor>/log-demo-service:v1
```

### 3 Write `pod-log-service.yaml` File

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

Annotations parameters explanation:

- source: Data source
- service: Tag marker
- pipeline: Pipeline script path
- ignore_status:
- multiline_match: Regular expression to match a line of log; e.g., starting with a date (like 2021-11-26) indicates a new log line, while subsequent lines not starting with that date are considered part of the previous log entry.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes (e.g., text color in standard output).

### 4 Configure Pipeline

Add the `pod-logging-demo.p` section to the ConfigMap resource in the `datakit-default.yaml` file.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  pod-logging-demo.p: |-
    # Log format
    #2021-12-01 10:41:06.015 [http-nio-8090-exec-2] INFO  c.s.d.c.HealthController - [getPing,19] -  - Call ping interface
    grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] -  - %{GREEDYDATA:msg}")

    default_time(time)
```

Mount `Pod-logging-demo.p` to DataKit:

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

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/) "Logs" module, input `log-demo-service`, and successfully view the logs.

![image](../images/pod-log/4.png)

![image](../images/pod-log/5.png)

## Solution Three

Mount Volume to Pod using hostPath type, mounting log files to the host machine. Deploy DataKit using DaemonSet, also mounting hostPath type Volume, allowing DataKit to collect logs from within the Pod.