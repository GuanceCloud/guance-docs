
# 容器数据采集
---

:fontawesome-brands-linux: :material-kubernetes: :material-docker:

---

采集 container 和 Kubernetes 的指标、对象和日志数据，上报到观测云。

## 前置条件 {#requrements}

- 目前 container 会默认连接 Docker 服务，需安装 Docker v17.04 及以上版本。
- 采集 Kubernetes 数据需要 DataKit 以 [DaemonSet 方式部署](datakit-daemonset-deploy.md)。
- 采集 Kubernetes Pod 指标数据，[需要 Kubernetes 安装 Metrics-Server 组件](https://github.com/kubernetes-sigs/metrics-server#installation){:target="_blank"}。

## 配置 {#config}

=== "主机安装"

    如果是纯 Docker 或 Containerd 环境，那么 DataKit 只能安装在宿主机上。
    
    进入 DataKit 安装目录下的 *conf.d/container* 目录，复制 *container.conf.sample* 并命名为 *container.conf*。示例如下：
    
    ``` toml
        
    [inputs.container]
      docker_endpoint = "unix:///var/run/docker.sock"
      containerd_address = "/var/run/containerd/containerd.sock"
    
      enable_container_metric = true
      enable_k8s_metric = true
      enable_pod_metric = true
      extract_k8s_label_as_tags = false
      auto_discovery_of_k8s_service_prometheus = false
    
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
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    
    ```
    
=== "Kubernetes"

    Kubernetes 中容器采集器一般默认自动开启，无需通过 *container.conf* 来配置。但可以通过如下环境变量来调整配置参数：
    
    | 环境变量名                                                       | 配置项含义                                                                     | 默认值                                            | 参数示例（yaml 配置时需要用英文双引号括起来）                                    |
    | ----:                                                            | ----:                                                                          | ----:                                             | ----                                                                             |
    | `ENV_INPUT_CONTAINER_DOCKER_ENDPOINT`                            | 指定 Docker Engine 的 enpoint                                                  | "unix:///var/run/docker.sock"                     | `"unix:///var/run/docker.sock"`                                                  |
    | `ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS`                         | 指定 Containerd 的 endpoint                                                    | "/var/run/containerd/containerd.sock"             | `"/var/run/containerd/containerd.sock"`                                          |
    | `ENV_INPUT_CONTIANER_EXCLUDE_PAUSE_CONTAINER`                    | 是否忽略 k8s 的 pause 容器                                                     | true                                              | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_ENABLE_CONTAINER_METRIC`                    | 开启容器指标采集                                                               | true                                              | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_ENABLE_K8S_METRIC`                          | 开启 k8s 指标采集                                                              | true                                              | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS`                  | 是否追加 pod label 到采集的指标 tag 中                                         | false                                             | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_AUTO_DISCOVERY_OF_K8S_SERVICE_PROMETHEUS`   | 是否开启自动发现 k8s Service promtheus 并采集指标                              | false                                             | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_ENABLE_POD_METRIC`                          | 开启 Pod 指标采集                                                              | true                                              | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG`                      | 容器日志的 include 条件，使用 image 过滤                                       | 无                                                | `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`                                  |
    | `ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG`                      | 容器日志的 exclude 条件，使用 image 过滤                                       | 无                                                | `"image:pubrepo.jiagouyun.com/datakit/logfwd*"`                                  |
    | `ENV_INPUT_CONTAINER_KUBERNETES_URL`                             | k8s api-server 访问地址                                                        | "https://kubernetes.default:443"                  | `"https://kubernetes.default:443"`                                               |
    | `ENV_INPUT_CONTAINER_BEARER_TOKEN`                               | 访问 k8s api-server 所需的 token 文件路径                                      | "/run/secrets/kubernetes.io/serviceaccount/token" | `"/run/secrets/kubernetes.io/serviceaccount/token"`                              |
    | `ENV_INPUT_CONTAINER_BEARER_TOKEN_STRING`                        | 访问 k8s api-server  所需的 token 字符串                                       | 无                                                | `"<your-token-string>"`                                                          |
    | `ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES`           | 日志采集删除包含的颜色字符                                                     | false                                             | `"true"`/`"false"`                                                               |
    | `ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP`                   | 日志采集配置额外的 source 匹配，符合正则的 source 会被改名                     | 无                                                | `"source_regex*=new_source,regex*=new_source2"`  以英文逗号分割的多个"key=value" |
    | `ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON`          | 日志采集针对 source 的多行配置，可以使用 source 自动选择多行                   | 无                                                | `'{"source_nginx":"^\\d{4}", "source_redis":"^[A-Za-z_]"}'` JSON 格式的 map      |
    | `ENV_INPUT_CONTAINER_LOGGING_BLOCKING_MODE`                      | 日志采集是否开启阻塞模式，数据发送失败会持续尝试，直到发送成功才再次采集       | true                                              | `"true"/"false"`                                                                 |
    | `ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_DETECTION`           | 日志采集是否开启自动多行模式，开启后会在 patterns 列表中匹配适用的多行规则     | true                                              | `"true"/"false"`                                                                 |
    | `ENV_INPUT_CONTAINER_LOGGING_AUTO_MULTILINE_EXTRA_PATTERNS_JSON` | 日志采集的自动多行模式 pattens 列表，支持手动配置多个多行规则                  | 默认规则详见[文档](logging.md#auto-multiline)     | `'["^\\d{4}-\\d{2}", "^[A-Za-z_]"]'` JSON 格式的字符串数组                       |
    | `ENV_INPUT_CONTAINER_LOGGING_MIN_FLUSH_INTERVAL`                 | 日志采集的最小上传间隔，如果在此期间没有新数据，将清空和上传缓存数据，避免堆积 | "5s"                                              | `"10s"`                                                                          |
    | `ENV_INPUT_CONTAINER_LOGGING_MAX_MULTILINE_LIFE_DURATION`        | 日志采集的单次多行最大生命周期，此周期结束将清空和上传现存的多行数据，避免堆积 | "3s"                                              | `"5s"`                                                                           |
    | `ENV_INPUT_CONTAINER_TAGS`                                       | 添加额外 tags                                                                  | 无                                                | `"tag1=value1,tag2=value2"`       以英文逗号分割的多个"key=value"                |

    环境变量额外说明：
    
    - ENV_INPUT_CONTAINER_TAGS：如果配置文件（*container.conf*）中有同名 tag，将会被这里的配置覆盖掉。
    
    - ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP：指定替换 source，参数格式是 `正则表达式=new_source`，当某个 source 能够匹配正则表达式，则这个 source 会被 new_source 替换。如果能够替换成功，则不再使用 `annotations/labels` 中配置的 source（[:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)）。如果要做到精确匹配，需要使用 `^` 和 `$` 将内容括起来。比如正则表达式写成 `datakit`，不仅可以匹配 `datakit` 字样，还能匹配到 `datakit123`；写成 `^datakit$` 则只能匹配到的 `datakit`。
    
    - ENV_INPUT_CONTAINER_LOGGING_SOURCE_MULTILINE_MAP_JSON：用来指定 source 到多行配置的映射，如果某个日志没有配置 `multiline_match`，就会根据它的 source 来此处查找和使用对应的 `multiline_match`。因为 `multiline_match` 值是正则表达式较为复杂，所以 value 格式是 JSON 字符串，可以使用 [json.cn](https://www.json.cn/){:target="_blank"} 辅助编写并压缩成一行
    k8s 数据的 `cluster_name` 字段可能会为空，为此提供注入环境变量的方式，取值优先级依次为：
    
        - k8s 集群返回的 ClusterName 值（不为空）
        - 环境变量 `ENV_K8S_CLUSTER_NAME` 指定的值
        - 默认值 `kubernetes`。

???+ attention

    - 对象数据采集间隔是 5 分钟，指标数据采集间隔是 20 秒，暂不支持配置
    - 采集到的日志, 单行（包括经过 `multiline_match` 处理后）最大长度为 32MB，超出部分会被截断且丢弃

#### Docker 和 Containerd sock 文件配置 {#docker-containerd-sock}

如果 Docker 或 Containerd 的 sock 路径不是默认的，则需要指定一下 sock 文件路径，根据 DataKit 不同部署方式，其方式有所差别，以 Containerd 为例：

=== "主机部署"

    修改 container.conf 的 `containerd_address` 配置项，将其设置为对应的 sock 路径。

=== "Kubernetes"

    更改 datakit.yaml 的 volumes `containerd-socket`，将新路径 mount 到 DataKit 中，同时配置环境变量 `ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS`：

    ``` yaml hl_lines="3 4 7 14"
    # 添加 env
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINERD_ADDRESS
        value: /path/to/new/containerd/containerd.sock
    
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
---

## 日志采集 {#logging-config}

容器/Pod 上的日志采集，相比主机上的日志采集，有很大的不同，其配置方式、采集机制都有差异。目前可以通过如下几个角度来控制容器环境下的日志采集：

- 通过 Pod/容器 *镜像特征* 来配置日志采集
- 通过 Annotation/Label 来标注特定 Pod/容器的日志采集

### 根据容器 image 来调整日志采集 {#logging-with-image-config}

默认情况下，DataKit 会收集所在机器/Node 上所有容器/Pod 的 stdout/stderr 日志，这可能不是大家的预期行为。某些时候，我们希望只采集（或不采集）部分容器/Pod 的日志，这里可以通过镜像名称来间接指代目标容器/Pod。

=== "主机安装"

    ``` toml
    ## 当容器的 image 能够匹配 `hello*` 时，会采集此容器的日志
    container_include_logging = ["image:hello*"]
    ## 忽略所有容器
    container_exclude_logging = ["image:*"]
    ```
    
    - `container_include` 和 `container_exclude` 必须以 `image` 开头，格式为一种[类正则的 Glob 通配](https://en.wikipedia.org/wiki/Glob_(programming)){:target="_blank"}： `"image:<glob规则>"`
    
=== "Kubernetes"

    可通过如下环境变量 

    - ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
    - ENV_INPUT_CONTAINER_CONTAINER_EXCLUDE_LOG

    来配置容器的日志采集。假设有 3 个 Pod，其 image 分别是：

    - A：`hello/hello-http:latest`
    - B：`world/world-http:latest`
    - C：`registry.jiagouyun.com/datakit/datakit:1.2.0`

    如果只希望采集 Pod A 的日志，那么配置 ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG 即可：

    ``` yaml
    - env:
      - name: ENV_INPUT_CONTAINER_CONTAINER_INCLUDE_LOG
        value: image:hello*  # 指定镜像名或其通配
    ```

???+ tip "如何查看镜像"
    
    Docker：

    ``` shell
    docker inspect --format "{{.Config.Image}}" $CONTAINER_ID
    ```

    Kubernetes Pod：
    
    ``` shell
    echo `kubectl get pod -o=jsonpath="{.items[0].spec.containers[0].image}"`
    ```

### 通过 Annotation/Label 调整容器日志采集 {#logging-with-annotation-or-label}

通过镜像只能大概配置日志采集（或不采集）的目标容器/Pod，更高级一些的配置则需要在容器/Pod 上追加对应的标注，通过这种定向的标注，可以用来配置诸如日志来源、多行配置、Pipeline 切割等功能。

在容器 Label 或 Pod yaml 中，标注有特定的 Key（`datakit/logs`），其 Value 是一个 JSON 字符串，示例如下：

``` json
[
  {
    "disable"  : false,
    "source"   : "testing-source",
    "service"  : "testing-service",
    "pipeline" : "test.p",

    # 用法和上文的 `根据 image 过滤容器` 完全相同，`image:` 后面填写正则表达式
    "only_images"  : ["image:<your_image_regexp>"],

    "multiline_match" : "^\\d{4}-\\d{2}",

    # 可以给该容器/Pod 日志打上额外的标签
    "tags" : {
      "some_tag" : "some_value",
      "more_tag" : "some_other_value"
    }
  }
]
```

Value 字段说明：

| 字段名            | 必填 | 取值             | 默认值 | 说明                                                                                                                                                             |
| -----             | ---- | ----             | ----   | ----                                                                                                                                                             |
| `disable`         | N    | true/false       | false  | 是否禁用该 pod/容器的日志采集                                                                                                                                    |
| `source`          | N    | 字符串           | 无     | 日志来源，参见[容器日志采集的 source 设置](container.md#config-logging-source)                                                                                   |
| `service`         | N    | 字符串           | 无     | 日志隶属的服务，默认值为日志来源（source）                                                                                                                       |
| `pipeline`        | N    | 字符串           | 无     | 适用该日志的 Pipeline 脚本，默认值为与日志来源匹配的脚本名（`<source>.p`）                                                                                       |
| `only_images`     | N    | 字符串数组       | 无     | 针对 Pod 内部多容器情景，如果填写了任何 image 通配，则只采集能匹配这些 image 的容器的日志，类似白名单功能；如果字段为空，即认为采集该 Pod 中所有容器的日志       |
| `multiline_match` | N    | 正则表达式字符串 | 无     | 用于[多行日志匹配](logging.md#multiline)时的首行识别，例如 `"multiline_match":"^\\d{4}"` 表示行首是4个数字，在正则表达式规则中`\d` 是数字，前面的 `\` 是用来转义 |
| `tags`            | N    | key/value 键值对 | 无     | 添加额外的 tags，如果已经存在同名的 key 将以此为准（[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) ）                                       |

#### 配置示例 {#logging-annotation-label-example}

可以通过配置容器的 Label 或 Pod 的 Annotation 来指定日志采集配置。

=== "Docker"

    Docker 容器添加 Label 的方法，参见[这里](https://docs.docker.com/engine/reference/commandline/run/#set-metadata-on-container--l---label---label-file){:target="_blank"}。

=== "Kubernetes"

    在 Kubernetes 可以在创建 Deployment 时，以 `template` 模式添加 Pod Annotation，例如：
    
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: testing-log-deployment
      labels:
        app: testing-log
    spec:
      template:
        metadata:
          labels:
            app: testing-log
          annotations:
            datakit/logs: |
              [
                {
                  "disable": false,
                  "source": "testing-source",
                  "service": "testing-service",
                  "pipeline": "test.p",
                  "multiline_match": "^\\d{4}-\\d{2}",
                  "only_images": ["image:.*nginx.*", "image:.*my_app.*"],
                  "tags" : {
                    "some_tag" : "some_value"
                  }
                }
              ]
    ```

???+ attention

    - 如无必要，不要轻易在 Annotation/Label 中配置 pipeline，一般情况下，通过 `source` 字段自动推导即可。
    - 如果是在配置文件或终端命令行添加 Labels/Annotations，两边是英文状态双引号，需要添加转义字符。

    `multiline_match` 的值是双重转义，4 根斜杠才能表示实际的 1 根，例如 `\"multiline_match\":\"^\\\\d{4}\"` 等价 `"multiline_match":"^\d{4}"`，示例：

    ```shell
    kubectl annotate pods my-pod datakit/logs="[{\"disable\":false,\"source\":\"testing-source\",\"service\":\"testing-service\",\"pipeline\":\"test.p\",\"only_images\":[\"image:<your_image_regexp>\"],\"multiline_match\":\"^\\\\d{4}-\\\\d{2}\"}]"
    ``` 

### 采集 Pod 内部日志 {#logging-with-sidecar-config}

如果 Pod 日志并未打到 stdout，则可以通过 Sidecar 形式可以采集 Pod 内部日志，参见[这里](logfwd.md)。

## 指标采集 {#metric-config}

由于指标数据量巨大，故指标采集默认是关闭的，可手动开启。

=== "Docker"
    
    进入 DataKit 安装目录下的 `conf.d/container` 目录，编辑 `container.conf`。修改指标采集配置：

    ```toml
    enable_container_metric = true
    ```

=== "Kubernetes"

    如果如下几个环境变量来配置 Kubernetes 中的指标采集，将它们设置为 "true" 即可开启对应的指标采集：

    - ENV_INPUT_CONTAINER_ENABLE_K8S_METRIC
    - ENV_INPUT_CONTAINER_ENABLE_POD_METRIC
    - ENV_INPUT_CONTAINER_ENABLE_CONTAINER_METRIC

### Prometheuse Exporter 指标采集 {#k8s-prom-exporter}

如果 Pod/容器有暴露 Prometheuse 指标，有两种方式可以采集，参见[这里](kubernetes-prom.md)

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.container.tags]` 指定其它标签：

```toml
 [inputs.container.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

### 指标 {#metrics}













#### `docker_containers`

容器指标数据，只采集正在运行的容器

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`container_id`|容器 ID|
|`container_name`|k8s 命名的容器名（在 labels 中取 'io.kubernetes.container.name'），如果值为空则跟 container_runtime_name 相同|
|`container_runtime_name`|由 runtime 命名的容器名（例如 docker ps 查看），如果值为空则默认是 unknown（[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)）|
|`container_type`|容器类型，表明该容器由谁创建，kubernetes/docker/containerd|
|`deployment`|deployment 名称（容器由 k8s 创建时存在，containerd 缺少此字段）|
|`docker_image`|镜像全称，例如 `nginx.org/nginx:1.21.0` （Depercated, use image）|
|`image`|镜像全称，例如 `nginx.org/nginx:1.21.0`|
|`image_name`|镜像名称，例如 `nginx.org/nginx`|
|`image_short_name`|镜像名称精简版，例如 `nginx`|
|`image_tag`|镜像 tag，例如 `1.21.0`|
|`linux_namespace`|该容器所在的 [linux namespace](https://man7.org/linux/man-pages/man7/namespaces.7.html)|
|`namespace`|pod 的 k8s 命名空间（k8s 创建容器时，会打上一个形如 'io.kubernetes.pod.namespace' 的 label，DataKit 将其命名为 'namespace'）|
|`pod_name`|pod 名称（容器由 k8s 创建时存在）|
|`state`|运行状态，running（containerd 缺少此字段）|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`block_read_byte`|从容器文件系统读取的总字节数（containerd 缺少此字段）|int|B|
|`block_write_byte`|向容器文件系统写入的总字节数（containerd 缺少此字段）|int|B|
|`cpu_delta`|容器 CPU 增量（containerd 缺少此字段）|int|ns|
|`cpu_numbers`|CPU 核心数（containerd 缺少此字段）|int|count|
|`cpu_system_delta`|系统 CPU 增量，仅支持 Linux（containerd 缺少此字段）|int|ns|
|`cpu_usage`|CPU 占主机总量的使用率|float|percent|
|`mem_failed_count`|内存分配失败的次数（containerd 缺少此字段）|int|B|
|`mem_limit`|内存可用总量，如果未对容器做内存限制，则为主机内存容量|int|B|
|`mem_usage`|内存使用量|int|B|
|`mem_used_percent`|内存使用率，使用量除以可用总量|float|percent|
|`network_bytes_rcvd`|从网络接收到的总字节数（containerd 缺少此字段）|int|B|
|`network_bytes_sent`|向网络发送出的总字节数（containerd 缺少此字段）|int|B|










#### `kubernetes`

Kubernetes count 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`namespace`|namespace|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`cluster_role`|RBAC cluster role count|int|-|
|`cronjob`|cronjob count|int|-|
|`deployment`|deployment count|int|-|
|`job`|job count|int|-|
|`node`|node count|int|-|
|`pod`|pod count|int|-|
|`replica_set`|replica_set count|int|-|
|`service`|service count|int|-|










#### `kube_cronjob`

Kubernetes cron job 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cronjob`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|Number of cronjobs|int|count|
|`duration_since_last_schedule`|The duration since the last time the cronjob was scheduled.|int|s|
|`spec_suspend`|This flag tells the controller to suspend subsequent executions.|bool|-|










#### `kube_daemonset`

Kubernetes Daemonset 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`daemonset`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|Number of daemonsets|int|count|
|`daemons_unavailable`|The number of nodes that should be running the daemon pod and have none of the daemon pod running and available (ready for at least spec.minReadySeconds).|int|count|
|`desired`|The total number of nodes that should be running the daemon pod (including nodes correctly running the daemon pod).|int|count|
|`misscheduled`|The number of nodes that are running the daemon pod, but are not supposed to run the daemon pod.|int|count|
|`ready`|The number of nodes that should be running the daemon pod and have one or more of the daemon pod running and ready.|int|count|
|`scheduled`|The number of nodes that are running at least one daemon pod and are supposed to run the daemon pod.|int|count|
|`updated`|The total number of nodes that are running updated daemon pod.|int|count|










#### `kube_deployment`

Kubernetes Deployment 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`deployment`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`condition`|The current status conditions of a deployment|int|count|
|`count`|Number of deployments|int|count|
|`paused`|Indicates that the deployment is paused (true or false).|bool|-|
|`replicas`|Total number of non-terminated pods targeted by this deployment (their labels match the selector).|int|count|
|`replicas_available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|count|
|`replicas_unavailable`|Total number of unavailable pods targeted by this deployment.|int|count|
|`replicas_updated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|count|
|`rollingupdate_max_surge`|The maximum number of pods that can be scheduled above the desired number of pods. |int|count|
|`rollingupdate_max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|






#### `kube_endpoint`

Kubernetes Endpoints 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`endpoint`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`address_available`|Number of addresses available in endpoint.|int|count|
|`address_not_ready`|Number of addresses not ready in endpoint.|int|count|
|`count`|Number of endpoints|int|count|










#### `kube_job`

Kubernetes Job 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`job`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`completion_failed`|The job has failed its execution.|int|count|
|`completion_succeeded`|The job has completed its execution.|int|count|
|`count`|Number of jobs|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count|










#### `kube_node`

Kubernetes Node 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`node`|Name must be unique within a namespace. (depercated)|
|`node_name`|Name must be unique within a namespace.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|The time in seconds since the creation of the node|int|s|
|`count`|Number of nodes|int|count|
|`cpu_allocatable`|The allocatable CPU of a node that is available for scheduling.|int|-|
|`cpu_capacity`|The CPU capacity of a node.|int|-|
|`ephemeral_storage_allocatable`|The allocatable ephemeral-storage of a node that is available for scheduling.|int|-|
|`memory_allocatable`|The allocatable memory of a node that is available for scheduling.|int|-|
|`memory_capacity`|The memory capacity of a node.|int|-|
|`pods_allocatable`|The allocatable pods of a node that is available for scheduling.|int|-|
|`pods_capacity`|The pods capacity of a node.|int|-|










#### `kube_pod`

Kubernetes pod 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`[POD_LABEL]`|The pod labels will be extracted as tags if `extract_k8s_label_as_tags` is enabled.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`pod`|Name must be unique within a namespace.|
|`pod_name`|Name must be unique within a namespace. (depercated)|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|Number of pods|int|count|
|`cpu_usage`|The percentage of cpu used|float|percent|
|`memory_usage_bytes`|The number of memory used in bytes|float|B|
|`ready`|Describes whether the pod is ready to serve requests.|int|count|










#### `kube_replicaset`

Kubernetes replicaset 指标数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`deployment`|The name of the deployment which the object belongs to.|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replica_set`|Name must be unique within a namespace.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`count`|Number of replicasets|int|count|
|`fully_labeled_replicas`|The number of fully labeled replicas per ReplicaSet.|int|count|
|`replicas`|Replicas is the most recently oberved number of replicas.|int|count|
|`replicas_desired`|Replicas is the number of desired replicas.|int|count|
|`replicas_ready`|The number of ready replicas for this replica set.|int|count|












### 对象 {#objects}

















#### `docker_containers`

容器对象数据，如果容器处于非 running 状态，则`cpu_usage`等指标将不存在

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`container_host`|容器内部的主机名（containerd 缺少此字段）|
|`container_id`|容器 ID|
|`container_name`|k8s 命名的容器名（在 labels 中取 'io.kubernetes.container.name'），如果值为空则跟 container_runtime_name 相同|
|`container_runtime_name`|由 runtime 命名的容器名（例如 docker ps 查看），如果值为空则默认是 unknown（[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)）|
|`container_type`|容器类型，表明该容器由谁创建，kubernetes/docker/containerd|
|`deployment`|deployment 名称（容器由 k8s 创建时存在）（containerd 缺少此字段）|
|`docker_image`|镜像全称，例如 `nginx.org/nginx:1.21.0` （Depercated, use image）|
|`image`|镜像全称，例如 `nginx.org/nginx:1.21.0`|
|`image_name`|镜像名称，例如 `nginx.org/nginx`|
|`image_short_name`|镜像名称精简版，例如 `nginx`|
|`image_tag`|镜像tag，例如 `1.21.0`|
|`linux_namespace`|该容器所在的 [linux namespace](https://man7.org/linux/man-pages/man7/namespaces.7.html){:target="_blank"}|
|`name`|对象数据的指定 ID|
|`namespace`|pod 的 k8s 命名空间（k8s 创建容器时，会打上一个形如 'io.kubernetes.pod.namespace' 的 label，DataKit 将其命名为 'namespace'）|
|`pod_name`|pod 名称（容器由 k8s 创建时存在）|
|`state`|运行状态，running/exited/removed（containerd 缺少此字段）|
|`status`|容器状态，例如 `Up 5 hours`（containerd 缺少此字段）|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|该容器创建时长，单位秒|int|s|
|`block_read_byte`|从容器文件系统读取的总字节数（containerd 缺少此字段）|int|B|
|`block_write_byte`|向容器文件系统写入的总字节数（containerd 缺少此字段）|int|B|
|`cpu_delta`|容器 CPU 增量（containerd 缺少此字段）|int|ns|
|`cpu_numbers`|CPU 核心数（containerd 缺少此字段）|int|count|
|`cpu_system_delta`|系统 CPU 增量，仅支持 Linux（containerd 缺少此字段）|int|ns|
|`cpu_usage`|CPU 占主机总量的使用率|float|percent|
|`from_kubernetes`|该容器是否由 Kubernetes 创建（deprecated）|bool|-|
|`mem_failed_count`|内存分配失败的次数（containerd 缺少此字段）|int|B|
|`mem_limit`|内存可用总量，如果未对容器做内存限制，则为主机内存容量|int|B|
|`mem_usage`|内存使用量|int|B|
|`mem_used_percent`|内存使用率，使用量除以可用总量|float|percent|
|`message`|容器对象详情|string|-|
|`network_bytes_rcvd`|从网络接收到的总字节数（containerd 缺少此字段）|int|B|
|`network_bytes_sent`|向网络发送出的总字节数（containerd 缺少此字段）|int|B|
|`process`|容器进程列表，即运行命令`ps -ef`所得，内容为 JSON 字符串，格式是 map 数组（containerd 缺少此字段）|string|-|










#### `kubernetes_cluster_roles`

Kubernetes cluster role 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`cluster_role_name`|Name must be unique within a namespace.|
|`name`|UID|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|age (seconds)|int|s|
|`create_time`|CreationTimestamp is a timestamp representing the server time when this object was created.(milliseconds)|int|sec|
|`message`|object details|string|-|










#### `kubernetes_cron_jobs`

Kubernetes cron job 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`cron_job_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`active_jobs`|The number of pointers to currently running jobs.|int|count|
|`age`|age (seconds)|int|s|
|`message`|object details|string|-|
|`schedule`|The schedule in Cron format, see https://en.wikipedia.org/wiki/Cron|string|-|
|`suspend`|This flag tells the controller to suspend subsequent executions, it does not apply to already started executions.|bool|-|










#### `kubernetes_deployments`

Kubernetes Deployment 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`deployment_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|age (seconds)|int|s|
|`available`|Total number of available pods (ready for at least minReadySeconds) targeted by this deployment.|int|-|
|`max_surge`|The maximum number of pods that can be scheduled above the desired number of pods|int|count|
|`max_unavailable`|The maximum number of pods that can be unavailable during the update.|int|count|
|`message`|object details|string|-|
|`ready`|Total number of ready pods targeted by this deployment.|string|-|
|`strategy`|Type of deployment. Can be "Recreate" or "RollingUpdate". Default is RollingUpdate.|string|-|
|`unavailable`|Total number of unavailable pods targeted by this deployment.|int|-|
|`up_dated`|Total number of non-terminated pods targeted by this deployment that have the desired template spec.|int|-|






















#### `kubernetes_jobs`

Kubernetes Job 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`job_name`|Name must be unique within a namespace.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`active`|The number of actively running pods.|int|count|
|`active_deadline`|Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it|int|s|
|`age`|age (seconds)|int|s|
|`backoff_limit`|Specifies the number of retries before marking this job failed.|int|count|
|`completions`|Specifies the desired number of successfully finished pods the job should be run with.|int|count|
|`failed`|The number of pods which reached phase Failed.|int|count|
|`message`|object details|string|-|
|`parallelism`|Specifies the maximum desired number of pods the job should run at any given time.|int|count|
|`succeeded`|The number of pods which reached phase Succeeded.|int|count|










#### `kubernetes_nodes`

Kubernetes node 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`internal_ip`|Node internal IP|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_ip`|Node IP (depercated)|
|`node_name`|Name must be unique within a namespace.|
|`role`|Node role. (master/node)|
|`status`|NodePhase is the recently observed lifecycle phase of the node. (Pending/Running/Terminated)|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|age (seconds)|int|s|
|`kubelet_version`|Kubelet Version reported by the node.|string|-|
|`message`|object details|string|-|










#### `kubelet_pod`

Kubernetes pod 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`deployment`|The name of the deployment which the object belongs to. (Probably empty)|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`phase`|The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle.(Pending/Running/Succeeded/Failed/Unknown)|
|`pod_name`|Name must be unique within a namespace.|
|`qos_class`|The Quality of Service (QOS) classification assigned to the pod based on resource requirements|
|`replica_set`|The name of the replicaSet which the object belongs to. (Probably empty)|
|`state`|Reason the container is not yet running. (Depercated, use status)|
|`status`|Reason the container is not yet running.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|age (seconds)|int|s|
|`available`|Number of containers|string|-|
|`cpu_usage`|The percentage of cpu used|float|percent|
|`create_time`|CreationTimestamp is a timestamp representing the server time when this object was created.(milliseconds)|int|msec|
|`memory_usage_bytes`|The number of memory used in bytes|float|B|
|`message`|object details|string|-|
|`ready`|Describes whether the pod is ready to serve requests.|string|-|
|`restart`|The number of times the container has been restarted. (Depercated, use restarts)|int|count|
|`restarts`|The number of times the container has been restarted.|int|count|










#### `kubernetes_replica_sets`

Kubernetes replicaset 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`deployment`|The name of the deployment which the object belongs to.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`replica_set_name`|Name must be unique within a namespace.|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|age (seconds)|int|s|
|`available`|The number of available replicas (ready for at least minReadySeconds) for this replica set.|int|-|
|`message`|object details|string|-|
|`ready`|The number of ready replicas for this replica set.|int|-|






#### `kubernetes_services`

Kubernetes service 对象数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`cluster_name`|The name of the cluster which the object belongs to.|
|`name`|UID|
|`namespace`|Namespace defines the space within each name must be unique.|
|`service_name`|Name must be unique within a namespace.|
|`type`|type determines how the Service is exposed. Defaults to ClusterIP. (ClusterIP/NodePort/LoadBalancer/ExternalName)|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`age`|age (seconds)|int|s|
|`cluster_ip`|clusterIP is the IP address of the service and is usually assigned randomly by the master.|string|-|
|`external_ips`|externalIPs is a list of IP addresses for which nodes in the cluster will also accept traffic for this service.|string|-|
|`external_name`|externalName is the external reference that kubedns or equivalent will return as a CNAME record for this service.|string|-|
|`external_traffic_policy`|externalTrafficPolicy denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints.|string|-|
|`message`|object details|string|-|
|`session_affinity`|Supports "ClientIP" and "None".|string|-|




### 日志 {#logging}









#### `容器日志`



- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`[POD_LABEL]`|如果该容器是由 k8s 创建，且配置参数 `extract_k8s_label_as_tags` 开启，则会将 pod 的 label 添加至标签中|
|`container_id`|容器ID|
|`container_name`|k8s 命名的容器名（在 labels 中取 'io.kubernetes.container.name'），如果值为空则跟 container_runtime_name 相同|
|`container_runtime_name`|由 runtime 命名的容器名（例如 docker ps 查看），如果值为空则默认是 unknown（[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)）|
|`container_type`|容器类型，表明该容器由谁创建，kubernetes/docker|
|`deployment`|deployment 名称（容器由 k8s 创建时存在，containerd 日志缺少此字段）|
|`namespace`|pod 的 k8s 命名空间（k8s 创建容器时，会打上一个形如 'io.kubernetes.pod.namespace' 的 label，DataKit 将其命名为 'namespace'）|
|`pod_name`|pod 名称（容器由 k8s 创建时存在）|
|`service`|服务名称|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`log_read_lines`|采集到的行数计数，多行数据算成一行（[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)）|int|count|
|`log_read_offset`|当前数据在文件中的偏移位置（[:octicons-tag-24: Version-1.4.8](changelog.md#cl-1.4.8) · [:octicons-beaker-24: Experimental](index.md#experimental)）|int|-|
|`log_read_time`|数据从文件中读取到的这一刻的时间戳，单位是秒|s|-|
|`message`|日志源数据|string|-|
|`message_length`|message 字段的长度，单位字节|B|count|
|`status`|日志状态，info/emerg/alert/critical/error/warning/debug/OK/unknown|string|-|














































#### `kubernetes_events`

Kubernetes event 日志数据

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`kind`|Kind of the referent.|
|`name`|Name must be unique within a namespace.|
|`namespace`|Namespace defines the space within which each name must be unique.|
|`node_name`|NodeName is a request to schedule this pod onto a specific node.|
|`reason`|This should be a short, machine understandable string that gives the reason, for the transition into the object's current status.|
|`status`|log status|
|`type`|Type of this event (Normal, Warning), new types could be added in the future.|

- 字段列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`message`|event log details|string|-|








































## FAQ {#faq}

### 容器日志的特殊字节码过滤 {#special-char-filter}

容器日志可能会包含一些不可读的字节码（比如终端输出的颜色等），可以

- 将 `logging_remove_ansi_escape_codes` 设置为 `true` 
- DataKit DaemonSet 部署时，将 `ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES` 置为 `true`

此配置会影响日志的处理性能，基准测试结果如下：

```
goos: linux
goarch: amd64
pkg: gitlab.jiagouyun.com/cloudcare-tools/test
cpu: Intel(R) Core(TM) i7-4770HQ CPU @ 2.20GHz
BenchmarkRemoveAnsiCodes
BenchmarkRemoveAnsiCodes-8        636033              1616 ns/op
PASS
ok      gitlab.jiagouyun.com/cloudcare-tools/test       1.056s
```

每一条文本的处理耗时将额外增加 `1616 ns` 不等。如果日志中不带有颜色等修饰，不要开启该功能。

### 容器日志采集的 source 设置 {#config-logging-source}

在容器环境下，日志来源（`source`）设置是一个很重要的配置项，它直接影响在页面上的展示效果。但如果挨个给每个容器的日志配置一个 source 未免残暴。如果不手动配置容器日志来源，DataKit 有如下规则（优先级递减）用于自动推断容器日志的来源：

> 所谓不手动指定容器日志来源，就是指在 Pod Annotation 中不指定，在 container.conf 中也不指定（目前 container.conf 中无指定容器日志来源的配置项）

- 容器名：一般从容器的 `io.kubernetes.container.name` 这个 label 上取值。如果不是 Kubernetes 创建的容器（比如只是单纯的 Docker 环境，那么此 label 没有，故不以容器名作为日志来源）
- short-image-name: 镜像名，如 `nginx.org/nginx:1.21.0` 则取 `nginx`。在非 Kubernetes 容器环境下，一般首先就是取（精简后的）镜像名
- `unknown`: 如果镜像名无效（如 `sha256:b733d4a32c...`），则取该未知值

## 延伸阅读 {#more-reading}

- [eBPF 采集器：支持容器环境下的流量采集](ebpf.md)
- [Pipeline：文本数据处理](../developers/pipeline.md)
- [正确使用正则表达式来配置](datakit-input-conf.md#debug-regex) 
- [Kubernetes 下 DataKit 的几种配置方式](k8s-config-how-to.md)
- [DataKit 日志采集综述](datakit-logging.md)
