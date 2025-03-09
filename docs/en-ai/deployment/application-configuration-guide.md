## Overview

This document aims to modify related configurations through the "Modify Application Configuration" feature of launcher, in order to better adapt to the local environment, optimize relevant configurations, and meet personalized configuration needs.

## Launcher Operation Steps

1. Access the launcher console via a browser.
2. Select the top right corner to enter the **Modify Application Configuration** interface.

![](img/launcher-fix-cfg_1.png)

3. To modify the corresponding configuration file, check the **Modify Configuration** option, which will allow it to be modified.
4. After completing the configuration modifications, you need to check the **Automatically Restart Related Services After Modifying Configuration** option at the bottom right corner of the page, then click Confirm Modification.

![](img/launcher-fix-cfg_4.jpg)

## Service Common Configuration Description

### Studio Backend Service {#studio-backend}

#### Configuration File Location

- Namespace: forethought-core
- Configuration Name in Launcher: Core
- Configmap Name in Kubernetes: core

#### Configuration File Example

```YAML

# <<< custom_key.brand_name >>> Console Access Protocol
protocol: "http"
# <<< custom_key.brand_name >>> Console Address
hostname: "console.cloudcare.cn"

# Management Site Access Address
managementHostname: "management.cloudcare.cn"

# Current Site Name
envName: <<< custom_key.brand_name >>> Deployment Plan

# Whether the system runs in debug mode, generally not enabled
debug: false
# System default language
defaultLanguage: "zh"

# Prefix for frontend access addresses; the first two curly braces are occupied by protocol and hostname. If you need to configure a unified secondary address, adjust this setting directly.
frontServerUrlPrefixFormat: "{}://{}"

# ExternalAPI service configuration.
external:
  # Validity period of each request signature, in seconds
  timeliness: 60
  # AK/SK configuration for API signatures; can set random strings as AK/SK
  accessKey: ""
  secretKey: ""
  # When the system runs in debug mode, allows unlimited automatic passing of signature strings, default is no value
  debugPassSignature: ""

# Fixed notification types for alert policies
alertPolicyFixedNotifyTypes:
  email:
    enable: true

# Default token expiration time settings
token_exp_set:
  # Web end default setting 4 hours
  front_web: 14400
  # Management backend token default expiration duration
  manage: 7200


# API documentation switch, default closed, true indicates open. API documentation path defaults to /v1/doc; inner API default path is /v1/inner.doc
apiDocPageSwitch:
  # Management backend
  admin: false
  # Frontend
  front: false
  # Inner service
  inner: false
  # OpenAPI service
  openapi: false
  center: false
  # External service
  external: false


# Time offset for query_view trace data range, in seconds
BusinessQueryViewTimeOffset: 900



# <<< custom_key.brand_name >>> Database Configuration
database:
  connection:
  pool_size: 20
  max_overflow: 100
  echo: false
  pool_timeout: 30
  # This setting causes the pool to recycle connections after the specified number of seconds. It defaults to -1, or no timeout. For example, setting it to 3600 means connections will be recycled after one hour. Note that MySQL automatically disconnects if there is no activity on the connection within eight hours (though this can be configured via MySQLDB connection itself and server settings).
  pool_recycle: 3600
  # Boolean value, if True, enables the connection pool “pre-ping” feature, which tests the connection's liveness every time it is checked out.
  pool_pre_ping: true
  # Retrieves connections using LIFO (last-in-first-out) QueuePool instead of FIFO (first-in-first-out). Using LIFO, server-side timeout schemes can reduce the number of connections used during off-peak periods. When planning server-side timeouts, ensure the use of recycling (pool_recycle) or pre-ping (pool_pre_ping) strategies to handle outdated connections properly.
  pool_use_lifo: true


# Logger Configuration
logger:
  filename: /logdata/business.log
  level: info
  # Maximum size of each log file
  max_bytes: 52428800
  # Total number of log file rotations
  backup_count: 3
  # Controls log output methods, default outputs to both file and stdout
  output_mode_switch:
    file: true
    stdout: true

# GunLogger-access, same as above
g_access_logger:
  filename: /logdata/g_access.log
  mode: a
  level: info
  max_bytes: 52428800
  backup_count: 3
  # Controls log output methods, default outputs to both file and stdout
  output_mode_switch:
    file: true
    stdout: true


# Default large log split size when creating a new workspace, in bytes
workspaceLoggingCutSizeSet:
  es: 10240
  sls: 2048
  beaver: 2048
  doris: 10240

# Default data retention policy when creating a new workspace
workspaceVersionSet:
  unlimited:
    # Default policy configuration for creating a new workspace under Deployment Plan
    durationSet:
      rp: 30d
      logging: 14d
      keyevent: 14d
      tracing: 7d
      profiling: 7d
      rum: 7d
      # Only the Deployment Plan has separate session_replay configuration
      session_replay: 7d
      network: 2d
      security: 90d
      backup_log: 180d

# Default workspace status settings
WorkspaceDefaultStatsConfig:
  isOpenLogMultipleIndex:  true     # By default, custom log indexes are not enabled when creating a workspace
  logMultipleIndexCount:  6         # By default, custom log index count when creating a workspace
  loggingCutSize: 10240             # By default, ultra-large log count unit 10KB when creating a workspace
  maxSearchResultCount: 0           # By default, search result limit 0 when creating a workspace

# Default ES/Doris index settings when creating a new workspace
WorkspaceDefaultesIndexSettings:
  number_of_shards: 1               # Default primary shard count for ES
  number_of_replicas: 1             # Default replica count for ES | Doris
  rollover_max_size: 30             # Default shard size for ES
  hot_retention: 24                 # Default hot data duration for ES | Doris

...

```

