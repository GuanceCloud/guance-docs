## Overview

This document aims to modify relevant configurations through the "Modify Application Configuration" feature of launcher, in order to better adapt to your own environment and achieve the purpose of optimizing related configurations and meeting personalized configuration needs.

## Launcher Operation Steps

1. Access the launcher console via a web browser.
2. Select the top-right corner and enter the **Modify Application Configuration** interface.

![](img/launcher-fix-cfg_1.png)

3. To modify the corresponding configuration file, check the **Modify Configuration** option, which will allow you to make changes.
4. After completing the configuration modifications, select the **Automatically Restart Related Services After Configuration Modification** option at the bottom right of the page, then click Confirm to Modify Configuration.

![](img/launcher-fix-cfg_4.jpg)

## Common Service Configuration Description

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

# Whether the system is in debug mode, generally not enabled
debug: false
# System default language
defaultLanguage: "zh"

# Frontend access address prefix; the first two curly braces are occupied by protocol and hostname. If you need to configure a unified secondary domain, adjust this setting directly.
frontServerUrlPrefixFormat: "{}://{}"

# ExternalAPI service configuration.
external:
  # Validity period for each request signature, in seconds
  timeliness: 60
  # AK/SK configuration used for API signing; can be set as random strings for ak/sk
  accessKey: ""
  secretKey: ""
  # Signature string allowed to pass without restriction when the system is running in debug mode, default is empty
  debugPassSignature: ""

# Alert policy notification methods
alertPolicyFixedNotifyTypes:
  email:
    enable: true

# Default token expiration time settings
token_exp_set:
  # Web end default setting 4 hours
  front_web: 14400
  # Management backend token default expiration duration
  manage: 7200


# API documentation switch, default is closed, set to true to open. Default path for API documentation is /v1/doc; inner api default path is /v1/inner.doc
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


# Time offset for BusinessQueryView traces, in seconds
BusinessQueryViewTimeOffset: 900



# <<< custom_key.brand_name >>> Database Configuration
database:
  connection:
  pool_size: 20
  max_overflow: 100
  echo: false
  pool_timeout: 30
  # This setting causes the pool to recycle connections after the specified number of seconds. It defaults to -1, or no timeout. For example, setting it to 3600 means connections will be recycled after one hour. Note that MySQL automatically disconnects if there is no activity on the connection within eight hours (although this can be configured via MySQLDB connection and server settings).
  pool_recycle: 3600
  # Boolean value, if True, enables the connection pool "pre ping" feature, which tests the activity of the connection upon each checkout
  pool_pre_ping: true
  # Use LIFO (Last In First Out) QueuePool instead of FIFO (First In First Out) when retrieving connections. Using LIFO can reduce the number of connections used during non-peak periods under server-side timeout schemes. When planning server-side timeouts, ensure you use the recycle(pool_recycle) or pre-ping(pool_pre_ping) strategy to properly handle outdated connections.
  pool_use_lifo: true


# Logger Configuration
logger:
  filename: /logdata/business.log
  level: info
  # Maximum size of each log file
  max_bytes: 52428800
  # Total number of rolled-over log files
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
    # Default policy configuration for creating a new workspace under Deployment Plan
    durationSet:
      rp: 30d
      logging: 14d
      keyevent: 14d
      tracing: 7d
      profiling: 7d
      rum: 7d
      # Only the Deployment Plan has a separate session_replay configuration
      session_replay: 7d
      network: 2d
      security: 90d
      backup_log: 180d

# Default workspace status settings
WorkspaceDefaultStatsConfig:
  isOpenLogMultipleIndex:  true     # By default, custom log indexes are not enabled when creating a workspace
  logMultipleIndexCount:  6         # Default custom log index count when creating a workspace
  loggingCutSize: 10240             # Default large log count unit 10KB when creating a workspace
  maxSearchResultCount: 0           # Default query result limit 0 when creating a workspace

# Default ES/Doris index configuration information
WorkspaceDefaultesIndexSettings:
  number_of_shards: 1               # Default primary shard count for ES when creating a workspace
  number_of_replicas: 1             # Default replica count for ES/Doris when creating a workspace
  rollover_max_size: 30             # Default shard size for ES when creating a workspace
  hot_retention: 24                 # Default hot data duration for ES/Doris when creating a workspace

