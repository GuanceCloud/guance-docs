## Overview

This document aims to modify relevant configurations through the "Modify Application Configuration" feature of launcher, in order to better adapt to the local environment and achieve the purpose of optimizing and meeting personalized configuration needs.

## Launcher Operation Steps

1. Browser access to the launcher console
2. Select the top right corner to enter the **Modify Application Configuration** interface

![](img/launcher-fix-cfg_1.png)

3. To modify the corresponding configuration file, you need to **check the Modify Configuration** option to enable modifications.
4. After completing the configuration modification, you need to check the **Automatically Restart Related Services After Modifying Configuration** at the bottom right corner of the page, then click Confirm Modification.

![](img/launcher-fix-cfg_4.jpg)

## Common Service Configuration Instructions

### Studio Backend Service {#studio-backend}

#### Configuration File Location

- Namespace: forethought-core
- Configuration name in Launcher: Core
- Configmap name in Kubernetes: core

#### Configuration File Example

```YAML

# Guance console access protocol
protocol: "http"
# Guance console address
hostname: "console.cloudcare.cn"

# Management backend site access address
managementHostname: "management.cloudcare.cn"

# Current site name
envName: Guance Deployment Plan

# Whether the system debug mode is enabled, generally not enabled
debug: false
# System default language
defaultLanguage: "zh"

# Prefix for frontend access addresses; the first two curly braces are occupied by protocol and hostname. If you need to configure a unified secondary address, adjust this setting directly.
frontServerUrlPrefixFormat: "{}://{}"

# ExternalAPI service configuration.
external:
  # Validity period for each request signature, in seconds
  timeliness: 60
  # ak/sk configuration for API signatures, can be set as random strings
  accessKey: ""
  secretKey: ""
  # Signature string allowed to pass automatically when the system runs in debug mode, no value by default
  debugPassSignature: ""

# Fixed notification types for alert policies
alertPolicyFixedNotifyTypes:
  email:
    enable: true

# Default expiration time settings for tokens
token_exp_set:
  # Web end default setting 4 hours
  front_web: 14400
  # Management backend token default expiration time
  manage: 7200


# API documentation switch, default closed, set to true to enable. API documentation path defaults to /v1/doc; inner API default path is /v1/inner.doc
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


# Time range offset for query_view links, in seconds
BusinessQueryViewTimeOffset: 900



# Guance database configuration
database:
  connection:
  pool_size: 20
  max_overflow: 100
  echo: false
  pool_timeout: 30
  # This setting causes the pool to recycle connections after the given number of seconds. It defaults to -1, or no timeout. For example, setting it to 3600 means connections will be recycled after one hour. Note that if there is no activity detected on a connection within eight hours, MySQL will automatically disconnect (though this can be configured via MySQLDB connections and server settings).
  pool_recycle: 3600
  # Boolean, if True, enables the connection pool "pre-ping" feature, which tests the liveness of connections upon checkout
  pool_pre_ping: true
  # Use LIFO (last-in-first-out) QueuePool instead of FIFO (first-in-first-out) when retrieving connections. Using LIFO can reduce the number of connections used during non-peak usage periods with server-side timeout schemes. When planning server-side timeouts, ensure proper handling of stale connections using recycling (pool_recycle) or pre-ping (pool_pre_ping) strategies.
  pool_use_lifo: true


# Logger Configuration
logger:
  filename: /logdata/business.log
  level: info
  # Maximum size of each log file
  max_bytes: 52428800
  # Total number of log file rollovers
  backup_count: 3
  # Control log output method, default outputs to both file and stdout
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
  # Control log output method, default outputs to both file and stdout
  output_mode_switch:
    file: true
    stdout: true


# Default large log split unit when creating a new workspace, in bytes
workspaceLoggingCutSizeSet:
  es: 10240
  sls: 2048
  beaver: 2048
  doris: 10240

# Default data retention policy when creating a new workspace
workspaceVersionSet:
  unlimited:
    # Default strategy configuration for creating a new workspace under the Deployment Plan
    durationSet:
      rp: 30d
      logging: 14d
      keyevent: 14d
      tracing: 7d
      profiling: 7d
      rum: 7d
      # Only the Deployment Plan has separate configuration for session_replay
      session_replay: 7d
      network: 2d
      security: 90d
      backup_log: 180d

# Default workspace status settings
WorkspaceDefaultStatsConfig:
  isOpenLogMultipleIndex:  true     # Default creation of a workspace does not enable custom log indexes
  logMultipleIndexCount:  6         # Default number of custom log indexes when creating a workspace
  loggingCutSize: 10240             # Default large log count unit 10KB when creating a workspace
  maxSearchResultCount: 0           # Default search result limit 0 when creating a workspace

# Default ES/Doris index configuration information
WorkspaceDefaultesIndexSettings:
  number_of_shards: 1               # Default primary shard count for ES when creating a workspace
  number_of_replicas: 1             # Whether replicas are enabled when creating a workspace for ES | Doris
  rollover_max_size: 30             # Shard size when creating a workspace for ES
  hot_retention: 24                 # Hot data duration when creating a workspace for ES | Doris

...

```

