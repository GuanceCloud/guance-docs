## Overview

This document aims to modify relevant configurations through the "Modify Application Configuration" function of launcher, in order to better adapt to your own environment and achieve the purpose of optimizing related configurations and meeting personalized configuration needs.

## Launcher Operation Steps

1. Browser access to the launcher console
2. Select the top right corner to enter the **Modify Application Configuration** interface

![](img/launcher-fix-cfg_1.png)

3. To modify the corresponding configuration file, you need to **check the Modify Configuration** option, which will allow it to be modified.
4. After completing the configuration modification, check the **Automatically Restart Related Services After Modifying Configuration** at the bottom right corner of the page, then click Confirm Modification.

![](img/launcher-fix-cfg_4.jpg)

## Partial Common Service Configuration Instructions

### Studio Backend Service {#studio-backend}

#### Configuration File Location

- Namespace: forethought-core
- Configuration name in Launcher: Core
- Configmap name in Kubernetes: core

#### Configuration File Example

```YAML

# <<< custom_key.brand_name >>> Console address access protocol
protocol: "http"
# <<< custom_key.brand_name >>> Console address
hostname: "console.cloudcare.cn"

# Management backend site access address
managementHostname: "management.cloudcare.cn"

# Current site name
envName: <<< custom_key.brand_name >>> Deployment Plan

# Whether the system is in debug mode, generally not enabled
debug: false
# System default language
defaultLanguage: "zh"

# Frontend access address prefix, the first two curly brackets will be occupied by protocol and hostname, if you need to configure a unified secondary address, you can directly adjust this configuration
frontServerUrlPrefixFormat: "{}://{}"

# ExternalAPI service configuration.
external:
  # The validity period of each request signature, in seconds
  timeliness: 60
  # ak/sk configuration used for interface signing, can set random strings as ak/sk
  accessKey: ""
  secretKey: ""
  # When the system runs in debug mode, the signature string that allows unlimited automatic passing, default has no value
  debugPassSignature: ""

# Fixed notification types for alert strategies
alertPolicyFixedNotifyTypes:
  email:
    enable: true

# Default token expiration time settings
token_exp_set:
  # Web end default setting 4 hours
  front_web: 14400
  # Management backend token default expiration duration
  manage: 7200


# Whether API documentation is enabled, default closed, true indicates enabled. API documentation path defaults to /v1/doc; inner api default address is /v1/inner.doc
apiDocPageSwitch:
  # Management backend
  admin: false
  # Frontend
  front: false
  # inner service
  inner: false
  # openapi service
  openapi: false
  center: false
  # external service
  external: false


# Time offset range for queries in query_view chains, unit in seconds
BusinessQueryViewTimeOffset: 900



# <<< custom_key.brand_name >>> Database Configuration
database:
  connection:
  pool_size: 20
  max_overflow: 100
  echo: false
  pool_timeout: 30
  # This setting causes the pool to recycle connections after the given number of seconds have passed. It defaults to -1, or no timeout. For example, setting it to 3600 means connections will be recycled after one hour. Note that MySQL will automatically disconnect any connection with no activity detected within eight hours (though this can be configured via MySQLDB connection itself and server settings).
  pool_recycle: 3600
  # Boolean value, if True, enables the connection pool “pre ping” feature, which tests the activity of the connection on each checkout
  pool_pre_ping: true
  # Retrieves connections using LIFO (last-in-first-out) QueuePool instead of FIFO (first-in-first-out). Using LIFO reduces the number of connections used during non-peak usage under server-side timeout schemes. When planning server-side timeouts, ensure use of recycling(pool_recycle) or pre-ping(pool_pre_ping) strategies to properly handle outdated connections.
  pool_use_lifo: true


# Logger Configuration
logger:
  filename: /logdata/business.log
  level: info
  # Maximum size of each log file
  max_bytes: 52428800
  # Total number of log file rollovers
  backup_count: 3
  # Controls log output method, by default outputs to both files and stdout
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
  # Controls log output method, by default outputs to both files and stdout
  output_mode_switch:
    file: true
    stdout: true


# Default ultra-large log split size when creating workspaces, unit byte
workspaceLoggingCutSizeSet:
  es: 10240
  sls: 2048
  beaver: 2048
  doris: 10240

# Default data retention policy when creating workspaces
workspaceVersionSet:
  unlimited:
    # Default strategy configuration for creating workspaces under Deployment Plan
    durationSet:
      rp: 30d
      logging: 14d
      keyevent: 14d
      tracing: 7d
      profiling: 7d
      rum: 7d
      # Only Deployment Plan will have separate session_replay configuration
      session_replay: 7d
      network: 2d
      security: 90d
      backup_log: 180d

# Default workspace status settings
WorkspaceDefaultStatsConfig:
  isOpenLogMultipleIndex:  true     # By default, when creating a workspace, custom log indexes are not enabled
  logMultipleIndexCount:  6         # By default, when creating a workspace, custom log index quantity
  loggingCutSize: 10240             # By default, when creating a workspace, ultra-large log count unit is 10KB
  maxSearchResultCount: 0           # By default, when creating a workspace, maximum search result count is 0

# Default ES/Doris index configuration information
WorkspaceDefaultesIndexSettings:
  number_of_shards: 1               # By default, when creating a workspace, primary shard count for ES
  number_of_replicas: 1             # By default, when creating a workspace, whether replica is enabled for ES | Doris
  rollover_max_size: 30             # By default, when creating a workspace, shard size for ES
  hot_retention: 24                 # By default, when creating a workspace, hot data duration for ES | Doris

...

```

