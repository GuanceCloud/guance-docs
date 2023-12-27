# OpenTelemetry Operator 最佳实践

---

> _作者： 刘锐_

> OpenTelemetry Operator 是 Kubernetes Operator 的一种实现。

主要管理以下操作：

- OpenTelemetry Collector
- Auto-instrumentation ：使用 OpenTelemetry 检测库自动检测工作负载

观测云采集器 DataKit 的引进了 OpenTelemetry 设计理念，兼容了`OTLP` 协议的, 所以可以绕过 OpenTelemetry Collector 直接将数据推送给 DataKit , 也可以把 OpenTelemetry Collector 的 exporter 设置为 `OTLP` ，地址指向 DataKit。

我们将使用两种方案将 APM 数据集成到观测云上。

- APM 数据通过 OpenTelemetry Collector 推送到观测云;
- APM 数据直接推送到观测云。

## 前置条件

- [x] `k8s` 环境
- [x] 观测云帐号

## OpenTelemetry 相关组件安装

### 安装 OpenTelemetry Operator

- 下载`opentelemetry-operator.yaml`

```shell
wget https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
```

- 安装`opentelemetry-operator.yaml`

```shell
[root@k8s-master ~]# kubectl apply -f opentelemetry-operator.yaml 
namespace/opentelemetry-operator-system created
customresourcedefinition.apiextensions.k8s.io/instrumentations.opentelemetry.io created
customresourcedefinition.apiextensions.k8s.io/opentelemetrycollectors.opentelemetry.io created
serviceaccount/opentelemetry-operator-controller-manager created
role.rbac.authorization.k8s.io/opentelemetry-operator-leader-election-role created
clusterrole.rbac.authorization.k8s.io/opentelemetry-operator-manager-role created
clusterrole.rbac.authorization.k8s.io/opentelemetry-operator-metrics-reader created
clusterrole.rbac.authorization.k8s.io/opentelemetry-operator-proxy-role created
rolebinding.rbac.authorization.k8s.io/opentelemetry-operator-leader-election-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/opentelemetry-operator-manager-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/opentelemetry-operator-proxy-rolebinding created
service/opentelemetry-operator-controller-manager-metrics-service created
service/opentelemetry-operator-webhook-service created
deployment.apps/opentelemetry-operator-controller-manager created
certificate.cert-manager.io/opentelemetry-operator-serving-cert created
issuer.cert-manager.io/opentelemetry-operator-selfsigned-issuer created
mutatingwebhookconfiguration.admissionregistration.k8s.io/opentelemetry-operator-mutating-webhook-configuration created
validatingwebhookconfiguration.admissionregistration.k8s.io/opentelemetry-operator-validating-webhook-configuration created

```

- 查看`pod`

```shell
[root@k8s-master df-demo]# kubectl get pod -n opentelemetry-operator-system
NAME                                                         READY   STATUS    RESTARTS   AGE
opentelemetry-operator-controller-manager-7b4687df88-9s967   2/2     Running   0          26h

```

### 安装 OpenTelemetry Collector

- 编写 `opentelemetry-collector.yaml`

```yaml
apiVersion: opentelemetry.io/v1alpha1
kind: OpenTelemetryCollector
metadata:
  name: demo
spec:
  config: |
    receivers:
      otlp:
        protocols:
          grpc:
          http:
    processors:
      memory_limiter:
        check_interval: 1s
        limit_percentage: 75
        spike_limit_percentage: 15
      batch:
        send_batch_size: 10000
        timeout: 10s

    exporters:
      logging:
      otlp:
        endpoint: "http://datakit-service.datakit:4319" # 将链路信息输出到观测云平台
        tls:
          insecure: true
        #compression: none # 不开启gzip

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [logging,otlp]
        metrics:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [logging]
        logs:
          receivers: [otlp]
          processors: [memory_limiter, batch]
          exporters: [logging]

```

- 执行 `opentelemetry-collector.yaml`

```shell
kubectl apply -f opentelemetry-collector.yaml 
```

- 查看`pod`

