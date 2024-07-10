## 概述

本文档旨在通过 launcher 的“修改应用配置”功能来修改相关配置，为了更好的跟自身环境适配，达到优化相关配置和满足个性化配置的目的。

## launcher 操作步骤

1、浏览器访问 launcher 控制台

2、选择右上角，进入**修改应用配置**界面

![](img/launcher-fix-cfg_1.png)

3、要修改对应的配置文件时，要**勾选修改配置**选项，即可被修改。

4、完成配置修改后，需要勾选页面底部右下角的 **修改配置后自动重启相关服务**，再点击确认修改配置。

![](img/launcher-fix-cfg_4.jpg)

## 服务的部分常用配置说明

### Studio 后端服务 {#studio-backend}

#### 配置文件位置

- Namespace: forethought-core
- Launcher 中的配置名称: Core
- kubernetes 中的 Configmap 名称: core

#### 配置文件示例

```YAML

# 观测云控制台地址访问协议
protocol: "http"
# 观测云控制台地址
hostname: "console.cloudcare.cn"

# 管理后台站点访问地址
managementHostname: "management.cloudcare.cn"

# 系统默认语言
defaultLanguage: "zh"

# Token 默认过期时间设置
token_exp_set:
  # web端默认设置 4小时
  front_web: 14400
  # 管理后台 token 默认过期时长
  manage: 7200


# API 文档是否开启, 默认关闭, 为true时表示开启。API文档路径默认为 /v1/doc; inner api 默认地址为 /v1/inner.doc
apiDocPageSwitch:
  # 管理后台
  admin: false
  # 前台
  front: false
  # inner 服务
  inner: false
  # openapi 服务
  openapi: false
  center: false
  # external 服务
  external: false


# query_view 中链路的时间范围偏移量, 单位为 秒
BusinessQueryViewTimeOffset: 900



# 观测云的数据库配置
database:
  connection:
  pool_size: 20
  max_overflow: 100
  echo: false
  pool_timeout: 30
  # 此设置会导致池在给定的秒数过去后回收连接。它默认为-1，或者没有超时。例如，设置为 3600 表示连接将在一小时后回收。请注意，如果八小时内没有检测到连接上的任何活动，MySQL 将自动断开连接（尽管这可以通过 MySQLDB 连接本身和服务器配置进行配置）。
  pool_recycle: 3600
  # 布尔值，如果为 True，将启用连接池“预 ping”功能，该功能在每次结帐时测试连接的活动性
  pool_pre_ping: true
  # 检索连接时使用 LIFO（后进先出）QueuePool而不是 FIFO（先进先出）。使用 LIFO，服务器端超时方案可以减少非高峰使用期间使用的连接数量。规划服务器端超时时，请确保使用回收(pool_recycle)或预 ping(pool_pre_ping) 策略来妥善处理过时的连接。
  pool_use_lifo: true


# Logger Configuration
logger:
  filename: /logdata/business.log
  level: info
  # 每个日志文件的最大大小
  max_bytes: 52428800
  # 日志文件滚动的总数量
  backup_count: 3
  # 控制日志输出方式, 默认即输出到文件也输出到stdout
  output_mode_switch:
    file: true
    stdout: true

# GunLogger-access, 同上
g_access_logger:
  filename: /logdata/g_access.log
  mode: a
  level: info
  max_bytes: 52428800
  backup_count: 3
  # 控制日志输出方式, 默认即输出到文件也输出到stdout
  output_mode_switch:
    file: true
    stdout: true


# 新建工作空间时, 默认的超大日志拆分单位, 单位byte
workspaceLoggingCutSizeSet:
  es: 10240
  sls: 2048
  beaver: 2048
  doris: 10240

# 新建工作空间时，默认的数据保留策略
workspaceVersionSet:
  unlimited:
    # 部署版新建工作空间的默认策略配置
    durationSet:
      rp: 30d
      logging: 14d
      keyevent: 14d
      tracing: 7d
      rum: 7d
      network: 2d
      security: 90d
      backup_log: 180d

# 工作空间默认状态设置
WorkspaceDefaultStatsConfig:
  isOpenLogMultipleIndex:  true     # 默认创建工作空间, 自定义日志索引不开启
  logMultipleIndexCount:  6         # 默认创建工作空间, 自定义日志索引数量
  loggingCutSize: 10240             # 默认创建工作空间, 超大日志计数单元10KB
  maxSearchResultCount: 0           # 默认创建工作空间, 查询数量上限0

# es/doris索引配置默认信息
WorkspaceDefaultesIndexSettings:
  number_of_shards: 1               # 默认创建工作空间, 主分片数 es
  number_of_replicas: 1             # 默认创建工作空间, 是否开启副本 es | doris
  rollover_max_size: 30             # 默认创建工作空间, 分片大小    es
  hot_retention: 24                 # 默认创建工作空间, 热数据时长   es | doris

...

```