#### Detailed Configuration Item Description

| Configuration Item                                          | Sub-item                     | Type   | Default Value                        | Description                                                                                                                                                                                                          |
| ---------------------------------------------------------- | ---------------------------- | ------ | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| protocol                                                   |                              | String | http                                 | <<< custom_key.brand_name >>> Console address access protocol                                                                                                                                                       |
| hostname                                                   |                              | String | console.cloudcare.cn                 | <<< custom_key.brand_name >>> Console address                                                                                                                                                                       |
| managementHostname                                         |                              | String | management.cloudcare.cn              | Management backend site access address                                                                                                                                                                              |
| envName                                                    |                              | String | <<< custom_key.brand_name >>>        | Current site name                                                                                                                                                                                                  |
| debug                                                      |                              | Boolean | false                                | Debug mode switch                                                                                                                                                                                                  |
| frontServerUrlPrefixFormat                                 |                              | String | {}://{}                              | Frontend access address prefix, the first two curly brackets will be occupied by protocol and hostname, if you need to configure a unified secondary address, you can directly adjust this configuration                |
| external                                                   | timeliness                   | Number  | 60                                   | Validity period of each request signature, in seconds                                                                                                                                                               |
|                                                            | accessKey                    | String  |                                      | ak configuration used for interface signing, can set random strings                                                                                                                                                |
|                                                            | secretKey                    | String  |                                      | sk configuration used for interface signing, can set random strings                                                                                                                                                |
|                                                            | debugPassSignature           | String  |                                      | When the system runs in debug mode, the signature string that allows unlimited automatic passing, default has no value                                                                                            |
| defaultLanguage                                            |                              | String  | zh                                   | System default language, if the newly created workspace does not specify a language, it will default to use this configuration value                                                                                 |
| token_exp_set                                              | front_web                    | Number  | 14400                                | Effective duration of user login on Studio browser end, unit: seconds                                                                                                                                              |
|                                                            | manage                       | Number  | 7200                                 | Effective duration of user login on management backend browser end, unit: seconds                                                                                                                                    |
| apiDocPageSwitch                                           | admin                        | Boolean | false                                | Management backend API interface documentation openness switch                                                                                                                                                        |
|                                                            | front                        | Boolean | false                                | Studio backend API interface documentation openness switch                                                                                                                                                           |
|                                                            | inner                        | Boolean | false                                | Inner service API interface documentation openness switch                                                                                                                                                            |
|                                                            | openapi                      | Boolean | false                                | OpenAPI interface documentation openness switch                                                                                                                                                                      |
|                                                            | external                     | Boolean | false                                | External API interface documentation openness switch                                                                                                                                                                 |
| BusinessQueryViewTimeOffset                                |                              | Number  | 900                                  | Time offset range for querying RUM Resource corresponding chain data, unit: seconds                                                                                                                                |
| database                                                   | connection                   | String  |                                      | Database link string                                                                                                                                                                                               |
|                                                            | pool_size                    | Number  | 20                                   | Regular size of single worker connection pool links                                                                                                                                                                |
|                                                            | max_overflow                 | Number  | 100                                  | Maximum overflow number of single worker connection pool links                                                                                                                                                      |
|                                                            | pool_timeout                 | Number  | 30                                   | Database link timeout time, unit: seconds                                                                                                                                                                          |
|                                                            | pool_recycle                 | Number  | 3600                                 | Controls the recycling time of connection pool links, links created will be recycled after the specified time in this value. Unit: seconds. Generally should be used together with pool_pre_ping, pool_use_lifo, and pool_use_lifo should be true. Note that the link recycling mechanism triggers only when the database link is used. |
|                                                            | pool_pre_ping                | Boolean | true                                 | Enables the connection pool “pre ping” feature, which tests the activity of the connection each time it is used                                                                                                     |
|                                                            | pool_use_lifo                | Boolean | true                                 | Retrieves connections using LIFO (last-in-first-out) QueuePool instead of FIFO (first-in-first-out)                                                                                                                 |
| logger                                                     | filename                     | String  | /logdata/business.log                | Log file                                                                                                                                                                                                           |
|                                                            | level                        | String  | info                                 | Minimum log level                                                                                                                                                                                                  |
|                                                            | max_bytes                    | Number  | 52428800                             | Maximum size of each log file, unit: bytes                                                                                                                                                                         |
|                                                            | backup_count                 | Number  | 3                                    | Total number of log file rollovers                                                                                                                                                                                |
|                                                            | output_mode_switch.file      |         | true                                 | Controls log output method switch, supports output to files                                                                                                                                                       |
|                                                            | output_mode_switch.stdout    |         | true                                 | Controls log output method switch, supports output to stdout                                                                                                                                                      |
| g_access_logger                                            |                              |         |                                      | gunicon log configuration, sub-configuration items are the same as logger                                                                                                                                            |
| workspaceLoggingCutSizeSet                                 | es                           | Number  | 10240                                | Default ultra-large log split size when creating workspaces, unit byte, storage type: elasticsearch/OpenSearch                                                                                                    |
|                                                            | sls                          | Number  | 2048                                 | Default ultra-large log split size when creating workspaces, unit byte, storage type: Alibaba Cloud SLS storage                                                                                                   |
|                                                            | beaver                       | Number  | 2048                                 | Default ultra-large log split size when creating workspaces, unit byte, storage type: LogEasy                                                                                                                    |
|                                                            | doris                        | Number  | 10240                                | Default ultra-large log split size when creating workspaces, unit byte, storage type: doris                                                                                                                      |
| WorkspaceDefaultStatsConfig.unlimited.durationSet           |                              | JSON    |                                      | Default data retention duration configuration when creating workspaces                                                                                                                                              |
|                                                            | rp                           | String  | 30d                                  | Default data retention duration for Metrics Sets                                                                                                                                                                   |
|                                                            | logging                      | String  | 14d                                  | Default data retention duration for Logs                                                                                                                                                                           |
|                                                            | keyevent                     | String  | 14d                                  | Default data retention duration for Events                                                                                                                                                                         |
|                                                            | tracing                      | String  | 7d                                   | Default data retention duration for Traces                                                                                                                                                                         |
|                                                            | rum                          | String  | 7d                                   | Default data retention duration for RUM                                                                                                                                                                            |
|                                                            | network                      | String  | 2d                                   | Default data retention duration for Network                                                                                                                                                                        |
|                                                            | security                     | String  | 90d                                  | Default data retention duration for Security Checks                                                                                                                                                                |
|                                                            | backup_log                   | String  | 180d                                 | Default data retention duration for Backup Logs                                                                                                                                                                   |
| WorkspaceDefaultStatsConfig                                | isOpenLogMultipleIndex       | Boolean | true                                 | When creating a workspace, whether custom log indexes are enabled                                                                                                                                                 |
|                                                            | logMultipleIndexCount        | Number  | 6                                    | When creating a workspace, custom log index count                                                                                                                                                                 |
|                                                            | loggingCutSize               | Number  | 6                                    | When creating a workspace, ultra-large log count unit is 10KB                                                                                                                                                     |
|                                                            | maxSearchResultCount         | Number  | 0                                    | Search result limit is 0                                                                                                                                                                                         |
| WorkspaceDefaultesIndexSettings                            | number_of_shards             | Number  | 1                                    | When creating a workspace, primary shard count, effective for storage type ES                                                                                                                                       |
|                                                            | number_of_shards             | Number  | 1                                    | When creating a workspace, primary shard count, effective for storage type ES                                                                                                                                       |
|                                                            | number_of_replicas           | Number  | 1                                    | When creating a workspace, whether replicas are enabled, effective for storage types ES/Doris                                                                                                                        |
|                                                            | rollover_max_size            | Number  | 30                                   | When creating a workspace, shard size, effective for storage types ES/Doris                                                                                                                                         |
|                                                            | hot_retention                | Number  | 24                                   | When creating a workspace, hot data duration, effective for storage types ES/Doris                                                                                                                                 |

