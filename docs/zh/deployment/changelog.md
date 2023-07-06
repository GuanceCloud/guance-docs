# 版本历史

## 1.65.131（2023 年 06 月 20 日）

pubrepo.guance.com/dataflux/1.65.131:launcher-d6c2ef5-1687506944

### 观测云更新

- RUM (Real User Monitoring) 采集器用于收集网页端或移动端上报的用户访问监测数据。现提供 RUM Headless一键开通服务，实现自动化安装部署在观测云的云主机中，自动完成 DataKit 安装，RUM 采集器部署。只需要手动接入应用即可。
- 查看器：优化筛选、搜索的交互转化等逻辑，让用户真正做到所见即所得，且能够在 UI 和手写模式自由切换。另：日志查看器支持的 DQL 手写模式新版本上线后将会做下线处理。
- 日志 > 备份日志：新增外部存储类型选择，支持写入 S3(AWS) 对象存储、支持华为云 OBS 数据写入。
- 日志 > 索引：新增日志易数据绑定配置入口。
- 仪表板/内置视图支持根因分析和下钻分析。
- 管理 > 角色管理：支持克隆已有用户角色减少操作步骤，快速增减权限并创建角色。
- 基础设施 > 容器：新增 Daemonset 对象数据显示，可拖拽改变对象分类显示顺序。
- 基础设施 > 容器：Deployments、Pods 支持直接关联 kubernetes 事件日志，在详情页可直接查看具体日志信息。
- 新增异常追踪 OpenAPI 接口。
- 管理 > 成员管理列表、监控 > 通知对象管理 > 邮件组、异常追踪 > 查看成员、所有选择通知对象处均支持按成员昵称进行检索。
- 工单状态更新或有新回复时，通过界面或者邮件提醒客户关注。
- 文本输入框输入不合法的字符或长度限制提示优化。

### DataKit 更新

- 新增 Chrony 采集器
- 新增 RUM Headless 支持
- Pipeline
- 新增 offload 功能
- 调整已有的文档结构
- 在 Datakit HTTP API 返回中增加更多信息，便于错误排查
- RUM 采集器增加更多 Prometheus 指标暴露
- 默认开启 Datakit 的 pprof 功能，便于问题排查

### 智能巡检更新

- 新增巡检
- AWS Cloudtrail 异常事件巡检：帮助快速识别问题并采取适当的纠正措施，以减少服务中断时间和业务影响。
- 新增脚本
- 观测云集成（阿里云-RDS错误日志）：收集阿里云的 RDS 错误日志，用于 RDS 的错误信息诊断；
- filebeats 数据采集器：收集 FileBeats 性能数据用于观测 FileBeats 性能、延迟等场景；
- logstash 数据采集器：收集 Logstash 性能数据用于观测 Logstash 性能、延迟等场景。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.64.130（2023 年 06 月 12 日）

pubrepo.guance.com/dataflux/1.64.130:launcher-e504618-1686575695

此版本是 fix 版本，主要有如下更新:

### 观测云部署版更新

- 修复私有部署版 OIDC 对接的一些 bug。
- 修复其他一些小 bug。


更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.64.129（2023 年 06 月 08 日）

pubrepo.guance.com/dataflux/1.64.129:launcher-ad357b8-1686206775

### 观测云部署版更新

- 管理后台新增密码安全策略：新增密码 8 位长度限制及密码有效期功能。

### 观测云更新

- 为进一步满足用户数据查看需求，商业版付费计划与账单新增设置高消费预警功能，新增消费分析列表，支持查看各类支出消费统计。
- 创建工作空间时新增菜单风格选择，支持选择不同的工作空间风格属性。
- 优化日志数据访问权限相关规则适配，进一步明确多角色数据查询权限及权限控制对应关系。
- 事件详情页下的基础属性下的检测维度新增关联查询，支持查看筛选当前检测维度下全部字段值的关联数据。
- 告警策略管理支持不同级别告警到不同的通知对象。
- 成员管理新增添加昵称备注功能，规范工作空间内的成员用户名，支持通过昵称备注搜索成员。
- 仪表板、查看器、监控、成员管理、分享管理等页面列表新增批量操作功能。
- 应用性能监测服务支持修改颜色，支持表头排序调整。
- 日志、应用性能监测 > 错误追踪查看器聚类分析支持对文档数量排序，默认倒叙。
- 支持保存登录选择语言版本到浏览器本地，再次登录自动显示上一次登录选择语言版本。
- 生成指标频率选项调整，支持选择 1 分钟、5 分钟、15 分钟。

### 智能巡检更新

- 新增巡检
- 工作空间资产巡检
- 新增脚本
- gitlab 研发效能分析：根据 gitlab 的代码提交频率和每次代码量，分团队、个人、时间维度展示团队的研发效能。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.63.128（2023 年 05 月 22 日）

pubrepo.guance.com/dataflux/1.63.128:launcher-d07d641-1685285792

### 私有部署版更新

- 支持选择使用私有拨测服务或 SaaS 拨测服务中心

### 观测云更新

- RUM 应用配置新增自定义类型和关联视图查看分析
- DQL 函数支持正则聚合数据统计显示返回
- 新增 PromQL 语法查询入口，支持通过 PromQL 查询时序数据
- show_tag_value() 函数支持查询对应指标字段的关联标签
- 小程序 SDK 支持采集启动参数相关的信息；新增自定义添加 Error
- Status Page 支持订阅故障通知
- 新增字段管理功能，在监控器、图表查询、查看器等位置若选择了相关字段则显示对应的描述和单位信息
- 指标分析新增表格功能，支持下载
- 工单状态调整
- 新增异常追踪引导页，频道新增时间范围筛选
- 备份日志优化：
    - 新增备份规则入口移至备份日志 > 备份管理
    - 新增全部备份逻辑：不添加筛选即表示保存全部日志数据

### 智能巡检更新

- 新增巡检
    - 云上闲置资源巡检
    - 主机重启巡检
- 功能优化
    - 闲置主机巡检：新增对云主机类型关联添加费用相关信息。

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.62.127（2023 年 04 月 20 日）

pubrepo.guance.com/dataflux/1.62.127:launcher-c737a19-1683555353

### 观测云更新

- 计费更新
    - 观测云自研时序引擎 GuanceDB 全新上线，时序数据存储及计费将会做如下调整：
    - 基础设施（DataKit）计费项下线，原 “DataKit + 时间线”、“仅时间线” 两种计费模式按照仅 GuanceDB 时间线作为出账逻辑使用；
    - GuanceDB 时间线：统计当天活跃的时间线数量计费，单价低至 ￥0.6 / 每千条时间线。
    - 用户访问监测 “会话重放” 正式启动付费，按照实际采集会话重放数据的 session 数量计费，￥10 / 每千个 Session。
- 功能更新
    - GuanceDB 时序引擎全新上线
    - 异常追踪新功能上线
    - 跨站点工作空间授权功能上线
    - SLS 新增第三方授权开通或绑定
    - 绑定索引配置页面优化，支持自定义添加映射字段配置
    - 命令面板新增本地 Func 的自定义函数选择
    - 时序图新增高级函数，支持本地 Func 根据 DQL 查询结果二次处理后返回显示
    - 工作空间新增时区配置，用户可自定义配置当前工作空间查询时间的时区
    - 智能巡检优化脚本集开启步骤，新增新增 AWS 同步多种认证方式、AWS Cloudwatch Logs 同步
    - 集成 - DataKit 页面引导优化
    - 查看器柱状分布图新增统计时间区间显示
    - 导航菜单支持右键选择新页打开
    - 黑名单重名导入问题修复
- 私有部署版更新
    - 新增账号登录映射规则配置，根据不同的映射规则动态分配成员加入的工作空间及对应的角色。

### DataKit 更新

