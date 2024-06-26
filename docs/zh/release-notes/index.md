---
icon: zy/release-notes
---
# 更新日志（2024 年）
---

本文档记录观测云每次上线发布的更新内容说明。

## 2024 年 6 月 26 日

### 观测云更新

- [Pipelines](../pipeline/index.md)：支持选择中心 Pipeline 执行脚本。
- 付费计划与账单：新增[中心 Pipeline 计费项](../billing/billing-method/index.md#pipeline)，统计所有命中中心 Pipeline 处理的原始日志的数据大小。
- 监控
    - 通知对象管理：新增[权限控制](../monitoring/notify-object.md#permission)。配置操作权限后，仅被赋予权限的对象可对此通知对象进行编辑、删除操作。
    - 智能监控 > 日志智能检测：新增追踪历史变化，过滤周期性的异常数据突变。
- 日志 
    - [数据访问](../logs/logdata-access.md#config)：新增对被授权查看的日志索引做访问权限配置。
    - 日志查看器：显示列拓展，支持[添加 json 对象内字段内容](../logs/explorer.md#json-content)到一级返回显示。
    - [BPF 网络日志](../logs/bpf-log.md)：
        - 连接展示效果优化；
        - 支持直接跳转至详情页；
        - 支持自定义添加显示列。
- 场景
    - 时序图：折线图、面积图新增[断点连接](../scene/visual-chart/timeseries-chart.md#breakpoint)设置，柱状图新增【显示返回值】按钮。
- [可用性监测](../usability-monitoring/request-task/index.md#manag)：任务列表新增表头排序。
- DataFlux Func：支持观测云异常追踪脚本[集成钉钉应用](https://func.guance.com/doc/script-market-guance-issue-dingtalk-integration/)。

### 观测云部署版更新

Profile：通过配置参数，支持文件存储和对象存储两种方式。 

## 2024 年 6 月 13 日

### 观测云更新

- [BPF 网络日志](../logs/bpf-log.md)：优化 BPF 网络功能，增强 L4/L7 网络联动。
- APM/RUM：新增 【[Issue 自动发现](../application-performance-monitoring/error.md#issue)】功能。启用该配置后，观测云会将符合配置项规则的错误数据记录自动创建 Issue。
- 监控
    - 智能监控：新增 [Kubernetes 智能检测](../monitoring/intelligent-monitoring/k8s.md)：通过智能算法自动检测 Kubernetes 中的异常，检测指标包含 Pod 总数，Pod 重启，APIServer QPS 等。
    - 告警策略管理：
        - 新增[过滤](../monitoring/alert-setting.md#filter)功能。在进行告警规则配置时，该功能允许在原有等级基础上增加更细致的过滤条件，仅匹配等级+过滤条件的事件才会发送给对应的通知对象。
        - 支持选择外部邮箱做为通知对象。
    - 监控器 > 事件内容：支持自定义输入外部邮箱。
- 场景
    - 拓扑图：新增链接配置。
    - 桑基图：由原先支持最多 4 个节点配置改为 6 个。
- Pipeline：列表新增过滤条件显示。
- 日志 > 索引：列表显示优化。


### 观测云部署版更新

Profile：文件大小由原先的固定 5MB 修改为支持自定义，点击查看[如何配置](../deployment/application-configuration-guide.md#studio-front)。

## 2024 年 6 月 3 日

### 观测云更新

- **管理 > [跨工作空间授权](../management/data-authorization.md#site)**：添加页面新增【数据范围】，支持多选数据类型。
- **日志 > 日志查看器**：支持[跨工作空间索引查询](../logs/cross-workspace-index.md)，快速获取其它空间的日志数据，从而突破日志数据存储位置的限制，大幅度提升数据分析和故障定位的效率。


## 2024 年 5 月 29 日

### 观测云更新

- [DCA](../dca/index.md)
    - 支持私有化部署，可直接通过工作空间页面按钮前往 DCA 控制台。
    - 支持批量管理功能。
- 异常追踪：
    - Webhook 接收通道：支持 Issue 回复的新增、修改通知；
    - 支持选择团队或添加外部邮箱为 Issue 负责人。
- 日志 > [上下文日志](../logs/explorer.md#up-down)：查询逻辑修改；支持通过日志上下文详情页对相关数据作进一步查询管理。
- 场景
    - 视图变量：分组标题/图表标题支持配置 `#{视图变量}` 显示。
    - 时序图 > 分析模式：支持调整时间间隔 interval。
    - 仪表板/自定义查看器：当标签数量超过 20 个时，显示搜索框；标签名前显示颜色。
- 监控
    - 监控器/智能监控/静默管理 > 快捷筛选：当值超过 20 个时，出现搜索框，支持搜索定位。
    - 监控器：针对 PromQL 查询检测，事件通知中自动列出可使用的模板变量。
- 基础设施 > 网络：网络详情页 > 网络分析支持 `ip:端口` 和 `ip` 两种维度统计列出展示。
- 应用性能监测 > 服务 > 新建/修改服务清单：填写仓库链接、文档链接时增加格式校验。

#### Breaking Changes

- 管理 > 属性声明：自定义属性字段值调整为字符串类型进行存储。


### 观测云部署版更新

- [模版管理](../deployment/integration.md)：新增导入模版入口，模版范围包括视图模板、监控器模板、自定义查看器模板、Pipeline。支持部署版用户将自定义模板变更为平台级别模板供其他工作空间使用。
- 用户管理：批量操作交互优化。

## 2024 年 5 月 15 日

### 观测云更新

- 监控 
    - 监控器 > [突变检测](../monitoring/monitor/mutation-detection.md) > 检测指标：支持【环比上期】选项，从而实现某个固定时间段内的数据进行最终比较。
    - [静默管理](../monitoring/silent-management.md)：新增【附加信息】功能，支持针对静默规则添加解释说明，从而标识静默的原因或者来源等信息。
    - 智能监控 > 主机智能监控：新增网络流量、磁盘 IO 两项检测维度。
- 场景 > 仪表板：
    - [视图变量](../scene/view-variable.md)：编辑页面样式优化，支持定义下拉单选、多选。
    - 分组表格图、指标分析 > 表格图支持多列查询结果显示适配，如 
```
L::RE(`.*`):(count(*),message,host) {index = 'default' and status = 'error'} BY source,service
```
- 查看器：
    - 日志查看器 > [上下文日志](../logs/explorer.md#up-down)支持微秒级的数据查询过滤，解决出现同一时刻（毫秒）有多条数据，导致不能命中定位显示某条日志上下文的问题。
    - 所有查看器支持选择[导出](../getting-started/function-details/explorer-search.md#csv)数据量为 CSV 文件。
    - 新增查看器搜索查询审计事件，即由用户手动发起的查询操作会计入审计事件记录。
- 服务管理：由原来所属的路径【场景】迁移至【应用性能监测】，优化使用体验。
- 生成指标：支持配置多个 by 分组，不做数量限制。
- DQL 查询：表达式查询支持指定值填充，支持针对子查询做结果填充和最终值填充。
- 用户访问监测 > Android：应用配置显示优化。
- 事件：新增详情页关联查看跳转入口。在不存在检测维度数据的情况下，可在详情页跳转查看器查看。

### 观测云部署版更新

- 新增 [DataKit 清单管理](../deployment/setting.md#datakit)页面。
- 部署版配置单点登录对接时，支持自定义登录[显示标题、描述和 logo](../deployment/azure-ad-pass.md#config)。
- [用户](../deployment/user.md#edit)：新增扩展属性配置。
    - 支持本地用户直接在编辑页面配置属性。
    - 支持单点登录时默认自动将第三方用户属性配置通过 userinfo 接口追加到观测云。

## 2024 年 4 月 24 日

### 观测云更新

- 管理：
    - 新增[云账号管理](../management/cloud-account-manag.md)：将企业所有的云服务账号集中起来进行统一管理，并借由账号下某些配置的唯一性来进行区分。通过配置集成采集器，针对每个账号下的云服务进行独立管理，从而实现对业务数据的精细化控制。
    - 账号管理：[账号登录过期时间](../management/index.md#login-hold-time)调整。
- 新增[快速搜索](../management/index.md#quick-entry)弹窗，可快速查看当前工作空间内最近访问的页面和其他各功能相关页面。
- 基础设施 > 容器：新增 [Statefulset](../infrastructure/container.md#statefulset)、[Persistent Volumes](../infrastructure/container.md#persistent-volumes) 两种对象查看器。
- 异常追踪：
    - 新增 Issue 负责人配置，观测云会为负责人发送邮件通知。
    - 频道管理：支持[升级配置](../exception/channel.md#upgrade)。即，设置新 Issue 超过某特定分钟数时，若未指定负责人，则发送升级通知给对应的通知对象。
- 监控 
    - 监控器：检测配置：支持在【触发条件】配置连续多次判断触发条件生效后，再次触发生成事件。
    - [静默管理](../monitoring/silent-management.md)：
        - 静默规则列表页展示优化：支持列出当前工作空间所有静默规则，可通过快捷筛选快速过滤列出目标规则。
        - 事件属性匹配支持反选，筛选条件格式如下：`attribute:value`、`attribute:*value*`、`-attribute:value`、`-attribute:*value*`，不同字段组合关系为 AND，相同字段的多个值为 OR。
- DQL `match` 函数的含义变更为`完全匹配`。此变更仅针对新引擎，分别应用查看器、监控器这两个场景。
    - 查看器场景示例：`host:~cn_hangzhou`。
    - 监控器场景示例：
    ```
    window("M::`cpu`:(avg(`load5s`)) { `host` = match('cn-hangzhou.172.16.***') } BY `host`", '1m')
    ```
- 场景 > 仪表板[图表](../scene/visual-chart/index.md#download)可直接下载为 PNG 图片，表格图还可导出为 CSV 文件。
- 日志 > 绑定索引：【字段映射】更改为非必填项。
- 集成/内置视图：模版新增标签管理。
- Service Map 跨工作空间节点[样式显示调整](../scene/service-manag.md#servicemap)。

### 观测云部署版更新

- 管理 > 基本信息 > License 信息：DataKit 数量限制支持按照数据统计范围调整，变更为存活时间 >= 12 小时以上的主机或 DK 数量。
- 支持配置黑名单，自定义选择导入观测云集成、视图模板、监控器模板范围。

### OpenAPI 更新

- Pipelines [新增](../open-api/pipeline/add.md)/[修改](../open-api/pipeline/modify.md)：新增 profiling 类型；
- 用户视图[新增](../open-api/inner-dashboard/add.md)/[修改](../open-api/inner-dashboard/modify.md)：支持绑定仪表板配置。

## 2024 年 4 月 10 日

### 观测云更新

- 监控 > 监控器 > 新建：新增【数据断档】、【信息生成】配置区域，以便更好地区分异常数据和无数据情况。
- 管理：新增[系统通知](../management/index.md#system-notice)页面，可查看当前账号下的工作空间所有配置的异常状态消息。
- 场景：
    - 图表查询：新增 [Rollup 函数](../dql/rollup-func.md)，该函数同样适用于【指标分析】与【查询工具】；
    - 仪表板/用户视图：新增 [pin 钉住](../scene/dashboard.md#pin)功能。在当前访问工作空间被授权查看若干其他工作空间数据的前提下，支持将查询其他工作空间数据设为默认选项。  
    - 系统视图：支持克隆创建为仪表板或者用户视图；
    - 自定义查看器：优化搜索模式；非编辑模式下，hover 在【数据范围】即可查看所有筛选条件。
- 查看器 > [快捷筛选](../getting-started/function-details/explorer-search.md#quick-filter)：
    - 新增【维度分析】按钮，点击后可快速切换到查看器分析模式；
    - 支持通过点击外部按钮直接将当前字段添加到显示列/从显示列移除。
- [体验版工作空间](../plans/trail.md#upgrade-entry) > 导航栏：新增【立即升级】按钮。
- 基础设施 > 容器 > 蜂窝图：新增 CPU 使用率（标准化）和 MEM 使用率（标准化）两种指标填充方式。

### 观测云部署版更新

工作空间管理：新增[数据上报限制](../deployment/space.md#report-limit)，帮助利益相关方节约资源等使用成本。

## 2024 年 3 月 27 日

### 观测云更新

- 监控：
    - 告警策略管理：每条通知规则（包含默认通知和自定义通知）配置新增[支持升级通知条件](../monitoring/alert-setting.md#upgrade)。
    - 监控器 > 事件内容：新增[自定义高级配置](../monitoring/monitor/threshold-detection.md#advanced-settings)，支持添加关联日志和错误堆栈；
    - 主机智能监控：将当前突变展示更改为基于周期以预测的方式进行异常告警，趋势图会展示当前指标及置信区间上下界，超出置信区间的异常会标红展示。
- 场景 > 图表：新增[拓扑图](../scene/visual-chart/topology-map.md)。
- APM > 链路详情页 > [服务调用关系](../application-performance-monitoring/explorer.md#call)：调整为服务拓扑展示，并展示服务与服务之间的调用次数。
- 数据保存策略：Session Replay 的数据保存策略与 RUM 的保存策略保持联动一致，即 RUM 数据保存 3 天，Session Replay 的数据也保存 3 天。
- 查看器：
    - 事件查看器 > 基础属性：新增检测指标是否显示配置，缓存到本地，全局适配；
    - APM > 错误追踪 > 聚类分析 > 详情页：支持创建异常追踪 Issue；
    - RUM > Error > 聚类分析 > 详情页：支持创建异常追踪 Issue；
    - RUM > View > 详情页：
        - 性能：新增【所有条目】选项，列出当前 View 下所有关联数据；
        - Fetch/XHR：点击数据行，支持打开对应链路详情页或 Resource 详情页。
    - 时间控件：获取 “当前时间” 时，精确到毫秒。
- 管理 > [工单管理](../management/work-order-management.md)：
    - 新增评星和评价；
    - 已反馈的工单需要调整为 7 天内无客户反馈则自动关单；
    - 支持工单列表导出；
    - 状态为【已完成】【已撤销】的工单可以进行重启操作；
    - 账号注销后其下提交的未关闭状态工单支持自动关闭处理。
- 云市场开通流程整体优化。

### 观测云部署版更新

- 数据保存策略：支持工作空间拥有者配置数据保存策略，且支持自定义输入保存时长。应用场景：
    - 指标管理 > 指标集；
    - 日志 > 索引 > 新建。
- 用户：支持[通过邮箱账号](../deployment/user.md#via-email)邀请成员。


## 2024 年 3 月 13 日

### 观测云更新

- 监控 > 监控器：监控器类型【[组合检测](../monitoring/monitor/composite-detection.md)】上线。支持将多个监控器的结果通过表达式组合成一个监控器，最终基于组合后的结果进行告警。
- 场景 > 服务：支持[跨工作空间 Service Map 查询](../scene/service-manag.md#servicemap)。

### 观测云部署版更新

- 管理 > 基本信息：新增 “已用 DK 数量” 显示；
- 管理 > 用户：新增[分组](../deployment/user.md#team)页面，基于组可配置关联工作空间及角色，用户可通过组获得对应工作空间的访问权限。



## 2024 年 3 月 6 日

### 观测云更新

- 监控
    - 监控器 > 检测频率：新增 **[Crontab 自定义输入](../monitoring/monitor/detection-frequency.md)**，满足仅需在特定的时间段执行检测的需求；
    - 突变检测：新增【最近 1 分钟】、【最近 5 分钟】的检测区间；
    - 静默管理：选择静默范围时“事件属性”为非必填项，可根据需要自行配置更细颗粒度的匹配规则。
- DataFlux Func：新增 [Function 外部函数](../dql/dql-out-func.md)。允许第三方用户充分利用 Function 的本地缓存和本地文件管理服务接口编写函数，在工作空间内执行数据分析查询。
- APM > [链路](../application-performance-monitoring/explorer.md)：
    - Title 区域 UI 显示优化；
    - 针对火焰图、瀑布图、Span 列表超过 1 万的 Span 结果，支持通过**偏移**设置查看未展示 Span；
    - 新增 **Error Span** 筛选入口；支持输入 Span 对应的资源名称或 Span ID 进行搜索匹配。
- 场景
    - 图表：新增[桑基图](../scene/visual-chart/sankey.md)；
    - 视图变量：新增**选中**按钮，勾选后默认全选当前所有值，可按需再反选。
- 账号管理：新增[注销](../management/index.md#cancel)入口。
- 查看器：
    - UI 显示优化；
    - 筛选新增正则匹配 / 反向正则匹配模式；
    - Wildcard 筛选和搜索支持左 * 匹配。
- 事件 > 详情页：【告警通知】tab 页 UI 显示优化。


### 观测云部署版更新

- 新增[登录方式选择](../deployment/setting.md#login-method)，对登录方式进行统一管理；
- 针对本地账号和单点登录账号新增[删除](../deployment/user.md#delete)操作。

## 2024 年 1 月 31 日

### 观测云更新

- 监控：
    - [智能监控](../monitoring/intelligent-monitoring/index.md)：
        - 主机、日志、应用智能检测频率调整为每 10 分钟执行一次，每执行一次检测计算为 10 次调用费用；
        - 为提升算法精度，日志、应用智能检测采用数据转存的方式，开启一个智能监控后，会生成对应的指标集及指标数据。这一调整会产生额外的时间线，具体数量为当前监控配置的过滤条件所过滤的检测维度数量(service、source) * 检测指标数量，由于没有对监控器的过滤条件进行存储，如果发生监控器过滤条件配置修改的情况，会生成新的等量时间线，所以在修改监控器过滤条件配置当日会有时间线重复计费的情况，修改后次日恢复正常。
    - 告警策略管理：
        - [新增自定义通知时间配置](../monitoring/alert-setting.md#custom)，按周期、时间区间细化告警通知配置；
        - 重复告警新增【永久】这一事件选项。
    - 监控器 
        - 告警配置：支持配置多组告警策略；若配置多个，则 `df_monitor_name` 与 `df_monitor_id` 会以多个的形式呈现，并由 `;` 分隔开；
        - 联动异常追踪 Issue 改造：新增【事件恢复同步关闭 Issue】开关，当异常事件恢复时，则同步恢复异常追踪 Issue；
        - 监控器列表[新增克隆按钮](../monitoring/monitor/index.md#options)。
    - 通知对象管理：新增[简单 HTTP 通知类型](../monitoring/notify-object.md#http)，直接通过 Webhook 地址接收告警通知；       
- 场景：
    - 图表：单位新增【货币】选项；高级配置 > 同期对比更改为【同环比】；
    - 服务管理 > 资源调用：排行榜新增 TOP / Bottom 数量选择。
- 查看器：显示列设置新增【时间列】开关。
- 付费计划与账单：
    - 工作空间锁定弹窗页面新增[新建工作空间](../billing-center/workspace-management.md#lock)入口，优化操作体验；
    - AWS 注册流程优化。

### 观测云部署版更新

- 支持 [LDAP 单点登录](../deployment/ldap.md)；
- 工作空间管理 > 数据存储策略新增自定义选项，范围为<= 1800 天（ 5 年）；其中，指标新增可选项 720 天、1080 天等保存时长；在控制台中设置 > 编辑数据存储策略，修改保存后即可同步更新后台数据存储；
- 用户：支持为用户账号一键配置分配工作空间以及角色；
- 新增控制台审计事件查看入口，可快速查看所有工作空间相关操作审计；  
- 新增【管理后台 MFA 认证】。


## 2024 年 1 月 11 日

### 观测云更新

- 日志：
    - 新增 BPF 网络日志采集及日志详情页，支持 JSON 格式转化；详情页新增可读的展示模式；
    - 新增绑定【关联网络日志】；
    - 数据访问：新增批量操作。
- 定时报告：新增可选分享方式【公开分享】或【加密分享】。
- 仪表板：
    - 视图变量新增【所有变量值】传参选项；
    - 时序图：新增排序逻辑（仅限新引擎），支持针对返回结果进行排序。
- 生成指标：支持批量操作；标准及以上权限成员支持克隆。
- 监控器：
    - 通知对象管理：适配新的钉钉机器人，创建时「密钥」选项非必填，快速关联钉钉机器人。
    - SLO 扣分逻辑优化。
- 用户访问监测（RUM）：公网 Dataway 支持 ip 转换成地理位置信息。