...

```

#### Detailed Configuration Item Description

| Configuration Item                                            | Sub-item                      | Type   | Default Value                        | Description                                                                                                                                                                                                          |
| ------------------------------------------------------------- | ----------------------------- | ------ | ------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| protocol                                                      |                              | String | http                                 | <<< custom_key.brand_name >>> Console Access Protocol                                                                                                                                                               |
| hostname                                                      |                              | String | console.cloudcare.cn                 | <<< custom_key.brand_name >>> Console Address                                                                                                                                                                       |
| managementHostname                                            |                              | String | management.cloudcare.cn              | Management backend site access address                                                                                                                                                                              |
| envName                                                       |                              | String | <<< custom_key.brand_name >>>         | Current site name                                                                                                                                                                                                   |
| debug                                                         |                              | Boolean | false                                | Debug mode switch                                                                                                                                                                                                   |
| frontServerUrlPrefixFormat                                    |                              | String | {}://{}                              | Frontend access address prefix; the first two curly braces are occupied by protocol and hostname. If you need to configure a unified secondary domain, adjust this setting directly.                                  |
| external                                                      | timeliness                    | Number | 60                                   | Validity period for each request signature, in seconds                                                                                                                                                             |
|                                                               | accessKey                     | String |                                      | AK configuration used for API signing; can be set as random strings                                                                                                                                                |
|                                                               | secretKey                     | String |                                      | SK configuration used for API signing; can be set as random strings                                                                                                                                                |
|                                                               | debugPassSignature            | String |                                      | Signature string allowed to pass without restriction when the system is running in debug mode, default is empty                                                                                                     |
| defaultLanguage                                               |                              | String | zh                                   | System default language; if a new workspace does not specify a language, it will default to this configuration                                                                                                      |
| token_exp_set                                                 | front_web                     | Number | 14400                                | Studio frontend user login validity duration, in seconds                                                                                                                                                           |
|                                                               | manage                        | Number | 7200                                 | Management backend user login validity duration, in seconds                                                                                                                                                         |
| apiDocPageSwitch                                              | admin                         | Boolean | false                                | API documentation switch for the management backend                                                                                                                                                                 |
|                                                               | front                         | Boolean | false                                | API documentation switch for the Studio backend                                                                                                                                                                     |
|                                                               | inner                         | Boolean | false                                | API documentation switch for the Inner service                                                                                                                                                                      |
|                                                               | openapi                       | Boolean | false                                | API documentation switch for the OpenAPI service                                                                                                                                                                    |
|                                                               | external                      | Boolean | false                                | API documentation switch for the External service                                                                                                                                                                   |
| BusinessQueryViewTimeOffset                                   |                              | Number | 900                                  | Time offset range for querying RUM Resource trace data, in seconds                                                                                                                                                  |
| database                                                      | connection                    | String  |                                      | Database connection string                                                                                                                                                                                          |
|                                                               | pool_size                     | Number | 20                                   | Normal connection pool size per worker                                                                                                                                                                              |
|                                                               | max_overflow                  | Number | 100                                  | Maximum overflow number of connections in the connection pool per worker                                                                                                                                            |
|                                                               | pool_timeout                  | Number | 30                                   | Database connection timeout, in seconds                                                                                                                                                                             |
|                                                               | pool_recycle                  | Number | 3600                                 | Controls the recycling time of connections in the connection pool. Connections created before this value will be recycled after the specified time. Unit: seconds. Generally used with pool_pre_ping and pool_use_lifo. |
|                                                               | pool_pre_ping                 | Boolean | true                                 | Enables the "pre ping" feature of the connection pool, which tests the activity of the connection upon each use                                                                                                     |
|                                                               | pool_use_lifo                 | Boolean | true                                 | Uses LIFO (Last In First Out) QueuePool instead of FIFO (First In First Out) when retrieving connections                                                                                                           |
| logger                                                        | filename                      | String  | /logdata/business.log                | Log file                                                                                                                                                                                                            |
|                                                               | level                         | String  | info                                 | Minimum log level                                                                                                                                                                                                   |
|                                                               | max_bytes                     | Number  | 52428800                             | Maximum size of each log file, in bytes                                                                                                                                                                             |
|                                                               | backup_count                  | Number  | 3                                    | Total number of rolled-over log files                                                                                                                                                                               |
|                                                               | output_mode_switch.file       |         | true                                 | Controls log output method, supports output to file                                                                                                                                                                 |
|                                                               | output_mode_switch.stdout     |         | true                                 | Controls log output method, supports output to stdout                                                                                                                                                               |
| g_access_logger                                               |                               |         |                                      | Gunicon log configuration, sub-items are the same as logger                                                                                                                                                         |
| workspaceLoggingCutSizeSet                                    | es                            | Number  | 10240                                | Default large log split unit when creating a new workspace, in bytes, storage type: elasticsearch/OpenSearch                                                                                                        |
|                                                               | sls                           | Number  | 2048                                 | Default large log split unit when creating a new workspace, in bytes, storage type: Alibaba Cloud SLS                                                                                                                |
|                                                               | beaver                        | Number  | 2048                                 | Default large log split unit when creating a new workspace, in bytes, storage type: Beaver                                                                                                                           |
|                                                               | doris                         | Number  | 10240                                | Default large log split unit when creating a new workspace, in bytes, storage type: Doris                                                                                                                            |
| WorkspaceDefaultStatsConfig.unlimited.durationSet             |                               | JSON    |                                      | Default data retention duration configuration when creating a new workspace                                                                                                                                         |
|                                                               | rp                            | String  | 30d                                  | Default data retention duration for Metrics                                                                                                                                                                         |
|                                                               | logging                       | String  | 14d                                  | Default data retention duration for Logs                                                                                                                                                                            |
|                                                               | keyevent                      | String  | 14d                                  | Default data retention duration for Events                                                                                                                                                                          |
|                                                               | tracing                       | String  | 7d                                   | Default data retention duration for Traces                                                                                                                                                                          |
|                                                               | rum                           | String  | 7d                                   | Default data retention duration for RUM                                                                                                                                                                             |
|                                                               | network                       | String  | 2d                                   | Default data retention duration for Network                                                                                                                                                                         |
|                                                               | security                      | String  | 90d                                  | Default data retention duration for Security Check                                                                                                                                                                  |
|                                                               | backup_log                    | String  | 180d                                 | Default data retention duration for Backup Logs                                                                                                                                                                     |
| WorkspaceDefaultStatsConfig                                   | isOpenLogMultipleIndex        | Boolean | true                                 | Whether custom log indexes are enabled when creating a workspace                                                                                                                                                     |
|                                                               | logMultipleIndexCount         | Number  | 6                                    | Custom log index count when creating a workspace                                                                                                                                                                     |
|                                                               | loggingCutSize                | Number  | 6                                    | Large log count unit 10KB when creating a workspace                                                                                                                                                                  |
|                                                               | maxSearchResultCount          | Number  | 0                                    | Query result limit 0                                                                                                                                                                                                |
| WorkspaceDefaultesIndexSettings                               | number_of_shards              | Number  | 1                                    | Primary shard count when creating a workspace, effective for storage type ES                                                                                                                                        |
|                                                               | number_of_replicas            | Number  | 1                                    | Replica count when creating a workspace, effective for storage types ES/Doris                                                                                                                                       |
|                                                               | rollover_max_size             | Number  | 30                                   | Shard size when creating a workspace, effective for storage types ES/Doris                                                                                                                                          |
|                                                               | hot_retention                 | Number  | 24                                   | Hot data duration when creating a workspace, effective for storage types ES/Doris                                                                                                                                    |

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
    "datakitScriptUrl": "https://static.<<< custom_key.brand_main_domain >>>/datakit",
    "datakitHelmUrl": "https://pubrepo.guance.com",
    "passPublicNetwork": 1,
    "isOverseas": 0,
    "maxTraceSpanLimit": 10000,
    "maxProfileM": 5,
    "paasCustomLoginInfo": [{ "iconUrl":"xxx", "label": "xxx", "url": "xxxx" ,desc:"xxx"}],
    "paasCustomSiteList": [{"url": "xxxx", "label": "xxx"}],
    "paasCustomLoginUrl": "https://www.xxx",
    "maxMessageByte": 10 * 1024,
    "webRumSdkUrl": "https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js",
    "defaultTimeMap": {
        'log': [1732254771701,1732255671701],// or relative time 5m
    }
    ...
}
```