#### 配置项详细说明

| 配置项                                            | 子项                      | 类型   | 默认值                  | 描述                                                                                                                                                                                                          |
| ------------------------------------------------- | ------------------------- | ------ | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| protocol                                          |                           | 字符串 | http                    | 观测云控制台地址访问协议                                                                                                                                                                                      |
| hostname                                          |                           | 字符串 | console.cloudcare.cn    | 观测云控制台地址                                                                                                                                                                                              |
| managementHostname                                |                           | 字符串 | management.cloudcare.cn | 管理后台站点访问地址                                                                                                                                                                                          |
| defaultLanguage                                   |                           | 字符串 | zh                      | 系统默认语言, 新建的工作空间如果未指定语言，则默认使用此配置值                                                                                                                                                |
| token_exp_set                                     | front_web                 | 数值   | 14400                   | Studio 浏览端用户登录的有效时长，单位：秒                                                                                                                                                                     |
|                                                   | manage                    | 数值   | 7200                    | 管理后台浏览端用户登录的有效时长，单位：秒                                                                                                                                                                    |
| apiDocPageSwitch                                  | admin                     | 布尔   | false                   | 管理后台的 API 接口文档开放开关                                                                                                                                                                               |
|                                                   | front                     | 布尔   | false                   | Studio 后端 API 接口文档开放开关                                                                                                                                                                              |
|                                                   | inner                     | 布尔   | false                   | Inner 服务 API 接口文档开放开关                                                                                                                                                                               |
|                                                   | openapi                   | 布尔   | false                   | OpenAPI 接口文档开放开关                                                                                                                                                                                      |
|                                                   | external                  | 布尔   | false                   | External API 接口文档开放开关                                                                                                                                                                                 |
| BusinessQueryViewTimeOffset                       |                           | 数值   | 900                     | 查询 RUM Resource 对应的链路数据的前后时间偏移范围，单位：秒                                                                                                                                                  |
| database                                          | connection                | 字符串 |                         | 数据库链接字符串                                                                                                                                                                                              |
|                                                   | pool_size                 | 数值   | 20                      | 单个 worker 链接池连接数常规大小                                                                                                                                                                              |
|                                                   | max_overflow              | 数值   | 100                     | 单个 worker 连接池链接最大溢出数量                                                                                                                                                                            |
|                                                   | pool_timeout              | 数值   | 30                      | 数据库链接超时时间, 单位：秒                                                                                                                                                                                  |
|                                                   | pool_recycle              | 数值   | 3600                    | 控制连接池链接的回收时间，链接创建之后在该值指定的时间之后会被回收。单位：秒。一般要与 pool_pre_ping、 pool_use_lifo 配合使用，且 pool_use_lifo 应为 true. 注意，链接回收机制是在数据库链接被使用时才会触发。 |
|                                                   | pool_pre_ping             | 布尔   | true                    | 将启用连接池“预 ping”功能，该功能在每次使用时会测试连接的活动性                                                                                                                                               |
|                                                   | pool_use_lifo             | 布尔   | true                    | 检索连接时使用 LIFO（后进先出）QueuePool 而不是 FIFO（先进先出）                                                                                                                                              |
| logger                                            | filename                  | 字符串 | /logdata/business.log   | 日志文件                                                                                                                                                                                                      |
|                                                   | level                     | 字符串 | info                    | 日志最低级别                                                                                                                                                                                                  |
|                                                   | max_bytes                 | 数值   | 52428800                | 每个日志文件的最大大小, 单位：字节                                                                                                                                                                            |
|                                                   | backup_count              | 数值   | 3                       | 日志文件滚动的总数量                                                                                                                                                                                          |
|                                                   | output_mode_switch.file   |        | true                    | 控制日志输出方式开关, 支持输出到文件                                                                                                                                                                          |
|                                                   | output_mode_switch.stdout |        | true                    | 控制日志输出方式开关, 支持输出到 stdout                                                                                                                                                                       |
| g_access_logger                                   |                           |        |                         | gunicon 日志配置，相关子配置项与 logger 相同                                                                                                                                                                  |
| workspaceLoggingCutSizeSet                        | es                        | 数值   | 10240                   | 新建工作空间时, 默认的超大日志拆分单位, 单位 byte，存储类型为: elasticsearch/OpenSearch                                                                                                                       |
|                                                   | sls                       | 数值   | 2048                    | 新建工作空间时, 默认的超大日志拆分单位, 单位 byte，存储类型为: 阿里云中的 SLS 存储                                                                                                                            |
|                                                   | beaver                    | 数值   | 2048                    | 新建工作空间时, 默认的超大日志拆分单位, 单位 byte，存储类型为: 日志易                                                                                                                                         |
|                                                   | doris                     | 数值   | 10240                   | 新建工作空间时, 默认的超大日志拆分单位, 单位 byte，存储类型为: doris                                                                                                                                          |
| WorkspaceDefaultStatsConfig.unlimited.durationSet |                           | json   |                         | 新建工作空间的默认数据保留时长配置                                                                                                                                                                            |
|                                                   | rp                        | 字符串 | 30d                     | 指标集的默认数据保留时长                                                                                                                                                                                      |
|                                                   | logging                   | 字符串 | 14d                     | 日志的默认数据保留时长                                                                                                                                                                                        |
|                                                   | keyevent                  | 字符串 | 14d                     | 事件的默认数据保留时长                                                                                                                                                                                        |
|                                                   | tracing                   | 字符串 | 7d                      | 链路的默认数据保留时长                                                                                                                                                                                        |
|                                                   | rum                       | 字符串 | 7d                      | RUM 的默认数据保留时长                                                                                                                                                                                        |
|                                                   | network                   | 字符串 | 2d                      | 网络的默认数据保留时长                                                                                                                                                                                        |
|                                                   | security                  | 字符串 | 90d                     | 安全巡检的默认数据保留时长                                                                                                                                                                                    |
|                                                   | backup_log                | 字符串 | 180d                    | 备份日志的默认数据保留时长                                                                                                                                                                                    |
| WorkspaceDefaultStatsConfig                       | isOpenLogMultipleIndex    | 布尔   | true                    | 创建工作空间时, 自定义日志索引是否开启                                                                                                                                                                        |
|                                                   | logMultipleIndexCount     | 数值   | 6                       | 创建工作空间时, 自定义日志索引数量                                                                                                                                                                            |
|                                                   | loggingCutSize            | 数值   | 6                       | 创建工作空间时, 超大日志计数单元 10KB                                                                                                                                                                         |
|                                                   | maxSearchResultCount      | 数值   | 0                       | 查询数量上限 0                                                                                                                                                                                                |
| WorkspaceDefaultesIndexSettings                   | number_of_shards          | 数值   | 1                       | 创建工作空间时, 主分片数, 存储类型为 es 时有效                                                                                                                                                                |
|                                                   | number_of_shards          | 数值   | 1                       | 创建工作空间时, 主分片数, 存储类型为 es 时有效                                                                                                                                                                |
|                                                   | number_of_replicas        | 数值   | 1                       | 创建工作空间时, 是否开启副本, 存储类型为 es/doris 时有效                                                                                                                                                      |
|                                                   | rollover_max_size         | 数值   | 30                      | 创建工作空间时, 分片大小, 存储类型为 es/doris 时有效                                                                                                                                                          |
|                                                   | hot_retention             | 数值   | 24                      | 创建工作空间时, 热数据时长, 存储类型为 es/doris 时有效                                                                                                                                                        |

