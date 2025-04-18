
# Kubernetes
---

本文档介绍如何在 K8s 中通过 DaemonSet 方式安装 DataKit。

## 安装 {#install}

<!-- markdownlint-disable MD046 -->
=== "DaemonSet"

    先下载 [*datakit.yaml*](https://static.<<<custom_key.brand_main_domain>>>/datakit/datakit.yaml){:target="_blank"}，其中开启了很多[默认采集器](datakit-input-conf.md#default-enabled-inputs)，无需配置。
    
    ???+ attention
    
        如果要修改这些采集器的默认配置，可通过 [ConfigMap 方式挂载单独的配置文件](k8s-config-how-to.md#via-configmap-conf) 来配置。部分采集器可以直接通过环境变量的方式来调整，具体参见具体采集器的文档。总而言之，不管是默认开启的采集器，还是其它采集器，在 DaemonSet 方式部署 Datakit 时，通过 [ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){:target="_blank"} 来配置采集器总是生效的。
    
    修改 `datakit.yaml` 中的 Dataway 配置
    
    ```yaml
    - name: ENV_DATAWAY
      value: https://openway.<<<custom_key.brand_main_domain>>>?token=<your-token> # 此处填上 DataWay 真实地址
    ```
    
    如果选择的是其它节点，此处更改对应的 Dataway 地址即可，如 AWS 节点：
    
    ```yaml
    - name: ENV_DATAWAY
      value: https://aws-openway.<<<custom_key.brand_main_domain>>>?token=<your-token> 
    ```
    
    安装 yaml
    
    ```shell
    $ kubectl apply -f datakit.yaml
    ```
    
    安装完后，会创建一个 Datakit 的 DaemonSet 部署：
    
    ```shell
    $ kubectl get pod -n datakit
    ```

=== "Helm"

    前提条件
    
    * Kubernetes >= 1.14
    * Helm >= 3.0+
    
    Helm 安装 Datakit（注意修改 `datakit.dataway_url` 参数）, 其中开启了很多[默认采集器](datakit-input-conf.md#default-enabled-inputs)，无需配置。更多 Helm 相关可参考 [Helm 管理配置](datakit-helm.md)
    
    
    ```shell
    $ helm install datakit datakit \
         --repo  https://pubrepo.<<<custom_key.brand_main_domain>>>/chartrepo/datakit \
         -n datakit --create-namespace \
         --set datakit.dataway_url="https://openway.<<<custom_key.brand_main_domain>>>?token=<your-token>" 
    ```
    
    查看部署状态：
    
    ```shell
    $ helm -n datakit list
    ```
    
    可以通过如下命令来升级：
    
    ```shell
    $ helm -n datakit get  values datakit -o yaml > values.yaml
    $ helm upgrade datakit datakit \
        --repo  https://pubrepo.<<<custom_key.brand_main_domain>>>/chartrepo/datakit \
        -n datakit \
        -f values.yaml
    ```
    
    可以通过如下命令来卸载：
    
    ```shell
    $ helm uninstall datakit -n datakit
    ```
<!-- markdownlint-enable -->

## 资源限制 {#requests-limits}

Datakit 默认设置了 Requests 和 Limits，如果 Datakit 容器状态变为 OOMKilled ，可自定义修改配置。

<!-- markdownlint-disable MD046 -->
=== "Yaml"

    *datakit.yaml* 中其大概格式为
    
    ```yaml
    ...
            resources:
              requests:
                cpu: "200m"
                memory: "128Mi"
              limits:
                cpu: "2000m"
                memory: "4Gi"
    ...
    ```

=== "Helm"

    Helm values.yaml 中其大概格式为
    
    ```yaml
    ...
    resources:
      requests:
        cpu: "200m"
        memory: "128Mi"
      limits:
        cpu: "2000m"
        memory: "4Gi"
    ...
    ```
<!-- markdownlint-enable -->

具体配置，参见[官方文档](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits){:target="_blank"}。

## Kubernetes 污点容忍度配置 {#toleration}

Datakit 默认会在 Kubernetes 集群的所有 Node 上部署（即忽略所有污点），如果 Kubernetes 中某些 Node 节点添加了污点调度，且不希望在其上部署 Datakit，可修改 *datakit.yaml*，调整其中的污点容忍度：

```yaml
      tolerations:
      - operator: Exists    <--- 修改这里的污点容忍度
```

具体绕过策略，参见[官方文档](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration){:target="_blank"}。

## ConfigMap 设置 {#configmap-setting}

部分采集器的开启，需通过 ConfigMap 来注入。以下是 MySQL 和 Redis 采集器的注入示例：

```yaml
# datakit.yaml

volumeMounts: # datakit.yaml 中已有该配置，直接搜索即可定位到
- mountPath: /usr/local/datakit/conf.d/db/mysql.conf
  name: datakit-conf
  subPath: mysql.conf
    readOnly: true
- mountPath: /usr/local/datakit/conf.d/db/redis.conf
  name: datakit-conf
  subPath: redis.conf
    readOnly: true

# 直接在 datakit.yaml 底部追加
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    mysql.conf: |-
      [[inputs.mysql]]
         ...
    redis.conf: |-
      [[inputs.redis]]
         ...
```

## ENV 设置采集器 {#env-setting}

采集器的开启，也可以通过 ENV_DATAKIT_INPUTS 这个环境变量来注入。以下是 MySQL 和 Redis 采集器的注入示例：

- *datakit.yaml* 中其大概格式为

```yaml
spec:
  containers:
    - env
    - name: ENV_XXX
      value: YYY
    - name: ENV_DATAKIT_INPUTS
      value: |
        [[inputs.mysql]]
          interval = "10s"
          ...
        [inputs.mysql.tags]
          some_tag = "some_value"

        [[inputs.redis]]
          interval = "10s"
          ...
        [inputs.redis.tags]
          some_tag = "some_value"
```

- Helm values.yaml 中其大概格式为

```yaml
  extraEnvs: 
    - name: "ENV_XXX"
      value: "YYY"
    - name: "ENV_DATAKIT_INPUTS"
      value: |
        [[inputs.mysql]]
          interval = "10s"
          ...
        [inputs.mysql.tags]
          some_tag = "some_value"

        [[inputs.redis]]
          interval = "10s"
          ...
        [inputs.redis.tags]
          some_tag = "some_value"
```

注入的内容，将存入容器的 conf.d/env_datakit_inputs.conf 文件中。

## Datakit 中其它环境变量设置 {#using-k8-env}

> 注意： ENV_LOG 如果配置成 `stdout`，则不要将 ENV_LOG_LEVEL 设置成 `debug`，否则可能循环产生日志，产生大量日志数据。

在 DaemonSet 模式中，Datakit 支持多个环境变量配置

- *datakit.yaml* 中其大概格式为

```yaml
spec:
  containers:
    - env
    - name: ENV_XXX
      value: YYY
    - name: ENV_OTHER_XXX
      value: YYY
```

- Helm values.yaml 中其大概格式为

```yaml
  extraEnvs: 
    - name: "ENV_XXX"
      value: "YYY"
    - name: "ENV_OTHER_XXX"
      value: "YYY"    
```

### 环境变量类型说明 {#env-types}

以下环境变量的取值分为如下几种数据类型：

- string：字符串类型
- JSON：一些较为复杂的配置，需要以 JSON 字符串形式来设置环境变量
- bool：开关类型，给定**任何非空字符串**即表示开启该功能，建议均以 `"on"` 作为其开启时的取值。如果不开启，必须将其删除或注释掉。
- string-list：以英文逗号分割的字符串，一般用于表示列表
- duration：一种字符串形式的时间长度表示，比如 `10s` 表示 10 秒，这里的单位支持 h/m/s/ms/us/ns。**不要给负数**。
- int：整数类型
- float：浮点类型

对于 string/bool/string-list/duration，建议都用双引号修饰一下，避免 k8s 解析 yaml 可能导致的问题。

### 最常用环境变量 {#env-common}

<!-- markdownlint-disable MD046 -->
- **ENV_DISABLE_PROTECT_MODE**

    禁用「配置保护」模式

    **字段类型**: Boolean

- **ENV_DATAWAY**

    配置 DataWay 地址

    **字段类型**: URL

    **示例**: `https://openway.<<<custom_key.brand_main_domain>>>.com?token=xxx`

    **必填**: Yes

- **ENV_DEFAULT_ENABLED_INPUTS**

    默认开启[采集器列表](datakit-input-conf.md#default-enabled-inputs)，以英文逗号分割，如 `cpu,mem,disk`

    **字段类型**: List

    **示例**: cpu,mem,disk

- **~~ENV_ENABLE_INPUTS~~**

    同 ENV_DEFAULT_ENABLED_INPUTS，将废弃

    **字段类型**: List

- **ENV_GLOBAL_HOST_TAGS**

    全局 tag，多个 tag 之间以英文逗号分割

    **字段类型**: List

    **示例**: tag1=val,tag2=val2

- **ENV_PIPELINE_DEFAULT_PIPELINE**

    为指定数据类别设置默认 Pipeline 脚本；与远程设置冲突时，此设置优先

    **字段类型**: Map

    **示例**: `{"logging":"abc.p","metric":"xyz.p"}`

- **ENV_PIPELINE_DISABLE_HTTP_REQUEST_FUNC**

    禁用 Pipeline `http_request` 函数

    **字段类型**: Boolean

- **ENV_PIPELINE_HTTP_REQUEST_HOST_WHITELIST**

    为 `http_request` 函数设置 HOST 白名单

    **字段类型**: List

- **ENV_PIPELINE_HTTP_REQUEST_CIDR_WHITELIST**

    为 `http_request` 函数设置 CIDR 白名单

    **字段类型**: List

- **ENV_PIPELINE_HTTP_REQUEST_DISABLE_INTERNAL_NET**

    使 `http_request` 函数禁止访问内部网络

    **字段类型**: List

- **~~ENV_GLOBAL_TAGS~~**

    同 ENV_GLOBAL_HOST_TAGS，将废弃

    **字段类型**: List

- **ENV_K8S_CLUSTER_NODE_NAME**

    如果多个 k8s cluster 中存在同名的 node-name，可以通过该环境变量在原 node-name 上加一个前缀来区分

    **字段类型**: String
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ note "区分*全局主机 tag* 和*全局选举 tag*"

    `ENV_GLOBAL_HOST_TAGS` 用来指定主机类全局 tag，这些 tag 的值一般跟随主机变迁，比如主机名、主机 IP 等。当然，其它不跟随主机变迁的 tag 也能加进来。所有非选举类采集器，会默认带上 `ENV_GLOBAL_HOST_TAGS` 中指定的 tag。

    而 `ENV_GLOBAL_ELECTION_TAGS` 建议只添加不随主机切换而变迁的 tags，如集群名、项目名等。对于[参与选举的采集器](election.md#inputs)，只会添加 `ENV_GLOBAL_ELECTION_TAGS` 中指定的 tag，不会增加 `ENV_GLOBAL_HOST_TAGS` 中指定的 tag。

    不管是主机类全局 tag 还是环境类全局 tag，如果原始数据中已经有对应 tag，则不会追加已存在的 tag，我们认为应该沿用原始数据中的 tag。

???+ attention "关于禁用保护模式（ENV_DISABLE_PROTECT_MODE）"

    保护模式一旦被禁用，即可以设置一些危险的配置参数，Datakit 将接受任何配置参数。这些参数可能会导致 Datakit 一些功能异常，或者影响采集器的采集功能。比如 HTTP 发送 Body 设置太小，会影响数据上传功能；某些采集器的采集频率过高，可能影响被采集的实体。
<!-- markdownlint-enable -->

<!--
### Point Pool 配置相关环境变量 {#env-pointpool}

[:octicons-tag-24: Version-1.28.0](changelog.md#cl-1.28.0) ·
[:octicons-beaker-24: Experimental](index.md#experimental)
-->

### Dataway 配置相关环境变量 {#env-dataway}

<!-- markdownlint-disable MD046 -->
- **ENV_DATAWAY**

    配置 DataWay 地址

    **字段类型**: URL

    **示例**: `https://openway.<<<custom_key.brand_main_domain>>>?token=xxx`

    **必填**: Yes

- **ENV_DATAWAY_TIMEOUT**

    配置 DataWay 请求超时

    **字段类型**: Duration

    **默认值**: 30s

- **ENV_DATAWAY_ENABLE_HTTPTRACE**

    开启 DataWay 请求时 HTTP 层面的指标暴露

    **字段类型**: Boolean

- **ENV_DATAWAY_HTTP_PROXY**

    设置 DataWay HTTP 代理

    **字段类型**: URL

- **ENV_DATAWAY_MAX_IDLE_CONNS**

    设置 DataWay HTTP 连接池大小 [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)

    **字段类型**: Int

- **ENV_DATAWAY_IDLE_TIMEOUT**

    设置 DataWay HTTP Keep-Alive 时长 [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)

    **字段类型**: Duration

    **默认值**: 90s

- **ENV_DATAWAY_MAX_RETRY_COUNT**

    指定当把数据发送到中心时，最多可以发送的次数，最小值为 1（失败后不重试），最大值为 10 [:octicons-tag-24: Version-1.17.0](changelog.md#cl-1.17.0)

    **字段类型**: Int

    **默认值**: 4

- **ENV_DATAWAY_RETRY_DELAY**

    数据发送失败时，两次重试之间的时间间隔 [:octicons-tag-24: Version-1.17.0](changelog.md#cl-1.17.0)

    **字段类型**: Duration

    **默认值**: 200ms

- **ENV_DATAWAY_MAX_RAW_BODY_SIZE**

    数据上传时单包（未压缩）大小

    **字段类型**: Int

    **默认值**: 10MB

- **ENV_DATAWAY_CONTENT_ENCODING**

    设置上传时的 point 数据编码（可选列表：`v1` 即行协议，`v2` 即 Protobuf）

    **字段类型**: String

- **ENV_DATAWAY_TLS_INSECURE**

    允许对应的 Dataway 上的证书是自签证书 [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **字段类型**: Boolean

- **ENV_DATAWAY_NTP_INTERVAL**

    设置 NTP 时间同步间隔 [:octicons-tag-24: Version-1.38.2](changelog.md#cl-1.38.2)

    **字段类型**: String

- **ENV_DATAWAY_NTP_DIFF**

    设置 NTP 时间同步的误差[:octicons-tag-24: Version-1.38.2](changelog.md#cl-1.38.2)

    **字段类型**: String

- **ENV_DATAWAY_WAL_CAPACITY**

    设置 WAL 占用的磁盘大小 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **字段类型**: Float

- **ENV_DATAWAY_WAL_WORKERS**

    设置 WAL worker 个数，默认为 CPU 配额核心数 X 8 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **字段类型**: Int

- **ENV_DATAWAY_WAL_MEM_CAPACITY**

    设置 WAL 内存队列长度，默认为 CPU 配额核心数 X 8 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **字段类型**: Int

- **ENV_DATAWAY_WAL_NO_DROP_CATEGORIES**

    当 WAL 磁盘限定容量写满时，设置不主动丢弃的数据类型列表 [:octicons-tag-24: Version-1.71.0](changelog.md#cl-1.71.0)

    **字段类型**: List

    **示例**: `'L,T,N'`

- **ENV_DATAWAY_WAL_PATH**

    设置 WAL 磁盘目录，默认为 Datakit 安装目录下的 *cache/dw-wal* [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **字段类型**: String

- **ENV_DATAWAY_WAL_FAIL_CACHE_CLEAN_INTERVAL**

    设置 WAL 失败队列的重试间隔，默认 `30s` [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **字段类型**: Duration
<!-- markdownlint-enable -->

### 日志配置相关环境变量 {#env-log}

<!-- markdownlint-disable MD046 -->
- **ENV_GIN_LOG**

    如果改成 `stdout`，Datakit 自身 gin 日志将不写文件，而是终端输出

    **字段类型**: String

    **默认值**: */var/log/datakit/gin.log*

- **ENV_LOG**

    如果改成 `stdout`，Datakit 自身日志将不写文件，而是终端输出

    **字段类型**: String

    **默认值**: */var/log/datakit/log*

- **ENV_LOG_LEVEL**

    设置 Datakit 自身日志等级，可选 `info/debug`（不区分大小写）

    **字段类型**: String

    **默认值**: info

- **ENV_DISABLE_LOG_COLOR**

    关闭日志颜色

    **字段类型**: Boolean

    **默认值**: -

- **ENV_LOG_ROTATE_BACKUP**

    设置最多保留日志分片的个数

    **字段类型**: Int

    **默认值**: 5

- **ENV_LOG_ROTATE_SIZE_MB**

    日志自动切割的阈值（单位：MB），当日志文件大小达到设置的值时，自动切换新的文件

    **字段类型**: Int

    **默认值**: 32
<!-- markdownlint-enable -->

### Pprof 相关 {#env-pprof}

<!-- markdownlint-disable MD046 -->
- **~~ENV_ENABLE_PPROF~~**

    是否开启 profiling 端口（已默认启用）

    **字段类型**: Boolean

- **ENV_PPROF_LISTEN**

    `pprof` 服务监听地址

    **字段类型**: String
<!-- markdownlint-enable -->

> `ENV_ENABLE_PPROF`：[:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) 已默认开启 pprof。

### 选举相关环境变量 {#env-elect}

<!-- markdownlint-disable MD046 -->
- **ENV_ENABLE_ELECTION**

    开启[选举](election.md)，默认不开启，如需开启，给该环境变量任意一个非空字符串值即可

    **字段类型**: Boolean

    **默认值**: -

- **ENV_NAMESPACE**

    Datakit 所在的命名空间，默认为空表示不区分命名空间，接收任意非空字符串，如 `dk-namespace-example`。如果开启了选举，可以通过此环境变量指定工作空间。

    **字段类型**: String

    **默认值**: default

- **ENV_ENABLE_ELECTION_NAMESPACE_TAG**

    开启该选项后，所有选举类的采集均会带上 `election_namespace=<your-election-namespace>` 的额外 tag，这可能会导致一些时间线的增长 [:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)

    **字段类型**: Boolean

    **默认值**: -

- **ENV_GLOBAL_ELECTION_TAGS**

    全局选举 tag，多个 tag 之间以英文逗号分割。ENV_GLOBAL_ENV_TAGS 将被弃用

    **字段类型**: List

    **示例**: tag1=val,tag2=val2

- **ENV_CLUSTER_NAME_K8S**

    Datakit 所在的 cluster，如果非空，会在 [Global Election Tags](election.md#global-tags) 中添加一个指定 tag，key 是 `cluster_name_k8s`，value 是环境变量的值 [:octicons-tag-24: Version-1.5.8](changelog.md#cl-1.5.8)

    **字段类型**: String

    **默认值**: default

- **ENV_ELECTION_NODE_WHITELIST**

    允许参加选举的节点名称列表 [:octicons-tag-24: Version-1.35.0](changelog.md#cl-1.35.0)

    **字段类型**: List

    **默认值**: []
<!-- markdownlint-enable -->

### HTTP/API 相关环境变量 {#env-http-api}

<!-- markdownlint-disable MD046 -->
- **ENV_DISABLE_404PAGE**

    禁用 Datakit 404 页面（公网部署 Datakit RUM 时常用）。

    **字段类型**: Boolean

    **默认值**: -

- **ENV_HTTP_LISTEN**

    可修改地址，使得外部可以调用 [Datakit 接口](apis.md)。

    **字段类型**: String

    **默认值**: localhost:9529

- **ENV_HTTP_LISTEN_SOCKET**

    可修改地址，使得外部可以通过 unix socket 调用 [Datakit 接口](apis.md)。

    **字段类型**: String

    **示例**: `/var/run/datakit/datakit.sock`

- **ENV_HTTP_PUBLIC_APIS**

    允许外部访问的 Datakit [API 列表](apis.md)，多个 API 之间以英文逗号分割。当 Datakit 部署在公网时，用来禁用部分 API。

    **字段类型**: List

- **ENV_HTTP_TIMEOUT**

    设置 9529 HTTP API 服务端超时时间 [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)

    **字段类型**: Duration

    **默认值**: 30s

- **ENV_HTTP_CLOSE_IDLE_CONNECTION**

    如果开启，则 9529 HTTP server 会主动关闭闲置连接（闲置时间等同于 `ENV_HTTP_TIMEOUT`） [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)

    **字段类型**: Boolean

    **默认值**: -

- **ENV_HTTP_ENABLE_TLS**

    开启 Datakit 9529 HTTPS [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **字段类型**: Boolean

    **默认值**: -

- **ENV_HTTP_TLS_CRT**

    配置 Datakit HTTP Server 上的 TLS cert 路径 [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **字段类型**: String

    **默认值**: -

- **ENV_HTTP_TLS_KEY**

    配置 Datakit HTTP Server 上的 TLS key 路径 [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **字段类型**: String

    **默认值**: -

- **ENV_REQUEST_RATE_LIMIT**

    限制 9529 [API 每秒请求数](datakit-conf.md#set-http-api-limit)。

    **字段类型**: Float

    **默认值**: 20.0

- **ENV_RUM_ORIGIN_IP_HEADER**

    设置 RUM 请求中真实 IP forward 对应的 HTTP header key。Datakit 将从该 Header 上获取端上用户的真实 IP，否则拿到可能是网关 IP。

    **字段类型**: String

    **默认值**: `X-Forwarded-For`

- **ENV_RUM_APP_ID_WHITE_LIST**

    RUM app-id 白名单列表，以 `,` 分割。

    **字段类型**: String

    **示例**: /appid-1,/appid-2

- **ENV_HTTP_ALLOWED_CORS_ORIGINS**

    设置 Datakit API CORS 属性（英文逗号分割）[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **字段类型**: List

    **示例**: Origin,Access-Control-Allow-Origin,Access-Control-Allow-Methods

    **默认值**: -
<!-- markdownlint-enable -->

### Confd 配置相关环境变量 {#env-confd}

<!-- markdownlint-disable MD046 -->
- **ENV_CONFD_BACKEND**

    要使用的后端

    **字段类型**: String

    **示例**: `etcdv3`

- **ENV_CONFD_BASIC_AUTH**

    使用 Basic Auth 进行身份验证（适用于 `etcdv3`/consul）

    **字段类型**: Boolean

    **默认值**: false

- **ENV_CONFD_CLIENT_CA_KEYS**

    客户端 CA 密钥文件

    **字段类型**: String

    **示例**: `/opt/ca.crt`

- **ENV_CONFD_CLIENT_CERT**

    客户端证书文件

    **字段类型**: String

    **示例**: `/opt/client.crt`

- **ENV_CONFD_CLIENT_KEY**

    客户端密钥文件

    **字段类型**: String

    **示例**: `/opt/client.key`

- **ENV_CONFD_BACKEND_NODES**

    后端源地址

    **字段类型**: JSON

    **示例**: `["http://aaa:2379","1.2.3.4:2379"]` (`Nacos must prefix http:// or https://`)

- **ENV_CONFD_USERNAME**

    身份验证的用户名（适用于 `etcdv3/consul/nacos`）

    **字段类型**: String

- **ENV_CONFD_PASSWORD**

    身份验证的密码（适用于 `etcdv3/consul/nacos`）

    **字段类型**: String

- **ENV_CONFD_SCHEME**

    后端 URI 方案

    **字段类型**: String

    **示例**: http/https

- **ENV_CONFD_SEPARATOR**

    在后端查找键时替换'/'的分隔符，前缀'/'也将被删除（适用于 redis）

    **字段类型**: String

    **默认值**: /

- **ENV_CONFD_ACCESS_KEY**

    客户端身份 ID（适用于 `nacos/aws`）

    **字段类型**: String

- **ENV_CONFD_SECRET_KEY**

    认证密钥（适用于 `nacos/aws`）

    **字段类型**: String

- **ENV_CONFD_CIRCLE_INTERVAL**

    循环检测间隔秒数（适用于 `nacos/aws`）

    **字段类型**: Int

    **默认值**: 60

- **ENV_CONFD_CONFD_NAMESPACE**

    配置信息的空间 ID（适用于 `nacos`）

    **字段类型**: String

    **示例**: `6aa36e0e-bd57-4483-9937-e7c0ccf59599`

- **ENV_CONFD_PIPELINE_NAMESPACE**

    `pipeline` 的信息空间 ID（适用于 `nacos`）

    **字段类型**: String

    **示例**: `d10757e6-aa0a-416f-9abf-e1e1e8423497`

- **ENV_CONFD_REGION**

    AWS 服务区（适用于 aws）

    **字段类型**: String

    **示例**: `cn-north-1`
<!-- markdownlint-enable -->

### Git 配置相关环境变量 {#env-git}

<!-- markdownlint-disable MD046 -->
- **ENV_GIT_BRANCH**

    指定拉取的分支。**为空则是默认**，默认是远程指定的主分支，一般是 `master`

    **字段类型**: String

    **示例**: master

- **ENV_GIT_INTERVAL**

    定时拉取的间隔

    **字段类型**: Duration

    **示例**: 1m

- **ENV_GIT_KEY_PATH**

    本地 PrivateKey 的全路径

    **字段类型**: String

    **示例**: /Users/username/.ssh/id_rsa

- **ENV_GIT_KEY_PW**

    本地 PrivateKey 的使用密码

    **字段类型**: String

    **示例**: passwd

- **ENV_GIT_URL**

    管理配置文件的远程 git repo 地址

    **字段类型**: URL

    **示例**: `http://username:password@github.com/username/repository.git`
<!-- markdownlint-enable -->

### Sinker 配置相关环境变量 {#env-sinker}

<!-- markdownlint-disable MD046 -->
- **ENV_SINKER_GLOBAL_CUSTOMER_KEYS**

    指定 Sinker 分流的自定义字段列表，各个 Key 之间以英文逗号分割

    **字段类型**: String

- **ENV_DATAWAY_ENABLE_SINKER**

    开启 DataWay 发送数据时的 Sinker 功能。该功能需新版本 Dataway 才能生效 [:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)

    **字段类型**: Boolean

    **默认值**: -
<!-- markdownlint-enable -->

### IO 模块配置相关环境变量 {#env-io}

<!-- markdownlint-disable MD046 -->
- **ENV_IO_FILTERS**

    添加[行协议过滤器](datakit-filter.md)

    **字段类型**: JSON

- **ENV_IO_FLUSH_INTERVAL**

    设置 compact 执行间隔 [:octicons-tag-24: Version-1.22.0](changelog.md#cl-1.22.0)

    **字段类型**: Duration

    **默认值**: 10s

- **ENV_IO_FEED_CHAN_SIZE**

    设置 compact 队列长度 [:octicons-tag-24: Version-1.22.0](changelog.md#cl-1.22.0)

    **字段类型**: Int

    **默认值**: 1

- **ENV_IO_FLUSH_WORKERS**

    设置 compactor worker 数，默认为 CPU 配额核心数 x 2 [:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

    **字段类型**: Int

- **ENV_IO_MAX_CACHE_COUNT**

    Compact 缓存的点数

    **字段类型**: Int

    **默认值**: 1024

- **~~ENV_IO_ENABLE_CACHE~~**

    是否开启发送失败的磁盘缓存。[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) 版本已移除

    **字段类型**: Boolean

    **默认值**: false

- **~~ENV_IO_CACHE_ALL~~**

    是否 cache 所有发送失败的数据。[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) 版本已移除

    **字段类型**: Boolean

    **默认值**: false

- **~~ENV_IO_CACHE_MAX_SIZE_GB~~**

    发送失败缓存的磁盘大小（单位 GB）。[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) 版本已移除

    **字段类型**: Int

    **默认值**: 10

- **~~ENV_IO_CACHE_CLEAN_INTERVAL~~**

    定期发送缓存在磁盘内的失败任务。[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0) 版本已移除

    **字段类型**: Duration

    **默认值**: 5s
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ note "关于 buffer 和 queue 的说明"

    `ENV_IO_MAX_CACHE_COUNT` 用来控制数据的发送策略，即当内存中 cache 的（行协议）点数超过该数值的时候，就会尝试将内存中当前 cache 的点数发送到中心。如果该 cache 的阈值调的太大，数据就都堆积在内存，导致内存飙升，但会提高 GZip 的压缩效果。如果太小，可能影响发送吞吐率。
<!-- markdownlint-enable -->

`ENV_IO_FILTERS` 是一个 JSON 字符串，示例如下：

```json
{
  "logging":[
    "{ source = 'datakit' and ( host in ['ubt-dev-01', 'tanb-ubt-dev-test'] )}",
    "{ source = 'abc' and ( host in ['ubt-dev-02', 'tanb-ubt-dev-test-1'] )}"
  ],

  "metric":[
    "{ measurement in in ['datakit', 'redis_client'] )}"
  ],
}
```

### DCA 相关环境变量 {#env-dca}

<!-- markdownlint-disable MD046 -->
- **ENV_DCA_WEBSOCKET_SERVER**

    DataKit 可以连接该地址，使得 DCA 可以进行管理该 DataKit，一旦开启 ENV_DCA_WEBSOCKET_SERVER 即默认启用 DCA 功能

    **字段类型**: URL
<!-- markdownlint-enable -->

### Refer Table 有关环境变量 {#env-reftab}

<!-- markdownlint-disable MD046 -->
- **ENV_REFER_TABLE_URL**

    设置数据源 URL

    **字段类型**: String

- **ENV_REFER_TABLE_PULL_INTERVAL**

    设置数据源 URL 的请求时间间隔

    **字段类型**: String

    **默认值**: 5m

- **ENV_REFER_TABLE_USE_SQLITE**

    设置是否使用 SQLite 保存数据

    **字段类型**: Boolean

    **默认值**: false

- **ENV_REFER_TABLE_SQLITE_MEM_MODE**

    当使用 SQLite 保存数据时，使用 SQLite 内存模式/磁盘模式

    **字段类型**: Boolean

    **默认值**: false
<!-- markdownlint-enable -->

### 数据录制有关环境变量 {#env-recorder}

[:octicons-tag-24: Version-1.22.0](changelog.md#1.22.0)

数据录制相关的功能，参见[这里的文档](datakit-tools-how-to.md#record-and-replay)。

<!-- markdownlint-disable MD046 -->
- **ENV_ENABLE_RECORDER**

    设置是否开启数据录制

    **字段类型**: Boolean

    **默认值**: false

- **ENV_RECORDER_PATH**

    设置数据录制的存放目录

    **字段类型**: String

    **默认值**: *Datakit 安装目录/recorder*

- **ENV_RECORDER_ENCODING**

    设置数据录制的存放格式，v1 为行协议格式，v2 为 JSON 格式

    **字段类型**: String

    **默认值**: v2

- **ENV_RECORDER_DURATION**

    设置数据录制时长（自 Datakit 启动以后），一旦超过该时长，则不再录制

    **字段类型**: Duration

    **默认值**: 30m

- **ENV_RECORDER_INPUTS**

    设置录制的采集器名称列表，以英文逗号分割

    **字段类型**: List

    **示例**: cpu,mem,disk

- **ENV_RECORDER_CATEGORIES**

    设置录制的数据分类列表，以英文逗号分割，完整的 Category 列表参见[这里](apis.md#category)

    **字段类型**: List

    **示例**: metric,logging,object
<!-- markdownlint-enable -->

### Remote Job 远程任务 {#remote_job}

[:octicons-tag-24: Version-1.63.0](changelog.md#cl-1.63.0)

<!-- markdownlint-disable MD046 -->
- **ENV_REMOTE_JOB_ENABLE**

    开启 remote job 功能

    **字段类型**: Boolean

    **示例**: `true`

    **默认值**: false

- **ENV_REMOTE_JOB_ENVS**

    主要作用于将生成的文件发送到 OSS.

    **字段类型**: String

    **示例**: `true`

    **默认值**: false

- **ENV_REMOTE_JOB_INTERVAL**

    定时请求服务端获取任务，默认 10 秒

    **字段类型**: String

    **示例**: 10s

    **默认值**: 10s
<!-- markdownlint-enable -->

### 其它杂项 {#env-others}

<!-- markdownlint-disable MD046 -->
- **ENV_CLOUD_PROVIDER**

    支持安装阶段填写云厂商

    **字段类型**: String

    **示例**: `aliyun/aws/tencent/hwcloud/azure`

- **ENV_HOSTNAME**

    默认为本地主机名，可安装时指定，如， `dk-your-hostname`

    **字段类型**: String

- **ENV_IPDB**

    指定 IP 信息库类型，目前只支持 `iploc/geolite2` 两种

    **字段类型**: String

- **ENV_ULIMIT**

    指定 Datakit 最大的可打开文件数

    **字段类型**: Int

- **ENV_PIPELINE_OFFLOAD_RECEIVER**

    设置 Offload 目标接收器的类型

    **字段类型**: String

    **默认值**: `datakit-http`

- **ENV_PIPELINE_OFFLOAD_ADDRESSES**

    设置 Offload 目标地址

    **字段类型**: List

    **示例**: `http://aaa:123,http://1.2.3.4:1234`

- **ENV_PIPELINE_DISABLE_APPEND_RUN_INFO**

    禁用追加 Pipeline 运行信息

    **字段类型**: Boolean

    **默认值**: `false`

- **ENV_CRYPTO_AES_KEY**

    AES 加解密的 key 长度是 16

    **字段类型**: String

    **示例**: `0123456789abcdef`

- **ENV_CRYPTO_AES_KEY_FILE**

    AES 加解密的 key 存放的文件路径

    **字段类型**: String

    **示例**: `/usr/local/datakit/enc4mysql`

- **ENV_LOGGING_MAX_OPEN_FILES**

    指定日志采集的最大文件个数，如果值是 -1 则没有限制，默认值 500

    **字段类型**: Int

    **示例**: `1000`
<!-- markdownlint-enable -->

### 特殊环境变量 {#env-special}

#### ENV_K8S_NODE_NAME {#env_k8s_node_name}

当 k8s node 名称跟其对应的主机名不同时，可将 k8s 的 node 名称顶替默认采集到的主机名，在 *datakit.yaml* 中增加环境变量：

> [1.2.19](changelog.md#cl-1.2.19) 版本的 *datakit.yaml* 中默认就带了这个配置，如果是从老版本的 yaml 直接升级而来，需要对 *datakit.yaml* 做如下手动改动。

```yaml
- env:
    - name: ENV_K8S_NODE_NAME
        valueFrom:
            fieldRef:
                apiVersion: v1
                fieldPath: spec.nodeName
```

#### ENV_K8S_CLUSTER_NODE_NAME {#env-rename-node}

[:octicons-tag-24: Version-1.36.0](changelog.md#1.36.0)

如果不同集群存在同名 Node，且这些集群的数据都打到**同一个工作空间**，可以通过 `ENV_K8S_CLUSTER_NODE_NAME` 来手动修改**采集到的 Node 名称**。在部署时，*datakit.yaml* 中位于 `ENV_K8S_NODE_NAME` **后面**新增一个配置段：

```yaml
- name: ENV_K8S_CLUSTER_NODE_NAME
  value: cluster_a_$(ENV_K8S_NODE_NAME) # 注意，此处引用的 ENV_K8S_NODE_NAME 必须在前面已有定义
```

这样之后，该集群获取到的主机名（主机对象列表）会多一个 `cluster_a_` 的前缀，除此之外，主机日志/进程/CPU/Mem 等指标集上，`host` 这个 tag 的值也都多了这个前缀。

### 各个采集器专用环境变量 {#inputs-envs}

部分采集器支持外部注入环境变量，以调整采集器自身的默认配置。具体参见各个具体的采集器文档。

## 延伸阅读 {#more-readings}

- [Datakit 选举](election.md)
- [Datakit 的几种配置方式](k8s-config-how-to.md)