#### Detailed Configuration Item Descriptions

| Configuration Item                                            | Sub-item                      | Type   | Default Value                  | Description                                                                                                                                                                                                          |
| ------------------------------------------------- | ------------------------- | ------ | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| protocol                                          |                           | String | http                    | Guance console access protocol                                                                                                                                                                                      |
| hostname                                          |                           | String | console.cloudcare.cn    | Guance console address                                                                                                                                                                                               |
| managementHostname                                |                           | String | management.cloudcare.cn | Management backend site access address                                                                                                                                                                               |
| envName                                           |                           | String | Guance                  | Current site name                                                                                                                                                                                                    |
| debug                                             |                           | Boolean | false                   | Debug mode switch                                                                                                                                                                                                   |
| frontServerUrlPrefixFormat                        |                           | String | {}://{}                 | Prefix for frontend access addresses; the first two curly braces are occupied by protocol and hostname. If you need to configure a unified secondary address, adjust this setting directly.                                                                                       |
| external                                          | timeliness                | Numeric | 60                      | Validity period for each request signature, in seconds                                                                                                                                                               |
|                                                   | accessKey                 | String |                         | ak configuration for API signatures, can be set as random strings                                                                                                                                                     |
|                                                   | secretKey                 | String |                         | sk configuration for API signatures, can be set as random strings                                                                                                                                                     |
|                                                   | debugPassSignature        | String |                         | Signature string allowed to pass automatically when the system runs in debug mode, no value by default                                                                                                              |
| defaultLanguage                                   |                           | String | zh                      | System default language, new workspaces without specified languages will use this configuration value by default                                                                                                     |
| token_exp_set                                     | front_web                 | Numeric | 14400                   | Valid duration for Studio web user login, in seconds                                                                                                                                                                 |
|                                                   | manage                    | Numeric | 7200                    | Valid duration for management backend web user login, in seconds                                                                                                                                                     |
| apiDocPageSwitch                                  | admin                     | Boolean | false                   | Switch for enabling API documentation in the management backend                                                                                                                                                       |
|                                                   | front                     | Boolean | false                   | Switch for enabling API documentation in the Studio backend                                                                                                                                                          |
|                                                   | inner                     | Boolean | false                   | Switch for enabling API documentation in the Inner service                                                                                                                                                           |
|                                                   | openapi                   | Boolean | false                   | Switch for enabling OpenAPI documentation                                                                                                                                                                            |
|                                                   | external                  | Boolean | false                   | Switch for enabling External API documentation                                                                                                                                                                       |
| BusinessQueryViewTimeOffset                       |                           | Numeric | 900                     | Time offset range for querying RUM Resource link data, in seconds                                                                                                                                                     |
| database                                          | connection                | String |                         | Database connection string                                                                                                                                                                                           |
|                                                   | pool_size                 | Numeric | 20                      | Normal pool connection count per worker                                                                                                                                                                              |
|                                                   | max_overflow              | Numeric | 100                     | Maximum overflow count for pool connections per worker                                                                                                                                                               |
|                                                   | pool_timeout              | Numeric | 30                      | Database connection timeout, in seconds                                                                                                                                                                              |
|                                                   | pool_recycle              | Numeric | 3600                    | Controls the recycling time for pool connections, connections created will be recycled after the specified time. Unit: seconds. Generally used with pool_pre_ping and pool_use_lifo, where pool_use_lifo should be true. |
|                                                   | pool_pre_ping             | Boolean | true                    | Enables the connection pool "pre-ping" feature, which tests the liveness of connections upon checkout                                                                                                                                               |
|                                                   | pool_use_lifo             | Boolean | true                    | Retrieves connections using LIFO (last-in-first-out) QueuePool instead of FIFO (first-in-first-out)                                                                                                                                              |
| logger                                            | filename                  | String | /logdata/business.log   | Log file                                                                                                                                                                                                             |
|                                                   | level                     | String | info                    | Minimum log level                                                                                                                                                                                                    |
|                                                   | max_bytes                 | Numeric | 52428800                | Maximum size of each log file, in bytes                                                                                                                                                                              |
|                                                   | backup_count              | Numeric | 3                       | Total number of log file rollovers                                                                                                                                                                                  |
|                                                   | output_mode_switch.file   |        | true                    | Controls log output method, supports output to file                                                                                                                                                                  |
|                                                   | output_mode_switch.stdout |        | true                    | Controls log output method, supports output to stdout                                                                                                                                                               |
| g_access_logger                                   |                           |        |                         | gunicon log configuration, related sub-items are the same as logger                                                                                                                                                  |
| workspaceLoggingCutSizeSet                        | es                        | Numeric | 10240                   | Default large log split unit when creating a new workspace, in bytes, storage type: elasticsearch/OpenSearch                                                                                                         |
|                                                   | sls                       | Numeric | 2048                    | Default large log split unit when creating a new workspace, in bytes, storage type: Alibaba Cloud SLS storage                                                                                                        |
|                                                   | beaver                    | Numeric | 2048                    | Default large log split unit when creating a new workspace, in bytes, storage type: Beaver                                                                                                                            |
|                                                   | doris                     | Numeric | 10240                   | Default large log split unit when creating a new workspace, in bytes, storage type: Doris                                                                                                                             |
| WorkspaceDefaultStatsConfig.unlimited.durationSet |                           | JSON   |                         | Default data retention duration configuration when creating a new workspace                                                                                                                                          |
|                                                   | rp                        | String | 30d                     | Default data retention duration for Mearsurement                                                                                                                                                                     |
|                                                   | logging                   | String | 14d                     | Default data retention duration for logs                                                                                                                                                                             |
|                                                   | keyevent                  | String | 14d                     | Default data retention duration for events                                                                                                                                                                           |
|                                                   | tracing                   | String | 7d                      | Default data retention duration for traces                                                                                                                                                                           |
|                                                   | rum                       | String | 7d                      | Default data retention duration for RUM                                                                                                                                                                              |
|                                                   | network                   | String | 2d                      | Default data retention duration for network                                                                                                                                                                          |
|                                                   | security                  | String | 90d                     | Default data retention duration for Security Check                                                                                                                                                                   |
|                                                   | backup_log                | String | 180d                    | Default data retention duration for backup logs                                                                                                                                                                      |
| WorkspaceDefaultStatsConfig                       | isOpenLogMultipleIndex    | Boolean | true                    | Whether custom log indexes are enabled when creating a workspace                                                                                                                                                     |
|                                                   | logMultipleIndexCount     | Numeric | 6                       | Number of custom log indexes when creating a workspace                                                                                                                                                               |
|                                                   | loggingCutSize            | Numeric | 6                       | Large log count unit 10KB when creating a workspace                                                                                                                                                                   |
|                                                   | maxSearchResultCount      | Numeric | 0                       | Search result limit 0                                                                                                                                                                                                |
| WorkspaceDefaultesIndexSettings                   | number_of_shards          | Numeric | 1                       | Primary shard count when creating a workspace, effective for ES storage type                                                                                                                                         |
|                                                   | number_of_replicas        | Numeric | 1                       | Whether replicas are enabled when creating a workspace, effective for ES/Doris storage type                                                                                                                          |
|                                                   | rollover_max_size         | Numeric | 30                      | Shard size when creating a workspace, effective for ES/Doris storage type                                                                                                                                            |
|                                                   | hot_retention             | Numeric | 24                      | Hot data duration when creating a workspace, effective for ES/Doris storage type                                                                                                                                 |