### Studio 前端站点 {#studio-front}

#### 配置文件位置

- Namespace：forethought-webclient
- Launcher 中的配置名称：frontWeb
- kubernetes 中的 Configmap 名称：front-web-config

#### 配置文件示例

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
    "paasCustomLoginUrl": "https://www.xxx"
    ...
}

```

#### 配置项详细说明

| 配置项                    | 子项 | 类型    | 默认值                              | 描述                                                                                                                                             |
| ------------------------- | ---- | ------- | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| rumDatawayUrl             |      | 字符串  | "https://rum-openway.guance.com"    | 用于上报 RUM 数据的专用 DataWay 地址，配置后将显示在 RUM 接入配置页面中                                                                          |
| datakitScriptUrl          |      | 字符串  | "https://static.guance.com/datakit" | DataKit 安装页面的默认安装脚本下载域名，如使用自建的内部静态资源，请修改此配置                                                                   |
| datakitHelmUrl            |      | 字符串  | "https://pubrepo.guance.com"        | DataKit Helm 镜像仓库地址，如使用自建镜像仓库，请修改此配置                                                                                      |
| passPublicNetwork         |      | 数值    | 1                                   | 配置访问 Studio 站点的客户端计算机是否有公网网络，0：无，1：有                                                                                   |
| isOverseas                |      | 数值    | 0                                   | 配置此观测云站点是否为海外部署，将影响 RUM 中的世界地图、中国地图组件的显示                                                                      |
| maxTraceSpanLimit         |      | 数值    | 10000                               | 链路的火焰图中最大的 Span 条数，默认值：10000                                                                                                    |
| maxProfileM               |      | 数值    | 5                                   | 获取 profile 显示火焰图的最大 MB 数,如果不配置，则默认取值: 5                                                                                    |
| paasCustomLoginInfo       |      | 数组    | 无                                  | 部署版观测云控制台登录页面单点登录入口配置 新增 iconUrl, desc 自定义字段, iconUrl 为单点登录图标地址,不配置则为默认 icon desc 为单点登录描述文案 |
| paasCustomSiteList        |      | 数组    | 无                                  | 部署版观测云控制台登录页面新增多站点选择配置 label 为站点显示文案 url 为站点地址,如果不存在多站点，可以不添加此配置项                            |
| rumEnable `自观测`        |      | Boolean | 无                                  | 是否开启 RUM，1 表示开启，如果不开启，以下的配置值可以为空                                                                                       |
| rumDatakitUrl `自观测`    |      | 字符串  | 无                                  | RUM DataKit 的地址 或者 公网 openway 地址                                                                                                        |
| rumApplicationId `自观测` |      | 字符串  | 无                                  | RUM 应用 ID，用于上报应用数据                                                                                                                    |
| rumJsUrl `自观测`         |      | 字符串  | 无                                  | RUM SDk CDN 地址                                                                                                                                 |
| rumClientToken `自观测`   |      | 字符串  | 无                                  | RUM Openway 方式上报数据(需要与 `rumOpenwayUrl` 配合使用)，在观测云平台生成的 clientToken 和 datakit 上报方式冲突，优先级高于 datakit 上报方式   |
| rumOpenwayUrl `自观测`    |      | 字符串  | 无                                  | RUM Openway 公网地址(需要与 `rumClientToken` 配合使用)，用于 Studio 前端站点数据自观测上报                                                       |
| paasCustomLoginUrl        |      | 字符串  | 无                                  | 自定义登录 url                                                                                                                                   |

### kodo 组件 {#kodo}

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: Kodo
- kubernetes 中的 Configmap 名称: kodo

#### 配置文件示例

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
    metric_query_workers: 8 # 时序数据worker数量，默认值为8
    log_query_workers: 8 # 日志数据worker数量，默认值为8
    ...

...

```

