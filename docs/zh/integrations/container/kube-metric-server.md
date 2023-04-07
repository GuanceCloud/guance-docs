---
icon: material/kubernetes
---
# Kubernetes with Metric Server
---

## 视图预览

Kubernetes with Metric Server 性能指标展示，包括 Pod 数量、 Deployment 数量、 Job 数量、 Endpoint 数量、 Service 数量、 CPU、内存、 Pod 分布等。

![image](../imgs/input-kube-metric-server-01.png)

![image](../imgs/input-kube-metric-server-02.png)

![image](../imgs/input-kube-metric-server-03.png)

![image](../imgs/input-kube-metric-server-04.png)

![image](../imgs/input-kube-metric-server-05.png)

![image](../imgs/input-kube-metric-server-06.png)

![image](../imgs/input-kube-metric-server-07.png)

## 版本支持

操作系统支持：Linux

## 前置条件

- Kubernetes 集群 <[安装 DataKit](../../datakit/datakit-daemonset-deploy.md)>。
- 采集 Kubernetes Pod 指标数据，[需要 Kubernetes 安装 Metrics-Server 组件](https://github.com/kubernetes-sigs/metrics-server#installation)。

## 安装部署

说明：示例 Kubernetes 版本为 1.22.6

### 部署 Metric-Server (必选)

新建 `metric-server.yaml` ，在 Kubernetes 集群执行

```shell
kubectl apply -f metric-server.yaml
```

??? quote " `metric-server.yaml` 完整内容如下："

    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      labels:
        k8s-app: metrics-server
      name: metrics-server
      namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      labels:
        k8s-app: metrics-server
        rbac.authorization.k8s.io/aggregate-to-admin: "true"
        rbac.authorization.k8s.io/aggregate-to-edit: "true"
        rbac.authorization.k8s.io/aggregate-to-view: "true"
      name: system:aggregated-metrics-reader
    rules:
      - apiGroups:
          - metrics.k8s.io
        resources:
          - pods
          - nodes
        verbs:
          - get
          - list
          - watch
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      labels:
        k8s-app: metrics-server
      name: system:metrics-server
    rules:
      - apiGroups:
          - ""
        resources:
          - pods
          - nodes
          - nodes/stats
          - namespaces
          - configmaps
        verbs:
          - get
          - list
          - watch
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      labels:
        k8s-app: metrics-server
      name: metrics-server-auth-reader
      namespace: kube-system
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: extension-apiserver-authentication-reader
    subjects:
      - kind: ServiceAccount
        name: metrics-server
        namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      labels:
        k8s-app: metrics-server
      name: metrics-server:system:auth-delegator
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: system:auth-delegator
    subjects:
      - kind: ServiceAccount
        name: metrics-server
        namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRoleBinding
    metadata:
      labels:
        k8s-app: metrics-server
      name: system:metrics-server
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: system:metrics-server
    subjects:
      - kind: ServiceAccount
        name: metrics-server
        namespace: kube-system
    ---
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        k8s-app: metrics-server
      name: metrics-server
      namespace: kube-system
    spec:
      ports:
        - name: https
          port: 443
          protocol: TCP
          targetPort: https
      selector:
        k8s-app: metrics-server
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        k8s-app: metrics-server
      name: metrics-server
      namespace: kube-system
    spec:
      selector:
        matchLabels:
          k8s-app: metrics-server
      strategy:
        rollingUpdate:
          maxUnavailable: 0
      template:
        metadata:
          labels:
            k8s-app: metrics-server
        spec:
          containers:
            - args:
                - --cert-dir=/tmp
                - --secure-port=4443
                - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
                - --kubelet-use-node-status-port
                - --metric-resolution=15s
                - --kubelet-insecure-tls
              # image: k8s.gcr.io/metrics-server/metrics-server:v0.5.2
              image: bitnami/metrics-server:0.5.2
              imagePullPolicy: IfNotPresent
              livenessProbe:
                failureThreshold: 3
                httpGet:
                  path: /livez
                  port: https
                  scheme: HTTPS
                periodSeconds: 10
              name: metrics-server
              ports:
                - containerPort: 4443
                  name: https
                  protocol: TCP
              readinessProbe:
                failureThreshold: 3
                httpGet:
                  path: /readyz
                  port: https
                  scheme: HTTPS
                initialDelaySeconds: 20
                periodSeconds: 10
              resources:
                requests:
                  cpu: 100m
                  memory: 200Mi
              securityContext:
                readOnlyRootFilesystem: true
                runAsNonRoot: true
                runAsUser: 1000
              volumeMounts:
                - mountPath: /tmp
                  name: tmp-dir
          nodeSelector:
            kubernetes.io/os: linux
          priorityClassName: system-cluster-critical
          serviceAccountName: metrics-server
          volumes:
            - emptyDir: {}
              name: tmp-dir
    ---
    apiVersion: apiregistration.k8s.io/v1
    kind: APIService
    metadata:
      labels:
        k8s-app: metrics-server
      name: v1beta1.metrics.k8s.io
    spec:
      group: metrics.k8s.io
      groupPriorityMinimum: 100
      insecureSkipTLSVerify: true
      service:
        name: metrics-server
        namespace: kube-system
      version: v1beta1
      versionPriority: 100
    ```

### Daemonset 部署 DataKit (必选)

登录[观测云](https://console.guance.com/)，「集成」 - 「DataKit」 - 「Kubernetes」，下载 `datakit.yaml`（命名无要求）。

1、 修改 `datakit.yaml` 中的 dataway 配置

进入「管理」模块，找到下图中 token。

![image](../imgs/input-kube-metric-server-08.png)

替换 `datakit.yaml` 文件中的 `ENV_DATAWAY` 环境变量的 value 值中的 `your-token`。

```yaml
- name: ENV_DATAWAY
  value: https://openway.guance.com?token=<your-token>
```

在 `datakit.yaml` 文件中的 `ENV_GLOBAL_TAGS` 环境变量值最后增加 `cluster_name_k8s=k8s-prod` ，其中 k8s-prod 为指标设置的全局 tag，即指标所在的集群名称。

```yaml
- name: ENV_GLOBAL_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
```

2、 增加 `ENV_NAMESPACE` 环境变量

修改 `datakit.yaml`，增加 `ENV_NAMESPACE` 环境变量，这个环境变量是为了区分不同集群的选举，多个集群 value 值不能相同。

```yaml
- name: ENV_NAMESPACE
  value: xxx
```

3、 定义 ConfigMap

**注意：** 下载的 `datakit.yaml` 并没有 ConfigMap，定义的 ConfigMap 可一起放到 `datakit.yaml` 。

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
    extract_k8s_label_as_tags = false

    ## Auto-Discovery of PrometheusMonitoring Annotations/CRDs
    enable_auto_discovery_of_prometheus_service_annotations = false
    enable_auto_discovery_of_prometheus_pod_monitors = false
    enable_auto_discovery_of_prometheus_service_monitors = false

    ## Containers logs to include and exclude, default collect all containers. Globs accepted.
    container_include_log = []
    container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]
    exclude_pause_container = true

    ## Removes ANSI escape codes from text strings
    logging_remove_ansi_escape_codes = false

    ## If the data sent failure, will retry forevery
    logging_blocking_mode = true

    kubernetes_url = "https://kubernetes.default:443"

    ## Authorization level:
    ##   bearer_token -> bearer_token_string -> TLS
    ## Use bearer token for authorization. ('bearer_token' takes priority)
    ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
    ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
    bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
    # bearer_token_string = "<your-token-string>"

    logging_auto_multiline_detection = true
    logging_auto_multiline_extra_patterns = []

    ## Set true to enable election for k8s metric collection
    election = true

    [inputs.container.logging_extra_source_map]
      # source_regexp = "new_source"

    [inputs.container.logging_source_multiline_map]
      # source = '''^\d{4}'''

    [inputs.container.tags]
       #tag1 = "val1"
       #tag2 = "valn"
```

[inputs.container]参数说明

- enable_container_metric：是否开启 container 指标采集，请设置为 true。
- enable_k8s_metric：是否开启 kubernetes 指标采集。
- enable_pod_metric：是否开启 Pod 指标采集。
- container_include_log：须要采集的容器日志。
- container_exclude_log：不须要采集的容器日志。

`container_include_log` 和 `container_exclude_log` 必须以 `image` 开头，格式为 `"image:<glob规则>"`，表示 glob 规则是针对容器 image 生效。<br />

<[Glob 规则](https://en.wikipedia.org/wiki/Glob_(programming))>是一种轻量级的正则表达式，支持 `*` `?` 等基本匹配单元。

4、 使用 ConfigMap

在 `datakit.yaml` 文件中的 volumeMounts 下面增加：

```yaml
- mountPath: /usr/local/datakit/conf.d/container/container.conf
  name: datakit-conf
  subPath: container.conf
```

5、 部署 DataKit

```shell
kubectl apply -f datakit.yaml
```

#### 日志采集

默认自动收集输出到控制台的日志。

#### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Kubernetes 指标都会带有 `tag1 = "val1"` 的标签，可以进行快速查询
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```toml
    [inputs.kubernetes.tags]
       tag1 = "val1"
       #tag2 = "valn"
```

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Kubernetes 监控视图>

## [指标详解](../../datakit/container.md#measurements)

## 常见问题排查

- <[无数据上报排查](../../datakit/why-no-data.md)>

## 进一步阅读

- <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>
- <[多个 Kubernetes 集群指标采集最佳实践](../../best-practices/cloud-native/multi-cluster.md)>