#### Detailed Configuration Item Descriptions

| Configuration Item                                            | Sub-item                      | Type   | Default Value                  | Description                                                                                                                                                                                                          |
| ------------------------------------------------------------- | ----------------------------- | ------ | ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| protocol                                                      |                              | String | http                           | <<< custom_key.brand_name >>> Console Access Protocol                                                                                                                                                                |
| hostname                                                      |                              | String | console.cloudcare.cn           | <<< custom_key.brand_name >>> Console Address                                                                                                                                         |
| managementHostname                                            |                              | String | management.cloudcare.cn        | Management site access address                                                                                                                                                                                      |
| envName                                                       |                              | String | <<< custom_key.brand_name >>>   | Current site name                                                                                                                                                                                                   |
| debug                                                         |                              | Boolean | false                          | Debug mode switch                                                                                                                                                                                                   |
| frontServerUrlPrefixFormat                                    |                              | String | {}://{}                        | Frontend access address prefix; the first two curly braces are occupied by protocol and hostname. If you need to configure a unified secondary address, adjust this setting directly.                                  |
| external                                                      | timeliness                    | Number | 60                             | Validity period of each request signature, in seconds                                                                                                                                                               |
|                                                               | accessKey                     | String |                                 | AK configuration for API signatures; can set random strings as AK                                                                                                                                                   |
|                                                               | secretKey                     | String |                                 | SK configuration for API signatures; can set random strings as SK                                                                                                                                                   |
|                                                               | debugPassSignature            | String |                                 | When the system runs in debug mode, allows unlimited automatic passing of signature strings, default is no value                                                                       |
| defaultLanguage                                               |                              | String | zh                             | System default language; if no language is specified when creating a new workspace, this configuration value is used by default.                                                                                    |
| token_exp_set                                                 | front_web                     | Number | 14400                          | Token validity duration for Studio web users, in seconds                                                                                                                                                            |
|                                                               | manage                        | Number | 7200                           | Token validity duration for management backend web users, in seconds                                                                                                                                                |
| apiDocPageSwitch                                              | admin                         | Boolean | false                          | API documentation switch for the management backend                                                                                                                                                                 |
|                                                               | front                         | Boolean | false                          | API documentation switch for Studio backend                                                                                                                                                                        |
|                                                               | inner                         | Boolean | false                          | API documentation switch for Inner service                                                                                                                                                                         |
|                                                               | openapi                       | Boolean | false                          | API documentation switch for OpenAPI                                                                                                                                                                               |
|                                                               | external                      | Boolean | false                          | API documentation switch for External API                                                                                                                                                                          |
| BusinessQueryViewTimeOffset                                   |                              | Number | 900                            | Time offset for querying RUM Resource trace data, in seconds                                                                                                                                                       |
| database                                                      | connection                    | String  |                                 | Database connection string                                                                                                                                                                                          |
|                                                               | pool_size                     | Number | 20                             | Regular connection pool size per worker                                                                                                                                                                            |
|                                                               | max_overflow                  | Number | 100                            | Maximum overflow size for connection pools per worker                                                                                                                                                              |
|                                                               | pool_timeout                  | Number | 30                             | Database connection timeout, in seconds                                                                                                                                                                           |
|                                                               | pool_recycle                  | Number | 3600                           | Controls the recycle time of connection pool connections. Connections created will be recycled after this specified time, in seconds. Generally used with `pool_pre_ping` and `pool_use_lifo`. Connection recycling triggers only when the connection is used. |
|                                                               | pool_pre_ping                 | Boolean | true                           | Enables the "pre-ping" feature of the connection pool, which tests the connection's liveness each time it is used                                                                                                    |
|                                                               | pool_use_lifo                 | Boolean | true                           | Retrieves connections using LIFO (last-in-first-out) QueuePool rather than FIFO (first-in-first-out)                                                                                                                |
| logger                                                        | filename                      | String  | /logdata/business.log          | Log file                                                                                                                                                                                                            |
|                                                               | level                         | String  | info                           | Minimum log level                                                                                                                                                                                                   |
|                                                               | max_bytes                     | Number  | 52428800                       | Maximum size of each log file, in bytes                                                                                                                                                                             |
|                                                               | backup_count                  | Number  | 3                              | Total number of log file rotations                                                                                                                                                                                  |
|                                                               | output_mode_switch.file       |         | true                           | Controls log output methods, supports output to files                                                                                                                                                               |
|                                                               | output_mode_switch.stdout     |         | true                           | Controls log output methods, supports output to stdout                                                                                                                                                             |
| g_access_logger                                               |                               |         |                                 | Gunicon log configuration, sub-items are the same as those for logger                                                                                                                                              |
| workspaceLoggingCutSizeSet                                    | es                            | Number  | 10240                          | Default large log split size when creating a new workspace, in bytes, storage type: elasticsearch/OpenSearch                                                                                                       |
|                                                               | sls                           | Number  | 2048                           | Default large log split size when creating a new workspace, in bytes, storage type: Alibaba Cloud SLS                                                                                                               |
|                                                               | beaver                        | Number  | 2048                           | Default large log split size when creating a new workspace, in bytes, storage type: Beaver                                                                                                                          |
|                                                               | doris                         | Number  | 10240                          | Default large log split size when creating a new workspace, in bytes, storage type: Doris                                                                                                                           |
| WorkspaceDefaultStatsConfig.unlimited.durationSet             |                               | JSON    |                                 | Default data retention duration configuration when creating a new workspace                                                                                                                                        |
|                                                               | rp                            | String  | 30d                            | Default data retention duration for Mearsurement                                                                                                                                                                   |
|                                                               | logging                       | String  | 14d                            | Default data retention duration for logs                                                                                                                                                                           |
|                                                               | keyevent                      | String  | 14d                            | Default data retention duration for events                                                                                                                                                                         |
|                                                               | tracing                       | String  | 7d                             | Default data retention duration for traces                                                                                                                                                                         |
|                                                               | rum                           | String  | 7d                             | Default data retention duration for RUM                                                                                                                                                                            |
|                                                               | network                       | String  | 2d                             | Default data retention duration for network                                                                                                                                                                        |
|                                                               | security                      | String  | 90d                            | Default data retention duration for Security Check                                                                                                                                                                 |
|                                                               | backup_log                    | String  | 180d                           | Default data retention duration for backup logs                                                                                                                                                                    |
| WorkspaceDefaultStatsConfig                                   | isOpenLogMultipleIndex        | Boolean | true                           | Whether custom log indexes are enabled when creating a workspace                                                                                                                                                   |
|                                                               | logMultipleIndexCount         | Number  | 6                              | Custom log index count when creating a workspace                                                                                                                                                                    |
|                                                               | loggingCutSize                | Number  | 10240                          | Ultra-large log count unit 10KB when creating a workspace                                                                                                                                                          |
|                                                               | maxSearchResultCount          | Number  | 0                              | Search result limit 0                                                                                                                                                                                              |
| WorkspaceDefaultesIndexSettings                               | number_of_shards              | Number  | 1                              | Primary shard count when creating a workspace, effective for ES                                                                                                                                                     |
|                                                               | number_of_replicas            | Number  | 1                              | Replica count when creating a workspace, effective for ES/Doris                                                                                                                                                     |
|                                                               | rollover_max_size             | Number  | 30                             | Shard size when creating a workspace, effective for ES/Doris                                                                                                                                                       |
|                                                               | hot_retention                 | Number  | 24                             | Hot data duration when creating a workspace, effective for ES/Doris                                                                                                                                                 |

