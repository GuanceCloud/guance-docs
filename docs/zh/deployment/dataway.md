# Dataway
---

## 简介 {#intro}

DataWay 是观测云的数据网关，采集器上报数据到观测云都需要经过 DataWay 网关。

## Dataway 安装 {#install}

- **新建 Dataway**

在观测云管理后台「数据网关」页面，点击「新建 Dataway 」。输入名称、绑定地址后，点击「创建」。

创建成功后会自动创建新的 Dataway 并生成 Dataway 的安装脚本。

<!-- markdownlint-disable MD046 -->
???+ info

    绑定地址即 Dataway 网关地址，必须填写完整的 HTTP 地址，例如 `http(s)://1.2.3.4:9528`，包含协议、主机地址和端口， 主机地址一般可使用部署 Dataway 机器的 IP 地址，也可以指定为一个域名，域名需做好解析。

    注意：需确保采集器能够访问该地址，否则数据将采集将不成功）
<!-- markdownlint-enable -->

- **安装 Dataway**

<!-- markdownlint-disable MD046 -->
=== "主机安装"

    ```shell
    DW_KODO=http://kodo_ip:port \
       DW_TOKEN=<tkn_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> \
       DW_UUID=<YOUR_UUID> \
       bash -c "$(curl https://static.guance.com/dataway/install.sh)"
    ```

    安装完成后，在安装目录下，会生成 *dataway.yaml*，其内容示例如下，可手动修改，通过重启服务来生效。

    ??? info "*dataway.yaml*（单击点开）"

        ```yaml
        uuid                  : not-set
        token                 : tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        secret_token          : ""
        enable_internal_token : false
        enable_empty_token    : false
        http_timeout          : 30s
        insecure_skip_verify  : false
        remote_host           : https://kodo.guance.com:443
        cascaded              : false
        bind                  : 0.0.0.0:9528
        api_limit_rate        : 100000
        max_http_body_bytes   : 67108864
        heartbeat_second      : 60
        http_client_trace     : true
        white_list            : []

        log       : log
        log_level : debug
        gin_log   : gin.log

        cache_cfg:
          disabled            : false
          max_disk_size       : 20480
          max_data_size       : 67108864
          batch_size          : 67108864
          dir                 : disk_cache
          clean_interval      : 30s
          expire_duration     : 24h

        sinker: null

        prometheus:
          url                 : /metrics
          listen              : 0.0.0.0:9091
          enable              : true
          disablegometrics    : false
        ```

