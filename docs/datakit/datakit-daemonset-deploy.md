
# DaemonSet 安装 DataKit 
---

- 操作系统支持：:fontawesome-brands-linux:

本文档介绍如何在 K8s 中通过 DaemonSet 方式安装 DataKit。

## 安装步骤 

- Helm 安装
- 普通 yaml 安装

### Helm 安装

#### 前提条件

* Kubernetes >= 1.14
* Helm >= 3.0+

#### 添加 DataKit Helm 仓库

```shell 
$ helm repo add datakit  https://pubrepo.guance.com/chartrepo/datakit
$ helm repo update 
```

#### Helm 安装 Datakit

```shell
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" --create-namespace 
```

> 注意修改 `datakit.dataway_url` 参数。

具体执行如下：

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=xxxxxxxxx" --create-namespace 
```

#### 查看部署状态

```shell
$ helm -n datakit list
```

#### 升级

```shell
$ helm repo update 
$ helm upgrade datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" 
```

#### 卸载

```shell
$ helm uninstall datakit -n datakit
```

### 普通 yaml 安装

先下载 [datakit.yaml](https://static.guance.com/datakit/datakit.yaml){:target="_blank"}，其中开启了很多[默认采集器](datakit-input-conf.md#default-enabled-inputs)，无需配置。

> 如果要修改这些采集器的默认配置，可通过 [Configmap 方式挂载单独的 conf](../integrations/k8s-config-how-to.md#via-configmap-conf) 来配置。部分采集器可以直接通过环境变量的方式来调整，具体参见具体采集器的文档（[容器采集器示例](../integrations/container.md#env-config)）。总而言之，不管是默认开启的采集器，还是其它采集器，在 DaemonSet 方式部署 DataKit 时，通过 [Configmap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){:target="_blank"} 来配置采集器总是生效的。

#### 修改配置

修改 `datakit.yaml` 中的 dataway 配置

```yaml
	- name: ENV_DATAWAY
		value: https://openway.guance.com?token=<your-token> # 此处填上 DataWay 真实地址
```

如果选择的是其它节点，此处更改对应的 DataWay 地址即可，如 AWS 节点：

```yaml
	- name: ENV_DATAWAY
		value: https://aws-openway.guance.com?token=<your-token> 
```

#### 安装 yaml

```shell
$ kubectl apply -f datakit.yaml
```

#### 查看运行状态

安装完后，会创建一个 datakit 的 DaemonSet 部署：

```shell
$ kubectl get pod -n datakit
```

#### Kubernetes 污点容忍度配置 {#toleration}

DataKit 默认会在 Kubernetes 集群的所有 node 上部署（即忽略所有污点），如果 Kubernetes 中某些 node 节点添加了污点调度，且不希望在其上部署 DataKit，可修改 datakit.yaml，调整其中的污点容忍度：

```yaml
      tolerations:
      - operator: Exists    <--- 修改这里的污点容忍度