### Studio Frontend Site {#studio-front}

#### Configuration File Location

- Namespace: forethought-webclient
- Configuration name in Launcher: frontWeb
- Configmap name in Kubernetes: front-web-config

#### Configuration File Example

```js
window.DEPLOYCONFIG = {
    ...
    "rumDatawayUrl": "https://rum-openway.<<< custom_key.brand_main_domain >>>",
    "datakitScriptUrl": "https://static.<<< custom_key.brand_main_domain >>>/datakit",
    "datakitHelmUrl": "https://pubrepo.<<< custom_key.brand_main_domain >>>",
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
        'log': [1732254771701,1732255671701],// Or relative time 5m
    }
    ...
}

```

#### Detailed Configuration Item Description

| Configuration Item                  | Sub-item | Type            | Default Value                                             | Description                                                                                                                                                                                                                         |
| ---------------------------------- | -------- | --------------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| rumDatawayUrl                      |          | String          | "https://rum-openway.<<< custom_key.brand_main_domain >>>"                   | Dedicated DataWay address used for reporting RUM data, displayed on the RUM integration configuration page after configuration                                                                                                          |
| datakitScriptUrl                   |          | String          | "https://static.<<< custom_key.brand_main_domain >>>/datakit"                | Default installation script download domain for the DataKit installation page, please modify this configuration if using self-built internal static resources                                                                          |
| datakitHelmUrl                     |          | String          | "https://pubrepo.<<< custom_key.brand_main_domain >>>"                        | DataKit Helm image repository address, please modify this configuration if using a self-built image repository                                                                                                                       |
| passPublicNetwork                  |          | Number          | 1                                                       | Configure whether the client computer accessing the Studio site has public network access, 0: No, 1: Yes                                                                                                                          |
| isOverseas                        |          | Number          | 0                                                       | Configure whether this <<< custom_key.brand_name >>> site is deployed overseas, affecting the display of world map and China map components in RUM                                                                                  |
| maxTraceSpanLimit                 |          | Number          | 10000                                                   | Maximum Span count in trace flame graph, default value: 10000                                                                                                                                      |
| maxProfileM                       |          | Number          | 5                                                       | Maximum MB number for profile display flame graph, default value: 5 if not configured                                                                                                               |
| paasCustomLoginInfo                |          | Array           | None                                                    | Single sign-on entry configuration for the login page of the Deployment Plan <<< custom_key.brand_name >>> control console New iconUrl, desc custom fields, iconUrl is the URL of the single sign-on icon, no configuration uses the default icon, desc is the single sign-on description |
| paasCustomSiteList                 |          | Array           | None                                                    | Multi-site selection configuration added to the login page of the Deployment Plan <<< custom_key.brand_name >>> control console label is the site display text, url is the site address, if there is no multi-site, this configuration item can be omitted |
| rumEnable `Self Monitoring`        |          | Boolean         | None                                                    | Whether to enable RUM, 1 means enabled, if not enabled, the following configuration values can be empty                                                                                                                             |
| rumDatakitUrl `Self Monitoring`    |          | String          | None                                                    | RUM DataKit address or public openway address                                                                                                                         |
| rumApplicationId `Self Monitoring`  |          | String          | None                                                    | RUM application ID, used for reporting application data                                                                                                                  |
| rumJsUrl `Self Monitoring`         |          | String          | None                                                    | RUM SDK CDN address                                                                                                                                                   |
| rumClientToken `Self Monitoring`   |          | String          | None                                                    | RUM Openway way to report data (requires cooperation with `rumOpenwayUrl`), conflicts with datakit reporting method generated by <<< custom_key.brand_name >>> platform, higher priority than datakit reporting method |
| rumOpenwayUrl `Self Monitoring`    |          | String          | None                                                    | RUM Openway public address (requires cooperation with `rumClientToken`), used for self-monitoring reporting of Studio frontend site data                                                                                           |
| paasCustomLoginUrl                 |          | String          | None                                                    | Custom login URL                                                                                                                                                      |
| maxMessageByte                     |          | String          | None                                                    | Maximum display byte count for messages in the log viewer list, default is 10 * 1024 if not filled                                                                                                                                |
| webRumSdkUrl                       |          | String          | None                                                    | Rum web SDK CDN address, default is https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v3/dataflux-rum.js if not filled                                                                                             |
| defaultTimeMap                     |          | String or Object | None                                                    | Default initialization time configuration for viewers, format is `{'log': '5m'}` or `{'log': [1732254771701,1732255671701]}` object key is fixed string, log viewer is `log`, security checks are `security` |