### Studio Frontend Site {#studio-front}

#### Configuration File Location

- Namespace: forethought-webclient
- Configuration name in Launcher: frontWeb
- Configmap name in Kubernetes: front-web-config

#### Configuration File Example

```js
window.DEPLOYCONFIG = {
    ...
    "rumDatawayUrl": "https://rum-openway.guance.com",
    "datakitScriptUrl": "https://static.guance.com/datakit",
    "datakitHelmUrl": "https://pubrepo.guance.com",
    "passPublicNetwork": 1,
    "isOverseas": 0,
    "maxTraceSpanLimit": 10000,
    "maxProfileM": 5,
    "paasCustomLoginInfo": [{ "iconUrl":"xxx", "label": "xxx", "url": "xxxx" ,desc:"xxx"}],
    "paasCustomSiteList": [{"url": "xxxx", "label": "xxx"}],
    "paasCustomLoginUrl": "https://www.xxx",
    "maxMessageByte": 10 * 1024,
    "webRumSdkUrl": "https://static.guance.com/browser-sdk/v3/dataflux-rum.js",
    "defaultTimeMap": {
        'log': [1732254771701,1732255671701],// or relative time 5m
    }
    ...
}
```

#### Detailed Configuration Item Descriptions

| Configuration Item                    | Sub-item | Type                | Default Value                              | Description                                                                                                                                                            |
| -------------------------------------- | -------- | ------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| rumDatawayUrl                         |          | String              | "https://rum-openway.guance.com"           | Dedicated DataWay URL for reporting RUM data, displayed on the RUM integration configuration page after configuration.                                                |
| datakitScriptUrl                      |          | String              | "https://static.guance.com/datakit"        | Default download domain for DataKit installation script on the DataKit installation page. Modify this configuration if using internal static resources.                 |
| datakitHelmUrl                        |          | String              | "https://pubrepo.guance.com"               | DataKit Helm image repository address. Modify this configuration if using a self-built image repository.                                                              |
| passPublicNetwork                     |          | Numeric             | 1                                          | Whether the client computer accessing the Studio site has public network access, 0: No, 1: Yes                                                                        |
| isOverseas                            |          | Numeric             | 0                                          | Whether this Guance site is deployed overseas, affecting the display of world map and China map components in RUM.                                                    |
| maxTraceSpanLimit                     |          | Numeric             | 10000                                      | Maximum number of Span entries in the flame graph for traces, default value: 10000                                                                                    |
| maxProfileM                           |          | Numeric             | 5                                          | Maximum MB size for displaying profile flame graphs, default value: 5 if not configured                                                                               |
| paasCustomLoginInfo                   |          | Array               | None                                       | Single sign-on entry configuration for the login page of the Deployment Plan Guance console. New fields include iconUrl and desc for custom icons and descriptions.   |
| paasCustomSiteList                    |          | Array               | None                                       | Multi-site selection configuration for the login page of the Deployment Plan Guance console. label is the site display text, url is the site address.                  |
| rumEnable `self-monitoring`           |          | Boolean             | None                                       | Whether RUM is enabled, 1 indicates enabled. If not enabled, the following configuration values can be empty.                                                        |
| rumDatakitUrl `self-monitoring`       |          | String              | None                                       | Address for RUM DataKit or public openway                                                                                                                              |
| rumApplicationId `self-monitoring`    |          | String              | None                                       | RUM application ID for reporting application data                                                                                                                     |
| rumJsUrl `self-monitoring`            |          | String              | None                                       | RUM SDK CDN address                                                                                                                                                    |
| rumClientToken `self-monitoring`      |          | String              | None                                       | ClientToken for RUM Openway reporting (requires cooperation with `rumOpenwayUrl`), generated on the Guance platform and conflicts with DataKit reporting methods. Higher priority than DataKit reporting.                     |
| rumOpenwayUrl `self-monitoring`       |          | String              | None                                       | Public Openway address for RUM Openway (requires cooperation with `rumClientToken`), used for self-monitoring data reporting from the Studio frontend site.           |
| paasCustomLoginUrl                    |          | String              | None                                       | Custom login URL                                                                                                                                                       |
| maxMessageByte                        |          | String              | None                                       | Maximum byte size for messages in the Viewer list, defaults to 10 * 1024 if not set                                                                                   |
| paasCustomLoginUrl                    |          | String              | None                                       | RUM web SDK CDN address, defaults to https://static.guance.com/browser-sdk/v3/dataflux-rum.js if not set                                                              |
| defaultTimeMap                        |          | String or Object    | None                                       | Default initialization time configuration for the Viewer, format `{'log': '5m'}` or `{'log': [1732254771701,1732255671701]}` object key is fixed string, log viewer is `log`, Security Check is `security`