#### Detailed Configuration Item Description

| Configuration Item                    | Sub-item | Type                | Default Value                                             | Description                                                                                                                                                                    |
| ------------------------------------- | -------- | ------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| rumDatawayUrl                         |          | String              | "https://rum-openway.guance.com"                          | Dedicated DataWay URL for reporting RUM data, displayed on the RUM integration configuration page                                                                              |
| datakitScriptUrl                      |          | String              | "https://static.<<< custom_key.brand_main_domain >>>/datakit" | Default download domain for DataKit installation script. Modify this configuration if using internal static resources                                                          |
| datakitHelmUrl                        |          | String              | "https://pubrepo.guance.com"                              | DataKit Helm repository URL. Modify this configuration if using a self-built image repository                                                                                  |
| passPublicNetwork                     |          | Number              | 1                                                         | Whether the client computer accessing the Studio site has public network access, 0: No, 1: Yes                                                                                 |
| isOverseas                           |          | Number              | 0                                                         | Whether this <<< custom_key.brand_name >>> site is deployed overseas, affecting the display of world map and China map components in RUM                                       |
| maxTraceSpanLimit                    |          | Number              | 10000                                                     | Maximum number of Spans in the flame graph for traces, default value: 10000                                                                      |
| maxProfileM                          |          | Number              | 5                                                         | Maximum MB for displaying profiles in the flame graph. If not configured, the default value is 5                                                                               |
| paasCustomLoginInfo                   |          | Array               | None                                                      | Single sign-on entry configuration for the <<< custom_key.brand_name >>> control panel login page. New fields `iconUrl` and `desc`. `iconUrl` is the single sign-on icon URL, `desc` is the single sign-on description text |
| paasCustomSiteList                    |          | Array               | None                                                      | Multi-site selection configuration for the <<< custom_key.brand_name >>> control panel login page. `label` is the site display text, `url` is the site address. If no multi-sites, this item can be omitted  |
| rumEnable `self-monitoring`           |          | Boolean             | None                                                      | Whether to enable RUM, 1 indicates enabled. If not enabled, the following configuration values can be left blank                                                              |
| rumDatakitUrl `self-monitoring`       |          | String              | None                                                      | RUM DataKit address or public openway address                                                                                                                                  |
| rumApplicationId `self-monitoring`    |          | String              | None                                                      | RUM application ID for reporting application data                                                                                                                              |
| rumJsUrl `self-monitoring`            |          | String              | None                                                      | RUM SDK CDN address                                                                                                                                                            |
| rumClientToken `self-monitoring`      |          | String              | None                                                      | RUM Openway method for reporting data (requires cooperation with `rumOpenwayUrl`). Generated by <<< custom_key.brand_name >>> platform, conflicts with DataKit reporting method, higher priority than DataKit reporting method |
| rumOpenwayUrl `self-monitoring`       |          | String              | None                                                      | RUM Openway public address (requires cooperation with `rumClientToken`), used for self-monitoring data reporting from the Studio frontend site                                 |
| paasCustomLoginUrl                    |          | String              | None                                                      | Custom login URL                                                                                                                                                               |
| maxMessageByte                        |          | String              | None                                                      | Maximum byte count for message display in the log viewer list, defaults to 10 \* 1024                                                                                          |
| webRumSdkUrl                          |          | String              | None                                                      | Rum web SDK CDN address, defaults to https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js                                                                  |
| defaultTimeMap                        |          | String or Object    | None                                                      | Default initialization time configuration for viewers, format `{'log': '5m'}` or `{'log': [1732254771701,1732255671701]}`. Key is fixed string, log viewer is `log`, Security Check is `security` |

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
    metric_query_workers: 8 # Time series data worker count, default value is 8
    log_query_workers: 8 # Log data worker count, default value is 8
    ...

