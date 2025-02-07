# 版本历史

## 1.103.189（2025 年 01 月 16 日） {#1.103.189}

pubrepo.guance.com/dataflux/1.103.189:launcher-d4a5efc-1737455050

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.103.189.tar.gz
    - MD5: `e3c0d6aa1ca3e063575aeb1c7c6cf2da`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.103.189.tar.gz
    - MD5: `1edf1c249834224b0ee2fa49e2280927`

### 功能更新 {#feature0116}

#### 用户访问监测

1. 新增[漏斗分析](../real-user-monitoring/user_insight_funnel.md)功能：用户可以通过定义转换步骤来创建漏斗，查看数据的转化并进行深入分析；
2. 用户洞察模块整合：新增用户洞察模块，将热图和漏斗分析整合在该模块中，提供更全面的用户行为分析工具；
3. 新增移动端 SourceMap 还原：Android 和 iOS 应用支持在页面上传 SourceMap 文件且在错误查看器支持查看还原后数据。

#### 应用性能监测

APM 添加服务时，新增[主机自动注入](../application-performance-monitoring/explorer/auto_wire/autowire_on_host.md)的安装引导方式，简化安装流程。

#### 集成

1. DataKit（数据采集工具）：DataKit 安装页面新增了 Docker 方式的安装引导，提供更多样化的安装选项；
2. 外部数据源优化：在 SLS 数据源查询时，新增了查询规范提示，帮助用户更准确地进行数据查询。


#### 场景