### kodo Component {#kodo}

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

#### Detailed Configuration Item Description

| Configuration Item | Sub-item               | Type   | Default Value        | Description                                                                                                                              |
| ------------------ | ---------------------- | ------ | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| log               | log_file               | String | '/logdata/log'       | Runtime logs, storage address, optional values include stdout, indicating standard output, not saved to file                                                           |
|                   | level                 | String | 'info'               | Minimum runtime log level                                                                                                              |
|                   | gin_log_file          | String | '/logdata/log'       | Gin logs, storage address, optional values include stdout, indicating standard output, not saved to file                                                               |
| database          | db_dialect            | String | 'mysql'              | Database type, default is mysql                                                                                                        |
|                   | addr                 | String | 'testsql.com:3306'   | Database connection address                                                                                                             |
|                   | username             | String | ' test_user'         | Username                                                                                                                               |
|                   | password             | String | 'test_password'      | Password                                                                                                                               |
|                   | network              | String | 'tcp'                | Connection protocol                                                                                                                     |
|                   | db_name              | String | 'test_db_name'       | Database name                                                                                                                          |
| nsq               | lookupd              | String | 'testnsq.com:4161'   | nsq lookupd address                                                                                                                    |
|                   | discard_expire_interval | Number | 5                    | Maximum redundancy time for time series data, unit is minutes, default time series metrics data exceeding 5-minute delay will not be written |
| redis             | host                 | String | 'testredis.com:6379' | Redis address used for data processing, cluster version supported. Note: All Redis configurations related to kodo must be consistent         |
|                   | password             | String | 'test_password'      | Password                                                                                                                               |
|                   | db                   | Number | 0                    | redis db value                                                                                                                         |
|                   | is_cluster           | Boolean | false                | When redis is a cluster and proxy connections are unsupported, needs to be set to true                                                  |
| asynq_redis       | host                 | String | ''                   | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster version, if `redis` configuration is cluster version, must configure a non-cluster version of asynq_redis |
|                   | password             | String | 'test_password'      | Password                                                                                                                               |
|                   | db                   | Number | 0                    | redis db value                                                                                                                         |