### Kodo Component {#kodo}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration name in Launcher: Kodo
- Configmap name in Kubernetes: kodo

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
    metric_query_workers: 8 # Time series data worker count, default value is 8
    log_query_workers: 8 # Log data worker count, default value is 8
    ...

...

```

#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item                    | Type   | Default Value               | Description                                                                                                                            |
| ----------- | ----------------------- | ------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| log         | log_file                | String | '/logdata/log'       | Running log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
|             | level                   | String | 'info'               | Minimum running log level                                                                                                                |
|             | gin_log_file            | String | '/logdata/log'       | Gin log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
| database    | db_dialect              | String | 'mysql'              | Database type, default is mysql                                                                                                        |
|             | addr                    | String | 'testsql.com:3306'   | Database connection address                                                                                                                  |
|             | username                | String | ' test_user'         | Username                                                                                                                          |
|             | password                | String | 'test_password'      | Password                                                                                                                            |
|             | network                 | String | 'tcp'                | Connection protocol                                                                                                                        |
|             | db_name                 | String | 'test_db_name'       | Database name                                                                                                                      |
| nsq         | lookupd                 | String | 'testnsq.com:4161'   | NSQ lookupd address                                                                                                                |
|             | discard_expire_interval | Numeric | 5                    | Maximum redundancy time for time series data, in minutes. Default time series metrics data exceeding 5 minutes delay will not be written.                                                    |
| redis       | host                    | String | 'testredis.com:6379' | Redis address for data processing, cluster edition supported. Note: All Kodo-related component Redis configurations must be consistent.                                             |
|             | password                | String | 'test_password'      | Password                                                                                                                            |
|             | db                      | Numeric | 0                    | Redis db value                                                                                                                     |
|             | is_cluster              | Boolean | false                | Set to true when Redis is a cluster and does not support proxy connections.                                                                       |
| asynq_redis | host                    | String | ''                   | Redis address for asynchronous tasks, default uses `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster asynq_redis must be configured. |
|             | password                | String | 'test_password'      | Password                                                                                                                            |
|             | db                      | Numeric | 0                    | Redis db value                                                                                                                     |