...

```

#### Detailed Configuration Item Description

| Configuration Item      | Sub-item                    | Type   | Default Value               | Description                                                                                                                            |
| ----------------------- | --------------------------- | ------ | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| log                     | log_file                    | String | '/logdata/log'              | Running log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
|                        | level                       | String | 'info'                      | Minimum running log level                                                                                                                |
|                        | gin_log_file                | String | '/logdata/log'              | Gin log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
| database                | db_dialect                  | String | 'mysql'                     | Database type, default is mysql                                                                                                        |
|                        | addr                        | String | 'testsql.com:3306'          | Database connection address                                                                                                                  |
|                        | username                    | String | ' test_user'                | Username                                                                                                                          |
|                        | password                    | String | 'test_password'             | Password                                                                                                                            |
|                        | network                     | String | 'tcp'                       | Connection protocol                                                                                                                        |
|                        | db_name                     | String | 'test_db_name'              | Database name                                                                                                                      |
| nsq                     | lookupd                     | String | 'testnsq.com:4161'          | nsq lookupd address                                                                                                                |
|                        | discard_expire_interval     | Number | 5                           | Maximum redundancy time for time series data, unit is minutes. Default time series indicator data exceeding 5 minutes delay will not be written                                                    |
| redis                   | host                        | String | 'testredis.com:6379'        | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent                                             |
|                        | password                    | String | 'test_password'             | Password                                                                                                                            |
|                        | db                          | Number | 0                           | redis db value                                                                                                                     |
|                        | is_cluster                  | Boolean | false                       | When the Redis cluster does not support proxy connections, set this to true                                                                       |
| asynq_redis             | host                        | String | ''                          | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster edition, if `redis` is configured as a cluster edition, must configure a non-cluster asynq_redis |
|                        | password                    | String | 'test_password'             | Password                                                                                                                            |
|                        | db                          | Number | 0                           | redis db value                                                                                                                     |

### Kodo-Internal Component {#kodo-inner}

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
    metric_query_workers: 8 # Time series data worker count, default value is 8
    log_query_workers: 8    # Log data worker count, default value is 8
    ...

...

```

