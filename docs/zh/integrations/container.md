---
title: '容器基础采集'
summary: '采集 Container 和 Kubernetes 的指标、对象和日志数据，上报到观测云。'
__int_icon:    'icon/kubernetes/'  
dashboard:
  - desc: 'Kubernetes 监控视图'
    path: 'dashboard/zh/kubernetes'
  - desc: 'Kubernetes Services 监控视图'
    path: 'dashboard/zh/kubernetes_services'
  - desc: 'Kubernetes Nodes Overview 监控视图'
    path: 'dashboard/zh/kubernetes_nodes_overview'
  - desc: 'Kubernetes Pods Overview 监控视图'
    path: 'dashboard/zh/kubernetes_pods_overview'
  - desc: 'Kubernetes Events 监控视图'
    path: 'dashboard/zh/kubernetes_events'
 
monitor:
  - desc: 'Kubernetes'
    path: 'monitor/zh/kubernetes'
---


<!-- markdownlint-disable MD025 -->
# 容器基础采集
<!-- markdownlint-enable -->
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

采集 Container 和 Kubernetes 的指标、对象和日志数据，上报到观测云。

## 采集器配置 {#config}

### 前置条件 {#requrements}

- 目前 container 支持 Docker、Containerd、CRI-O 容器运行时
    - 版本要求：Docker v17.04 及以上版本，Containerd v1.5.1 及以上，CRI-O 1.20.1 及以上
- 采集 Kubernetes 数据需要 DataKit 以 [DaemonSet 方式部署](../datakit/datakit-daemonset-deploy.md)。