- 新增 Pinpoint API 接入
- 优化 Windows 安装脚本和升级脚本输出方式，便于在终端直接黏贴复制
- 优化 Datakit 自身文档构建流程
- 优化 OpenTelemetry 字段处理
- Prom 采集器支持采集 info 类型的 label 并将其追加到所有关联指标上（默认开启）
- 在 system 采集器 中，新增 CPU 和内存占用百分比指标
- Datakit 在发送的数据中，增加数据点数标记（X-Points），便于中心相关指标构建
- 优化 Datakit HTTP 的 User-Agent 标记，改为 datakit-<os>-<arch>/<version> 形态
- KafkaMQ：
- 支持处理 Jaeger 数据
- 优化 SkyWalking 数据的处理流程
- 新增第三方 RUM 接入功能
- SkyWalking 新增 HTTP 接入功能

更多详情可参考帮助文档：https://docs.guance.com/release-notes/


## 1.61.126（2023 年 04 月 06 日）

pubrepo.guance.com/dataflux/1.61.126:launcher-d290e0d-1681300585

### 观测云更新

- 日志新增 3 天数据保存策略和定价，计费相关请参考文档计费方式。
- 日志新增数据访问权限控制，支持将某个范围内的日志数据查看权限授予给相关角色
- 角色权限清单新增各功能模块数据查询权限，支持自定义角色配置对应模块的数据查询权限入口
- 标准成员新增 “快照管理” 权限，支持快照增删操作
- 快照分享支持搜索功能。（日志 DQL 查询模式下不支持调整搜索范围）
- 支持本地 Func 通过 websocket 协议创建自定义的通知对象，实现外部通知渠道接收告警通知
- 查看器新增copy as cURL数据查询功能
- 仪表板图表配置交互优化
- 概览图新增数值单位选项配置，支持选择中国科学记数法进位（default）和短级差制（short scale）
- 新增视图变量是否应用到图表效果显示
- 图表存在分组条件时，支持将某个分组条件值反向应用到视图变量实现联动筛选
- 图表存在分组条件时，选中某个分组条件对应时间线或数据点时支持其他图表中相同分组联动高亮显示
- 图表拖拽效果优化
- 账号无操作会话过期时间默认调整为 3 小时，此次调整仅针对未编辑过无操作会话过期时间配置的账号，不影响已编辑过的无操作会话过期时间配置的账号。
- 筛选历史新增搜索条件保存
- 用户访问监测应用 SDK 接入引导优化
- 生成指标配置优化，支持针对新生成的指标配置单位和描述
- 主机查看器支持多行显示，多行模式下 label 将另起一行显示
- 时序图、饼图新增返回显示数量配置

### DataKit 更新 

- 新加功能
    - 新增伺服服务，用来管理 Datakit 升级
    - 新增故障排查功能
- 功能优化
    - 优化升级功能，避免 datakit.conf 文件被破坏
    - 优化 cgroup 配置，移除 CPU 最小值限制
    - 优化 self 采集器，我们能选择是否开启该采集器，同时对其采集性能做了一些优化
    - Prom 采集器允许增加 instance tag，以保持跟原生 Prometheus 体系一致
    - DCA 增加 Kubernetes 部署方式
    - 优化日志采集的磁盘缓存性能
    - 优化 Datakit 自身指标体系，暴露更多 Prometheus 指标
    - 优化 /v1/write
    - 优化安装过程中 token 出错提示
    - monitor 支持自动从 datakit.conf 中获取连接地址
    - 取消 eBPF 对内核版本的强制检查，尽量支持更多的内核版本
    - Kafka 订阅采集支持多行 json 功能
    - 优化 IO 模块的配置，新增上传 worker 数配置字段
- 兼容调整
    - 本次移除了大部分 Sinker 功能，只保留了 Dataway 上的 Sinker 功能。同时 sinker 的主机安装配置以及 Kubernetes 安装配置都做了调整，其中的配置方式也跟之前不同，请大家升级的时候，注意调整
    - 老版本的发送失败磁盘缓存由于性能问题，我们替换了实现方式。新的实现方式，其缓存的二进制格式不再兼容，如果升级的话，老的数据将不被识别。建议先手动删除老的缓存数据（老数据可能会影响新版本磁盘缓存），然后再升级新版本的 Datakit。尽管如此，新版本的磁盘缓存，仍然是一个实验性功能，请谨慎使用
    - Datakit 自身指标体系做了更新，原有 DCA 获取到的指标将有一定的缺失，但不影响 DCA 本身功能的运行


更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.60.125（2023 年 03 月 23 日）

pubrepo.guance.com/dataflux/1.60.125:launcher-6723827-1679932675

### 私有部署版更新

- 解决了在部署过程中无法使用包含复杂字符密码的中间件的问题
- 提升了在部署过程中自动生成的数据库账号密码的复杂度

### 观测云更新

- 帮助文档搜索功能优化
- 备份日志新增扩展字段保存逻辑
- 查看器/仪表板时间控件新增“时区选择”和“全局锁定”功能
- 监控器优化
- 支持查看上次的历史配置，支持点击还原到历史配置版本
- 列表和页面新增创建、变更信息显示
- 突变检测新增对比维度，支持选择跟“昨日”“上一小时”统计指标比对逻辑
- 智能巡检事件新增效果反馈入口
- 快照分享支持添加“创建人”水印显示
- 注册开通流程优化，云市场开通路径新增站点选择
- 笔记创建逻辑和添加内容交互调整
- 图表查询新增 label 反选逻辑
- 链路详情页 Span 列表显示逻辑调整，按“持续时间”倒序显示
- 成员管理触发审核流程后角色修改逻辑调整
- 查看器列宽度保存、日志显示多行等逻辑调整

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## 1.59.124（2023 年 03 月 09 日）

pubrepo.guance.com/dataflux/1.59.124:launcher-cfaec26-1679407401

### 观测云更新

- 数据存储策略变更优化
- 图表链接配置优化
- 新增支持创建重名的仪表板、笔记、自定义查看器
- DQL 参数生效优先级调整
- 日志 Message 数据展示优化
- 监控配置页面优化
- SSO 相关优化
- 其他功能优化
    - 商业版开通流程支持 “观测云直接开通”、“阿里云市场开通“和“亚马逊云市场开通“三种方式任意选择；
    - 查看器左 * 查询功能范围调整，新开通的工作空间不再默认支持左 * 查询，如有需求请联系客户经理；
    - SLIMIT 限制调整，时序图查询若存在 group by 分组时，默认返回最多 20 条数据；
    - 新创建的工作空间新手引导流程优化。

### DataKit 更新 

- 新加功能
    - Pipeline 支持 key 删除
    - Pipeline 增加新的 KV 操作
    - Pipeline 增加时间函数
    - netstat 支持 IPV6
    - diskio 支持 io wait 指标
    - 容器采集允许 Docker 和 Containerd 共存
    - 整合 Datakit Operator 配置文档
- 功能优化
    - 优化 Point Checker
    - 优化 Pipeline replace 性能
    - 优化 Windows 下 Datakit 安装流程
    - 优化 confd 配置处理流程
    - 添加 Filebeat 集成测试能力
    - 添加 Nginx 集成测试能力
    - 重构 OTEL Agent
    - 重构 Datakit Monitor 信息

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## v1.58.123（2023 年 03 月 07 日）

pubrepo.guance.com/dataflux/1.58.123:launcher-a4e6282-1678200092

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复 Profiling 的数据过期清理的 bug
- 修复 DQL series_sum 函数计算逻辑的 bug

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.58.122（2023 年 03 月 04 日）

pubrepo.guance.com/dataflux/1.58.122:launcher-08db157-1677907360

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复 RUM Session Replay 功能播放时 bug
- 一些其他小 bug 修复

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.58.121（2023 年 02 月 23 日）

pubrepo.guance.com/dataflux/1.58.121:launcher-105a217-1677566915

### 观测云更新

- 用户访问监测优化
    - 新增用户访问监测自动化追踪
    - 用户访问监测应用列表、查看器、分析看板布局整体调整
    - 新增 CDN 质量分析