### kodo-inner Component {#kodo-inner}

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

#### Detailed Configuration Item Description

| Configuration Item | Sub-item                  | Type   | Default Value        | Description                                                                                                                              |
| ------------------ | ------------------------- | ------ | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| log               | log_file                  | String | '/logdata/log'       | Runtime logs, storage address, optional values include stdout, indicating standard output, not saved to file                                                           |
|                   | level                    | String | 'info'               | Minimum runtime log level                                                                                                              |
|                   | gin_log_file             | String | '/logdata/log'       | Gin logs, storage address, optional values include stdout, indicating standard output, not saved to file                                                               |
| database          | db_dialect               | String | 'mysql'              | Database type, default is mysql                                                                                                        |
|                   | addr                     | String | 'testsql.com:3306'   | Database connection address                                                                                                             |
|                   | username                 | String | ' test_user'         | Username                                                                                                                               |
|                   | password                 | String | 'test_password'      | Password                                                                                                                               |
|                   | network                  | String | 'tcp'                | Connection protocol                                                                                                                     |
|                   | db_name                  | String | 'test_db_name'       | Database name                                                                                                                          |
| nsq               | lookupd                  | String | 'testnsq.com:4161'   | nsq lookupd address                                                                                                                    |
|                   | discard_expire_interval  | Number | 5                    | Maximum redundancy time for time series data, unit is minutes, default time series metrics data exceeding 5-minute delay will not be written |
| redis             | host                     | String | 'testredis.com:6379' | Redis address used for data processing, cluster version supported. Note: All Redis configurations related to kodo must be consistent         |
|                   | password                 | String | 'test_password'      | Password                                                                                                                               |
|                   | db                       | Number | 0                    | redis db value                                                                                                                         |
|                   | is_cluster               | Boolean | false                | When redis is a cluster and proxy connections are unsupported, needs to be set to true                                                  |
| asynq_redis       | host                     | String | ''                   | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster version, if `redis` configuration is cluster version, must configure a non-cluster version of asynq_redis |
|                   | password                 | String | 'test_password'      | Password                                                                                                                               |
|                   | db                       | Number | 0                    | redis db value                                                                                                                         |
| dql               | metric_query_workers     | Number | 32                   | DQL metric data query worker count                                                                                                    |
|                   | query_metric_channel_size | Number | 32                   | Request queue size in each metric_query_worker                                                                                        |
|                   | log_query_workers        | Number | 32                   | DQL log text class (log, trace, RUM, etc., all text class data) data query worker count                                              |
|                   | query_log_channel_size   | Number | 32                   | Request queue size in each log_query_worker                                                                                           |
|                   | general_query_workers    | Number | 32                   | Non-metric or log query worker count                                                                                                  |
|                   | query_general_channel_size | Number | 32                   | Request queue size in each general_query_worker                                                                                       |
|                   | profiling_parse          | Boolean | true                 | Whether DQL queries enable indicators, statistics for various stages of query timing                                                   |
| influxdb          | read_timeout             | Number | 60                   | Query time series indicator data, query timeout time, unit is s, i.e., default timeout time is 60s                                    |
|                   | dial_timeout             | Number | 30                   | Query time series indicator data, establish connection timeout time, unit is ms, i.e., default create connection timeout time is 30ms     |
| doris             | read_timeout             | Number | 60                   | Query log data, query timeout time, unit is s, i.e., default timeout time is 60s                                                      |
|                   | dial_timeout             | Number | 30                   | Query log data, establish connection timeout time, unit is ms, i.e., default create connection timeout time is 30ms                     |
| global            | datakit_usage_check_enabled | Boolean | false                | Whether to detect datakit quantity exceeds license restrictions during log queries, default does not detect                            |