#### Detailed Configuration Item Description

| Configuration Item      | Sub-item                        | Type   | Default Value               | Description                                                                                                                            |
| ----------------------- | ------------------------------- | ------ | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| log                     | log_file                        | String | '/logdata/log'              | Running log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
|                        | level                           | String | 'info'                      | Minimum running log level                                                                                                                |
|                        | gin_log_file                    | String | '/logdata/log'              | Gin log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
| database                | db_dialect                      | String | 'mysql'                     | Database type, default is mysql                                                                                                        |
|                        | addr                            | String | 'testsql.com:3306'          | Database connection address                                                                                                                  |
|                        | username                        | String | ' test_user'                | Username                                                                                                                          |
|                        | password                        | String | 'test_password'             | Password                                                                                                                            |
|                        | network                         | String | 'tcp'                       | Connection protocol                                                                                                                        |
|                        | db_name                         | String | 'test_db_name'              | Database name                                                                                                                      |
| nsq                     | lookupd                         | String | 'testnsq.com:4161'          | nsq lookupd address                                                                                                                |
|                        | discard_expire_interval         | Number | 5                           | Maximum redundancy time for time series data, unit is minutes. Default time series indicator data exceeding 5 minutes delay will not be written                                                    |
| redis                   | host                            | String | 'testredis.com:6379'        | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent                                             |
|                        | password                        | String | 'test_password'             | Password                                                                                                                            |
|                        | db                              | Number | 0                           | redis db value                                                                                                                     |
|                        | is_cluster                      | Boolean | false                       | When the Redis cluster does not support proxy connections, set this to true                                                                       |
| asynq_redis             | host                            | String | ''                          | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster edition, if `redis` is configured as a cluster edition, must configure a non-cluster asynq_redis |
|                        | password                        | String | 'test_password'             | Password                                                                                                                            |
|                        | db                              | Number | 0                           | redis db value                                                                                                                     |
| dql                     | metric_query_workers            | Number | 32                          | DQL metrics data query worker count                                                                                                    |
|                        | query_metric_channel_size       | Number | 32                          | Request queue size in each metric_query_worker                                                                                         |
|                        | log_query_workers               | Number | 32                          | DQL log text data (logs, traces, RUM, etc.) query worker count                                                                           |
|                        | query_log_channel_size          | Number | 32                          | Request queue size in each log_query_worker                                                                                            |
|                        | general_query_workers           | Number | 32                          | Non-metric or log query worker count                                                                                             |
|                        | query_general_channel_size      | Number | 32                          | Request queue size in each general_query_worker                                                                                        |
|                        | profiling_parse                 | Boolean | true                        | Whether DQL queries enable metrics, statistical query stage timing                                                                 |
| influxdb                | read_timeout                    | Number | 60                          | Timeout for querying time series data, unit is s, default timeout is 60s                                                                  |
|                        | dial_timeout                    | Number | 30                          | Timeout for establishing a connection when querying time series data, unit is ms, default connection creation timeout is 30ms                                                    |
| doris                   | read_timeout                    | Number | 60                          | Timeout for querying log data, unit is s, default timeout is 60s                                                                    |
|                        | dial_timeout                    | Number | 30                          | Timeout for establishing a connection when querying log data, unit is ms, default connection creation timeout is 30ms                                                      |
| global                  | datakit_usage_check_enabled     | Boolean | false                       | Whether to check if the number of datakits exceeds the license limit during log queries, default is not checked                                                            |

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
    metric_query_workers: 8 # Time series data worker count, default value is 8
    log_query_workers: 8 # Log data worker count, default value is 8
    ...

