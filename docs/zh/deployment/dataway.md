<!-- 不要在 dataflux-doc 仓库直接修改本文件，该文件由 Dataway 项目自动导出 -->

# Dataway
---

## 简介 {#intro}

DataWay 是<<< custom_key.brand_name >>>的数据网关，采集器上报数据到<<< custom_key.brand_name >>>都需要经过 DataWay 网关。

## Dataway 安装 {#install}

- **新建 Dataway**

在<<< custom_key.brand_name >>>管理后台「数据网关」页面，点击「新建 Dataway 」。输入名称、绑定地址后，点击「创建」。

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
       bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/dataway/install.sh)"
    ```

    安装完成后，在安装目录下，会生成 *dataway.yaml*，其内容示例如下，可手动修改，通过重启服务来生效。

    ??? info "*dataway.yaml*（单击点开）"

        ```yaml
        # ============= DATAWAY CONFIG =============
        
        # Dataway UUID, we can get it on during create a new dataway
        uuid:
        
        # It's the workspace token, most of the time, it's
        # system worker space's token.
        token:
        
        # secret_token used under sinker mode, and to check if incomming datakit
        # requests are valid.
        secret_token:
        
        # If __internal__ token allowed? If ok, the data/request will direct to
        # the workspace with the token above
        enable_internal_token: false
        
        # is empty token allowed? If ok, the data/request will direct to
        # the workspace with the token above
        enable_empty_token: false
        
        # Is dataway cascaded? For cascaded Dataway, it's remote_host is
        # another Dataway and not Kodo.
        cascaded: false
        
        # kodo(next dataway) related configures
        remote_host:
        http_timeout: 30s
        
        http_max_idle_conn_perhost: 0 # default to CPU cores
        http_max_conn_perhost: 0      # default no limit
        
        insecure_skip_verify: false
        http_client_trace: false
        max_conns_per_host: 0
        sni: ""
        
        # dataway API configures
        bind: 0.0.0.0:9528
        
        # disable 404 page
        disable_404page: false
        
        # dataway TLS file path
        tls_crt:
        tls_key:
        
        # enable pprof
        pprof_bind: localhost:6060
        
        api_limit_rate : 100000         # 100K
        max_http_body_bytes : 67108864  # 64MB
        copy_buffer_drop_size : 262144  # 256KB, if copy buffer memory larger than this, this memory released
        reserved_pool_size: 4096        # reserved pool size for better GC
        
        within_docker: false
        
        log_level: info
        log: log
        gin_log: gin.log
        
        cache_cfg:
          # cache disk path
          dir: "disk_cache"
        
          # disable cache
          disabled: false
        
          clean_interval: "10s"
        
          # in MB, max single data package size in disk cache, such as HTTP body
          max_data_size: 100
        
          # in MB, single disk-batch(single file) size
          batch_size: 128
        
          # in MB, max disk size allowed to cache data
          max_disk_size: 65535
        
          # expire duration, default 7 days
          expire_duration: "168h"
        
        prometheus:
          listen: "localhost:9090"
          url: "/metrics"
          enable: true
        
        #sinker:
        #  etcd:
        #    urls:
        #    - http://localhost:2379 # one or multiple etcd host
        #    dial_timeout: 30s
        #    key_space: "/dw_sinker" # subscribe to the etcd key
        #    username: "dataway"
        #    password: "<PASSWORD>"
        #  #file:
        #  #  path: /path/to/sinker.json
        ```

=== "Kubernetes"

    下载 [*dataway.yaml*](https://static.<<< custom_key.brand_main_domain >>>/dataway/dataway.yaml){:target="_blank"}，安装：

    ```shell
    $ wget https://static.<<< custom_key.brand_main_domain >>>/dataway/dataway.yaml -O dw-deployment.yaml
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

    - Dataway 只能在 Linux 系统上运行（目前只发布了 Linux arm64/amd64 二进制）
    - 主机安装时，Dataway 安装路径为 */usr/local/cloudcare/dataflux/dataway*
    - Kubernetes 下默认设置了 4000m/4Gi 的资源限制，可根据实际情况做调整。最低要求为 100m/512Mi
<!-- markdownlint-enable -->

- **验证 Dataway 安装**

安装完毕后，等待片刻刷新「数据网关」页面，如果在刚刚添加的数据网关的「版本信息」列中看到了版本号，即表示这个 Dataway 已成功与<<< custom_key.brand_name >>>中心连接，前台用户可以通过它来接入数据了。

Dataway 成功与<<< custom_key.brand_name >>>中心连接后，登录<<< custom_key.brand_name >>>控制台，在「集成」/「DataKit」页面，即可查看所有的 Dataway 地址，选择需要的 Dataway 网关地址，获取 DataKit 安装指令在服务器上执行，即可开始采集数据。

## 管理 DataWay {#manage}

### 删除 DataWay {#delete}

在<<< custom_key.brand_name >>>管理后台「数据网关」页面，选择需要删除的 DataWay ，点击「配置」，在弹出的编辑 DataWay 对话框，点击左下角「删除」按钮即可。

