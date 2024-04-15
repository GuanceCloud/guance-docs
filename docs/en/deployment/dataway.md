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

        log : log
        log_level : debug
        gin_log   : gin.log

        cache_cfg:
          disabled            : false
          max_disk_size       : 20480
          max_data_size       : 67108864
          batch_size          : 67108864
          dir : disk_cache
          clean_interval      : 30s
          expire_duration: 24h

        sinker: null

        prometheus:
          url                 : /metrics
          listen              : 0.0.0.0:9091
          enable              : true
          disablegometrics    : false
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
???+ attention

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

When installing a host, you can inject the following environment variables into the installation command:

??? attention "Compatible with lagacy dataway.yaml"

    Some old Dataway's configure imported by ConfigMap(and mount to install path with the name of *dataway.yaml*).
    After Dataway image started, if detect the file *dataway.yaml*, all the configures from `DW_*` are ignored and only
    apply the lagacy *dataway.yaml*. We can remove the ConfigMap on *dataway.yaml* to recover these environment configures.

    If these environment configures applied, there was a hidden file `.dataway.ayml`(view them via `ls -a`) under
    install path, we can `cat` it to check if all these environment configures applied ok.

| Env                  | Required | Description | Value |
| ---                  | ---      | ---                                                                                                | ---  |
| DW_BIND              | N        | Dataway HTTP API binding address, default `0.0.0.0:9528` |      |
| DW_CASCADED          | N        | Whether the Dataway is cascading | "on" |
| DW_ETCD_HOST         | N        | etcd address, currently only supports specifying a single address, such as `http://1.2.3.4:2379` |      |
| DW_ETCD_PASSWORD     | N        | etcd password |      |
| DW_ETCD_USERNAME     | N        | etcd username |      |
| DW_HTTP_CLIENT_TRACE | N        | Dataway itself, as an HTTP client, can turn on some related metrics collection, which will eventually be output in its Prometheus metrics `on` |
| DW_KODO              | Y        | The kodo address, or the next Dataway address, is shaped like `http://host:port` |      |
| DW_SECRET_TOKEN      | N        | When the sinker function is enabled, you can set the token |      |
| DW_TOKEN             | Y        | Generally the data token | of the system workspace      |
| DW_UPGRADE           | N        | Specify it as 1|when upgrading      |
| DW_UUID              | Y        | Dataway UUID, this will generate | in the system workspace when creating a new Dataway      |

### Docker image environment variable {#img-envs}

When Dataway runs in a Kubernetes environment, it supports the following environment variables.

#### API about {#env-apis}

| Env                         | Required | Description | Value |
| ---                         | ---      | ---                                                                                                | ---  |
| DW_REMOTE_HOST              | Y        | The kodo address, or the next Dataway address, is shaped like `http://host:port` |      |
| DW_WHITE_LIST               | N        | Dataway client IP whitelist, split by `,` in English      |
| DW_HTTP_TIMEOUT             | N        | Dataway requests the timeout setting for Kodo or the next Dataway, default 30s |      |
| DW_BIND                     | N        | Dataway HTTP API binding address, default `0.0.0.0:9528` |      |
| DW_API_LIMIT                | N        | Dataway API throttling setting, if set to 1000, each specific API only allows 1000 requests within 1s, and the default is 100K|      |
| DW_HEARTBEAT                | N        | The heartbeat interval between Dataway and the center, default 60s |      |
| DW_MAX_HTTP_BODY_BYTES      | N        | The maximum HTTP Body (per byte) allowed by the Dataway API, default 64MB |      |
| DW_TLS_INSECURE_SKIP_VERIFY | N        | Ignore HTTPS/TLS certificate error | `on` |
| DW_HTTP_CLIENT_TRACE        | N        | Dataway itself, as an HTTP client, can turn on some related metrics collection, which will eventually be output in its Prometheus metrics `on` |

#### logabout {#env-logging}

| Env          | Required | Description | Value |
| ---          | ---      | ---                    | ---  |
| DW_LOG       | N        | Log path, default to *log* |      |
| DW_LOG_LEVEL | N        | The default is `info` |      |
| DW_GIN_LOG   | N        | The default is *gin.log* |      |

#### Token/UUID Settings {#env-token-uuid}

| Env                      | Required | Description | Value |
| ---                      | ---      | ---                                                                      | ---  |
| DW_UUID                  | Y        | Dataway UUID, this will generate | in the system workspace when creating a new Dataway      |
| DW_TOKEN                 | Y        | Generally the data token | of the system workspace      |
| DW_SECRET_TOKEN          | N        | When the sinker function is enabled, you can set the token |      |
| DW_ENABLE_INTERNAL_TOKEN | N        | `__internal__` is allowed as the client token, and the Token | of the system workspace is used by default      |
| DW_ENABLE_EMPTY_TOKEN    | N        | It is allowed to upload data without a token, and the token | of the system workspace is used by default      |

#### Sinker About setting {#env-sinker}

| Env                         | Required | Description | Value |
| ---                         | ---      | ---                                                                      | ---  |
| DW_CASCADED                 | N        | Whether the Dataway is cascading | "on" |
| DW_SINKER_ETCD_URLS         | N        | etcd address lists, separated by `,`, e.g. `http://1.2.3.4:2379,http://1.2.3.4:2380` |      |
| DW_SINKER_ETCD_DIAL_TIMEOUT | N        | etcd connection timeout, default 30s |      |
| DW_SINKER_ETCD_KEY_SPACE    | N        | The name of the etcd key where the sinker configuration is located (default `/dw_sinker`) |      |
| DW_SINKER_ETCD_USERNAME     | N        | etcd username |      |
| DW_SINKER_ETCD_PASSWORD     | N        | etcd password |      |
| DW_SINKER_FILE_PATH         | N        | Specify the sinker rule configuration | via a local file      |

