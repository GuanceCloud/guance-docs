# Dataway
---

## Introduction {#intro}

DataWay is the data gateway of <<< custom_key.brand_name >>>. All data reported by collectors to <<< custom_key.brand_name >>> must go through the DataWay gateway.

## Dataway Installation {#install}

- **Create Dataway**

In the <<< custom_key.brand_name >>> management console on the "Data Gateway" page, click “Create Dataway”. Enter a name and bind address, then click “Create”.

After successful creation, a new Dataway will be automatically created along with the installation script for Dataway.

<!-- markdownlint-disable MD046 -->
???+ info

    The bind address is the Dataway gateway address. It must be a complete HTTP address, such as `http(s)://1.2.3.4:9528`, including protocol, host address, and port. The host address can generally be the IP address of the machine where Dataway is deployed or can be specified as a domain name which needs proper DNS resolution.

    Note: Ensure that the collector can access this address; otherwise, data collection will not succeed.
<!-- markdownlint-enable -->

- **Install Dataway**

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    ```shell
    DW_KODO=http://kodo_ip:port \
       DW_TOKEN=<tkn_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX> \
       DW_UUID=<YOUR_UUID> \
       bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/dataway/install.sh)"
    ```

    After installation, in the installation directory, a *dataway.yaml* file will be generated. Its content is as follows and can be manually modified to take effect after restarting the service.

    ??? info "*dataway.yaml* (Click to expand)"

        ```yaml
        # ============= DATAWAY CONFIG =============
        
        # Dataway UUID, we can get it during the creation of a new dataway
        uuid:
        
        # It's the workspace token, most of the time, it's
        # system worker space's token.
        token:
        
        # secret_token used under sinker mode, and to check if incoming datakit
        # requests are valid.
        secret_token:
        
        # If __internal__ token allowed? If ok, the data/request will direct to
        # the workspace with the token above
        enable_internal_token: false
        
        # Is empty token allowed? If ok, the data/request will direct to
        # the workspace with the token above
        enable_empty_token: false
        
        # Is dataway cascaded? For cascaded Dataway, its remote_host is
        # another Dataway and not Kodo.
        cascaded: false
        
        # kodo(next dataway) related configurations
        remote_host:
        http_timeout: 30s
        
        http_max_idle_conn_perhost: 0 # default to CPU cores
        http_max_conn_perhost: 0      # default no limit
        
        insecure_skip_verify: false
        http_client_trace: false
        max_conns_per_host: 0
        sni: ""
        
        # dataway API configurations
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
        #    - http://localhost:2379 # one or multiple etcd hosts
        #    dial_timeout: 30s
        #    key_space: "/dw_sinker" # subscribe to the etcd key
        #    username: "dataway"
        #    password: "<PASSWORD>"
        #  #file:
        #  #  path: /path/to/sinker.json
        ```

