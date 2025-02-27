# 在 Kubernetes 上部署
---

## 安装 DataKit Agent

进行系统和应用程序的链路数据分析之前，需要在每个目标主机上[部署{{{ custom_key.brand_name }}} DataKit 采集器](../../../datakit/datakit-install.md)，以收集必要的链路数据。

## 开启 DDTrace 采集器

DDTrace 用于接收、运算、分析 Tracing 协议数据，执行下面的命令，开启 DDTrace 采集器。其他第三方 Tracing 采集配置请参照[集成](../../../integrations/integration-index.md)。

```
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
```

配置完成后，重启 DataKit：

```
datakit service -R
```

## 选择语言


### Java

安装依赖：

```
wget -O dd-java-agent.jar 'https://{{{ custom_key.static_domain }}}/dd-image/dd-java-agent.jar'
```

运行应用：

在 Kubernetes 中，可以通过 Datakit Operator 来注入 trace agent，也可以手动挂载 trace agent 到应用容器中：

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

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
5. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
6. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息；
7. 开启 JVM 指标采集：需要同步开启 [statsd 采集器](../../../integrations/statsd.md)。

> 更多参数配置，参考 [这里](../../../integrations/ddtrace-java.md#start-options)。

### Python

安装依赖：

```
pip install ddtrace
```

运行应用：

可以通过多种途径运行你的 Java Code，如 IDE，Maven，Gradle 或直接通过 `java -jar` 命令，以下通过 `java` 命令启动应用：

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

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
5. 为服务设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
6. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息；
7. 开启 Python 指标采集：需要同步开启 [statsd 采集器](../../../integrations/statsd.md)。

> 更多参数配置，参考 [这里](../../../integrations/ddtrace-java.md#start-options)。

### Golang

安装依赖：

```
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer
```

运行应用：

可以通过多种途径运行你的 Java Code，如 IDE，Maven，Gradle 或直接通过 `java -jar` 命令，以下通过 `java` 命令启动应用：

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

参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
5. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)。

> 更多参数配置，参考 [这里](../../../integrations/ddtrace-java.md#start-options)。

### Node.JS

运行应用：

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


参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
5. 设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)。

### C++

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; 请参考</font>](../../../integrations/ddtrace-cpp.md)

</div>

</font>

### PHP

运行应用：

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


参数配置：

1. `service.name`：服务名；
2. `env`：应用服务的环境信息；
3. `version`：版本号；
4. 自定义 DataKit 监听地址，若不设置则跟随默认地址；
5. 为服务设置采样率：开启后，可降低实际产生的数据量；数字范围从 0.0(0%) ~ 1.0(100%)；
6. 收集 Profiling 数据：开启后可以看到更多应用程序运行时的信息。