=== "Kubernetes"

    下载 [*dataway.yaml*](https://static.guance.com/dataway/dataway.yaml){:target="_blank"}，安装：

    ```shell
    $ wget https://static.guance.com/dataway/dataway.yaml -O dw-deployment.yaml
    $ kubectl apply -f dw-deployment.yaml
    ```

    在 *dw-deployment.yaml* 中可通过环境变量修改 Dataway 配置，参见[这里](dataway.md#img-envs)。

    也可以通过 ConfigMap 外挂一个 *dataway.yaml*，但必须将其挂载成 */usr/local/cloudcare/dataflux/dataway/dataway.yaml*：

    ```yaml
    containers:
      volumeMounts:
        - name: dataway-config
          mountPath: /usr/local/cloudcare/dataflux/dataway/dataway.yaml
          subPath: config.yaml
    volumes:
    - configMap:
        defaultMode: 256
        name: dataway-config
        optional: false
      name: dataway-config
    ```
---

???+ note "注意事项"

    - 只能在 Linux 系统上运行
    - 主机安装时，Dataway 安装路径为 */usr/local/cloudcare/dataflux/dataway*
    - Kubernetes 下默认设置了 4000m/4Gi 的资源限制，可根据实际情况做调整。最低要求为 100m/512Mi
<!-- markdownlint-enable -->

- **验证 Dataway 安装**

安装完毕后，等待片刻刷新「数据网关」页面，如果在刚刚添加的数据网关的「版本信息」列中看到了版本号，即表示这个 Dataway 已成功与观测云中心连接，前台用户可以通过它来接入数据了。

Dataway 成功与观测云中心连接后，登录观测云控制台，在「集成」/「DataKit」页面，即可查看所有的 Dataway 地址，选择需要的 Dataway 网关地址，获取 DataKit 安装指令在服务器上执行，即可开始采集数据。

## 管理 DataWay {#manage}

### 删除 DataWay {#delete}

在观测云管理后台「数据网关」页面，选择需要删除的 DataWay ，点击「配置」，在弹出的编辑 DataWay 对话框，点击左下角「删除」按钮即可。

<!-- markdownlint-disable MD046 -->
???+ attention

    删除 DataWay 后，还需登录部署 DataWay 网关的服务器中停止 DataWay 的运行，然后删除安装目录才可彻底删除 DataWay。
<!-- markdownlint-enable -->

### 升级 DataWay {#upgrade}

在观测云管理后台「数据网关」页面，如果 DataWay 存在可升级的版本，版本信息处会有升级提示。

<!-- markdownlint-disable MD046 -->
=== "主机升级"

    ```shell
    DW_UPGRADE=1 bash -c "$(curl https://static.guance.com/dataway/install.sh)"
    ```

=== "Kubernetes 升级"

    直接替换镜像版本即可：

    ```yaml
    - image: pubrepo.jiagouyun.com/dataflux/dataway:<VERSION>
    ```
<!-- markdownlint-enable -->

### Dataway 服务管理 {#manage-service}

主机安装 Dataway 时，可用如下命令管理 Dataway 服务。

``` shell
# 启动
$ systemctl start dataway

# 重启
$ systemctl restart dataway

# 停止
$ systemctl stop dataway
```

Kubernetes 重启对应的 Pod 即可。

## 环境变量 {#dw-envs}

### 主机安装支持环境变量 {#install-envs}

主机安装时，可以在安装命令中注入如下环境变量：

| Env                  | 是否必需 | 说明                                                                                               | 取值 |
| ---                  | ---      | ---                                                                                                | ---  |
| DW_BIND              | N        | Dataway HTTP API 绑定地址，默认 `0.0.0.0:9528`                                                     |      |
| DW_CASCADED          | N        | Dataway 是否级联                                                                                   | "on" |
| DW_ETCD_HOST         | N        | etcd 地址，目前仅支持指定单个地址，如 `http://1.2.3.4:2379`                                        |      |
| DW_ETCD_PASSWORD     | N        | etcd 密码                                                                                          |      |
| DW_ETCD_USERNAME     | N        | etcd 用户名                                                                                        |      |
| DW_HTTP_CLIENT_TRACE | N        | Dataway 自己作为 HTTP 客户端，可以开启一些相关的指标收集，这些指标最终会在其 Prometheus 指标中输出 | `on` |
| DW_KODO              | Y        | Kodo 地址，或下一个 Dataway 地址，形如 `http://host:port`                                          |      |
| DW_SECRET_TOKEN      | N        | 当开启 Sinker 功能时，可设置一下该 Token                                                           |      |
| DW_TOKEN             | Y        | 一般是系统工作空间的数据 Token                                                                     |      |
| DW_UPGRADE           | N        | 升级时将其指定为 1                                                                                 |      |
| DW_UUID              | Y        | Dataway UUID，这个在新建 Dataway 的时候，系统工作空间会生成                                        |      |

### 镜像环境变量 {#img-envs}

Dataway 在 Kubernetes 环境中运行时，支持如下环境变量。

??? attention "兼容已有 dataway.yaml"

    由于一些老的 Dataway 是通过 ConfigMap 方式来注入配置的（挂到容器中的文件名一般都是 *dataway.yaml*），
    如果 Dataway 镜像启动后，发现安装目录中存在 ConfigMap 挂进来的文件，则下述 `DW_*` 环境变量将不生效。
    移除已有的 ConfigMap 挂载后，这些环境变量方可生效。

    如果环境变量生效，则在 Dataway 安装目录下会有一个隐藏（通过 `ls -a` 查看）的 *.dataway.yaml* 文件，可以 `cat`
    该文件以确认环境变量的生效情况。

#### API 有关 {#env-apis}

| Env                         | 是否必需 | 说明                                                                                               | 取值 |
| ---                         | ---      | ---                                                                                                | ---  |
| DW_REMOTE_HOST              | Y        | Kodo 地址，或下一个 Dataway 地址，形如 `http://host:port`                                          |      |
| DW_WHITE_LIST               | N        | Dataway 客户端 IP 白名单，以英文 `,` 分割                                                          |      |
| DW_HTTP_TIMEOUT             | N        | Dataway 请求 Kodo 或下一个 Dataway 的超时设置，默认 30s                                            |      |
| DW_BIND                     | N        | Dataway HTTP API 绑定地址，默认 `0.0.0.0:9528`                                                     |      |
| DW_API_LIMIT                | N        | Dataway API 限流设置，如设置为 1000，则每个具体的 API 在 1s 以内只允许请求 1000 次，默认 100K      |      |
| DW_HEARTBEAT                | N        | Dataway 跟中心的心跳间隔，默认 60s                                                                 |      |
| DW_MAX_HTTP_BODY_BYTES      | N        | Dataway API 允许的最大 HTTP Body（单位字节），默认 64MB                                            |      |
| DW_TLS_INSECURE_SKIP_VERIFY | N        | 忽略 HTTPS/TLS 证书错误                                                                            | `on` |
| DW_HTTP_CLIENT_TRACE        | N        | Dataway 自己作为 HTTP 客户端，可以开启一些相关的指标收集，这些指标最终会在其 Prometheus 指标中输出 | `on` |

#### 日志有关 {#env-logging}

| Env          | 是否必需 | 说明                   | 取值 |
| ---          | ---      | ---                    | ---  |
| DW_LOG       | N        | 日志路径，默认为 *log* |      |
| DW_LOG_LEVEL | N        | 默认为 `info`          |      |
| DW_GIN_LOG   | N        | 默认为 *gin.log*       |      |

#### Token/UUID 设置 {#env-token-uuid}

| Env                      | 是否必需 | 说明                                                                     | 取值 |
| ---                      | ---      | ---                                                                      | ---  |
| DW_UUID                  | Y        | Dataway UUID，这个在新建 Dataway 的时候，系统工作空间会生成              |      |
| DW_TOKEN                 | Y        | 一般是系统工作空间的数据 Token                                           |      |
| DW_SECRET_TOKEN          | N        | 当开启 Sinker 功能时，可设置一下该 Token                                 |      |
| DW_ENABLE_INTERNAL_TOKEN | N        | 允许以 `__internal__` 作为客户端 Token，此时默认使用系统工作空间的 Token |      |
| DW_ENABLE_EMPTY_TOKEN    | N        | 允许不使用 Token 上传数据，此时默认使用系统工作空间的 Token              |      |

#### Sinker 有关设置 {#env-sinker}

| Env                         | 是否必需 | 说明                                                                     | 取值 |
| ---                         | ---      | ---                                                                      | ---  |
| DW_CASCADED                 | N        | Dataway 是否级联                                                         | "on" |
| DW_SINKER_ETCD_URLS         | N        | etcd 地址列表，以 `,` 分割，如 `http://1.2.3.4:2379,http://1.2.3.4:2380` |      |
| DW_SINKER_ETCD_DIAL_TIMEOUT | N        | etcd 连接超时，默认 30s                                                  |      |
| DW_SINKER_ETCD_KEY_SPACE    | N        | Sinker 配置所在的 etcd key 名称（默认 `/dw_sinker`）                     |      |
| DW_SINKER_ETCD_USERNAME     | N        | etcd 用户名                                                              |      |
| DW_SINKER_ETCD_PASSWORD     | N        | etcd 密码                                                                |      |
| DW_SINKER_FILE_PATH         | N        | 通过本地文件来指定 sinker 规则配置                                       |      |

<!-- markdownlint-disable MD046 -->
???+ attention

    如果同时指定本地文件和 etcd 两种方式，则优先采用本地文件中的 Sinker 规则。
<!-- markdownlint-enable -->

#### Prometheus 指标暴露 {#env-metrics}

| Env              | 是否必需 | 说明                                             | 取值 |
| ---              | ---      | ---                                              | ---  |
| DW_PROM_URL      | N        | Prometheus 指标的 URL Path（默认 `/metrics`）    |      |
| DW_PROM_LISTEN   | N        | Prometheus 指标暴露地址（默认 `localhost:9090`） |      |
| DW_PROM_DISABLED | N        | 禁用 Prometheus 指标暴露                         | "on" |

#### 磁盘缓存设置 {#env-diskcache}

| Env                          | 是否必需 | 说明                                               | 取值                               |
| ---                          | ---      | ---                                                | ---                                |
| DW_DISKCACHE_DIR             | N        | 设置缓存目录，**该目录一般外挂存储**               | *path/to/your/cache*               |
| DW_DISKCACHE_DISABLE         | N        | 禁用磁盘缓存，**如果不禁用缓存，需删除该环境变量** | "on"                               |
| DW_DISKCACHE_CLEAN_INTERVAL  | N        | 缓存清理间隔（默认 30s）                           | Duration 字符串                    |
| DW_DISKCACHE_EXPIRE_DURATION | N        | 缓存过期时间（默认 24h）                           | Duration 字符串，如 `72h` 表示三天 |

## Dataway API 列表 {#apis}

> 以下各个 API 详情待补充。

### `POST /v1/write/:category` {#v1-write-category}

- API 说明：接收 Datakit 上传的各种采集数据

### `GET /v1/datakit/pull` {#v1-datakit-pull}

- API 说明：处理 Datakit 拉取中心配置（黑名单/Pipeline）请求

### `POST /v1/write/rum/replay` {#v1-write-rum-replay}

- API 说明：接收 Datakit 上传的 Session Replay 数据

### `POST /v1/upload/profiling` {#v1-upload-profiling}

- API 说明：接收 Datakit 上传的 Profiling 数据

### `POST /v1/election` {#v1-election}

- API 说明：处理 Datakit 的选举请求

### `POST /v1/election/heartbeat` {#v1-election-heartbeat}

- API 说明：处理 Datakit 的选举心跳请求

### `POST /v1/query/raw` {#v1-query-raw}

- API 说明：处理 Datakit 端发起的 DQL 查询请求

### `POST /v1/workspace` {#v1-workspace}

- API 说明：处理 Datakit 端发起的工作空间查询请求

### `POST /v1/object/labels` {#v1-object-labels}

- API 说明：处理修改对象 Label 请求

### `DELETE /v1/object/labels` {#v1-delete-object-labels}

- API 说明：处理删除对象 Label 请求

### `GET /v1/check/:token` {#v1-check-token}

- API 说明：检测 tokken 是否合法

## Dataway 指标采集 {#collect-metrics}

<!-- markdownlint-disable MD046 -->
???+ attention "HTTP client 指标采集"

    如果要采集 Dataway HTTP 请求 Kodo（或者下一跳 Dataway）的指标，需要手动开启 `http_client_trace` 配置。也可以在安装阶段，指定 `DW_HTTP_CLIENT_TRACE=on`。

=== "主机部署"

    Dataway 自身暴露了 Prometheus 指标，通过 Datakit 自带的 `prom` 采集器能采集其指标，采集器示例配置如下：

    ```toml
    [[inputs.prom]]
      ## Exporter URLs.
      urls = [ "http://localhost:9090/metrics", ]

      source = "dataway"

      election = true

      ## dataway 指标集固定为 dw，不要更改
      measurement_name = "dw"
    ```

=== "Kubernetes"

    如果集群中有部署 Datakit（需 [Datakit 1.14.2](../datakit/changelog.md#cl-1.14.2) 以上版本），那么可以在 Dataway 中开启 Prometheus 指标暴露：

    ```yaml
    annotations: # 以下 annotation 默认已添加
       datakit/prom.instances: |
         [[inputs.prom]]
           url = "http://$IP:9090/metrics" # 此处端口（默认 9090）视情况而定
           source = "dataway"
           measurement_name = "dw" # 固定为该指标集
           interval = "30s"

           [inputs.prom.tags]
             namespace = "$NAMESPACE"
             pod_name = "$PODNAME"
             node_name = "$NODENAME"

    ...
    env:
    - name: DW_PROM_LISTEN
      value: "0.0.0.0:9090" # 此处端口保持跟上面 url 中端口一致
    ```

<!-- markdownlint-enable -->

---

如果采集成功，在观测云「场景」/「内置视图」中搜索 `dataway` 即可看到对应的监控视图。

### Dataway 指标列表 {#metrics}

以下是 Dataway 暴露的指标，通过请求 `http://localhost:9090/metrics` 即可获取这些指标，可通过如下命令实时查看（3s）某个具体的指标：

> 某些指标如果查询不到，可能是相关业务模块尚未运行所致。

```shell
watch -n 3 'curl -s http://localhost:9090/metrics | grep -a <METRIC-NAME>'
```

|TYPE|NAME|LABELS|HELP|
|---|---|---|---|
|COUNTER|`dataway_http_api_dropped_total`|`api,method`|API request dropped when sinker rule match failed|
|COUNTER|`dataway_http_api_signed_total`|`api,method`|API signature count|
|SUMMARY|`dataway_http_api_reusable_body_read_bytes`|`api,method`|API re-read body on forking request|
|COUNTER|`dataway_http_api_forked_total`|`api,method,token`|API request forked total|
|GAUGE|`dataway_http_info`|`cascaded,docker,http_client_trace,listen,release_date,remote,secret,token,version`|Dataway API basic info|
|GAUGE|`dataway_cpu_usage`|`N/A`|Dataway CPU usage(%)|
|GAUGE|`dataway_open_files`|`N/A`|Dataway open files|
|GAUGE|`dataway_cpu_cores`|`N/A`|Dataway CPU cores|
|COUNTER|`dataway_process_ctx_switch_total`|`N/A`|Dataway process context switch count(Linux only)|
|COUNTER|`dataway_process_io_count_total`|`N/A`|Dataway process IO count count|
|COUNTER|`dataway_process_io_bytes_total`|`N/A`|Dataway process IO bytes count|
|GAUGE|`dataway_last_heartbeat_time`|`N/A`|Dataway last heartbeat with Kodo timestamp|
|SUMMARY|`dataway_http_api_dropped_expired_cache`|`api,method`|Dropped expired cache data|
|SUMMARY|`dataway_http_api_elapsed_seconds`|`api,method,status`|API request latency|
|SUMMARY|`dataway_http_api_req_size_bytes`|`api,method,status`|API request size|
|COUNTER|`dataway_http_api_total`|`api,method,status`|API request count|
|COUNTER|`dataway_httpcli_tcp_conn_total`|`server,remote,type`|HTTP TCP connection count|
|COUNTER|`dataway_httpcli_conn_reused_from_idle_total`|`server`|HTTP connection reused from idle count|
|SUMMARY|`dataway_httpcli_conn_idle_time_seconds`|`server`|HTTP connection idle time|
|SUMMARY|`dataway_httpcli_dns_cost_seconds`|`server`|HTTP DNS cost|
|SUMMARY|`dataway_httpcli_tls_handshake_seconds`|`server`|HTTP TLS handshake cost|
|SUMMARY|`dataway_httpcli_http_connect_cost_seconds`|`server`|HTTP connect cost|
|SUMMARY|`dataway_httpcli_got_first_resp_byte_cost_seconds`|`server`|Got first response byte cost|
|COUNTER|`dataway_sinker_pull_total`|`event,source`|Sinker pulled or pushed counter|
|GAUGE|`dataway_sinker_rule_error`|`error`|Rule errors|
|GAUGE|`dataway_sinker_rule_last_applied_time`|`source`|Rule last applied time(Unix timestamp)|
|SUMMARY|`dataway_sinker_rule_cost_seconds`|`N/A`|Rule cost time seconds|
|COUNTER|`diskcache_put_total`|`N/A`|cache Put() count|
|COUNTER|`diskcache_put_bytes_total`|`N/A`|cache Put() bytes count|
|COUNTER|`diskcache_get_total`|`N/A`|cache Get() count|
|COUNTER|`diskcache_wakeup_total`|`N/A`|wakeup count on sleeping write file|
|COUNTER|`diskcache_get_bytes_total`|`N/A`|cache Get() bytes count|
|GAUGE|`diskcache_capacity`|`N/A`|current capacity(in bytes)|
|GAUGE|`diskcache_max_data`|`N/A`|max data to Put(in bytes), default 0|
|GAUGE|`diskcache_batch_size`|`N/A`|data file size(in bytes)|
|GAUGE|`diskcache_size`|`N/A`|current cache size(in bytes)|
|GAUGE|`diskcache_open_time`|`N/A`|current cache Open time in unix timestamp(second)|
|GAUGE|`diskcache_last_close_time`|`N/A`|current cache last Close time in unix timestamp(second)|
|GAUGE|`diskcache_datafiles`|`N/A`|current un-read data files|
|SUMMARY|`diskcache_get_latency`|`N/A`|Get() time cost(micro-second)|
|SUMMARY|`diskcache_put_latency`|`N/A`|Put() time cost(micro-second)|
|COUNTER|`diskcache_dropped_bytes_total`|`N/A`|dropped bytes during Put() when capacity reached.|
|COUNTER|`diskcache_dropped_total`|`N/A`|dropped files during Put() when capacity reached.|
|COUNTER|`diskcache_rotate_total`|`N/A`|cache rotate count, mean file rotate from data to data.0000xxx|
|COUNTER|`diskcache_remove_total`|`N/A`|removed file count, if some file read EOF, remove it from un-read list|