- 场景优化
    - 新增自定义查看器导航菜单
    - 增强场景视图变量级联功能
    - 饼图新增合并配置选项
- 其他功能优化
    - 观测云商业版注册流程支持绑定观测云费用中心账号；
    - 配置监控器时，「检测维度」支持非必选。
    - 图表查询中 match / not match 运算符翻译逻辑调整，日志类数据中 match 去除默认右 * 匹配逻辑。

### DataKit 更新

- 新加功能
    - 命令行增加解析行协议功能
    - Datakit yaml 和 helm 支持资源 limit 配置
    - Datakit yaml 和 helm 支持 CRD 部署
    - 添加 SQL-Server 集成测试
    - RUM 支持 resource CDN 标注
- 功能优化
    - 优化拨测逻辑
    - 优化 Windows 下安装提示
    - 优化 powershell 安装脚本模板
    - 优化 k8s 中 Pod, ReplicaSet, Deployment 的关联方法
    - 重构 point 数据结构及功能
    - Datakit 自带 eBPF 采集器二进制安装

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.57.120（2023 年 01 月 12 日）

pubrepo.guance.com/dataflux/1.57.120:launcher-e5345d3-1675061598

### 观测云更新

- 观测云英文语言支持
- 新增观测云站点服务 Status Page
- 新增绑定自建 Elasticsearch / OpenSearch 索引
- 新增网络查看器列表模式
- 新增前端应用 Span 请求耗时分布显示
- 优化用户访问监测 Session 交互逻辑
- Pod 指标数据采集默认关闭
- 其他功能优化
    - 绑定 MFA 认证调整为邮箱验证
    - 注册时调整手机验证为邮箱验证
    - 登录时安全验证调整为滑块验证
    - 创建工作空间新增观测云专属版引导
    - 工作空间新增备注显示功能
    - 云账号结算用户新增在观测云付费计划与账单查看账单列表
    - 表格图支持基于 「by 分组」设置别名
    - 优化监控器配置中的时序图，仅在选择维度后显示
    - 优化日志类数据无数据告警配置
    - OpenAPI 新增创建接口

### 最佳实践更新

- 云平台接入：AWS - EKS 部署 DataKit。
- 监控 Monitoring：应用性能监控 (APM) - 调用链 - 使用 datakit-operator 注入 dd-java-agent。

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.56.119（2022 年 12 月 29 日）

pubrepo.guance.com/dataflux/1.56.119:launcher-e4d9302-1672825365

### 观测云更新

- 新增工作空间 MFA 认证管理
- 新增工作空间 IP 访问登录白名单
- 新增 Service 网络拓扑
- 其他功能优化
    - Pipeline 使用优化
    - 日志聚类分析支持自定义字段
    - 超大日志切割后支持查看其关联日志
    - 备份日志显示优化
    - 数据授权敏感字段支持除指标以外所有类型的数据

### DataKit 更新

- Prometheus 采集器支持通过 Unix Socket 采集数据
- 允许非 root 用户运行 DataKit
- 优化 eBPF 中 httpflow 协议判定
- 优化 Windows 下 Datakit 安装升级命令
- 优化 Pythond 使用封装
- Pipeline 提供更详细的操作报错信息
- Pipeline reftable 提供基于 SQLite 的本地化存储实现

### 智能巡检更新

- 官方智能巡检「内存泄露」、「应用性能检测」、「磁盘使用率」下线
- 新增云账户实例维度账单巡检
- 新增阿里云抢占式实例存活巡检

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.55.117（2022 年 12 月 15 日）

pubrepo.guance.com/dataflux/1.55.117:launcher-f4f56ef-1672025178

### 观测云更新

- 新增 Profile、network 计费
- 观测云注册流程优化
- 新增作战室功能
- 新增仪表板轮播功能
- 工作空间绑定外部 SLS 索引
- 链路查看器图表显示优化
- 其他功能优化
    - 视图变量交互优化
    - 绑定内置视图配置交互优化
    - 工作空间欠费锁定流程优化
    - 工作空间邀请用户体验优化
    - 帮助文档新增评价系统，包括文档较好和较差
    - 监控器批量功能优化
    - SLO新增启用/禁用功能
    - 模糊匹配 Wildcard 左 * 匹配查询限制优化

### DataKit 更新

- 新增 Golang Profiling 接入
- logfwd 支持通过 LOGFWD_TARGET_CONTAINER_IMAGE 来支持 image 字段注入
- trace 采集器：
- 优化 error-stack/error-message 格式问题
- SkyWalking 兼容性调整，支持 8.X 全序列
- eBPF httpflow 增加 pid/process_name 字段，优化内核版本支持
- datakit.yaml 有调整，建议更新 yaml
- GPU 显卡采集支持远程模式

### 智能巡检更新

- 智能巡检新增引导页
- 智能巡检组件支持配置自定义跳转链接

### 最佳实践更新

- 场景 (Scene) - SpringBoot 项目外置 Tomcat 场景链路可观测

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.54.116（2022 年 12 月 01 日）

pubrepo.guance.com/dataflux/1.54.116:launcher-56de9cd-1670394824

### 观测云更新

- 应用性能新增服务清单功能
- 仪表板图表使用体验优化
    - 新增图表单位、颜色、别名的手动输入，您可以按照当前的规范自定义预设单位、颜色和别名，如单位的输入格式为：聚合函数(指标)，如 last(usage_idle)
    - 时序图新增 Y 轴配置，您可以手动配置 Y 轴的最大值和最小值
    - 时序图、饼图新增分组显示，开启后图例中仅显示标签值
    - 蜂窝图、中国地图、世界地图新增渐变区间，包括自动和自定义
    - 柱状图、直方图显示优化
- 视图变量使用体验优化
    - 视图变量新增支持多选
    - 视图变量配置时新增是否设置多个默认值
- 用户访问监测 Session 查看器调整
- 事件新增移动端跳转选项
- 其他功能优化
    - 新手引导页优化，支持最小化
    - 用户访问监测应用列表优化，新增时间控件自定义区间切换查询
    - 主机添加 Label 交互优化

### 智能巡检更新

- Kubernetes Pod 异常重启巡检
- MySQL 性能巡检
- 服务端应用错误巡检
- 内存泄漏巡检
- 磁盘使用率巡检
- 应用性能巡检
- 前端应用日志错误巡检

### 最佳实践更新

- 应用性能监控 (APM) - 性能优化 - 利用 async-profiler 对应用性能调优

### 私有部署版更新

- 支持使用自定义镜像仓库
- 支持在部署时，一键创建中件间基础设施：MySQL、Redis、OpenSearch、TDengine 等
- 支持 MySQL 8.x

更多详情可参考帮助文档：https://docs.guance.com/release-notes/

## v1.53.115（2022年11月17日）

pubrepo.guance.com/dataflux/1.53.115:launcher-0da0220-1669271832

### 观测云更新

- Pipeline 使用体验优化
    - Pipeline 支持过滤条件配置多选
    - 支持将任意一个 Pipeline 脚本设置为“默认 Pipeline 脚本“
    - 脚本函数归类
- 事件优化
    - 支持写入用户的自定义事件
    - 未恢复事件查看器左侧新增快捷筛选
- 自定义查看器支持选择更多类型的数据
- 成员管理新增成员分组功能
- 优化内置视图绑定功能
- 新增一键导入导出工作空间内的仪表板、自定义查看器、监控器
- 应用性能监测日志页面新增自定义关联字段
- 其他功能优化
    - 当筛选条件使用模糊匹配和模糊不匹配的时候，支持左 \* 匹配
    - 基础设施分析维度优化，在主机详情页主机最后上报时间
    - 支持用户快速登录到上一次单点登录
    - 黑名单的应用性能监测新增支持过滤“全部服务”
    - “中国区4（广州）”站点注册的用户升级到商业版流程优化
    - 字段描述支持在快捷筛选、显示列等处查看

