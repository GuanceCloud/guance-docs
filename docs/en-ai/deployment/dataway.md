# Dataway
---

## Introduction {#intro}

DataWay is Guance's data gateway, through which collectors report data to Guance. All data submissions must go through the DataWay gateway.

## Dataway Installation {#install}

- **Create a New Dataway**

In the Guance management console under the "Data Gateway" page, click “Create Dataway”. Enter the name and binding address, then click “Create”.

Upon successful creation, a new Dataway will be automatically created along with the installation script for Dataway.

<!-- markdownlint-disable MD046 -->
???+ info

    The binding address is the Dataway gateway address, which must include the full HTTP address, such as `http(s)://1.2.3.4:9528`, including protocol, host address, and port. The host address can generally use the IP address of the machine where Dataway is deployed or specify it as a domain name, which needs proper DNS resolution.

    Note: Ensure that the collector can access this address; otherwise, the data collection will not succeed.
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

    After installation, in the installation directory, a *dataway.yaml* file will be generated. An example content is shown below, which can be manually modified and made effective by restarting the service.

    ??? info "*dataway.yaml* (Click to expand)"

        ```yaml
        # ============= DATAWAY CONFIG =============
        
        # Dataway UUID, obtained during the creation of a new dataway
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

    Download [*dataway.yaml*](https://static.guance.com/dataway/dataway.yaml){:target="_blank"} and install:

    ```shell
    $ wget https://static.guance.com/dataway/dataway.yaml -O dw-deployment.yaml
    $ kubectl apply -f dw-deployment.yaml
    ```

    In *dw-deployment.yaml*, you can modify Dataway configurations via environment variables; see [here](dataway.md#img-envs).

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

    - Dataway can only run on Linux systems (currently only Linux arm64/amd64 binaries are released)
    - During host installation, the Dataway installation path is */usr/local/cloudcare/dataflux/dataway*
    - Kubernetes sets default resource limits of 4000m/4Gi, which can be adjusted according to actual conditions. Minimum requirements are 100m/512Mi.
<!-- markdownlint-enable -->

- **Verify Dataway Installation**

After installation, refresh the "Data Gateway" page after a short wait. If you see a version number in the "Version Information" column of the newly added data gateway, it indicates that this Dataway has successfully connected to the Guance center, and frontend users can start sending data through it.

Once Dataway successfully connects to the Guance center, log into the Guance control panel, go to the "Integration" / "DataKit" page, view all Dataway addresses, select the required Dataway gateway address, obtain the DataKit installation instructions, and execute them on the server to start collecting data.

## Managing DataWay {#manage}

### Deleting DataWay {#delete}

In the Guance management console under the "Data Gateway" page, select the DataWay you want to delete, click "Configuration", and in the pop-up edit DataWay dialog box, click the "Delete" button at the bottom left.

<!-- markdownlint-disable MD046 -->
???+ warning

    After deleting DataWay, you need to log into the server where the DataWay gateway is deployed to stop the DataWay service and delete the installation directory to completely remove DataWay.
<!-- markdownlint-enable -->

### Upgrading DataWay {#upgrade}

On the "Data Gateway" page in the Guance management console, if there is an available upgrade for DataWay, there will be an upgrade prompt in the version information section.

<!-- markdownlint-disable MD046 -->
=== "Host Upgrade"

    ```shell
    DW_UPGRADE=1 bash -c "$(curl https://static.guance.com/dataway/install.sh)"
    ```

=== "Kubernetes Upgrade"

    Simply replace the image version:

    ```yaml
    - image: pubrepo.jiagouyun.com/dataflux/dataway:<VERSION>
    ```
<!-- markdownlint-enable -->

### Dataway Service Management {#manage-service}

When installing Dataway on a host, you can manage the Dataway service using the following commands.

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

> We no longer recommend host installation, and new configuration items are not supported via command-line parameters. If you cannot change the deployment method, it is suggested to manually modify the corresponding configurations after installation (upgrade). Default configurations are shown in the default configuration example above.

During host installation, the following environment variables can be injected into the installation command:

| Env                   | Type     | Required | Description                                                                                                               | Example Value |
| ---                   | ---       | ---      | ---                                                                                                                | ---      |
| DW_BIND               | string    | N        | Dataway HTTP API bind address, default `0.0.0.0:9528`                                                                     |          |
| DW_CASCADED           | boolean   | N        | Whether Dataway is cascaded                                                                                                   | `true`   |
| DW_HTTP_CLIENT_TRACE  | boolean   | N        | Dataway acts as an HTTP client and can collect some related metrics, these metrics will eventually be exposed in its Prometheus metrics                 | `true`   |
| DW_KODO               | string    | Y        | Kodo address or next Dataway address, format `http://host:port`                                                          |          |
| DW_TOKEN              | string    | Y        | Generally the data Token of the system workspace                                                                                 |          |
| DW_UPGRADE            | boolean   | N        | Set to 1 for upgrade                                                                                                 |          |
| DW_UUID               | string    | Y        | Dataway UUID, generated when creating a new Dataway in the system workspace                                                        |          |
| DW_TLS_CRT            | file-path | N        | Specify HTTPS/TLS crt file path [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                       |          |
| DW_TLS_KEY            | file-path | N        | Specify HTTPS/TLS key file path [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                       |          |
| DW_PROM_EXPORTOR_BIND | string    | N        | Specify Dataway's own metric exposure HTTP port (default 9090) [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0) |          |
| DW_PPROF_BIND         | string    | N        | Specify Dataway's own pprof HTTP port (default 6060) [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)     |          |
| DW_DISK_CACHE_CAP_MB  | int       | N        | Specify disk cache size (unit MB), default 65535MB [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0)         |          |

<!-- markdownlint-disable MD046 -->
???+ warning

    Sinker-related settings need to be manually modified after installation. Currently, they are not supported during the installation process. [:octicons-tag-24: Version-1.5.0](dataway-changelog.md#cl-1.5.0-brk)
<!-- markdownlint-enable -->

### Image Environment Variables {#img-envs}

When running Dataway in a Kubernetes environment, the following environment variables are supported.

<!-- markdownlint-disable MD046 -->
???+ warning "Compatibility with existing dataway.yaml"

    Since some old Dataways were configured via ConfigMap (usually mounted as *dataway.yaml* in the container),
    if the Dataway image detects an existing ConfigMap-mounted file in the installation directory, the following `DW_*` environment variables will not take effect.
    Removing the existing ConfigMap mount allows these environment variables to take effect.

    If the environment variables are effective, a hidden *.dataway.yaml* file will appear in the Dataway installation directory (viewable with `ls -a`). You can `cat`
    this file to confirm the effectiveness of the environment variables.
<!-- markdownlint-enable -->

#### HTTP Server Settings {#env-apis}

| Env                           | Type     | Required | Description                                                                                                                            | Example Value |
| ---                           | ---       | ---      | ---                                                                                                                             | ---      |
| DW_REMOTE_HOST                | string    | Y        | Kodo address or next Dataway address, format `http://host:port`                                                                       |          |
| DW_WHITE_LIST                 | string    | N        | Dataway client IP whitelist, separated by English `,`                                                                                       |          |
| DW_HTTP_TIMEOUT               | string    | N        | Timeout setting for Dataway requests to Kodo or the next Dataway, default 30s                                                                         |          |
| DW_HTTP_MAX_IDLE_CONN_PERHOST | int       | N        | Maximum idle connection setting for Dataway requests to Kodo, default value is CPU cores[:octicons-tag-24: Version-1.6.2](dataway-changelog.md#cl-1.6.2) |          |
| DW_HTTP_MAX_CONN_PERHOST      | int       | N        | Maximum connection setting for Dataway requests to Kodo, default unlimited[:octicons-tag-24: Version-1.6.2](dataway-changelog.md#cl-1.6.2)                    |          |
| DW_BIND                       | string    | N        | Dataway HTTP API bind address, default `0.0.0.0:9528`                                                                                  |          |
| DW_API_LIMIT                  | int       | N        | Dataway API rate limiting setting, e.g., set to 1000, allowing up to 1000 requests per second for each specific API, default 100K                                   |          |
| DW_HEARTBEAT                  | string    | N        | Heartbeat interval between Dataway and the center, default 60s                                                                                              |          |
| DW_MAX_HTTP_BODY_BYTES        | int       | N        | Maximum allowed HTTP Body size for Dataway API (**in bytes**), default 64MB                                                                     |          |
| DW_TLS_INSECURE_SKIP_VERIFY   | boolean   | N        | Ignore HTTPS/TLS certificate errors                                                                                                         | `true`   |
| DW_HTTP_CLIENT_TRACE          | boolean   | N        | Dataway acts as an HTTP client and can collect some related metrics, these metrics will eventually be exposed in its Prometheus metrics                              | `true`   |
| DW_ENABLE_TLS                 | boolean   | N        | Enable HTTPS [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)                                                     |          |
| DW_TLS_CRT                    | file-path | N        | Specify HTTPS/TLS crt file path [:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                    |          |
| DW_TLS_KEY                    | file-path | N        | Specify HTTPS/TLS key file path[:octicons-tag-24: Version-1.4.0](dataway-changelog.md#cl-1.4.0)                                     |          |
| DW_SNI                        | string    | N        | Specify current Dataway SNI information[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)                                       |          |
| DW_DISABLE_404PAGE            | boolean   | N        | Disable 404 page[:octicons-tag-24: Version-1.6.1](dataway-changelog.md#cl-1.6.1)                                                   |          |

[^1]: This limit is used to avoid Dataway containers/Pods being restricted by the system to use approximately 20,000 connections. Increasing this limit can affect the efficiency of Dataway data uploads. When Dataway traffic is high, consider increasing the number of CPUs for a single Dataway instance or horizontally scaling the Dataway instances.

##### HTTP TLS Settings {#http-tls}

To generate a TLS certificate valid for one year, you can use the following OpenSSL command:

```shell
# Generate a TLS certificate valid for one year
$ openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out tls.crt -keyout tls.key
...
```

After executing this command, the system will prompt you to input necessary information, including your country, region, city, organization name, department name, and email address. This information will be included in your certificate.

After completing the information input, two files will be generated: *tls.crt* (certificate file) and *tls.key* (private key file). Safeguard your private key file and ensure its security.

To make the application use these TLS certificates, you need to set the absolute paths of these two files in the application’s environment variables. Here is an example of setting environment variables:

> Must first enable `DW_ENABLE_TLS`, otherwise the other two ENV (`DW_TLS_CRT/DW_TLS_KEY`) will not take effect. [:octicons-tag-24: Version-1.4.1](dataway-changelog.md#cl-1.4.1)

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

After setting, you can test if TLS is effective using the following command:

```shell
$ curl -k http://localhost:9528
```

If successful, it will display an ASCII Art message saying `It's working!`. If the certificate does not exist, there will be an error similar to the following in the Dataway logs:

```text
server listen(TLS) failed: open /path/to/your/tls.{crt,key}: no such file or directory
```

At this point, Dataway cannot start, and the above curl command will also fail:

```shell
$ curl -vvv -k http://localhost:9528
curl: (7) Failed to connect to localhost port 9528 after 6 ms: Couldn't connect to server
```

#### Logging Settings {#env-logging}

| Env          | Type   | Required | Description                   | Example Value |
| ---          | ---    | ---      | ---                    | ---      |
| DW_LOG       | string | N        | Log path, default *log* |          |
| DW_LOG_LEVEL | string | N        | Default `info`          |          |
| DW_GIN_LOG   | string | N        | Default *gin.log*       |          |

#### Token/UUID Settings {#env-token-uuid}

| Env                      | Type    | Required | Description                                                                     | Example Value |
| ---                      | ---     | ---      | ---                                                                      | ---      |
| DW_UUID                  | string  | Y        | Dataway UUID, generated when creating a new Dataway in the system workspace              |          |
| DW_TOKEN                 | string  | Y        | Generally the data upload Token of the system workspace                                       |          |
| DW_SECRET_TOKEN          | string  | N        | Can set this Token when enabling Sinker feature                                 |          |
| DW_ENABLE_INTERNAL_TOKEN | boolean | N        | Allow using `__internal__` as the client Token, defaulting to the system workspace Token |          |
| DW_ENABLE_EMPTY_TOKEN    | boolean | N        | Allow uploading data without a Token, defaulting to the system workspace Token              |          |

#### Sinker Settings {#env-sinker}

| Env                         | Type      | Required | Description                                                                     | Example Value |
| ---                         | ---       | ---      | ---                                                                      | ---      |
| DW_SECRET_TOKEN             | string    | N        | Can set this Token when enabling Sinker feature                                   |          |
| DW_CASCADED                 | string    | N        | Whether Dataway is cascaded                                                         | `true`   |
| DW_SINKER_ETCD_URLS         | string    | N        | List of etcd addresses, separated by `,`, e.g., `http://1.2.3.4:2379,http://1.2.3.4:2380` |          |
| DW_SINKER_ETCD_DIAL_TIMEOUT | string    | N        | Etcd connection timeout, default 30s                                                  |          |
| DW_SINKER_ETCD_KEY_SPACE    | string    | N        | Sinker configuration etcd key name (default `/dw_sinker`)                     |          |
| DW_SINKER_ETCD_USERNAME     | string    | N        | Etcd username                                                              |          |
| DW_SINKER_ETCD_PASSWORD     | string    | N        | Etcd password                                                                |          |
| DW_SINKER_FILE_PATH         | file-path | N        | Specify sinker rules configuration via a local file                                       |          |

<!-- markdownlint-disable MD046 -->
???+ warning

    If both local file and etcd methods are specified, the local file Sinker rules will take precedence.
<!-- markdownlint-enable -->

#### Prometheus Metrics Exposure {#env-metrics}

| Env              | Type    | Required | Description                                             | Example Value |
| ---              | ---     | ---      | ---                                              | ---      |
| DW_PROM_URL      | string  | N        | Prometheus metrics URL Path (default `/metrics`）    |          |
| DW_PROM_LISTEN   | string  | N        | Prometheus metrics exposure address (default `localhost:9090`) |          |
| DW_PROM_DISABLED | boolean | N        | Disable Prometheus metrics exposure                         | `true`   |

#### Disk Cache Settings {#env-diskcache}

| Env                           | Type      | Required | Description                                                                                                                                                                  | Example Value                           |
| ---                           | ---       | ---      | ---                                                                                                                                                                   | ---                                |
| DW_DISKCACHE_DIR              | file-path | N        | Set cache directory, **this directory is generally mounted storage**                                                                                                                                  | *path/to/your/cache*               |
| DW_DISKCACHE_DISABLE          | boolean   | N        | Disable disk cache, **if not disabled, remove this environment variable**                                                                                                                    | `true`                             |
| DW_DISKCACHE_CLEAN_INTERVAL   | string    | N        | Cache cleanup interval, default 30s                                                                                                                                                | Duration string                    |
| DW_DISKCACHE_EXPIRE_DURATION  | string    | N        | Cache expiration time, default 168h（7d）                                                                                                                                         | Duration string, e.g., `72h` for three days |
| DW_DISKCACHE_CAPACITY_MB      | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set available disk space size, unit MB, default 20GB                                                           | Set `1024` for 1GB                 |
| DW_DISKCACHE_BATCH_SIZE_MB    | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set maximum size of a single disk cache file, unit MB, default 64MB                                                     | Set `1024` for 1GB                 |
| DW_DISKCACHE_MAX_DATA_SIZE_MB | int       | N        | [:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0) Set maximum size of a single cache content (e.g., a single HTTP body), unit MB, default 64MB, exceeding this size will be discarded | Set `1024` for 1GB                 |

<!-- markdownlint-disable MD046 -->
???+ tips

    Setting `DW_DISKCACHE_DISABLE` disables the disk cache.
<!-- markdownlint-enable -->

#### Performance-related Settings {#env-perfmance}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

| Env                      | Type | Required | Description                                                                                       | Example Value |
| ---                      | ---  | ---      | ---                                                                                        | ---      |
| DW_COPY_BUFFER_DROP_SIZE | int  | N        | HTTP body buffers exceeding the specified size (in bytes) will be immediately cleared to avoid excessive memory consumption. Default value 256KB | 524288   |

## Dataway API List {#apis}

> Details of each API below are to be supplemented.

### `GET /v1/ntp/` {#v1-ntp}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

- API Description: Get the current Unix timestamp (seconds) from Dataway

### `POST /v1/write/:category` {#v1-write-category}

- API Description: Receive various collected data uploaded by Datakit

### `GET /v1/datakit/pull` {#v1-datakit-pull}

- API Description: Handle Datakit's request to pull central configuration (blacklist/Pipeline)

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

Response result explanation:

- Real data is located in the inner `series` field
- `name` represents the name of the Mearsurement (in this case, querying CPU Metrics; if it's log data, this field does not exist)
- `columns` represent the names of the returned result columns
- `values` contain the corresponding column results for `columns`

---

<!-- markdownlint-disable MD046 -->
???+ info

    - The token in the URL request parameter can differ from the token in the JSON body. The former is used to verify the legality of the query request, while the latter determines the target workspace for the data.
    - The `queries` field can contain multiple queries, each of which can carry additional fields. See [here](../datakit/apis.md#api-raw-query) for the list of specific fields.
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

## Dataway Metrics Collection {#collect-metrics}

<!-- markdownlint-disable MD046 -->
???+ warning "HTTP Client Metrics Collection"

    To collect metrics for Dataway HTTP requests to Kodo (or the next hop Dataway), you need to manually enable the `http_client_trace` configuration. Or set the environment variable `DW_HTTP_CLIENT_TRACE=true`.

=== "Host Deployment"

    Dataway exposes Prometheus metrics, which can be collected using the built-in `prom` collector in Datakit. Sample configuration for the collector is as follows:

    ```toml
    [[inputs.prom]]
      ## Exporter URLs.
      urls = [ "http://localhost:9090/metrics", ]
      source = "dataway"
      election = true
      measurement_name = "dw" # Fixed as dw, do not change
    [inputs.prom.tags]
      service = "dataway"
    ```

=== "Kubernetes"

    If Datakit is deployed in the cluster (requires [Datakit 1.14.2](../datakit/changelog.md#cl-1.14.2) or higher), you can enable Prometheus metrics exposure in Dataway (already included by default in the Dataway POD yaml):

    ```yaml
    annotations: # The following annotation is already added by default
       datakit/prom.instances: |
         [[inputs.prom]]
           url = "http://$IP:9090/metrics" # This port (default 9090) depends on the situation
           source = "dataway"
           measurement_name = "dw" # Fixed as this Mearsurement
           interval = "10s"
           disable_instance_tag = true

         [inputs.prom.tags]
           service = "dataway"
           instance = "$PODNAME"

    ...
    env:
    - name: DW_PROM_LISTEN
      value: "0.0.0.0:9090" # Keep this port consistent with the port in the URL above
    ```

<!-- markdownlint-enable -->

---

If the collection is successful, search for `dataway` in the Guance "Scenarios" / "Built-in Views" to see the corresponding monitoring views.

### Dataway Metrics List {#metrics}

Below are the metrics exposed by Dataway. You can retrieve these metrics by requesting `http://localhost:9090/metrics`. You can monitor a specific metric in real-time (every 3 seconds) using the following command:

> Some metrics may not be found because the relevant business modules have not yet started. Certain new metrics only exist in the latest versions. Refer to the metrics list returned by the `/metrics` interface for accurate details.

```shell
watch -n 3 'curl -s http://localhost:9090/metrics | grep -a <METRIC-NAME>'
```

|TYPE|NAME|LABELS|HELP|
|---|---|---|---|
|SUMMARY|`dataway_http_api_elapsed_seconds`|`api,method,status`|API request latency|
|SUMMARY|`dataway_http_api_body_buffer_utilization`|`api`|API body buffer utilization(Len/Cap)|
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
|SUMMARY|`dataway_httpcli_dns_cost_seconds`|`server