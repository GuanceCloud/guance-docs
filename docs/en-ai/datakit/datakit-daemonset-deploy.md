# Kubernetes
---

This document introduces how to install DataKit in K8s using the DaemonSet method.

## Installation {#install}

<!-- markdownlint-disable MD046 -->
=== "DaemonSet"

    First, download [*datakit.yaml*](https://static.guance.com/datakit/datakit.yaml){:target="_blank"}, which enables many [default collectors](datakit-input-conf.md#default-enabled-inputs) without requiring configuration.
    
    ???+ attention
    
        If you need to modify the default configurations of these collectors, you can configure them by mounting separate configuration files via [ConfigMap](k8s-config-how-to.md#via-configmap-conf). Some collectors can be adjusted directly through environment variables; refer to the specific collector's documentation for details. In summary, whether it's the default enabled collectors or other collectors, configuring collectors through [ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){:target="_blank"} always takes effect when deploying DataKit via DaemonSet.
    
    Modify the Dataway configuration in `datakit.yaml`
    
    ```yaml
    - name: ENV_DATAWAY
      value: https://openway.guance.com?token=<your-token> # Replace with the actual DataWay address
    ```
    
    If you choose a different node, change the corresponding Dataway address here, such as AWS nodes:
    
    ```yaml
    - name: ENV_DATAWAY
      value: https://aws-openway.guance.com?token=<your-token> 
    ```
    
    Install the YAML file
    
    ```shell
    $ kubectl apply -f datakit.yaml
    ```
    
    After installation, a DataKit DaemonSet deployment will be created:
    
    ```shell
    $ kubectl get pod -n datakit
    ```

=== "Helm"

    Prerequisites
    
    * Kubernetes >= 1.14
    * Helm >= 3.0+
    
    Install DataKit using Helm (note to modify the `datakit.dataway_url` parameter), which enables many [default collectors](datakit-input-conf.md#default-enabled-inputs) without requiring configuration. For more Helm-related information, refer to [Helm Configuration Management](datakit-helm.md)
    
    
    ```shell
    $ helm install datakit datakit \
         --repo  https://pubrepo.guance.com/chartrepo/datakit \
         -n datakit --create-namespace \
         --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" 
    ```
    
    View deployment status:
    
    ```shell
    $ helm -n datakit list
    ```
    
    You can upgrade using the following command:
    
    ```shell
    $ helm -n datakit get  values datakit -o yaml > values.yaml
    $ helm upgrade datakit datakit \
        --repo  https://pubrepo.guance.com/chartrepo/datakit \
        -n datakit \
        -f values.yaml
    ```
    
    You can uninstall using the following command:
    
    ```shell
    $ helm uninstall datakit -n datakit
    ```
<!-- markdownlint-enable -->

## Resource Limits {#requests-limits}

DataKit sets default Requests and Limits. If the DataKit container state becomes OOMKilled, you can customize and modify the configuration.

<!-- markdownlint-disable MD046 -->
=== "YAML"

    The general format in *datakit.yaml* is
    
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

    The general format in Helm values.yaml is
    
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

Refer to the [official documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits){:target="_blank"} for specific configurations.

## Taint Tolerance Configuration {#toleration}

By default, DataKit deploys on all Nodes in the Kubernetes cluster (i.e., ignoring all taints). If some Nodes in Kubernetes have added taints and you do not want DataKit deployed on them, you can modify *datakit.yaml* to adjust the taint tolerance:

```yaml
      tolerations:
      - operator: Exists    <--- Modify the taint tolerance here
```

Refer to the [official documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration){:target="_blank"} for specific bypass strategies.

## ConfigMap Configuration {#configmap-setting}

Some collectors need to be injected via ConfigMap. Below are examples of injecting MySQL and Redis collectors:

```yaml
# datakit.yaml

volumeMounts: # This configuration already exists in datakit.yaml; simply search to locate it
- mountPath: /usr/local/datakit/conf.d/db/mysql.conf
  name: datakit-conf
  subPath: mysql.conf
    readOnly: true
- mountPath: /usr/local/datakit/conf.d/db/redis.conf
  name: datakit-conf
  subPath: redis.conf
    readOnly: true

# Add directly at the bottom of datakit.yaml
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

## Collector ENV Setting {#env-setting}

Collectors can also be configured via the `ENV_DATAKIT_INPUTS` environment variable. Below are examples of injecting MySQL and Redis collectors:

- General format in *datakit.yaml*

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

- General format in Helm values.yaml

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

The injected content will be stored in the container's `conf.d/env_datakit_inputs.conf` file.

## Other Environment Variable Settings in Datakit {#using-k8-env}

> Note: If `ENV_LOG` is set to `stdout`, do not set `ENV_LOG_LEVEL` to `debug`, as this may cause a log loop and generate a large amount of log data.

In DaemonSet mode, DataKit supports multiple environment variable configurations.

- General format in *datakit.yaml*

```yaml
spec:
  containers:
    - env
    - name: ENV_XXX
      value: YYY
    - name: ENV_OTHER_XXX
      value: YYY
```

- General format in Helm values.yaml

```yaml
  extraEnvs: 
    - name: "ENV_XXX"
      value: "YYY"
    - name: "ENV_OTHER_XXY"
      value: "YYY"    
```

### Types of Environment Variables {#env-types}

The values of the following environment variables can be divided into several data types:

- string: String type
- JSON: More complex configurations that need to be set as JSON strings
- bool: Toggle type; any non-empty string indicates enabling the feature. It is recommended to use `"on"` as the value when enabling. If not enabled, delete or comment out the variable.
- string-list: Comma-separated string, generally used to represent lists
- duration: A string representing time length, e.g., `10s` for 10 seconds. Supported units include h/m/s/ms/us/ns. **Do not use negative numbers**.
- int: Integer type
- float: Floating-point type

For string/bool/string-list/duration, it is recommended to enclose them in double quotes to avoid potential issues with k8s parsing YAML.

### Most Common Environment Variables {#env-common}

<!-- markdownlint-disable MD046 -->
- **ENV_DISABLE_PROTECT_MODE**

    Disable the "configuration protection" mode

    **Field Type**: Boolean

- **ENV_DATAWAY**

    Configure the DataWay address

    **Field Type**: URL

    **Example**: `https://openway.guance.com?token=xxx`

    **Required**: Yes

- **ENV_DEFAULT_ENABLED_INPUTS**

    Default enabled [collector list](datakit-input-conf.md#default-enabled-inputs), separated by English commas, such as `cpu,mem,disk`

    **Field Type**: List

    **Example**: cpu,mem,disk

- **~~ENV_ENABLE_INPUTS~~**

    Same as ENV_DEFAULT_ENABLED_INPUTS, will be deprecated

    **Field Type**: List

- **ENV_GLOBAL_HOST_TAGS**

    Global tags, multiple tags separated by English commas

    **Field Type**: List

    **Example**: tag1=val,tag2=val2

- **ENV_PIPELINE_DEFAULT_PIPELINE**

    Set default Pipeline script for specified data categories; this setting takes precedence over remote settings

    **Field Type**: Map

    **Example**: `{"logging":"abc.p","metric":"xyz.p"}`

- **ENV_PIPELINE_DISABLE_HTTP_REQUEST_FUNC**

    Disable the `http_request` function in Pipeline

    **Field Type**: Boolean

- **ENV_PIPELINE_HTTP_REQUEST_HOST_WHITELIST**

    Set HOST whitelist for the `http_request` function

    **Field Type**: List

- **ENV_PIPELINE_HTTP_REQUEST_CIDR_WHITELIST**

    Set CIDR whitelist for the `http_request` function

    **Field Type**: List

- **ENV_PIPELINE_HTTP_REQUEST_DISABLE_INTERNAL_NET**

    Prevent the `http_request` function from accessing internal networks

    **Field Type**: List

- **~~ENV_GLOBAL_TAGS~~**

    Same as ENV_GLOBAL_HOST_TAGS, will be deprecated

    **Field Type**: List

- **ENV_K8S_CLUSTER_NODE_NAME**

    If there are Nodes with the same name across multiple k8s clusters, you can add a prefix to the original Node name using this environment variable to differentiate them

    **Field Type**: String
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ note "Distinguishing *Global Host Tags* and *Global Election Tags*"

    `ENV_GLOBAL_HOST_TAGS` specifies global tags for host classes. These tags generally follow changes in hosts, such as hostname, host IP, etc. Of course, other tags that do not follow host changes can also be added. All non-election collectors will default to including the tags specified in `ENV_GLOBAL_HOST_TAGS`.

    On the other hand, `ENV_GLOBAL_ELECTION_TAGS` should only add tags that do not change with host switches, such as cluster names, project names, etc. For [election participating collectors](election.md#inputs), only the tags specified in `ENV_GLOBAL_ELECTION_TAGS` will be added, not those specified in `ENV_GLOBAL_HOST_TAGS`.

    Regardless of whether they are global host tags or global environment tags, if the original data already contains corresponding tags, they will not be appended again. We believe the original data's tags should be retained.

???+ attention "Regarding disabling protection mode (ENV_DISABLE_PROTECT_MODE)"

    Once protection mode is disabled, dangerous configuration parameters can be set, and DataKit will accept any configuration parameters. These parameters may lead to abnormal functionality in DataKit or affect the collection functions of collectors. For example, setting HTTP send Body too small can impact data upload functionality; excessively high collection frequency for certain collectors can affect the entities being collected.
<!-- markdownlint-enable -->

### Dataway Configuration Related Environment Variables {#env-dataway}

<!-- markdownlint-disable MD046 -->
- **ENV_DATAWAY**

    Configure the DataWay address

    **Field Type**: URL

    **Example**: `https://openway.guance.com?token=xxx`

    **Required**: Yes

- **ENV_DATAWAY_TIMEOUT**

    Configure DataWay request timeout

    **Field Type**: Duration

    **Default Value**: 30s

- **ENV_DATAWAY_ENABLE_HTTPTRACE**

    Enable exposure of metrics at the HTTP layer during DataWay requests

    **Field Type**: Boolean

- **ENV_DATAWAY_HTTP_PROXY**

    Set DataWay HTTP proxy

    **Field Type**: URL

- **ENV_DATAWAY_MAX_IDLE_CONNS**

    Set the size of the DataWay HTTP connection pool [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)

    **Field Type**: Int

- **ENV_DATAWAY_IDLE_TIMEOUT**

    Set the duration of DataWay HTTP Keep-Alive [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)

    **Field Type**: Duration

    **Default Value**: 90s

- **ENV_DATAWAY_MAX_RETRY_COUNT**

    Specify the maximum number of attempts to send data to Guance Center, minimum value is 1 (no retry after failure), maximum value is 10 [:octicons-tag-24: Version-1.17.0](changelog.md#cl-1.17.0)

    **Field Type**: Int

    **Default Value**: 4

- **ENV_DATAWAY_RETRY_DELAY**

    Interval between retries when data sending fails [:octicons-tag-24: Version-1.17.0](changelog.md#cl-1.17.0)

    **Field Type**: Duration

    **Default Value**: 200ms

- **ENV_DATAWAY_MAX_RAW_BODY_SIZE**

    Size of a single package (uncompressed) during data upload

    **Field Type**: Int

    **Default Value**: 10MB

- **ENV_DATAWAY_CONTENT_ENCODING**

    Set the encoding for point data uploads (options: `v1` for line protocol, `v2` for Protobuf)

    **Field Type**: String

- **ENV_DATAWAY_TLS_INSECURE**

    Allow self-signed certificates on the corresponding Dataway [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Field Type**: Boolean

- **ENV_DATAWAY_NTP_INTERVAL**

    Set the NTP synchronization interval [:octicons-tag-24: Version-1.38.2](changelog.md#cl-1.38.2)

    **Field Type**: String

- **ENV_DATAWAY_NTP_DIFF**

    Set the NTP synchronization error margin [:octicons-tag-24: Version-1.38.2](changelog.md#cl-1.38.2)

    **Field Type**: String

- **ENV_DATAWAY_WAL_CAPACITY**

    Set the disk space occupied by WAL [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Float

- **ENV_DATAWAY_WAL_WORKERS**

    Set the number of WAL workers, default is CPU quota cores X 2 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Int

- **ENV_DATAWAY_WAL_MEM_CAPACITY**

    Set the length of the WAL memory queue, default is CPU quota cores X 2 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Int

- **ENV_DATAWAY_WAL_PATH**

    Set the WAL disk directory, default is `cache/dw-wal` under the DataKit installation directory [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: String

- **ENV_DATAWAY_WAL_FAIL_CACHE_CLEAN_INTERVAL**

    Set the retry interval for failed WAL queues, default is `30s` [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Duration
<!-- markdownlint-enable -->

### Log Configuration Related Environment Variables {#env-log}

<!-- markdownlint-disable MD046 -->
- **ENV_GIN_LOG**

    If changed to `stdout`, DataKit's own gin logs will not be written to files but output to the terminal

    **Field Type**: String

    **Default Value**: */var/log/datakit/gin.log*

- **ENV_LOG**

    If changed to `stdout`, DataKit's own logs will not be written to files but output to the terminal

    **Field Type**: String

    **Default Value**: */var/log/datakit/log*

- **ENV_LOG_LEVEL**

    Set the log level for DataKit itself, options are `info/debug` (case-insensitive)

    **Field Type**: String

    **Default Value**: info

- **ENV_DISABLE_LOG_COLOR**

    Disable log color

    **Field Type**: Boolean

    **Default Value**: -

- **ENV_LOG_ROTATE_BACKUP**

    Set the maximum number of log fragments to retain

    **Field Type**: Int

    **Default Value**: 5

- **ENV_LOG_ROTATE_SIZE_MB**

    Threshold for automatic log rotation (unit: MB), when the log file size reaches the set value, it automatically switches to a new file

    **Field Type**: Int

    **Default Value**: 32
<!-- markdownlint-enable -->

### Pprof Related {#env-pprof}

<!-- markdownlint-disable MD046 -->
- **~~ENV_ENABLE_PPROF~~**

    Whether to enable the profiling port (already enabled by default)

    **Field Type**: Boolean

- **ENV_PPROF_LISTEN**

    Address where `pprof` service listens

    **Field Type**: String
<!-- markdownlint-enable -->

> `ENV_ENABLE_PPROF`: [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) pprof is now enabled by default.

### Election Related Environment Variables {#env-elect}

<!-- markdownlint-disable MD046 -->
- **ENV_ENABLE_ELECTION**

    Enable [election](election.md), default is not enabled; assign any non-empty string value to enable

    **Field Type**: Boolean

    **Default Value**: -

- **ENV_NAMESPACE**

    Namespace where DataKit resides, default is empty indicating no namespace distinction, accepts any non-empty string, e.g., `dk-namespace-example`. If election is enabled, you can specify the workspace via this environment variable.

    **Field Type**: String

    **Default Value**: default

- **ENV_ENABLE_ELECTION_NAMESPACE_TAG**

    When enabled, all election-based collections will include an additional tag `election_namespace=<your-election-namespace>`, which may increase the number of Time Series [:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)

    **Field Type**: Boolean

    **Default Value**: -

- **ENV_GLOBAL_ELECTION_TAGS**

    Global election tags, multiple tags separated by English commas. ENV_GLOBAL_ENV_TAGS will be deprecated

    **Field Type**: List

    **Example**: tag1=val,tag2=val2

- **ENV_CLUSTER_NAME_K8S**

    Cluster where DataKit resides, if non-empty, adds a specified tag in [Global Election Tags](election.md#global-tags), key is `cluster_name_k8s`, value is the environment variable value [:octicons-tag-24: Version-1.5.8](changelog.md#cl-1.5.8)

    **Field Type**: String

    **Default Value**: default

- **ENV_ELECTION_NODE_WHITELIST**

    List of allowed node names for participating in elections [:octicons-tag-24: Version-1.35.0](changelog.md#cl-1.35.0)

    **Field Type**: List

    **Default Value**: []
<!-- markdownlint-enable -->

### HTTP/API Related Environment Variables {#env-http-api}

<!-- markdownlint-disable MD046 -->
- **ENV_DISABLE_404PAGE**

    Disable DataKit's 404 page (commonly used when deploying DataKit RUM publicly).

    **Field Type**: Boolean

    **Default Value**: -

- **ENV_HTTP_LISTEN**

    Modify the address to allow external calls to [DataKit APIs](apis.md).

    **Field Type**: String

    **Default Value**: localhost:9529

- **ENV_HTTP_LISTEN_SOCKET**

    Modify the address to allow external calls to [DataKit APIs](apis.md) via unix socket.

    **Field Type**: String

    **Example**: `/var/run/datakit/datakit.sock`

- **ENV_HTTP_PUBLIC_APIS**

    List of DataKit [APIs](apis.md) allowed for external access, multiple APIs separated by English commas. Used to disable some APIs when DataKit is deployed publicly.

    **Field Type**: List

- **ENV_HTTP_TIMEOUT**

    Set the server-side timeout for the 9529 HTTP API service [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)

    **Field Type**: Duration

    **Default Value**: 30s

- **ENV_HTTP_CLOSE_IDLE_CONNECTION**

    If enabled, the 9529 HTTP server will actively close idle connections (idle time equals `ENV_HTTP_TIMEOUT`) [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)

    **Field Type**: Boolean

    **Default Value**: -

- **ENV_HTTP_ENABLE_TLS**

    Enable DataKit 9529 HTTPS [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Field Type**: Boolean

    **Default Value**: -

- **ENV_HTTP_TLS_CRT**

    Path to TLS cert for DataKit HTTP Server [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Field Type**: String

    **Default Value**: -

- **ENV_HTTP_TLS_KEY**

    Path to TLS key for DataKit HTTP Server [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Field Type**: String

    **Default Value**: -

- **ENV_REQUEST_RATE_LIMIT**

    Limit the number of requests per second for the 9529 [API](datakit-conf.md#set-http-api-limit).

    **Field Type**: Float

    **Default Value**: 20.0

- **ENV_RUM_ORIGIN_IP_HEADER**

    Set the HTTP header key for the real IP forward in RUM requests. DataKit will retrieve the user's real IP from this Header, otherwise, it might get the gateway IP.

    **Field Type**: String

    **Default Value**: `X-Forwarded-For`

- **ENV_RUM_APP_ID_WHITE_LIST**

    RUM app-id whitelist, separated by `,`.

    **Field Type**: String

    **Example**: /appid-1,/appid-2

- **ENV_HTTP_ALLOWED_CORS_ORIGINS**

    Set CORS properties for DataKit APIs (separated by English commas) [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: List

    **Example**: Origin,Access-Control-Allow-Origin,Access-Control-Allow-Methods

    **Default Value**: -
<!-- markdownlint-enable -->

### Confd Configuration Related Environment Variables {#env-confd}

<!-- markdownlint-disable MD046 -->
- **ENV_CONFD_BACKEND**

    Backend to use

    **Field Type**: String

    **Example**: `etcdv3`

- **ENV_CONFD_BASIC_AUTH**

    Use Basic Auth for authentication (applicable to `etcdv3`/consul)

    **Field Type**: Boolean

    **Default Value**: false

- **ENV_CONFD_CLIENT_CA_KEYS**

    Client CA key file

    **Field Type**: String

    **Example**: `/opt/ca.crt`

- **ENV_CONFD_CLIENT_CERT**

    Client certificate file

    **Field Type**: String

    **Example**: `/opt/client.crt`

- **ENV_CONFD_CLIENT_KEY**

    Client key file

    **Field Type**: String

    **Example**: `/opt/client.key`

- **ENV_CONFD_BACKEND_NODES**

    Backend source addresses

    **Field Type**: JSON

    **Example**: `["http://aaa:2379","1.2.3.4:2379"]` (`Nacos must prefix http:// or https://`)

- **ENV_CONFD_USERNAME**

    Username for authentication (applicable to `etcdv3/consul/nacos`)

    **Field Type**: String

- **ENV_CONFD_PASSWORD**

    Password for authentication (applicable to `etcdv3/consul/nacos`)

    **Field Type**: String

- **ENV_CONFD_SCHEME**

    Backend URI scheme

    **Field Type**: String

    **Example**: http/https

- **ENV_CONFD_SEPARATOR**

    Separator used to replace '/' when looking up keys in the backend, prefix '/' will also be removed (applicable to redis)

    **Field Type**: String

    **Default Value**: /

- **ENV_CONFD_ACCESS_KEY**

    Client identity ID (applicable to `nacos/aws`)

    **Field Type**: String

- **ENV_CONFD_SECRET_KEY**

    Authentication secret key (applicable to `nacos/aws`)

    **Field Type**: String

- **ENV_CONFD_CIRCLE_INTERVAL**

    Interval in seconds for cyclic detection (applicable to `nacos/aws`)

    **Field Type**: Int

    **Default Value**: 60

- **ENV_CONFD_CONFD_NAMESPACE**

    Configuration information space ID (applicable to `nacos`)

    **Field Type**: String

    **Example**: `6aa36e0e-bd57-4483-9937-e7c0ccf59599`

- **ENV_CONFD_PIPELINE_NAMESPACE**

    `pipeline` information space ID (applicable to `nacos`)

    **Field Type**: String

    **Example**: `d10757e6-aa0a-416f-9abf-e1e1e8423497`

- **ENV_CONFD_REGION**

    AWS region (applicable to aws)

    **Field Type**: String

    **Example**: `cn-north-1`
<!-- markdownlint-enable -->

### Git Configuration Related Environment Variables {#env-git}

<!-- markdownlint-disable MD046 -->
- **ENV_GIT_BRANCH**

    Specify the branch to pull. **Empty means default**, which is usually the main branch of the remote repository, typically `master`

    **Field Type**: String

    **Example**: master

- **ENV_GIT_INTERVAL**

    Interval for periodic pulls

    **Field Type**: Duration

    **Example**: 1m

- **ENV_GIT_KEY_PATH**

    Full path to the local PrivateKey

    **Field Type**: String

    **Example**: /Users/username/.ssh/id_rsa

- **ENV_GIT_KEY_PW**

    Password for the local PrivateKey

    **Field Type**: String

    **Example**: passwd

- **ENV_GIT_URL**

    Remote git repo address for managing configuration files

    **Field Type**: URL

    **Example**: `http://username:password@github.com/username/repository.git`
<!-- markdownlint-enable -->

### Sinker Configuration Related Environment Variables {#env-sinker}

<!-- markdownlint-disable MD046 -->
- **ENV_SINKER_GLOBAL_CUSTOMER_KEYS**

    List of custom fields for Sinker分流, separated by English commas

    **Field Type**: String

- **ENV_DATAWAY_ENABLE_SINKER**

    Enable Sinker functionality when DataWay sends data. This feature requires a new version of Dataway to take effect [:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)

    **Field Type**: Boolean

    **Default Value**: -
<!-- markdownlint-enable -->

### IO Module Configuration Related Environment Variables {#env-io}

<!-- markdownlint-disable MD046 -->
- **ENV_IO_FILTERS**

    Add [line protocol filters](datakit-filter.md)

    **Field Type**: JSON

- **ENV_IO_FLUSH_INTERVAL**

    Set the compact execution interval [:octicons-tag-24: Version-1.22.0](changelog.md#cl-1.22.0)

    **Field Type**: Duration

    **Default Value**: 10s

- **ENV_IO_FEED_CHAN_SIZE**

    Set the compact queue length [:octicons-tag-24: Version-1.22.0](changelog.md#cl-1.22.0)

    **Field Type**: Int

    **Default Value**: 1

- **ENV_IO_FLUSH_WORKERS**

    Set the number of compactor workers, default is CPU quota cores x 2 [:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

    **Field Type**: Int

- **ENV_IO_MAX_CACHE_COUNT**

    Number of points cached in Compact

    **Field Type**: Int

    **Default Value**: 1024

- **~~ENV_IO_ENABLE_CACHE~~**

    Whether to enable disk caching for failed sends. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Boolean

    **Default Value**: false

- **~~ENV_IO_CACHE_ALL~~**

    Whether to cache all failed sends. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Boolean

    **Default Value**: false

- **~~ENV_IO_CACHE_MAX_SIZE_GB~~**

    Disk size (in GB) for failed send cache. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Int

    **Default Value**: 10

- **~~ENV_IO_CACHE_CLEAN_INTERVAL~~**

    Periodically send tasks cached on disk. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Field Type**: Duration

    **Default Value**: 5s
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ note "Explanation of buffer and queue"

    `ENV_IO_MAX_CACHE_COUNT` controls the data sending strategy, i.e., when the number of cached (line protocol) points in memory exceeds this value, it will attempt to send the current cached points to the center. If this cache threshold is set too high, data will pile up in memory, leading to memory spikes but improving GZip compression efficiency. If set too low, it may affect sending throughput.
<!-- markdownlint-enable -->

`ENV_IO_FILTERS` is a JSON string, example:

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

### DCA Related Environment Variables {#env-dca}

<!-- markdownlint-disable MD046 -->
- **ENV_DCA_WEBSOCKET_SERVER**

    DataKit can connect to this address to manage DCA, once `ENV_DCA_WEBSOCKET_SERVER` is enabled, DCA functionality is activated by default

    **Field Type**: URL
<!-- markdownlint-enable -->

### Refer Table Related Environment Variables {#env-reftab}

<!-- markdownlint-disable MD046 -->
- **ENV_REFER_TABLE_URL**

    Set the data source URL

    **Field Type**: String

- **ENV_REFER_TABLE_PULL_INTERVAL**

    Set the request interval for the data source URL

    **Field Type**: String

    **Default Value**: 5m

- **ENV_REFER_TABLE_USE_SQLITE**

    Set whether to use SQLite for data storage

    **Field Type**: Boolean

    **Default Value**: false

- **ENV_REFER_TABLE_SQLITE_MEM_MODE**

    When using SQLite for data storage, use SQLite memory mode or disk mode

    **Field Type**: Boolean

    **Default Value**: false
<!-- markdownlint-enable -->

### Data Recording Related Environment Variables {#env-recorder}

[:octicons-tag-24: Version-1.22.0](changelog.md#1.22.0)

Refer to [this documentation](datakit-tools-how-to.md#record-and-replay) for data recording features.

<!-- markdownlint-disable MD046 -->
- **ENV_ENABLE_RECORDER**

    Enable data recording

    **Field Type**: Boolean

    **Default Value**: false

- **ENV_RECORDER_PATH**

    Set the directory for storing recorded data

    **Field Type**: String

    **Default Value**: *DataKit installation directory/recorder*

- **ENV_RECORDER_ENCODING**

    Set the format for storing recorded data, v1 for line protocol format, v2 for JSON format

    **Field Type**: String

    **Default Value**: v2

- **ENV_RECORDER_DURATION**

    Set the recording duration (since DataKit startup), once exceeded, no further recording occurs

    **Field Type**: Duration

    **Default Value**: 30m

- **ENV_RECORDER_INPUTS**

    Set the list of collector names to record, separated by English commas

    **Field Type**: List

    **Example**: cpu,mem,disk

- **ENV_RECORDER_CATEGORIES**

    Set the list of data categories to record, separated by English commas, full Category list see [here](apis.md#category)

    **Field Type**: List

    **Example**: metric,logging,object
<!-- markdownlint-enable -->

### Remote Job {#remote_job}

[:octicons-tag-24: Version-1.63.0](changelog.md#cl-1.63.0)

<!-- markdownlint-disable MD046 -->
- **ENV_REMOTE_JOB_ENABLE**

    Enable remote job functionality

    **Field Type**: Boolean

    **Example**: `true`

    **Default Value**: false

- **ENV_REMOTE_JOB_ENVS**

    Mainly used to send generated files to OSS.

    **Field Type**: String

    **Example**: `true`

    **Default Value**: false

- **ENV_REMOTE_JOB_INTERVAL**

    Timed request to the server to obtain tasks, default 10 seconds

    **Field Type**: String

    **Example**: 10s

    **Default Value**: 10s
<!-- markdownlint-enable -->

### Miscellaneous Others {#env-others}

<!-- markdownlint-disable MD046 -->
- **ENV_CLOUD_PROVIDER**

    Support specifying cloud provider during installation

    **Field Type**: String

    **Example**: `aliyun/aws/tencent/hwcloud/azure`

- **ENV_HOSTNAME**

    Defaults to the local hostname, can be specified during installation, e.g., `dk-your-hostname`

    **Field Type**: String

- **ENV_IPDB**

    Specify the type of IP information database, currently supports `iploc/geolite2` only

    **Field Type**: String

- **ENV_ULIMIT**

    Specify the maximum number of open files for Datakit

    **Field Type**: Int

- **ENV_PIPELINE_OFFLOAD_RECEIVER**

    Set the type of Offload target receiver

    **Field Type**: String

    **Default Value**: `datakit-http`

- **ENV_PIPELINE_OFFLOAD_ADDRESSES**

    Set Offload target addresses

    **Field Type**: List

    **Example**: `http://aaa:123,http://1.2.3.4:1234`

- **ENV_PIPELINE_DISABLE_APPEND_RUN_INFO**

    Disable appending Pipeline runtime information

    **Field Type**: Boolean

    **Default Value**: `false`

- **ENV_CRYPTO_AES_KEY**

    AES encryption/decryption key length is 16

    **Field Type**: String

    **Example**: `0123456789abcdef`

- **ENV_CRYPTO_AES_KEY_FILE**

    Path to the file containing the AES encryption/decryption key

    **Field Type**: String

    **Example**: `/usr/local/datakit/enc4mysql`

- **ENV_LOGGING_MAX_OPEN_FILES**

    Specify the maximum number of open files for log collection, if the value is -1 there is no limit, default value is 500

    **Field Type**: Int

    **Example**: `1000`
<!-- markdownlint-enable -->

### Special Environment Variables {#env-special}

#### ENV_K8S_NODE_NAME {#env_k8s_node_name}

When the k8s node name differs from its corresponding hostname, you can override the default collected hostname with the