### DataKit 更新

- 新增 SNMP 采集器
- 新增 IPMI 采集器
- 新增批量注入 DDTrace-Java 工具
- 最新 DDTrace-Java SDK 增强了 SQL 脱敏功能
- Pipeline 支持来源映射关系配置，便于实现 Pipeline 和数据源之间的批量配置
- Pipeline 提供了函数分类信息，便于远程 Pipeline 编写
- 优化 Kafka 消息订阅，不再局限于获取 SkyWalking 相关的数据，同时支持限速、多版本覆盖、采样以及负载均衡等设定
- 通过提供额外配置参数（ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL），缓解短生命周期 Pod 日志采集问题
- 纯容器环境下，支持 通过 label 方式 配置容器内日志采集
- 新增 Pipeline 函数

### 最佳实践更新

- 观测云小妙招(Skills) - DataKit 配置 HTTPS
- 应用性能监控 (APM) - ddtrace 常见参数用法
- 应用性能监控 (APM) - ddtrace-api 使用指南
- 应用性能监控 (APM) - ddtrace 采样
- 应用性能监控 (APM) - ddtrace log 关联

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.52.114（2022年11月03日）

pubrepo.guance.com/dataflux/1.52.114:launcher-86c0c1f-1668062771

### 观测云更新

- 新增观测云、SLS 联合解决方案
- 优化新手引导页面
- 新增 3 个智能巡检配置文档
- 新增链路错误追踪查看器
- 优化时序图、概览图同期对比功能
- 其他功能优化
    - 仪表板/笔记/查看器在「设置」里面新增 “保存快照” 的按钮；
    - 时间控件新增更多选项；
    - Pipeline 和黑名单功能，新增导入、批量导出、批量删除功能；
    - 智能巡检新增仪表盘、柱状图图表组件；
    - 集成菜单下 Func 页面优化。

### DataKit 更新

- 完善 Prometheus 生态兼容，增加 ServiceMonitor 和 PodMonitor 采集识别
- 增加基于 async-profiler 的 Java Profiling 接入
- eBPF 采集增加 interval 参数，便于调节采集的数据量
- 所有远程采集器默认以其采集地址作为 host 字段的取值，避免远程采集时可能误解 host 字段的取值
- DDTrace 采集到的 APM 数据，能自动提取 error 相关的字段，便于中心做更好的 APM 错误追踪
- MySQL 采集器增加额外字段 Com_commit/Com_rollback 采集

### 最佳实践更新

- 监控 Monitoring
- 应用性能监控 (APM) - Kafka 可观测最佳实践
- 云平台接入
- 阿里云 - 阿里云 ACK 接入观测云

### 私有部署版更新

- 私有部署版本，支持了 Profiling 功能

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.51.112（2022年10月20日）

pubrepo.guance.com/dataflux/1.51.112:launcher-43db8d3-1667315533

此版本是产品迭代版本，主要有如下更新:

### 观测云更新

- 监控优化
    - 新增离群检测
    - 突变检测逻辑优化
    - 区间检测逻辑优化
    - 无数据配置选择“触发无数据事件”与“触发恢复事件”配置调整为时间范围配置，并根据输入的时间范围提供建议。
    - 支持基于 “事件” 数据配置监控器检测。
    - 告警配置新增“信息”事件通知等级选择
- 场景图表优化
    - 新增直方图图表组件
    - 概览图、矩形树图、漏斗图新增时间分片功能
    - 时序图“查看相似趋势指标”从仅支持指标查询调整为支持所有数据类型，包括日志、应用性能、用户访问等
    - 排行榜支持查看超出图表宽度全部内容
    - 蜂窝图显示优化
- 查看器优化
    - 查看器支持分析模式
    - 优化关联日志查看体验
- 日志索引优化
- 优化指标分析的图表查询
- 其他功能优化
    - 在用户访问监测应用列表，点击进入应用，在左上角新增下拉菜单选项，帮助用户快速切换查看不同的应用数据
    - 在指标、用户访问监测、应用性能监测、基础设施、安全巡检目录新增 Pipelines 快捷入口

### DataKit 更新

- DataKit 采集器配置和 Pipeline 支持通过 etcd/Consul 等配置中心来同步
- Prometheus Remote Write 优化
- 采集支持通过正则过滤 tag
- 支持通过正则过滤指标集名称
- Pipeline 优化
- 优化 grok() 等函数，使得其可以用在 if/else 语句中，以判定操作是否生效
- 增加 match() 函数
- 增加 cidr() 函数
- 进程采集器增加打开的文件列表详情字段
- 完善外部接入类数据（T/R/L）的磁盘缓存和队列处理
- Monitor 上增加用量超支提示：在 monitor 底部，如果当前空间用量超支，会有红色文字 Beyond Usage 提示
- 优化日志采集 position 功能，在容器环境下会将该文件外挂到宿主机，避免 DataKit 重启后丢失原有 position 记录
- 优化稀疏日志场景下采集延迟问题

### 最佳实践更新

-  基础设施监控 (ITIM) - Ansible 批处理实战
-  日志 - 观测云采集 Amazon ECS 日志

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.50.111（2022年10月12日）

pubrepo.guance.com/dataflux/1.50.111:launcher-a3b4793-1665543227

此版本是 fix 版本，主要有如下更新:

### 观测云更新

- 修复 Pipeline 测试器无法正常使用的问题


## v1.50.110（2022年9月29日）

pubrepo.guance.com/dataflux/1.50.110:launcher-bf5e4a7-1664640281

### 观测云更新

- 新增字段管理
- 指标查看器改造，原「指标查看器」更改为「指标分析」
- 优化指标管理
- 新增以 PDF 格式导出事件内容
- 监控器调整
- 静默规则支持动态配置
- 优化 Pipeline 配置页面
- 其他功能优化
    - 笔记新增全局锁定时间配置，配置好全局锁定时间后，该笔记页面的所有图表都按照该锁定时间显示数据
    - 未恢复事件查询修改成最近 48 小时数据，支持手动刷新
    - 用户访问监测支持同名用户视图覆盖逻辑
    - 智能巡检新增支持自建巡检
    - 生成指标页面操作列调整，新增“在指标分析中打开”和“在指标管理中打开”操作图标
    - 管理导航菜单位置调整，SSO 管理迁移至成员管理，通知对象管理迁移至监控，内置视图迁移至场景

### 最佳实践更新

- 云原生：多个 Kubernetes 集群指标采集最佳实践

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.49.108 (2022年9月23日)

pubrepo.guance.com/dataflux/1.49.108:launcher-833084a-1663915927

### 观测云更新

- 修复几个小 bug

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.49.107 (2022年9月15日)

pubrepo.guance.com/dataflux/1.49.107:launcher-e550301-1663603951

### 观测云更新

- 优化笔记文本组件 Markdown 格式
- 新增基础设施 YAML 显示
- 新增日志查看器 DQL 搜索模式
- 优化应用性能监测，包括链路和Profile 查看器详情页优化
- 优化监控器事件通知内容编辑模式
- 新增静默管理支持配置周期性静默
- 其他功能优化
    - 场景仪表板分组显示优化
    - 基础设施查看器显示优化，新增显示列 CPU 使用率、MEM 使用率等提示信息
    - 指标查看器删除列表查看模式，保留平铺查看模式和混合查看模式
    - 日志多索引支持跳转查看
    - 查看器快捷筛选值 TOP 5 支持查看占比数量，查看器时间字段格式优化，默认显示格式为 2022/09/15 20:53:40
    - 链路查看器时序图新增图例显示、快捷筛选新增 HTTP 相关字段

### 最佳实践更新

- 监控 Monitoring- 中间件（Middleware） - 洞见 MySQL

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

## v1.48.106(2022年9月1日)

pubrepo.guance.com/dataflux/1.48.106:launcher-e40becc-1662478572

### 观测云更新

