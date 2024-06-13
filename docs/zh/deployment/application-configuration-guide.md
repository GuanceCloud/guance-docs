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

### Studio 后端服务

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
  # 各项服务独立配置
  server_custom_set:
    # enable 为 true 时, 以下各个服务的配置将覆盖主配置信息. 对数据库链接数有要求的客户可开启此配置针对性的设置各个服务的链接配置
    enable: false
    front-backend:
      pool_size: 10
      max_overflow: 50
    inner:
      pool_size: 10
      max_overflow: 50
    management-backend:
      pool_size: 5
      max_overflow: 50
    external-api:
      pool_size: 5
      max_overflow: 50
    open-api:
      pool_size: 5
      max_overflow: 50
    core-worker:
      pool_size: 10
      max_overflow: 50
    core-worker-beat:
      pool_size: 5
      max_overflow: 20
    core-worker-correlation:
      pool_size: 10
      max_overflow: 50
    snapshot-server:
      pool_size: 5
      max_overflow: 50


# Logger Configuration
logger:
  filename: /logdata/business.log
  mode: a
  level: info
  # 每个日志文件的最大大小
  max_bytes: 52428800
  # 日志文件滚动的总数量
  backup_count: 3
  delay: true
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
  delay: true
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

| 配置项 | 子项  | 类型  | 默认值 | 描述  |
| --- | --- | --- | --- | --- |
| token_exp_set |  front_web   | 数值 | 14400    | Studio 浏览端用户登录的有效时长，单位：秒    |
|               |  manage   | 数值 | 7200    | 管理后台浏览端用户登录的有效时长，单位：秒    |
| apiDocPageSwitch|  admin   | 布尔 | false    | 管理后台的 API 接口文档开放开关    |
|                 |  front   | 布尔 | false    | Studio 后端 API 接口文档开放开关    |
|                 |  inner   | 布尔 | false    | Inner 服务 API 接口文档开放开关    |
|                 |  openapi   | 布尔 | false    | OpenAPI 接口文档开放开关    |
|                 |  external   | 布尔 | false    | External API 接口文档开放开关  |
| BusinessQueryViewTimeOffset |    | 数值 | 900    | 查询 RUM Resource 对应的链路数据的前后时间偏移范围，单位：秒 |

### Studio 前端站点

#### 配置文件位置

- Namespace：forethought-webclient
- Launcher 中的配置名称：frontWeb
- kubernetes 中的 Configmap 名称：front-web-config

#### 配置文件示例

```json
window.DEPLOYCONFIG = {
    ...
    "rumDatawayUrl": "https://rum-openway.guance.com",
    "datakitScriptUrl": "https://static.guance.com/datakit",
    "datakitHelmUrl": "https://pubrepo.guance.com",
    "passPublicNetwork": 1,
    "isOverseas": 0,
    "maxTraceSpanLimit": 10000
    ...
}

```

#### 配置项详细说明

| 配置项 | 子项  | 类型  | 默认值 | 描述  |
| --- | --- | --- | --- | --- |
| rumDatawayUrl |    | 字符串 | "https://rum-openway.guance.com"    | 用于上报 RUM 数据的专用 DataWay 地址，配置后将显示在 RUM 接入配置页面中 |
| datakitScriptUrl |    | 字符串 | "https://static.guance.com/datakit"    | DataKit 安装页面的默认安装脚本下载域名，如使用自建的内部静态资源，请修改此配置 |
| datakitHelmUrl |    | 字符串 | "https://pubrepo.guance.com"    | DataKit Helm 镜像仓库地址，如使用自建镜像仓库，请修改此配置 |
| passPublicNetwork |    | 数值 | 1    | 配置访问 Studio 站点的客户端计算机是否有公网网络，0：无，1：有 |
| isOverseas |    | 数值 | 0    | 配置此观测云站点是否为海外部署，将影响 RUM 中的世界地图、中国地图组件的显示 |
| maxTraceSpanLimit |    | 数值 | 10000    | 链路的火焰图中最大的 Span 条数，默认值：10000 |

### kodo 组件

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

...

dql:
    metric_query_workers: 8 # 时序数据worker数量，默认值为8
    log_query_workers: 8 # 日志数据worker数量，默认值为8
    ...

...

```

#### 配置项详细说明

| 配置项 | 子项  | 类型  | 默认值 | 描述  |
| --- | --- | --- | --- | --- |
| global |  workers   | 数值 | 8    | 指标数据的处理 worker 数量  |
|        |  log_workers   | 数值 | 8    | 日志数据的处理 worker 数量  |
|        |  tracing_workers   | 数值 | 8    | 链路数据的处理 worker 数量，默认使用 log_workers 配置项的值  |
|  dql   |  metric_query_workers   | 布尔 | false    |  DQL 指标数据查询 worker 数量 |
|        |  log_query_workers   | 布尔 | false    | DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量 |

### kodo-inner 组件

#### 配置文件位置

- Namespace: forethought-kodo
- Launcher 中的配置名称: KodoInner
- kubernetes 中的 Configmap 名称: kodo-inner

#### 配置文件示例

```YAML

...

dql:
    metric_query_workers: 8 # 时序数据worker数量，默认值为8
    log_query_workers: 8    # 日志数据worker数量，默认值为8
    ...

...

```

#### 配置项详细说明

| 配置项 | 子项  | 类型  | 默认值 | 描述  |
| --- | --- | --- | --- | --- |
|  dql   |  metric_query_workers   | 布尔 | false    |  DQL 指标数据查询 worker 数量 |
|        |  log_query_workers   | 布尔 | false    | DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量 |


### kodo-x 组件

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

...

doris:
    dial_timeout: 10
    gzip_enable: false

...

dql:
    metric_query_workers: 8 # 时序数据worker数量，默认值为8
    log_query_workers: 8 # 日志数据worker数量，默认值为8
    ...

...

```

#### 配置项详细说明

| 配置项 | 子项  | 类型  | 默认值 | 描述  |
| --- | --- | --- | --- | --- |
| global |  workers   | 数值 | 8    | 指标数据的处理 worker 数量  |
|        |  log_workers   | 数值 | 8    | 日志数据的处理 worker 数量  |
|        |  tracing_workers   | 数值 | 8    | 链路数据的处理 worker 数量，默认使用 log_workers 配置项的值  |
|  dql   |  metric_query_workers   | 布尔 | false    |  DQL 指标数据查询 worker 数量 |
|        |  log_query_workers   | 布尔 | false    | DQL 日志文本类（日志、链路、RUM 等所有文本类数据）数据查询 worker 数量 |
|  doris |  dial_timeout   | 数值 | 10    |  数据写 Doris 引擎，TCP 连接超时时间，单位：毫秒 |
|        |  gzip_enable   | 布尔 | false    | 数据写 Doris 引擎，是否开启 gzip 压缩 |

