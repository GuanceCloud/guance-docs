---
icon: zy/release-notes
---

# 更新日志（2025 年）

---

本文档记录{{{ custom_key.brand_name }}}每次上线发布的更新内容说明。

<div class="grid cards" markdown>

- :fontawesome-regular-clipboard:{ .lg .middle }

    ***

    <table>
      <tr>
        <th><a href="https://docs.guance.com/datakit/changelog/" target="_blank">DataKit</a></th>
      </tr>
    </table>

    ***

    <table>
      <tr>
        <th colspan="5">SDK</th>
      </tr>
      <tr>
        <td><a href="https://docs.guance.com/real-user-monitoring/web/sdk-changelog/" target="_blank">Web</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">小程序</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="https://docs.guance.com/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## 2025 年 2 月 19 日

### Breaking Changes {#breakingchanges0219}

[事件](../events/index.md) `df_meta` 内将不再保留 `alert_info` 相关信息记录。此前依赖该信息实现通知对象获取的用户，请切换至使用新增的 `df_alert_info`（事件告警通知）、`df_is_silent`（是否静默）、`df_sent_target_types`（事件通知对象类型）3 个字段来完成相应功能。

可能影响到的功能场景:

1. 通过 OpenAPI 获取事件对接外部系统的自定义使用场景
2. 通过 Webhook 通知对象转发事件到外部系统的自定义使用场景

### 功能更新 {#feature0116}


#### PromQL 查询

新增查询类型：Instant Query，即针对单个时间点进行查询。


#### 监控

监控器配置页面：

1. 触发条件的逻辑匹配中新增 `not between` 选项；
2. 支持直接修改监控器状态（“启用”或“禁用”）。


#### 应用性能监测