### Studio Frontend Site {#studio-front}

#### Configuration File Location

- Namespace: forethought-webclient
- Configuration Name in Launcher: frontWeb
- Configmap Name in Kubernetes: front-web-config

#### Configuration File Example

```js
window.DEPLOYCONFIG = {
    ...
    "rumDatawayUrl": "https://rum-openway.guance.com",
    "datakitScriptUrl": "https://<<< custom_key.static_domain >>>/datakit",
    "datakitHelmUrl": "https://pubrepo.guance.com",
    "passPublicNetwork": 1,
    "isOverseas": 0,
    "maxTraceSpanLimit": 10000,
    "maxProfileM": 5,
    "paasCustomLoginInfo": [{ "iconUrl":"xxx", "label": "xxx", "url": "xxxx" ,desc:"xxx"}],
    "paasCustomSiteList": [{"url": "xxxx", "label": "xxx"}],
    "paasCustomLoginUrl": "https://www.xxx",
    "maxMessageByte": 10 * 1024,
    "webRumSdkUrl": "https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js",
    "defaultTimeMap": {
        'log': [1732254771701,1732255671701],// Or relative time 5m
    }
    ...
}
```

#### Detailed Configuration Item Descriptions

| Configuration Item                    | Sub-item | Type                | Default Value                              | Description                                                                                                                                                            |
| ------------------------------------- | -------- | ------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| rumDatawayUrl                         |          | String              | "https://rum-openway.guance.com"           | Dedicated DataWay URL for reporting RUM data, displayed on the RUM integration configuration page after configuration.                                                |
| datakitScriptUrl                      |          | String              | "https://<<< custom_key.static_domain >>>/datakit" | Default installation script download domain for DataKit installation page; modify this configuration if using internal static resources.                              |
| datakitHelmUrl                        |          | String              | "https://pubrepo.guance.com"               | DataKit Helm image repository address; modify this configuration if using a self-built image repository.                                                               |
| passPublicNetwork                     |          | Number              | 1                                          | Whether the client computer accessing the Studio site has public network access, 0: No, 1: Yes.                                                                        |
| isOverseas                            |          | Number              | 0                                          | Whether this <<< custom_key.brand_name >>> site is deployed overseas, affecting the display of world map and China map components in RUM.                             |
| maxTraceSpanLimit                     |          | Number              | 10000                                      | Maximum number of spans in flame graphs, default value: 10000.                                                                                                         |
| maxProfileM                           |          | Number              | 5                                          | Maximum MB for displaying profile flame graphs, default value: 5.                                                                                                      |
| paasCustomLoginInfo                   |          | Array               | None                                       | Single sign-on entry configuration for the login page of the Deployment Plan <<< custom_key.brand_name >>> console. New fields `iconUrl`, `desc`; `iconUrl` is the single sign-on icon URL, `desc` is the description text. |
| paasCustomSiteList                    |          | Array               | None                                       | Multi-site selection configuration for the login page of the Deployment Plan <<< custom_key.brand_name >>> console. `label` is the site display text, `url` is the site address. |
| rumEnable `Self-Observability`        |          | Boolean             | None                                       | Whether to enable RUM, 1 indicates enabled; if not enabled, the following configuration values can be empty.                                                          |
| rumDatakitUrl `Self-Observability`    |          | String              | None                                       | RUM DataKit address or public openway address.                                                                                                                         |
| rumApplicationId `Self-Observability` |          | String              | None                                       | RUM application ID for reporting application data.                                                                                                                     |
| rumJsUrl `Self-Observability`         |          | String              | None                                       | RUM SDK CDN address.                                                                                                                                                   |
| rumClientToken `Self-Observability`   |          | String              | None                                       | RUM Openway public reporting data (requires cooperation with `rumOpenwayUrl`), generated by the <<< custom_key.brand_name >>> platform. Conflicts with DataKit reporting method, higher priority than DataKit reporting.       |
| rumOpenwayUrl `Self-Observability`    |          | String              | None                                       | Public RUM Openway address (requires cooperation with `rumClientToken`), used for self-observability reporting from the Studio frontend site.                           |
| paasCustomLoginUrl                    |          | String              | None                                       | Custom login URL.                                                                                                                                                      |
| maxMessageByte                        |          | String              | None                                       | Maximum byte size for messages in the Explorer list, default is 10 * 1024.                                                                                             |
| webRumSdkUrl                          |          | String              | None                                       | RUM web SDK CDN address, default is https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-rum.js.                                                           |
| defaultTimeMap                        |          | String or Object    | None                                       | Default initialization time configuration for the Explorer, format `{'log': '5m'}` or `{'log': [1732254771701,1732255671701]}`. Key is fixed string, `log` for log Explorer, `security` for Security Check. |