```shell
[root@k8s-master ~]# kubectl get pod 
NAME                                 READY   STATUS    RESTARTS   AGE
demo-collector-59b9447bf9-dz47k      1/1     Running   0          61m
```

### 安装 Instrumentation

OpenTelemetry Operator 可以注入和配置 OpenTelemetry 自动检测库。目前支持`Apache HTTPD`、`DotNet`、`Go`、`Java`、`NodeJS`和`Python`。

若要使用自动检测，请使用 SDK 和检测的配置来配置检测资源。

- 编写 `opentelemetry-instrumentation.yaml`

```yaml
apiVersion: opentelemetry.io/v1alpha1
kind: Instrumentation
metadata:
  name: my-instrumentation
spec:
  exporter:
    endpoint: http://demo-collector:4317 # Opentelemetry collector address
    # endpoint: http://datakit-service.datakit:4319 # Guance datakit opentelemetry collector address
  propagators:
    - tracecontext
    - baggage
    - b3
  #sampler:   
      #type: parentbased_traceidratio
      #argument: "0.25"
  java:
    image: ghcr.io/open-telemetry/opentelemetry-operator/autoinstrumentation-java:latest
  nodejs:
    image: ghcr.io/open-telemetry/opentelemetry-operator/autoinstrumentation-nodejs:latest
  python:
    image: ghcr.io/open-telemetry/opentelemetry-operator/autoinstrumentation-python:latest
```