### Kodo-inner Component {#kodo-inner}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration name in Launcher: KodoInner
- Configmap name in Kubernetes: kodo-inner

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
    metric_query_workers: 8 # Time series data worker count, default value is 8
    log_query_workers: 8    # Log data worker count, default value is 8
    ...

...

```

#### Detailed Configuration Item Descriptions

| Configuration Item      | Sub-item                        | Type   | Default Value               | Description                                                                                                                            |
| ----------- | --------------------------- | ------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| log         | log_file                    | String | '/logdata/log'       | Running log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
|             | level                       | String | 'info'               | Minimum running log level                                                                                                                |
|             | gin_log_file                | String | '/logdata/log'       | Gin log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
| database    | db_dialect                  | String | 'mysql'              | Database type, default is mysql                                                                                                        |
|             | addr                        | String | 'testsql.com:3306'   | Database connection address                                                                                                                  |
|             | username                | String | ' test_user'         | Username                                                                                                                          |
|             | password                | String | 'test_password'      | Password                                                                                                                            |
|             | network                 | String | 'tcp'                | Connection protocol                                                                                                                        |
|             | db_name                 | String | 'test_db_name'       | Database name                                                                                                                      |
| nsq         | lookupd                     | String | 'testnsq.com:4161'   | NSQ lookupd address                                                                                                                |
|             | discard_expire_interval     | Numeric | 5                    | Maximum redundancy time for time series data, in minutes. Default time series metrics data exceeding 5 minutes delay will not be written.                                                    |
| redis       | host                        | String | 'testredis.com:6379' | Redis address for data processing, cluster edition supported. Note: All Kodo-related component Redis configurations must be consistent.                                             |
|             | password                | String | 'test_password'      | Password                                                                                                                            |
|             | db                      | Numeric | 0                    | Redis db value                                                                                                                     |
|             | is_cluster              | Boolean | false                | Set to true when Redis is a cluster and does not support proxy connections.                                                                       |
| asynq_redis | host                    | String | ''                   | Redis address for asynchronous tasks, default uses `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster asynq_redis must be configured. |
|             | password                | String | 'test_password'      | Password                                                                                                                            |
|             | db                      | Numeric | 0                    | Redis db value                                                                                                                     |
| dql         | metric_query_workers        | Numeric | 32                   | DQL metric data query worker count                                                                                                    |
|             | query_metric_channel_size   | Numeric | 32                   | Request queue size per metric_query_worker                                                                                         |
|             | log_query_workers           | Numeric | 32                   | DQL log text data (logs, traces, RUM, etc.) query worker count                                                                      |
|             | query_log_channel_size      | Numeric | 32                   | Request queue size per log_query_worker                                                                                            |
|             | general_query_workers       | Numeric | 32                   | Non-metric or log query worker count                                                                                             |
|             | query_general_channel_size  | Numeric | 32                   | Request queue size per general_query_worker                                                                                        |
|             | profiling_parse             | Boolean | true                 | Whether DQL queries enable profiling to track the duration of various stages                                                                                   |
| influxdb    | read_timeout                | Numeric | 60                   | Query timeout for time series metrics data, in seconds, default timeout is 60s                                                                  |
|             | dial_timeout                | Numeric | 30                   | Connect timeout for querying time series metrics data, in milliseconds, default connect timeout is 30ms                                                    |
| doris       | read_timeout                | Numeric | 60                   | Query timeout for log text data, in seconds, default timeout is 60s                                                                    |
|             | dial_timeout                | Numeric | 30                   | Connect timeout for querying log text data, in milliseconds, default connect timeout is 30ms                                                      |
| global      | datakit_usage_check_enabled | Boolean | false                | Whether to check if the number of DataKits exceeds the license limit during log queries, default is not checked                                                            |