### Kodo Component {#kodo}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration Name in Launcher: Kodo
- Configmap Name in Kubernetes: kodo

#### Configuration File Example

```YAML

...

global:
    workers: 8
    log_workers: 8
    tracing_workers: 8
    ...

redis:
    host: "r-xxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

asynq_redis:
    host: "r-xxxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

dql:
    metric_query_workers: 8 # Time series data worker count, default is 8
    log_query_workers: 8 # Log data worker count, default is 8
    ...

...
```

#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item                    | Type   | Default Value               | Description                                                                                                                            |
| ----------------------- | --------------------------- | ------ | --------------------------- | -------------------------------------------------------------------------------------------------------- |
| log                     | log_file                    | String | '/logdata/log'              | Runtime log storage address, optional values include stdout, indicating standard output without saving to file.                        |
|                        | level                       | String | 'info'                      | Minimum runtime log level.                                                                                                             |
|                        | gin_log_file                | String | '/logdata/log'              | Gin log storage address, optional values include stdout, indicating standard output without saving to file.                             |
| database                | db_dialect                  | String | 'mysql'                     | Database type, default is mysql.                                                                                                       |
|                        | addr                        | String | 'testsql.com:3306'          | Database connection address.                                                                                                           |
|                        | username                    | String | ' test_user'                | Username.                                                                                                                              |
|                        | password                    | String | 'test_password'             | Password.                                                                                                                              |
|                        | network                     | String | 'tcp'                       | Connection protocol.                                                                                                                   |
|                        | db_name                     | String | 'test_db_name'              | Database name.                                                                                                                         |
| nsq                     | lookupd                     | String | 'testnsq.com:4161'          | NSQ lookupd address.                                                                                                                   |
|                        | discard_expire_interval     | Number | 5                           | Maximum redundancy time for time series data, in minutes. By default, time series metrics data older than 5 minutes delay will not be written. |
| redis                   | host                        | String | 'testredis.com:6379'        | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent. |
|                        | password                    | String | 'test_password'             | Password.                                                                                                                              |
|                        | db                          | Number | 0                           | Redis DB value.                                                                                                                        |
|                        | is_cluster                  | Boolean | false                       | Set to true when Redis is a cluster and does not support proxy connections.                                                            |
| asynq_redis             | host                        | String | ''                          | Redis address used for asynchronous tasks, defaults to `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster version of `asynq_redis` must be configured. |
|                        | password                    | String | 'test_password'             | Password.                                                                                                                              |
|                        | db                          | Number | 0                           | Redis DB value.                                                                                                                        |

### Kodo-Inner Component {#kodo-inner}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration Name in Launcher: KodoInner
- Configmap Name in Kubernetes: kodo-inner

#### Configuration File Example

```YAML