链路：详情页新增[服务上下文](../application-performance-monitoring/explorer/explorer-analysis.md#context) tab 页。


#### 事件

事件详情页：新增支持绑定[内置视图](../events/event-explorer/event-details.md#inner_view)；


#### 异常追踪

1. Issue 新增 [`working`、`closed` 状态](../exception/issue.md#concepts)；  
2. 针对 `open` 状态停留超时和未指定负责人和处理超时的情况，[Issue 升级](../exception/config-manag/strategy.md#upgrade)新增重复通知配置；  
3. 调整 Issue 系统评论、频道通知的 UI 显示；
4. 分析看板：新增时间控件。


#### 场景

1. [图表链接](../scene/visual-chart/chart-link.md)：新增“查看主机监控视图”，默认关闭。
2. 查看器：支持删除固定 `name` 列，用户可自定义列表显示。
3. 云账单分析视图：支持查看账单详情。

#### 管理

[角色管理](../management/role-list.md)：Session Replay 查看、审计事件新增自定义添加查看权限能力。

#### 指标

生成指标：指标名输入不再支持使用 `-` 中划线。

#### 集成

集成卡片新增描述信息。

### 部署版更新 {#deployment0219}

1. 模板管理：支持上传基础设施查看器模板；
2. 索引配置：弃用“备份日志”项；可在“编辑工作空间 > 数据存储策略 > 数据转发-默认存储”处配置对应存储策略。

### 新增集成 {#inte0219}

- 新增 [Milvus](../integrations/milvus.md)；
- 新增 [火山云公网 IP](../integrations/volcengine_eip.md)；
- 新增 [opentelemetry-python](../integrations/opentelemetry-python.md)；
- 新增 [openLIT 集成](../integrations/openlit.md)；
- 更新 k8s\es\mongodb\rabbitmq\oracle\coredns\sqlserver 中英文监控器&视图。

### Bug 修复 {#bug0219}

1. 修复了 AI 聚合通知消息中特殊字符引起结果异常的问题；
2. 修复了 Servicemap 部署版适配的问题；
3. 修复了组合图表无法配置已隐藏的视图变量的问题；
4. 修复了异常追踪 > 分析看板的"未恢复问题列表"显示错乱的问题；
5. 修复了用户访问监测分析看板中最受欢迎页面的 P75 结果和 DQL 查询结果不一致的问题；
6. 修复了用户访问监测 > 查看器搜索框异常的问题；
7. 修复了场景 > 对象映射中，使用资源目录进行字段映射，看板中同一字段只有部分生效的问题；
8. 修复了监控器 > 事件内容 UI 显示的问题；
9. 修复了事件查看器未恢复事件快捷筛选结果不满足预期的问题。

## 2025 年 1 月 16 日

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

## 2025 年 1 月 8 日

### OpenAPI 更新 {#openapi0108}

1. 字段管理：支持获取字段管理列表，支持[新增](../open-api/field-cfg/add.md)/[修改](../open-api/field-cfg/modify.md)/[删除](../open-api/field-cfg/delete.md)字段管理。
2. 可用性监测：支持[修改](../open-api/dialing-task/modify.md)拨测任务。
3. 异常追踪 > 日程：支持获取日程列表，支持[新建](../open-api/notification-schedule/add.md)/[修改](../open-api/notification-schedule/modify.md)/[删除](../open-api/notification-schedule/delete.md)日程。
4. 异常追踪 > 配置管理：支持获取通知策略列表，支持[新增](../open-api/issue-notification-policy/add.md)/[修改](../open-api/issue-notification-policy/modify.md)/[删除](../open-api/issue-notification-policy/delete.md)通知策略；支持获取 Issue 发现列表，支持[新建](../open-api/issue-auto-discovery/add.md)/[修改](../open-api/issue-auto-discovery/modify.md)/[启用/禁用](../open-api/issue-auto-discovery/set-disable.md)/[删除](../open-api/issue-auto-discovery/delete.md) Issue 发现配置。


### 功能更新 {#feature0108}

#### 日志

1. 日志索引优化：
    - 访问日志内置视图、日志上下文 tab 页时，将分别默认选中当前日志所在的索引、`default` 索引，两处 tab 页均支持索引的多选，同时，在开启了跨工作空间查询，并在所属菜单选取了授权工作空间后，支持在此处直接查询对应工作空间的索引数据。最终帮助用户在一个页面完整查看所关联的日志数据，优化日志查询交互。  
    - 在日志索引列出时，除 `default` 置顶展示之外，其余日志索引按照 A-Z 排序列出。
2. 日志查看器新增堆叠[查看模式](../logs/manag-explorer.md#mode)：堆叠模式下字段将会整合在同一列， 并且这些字段在单元格内部以行的形式呈现。日志信息的展示更加紧凑和清晰，方便用户快速浏览和分析。
3. 日志 Pipeline 优化：日志 Pipeline 的测试样本调整为获取日志的全部字段，并且需要以行协议格式填入。同时用户手动输入的日志也要遵循格式要求。

#### 场景

1. [表格图](../scene/visual-chart/table-chart.md)优化：
    - 多指标查询排序支持：当使用一个 DQL 进行多指标查询时，表格图现在支持进行排序。
    - 表格分页选择：新增了表格分页选择功能，用户可以根据数据量和查看需求，选择合适的分页大小。
2. 组合图表：支持调整图表的顺序。
3. 图表优化：调整了 DQL 查询组件的函数顺序，同时特别强调了 Rollup 函数的使用场景，帮助用户更好地利用 Rollup 函数进行数据聚合和分析。

#### 管理

1. 事件支持配置[数据转发](../management/backup/index.md)：支持配置事件类型的数据转发规则，将符合过滤条件的事件数据保存到{{{ custom_key.brand_name }}}的对象存储及转发到外部存储，提供灵活管理事件数据的能力。

2. 工作空间新增 DataKit [环境变量](../management/env_variable.md)：工作空间支持管理 DataKit 环境变量，用户可以轻松配置和更新环境变量，实现远程同步更新 DataKit 采集配置。

3. 查询[审计事件](../management/audit-event.md)优化：新增多个字段用于记录查询信息，同时事件内容中补充了查询的时间范围，便于追踪和分析查询行为。

#### Pipeline

自动生成 Pipeline 优化：更改提示出现方式，优化产品体验。

#### AI 智能助手

AI 智能助手新增[生成图表](../guance-ai/index.md#chart)：生成图表功能基于大模型自动分析用户输入的文本数据，智能生成合适的图表，解决了手动创建图表繁琐、图表选择困难等问题。

#### 监控

[告警策略](../monitoring/alert-setting.md#member)：按照成员配置通知规则支持追加名称用于用途描述。

### 部署版更新 {#deployment0108}

1. 管理后台 > 工作空间菜单优化：
    - 工作空间列表新增主存储引擎、业务两个筛选项，支持便捷筛选工作空间；
    - 优化工作空间列表页码返回逻辑，当修改/删除某工作空间，或者修改工作空间的数据上报限制，将停留在当前页，以优化查询体验。
2. 部署版新增参数：`alertPolicyFixedNotifyTypes`，支持配置告警策略中，选择“邮件”通知方式是否显示 [配置参考](/deployment/application-configuration-guide/#studio-backend)。

### 新增集成 {#inte0108}

1. 新增 [AWS Gateway Classic ELB](../integrations/aws_elb.md)；
2. 新增[火山引擎 TOS 对象存储](../integrations/volcengine_tos.md)；
3. 修改 AWS Classic 采集器名称；
4. 新增 [MinIO V3](../integrations/minio_v3.md)集成；
5. 更新 elasticsearch、solr、nacos、influxdb_v2、mongodb 集成（视图、文档、监控器）；
6. 更新 kubernetes 监控视图。

### Bug 修复 {#bug0108}

1. 解决了事件数据跨空间授权未生效的问题；
2. 解决了日志关联链路跳转到链路查看器携带 `trace_id` 无法查询数据的问题；
3. 解决了视图表达式查询无法进行数值填充的问题；
4. 解决了外部事件检测监控器在变更告警策略时未产生操作审计记录的问题；
5. 解决了事件显示列表的列宽无法调整的问题。