```

具体绕过策略，参见[官方文档](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration){:target="_blank"}。

#### ConfigMap 设置 {#configmap-setting}

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

## DataKit 中其它环境变量设置 {#using-k8-env}

> 注意： ENV_LOG 如果配置成 `stdout`，则不要将 ENV_LOG_LEVEL 设置成 `debug`，否则可能循环产生日志，产生大量日志数据。

在 DaemonSet 模式中，DataKit 支持多个环境变量配置

- datakit.yaml 中其大概格式为

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
- bool：开关类型，给定**任何非空字符串**即表示开启该功能，建议均以 `"on"` 作为其开启时的取值。如果不开启，必须将其删除或注释掉。
- string-list：以英文逗号分割的字符串，一般用于表示列表
- duration：一种字符串形式的时间长度表示，比如 `10s` 表示 10 秒，这里的单位支持 h/m/s/ms/us/ns。==不要给负值==。
- int：整数类型
- float：浮点类型

对于 string/bool/string-list/duration，建议都用双引号修饰一下，避免 k8s 解析 yaml 可能导致的问题。

### 最常用环境变量 {#env-common}

| 环境变量名称               | 类型        | 默认值 | 必须   | 说明                                                                                                  |
| ---------:                 | ----:       | ---:   | ------ | ----                                                                                                  |
| ENV_DATAWAY                | string      | 无     | 是     | 配置 DataWay 地址，如 `https://openway.guance.com?token=xxx`                                          |
| ENV_DEFAULT_ENABLED_INPUTS | string-list | 无     | 否     | 默认开启[采集器列表](datakit-input-conf.md#default-enabled-inputs)，以英文逗号分割，如 `cpu,mem,disk` |
| ENV_ENABLE_INPUTS          | string-list | 无     | 否     | ==将废弃==，改用 ENV_DEFAULT_ENABLED_INPUTS                                                           |
| ENV_GLOBAL_TAGS            | string-list | 无     | 否     | ==将废弃==，改用 ENV_GLOBAL_HOST_TAGS                                                                 |
| ENV_GLOBAL_HOST_TAGS       | string-list | 无     | 否     | 全局 tag，多个 tag 之间以英文逗号分割，如 `tag1=val,tag2=val2`                                        |
| ENV_GLOBAL_ENV_TAGS        | string-list | 无     | 否     | 全局环境 tag，多个 tag 之间以英文逗号分割，如 `tag1=val,tag2=val2`                                    |

???+ note "区分全局主机 tag 和 环境 tag"

    `ENV_GLOBAL_HOST_TAGS` 用来指定主机类全局 tag，这些 tag 的值一般跟随主机变迁，比如主机名、主机 IP 等。当然，其它不跟随主机变迁的 tag 也能加进来。所有非选举类采集器，会默认带上 `ENV_GLOBAL_HOST_TAGS` 中指定的 tag。

    而 `ENV_GLOBAL_ENV_TAGS` 建议只添加不随主机切换而变迁的 tags，如集群名、项目名等。对于[参与选举的采集器](election.md#inputs)，只会添加 `ENV_GLOBAL_ENV_TAGS` 中指定的 tag，不会增加 `ENV_GLOBAL_HOST_TAGS` 中指定的 tag。

    不管是主机类全局 tag 还是环境类全局 tag，如果原始数据中已经有对应 tag，则不会追加已存在的 tag，我们认为应该沿用原始数据中的 tag。

### 日志配置相关环境变量 {#env-log}

| 环境变量名称          | 类型   | 默认值                     | 必须   | 说明                                                             |
| ---------:            | ----:  | ---:                       | ------ | ----                                                             |
| ENV_GIN_LOG           | string | */var/log/datakit/gin.log* | 否     | 如果改成 `stdout`，DataKit 自身 gin 日志将不写文件，而是终端输出 |
| ENV_LOG               | string | */var/log/datakit/log*     | 否     | 如果改成 `stdout`，DatakIt 自身日志将不写文件，而是终端输出      |
| ENV_LOG_LEVEL         | string | info                       | 否     | 设置 DataKit 自身日志等级，可选 `info/debug`                     |
| ENV_DISABLE_LOG_COLOR | bool   | -                          | 否     | 关闭日志颜色                                                     |

###  DataKit pprof 相关 {#env-pprof}

| 环境变量名称     | 类型   | 默认值 | 必须   | 说明                |
| ---------:       | ----:  | ---:   | ------ | ----                |
| ENV_ENABLE_PPROF | bool   | -      | 否     | 是否开启 `pprof`    |
| ENV_PPROF_LISTEN | string | 无     | 否     | `pprof`服务监听地址 |

### 选举相关环境变量 {#env-elect}

| 环境变量名称                      | 类型   | 默认值    | 必须   | 说明                                                                                                                                                                                       |
| ---------:                        | ----:  | ---:      | ------ | ----                                                                                                                                                                                       |
| ENV_ENABLE_ELECTION               | bool   | -         | 否     | 开启[选举](election.md)，默认不开启，如需开启，给该环境变量任意一个非空字符串值即可                                                                                                        |
| ENV_NAMESPACE                     | string | `default` | 否     | DataKit 所在的命名空间，默认为空表示不区分命名空间，接收任意非空字符串，如 `dk-namespace-example`。如果开启了选举，可以通过此环境变量指定工作空间。                                        |
| ENV_ENABLE_ELECTION_NAMESPACE_TAG | bool   | -         | 否     | 开启该选项后，所有选举类的采集均会带上 `election_namespace=<your-election-namespace>` 的额外 tag，这可能会导致一些时间线的增长（[:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)） |

### HTTP/API 相关环境变量 {#env-http-api}

| 环境变量名称                   | 类型        | 默认值            | 必须   | 说明                                                                                                                                                                                                        |
| ---------:                     | ----:       | ---:              | ------ | ----                                                                                                                                                                                                        |
| ENV_DISABLE_404PAGE            | bool        | -                 | 否     | 禁用 DataKit 404 页面（公网部署 DataKit RUM 时常用）                                                                                                                                                        |
| ENV_HTTP_LISTEN                | string      | localhost:9529    | 否     | 可修改地址，使得外部可以调用 [DataKit 接口](apis)                                                                                                                                                           |
| ENV_HTTP_PUBLIC_APIS           | string-list | 无                | 否     | 允许外部访问的 DataKit [API 列表](apis)，多个 API 之间以英文逗号分割。当 DataKit 部署在公网时，用来禁用部分 API                                                                                             |
| ENV_HTTP_TIMEOUT               | duration    | 30s               | 否     | 设置 9529 HTTP API 服务端超时时间 [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)                                                     |
| ENV_HTTP_CLOSE_IDLE_CONNECTION | bool        | -                 | 否     | 如果开启，则 9529 HTTP server 会主动关闭闲置连接（闲置时间等同于 `ENV_HTTP_TIMEOUT`） [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental) |
| ENV_REQUEST_RATE_LIMIT         | float       | 无                | 否     | 限制 9529 [API 每秒请求数](datakit-conf.md#set-http-api-limit)                                                                                                                                              |
| ENV_RUM_ORIGIN_IP_HEADER       | string      | `X-Forwarded-For` | 否     | RUM 专用                                                                                                                                                                                                    |
| ENV_RUM_APP_ID_WHITE_LIST      | string      | 无                | 否     | RUM app-id 白名单列表，以 `,` 分割，如 `appid-1,appid-2`                                                                                                                                                    |

### Git 配置相关环境变量 {#env-git}

| 环境变量名称     | 类型     | 默认值 | 必须   | 说明                                                                                                   |
| ---------:       | ----:    | ---:   | ------ | ----                                                                                                   |
| ENV_GIT_BRANCH   | string   | 无     | 否     | 指定拉取的分支。<stong>为空则是默认</strong>，默认是远程指定的主分支，一般是 `master`。                |
| ENV_GIT_INTERVAL | duration | 无     | 否     | 定时拉取的间隔。（如 `1m`）                                                                            |
| ENV_GIT_KEY_PATH | string   | 无     | 否     | 本地 PrivateKey 的全路径。（如 `/Users/username/.ssh/id_rsa`）                                         |
| ENV_GIT_KEY_PW   | string   | 无     | 否     | 本地 PrivateKey 的使用密码。（如 `passwd`）                                                            |
| ENV_GIT_URL      | string   | 无     | 否     | 管理配置文件的远程 git repo 地址。（如 `http://username:password@github.com/username/repository.git`） |

### Sinker 配置相关环境变量 {#env-sinker}

| 环境变量名称 | 类型   | 默认值 | 必须   | 说明                              |
| ---------:   | ----:  | ---:   | ------ | ----                              |
| ENV_SINK_M   | string | 无     | 否     | 安装时指定 Metric 的 sink。       |
| ENV_SINK_N   | string | 无     | 否     | 安装时指定 Network 的 sink。      |
| ENV_SINK_K   | string | 无     | 否     | 安装时指定 KeyEvent 的 sink。     |
| ENV_SINK_O   | string | 无     | 否     | 安装时指定 Object 的 sink。       |
| ENV_SINK_CO  | string | 无     | 否     | 安装时指定 CustomObject 的 sink。 |
| ENV_SINK_L   | string | 无     | 否     | 安装时指定 Logging 的 sink。      |
| ENV_SINK_T   | string | 无     | 否     | 安装时指定 Tracing 的 sink。      |
| ENV_SINK_R   | string | 无     | 否     | 安装时指定 RUM 的 sink。          |
| ENV_SINK_S   | string | 无     | 否     | 安装时指定 Security 的 sink。     |

### IO 模块配置相关环境变量 {#env-io}

| 环境变量名称             | 默认值 | 必须   | 说明                               |
| ---------:               | ---:   | ------ | ----                               |
| ENV_IO_FILTERS           | 无     | 否     | 添加[行协议过滤器](datakit-filter) |
| ENV_IO_FLUSH_INTERVAL    | 10s    | 否     | IO 发送时间频率                    |
| ENV_IO_BLOCKING_MODE     | false  | 否     | 阻塞模式 [:octicons-tag-24: Version-1.4.8](changelog.md#cl-1.4.8) · [:octicons-beaker-24: Experimental](index.md#experimental)|
| ENV_IO_MAX_CACHE_COUNT   | 512    | 否     | 发送 buffer（点数）大小 |
| ENV_IO_QUEUE_SIZE        | 4096   | 否     | IO 模块数据处理队列长度 |

???+ note "关于 buffer 和 queue 的说明"

    `ENV_IO_MAX_CACHE_COUNT` 用来控制数据的发送策略，即当内存中 cache 的点数超过该数值的时候，就会尝试将内存中当前 cache 的点数发送到中心。如果该 cache 的阈值调的太大，数据就都堆积在内存，导致内存飙升。如果太小，可能影响发送吞吐率。`ENV_IO_QUEUE_SIZE` 为数据处理的队列长度，在数据量不大的情况下，即使将该值调大一点，不大会影响内存占用，但如果数据量足够大，而发送的效率又太低（网络原因或其它设置原因），会导致采集到的数据都堆积在队列中，同样导致内存飙升。

???+ warning "阻塞和非阻塞模式"

    `ENV_IO_BLOCKING_MODE` 默认是关闭的，即非阻塞模式。在非阻塞模式下，如果处理队列（`ENV_IO_QUEUE_SIZE`）拥塞，将导致采集器上报的数据被丢弃，但不会影响新数据的采集。而在阻塞模式下，如果队列拥塞，那么数据采集也一并阻塞住，直到处理队列空闲，才会恢复新数据的采集。

<!--
| ENV_IO_ENABLE_CACHE      | false  | 否     | 开启 IO 磁盘 cache                 |
| ENV_IO_CACHE_MAX_SIZE_GB | 1      | 否     | IO 磁盘 cache 大小                 |
| ENV_IO_MAX_CACHE_COUNT   | 1024   | 否     | IO cache 大小                      |
-->

`ENV_IO_FILTERS` 是一个 json 字符串，示例如下:

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

### 其它杂项 {#env-others}

| 环境变量名称                 | 类型     | 默认值         | 必须   | 说明                                                       |
| ---------:                   | ----:    | ---:           | ------ | ----                                                       |
| ENV_CLOUD_PROVIDER           | string   | 无             | 否     | 支持安装阶段填写云厂商(`aliyun/aws/tencent/hwcloud/azure`) |
| ENV_DCA_LISTEN               | string   | localhost:9531 | 否     | 可修改改地址，使得 [DCA](dca) 客户端能管理该 DataKit       |
| ENV_DCA_WHITE_LIST           | string   | 无             | 否     | 配置 DCA 白名单，以英文逗号分隔                            |
| ENV_HOSTNAME                 | string   | 无             | 否     | 默认为本地主机名，可安装时指定，如， `dk-your-hostname`    |
| ENV_IPDB                     | string   | 无             | 否     | 指定 IP 信息库类型，目前只支持 `iploc/geolite2` 两种       |
| ENV_ULIMIT                   | int      | 无             | 否     | 指定 Datakit 最大的可打开文件数                            |
| ENV_DATAWAY_TIMEOUT          | duration | 30s            | 否     | 设置 DataKit 请求 DataWay 的超时时间                       |
| ENV_DATAWAY_ENABLE_HTTPTRACE | bool     | false          | 否     | 在 debug 日志中输出 dataway HTTP 请求的网络日志            |
| ENV_DATAWAY_HTTP_PROXY       | string   | 无             | 否     | 设置 DataWay HTTP 代理                                     |

### 特殊环境变量 {#env-special}

#### ENV_K8S_NODE_NAME

当 k8s node 名称跟其对应的主机名不同时，可将 k8s 的 node 名称顶替默认采集到的主机名，在 *datakit.yaml* 中增加环境变量：

> [1.2.19](changelog.md#cl-1.2.19) 版本的 datakit.yaml 中默认就带了这个配置，如果是从老版本的 yaml 直接升级而来，需要对 *datakit.yaml* 做如下手动改动。

```yaml
- env:
	- name: ENV_K8S_NODE_NAME
		valueFrom:
			fieldRef:
				apiVersion: v1
				fieldPath: spec.nodeName
```

### 各个采集器专用环境变量

部分采集器支持外部注入环境变量，以调整采集器自身的默认配置。具体参见各个具体的采集器文档。

## 延伸阅读

- [DataKit 选举](election.md)
- [DataKit 的几种配置方式](../integrations/k8s-config-how-to.md)
- [DataKit DaemonSet 配置管理最佳实践](../integrations/datakit-daemonset-bp.md)