...

redis:
    host: "r-xxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

asynq_redis:
    host: "r-xxxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

dql:
    metric_query_workers: 8 # Time series data worker count, default is 8
    log_query_workers: 8    # Log data worker count, default is 8
    ...

...
```

#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item                        | Type   | Default Value               | Description                                                                                                                            |
| ----------------------- | ------------------------------- | ------ | --------------------------- | -------------------------------------------------------------------------------------------------------- |
| log                     | log_file                        | String | '/logdata/log'              | Runtime log storage address, optional values include stdout, indicating standard output without saving to file.                        |
|                        | level                           | String | 'info'                      | Minimum runtime log level.                                                                                                             |
|                        | gin_log_file                    | String | '/logdata/log'              | Gin log storage address, optional values include stdout, indicating standard output without saving to file.                             |
| database                | db_dialect                      | String | 'mysql'                     | Database type, default is mysql.                                                                                                       |
|                        | addr                            | String | 'testsql.com:3306'          | Database connection address.                                                                                                           |
|                        | username                        | String | ' test_user'                | Username.                                                                                                                              |
|                        | password                        | String | 'test_password'             | Password.                                                                                                                              |
|                        | network                         | String | 'tcp'                       | Connection protocol.                                                                                                                   |
|                        | db_name                         | String | 'test_db_name'              | Database name.                                                                                                                         |
| nsq                     | lookupd                         | String | 'testnsq.com:4161'          | NSQ lookupd address.                                                                                                                   |
|                        | discard_expire_interval         | Number | 5                           | Maximum redundancy time for time series data, in minutes. By default, time series metrics data older than 5 minutes delay will not be written. |
| redis                   | host                            | String | 'testredis.com:6379'        | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent. |
|                        | password                        | String | 'test_password'             | Password.                                                                                                                              |
|                        | db                              | Number | 0                           | Redis DB value.                                                                                                                        |
|                        | is_cluster                      | Boolean | false                       | Set to true when Redis is a cluster and does not support proxy connections.                                                            |
| asynq_redis             | host                            | String | ''                          | Redis address used for asynchronous tasks, defaults to `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster version of `asynq_redis` must be configured. |
|                        | password                        | String | 'test_password'             | Password.                                                                                                                              |
|                        | db                              | Number | 0                           | Redis DB value.                                                                                                                        |
| dql                     | metric_query_workers            | Number | 32                          | Number of DQL metric data query workers.                                                                                               |
|                        | query_metric_channel_size       | Number | 32                          | Request queue size for each metric_query_worker.                                                                                       |
|                        | log_query_workers               | Number | 32                          | Number of DQL log text class (logs, traces, RUM, etc.) data query workers.                                                              |
|                        | query_log_channel_size          | Number | 32                          | Request queue size for each log_query_worker.                                                                                          |
|                        | general_query_workers           | Number | 32                          | Number of non-metric or log query workers.                                                                                             |
|                        | query_general_channel_size      | Number | 32                          | Request queue size for each general_query_worker.                                                                                      |
|                        | profiling_parse                 | Boolean | true                        | Whether DQL queries are enabled to profile and record the duration of various stages.                                                  |
| influxdb                | read_timeout                    | Number | 60                          | Query timeout for time series metrics data, in seconds, default timeout is 60s.                                                        |
|                        | dial_timeout                    | Number | 30                          | Connect timeout for querying time series metrics data, in milliseconds, default connect timeout is 30ms.                               |
| doris                   | read_timeout                    | Number | 60                          | Query timeout for log data, in seconds, default timeout is 60s.                                                                        |
|                        | dial_timeout                    | Number | 30                          | Connect timeout for querying log data, in milliseconds, default connect timeout is 30ms.                                               |
| global                  | datakit_usage_check_enabled     | Boolean | false                       | Whether to check if the number of DataKit exceeds the license limit during log queries, default does not check.                        |

