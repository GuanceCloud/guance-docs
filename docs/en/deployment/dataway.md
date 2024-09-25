<!-- 不要在 dataflux-doc 仓库直接修改本文件，该文件由 Dataway 项目自动导出 -->

# Dataway
---

## Introduction {#intro}

DataWay is the data gateway of the observation cloud, and the collector needs to pass through the DataWay gateway to report data to the observation cloud

## Dataway Installation {#install}

- **New Dataway**

On the Data Gateways page in the observation cloud management console, click Create Dataway. Enter a name and binding address, and then click Create.

After the creation is successful, a new Dataway is automatically created and the installation script for the Dataway is generated.

<!-- markdownlint-disable MD046 -->
???+ info

    The binding address is the Dataway gateway address, which must be filled in as a complete HTTP address, such as `http(s)://1.2.3.4:9528`, including the protocol, host address and port, the host address can generally use the IP address of the Dataway machine deployed or specified as a domain name, and the domain name needs to be resolved.

    Note: Make sure that the collector can access the address, otherwise the data collection will not be successful)
<!-- markdownlint-enable -->

- **Install Dataway**

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    ```shell
    DW_KODO=http://kodo_ip:port \
       DW_TOKEN=<tkn_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> \
       DW_UUID=<YOUR_UUID> \
       bash -c "$(curl https://static.guance.com/dataway/install.sh)"
    ```

    After the installation is complete, in the installation directory, *dataway.yaml* will be generated, the content of which can be manually modified and take effect by restarting the service.

    ??? info "*dataway.yaml*"

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
        insecure_skip_verify: false
        http_client_trace: false
        sni: ""

        # dataway API configures
        bind: 0.0.0.0:9528

        # dataway TLS file path
        tls_crt:
        tls_key:

        # enable pprof
        pprof_bind: localhost:6060

        api_limit_rate : 100000          # 100K
        max_http_body_bytes : 67108864   # 64MB
        copy_buffer_drop_size : 8388608  # 8MB, if copy buffer memory larger than this, this memory released
        reserved_pool_size: 4096         # reserved pool size for better GC

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

    Download [*dataway.yaml*](https://static.guance.com/dataway/dataway.yaml){:target="_blank"}, install:

    ```shell
    $ wget https://static.guance.com/dataway/dataway.yaml -O dw-deployment.yaml
    $ kubectl apply -f dw-deployment.yaml
    ```

    In *dw-deployment.yaml*, you can modify the Dataway configuration through environment variables, see [here] (dataway.md#img-envs).

---

???+ Note "Notes"

    - Can only run on Linux systems
    - When the host is installed, the Dataway installation path is */usr/local/cloudcare/dataflux/dataway*
<!-- markdownlint-enable -->

- **Verify Dataway installation**

After installation, wait for a while to refresh the "Data Gateway" page, if you see the version number in the "Version Information" column of the data gateway you just added, it means that the Dataway has been successfully connected to the observation cloud center, and front-end users can access data through it.

After Dataway is successfully connected to the observation cloud center, log in to the observation cloud console, view all Dataway addresses on the "Integration" / DataKit page, select the required Dataway gateway address, and obtain the DataKit installation command to execute on the server to start collecting data.

## Manage DataWay {#manage}

### Delete DataWay {#delete}

On the "Data Gateway" page of the observation cloud management background, select the DataWay to be deleted, click "Configure", and click the "Delete" button in the lower left corner of the pop-up Edit DataWay dialog box.

<!-- markdownlint-disable MD046 -->
???+ warning

    After deleting DataWay, you also need to log in to the server where the DataWay gateway is deployed to stop the operation of DataWay, and then delete the installation directory to completely delete the DataWay.
<!-- markdownlint-enable -->

### Upgrade DataWay {#upgrade}

On the Data Gateways page in the observation cloud management background, if an upgradeable version exists for DataWay, an upgrade prompt appears in the version information.

<!-- markdownlint-disable MD046 -->
=== "Host Upgrade"

    ```shell
    DW_UPGRADE=1 bash -c "$(curl https://static.guance.com/dataway/install.sh)"
    ```

=== "Kubernetes upgrade"

    Replace the image version directly:

    ```yaml
    - image: pubrepo.jiagouyun.com/dataflux/dataway:<VERSION>
    ```
<!-- markdownlint-enable -->

### Dataway Service Management {#manage-service}

When the host installs Dataway, you can use the following command to manage the Dataway service:

``` shell
# Start
$ systemctl start dataway

# Reboot
$ systemctl restart dataway

# Stop
$ systemctl stop dataway
```

Kubernetes can restart the corresponding pod.

## Environment variable {#dw-envs}

### Host installation supports environment variable {#install-envs}

> The method of installing directly on the host is no longer recommended, and new configuration items are also not supported to be configured via command-line parameters. If it is not possible to change the deployment method, it is suggested to manually modify the corresponding configurations after the installation (upgrade) is complete. For default configurations, please refer to the default configuration examples provided above.

When installing a host, you can inject the following environment variables into the installation command:

| Env                   | Type      | Required | Description                                                                                                                              | Example Value |
| ---                   | ---       | ---      | ---                                                                                                                                      | ---           |
| DW_BIND               | string    | No       | Dataway HTTP API binding address, default is `0.0.0.0:9528`                                                                              |               |
| DW_CASCADED           | boolean   | No       | Whether Dataway is cascaded                                                                                                              | `true`        |
| DW_HTTP_CLIENT_TRACE  | boolean   | No       | When Dataway acts as an HTTP client, enabling this can collect related metrics, which will be output in its Prometheus metrics           | `true`        |
| DW_KODO               | string    | Yes      | Kodo address, or the address of the next Dataway, in the form of `http://host:port`                                                      |               |
| DW_SECRET_TOKEN       | string    | No       | When the Sinker feature is enabled, you can set this Token for security                                                                  |               |
| DW_TOKEN              | string    | Yes      | Generally, it is the data Token of the system workspace                                                                                  |               |
| DW_UPGRADE            | boolean   | No       | Set this to 1 during an upgrade                                                                                                          |               |
| DW_UUID               | string    | Yes      | Dataway UUID, this is generated by the system workspace when a new Dataway is created                                                    |               |
| DW_TLS_CRT            | file-path | No       | Specify the directory of the HTTPS/TLS crt file [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                         |               |
| DW_TLS_KEY            | file-path | No       | Specify the directory of the HTTPS/TLS key file [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                         |               |
| DW_PROM_EXPORTOR_BIND | string    | No       | Specify the HTTP port for Dataway's own metrics exposure (default 9090) [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0) |               |
| DW_PPROF_BIND         | string    | No       | Specify the HTTP port for Dataway's own pprof (default 6060) [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)            |               |
| DW_DISK_CACHE_CAP_MB  | int       | No       | Specify the disk cache size (unit MB), default is 65535MB [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)               |               |

<!-- markdownlint-disable MD046 -->
???+ warning

    Sinker-related settings must be manually modified after installation. Currently, it is not supported to specify Sinker configurations during the installation process. [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0-brk)
<!-- markdownlint-enable -->

### Docker image environment variable {#img-envs}

When Dataway runs in a Kubernetes environment, it supports the following environment variables.

<!-- markdownlint-disable MD046 -->
???+ warning "Compatible with lagacy dataway.yaml"

    Some old Dataway's configure imported by ConfigMap(and mount to install path with the name of *dataway.yaml*).
    After Dataway image started, if detect the file *dataway.yaml*, all the configures from `DW_*` are ignored and only
    apply the lagacy *dataway.yaml*. We can remove the ConfigMap on *dataway.yaml* to recover these environment configures.

    If these environment configures applied, there was a hidden file `.dataway.ayml`(view them via `ls -a`) under
    install path, we can `cat` it to check if all these environment configures applied ok.
<!-- markdownlint-enable -->

#### HTTP Server Settings {#env-apis}

| Env                         | Type      | Required | Description                                                                                                                                                | Example Value |
| ---                         | ---       | ---      | ---                                                                                                                                                        | ---           |
| DW_REMOTE_HOST              | string    | Yes      | Kodo address, or the next Dataway address, in the form of `http://host:port`                                                                               |               |
| DW_WHITE_LIST               | string    | No       | Dataway client IP whitelist, separated by English `,`                                                                                                      |               |
| DW_HTTP_TIMEOUT             | string    | No       | Dataway request timeout setting for Kodo or the next Dataway, default is 30s                                                                               |               |
| DW_BIND                     | string    | No       | Dataway HTTP API binding address, default is `0.0.0.0:9528`                                                                                                |               |
| DW_API_LIMIT                | int       | No       | Dataway API rate limit setting, for example, if set to 1000, each specific API is only allowed to be requested 1000 times within 1 second, default is 100K |               |
| DW_HEARTBEAT                | string    | No       | Dataway heartbeat interval with the center, default is 60s                                                                                                 |               |
| DW_MAX_HTTP_BODY_BYTES      | int       | No       | Maximum HTTP Body size allowed by Dataway API (**unit bytes**), default is 64MB                                                                            |               |
| DW_TLS_INSECURE_SKIP_VERIFY | boolean   | No       | Ignore HTTPS/TLS certificate errors                                                                                                                        | `true`        |
| DW_HTTP_CLIENT_TRACE        | boolean   | No       | Dataway, acting as an HTTP client, can enable the collection of some related metrics, which will ultimately be output in its Prometheus metrics            | `true`        |
| DW_ENABLE_TLS               | boolean   | No       | Enable HTTPS [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                                                                              |               |
| DW_TLS_CRT                  | file-path | No       | Specify the directory of the HTTPS/TLS crt file [:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                           |               |
| DW_TLS_KEY                  | file-path | No       | Specify the directory of the HTTPS/TLS key file [:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                           |               |
| DW_SNI                      | string    | N        | Specify current Dataway's SNI [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)                                                             |               |

##### HTTP TLS Settings {#http-tls}

To generate a TLS certificate with a one-year validity period, you can use the following OpenSSL command:

```shell
# Generate a TLS certificate with a one-year validity
$ openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out tls.crt -keyout tls.key
...
```

After executing this command, the system will prompt you to enter some necessary information, including your country, region, city, organization name, department name, and your email address. This information will be included in your certificate.

After completing the information input, you will generate two files: *tls.crt* (certificate file) and *tls.key* (private key file). Please keep your private key file secure and safe.

In order for the application to use these TLS certificates, you need to set the absolute paths of these two files to the application's environment variables. Here is an example of setting environment variables:

> `DW_ENABLE_TLS` must be turned on first, and then the other two ENVs (`DW_TLS_CRT/DW_TLS_KEY`) will take effect. [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)

```yaml
env:
- name: DW_ENABLE_TLS
  value: "true"
- name: DW_TLS_CRT
  value: "/path/to/your/tls.crt"
- name: DW_TLS_KEY
  value: "/path/to/your/tls.key"
```

Replace `/path/to/your/tls.crt` and `/path/to/your/tls.key` with the actual paths to your `tls.crt` and `tls.key` files, respectively.

After setting up the environment variables, you can test whether TLS is functioning correctly with the following command:

```shell
curl -k https://localhost:9528
```

If successful, you should see an ASCII art message indicating "It's working!" If the certificates are missing, you might encounter an error in the Dataway logs similar to:

```text
server listen(TLS) failed: open /path/to/your/tls.{crt,key}: no such file or directory
```

In this case, Dataway would not start, and the `curl` command would also result in an error:

```shell
curl: (7) Failed to connect to localhost port 9528 after 6 ms: Couldn't connect to server
```

Ensure that the paths to the TLS certificate and key are correctly specified and that the files have the appropriate permissions for the application to read them.

#### Logging Settings {#env-logging}

| Env          | Type  | Required | Description                | Value |
| ---          | ---   | ---      | ---                        | ---   |
| DW_LOG       | string| N        | Log path, default to *log* |       |
| DW_LOG_LEVEL | string| N        | The default is `info`      |       |
| DW_GIN_LOG   | string| N        | The default is *gin.log*   |       |

#### Token/UUID Settings {#env-token-uuid}

| Env                      | Type    | Required | Description                                                                                             | Value |
| ---                      | ---     | ---      | ---                                                                                                     | ---   |
| DW_UUID                  | string  | Y        | Dataway UUID, this will generate in the system workspace when creating a new Dataway                    |       |
| DW_TOKEN                 | string  | Y        | Generally the token of the system workspace                                                             |       |
| DW_SECRET_TOKEN          | string  | N        | When the sinker function is enabled, you can set the token                                              |       |
| DW_ENABLE_INTERNAL_TOKEN | boolean | N        | `__internal__` is allowed as the client token, and the Token of the system workspace is used by default |       |
| DW_ENABLE_EMPTY_TOKEN    | boolean | N        | It is allowed to upload data without a token, and the token  of the system workspace is used by default |       |

#### Sinker Settings {#env-sinker}

| Env                         | Type      | Required | Description                                                                               | Value |
| ---                         | ---       | ---      | ---                                                                                       | ---   |
| DW_CASCADED                 | string    | N        | Whether the Dataway is cascading                                                          | "on"  |
| DW_SINKER_ETCD_URLS         | string    | N        | etcd address lists, separated by `,`, e.g. `http://1.2.3.4:2379,http://1.2.3.4:2380`      |       |
| DW_SINKER_ETCD_DIAL_TIMEOUT | string    | N        | etcd connection timeout, default 30s                                                      |       |
| DW_SINKER_ETCD_KEY_SPACE    | string    | N        | The name of the etcd key where the sinker configuration is located (default `/dw_sinker`) |       |
| DW_SINKER_ETCD_USERNAME     | string    | N        | etcd username                                                                             |       |
| DW_SINKER_ETCD_PASSWORD     | string    | N        | etcd password                                                                             |       |
| DW_SINKER_FILE_PATH         | file-path | N        | Specify the sinker rule configuration via a local file                                    |       |

<!-- markdownlint-disable MD046 -->
???+ warning

    If both local files and etcd are specified, the sinker rule in the local file takes precedence.
<!-- markdownlint-enable -->

#### Prometheus metrics expose {#env-metrics}

| Env              | Type   | Required | Description                                                             | Value |
| ---              | ---    | ---      | ---                                                                     | ---   |
| DW_PROM_URL      | string | N        | URL Path for Prometheus metrics (default `/metrics`)                    |       |
| DW_PROM_LISTEN   | string | N        | The Prometheus indicator exposes the address (default `localhost:9090`) |       |
| DW_PROM_DISABLED | boolean| N        | Disable Prometheus indicator exposure                                   | "on"  |

#### Disk cache settings {#env-diskcache}

| Env                           | Type      | Required | Description                                                                                                                                                                                                                        | Value                                         |
| ---                           | ---       | ---      | ---                                                                                                                                                                                                                                | ---                                           |
| DW_DISKCACHE_DIR              | file-path | N        | Set the cache directory, **This directory is generally plugged in**                                                                                                                                                                | *path/to/your/cache*                          |
| DW_DISKCACHE_DISABLE          | boolean   | N        | Disable disk caching, **If caching is not disabled, delete the environment variable**                                                                                                                                              | "on"                                          |
| DW_DISKCACHE_CLEAN_INTERVAL   | string    | N        | Cache cleanup interval (default 30s)                                                                                                                                                                                               | Duration string                               |
| DW_DISKCACHE_EXPIRE_DURATION  | string    | N        | Cache expiration time (default 24h)                                                                                                                                                                                                | Duration string, such as `72h` for three days |
| DW_DISKCACHE_CAPACITY_MB      | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set the available disk space size for caching, unit MB, default is 20GB                                                                                           | Specify `1024` for 1GB                        |
| DW_DISKCACHE_BATCH_SIZE_MB    | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set the maximum size of a single disk cache file, unit MB, default is 64MB                                                                                        | Specify `1024` for 1GB                        |
| DW_DISKCACHE_MAX_DATA_SIZE_MB | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set the maximum size of a single cache content (e.g., a single HTTP body), unit MB, default is 64MB, any single data packet exceeding this size will be discarded | Specify `1024` for 1GB                        |


<!-- markdownlint-disable MD046 -->
???+ warning

    Set `DW_DISKCACHE_DISABLE` to disable diskcache globally.
<!-- markdownlint-enable -->

#### Performance related {#env-perfmance}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

| Env                         | Type | Required | Description                                                                                                                          | Example Value |
| ---                         | ---  | ---      | ---                                                                                                                                  | ---           |
| DW_DW_COPY_BUFFER_DROP_SIZE | int  | No       | Any buffer exceeding the specified size (in bytes) will be immediately cleared to avoid excessive memory consumption. Default is 1MB | 1048576       |
| DW_RESERVED_POOL_SIZE       | int  | No       | The base size of the memory pool, with a default of 4096 bytes.                                                                      | 4096          |

## Dataway API List {#apis}

> Details of each API below are to be added.

### `GET /v1/ntp/` {#v1-ntp}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

- API description: Get current dataway unix timestamp(unit: second)

### `POST /v1/write/:category` {#v1-write-category}

- API description: Receive various collection data uploaded by Datakit

### `GET /v1/datakit/pull` {#v1-datakit-pull}

- API description: Handles Datakit pull center configuration (blacklist/pipeline) requests

### `POST /v1/write/rum/replay` {#v1-write-rum-replay}

- API description: Receive Session Replay data uploaded by Datakit

### `POST /v1/upload/profiling` {#v1-upload-profiling}

- API description: Receive profiling data uploaded by Datakit

### `POST /v1/election` {#v1-election}

- API description: Handles election requests for Datakit

### `POST /v1/election/heartbeat` {#v1-election-heartbeat}

- API description: Handles election heartbeat requests for Datakit

### `POST /v1/query/raw` {#v1-query-raw}

- API description: Handles DQL query requests initiated by the Datakit side

### `POST /v1/workspace` {#v1-workspace}

- API description: Handles workspace query requests initiated by Datakit

### `POST /v1/object/labels` {#v1-object-labels}

- API description: Handles requests to modify object labels

### `DELETE /v1/object/labels` {#v1-delete-object-labels}

- API description: Handles delete object Label requests

### `GET /v1/check/:token` {#v1-check-token}

- API description: Detect if tokken is legitimate

## Dataway metrics collection {#collect-metrics}

<!-- markdownlint-disable MD046 -->
???+ warning "HTTP client metrics collection"

    If you want to collect metrics for Dataway HTTP requests to Kodo (or Dataway next hop), you need to manually enable the `http_client_trace` configuration. You can also specify `DW_HTTP_CLIENT_TRACE=true` during the installation phase.

=== "Host Deployment"

    Dataway itself exposes Prometheus metrics, which can be collected through Datakit's built-in `prom` collector, which is configured as follows:

    ```toml
    [[inputs.prom]]
      ## Exporter URLs.
      urls = [ "http://localhost:9090/metrics", ]

      source = "dataway"

      election = true

      ## Dataway metric set fixed to dw, do not change
      measurement_name = "dw"
    ```

=== "Kubernetes"

    You can add annotations on pods (requires [Datakit 1.14.2] (../datakit/changelog.md#cl-1.14.2) or above):

    ```yaml
    annotations:
       datakit/prom.instances: |
         [[inputs.prom]]
           url = "http://$IP:9090/metrics" # Here the port (default 9090) is as appropriate
           source = "dataway"
           measurement_name = "dw" # pinned to this metric set
           interval = "30s"

           [inputs.prom.tags]
             namespace = "$NAMESPACE"
             pod_name = "$PODNAME"
             node_name = "$NODENAME"
    ```
<!-- markdownlint-enable -->

If the collection is successful, search for `dataway` in the "Scene"/"Built-in View" of the observation cloud to see the corresponding monitoring view.

### Dataway Metric List {#metrics}

The following are the indicators exposed by Dataway, which can be obtained by requesting `http://localhost:9090/metrics`, and you can view (3s) a specific indicator in real time by following the following command:

> If some metrics cannot be queried, it may be caused by the relevant business module not running.

```shell
watch -n 3 'curl -s http://localhost:9090/metrics | grep -a <METRIC-NAME>'
```

|TYPE|NAME|LABELS|HELP|
|---|---|---|---|
|SUMMARY|`dataway_http_api_body_buffer_utilization`|`api`|API body buffer utillization(Len/Cap)|
|SUMMARY|`dataway_http_api_body_copy`|`api`|API body copy|
|SUMMARY|`dataway_http_api_req_size_bytes`|`api,method,status`|API request size|
|COUNTER|`dataway_http_api_total`|`api,status`|API request count|
|COUNTER|`dataway_http_api_body_too_large_dropped_total`|`api,method`|API request too large dropped|
|COUNTER|`dataway_http_api_with_inner_token`|`api,method`|API request with inner token|
|COUNTER|`dataway_http_api_dropped_total`|`api,method`|API request dropped when sinker rule match failed|
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
|GAUGE|`dataway_open_files`|`N/A`|Dataway open files|
|GAUGE|`dataway_cpu_cores`|`N/A`|Dataway CPU cores|
|GAUGE|`dataway_uptime`|`N/A`|Dataway uptime|
|COUNTER|`dataway_process_ctx_switch_total`|`type`|Dataway process context switch count(Linux only)|
|COUNTER|`dataway_process_io_count_total`|`type`|Dataway process IO count count|
|COUNTER|`dataway_process_io_bytes_total`|`type`|Dataway process IO bytes count|
|COUNTER|`dataway_http_api_copy_buffer_drop_total`|`N/A`|API copy buffer dropped(too large cached buffer) count|
|SUMMARY|`dataway_http_api_dropped_expired_cache`|`api,method`|Dropped expired cache data|
|SUMMARY|`dataway_http_api_elapsed_seconds`|`api,method,status`|API request latency|
|SUMMARY|`dataway_httpcli_http_connect_cost_seconds`|`server`|HTTP connect cost|
|SUMMARY|`dataway_httpcli_got_first_resp_byte_cost_seconds`|`server`|Got first response byte cost|
|COUNTER|`dataway_httpcli_tcp_conn_total`|`server,remote,type`|HTTP TCP connection count|
|COUNTER|`dataway_httpcli_conn_reused_from_idle_total`|`server`|HTTP connection reused from idle count|
|SUMMARY|`dataway_httpcli_conn_idle_time_seconds`|`server`|HTTP connection idle time|
|SUMMARY|`dataway_httpcli_dns_cost_seconds`|`server`|HTTP DNS cost|
|SUMMARY|`dataway_httpcli_tls_handshake_seconds`|`server`|HTTP TLS handshake cost|
|SUMMARY|`dataway_sinker_cache_key_len`|`N/A`|cache key length(bytes)|
|SUMMARY|`dataway_sinker_cache_val_len`|`N/A`|cache value length(bytes)|
|COUNTER|`dataway_sinker_pull_total`|`event,source`|Sinker pulled or pushed counter|
|GAUGE|`dataway_sinker_rule_cache_miss`|`N/A`|Sinker rule cache miss|
|GAUGE|`dataway_sinker_rule_cache_hit`|`N/A`|Sinker rule cache hit|
|GAUGE|`dataway_sinker_rule_cache_size`|`N/A`|Sinker rule cache size|
|GAUGE|`dataway_sinker_rule_error`|`error`|Rule errors|
|GAUGE|`dataway_sinker_rule_last_applied_time`|`source`|Rule last applied time(Unix timestamp)|
|SUMMARY|`dataway_sinker_rule_cost_seconds`|`N/A`|Rule cost time seconds|
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

#### Metrics under Docker {#metrics-within-docker}

There are two modes for non-Kubernetes, host mode and Docker mode. This section will specifically discuss the differences in metrics collection when installing in Docker.

When installed in docker, the HTTP port that exposes metrics will be mapped to port 19090 on the host machine (by default). In this case, the metrics collection address is `http://localhost:19090/metrics`.

If a different port is specified, the installer will add 10000 to the specified port during installation. Therefore, the specified port should not exceed 45535.

In addition, when installed in Docker mode, a profile collection port will also be exposed, which is mapped to port 16060 on the host machine by default. The mechanism is also to add 10000 to the specified port.

### Dataway's Own Log Collection and Processing {#logging}

Dataway's own logs are divided into two categories: one is the gin log, and the other is the Dataway's own log. The following Pipeline can separate them:

```python
# Pipeline for dataway logging

# Testing sample loggin
'''
2023-12-14T11:27:06.744+0800	DEBUG	apis	apis/api_upload_profile.go:272	save profile file to disk [ok] /v1/upload/profiling?token=****************a4e3db8481c345a94fe5a
[GIN] 2021/10/25 - 06:48:07 | 200 |   30.890624ms |  114.215.200.73 | POST     "/v1/write/logging?token=tkn_5c862a11111111111111111111111"
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

## Dataway Bug Report {#bug-report}

Dataway exposes its own metrics and profiling collection endpoints, allowing us to gather this information for troubleshooting purposes.

> The following information collection should based on actual configured ports and addresses. These listed commands are based on default configurations.

```shell title="dw-bug-report.sh"
br_dir="dw-br-$(date +%s)"
mkdir -p $br_dir

echo "Save bug report to ${br_dir}"

# Modify the following configurations according to your actual situation
dw_ip="localhost" # The IP address where Dataway's metrics/profile is exposed
metric_port=9090  # The port where metrics are exposed
profile_port=6060 # The port where profiling information is exposed
dw_yaml_conf="/usr/local/cloudcare/dataflux/dataway/dataway.yaml"
dw_dot_yaml_conf="/usr/local/cloudcare/dataflux/dataway/.dataway.yaml"

# Collect runtime metrics
curl -v "http://${dw_ip}:${metric_port}/metrics" -o $br_dir/metrics

# Collect profiling information
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/allocs" -o $br_dir/allocs
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/heap" -o $br_dir/heap
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/profile" -o $br_dir/profile # This command will take about 30 seconds to run

cp $dw_yaml_conf $br_dir/dataway.yaml.copy
cp $dw_dot_yaml_conf $br_dir/.dataway.yaml.copy

tar czvf ${br_dir}.tar.gz ${br_dir}
rm -rf ${br_dir}
```

Run the script:

```shell
$ sh dw-bug-report.sh
...
```

After execution, a file similar to *dw-br-1721188604.tar.gz* will be generated. You can then retrieve this file for further use.

## FAQ {#faq}

### Request Entity Too Large Issue {#too-large-request-body}

[:octicons-tag-24: Version-1.3.7](dataway-changelog.md#cl-1.3.7)

Dataway has a default setting for the size of the request body (default is 64MB), but when the request body is too large, the client will receive an HTTP 413 error (`Request Entity Too Large`). If the request body is within a reasonable range, you can appropriately increase this value (unit is bytes):

- Set the environment variable `DW_MAX_HTTP_BODY_BYTES` for Kubernetes Pod install
- In *dataway.yaml*, set `max_http_body_bytes` for host install

If there is a request that is too large during runtime, it is reflected in both metrics and logs:

- The metric `dataway_http_too_large_dropped_total` exposes the number of discarded large requests
- Search the Dataway logs with `cat log | grep 'drop too large request'`. The logs will output the details of the HTTP request Header, which is helpful for further understanding the client situation

<!-- markdownlint-disable MD046 -->
???+ warning

    In the disk cache module, there is also a maximum data block write limit (default 64MB). If you increase the maximum request body configuration, you should also adjust this configuration accordingly ([`ENV_DISKCACHE_MAX_DATA_SIZE`](https://github.com/GuanceCloud/cliutils/tree/main/diskcache#%E9%80%9A%E8%BF%87-env-%E6%8E%A7%E5%88%B6%E7%BC%93%E5%AD%98-option){:target="_blank"}), to ensure that large requests can be correctly written to the disk cache.
<!-- markdownlint-enable -->