### Kodo-x Component {#kodo-x}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration name in Launcher: KodoX
- Configmap name in Kubernetes: kodo-x

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
    metric_query_workers: 8 # Time series data worker count, default value is 8
    log_query_workers: 8 # Log data worker count, default value is 8
    ...

pipeline:
    enable: false
    pull_duration: "1m"

...

```

#### Detailed Configuration Item Descriptions

| Configuration Item       | Sub-item                    | Type   | Default Value               | Description                                                                                                                                                                   |
| ------------ | ----------------------- | ------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| log          | log_file                | String | '/logdata/log'       | Running log storage address, optional values include stdout, indicating standard output, not saved to file                                                                                                        |
|              | level                   | String | 'info'               | Minimum running log level                                                                                                                                                       |
|              | gin_log_file            | String | '/logdata/log'       | Gin log storage address, optional values include stdout, indicating standard output, not saved to file                                                                                                        |
| database     | db_dialect              | String | 'mysql'              | Database type, default is mysql                                                                                                                                               |
|              | addr                    | String | 'testsql.com:3306'   | Database connection address                                                                                                                                                         |
|              | username                | String | ' test_user'         | Username                                                                                                                                                                 |
|              | password                | String | 'test_password'      | Password                                                                                                                                                                   |
|              | network                 | String | 'tcp'                | Connection protocol                                                                                                                                                               |
|              | db_name                 | String | 'test_db_name'       | Database name                                                                                                                                                             |
| nsq          | lookupd                 | String | 'testnsq.com:4161'   | NSQ lookupd address                                                                                                                                                       |
|              | discard_expire_interval | Numeric | 5                    | Maximum redundancy time for time series data, in minutes. Default time series metrics data exceeding 5 minutes delay will not be written.                                                                                           |
| redis        | host                    | String | 'testredis.com:6379' | Redis address for data processing, cluster edition supported. Note: All Kodo-related component Redis configurations must be consistent.                                                                                    |
|              | password                | String | 'test_password'      | Password                                                                                                                                                                   |
|              | db                      | Numeric | 0                    | Redis db value                                                                                                                                                            |
|              | is_cluster              | Boolean | false                | Set to true when Redis is a cluster and does not support proxy connections.                                                                                                              |
| asynq_redis  | host                    | String | ''                   | Redis address for asynchronous tasks, default uses `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster asynq_redis must be configured.                                        |
|              | password                | String | 'test_password'      | Password                                                                                                                                                                   |
|              | db                      | Numeric | 0                    | Redis db value                                                                                                                                                            |
| global       | workers                 | Numeric | 8                    | Default worker count for various data processing                                                                                                                                         |
|              | metric_workers          | Numeric | 8                    | Worker count for processing time series metrics data                                                                                                                                         |
|              | log_workers             | Numeric | 8                    | Worker count for processing log data                                                                                                                                             |
|              | tracing_workers         | Numeric | 8                    | Worker count for processing trace data, default uses the value of the log_workers configuration item                                                                                                            |
| influxdb     | read_timeout            | Numeric | 60                   | Query timeout for time series metrics data, in seconds, default timeout is 60s                                                                                                         |
|              | write_timeout           | Numeric | 300                  | Write timeout for time series metrics data, in seconds, default write timeout is 5 min                                                                                                         |
|              | enable_gz               | Boolean | false                | Whether to enable gzip compression for writing data                                                                                                                                             |
|              | dial_timeout            | Numeric | 30                   | Connect timeout for querying time series metrics data, in milliseconds, default connect timeout is 30ms                                                                                           |
| doris        | read_timeout            | Numeric | 60                   | Query timeout for log text data, in seconds, default timeout is 60s                                                                                                           |
|              | write_timeout           | Numeric | 300                  | Write timeout for log text data, in seconds, default write timeout is 5 min                                                                                                           |
|              | gzip_enable             | Boolean | false                | Whether to enable gzip compression for writing data                                                                                                                                             |
|              | dial_timeout            | Numeric | 30                   | Connect timeout for querying log text data, in milliseconds, default connect timeout is 30ms                                                                                             |
| backup_kafka | async                   | Boolean | false                | Whether data forwarding to Kafka uses asynchronous writes, default is synchronous writes                                                                                                                             |
|              | write_timeout           | Numeric | 30                   | Write timeout for Kafka, in seconds, default write timeout is 30s                                                                                                                |
|              | max_bulk_docs           | Numeric | 0                    | Whether multiple logs are written into one Kafka message, default is one log per Kafka message                                                                          |
| pipeline     | enable                  | Boolean | false                | Set to `true` to enable central Pipeline functionality                                                                                                                                   |
|              | pull_duration           | String  | 1m                   | Interval for synchronizing central Pipeline scripts, default value `1m` means every 1 minute, supports `s`, `m`, `h` units, e.g., `1m30s` means every 1 minute and 30 seconds. |