### Kodo-X Component {#kodo-x}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration Name in Launcher: KodoX
- Configmap Name in Kubernetes: kodo-x

#### Configuration File Example

```YAML

...

global:
    workers: 8
    log_workers: 8
    tracing_workers: 8
    ...

redis:
    host: "r-xxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

asynq_redis:
    host: "r-xxxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

doris:
    dial_timeout: 10
    gzip_enable: false

dql:
    metric_query_workers: 8 # Time series data worker count, default is 8
    log_query_workers: 8 # Log data worker count, default is 8
    ...

pipeline:
    enable: false
    pull_duration: "1m"

...
```

#### Detailed Configuration Item Descriptions

| Configuration Item       | Sub-item                    | Type   | Default Value               | Description                                                                                                                                                                   |
| ------------------------ | --------------------------- | ------ | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| log                      | log_file                    | String | '/logdata/log'              | Runtime log storage address, optional values include stdout, indicating standard output without saving to file.                                                                |
|                         | level                       | String | 'info'                      | Minimum runtime log level.                                                                                                                                                    |
|                         | gin_log_file                | String | '/logdata/log'              | Gin log storage address, optional values include stdout, indicating standard output without saving to file.                                                                    |
| database                 | db_dialect                  | String | 'mysql'                     | Database type, default is mysql.                                                                                                                                             |
|                         | addr                        | String | 'testsql.com:3306'          | Database connection address.                                                                                                                                                 |
|                         | username                    | String | ' test_user'                | Username.                                                                                                                                      |
|                         | password                    | String | 'test_password'             | Password.                                                                                                                                      |
|                         | network                     | String | 'tcp'                       | Connection protocol.                                                                                                                                      |
|                         | db_name                     | String | 'test_db_name'              | Database name.                                                                                                                                      |
| nsq                      | lookupd                     | String | 'testnsq.com:4161'          | NSQ lookupd address.                                                                                                                                      |
|                         | discard_expire_interval     | Number | 5                           | Maximum redundancy time for time series data, in minutes. By default, time series metrics data older than 5 minutes delay will not be written.                                 |
| redis                    | host                        | String | 'testredis.com:6379'        | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent.                                     |
|                         | password                    | String | 'test_password'             | Password.                                                                                                                                      |
|                         | db                          | Number | 0                           | Redis DB value.                                                                                                                                      |
|                         | is_cluster                  | Boolean | false                       | Set to true when Redis is a cluster and does not support proxy connections.                                                                     |
| asynq_redis              | host                        | String | ''                          | Redis address used for asynchronous tasks, defaults to `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster version of `asynq_redis` must be configured. |
|                         | password                    | String | 'test_password'             | Password.                                                                                                                                      |
|                         | db                          | Number | 0                           | Redis DB value.                                                                                                                                      |
| global                   | workers                     | Number | 8                           | Default worker count for various data processing.                                                                                                                             |
|                         | metric_workers              | Number | 8                           | Worker count for processing time series metrics data.                                                                                                                         |
|                         | log_workers                 | Number | 8                           | Worker count for processing log data.                                                                                                                                         |
|                         | tracing_workers             | Number | 8                           | Worker count for processing trace data, defaults to the value of `log_workers` configuration item.                                                                             |
| influxdb                 | read_timeout                | Number | 60                          | Query timeout for time series metrics data, in seconds, default timeout is 60s.                                                                                               |
|                         | write_timeout               | Number | 300                         | Write timeout for time series metrics data, in seconds, default write timeout is 5 min.                                                                                        |
|                         | enable_gz                   | Boolean | false                       | Whether to enable gzip compression for writing data.                                                                                                                         |
|                         | dial_timeout                | Number | 30                          | Connect timeout for querying time series metrics data, in milliseconds, default connect timeout is 30ms.                                                                     |
| doris                    | read_timeout                | Number | 60                          | Query timeout for log data, in seconds, default timeout is 60s.                                                                                                               |
|                         | write_timeout               | Number | 300                         | Write timeout for log data, in seconds, default write timeout is 5 min.                                                                                                       |
|                         | gzip_enable                 | Boolean | false                       | Whether to enable gzip compression for writing data.                                                                                                                         |
|                         | dial_timeout                | Number | 30                          | Connect timeout for querying log data, in milliseconds, default connect timeout is 30ms.                                                                                     |
| backup_kafka             | async                       | Boolean | false                       | Data forwarding to Kafka, write mode, default is synchronous write.                                                                                                          |
|                         | write_timeout               | Number | 30                          | Write timeout for Kafka, in seconds, default write timeout is 30s.                                                                                                           |
|                         | max_bulk_docs               | Number | 0                           | Whether to batch multiple logs into a single Kafka message, default sends one Kafka message per log.                                                                         |
| pipeline                 | enable                      | Boolean | false                       | Set to `true` to enable central Pipeline functionality.                                                                                                                      |
|                         | pull_duration               | String  | 1m                          | Interval for synchronizing central Pipeline scripts, default value `1m` means synchronization every 1 minute, supports `s`, `m`, `h` intervals, e.g., `1m30s` means every 1 minute 30 seconds. |

### Kodo-Servicemap Component {#kodo-servicemap}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration Name in Launcher: kodoServiceMap
- Configmap Name in Kubernetes: kodo-servicemap

#### Configuration File Example

```YAML