<!-- markdownlint-disable MD046 -->
???+ attention

    If both local files and etcd are specified, the sinker rule in the local file takes precedence.
<!-- markdownlint-enable -->

#### Prometheus metrics expose {#env-metrics}

| Env              | Required | Description | Value |
| ---              | ---      | ---                                              | ---  |
| DW_PROM_URL      | N        | URL Path for Prometheus metrics (default `/metrics`) |      |
| DW_PROM_LISTEN   | N        | The Prometheus indicator exposes the address (default `localhost:9090`) |      |
| DW_PROM_DISABLED | N        | Disable Prometheus indicator exposure | "on" |

#### Disk cache settings {#env-diskcache}

| Env                          | Required | Description | Value |
| ---                          | ---      | ---                                                | ---                                |
| DW_DISKCACHE_DIR             | N        | Set the cache directory, **This directory is generally plugged in** | *path/to/your/cache*               |
| DW_DISKCACHE_DISABLE         | N        | Disable disk caching, **If caching is not disabled, delete the environment variable** | "on"                               |
| DW_DISKCACHE_CLEAN_INTERVAL  | N        | Cache cleanup interval (default 30s) | Duration string |
| DW_DISKCACHE_EXPIRE_DURATION | N        | Cache expiration time (default 24h) | Duration string, such as `72h` for three days |

## Dataway API List {#apis}

> Details of each API below are to be added.

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
???+ attention "HTTP client metrics collection"

    If you want to collect metrics for Dataway HTTP requests to Kodo (or Dataway next hop), you need to manually enable the `http_client_trace` configuration. You can also specify `DW_HTTP_CLIENT_TRACE=on` during the installation phase.

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
|COUNTER|`dataway_http_api_body_too_large_dropped_total`|`api,method`|API request too large dropped|
|COUNTER|`dataway_http_api_with_inner_token`|`api,method`|API request with inner token|
|COUNTER|`dataway_http_api_dropped_total`|`api,method`|API request dropped when sinker rule match failed|
|COUNTER|`dataway_http_api_signed_total`|`api,method`|API signature count|
|SUMMARY|`dataway_http_api_cached_bytes`|`api,cache_type,method,reason`|API cached body bytes|
|SUMMARY|`dataway_http_api_reusable_body_read_bytes`|`api,method`|API re-read body on forking request|
|COUNTER|`dataway_http_api_forked_total`|`api,method,token`|API request forked total|
|GAUGE|`dataway_http_info`|`cascaded,docker,http_client_trace,listen,max_body,release_date,remote,version`|Dataway API basic info|
|GAUGE|`dataway_cpu_usage`|`N/A`|Dataway CPU usage(%)|
|GAUGE|`dataway_open_files`|`N/A`|Dataway open files|
|GAUGE|`dataway_cpu_cores`|`N/A`|Dataway CPU cores|
|COUNTER|`dataway_process_ctx_switch_total`|`type`|Dataway process context switch count(Linux only)|
|COUNTER|`dataway_process_io_count_total`|`type`|Dataway process IO count count|
|COUNTER|`dataway_process_io_bytes_total`|`type`|Dataway process IO bytes count|
|GAUGE|`dataway_last_heartbeat_time`|`N/A`|Dataway last heartbeat with Kodo timestamp|
|SUMMARY|`dataway_http_api_dropped_expired_cache`|`api,method`|Dropped expired cache data|
|SUMMARY|`dataway_http_api_elapsed_seconds`|`api,method,status`|API request latency|
|SUMMARY|`dataway_http_api_req_size_bytes`|`api,method,status`|API request size|
|COUNTER|`dataway_http_api_total`|`api,method,status`|API request count|
|SUMMARY|`dataway_httpcli_http_connect_cost_seconds`|`server`|HTTP connect cost|
|SUMMARY|`dataway_httpcli_got_first_resp_byte_cost_seconds`|`server`|Got first response byte cost|
|COUNTER|`dataway_httpcli_tcp_conn_total`|`server,remote,type`|HTTP TCP connection count|
|COUNTER|`dataway_httpcli_conn_reused_from_idle_total`|`server`|HTTP connection reused from idle count|
|SUMMARY|`dataway_httpcli_conn_idle_time_seconds`|`server`|HTTP connection idle time|
|SUMMARY|`dataway_httpcli_dns_cost_seconds`|`server`|HTTP DNS cost|
|SUMMARY|`dataway_httpcli_tls_handshake_seconds`|`server`|HTTP TLS handshake cost|
|COUNTER|`dataway_sinker_pull_total`|`event,source`|Sinker pulled or pushed counter|
|GAUGE|`dataway_sinker_rule_cache_miss`|`N/A`|Sinker rule cache miss|
|GAUGE|`dataway_sinker_rule_cache_hit`|`N/A`|Sinker rule cache hit|
|GAUGE|`dataway_sinker_rule_cache_size`|`N/A`|Sinker rule cache size|
|GAUGE|`dataway_sinker_rule_error`|`error`|Rule errors|
|GAUGE|`dataway_sinker_rule_last_applied_time`|`source`|Rule last appliied time(Unix timestamp)|
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