- 计费更新
- 帮助文档目录更新
- 新增 DEMO 工作空间
- 时序图新增事件关联分析
- 日志新增多索引模式
- 优化备份日志规则
- 优化日志上下文
- 优化用户访问监测
    - 新增自定义用户访问监测应用 ID
    - 新增用户访问监测网络请求 ERROR 错误关联链路查看
- 智能巡检全面升级
- 优化监控
    - 调整分组为告警策略
    - 优化监控器配置
    - 新增「基础设施存活检测」
    - 新增「进程异常检测」
    - 优化「应用性能指标检测」
- 优化成员管理
- 其他功能优化
    - 图表中指标聚合函数从默认的 last 变更为 avg，日志类数据聚合函数从默认的 last 变更为 count
    - 优化时序图、饼图图例复制体验
    - 优化笔记编辑模式下的交互显示
    - 快照支持保存当前查看器的显示列信息
    - 链路详情页针对时间的字段做格式化显示，把时间戳转换成日期格式显示
    - 部署版管理后台支持修改工作空间的数据保存策略

### DataKit 更新

**1.Breaking changes**

- Gitlab 以及 Jenkins 采集器中，CI/CD 数据有关的时间字段做了调整，以统一前端页面的数据展示效果

**2.采集器功能调整**

- 优化 IO 模块的数据处理，提升数据吞吐效率
- 在各类 Trace 上加上的磁盘缓存功能
- DataKit 自身指标集增加 goroutine 使用有关的指标集（`datakit_goroutine`）
- MySQL 采集器增加 `mysql_dbm_activity` 指标集
- 增加netstat 采集器
- TDengine 增加日志采集
- 优化磁盘采集器中的 fstype 过滤，默认只采集常见的文件系统
- 日志采集器中，针对每条日志，增加字段 `message_length` 表示当前日志长度，便于通过长度来过滤日志
- CRD 支持通过 DaemonSet 来定位 Pod 范围
- eBPF 移除 go-bindata 依赖
- 容器采集器中默认会打开k8s 和容器相关的指标，这在一定程度上会消耗额外的时间线

**3.Bug 修复**

- 修复 DataKit 自身 CPU 使用率计算错误
- 修复 SkyWalking 中间件识别问题
- 修复 Oracle 退出问题
- 修复 Sink DataWay 失效问题
- 修复 HTTP /v1/write/:category 接口 JSON 写入问题

**4.文档调整**

- 几乎每个章节都增加了跳转标签，便于其它文档永久性引用
- pythond 文档已转移到自定义开发目录
- 采集器文档从原来「集成」迁移到 「DataKit」文档库
- DataKit 文档目录结构调整，减少了目录层级
- 几乎每个采集器都增加了 k8s 配置入口
- 调整文档头部显示，除了操作系统标识外，对支持选举的采集器，增加选举标识