### Kodo-servicemap Component {#kodo-servicemap}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration name in Launcher: kodoServiceMap
- Configmap name in Kubernetes: kodo-servicemap

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
| ----------- | ---- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host | String | ''     | Redis address for data processing, cluster edition supported. Note: All Kodo-related component Redis configurations must be consistent                                             |
| asynq_redis | host | String | ''     | Redis address for asynchronous tasks, default uses `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster asynq_redis must be configured |

### Kodo-x-scan Component {#kodo-x-scan}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration name in Launcher: kodoXScan
- Configmap name in Kubernetes: kodo-x-scan

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
| ----------- | ---- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host | String | ''     | Redis address for data processing, cluster edition supported. Note: All Kodo-related component Redis configurations must be consistent                                             |
| asynq_redis | host | String | ''     | Redis address for asynchronous tasks, default uses `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster asynq_redis must be configured |

### Kodo-ws Component {#kodo-ws}

#### Configuration File Location

- Namespace: forethought-kodo
- Configuration name in Launcher: kodoWS
- Configmap name in Kubernetes: kodo-ws

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
| ----------- | ---- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host | String | ''     | Redis address for data processing, cluster edition supported. Note: All Kodo-related component Redis configurations must be consistent                                             |
| asynq_redis | host | String | ''     | Redis address for asynchronous tasks, default uses `redis` configuration, does not support cluster edition. If `redis` is configured as a cluster, an non-cluster asynq_redis must be configured |