pipeline:
    enable: false
    pull_duration: "1m"

...

```

#### Detailed Configuration Item Description

| Configuration Item       | Sub-item                    | Type   | Default Value               | Description                                                                                                                                                                   |
| ------------------------ | --------------------------- | ------ | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| log                      | log_file                    | String | '/logdata/log'              | Running log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
|                         | level                       | String | 'info'                      | Minimum running log level                                                                                                                                                       |
|                         | gin_log_file                | String | '/logdata/log'              | Gin log storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
| database                 | db_dialect                  | String | 'mysql'                     | Database type, default is mysql                                                                                                                                               |
|                         | addr                        | String | 'testsql.com:3306'          | Database connection address                                                                                                                                                         |
|                         | username                    | String | ' test_user'                | Username                                                                                                                                                                 |
|                         | password                    | String | 'test_password'             | Password                                                                                                                                                                   |
|                         | network                     | String | 'tcp'                       | Connection protocol                                                                                                                                                               |
|                         | db_name                     | String | 'test_db_name'              | Database name                                                                                                                                                             |
| nsq                      | lookupd                     | String | 'testnsq.com:4161'          | nsq lookupd address                                                                                                                                                       |
|                         | discard_expire_interval     | Number | 5                           | Maximum redundancy time for time series data, unit is minutes. Default time series indicator data exceeding 5 minutes delay will not be written                                                                                           |
| redis                    | host                        | String | 'testredis.com:6379'        | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent                                                                                    |
|                         | password                    | String | 'test_password'             | Password                                                                                                                                                                   |
|                         | db                          | Number | 0                           | redis db value                                                                                                                                                            |
|                         | is_cluster                  | Boolean | false                       | When the Redis cluster does not support proxy connections, set this to true                                                                                                              |
| asynq_redis             | host                        | String | ''                          | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster edition, if `redis` is configured as a cluster edition, must configure a non-cluster asynq_redis                                        |
|                         | password                    | String | 'test_password'             | Password                                                                                                                                                                   |
|                         | db                          | Number | 0                           | redis db value                                                                                                                                                            |
| global                   | workers                     | Number | 8                           | Default worker count for various data processing                                                                                                                                         |
|                         | metric_workers              | Number | 8                           | Worker count for processing time series data                                                                                                                                         |
|                         | log_workers                 | Number | 8                           | Worker count for processing log data                                                                                                                                             |
|                         | tracing_workers             | Number | 8                           | Worker count for processing trace data, default uses the value of the `log_workers` configuration item                                                                                                            |
| influxdb                 | read_timeout                | Number | 60                          | Timeout for querying time series data, unit is s, default timeout is 60s                                                                                                         |
|                         | write_timeout               | Number | 300                         | Write timeout for time series data, unit is s, default write timeout is 5 min                                                                                                         |
|                         | enable_gz                   | Boolean | false                       | Whether to enable gzip compression for writing data                                                                                                                                             |
|                         | dial_timeout                | Number | 30                          | Timeout for establishing a connection when querying time series data, unit is ms, default connection creation timeout is 30ms                                                                                           |
| doris                    | read_timeout                | Number | 60                          | Timeout for querying log data, unit is s, default timeout is 60s                                                                                                           |
|                         | write_timeout               | Number | 300                         | Write timeout for log data, unit is s, default write timeout is 5 min                                                                                                           |
|                         | gzip_enable                 | Boolean | false                       | Whether to enable gzip compression for writing data                                                                                                                                             |
|                         | dial_timeout                | Number | 30                          | Timeout for establishing a connection when querying log data, unit is ms, default connection creation timeout is 30ms                                                                                             |
| backup_kafka             | async                       | Boolean | false                       | Data forwarding to Kafka, write method, default is synchronous write                                                                                                                             |
|                         | write_timeout               | Number | 30                          | Write timeout for Kafka, unit is s, default write timeout is 30s                                                                                                                |
|                         | max_bulk_docs               | Number | 0                           | Whether to send multiple logs in one Kafka message, default sends one log per Kafka message                                                                          |
| pipeline                 | enable                      | Boolean | false                       | Set to `true` to enable central Pipeline functionality                                                                                                                                   |
|                         | pull_duration               | String  | 1m                          | Interval for syncing central Pipeline scripts, default value `1m` means every 1 minute sync once, supports `s`, `m`, `h` time interval notation, e.g., `1m30s` means sync every 1 minute 30 seconds |

### Kodo-ServiceMap Component {#kodo-servicemap}

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

#### Detailed Configuration Item Description

| Configuration Item      | Sub-item | Type   | Default Value | Description                                                                                                                            |
| ----------------------- | -------- | ------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| redis                   | host     | String | ''            | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent                                             |
| asynq_redis             | host     | String | ''            | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster edition, if `redis` is configured as a cluster edition, must configure a non-cluster asynq_redis |

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

#### Detailed Configuration Item Description

| Configuration Item      | Sub-item | Type   | Default Value | Description                                                                                                                            |
| ----------------------- | -------- | ------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| redis                   | host     | String | ''            | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent                                             |
| asynq_redis             | host     | String | ''            | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster edition, if `redis` is configured as a cluster edition, must configure a non-cluster asynq_redis |

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

#### Detailed Configuration Item Description

| Configuration Item      | Sub-item | Type   | Default Value | Description                                                                                                                            |
| ----------------------- | -------- | ------ | ------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| redis                   | host     | String | ''            | Redis address used for data processing, supports cluster edition. Note: All Kodo-related component Redis configurations must be consistent                                             |
| asynq_redis             | host     | String | ''            | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster edition, if `redis` is configured as a cluster edition, must configure a non-cluster asynq_redis |

---

## Summary

This document provides an overview of the configuration modification process through the "Modify Application Configuration" feature of launcher. It covers detailed steps and explanations for modifying various configuration items to better adapt to your environment, optimize configurations, and meet personalized needs.

Each section includes:

- **Configuration File Location**: Namespace, Launcher configuration name, and Kubernetes Configmap name.
- **Configuration File Example**: Sample YAML or JavaScript configuration snippets.
- **Detailed Configuration Item Description**: A table explaining each configuration item, its sub-items, type, default value, and description.

By following this guide, you can effectively customize and manage the configurations for different components in your environment, ensuring optimal performance and functionality. 

---

### Key Components Covered

1. **Studio Backend Service**: Describes backend service configurations including protocol settings, database connections, logging, and more.
2. **Studio Frontend Site**: Explains frontend site configurations like RUM DataWay URL, custom login information, and API documentation switches.
3. **Kodo Component**: Details configurations for Redis, DQL workers, and other internal services.
4. **Kodo-Internal Component**: Provides additional details specific to internal components.
5. **Kodo-X Component**: Covers advanced configurations for time series and log data processing.
6. **Kodo-ServiceMap Component**: Focuses on service mapping configurations.
7. **Kodo-X-Scan Component**: Explains scan-related configurations.
8. **Kodo-WS Component**: Describes WebSocket-related configurations.

For further assistance or specific configurations, please refer to the official documentation or contact support.