=== "Kubernetes"

    Download [*dataway.yaml*](https://static.<<< custom_key.brand_main_domain >>>/dataway/dataway.yaml){:target="_blank"} and install:

    ```shell
    $ wget https://static.<<< custom_key.brand_main_domain >>>/dataway/dataway.yaml -O dw-deployment.yaml
    $ kubectl apply -f dw-deployment.yaml
    ```

    In *dw-deployment.yaml*, you can modify Dataway configurations via environment variables; refer to [here](dataway.md#img-envs).

    You can also mount an external *dataway.yaml* via ConfigMap but must mount it as */usr/local/cloudcare/dataflux/dataway/dataway.yaml*:

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

???+ note "Notes"

    - Dataway only runs on Linux systems (currently only Linux arm64/amd64 binaries are released)
    - During host installation, the Dataway installation path is */usr/local/cloudcare/dataflux/dataway*
    - Kubernetes defaults to setting resource limits of 4000m/4Gi, which can be adjusted based on actual conditions. The minimum requirement is 100m/512Mi
<!-- markdownlint-enable -->

- **Verify Dataway Installation**

After installation, wait a moment and refresh the "Data Gateway" page. If you see the version number in the "Version Information" column of the newly added data gateway, it indicates that this Dataway has successfully connected to the <<< custom_key.brand_name >>> center, and front-end users can start connecting data through it.

Once Dataway successfully connects to the <<< custom_key.brand_name >>> center, log in to the <<< custom_key.brand_name >>> console, go to the "Integration"/"DataKit" page, view all Dataway addresses, select the required Dataway gateway address, obtain the DataKit installation instructions and execute them on the server to start collecting data.

## Manage DataWay {#manage}

### Delete DataWay {#delete}

In the <<< custom_key.brand_name >>> management console on the "Data Gateway" page, choose the DataWay you need to delete, click “Configure”, in the popped-up DataWay edit dialog box, click the “Delete” button at the bottom left.

<!-- markdownlint-disable MD046 -->
???+ warning

    After deleting DataWay, you still need to log in to the server where the DataWay gateway is deployed to stop the operation of DataWay and delete the installation directory to completely remove DataWay.
<!-- markdownlint-enable -->

### Upgrade DataWay {#upgrade}

On the <<< custom_key.brand_name >>> management console "Data Gateway" page, if there is an upgradable version for DataWay, an upgrade prompt will appear in the version information section.

<!-- markdownlint-disable MD046 -->
=== "Host Upgrade"

    ```shell
    DW_UPGRADE=1 bash -c "$(curl https://static.<<< custom_key.brand_main_domain >>>/dataway/install.sh)"
    ```

=== "Kubernetes Upgrade"

    Directly replace the image version:

    ```yaml
    - image: pubrepo.jiagouyun.com/dataflux/dataway:<VERSION>
    ```
<!-- markdownlint-enable -->

### Dataway Service Management {#manage-service}

For host-installed Dataway, use the following commands to manage the Dataway service.

``` shell
# Start
$ systemctl start dataway

# Restart
$ systemctl restart dataway

# Stop
$ systemctl stop dataway
```

For Kubernetes, simply restart the corresponding Pod.

## Environment Variables {#dw-envs}

### Host Installation Supported Environment Variables {#install-envs}

> We no longer recommend host installation, and new configuration items are no longer supported via command-line parameters. If you cannot change the deployment method, it is suggested to manually modify the corresponding configurations after installation (upgrade). Default configurations are shown in the default configuration example above.

During host installation, you can inject the following environment variables into the installation command:

| Env                   | Type      | Required | Description                                                                                                               | Example Value |
| ---                   | ---       | ---      | ---                                                                                                                | ---      |
| DW_BIND               | string    | N        | Dataway HTTP API bind address, default `0.0.0.0:9528`                                                                     |          |
| DW_CASCADED           | boolean   | N        | Whether Dataway is cascaded                                                                                                   | `true`   |
| DW_HTTP_CLIENT_TRACE  | boolean   | N        | Enable some related metrics collection when Dataway acts as an HTTP client, these metrics will ultimately be output in Prometheus metrics                 | `true`   |
| DW_KODO               | string    | Y        | Kodo address or next Dataway address, e.g., `http://host:port`                                                          |          |
| DW_TOKEN              | string    | Y        | Generally the data Token of the system workspace                                                                                     |          |
| DW_UPGRADE            | boolean   | N        | Set to 1 for upgrades                                                                                                 |          |
| DW_UUID               | string    | Y        | Dataway UUID, generated by the system workspace when creating a new Dataway                                                        |          |
| DW_TLS_CRT            | file-path | N        | Specify HTTPS/TLS crt file path [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                       |          |
| DW_TLS_KEY            | file-path | N        | Specify HTTPS/TLS key file path [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                       |          |
| DW_PROM_EXPORTOR_BIND | string    | N        | Specify Dataway's own metrics exposure HTTP port (default 9090) [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0) |          |
| DW_PPROF_BIND         | string    | N        | Specify Dataway's own pprof HTTP port (default 6060) [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)     |          |
| DW_DISK_CACHE_CAP_MB  | int       | N        | Specify disk cache size (in MB), default 65535MB [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)         |          |

<!-- markdownlint-disable MD046 -->
???+ warning

    Sinker-related settings need to be manually modified after installation. Currently, Sinker configurations cannot be specified during installation. [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0-brk)
<!-- markdownlint-enable -->

### Image Environment Variables {#img-envs}

When Dataway runs in a Kubernetes environment, it supports the following environment variables.

<!-- markdownlint-disable MD046 -->
???+ warning "Compatibility with existing dataway.yaml"

    Since some old Dataways are configured via ConfigMap (the filename mounted in the container is usually *dataway.yaml*),
    if the Dataway image detects an existing ConfigMap-mounted file in the installation directory, the following `DW_*` environment variables will not take effect.
    Removing the existing ConfigMap mount allows these environment variables to take effect.

    If the environment variables are effective, a hidden (viewable with `ls -a`) *.dataway.yaml* file will exist in the Dataway installation directory. You can check the effectiveness of the environment variables by using `cat` on this file.
<!-- markdownlint-enable -->

#### HTTP Server Settings {#env-apis}

| Env                           | Type      | Required | Description                                                                                                                            | Example Value |
| ---                           | ---       | ---      | ---                                                                                                                             | ---      |
| DW_REMOTE_HOST                | string    | Y        | Kodo address or next Dataway address, e.g., `http://host:port`                                                                       |          |
| DW_WHITE_LIST                 | string    | N        | Dataway client IP whitelist, separated by English `,`                                                                                       |          |
| DW_HTTP_TIMEOUT               | string    | N        | Timeout setting for Dataway's requests to Kodo or the next Dataway, default 30s                                                                         |          |
| DW_HTTP_MAX_IDLE_CONN_PERHOST | int       | N        | Maximum idle connection setting for Dataway's requests to Kodo, default value is CPU cores[:octicons-tag-24: Version-1.6.2](dataway-changelog.md#cl-1.6.2) |          |
| DW_HTTP_MAX_CONN_PERHOST      | int       | N        | Maximum connection setting for Dataway's requests to Kodo, default unlimited[:octicons-tag-24: Version-1.6.2](dataway-changelog.md#cl-1.6.2)                    |          |
| DW_BIND                       | string    | N        | Dataway HTTP API bind address, default `0.0.0.0:9528`                                                                                  |          |
| DW_API_LIMIT                  | int       | N        | API rate limiting setting for Dataway, e.g., setting it to 1000 means each specific API can be requested up to 1000 times per second, default 100K                                   |          |
| DW_HEARTBEAT                  | string    | N        | Heartbeat interval between Dataway and the center, default 60s                                                                                              |          |
| DW_MAX_HTTP_BODY_BYTES        | int       | N        | Maximum allowed HTTP Body size for Dataway API (**unit bytes**), default 64MB                                                                     |          |
| DW_TLS_INSECURE_SKIP_VERIFY   | boolean   | N        | Ignore HTTPS/TLS certificate errors                                                                                                         | `true`   |
| DW_HTTP_CLIENT_TRACE          | boolean   | N        | When Dataway acts as an HTTP client, enable some related metrics collection, these metrics will ultimately be output in Prometheus metrics                              | `true`   |
| DW_ENABLE_TLS                 | boolean   | N        | Enable HTTPS [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                                                     |          |
| DW_TLS_CRT                    | file-path | N        | Specify HTTPS/TLS crt file path [:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                    |          |
| DW_TLS_KEY                    | file-path | N        | Specify HTTPS/TLS key file path[:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                     |          |
| DW_SNI                        | string    | N        | Specify the current Dataway SNI information[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)                                       |          |
| DW_DISABLE_404PAGE            | boolean   | N        | Disable 404 page[:octicons-tag-24: Version-1.6.1](dataway-changelog.md#cl-1.6.1)                                                   |          |

[^1]: This restriction is to avoid Dataway containers/Pods being limited to approximately 20,000 connections due to system limitations. Increasing the limit will affect the efficiency of Dataway data uploads. When Dataway traffic is high, consider increasing the CPU count for individual Dataways or horizontally scaling Dataway instances.

##### HTTP TLS Settings {#http-tls}

To generate a TLS certificate valid for one year, you can use the following OpenSSL command:

```shell
# Generate a TLS certificate valid for one year
$ openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out tls.crt -keyout tls.key
...
```

After executing this command, the system will prompt you to enter some necessary information, including your country, region, city, organization name, department name, and email address. This information will be included in your certificate.

After completing the information input, two files will be generated: *tls.crt* (certificate file) and *tls.key* (private key file). Safely store your private key file and ensure its security.

To make the application use these TLS certificates, you need to set the absolute paths of these two files in the application's environment variables. Below is an example of setting environment variables:

> Must first enable `DW_ENABLE_TLS`, then the other two ENV (`DW_TLS_CRT/DW_TLS_KEY`) will take effect. [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)

```yaml
env:
- name: DW_ENABLE_TLS
  value: "true"
- name: DW_TLS_CRT
  value: "/path/to/your/tls.crt"
- name: DW_TLS_KEY
  value: "/path/to/your/tls.key"
```

Replace `/path/to/your/tls.crt` and `/path/to/your/tls.key` with the actual paths where you store `tls.crt` and `tls.key`.

After setting, you can use the following command to test whether TLS is effective:

```shell
$ curl -k http://localhost:9528
```

If successful, it will display an ASCII Art message saying `It's working!`. If the certificate does not exist, there will be an error in the Dataway logs similar to the following:

```text
server listen(TLS) failed: open /path/to/your/tls.{crt,key}: no such file or directory
```

At this point, Dataway cannot start, and the above curl command will also report an error:

```shell
$ curl -vvv -k http://localhost:9528
curl: (7) Failed to connect to localhost port 9528 after 6 ms: Couldn't connect to server
```

#### Log Settings {#env-logging}

| Env          | Type   | Required | Description                   | Example Value |
| ---          | ---    | ---      | ---                    | ---      |
| DW_LOG       | string | N        | Log path, default *log* |          |
| DW_LOG_LEVEL | string | N        | Default `info`          |          |
| DW_GIN_LOG   | string | N        | Default *gin.log*       |          |

#### Token/UUID Settings {#env-token-uuid}

| Env                      | Type    | Required | Description                                                                     | Example Value |
| ---                      | ---     | ---      | ---                                                                      | ---      |
| DW_UUID                  | string  | Y        | Dataway UUID, generated by the system workspace when creating a new Dataway              |          |
| DW_TOKEN                 | string  | Y        | Generally the data upload Token of the system workspace                                       |          |
| DW_SECRET_TOKEN          | string  | N        | Can set this Token when enabling Sinker functionality                                 |          |
| DW_ENABLE_INTERNAL_TOKEN | boolean | N        | Allow using `__internal__` as the client Token, default uses the system workspace's Token |          |
| DW_ENABLE_EMPTY_TOKEN    | boolean | N        | Allow uploading data without a Token, default uses the system workspace's Token              |          |

#### Sinker Settings {#env-sinker}

| Env                         | Type      | Required | Description                                                                     | Example Value |
| ---                         | ---       | ---      | ---                                                                      | ---      |
| DW_SECRET_TOKEN             | string    | N        | Can set this Token when enabling Sinker functionality                                   |          |
| DW_CASCADED                 | string    | N        | Whether Dataway is cascaded                                                         | `true`   |
| DW_SINKER_ETCD_URLS         | string    | N        | List of etcd addresses, separated by `,`, e.g., `http://1.2.3.4:2379,http://1.2.3.4:2380` |          |
| DW_SINKER_ETCD_DIAL_TIMEOUT | string    | N        | Etcd connection timeout, default 30s                                                  |          |
| DW_SINKER_ETCD_KEY_SPACE    | string    | N        | Key name for Sinker configuration in etcd (default `/dw_sinker`)                     |          |
| DW_SINKER_ETCD_USERNAME     | string    | N        | Etcd username                                                              |          |
| DW_SINKER_ETCD_PASSWORD     | string    | N        | Etcd password                                                                |          |
| DW_SINKER_FILE_PATH         | file-path | N        | Specify sinker rule configuration via a local file                                       |          |

<!-- markdownlint-disable MD046 -->
???+ warning

    If both local file and etcd methods are specified, the local file's Sinker rules will take precedence.
<!-- markdownlint-enable -->

#### Prometheus Metrics Exposure {#env-metrics}

| Env              | Type    | Required | Description                                             | Example Value |
| ---              | ---     | ---      | ---                                              | ---      |
| DW_PROM_URL      | string  | N        | URL Path for Prometheus metrics (default `/metrics`)|          |
| DW_PROM_LISTEN   | string  | N        | Address for exposing Prometheus metrics (default `localhost:9090`) |          |
| DW_PROM_DISABLED | boolean | N        | Disable Prometheus metrics exposure                         | `true`   |

#### Disk Cache Settings {#env-diskcache}

| Env                           | Type      | Required | Description                                                                                                                                                                  | Example Value                           |
| ---                           | ---       | ---      | ---                                                                                                                                                                           | ---                                |
| DW_DISKCACHE_DIR              | file-path | N        | Set cache directory, **this directory is generally mounted storage**                                                                                                                                  | *path/to/your/cache*               |
| DW_DISKCACHE_DISABLE          | boolean   | N        | Disable disk cache, **if not disabling cache, remove this environment variable**                                                                                                                    | `true`                             |
| DW_DISKCACHE_CLEAN_INTERVAL   | string    | N        | Cache cleanup interval, default 30s                                                                                                                                                | Duration string                    |
| DW_DISKCACHE_EXPIRE_DURATION  | string    | N        | Cache expiration time, default 168h (7d)                                                                                                                                         | Duration string, e.g., `72h` indicating three days |
| DW_DISKCACHE_CAPACITY_MB      | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set available disk space size, unit MB, default 20GB                                                           | Specifying `1024` is 1GB                 |
| DW_DISKCACHE_BATCH_SIZE_MB    | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set maximum size of a single disk cache file, unit MB, default 64MB                                                     | Specifying `1024` is 1GB                 |
| DW_DISKCACHE_MAX_DATA_SIZE_MB | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set maximum size of a single cache content (e.g., single HTTP body), unit MB, default 64MB, exceeding this size will drop the single data packet | Specifying `1024` is 1GB                 |

<!-- markdownlint-disable MD046 -->
???+ tips

    Setting `DW_DISKCACHE_DISABLE` disables disk cache.
<!-- markdownlint-enable -->

#### Performance-Related Settings {#env-perfmance}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

| Env                      | Type | Required | Description                                                                                       | Example Value |
| ---                      | ---  | ---      | ---                                                                                        | ---      |
| DW_COPY_BUFFER_DROP_SIZE | int  | N        | Immediately clear HTTP body buffers exceeding the specified size (unit bytes) to avoid excessive memory consumption. Default value 256KB | 524288   |

## Dataway API List {#apis}

> Details of the following APIs are pending.

### `GET /v1/ntp/` {#v1-ntp}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

- API Description: Get the current Unix timestamp (in seconds) of Dataway

### `POST /v1/write/:category` {#v1-write-category}

- API Description: Receive various types of collected data uploaded by Datakit

### `GET /v1/datakit/pull` {#v1-datakit-pull}

- API Description: Handle Datakit's pull request for central configurations (blacklist/Pipeline)

### `POST /v1/write/rum/replay` {#v1-write-rum-replay}

- API Description: Receive Session Replay data uploaded by Datakit

### `POST /v1/upload/profiling` {#v1-upload-profiling}

- API Description: Receive Profiling data uploaded by Datakit

### `POST /v1/election` {#v1-election}

- API Description: Handle Datakit's election request

### `POST /v1/election/heartbeat` {#v1-election-heartbeat}

- API Description: Handle Datakit's election heartbeat request

### `POST /v1/query/raw` {#v1-query-raw}

Handle DQL query requests. A simple example is as follows:

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

Response example:

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

Explanation of the response results:

- Real data is located in the inner `series` field
- `name` indicates the Mearsurement name (for this query, it is the CPU metric; if it is log data, this field does not exist)
- `columns` indicate the names of the returned result columns
- `values` contain the column results corresponding to `columns`

---

<!-- markdownlint-disable MD046 -->
???+ info

    - The token in the URL request parameter can differ from the token in the JSON body. The former is used to verify the validity of the query request, while the latter determines the target workspace for the data.
    - The `queries` field can contain multiple queries, each of which can carry additional fields. Refer to [here](../datakit/apis.md#api-raw-query) for the list of specific fields.
<!-- markdownlint-enable -->

---

### `POST /v1/workspace` {#v1-workspace}

- API Description: Handle workspace query requests initiated by Datakit

### `POST /v1/object/labels` {#v1-object-labels}

- API Description: Handle object Label modification requests

### `DELETE /v1/object/labels` {#v1-delete-object-labels}

- API Description: Handle object Label deletion requests

### `GET /v1/check/:token` {#v1-check-token}

- API Description: Check if the token is valid

## Dataway Metric Collection {#collect-metrics}

<!-- markdownlint-disable MD046 -->
???+ warning "HTTP Client Metric Collection"

    To collect metrics for Dataway's HTTP requests to Kodo (or the next-hop Dataway), you need to manually enable the `http_client_trace` configuration or specify the environment variable `DW_HTTP_CLIENT_TRACE=true`.

=== "Host Deployment"

    Dataway exposes Prometheus metrics, which can be collected by Datakit's built-in `prom` collector. An example configuration for the collector is as follows:

    ```toml
    [[inputs.prom]]
      ## Exporter URLs.
      urls = [ "http://localhost:9090/metrics", ]
      source = "dataway"
      election = true
      measurement_name = "dw" # The metric set for Dataway is fixed as "dw", do not change it
    [inputs.prom.tags]
      service = "dataway"
    ```

=== "Kubernetes"

    If the cluster has Datakit deployed (version [Datakit 1.14.2](../datakit/changelog.md#cl-1.14.2) or higher), you can enable Prometheus metrics exposure in Dataway (Dataway's default POD yaml already includes this):

    ```yaml
    annotations: # The following annotation is added by default
       datakit/prom.instances: |
         [[inputs.prom]]
           url = "http://$IP:9090/metrics" # This port (default 9090) depends on the situation
           source = "dataway"
           measurement_name = "dw" # Fixed as this metric set
           interval = "10s"
           disable_instance_tag = true

         [inputs.prom.tags]
           service = "dataway"
           instance = "$PODNAME"

    ...
    env:
    - name: DW_PROM_LISTEN
      value: "0.0.0.0:9090" # This port should match the port in the above URL
    ```

<!-- markdownlint-enable -->

---

If collection is successful, search for `dataway` in <<< custom_key.brand_name >>>'s "Scenarios"/"Built-in Views" to see the corresponding monitoring view.

### Dataway Metric List {#metrics}

Below are the metrics exposed by Dataway. By requesting `http://localhost:9090/metrics`, you can obtain these metrics. You can use the following command to monitor (every 3 seconds) a specific metric in real-time:

> Some metrics may not be found because the relevant business modules have not yet started. Some new metrics only exist in the latest versions, so the version information of each metric is not listed here. Refer to the metrics list returned by the `/metrics` interface for accurate information.

```shell
watch -n 3 'curl -s http://localhost:9090/metrics | grep -a <METRIC-NAME>'
```

|TYPE|NAME|LABELS|HELP|
|---|---|---|---|
|SUMMARY|`dataway_http_api_elapsed_seconds`|`api,method,status`|API request latency|
|SUMMARY|`dataway_http_api_body_buffer_utilization`|`api`|API body buffer utilization (Len/Cap)|
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
|SUMMARY|`dataway_http_api_recv_points`|`api`|API /v1/write/:category received points|
|SUMMARY|`dataway_http_api_send_points`|`api`|API /v1/write/:category send points|
|SUMMARY|`dataway_http_api_cache_points`|`api,cache_type`|Disk cached /v1/write/:category points|
|SUMMARY|`dataway_http_api_cache_cleaned_points`|`api,cache_type,status`|Disk cache cleaned /v1/write/:category points|
|COUNTER|`dataway_http_api_forked_total`|`api,method,token`|API request forked total|
|GAUGE|`dataway_http_info`|`cascaded,docker,http_client_trace,listen,max_body,release_date,remote,version`|Dataway API basic info|
|GAUGE|`dataway_last_heartbeat_time`|`N/A`|Dataway last heartbeat with Kodo timestamp|
|GAUGE|`dataway_cpu_usage`|`N/A`|Dataway CPU usage (%)|
|GAUGE|`dataway_mem_stat`|`type`|Dataway memory usage stats|
|SUMMARY|`dataway_http_api_copy_buffer_drop_total`|`max`|API copy buffer dropped (too large cached buffer) count|
|GAUGE|`dataway_open_files`|`N/A`|Dataway open files|
|GAUGE|`dataway_cpu_cores`|`N/A`|Dataway CPU cores|
|GAUGE|`dataway_uptime`|`N/A`|Dataway uptime|
|COUNTER|`dataway_process_ctx_switch_total`|`type`|Dataway process context switch count (Linux only)|
|COUNTER|`dataway_process_io_count_total`|`type`|Dataway process IO count|
|SUMMARY|`dataway_http_api_copy_buffer_drop_total`|`max`|API copy buffer dropped (too large cached buffer) count|
|COUNTER|`dataway_process_io_bytes_total`|`type`|Dataway process IO bytes count|
|SUMMARY|`dataway_http_api_dropped_expired_cache`|`api,method`|Dropped expired cache data|
|SUMMARY|`dataway_httpcli_tls_handshake_seconds`|`server`|HTTP TLS handshake cost|
|SUMMARY|`dataway_httpcli_http_connect_cost_seconds`|`server`|HTTP connect cost|
|SUMMARY|`dataway_httpcli_got_first_resp_byte_cost_seconds`|`server`|Got first response byte cost|
|SUMMARY|`http_latency`|`api,server`|HTTP latency|
|C|COUNTER|`dataway_httpcli_tcp_conn_total`|`server,remote,type`|HTTP TCP connection count|
|COUNTER|`dataway_httpcli_conn_reused_from_idle_total`|`server`|HTTP connection reused from idle count|
|SUMMARY|`dataway_httpcli_conn_idle_time_seconds`|`server`|HTTP connection idle time|
|SUMMARY|`dataway_httpcli_dns_cost_seconds`|`server`|HTTP DNS cost|
|SUMMARY|`dataway_sinker_rule_cost_seconds`|`N/A`|Rule cost time seconds|
|SUMMARY|`dataway_sinker_cache_key_len`|`N/A`|Cache key length (bytes)|
|SUMMARY|`dataway_sinker_cache_val_len`|`N/A`|Cache value length (bytes)|
|COUNTER|`dataway_sinker_pull_total`|`event,source`|Sinker pulled or pushed counter|
|GAUGE|`dataway_sinker_rule_cache_miss`|`N/A`|Sinker rule cache miss|
|GAUGE|`dataway_sinker_rule_cache_hit`|`N/A`|Sinker rule cache hit|
|GAUGE|`dataway_sinker_rule_cache_size`|`N/A`|Sinker rule cache size|
|GAUGE|`dataway_sinker_rule_error`|`error`|Rule errors|
|GAUGE|`dataway_sinker_default_rule_hit`|`info`|Default sinker rule hit count|
|GAUGE|`dataway_sinker_rule_last_applied_time`|`source`|Rule last applied time (Unix timestamp)|
|COUNTER|`diskcache_put_bytes_total`|`path`|Cache Put() bytes count|
|COUNTER|`diskcache_get_total`|`path`|Cache Get() count|
|COUNTER|`diskcache_wakeup_total`|`path`|Wakeup count on sleeping write file|
|COUNTER|`diskcache_seek_back_total`|`path`|Seek back when Get() got any error|
|COUNTER|`diskcache_get_bytes_total`|`path`|Cache Get() bytes count|
|GAUGE|`diskcache_capacity`|`path`|Current capacity (in bytes)|
|GAUGE|`diskcache_max_data`|`path`|Max data to Put (in bytes), default 0|
|GAUGE|`diskcache_batch_size`|`path`|Data file size (in bytes)|
|GAUGE|`diskcache_size`|`path`|Current cache size (in bytes)|
|GAUGE|`diskcache_open_time`|`no_fallback_on_error,no_lock,no_pos,no_sync,path`|Current cache open time in Unix timestamp (second)|
|GAUGE|`diskcache_last_close_time`|`path`|Current cache last close time in Unix timestamp (second)|
|GAUGE|`diskcache_datafiles`|`path`|Current un-read data files|
|SUMMARY|`diskcache_get_latency`|`path`|Get() time cost (micro-second)|
|SUMMARY|`diskcache_put_latency`|`path`|Put() time cost (micro-second)|
|COUNTER|`diskcache_dropped_bytes_total`|`path`|Dropped bytes during Put() when capacity reached.|
|COUNTER|`diskcache_dropped_total`|`path,reason`|Dropped files during Put() when capacity reached.|
|COUNTER|`diskcache_rotate_total`|`path`|Cache rotate count, meaning file rotation from data to data.0000xxx|
|COUNTER|`diskcache_remove_total`|`path`|Removed file count, if some file read EOF, remove it from the un-read list|
|COUNTER|`diskcache_put_total`|`path`|Cache Put() count|

#### Metrics Collection in Docker Mode {#metrics-within-docker}

Host installation has two modes: one is host installation, and the other is through Docker. Here we specifically explain the differences in metrics collection when installed via Docker.

When installed via Docker, the exposed HTTP port for metrics will be mapped to the host's port 19090 (by default). At this point, the metrics collection address is `http://localhost:19090/metrics`.

If a different port is specified separately, then during Docker installation, it will add 10000 to the specified port, so ensure the specified port does not exceed 45535.

Additionally, when installing via Docker, the profile collection port will also be exposed, defaulting to port 16060 on the host. This mechanism also adds 10000 to the specified port.

### Dataway Self-Logging Collection and Processing {#logging}

Dataway's own logs are divided into two categories: one is Gin logs, and the other is application logs. The following Pipeline can separate them:

```python
# Pipeline for dataway logging

# Testing sample logging
'''
2023-12-14T11:27:06.744+0800    DEBUG   apis     apis/api_upload_profile.go:272   save profile file to disk [ok] /v1/upload/profiling?token=****************a4e3db8481c345a94fe5a
[GIN] 2021/10/25 - 06:48:07 | 200 |   30.890624ms |  114.215.200.73 | POST     "/v1/write/logging?token=tkn_5c862a11111111111111111111111111"
'''

add_pattern("TOKEN", "tkn_\\w+")
add_pattern("GINTIME", "%{YEAR}/%{MONTHNUM}/%{MONTHDAY}%{SPACE}-%{SPACE}%{HOUR}:%{MINUTE}:%{SECOND}")
grok(_,"\\[GIN\\]%{SPACE}%{GINTIME:timestamp}%{SPACE}\\|%{SPACE}%{NUMBER:dataway_code}%{SPACE}\\|%{SPACE}%{NOTSPACE:cost_time}%{SPACE}\\|%{SPACE}%{NOTSPACE:client_ip}%{SPACE}\\|%{SPACE}%{NOTSPACE:method}%{SPACE}%{GREEDYDATA:http_url}")

# Gin logging
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

# App logging
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

  # If debug level is enabled, drop most of them
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

Dataway exposes metrics and profiling collection endpoints, which we can collect to facilitate issue troubleshooting.

> The following information collection uses actual configured ports and addresses. The commands below use default parameters.

```shell title="dw-bug-report.sh"
br_dir="dw-br-$(date +%s)"
mkdir -p $br_dir

echo "save bug report to ${br_dir}"

# Modify these configurations based on actual conditions
dw_ip="localhost" # IP address where Dataway exposes metrics/profile
metric_port=9090  # Port for exposing metrics
profile_port=6060 # Port for exposing profiles
dw_yaml_conf="/usr/local/cloudcare/dataflux/dataway/dataway.yaml"
dw_dot_yaml_conf="/usr/local/cloudcare/dataflux/dataway/.dataway.yaml" # Present in container installations

# Collect runtime metrics
curl -v "http://${dw_ip}:${metric_port}/metrics" -o $br_dir/metrics

# Collect profiling information
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/allocs" -o $br_dir/allocs
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/heap" -o $br_dir/heap
curl -v "http://${dw_ip}:${profile_port}/debug/pprof/profile" -o $br_dir/profile # This command runs for about 30 seconds

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

After execution, a file similar to *dw-br-1721188604.tar.gz* will be generated. You can retrieve this file for further analysis.

## FAQ {#faq}

### Too Large Request Body Issue {#too-large-request-body}

[:octicons-tag-24: Version-1.3.7](dataway-changelog.md#cl-1.3.7)

Dataway has a default setting for request body size (default 64MB). When the request body is too large, the client receives an HTTP 413 error (`Request Entity Too Large`). If the request body is within a reasonable range, you can appropriately increase this value (unit bytes):

- Set the environment variable `DW_MAX_HTTP_BODY_BYTES`
- In *dataway.yaml*, set `max_http_body_bytes`

If a large request packet appears during operation, it will be reflected in both metrics and logs:

- The metric `dataway_http_too_large_dropped_total` exposes the number of dropped large requests
- Search Dataway logs `cat log | grep 'drop too large request'`, which outputs HTTP request headers for further understanding of the client situation

<!-- markdownlint-disable MD046 -->
???+ warning

    In the disk cache module, there is also a maximum data block write limit (default 64MB). If you increase the maximum request body configuration, adjust this configuration accordingly ([`ENV_DISKCACHE_MAX_DATA_SIZE`](https://github.com/GuanceCloud/cliutils/tree/main/diskcache#%E9%80%9A%E8%BF%87-env-%E6%8E%A7%E5%88%B6%E7%BC%93%E5%AD%98-option){:target="_blank"}) to ensure that large requests can be correctly written to disk cache.
<!-- markdownlint-enable -->