#### 配置项详细说明

| 配置项      | 子项                 | 类型   | 默认值 | 描述                                                                                                                            |
| ----------- | -------------------- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| global      | workers              | 数值   | 8      | 指标数据的处理 worker 数量                                                                                                      |
|             | log_workers          | 数值   | 8      | 日志数据的处理 worker 数量                                                                                                      |
|             | tracing_workers      | 数值   | 8      | 链路数据的处理 worker 数量，默认使用 log_workers 配置项的值                                                                     |
| redis       | host                 | 字符串 | ''     | 用于数据处理的 Redis 地址，支持集群版。 注：所有 kodo 相关组件的 Redis 配置必须一致                                             |
| asynq_redis | host                 | 字符串 | ''     | 用于异步任务的 Redis 地址，默认使用 `redis` 配置，不支持集群版，如果 `redis` 配置的是集群版，必须配置一个非集群版的 asynq_redis |
| dql         | metric_query_workers | 布尔   | false  | DQL 指标数据查询 worker 数量                                                                                                    |
|             | log_query_workers    | 布尔   | false  | DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量                                                          |

### kodo-inner 组件 {#kodo-inner}

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: KodoInner
- kubernetes 中的 Configmap 名称: kodo-inner

#### 配置文件示例

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
    metric_query_workers: 8 # 时序数据worker数量，默认值为8
    log_query_workers: 8    # 日志数据worker数量，默认值为8
    ...

...