### kodo-x Component {#kodo-x}

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

#### Detailed Configuration Item Description

| Configuration Item | Sub-item                  | Type   | Default Value        | Description                                                                                                                                                                   |
| ------------------ | ------------------------- | ------ | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| log               | log_file                  | String | '/logdata/log'       | Runtime logs, storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
|                   | level                    | String | 'info'               | Minimum runtime log level                                                                                                                                                   |
|                   | gin_log_file             | String | '/logdata/log'       | Gin logs, storage address, optional values include stdout, indicating standard output, not saved to file                                                                 |
| database          | db_dialect               | String | 'mysql'              | Database type, default is mysql                                                                                                                                             |
|                   | addr                     | String | 'testsql.com:3306'   | Database connection address                                                                                                                                                  |
|                   | username                 | String | ' test_user'         | Username                                                                                                                                                                    |
|                   | password                 | String | 'test_password'      | Password                                                                                                                                                                    |
|                   | network                  | String | 'tcp'                | Connection protocol                                                                                                                                                          |
|                   | db_name                  | String | 'test_db_name'       | Database name                                                                                                                                                               |
| nsq               | lookupd                  | String | 'testnsq.com:4161'   | nsq lookupd address                                                                                                                                                         |
|                   | discard_expire_interval  | Number | 5                    | Maximum redundancy time for time series data, unit is minutes, default time series metrics data exceeding 5-minute delay will not be written                               |
| redis             | host                     | String | 'testredis.com:6379' | Redis address used for data processing, cluster version supported. Note: All Redis configurations related to kodo must be consistent               |
|                   | password                 | String | 'test_password'      | Password                                                                                                                                                                    |
|                   | db                       | Number | 0                    | redis db value                                                                                                                                                             |
|                   | is_cluster               | Boolean | false                | When redis is a cluster and proxy connections are unsupported, needs to be set to true                                                        |
| asynq_redis       | host                     | String | ''                   | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster version, if `redis` configuration is cluster version, must configure a non-cluster version of asynq_redis |
|                   | password                 | String | 'test_password'      | Password                                                                                                                                                                    |
|                   | db                       | Number | 0                    | redis db value                                                                                                                                                             |
| global            | workers                  | Number | 8                    | Default handling worker count for various data                                                                                                                              |
|                   | metric_workers           | Number | 8                    | Handling worker count for time series indicator data                                                                                                                        |
|                   | log_workers              | Number | 8                    | Handling worker count for log data                                                                                                                                         |
|                   | tracing_workers          | Number | 8                    | Handling worker count for trace data, default uses the value of the log_workers configuration item                                                                        |
| influxdb          | read_timeout            | Number | 60                   | Query timeout time for time series indicator data, unit is s, i.e., default timeout time is 60s                                                                            |
|                   | write_timeout           | Number | 300                  | Write timeout time for time series indicator data, unit is s, i.e., default write timeout time is 5 min                                                                     |
|                   | enable_gz               | Boolean | false                | Whether to enable gzip compression for writing data                                                                                                                         |
|                   | dial_timeout            | Number | 30                   | Establish connection timeout time for querying time series indicator data, unit is ms, i.e., default create connection timeout time is 30ms                                    |
| doris             | read_timeout            | Number | 60                   | Query timeout time for log data, unit is s, i.e., default timeout time is 60s                                                                                             |
|                   | write_timeout           | Number | 300                  | Write timeout time for log data, unit is s, i.e., default write timeout time is 5 min                                                                                     |
|                   | gzip_enable             | Boolean | false                | Whether to enable gzip compression for writing data                                                                                                                         |
|                   | dial_timeout            | Number | 30                   | Establish connection timeout time for querying log data, unit is ms, i.e., default create connection timeout time is 30ms                                                     |
| backup_kafka      | async                   | Boolean | false                | Data forwarding to kafka, write method, default is synchronous write                                                                          |
|                   | write_timeout           | Number | 30                   | Write timeout time for kafka, unit is s, i.e., default write timeout time is 30s                                                             |
|                   | max_bulk_docs           | Number | 0                    | Whether to write multiple logs into one kafka message and send it to kafka, default one log forms one kafka message                                                       |
| pipeline          | enable                 | Boolean | false                | Set to `true` to enable central Pipeline functionality                                                                                         |
|                   | pull_duration          | String | 1m                   | Synchronization interval for central Pipeline scripts, default value `1m` means synchronized every 1 minute, supports `s`, `m`, `h` time interval notation, such as `1m30s` meaning synchronized every 1 minute 30 seconds |

### kodo-servicemap Component {#kodo-servicemap}

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

#### Detailed Configuration Item Description

| Configuration Item | Sub-item | Type   | Default Value | Description                                                                                                                              |
| ------------------ | -------- | ------ | ------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| redis             | host     | String | ''            | Redis address used for data processing, cluster version supported. Note: All Redis configurations related to kodo must be consistent         |
| asynq_redis       | host     | String | ''            | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster version, if `redis` configuration is cluster version, must configure a non-cluster version of asynq_redis |

### kodo-x-scan Component {#kodo-x-scan}

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

#### Detailed Configuration Item Description

| Configuration Item | Sub-item | Type   | Default Value | Description                                                                                                                              |
| ------------------ | -------- | ------ | ------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| redis             | host     | String | ''            | Redis address used for data processing, cluster version supported. Note: All Redis configurations related to kodo must be consistent         |
| asynq_redis       | host     | String | ''            | Redis address used for asynchronous tasks, default uses `redis` configuration, does not support cluster version, if `redis` configuration is cluster version, must configure a non-cluster version of asynq_redis |