[组合图表](../scene/visual-chart/index.md#conbine)优化：组合图表新增视图变量配置，支持选取当前仪表板中的视图变量作用于该组合图表，帮助更灵活地筛选和分析数据。

#### 监控

突变检测监控器：新增对查询周期的周同比、月同比支持。

#### AI 智能助手

新增 DataFlux Func 相关知识库。

#### Pipeline

自动生成 Pipeline 优化：支持同时以结构化加自然语言的方式交互获取 Pipeline 解析。

### Bug 修复 {#bug0116}

1. 修复了日志堆叠模式中的显示问题；
2. 修复了日志检测监控器函数输入框错位的问题；
3. 修复了指标运算有误的问题；
4. 修复了火山引擎不支持 `having` 语句的问题；
5. 修复了应用性能指标检测中，选择“请求错误率”和“平均每秒请求数”两个指标时报错的问题；
6. 修复了火山引擎底座 `not in` 语句不生效的问题；
7. 修复了事件列表返回的数据过大从而影响页面加载速度的问题；
8. 修复了杭州站点事件一键恢复不满足预期的问题。


## 1.102.188（2025 年 01 月 08 日） {#1.102.188}

pubrepo.guance.com/dataflux/1.102.188:launcher-0bd0be5-1736856269

### 离线镜像包下载

- AMD64 架构下载: https://static.guance.com/dataflux/package/guance-amd64-1.102.188.tar.gz
    - MD5: `07d82df7e9a6ccb4ba747e8cb02d0882`

- ARM64 架构下载: https://static.guance.com/dataflux/package/guance-arm64-1.102.188.tar.gz
    - MD5: `e5ee7933fd1f46ae9df5d05219b4726d`

### 部署版更新 {#deployment0108}

1. 部署工具 `Launcer` 优化：
    - 修复 `工作负载配置` 功能，“资源配置” CPU 核、内存字节 单位错误的问题。
    - 优化 `重启` 工作负载，确认弹窗重复的问题。
2. 管理后台 > 工作空间菜单优化：
    - 工作空间列表新增主存储引擎、业务两个筛选项，支持便捷筛选工作空间；
    - 优化工作空间列表页码返回逻辑，当修改/删除某工作空间，或者修改工作空间的数据上报限制，将停留在当前页，以优化查询体验。
3. 部署版新增参数：`alertPolicyFixedNotifyTypes`，支持配置告警策略中，选择“邮件”通知方式是否显示 [配置参考](/deployment/application-configuration-guide/#studio-backend)。

### OpenAPI 更新 {#openapi0108}

1. 字段管理：支持获取字段管理列表，支持[新增](../../open-api/field-cfg/add.md)/[修改](../../open-api/field-cfg/modify.md)/[删除](../../open-api/field-cfg/delete.md)字段管理。
2. 可用性监测：支持[修改](../../open-api/dialing-task/modify.md)拨测任务。
3. 异常追踪 > 日程：支持获取日程列表，支持[新建](../../open-api/notification-schedule/add.md)/[修改](../../open-api/notification-schedule/modify.md)/[删除](../../open-api/notification-schedule/delete.md)日程。
4. 异常追踪 > 配置管理：支持获取通知策略列表，支持[新增](../../open-api/issue-notification-policy/add.md)/[修改](../../open-api/issue-notification-policy/modify.md)/[删除](../../open-api/issue-notification-policy/delete.md)通知策略；支持获取 Issue 发现列表，支持[新建](../../open-api/issue-auto-discovery/add.md)/[修改](../../open-api/issue-auto-discovery/modify.md)/[启用/禁用](../../open-api/issue-auto-discovery/set-disable.md)/[删除](../../open-api/issue-auto-discovery/delete.md) Issue 发现配置。


### 功能更新 {#feature0108}

#### 日志

1. 日志索引优化：
    - 访问日志内置视图、日志上下文 tab 页时，将分别默认选中当前日志所在的索引、`default` 索引，两处 tab 页均支持索引的多选，同时，在开启了跨工作空间查询，并在所属菜单选取了授权工作空间后，支持在此处直接查询对应工作空间的索引数据。最终帮助用户在一个页面完整查看所关联的日志数据，优化日志查询交互。  
    - 在日志索引列出时，除 `default` 置顶展示之外，其余日志索引按照 A-Z 排序列出。
2. 日志查看器新增堆叠[查看模式](../../logs/manag-explorer.md#mode)：堆叠模式下字段将会整合在同一列， 并且这些字段在单元格内部以行的形式呈现。日志信息的展示更加紧凑和清晰，方便用户快速浏览和分析。
3. 日志 Pipeline 优化：日志 Pipeline 的测试样本调整为获取日志的全部字段，并且需要以行协议格式填入。同时用户手动输入的日志也要遵循格式要求。

#### 场景

1. [表格图](../../scene/visual-chart/table-chart.md)优化：
    - 多指标查询排序支持：当使用一个 DQL 进行多指标查询时，表格图现在支持进行排序。
    - 表格分页选择：新增了表格分页选择功能，用户可以根据数据量和查看需求，选择合适的分页大小。
2. 组合图表：支持调整图表的顺序。
3. 图表优化：调整了 DQL 查询组件的函数顺序，同时特别强调了 Rollup 函数的使用场景，帮助用户更好地利用 Rollup 函数进行数据聚合和分析。

#### 管理

1. 事件支持配置[数据转发](../../management/backup/index.md)：支持配置事件类型的数据转发规则，将符合过滤条件的事件数据保存到观测云的对象存储及转发到外部存储，提供灵活管理事件数据的能力。

2. 工作空间新增 DataKit [环境变量](../../management/env_variable.md)：工作空间支持管理 DataKit 环境变量，用户可以轻松配置和更新环境变量，实现远程同步更新 DataKit 采集配置。

3. 查询[审计事件](../../management/audit-event.md)优化：新增多个字段用于记录查询信息，同时事件内容中补充了查询的时间范围，便于追踪和分析查询行为。

#### Pipeline

自动生成 Pipeline 优化：更改提示出现方式，优化产品体验。

#### AI 智能助手

AI 智能助手新增[生成图表](../../guance-ai/index.md#chart)：生成图表功能基于大模型自动分析用户输入的文本数据，智能生成合适的图表，解决了手动创建图表繁琐、图表选择困难等问题。

#### 监控

[告警策略](../../monitoring/alert-setting.md#member)：按照成员配置通知规则支持追加名称用于用途描述。

### 新增集成 {#inte0108}

1. 新增 [AWS Gateway Classic ELB](../../integrations/aws_elb.md)；
2. 新增[火山引擎 TOS 对象存储](../../integrations/volcengine_tos.md)；
3. 修改 AWS Classic 采集器名称；
4. 新增 [MinIO V3](../../integrations/minio_v3.md)集成；
5. 更新 elasticsearch、solr、nacos、influxdb_v2、mongodb 集成（视图、文档、监控器）；
6. 更新 kubernetes 监控视图。

### Bug 修复 {#bug0108}

1. 解决了事件数据跨空间授权未生效的问题；
2. 解决了日志关联链路跳转到链路查看器携带 `trace_id` 无法查询数据的问题；
3. 解决了视图表达式查询无法进行数值填充的问题；
4. 解决了外部事件检测监控器在变更告警策略时未产生操作审计记录的问题；
5. 解决了事件显示列表的列宽无法调整的问题。