更多 DataKit 更新可参考 [DataKit 版本历史](https://docs.guance.com/datakit/changelog/) 。

### 最佳实践更新

- 云原生
    - [使用 CRD 开启您的 Ingress 可观测之路](https://docs.guance.com/best-practices/cloud-native/ingress-crd/)
- 监控 Monitoring
    - 应用性能监控 (APM) - [DDtrace 自定义 Instrumentation](https://docs.guance.com/best-practices/monitoring/ddtrace-instrumentation/)
    - 应用性能监控 (APM) - [DDtrace 观测云二次开发实践](https://docs.guance.com/developers/ddtrace-guance/)

更多最佳实践更新可参考 [最佳实践版本历史](https://docs.guance.com/best-practices/) 。

## v1.47.103(2022年8月18日)

pubrepo.guance.com/dataflux/1.47.103:launcher-e472ac9-1661174654 

### 观测云计费更新

- 观测云计费项应用性能、用户访问、日志新增数据保存策略以及对应单价

### 观测云更新

- 优化查看器
    - 新增筛选历史
    - 新增快捷筛选值排序
    - 新增时间控件输入格式提示页
    - 新增显示列字段分割线及文案提示
- 新增场景仪表板**/**笔记**/**查看器的查看权限。
- 新增快照的查看权限
- 优化监控器和事件
    - 新增监控器测试
    - 优化智能巡检信息展示
    - 优化事件详情页
- 其他功能优化
    - 观测云新增支持邮箱验证方式认证
    - 查看器详情页关联网络页面优化主机、Pod、Deployment 类型显示；
    - 仪表板和内置视图等地方添加图表时新增切换图标，调整视图变量编辑按钮位置；
    - 时序图图例值新增 sum 求和统计，同时优化图例显示和交互；
    - 监控器、图表查询日志类数据时筛选条件新增 wildcard 和 not wildcard 。

### DataKit 更新

- Pipeline 中新增 reftable 功能
- DataKit 9529 HTTP 支持绑定到 domain socket
    - 对应的 eBPF 采集和 Oracle 采集，其配置方式也需做对应变更。
- RUM sourcemap 增加 Android R8 支持
- CRD 增加日志配置支持
    - 完整示例
- 优化容器采集器文档
- 新增常见 Tag 文档
- 优化选举的配置和一些相关的命名
- 选举类采集器在 DataKit 开启选举的情况下，仍然支持在特定的采集器上关闭选举功能
- 支持指定数据类型的 io block 配置
- DDTrace 采集器的采样增加 meta 信息识别
- DataKit 自身指标集增加 9529 HTTP 请求相关指标
- 优化 Zipkin 采集的内存使用
- DDTrace 采集器在开启磁盘缓存后，默认变成阻塞式 IO feed
- eBPF 增加进程名（process_name）字段
- DCA 新版本发布
- 日志类 HTTP 数据写入（logstreaming/Jaeger/OpenTelemetry/Zipkin）均增加队列支持
- 日志采集增加自动多行支持
- 修复 MySQL 采集器连接泄露问题
- 修复 Pipeline Json 取值问题
- 修复 macOS 上 ulimit 设置无效问题
- 修复 sinker-Dataway 在 Kubernetes 中无效问题
- 修复 HTTP 数据写入类接口数据校验问题
- 修复 eBPF 采集器因内核变更后结构体偏移计算失败问题
- 修复 DDTrace close-resource 问题

### 最佳实践更新

- 监控 Monitoring
    - 使用 extract + TextMapAdapter 实现了自定义 traceId
- 洞见 Insight
    - 场景(Scene) - CDB
    - 场景(Scene) - CLB
    - 场景(Scene) - COS
    - 场景(Scene) - CVM
    - 场景(Scene) - 内网场景 Dubbo 微服务接入观测云

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.46.102(2022年8月10日)

pubrepo.guance.com/dataflux/1.46.102:launcher-9765d09-1660104260 

### 观测云更新
- Func 平台小 bug 修复

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.46.101(2022年8月9日)

pubrepo.guance.com/dataflux/1.46.101:launcher-a785aaa-1660058667 

### 观测云更新
- DCA Web 端上线
- 优化查看器搜索、快捷筛选、时间控件、显示列
- 优化查看器详情页
- 新增全局的查看器自动刷新配置
- 新增全局黑名单功能
- 新增自定义功能菜单
- 新增图表查询别名
- 新增时序图、饼图图例样式
- 优化对象历史数据保存策略
- 调整保存快照的位置
- 其他功能优化
    - 时序图时间间隔新增到毫秒级
    - 管理后台新增工作空间级别的索引配置调整入口
    - 日志查看器分布图新增支持自定义选择时间间隔
    - RUM查看器页面新增当前数据扩展字段页面展示

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.45.100(2022年8月4日)

pubrepo.guance.com/dataflux/1.45.100:launcher-38e7844-1659597427 

### 观测云更新

- 优化链路写入性能
- 其他的一些 bug 修复

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)


## v1.45.99(2022年7月26日)

pubrepo.guance.com/dataflux/1.45.99:launcher-fe8f074-1658756821 

### 观测云更新
- 新增智能巡检功能：内存泄漏、磁盘使用率、应用性能检测
- 优化查看器搜索和筛选功能：搜索新增「not wildcard 反向模糊匹配」、快捷筛选新增空间级和个人级筛选方式
- 新增修改** URL **中的时间范围进行数据查询
- 新增仪表板视图变量日志、应用性能、用户访问、安全巡检数据来源配置
- 优化图表查询交互
- 新增用户访问指标检测事件通知模板变量
- 优化事件内容一键打开链接

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

### 最佳实践更新

- [Rancher部署DataKit最佳实践](https://preprod-docs.cloudcare.cn/best-practices/partner/rancher-datakit-install/)
- [腾讯云产品可观测最佳实践(Function)](https://preprod-docs.cloudcare.cn/best-practices/partner/tencent-prod-func/)

更多详情可参考最佳实践帮助文档：[https://docs.guance.com/best-practices/](https://docs.guance.com/best-practices/)

### DataKit 更新

- prom 采集器的内置超时时长为 3 秒
- 日志相关问题修复：
    - 添加日志采集的 log_read_offset 字段
    - 修复日志文件在 rotate 后没有正确 readAll 的 bug
- 容器采集相关问题修复：
    - 修复对环境变量 NODE_NAME 的不兼容问题
    - k8s 自动发现的 prom 采集器改为串行式的、node 分散采集
    - 添加日志 source 和多行的的映射配置
    - 修复容器日志替换 source 后还使用之前的 multiline 和 pipeline 的 bug
    - 修正容器日志，设置文件活跃时长是 12 小时
    - 优化 docker 容器日志的 image 字段
    - 优化 k8s pod 对象的 host 字段
    - 修复容器指标和对象采集没有添加 host tag 的问题
- eBPF 相关：
    - 修复 uprobe event name 命名冲突问题
    - 增加更多环境变量配置，便于云 k8s 环境的部署
- 优化 APM 数据接收接口的数据处理，缓解卡死客户端以及内存占用问题
- SQLServer 采集器修复：
    - 恢复 TLS1.0 支持
    - 支持通过 instance 采集过滤，以减少时间线消耗
- Pipeline 函数 adjust_timezone() 有所调整
- IO 模块优化，提高整体数据处理能力，保持内存消耗的相对可控
- Monitor 更新：
    - 修复繁忙时 Monitor 可能导致的长时间卡顿
    - 优化 Monitor 展示，增加 IO 模块的信息展示，便于用于调整 IO 模块参数
- 修复 Redis 奔溃问题
- 去掉部分繁杂的冗余日志
- 修复选举类采集器在非选举模式下不追加主机 tag 的问题

更多详情可参考 DataKit 帮助文档：[https://docs.guance.com/datakit/changelog/](https://docs.guance.com/datakit/changelog/) 

## v1.44.98(2022年7月7日)

pubrepo.guance.com/dataflux/1.44.98:launcher-75d7974-1657638696 

### 观测云更新

- 优化查看器正选、反选、模糊匹配三种筛选模式
- 优化查看器快捷筛选
- 新增查看器显示列多种快捷操作
- 优化查看器详情页属性/字段快捷筛选
- 优化历史快照功能，支持三种时间保存策略
- 新增 Pipeline 一键获取样本测试数据
- 新增场景自定义查看器文本分析模式
- 新增日志查看器详情页关联网络 pod 和 deployment 视图
- 新增查看器详情页关联网络 48 小时数据回放功能
- 调整未恢复事件保存策略，支持手动恢复事件
- 其他功能优化
  - 图表锁定时间新增【最新5分钟】时间范围，时间间隔新增【5s】【10s】【30s】三个秒级时间选择
  - 场景查看器显示列、视图变量基础对象字段属性/标签支持自定义输入
  - 调整事件详情关联仪表板位置
  - 在指标管理新增时间线数量统计
  - 优化日志详情页关联链路，根据日志当中的 trace_id 和 span_id 显示火焰图并选中对应span的所有数据
  - 优化用户访问监测服务显示及交互
  - RUM、网络、可用性监测、CI 查看器下拉选项调整为平铺显示
  - 监控器事件通知内容支持配置模版变量字段映射，支持通过在 DQL 查询语句配置模版变量对应值。
  - 帮助中心首页新增重点功能快捷跳转入口

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/)

### DataKit 更新

- 调整全局 tag 的行为，避免选举类采集的 tag 分裂
- SQLServer 采集器增加选举支持
- 行协议过滤器支持所有数据类型
- 9529 HTTP 服务增加超时机制
- MySQL：dbm 指标集名字调整、service 字段冲突问题
- 容器对象增加字段 container_runtime_name 以区分不同层次的容器名
- Redis 调整 slowlog 采集，将其数据改为日志存储
- 优化 TDEngine 采集
- 完善 Containerd 日志采集
- Pipeline 增加 Profile 类数据支持
- 容器/Pod 日志采集支持在 Label/Annotation 上额外追加 tag
- 修复 Jenkins CI 数据采集的时间精度问题
- 修复 Tracing resource-type 值不统一的问题
- eBPF 增加 HTTPS 支持
- 修复日志采集器可能的奔溃问题
- 修复 prom 采集器泄露问题
- 支持通过环境变量配置 io 磁盘缓存
- 增加 Kubernetes CRD 支持

更多详情可参考 DataKit 帮助文档：[https://docs.guance.com/datakit/changelog/](https://docs.guance.com/datakit/changelog/)

### 最佳实践更新

- Skywalking 采集 JVM 可观测最佳实践
- Minio 可观测最佳实践

更多详情可参考最佳实践帮助文档：[https://docs.guance.com/best-practices/](https://docs.guance.com/best-practices/) 

## v1.43.97(2022年6月22日)

pubrepo.guance.com/dataflux/1.43.97:launcher-508cfe1-1656344897 

### 观测云更新
- 观测云帮助文档全新上线
- 新增 Profile 可观测
- Pipeline 覆盖了全数据的文本分析处理
- 新增 Deployment 网络详情及网络分布
- 优化事件检测维度跳转到其他查看器
- 新增日志查看器 JSON 格式的 message 信息搜索
- 新增用户访问监测新建应用时支持用户自定义输入 app_id 信息
- 优化进程检测为基础设施对象检测
- 其他功能优化
    - 基础设施POD查看器蜂窝模式下新增 CPU 使用率、内存使用量填充指标
    - 优化日志黑名单配置。支持手动输入日志来源，作为日志黑名单的来源
    - 优化应用性能监测服务列表数据查询时间组件，支持自定义时间范围选择
    - 优化在 K8S 上安装 DataKit 引导文案，配置 DataWay 数据网关地址中自动增加当前工作空间的 token
    - 优化监控器配置 UI 样式 

### DataKit 更新

- gitrepo 支持无密码模式
- prom 采集器
- 支持日志模式采集
- 支持配置 HTTP 请求头
- 支持超 16KB 长度的容器日志采集
- 支持 TDEngine 采集器
- Pipeline
- 支持 XML 解析
- 远程调试支持多类数据类型
- 支持 Pipeline 通过 use() 函数调用外部 Pipeline 脚本
- 新增 IP 库（MaxMindIP）支持
- 新增 DDTrace Profile 集成
- Containerd 日志采集支持通过 image 和 K8s Annotation 配置过滤规则
- 文档库整体切换 

### 最佳实践更新

- APM：GraalVM 与 Spring Native 项目实现链路可观测
- 接入集成：主机可观测最佳实践 (Linux) 

### 集成模版更新
- 新增文档
    - 阿里云 NAT
    - 阿里云 CDN
- 新增视图
    - 阿里云 NAT
    - 阿里云 CDN 

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.42.95(2022年6月10日)
pubrepo.guance.com/dataflux/1.42.95:launcher-8478e83-1654839989 

### 观测云计费更新

- 优化时间线计费逻辑，以及指标数据的数据保存策略

### 观测云更新

- 新增 Jenkins CI 可观测
- 新增自定义查看器图表同步搜索
- 新增网络拓扑和服务拓扑下钻分析
- 新增删除自定义对象的数据及索引
- 新增查看器快照查看入口
- 新增查看器筛选条件编辑功能
- 优化用户访问 View 查看器关联链路为 Fetch/XHR
- 新增图表数据加载高性能模式
- 新增告警配置事件通知等级
- 其他功能优化
    - 场景仪表板组合图表支持隐藏/显示大标题
    - 优化事件详情页事件类型文案显示
    - 基础设施列表查看新增按照字段排序功能
    - 日志查看器新增隐藏分布图按钮
    - 查看器支持通过关键字搜索显示列，支持自定义显示列作为预设字段，后续通过Pipeline切割字段并上报数据后可直接显示上报的数据。
    - 在内置模板库和内置视图增加一键查看对应的集成文档，帮助您快速配置对应的采集器
    - 内置视图除支持在查看器绑定链路服务、应用、日志源、项目、标签等相关视图外，新增支持自定义 key 和 value 绑定相关视图，同时支持服务侧滑详情页绑定内置视图
    - 优化通知对象飞书机器人，支持自定义是否需要密钥安全校验
    - 配置监视器时，若配置的数据范围小于检测频率，触发提示配置会存在数据空洞问题

### DataKit 更新（2022/5/12）

- Pipeline 做了调整，所有数据类型，均可通过配置 Pipeline 来额外处理数据
- grok() 支持直接将字段提取为指定类型，无需再额外通过 cast() 函数进行类型转换
- Pipeline 增加多行字符串支持，对于很长的字符串（比如 grok 中的正则切割），可以通过将它们写成多行，提升了可读性
- 每个 Pipeline 的运行情况，通过 datakit monitor -V 可直接查看
- 增加 Kubernetes Pod 对象 CPU/内存指标
- Helm 增加更多 Kubernetes 版本安装适配
- 优化 OpenTelemetry，HTTP 协议增加 JSON 支持
- DataKit 在自动纠错行协议时，对纠错行为增加了日志记录，便于调试数据问题
- 移除时序类数据中的所有字符串指标
- 在 DaemonSet 安装中，如果配置了选举的命名空间，对参与选举的采集器，其数据上均会新增特定的 tag（election_namespace）
- CI 可观测，增加 Jenkins 支持

### 最佳实践更新

- APM
    - 基于观测云，使用 SkyWalking 实现 RUM、APM 和日志联动分析
- 监控最佳实践
    - OpenTelemetry 可观测建设
    - OpenTelemetry to Jeager 、Grafana、ELK
    - OpenTelemetry to Grafana
    - OpenTelemetry to 观测云
- 观测云小妙招
    - OpenTelemetry 采样最佳实践

### 集成模版更新

- 新增文档和视图
    - Opentelemetry Collector
    - Kubernetes Scheduler
    - Kubernetes Controller Manager
    - Kubernetes API Server
    - Kubernetes Kubelet
- 新增视图
    - Kubernetes Nodes Overview
    - JVM Kubernetes

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.41.94(2022年5月28日)

pubrepo.guance.com/dataflux/1.41.94:launcher-249ba21-1653737335 

### 观测云更新

- 优化观测云商业版注册流程
- 新增场景仪表板用户视图模版库
- 新增场景自定义查看器日志来源及筛选联动
- 新增事件详情页内容复制为Json格式
- 新增日志数据脱敏处理
- 优化日志查看器及详情页
- 新增网络数据检测监控器
- 优化内置视图绑定功能
- 其他功能优化
    - 付费计划与账单新增储值卡余额
    - 基础设施详情样式优化
    - 链路详情页属性换行显示优化
    - 监控器配置模版变量显示优化
    - 增加快捷入口，DQL查询和快照菜单移至快捷入口下
    - 观测云管理后台补充模版管理分类信息

### DataKit 更新（2022/5/12）

- eBPF 增加 arm64 支持
- 行协议构造支持自动纠错
- DataKit 主配置增加示例配置
- Prometheus Remote Write 支持 tag 重命名
- 合并社区版 DataKit 已有的功能，主要包含 Sinker 功能以及 filebeat 采集器
- 调整容器日志采集，DataKit 直接支持 containerd 下容器 stdout/stderr 日志采集
- 调整 DaemonSet 模式下主机名获取策略
- Trace 采集器支持通过服务名（service）通配来过滤资源（resource）

### 最佳实践更新

- 云原生
    - 利用观测云一键开启Rancher可观测之旅
- 微服务可观测最佳实践
    - Kubernetes 集群 应用使用 SkyWalking 采集链路数据
    - Kubernetes 集群日志上报到同节点的 DataKit 最佳实践
- Gitlab-CI 可观测最佳实践

### 集成模版更新

- 新增文档和视图
    - Resin
    - Beats
    - Procstat
- 新增视图
    - Istio Service
    - ASM Service

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.40.93(2022年5月9日)

pubrepo.guance.com/dataflux/1.40.93:launcher-aa97377-1652102035 

### 观测云更新

- 优化观测云商业版升级流程
- 新增进程、日志、链路详情页关联网络
- 场景模块优化
    - 优化仪表板，去掉编辑模式
    - 新增图表链接显示开关
    - 优化 DQL 查询与简单查询转换
- 监控器和事件模块优化
    - 新增事件关联信息
    - 新增无数据事件名称和内容配置
    - 优化可用性数据检测
    - 优化告警通知模版，增加关联跳转链接
- 其他功能优化
    - 优化服务 servicemap 指标查询性能
    - 新增查看器数值型字段支持5种写法
    - 新增指标查看器标签支持级联筛选
    - 优化 DQL 查询返回报错提示

### DataKit 更新

- 进程采集器的过滤功能仅作用于指标采集，对象采集不受影响
- 优化 DataKit 发送 DataWay 超时问题
- 优化 Gitlab 采集器 
- 修复日志采集截断的问题
- 修复各种 trace 采集器 reload 后部分配置不生效的问题

### 集成模版更新

- 新增数据存储 Redis Sentinel 集成文档和视图

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.39.92(2022年5月5日)

pubrepo.guance.com/dataflux/1.39.92:launcher-ffcd8f2-1651715327 

### 安装器 Launcher：

- 支持更换域名的 TLS 证书
- 适配 Ingress Kind 的 networking.k8s.i0/v1、extensions/v1beta1 两种 apiVersion
- 其他一些小 Bug 修复

## v1.39.91(2022年4月26日)

pubrepo.guance.com/dataflux/1.39.91:launcher-8943ead-1650979666 

### 观测云更新

- 一些前端 Bug 修复

## v1.39.90(2022年4月25日)

pubrepo.guance.com/dataflux/1.39.90:launcher-23f161d-1650898148 

### 观测云社区版上线

### 观测云更新

- 新增 Gitlab CI 可观测
- 新增在线帮助手册
- 新增仪表板设置刷新频率
- 新增进程 48 小时回放
- 新增集成 DataKit Kubernetes(Helm)安装引导页
- 新增应用性能全局概览、服务分类筛选、服务拓扑图区分环境和版本
- 其他功能优化
    - 新增链路详情页中关联日志“全部来源”选项 
    - 新增指标筛选支持反选，聚合函数位置调整
    - 优化日志、应用性能、用户访问、安全巡检生成指标，“频率”所选时间也作为聚合周期
    - 优化观测云部署版工作空间拥有者移交权限功能取消，支持管理后台设置
    - 优化告警通知短信模版
    - 优化可用性监测新建拨测列表，支持直接选择 HTTP、TCP、ICMP、WEBSOCKET 拨测
    - SSO登录配置用户白名单调整为邮箱域名，用于校验单点登录处输入邮箱后缀是否匹配，匹配的邮箱可以在线获取SSO的登录链接

### DataKit 更新

- Pipeline 模块修复 Grok 中动态多行 pattern 问题
- DaemonSet 优化 Helm 安装，增加开启 pprof 环境变量配置，DaemonSet 中所有默认开启采集器各个配置均支持通过环境变量配置
- Tracing 采集器初步支持 Pipeline 数据处理，参考 DDtrace 配置示例。
- 拨测采集器增加失败任务退出机制
- 日志新增 unknown 等级（status），对于未指定等级的日志均为 unknown
- 容器采集器修复：
    - 修复 cluster 字段命名问题
    - 修复 namespace 字段命名问题
    - 容器日志采集中，如果 Pod Annotation 不指定日志 source，那么 source 默认的取值顺序依次为
    - 对象上报不再受 32KB 字长限制（因 Annotation 内容超 32KB），所有 Kubernetes 对象均删除 annotation 
    - 修复 prom 采集器不因 Pod 退出的问题

### 最佳实践更新

- 微服务可观测最佳实践
    - service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)
    - service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(下)
    - service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(中)
- 监控最佳实践
    - JAVA OOM异常可观测最佳实践

### 集成模版更新

- 新增文档
    - 应用性能监测 (APM)：Node.JS
    - 中间件：RocketMQ
- 新增视图
    - 容器编排：K8s Pods Overview 和 Istio Mesh
    - 阿里云：阿里云 ASM Mesh、阿里云 ASM Control Plane 和 阿里云 ASM Workload
    - 中间件：RocketMQ

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.38.89(2022年4月10日)

pubrepo.guance.com/dataflux/1.38.89:launcher-db22a51-1649942760 

### 观测云计费更新

- 新增阿里云账户结算方式

### 观测云更新

- 新增 DQL 查询查看器
- 可用性监测新增 TCP/ICMP/Websocket 拨测协议
- 新增基础设施网络模块
- 基础设施容器 Pod 新增 HTTP 七层网络数据展示
- 新增查看器快捷筛选“反选”和“重置”功能
- 优化日志黑名单
- 其他功能优化
    - 新增链路详情页 span 数量统计
    - 优化链路关联主机时间线绘制方式
    - 优化概览图时间分片，取消选项，若之前的概览图开启了时间分片，优化后默认更改为不开启时间分片
    - 优化组合图表在浏览器缩放情况下，进入编辑后无法实现组合图表切换编辑不同的图表查询
    - 优化日志查看器手动暂停页面刷新后，滚轴滑动到顶部不触发自动刷新 

### DataKit 更新

- 增加宿主机运行时的内存限制，安装阶段即支持内存限制配置，
- CPU 采集器增加 load5s 指标
- 支持观测云优化的日志黑名单功能，调整 monitor 布局，增加黑名单过滤情况展示
- DaemonSet 安装增加 Helm 支持，新增 DaemonSet 安装最佳实践
- eBPF 增加 HTTP 协议采集，主机安装时，eBPF 采集器默认不再会安装，如需安装需用特定的安装指令，DaemonSet 安装不受影响

### 观测云移动端 APP 更新

- 新增站点登陆的能力，优化场景、事件查看器，保持了与网页端查看器相同的访问体验。 

### 最佳实践更新

- 观测云小妙招
    - 多微服务项目的性能可观测实践
    - ddtrace 高级用法
    - Kubernetes 集群使用 ExternalName 映射 DataKit 服务
- 接入(集成)最佳实践
    - OpenTelemetry 链路数据接入最佳实践
- 微服务可观测最佳实践
    - 基于阿里云 ASM 实现微服务可观测最佳实践

### 集成模版更新

- 新增阿里云 PolarDB Oracle 集成文档、视图和监控器
- 新增阿里云 PolarDB PostgreSQL 集成文档、视图和监控器
- 新增阿里云 RDS SQLServer 集成文档、视图和检测库
- 新增阿里云 DataKit 集成文档、视图和监控器
- 新增阿里云 Nacos 集成文档、视图

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.37.86(2022年3月28日)

pubrepo.guance.com/dataflux/1.37.86:launcher-bd2650e-1648456839

### 观测云站点更新

- 新增“海外区1（俄勒冈）”站点，原“中国区1（阿里云）”变更为“中国区1（杭州）”，原“中国区2（AWS）”变更为“中国区2（宁夏）”。

### 观测云更新

- 新增工作空间数据授权
- 新增保存在线 Pipeline 样本测试数据
- 优化自定义对象查看器
- 优化快照分享支持永久有效的链接
- 优化图表时间间隔
- 优化进程、应用性能、用户访问检测无数据触发策略
- 其他功能优化
    - 优化集成DataKit、Func 安装引导页
    - 优化日志查看器单条日志完全展示
    - 新增查看器关联搜索 NOT 组合
    - 优化编辑成员权限显示

### DataKit 更新

- 增加 DataKit 命令行补全功能，帮助您在终端操作的时候进行命令提示和补全参数
- 允许 DataKit 升级到非稳定版，体验最新的试验性功能，若您是生产环境，请谨慎升级
- 初步支持 Kubernetes/Containerd 架构的数据采集
- 网络拨测增加 TCP/UDP/ICMP/Websocket 几种协议支持
- 调整 Remote Pipeline 的在 DataKit 本地的存储，避免不同文件系统差异导致的文件名大小写问题
- Pipeline新增 decode() 函数，可以避免在日志采集器中去配置编码，在 Pipeline 中实现编码转换；add_pattern() 增加作用域管理

### 最佳实践更新

- 场景最佳实践：RUM 数据上报 DataKit 集群最佳实践
- 日志最佳实践：Pod 日志采集最佳实践

### 集成模板更新

- 新增阿里云 PolarDB Mysql 集成文档、视图和检测库

更多详情可参考帮助文档：[https://docs.guance.com/release-notes/](https://docs.guance.com/release-notes/) 

## v1.36.85(2022年3月14日)

pubrepo.guance.com/dataflux/1.36.85:launcher-d8e6ee9-1647272237 

### 观测云计费更新

- 新增观测云计费储值卡

### 观测云更新

- 新增用户访问监测 resource（资源）、action（操作）、long_task（长任务）、error（错误）查看器
-  新增 Pod 网络详情及网络分布

### DataKit 更新

- DataKit 采集器新增支持 SkyWalking、Jaeger、Zipkin 数据配置采样策略，更多详情可参考 Datakit Tracing Frontend 。
- DataKit 采集器新增支持 OpenTelemetry 数据接入 。
- DataKit 文档库新增文档 DataKit 整体日志采集介绍，包括从磁盘文件获取日志、通过调用环境 API 获取日志、远程推送日志给 DataKit、Sidecar 形式的日志采集四种方式。

### SDK 更新

- 用户访问监测兼容 Opentracing 协议链路追踪工具，Web、小程序、Android、iOS SDK 支持 OTEL、SkyWalking、Jaeger 等链路追踪工具数据联动。

### 最佳实践更新

- 快速上手 pythond 采集器的最佳实践
- 阿里云“云监控数据”集成最佳实践
- logback socket 日志采集最佳实践

### 场景模板更新

- 新增场景自定义查看器 MySQL 数据库查看器模板

### 集成模板更新

- 新增主机系统 EthTool 集成文档和视图
- 新增主机系统 Conntrack 集成文档和视图

## v1.35.84(2022年2月22日)

pubrepo.guance.com/dataflux/1.35.84:launcher-191ef71-1645780061 

- 新增日志配置 **pipeline** 脚本
- 新增 **IFrame** 图表组件
- 新增事件详情历史记录、关联 **SLO**
- 新增保存快照默认开启绝对时间
- 优化监控器无数据触发事件配置及触发条件单位提示
- 优化图表查询表达式计算单位
- 新增“时间线”按量付费模式
- 其他优化功能
    - 图表查询数据来源日志、应用性能、安全巡检和网络支持全选（*）;
    - 图表查询文案、按钮样式以及文字提示优化；
    - 工作空间操作按钮图标化，如编辑、删除等等。
    - 其他 UI 显示优化

