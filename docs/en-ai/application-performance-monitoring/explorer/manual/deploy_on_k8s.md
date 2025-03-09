# Deployment on Kubernetes
---

## Install DataKit Agent

Before performing link data analysis for systems and applications, you need to [deploy <<< custom_key.brand_name >>> DataKit collector](../../../datakit/datakit-install.md) on each target host to collect necessary trace data.

## Enable DDTrace Collector

DDTrace is used to receive, process, and analyze Tracing protocol data. Run the following command to enable the DDTrace collector. For configurations of other third-party tracing collectors, refer to [Integration](../../../integrations/integration-index.md).

```
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
```

After configuration, restart DataKit:

```
datakit service -R
```

## Choose Language


### Java

Install dependencies:

```
wget -O dd-java-agent.jar 'https://<<< custom_key.static_domain >>>/dd-image/dd-java-agent.jar'
```

Run application:

In Kubernetes, you can inject the trace agent via Datakit Operator or manually mount the trace agent into the application container:

```
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
        - name: <CONTAINER_NAME>
          image: <CONTAINER_IMAGE>/<TAG>
          env: 
```

Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Custom DataKit listening address; if not set, it follows the default address;
5. Set sampling rate: When enabled, it can reduce the actual amount of generated data; the numeric range is from 0.0(0%) ~ 1.0(100%);
6. Collect Profiling data: When enabled, more runtime information about the application can be seen;
7. Enable JVM metrics collection: Requires enabling the [statsd collector](../../../integrations/statsd.md) simultaneously.

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

### Python

Install dependencies:

```
pip install ddtrace
```

Run application:

You can run your Java code through various methods such as IDE, Maven, Gradle, or directly using the `java -jar` command. The following example starts the application using the `java` command:

```
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
        - name: <CONTAINER_NAME>
          image: <CONTAINER_IMAGE>/<TAG>
          env: 
```

Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Custom DataKit listening address; if not set, it follows the default address;
5. Set sampling rate for the service: When enabled, it can reduce the actual amount of generated data; the numeric range is from 0.0(0%) ~ 1.0(100%);
6. Collect Profiling data: When enabled, more runtime information about the application can be seen;
7. Enable Python metrics collection: Requires enabling the [statsd collector](../../../integrations/statsd.md) simultaneously.

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

### Golang

Install dependencies:

```
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

Run application:

You can run your Java code through various methods such as IDE, Maven, Gradle, or directly using the `java -jar` command. The following example starts the application using the `java` command:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    tags.datadoghq.com/env: <env>
    tags.datadoghq.com/service: <service>
    tags.datadoghq.com/version: <version>
spec:
  template:
    metadata:
      labels:
        tags.datadoghq.com/env: <env>
        tags.datadoghq.com/service: <service>
        tags.datadoghq.com/version: <version>
    spec:
      volumes:
        - hostPath:
            path: /var/run/datadog/
          name: apmsocketpath
      containers:
        - name: <CONTAINER_NAME>
          image: <CONTAINER_IMAGE>/<TAG>
          volumeMounts:
            - name: apmsocketpath
              mountPath: /var/run/datadog
          env:
            - name: DD_ENV
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/env']
            - name: DD_SERVICE
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/service']
            - name: DD_VERSION
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/version'] 
```

Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Custom DataKit listening address; if not set, it follows the default address;
5. Set sampling rate: When enabled, it can reduce the actual amount of generated data; the numeric range is from 0.0(0%) ~ 1.0(100%).

> For more parameter configurations, refer to [here](../../../integrations/ddtrace-java.md#start-options).

### Node.JS

Run application:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    tags.datadoghq.com/env: <env>
    tags.datadoghq.com/service: <service>
    tags.datadoghq.com/version: <version>
spec:
  template:
    metadata:
      labels:
        tags.datadoghq.com/env: <env>
        tags.datadoghq.com/service: <service>
        tags.datadoghq.com/version: <version>
    spec:
      containers:
        - name: <CONTAINER_NAME>
          image: <CONTAINER_IMAGE>/<TAG>
          env:
            - name: DD_AGENT_HOST
              valueFrom:
                fieldRef:
                  fieldPath: status.hostIP
            - name: DD_ENV
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/env']
            - name: DD_SERVICE
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/service']
            - name: DD_VERSION
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/version'] 
```


Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Custom DataKit listening address; if not set, it follows the default address;
5. Set sampling rate: When enabled, it can reduce the actual amount of generated data; the numeric range is from 0.0(0%) ~ 1.0(100%).

### C++

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Refer to</font>](../../../integrations/ddtrace-cpp.md)

</div>

</font>

### PHP

Run application:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    tags.datadoghq.com/env: <env>
    tags.datadoghq.com/service: <service>
    tags.datadoghq.com/version: <version>
spec:
  template:
    metadata:
      labels:
        tags.datadoghq.com/env: <env>
        tags.datadoghq.com/service: <service>
        tags.datadoghq.com/version: <version>
    spec:
      volumes:
        - hostPath:
            path: /var/run/datadog/
          name: apmsocketpath
      containers:
        - name: <CONTAINER_NAME>
          image: <CONTAINER_IMAGE>/<TAG>
          volumeMounts:
            - name: apmsocketpath
              mountPath: /var/run/datadog
          env:
            - name: DD_ENV
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/env']
            - name: DD_SERVICE
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/service']
            - name: DD_VERSION
              valueFrom:
                fieldRef:
                  fieldPath:
metadata.labels['tags.datadoghq.com/version'] 
```


Parameter configuration:

1. `service.name`: Service name;
2. `env`: Environment information of the application service;
3. `version`: Version number;
4. Custom DataKit listening address; if not set, it follows the default address;
5. Set sampling rate for the service: When enabled, it can reduce the actual amount of generated data; the numeric range is from 0.0(0%) ~ 1.0(100%);
6. Collect Profiling data: When enabled, more runtime information about the application can be seen.