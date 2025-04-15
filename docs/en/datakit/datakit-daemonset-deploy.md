# Kubernetes
---

This document describes how to install DataKit in K8s via DaemonSet.

## Installation {#install}

<!-- markdownlint-disable MD046 -->
=== "DaemonSet"

    Download [`datakit.yaml`](https://static.<<<custom_key.brand_main_domain>>>/datakit/datakit.yaml){:target="_blank"}, in which many [default collectors](datakit-input-conf.md#default-enabled-inputs) are turned on without configuration.
    
    ???+ attention
    
        If you want to modify the default configuration of these collectors, you can configure them by [mounting a separate conf in `ConfigMap` mode](k8s-config-how-to.md#via-configmap-conf). Some collectors can be adjusted directly by means of environment variables. See the documents of specific collectors for details. All in all, configuring the collector through [`ConfigMap`](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/){:target="_blank"} is always effective when deploying the DataKit in DaemonSet mode, whether it is a collector turned on by default or other collectors.
    
    Modify the Dataway configuration in `datakit.yaml`
    
    ```yaml
        - name: ENV_DATAWAY
            value: https://openway.<<<custom_key.brand_main_domain>>>?token=<your-token> # Fill in the real address of DataWay here
    ```
    
    If you choose another node, change the corresponding DataWay address here, such as AWS node:
    
    ```yaml
        - name: ENV_DATAWAY
            value: https://aws-openway.<<<custom_key.brand_main_domain>>>?token=<your-token> 
    ```
    
    Install yaml
    
    ```shell
    $ kubectl apply -f datakit.yaml
    ```
    
    After installation, a DaemonSet deployment of DataKit is created:
    
    ```shell
    $ kubectl get pod -n datakit
    ```

=== "Helm"

    Precondition:
    
    * Kubernetes >= 1.14
    * Helm >= 3.0+
    
    Helm installs Datakit (note modifying the `datakit.dataway_url` parameter)，in which many [default collectors](datakit-input-conf.md#default-enabled-inputs) are turned on without configuration.
    
    ```shell
    $ helm install datakit datakit \
               --repo  https://pubrepo.<<<custom_key.brand_main_domain>>>/chartrepo/datakit \
               -n datakit --create-namespace \
               --set datakit.dataway_url="https://openway.<<<custom_key.brand_main_domain>>>?token=<your-token>" 
    ```
    
    View deployment status:
    
    ```shell
    $ helm -n datakit list
    ```
    
    You can upgrade with the following command:
    
    ```shell
    $ helm -n datakit get  values datakit -o yaml > values.yaml
    $ helm upgrade datakit datakit \
        --repo  https://pubrepo.<<<custom_key.brand_main_domain>>>/chartrepo/datakit \
        -n datakit \
        -f values.yaml
    ```
    
    You can uninstall it with the following command:
    
    ```shell
    $ helm uninstall datakit -n datakit
    ```
<!-- markdownlint-enable -->

## Kubernetes Tolerance Configuration {#toleration}

DataKit is deployed on all nodes in the Kubernetes cluster by default (that is, all stains are ignored). If some node nodes in Kubernetes have added stain scheduling and do not want to deploy DataKit on them, you can modify `datakit.yaml` to adjust the stain tolerance:

```yaml
      tolerations:
      - operator: Exists    <--- Modify the stain tolerance here
```

For specific bypass strategies, see [official doc](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration){:target="_blank"}。

## ConfigMap Settings {#configmap-setting}

The opening of some collectors needs to be injected through ConfigMap. The following is an injection example of MySQL and Redis collectors:

```yaml
# datakit.yaml

volumeMounts: #  this configuration have existed in datakit.yaml, and you can locate it by searching directly
- mountPath: /usr/local/datakit/conf.d/db/mysql.conf
  name: datakit-conf
  subPath: mysql.conf
    readOnly: true
- mountPath: /usr/local/datakit/conf.d/db/redis.conf
  name: datakit-conf
  subPath: redis.conf
    readOnly: true

# append directly to the bottom of datakit.yaml
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

## Environment Variables {#using-k8-env}

> Note: If ENV_LOG is configured to `stdout`, do not set ENV_LOG_LEVEL to `debug`, otherwise looping logs may result in large amounts of log data.

In DaemonSet mode, DataKit supports multiple environment variable configurations.

- The approximate format in `datakit.yaml` is

```yaml
spec:
  containers:
    - env
    - name: ENV_XXX
      value: YYY
    - name: ENV_OTHER_XXX
      value: YYY
```

- The approximate format in Helm values.yaml is

```yaml
  extraEnvs: 
    - name: "ENV_XXX"
      value: "YYY"
    - name: "ENV_OTHER_XXX"
      value: "YYY"    
```

## ENV Set Collectors {#env-setting}

The opening of some collectors can also be injected through ENV_DATAKIT_INPUTS.
The following is an injection example of MySQL and Redis collectors:

- The approximate format in `datakit.yaml` is

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

- The approximate format in Helm values.yaml is

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

The injected content will be stored in the conf.d/env_datakit_inputs.conf file of the container.

### Description of Environment Variable Type {#env-types}

The values of the following environment variables are divided into the following data types:

- string: string type
- JSON: some of the more complex configurations that require setting environment variables in the form of a JSON string
- bool: switch type. Given **any non-empty string** , this function is turned on. It is recommended to use `"on"` as its value when turned on. If it is not opened, it must be deleted or commented out.
- string-list: a string separated by an English comma, commonly used to represent a list
- duration: a string representation of the length of time, such as `10s` for 10 seconds, where the unit supports h/m/s/ms/us/ns. **Don't give a negative value**.
- int: integer type
- float: floating point type

For string/bool/string-list/duration, it is recommended to use double quotation marks to avoid possible problems caused by k8s parsing yaml.

### Most Commonly Used Environment Variables {#env-common}

<!-- markdownlint-disable MD046 -->
- **ENV_DISABLE_PROTECT_MODE**

    Disable protect mode

    **Type**: Boolean

- **ENV_DATAWAY**

    Configure the DataWay address

    **Type**: URL

    **Example**: `https://openway.<<<custom_key.brand_main_domain>>>.com?token=xxx`

    **Required**: Yes

- **ENV_DEFAULT_ENABLED_INPUTS**

    [The list of collectors](datakit-input-conf.md#default-enabled-inputs) is opened by default, divided by commas

    **Type**: List

    **Example**: cpu,mem,disk

- **~~ENV_ENABLE_INPUTS~~**

    Same as ENV_DEFAULT_ENABLED_INPUTS(Deprecated)

    **Type**: List

- **ENV_GLOBAL_HOST_TAGS**

    Global tag, multiple tags are divided by English commas. The old `ENV_GLOBAL_TAGS` will be discarded

    **Type**: List

    **Example**: tag1=val,tag2=val2

- **ENV_PIPELINE_DEFAULT_PIPELINE**

    Set the default Pipeline script for the specified data category. This setting takes precedence when it conflicts with the remote setting.

    **Type**: Map

    **Example**: `{"logging":"abc.p","metric":"xyz.p"}`

- **ENV_PIPELINE_DISABLE_HTTP_REQUEST_FUNC**

    Disable Pipeline `http_request` function

    **Type**: Boolean

- **ENV_PIPELINE_HTTP_REQUEST_HOST_WHITELIST**

    Set HOST whitelist for `http_request` function

    **Type**: List

- **ENV_PIPELINE_HTTP_REQUEST_CIDR_WHITELIST**

    Set CIDR whitelist for `http_request` function

    **Type**: List

- **ENV_PIPELINE_HTTP_REQUEST_DISABLE_INTERNAL_NET**

    Disable `http_request` function to access internal network

    **Type**: List

- **~~ENV_GLOBAL_TAGS~~**

    Same as ENV_GLOBAL_HOST-TAGS(Deprecated)

    **Type**: List

- **ENV_K8S_CLUSTER_NODE_NAME**

    If we got same node-name among multiple k8s cluster, we can add a prefix based on origin node-name via this ENV

    **Type**: String
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ note "Distinguish between *global host tag*  and *global election tag*"

    `ENV_GLOBAL_HOST_TAGS` is used to specify host class global tags whose values generally follow host transitions, such as host name and host IP. Of course, other tags that do not follow the host changes can also be added. All collectors of non-elective classes are taken by default with the tag specified in `ENV_GLOBAL_HOST_TAGS`.
    
    And `ENV_GLOBAL_ELECTION_TAGS` recommends adding only tags that do not change with host switching, such as cluster name, project name, etc. For [election collector](election.md#inputs), only the tag specified in `ENV_GLOBAL_ELECTION_TAGS` will be added, not the tag specified in `ENV_GLOBAL_HOST_TAGS`.
    
    Whether it is a host class global tag or an environment class global tag, if there is already a corresponding tag in the original data, the existing tag will not be appended, and we think that the tag in the original data should be used.

???+ attention "About Protect Mode(ENV_DISABLE_PROTECT_MODE)"

    Once protected mode is disabled, some dangerous configuration parameters can be set, and Datakit will accept any configuration parameters. These parameters may cause some Datakit functions to be abnormal or affect the collection function of the collector. For example, if the HTTP sending body is too small, the data upload function will be affected. And the collection frequency of some collectors set too high, which may affect the entities(for example MySQL) to be collected.
<!-- markdownlint-enable -->

<!--
### Point Pool Environments {#env-pointpool}

[:octicons-tag-24: Version-1.28.0](changelog.md#cl-1.28.0) ·
[:octicons-beaker-24: Experimental](index.md#experimental)
-->


### Dataway Configuration Environments {#env-dataway}

<!-- markdownlint-disable MD046 -->
- **ENV_DATAWAY**

    Set DataWay address

    **Type**: URL

    **Example**: `https://openway.<<<custom_key.brand_main_domain>>>?token=xxx`

    **Required**: Yes

- **ENV_DATAWAY_TIMEOUT**

    Set DataWay request timeout

    **Type**: Duration

    **Default**: 30s

- **ENV_DATAWAY_ENABLE_HTTPTRACE**

    Enable metrics on DataWay HTTP request

    **Type**: Boolean

- **ENV_DATAWAY_HTTP_PROXY**

    Set DataWay HTTP Proxy

    **Type**: URL

- **ENV_DATAWAY_MAX_IDLE_CONNS**

    Set DataWay HTTP connection pool size [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)

    **Type**: Int

- **ENV_DATAWAY_IDLE_TIMEOUT**

    Set DataWay HTTP Keep-Alive timeout [:octicons-tag-24: Version-1.7.0](changelog.md#cl-1.7.0)

    **Type**: Duration

    **Default**: 90s

- **ENV_DATAWAY_MAX_RETRY_COUNT**

    Specify at most how many times the data sending operation will be performed when encounter failures [:octicons-tag-24: Version-1.18.0](changelog.md#cl-1.18.0)

    **Type**: Int

    **Default**: 4

- **ENV_DATAWAY_RETRY_DELAY**

    The interval between two data sending retry, valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h" [:octicons-tag-24: Version-1.18.0](changelog.md#cl-1.18.0)

    **Type**: Duration

    **Default**: 200ms

- **ENV_DATAWAY_MAX_RAW_BODY_SIZE**

    Set upload package size(before gzip)

    **Type**: Int

    **Default**: 10MB

- **ENV_DATAWAY_CONTENT_ENCODING**

    Set the encoding of the point data at upload time (optional list: 'v1' is the line protocol, 'v2' is Protobuf)

    **Type**: String

- **ENV_DATAWAY_TLS_INSECURE**

    Enable self-signed TLS certificate on Dataway [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Type**: Boolean

- **ENV_DATAWAY_NTP_INTERVAL**

    Set NTP sync interval [:octicons-tag-24: Version-1.38.2](changelog.md#cl-1.38.2)

    **Type**: String

- **ENV_DATAWAY_NTP_DIFF**

    Set NTP sync difference [:octicons-tag-24: Version-1.38.2](changelog.md#cl-1.38.2)

    **Type**: String

- **ENV_DATAWAY_WAL_CAPACITY**

    Set WAL disk cache capacity [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Float

- **ENV_DATAWAY_WAL_WORKERS**

    Set WAL workers, default to limited CPU cores X 8 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Int

- **ENV_DATAWAY_WAL_MEM_CAPACITY**

    Set WAL memory queue length, default to limited CPU cores X 8 [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Int

- **ENV_DATAWAY_WAL_NO_DROP_CATEGORIES**

    Set category list that do not drop data if WAL disk full [:octicons-tag-24: Version-1.71.0](changelog.md#cl-1.71.0)

    **Type**: List

    **Example**: `'L,T,N'`

- **ENV_DATAWAY_WAL_PATH**

    Set WAL disk path, default path is *cache/dw-wal* under Datakit install path[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: String

- **ENV_DATAWAY_WAL_FAIL_CACHE_CLEAN_INTERVAL**

    Set WAL fail-cache clean interval, default `30s`[:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Duration
<!-- markdownlint-enable -->

### Log Configuration Environments {#env-log}

<!-- markdownlint-disable MD046 -->
- **ENV_GIN_LOG**

    If it is changed to `stdout`, the DataKit's own gin log will not be written to the file, but will be output by the terminal.

    **Type**: String

    **Default**: */var/log/datakit/gin.log*

- **ENV_LOG**

    If it is changed to `stdout`, DataKit's own log will not be written to the file, but will be output by the terminal.

    **Type**: String

    **Default**: */var/log/datakit/log*

- **ENV_LOG_LEVEL**

    Set DataKit's own log level, optional `info/debug`(case insensitive).

    **Type**: String

    **Default**: info

- **ENV_DISABLE_LOG_COLOR**

    Turn off log colors

    **Type**: Boolean

    **Default**: -

- **ENV_LOG_ROTATE_BACKUP**

    The upper limit count for log files to be reserve.

    **Type**: Int

    **Default**: 5

- **ENV_LOG_ROTATE_SIZE_MB**

    The threshold for automatic log rotating in MB, which automatically switches to a new file when the log file size reaches the threshold.

    **Type**: Int

    **Default**: 32
<!-- markdownlint-enable -->

### Something about DataKit pprof {#env-pprof}

<!-- markdownlint-disable MD046 -->
- **~~ENV_ENABLE_PPROF~~**

    Whether to start port on for profiling(Deprecated: Default enabled)

    **Type**: Boolean

- **ENV_PPROF_LISTEN**

    `pprof` service listening address

    **Type**: String
<!-- markdownlint-enable -->

> `ENV_ENABLE_PPROF`: [:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) enabled pprof by default.

### Election-related Environmental Variables {#env-elect}

<!-- markdownlint-disable MD046 -->
- **ENV_ENABLE_ELECTION**

    If you want to open the [election](election.md), it will not be opened by default. If you want to open it, you can give any non-empty string value to the environment variable.

    **Type**: Boolean

    **Default**: -

- **ENV_NAMESPACE**

    The namespace in which the DataKit resides, which defaults to null to indicate that it is namespace-insensitive and accepts any non-null string, such as `dk-namespace-example`. If the election is turned on, you can specify the workspace through this environment variable.

    **Type**: String

    **Default**: default

- **ENV_ENABLE_ELECTION_NAMESPACE_TAG**

    When this option is turned on, all election classes are collected with an extra tag of `election_namespace=<your-election-namespace>`, which may result in some timeline growth [:octicons-tag-24: Version-1.4.7](changelog.md#cl-1.4.7)

    **Type**: Boolean

    **Default**: -

- **ENV_GLOBAL_ELECTION_TAGS**

    Tags are elected globally, and multiple tags are divided by English commas. ENV_GLOBAL_ENV_TAGS will be discarded.

    **Type**: List

    **Example**: tag1=val,tag2=val2

- **ENV_CLUSTER_NAME_K8S**

    The cluster name in which the Datakit residers, if the cluster is not empty, a specified tag will be added to [global election tags](election.md#global-tags), the key is `cluster_name_k8s` and the value is the environment variable [:octicons-tag-24: Version-1.5.8](changelog.md#cl-1.5.8)

    **Type**: String

    **Default**: default

- **ENV_ELECTION_NODE_WHITELIST**

    List of node names that are allowed to participate in elections [:octicons-tag-24: Version-1.35.0](changelog.md#cl-1.35.0)

    **Type**: List

    **Default**: []
<!-- markdownlint-enable -->

### HTTP/API Environment Variables {#env-http-api}

<!-- markdownlint-disable MD046 -->
- **ENV_DISABLE_404PAGE**

    Disable the DataKit 404 page (commonly used when deploying DataKit RUM on the public network).

    **Type**: Boolean

    **Default**: -

- **ENV_HTTP_LISTEN**

    The address can be modified so that the [DataKit interface](apis.md) can be called externally.

    **Type**: String

    **Default**: localhost:9529

- **ENV_HTTP_LISTEN_SOCKET**

    The address can be modified so that the [DataKit interface](apis.md) can be called externally.

    **Type**: String

    **Example**: `/var/run/datakit/datakit.sock`

- **ENV_HTTP_PUBLIC_APIS**

    [API list](apis.md) that allow external access, separated by English commas between multiple APIs. When DataKit is deployed on the public network, it is used to disable some APIs.

    **Type**: List

- **ENV_HTTP_TIMEOUT**

    Setting the 9529 HTTP API Server Timeout [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)

    **Type**: Duration

    **Default**: 30s

- **ENV_HTTP_CLOSE_IDLE_CONNECTION**

    If turned on, the 9529 HTTP server actively closes idle connections(idle time equal to `ENV_HTTP_TIMEOUT`) [:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)

    **Type**: Boolean

    **Default**: -

- **ENV_HTTP_ENABLE_TLS**

    Enable Datakit 9529 HTTPS [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Type**: Boolean

    **Default**: -

- **ENV_HTTP_TLS_CRT**

    Set Datakit HTTP Server's TLS cert path [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Type**: String

    **Default**: -

- **ENV_HTTP_TLS_KEY**

    Set Datakit HTTP Server's TLS key path [:octicons-tag-24: Version-1.29.0](changelog.md#cl-1.29.0)

    **Type**: String

    **Default**: -

- **ENV_REQUEST_RATE_LIMIT**

    Limit 9529 [API requests per second](datakit-conf.md#set-http-api-limit).

    **Type**: Float

    **Default**: 20.0

- **ENV_RUM_ORIGIN_IP_HEADER**

    Set RUM HTTP request(`/v1/write/rum`) real IP forward header key.

    **Type**: String

    **Default**: `X-Forwarded-For`

- **ENV_RUM_APP_ID_WHITE_LIST**

    RUM app-id white list, split by `,`.

    **Type**: String

    **Example**: /appid-1,/appid-2

- **ENV_HTTP_ALLOWED_CORS_ORIGINS**

    Setup CORS on Datakit HTTP APIs(split by `,`) [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: List

    **Example**: Origin,Access-Control-Allow-Origin,Access-Control-Allow-Methods

    **Default**: -
<!-- markdownlint-enable -->

### Confd Environment Variables {#env-confd}

<!-- markdownlint-disable MD046 -->
- **ENV_CONFD_BACKEND**

    The backend to use

    **Type**: String

    **Example**: `etcdv3`

- **ENV_CONFD_BASIC_AUTH**

    Use Basic Auth to authenticate (used with `etcdv3`/consul)

    **Type**: Boolean

    **Default**: false

- **ENV_CONFD_CLIENT_CA_KEYS**

    The client CA key file

    **Type**: String

    **Example**: `/opt/ca.crt`

- **ENV_CONFD_CLIENT_CERT**

    The client cert file

    **Type**: String

    **Example**: `/opt/client.crt`

- **ENV_CONFD_CLIENT_KEY**

    The client key file

    **Type**: String

    **Example**: `/opt/client.key`

- **ENV_CONFD_BACKEND_NODES**

    Backend source address

    **Type**: JSON

    **Example**: `["http://aaa:2379","1.2.3.4:2379"]` (`Nacos must prefix http:// or https://`)

- **ENV_CONFD_USERNAME**

    The username to authenticate (used with `etcdv3/consul/nacos`)

    **Type**: String

- **ENV_CONFD_PASSWORD**

    The password to authenticate (used with `etcdv3/consul/nacos`)

    **Type**: String

- **ENV_CONFD_SCHEME**

    The backend URI scheme

    **Type**: String

    **Example**: http/https

- **ENV_CONFD_SEPARATOR**

    The separator to replace '/' with when looking up keys in the backend, prefixed '/' will also be removed (used with rides)

    **Type**: String

    **Default**: /

- **ENV_CONFD_ACCESS_KEY**

    Access Key Id (use with `nacos/aws`)

    **Type**: String

- **ENV_CONFD_SECRET_KEY**

    Secret Access Key (use with `nacos/aws`)

    **Type**: String

- **ENV_CONFD_CIRCLE_INTERVAL**

    Loop detection interval second (use with `nacos/aws`)

    **Type**: Int

    **Default**: 60

- **ENV_CONFD_CONFD_NAMESPACE**

    `confd` namespace id (use with `nacos`)

    **Type**: String

    **Example**: `6aa36e0e-bd57-4483-9937-e7c0ccf59599`

- **ENV_CONFD_PIPELINE_NAMESPACE**

    `pipeline` namespace id (use with `nacos`)

    **Type**: String

    **Example**: `d10757e6-aa0a-416f-9abf-e1e1e8423497`

- **ENV_CONFD_REGION**

    AWS Local Zone (use with aws)

    **Type**: String

    **Example**: `cn-north-1`
<!-- markdownlint-enable -->

### Git Environment Variable {#env-git}

<!-- markdownlint-disable MD046 -->
- **ENV_GIT_BRANCH**

    Specifies the branch to pull. **If it is empty, it is the default.** And the default is the remotely specified main branch, which is usually `master`.

    **Type**: String

    **Example**: master

- **ENV_GIT_INTERVAL**

    The interval of timed pull.

    **Type**: Duration

    **Example**: 1m

- **ENV_GIT_KEY_PATH**

    The full path of the local PrivateKey.

    **Type**: String

    **Example**: /Users/username/.ssh/id_rsa

- **ENV_GIT_KEY_PW**

    Use password of local PrivateKey.

    **Type**: String

    **Example**: passwd

- **ENV_GIT_URL**

    Manage the remote git repo address of the configuration file.

    **Type**: URL

    **Example**: `http://username:password@github.com/username/repository.git`
<!-- markdownlint-enable -->

### Sinker {#env-sinker}

<!-- markdownlint-disable MD046 -->
- **ENV_SINKER_GLOBAL_CUSTOMER_KEYS**

    Sinker Global Customer Key list, keys are split with `,`

    **Type**: String

- **ENV_DATAWAY_ENABLE_SINKER**

    Enable DataWay Sinker [:octicons-tag-24: Version-1.14.0](changelog.md#cl-1.14.0)

    **Type**: Boolean

    **Default**: -
<!-- markdownlint-enable -->

### IO Module Environment Variables {#env-io}

<!-- markdownlint-disable MD046 -->
- **ENV_IO_FILTERS**

    Add [line protocol filter](datakit-filter.md)

    **Type**: JSON

- **ENV_IO_FLUSH_INTERVAL**

    Set compact interval [:octicons-tag-24: Version-1.22.0](changelog.md#cl-1.22.0)

    **Type**: Duration

    **Default**: 10s

- **ENV_IO_FEED_CHAN_SIZE**

    Set compact queue size [:octicons-tag-24: Version-1.22.0](changelog.md#cl-1.22.0)

    **Type**: Int

    **Default**: 1

- **ENV_IO_FLUSH_WORKERS**

    Set compact workers, default to limited CPU cores x 2 [:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9)

    **Type**: Int

- **ENV_IO_MAX_CACHE_COUNT**

    Compact buffer size

    **Type**: Int

    **Default**: 1024

- **~~ENV_IO_ENABLE_CACHE~~**

    Whether to open the disk cache that failed to send. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Boolean

    **Default**: false

- **~~ENV_IO_CACHE_ALL~~**

    Cache failed data points of all categories. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Boolean

    **Default**: false

- **~~ENV_IO_CACHE_MAX_SIZE_GB~~**

    Disk size of send failure cache (in GB). Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Int

    **Default**: 10

- **~~ENV_IO_CACHE_CLEAN_INTERVAL~~**

    Periodically send failed tasks cached on disk. Removed in [:octicons-tag-24: Version-1.62.0](changelog.md#cl-1.62.0)

    **Type**: Duration

    **Default**: 5s
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ note "description on buffer and queue"

    `ENV_IO_MAX_CACHE_COUNT` is used to control the data sending policy, that is, when the number of (row protocol) points of the cache in memory exceeds this value, an attempt is made to send the number of points of the current cache in memory to the center. If the threshold of the cache is set too high, the data will accumulate in memory, causing memory to soar, but will improve the compression effect of GZip. If it is too small, it may affect the transmission throughput.
<!-- markdownlint-enable -->

`ENV_IO_FILTERS` is a JSON string, as shown below:

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

### DCA {#env-dca}

<!-- markdownlint-disable MD046 -->
- **ENV_DCA_WEBSOCKET_SERVER**

    The server address that the the DataKit can connect to. Once `ENV_DCA_WEBSOCKET_SERVER` is set, the DCA function is enabled by default

    **Type**: URL
<!-- markdownlint-enable -->

### Refer Table About Environment Variables {#env-reftab}

<!-- markdownlint-disable MD046 -->
- **ENV_REFER_TABLE_URL**

    Set the data source URL

    **Type**: String

- **ENV_REFER_TABLE_PULL_INTERVAL**

    Set the request interval for the data source URL

    **Type**: String

    **Default**: 5m

- **ENV_REFER_TABLE_USE_SQLITE**

    Set whether to use SQLite to save data

    **Type**: Boolean

    **Default**: false

- **ENV_REFER_TABLE_SQLITE_MEM_MODE**

    When using SQLite to save data, use SQLite memory mode/disk mode

    **Type**: Boolean

    **Default**: false
<!-- markdownlint-enable -->

### Recorder Environment Variables {#env-recorder}

[:octicons-tag-24: Version-1.22.0](changelog.md#1.22.0)

For more info about recorder, see [here](datakit-tools-how-to.md#record-and-replay).

<!-- markdownlint-disable MD046 -->
- **ENV_ENABLE_RECORDER**

    To enable or disable recorder

    **Type**: Boolean

    **Default**: false

- **ENV_RECORDER_PATH**

    Set recorder data path

    **Type**: String

    **Default**: *Datakit 安装目录/recorder*

- **ENV_RECORDER_ENCODING**

    Set recorder format. v1 is lineprotocol, v2 is JSON

    **Type**: String

    **Default**: v2

- **ENV_RECORDER_DURATION**

    Set recorder duration(since Datakit start). After the duration, the recorder will stop to write data to file

    **Type**: Duration

    **Default**: 30m

- **ENV_RECORDER_INPUTS**

    Set allowed input names for recording, split by comma

    **Type**: List

    **Example**: cpu,mem,disk

- **ENV_RECORDER_CATEGORIES**

    Set allowed categories for recording, split by comma, full list of categories see [here](apis.md#category)

    **Type**: List

    **Example**: metric,logging,object
<!-- markdownlint-enable -->

### Remote Job {#remote_job}

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


### Others {#env-others}

<!-- markdownlint-disable MD046 -->
- **ENV_CLOUD_PROVIDER**

    Support filling in cloud suppliers during installation

    **Type**: String

    **Example**: `aliyun/aws/tencent/hwcloud/azure`

- **ENV_HOSTNAME**

    The default is the local host name, which can be specified at installation time, such as, `dk-your-hostname`

    **Type**: String

- **ENV_IPDB**

    Specify the IP repository type, currently only supports `iploc/geolite2`

    **Type**: String

- **ENV_ULIMIT**

    Specify the maximum number of open files for Datakit

    **Type**: Int

- **ENV_PIPELINE_OFFLOAD_RECEIVER**

    Set offload receiver

    **Type**: String

    **Default**: `datakit-http`

- **ENV_PIPELINE_OFFLOAD_ADDRESSES**

    Set offload addresses

    **Type**: List

    **Example**: `http://aaa:123,http://1.2.3.4:1234`

- **ENV_PIPELINE_DISABLE_APPEND_RUN_INFO**

    Disable appending the Pipeline run info

    **Type**: Boolean

    **Default**: `false`

- **ENV_CRYPTO_AES_KEY**

    The crypto key(len 16)

    **Type**: String

    **Example**: `0123456789abcdef`

- **ENV_CRYPTO_AES_KEY_FILE**

    File path for storing AES encryption and decryption key

    **Type**: String

    **Example**: `/usr/local/datakit/enc4mysql`

- **ENV_LOGGING_MAX_OPEN_FILES**

    Specify the maximum number of open files for logging collection, if the value is -1 then there is no limit, default 500

    **Type**: Int

    **Example**: `1000`
<!-- markdownlint-enable -->

### Special Environment Variable {#env-special}

#### ENV_K8S_NODE_NAME {#env_k8s_node_name}

When the k8s node name is different from its corresponding host name, the k8s node name can be replaced by the default collected host name, and the environment variable can be added in *datakit.yaml*:

> This configuration is included by default in `datakit.yaml` version  [1.2.19](changelog.md#cl-1.2.19). If you upgrade directly from the old version of yaml, you need to make the following manual changes to *datakit.yaml*.

```yaml
- env:
    - name: ENV_K8S_NODE_NAME
        valueFrom:
            fieldRef:
                apiVersion: v1
                fieldPath: spec.nodeName
```

#### ENV_K8s_CLUSTER_NODE_NAME {#env-rename-node}

[:octicons-tag-24: Version-1.36.0](changelog.md#1.36.0)

When multiple clusters share a workspace and contain nodes with identical names, the `ENV_K8S_CLUSTER_NODE_NAME` environment variable can be used to manually customize the collected node name. During deployment, add a new configuration section **after** the `ENV_K8S_NODE_NAME` section in your `datakit.yaml` file:

```yaml
- name: ENV_K8S_CLUSTER_NODE_NAME
  value: cluster_a_$(ENV_K8S_NODE_NAME) # Ensure that ENV_K8S_NODE_NAME is defined beforehand
```

This configuration appends `cluster_a_` to the original hostname, effectively creating a unique identifier for nodes in this cluster. As a result, the `host` tag associated with metrics such as logs, processes, CPU usage, and memory will also be prefixed with `cluster_a_`, enabling better data organization and filtering.

<!-- markdownlint-disable MD013 -->
### Individual Collector-specific Environment Variable {#inputs-envs}
<!-- markdownlint-enable -->

Some collectors support external injection of environment variables to adjust the default configuration of the collector itself. See each specific collector document for details.

## Extended Readings {#more-readings}

- [DataKit election](election.md)
- [Several Configuration Methods of DataKit](k8s-config-how-to.md)