- exporter：数据上报地址，可以是 Opentelemetry collector,也可以是其他可以接收`otlp`协议数据的采集器
- propagators: 链路数据传播器，关于更多传播器的行为，请参考[文档](https://juejin.cn/post/7254125867177443365)
- sampler: 采样
- java\nodejs\python: 不同语言的 agent，根据实际项目需要填写。

- 执行 `opentelemetry-instrumentation.yaml`

```shell
kubectl apply -f opentelemetry-instrumentation.yaml 
```

- 查看`instrumentation`

```shell
[root@k8s-master ~]# kubectl get instrumentation
NAME                 AGE   ENDPOINT                     SAMPLER   SAMPLER ARG
my-instrumentation   65m   http://demo-collector:4317  
```

或者使用`kubectl get otelinst`命令来查看。

```shell
[root@k8s-master ~]#  kubectl get otelinst
NAME                 AGE   ENDPOINT                     SAMPLER   SAMPLER ARG
my-instrumentation   71m   http://demo-collector:4317    
```

## 观测云

### Kubernetes DataKit 安装

[Kubernetes DataKit 安装](https://docs.guance.com/datakit/datakit-daemonset-deploy/)

### OpenTelemetry 采集器配置

- 在 `datakit.yaml` 的`DaemonSet`下面新增`volumeMounts`：

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: daemonset-datakit
  name: datakit
  namespace: datakit
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: daemonset-datakit
  template:
    metadata:
      labels:
        app: daemonset-datakit
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      ...
      volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/opentelemetry/opentelemetry.conf
          name: datakit-conf
          subPath: opentelemetry.conf
      ....
```

- 在 `datakit.yaml` 的`ConfigMap` data 下新增`opentelemetry.conf`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    opentelemetry.conf: |-
        [[inputs.opentelemetry]]
            [inputs.opentelemetry.grpc]
            trace_enable = true
            metric_enable = true
            addr = "0.0.0.0:4319" # defalut 4317
            [inputs.opentelemetry.http]
            enable = false
            http_status_ok = 200

```

- 重启 DataKit


## 应用

这里准备了一个 JAVA 应用 [`springboot-server`](registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-server)


- 编写 `springboot-server.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: springboot-server
  labels:
    app: springboot-server
spec:
  selector:
    app: springboot-server
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
      nodePort: 31010
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: springboot-server
spec:
  selector:
    matchLabels:
      app: springboot-server
  replicas: 1
  template:
    metadata:
      labels:
        app: springboot-server
      annotations:
        sidecar.opentelemetry.io/inject: "true"
        instrumentation.opentelemetry.io/inject-java: "true"
    spec:
      containers:
      - name: app
        image: registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-server
        ports:
          - containerPort:  8080
            protocol: TCP
```

- 执行 `springboot-server.yaml`

```shell
kubectl apply -f springboot-server.yaml
```

-  查看`pod`

```shell
[root@k8s-master ~]# kubectl get pod -owide
NAME                                 READY   STATUS    RESTARTS   AGE    IP                NODE        NOMINATED NODE   READINESS GATES
demo-collector-59b9447bf9-dz47k      1/1     Running   0          24h    100.111.156.98    k8s-node1   <none>           <none>
springboot-server-64b78f4487-9hv9r   1/1     Running   0          24h    100.111.156.108   k8s-node1   <none>           <none>

```

- 查看`pod`详情

```shell
root@k8s-master ~]# kubectl describe pod springboot-server-64b78f4487-9hv9r
Name:         springboot-server-64b78f4487-9hv9r
Namespace:    default
Priority:     0
Node:         k8s-node1/172.31.22.247
Start Time:   ...
Labels:       app=springboot-server
              pod-template-hash=64b78f4487
Annotations:  cni.projectcalico.org/containerID: 5700e2ab666a8bbc32b1ac84cc3d98137a7e186ca5cf4b0b6e7407ac8139d391
              cni.projectcalico.org/podIP: 100.111.156.108/32
              cni.projectcalico.org/podIPs: 100.111.156.108/32
              instrumentation.opentelemetry.io/inject-java: true
              sidecar.opentelemetry.io/inject: true
Status:       Running
IP:           100.111.156.108
IPs:
  IP:           100.111.156.108
Controlled By:  ReplicaSet/springboot-server-64b78f4487
Init Containers:
  opentelemetry-auto-instrumentation:
    Container ID:  containerd://c5747d8217b43fcb1a8eac00fbd33d70c7b25d1a3f0faaccdacea94c8b1e016b
    Image:         ghcr.io/open-telemetry/opentelemetry-operator/autoinstrumentation-java:latest
    Image ID:      ghcr.io/open-telemetry/opentelemetry-operator/autoinstrumentation-java@sha256:f903e6eb067f28cba1f37b6ac592b511c61ce0bf2a73f6e7619359ac5d500d85
    Port:          <none>
    Host Port:     <none>
    Command:
      cp
      /javaagent.jar
      /otel-auto-instrumentation/javaagent.jar
    ...
    Mounts:
      /otel-auto-instrumentation from opentelemetry-auto-instrumentation (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-lbmf6 (ro)
Containers:
  app:
    Container ID:   containerd://0db185a75e9eeb5eed97aaf8e707f4bd30f210e404f5fae98fc0d55a300a4470
    Image:          registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-server
    Image ID:       registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-server@sha256:bf394ec31566653bc6aa0e56dfc94a602bde3d95dfb08ac96d7f33c5dc00005e
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      ...
    Ready:          True
    Restart Count:  0
    Environment:
      JAVA_TOOL_OPTIONS:                    -javaagent:/otel-auto-instrumentation/javaagent.jar
      OTEL_SERVICE_NAME:                   springboot-server
      OTEL_EXPORTER_OTLP_ENDPOINT:         http://demo-collector:4317
      OTEL_RESOURCE_ATTRIBUTES_POD_NAME:   springboot-server-64b78f4487-9hv9r (v1:metadata.name)
      OTEL_RESOURCE_ATTRIBUTES_NODE_NAME:   (v1:spec.nodeName)
      OTEL_PROPAGATORS:                    tracecontext,baggage,b3
      OTEL_RESOURCE_ATTRIBUTES:            k8s.container.name=app,k8s.deployment.name=springboot-server,k8s.namespace.name=default,k8s.node.name=$(OTEL_RESOURCE_ATTRIBUTES_NODE_NAME),k8s.pod.name=$(OTEL_RESOURCE_ATTRIBUTES_POD_NAME),k8s.replicaset.name=springboot-server-64b78f4487
    Mounts:
      /otel-auto-instrumentation from opentelemetry-auto-instrumentation (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-lbmf6 (ro)

```

Init Containers：初始化容器，执行了 `opentelemetry-auto-instrumentation` sidecar 。

默认 JAVA 应用注入的环境变量

```shell
    Environment:
      JAVA_TOOL_OPTIONS:                    -javaagent:/otel-auto-instrumentation/javaagent.jar
      OTEL_SERVICE_NAME:                   springboot-server
      OTEL_EXPORTER_OTLP_ENDPOINT:         http://demo-collector:4317
      OTEL_RESOURCE_ATTRIBUTES_POD_NAME:   springboot-server-64b78f4487-9hv9r (v1:metadata.name)
      OTEL_RESOURCE_ATTRIBUTES_NODE_NAME:   (v1:spec.nodeName)
      OTEL_PROPAGATORS:                    tracecontext,baggage,b3
      OTEL_RESOURCE_ATTRIBUTES:            k8s.container.name=app,k8s.deployment.name=springboot-server,k8s.namespace.name=default,k8s.node.name=$(OTEL_RESOURCE_ATTRIBUTES_NODE_NAME),k8s.pod.name=$(OTEL_RESOURCE_ATTRIBUTES_POD_NAME),k8s.replicaset.name=springboot-server-64b78f4487
```

至此，JAVA 应用成功注入了 `opentelemetry-auto-instrumentation` sidecar 。

### 生成 Trace 数据

- 在主机通过执行以下命令，生成 `trace` 数据

    ```shell
    [root@k8s-master ~]# curl http://100.111.156.108:8080/gateway
    {"msg":"下单成功","code":200}
    ```
    **100.111.156.108** 为 pod 对应的`ip`。

- 也可以通过访问svc的端口，生成 `trace` 数据
    ```shell
    [root@k8s-master ~]# curl http://localhost:31010/gateway
    {"msg":"下单成功","code":200}
    ```

### 查看应用日志信息

```shell
[root@k8s-master ~]# kubectl logs -f springboot-server-64b78f4487-9hv9r
....
2023-08-* 16:34:17.454 [http-nio-8080-exec-8] INFO  c.z.o.s.c.ServerController - [auth,74] traceId=a1b510158fc09c55c04de2d9472d10d7 spanId=61b6bd8264f7d8b1 - this is auth
2023-08-* 16:34:17.456 [http-nio-8080-exec-5] INFO  c.z.o.s.f.CorsFilter - [doFilter,32] traceId=a1b510158fc09c55c04de2d9472d10d7 spanId=62370160a0fc0738 - url:/billing,header:
accept				:application/json, application/*+json
traceparent				:00-a1b510158fc09c55c04de2d9472d10d7-057f9e068e9cc007-01
b3				:a1b510158fc09c55c04de2d9472d10d7-057f9e068e9cc007-1
user-agent				:Java/1.8.0_212
host				:localhost:8080
connection				:keep-alive

2023-08-* 16:34:17.456 [http-nio-8080-exec-5] INFO  c.z.o.s.c.ServerController - [billing,82] traceId=a1b510158fc09c55c04de2d9472d10d7 spanId=9514404368a2d4fd - this is method3,null

```

可以看到已经生成了trace 相关信息： `traceparent`、`b3`。

这里发现日志里面也生成了`traceId`和`spanId`,关于日志如何关联`trace`，参考文档 [日志关联](/integrations/java/#logging)。


## 应用数据直推观测云

- 调整 `opentelemetry-instrumentation.yaml` 文件 `OTEL_EXPORTER_OTLP_ENDPOINT` 

```shell
[root@k8s-master ~]# kubectl describe pod springboot-server-64b78f4487-t7gph |grep OTEL_EXPORTER_OTLP_ENDPOINT
      OTEL_EXPORTER_OTLP_ENDPOINT:         http://datakit-service.datakit:4319
```

- 重新执行以下 `yaml`

```shell
kubectl delete -f opentelemetry-instrumentation.yaml 
kubectl apply -f opentelemetry-instrumentation.yaml 

kubectl delete -f springboot-server.yaml
kubectl apply -f springboot-server.yaml
```

- 访问应用 url，生成 trace 数据。

- 登陆观测云帐号，查看链路视图

![链路详情](../images/otel_operator_2.png)

## 源码

[opentelemetry-operator-demo](https://github.com/lrwh/opentelemetry-operator-demo)