```

#### 配置项详细说明

| 配置项      | 子项                 | 类型   | 默认值 | 描述                                                                                                                            |
| ----------- | -------------------- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host                 | 字符串 | ''     | 用于数据处理的 Redis 地址，支持集群版。 注：所有 kodo 相关组件的 Redis 配置必须一致                                             |
| asynq_redis | host                 | 字符串 | ''     | 用于异步任务的 Redis 地址，默认使用 `redis` 配置，不支持集群版，如果 `redis` 配置的是集群版，必须配置一个非集群版的 asynq_redis |
| dql         | metric_query_workers | 布尔   | false  | DQL 指标数据查询 worker 数量                                                                                                    |
|             | log_query_workers    | 布尔   | false  | DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量                                                          |

### kodo-x 组件 {#kodo-x}

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: KodoX
- kubernetes 中的 Configmap 名称: kodo-x

#### 配置文件示例

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
    metric_query_workers: 8 # 时序数据worker数量，默认值为8
    log_query_workers: 8 # 日志数据worker数量，默认值为8
    ...

...

```

#### 配置项详细说明

| 配置项      | 子项                 | 类型   | 默认值 | 描述                                                                                                                            |
| ----------- | -------------------- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| global      | workers              | 数值   | 8      | 指标数据的处理 worker 数量                                                                                                      |
|             | log_workers          | 数值   | 8      | 日志数据的处理 worker 数量                                                                                                      |
|             | tracing_workers      | 数值   | 8      | 链路数据的处理 worker 数量，默认使用 log_workers 配置项的值                                                                     |
| redis       | host                 | 字符串 | ''     | 用于数据处理的 Redis 地址，支持集群版。 注：所有 kodo 相关组件的 Redis 配置必须一致                                             |
| asynq_redis | host                 | 字符串 | ''     | 用于异步任务的 Redis 地址，默认使用 `redis` 配置，不支持集群版，如果 `redis` 配置的是集群版，必须配置一个非集群版的 asynq_redis |
| dql         | metric_query_workers | 布尔   | false  | DQL 指标数据查询 worker 数量                                                                                                    |
|             | log_query_workers    | 布尔   | false  | DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量                                                          |
| doris       | dial_timeout         | 数值   | 10     | 数据写 Doris 引擎，TCP 连接超时时间，单位：毫秒                                                                                 |
|             | gzip_enable          | 布尔   | false  | 数据写 Doris 引擎，是否开启 gzip 压缩                                                                                           |

### kodo-servicemap 组件 {#kodo-servicemap}

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: kodoServiceMap
- kubernetes 中的 Configmap 名称: kodo-servicemap

#### 配置文件示例

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

#### 配置项详细说明

| 配置项      | 子项 | 类型   | 默认值 | 描述                                                                                                                            |
| ----------- | ---- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host | 字符串 | ''     | 用于数据处理的 Redis 地址，支持集群版。 注：所有 kodo 相关组件的 Redis 配置必须一致                                             |
| asynq_redis | host | 字符串 | ''     | 用于异步任务的 Redis 地址，默认使用 `redis` 配置，不支持集群版，如果 `redis` 配置的是集群版，必须配置一个非集群版的 asynq_redis |

### kodo-x-scan 组件 {#kodo-x-scan}

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: kodoXScan
- kubernetes 中的 Configmap 名称: kodo-x-scan

#### 配置文件示例

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

#### 配置项详细说明

| 配置项      | 子项 | 类型   | 默认值 | 描述                                                                                                                            |
| ----------- | ---- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host | 字符串 | ''     | 用于数据处理的 Redis 地址，支持集群版。 注：所有 kodo 相关组件的 Redis 配置必须一致                                             |
| asynq_redis | host | 字符串 | ''     | 用于异步任务的 Redis 地址，默认使用 `redis` 配置，不支持集群版，如果 `redis` 配置的是集群版，必须配置一个非集群版的 asynq_redis |

### kodo-ws 组件 {#kodo-ws}

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: kodoWS
- kubernetes 中的 Configmap 名称: kodo-ws

#### 配置文件示例

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

#### 配置项详细说明

| 配置项      | 子项 | 类型   | 默认值 | 描述                                                                                                                            |
| ----------- | ---- | ------ | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| redis       | host | 字符串 | ''     | 用于数据处理的 Redis 地址，支持集群版。 注：所有 kodo 相关组件的 Redis 配置必须一致                                             |
| asynq_redis | host | 字符串 | ''     | 用于异步任务的 Redis 地址，默认使用 `redis` 配置，不支持集群版，如果 `redis` 配置的是集群版，必须配置一个非集群版的 asynq_redis |