<!-- markdownlint-disable MD046 -->
???+ warning

    删除 DataWay 后，还需登录部署 DataWay 网关的服务器中停止 DataWay 的运行，然后删除安装目录才可彻底删除 DataWay。
<!-- markdownlint-enable -->

### 升级 DataWay {#upgrade}

在<<< custom_key.brand_name >>>管理后台「数据网关」页面，如果 DataWay 存在可升级的版本，版本信息处会有升级提示。

<!-- markdownlint-disable MD046 -->
=== "主机升级"

    ```shell
    DW_UPGRADE=1 bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/dataway/install.sh)"
    ```

=== "Kubernetes 升级"

    直接替换镜像版本即可：

    ```yaml
    - image: pubrepo.<<< custom_key.brand_main_domain >>>/dataflux/dataway:<VERSION>
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

> 主机安装的方式我们已经不再推荐，新增的配置项也不再支持通过命令行参数方式来配置。如果无法更改部署方式，建议安装（升级）完后手动修改对应配置。默认配置，参见上面的默认配置示例。

主机安装时，可以在安装命令中注入如下环境变量：

| Env                   | 类型      | 是否必需 | 说明                                                                                                               | 取值示例 |
| ---                   | ---       | ---      | ---                                                                                                                | ---      |
| DW_BIND               | string    | N        | Dataway HTTP API 绑定地址，默认 `0.0.0.0:9528`                                                                     |          |
| DW_CASCADED           | boolean   | N        | Dataway 是否级联                                                                                                   | `true`   |
| DW_HTTP_CLIENT_TRACE  | boolean   | N        | Dataway 自己作为 HTTP 客户端，可以开启一些相关的指标收集，这些指标最终会在其 Prometheus 指标中输出                 | `true`   |
| DW_KODO               | string    | Y        | Kodo 地址，或下一个 Dataway 地址，形如 `http://host:port`                                                          |          |
| DW_TOKEN              | string    | Y        | 一般是系统工作空间的数据 Token                                                                                     |          |
| DW_UPGRADE            | boolean   | N        | 升级时将其指定为 1                                                                                                 |          |
| DW_UUID               | string    | Y        | Dataway UUID，这个在新建 Dataway 的时候，系统工作空间会生成                                                        |          |
| DW_TLS_CRT            | file-path | N        | 指定 HTTPS/TLS crt 文件目录 [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                       |          |
| DW_TLS_KEY            | file-path | N        | 指定 HTTPS/TLS key 文件目录 [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                       |          |
| DW_PROM_EXPORTOR_BIND | string    | N        | 指定 Dataway 自身指标暴露的 HTTP 端口（默认 9090）[:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0) |          |
| DW_PPROF_BIND         | string    | N        | 指定 Dataway 自身 pprof HTTP 端口（默认 6060）[:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)     |          |
| DW_DISK_CACHE_CAP_MB  | int       | N        | 指定磁盘缓存大小（单位 MB），默认 65535MB [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)         |          |

<!-- markdownlint-disable MD046 -->
???+ warning

    Sinker 有关的设置，需安装完之后，手动修改。目前不支持在安装过程中指定 Sinker 的配置。 [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0-brk)
<!-- markdownlint-enable -->

### 镜像环境变量 {#img-envs}

Dataway 在 Kubernetes 环境中运行时，支持如下环境变量。

<!-- markdownlint-disable MD046 -->
???+ warning "兼容已有 dataway.yaml"

    由于一些老的 Dataway 是通过 ConfigMap 方式来注入配置的（挂到容器中的文件名一般都是 *dataway.yaml*），
    如果 Dataway 镜像启动后，发现安装目录中存在 ConfigMap 挂进来的文件，则下述 `DW_*` 环境变量将不生效。
    移除已有的 ConfigMap 挂载后，这些环境变量方可生效。

    如果环境变量生效，则在 Dataway 安装目录下会有一个隐藏（通过 `ls -a` 查看）的 *.dataway.yaml* 文件，可以 `cat`
    该文件以确认环境变量的生效情况。
<!-- markdownlint-enable -->

#### HTTP Server 设置 {#env-apis}

| Env                           | 类型      | 是否必需 | 说明                                                                                                                            | 取值示例 |
| ---                           | ---       | ---      | ---                                                                                                                             | ---      |
| DW_REMOTE_HOST                | string    | Y        | Kodo 地址，或下一个 Dataway 地址，形如 `http://host:port`                                                                       |          |
| DW_WHITE_LIST                 | string    | N        | Dataway 客户端 IP 白名单，以英文 `,` 分割                                                                                       |          |
| DW_HTTP_TIMEOUT               | string    | N        | Dataway 请求 Kodo 或下一个 Dataway 的超时设置，默认 30s                                                                         |          |
| DW_HTTP_MAX_IDLE_CONN_PERHOST | int       | N        | Dataway 请求 Kodo 最大 idle connection 设置，默认值为 CPU cores[:octicons-tag-24: Version-1.6.2](dataway-changelog.md#cl-1.6.2) |          |
| DW_HTTP_MAX_CONN_PERHOST      | int       | N        | Dataway 请求 Kodo 最大连接数设置，默认不限制[:octicons-tag-24: Version-1.6.2](dataway-changelog.md#cl-1.6.2)                    |          |
| DW_BIND                       | string    | N        | Dataway HTTP API 绑定地址，默认 `0.0.0.0:9528`                                                                                  |          |
| DW_API_LIMIT                  | int       | N        | Dataway API 限流设置，如设置为 1000，则每个具体的 API 在 1s 以内只允许请求 1000 次，默认 100K                                   |          |
| DW_HEARTBEAT                  | string    | N        | Dataway 跟中心的心跳间隔，默认 60s                                                                                              |          |
| DW_MAX_HTTP_BODY_BYTES        | int       | N        | Dataway API 允许的最大 HTTP Body（**单位字节**），默认 64MB                                                                     |          |
| DW_TLS_INSECURE_SKIP_VERIFY   | boolean   | N        | 忽略 HTTPS/TLS 证书错误                                                                                                         | `true`   |
| DW_HTTP_CLIENT_TRACE          | boolean   | N        | Dataway 自己作为 HTTP 客户端，可以开启一些相关的指标收集，这些指标最终会在其 Prometheus 指标中输出                              | `true`   |
| DW_ENABLE_TLS                 | boolean   | N        | 启用 HTTPS [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                                                     |          |
| DW_TLS_CRT                    | file-path | N        | 指定 HTTPS/TLS crt 文件目录 [:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                    |          |
| DW_TLS_KEY                    | file-path | N        | 指定 HTTPS/TLS key 文件目录[:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                     |          |
| DW_SNI                        | string    | N        | 指定当前 Dataway SNI 信息[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)                                       |          |
| DW_DISABLE_404PAGE            | boolean   | N        | 禁用 404 页面[:octicons-tag-24: Version-1.6.1](dataway-changelog.md#cl-1.6.1)                                                   |          |

[^1]: 该限制用来避免 Dataway 容器/Pod 运行时，受系统限制，只能使用大约 20000 个连接。增加限制后，会影响 Dataway 数据上传的效率。在 Dataway 流量大的时候，可以考虑增加单个 Dataway 的 CPU 数量，或者水平扩容 Dataway 实例。

##### HTTP TLS 设置 {#http-tls}

要生成一个有效期为一年的 TLS 证书，您可以使用以下 OpenSSL 命令：

```shell
# 生成有效期一年的 TLS 证书
$ openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out tls.crt -keyout tls.key
...
```

执行该命令后，系统会提示您输入一些必要信息，包括您的国家、地区、城市、组织名称、部门名称以及您的电子邮件地址。这些信息将被包含在您的证书中。

完成信息输入后，您将生成两个文件：*tls.crt*（证书文件）和 *tls.key*（私钥文件）。请妥善保管您的私钥文件，并确保其安全性。

为了使应用程序能够使用这些 TLS 证书，您需要将这两个文件的绝对路径设置到应用程序的环境变量中。以下是设置环境变量的一个示例：

> 必须先开启 `DW_ENABLE_TLS`，另外两个 ENV （`DW_TLS_CRT/DW_TLS_KEY`）才会生效。 [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)

```yaml
env:
- name: DW_ENABLE_TLS
  value: "true"
- name: DW_TLS_CRT
  value: "/path/to/your/tls.crt"
- name: DW_TLS_KEY
  value: "/path/to/your/tls.key"
```

请将 `/path/to/your/tls.crt` 和 `/path/to/your/tls.key` 替换为您实际存放 `tls.crt` 和 `tls.key` 文件的路径。

设置完以后，可以用如下命令测试 TLS 是否生效：

```shell
$ curl -k http://localhost:9528
```

如果成功，会显示一个 `It's working!` 的 ASCII Art 信息。如果证书不存在，Dataway 日志中会有类似如下报错：

```text
server listen(TLS) failed: open /path/to/your/tls.{crt,key}: no such file or directory
```

此时 Dataway 无法启动，上面的 curl 命令也会报错：

```shell
$ curl -vvv -k http://localhost:9528
curl: (7) Failed to connect to localhost port 9528 after 6 ms: Couldn't connect to server
```

#### 日志设置 {#env-logging}

| Env          | 类型   | 是否必需 | 说明                   | 取值示例 |
| ---          | ---    | ---      | ---                    | ---      |
| DW_LOG       | string | N        | 日志路径，默认为 *log* |          |
| DW_LOG_LEVEL | string | N        | 默认为 `info`          |          |
| DW_GIN_LOG   | string | N        | 默认为 *gin.log*       |          |

#### Token/UUID 设置 {#env-token-uuid}

| Env                      | 类型    | 是否必需 | 说明                                                                     | 取值示例 |
| ---                      | ---     | ---      | ---                                                                      | ---      |
| DW_UUID                  | string  | Y        | Dataway UUID，这个在新建 Dataway 的时候，系统工作空间会生成              |          |
| DW_TOKEN                 | string  | Y        | 一般是系统工作空间的数据上传 Token                                       |          |
| DW_SECRET_TOKEN          | string  | N        | 当开启 Sinker 功能时，可设置一下该 Token                                 |          |
| DW_ENABLE_INTERNAL_TOKEN | boolean | N        | 允许以 `__internal__` 作为客户端 Token，此时默认使用系统工作空间的 Token |          |
| DW_ENABLE_EMPTY_TOKEN    | boolean | N        | 允许不使用 Token 上传数据，此时默认使用系统工作空间的 Token              |          |

#### Sinker 设置 {#env-sinker}

| Env                         | 类型      | 是否必需 | 说明                                                                     | 取值示例 |
| ---                         | ---       | ---      | ---                                                                      | ---      |
| DW_SECRET_TOKEN             | string    | N        | 开启 Sinker 功能时，可设置一下该 Token                                   |          |
| DW_CASCADED                 | string    | N        | Dataway 是否级联                                                         | `true`   |
| DW_SINKER_ETCD_URLS         | string    | N        | etcd 地址列表，以 `,` 分割，如 `http://1.2.3.4:2379,http://1.2.3.4:2380` |          |
| DW_SINKER_ETCD_DIAL_TIMEOUT | string    | N        | etcd 连接超时，默认 30s                                                  |          |
| DW_SINKER_ETCD_KEY_SPACE    | string    | N        | Sinker 配置所在的 etcd key 名称（默认 `/dw_sinker`）                     |          |
| DW_SINKER_ETCD_USERNAME     | string    | N        | etcd 用户名                                                              |          |
| DW_SINKER_ETCD_PASSWORD     | string    | N        | etcd 密码                                                                |          |
| DW_SINKER_FILE_PATH         | file-path | N        | 通过本地文件来指定 sinker 规则配置                                       |          |

<!-- markdownlint-disable MD046 -->
???+ warning

    如果同时指定本地文件和 etcd 两种方式，则优先采用本地文件中的 Sinker 规则。
<!-- markdownlint-enable -->

#### Prometheus 指标暴露 {#env-metrics}

| Env              | 类型    | 是否必需 | 说明                                             | 取值示例 |
| ---              | ---     | ---      | ---                                              | ---      |
| DW_PROM_URL      | string  | N        | Prometheus 指标的 URL Path（默认 `/metrics`）    |          |
| DW_PROM_LISTEN   | string  | N        | Prometheus 指标暴露地址（默认 `localhost:9090`） |          |
| DW_PROM_DISABLED | boolean | N        | 禁用 Prometheus 指标暴露                         | `true`   |

#### 磁盘缓存设置 {#env-diskcache}

| Env                           | 类型      | 是否必需 | 说明                                                                                                                                                                  | 取值示例                           |
| ---                           | ---       | ---      | ---                                                                                                                                                                   | ---                                |
| DW_DISKCACHE_DIR              | file-path | N        | 设置缓存目录，**该目录一般外挂存储**                                                                                                                                  | *path/to/your/cache*               |
| DW_DISKCACHE_DISABLE          | boolean   | N        | 禁用磁盘缓存，**如果不禁用缓存，需删除该环境变量**                                                                                                                    | `true`                             |
| DW_DISKCACHE_CLEAN_INTERVAL   | string    | N        | 缓存清理间隔，默认 30s                                                                                                                                                | Duration 字符串                    |
| DW_DISKCACHE_EXPIRE_DURATION  | string    | N        | 缓存过期时间，默认 168h（7d）                                                                                                                                         | Duration 字符串，如 `72h` 表示三天 |
| DW_DISKCACHE_CAPACITY_MB      | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) 设置可用的磁盘空间大小，单位 MB，默认 20GB                                                           | 指定 `1024` 即 1GB                 |
| DW_DISKCACHE_BATCH_SIZE_MB    | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) 设置单个磁盘缓存文件最大大小，单位 MB，默认 64MB                                                     | 指定 `1024` 即 1GB                 |
| DW_DISKCACHE_MAX_DATA_SIZE_MB | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) 设置单个缓存内容（比如单个 HTTP body）最大大小，单位 MB，默认 64MB，超过该大小的单个数据包，会被丢弃 | 指定 `1024` 即 1GB                 |

<!-- markdownlint-disable MD046 -->
???+ tips

    设置 `DW_DISKCACHE_DISABLE` 即可禁用磁盘缓存。
<!-- markdownlint-enable -->

#### 性能相关设置 {#env-perfmance}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

| Env                      | 类型 | 是否必需 | 说明                                                                                       | 取值示例 |
| ---                      | ---  | ---      | ---                                                                                        | ---      |
| DW_COPY_BUFFER_DROP_SIZE | int  | N        | 单个超过指定大小（单位字节）的 HTTP body buffer 会立即清除，避免消耗太多内存。默认值 256KB | 524288   |

## Dataway API 列表 {#apis}

> 以下各个 API 详情待补充。

### `GET /v1/ntp/` {#v1-ntp}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

- API 说明：获取 Dataway 当前的 Unix 时间戳（单位秒）

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

处理 DQL 查询请求，简单示例如下：

``` text
POST /v1/query/raw?token=<workspace-token> HTTP/1.1
Content-Type: application/json

{
    "token": "workspace-token",
    "queries": [
        {
            "query": "M::cpu LIMIT 1"
        }
    ],
    "echo_explain": <true/false>
}
```

返回示例：

```json
{
  "content": [
    {
      "series": [
        {
          "name": "cpu",
          "columns": [
            "time",
            "usage_iowait",
            "usage_total",
            "usage_user",
            "usage_guest",
            "usage_system",
            "usage_steal",
            "usage_guest_nice",
            "usage_irq",
            "load5s",
            "usage_idle",
            "usage_nice",
            "usage_softirq",
            "global_tag1",
            "global_tag2",
            "host",
            "cpu"
          ],
          "values": [
            [
              1709782208662,
              0,
              7.421875,
              3.359375,
              0,
              4.0625,
              0,
              0,
              0,
              1,
              92.578125,
              0,
              0,
              null,
              null,
              "WIN-JCHUL92N9IP",
              "cpu-total"
            ]
          ]
        }
      ],
      "points": null,
      "cost": "24.558375ms",
      "is_running": false,
      "async_id": "",
      "query_parse": {
        "namespace": "metric",
        "sources": {
          "cpu": "exact"
        },
        "fields": {},
        "funcs": {}
      },
      "index_name": "",
      "index_store_type": "",
      "query_type": "guancedb",
      "complete": false,
      "index_names": "",
      "scan_completed": false,
      "scan_index": "",
      "next_cursor_time": -1,
      "sample": 1,
      "interval": 0,
      "window": 0
    }
  ]
}
```

返回结果说明：

- 真实的数据位于里层的 `series` 字段中
- `name` 表示指标集名字（此处查询的是 CPU 指标，如果是日志类数据，则没有该字段）
- `columns` 表示返回的结果列名称
- `values` 中即 `columns` 中对应的列结果

---

<!-- markdownlint-disable MD046 -->
???+ info

    - URL 请求参数中的 token 可以和 JSON body 中的 token 不同。前者用于验证查询请求是否合法，后者用于确定目标数据所在的工作空间。
    - `queries` 字段可以带多个查询，每个查询可以携带额外字段，具体字段列表，参见[这里](../datakit/apis.md#api-raw-query)
<!-- markdownlint-enable -->

---

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
???+ warning "HTTP client 指标采集"

    如果要采集 Dataway HTTP 请求 Kodo（或者下一跳 Dataway）的指标，需要手动开启 `http_client_trace` 配置。或者指定环境变量 `DW_HTTP_CLIENT_TRACE=true`。

=== "主机部署"

    Dataway 自身暴露了 Prometheus 指标，通过 Datakit 自带的 `prom` 采集器能采集其指标，采集器示例配置如下：

    ```toml
    [[inputs.prom]]
      ## Exporter URLs.
      urls = [ "http://localhost:9090/metrics", ]
      source = "dataway"
      election = true
      measurement_name = "dw" # dataway 指标集固定为 dw，不要更改
    [inputs.prom.tags]
      service = "dataway"
    ```

=== "Kubernetes"

    如果集群中有部署 Datakit（需 [Datakit 1.14.2](../datakit/changelog.md#cl-1.14.2) 以上版本），那么可以在 Dataway 中开启 Prometheus 指标暴露（Dataway 默认 POD yaml 已经自带）：

    ```yaml
    annotations: # 以下 annotation 默认已添加
       datakit/prom.instances: |
         [[inputs.prom]]
           url = "http://$IP:9090/metrics" # 此处端口（默认 9090）视情况而定
           source = "dataway"
           measurement_name = "dw" # 固定为该指标集
           interval = "10s"
           disable_instance_tag = true

         [inputs.prom.tags]
           service = "dataway"
           instance = "$PODNAME"

    ...
    env:
    - name: DW_PROM_LISTEN
      value: "0.0.0.0:9090" # 此处端口保持跟上面 url 中端口一致
    ```

<!-- markdownlint-enable -->

---

如果采集成功，在<<< custom_key.brand_name >>>「场景」/「内置视图」中搜索 `dataway` 即可看到对应的监控视图。

### Dataway 指标列表 {#metrics}

以下是 Dataway 暴露的指标，通过请求 `http://localhost:9090/metrics` 即可获取这些指标，可通过如下命令实时查看（3s）某个具体的指标：

> 某些指标如果查询不到，可能是相关业务模块尚未运行所致。某些新的指标只在最新版本中存在，此处不再一一标明各个指标的版本信息，以 `/metrics` 接口返回的指标列表为准。

```shell
watch -n 3 'curl -s http://localhost:9090/metrics | grep -a <METRIC-NAME>'
```

|TYPE|NAME|LABELS|HELP|
|---|---|---|---|
|SUMMARY|`dataway_http_api_elapsed_seconds`|`api,method,status`|API request latency|
|SUMMARY|`dataway_http_api_body_buffer_utilization`|`api`|API body buffer utillization(Len/Cap)|
|SUMMARY|`dataway_http_api_body_copy`|`api`|API body copy|
|SUMMARY|`dataway_http_api_resp_size_bytes`|`api,method,status`|API response size|
|SUMMARY|`dataway_http_api_req_size_bytes`|`api,method,status`|API request size|
|COUNTER|`dataway_http_api_total`|`api,status`|API request count|
|COUNTER|`dataway_http_api_body_too_large_dropped_total`|`api,method`|API request too large dropped|
|COUNTER|`dataway_http_api_with_inner_token`|`api,method`|API request with inner token|
|COUNTER|`dataway_http_api_dropped_total`|`api,method`|API request dropped when sinker rule match failed|
|COUNTER|`dataway_syncpool_stats`|`name,type`|sync.Pool usage stats|
|COUNTER|`dataway_http_api_copy_body_failed_total`|`api`|API copy body failed count|
|COUNTER|`dataway_http_api_signed_total`|`api,method`|API signature count|
|SUMMARY|`dataway_http_api_cached_bytes`|`api,cache_type,method,reason`|API cached body bytes|
|SUMMARY|`dataway_http_api_reusable_body_read_bytes`|`api,method`|API re-read body on forking request|
|SUMMARY|`dataway_http_api_recv_points`|`api`|API /v1/write/:category recevied points|
|SUMMARY|`dataway_http_api_send_points`|`api`|API /v1/write/:category send points|
|SUMMARY|`dataway_http_api_cache_points`|`api,cache_type`|Disk cached /v1/write/:category points|
|SUMMARY|`dataway_http_api_cache_cleaned_points`|`api,cache_type,status`|Disk cache cleaned /v1/write/:category points|
|COUNTER|`dataway_http_api_forked_total`|`api,method,token`|API request forked total|
|GAUGE|`dataway_http_info`|`cascaded,docker,http_client_trace,listen,max_body,release_date,remote,version`|Dataway API basic info|
|GAUGE|`dataway_last_heartbeat_time`|`N/A`|Dataway last heartbeat with Kodo timestamp|
|GAUGE|`dataway_cpu_usage`|`N/A`|Dataway CPU usage(%)|
|GAUGE|`dataway_mem_stat`|`type`|Dataway memory usage stats|
|SUMMARY|`dataway_http_api_copy_buffer_drop_total`|`max`|API copy buffer dropped(too large cached buffer) count|
|GAUGE|`dataway_open_files`|`N/A`|Dataway open files|
|GAUGE|`dataway_cpu_cores`|`N/A`|Dataway CPU cores|
|GAUGE|`dataway_uptime`|`N/A`|Dataway uptime|
|COUNTER|`dataway_process_ctx_switch_total`|`type`|Dataway process context switch count(Linux only)|
|COUNTER|`dataway_process_io_count_total`|`type`|Dataway process IO count|
|SUMMARY|`dataway_http_api_copy_buffer_drop_total`|`max`|API copy buffer dropped(too large cached buffer) count|
|COUNTER|`dataway_process_io_bytes_total`|`type`|Dataway process IO bytes count|
|SUMMARY|`dataway_http_api_dropped_expired_cache`|`api,method`|Dropped expired cache data|
|SUMMARY|`dataway_httpcli_tls_handshake_seconds`|`server`|HTTP TLS handshake cost|
|SUMMARY|`dataway_httpcli_http_connect_cost_seconds`|`server`|HTTP connect cost|
|SUMMARY|`dataway_httpcli_got_first_resp_byte_cost_seconds`|`server`|Got first response byte cost|
|SUMMARY|`http_latency`|`api,server`|HTTP latency|
|COUNTER|`dataway_httpcli_tcp_conn_total`|`server,remote,type`|HTTP TCP connection count|
|COUNTER|`dataway_httpcli_conn_reused_from_idle_total`|`server`|HTTP connection reused from idle count|
|SUMMARY|`dataway_httpcli_conn_idle_time_seconds`|`server`|HTTP connection idle time|
|SUMMARY|`dataway_httpcli_dns_cost_seconds`|`server`|HTTP DNS cost|
|SUMMARY|`dataway_sinker_rule_cost_seconds`|`N/A`|Rule cost time seconds|
|SUMMARY|`dataway_sinker_cache_key_len`|`N/A`|cache key length(bytes)|
|SUMMARY|`dataway_sinker_cache_val_len`|`N/A`|cache value length(bytes)|
|COUNTER|`dataway_sinker_pull_total`|`event,source`|Sinker pulled or pushed counter|
|GAUGE|`dataway_sinker_rule_cache_miss`|`N/A`|Sinker rule cache miss|
|GAUGE|`dataway_sinker_rule_cache_hit`|`N/A`|Sinker rule cache hit|
|GAUGE|`dataway_sinker_rule_cache_size`|`N/A`|Sinker rule cache size|
|GAUGE|`dataway_sinker_rule_error`|`error`|Rule errors|
|GAUGE|`dataway_sinker_default_rule_hit`|`info`|Default sinker rule hit count|
|GAUGE|`dataway_sinker_rule_last_applied_time`|`source`|Rule last applied time(Unix timestamp)|
|COUNTER|`diskcache_put_bytes_total`|`path`|Cache Put() bytes count|
|COUNTER|`diskcache_get_total`|`path`|Cache Get() count|
|COUNTER|`diskcache_wakeup_total`|`path`|Wakeup count on sleeping write file|
|COUNTER|`diskcache_seek_back_total`|`path`|Seek back when Get() got any error|
|COUNTER|`diskcache_get_bytes_total`|`path`|Cache Get() bytes count|
|GAUGE|`diskcache_capacity`|`path`|Current capacity(in bytes)|
|GAUGE|`diskcache_max_data`|`path`|Max data to Put(in bytes), default 0|
|GAUGE|`diskcache_batch_size`|`path`|Data file size(in bytes)|
|GAUGE|`diskcache_size`|`path`|Current cache size(in bytes)|
|GAUGE|`diskcache_open_time`|`no_fallback_on_error,no_lock,no_pos,no_sync,path`|Current cache Open time in unix timestamp(second)|
|GAUGE|`diskcache_last_close_time`|`path`|Current cache last Close time in unix timestamp(second)|
|GAUGE|`diskcache_datafiles`|`path`|Current un-read data files|
|SUMMARY|`diskcache_get_latency`|`path`|Get() time cost(micro-second)|
|SUMMARY|`diskcache_put_latency`|`path`|Put() time cost(micro-second)|
|COUNTER|`diskcache_dropped_bytes_total`|`path`|Dropped bytes during Put() when capacity reached.|
|COUNTER|`diskcache_dropped_total`|`path,reason`|Dropped files during Put() when capacity reached.|
|COUNTER|`diskcache_rotate_total`|`path`|Cache rotate count, mean file rotate from data to data.0000xxx|
|COUNTER|`diskcache_remove_total`|`path`|Removed file count, if some file read EOF, remove it from un-read list|
|COUNTER|`diskcache_put_total`|`path`|Cache Put() count|

#### Docker 模式下的指标采集 {#metrics-within-docker}

主机安装有两种模式，一种是宿主机安装，一种是通过 Docker 安装。这里单独说明一下通过 Docker 安装时指标采集的差异。

通过 Docker 安装时，指标暴露的 HTTP 端口会映射到宿主机的 19090 端口（默认情况下），此时其指标采集地址为 `http://localhost:19090/metrics`。

如果单独指定了不同的端口，则 Docker 安装时，会在该端口基础上加上 10000，故此处指定的端口不要超过 45535。

此外，Docker 安装时，还会暴露 profile 采集端口，默认映射到宿主机上的端口为 16060，其机制也是在指定的端口基础上加上 10000。

### Dataway 自身日志采集和处理 {#logging}

Dataway 自身 Log 分为两类，一个是 gin 日志，一个是自身程序日志，通过如下 Pipeline 可将其分离出来：

```python
# Pipeline for dataway logging

# Testing sample loggin
'''
2023-12-14T11:27:06.744+0800	DEBUG	apis	apis/api_upload_profile.go:272	save profile file to disk [ok] /v1/upload/profiling?token=****************a4e3db8481c345a94fe5a
[GIN] 2021/10/25 - 06:48:07 | 200 |   30.890624ms |  114.215.200.73 | POST     "/v1/write/logging?token=tkn_5c862a11111111111111111111111111"
'''

add_pattern("TOKEN", "tkn_\\w+")
add_pattern("GINTIME", "%{YEAR}/%{MONTHNUM}/%{MONTHDAY}%{SPACE}-%{SPACE}%{HOUR}:%{MINUTE}:%{SECOND}")
grok(_,"\\[GIN\\]%{SPACE}%{GINTIME:timestamp}%{SPACE}\\|%{SPACE}%{NUMBER:dataway_code}%{SPACE}\\|%{SPACE}%{NOTSPACE:cost_time}%{SPACE}\\|%{SPACE}%{NOTSPACE:client_ip}%{SPACE}\\|%{SPACE}%{NOTSPACE:method}%{SPACE}%{GREEDYDATA:http_url}")

# gin logging
if cost_time != nil {
  if http_url != nil  {
    grok(http_url, "%{TOKEN:token}")
    cover(token, [5, 15])
    replace(message, "tkn_\\w{0,5}\\w{6}", "****************$4")
    replace(http_url, "tkn_\\w{0,5}\\w{6}", "****************$4")
  }

  group_between(dataway_code, [200,299], "info", status)
  group_between(dataway_code, [300,399], "notice", status)
  group_between(dataway_code, [400,499], "warning", status)
  group_between(dataway_code, [500,599], "error", status)

  if sample(0.1) { # drop 90% debug log
    drop()
    exit()
  } else {
    set_tag(sample_rate, "0.1")
  }

  parse_duration(cost_time)
  duration_precision(cost_time, "ns", "ms")

  set_measurement('gin', true)
  set_tag(service,"dataway")
  exit()
}

# app logging
if cost_time == nil {
  grok(_,"%{TIMESTAMP_ISO8601:timestamp}%{SPACE}%{NOTSPACE:status}%{SPACE}%{NOTSPACE:module}%{SPACE}%{NOTSPACE:code}%{SPACE}%{GREEDYDATA:msg}")
  if level == nil {
    grok(message,"Error%{SPACE}%{DATA:errormsg}")
    if errormsg != nil {
      add_key(status,"error")
      drop_key(errormsg)
    }
  }
  lowercase(level)

  # if debug level enabled, drop most of them
  if status == 'debug' {
    if sample(0.1) { # drop 90% debug log
      drop()
      exit()
    } else {
      set_tag(sample_rate, "0.1")
    }
  }

  group_in(status, ["error", "panic", "dpanic", "fatal","err","fat"], "error", status) # mark them as 'error'

  if msg != nil {
    grok(msg, "%{TOKEN:token}")
    cover(token, [5, 15])
    replace(message, "tkn_\\w{0,5}\\w{6}", "****************$4")
    replace(msg, "tkn_\\w{0,5}\\w{6}", "****************$4")
  }

  set_measurement("dataway-log", true)
  set_tag(service,"dataway")
}
```

## Dataway bug report {#bug-report}

Dataway 自身暴露指标和 profiling 收集入口，我们可以收集这些信息以便于问题排查。

> 以下信息收集，以实际配置的端口和地址为准，已有命令按照默认参数来列举。

```shell title="dw-bug-report.sh"
br_dir="dw-br-$(date +%s)"
mkdir -p $br_dir

echo "save bug report to ${br_dir}"

# 依据实际情况，修改这里的配置
dw_ip="localhost" # dataway 指标/profile 暴露的 IP 地址
metric_port=9090  # 指标暴露的端口
profile_port=6060 # profile 暴露的端口
dw_yaml_conf="/usr/local/cloudcare/dataflux/dataway/dataway.yaml"
dw_dot_yaml_conf="/usr/local/cloudcare/dataflux/dataway/.dataway.yaml" # 容器安装时有该文件

# 收集运行时指标
curl -v "http://${dw_ip}:${metric_port}/metrics" -o $br_dir/metrics

# 收集 profiling 信息
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/allocs" -o $br_dir/allocs
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/heap" -o $br_dir/heap
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/profile" -o $br_dir/profile # 此命令会运行 30s 左右

cp $dw_yaml_conf $br_dir/dataway.yaml.copy
cp $dw_dot_yaml_conf $br_dir/.dataway.yaml.copy

tar czvf ${br_dir}.tar.gz ${br_dir}
rm -rf ${br_dir}
```

运行脚本：

```shell
$ sh dw-bug-report.sh
...
```

执行完后，会生成类似 *dw-br-1721188604.tar.gz* 的文件，将该文件拿出来即可。

## FAQ {#faq}

### 请求体太大问题 {#too-large-request-body}

[:octicons-tag-24: Version-1.3.7](dataway-changelog.md#cl-1.3.7)

Dataway 对请求体大小有默认设置（默认 64MB），但请求体太大时，客户端会收到一个 HTTP 413 报错（`Request Entity Too Large`），如果请求体在合理范围内，可以适当放大该数值（单位字节）：

- 设置环境变量 `DW_MAX_HTTP_BODY_BYTES`
- 在 *dataway.yaml* 中设置 `max_http_body_bytes`

如果运行期间出现太大的请求包，在指标和日志中都有体现：

- 指标 `dataway_http_too_large_dropped_total` 暴露了丢弃的大请求个数
- 搜索 Dataway 日志 `cat log | grep 'drop too large request'`，日志会输出 HTTP 请求的 Header 详情，便于进一步了解客户端情况

<!-- markdownlint-disable MD046 -->
???+ warning

    在磁盘缓存模块，也有一个最大的数据块写入限制（默认 64MB）。如果增加最大请求体配置，也要一并调整该配置（[`ENV_DISKCACHE_MAX_DATA_SIZE`](https://github.com/GuanceCloud/cliutils/tree/main/diskcache#%E9%80%9A%E8%BF%87-env-%E6%8E%A7%E5%88%B6%E7%BC%93%E5%AD%98-option){:target="_blank"}），以确保大请求能正确写入磁盘缓存。
<!-- markdownlint-enable -->
