---
icon: zy/release-notes
---

# 更新日志（2025 年）

---

本文档记录<<< custom_key.brand_name >>>每次上线发布的更新内容说明。

<div class="grid cards" markdown>

- :fontawesome-regular-clipboard:{ .lg .middle }

    ***

    <table>
      <tr>
        <th><a href="<<< homepage >>>/datakit/changelog-2025/" target="_blank">DataKit</a></th>
      </tr>
    </table>

    ***

    <table>
      <tr>
        <th colspan="5">SDK</th>
      </tr>
      <tr>
        <td><a href="<<< homepage >>>/real-user-monitoring/web/sdk-changelog/" target="_blank">Web</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/miniapp/sdk-changelog/" target="_blank">小程序</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/android/sdk-changelog/" target="_blank">Android</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/ios/sdk-changelog/" target="_blank">iOS</a></td>
        <td><a href="<<< homepage >>>/real-user-monitoring/react-native/sdk-changelog/" target="_blank">React Native</a></td>
      </tr>
    </table>

</div>

## 2025 年 4 月 9 日 {#20250409}

### OpenAPI 更新 {#openapi0409}

1. 支持创建、编辑、删除多步拨测任务；
2. 支持配置工作空间数量上限限制。

### 功能更新 {#feature0409}

#### 场景