<!-- markdownlint-disable MD046 -->
???+ info

    - 容器采集支持 Docker 和 Containerd 两种运行时[:octicons-tag-24: Version-1.5.7](../datakit/changelog.md#cl-1.5.7)，且默认都开启采集。

=== "主机安装"

    如果是纯 Docker 或 Containerd 环境，那么 DataKit 只能安装在宿主机上。
    
    进入 DataKit 安装目录下的 *conf.d/container* 目录，复制 *container.conf.sample* 并命名为 *container.conf*。示例如下：
    
    ``` toml
        
    [inputs.container]
      endpoints = [
        "unix:///var/run/docker.sock",
        "unix:///var/run/containerd/containerd.sock",
        "unix:///var/run/crio/crio.sock",
      ]
    
      enable_container_metric = true
      enable_k8s_metric = true
      enable_pod_metric = false
      enable_k8s_event = true
      enable_k8s_node_local = true
    
      ## Add resource Label as Tags (container use Pod Label), need to specify Label keys.
      ## e.g. ["app", "name"]
      # extract_k8s_label_as_tags_v2 = []
      # extract_k8s_label_as_tags_v2_for_metric = []
    
      ## Auto-Discovery of PrometheusMonitoring Annotations/CRDs
      enable_auto_discovery_of_prometheus_pod_annotations = false
      enable_auto_discovery_of_prometheus_service_annotations = false
      enable_auto_discovery_of_prometheus_pod_monitors = false
      enable_auto_discovery_of_prometheus_service_monitors = false
    
      ## Containers logs to include and exclude, default collect all containers. Globs accepted.
      container_include_log = []
      container_exclude_log = ["image:*logfwd*", "image:*datakit*"]
    
      kubernetes_url = "https://kubernetes.default:443"
    
      ## Authorization level:
      ##   bearer_token -> bearer_token_string -> TLS
      ## Use bearer token for authorization. ('bearer_token' takes priority)
      ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
      bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
      # bearer_token_string = "<your-token-string>"
    
      ## Set true to enable election for k8s metric collection
      election = true
    
      logging_auto_multiline_detection = true
      logging_auto_multiline_extra_patterns = []
    
      ## Removes ANSI escape codes from text strings.
      logging_remove_ansi_escape_codes = false
    
      ## Search logging interval, default "60s"
      #logging_search_interval = ""
    
      [inputs.container.logging_extra_source_map]
        # source_regexp = "new_source"
    
      [inputs.container.logging_source_multiline_map]
        # source = '''^\d{4}'''
    
      [inputs.container.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```

=== "Kubernetes"

    可通过 [ConfigMap 方式注入采集器配置](../datakit/datakit-daemonset-deploy.md#configmap-setting) 或 [配置 ENV_DATAKIT_INPUTS](../datakit/datakit-daemonset-deploy.md#env-setting) 开启采集器。

    也支持以环境变量的方式修改配置参数（需要在 ENV_DEFAULT_ENABLED_INPUTS 中加为默认采集器）：

    - **ENV_INPUT_CONTAINER_ENDPOINTS**
    
        追加多个容器运行时的 endpoint
    
        **Type**: List
    
        **ConfField**: `endpoints`
    
        **Example**: "`unix:///var/run/docker.sock,unix:///var/run/containerd/containerd.sock,unix:///var/run/crio/crio.sock`"
    
    - **ENV_INPUT_CONTAINER_DOCKER_ENDPOINT**
    
        已废弃，指定 Docker Engine 的 endpoint
    
        **Type**: String
    
        **ConfField**: `docker_endpoint`
    
        **Example**: `unix:///var/run/docker.sock`
    
    - **ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS**
    
        已废弃，指定 `Containerd` 的 endpoint
    
        **Type**: String
    
        **ConfField**: `containerd_address`
    
        **Example**: `/var/run/containerd/containerd.sock`
    
    - **ENV_INPUT_CONTAINER_ENABLE_CONTAINER_METRIC**
    
        开启容器指标采集
    
        **Type**: Boolean
    
        **ConfField**: `enable_container_metric`
    
        **Default**: true
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_METRIC**
    
        开启 k8s 指标采集
    
        **Type**: Boolean
    
        **ConfField**: `enable_k8s_metric`
    
        **Default**: true
    
    - **ENV_INPUT_CONTAINER_ENABLE_POD_METRIC**
    
        是否开启 Pod 指标采集（CPU 和内存使用情况），需要安装[Kubernetes-metrics-server](https://github.com/kubernetes-sigs/metrics-server){:target="_blank"}
    
        **Type**: Boolean
    
        **ConfField**: `enable_pod_metric`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_EVENT**
    
        是否开启分时间采集模式
    
        **Type**: Boolean
    
        **ConfField**: `enable_k8s_event`
    
        **Default**: true
    
    - **ENV_INPUT_CONTAINER_ENABLE_K8S_NODE_LOCAL**
    
        是否开启分 Node 采集模式，由部署在各个 Node 的 Datakit 独立采集当前 Node 的资源。[:octicons-tag-24: Version-1.19.0](../datakit/changelog.md#cl-1.19.0) 需要额外的 `RABC` 权限，见[此处](#rbac-nodes-stats)
    
        **Type**: Boolean
    
        **ConfField**: `enable_k8s_node_local`
    
        **Default**: true
    
    - **ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS**
    
        是否追加资源的 labels 到采集的 tag 中。只有 Pod 指标、对象和 Node 对象会添加，另外容器日志也会添加其所属 Pod 的 labels。如果 label 的 key 有 dot 字符，会将其变为横线
    
        **Type**: Boolean
    
        **ConfField**: `extract_k8s_label_as_tags`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2**
    
        追加资源的 labels 到数据（不包括指标数据）的 tag 中。需指定 label keys，如果只有一个 key 且为空字符串（例如 [""]），会添加所有 labels 到 tag。容器会继承 Pod labels。如果 label 的 key 有 dot 字符，会将其变为横线
    
        **Type**: JSON
    
        **ConfField**: `env_input_container_extract_k8s_label_as_tags_v2`
    
        **Example**: ["app","name"]
    
    - **ENV_INPUT_CONTAINER_ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2_FOR_METRIC**
    
        追加资源的 labels 到指标数据的 tag 中。需指定 label keys，如果只有一个 key 且为空字符串（例如 [""]），会添加所有 labels 到 tag。容器会继承 Pod labels。如果 label 的 key 有 dot 字符，会将其变为横线
    
        **Type**: JSON
    
        **ConfField**: `env_input_container_extract_k8s_label_as_tags_v2_for_metric`
    
        **Example**: ["app","name"]
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_ANNOTATIONS**
    
        是否开启自动发现 Prometheus Pod Annotations 并采集指标
    
        **Type**: Boolean
    
        **ConfField**: `enable_auto_discovery_of_prometheus_pod_annotations`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_ANNOTATIONS**
    
        是否开启自动发现 Prometheus 服务 Annotations 并采集指标
    
        **Type**: Boolean
    
        **ConfField**: `enable_auto_discovery_of_prometheus_service_annotations`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_POD_MONITORS**
    
        是否开启自动发现 Prometheus Pod Monitor CRD 并采集指标，详见[Prometheus-Operator CRD 文档](kubernetes-prometheus-operator-crd.md#config)
    
        **Type**: Boolean
    
        **ConfField**: `enable_auto_discovery_of_prometheus_pod_monitors`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_ENABLE_AUTO_DISCOVERY_OF_PROMETHEUS_SERVICE_MONITORS**
    
        是否开启自动发现 Prometheus ServiceMonitor CRD 并采集指标，详见[Prometheus-Operator CRD 文档](kubernetes-prometheus-operator-crd.md#config)
    
        **Type**: Boolean
    
        **ConfField**: `enable_auto_discovery_of_prometheus_service_monitors`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG**
    
        容器日志白名单，使用 image 过滤
    
        **Type**: List
    
        **ConfField**: `container_include_log`
    
        **Example**: "image:pubrepo.jiagouyun.com/datakit/logfwd*"
    
    - **ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG**
    
        容器日志黑名单，使用 image 过滤
    
        **Type**: List
    
        **ConfField**: `container_exclude_log`
    
        **Example**: "image:pubrepo.jiagouyun.com/datakit/logfwd*"
    
    - **ENV_INPUT_CONTAINER_KUBERNETES_URL**
    
        k8s API 服务访问地址
    
        **Type**: String
    
        **ConfField**: `kubernetes_url`
    
        **Example**: https://kubernetes.default:443
    
    - **ENV_INPUT_CONTAINER_BEARER_TOKEN**
    
        访问 k8s 服务所需的 token 文件路径
    
        **Type**: String
    
        **ConfField**: `bearer_token`
    
        **Example**: `/run/secrets/kubernetes.io/serviceaccount/token`
    
    - **ENV_INPUT_CONTAINER_BEARER_TOKEN_STRING**
    
        访问 k8s 服务所需的 token 字符串
    
        **Type**: String
    
        **ConfField**: `bearer_token_string`
    
        **Example**: your-token-string
    
    - **ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL**
    
        日志发现的时间间隔，即每隔多久检索一次日志，如果间隔太长，会导致忽略了一些存活较短的日志
    
        **Type**: TimeDuration
    
        **ConfField**: `logging_search_interval`
    
        **Default**: 60s
    
    - **ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP**
    
        日志采集配置额外的 source 匹配，符合正则的 source 会被改名
    
        **Type**: Map
    
        **ConfField**: `logging_extra_source_map`
    
        **Example**: source_regex*=new_source,regex*=new_source2
    
    - **ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON**
    
        日志采集配置额外的 source 匹配，符合正则的 source 会被改名
    
        **Type**: JSON
    
        **ConfField**: `logging_source_multiline_map`
    
        **Example**: {"source_nginx":"^\\d{4}", "source_redis":"^[A-Za-z_]"}
    
    - **ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_DETECTION**
    
        日志采集是否开启自动多行模式，开启后会在 patterns 列表中匹配适用的多行规则
    
        **Type**: Boolean
    
        **ConfField**: `logging_auto_multiline_detection`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_EXTRA_PATTERNS_JSON**
    
        日志采集的自动多行模式 pattens 列表，支持手动配置多个多行规则
    
        **Type**: JSON
    
        **ConfField**: `logging_auto_multiline_extra_patterns`
    
        **Example**: ["^\\d{4}-\\d{2}", "^[A-Za-z_]"]
    
        **Default**: For more default rules, see [doc](logging.md#auto-multiline)
    
    - **ENV_INPUT_CONTAINER_LOGGING_MAX_MULTILINE_LIFE_DURATION**
    
        日志采集的单次多行最大生命周期，此周期结束将清空和上传现存的多行数据，避免堆积
    
        **Type**: TimeDuration
    
        **ConfField**: `logging_max_multiline_life_duration`
    
        **Default**: 3s
    
    - **ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES**
    
        日志采集删除包含的颜色字符，详见[日志特殊字符处理说明](logging.md#ansi-decode)
    
        **Type**: Boolean
    
        **ConfField**: `logging_remove_ansi_escape_codes`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_LOGGING_FORCE_FLUSH_LIMIT**
    
        日志采集上传限制，如果连续 N 次都采集为空，会将现有的数据上传，避免数据积攒占用内存
    
        **Type**: Int
    
        **ConfField**: `logging_force_flush_limit`
    
        **Default**: 5
    
    - **ENV_INPUT_CONTAINER_CONTAINER_MAX_CONCURRENT**
    
        采集容器数据时的最大并发数，推荐只在采集延迟较大时开启
    
        **Type**: Int
    
        **ConfField**: `container_max_concurrent`
    
        **Default**: cpu cores + 1
    
    - **ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB**
    
        关闭对 Kubernetes Job 资源的采集（包括指标数据和对象数据）
    
        **Type**: Boolean
    
        **ConfField**: `disable_collect_kube_job`
    
        **Default**: false
    
    - **ENV_INPUT_CONTAINER_TAGS**
    
        自定义标签。如果配置文件有同名标签，将会覆盖它
    
        **Type**: Map
    
        **ConfField**: `tags`
    
        **Example**: tag1=value1,tag2=value2

    环境变量额外说明：
    
    - ENV_INPUT_CONTAINER_TAGS：如果配置文件（*container.conf*）中有同名 tag，将会被这里的配置覆盖掉。
    
    - ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP：指定替换 source，参数格式是「正则表达式=new_source」，当某个 source 能够匹配正则表达式，则这个 source 会被 new_source 替换。如果能够替换成功，则不再使用 `annotations/labels` 中配置的 source（[:octicons-tag-24: Version-1.4.7](../datakit/changelog.md#cl-1.4.7)）。如果要做到精确匹配，需要使用 `^` 和 `$` 将内容括起来。比如正则表达式写成 `datakit`，不仅可以匹配 `datakit` 字样，还能匹配到 `datakit123`；写成 `^datakit$` 则只能匹配到的 `datakit`。
    
    - ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON：用来指定 source 到多行配置的映射，如果某个日志没有配置 `multiline_match`，就会根据它的 source 来此处查找和使用对应的 `multiline_match`。因为 `multiline_match` 值是正则表达式较为复杂，所以 value 格式是 JSON 字符串，可以使用 [json.cn](https://www.json.cn/){:target="_blank"} 辅助编写并压缩成一行。

???+ attention

    - 对象数据采集间隔是 5 分钟，指标数据采集间隔是 60 秒，不支持配置
    - 采集到的日志，单行（包括经过 `multiline_match` 处理后）最大长度为 32MB，超出部分会被截断且丢弃

### Docker 和 Containerd sock 文件配置 {#sock-config}

如果 Docker 或 Containerd 的 sock 路径不是默认的，则需要指定一下 sock 文件路径，根据 DataKit 不同部署方式，其方式有所差别，以 Containerd 为例：

=== "主机部署"

    修改 container.conf 的 `endpoints` 配置项，将其设置为对应的 sock 路径。

=== "Kubernetes"

    更改 *datakit.yaml* 的 volumes `containerd-socket`，将新路径 mount 到 Datakit 中，同时配置环境变量 `ENV_INPUT_CONTAINER_ENDPOINTS`：

    ``` yaml hl_lines="3 4 7 14"
    # 添加 env
    - env:
      - name: ENV_INPUT_CONTAINER_ENDPOINTS
        value: ["unix:///path/to/new/containerd/containerd.sock"]
    
    # 修改 mountPath
      - mountPath: /path/to/new/containerd/containerd.sock
        name: containerd-socket
        readOnly: true
    
    # 修改 volumes
    volumes:
    - hostPath:
        path: /path/to/new/containerd/containerd.sock
      name: containerd-socket
    ```
<!-- markdownlint-enable -->

环境变量 `ENV_INPUT_CONTAINER_ENDPOINTS` 是追加到现有的 endpoints 配置，最终实际 endpoints 配置可能有很多项，采集器会去重然后逐一连接、采集。

默认的 endpoints 配置是：

```yaml
  endpoints = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/containerd/containerd.sock",
    "unix:///var/run/crio/crio.sock",
  ] 
```

使用环境变量 `ENV_INPUT_CONTAINER_ENDPOINTS` 为 `["unix:///path/to/new//run/containerd.sock"]`，最终 endpoints 配置如下：

```yaml
  endpoints = [
    "unix:///var/run/docker.sock",
    "unix:///var/run/containerd/containerd.sock",
    "unix:///var/run/crio/crio.sock",
    "unix:///path/to/new//run/containerd.sock",
  ] 
```

采集器会连接和采集这些容器运行时，如果 sock 文件不存在，会在第一次连接失败时输出报错日志，不影响后续采集。

### Prometheus Exporter 指标采集 {#k8s-prom-exporter}

<!-- markdownlint-disable MD024 -->
如果 Pod/容器有暴露 Prometheus 指标，有两种方式可以采集，参见[这里](kubernetes-prom.md)


### 日志采集 {#logging-config}

日志采集的相关配置详见[此处](container-log.md)。

---

## 指标 {#metric}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.container.tags]` 指定其它标签：

```toml
 [inputs.container.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```





### `docker_containers`

The metric of containers, only supported Running status.

- 标签


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`image`|The full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, example `nginx`.|
|`image_tag`|The tag of the container image, example `1.21.0`.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|The pod uid of the container (label `io.kubernetes.pod.uid`).|
|`state`|Container status (only Running).|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`task_arn`|The task arn of the AWS Fargate.|
|`task_family`|The task family of the AWS fargate.|
|`task_version`|The task version of the AWS fargate.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|Total number of bytes read from the container file system (only supported docker).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (only supported docker).|int|B|
|`cpu_numbers`|The number of the CPU core.|int|count|
|`cpu_usage`|The percentage usage of CPU on system host.|float|percent|
|`cpu_usage_base100`|The normalized cpu usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The limit memory in the container.|int|B|
|`mem_usage`|The usage of the memory.|int|B|
|`mem_used_percent`|The percentage usage of the memory is calculated based on the capacity of host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of the memory is calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes send to the network (only count the usage of the main process in the container, excluding loopback).|int|B|














### `kubernetes`

The count of the Kubernetes resource.

- 标签


| Tag | Description |
|  ----  | --------|
|`namespace`|namespace|
|`node_name`|NodeName is a request to schedule this pod onto a specific node (only supported Pod and Container).|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`container`|Container count|int|-|
|`cronjob`|CronJob count|int|-|
|`daemonset`|Service count|int|-|
|`deployment`|Deployment count|int|-|
|`endpoint`|Endpoint count|int|-|
|`job`|Job count|int|-|
|`node`|Node count|int|-|
|`pod`|Pod count|int|-|
|`replicaset`|ReplicaSet count|int|-|
|`service`|Service count|int|-|
|`statefulset`|StatefulSet count|int|-|






### `kube_cronjob`

The metric of the Kubernetes CronJob.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`cronjob`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of CronJob.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`spec_suspend`|This flag tells the controller to suspend subsequent executions.|bool|-|










### `kube_daemonset`

The metric of the Kubernetes DaemonSet.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of DaemonSet.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`daemons_available`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count|










### `kube_deployment`

The metric of the Kubernetes Deployment.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`deployment`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Deployment.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replicas`|Total number of non-terminated pods targeted by this deployment (their labels match the selector).|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|count|
|`replicas_desired`|Number of desired pods for a Deployment.|int|count|
|`replicas_ready`|The number of pods targeted by this Deployment with a Ready Condition.|int|count|
|`replicas_unavailable`|Total number of unavailable pods targeted by this deployment.|int|count|
|`replicas_updated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|count|
|`rollingupdate_max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. |int|count|
|`rollingupdate_max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|










### `kube_dfpv`

The metric of the Kubernetes PersistentVolume.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The dfpv name, consists of pvc name and pod name|
|`namespace`|The namespace of Pod and PVC.|
|`node_name`|Reference to the Node.|
|`pod_name`|Reference to the Pod.|
|`pvc_name`|Reference to the PVC.|
|`volume_mount_name`|The name given to the Volume.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`available`|AvailableBytes represents the storage space available (bytes) for the filesystem.|int|B|
|`capacity`|CapacityBytes represents the total capacity (bytes) of the filesystems underlying storage.|int|B|
|`inodes`|Inodes represents the total inodes in the filesystem.|int|count|
|`inodes_free`|InodesFree represents the free inodes in the filesystem.|int|count|
|`inodes_used`|InodesUsed represents the inodes used by the filesystem.|int|count|
|`used`|UsedBytes represents the bytes used for a specific task on the filesystem.|int|B|










### `kube_endpoint`

The metric of the Kubernetes Endpoints.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`endpoint`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Endpoint.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`address_available`|Number of addresses available in endpoint.|int|count|
|`address_not_ready`|Number of addresses not ready in endpoint.|int|count|










### `kube_job`

The metric of the Kubernetes Job.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`job`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Job.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|The number of actively running pods.|int|count|
|`completion_failed`|The job has failed its execution.|int|count|
|`completion_succeeded`|The job has completed its execution.|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count|










### `kube_node`

The metric of the Kubernetes Node.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`node`|Name must be unique within a namespace|
|`uid`|The UID of Node.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_allocatable`|The allocatable CPU of a node that is available for scheduling.|int|-|
|`cpu_capacity`|The CPU capacity of a node.|int|-|
|`ephemeral_storage_allocatable`|The allocatable ephemeral-storage of a node that is available for scheduling.|int|-|
|`ephemeral_storage_capacity`|The ephemeral-storage capacity of a node.|int|-|
|`memory_allocatable`|The allocatable memory of a node that is available for scheduling.|int|-|
|`memory_capacity`|The memory capacity of a node.|int|-|
|`pods_allocatable`|The allocatable pods of a node that is available for scheduling.|int|-|
|`pods_capacity`|The pods capacity of a node.|int|-|


















### `kube_pod`

The metric of the Kubernetes Pod.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`pod`|Name must be unique within a namespace.|
|`pod_name`|Renamed from 'pod'.|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`uid`|The UID of pod.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`cpu_limit_millicores`|Max limits for CPU resources.|int|ms|
|`cpu_usage`|The sum of the cpu usage of all containers in this Pod.|float|percent|
|`cpu_usage_base100`|The normalized cpu usage, with a maximum of 100%. (Experimental)|float|percent|
|`cpu_usage_millicores`|Total CPU usage (sum of all cores) averaged over the sample window.|int|ms|
|`ephemeral_storage_available_bytes`|The storage space available (bytes) for the filesystem.|int|B|
|`ephemeral_storage_capacity_bytes`|The total capacity (bytes) of the filesystems underlying storage.|int|B|
|`ephemeral_storage_used_bytes`|The bytes used for a specific task on the filesystem.|int|B|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The sum of the memory limit of all containers in this Pod.|int|B|
|`mem_usage`|The sum of the memory usage of all containers in this Pod.|int|B|
|`mem_used_percent`|The percentage usage of the memory is calculated based on the capacity of host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of the memory is calculated based on the limit.|float|percent|
|`memory_capacity`|The total memory in the host machine (Deprecated use `mem_capacity`).|int|B|
|`memory_usage_bytes`|The sum of the memory usage of all containers in this Pod (Deprecated use `mem_usage`).|int|B|
|`memory_used_percent`|The percentage usage of the memory (refer from `mem_used_percent`|float|percent|
|`network_bytes_rcvd`|Cumulative count of bytes received.|int|B|
|`network_bytes_sent`|Cumulative count of bytes transmitted.|int|B|
|`ready`|Describes whether the pod is ready to serve requests.|int|count|
|`restarts`|The number of times the container has been restarted.|int|count|










### `kube_replicaset`

The metric of the Kubernetes ReplicaSet.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replica_set_name`|Name must be unique within a namespace. (Deprecated)|
|`replicaset_name`|Name must be unique within a namespace.|
|`uid`|The UID of ReplicaSet.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`fully_labeled_replicas`|The number of fully labeled replicas per ReplicaSet.|int|count|
|`replicas`|The most recently observed number of replicas.|int|count|
|`replicas_available`|The number of available replicas (ready for at least minReadySeconds) for this replica set.|int|count|
|`replicas_desired`|The number of desired replicas.|int|count|
|`replicas_ready`|The number of ready replicas for this replica set.|int|count|










### `kube_service`

The metric of the Kubernetes Service.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`service`|Name must be unique within a namespace.|
|`uid`|The UID of Service|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`ports`|Total number of ports that are exposed by this service.|int|count|










### `kube_statefulset`

The metric of the Kubernetes StatefulSet.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`statefulset`|Name must be unique within a namespace.|
|`uid`|The UID of StatefulSet.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`replicas`|The number of Pods created by the StatefulSet controller.|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this StatefulSet.|int|count|
|`replicas_current`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.|int|count|
|`replicas_desired`|The desired number of replicas of the given Template.|int|count|
|`replicas_ready`|The number of pods created for this StatefulSet with a Ready Condition.|int|count|
|`replicas_updated`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.|int|count|








## 对象 {#object}









### `docker_containers`

The object of containers, only supported Running status.

- 标签


| Tag | Description |
|  ----  | --------|
|`aws_ecs_cluster_name`|Cluster name of the AWS ECS.|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`container_runtime`|Container runtime (this container from Docker/Containerd/cri-o).|
|`container_runtime_name`|Container name from runtime (like 'docker ps'). If empty then use 'unknown'.|
|`container_runtime_version`|Container runtime version.|
|`container_type`|The type of the container (this container is created by Kubernetes/Docker/Containerd/cri-o).|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`image`|The full name of the container image, example `nginx.org/nginx:1.21.0`.|
|`image_name`|The name of the container image, example `nginx.org/nginx`.|
|`image_short_name`|The short name of the container image, example `nginx`.|
|`image_tag`|The tag of the container image, example `1.21.0`.|
|`name`|The ID of the container.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`pod_uid`|The pod uid of the container (label `io.kubernetes.pod.uid`).|
|`state`|The state of the Container (only Running).|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`status`|The status of the container，example `Up 5 hours`.|
|`task_arn`|The task arn of the AWS Fargate.|
|`task_family`|The task family of the AWS fargate.|
|`task_version`|The task version of the AWS fargate.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`block_read_byte`|Total number of bytes read from the container file system (only supported docker).|int|B|
|`block_write_byte`|Total number of bytes wrote to the container file system (only supported docker).|int|B|
|`cpu_numbers`|The number of the CPU core.|int|count|
|`cpu_usage`|The percentage usage of CPU on system host.|float|percent|
|`cpu_usage_base100`|The normalized cpu usage, with a maximum of 100%.|float|percent|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The limit memory in the container.|int|B|
|`mem_usage`|The usage of the memory.|int|B|
|`mem_used_percent`|The percentage usage of the memory is calculated based on the capacity of host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of the memory is calculated based on the limit.|float|percent|
|`network_bytes_rcvd`|Total number of bytes received from the network (only count the usage of the main process in the container, excluding loopback).|int|B|
|`network_bytes_sent`|Total number of bytes send to the network (only count the usage of the main process in the container, excluding loopback).|int|B|


















### `kubernetes_cron_jobs`

The object of the Kubernetes CronJob.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`cron_job_name`|Name must be unique within a namespace.|
|`name`|The UID of CronJob.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of CronJob.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active_jobs`|The number of pointers to currently running jobs.|int|count|
|`age`|Age (seconds)|int|s|
|`message`|Object details|string|-|
|`schedule`|The schedule in Cron format, see [doc](https://en.wikipedia.org/wiki/Cron){:target="_blank"}|string|-|
|`suspend`|This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.|bool|-|










### `kubernetes_daemonset`

The object of the Kubernetes DaemonSet.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset_name`|Name must be unique within a namespace.|
|`name`|The UID of DaemonSet.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of DaemonSet.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`daemons_available`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`message`|Object details|string|-|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count|










### `kubernetes_deployments`

The object of the Kubernetes Deployment.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`deployment_name`|Name must be unique within a namespace.|
|`name`|The UID of Deployment.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Deployment.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment. (Deprecated)|int|count|
|`max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. (Deprecated)|int|count|
|`max_unavailable`|The maximum number of pods that can be unavailable during the update. (Deprecated)|int|count|
|`message`|Object details|string|-|
|`paused`|Indicates that the deployment is paused (true or false).|bool|-|
|`ready`|The number of pods targeted by this Deployment with a Ready Condition. (Deprecated)|int|count|
|`replicas`|Total number of non-terminated pods targeted by this deployment (their labels match the selector).|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|count|
|`replicas_desired`|Number of desired pods for a Deployment.|int|count|
|`replicas_ready`|The number of pods targeted by this Deployment with a Ready Condition.|int|count|
|`replicas_unavailable`|Total number of unavailable pods targeted by this deployment.|int|count|
|`replicas_updated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|count|
|`rollingupdate_max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. |int|count|
|`rollingupdate_max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|
|`strategy`|Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.|string|-|
|`unavailable`|Total number of unavailable pods targeted by this deployment. (Deprecated)|int|count|
|`up_dated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec. (Deprecated)|int|count|










### `kubernetes_dfpv`

The object of the Kubernetes PersistentVolume.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The dfpv name, consists of pvc name and pod name|
|`namespace`|The namespace of Pod and PVC.|
|`node_name`|Reference to the Node.|
|`pod_name`|Reference to the Pod.|
|`pvc_name`|Reference to the PVC.|
|`volume_mount_name`|The name given to the Volume.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`available`|AvailableBytes represents the storage space available (bytes) for the filesystem.|int|B|
|`capacity`|CapacityBytes represents the total capacity (bytes) of the filesystems underlying storage.|int|B|
|`inodes`|Inodes represents the total inodes in the filesystem.|int|count|
|`inodes_free`|InodesFree represents the free inodes in the filesystem.|int|count|
|`inodes_used`|InodesUsed represents the inodes used by the filesystem.|int|count|
|`message`|Object details|string|-|
|`used`|UsedBytes represents the bytes used for a specific task on the filesystem.|int|B|


















### `kubernetes_jobs`

The object of the Kubernetes Job.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`job_name`|Name must be unique within a namespace.|
|`name`|The UID of Job.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`uid`|The UID of Job.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`active`|The number of actively running pods.|int|count|
|`active_deadline`|Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it|int|s|
|`age`|Age (seconds)|int|s|
|`backoff_limit`|Specifies the number of retries before marking this job failed.|int|count|
|`completions`|Specifies the desired number of successfully finished pods the job should be run with.|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`message`|Object details|string|-|
|`parallelism`|Specifies the maximum desired number of pods the job should run at any given time.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count|










### `kubernetes_nodes`

The object of the Kubernetes Node.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`internal_ip`|Node internal IP|
|`name`|The UID of Node.|
|`node_name`|Name must be unique within a namespace.|
|`role`|Node role. (master/node)|
|`status`|NodePhase is the recently observed lifecycle phase of the node. (Pending/Running/Terminated)|
|`uid`|The UID of Node.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`kubelet_version`|Kubelet Version reported by the node.|string|-|
|`message`|Object details|string|-|
|`node_ready`|NodeReady means kubelet is healthy and ready to accept pods (true/false/unknown)|string|-|
|`unschedulable`|Unschedulable controls node schedulability of new pods (yes/no).|string|-|






### `kubernetes_persistentvolumes`

The object of the Kubernetes PersistentVolume.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of PersistentVolume.|
|`persistentvolume_name`|The name of PersistentVolume|
|`uid`|The UID of PersistentVolume.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`claimRef_name`|Name of the bound PersistentVolumeClaim.|string|-|
|`claimRef_namespace`|Namespace of the PersistentVolumeClaim.|string|-|
|`message`|Object details|string|-|
|`phase`|The phase indicates if a volume is available, bound to a claim, or released by a claim.(Pending/Available/Bound/Released/Failed)|string|-|






### `kubernetes_persistentvolumeclaims`

The object of the Kubernetes PersistentVolumeClaim.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of PersistentVolume.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`persistentvolumeclaim_name`|Name must be unique within a namespace.|
|`uid`|The UID of PersistentVolume.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`message`|Object details|string|-|
|`phase`|The phase indicates if a volume is available, bound to a claim, or released by a claim.(Pending/Bound/Lost)|string|-|
|`storage_class_name`|StorageClassName is the name of the StorageClass required by the claim.|string|-|
|`volume_mode`|VolumeMode defines what type of volume is required by the claim.(Block/Filesystem)|string|-|
|`volume_name`|VolumeName is the binding reference to the PersistentVolume backing this claim.|string|-|










### `kubelet_pod`

The object of the Kubernetes Pod.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`name`|The UID of Pod.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`phase`|The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle.(Pending/Running/Succeeded/Failed/Unknown)|
|`pod_name`|Name must be unique within a namespace.|
|`qos_class`|The Quality of Service (QOS) classification assigned to the pod based on resource requirements|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`status`|Reason the container is not yet running.|
|`uid`|The UID of Pod.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|Number of containers|int|count|
|`cpu_limit_millicores`|Max limits for CPU resources.|int|ms|
|`cpu_usage`|The sum of the cpu usage of all containers in this Pod.|float|percent|
|`cpu_usage_base100`|The normalized cpu usage, with a maximum of 100%. (Experimental)|float|percent|
|`cpu_usage_millicores`|Total CPU usage (sum of all cores) averaged over the sample window.|int|ms|
|`mem_capacity`|The total memory in the host machine.|int|B|
|`mem_limit`|The sum of the memory limit of all containers in this Pod.|int|B|
|`mem_usage`|The sum of the memory usage of all containers in this Pod.|int|B|
|`mem_used_percent`|The percentage usage of the memory is calculated based on the capacity of host machine.|float|percent|
|`mem_used_percent_base_limit`|The percentage usage of the memory is calculated based on the limit.|float|percent|
|`memory_capacity`|The total memory in the host machine (Deprecated use `mem_capacity`).|int|B|
|`memory_usage_bytes`|The sum of the memory usage of all containers in this Pod (Deprecated use `mem_usage`).|int|B|
|`memory_used_percent`|The percentage usage of the memory (refer from `mem_used_percent`|float|percent|
|`message`|Object details|string|-|
|`ready`|Describes whether the pod is ready to serve requests.|int|count|
|`restarts`|The number of times the container has been restarted.|int|count|










### `kubernetes_replica_sets`

The object of the Kubernetes ReplicaSet.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`name`|The UID of ReplicaSet.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replica_set_name`|Name must be unique within a namespace. (Deprecated)|
|`replicaset_name`|Name must be unique within a namespace.|
|`statefulset`|The name of the StatefulSet which the object belongs to.|
|`uid`|The UID of ReplicaSet.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`available`|The number of available replicas (ready for at least minReadySeconds) for this replica set. (Deprecated)|int|-|
|`message`|Object details|string|-|
|`ready`|The number of ready replicas for this replica set. (Deprecated)|int|-|
|`replicas`|The most recently observed number of replicas.|int|count|
|`replicas_available`|The number of available replicas (ready for at least minReadySeconds) for this replica set.|int|count|
|`replicas_desired`|The number of desired replicas.|int|count|
|`replicas_ready`|The number of ready replicas for this replica set.|int|count|










### `kubernetes_services`

The object of the Kubernetes Service.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of Service|
|`namespace`|Namespace defines the space within each name must be unique.|
|`service_name`|Name must be unique within a namespace.|
|`type`|Type determines how the Service is exposed. Defaults to ClusterIP. (ClusterIP/NodePort/LoadBalancer/ExternalName)|
|`uid`|The UID of Service|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`cluster_ip`|ClusterIP is the IP address of the service and is usually assigned randomly by the master.|string|-|
|`external_ips`|ExternalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.|string|-|
|`external_name`|ExternalName is the external reference that kubedns or equivalent will return as a CNAME record for this service.|string|-|
|`external_traffic_policy`|ExternalTrafficPolicy denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints.|string|-|
|`message`|Object details|string|-|
|`session_affinity`|Supports "ClientIP" and "None".|string|-|










### `kubernetes_statefulsets`

The object of the Kubernetes StatefulSet.

- 标签


| Tag | Description |
|  ----  | --------|
|`cluster_name_k8s`|K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.|
|`name`|The UID of StatefulSet.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`statefulset_name`|Name must be unique within a namespace.|
|`uid`|The UID of StatefulSet.|

- 指标列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`age`|Age (seconds)|int|s|
|`message`|Object details|string|-|
|`replicas`|The number of Pods created by the StatefulSet controller.|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this StatefulSet.|int|count|
|`replicas_current`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by currentRevision.|int|count|
|`replicas_desired`|The desired number of replicas of the given Template.|int|count|
|`replicas_ready`|The number of pods created for this StatefulSet with a Ready Condition.|int|count|
|`replicas_updated`|The number of Pods created by the StatefulSet controller from the StatefulSet version indicated by updateRevision.|int|count|




## 日志 {#logging}













### `Use Logging Source`

The logging of the container.

- 标签


| Tag | Description |
|  ----  | --------|
|`container_id`|Container ID|
|`container_name`|Container name from k8s (label `io.kubernetes.container.name`). If empty then use $container_runtime_name.|
|`daemonset`|The name of the DaemonSet which the object belongs to.|
|`deployment`|The name of the Deployment which the object belongs to.|
|`namespace`|The namespace of the container (label `io.kubernetes.pod.namespace`).|
|`pod_name`|The pod name of the container (label `io.kubernetes.pod.name`).|
|`service`|The name of the service, if `service` is empty then use `source`.|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`log_read_lines`|The lines of the read file ([:octicons-tag-24: Version-1.4.6](../datakit/changelog.md#cl-1.4.6)).|int|count|
|`log_read_offset`|The offset of the read file ([:octicons-tag-24: Version-1.4.8](../datakit/changelog.md#cl-1.4.8) · [:octicons-beaker-24: Experimental](../datakit/index.md#experimental)).|int|-|
|`log_read_time`|The timestamp of the read file.|s|-|
|`message`|The text of the logging.|string|-|
|`message_length`|The length of the message content.|B|count|
|`status`|The status of the logging, only supported `info/emerg/alert/critical/error/warning/debug/OK/unknown`.|string|-|














































### `kubernetes_events`

The logging of the Kubernetes Event.

- 标签


| Tag | Description |
|  ----  | --------|
|`reason`|This should be a short, machine understandable string that gives the reason, for the transition into the object's current status.|
|`type`|Type of this event.|
|`uid`|The UID of event.|

- 字段列表


| Metric | Description | Type | Unit |
| ---- |---- | :---:    | :----: |
|`involved_kind`|Kind of the referent for involved object.|string|-|
|`involved_name`|Name must be unique within a namespace for involved object.|string|-|
|`involved_namespace`|Namespace defines the space within which each name must be unique for involved object.|string|-|
|`involved_uid`|The UID of involved object.|string|-|
|`message`|Details of event log|string|-|



























































<!-- markdownlint-enable -->

## 联动 Dataway Sink 功能 {#link-dataway-sink}

Dataway Sink [详见文档](../deployment/dataway-sink.md)。

所有的 Kubernetes 资源采集，都会添加与 CustomerKey 匹配的 Label。例如 CustomerKey 是 `name`，DaemonSet、Deployment、Pod 等资源，会在自己当前的 Labels 中找到 `name`，并将其添加到 tags。

容器会添加其所属 Pod 的 Customer Labels。


## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: NODE_LOCAL 需要新的权限 {#rbac-nodes-stats}
<!-- markdownlint-enable -->

`ENV_INPUT_CONTAINER_ENABLE_K8S_NODE_LOCAL` 模式只推荐 DaemonSet 部署时使用，该模式需要访问 kubelet，所以需要在 RBAC 添加 `nodes/stats` 权限。例如：

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups: [""]
  resources: ["nodes", "nodes/stats"]
  verbs: ["get", "list", "watch"]
```

此外，Datakit Pod 还需要开启 `hostNetwork: true` 配置项。

<!-- markdownlint-disable MD013 -->
### :material-chat-question: 采集 PersistentVolumes 和 PersistentVolumeClaims 需要新的权限 {#rbac-pv-pvc}
<!-- markdownlint-enable -->

Datakit 在 1.25.0[:octicons-tag-24: Version-1.25.0](../datakit/changelog.md#cl-1.25.0) 版本支持采集 Kubernetes PersistentVolume 和 PersistentVolumeClaim 的对象数据，采集这两种资源需要新的 RBAC 权限，详细见下：

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups: [""]
  resources: ["persistentvolumes", "persistentvolumeclaims"]
  verbs: ["get", "list", "watch"]
```

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Kubernetes YAML 敏感字段屏蔽 {#yaml-secret}
<!-- markdownlint-enable -->

Datakit 会采集 Kubernetes Pod 或 Service 等资源的 yaml 配置，并存储到对象数据的 `yaml` 字段中。如果该 yaml 中包含敏感数据（例如密码），Datakit 暂不支持手动配置屏蔽敏感字段，推荐使用 Kubernetes 官方的做法，即使用 ConfigMap 或者 Secret 来隐藏敏感字段。

例如，现在需要在 env 中添加一份密码，正常情况下是这样：

```yaml
    containers:
    - name: mycontainer
      image: redis
      env:
        - name: SECRET_PASSWORD
      value: password123
```

在编排 yaml 配置会将密码明文存储，这是很不安全的。可以使用 Kubernetes Secret 实现隐藏，方法如下：

创建一个 Secret：

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysecret
type: Opaque
data:
  username: username123
  password: password123
```

执行：

```shell
kubectl apply -f mysecret.yaml
```

在 env 中使用 Secret：

```yaml
    containers:
    - name: mycontainer
      image: redis
      env:
        - name: SECRET_PASSWORD
      valueFrom:
          secretKeyRef:
            name: mysecret
            key: password
            optional: false
```

详见[官方文档](https://kubernetes.io/zh-cn/docs/concepts/configuration/secret/#using-secrets-as-environment-variables){:target="_blank"}。

## 延伸阅读 {#more-reading}

- [eBPF 采集器：支持容器环境下的流量采集](ebpf.md)
- [正确使用正则表达式来配置](../datakit/datakit-input-conf.md#debug-regex)
- [Kubernetes 下 DataKit 的几种配置方式](../datakit/k8s-config-how-to.md)