...

redis:
    host: "r-xxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

asynq_redis:
    host: "r-xxxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

...
```

#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item | Type   | Default Value | Description                                                                                                                            |
| ----------------------- | -------- | ------ | ------------- | -------------------------------------------------------------------------------------------------------- |
| redis                   | host     | String | ''            | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent. |
| asynq_redis             | host     | String | ''            | Redis address used for asynchronous tasks, defaults to `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster version of `asynq_redis` must be configured. |

### Kodo-X-Scan Component {#kodo-x-scan}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration Name in Launcher: kodoXScan
- Configmap Name in Kubernetes: kodo-x-scan

#### Configuration File Example

```YAML

...

redis:
    host: "r-xxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

asynq_redis:
    host: "r-xxxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

...
```

#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item | Type   | Default Value | Description                                                                                                                            |
| ----------------------- | -------- | ------ | ------------- | -------------------------------------------------------------------------------------------------------- |
| redis                   | host     | String | ''            | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent. |
| asynq_redis             | host     | String | ''            | Redis address used for asynchronous tasks, defaults to `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster version of `asynq_redis` must be configured. |

### Kodo-WS Component {#kodo-ws}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration Name in Launcher: kodoWS
- Configmap Name in Kubernetes: kodo-ws

#### Configuration File Example

```YAML

...

redis:
    host: "r-xxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

asynq_redis:
    host: "r-xxxx.redis.rds.xxx.com:6379"
    password: "..."
    db: 0

...
```

#### Detailed Configuration Item Descriptions

|#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item | Type   | Default Value | Description                                                                                                                            |
| ----------------------- | -------- | ------ | ------------- | -------------------------------------------------------------------------------------------------------- |
| redis                   | host     | String | ''            | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent. |
| asynq_redis             | host     | String | ''            | Redis address used for asynchronous tasks, defaults to `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster version of `asynq_redis` must be configured. |

### Summary

This document provides detailed instructions on how to modify application configurations using the "Modify Application Configuration" feature in launcher. It covers various components such as Studio Backend Service, Studio Frontend Site, Kodo, Kodo-Inner, Kodo-X, Kodo-Servicemap, Kodo-X-Scan, and Kodo-WS. Each section includes the location of the configuration files, example configurations, and detailed descriptions of each configuration item to ensure proper setup and customization for your environment.

---

If you have any further questions or need additional assistance with specific configurations, please refer to the official documentation or contact support for more information.