1. 图表优化    
    - 柱状图：
        - 调整[别名](../scene/visual-chart/chart-config.md#alias)位置，支持列出所有指标和分组；
        - 新增 X 轴配置项。
    - 分组[表格图](../scene/visual-chart/table-chart.md)：
        - 支持基于分组选择排序；
        - 返回数量下拉中新增 200 选项，支持手动输入最大数量调整为 1,000。
    - 时序图 > [折线图](../scene/visual-chart/timeseries-chart.md#line-chart)：新增线条“风格”设置，包括线性、平滑、前阶梯、后阶梯。
2. 快照：针对配置权限的[仪表板快照](../getting-started/function-details/share-snapshot.md#sharing-method)分享新增权限提示。
3. 查看器、仪表板 > 时间控件：新增“最近 1 分钟”、“最近 5 分钟”，默认选中后者。

#### 管理

- [跨工作空间授权](../management/data-authorization.md)：支持跨站点进行数据授权，实现扩展数据共享。
- 数据转发：
    - 数据类型新增“审计事件”。
    - 调整查看器的查询时间逻辑：
        - 更改为按天查询，不支持跨天查询；
        - 查看转发数据时，系统自动查询并持续加载直至完整显示，无需用户手动点击；
        - 管理 > 空间设置 > 高级设置：新增[“数据转发查询时长”](../management/backup/index.md#query_time_change)配置。
- 数据访问、Pipeline、黑名单权限拆分，将“管理”权限调整为：“新建、编辑”和“删除”。

#### 监控

1. 系统通知：新增关联日志的跳转链接，允许跳转到日志查看器并筛选出此通知对象发送失败的日志。
2. 监控器：
    - 从模版新建 > 官方模版库：新增搜索功能；
    - 配置页面 > [事件内容](../monitoring/monitor/monitor-rule.md#content)：更新注意提示。仅当启用关联异常追踪时，`@ 成员`配置才会生效并向指定成员发送此处的事件内容。
    - 阈值检测：新增[恢复条件](../monitoring/monitor/threshold-detection.md#recover-conditions)开关，配置恢复条件及严重程度，当查询结果为多个值时，任意一值满足触发条件则产生恢复事件。

#### 异常追踪

Issue 邮件通知中的“来源”修改为超链接，用户点击后可以直接访问。

#### RUM

SourceMap：

- 页面交互调整，由原来的弹窗改为单独页面；
- 列表页面新增搜索、导出功能。


#### AI 智能助手

优化[生成图表](../guance-ai/index.md#chart)功能：通过本地 Func 缓存指标管理数据，生成的 DQL 更加贴近语义描述。

#### [AI 错误分析](../logs/explorer-details.md#ai)

添加上下文支持根因分析，帮助用户更快、更全面理解错误发生的上下文，提高诊断效率。


#### 集成 > 扩展

DataFlux Func 托管版/ RUM Headless：应用扣费新增邮件提醒和系统通知。

#### 基础设施

主机 > 详情页：磁盘容量统计区分本地磁盘和远端磁盘显示。

### 部署版更新 {#deployment0409}

模版管理：

- 页面交互优化，包含显示列新增“模版类型”等；
- 顶部筛选项新增“模版类型”；
- 支持批量导出模版；
- 导入模版时，支持预览查看模版详情；
- 内置视图、Pipeline、监控器模板上传支持同名覆盖逻辑。

### 新增集成 {#inte0409}

1. 新增 [GCP Compute Engine](../integrations/gcp_ce.md)；
2. 新增 [Azure Storage](../integrations/azure_storage.md)；
3. 新增 [Azure redis cache](../integrations/azure_redis_cache.md)；
4. 新增 [Azure kubernetes](../integrations/azure_kubernetes.md)；
5. 新增 [Azure Postgresql](../integrations/azure_postgresql.md)；
6. 新增 阿里云 Rds MYSQL Automata 集成；
7. 新增 [Druid](../integrations/druid.md) 集成
8. 更新 [Trino](../integrations/trino.md)；
9. 调整 AWS/阿里云关于 Automata 的集成文档：新增`托管版开通脚本`步骤。

### Bug 修复 {#bug0409}

1. 修复了调用 OpenAPI 获取未恢复事件与实际不符的问题。
2. 修复了事件查看器在搜索时报错的问题。
3. 修复了外接数据源数据查询异常的问题。
4. 修复了异常追踪邮件通知的相关问题。
5. 修复了异常追踪 > 分析看板加载缓慢的问题。
6. 修复了柱状图显示颜色不正确的问题。
7. 修复了外部事件提示没有 AK 的问题。
8. 修复了状态分布图、日志量没有正确显示的问题。



## 2025 年 3 月 26 日 {#20250326}



### 功能更新 {#feature0326}


#### 事件

1. [未恢复事件](../events/event-explorer/unrecovered-events.md)：时间控件默认自动刷新，手动恢复事件恢复成功后新增前端页面提示。
2. [事件详情](../events/event-explorer/event-details.md)：告警通知页面显示优化。
3. 事件、智能监控查看器导出追加“是否通知”显示。

#### 管理

[数据转发](../management/backup/index.md#permission)：新增权限配置。通过为转发的数据设置查看权限，有效提高数据安全性。

#### 监控

1. [基础设施存活检测 V2](../monitoring/monitor/infrastructure-detection.md)：新增可配置检测区间。
2. 告警策略：通知匹配逻辑调整，提升事件在命中多组策略及复杂告警策略场景下的执行效率。
3. 通知对象管理：新增 [Slack](../monitoring/notify-target-slack.md) 和 [Teams](../monitoring/notify-target-teams.md) 两个通知对象，以满足全球更多用户的需求。

#### 场景

1. 视图变量：支持外部数据源查询。
2. 图表：
    
    - 新增“[监控器总览](../scene/visual-chart/monitor_summary.md)”图表，集成监控器列表，展示最新状态，实现即时监测与异常态势感知。
    - 命令面板：显示优化；
    - 图表查询：在 DQL 查询中，使用 “wildcard” 或“正则”时，新增查询建议提示。
3. 查看器、仪表板 > 时间控件:新增“最近 1 分钟”和“最近 5 分钟”选项。

#### 付费计划与账单

1. 新增[月账单](../billing/index.md#monthly_bill)模块，直观展示月消费总量。
2. 新增导出账单功能。

#### 用户访问监测

应用列表 > 新建应用：新增“压缩上传”和“自定义托管地址”的参数配置。

#### 可用性监测

新增“南非”和“中国香港”作为拨测节点，进一步扩展全球覆盖范围。

#### 日志

1. [日志查看器](../logs/explorer.md)
    - 快捷筛选操作项调整；
    - 列表分词逻辑优化；
    - JSON 格式数据新增 “[JSON 搜索](../logs/explorer-details.md#json)”；
2. 索引 > 关键字段：新增“[一键获取](../logs/multi-index/index.md#extract)”。


### 新增集成 {#inte0326}

- 新增 [Azure Network Interfaces](../integrations/azure_network_interfaces.md)；
- 新增 [Azure Kubernetes](../integrations/azure_kubernetes.md)；
- 新增 [Azure virtual network gateway](../integrations/azure_virtual_network_gateway.md)；
- 完善英文集成翻译。

### Bug 修复 {#bug0326}

1. 修复了日志页面展示利用率不高的问题。
2. 修复了 Service Map 的指标单位显示问题。
3. 修复了表格图多列无法选择单位的问题。
4. 修复了仪表板 > 日志流图导出 CSV 时，选择 1,000 以外的导出条数会报错的问题。
5. 修复了最受欢迎页面的 P75 和 DQL 查询结果不一致的问题。
6. 修复了时间筛选器点击 `<<` 按钮后时间框仍然显示今日的问题。
7. 修复了菜单管理不符合预期的问题。
8. 修复了管理后台中搜索空间 ID 筛选异常的问题。
9. 修复了 Pipeline 界面测试样本丢失的问题。
10. 修复了配置迁移导出功能耗时过长的问题。
11. 修复了升级后事件详情界面快捷筛选标签有大量空项的问题。
12. 修复了监控器官方模板库检测库列表重复，且一旦选中检测库就无法搜索其他监控器的问题。

## 2025 年 3 月 12 日 {#20250312}

### Breaking Changes {#breakingchanges0312}

[事件](../events/index.md) `df_alert_info` 字段定义调整，新增告警策略未匹配原因说明，仍然需要通过 `isIgnored` 做过滤判断获取实际对外发送的通知对象。


### 功能更新 {#feature0312}

#### 异常追踪

1. 新增[异常追踪管理](../management/index.md#personal_incidents)入口，通过该入口，当前登录用户可以查看和管理所有已加入工作空间的异常追踪状态。
2. 优化异常追踪页面[频道列表](../exception/channel.md#list)显示，提升频道过多时的查询效率。

#### 管理

1. [云账号管理](../management/cloud-account-manag.md#alibaba)：新增阿里云云账号授权类型。
2. [API Key 管理](../management/api-key/index.md)：新增对 API Key 的权限控制功能，支持添加角色授权。通过角色授权，API Key 仅具备角色范围内的操作权限，从而有效降低安全风险。
3. 数据转发：默认交互变更为不选中规则。

#### AI 错误分析

以下详情页新增 [AI 错误分析](../logs/explorer-details.md#ai)能力：

- error 日志
- APM > 链路/错误追踪

#### 场景

1. 定时报告：

    - 新增 Webhook 发送作为通知方式；
    - 支持将仪表板图片分享到企业微信/钉钉。

2. 时序图：选择面积图作为图表类型后，新增[堆叠模式](../scene/visual-chart/timeseries-chart.md#style)风格，便于观察整体数据的累积效果。

#### APM

链路：支持列表批量导出 JSONL 格式。

#### RUM

用户洞察 > [漏斗分析](../real-user-monitoring/user_insight_funnel.md)：对于查询到的 Session 列表支持会话重放功能。


#### 日志

1. 查看器：    
    - 日志查看器 > 索引快捷筛选在搜索栏列出显示效果优化； 
    - 日志详情 > 扩展字段：新增“进行维度分析”模式；         
2. 索引：在索引的维度下支持设置专属[关键字段](../logs/multi-index/index.md#key_key)。

#### 查看器时间控件

左侧选择时间范围与右侧刷新频率各自独立。仅两种情况会影响刷新频率：  

- 所选时间范围超过 1h       
- 所选时间是绝对时间     


#### 基础设施

主机：查看器支持调整时间范围。
   
#### Pipeline

1. 配置页面显示优化；
2. Pipeline 处理类型新增“事件”；
3. 测试样本支持获取 JSON 格式。
4. 过滤条件 > 可用性监测：支持选择多步拨测。

### 部署版更新 {#deployment0312}

[模板管理](../deployment/integration.md)：支持上传所有查看器模板。

### 新增集成 {#inte0312}

1. 新增 [azure_load_balancer](../integrations/azure_load_balancer.md)；
2. 重写 [K8S server api](../integrations/kubernetes-api-server.md)；
3. 更新 [Gitlab CI](../integrations/gitlab.md)；
4. 翻译 Volcengine 相关视图；
5. 翻译 AWS 相关视图。

### Bug 修复 {#bug0312}

1. 修复了日志流图导出到 CSV 无反应的问题。
2. 修复了 `ddtrace` 采集的 JVM 指标视图变量为 `runtime-id` 字段时，时序图添加相关筛选后无数据的问题。
3. 修复了自定义渐变区间色阶界面显示的问题。
4. 修复了时序图编辑 DQL 查询时，过滤条件选择 >0 后保存，再次编辑时显示为空的问题。
5. 修复了应用性能监测 > 基础设施表格图显示异常的问题。
6. 修复了管理后台设置数据转发存储时长为 1,800 天后，前台转发规则不支持的问题。
7. 修复了快捷查询执行 show_object_field(`HOST`) 时，报错 “kodo 服务 API 请求错误: Service Unavailable”的问题。
8. 修复了快捷入口中存在的 bug 问题。
9. 修复了 RUM 中 `session` 和 `view` 无数据，而其他 `resource` 和 action 等有数据的问题。
10. 修复了多步拨测创建请求步骤会立即校验必填项的问题。
11. 修复了数据访问设置角色授权时，过滤条件不生效的问题。



## 2025 年 2 月 27 日 {#20250227}

### OpenAPI 更新 {#openapi0227}

指标：新增[指标集和标签信息获取](../open-api/metric/metric-info-get.md)。

### 功能更新 {#feature0227}

#### 可用性监测

1. HTTP 拨测：支持[脚本模式](../usability-monitoring/request-task/http.md#script)。通过编写 Pipeline 脚本，灵活自定义拨测任务的判断条件和数据处理逻辑。
2. 新增[多步拨测](../usability-monitoring/request-task/multistep_test.md)：允许使用多个 API 连接的响应数据创建测试，并通过局部变量传值，链接多个任务请求。


#### 场景

1. 仪表板 > 可见范围：新增“自定义”配置，可配置此仪表板的“操作”、“查看”权限。同时该配置下新增“全部成员”的选项。
2. 图表：
    - 新增基于 AI 自动生成图表标题及描述的能力；
    - 日志流图新增“规则映射”功能；
    - 表格图显示列优化；
    - 分组表格图：表达式结果支持排序；
    - 时序图、饼图等多个表格支持数据导出为 CSV 文件。

#### 指标

1. [指标分析 > 表格图](../metrics/explorer.md#table)：查询结果返回数量超过 2,000 条时，三个模式新增“查询结果计数”展示。
2. [指标管理](../metrics/dictionary.md)：支持一键跳转到指标分析。
3. [生成指标](../metrics/generate-metrics.md#manage)：支持导入创建方式、支持批量导出。

#### 基础设施

容器/ Pod 查看器：对象数据新增 `cpu_usage_by_limit`、`cpu_usage_by_request`、`mem_used_percent_base_limit`、`mem_used_percent_base_request` 4 个新字段。

#### 应用性能监测

1. Profiling > 火焰图交互优化：选中单条搜索方法名称，可直接聚焦定位。
2. ServiceMap 交互优化：在上下游页面中，支持对当前画布中的节点进行搜索。

### 新增集成 {#inte0227}

1. 新增 [AWS 云账单](../integrations/aws_billing.md)；
2. 新增 [Kube Scheduler](../integrations/kube_scheduler.md)；
3. 新增 [MQTT](../integrations/mqtt.md)；
4. 重写 [APISIX](../integrations/apisix.md)；
5. 更新 [tidb](../integrations/tidb.md) 英文文档和视图；
6. 更新 [Zookeeper](../integrations/zookeeper.md) 视图、补充集成图标；
7. 修复部分组件 mainfest.yaml 英文翻译。

### Bug 修复 {#bug0227}

1. 修复了点击应用性能监测 > 链路详情 tab 页显示错误的问题；
2. 修复了异常追踪 > Issue 回复中 `@成员` 有误的问题；
3. 修复了图表中温度单位不正确的问题。


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

1. 新增 [Milvus](../integrations/milvus.md)；
2. 新增 [火山云公网 IP](../integrations/volcengine_eip.md)；
3. 新增 [opentelemetry-python](../integrations/opentelemetry-python.md)；
4. 新增 [openLIT 集成](../integrations/openlit.md)；
5. 更新 k8s\es\mongodb\rabbitmq\oracle\coredns\sqlserver 中英文监控器&视图。

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

1. 事件支持配置[数据转发](../management/backup/index.md)：支持配置事件类型的数据转发规则，将符合过滤条件的事件数据保存到<<< custom_key.brand_name >>>的对象存储及转发到外部存储，提供灵活管理事件数据的能力。

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