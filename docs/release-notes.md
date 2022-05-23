---

本文档记录观测云每次上线发布的更新内容说明，包括 DataKit、Function、观测云最佳实践、观测云集成文档和观测云。

## 2022 年 5月 19号

### 观测云更新

#### **新增一键注册观测云商业版**

观测云注册时，提供免费版和商业版注册选项，您可以按照实际需求注册观测云账号。观测云支持按需购买，按量付费的计费方式，为您提供开箱即用，实现全面观测的云平台。

| **区别** | **项目** | **免费版** | **商业版** |
| --- | --- | --- | --- |
| 数据 | DataKit 数量 | 不限 | 不限 |
|  | 每日数据上报限制 | 有限数据上报 | 不限 |
|  | 数据存储策略 | 7 天循环 | 自定义存储策略 |
| 功能 | 基础设施 | 
- [x] 

 | 
- [x] 

 |
|  | 日志 | 
- [x] 

 | 
- [x] 

 |
|  | 备份日志 | / | 
- [x] 

 |
|  | 应用性能监测 | 
- [x] 

 | 
- [x] 

 |
|  | 用户访问监测 | 
- [x] 

 | 
- [x] 

 |
|  | CI 可视化监测 | 
- [x] 

 | 
- [x] 

 |
|  | 安全巡检 | 
- [x] 

 | 
- [x] 

 |
|  | 监控 | 
- [x] 

 | 
- [x] 

 |
|  | 可用性监测 | 中国区拨测 | 全球拨测 |
|  | 短信告警通知 | / | 
- [x] 

 |
|  | DataFlux Func | 
- [x] 

 | 
- [x] 

 |
| 服务 | 基础服务 | 社区、电话、工单支持(5 x 8 小时) | 社区、电话、工单支持(5 x 8 小时) |
|  | 培训服务 | 可观测性定期培训 | 可观测性定期培训 |
|  | 专家服务 | / | 专业产品技术专家支持 |
|  | 增值服务 | / | 互联网专业运维服务 |
|  | 监控数字作战屏 | / | 可定制 |


#### 新增用户视图一键创建新的场景仪表板

观测云内置60余种系统视图模板，无需配置，即选即用，满足你各种监控场景的需求，您可以自定义视图作为用户视图模版来一键创建仪表板。更多仪表板的搭建可参考文档 [仪表板](https://www.yuque.com/dataflux/doc/gqatnx) 。
![1.dashboard_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652939739991-4c8eebae-090a-4212-9087-8ec99b3e48b8.png#clientId=u7b4ab888-56ce-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u56392036&margin=%5Bobject%20Object%5D&name=1.dashboard_1.png&originHeight=777&originWidth=1335&originalType=binary&ratio=1&rotation=0&showTitle=false&size=91619&status=done&style=stroke&taskId=u59cae9a1-2023-4d32-9abf-c57f80e6962&title=)

#### 新增场景自定义查看器日志来源及筛选联动

场景自定义查看器的数据范围新增筛选功能，基于日志来源，筛选该日志来源下的字段数据，支持匹配多个字段数据，配合搜索和分组可对日志数据进一步筛选。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652962124414-02138700-a26b-43d9-ad23-6b3b289886d6.png?x-oss-process=image%2Fresize%2Cw_750%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=wSyFc&margin=%5Bobject%20Object%5D&originHeight=374&originWidth=750&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 新增事件详情页内容复制为Json格式

在事件详情页，支持点击“复制事件完整内容”按钮，获取当前事件所对应的所有关键数据，若在配置监控器时关联了仪表板，可点击“关联仪表板”按钮跳转到对应的仪表板。

在事件详情页的“关联信息”，若“日志检测”配置多个表达式查询（同一个对象类型），关联信息支持多个表达式查询的 tab 切换，若有两个表达式查询 A 和 B，则在关系信息包含 A 和 B 两个 tab 可切换查看。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652957941001-2bfa76f5-2f95-48a3-876a-59f0efa85a3a.png#crop=0&crop=0&crop=1&crop=1&from=url&id=i96ju&margin=%5Bobject%20Object%5D&originHeight=702&originWidth=1140&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 新增日志数据脱敏处理

观测云新增日志数据脱敏处理，数据采集上报到观测云工作空间以后，部分数据会存在一些敏感信息，比如说 IP 地址、用户信息等，针对这部分信息可以通过配置敏感字段来做脱敏处理。
注意：

- 脱敏后的数据仅支持工作空间管理员及以上的成员进行查看，标准和只读成员无法查看脱敏后的信息。
- 配置敏感字段仅支持工作空间管理员及以上的成员进行操作，标准和只读成员仅支持查看配置的敏感字段。

更多详情可参考文档 [数据权限管理](https://www.yuque.com/dataflux/doc/hgn17u) 。
![3.data_7.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652954199068-e407204e-0612-4942-ae33-c451555d5339.png#clientId=ubd0d6171-c775-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u413adc23&margin=%5Bobject%20Object%5D&name=3.data_7.png&originHeight=616&originWidth=1224&originalType=binary&ratio=1&rotation=0&showTitle=false&size=186011&status=done&style=stroke&taskId=u252915e6-4239-46a1-80be-03e3003e054&title=)

#### 优化日志查看器及详情页

观测云[日志查看器](https://www.yuque.com/dataflux/doc/ibg4fx)默认显示“time”和“message”字段，本次优化支持可隐藏“message”字段显示。

在日志详情页，日志内容根据 message 类型自动显示 Json 和文本两种查看模式。若日志没有 message 字段，则不显示日志内容部分，日志内容支持展开收起，默认为展开状态，收起后仅显示1行的高度。

扩展字段展示日志的所有相关字段，支持“复制”和“添加到筛选”进行快速筛选查看。
![2.log_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652941124663-bbdd28b3-ff8c-43b5-a80a-98b23c16d4f4.png#clientId=u19f0fdeb-488d-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u73adc6af&margin=%5Bobject%20Object%5D&name=2.log_2.png&originHeight=757&originWidth=1139&originalType=binary&ratio=1&rotation=0&showTitle=false&size=138779&status=done&style=stroke&taskId=u1d9fe770-1615-4a21-a65c-2f5707a3ce9&title=)

#### 新增网络数据检测监控器

[网络数据检测](https://www.yuque.com/dataflux/doc/vbeqrd)用于监测工作空间内网络性能的指标数据，通过设置阈值范围，当指标到达阈值后触发告警。“观测云”支持对单个指标设置告警和自定义告警等级。在「监控器」中，点击「+新建监控器」，选择「网络数据检测」，进入检测规则的配置页面。
![6.monitor_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652960028250-4553e4c0-8943-4c99-bf90-0f194b3f86e8.png#clientId=u48281c0a-3e24-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u55910b93&margin=%5Bobject%20Object%5D&name=6.monitor_3.png&originHeight=656&originWidth=951&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74764&status=done&style=stroke&taskId=uac293cf4-0b9e-43b3-be98-e0c1c457ec0&title=)

#### 优化内置视图绑定功能

观测云[内置视图](https://www.yuque.com/dataflux/doc/gyl9vv)包括系统视图和用户视图，本次优化取消自定义绑定系统视图为查看器视图，仅支持绑定用户视图为查看器视图，若需要绑定系统视图，可先克隆系统视图为用户视图，若系统视图和用户视图重名，在查看器优先显示用户视图。关于如何绑定用户视图为查看器视图，可参考文档 [绑定内置视图](https://www.yuque.com/dataflux/doc/dns233) 。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1652956407868-5a02830b-7872-477c-8aeb-58f4defa7731.png?x-oss-process=image%2Fresize%2Cw_750%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=qDv9m&margin=%5Bobject%20Object%5D&originHeight=352&originWidth=750&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 其他功能优化

- 付费计划与账单新增储值卡余额
- 基础设施详情样式优化
- 链路详情页属性换行显示优化
- 监控器配置模版变量显示优化
- 增加快捷入口，DQL查询和快照菜单移至快捷入口下
- 观测云管理后台补充模版管理分类信息

## DataKit 更新（2022/5/12）

- eBPF 增加 arm64 支持
- 行协议构造支持自动纠错
- DataKit 主配置增加示例配置
- Prometheus Remote Write 支持 tag 重命名
- 合并社区版 DataKit 已有的功能，主要包含 Sinker 功能以及 filebeat 采集器
- 调整容器日志采集，DataKit 直接支持 containerd 下容器 stdout/stderr 日志采集
- 调整 DaemonSet 模式下主机名获取策略
- Trace 采集器支持通过服务名（`service`）通配来过滤资源（`resource`）

更多 DataKit 更新可参考 [DataKit 版本历史](https://www.yuque.com/dataflux/datakit/changelog) 。

## 最佳实践更新

- 云原生
   - [利用观测云一键开启Rancher可观测之旅](https://www.yuque.com/dataflux/bp/rancher-datakit)
- 微服务可观测最佳实践
   - [Kubernetes 集群 应用使用 SkyWalking 采集链路数据](https://www.yuque.com/dataflux/bp/k8s-skywalking)
   - [Kubernetes 集群日志上报到同节点的 DataKit 最佳实践](https://www.yuque.com/dataflux/bp/la0i12)
- Gitlab-CI 可观测最佳实践
   - [Gitlab-CI 可观测最佳实践](https://www.yuque.com/dataflux/bp/gitlab-cicd)

更多最佳实践更新可参考 [最佳实践版本历史](https://www.yuque.com/dataflux/bp/changelog) 。

## 集成模版更新

#### 新增文档和视图

- 中间件
   - [Resin](https://www.yuque.com/dataflux/integrations/resin)
   - [Beats](https://www.yuque.com/dataflux/integrations/epsgce)
- 主机系统
   - [Procstat](https://www.yuque.com/dataflux/integrations/ubgene)
#### 新增视图

- 容器编排
   - Istio Service
- 阿里云
   - ASM Service

更多集成模版更新可参考 [集成文档版本历史](https://www.yuque.com/dataflux/integrations/changelog) 。

## 2022 年 5月 6 号

### 观测云更新

#### 优化观测云商业版升级流程

观测云升级到商业版默认开通[观测云费用中心账户结算](https://www.yuque.com/dataflux/doc/xcifgo)，支持更改结算方式为云账号结算，包括[阿里云账号](https://www.yuque.com/dataflux/doc/vgdy2u)和 [AWS 云账号](https://www.yuque.com/dataflux/doc/zszq8p)结算方式。

#### 新增进程、日志、链路详情页关联网络

观测云[进程](https://www.yuque.com/dataflux/doc/yoon4o#AiLrJ)、[日志](https://www.yuque.com/dataflux/doc/ibg4fx#X2gmO)、[链路](https://www.yuque.com/dataflux/doc/qp1efz#QVkkG)详情页新增关联网络数据分析，支持基于 IP/端口查看源主机/源进程服务到目标之间的网络流量和数据连接情况，通过可视化的方式进行实时展示，帮助企业实时了解业务系统的网络运行状态，快速分析、追踪和定位问题故障，预防或避免因网络性能下降或中断而导致的业务问题。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651852713540-8ac30001-4fbb-4cf2-91d1-780e574b0410.png#crop=0&crop=0&crop=1&crop=1&from=url&id=E49zj&margin=%5Bobject%20Object%5D&originHeight=693&originWidth=1145&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 场景模块优化

##### 优化仪表板，去掉编辑模式
在场景[仪表板](https://www.yuque.com/dataflux/doc/gqatnx)顶部导航栏，去掉“编辑”按钮，新增“添加图表”为仪表板添加新的图表，图表添加完成后，点击右上角「完成添加」即可。
![3.view_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651809927764-9b6d717a-95da-44a6-8b99-807ed945193e.png#clientId=u035c389a-289a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u275eb2c8&margin=%5Bobject%20Object%5D&name=3.view_2.png&originHeight=571&originWidth=1240&originalType=binary&ratio=1&rotation=0&showTitle=false&size=111413&status=done&style=stroke&taskId=u8ccd4d53-b303-48d5-9fa4-5e73770a76a&title=)
在[图表](https://www.yuque.com/dataflux/doc/rttwsy)中，点击「设置」按钮，选择「修改」，即可对图表进行编辑。
![3.view_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651809915020-3cf1c983-1e3e-4a9d-b938-ab90cb985342.png#clientId=u035c389a-289a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc44a0f6d&margin=%5Bobject%20Object%5D&name=3.view_1.png&originHeight=455&originWidth=1227&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94696&status=done&style=stroke&taskId=u705db830-a128-468a-85b4-34261d947da&title=)

##### 新增图表链接显示开关
观测云支持图表内置链接和自定义链接，可以帮助您实现从当前图表跳转至目标页面。内置链接是观测云默认为图表提供的关联链接，主要基于当前查询的时间范围和分组标签，帮助您查看对应的日志、进程、容器、链路，内置链接显示开关默认关闭，可在编辑图表时开启；自定义链接创建完成后，显示开关默认开启。更多详情可参考文档 [图表链接](https://www.yuque.com/dataflux/doc/nn6o31#fMzve) 。
![4.link_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651820028660-2159315c-f2e4-41b9-9b27-0cf101e0c4b3.png#clientId=u1be4abcd-8658-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf6011098&margin=%5Bobject%20Object%5D&name=4.link_1.png&originHeight=361&originWidth=1008&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64688&status=done&style=stroke&taskId=u6e8e815e-fdc6-422d-b0f2-e4e5b038582&title=)

##### 优化 DQL 查询与简单查询转换
点击“[DQL 查询](https://www.yuque.com/dataflux/doc/gc6mwk)”右侧的切换按钮![3.dql_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649324053221-27764ea3-80ff-456c-8cd8-f47aa6cd307a.png#clientId=ub66c5fcf-5970-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=upJYW&margin=%5Bobject%20Object%5D&name=3.dql_5.png&originHeight=14&originWidth=19&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7186&status=done&style=stroke&taskId=ufb92460f-fea4-4490-95ef-6369ca07a3a&title=)，可切换 DQL 查询为简单查询。
注意：「DQL查询」切换成「简单查询」时，若无法解析或者解析不完整：

- 在「简单查询」下未操作，直接切换回「DQL查询」则显示之前的 DQL 查询语句；
- 在「简单查询」下调整了查询语句，再次切换回「DQL查询」将按照最新的「简单查询」进行解析。

更多 DQL 查询和简单查询的应用，可参考文档 [图表查询](https://www.yuque.com/dataflux/doc/cxlbps) 。
![3.dql_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320677940-aba9ac38-1125-46b9-8454-0602b1b97cce.png#clientId=u628c267d-b2c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=EFJIo&margin=%5Bobject%20Object%5D&name=3.dql_2.png&originHeight=519&originWidth=1350&originalType=binary&ratio=1&rotation=0&showTitle=false&size=69469&status=done&style=stroke&taskId=uc095cad8-22a1-4497-a391-65baf1d06e0&title=)

#### 监控器和事件模块优化

##### 新增事件关联信息
观测云支持查看触发当前事件的相关信息，如查看触发事件的相关日志。此“关联信息”仅支持 4 种监控器产生的事件：日志检测、安全巡检异常检测、进程异常检测以及可用性数据检测。
![7.event_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651840390781-7afe937a-d03d-480e-8301-1a6fdbea5737.png#clientId=u62dee0eb-a9c5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=l8K8Y&margin=%5Bobject%20Object%5D&name=7.event_1.png&originHeight=328&originWidth=1136&originalType=binary&ratio=1&rotation=0&showTitle=false&size=127857&status=done&style=stroke&taskId=u48e5f142-b151-41da-b17c-c1b4c9d849b&title=)
##### 新增无数据事件名称和内容配置
观测云监控器“阈值检测”、“水位检测”、“区间检测”、“突变检测”、“进程异常检测”、“应用性能指标检测”、“用户访问指标检测”新增无数据事件标题和内容配置，默认不可填写，当选择触发无数据事件时为可填写无数据事件名称，支持使用预置的模板变量，详情参考 [事件名称/内容模板](https://www.yuque.com/dataflux/doc/zvayo3) 。
![6.monitor_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1651836364213-759fbfee-4d27-4e0d-a2d5-978e329ac6a4.png#clientId=u173c3e5f-a205-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6b8a34e8&margin=%5Bobject%20Object%5D&name=6.monitor_2.png&originHeight=493&originWidth=759&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75400&status=done&style=stroke&taskId=u46a8b0ba-811d-4730-b292-d225812daa3&title=)

##### 优化可用性数据检测
观测云监控器[可用性数据检测](https://www.yuque.com/dataflux/doc/he412g)，优化支持选择 HTTP、TCP、ICMP、WEBSOCKET 拨测类型。

##### 优化告警通知模版，增加关联跳转链接
邮件、钉钉、微信、飞书收到的告警通知包含“观测云跳转链接”，点击可直接跳转到对应的观测云事件详情，时间范围为当前时间的往前15分钟，即18:45:00的事件，点击链接后跳转至事件详情页，时间范围固定为4.20 18:30:00 ~ 4.20 18:45:00。更多告警通知可参考文档 [告警设置](https://www.yuque.com/dataflux/doc/qxz5xz) 。

#### 其他功能优化

- 优化服务 servicemap 指标查询性能
- 新增查看器数值型字段支持 > | >= | < | <= | [] 5种写法
- 新增指标查看器标签支持级联筛选
- 优化 DQL 查询返回报错提示

## DataKit 更新

- [进程采集器](https://www.yuque.com/dataflux/datakit/host_processes)的过滤功能仅作用于指标采集，对象采集不受影响
- 优化 DataKit 发送 DataWay 超时问题
- 优化 [Gitlab 采集器](https://www.yuque.com/dataflux/datakit/gitlab) 
- 修复日志采集截断的问题
- 修复各种 trace 采集器 reload 后部分配置不生效的问题

更多 DataKit 更新可参考 [DataKit 版本历史](https://www.yuque.com/dataflux/datakit/changelog) 。

## 集成模版更新

#### 新增数据存储 Redis Sentinel 集成文档和视图

[Redis-sentinel](https://www.yuque.com/dataflux/integrations/redis_sentinel) 观测场景主要展示了 Redis 的集群、slaves、节点分布信息等。
![火狐截图_2022-05-05T01-40-25.777Z.png](https://cdn.nlark.com/yuque/0/2022/png/22022417/1651714856494-d83d1998-138e-4f9a-890f-b2216e2d0a4b.png#clientId=ub0b48158-55b9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=1370&id=ucc9101a5&margin=%5Bobject%20Object%5D&name=%E7%81%AB%E7%8B%90%E6%88%AA%E5%9B%BE_2022-05-05T01-40-25.777Z.png&originHeight=1370&originWidth=1842&originalType=binary&ratio=1&rotation=0&showTitle=false&size=254485&status=done&style=stroke&taskId=uc79f6810-4e99-463d-9fef-65a7e6673cf&title=&width=1842)

更多集成模版更新可参考 [集成文档版本历史](https://www.yuque.com/dataflux/integrations/changelog) 。

## 2022 年 4 月 26 号

### 观测云更新

#### 优化 SSO 单点登录

观测云支持用户基于工作空间开启 SSO 单点登录，用户在登录时通过输入公司邮箱，获取对应SSO登录，实现对应验证登录。在观测云工作空间「管理」-「SSO管理」-「启用」，即可为员工设置SSO单点登录。本次优化内容主要包括以下几点：

- 一个工作空间从支持创建多个身份提供商更新为仅支持配置一个 SSO 单点登录，默认会将您最后一次更新的 SAML2.0 配置视为最终单点登录验证入口
- 若多个工作空间配置同一份身份提供商（IdP）的数据，通过 SSO 单点登录后可切换查看对应工作空间的数据
-  在配置 SSO 单点登录时，“用户白名单”配置替换成“邮箱域名”，只需配置邮箱的后缀域名即可和身份提供商（IdP）配置的用户邮箱后缀匹配进行单点登录
- SSO 单点登录启用、配置更新、删除支持邮件通知和产生审计事件
- SSO 单点登录用户支持删除和编辑，编辑时可升级权限至“管理员”

更多 SSO 点单登录详情可参考文档 [SSO 管理](https://www.yuque.com/dataflux/doc/aoadgo) 。
![12.sso_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650974869340-fe8264d7-d514-4e03-9d85-e2175df9b704.png#clientId=u3ba557d2-7d25-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u4e6a6215&margin=%5Bobject%20Object%5D&name=12.sso_4.png&originHeight=203&originWidth=1345&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57525&status=done&style=stroke&taskId=u59dc604d-39bb-48a2-b068-111d31455da&title=)

## 2022 年 4 月 21 号

### 观测云社区版上线

观测云社区版为老师、学生、云计算爱好者等社区用户提供一个简单易得又功能完备的产品化本地部署平台。欢迎免费申请并下载试用，搭建您自己的观测云平台，体验完整的产品功能。详情可参考文档 [社区版](https://www.yuque.com/dataflux/doc/wbql50#zeDMh) 。

### 观测云更新

#### 新增 Gitlab CI 可观测

观测云支持为 Gitlab 内置的 CI 的过程和结果进行可视化，您可以通过观测云的 CI 可视化功能直接查看在 Gitlab 的 CI 结果。CI 的过程是持续集成，开发人员在 push 代码的时候，若碰到问题，可以在观测云查看所有 CI 的 pipeline 及其成功率、失败原因、具体失败环节，帮助您提供代码更新保障。更多详情介绍可参考 [CI 查看器](https://www.yuque.com/dataflux/doc/bs4iss)。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650547270993-dc77f27e-5456-42a2-80bb-6c0281bbb53e.png#crop=0&crop=0&crop=1&crop=1&from=url&id=nBTAT&margin=%5Bobject%20Object%5D&originHeight=737&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 新增在线帮助奥布斯小助手

观测云奥布斯小助手支持您在工作空间快速查看基础入门、进阶指南、最佳实践、DataKit、Func等文档，通过点击提供的关键词或者在搜索栏直接输入关键字进行搜素，帮助您快速获取相关的文档说明。更多详情介绍可参考文档 [帮助](https://www.yuque.com/dataflux/doc/uxga96) 。
![3.help_1.3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650780047396-dfc77220-009c-4d7a-abca-8234f3e0295f.png#clientId=u7df5ad5f-33e6-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1f7a52cd&margin=%5Bobject%20Object%5D&name=3.help_1.3.png&originHeight=462&originWidth=497&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50747&status=done&style=stroke&taskId=u17bd411d-6018-40d2-a248-70a185fab90&title=)

#### 新增仪表板设置刷新频率

观测云支持在场景仪表板设置刷新频率。初次设置刷新频率默认为 30 秒，支持 10 秒、30 秒、60 秒三种选项，若时间控件“暂停”，则不再刷新。
![9.dashboard_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650538404667-b4b114e8-72cd-42c7-87e2-567e41204d82.png#clientId=uc05634d3-9d43-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u78be5b39&margin=%5Bobject%20Object%5D&name=9.dashboard_1.png&originHeight=453&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&size=107205&status=done&style=stroke&taskId=ucd9b7b9a-668f-4389-92ca-b543311682f&title=)

#### 新增进程 48 小时回放

观测云基础设施进程支持查看**最近十分钟内**采集的进程数据，点击时间范围可查看进程 48 小时回放，拖动后，刷新暂停，时间显示为：[ 开始时间-结束时间 ]，查询的时间范围为5分钟，点击「播放」按钮或刷新页面，回到查看「最近10分钟」的进程。
![8.process.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650533965351-d56aaedb-360d-4d6d-ad46-cce77796ab5e.png#clientId=u1cff4303-23ec-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8af75418&margin=%5Bobject%20Object%5D&name=8.process.png&originHeight=155&originWidth=1231&originalType=binary&ratio=1&rotation=0&showTitle=false&size=28450&status=done&style=stroke&taskId=uabce52c9-78d0-493c-bfd8-f9620eb9477&title=)

#### 新增集成 DataKit Kubernetes(Helm)安装引导页

在观测云集成 DataKit 安装引导页，新增 Kubernetes(Helm)安装引导，介绍在 K8S 中如何使用 Helm 安装 DataKit。更多关于详情可参考文档 [DaemonSet 安装](https://www.yuque.com/dataflux/datakit/datakit-daemonset-deploy#e4d3facf) 。
![11.changelog_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650552452207-d532d731-89f3-4368-9bc1-7387686ae7f5.png#clientId=u263cf46c-528f-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua2085273&margin=%5Bobject%20Object%5D&name=11.changelog_1.png&originHeight=781&originWidth=1042&originalType=binary&ratio=1&rotation=0&showTitle=false&size=121485&status=done&style=stroke&taskId=u18d4a2ba-f322-473d-82f5-2541c14fc11&title=)

#### 新增应用性能全局概览、服务分类筛选、服务拓扑图区分环境和版本

应用性能监测新增全局性能概览视图，您可以在概览页面查看在线服务数量、P90 服务响应耗时、服务最大影响耗时、服务错误数、服务错误率统计，同时还可以查看 P90 服务、资源、操作的响应耗时 Top10 排行，以及服务错误率、资源 5xx 错误率、资源 4xx 错误率 Top10 排行。
![1.apm_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650457638599-b2fc57cb-adb4-44db-a224-0f6df7b19768.png#clientId=u222de9d6-bdf7-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u2180ba4e&margin=%5Bobject%20Object%5D&name=1.apm_3.png&originHeight=732&originWidth=1229&originalType=binary&ratio=1&rotation=0&showTitle=false&size=147719&status=done&style=stroke&taskId=uf7de438b-7a05-4467-945b-185082ce391&title=)

在应用性能服务列表中，支持您通过点击服务类型图标进行分类筛选，再次点击即可恢复全部查看。
![1.apm_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650457347772-4f3f3695-cd7c-49f9-a3d0-e97e4d4abcd6.png#clientId=u335d2c16-089e-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua670ff5e&margin=%5Bobject%20Object%5D&name=1.apm_2.png&originHeight=351&originWidth=1232&originalType=binary&ratio=1&rotation=0&showTitle=false&size=79422&status=done&style=stroke&taskId=uc3bf4934-952e-4b8c-8a17-52e65236c37&title=)

在服务列表，切换至「拓扑图」模式可查看各个服务之间的调用关系。支持基于服务（service）和服务环境版本（service+env+version）两种维度绘制链路拓扑图，开启“区分环境和版本”后，将按照不同的环境版本绘制服务拓扑图。比如说金丝雀发布，通过开启环境和版本，即可查看不同环境版本下的服务调用情况。
![11.changelog_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650778445153-fa927c4f-8215-4025-a995-0ae98aaf267b.png#clientId=u1d749645-a1b0-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u46007a26&margin=%5Bobject%20Object%5D&name=11.changelog_2.png&originHeight=711&originWidth=1234&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90458&status=done&style=stroke&taskId=u5b886983-5f65-4a1b-a906-2b95f1f47d1&title=)
#### 优化 SSO 单点登录配置
SSO 单点登录配置用户白名单调整为邮箱域名，用于校验单点登录处输入邮箱后缀是否匹配，匹配的邮箱可以在线获取 SSO 的登录链接。更多 SSO 配置详情可参考文档 [SSO管理](https://www.yuque.com/dataflux/doc/aoadgo) 。
![12.sso_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650784038577-91743c3f-9987-4e81-9b98-130d1b4d38b7.png#clientId=u510f5643-ed84-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u77daefff&margin=%5Bobject%20Object%5D&name=12.sso_2.png&originHeight=784&originWidth=1228&originalType=binary&ratio=1&rotation=0&showTitle=false&size=93884&status=done&style=stroke&taskId=u734ef3ec-7ab0-49e9-8de1-9d4fe97a95a&title=)
#### 其他功能优化

- 新增链路详情页中关联日志“全部来源”选项 
- 新增指标筛选支持反选，聚合函数位置调整
- 优化日志、应用性能、用户访问、安全巡检生成指标，“频率”所选时间也作为聚合周期
- 优化观测云部署版工作空间拥有者移交权限功能取消，支持管理后台设置
- 优化告警通知短信模版
- 优化可用性监测新建拨测列表，支持直接选择 HTTP、TCP、ICMP、WEBSOCKET 拨测

## DataKit 更新

- Pipeline 模块修复 Grok 中[动态多行 pattern](https://www.yuque.com/dataflux/datakit/datakit-pl-how-to#88b72768) 问题
- DaemonSet 优化 [Helm 安装](https://www.yuque.com/dataflux/datakit/datakit-daemonset-deploy#e4d3facf)，增加[开启 pprof 环境变量](https://www.yuque.com/dataflux/datakit/datakit-daemonset-deploy#cc08ec8c)配置，DaemonSet 中所有[默认开启采集器](https://www.yuque.com/dataflux/datakit/datakit-input-conf#764ffbc2)各个配置均支持通过环境变量配置
- Tracing 采集器初步支持 Pipeline 数据处理，参考 [DDtrace 配置示例](https://www.yuque.com/dataflux/datakit/ddtrace#69995abe)。
- 拨测采集器增加失败任务退出机制
- 日志新增 `unknown` 等级（status），对于未指定等级的日志均为 `unknown`
- 容器采集器修复：
   - 修复 cluster 字段命名问题
   - 修复 namespace 字段命名问题
   - 容器日志采集中，如果 Pod Annotation 不指定日志 `source`，那么 DataKit 将按照[此优先级来推导日志来源](https://www.yuque.com/dataflux/datakit/container#6de978c3)
   - 对象上报不再受 32KB 字长限制（因 Annotation 内容超 32KB），所有 Kubernetes 对象均删除 `annotation` 

更多 DataKit 更新可参考 [DataKit 版本历史](https://www.yuque.com/dataflux/datakit/changelog) 。

## 最佳实践更新

- 微服务可观测最佳实践
   - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(上)](https://www.yuque.com/dataflux/bp/microservices1)
   - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(下)](https://www.yuque.com/dataflux/bp/microservices3)
   - [service mesh 微服务架构从研发到金丝雀发布全流程最佳实践(中)](https://www.yuque.com/dataflux/bp/microservices2)
- 监控最佳实践
   - [JAVA OOM异常可观测最佳实践](https://www.yuque.com/dataflux/bp/java-oom)

更多最佳实践更新可参考 [最佳实践版本历史](https://www.yuque.com/dataflux/bp/changelog) 。

## 集成模版更新

### 新增文档

- 应用性能监测 (APM)
   - Node.JS
   - Ruby
- 中间件
   - RocketMQ
- 容器编排
   - Istio
   - Kube State Metrics
- 数据存储
   - Aerospike
### 新增视图

- 容器编排
   - Kubernetes Overview by Pods
   - Istio Mesh
   - Istio Control Plane
- 阿里云
   - 阿里云 ASM Mesh
   - 阿里云 ASM Control Plane
   - 阿里云 ASM Workload
- 中间件
   - RocketMQ

更多集成模版更新可参考 [集成文档版本历史](https://www.yuque.com/dataflux/integrations/changelog) 。

## 2022 年 4 月 8 号

### 观测云计费更新

#### 新增阿里云账户结算方式

在观测云费用中心「管理工作空间」，支持查看账户下绑定的所有工作空间，支持修改已绑定工作空间的结算方式，通过“更改结算方式”可任意切换观测云费用中心账户、亚马逊云账户和阿里云账户结算。

### 观测云更新

#### 新增 DQL 查询查看器

DQL 是专为观测云开发的语言，语法简单，方便使用，可在观测云工作空间或者终端设备通过 DQL 语言进行数据查询。

在观测云工作空间，点击菜单栏的「DQL 查询」即可打开 DQL 查询查看器，或者您可以通过快捷键`Alt+Q`直接打开 DQL 查询。DQL 查询查看器支持表格和 JSON 两种返回结果，支持保存7天历史查询记录。更多使用操作说明可参考文档 [DQL 查询](https://www.yuque.com/dataflux/doc/gc6mwk) 。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649320668248-6173e567-ae4d-4361-99e3-d2cd6054d46e.png#crop=0&crop=0&crop=1&crop=1&from=url&id=TINrM&margin=%5Bobject%20Object%5D&originHeight=520&originWidth=1349&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 可用性监测新增 TCP/ICMP/Websocket 拨测协议

观测云支持自定义拨测任务。通过创建基于`[HTTP](https://www.yuque.com/dataflux/doc/kwbu7h)、[TCP](https://www.yuque.com/dataflux/doc/qgx4ai)、[ICMP](https://www.yuque.com/dataflux/doc/mcmful)、[WEBSOCKET](https://www.yuque.com/dataflux/doc/yytvyg)`等不同协议的拨测任务，全面监测不同地区、不同运营商到各个服务的网络性能、网络质量、网络数据传输稳定性等状况。
![4.dailtesting_tcp_1.1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649403842527-858e598b-d90c-4f09-8048-22a1a0df9ffd.png#clientId=ubd0c4302-691b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u7e1744fd&margin=%5Bobject%20Object%5D&name=4.dailtesting_tcp_1.1.png&originHeight=357&originWidth=628&originalType=binary&ratio=1&rotation=0&showTitle=false&size=33763&status=done&style=stroke&taskId=uf640fa7b-a4dd-46c2-ad2c-25ea759c3fc&title=)

#### 新增基础设施网络模块

在基础设施，原主机网络 Map 和 Pod 网络 Map 从主机和容器模块迁移至新增模块“网络”下，支持查看主机和 Pod 的网络 Map。Pod 网络 Map 填充指标新增七层网络指标：每秒请求数、错误率以及平均响应时间。更多详情可参考文档 [网络](https://www.yuque.com/dataflux/doc/quyskl) 。
![5.network_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649408249789-03f6173b-b957-4afa-a5e8-e5fb8587fc9f.png#clientId=u42411d64-9a1b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u2867c8b9&margin=%5Bobject%20Object%5D&name=5.network_2.png&originHeight=788&originWidth=1253&originalType=binary&ratio=1&rotation=0&showTitle=false&size=138292&status=done&style=stroke&taskId=u9ec96302-e6bf-4b33-82c8-3fb3a1c85f2&title=)


#### 基础设施容器 Pod 新增 HTTP 七层网络数据展示

基础设施容器 Pod 新增 HTTP 七层网络数据采集和展示，Pod 网络数据采集成功后会上报到观测云工作空间，在「基础设施」-「容器」-「Pod」详情页中的「网络」，您可以查看到工作空间内全部 Pod 网络性能监测数据信息。查看基础更多详情可参考文档 [Pod 网络](https://www.yuque.com/dataflux/doc/gy7lei#PqtQj) 。
![5.network_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649408726576-d740f6a4-7003-4aa3-bbe6-dad2bb475650.png#clientId=u42411d64-9a1b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u97355168&margin=%5Bobject%20Object%5D&name=5.network_4.png&originHeight=714&originWidth=1120&originalType=binary&ratio=1&rotation=0&showTitle=false&size=122721&status=done&style=stroke&taskId=u7acf4878-8401-4b79-b1f3-b35f8582b9d&title=)

#### 新增查看器快捷筛选“反选”和“重置”功能

在任意查看器的“快捷筛选”，支持在选择字段筛选内容时进行“反选”或者“重置”，“反选”表示选中的字段筛选内容不展示（再次点击“反选”可返回字段选中状态），“重置”可清空筛选条件。更多详情说明可参考 [日志查看器快捷筛选 ](https://www.yuque.com/dataflux/doc/ibg4fx#av1Zj)。
![1.log_7.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649311779990-3a5624d8-7200-470b-b680-c86cc507fb1a.png#clientId=u70ea4e72-f5a1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u612891d1&margin=%5Bobject%20Object%5D&name=1.log_7.png&originHeight=721&originWidth=1245&originalType=binary&ratio=1&rotation=0&showTitle=false&size=235242&status=done&style=stroke&taskId=u3ff39c26-ac9a-43d6-b91e-da491a83ed5&title=)

#### 优化日志黑名单

观测云支持通过设置日志黑名单的方式过滤掉符合条件的日志，即配置日志黑名单以后，符合条件的日志数据不再上报到观测云工作空间，帮助用户节约日志数据存储费用。

日志黑名单优化支持匹配全部日志来源，支持两种黑名单配置方式：

- 满足任意一个过滤条件，触发黑名单过滤
- 满足所有过滤条件，触发黑名单过滤

更多黑名单配置可参考文档 [日志黑名单](https://www.yuque.com/dataflux/doc/na6x2c) 。
![1.log_10.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1649420739656-ededbb22-7296-4dce-9705-97192706ecce.png#clientId=ud15e3cce-22c9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u60082736&margin=%5Bobject%20Object%5D&name=1.log_10.png&originHeight=434&originWidth=586&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38252&status=done&style=stroke&taskId=u2318d0f1-649f-4216-996a-803d0f88e63&title=)

#### 其他功能优化

- 新增链路详情页 span 数量统计
- 优化链路关联主机时间线绘制方式
- 优化概览图时间分片，取消选项，若之前的概览图开启了时间分片，优化后默认更改为不开启时间分片
- 优化组合图表在浏览器缩放情况下，进入编辑后无法实现组合图表切换编辑不同的图表查询
- 优化日志查看器手动暂停页面刷新后，滚轴滑动到顶部不触发自动刷新

### DataKit 更新

- 增加宿主机运行时的[内存限制](https://www.yuque.com/dataflux/datakit/datakit-conf#4e7ff8f3)，安装阶段即支持[内存限制配置](https://www.yuque.com/dataflux/datakit/datakit-install#03be369a)，
- CPU 采集器增加 [load5s 指标](https://www.yuque.com/dataflux/datakit/cpu#13e60209)
- 支持观测云优化的日志黑名单功能，调整 monitor 布局，增加黑名单过滤情况展示
- DaemonSet 安装增加 [Helm 支持](https://www.yuque.com/dataflux/datakit/datakit-daemonset-deploy)，新增 [DaemonSet 安装最佳实践](https://www.yuque.com/dataflux/datakit/datakit-daemonset-bp)
- eBPF 增加 [HTTP 协议采集](https://www.yuque.com/dataflux/datakit/ebpf#905896c5)，主机安装时，eBPF 采集器默认不再会安装，如需安装[需用特定的安装指令](https://www.yuque.com/dataflux/datakit/ebpf#852abae7)，DaemonSet 安装不受影响

更多 DataKit 更新可参考 [DataKit 版本历史](https://www.yuque.com/dataflux/datakit/changelog) 。

### 观测云移动端 APP 更新

新增站点登陆的能力，优化场景、事件查看器，保持了与网页端查看器相同的访问体验。

- 支持用户选择账号对应的站点，通过账号密码或验证码方式登陆。
- 支持用户查看全部来源或任一来源的日志数据
- 支持用户查看当前空间下的全部仪表板，并通过下拉菜单切换“全部仪表板”，“我的收藏”、“导入项目”、“我的创建”和“经常浏览”，以快速过滤查找对应的仪表板。
- 支持用户在「事件」查看器中，通过「全部」查看、搜索和过滤异常检测库触发的全部未恢复事件内容；通过「我的」事件，查看通过邮件、钉钉机器人、企业微信机器人、Webhook等通知到用户的当前仍未恢复的事件内容。

更多详情可参考文档 [移动端](https://www.yuque.com/dataflux/doc/atdydg) 。

### 最佳实践更新

- 观测云小妙招
   - [多微服务项目的性能可观测实践](https://www.yuque.com/dataflux/bp/nce2kw)
   - [ddtrace 高级用法](https://www.yuque.com/dataflux/bp/ddtrace)
   - [Kubernetes 集群使用 ExternalName 映射 DataKit 服务](https://www.yuque.com/dataflux/bp/external-name)
- 接入(集成)最佳实践
   - [OpenTelemetry 链路数据接入最佳实践](https://www.yuque.com/dataflux/bp/opentelemetry)
- 微服务可观测最佳实践
   - [基于阿里云 ASM 实现微服务可观测最佳实践](https://www.yuque.com/dataflux/bp/asm)

更多最佳实践更新可参考 [最佳实践版本历史](https://www.yuque.com/dataflux/bp/changelog) 。

### 集成模版更新

#### 新增阿里云 PolarDB Oracle 集成文档、视图和监控器

[阿里云 PolarDB Oracle](https://www.yuque.com/dataflux/integrations/oqh2z2) 指标展示，包括 CPU 使用率，内存使用率，网络流量，连接数，IOPS，TPS，数据盘大小等
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1648871634067-b59721be-c9f7-49b9-a9dd-0e7dc5592683.png#clientId=u5efc4d60-f7da-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=675&id=u491b52fe&margin=%5Bobject%20Object%5D&name=image.png&originHeight=675&originWidth=1702&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51039&status=done&style=stroke&taskId=u458758e0-abee-4ad1-9441-b27aad6e1e0&title=&width=1702)

#### 新增阿里云 PolarDB PostgreSQL 集成文档、视图和监控器

[阿里云 PolarDB PostgreSQL](https://www.yuque.com/dataflux/integrations/qm36w8) 指标展示，包括 CPU 使用率，内存使用率，网络流量，连接数，IOPS，TPS，数据盘大小等
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1648694635915-2c9fcb15-1ccb-4716-a1c4-008944ad96ff.png#clientId=u5fba5867-95cf-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=720&id=ucfaf9658&margin=%5Bobject%20Object%5D&name=image.png&originHeight=720&originWidth=1702&originalType=binary&ratio=1&rotation=0&showTitle=false&size=82834&status=done&style=stroke&taskId=u9ab09708-8c02-481b-84ae-cfa89873aaa&title=&width=1702)

#### 新增阿里云 RDS SQLServer 集成文档、视图和检测库

[阿里云 RDS SQLServer](https://www.yuque.com/dataflux/integrations/ub9hfh) 指标展示，包括 CPU 使用率，磁盘使用率，IOPS，网络带宽，TPS，QPS 等
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1649217050778-d4be38cf-47d8-4f59-85b3-404cd5210c3c.png#clientId=uad3139d4-1b97-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=310&id=u3567d268&margin=%5Bobject%20Object%5D&name=image.png&originHeight=310&originWidth=1718&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54535&status=done&style=stroke&taskId=u47d5aa61-e0f6-40f2-9e15-d1e92a43ded&title=&width=1718)

#### 新增 DataKit 集成文档、视图和监控器

[DataKit](https://www.yuque.com/dataflux/integrations/qwtrhy) 性能指标展示，包括 CPU 使用率，内存信息，运行时间，日志记录等
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1648445740952-c302e4cc-99c6-4de7-a205-b4ffe6f69862.png#clientId=u2d79c45a-91ad-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=791&id=u3af8dbe7&margin=%5Bobject%20Object%5D&name=image.png&originHeight=791&originWidth=1696&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105639&status=done&style=stroke&taskId=ub850d3c1-fd4d-498b-8e23-72371f5f7a0&title=&width=1696)

#### 新增 Nacos 集成文档、视图

[Nacos](https://www.yuque.com/dataflux/integrations/nacos) 性能指标展示：Nacos 在线时长、Nacos config 长链接数、Nacos config 配置个数、Service Count、http请求次数等。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/22022417/1648632783948-4a411dd6-8e17-4471-adf8-1d4c477f3dc5.png#clientId=u7a516339-b432-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=852&id=u62192712&margin=%5Bobject%20Object%5D&name=image.png&originHeight=852&originWidth=1858&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105721&status=done&style=stroke&taskId=ube480a66-866b-4b9d-b73f-1951264cb69&title=&width=1858)

更多集成模版更新可参考 [集成文档版本历史](https://www.yuque.com/dataflux/integrations/changelog) 。

## 2022 年 3 月 24 号

### 观测云站点更新

观测云支持多站点登录和注册，新增“海外区1（俄勒冈）”站点，原“中国区1（阿里云）”变更为“中国区1（杭州）”，原“中国区2（AWS）”并更为“中国区2（宁夏）”。

不同站点的账号和数据相互独立，无法互相共享和迁移数据。您可以根据使用资源的情况，选择适合的站点进行注册登录。目前观测云支持以下三个站点。关于如何选择站点，可参考文档 [观测云站点](https://www.yuque.com/dataflux/doc/qfigg3) 。

| 站点 | 登录地址 URL | 运营商 |
| --- | --- | --- |
| 中国区1（杭州） | [https://auth.guance.com/](https://auth.guance.com/login/pwd) | 阿里云（中国杭州） |
| 中国区2（宁夏） | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) | AWS（中国宁夏） |
| 海外区1（俄勒冈） | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS（美国俄勒冈） |


## 如何选择站点
### 观测云更新

#### 新增工作空间数据授权

观测云支持通过数据授权的方式，授权多个工作空间的数据给到当前的工作空间，通过场景仪表板和笔记的图表组件进行查询和展示。若有多个工作空间，配置数据授权后，即可在一个工作空间查看所有工作空间的数据。更多配置详情，可参考文档 [数据授权](https://www.yuque.com/dataflux/doc/hgn17u) 。

1.在「管理」-「数据授权」配置需要授权查看数据的工作空间
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648116301049-f8113bad-ca48-4f4b-8c0b-0b71fa8d1ce3.png#crop=0&crop=0&crop=1&crop=1&from=url&id=Rying&margin=%5Bobject%20Object%5D&originHeight=271&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)
2.在工作空间获得数据授权后，打开「场景」-「[仪表板](https://www.yuque.com/dataflux/doc/gqatnx)或者[笔记](https://www.yuque.com/dataflux/doc/qvf618)」，选择图表组件，在“设置”的“工作空间”选择被授权查看的工作空间，然后就可以通过[图表查询](https://www.yuque.com/dataflux/doc/cxlbps)查看和分析被授权工作空间的数据。
![9.dataauth_7.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648109989588-ab62f5ff-9327-4979-aef6-732a2ee0cfa9.png#clientId=ude02eb88-9d2f-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9e25b3c0&margin=%5Bobject%20Object%5D&name=9.dataauth_7.png&originHeight=654&originWidth=1355&originalType=binary&ratio=1&rotation=0&showTitle=false&size=138987&status=done&style=stroke&taskId=u709efb62-85fc-4e9d-afa3-c8fbe4160e3&title=)

#### 新增保存在线 Pipeline 样本测试数据

观测云 Pipeline 支持自定义和官方库两种：

- 自定义 Pipeline 脚本规则编写完成后，可以输入日志样本数据进行测试，来验证你配置的解析规则是否正确，自定义 Pipeline 保存后， 日志样本测试数据同步保存。
- Pipeline 官方库自带多个日志样本测试数据，在“克隆”前可选择符合自身需求的日志样本测试数据，克隆的 Pipeline 修改保存后， 日志样本测试数据同步保存。

更多在线 Pipeline 功能详情，可参考文档 [Pipelines](https://www.yuque.com/dataflux/doc/caczze) 。
![10.pipeline_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648119592032-82f7c6bd-bcf6-4e25-a793-701b415c15ab.png#clientId=u0ca629c8-d4be-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8f626b38&margin=%5Bobject%20Object%5D&name=10.pipeline_1.png&originHeight=581&originWidth=852&originalType=binary&ratio=1&rotation=0&showTitle=false&size=93818&status=done&style=stroke&taskId=uc3f9c653-536f-4f5e-8fbf-ac264bed299&title=)

#### 优化自定义对象查看器

在观测云工作空间，通过 「基础设施」-「自定义」-「添加对象分类」，您可以创建新的对象分类，并自定义对象分类名称和对象字段。

添加完自定义对象分类以后，即可通过 [Func 函数处理平台](https://www.yuque.com/dataflux/func/quick-start)进行自定义数据上报。关于如何通过 Func 向观测云工作空间上报数据，可参考文档 [自定义对象数据上报](https://www.yuque.com/dataflux/doc/nw9bxt) 。

![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648121404200-9f1de223-ba08-48c4-b42c-adabffc5cb78.png#crop=0&crop=0&crop=1&crop=1&from=url&id=Wqqqt&margin=%5Bobject%20Object%5D&originHeight=544&originWidth=1241&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 优化快照分享支持永久有效的链接

快照分享支持设置有效时间，支持选择 “48 小时”或者“永久有效”。在快照列表，点击分享按钮，即可在弹出对话框中进行高级设置“隐藏顶部栏”。更多快照分享详情，可参考文档 [快照](https://www.yuque.com/dataflux/doc/uuy378) 。

注意：永久有效分享容易存在数据安全风险，请谨慎使用。
![6.share_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648037477293-b43d9e00-9621-4fd4-b800-383095db6894.png#clientId=u17b4ca54-1898-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u48556e14&margin=%5Bobject%20Object%5D&name=6.share_4.png&originHeight=286&originWidth=536&originalType=binary&ratio=1&rotation=0&showTitle=false&size=29537&status=done&style=stroke&taskId=u631a8d32-f030-4e68-af4c-eeafe5005c4&title=)

#### 优化图表时间间隔

在场景仪表板的图表设置中时间间隔选择“自动对齐”， 在预览图表时，图表右上角会出现时间间隔选项，您可以按照您的实际情况选择时间间隔查看您的数据。更多详情可参考文档 [视图分析](https://www.yuque.com/dataflux/doc/rr32l0) 。
![8.table_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1648105524605-f065fa00-67c7-4faf-a568-a5c37fd5ed78.png#clientId=u8f673cfa-e936-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u32adf1b0&margin=%5Bobject%20Object%5D&name=8.table_1.png&originHeight=425&originWidth=806&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50605&status=done&style=stroke&taskId=u07def71c-8880-4df6-a180-ae3086ba6e8&title=)

#### 优化进程、应用性能、用户访问检测无数据触发策略

在观测云监控功能模块，配置[进程异常检测](https://www.yuque.com/dataflux/doc/uskqmx)、[应用性能指标检测](https://www.yuque.com/dataflux/doc/tag1nx)、[用户访问指标检测](https://www.yuque.com/dataflux/doc/qnpqmm)监控时，无数据状态支持「触发无数据事件」、「触发恢复事件」、「不触发事件」三种配置，需要手动配置无数据处理策略。

#### 其他功能优化

- 优化集成DataKit、Func 安装引导页
- 优化日志查看器单条日志完全展示
- 新增查看器关联搜索 NOT 组合
- 优化编辑成员权限显示

### DataKit 更新

- 增加 [DataKit 命令行补全](https://www.yuque.com/dataflux/datakit/datakit-tools-how-to#9e4e5d5f)功能，帮助您在终端操作的时候进行命令提示和补全参数
- 允许 DataKit [升级到非稳定版](https://www.yuque.com/dataflux/datakit/datakit-update#42d8b0e4)，体验最新的试验性功能，若您是生产环境，请谨慎升级
- 初步支持 [Kubernetes/Containerd 架构的数据采集](https://www.yuque.com/dataflux/datakit/container)
- [网络拨测](https://www.yuque.com/dataflux/datakit/dialtesting)增加 TCP/UDP/ICMP/Websocket 几种协议支持
- 调整 Remote Pipeline 的在 DataKit 本地的存储，避免不同文件系统差异导致的文件名大小写问题
- Pipeline新增 [decode()](https://www.yuque.com/dataflux/datakit/pipeline#837c4e09) 函数，可以避免在日志采集器中去配置编码，在 Pipeline 中实现编码转换；[add_pattern()](https://www.yuque.com/dataflux/datakit/pipeline#89bd3d4e) 增加作用域管理

更多 DataKit 更新可参考 [DataKit 版本历史](https://www.yuque.com/dataflux/datakit/changelog) 。

### 最佳实践更新

- 场景最佳实践
   - [RUM 数据上报 DataKit 集群最佳实践](https://www.yuque.com/dataflux/bp/datakit-cluster)
- 日志最佳实践
   - [Pod 日志采集最佳实践](https://www.yuque.com/dataflux/bp/pod-log)

更多最佳实践更新可参考 [最佳实践版本历史](https://www.yuque.com/dataflux/bp/changelog) 。

### 集成模版更新

#### 新增阿里云 PolarDB Mysql 集成文档、视图和检测库

[阿里云 PolarDB Mysql](https://www.yuque.com/dataflux/integrations/oe08qg) 指标展示，包括 CPU 使用率，内存命中率，网络流量，连接数，QPS，TPS，只读节点延迟等
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1648088885474-d069dc0d-bf17-4aa6-8bbe-71bde7ec6c3a.png#clientId=ua5321030-4428-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=551&id=ubb2db3d4&margin=%5Bobject%20Object%5D&name=image.png&originHeight=551&originWidth=1689&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51158&status=done&style=stroke&taskId=u82f97ac4-a707-43c6-9a58-08f26d58b0e&title=&width=1689)

更多集成模版更新可参考 [集成文档版本历史](https://www.yuque.com/dataflux/integrations/changelog) 。


## 2022 年 3 月 10 号

### 观测云计费更新

#### 新增观测云计费储值卡

观测云储值卡支持通过账户现金余额进行购买，适用于所有观测云的消费模式，包括按量付费和包年套餐。登录到观测云[费用中心](https://boss.guance.com)，点击“管理储值卡”，即可进入储值卡管理页面购买，储值卡购买并支付费用后，按照实付金额开具等额发票。更多详情可参考 [储值卡管理](https://www.yuque.com/dataflux/doc/woqm59#EYClJ) 。

### 观测云更新

#### 新增用户访问监测 resource（资源）、action（操作）、long_task（长任务）、error（错误）查看器

用户访问监测查看器可以帮助您查看与分析用户访问应用程序的详细信息。在观测云工作空间内打开「用户访问监测」，点击任意一个应用后即可通过「查看器」了解每个用户会话、页面性能、资源、长任务、动态组件中的错误、延迟对用户的影响、帮助你通过搜索、筛选和关联分析全面了解和改善应用的运行状态和使用情况，提高用户体验。

观测云用户访问监测查看器包括 session（会话）、view（页面）、resource（资源）、action（操作）、long_task（长任务）、error（错误）。更多详情可参考 [用户访问监测查看器](https://www.yuque.com/dataflux/doc/dh5lg9) 。

| 查看器类型 | 概述 |
| --- | --- |
| session（会话） | 查看用户访问的一系列详情，包括用户访问时间、访问页面路径、访问操作数、访问路径和出现的错误信息等。 |
| view（页面） | 查看用户访问环境、回溯用户的操作路径、分解用户操作的响应时间以及了解用户操作导致后端应用一系列调用链的性能指标情况 |
| resource（资源） | 查看网页上加载的各种资源信息，包括状态码、请求方式、资源地址，加载耗时等 |
| action（操作） | 查看用户在使用应用期间的操作交互，包括操作类型，页面操作详情，操作耗时等 |
| long_task（长任务） | 查看用户在使用应用期间，阻塞主线程超过 50ms 的长任务，包括页面地址、任务耗时等 |
| error（错误） | 查看用户在使用应用期间，浏览器发出的前端错误，包括错误类型、错误内容等 |


#### 新增 Pod 网络详情及网络分布

Pod 网络支持查看 Pod 之间的网络流量。支持基于 IP/端口查看源 IP 到目标 IP 之间的网络流量和数据连接情况，通过可视化的方式进行实时展示，帮助企业实时了解业务系统的网络运行状态，快速分析、追踪和定位问题故障，预防或避免因网络性能下降或中断而导致的业务问题。

Pod 网络数据采集成功后会上报到观测云控制台，在「基础设施」-「容器」-「Pod」详情页中的「网络」，您可以查看到工作空间内全部 Pod 网络性能监测数据信息。更多详情可参考 [Pod 网络](https://www.yuque.com/dataflux/doc/gy7lei#PqtQj) 。
![7.pod_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1646891081597-4f85bc74-2039-41b4-a469-c9a87ad5b3bd.png#clientId=udddd46fb-98fb-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u12556989&margin=%5Bobject%20Object%5D&name=7.pod_1.png&originHeight=750&originWidth=1146&originalType=binary&ratio=1&rotation=0&showTitle=false&size=119175&status=done&style=stroke&taskId=ua4130027-43f3-47e3-af17-ccaa7632b18&title=)
在「基础设施」-「容器」-「Pod」，点击左上角网络分布图的小图标![3.host_netmap_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1634699082776-086c9dc0-c952-45e4-9300-ec928ccec30c.png#clientId=uc0541857-b38c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=LliL2&margin=%5Bobject%20Object%5D&name=3.host_netmap_2.png&originHeight=16&originWidth=16&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7373&status=done&style=none&taskId=uc846671b-38dc-40e3-9c1c-f5de464a879&title=)，即可切换到查看 Pod 网络分布情况。在「网络分布图」，你能够可视化查询当前工作空间 Pod 与 Pod 之间的网络流量，快速分析不同 Pod 之间的 TCP延迟、TCP波动、TCP重传次数、TCP连接次数以及 TCP关闭次数。更多详情可参考 [Pod 网络分布图](https://www.yuque.com/dataflux/doc/gy7lei#yKAcN) 。
![7.pod_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1646891161797-ed8d81b0-50a5-4c45-a03d-d12b7402df8a.png#clientId=udddd46fb-98fb-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u90669117&margin=%5Bobject%20Object%5D&name=7.pod_3.png&originHeight=755&originWidth=1239&originalType=binary&ratio=1&rotation=0&showTitle=false&size=182225&status=done&style=stroke&taskId=u83b1ba1d-caa4-4cd3-9334-3170ffe88c3&title=)

### DataKit 更新

- DataKit 采集器新增支持 SkyWalking、Jaeger、Zipkin 数据配置采样策略，更多详情可参考 [Datakit Tracing Frontend ](https://www.yuque.com/dataflux/datakit/datakit-tracing#64df2902)。
- DataKit 采集器新增支持 [OpenTelemetry 数据接入](https://www.yuque.com/dataflux/datakit/opentelemetry) 。
- DataKit 文档库新增文档 [DataKit 整体日志采集介绍](https://www.yuque.com/dataflux/datakit/datakit-logging)，包括从磁盘文件获取日志、通过调用环境 API 获取日志、远程推送日志给 DataKit、Sidecar 形式的日志采集四种方式。

#### Breaking Changes

**2022/03/22**

-  本次对 Tracing 数据采集做了较大的调整，涉及几个方面的不兼容： 
   - [DDtrace](ddtrace) 原有 conf 中配置的 `ignore_resources` 字段需改成 `close_resource`，且字段类型由原来的数组（`[...]`）形式改成了字典数组（`map[string][...]`）形式（可参照 [conf.sample](ddtrace#69995abe) 来配置）
   - DDTrace 原数据中采集的 [tag ](ddtrace#01b88adb)`[type](ddtrace#01b88adb)`[ 字段改成 ](ddtrace#01b88adb)`[source_type](ddtrace#01b88adb)`

**2022/03/04**

- 老版本的 DataKit 如果开启了 RUM 功能，升级上来后，需[重新安装 IP 库](datakit-tools-how-to#ab5cd5ad)，老版本的 IP 库将无法使用。

**2021/12/30**

- 老版本的 DataKit 通过 `datakit --version` 已经无法推送新升级命令，直接使用如下命令：

- Linux/Mac:

```shell
DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Windows

```powershell
$env:DK_UPGRADE="1"; Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1; powershell .install.ps1;
```

更多 DataKit 更新可参考 [DataKit 版本历史](https://www.yuque.com/dataflux/datakit/changelog) 。

### SDK 更新

用户访问监测兼容 Opentracing 协议链路追踪工具，[Web](https://www.yuque.com/dataflux/doc/eqs7v2)、[小程序](https://www.yuque.com/dataflux/doc/clgea8)、[Android](https://www.yuque.com/dataflux/doc/pnzoyp)、[iOS](https://www.yuque.com/dataflux/doc/gsto6k) SDK 支持 OTEL、SkyWalking、Jaeger 等链路追踪工具数据联动。

### 最佳实践更新

- 自定义接入最佳实践
   - [快速上手 pythond 采集器的最佳实践](https://www.yuque.com/dataflux/bp/vdpvse)
   - [阿里云“云监控数据”集成最佳实践](https://www.yuque.com/dataflux/bp/aliyun-monitoring)
- 日志最佳实践
   - [logback socket 日志采集最佳实践](https://www.yuque.com/dataflux/bp/k8s-socket)

更多最佳实践更新可参考 [最佳实践版本历史](https://www.yuque.com/dataflux/bp/changelog) 。

### 场景模版更新

#### 新增场景自定义查看器 MySQL 数据库查看器模板

观测云的场景自定义查看器新增 MySQL 数据库查看器模版，可帮助你一键搭建 MySQL 日志的查看器。在观测云工作空间「场景」-「查看器」-「内置查看器模版」，点击「MySQL 查看器模版」，即可直接创建 MySQL 日志查看器，若已经采集相关日志，即可通过该日志查看器进行数据查看和分析。更多详情可参考 [场景自定义查看器](https://www.yuque.com/dataflux/doc/uynpbs) 。
![11.changelog_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1646913674515-66763fba-2434-4927-baf3-5bd7e95f9108.png#clientId=ue55e86fa-8dbd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u042d3980&margin=%5Bobject%20Object%5D&name=11.changelog_1.png&originHeight=571&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&size=171050&status=done&style=stroke&taskId=uefb04933-0bac-4439-8aba-45d5eea530e&title=)

### 集成模版更新

#### 新增主机系统 EthTool 集成文档和视图

[EthTool](https://www.yuque.com/dataflux/integrations/gpv332) 指标包括网络接口入/出流量，入/出数据包，丢弃的数据包等。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1646805730871-27dba35a-1d2e-40d9-8719-55444466de56.png#clientId=u873d2e72-890b-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=305&id=u13a12b08&margin=%5Bobject%20Object%5D&name=image.png&originHeight=457&originWidth=1612&originalType=binary&ratio=1&rotation=0&showTitle=false&size=99859&status=done&style=stroke&taskId=u2fae8efb-6a4b-4fc4-adca-b535709729d&title=&width=1074.6666666666667)
 
#### 新增主机系统 Conntrack 集成文档和视图

[Conntrack](https://www.yuque.com/dataflux/integrations/pnnltg) 性能指标包括成功搜索条目数，插入的包数，连接数量等。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21512093/1646638741387-fd194675-ad50-4007-bb77-da7d03d61f3c.png#clientId=u3f5e7e95-9cde-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=298&id=ubb18be5d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=447&originWidth=1603&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51011&status=done&style=stroke&taskId=u567238be-fbd0-49f1-aef0-e268608e66f&title=&width=1068.6666666666667)

更多集成模版更新可参考 [集成文档版本历史](https://www.yuque.com/dataflux/integrations/changelog) 。

## 2022 年 2 月 22 号

#### 新增日志配置 pipeline 脚本

Pipeline 用于日志数据解析，通过定义解析规则，将格式各异的日志切割成符合我们要求的结构化数据。观测云提供三种日志 Pipeline 文本处理方式：

- [DataKit](https://www.yuque.com/dataflux/doc/gxh1t2)：在服务器安装DataKit以后，在终端工具中配置DataKit的日志采集器及其对应的 pipeline 文件，对文本数据进行处理；
- [DCA](https://www.yuque.com/dataflux/doc/fgcgug)：DataKit Control APP，是DataKit的桌面客户端应用，需要先安装，安装完成后可在客户端查看和编辑 DataKit 默认自带的日志 pipeline 文件和自定义手动添加 pipeline 文件；
- [Pipelines](https://www.yuque.com/dataflux/doc/caczze)：支持在观测云工作空间手动配置和查看日志 pipeline 文件，无需登录 DataKit 服务器进行操作。

![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645178259538-cffb882a-89bf-4d03-bf2b-7efe530c78d2.png#crop=0&crop=0&crop=1&crop=1&from=url&id=JiHbH&margin=%5Bobject%20Object%5D&originHeight=208&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 新增 IFrame 图表组件

观测云新增 IFrame 图表组件，支持您配置 https 或者 http 链接地址。在 IFrame URL 可直接输入外网地址查看，或者在 IFrame URL 使用模版变量查看，更多配置详情可参考文档 [IFrame](https://www.yuque.com/dataflux/doc/yehahh) 。
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645498778382-3318e6ea-94a3-4111-9ced-2214998d4430.png#crop=0&crop=0&crop=1&crop=1&from=url&id=vRz5Q&margin=%5Bobject%20Object%5D&originHeight=713&originWidth=1357&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)

#### 新增事件详情历史记录、关联 SLO

观测在事件详情页优化基础属性、状态&趋势和关联事件布局，并新增历史记录和关联 SLO ，在异常事件列表中点击事件名称，即可查看。更多详情可参考文档 [事件](https://www.yuque.com/dataflux/doc/vzall6#cPhc7) 。

新增事件的历史记录，支持查看检测对象主机、异常/恢复时间和持续时长。
![9.event_6.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521580941-e9830b8e-ff7f-4a65-be8a-71018e2a58d8.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0183d6d3&margin=%5Bobject%20Object%5D&name=9.event_6.png&originHeight=229&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38111&status=done&style=stroke&taskId=ud3e506e1-a83f-4c94-89ef-569d1813b03&title=)
若在监控配置了 SLO ，则可以查看关联 SLO ，包括 SLO 名称、达标率、剩余额度、目标等信息。
![9.event_8.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645521672593-07b5553d-0438-4627-8eac-2e0862802c31.png#clientId=uab7a75ec-5540-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue0272efd&margin=%5Bobject%20Object%5D&name=9.event_8.png&originHeight=171&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38569&status=done&style=stroke&taskId=u59550015-c73e-4a33-bb10-13528f31709&title=)

#### 新增保存快照默认开启绝对时间

观测云新增保存快照时默认开启绝对时间。

- 若在保存快照的时候选择开启绝对时间，分享后则显示保存快照时的绝对时间。如保存快照时，选择最近15分钟，您在14：00点开快照链接，显示之前的绝对时间的数据；
- 若在保存快照的时候选择关闭绝对时间，分享后则显示保存快照时的绝对时间。如保存快照时，选择最近15分钟，您在14：00点开快照链接，显示13：45 ~ 14：00的数据。

更多快照分享详情可参考文档 [快照](https://www.yuque.com/dataflux/doc/uuy378) 。
![8.snap_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645508626528-1b938a86-7c5a-4d5b-b30d-774689d6f3a2.png#clientId=uf00feb2e-5a2b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u2c350d31&margin=%5Bobject%20Object%5D&name=8.snap_1.png&originHeight=382&originWidth=1243&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71081&status=done&style=stroke&taskId=udadd82cf-49da-41bf-bfce-2352daf3b1f&title=)

#### 优化监控器无数据触发事件配置及触发条件单位提示

观测云新增三种无数据状态配置「触发无数据事件」、「触发恢复事件」、「不触发事件」。

- 指标类数据监控器配置时，需要手动配置无数据处理策略；
- 日志类数据监控器配置时，默认选择「触发恢复事件」策略，不需要做无数据的配置，获取「正常」条件处的周期作为无数据恢复事件周期；

![11.changelog_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1645530685618-ea410e7f-6bdd-43c3-9e38-a14e368c2fa3.png#clientId=u9ae54f9e-d415-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u30d0775c&margin=%5Bobject%20Object%5D&name=11.changelog_1.png&originHeight=422&originWidth=1205&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56961&status=done&style=stroke&taskId=ud2f45358-5dbb-4afe-8eb8-71ab4d6d505&title=)

#### 优化图表查询表达式计算单位

观测云优化图表查询表达式计算单位逻辑。若查询 A 带单位，查询 A 与数字的运算结果同样带单位。例如：A 的单位是 KB，那么A+100的单位也是 KB。更多详情可参考文档 [图表查询](https://www.yuque.com/dataflux/doc/cxlbps#S37pM) 。

#### 新增“时间线”按量付费模式

观测云新增“时间线”按量付费模式，并优化“DataKit+时间线”按量付费模式，具体计费模式可参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans#BhPoQ)。

#### 其他优化功能

- 图表查询数据来源日志、应用性能、安全巡检和网络支持全选（*）;
- 图表查询文案、按钮样式以及文字提示优化；
- 工作空间操作按钮图标化，如编辑、删除等等。
- 其他 UI 显示优化
## 2022 年 1 月 20 号
#### 
#### 新增 Open API 及 API Key 管理

“观测云” 支持通过调用 Open API 接口的方式来获取和更新观测云工作空间的数据，在调用 API 接口前，需要先创建 API Key 作为认证方式。更多详情，可参考文档 [API Key 管理](https://www.yuque.com/dataflux/doc/ag17mc) 。![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642671985351-ac1327f8-0849-4ec1-bb89-5936f6ea8121.png#clientId=u63cdab9d-353e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=286&id=u89319439&margin=%5Bobject%20Object%5D&name=image.png&originHeight=286&originWidth=1249&originalType=binary&ratio=1&rotation=0&showTitle=false&size=37553&status=done&style=none&taskId=ud6aa2c3a-25c3-4e71-9035-50dead6662f&title=&width=1249)

#### 新增指标字典、指标单位管理

指标数据采集后，可以在观测云工作空间的「指标字典」查看所有采集的指标集及其指标和标签，支持为自定义指标数据手动设置单位。更多详情，可参考文档 [指标字典](https://www.yuque.com/dataflux/doc/mq149i) 。

- 指标可以帮助您了解系统的整体可用性，比如说服务器 CPU 使用情况，网站的加载耗时等，配合观测云提供的日志和链路追踪，可以帮助您快速定位和解决故障。
- 标签可以帮助您关联数据，观测云支持把所有的指标、日志、链路数据统一上报到工作空间，通过对采集的数据打上相同的标签进行关联查询，可以帮您进行关联分析，发现并解决存在的潜在风险。

![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642661117658-243f6186-5add-49ce-b92a-321ac142aa19.png#crop=0&crop=0&crop=1&crop=1&from=url&id=ABVMc&margin=%5Bobject%20Object%5D&originHeight=525&originWidth=1239&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=stroke&title=)
#### 新增场景图表漏斗图

漏斗图一般适用于具有规范性、周期长、环节多的流程分析，通过漏斗图比较各环节的数据，能够直观地对比问题。另外漏斗图还适用于网站业务流程分析，展示用户从进入网站到实现购买的最终转化率，及每个步骤的转化率。更多详情，可参考文档 [漏斗图](https://www.yuque.com/dataflux/doc/hf6x84) 。
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642673574927-01c960b0-6fa9-4de6-830c-6bd555050af6.png#clientId=u63cdab9d-353e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=394&id=u6d75fe77&margin=%5Bobject%20Object%5D&name=image.png&originHeight=394&originWidth=750&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51534&status=done&style=stroke&taskId=u30594bd7-35ce-4962-bef6-8502af95f45&title=&width=750)

#### 新增场景仪表板保存到内置视图，并绑定 Label 数据

仪表版视图创建完成后，可以点击“设置”按钮，选择“保存到内置视图”，把仪表板视图保存到内置视图的“用户视图”。
![4.dashboad_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642503692354-2e09d6a9-9d1e-4929-a74d-472b7e446a78.png#clientId=ub39217ba-1339-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=mrbvx&margin=%5Bobject%20Object%5D&name=4.dashboad_1.png&originHeight=456&originWidth=1255&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97833&status=done&style=stroke&taskId=u5f2c77b5-3323-42d3-bd2b-d16dff45ebf&title=)
仪表板视图保存到内置视图时，支持选择绑定关系，选择绑定关系“label”。保存到内置视图后，即可在观测云工作空间「管理」-「内置视图」的「用户视图」查看保存的仪表版视图。同时因为设置了绑定关系`label:*`，在基础设施设置过 “Label 属性”的主机、容器详情页即可查看绑定的内置视图。更多详情，可参考文档 [保存仪表板为内置视图](https://www.yuque.com/dataflux/doc/gqatnx#dP9Qb) 。
![4.dashboad_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642503701221-c3636ec0-fda7-49a9-9305-28f48d5d1a27.png#clientId=ub39217ba-1339-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=QejSp&margin=%5Bobject%20Object%5D&name=4.dashboad_3.png&originHeight=459&originWidth=1253&originalType=binary&ratio=1&rotation=0&showTitle=false&size=66895&status=done&style=stroke&taskId=u61833156-6105-4ac4-9562-09ce892a510&title=)

#### 新增容器详情页关联 Pod

在容器详情页，支持您通过详情页查看相关 Pod（关联字段：pod_name）的基本信息和**在选定时间组件范围内**的性能指标状态。更多容器关联查询，可参考文档 [容器](https://www.yuque.com/dataflux/doc/gy7lei/) 。
注意：在容器详情中查看相关 Pod，需要匹配字段“pod_name”，否则无法在容器详情查看到相关 Pod 的页面。
![8.contrainer_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642665099139-f87d7541-0767-4b5f-97ad-70fdad9e6fa7.png#clientId=u70bc9600-322e-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u2921a83f&margin=%5Bobject%20Object%5D&name=8.contrainer_1.png&originHeight=317&originWidth=1141&originalType=binary&ratio=1&rotation=0&showTitle=false&size=39064&status=done&style=stroke&taskId=u278d2c8d-118e-4ec2-8913-0b3f706714f&title=)

#### 新增监控器分组管理

观测云新增的分组功能支持您在设定监控器时，自定义创建有意义的监测器组合，支持通过「分组」筛选出对应监控器，方便分组管理各项监控器。更多详情，可参考文档 [分组管理](https://www.yuque.com/dataflux/doc/hd5ior#joogr) 。
注意：

- 每个监控器创建时必须选择一个分组，默认选中「默认分组」；
- 当某个分组被删除时，删除分组下的监控器将自动归类到「默认分组」下。

![2.monitor_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642417041778-6d2fd1ba-c65a-4048-a734-c3957cdd6cb9.png#clientId=ub663233b-8a61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u07c5f138&margin=%5Bobject%20Object%5D&name=2.monitor_1.png&originHeight=498&originWidth=1247&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75514&status=done&style=stroke&taskId=ub843dbde-b2bc-4083-b579-b5c0d7a2558&title=)

#### 新增日志查看器、表格图、日志流图格式化配置

观测云新增的格式化配置可以让您隐藏敏感日志数据内容或者突出需要查看的日志数据内容，还可以通过替换原有日志内容进行快速筛选。支持在[日志查看器](https://www.yuque.com/dataflux/doc/uynpbs#TBmik)、[表格图](https://www.yuque.com/dataflux/doc/gd2mzn#ZZgmL)、[日志流图](https://www.yuque.com/dataflux/doc/nyca45#ZZgmL)进行格式化配置。
![5.browser_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642580643893-644ffb18-296c-4ebe-81d7-86168d401582.png#clientId=ub505f5e4-9a1a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uaf5e0fa8&margin=%5Bobject%20Object%5D&name=5.browser_5.png&originHeight=495&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94421&status=done&style=stroke&taskId=u428b595b-2d26-4d67-8902-50192beba7b&title=)

#### 优化静默管理，新增禁用/启用规则

观测云新增静默规则禁用/启用功能，帮助您快速禁用/启用静默任务。更多详情，可参考文档 [静默管理](https://www.yuque.com/dataflux/doc/gn55dz) 。

- 启用：静默规则按照正常流程执行
- 禁用：静默规则不生效；若有设置静默通知策略，选择的是开始前“xx分钟”且静默通知操作还未执行的情况下，通知不会执行

注意：启用/禁用规则都会产生操作审计事件，可在观测云工作空间「管理」-「基本设置」下的操作审计进行查看。
![2.monitor_6.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642493491992-42dc2f3d-6bee-4d01-8cbb-ab17c2391744.png#clientId=u88f73e85-8170-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=rh6TX&margin=%5Bobject%20Object%5D&name=2.monitor_6.png&originHeight=296&originWidth=1247&originalType=binary&ratio=1&rotation=0&showTitle=false&size=51515&status=done&style=stroke&taskId=u423d56f7-d8c0-427f-ae20-a846d8bf073&title=)

#### 新增日志 pipeline 使用手册

观测云新增日志的 [pipeline 使用手册](https://www.yuque.com/dataflux/doc/gxh1t2)，帮助您了解如何通过 DataKit 内置的调试工具，来辅助编写 Pipeline 脚本。
```
# 调试脚本示例
datakit --pl datakit.p --txt '2022-01-12T18:40:51.962+0800 WARN diskio diskio/input.go:320 Error gathering disk info: open /run/udev/data/b252:1: no such file or directory'

# 提取成功示例
Extracted data(drop: false, cost: 3.108038ms):
{
  "code": "diskio/input.go:320",
  "level": "WARN",
  "message": "2022-01-12T18:40:51.962+0800 WARN diskio diskio/input.go:320 Error gathering disk info: open /run/udev/data/b252:1: no such file or directory",
  "module": "diskio",
  "msg": "Error gathering disk info: open /run/udev/data/b252:1: no such file or directory",
  "time": 1641984051962000000
}
```

#### 新增 DQL 外层函数

观测云新增两个外层函数`rate()`和`irate()`。

- rate()：计算某个指标一定时间范围内的平均变化率。适合警报和缓慢移动的计数器。
- irate()：计算某个指标一定时间范围内的瞬时变化率，适合绘制易失性、快速变化的计数器。

更多详情，可参考文档 [DQL 外层函数](https://www.yuque.com/dataflux/doc/wgrf10#hwbBA) 。

## 2021 年 12 月 30 号

#### 优化绑定内置视图

“观测云” 支持通过将内置视图与不同的链路服务、应用、日志源、项目等字段进行关联绑定，根据绑定字段可在对应的查看器详情页查看绑定的内置视图（系统视图、用户视图），支持的查看器包括场景自定义查看器、基础设施、日志、链路、用户访问、安全巡检、可用性等查看器。更多详情介绍可参考文档 [绑定内置视图](https://www.yuque.com/dataflux/doc/dns233) 。
![4.view_bang_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1640767151595-7295fcbd-c6ae-4617-96ad-f340b077b90e.png#clientId=uba0df414-8b6e-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u79f52b91&margin=%5Bobject%20Object%5D&name=4.view_bang_2.png&originHeight=422&originWidth=1088&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56879&status=done&style=stroke&taskId=ucb0dc9ab-5772-4dcc-a023-7914620b590&title=)
#### 优化日志查看器

- 在日志查看器，左侧来源列表首次登录默认展开，可手动收起，查看器会默认记住最后一次的状态；
- 在日志查看器，点击左侧设置按钮，可手动添加筛选字段进行快捷筛选；
- 在日志数据列表，您可以使用“鼠标悬停”至日志内容，展开查看日志的全部内容，点击“复制”按钮可把整条日志内容复制到粘贴板。展开时若可以系统会将该条日志JSON格式化，若不可以则正常展示该日志内容。更多日志查看器的介绍，可参考文档 [日志分析](https://www.yuque.com/dataflux/doc/ibg4fx) 。

![6.log_12.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1640847038179-8878d9e1-c78e-4a1b-b9ea-440f570fc713.png#clientId=ua8e6f84f-aefc-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u72e7f685&margin=%5Bobject%20Object%5D&name=6.log_12.png&originHeight=432&originWidth=1227&originalType=binary&ratio=1&rotation=0&showTitle=false&size=73811&status=done&style=stroke&taskId=uba6dfb2e-56a9-4f94-8a96-6aaaa569de6&title=)

#### 优化查看器详情页关联显示

在日志、基础设施、链路、安全巡检查看器详情页优化关联显示，包括主机、指标、链路、容器、日志、Pod等关联查询显示，支持两种关联显示：固定显示和非固定显示（需要根据是否包含关联字段来显示关联查询）。

以日志查看器详情页关联主机为例，关联字段分别为“host”，在日志详情中查看相关主机，需要匹配字段“host”，否则无法在日志详情查看到相关主机的页面。字段匹配后，在关联主机下可以查看主机的基本信息和指标性能状态。更多详情可参考 [日志分析](https://www.yuque.com/dataflux/doc/ibg4fx#MDXYO) 。

- 属性视图：包括主机的基本信息、集成运行情况，若开启云主机的采集，还可查看云厂商的信息。

![7.host_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1640842768987-f567b22d-3f2d-4b72-a685-129d5513adaf.png#clientId=ua8e6f84f-aefc-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9c17b30f&margin=%5Bobject%20Object%5D&name=7.host_1.png&originHeight=715&originWidth=1110&originalType=binary&ratio=1&rotation=0&showTitle=false&size=86432&status=done&style=stroke&taskId=u10babe85-12c3-4c1c-ac75-85589fa6d50&title=)

- 指标视图：可查看默认15分种内，相关主机的CPU、内存等性能指标视图。点击「打开该视图」至内置视图，可通过克隆的方式对主机视图进行自定义修改，并作为用户视图保存，用户视图可通过绑定在日志详情页查看，更多配置详情，可参考[绑定内置视图](https://www.yuque.com/dataflux/doc/dns233/)。

![7.host_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1640842998611-e27ff0bd-1cd0-46f2-ab84-add85ee16121.png#clientId=ua8e6f84f-aefc-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u129544f2&margin=%5Bobject%20Object%5D&name=7.host_2.png&originHeight=669&originWidth=1102&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116942&status=done&style=stroke&taskId=u49047089-bf7a-4dd4-aecc-9c88a621c3f&title=)

#### 优化快照分享

快照分享支持隐藏分享页面的顶部栏，在快照列表，点击分享按钮，即可在弹出对话框中进行高级设置“隐藏顶部栏”。更多详情介绍可参考文档 [快照](https://www.yuque.com/dataflux/doc/uuy378#ZpIz5) 。
![12.share_pic_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1640861300892-2b6e0567-cd96-4e4f-b028-20955bc8fcca.png#clientId=u575bad39-5c3f-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u77748abc&margin=%5Bobject%20Object%5D&name=12.share_pic_1.png&originHeight=261&originWidth=534&originalType=binary&ratio=1&rotation=0&showTitle=false&size=16316&status=done&style=stroke&taskId=u1b2ef41c-671d-47ae-86a6-e27e747f87b&title=)
#### 优化图表查询结果显示千分位

观测云仪表板图表查询结果支持自动加上数据千分位格式显示，若设置了单位，则按照设置的单位显示数据格式，设置完成后可以在预览情况下查看。更多详情可参考文档 [图表查询](https://www.yuque.com/dataflux/doc/cxlbps#zR8G0) 。
![13.table_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1640862968830-194ad7f6-bf80-4a6d-a684-6aeeec779751.png#clientId=u70bdef1f-4800-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0730e455&margin=%5Bobject%20Object%5D&name=13.table_4.png&originHeight=385&originWidth=795&originalType=binary&ratio=1&rotation=0&showTitle=false&size=29842&status=done&style=stroke&taskId=u3ea3ad5d-5662-449b-aa08-d4d5e0e7ce5&title=)
#### 其他优化功能

- 优化主机网络拓扑图查询性能，新增目标域名在网络拓扑图节点显示。即若目标主机不在当前工作空间但是目标域名存在且目标域名的端口小于 10000 ，则目标域名会在拓扑图中显示。
- 优化场景仪表板、笔记查看器收藏置顶逻辑：
   - 未收藏的仪表板，按创建时间倒序排序
   - 收藏的仪表板，按收藏时间倒序排序
   - 收藏的仪表板显示在未收藏的仪表板上方
- 优化视图变量级联查询逻辑，即两个变量联动查询时，前一个选择`*`，联动的变量不做筛选，展示所有的 value 值。
- 优化左侧收起的导航栏，增加导航栏的帮助文档链接。
## 2021 年 12 月 16 号

#### 新增时序图相似性指标查询

在时序图的分析模式下，支持选中“图表查询”为指标查询的趋势线/柱，可“查看相似趋势指标”。通过框选的绝对时间范围，可查询空间内相似的指标趋势。更多详情可参考文档 [时序图相似趋势指标](https://www.yuque.com/dataflux/doc/sqg3vu#ATVjL) 。  
![12.changelog_8.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639668159480-a86827a4-1aba-4f0e-b9f7-18a283d2bb62.png#clientId=u8b555627-f7ea-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uecd7f7f0&margin=%5Bobject%20Object%5D&name=12.changelog_8.png&originHeight=1490&originWidth=1270&originalType=binary&ratio=1&rotation=0&showTitle=false&size=215344&status=done&style=stroke&taskId=u858997a4-37f7-4890-a7b9-fbaf691d502&title=)
#### 新增查看器详情页关联数据统计显示
新增查看器详情页的相关日志、链路、容器等列表数据量统计，支持在查看器详情页面的Tab标题中直接获取相关数据的统计量显示，包括基础设施、日志、应用性能、用户访问、安全巡检等查看器。
![12.changelog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639645661327-1a492250-4b07-451a-86ca-a24d4a42d602.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u58ea9b2e&margin=%5Bobject%20Object%5D&name=12.changelog_2.png&originHeight=731&originWidth=1140&originalType=binary&ratio=1&rotation=0&showTitle=false&size=146690&status=done&style=stroke&taskId=u96b6409b-0f56-4a94-bbca-954e574df4a&title=)
#### 新增查看器图表导出功能

观测云支持将“观测云”空间查看器中的任意图表导出到仪表板、笔记或粘贴板。 
![12.changelog_3.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639646421784-1f84af8e-7728-466e-9b33-64671ef4146d.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u21ee2a1c&margin=%5Bobject%20Object%5D&name=12.changelog_3.1.png&originHeight=281&originWidth=1243&originalType=binary&ratio=1&rotation=0&showTitle=false&size=62620&status=done&style=stroke&taskId=u806a391b-0c56-49a7-a975-14f73d16290&title=)
#### 新增查看器搜索match匹配

观测云支持在查看器的搜索栏通过字段筛选如“host:cc*”格式进行`wildcard`搜索，可用于如命名开头一致的主机日志数据筛选。同时在查看器搜索栏右侧增加“删除号”，支持文本输入一键删除。更多查看器搜索详情可参考文档 [查看器搜索说明](https://www.yuque.com/dataflux/doc/wi8yz6) 。
![12.changelog_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639647534767-f6359b80-84d5-4d8b-815c-071f69cff892.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u64c0f56c&margin=%5Bobject%20Object%5D&name=12.changelog_4.png&originHeight=282&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&size=41550&status=done&style=stroke&taskId=u97a3b3d0-4cc6-47c3-b95d-c2d14b53a6d&title=)

#### 优化日志查看器和日志类关联数据查询

- “观测云” 通过日志详情页下方的「容器」可以查看最近十分钟内与该日志相关主机的全部容器（Container）数据。
- 日志详情页相关的链路和容器数据支持以“trace_id“或“host”筛选
- 日志详情页的内容展示支持Json 和 文本两种查看模式，依据 message 类型自动显示格式
- 通过近似文本查看器，可查看Pattern聚类后关联日志的详情
- 日志查看器的鼠标悬浮hover提示去掉颜色

更多日志优化详情可参考文档 [日志分析](https://www.yuque.com/dataflux/doc/ibg4fx) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1639461998289-62dad4c3-670b-4803-b8a1-41d35ff9a1ad.png#clientId=u13702a44-3c68-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=444&id=u815dc758&margin=%5Bobject%20Object%5D&name=image.png&originHeight=444&originWidth=856&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64132&status=done&style=stroke&taskId=u09510cfe-823f-4a4c-8c75-47d58811272&title=&width=856)
#### 优化沉默策略，支持针对监控器规则设置沉默

观测云支持用户在「监控」功能中，通过“静默管理”是对当前空间的全部静默规则进行管理。“观测云”提供了三种静默类型，包括主机静默、监控器静默、分组静默，支持对不同的主机、监控器、分组进行静默管理，使静默对象在静默时间内不向任一告警通知对象发送告警通知。更多详情可参考文档 [静默管理](https://www.yuque.com/dataflux/doc/gn55dz) 。 
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1639535284460-89caad91-70f2-46ac-934d-4ac1975fbad2.png#clientId=ua28487dc-1f82-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=519&id=u05392f5d&margin=%5Bobject%20Object%5D&name=image.png&originHeight=519&originWidth=742&originalType=binary&ratio=1&rotation=0&showTitle=false&size=41911&status=done&style=stroke&taskId=u1dbc2273-955f-4d14-a902-e0e64d96937&title=&width=742)

#### 优化监控器管理

监控器列表出现重复的监控器会影响用户快速定位监控对象，“观测云”支持选择是否从模版新建重复的监控器。同时，用户可通过新增的”批量管理”工具，自定义导出/删除监控器。更多详情可参考文档 [监控器管理](https://www.yuque.com/dataflux/doc/hd5ior) 。 
![12.changelog_5.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639648609243-3aed7f88-0a50-4fb7-bbf2-ca0cf5f32599.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u68e4121a&margin=%5Bobject%20Object%5D&name=12.changelog_5.png&originHeight=252&originWidth=514&originalType=binary&ratio=1&rotation=0&showTitle=false&size=26278&status=done&style=stroke&taskId=u79ac4951-5ca0-4def-ab25-8d7e0470f94&title=)
#### 优化视图变量的查询显示
 

- 仪表板视图变量新增默认值，支持预览当前视图变量的全部变量，并选择在仪表板默认查看的初始变量
- 支持通过鼠标悬浮（hover）拖动视图变量以调节先后顺序
- 去除视图变量的「设置」按钮，可直接在视图变量列表中使用“排序”、“隐藏”和“删除”功能

更多详情可参考文档 [视图变量](https://www.yuque.com/dataflux/doc/mgpxkf ) 。
![12.changelog_6.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639649956290-db6d734d-01b4-4723-b0bb-00c7d17deeef.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udeaeee56&margin=%5Bobject%20Object%5D&name=12.changelog_6.png&originHeight=264&originWidth=1232&originalType=binary&ratio=1&rotation=0&showTitle=false&size=36401&status=done&style=stroke&taskId=uaf28b938-c524-4396-a3cf-d47878d0c3e&title=)
#### 优化仪表板、笔记图表锁定时间设置

观测云支持在仪表板、笔记图表锁定时间设置增加“更多”选择来自定义锁定时间范围，此次优化后锁定时间组件和图表组件功能保持一致。
![12.changelog_7.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639651819321-02de4297-d2e4-4beb-8dd1-96d1b5c27486.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u80327e9a&margin=%5Bobject%20Object%5D&name=12.changelog_7.png&originHeight=711&originWidth=1355&originalType=binary&ratio=1&rotation=0&showTitle=false&size=135076&status=done&style=stroke&taskId=ub75e70f0-f9ef-4011-bd94-a99729ae3fa&title=)

#### 优化帮助中心页面入口 

在观测云帮助中心，可快速查看产品文档、产品更新、博客、直播回顾等多种信息，在可通过扫码的方式加入我们观测云的官方服务群。
![12.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1639643606181-b2640507-688b-4805-9758-c5ed7b42fc09.png#clientId=u5b78c905-06cd-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=x9e2d&margin=%5Bobject%20Object%5D&name=12.changelog_1.png&originHeight=951&originWidth=1256&originalType=binary&ratio=1&rotation=0&showTitle=false&size=345319&status=done&style=stroke&taskId=ub223150e-2bb0-487d-bca0-c519423dfc9&title=)
## 2021 年 12 月 2 号

#### 新增拥有者成员角色

观测云新增当前工作空间的拥有者角色，目前支持定义四种工作空间成员权限，包括“拥有者”、“管理员”、“标准成员”和“只读成员”，分别对不同成员类别的管理权限、配置权限、操作权限、浏览权限进行了约束。“拥有者”角色拥有最高操作权限，可以指定当前空间“管理员”并进行任意的管理、配置、操作和数据浏览。在观测云工作空间的「管理」-「成员管理」-「修改」，即可编辑更新成员的权限。详情可参考文档 [权限管理](https://www.yuque.com/dataflux/doc/nzlwt8) 。

![6.changelog_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1638448224857-941a9975-ac73-4e18-82ac-b86a1f8bc3ac.png#clientId=ued14605b-30b2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua1487ee3&margin=%5Bobject%20Object%5D&name=6.changelog_4.png&originHeight=255&originWidth=533&originalType=binary&ratio=1&rotation=0&showTitle=false&size=23558&status=done&style=stroke&taskId=u77ec9c92-7055-4626-b76d-7136aec0a24&title=)
#### 场景新增自定义查看器

“观测云”在场景提供了可快速搭建的基于日志数据范围的查看器，支持空间成员共同搭建基于自定义场景的查看器，定制化查看需求。制作完成的“查看器”可导出分享给他人，共享查看器模版。详情可参考文档 [查看器](https://www.yuque.com/dataflux/doc/uynpbs) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1638257995436-9fe13cd7-e486-4f2d-aaa0-2a5febe06e99.png#clientId=ua66d3fb0-fc29-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=601&id=KMQEh&margin=%5Bobject%20Object%5D&name=image.png&originHeight=601&originWidth=961&originalType=binary&ratio=1&rotation=0&showTitle=false&size=133666&status=done&style=stroke&taskId=ua7a4d85f-e62d-48d5-acb1-a10bf44d2a6&title=&width=961)

#### 新增导出用户视图到仪表板

“观测云”支持在「内置视图」中，导出已创建的用户视图为一份json文件，json文件可用于不同工作空间的场景或内置视图导入。详情可参考文档 [内置视图](https://www.yuque.com/dataflux/doc/gyl9vv) 。
![6.changelog_5.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1638449003289-7e402f72-5b5f-45f8-ab79-fea013efefb8.png#clientId=ued14605b-30b2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue734f923&margin=%5Bobject%20Object%5D&name=6.changelog_5.png&originHeight=268&originWidth=1245&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49577&status=done&style=stroke&taskId=u2819342b-f3d3-4289-a1c4-766286fba69&title=)
#### 优化主机网络可观测，新增网络流数据查看列表

“观测云”支持在基础设施「主机」详情页的「网络」，根据选择不同的协议展示不同的可视化图表，并自定义网络流数据列表显示字段。
![6.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1638446657761-1446d869-52af-44eb-9328-2668a97e355b.png#clientId=ued14605b-30b2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u4773c11a&margin=%5Bobject%20Object%5D&name=6.changelog_1.png&originHeight=786&originWidth=1106&originalType=binary&ratio=1&rotation=0&showTitle=false&size=125577&status=done&style=stroke&taskId=uadb4e04a-443b-4748-b445-e19d0de527e&title=)
通过点击「查看网络流数据」，支持默认查看最近2天的网络流数据，包括时间、源IP/端口、目标IP/端口、源主机、传输方向、协议、发送字节数等。支持自定义显示字段，或添加筛选条件，筛选所有字符串类型的keyword字段。详情可参考文档 [主机网络](https://www.yuque.com/dataflux/doc/mwqbgr#PqtQj) 。
![6.changelog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1638447248976-a8f068bf-e128-4d89-aabf-f9ccaf2ce7d9.png#clientId=ued14605b-30b2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u940ae8c3&margin=%5Bobject%20Object%5D&name=6.changelog_2.png&originHeight=467&originWidth=1104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=77371&status=done&style=stroke&taskId=u4738cba5-511b-4912-868a-bac4b8ca9f7&title=)

#### 新增sourcemap功能

应用在生产环境中发布的时候，为了防止代码泄露等安全问题，一般打包过程中会针对文件做转换、压缩等操作。以上举措在保障代码安全的同时也致使收集到的错误堆栈信息是经过混淆后的，无法直接定位问题，为后续 Bug 排查带来了不便。

为了解决以上的问题，"观测云" 为 Web 应用程序提供 sourcemap 功能，支持还原混淆后的代码，方便错误排查时定位源码，帮助用户更快解决问题。详情可参考文档 [Sourcemap上传](https://www.yuque.com/dataflux/doc/qefigz) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1638354143520-d825d40f-334b-4f3c-9b63-12beea936b5d.png#clientId=uc87c46a2-a9d8-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=322&id=uc28164d1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=322&originWidth=1018&originalType=binary&ratio=1&rotation=0&showTitle=false&size=76717&status=done&style=stroke&taskId=ufa580c5c-8f2f-488f-ad7c-07f403d8f0b&title=&width=1018)

#### 新增主机关联安全巡检数据分析

“观测云”支持查看最近一天内与该主机相关的安全巡检数据，并对这些安全巡检数据进行关键字搜索、多标签筛选和数据排序。详情可参考文档 [关联安全巡检](https://www.yuque.com/dataflux/doc/mwqbgr#JAbqW) 。
![6.changelog_6.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1638449524284-f15524f7-08dd-422c-ba0e-793be18d2823.png#clientId=ued14605b-30b2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u11db56a8&margin=%5Bobject%20Object%5D&name=6.changelog_6.png&originHeight=392&originWidth=1142&originalType=binary&ratio=1&rotation=0&showTitle=false&size=100865&status=done&style=stroke&taskId=u9e556e32-c913-400a-9105-30005037aea&title=)
#### 新增DataKit采集器kubernetes安装引导

“观测云”支持在工作空间「集成」-「DataKit」中新增在 Kubernetes 集群安装 DataKit 采集器引导说明。
![6.changelog_8.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1638451198986-36bd91e4-a0df-4a2e-a61c-88d6744c19f5.png#clientId=ued14605b-30b2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua88776aa&margin=%5Bobject%20Object%5D&name=6.changelog_8.png&originHeight=994&originWidth=1198&originalType=binary&ratio=1&rotation=0&showTitle=false&size=167433&status=done&style=stroke&taskId=u6fbaee1a-297d-4231-b5d8-03e3aa752d6&title=)

#### 优化用户访问监测关联链路查询

“观测云”支持在链路详情页和用户访问页面性能详情页（用户访问监测view查看器），将属性添加到当前筛选或复制（复制该标签至本地粘贴板）。详情可参考文档 [用户访问监测查看器](https://www.yuque.com/dataflux/doc/dh5lg9) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1638439771358-70034e01-662e-4396-ad9f-0d4ba62b39d5.png#clientId=ucacabab4-3826-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=267&id=u66fbaec5&margin=%5Bobject%20Object%5D&name=image.png&originHeight=267&originWidth=902&originalType=binary&ratio=1&rotation=0&showTitle=false&size=49825&status=done&style=stroke&taskId=uf0a5c88f-7e9a-48f2-823e-faad498cea2&title=&width=902)
#### 优化注册升级流程

观测云新增注册账号时直接选择开通观测云计费平台，并对登录到工作空间后，升级到敏捷版的流程进行优化，详情请参考文档 [观测云计费平台结算](https://www.yuque.com/dataflux/doc/xcifgo) 。

#### 计费降价调整

观测云采用最新的技术，优化数据存储成本，故对计费进行降价调整，新增基于[数据存储策略](https://www.yuque.com/dataflux/doc/evmgge)的梯度计费模式，包括日志类数据、应用性能 Trace、用户访问 PV 这三个计费项。更多价格和数据过期策略详情请参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。

另外为了助力企业以更优惠的价格，更全面的观测IT基础设施、应用系统等企业资产，观测云根据企业的不同发展阶段推出三种套餐包：初创加速包、创业发展包以及企业标准包，以及可叠加流量包供企业按照自身需求和套餐叠加使用。更多套餐包详情请参考文档 [套餐说明](https://www.yuque.com/dataflux/doc/fbpn8y) 。

#### 其他优化功能

- 监控器用户访问指标检测新增 LCP、FID、CLS、FCP 相关检测指标。在观测云工作空间「监控」-「监控器」，点击「+新建监控器」，选择「用户访问指标检测」，即可进入检测规则的配置页面。详情可参考文档 [用户访问指标检测](https://www.yuque.com/dataflux/doc/qnpqmm) 。 
- 监控器简单查询中的分组更改为检测维度，检测维度决定着检测规则基于哪个维度触发，即触发对象。“观测云”支持添加多个检测维度，任意一个检测维度的指标满足告警条件则触发告警。
- 优化导航菜单显示，“观测云”工作台的导航栏呈收起状态时，二级菜单顶格显示该功能的导航名称。

## 2021 年 11 月 18 号

#### 新增SSO登录

观测云支持用户基于工作空间创建身份提供商，用户在登录时通过输入公司邮箱，获取对应SSO登录链接，点击SSO登录链接实现对应验证登录。在观测云工作空间「管理」-「SSO管理」-「新建身份提供商」，即可为员工设置SSO单点登录。更多详情可参考文档 [SSO管理](https://www.yuque.com/dataflux/doc/aoadgo) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1637234770825-97c6150f-27bc-4691-8c1b-52456d9dcd13.png#clientId=uf8998ac2-a897-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=764&id=u52f14a79&margin=%5Bobject%20Object%5D&name=image.png&originHeight=764&originWidth=1242&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46015&status=done&style=stroke&taskId=uc1df7f5b-2669-4408-aca6-d1f2105c4ba&title=&width=1242)

#### 新增仪表板和笔记SLO图表

在场景仪表板和笔记新增SLO图表，SLO图表可直接选择设置的监控SLO进行SLO数据展示，通过选择不同的SLO名称，同步展示SLO数据结果。更多详情可参考文档 [SLO](https://www.yuque.com/dataflux/doc/nmbghv) 。
![7.slo_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1637229522188-787ad715-051a-4b68-aedb-798541d441c5.png#clientId=uf8998ac2-a897-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ofKDK&margin=%5Bobject%20Object%5D&name=7.slo_1.png&originHeight=713&originWidth=1355&originalType=binary&ratio=1&rotation=0&showTitle=false&size=72104&status=done&style=stroke&taskId=u330bc005-2de2-4889-9a90-87023ab7df8&title=)
#### 新增基础设施分组自定义添加分组字段

在观测云基础设施查看器，点击分组右侧的设置按钮，可自定义添加分组标签，添加完成后，可选择按照添加分组标签进行分组聚合展示。
注意：自定义分组标签仅管理员可添加。
![4.host_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1637146285506-bcf6823b-bbd3-435e-ba28-8d48a8ba9758.png#clientId=u05eb20db-783b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=kIWeF&margin=%5Bobject%20Object%5D&name=4.host_1.png&originHeight=584&originWidth=1236&originalType=binary&ratio=1&rotation=0&showTitle=false&size=93930&status=done&style=stroke&taskId=ua408ec83-6c10-45ad-98db-4d851eb66c1&title=)
#### 新增SLO通知沉默配置

若同一个事件不是非常紧急，但是告警通知频率高，可以通过设置通知沉默的方式减少通知频率。通知沉默设置后事件会继续产生，但是通知不会再发送，产生的事件会存入事件管理。
#### ![7.slo_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1637232677345-7a641315-9712-4dd6-b256-ae9219bcab29.png#clientId=uf8998ac2-a897-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ub42b9b8a&margin=%5Bobject%20Object%5D&name=7.slo_2.png&originHeight=765&originWidth=1245&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56851&status=done&style=stroke&taskId=ub854a4f5-e3b0-429d-a334-b7c1d64b4a5&title=)
#### 优化图表链接

观测云支持添加内置链接和自定义链接到图表，通过链接可从当前图表跳转至目标页面，并通过模板变量修改链接中对应的变量值将数据信息传送过去，完成数据联动。图表链接支持从新页面、当前页面、侧滑详情页打开，实现联动分析。更多详细介绍可参考文档 [图表链接](https://www.yuque.com/dataflux/doc/nn6o31) 。
![8.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1637231883512-d41ed69d-bd05-4996-892d-781b3aab8cc4.png#clientId=uf8998ac2-a897-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u993d066a&margin=%5Bobject%20Object%5D&name=8.changelog_1.png&originHeight=412&originWidth=750&originalType=binary&ratio=1&rotation=0&showTitle=false&size=121632&status=done&style=stroke&taskId=u7f23454d-5603-46f3-9e60-8d07fd8685d&title=)

#### 计费降价调整

- 每天DataKit 单价下调为每台 3 元 
- 可用性 API 拨测调整为 每 1 万次 1元

更多价格和数据过期策略详情请参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。

#### 其他优化功能

- 上线中国区1（阿里云）免费新版本：免费版分成阿里云登录和AWS登录，阿里云登录时间线的数据保存策略为30天，其他的数据保存策略为7天，AWS登录所有的数据保存策略为1天；
- 优化SLO扣分逻辑：监控器为禁用状态，不会计入扣分范围；
- 新增仪表板标签功能：在创建/修改仪表板视图时，可以为仪表板添加自定义标签，帮助快速筛选；
- 优化日志高亮显示：在搜索栏对日志进行搜索时，返回的列表仅保留匹配到的关键词的高亮显示；
- 优化查看器搜索：在查看器搜索下拉框增加帮助文档链接；
- 优化文本图表Markdown格式：增加支持无序列表和有序列表，优化显示格式。

## 2021 年 11 月 4 号

#### 新增场景笔记

在场景下，可以创建多个笔记来进行总结报告，支持插入实时可视化图表进行数据分析，支持插入文本文档进行说明，结合图表和文档进行数据分析和总结报告；支持基础设施、日志、应用性能、用户访问等查看器数据导出到笔记进行数据分析；支持与工作空间所有成员共享笔记，留存异常数据分析，帮助回溯、定位、解决问题。
![5.notebook_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1636027827153-10fa1ee5-4d09-4204-bc1f-b3c4b4d94068.png#clientId=u691b4452-415b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uxetK&margin=%5Bobject%20Object%5D&name=5.notebook_4.png&originHeight=722&originWidth=1244&originalType=binary&ratio=1&rotation=0&showTitle=false&size=78824&status=done&style=stroke&taskId=u9f6005b7-cd76-4a72-a339-9450f0cf835&title=)
#### 场景视图升级为仪表板

观测云的场景视图升级为仪表板，并对仪表板的功能和布局做了调整。在场景下，可以创建多个仪表板来构建数据洞察场景，支持通过关键字搜索仪表板，支持为仪表板添加可视化图表进行数据分析，支持从“我的收藏”、“导入项目”、“我的创建”和“经常浏览”来快速过滤查找对应的仪表板。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1636028188362-d57400b3-faeb-4dab-a682-5fca63f0435b.png#clientId=u691b4452-415b-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=353&id=uaf989c68&margin=%5Bobject%20Object%5D&name=image.png&originHeight=353&originWidth=1250&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53720&status=done&style=stroke&taskId=u2682a08f-c439-4708-a75f-db57f28dd14&title=&width=1250)

#### 查看器新增导出到仪表板和笔记

基础设施、日志监测、应用性能监测、可用性监测、安全巡检等查看器新增导出到仪表板和笔记。
![10.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1636338562310-dc186f90-407b-44b6-8aba-dbb4f581a0e4.png#clientId=u40080c90-7926-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9a9edd0a&margin=%5Bobject%20Object%5D&name=10.changelog_1.png&originHeight=522&originWidth=1241&originalType=binary&ratio=1&rotation=0&showTitle=false&size=119838&status=done&style=stroke&taskId=uefab100d-544c-4100-9cc1-57638eb24cb&title=)
#### 异常检测库升级为监控

原「异常检测库」升级为「监控」，原有「异常检测库」、「检测规则」等名称发生变更，具体变更如下：

- 监控器（原指“异常检测规则”）提供「阈值检测」、「日志检测」等多种监测方式，允许用户自定义配置检测规则和触发条件，并通过告警第一时间接收告警通知。
- 模版（原指“内置检测库”），“观测云”内置多种开箱即用的可用性监控模版，支持一键创建Docker、Elasticsearch、Host、Redis监控。成功新建模版后，即自动添加对应的官方监控器至当前工作空间。
- 分组（原指“自定义监测库”），分组功能支持您自定义创建有意义的监测器组合，方便分组管理各项监控器。

  
更多详情内容可参考文档 [监视器管理](https://www.yuque.com/dataflux/doc/hd5ior) 。
![6.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1636029127854-3210b869-2d75-4007-8655-75cd0be5bc03.png#clientId=u691b4452-415b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udec66e3a&margin=%5Bobject%20Object%5D&name=6.changelog_1.png&originHeight=537&originWidth=1254&originalType=binary&ratio=1&rotation=0&showTitle=false&size=133970&status=done&style=stroke&taskId=u83d137c1-3c05-459a-a274-005e5c39b1b&title=)

#### 新增监控SLO功能，支持导出到仪表板


「监控」新增SLO监控，支持在云时代背景下，对系统服务提供者（Provider）的服务质量评分，对比检测对应的SLI（Service Level Indicator）是否满足目标需要。同时，“观测云”还支持导出SLO为视图至仪表板，以便利在仪表板同步进行SLO监控。更多详情可参考文档 [SLO](https://www.yuque.com/dataflux/doc/aisb71) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1636029484402-a8937a2d-f354-40a6-b1f0-d7a0ab27c927.png#clientId=u691b4452-415b-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=291&id=u32dd1cfe&margin=%5Bobject%20Object%5D&name=image.png&originHeight=291&originWidth=1104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=40690&status=done&style=stroke&taskId=ub23e85aa-8a31-4736-969f-e67c8227a15&title=&width=1104)

#### 其他优化功能

- 图表优化：
   - 概览图去掉分组的选择；
   - 时序图、饼图、柱状图图表选择样式调整；
   - 时间分片新增提示信息；
   - 图表json支持编辑，和查询/设置联动，支持对输入的Json进行校验，若有错误则显示错误提示；
   - 时序图分析模式下的样式优化；
- 付费计划与账单新增提示，结算方式选择aliyun或者aws，账单列表直接显示跳转到对应云服务控制台查看账单信息。


## 2021 年 10 月 21 号

#### 新增主机网络分布图

新增主机网络分布图，提供基础设施网络可观测。在「基础设施」-「主机」，点击左上角的小图标![3.host_netmap_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1634699082776-086c9dc0-c952-45e4-9300-ec928ccec30c.png#clientId=uc0541857-b38c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ucae425c3&margin=%5Bobject%20Object%5D&name=3.host_netmap_2.png&originHeight=16&originWidth=16&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7373&status=done&style=none&taskId=uc846671b-38dc-40e3-9c1c-f5de464a879&title=)，即可切换到查看主机网络分布情况。在「网络分布图」，您能够可视化查询当前工作空间主机与主机之间的网络流量，快速分析不同主机之间的 TCP延迟、TCP波动、TCP重传次数、TCP连接次数以及 TCP关闭次数。更多详情介绍，可参考文档 [主机网络分布图](https://www.yuque.com/dataflux/doc/mwqbgr#yKAcN) 。
![3.host_netmap_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1634797398623-f008a445-12a8-41a7-a327-658e6535fcfc.png#clientId=u84c7dcc5-d054-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uba12e68e&margin=%5Bobject%20Object%5D&name=3.host_netmap_4.png&originHeight=790&originWidth=1251&originalType=binary&ratio=1&rotation=0&showTitle=false&size=123525&status=done&style=stroke&taskId=u1a5d3736-2556-41ed-b118-c1159db32ad&title=)

#### 新增用户访问监测追踪功能

新增用户访问监测「追踪」功能。支持用户通过「用户访问监测」新建追踪任务，对自定义的链路追踪轨迹进行实时监控。通过预先设定链路追踪轨迹，可以集中筛选链路数据，精准查询用户访问体验，及时发现漏洞、异常和风险。详情可参考文档 [自建追踪](https://www.yuque.com/dataflux/doc/olc625) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1634800773270-42a33e5d-3fd3-4c1d-9013-b585489e73d6.png#clientId=u84c7dcc5-d054-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=538&id=u76a377ee&margin=%5Bobject%20Object%5D&name=image.png&originHeight=538&originWidth=801&originalType=binary&ratio=1&rotation=0&showTitle=false&size=42741&status=done&style=stroke&taskId=u06b78529-ffaa-499c-baf6-3bc77f02b4f&title=&width=801)

#### 新增场景图表 Json 格式查询

在「场景」编辑图表时，每一个正确的图表查询都对应一个json文本，支持工作台内的 json文本和图表查询可互相解析，帮助您洞察图表绘制详情。详情可参考文档 [图表查询](https://www.yuque.com/dataflux/doc/cxlbps) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1634801532836-181d8f2a-1cf0-4db9-8328-1af596a91b52.png#clientId=u84c7dcc5-d054-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=615&id=ude694ba7&margin=%5Bobject%20Object%5D&name=image.png&originHeight=615&originWidth=1204&originalType=binary&ratio=1&rotation=0&showTitle=false&size=68697&status=done&style=stroke&taskId=ufd890dc8-fa60-40b0-8776-4f9f87bc924&title=&width=1204)

#### 优化 DCA 桌面客户端应用

优化 DCA 桌面客户端 UI 展示，增加主机状态，更多详情可参考文档 [DCA](https://www.yuque.com/dataflux/doc/fgcgug) 。

- online：说明数据上报正常，可通过 DCA 查看 DataKit 的运行情况和配置采集器；
- unknown：说明远程管理配置未开启，或者不在一个局域网内；
- offline：说明主机已经超过 10 分钟未上报数据，或者主机名称被修改后，原主机名称会显示成 offline 的状态。未正常上报数据的主机，若超过 24 小时仍未有数据上报，该主机记录将会从列表中移除。

![1.dca_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1634106281478-7b83b4e5-5215-442a-aa7b-5435ae5ff2c2.png#clientId=u3b5f43b6-c832-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9fffb3a0&margin=%5Bobject%20Object%5D&name=1.dca_2.png&originHeight=796&originWidth=1425&originalType=binary&ratio=1&rotation=0&showTitle=false&size=136525&status=done&style=stroke&taskId=uec3de7e3-3570-45fe-817d-fef9e3ccf47&title=)

#### 优化事件主机联动查询及检测规则查询

优化事件模块，支持对事件的关联主机进行联动查询，可实时监控与该事件相关的主机在选定时间组件范围内的日志、容器、进程，链路，巡检事件；支持一键查看事件关联的检测规则，并查询对应检测规则下的其他被触发事件。详情可参考文档 [事件分析](https://www.yuque.com/dataflux/doc/vzall6) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1634621738065-6604176e-5664-4709-a595-198c8b5372ed.png#clientId=u1ffff782-91ef-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=306&id=u7bf0a5d1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=306&originWidth=787&originalType=binary&ratio=1&rotation=0&showTitle=false&size=44950&status=done&style=stroke&taskId=u77db6f5a-3ff1-4144-904c-1ce0195de1d&title=&width=787)
#### 调整计费方式

- 按节点登录方式，选择计费结算方式，包括CloudCare账号、Aliyun、AWS。其中CloudCare账号结算为通用方式，阿里云登录节点对应可选择Aliyun账号结算方式（上线中），AWS登录节点对应可选择AWS账号结算方式（已上线）。
- 去除Session数量和Browser拨测数量计费维度，在「付费计划与账单」去除Session数量和Browser拨测数量统计及视图，新增安全巡检数量统计图。

更多计费规则和数据过期策略详情可参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。
更多版本升级和结算方式详情可参考文档 [付费计划与账单](https://www.yuque.com/dataflux/doc/fb8rwv) 。

#### 其他优化功能

- 优化场景添加图表功能，去掉「编辑」模式下「添加图表」按钮，所有可添加的图表类型在场景顶部可选；
- 优化场景[图表分组](https://www.yuque.com/dataflux/doc/zr8h0h)功能，支持仅删除分组，并保留原有图表进入默认分组下；
- 新增[中国地图](https://www.yuque.com/dataflux/doc/lhm393)/[世界地图](https://www.yuque.com/dataflux/doc/eplxkm)的「地区排名」开关，默认关闭地区排名；
- 优化查看器查询方式，合并搜索与筛选栏，支持基于标签、字段、文本进行关键词搜索、标签字段筛选、关联搜索。

## 2021 年 9 月 28 号

#### 新增主机网络性能监测

主机网络性能监测支持查看主机服务、容器和任意带标签的基础设施等之间的网络流量。支持基于 IP/端口查看源主机到目标之间的网络流量和数据连接情况，通过可视化的方式进行实时展示，帮助企业实时了解业务系统的网络运行状态，快速分析、追踪和定位问题故障，预防或避免因网络性能下降或中断而导致的业务问题。

主机网络数据采集成功后会上报到观测云控制台，在「基础设施」-「主机」详情页中的「网络」，您可以查看到工作空间内全部网络性能监测数据信息。更多详情可参考文档 [主机网络](https://www.yuque.com/dataflux/doc/mwqbgr#PqtQj) 。
![3.network_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1632813221675-41141e7f-fde1-4cc1-8a45-0456d98b8a32.png#clientId=u72bb9e86-ead4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ubca900d0&margin=%5Bobject%20Object%5D&name=3.network_1.png&originHeight=578&originWidth=1146&originalType=binary&ratio=1&rotation=0&showTitle=false&size=98185&status=done&style=stroke&taskId=ud07cf1e3-a5b0-426a-8df7-275ee2cce23&title=)
#### 新增图表联动查询

在场景视图，支持通过单击鼠标查看该图表的DQL查询语句、关联的链接等，或关联查询不同分组查询标签下的相关日志、容器、进程、链路等。当图表查询存在主机（host) 信息时，支持查看相关的主机监控视图。如点击图中任意图表，即可查看图表的DQL查询语句、设置的链接以及关联查询相关日志、容器、进程、链路、主机监控视图等。更多详情可参考文档 [视图分析](https://www.yuque.com/dataflux/doc/rr32l0) 。
![1.changelog.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1632991900850-2aa12140-8d88-4d3c-b168-67943a4cd9af.png#clientId=u266219c8-d5c1-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=t8MIA&margin=%5Bobject%20Object%5D&name=1.changelog.png&originHeight=777&originWidth=1254&originalType=binary&ratio=1&rotation=0&showTitle=false&size=145975&status=done&style=stroke&taskId=uf73e8c3b-81b1-45d5-b4be-4dda52f1cdf&title=)
#### 新增图表矩形树图

矩形树图用于展示不同分组下指标数据的占比分布可视化。矩形树图颜色表示分组的标签（Tag），面积表示指标数据。当添加了多个指标查询时，可选择主要展示的指标，面积大小根据选择的指标数据结果、Top/Bottom 以及数量进行展示。如本图中通过可视化的方式展示主机的CPU使用率排名。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1632989780032-c8461a3c-02e6-4344-9ae7-808cd6ccf217.png#clientId=u266219c8-d5c1-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=714&id=u57cea398&margin=%5Bobject%20Object%5D&name=image.png&originHeight=714&originWidth=1358&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75439&status=done&style=stroke&taskId=u2609e398-3459-41bf-9d97-71859e88362&title=&width=1358)
#### 新增应用性能和用户访问监测关联查询

在应用性能监测链路详情内，支持通过页面上方的「相关view」查看关联（相同trace_id）的真实用户访问体验数据。此功能不仅能够帮助您查看主动式监测的应用性能数据，还能够帮助您快速透视真实用户的访问情况。更多应用性能监测可参考文档 [链路分析](https://www.yuque.com/dataflux/doc/qp1efz) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1632810421983-601ffafe-e42c-4778-91bf-fed6f73ec111.png#clientId=u574aeb11-8269-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=603&id=uOOFV&margin=%5Bobject%20Object%5D&name=image.png&originHeight=603&originWidth=814&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74245&status=done&style=stroke&taskId=u981a43fe-5554-4f12-bf9b-f5c364ee79b&title=&width=814)
#### 新增基础设施查询绝对时间范围

基础设施新增「[主机](https://www.yuque.com/dataflux/doc/mwqbgr)」、「[容器](https://www.yuque.com/dataflux/doc/gy7lei)」、「[进程](https://www.yuque.com/dataflux/doc/yoon4o)」查询范围绝对时间，默认展示最近24小时的主机数据、最近十分钟内的容器数据、最近十分钟的进程数据，可通过手动方式刷新查询范围。鼠标悬停在离线的主机，可查看主机离线处理提示。
![7.changelog_host.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1632818786268-ae116297-9810-43ff-8411-18de1627e4a2.png#clientId=u72bb9e86-ead4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udaf018b2&margin=%5Bobject%20Object%5D&name=7.changelog_host.png&originHeight=530&originWidth=1248&originalType=binary&ratio=1&rotation=0&showTitle=false&size=120307&status=done&style=stroke&taskId=u692fdefc-3343-4b96-a1ce-c9a689fe9af&title=)
#### 优化图表同期对比功能

优化图表同期对比功能，支持对[时序图](https://www.yuque.com/dataflux/doc/sqg3vu)、[概览图](https://www.yuque.com/dataflux/doc/nlqqgk)等的同期数据进行比较，可选择同比（相邻时间段中某一相同时间点的比较）或环比（相邻时间段的对比）。根据图表锁定时间，可选择环比、日环比、周环比、月环比、周同比、月同比等选项。
![3.view_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1632817128821-f08d6636-b47f-42cf-bde3-875b93b8e194.png#clientId=u72bb9e86-ead4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6e69656c&margin=%5Bobject%20Object%5D&name=3.view_2.png&originHeight=712&originWidth=1356&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103594&status=done&style=stroke&taskId=ud7cf7c71-cba8-45b8-8d7e-670da9ea68f&title=)

#### 优化图表查询 SLIMIT

默认为分组查询的图表添加SLIMIT，用于限制**时序图**图表查询返回的points或series的数目。一个图表限制返回10000个点，一个查询最多返回 10 条时间线。
![7.changelog_view_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1632819818297-569e642e-67c5-49cf-b4c2-26ee6c6dde09.png#clientId=u72bb9e86-ead4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ubada711e&margin=%5Bobject%20Object%5D&name=7.changelog_view_1.png&originHeight=710&originWidth=1292&originalType=binary&ratio=1&rotation=0&showTitle=false&size=171075&status=done&style=stroke&taskId=u166a8939-e607-4029-8402-fc4ba7ca113&title=)

#### 云拨测调整为可用性监测

云拨测分成 API 拨测和 Browser 拨测，调整为可用性拨测以后，保留 API 拨测。其他功能如概览分析、查看器分析、自建节点功能保持不变。更多详情可参考文档 [可用性监测](https://www.yuque.com/dataflux/doc/rgcad6) 。

#### 计费降价调整

- 日志价格从每100万条1元调整为每100万条0.5元
- 用户访问监测价格去除 Session 计费维度，调整为每1000个 PV 0.3元

更多价格和数据过期策略详情请参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。
## 2021 年 9 月 9 号

#### DataFlux 更名为“观测云”

云计算时代，可观测性被越来越多的企业所采纳和重视，DataFlux作为驻云科技推出的云时代的可观测性平台，为了让企业和用户更容易理解，本次发布将正式更名为“观测云”，网址为“[www.guance.com](https://www.guance.com)”。

同时我们为“观测云”设计了新的 Logo ，以字母C和G为基础组成类似雷达波的图形，体现探测、观测特性，充分贴合可观测性的特征，也体现了“观测云”为企业和用户构建基于数据的核心保障体系。

![登录logo.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631178341869-baa64b04-6fb3-44b1-b28e-b06919646b89.png#clientId=u586bc735-f875-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u7882d207&margin=%5Bobject%20Object%5D&name=%E7%99%BB%E5%BD%95logo.png&originHeight=36&originWidth=115&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7182&status=done&style=none&taskId=u09641920-e63c-4a2f-ad93-9c9a9798018&title=)

#### 新增日志近似文本查看器

“观测云”支持对原始日志数据的`message`字段进行相似度计算分析，根据右上方选择的时间范围固定当前时间段，并获取该时间段内 10000 条日志数据做近似分析，将近似度高的日志进行聚合，提取并统计共同的 Pattern 聚类，帮助快速发现异常日志和定位问题。
![5.logging_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631165632836-f9bd4ba2-21e0-4732-8b8a-70fe4f0716d9.png#clientId=u9398dff0-2cd2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6570889f&margin=%5Bobject%20Object%5D&name=5.logging_4.png&originHeight=592&originWidth=1241&originalType=binary&ratio=1&rotation=0&showTitle=false&size=144136&status=done&style=stroke&taskId=u2f2fdc70-08de-48f8-83c9-c9b3adf7575&title=)

**Pattern 聚类详情**

点击 Pattern 聚类列表，即可划出当前所有的 Pattern 聚类列表，返回数据列表按照时间倒序排列，支持显示最近50条日志数据，可选择 1行、3行、10行的方式显示。
![5.logging_5.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631165742065-acc0f997-9468-4b4e-9e46-58281077566f.png#clientId=u9398dff0-2cd2-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1c34e8e3&margin=%5Bobject%20Object%5D&name=5.logging_5.1.png&originHeight=481&originWidth=1135&originalType=binary&ratio=1&rotation=0&showTitle=false&size=184016&status=done&style=stroke&taskId=udc47c0d0-178a-430a-a863-416bb49d100&title=)

#### 新增容器Jobs和Cron Jobs查看器

“观测云”新增容器「Jobs」、「Cron Jobs」查看器, 在「基础设施」-「容器」的左侧对象列表选择对应的查看器，支持查看 Kubernetes 中 Job 和 Cron Job 的运行状态和服务能力相关指标，进而实现对 Kubernetes 集群以及其中部署的各类资源的实时监测。详情可参考文档 [容器](https://www.yuque.com/dataflux/doc/gy7lei) 。
![15.changelog_1.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631181751175-76bbf3be-af31-4b15-8652-cf1395f0ed16.png#clientId=u586bc735-f875-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uaff29011&margin=%5Bobject%20Object%5D&name=15.changelog_1.1.png&originHeight=766&originWidth=1234&originalType=binary&ratio=1&rotation=0&showTitle=false&size=165698&status=done&style=stroke&taskId=u7f188288-e3a1-4d08-ab78-8cdbc0d4e66&title=)
#### 新增 DCA 桌面客户端应用

DCA，DataKit Control APP，是一款桌面客户端应用，旨在方便管理已经安装和配置的采集器，支持查看集成列表、配置文件管理、Pipeline管理、集成配置文档在线查看等功能。您可以通过 DCA 远程连接 DataKit ，在线变更采集器，变更完成后保存更新即可生效。

在“观测云”工作空间，依次点击「集成」-「DCA」，即可下载安装包。下载完成后，可安装在您的电脑远程管理 DataKit 。更多使用说明可参考文档 [DCA](https://www.yuque.com/dataflux/doc/fgcgug) 。
![1.dca_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631003814728-92c32f4e-45dd-4615-93b2-88dfdfe347cc.png#clientId=u5eb6b312-4f1a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue3b46e16&margin=%5Bobject%20Object%5D&name=1.dca_1.png&originHeight=472&originWidth=857&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50639&status=done&style=stroke&taskId=u1b53ee67-9053-480d-9c46-a36db97f62b&title=)
#### 新增移动端 APP

DataFlux Mobile 可以帮助您在移动设备上随时随地查看来自观测云的日志数据、场景视图等，接收通过邮件、钉钉机器人、企业微信机器人、Webhook等通知到您的全部告警事件。

在观测云的工作空间内，您可以通过「集成」-「移动端」进行 DataFlux Mobile APP的下载。更多使用说明可参考文档 [DataFlux Mobile 移动端APP](https://www.yuque.com/dataflux/doc/atdydg) 。
![15.changelog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631182374037-bf723b37-062b-45f9-978b-9031f7e33c49.png#clientId=u586bc735-f875-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u34fabd5f&margin=%5Bobject%20Object%5D&name=15.changelog_2.png&originHeight=436&originWidth=926&originalType=binary&ratio=1&rotation=0&showTitle=false&size=65129&status=done&style=stroke&taskId=uc0584c1d-1fb0-43e0-9ba1-c43332e1afe&title=)
#### 新增指标的标签筛选功能，优化指标的三种查看模式

DataKit 采集器会默认给采集到的所有数据追加标签 `host=<DataKit所在主机名>`，更多介绍可参考文档 [DataKit 使用入门](https://www.yuque.com/dataflux/datakit/datakit-how-to#cdcbfcc9) 。

标签是标识一个数据点采集对象的属性的集合，标签分为标签名和标签值，在「指标」页面可选择需要查看的标签值对应的指标视图。如下图所示：在标签栏筛选主机，并查看其 `usage_system`、`usage_total`、`usage_user`、`usage_iowait`等指标视图。
![3.metric_3.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631087874097-741af3e3-ddc8-4169-a4d2-752d06c44ce7.png#clientId=u4219df50-b9b0-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u06d9b0b2&margin=%5Bobject%20Object%5D&name=3.metric_3.1.png&originHeight=641&originWidth=1244&originalType=binary&ratio=1&rotation=0&showTitle=false&size=108410&status=done&style=stroke&taskId=u7b8703fd-c18e-4015-be8d-111127cbc2c&title=)
在「指标」页面左侧可选择切换指标查看模式，支持三种查看模式：平铺模式、混合模式、列表模式，默认选中平铺模式。更多查看模式介绍，可参考文档 [指标管理](https://www.yuque.com/dataflux/doc/mx0gcw#HIH5l) 。

#### 优化异常检测

新增window（窗口）函数在异常检测规则查询和图表查询的使用，即支持以选定的时间间隔为窗口（记录集合），以检测频率为偏移，重新对每条记录执行统计计算。更过详情可参考 [事件分析](https://www.yuque.com/dataflux/doc/vzall6) 。

•  在进行图表查询时，支持添加窗口函数，即以选定的时间间隔为窗口（支持选择1分钟、5分钟、15分钟、30分钟、1小时、3小时），结合聚合函数对每条记录都执行统计计算。
•  在配置异常检测规则配置时，新增window函数为查询结果的绘图展示区域，返回用于触发告警的实时异常检测指标数据。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631187777298-9fbf7916-2ccb-4338-9a9e-fc27b4af5bf5.png#clientId=u586bc735-f875-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=281&id=u4f8b110a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=281&originWidth=1172&originalType=binary&ratio=1&rotation=0&showTitle=false&size=26394&status=done&style=none&taskId=u04008651-2dae-467e-8f03-05a86cb981d&title=&width=1172)

新增percent()函数在异常规则查询和图表查询的聚合函数中使用。支持在聚合函数中添加percent()函数，包括 p50(取中位数值)、p75（取处于75%位置的值）、p90（取处于90%位置的值）、p99(取处于99%位置的值)。 更多图表查询函数应用可参考文档 [图表查询](https://www.yuque.com/dataflux/doc/cxlbps) 。

新增lable筛选在异常规则查询和图表查询中使用，支持选择主机 label 属性进行筛选显示。在查询中选择 label 之前，您需在「基础设施」-「主机」中为主机设置 label 属性。 关于如何添加 label 属性，可参考文档 [主机标签属性](https://www.yuque.com/dataflux/doc/mwqbgr#MP3rm) 。

#### 优化未恢复事件显示样式

在未恢复事件列表中，您可以预览事件最近 6 小时的window函数：
•  虚线边框的展示效果为异常事件影响的时间段
•  检测库规则类型为阈值、日志、应用性能指标、用户访问指标检测、安全巡检、异常进程、云拨测检测时，根据不同告警等级对应的色块可查看相关异常检测指标数据，包括紧急、错误、警告。
•  检测库规则类型为突变、区间、水位时，根据图表“竖线”可快速识别出当前事件触发的时间点。
更多详情可参考文档 [事件分析](https://www.yuque.com/dataflux/doc/vzall6) 。 
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1631188136895-9c318b69-57af-44cb-b1bd-7f9088e3d9a9.png#clientId=u586bc735-f875-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=679&id=u0b64a288&margin=%5Bobject%20Object%5D&name=image.png&originHeight=679&originWidth=1126&originalType=binary&ratio=1&rotation=0&showTitle=false&size=99086&status=done&style=stroke&taskId=ua9a6f1f5-7f82-48bf-a3cc-8b46dc501b4&title=&width=1126)

在事件的详情页面支持查看异常事件的状态分布、DQL函数和窗口函数折线图。
•  状态分布：展示选定时间范围内（默认展示最近6小时）的事件状态 (紧急、重要、警告、无数据)
•  DQL查询语句：基于异常检测规则的自定义查询语句返回的实时指标数据，默认展示最近6小时的实时指标数据
•  window 函数：基于异常检测规则，以选定的时间范围为窗口（记录集合），以检测频率为偏移，重新对每条记录执行统计计算，返回用于触发告警的实时异常检测指标数据。默认展示最近6小时的实时异常检测指标数据
更多详情可参考文档 [事件分析](https://www.yuque.com/dataflux/doc/vzall6) 。 
![截屏2021-09-08 下午6.57.31.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1631099238338-6b438767-1124-46c1-b1f4-3ac4d3c2d4de.png#clientId=u882ec291-7d0f-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3b8c3b08&margin=%5Bobject%20Object%5D&name=%E6%88%AA%E5%B1%8F2021-09-08%20%E4%B8%8B%E5%8D%886.57.31.png&originHeight=646&originWidth=1013&originalType=binary&ratio=1&rotation=0&showTitle=false&size=96643&status=done&style=stroke&taskId=uae432636-2f6c-4ac3-a1b8-6eb4dcd84a0&title=)

#### 优化场景视图分析

在预览模式下，通过双击图表，即可放大图表进入分析模式查看。在编辑模式下，双击图表可进入编辑模式。对图表进行增删改查。详情可参考文档 [视图分析](https://www.yuque.com/dataflux/doc/rr32l0) 。  

#### 优化基础设施绑定内置视图

选择内置视图时，会过滤重名视图，当系统视图和用户视图重名时，优先展示用户视图，即只能选择用户视图，若需要选择系统视图，则需更改或者删除重名的用户视图。更多详情可参考文档 [绑定内置视图](https://www.yuque.com/dataflux/doc/dns233) 。

#### 优化计费方式，新增云拨测计费，调整数据过期策略

- 新增 PV 数量统计：Session 数量和 PV 数量按照实际产生的费用低那个作为最终费用
- 新增云拨测任务次数费用统计：开放云拨测自建节点管理，支持任何空间管理员在全球范围内自建新的拨测节点；云拨测的计费维度将根据当前工作空间的云拨测任务调用次数收费；免费版工作空间最多可创建 5 个拨测任务，且仅支持“中国区”拨测节点的使用；敏捷版及以上版本工作空间支持创建更多拨测任务，并且使用更多的国外拨测节点。更多详情可参考文档 [云拨测数据采集](https://www.yuque.com/dataflux/doc/qnfc4a) 。

更多价格和数据过期策略详情请参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。

## 2021 年 8 月 26 号
### DataFlux Studio

#### 新增图表查询label筛选

DataFlux 支持选择主机 label 属性进行筛选显示，在图表查询中选择 label 之前，需在「基础设施」-「主机」中为主机设置 label 属性。如下图中，包含“production” label 属性有两台主机，故显示两台主机的数据。有关主机 label 设置可参考文档 [主机](https://www.yuque.com/dataflux/doc/mwqbgr#MP3rm) 。
![3.query_4.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1629878010347-57d41b54-d7ad-400c-b98f-52740a2d81d8.png#clientId=u459f28ec-dd61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u687406ac&margin=%5Bobject%20Object%5D&name=3.query_4.1.png&originHeight=710&originWidth=1356&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90712&status=done&style=stroke&taskId=u7a87574a-d886-469d-9b9a-2ed95a9cf7f&title=)

#### 新增基础设施容器 Cluster、Replicate Set、Node查看器 

DataFlux 新增容器 Cluster、Replicate Set、Node查看器, 支持查看 Kubernetes 中 Cluster、Replicate Set、Node 的运行状态和服务能力相关指标，进而实现对Kubernetes集群以及其中部署的各类资源的实时监测。详情可参考文档 [容器](https://www.yuque.com/dataflux/doc/gy7lei) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1629787348524-3e0dc3b9-0431-4943-a0be-fb0de8238f82.png#clientId=u9197bd83-0cb7-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=563&id=ub7df33c1&margin=%5Bobject%20Object%5D&name=image.png&originHeight=563&originWidth=1098&originalType=binary&ratio=1&rotation=0&showTitle=false&size=101692&status=done&style=stroke&taskId=u3f199c86-6d84-41ce-8a0e-4a607c5b661&title=&width=1098)
#### 新增用户访问监测 View 查看器快捷筛选

DataFlux 支持在 View 查看器，点击左侧快速筛选的设置按钮，即可自定义添加筛选字段。选择需要添加的字段后，点击“完成”即可。
![8.rum_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1629961000021-03b50f01-c167-4183-87aa-74e600cd2c1e.png#clientId=ucd61c5fc-476c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u37e4e027&margin=%5Bobject%20Object%5D&name=8.rum_2.png&originHeight=352&originWidth=237&originalType=binary&ratio=1&rotation=0&showTitle=false&size=23386&status=done&style=stroke&taskId=u53bd0df3-23cf-475f-9bf8-aed7c353bd7&title=)
注意：若添加筛选的字段是代表时间的字段，支持通过选择时间区间筛选查看对应的页面内容。如 loading_time（页面加载时间）。
![8.rum_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1629961008178-89b43700-c31c-421f-86d5-821dd1a9232d.png#clientId=ucd61c5fc-476c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u21ff9a63&margin=%5Bobject%20Object%5D&name=8.rum_3.png&originHeight=953&originWidth=1204&originalType=binary&ratio=1&rotation=0&showTitle=false&size=226923&status=done&style=stroke&taskId=u7320db1f-6ba9-46a0-96f6-6f9912091be&title=)

#### 新增导航菜单帮助入口，新增多个查看器数据采集引导入口

DataFlux 在导航菜单新增帮助文档入口，同时当查看器未上传数据时，DataFlux 为您提供了快捷访问 “如何开始数据采集”的入口，以帮助您在不同查看器下及时开启数据实时监测之路。包括[如何开启日志监测](https://www.yuque.com/dataflux/doc/zwvm0b)、[如何开启云拨测](https://www.yuque.com/dataflux/doc/qdp9u5)、[如何采集主机对象](https://www.yuque.com/dataflux/doc/si9tnv)等。

#### 优化日志查看器

DataFlux 优化日志查看器，采用不同的颜色高亮日志的不同内容，让您能更快的的获取日志的重点数据信息，支持浅色和深色两种主题颜色。

| 日志内容 | 浅色主题 | 深色主题 |
| --- | --- | --- |
| 日期（日志发生的时间） | 黄色 | 浅黄色 |
| 关键字（HTTP协议相关，如GET） | 绿色 | 浅绿色 |
| 文本（带引号的字符串） | 蓝色 | 浅蓝色 |
| 默认（无任何标示的文本） | 黑色 | 灰色 |
| 数字（日志状态码等，如404） | 紫色 | 浅紫色 |

![1.logging_7.3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1629800011801-737814d4-c67d-482d-9987-ab7a6301dcde.png#clientId=u73c3a827-1ace-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=jTCIW&margin=%5Bobject%20Object%5D&name=1.logging_7.3.png&originHeight=560&originWidth=1246&originalType=binary&ratio=1&rotation=0&showTitle=false&size=154438&status=done&style=stroke&taskId=u071dc877-96da-4336-9efa-9a03f85f545&title=)
#### 优化安全巡检概览统计

DataFlux 支持自定义安全巡检概览页面的视图，通过点击「跳转」按钮，可跳转至概览页面对应的内置视图进行查看，并对该视图进行编辑、复制和导出。详情可参考文档 [安全巡检分析](https://www.yuque.com/dataflux/doc/dpx1qg#cATaT) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1629784765780-e91bac1c-6e77-4c46-9e6e-bcbceb726fca.png#clientId=u79fa34f0-743e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=509&id=u0b4d9075&margin=%5Bobject%20Object%5D&name=image.png&originHeight=509&originWidth=1110&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64660&status=done&style=stroke&taskId=ue0096f25-02d2-4c51-8c51-fa8b0c857e0&title=&width=1110)

#### 优化工作空间切换

DataFlux支持通过点击 「当前空间」名称即可切换至其他工作空间或新建工作空间。
![WeChat9a634816694a7d55cac97283c93c943a.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1629785783700-aba56870-dfd2-4c19-9234-a7edbf220a26.png#clientId=u90c02b98-40b4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf0160f66&margin=%5Bobject%20Object%5D&name=WeChat9a634816694a7d55cac97283c93c943a.png&originHeight=660&originWidth=1170&originalType=binary&ratio=1&rotation=0&showTitle=false&size=92344&status=done&style=stroke&taskId=ue163e200-2148-423f-82c5-ad4d32f1948&title=)
#### 优化系统主题颜色切换

DataFlux 新增系统主题颜色“自动”选项，可根据电脑外观设置自动切换主题颜色。
![4.color_1.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1629881226789-caeca1f5-7f94-4ba1-9b73-fc4df2d677a0.png#clientId=ua8f66061-4e52-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=dwipQ&margin=%5Bobject%20Object%5D&name=4.color_1.1.png&originHeight=247&originWidth=391&originalType=binary&ratio=1&rotation=0&showTitle=false&size=25806&status=done&style=stroke&taskId=u67922f56-f009-471b-aced-a65629cc6a1&title=)
#### 其他优化功能

- 优化应用性能监测「服务」详情，在服务详情页，点击服务的资源名称可直接跳转到「链路」查看对应的资源的链路情况；
- 优化用户访问监测 View 查看器「性能」详情，点击性能详情中的错误数据（在 View 列表中含“错误”标志的数据），可查看错误对应的详情；
- 优化指标查看器标签名和标签值显示；
- 优化时序图 X 轴时间显示，默认时间范围最近15分钟，X 轴分段按照分钟间隔；最近1天，X 轴分段按照小时间隔；最近7天，X 轴分段按照天间隔；
- 优化表达式查询，图表查询时，若表达式查询包含多个查询语句，分组标签需保持一致；
- 优化主机集成运行情况，在「基础设施」-「主机」-「集成运行情况」新增主机安装的 DataKit 版本信息；
- 优化快照分享，支持分享快照给拥有分享链接的“任何人”，或者加密分享给拥有链接和密钥的人。

## 2021 年 8 月 12 号
### DataFlux Studio

#### 新增 3 种权限角色，优化场景查看权限

DataFlux 目前支持定义三种工作空间成员权限，包括“管理员”、“标准成员”和“只读成员”，分别对不同成员类别的管理权限、操作权限、浏览权限进行了约束。“管理员”能够自定义成员的权限范围，如：限定只读成员可访问的场景视图、限定标准成员可编辑的场景视图等。

在 DataFlux 工作空间的「管理」-「成员管理」-「修改」，即可编辑更新成员的权限。详情可参考文档 [权限管理](https://www.yuque.com/dataflux/doc/nzlwt8) 。
![12.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628675534200-e175921f-0e2b-4d5d-8901-e647e8f1a8bd.png#clientId=ub7604c98-e464-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0c43a54a&margin=%5Bobject%20Object%5D&name=12.changelog_1.png&originHeight=496&originWidth=514&originalType=binary&ratio=1&rotation=0&showTitle=false&size=42555&status=done&style=stroke&taskId=u36ede28c-fce1-4fca-b548-50ae368fe47&title=)
#### 新增基础设施主机详情查看连接追踪和文件及布局优化

DataFlux 支持在基础设施主机详情页查看主机系统信息，包括主机名称、操作系统、处理器、内存，网络，硬盘以及连接追踪数、文件句柄数等数据。更多主机详情页的说明可参考文档 [主机](https://www.yuque.com/dataflux/doc/mwqbgr#mPkpY) 。
![3.host_7.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628649699964-70f36e11-fabe-4e55-b251-2e50a42e1851.png#clientId=uac3f0762-a475-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u243546b0&margin=%5Bobject%20Object%5D&name=3.host_7.png&originHeight=616&originWidth=1144&originalType=binary&ratio=1&rotation=0&showTitle=false&size=73716&status=done&style=stroke&taskId=u73c36388-88ef-41dc-993c-3b6942d3492&title=)
#### 新增场景视图快照保存功能

在 DataFlux 工作空间，进入「场景」-「节点」，点击顶部导航栏的「设置」按钮，选择「保存快照」即可保存当前视图所展示的数据内容为快照。
![12.changelog_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628765281970-86e58a5c-407e-4816-b1aa-57dc9bfbcc72.png#clientId=ub7604c98-e464-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud4792073&margin=%5Bobject%20Object%5D&name=12.changelog_4.png&originHeight=641&originWidth=1243&originalType=binary&ratio=1&rotation=0&showTitle=false&size=150105&status=done&style=stroke&taskId=u779e9e67-90b1-4752-b168-4e7c7ad3b6e&title=)
另外，DataFlux 支持通过页面功能按钮和快捷键（Ctrl+K ）快速保存快照。在场景视图和全部查看器内，使用快捷键 Ctrl+K ，即可快速弹出【保存快照】弹窗，输入名称，点击【确定】即可添加当前页面为新的快照。

**注意**：当您的后台程序存在与快捷键 Ctrl+K 冲突的其他快捷键时，您将无法使用「保存快照」的快捷键功能。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1628498602022-843a301b-ba20-41fa-88b9-f33749f5ca0a.png#clientId=u147dd289-ae74-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=497&id=OVh2e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=497&originWidth=1102&originalType=binary&ratio=1&rotation=0&showTitle=false&size=100256&status=done&style=none&taskId=uc39aa9c5-0646-4709-b0f1-c28d4b3669b&title=&width=1102)
#### 新增图表和快照分享管理

DataFlux 支持对当前空间内分享的图表和快照进行统一管理。如在「场景视图中」完成图表分享后，通过「管理」-「分享管理」-「图表分享」可以查看当前空间内的图表分享列表，并进行图表查看，查看嵌入代码和取消分享。详情可参考文档 [分享管理](https://www.yuque.com/dataflux/doc/eybvlv) 。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1628580029848-9edef1ae-93e1-4d31-8adb-d61ba3a7690f.png#clientId=u4599a029-0f9b-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=452&id=u66220208&margin=%5Bobject%20Object%5D&name=image.png&originHeight=452&originWidth=849&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105145&status=done&style=none&taskId=u393411f5-fe0a-4dec-99be-0f737d1a4be&title=&width=849)
#### 新增用户邮箱更换、手机更换解绑功能

在 DataFlux 工作空间，点击左下角「账号」-「设置」-「基础设置」，即可更换、解绑手机和邮箱。
![6.account_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628675808426-feae2691-1e4e-411e-b27c-0329d93adc7e.png#clientId=ub7604c98-e464-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=jClgV&margin=%5Bobject%20Object%5D&name=6.account_1.png&originHeight=362&originWidth=830&originalType=binary&ratio=1&rotation=0&showTitle=false&size=36758&status=done&style=stroke&taskId=u44073194-4b40-4c52-b1f4-470d568e24b&title=)

#### 新增自定义用户访问监测 SDK 采集数据内容

DataFlux 支持自定义用户访问监测 SDK 采集数据内容，通过自定义设置用户标识、自定义设置会话以及自定义添加额外的数据 TAG ，帮助用户在特定场景下，通过设置不同类型的标识来定位分析数据。详情可参考文档 [自定义用户访问监测 SDK 采集数据内容](https://www.yuque.com/dataflux/doc/xu6qg3) 。

#### 新增付费版 Session 、任务调度、Trace 免费额度

DataFlux 付费版本新增每台 DataKit 每天赠送 100 万条日志类数据、100 个 Session 数量、1 万次任务调度次数以及 100万个Trace数量。更多计费逻辑可参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。

#### 优化场景图表分析模式

DataFlux 支持在时序图的分析模式下，通过图表下方的时间轴，预览对象数据在四倍查询周期内的交互变化，并且通过拖动时间轴选择时序图展示的时间范围。如：当前时间点为14:00，时间范围选择【10:00-11:00】，那么时间轴范围【08:00-12:00】。详情可参考文档 [时序图](https://www.yuque.com/dataflux/doc/sqg3vu) 。
![12.changelog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628749653041-1ca950a6-73f3-4184-af9f-585963757126.png#clientId=ub7604c98-e464-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=JNTAP&margin=%5Bobject%20Object%5D&name=12.changelog_2.png&originHeight=706&originWidth=1293&originalType=binary&ratio=1&rotation=0&showTitle=false&size=108998&status=done&style=stroke&taskId=ucd60814e-e037-4b71-8c08-0fd4f92537e&title=)注意：时序图一条查询语句最多返回 10 条时间线，即根据分组（group by）条件的结果，超过 10 条时间线的数据按照顺序只显示 10 条时间线。

#### 优化基础设施主机、容器蜂窝图

悬停鼠标至主机、容器对象，可查看主机、容器名称、CPU 使用率和 MEM 使用率。

![4.contrainer_2.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628750370230-7d97d7cf-63f2-4182-9e7b-a306e69d9634.png#clientId=ub7604c98-e464-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9e3bdc12&margin=%5Bobject%20Object%5D&name=4.contrainer_2.1.png&originHeight=783&originWidth=1248&originalType=binary&ratio=1&rotation=0&showTitle=false&size=120047&status=done&style=stroke&taskId=u7034496d-889c-41f1-ac7b-03d48b5bc1a&title=)

#### 优化日志来源列表根据查看器时间范围显示

DataFlux 支持通过选择查看器时间范围筛选日志来源列表。如在 DataFlux 工作空间「日志查看器」右上角时间范围选择 15 分钟，左侧日志列表仅显示 15 分钟内有数据的日志来源。
![12.changelog_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628756098125-bc1f1516-a4da-4edb-8ba9-f1c667167070.png#clientId=ub7604c98-e464-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ucc1e2806&margin=%5Bobject%20Object%5D&name=12.changelog_3.png&originHeight=640&originWidth=1246&originalType=binary&ratio=1&rotation=0&showTitle=false&size=152943&status=done&style=stroke&taskId=u0148c076-b558-423f-99eb-51f1ab9dd5c&title=)

#### 优化系统主题颜色切换

DataFlux 支持切换系统主题颜色，分成浅色和深色两种，点击左下角账号，在「系统主题」点击需要的主题即可直接切换使用。
![11.show_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628674906455-4223daca-af2b-442d-aece-9cd34a45dad7.png#clientId=ue5167666-f6d8-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u399b305e&margin=%5Bobject%20Object%5D&name=11.show_1.png&originHeight=247&originWidth=391&originalType=binary&ratio=1&rotation=0&showTitle=false&size=25337&status=done&style=stroke&taskId=u5aa6cb31-1976-4f0e-a966-f900de5b281&title=)
#### 其他优化功能

- Webhook自定义通知发送内容的类型从文本格式调整为json格式 。
- 新增异常检测库告警设置的告警沉默 15 分钟选项，即在 15 分钟时间范围内，相同告警不发送通知。
- 未恢复事件列表页显示样式调整，日志告警事件统计显示从表格图调整为时序图。

## 2021 年 8 月 4 号
### DataFlux Studio
m
#### 新增容器Services和Deployments查看器

DataFlux支持通过「Container」、「Pod」、「Services」、「Deployments」等查看器，从不同的维度全面展示容器的状态。

在工作空间「基础设施」-「容器」，通过左上角的数据类型筛选栏，可以切换至「[Services](https://www.yuque.com/dataflux/doc/gy7lei#Xbgsf)」查看空间内留存的全部 Service 的详尽信息，包括Service 名称、服务类型、Cluster IP、External IP、运行时长等。
![1.contrainer_services_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628132197227-c86fd9ca-4395-4198-a113-4c6fd3570f4e.png#clientId=u5c25d63e-59ca-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u28372349&margin=%5Bobject%20Object%5D&name=1.contrainer_services_1.png&originHeight=362&originWidth=1245&originalType=binary&ratio=1&rotation=0&showTitle=false&size=72217&status=done&style=stroke&taskId=u29f6b850-b46a-4f4b-81fe-da2e1d719a8&title=)
切换至「[Deployments](https://www.yuque.com/dataflux/doc/gy7lei#cszE8)」可查看空间内留存的全部 Deployment 的详尽信息，包括Deployment 名称、可用副本、已升级副本、准备就绪、运行时长等。
![1.contrainer_deployments_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1628132895844-3197933c-e609-47e1-9b24-c67848086b28.png#clientId=u5c25d63e-59ca-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8c480818&margin=%5Bobject%20Object%5D&name=1.contrainer_deployments_1.png&originHeight=345&originWidth=1249&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61147&status=done&style=stroke&taskId=u7242cbee-b0e5-4145-bf09-13771d6db4c&title=)
## 2021 年 7 月 29 号
### DataFlux Studio

#### 新增基础设施全局 Label 功能

DataFlux 新增基础设施全局 Label 功能，支持用户针对主机、容器、进程等基础设施对象添加自定义标签，并通过添加的标签筛选展示相同标签的基础设施对象。

在基础设施对象列表中，点击对象名称，即可划出详情页为对象添加标签「Label 属性」。
![6.host_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627443895342-982d4466-ee89-42dd-834d-24063c4facd7.png#clientId=u5f108af0-a49d-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u27b0151d&margin=%5Bobject%20Object%5D&name=6.host_2.png&originHeight=572&originWidth=1136&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61012&status=done&style=stroke&taskId=u34f33f7a-7029-4a71-9fcf-6b068ad9842&title=)
自定义标签添加后，可在对象列表通过添加的标签筛选展示相同标签的对象列表。
![6.host_20.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627537057273-97d8507a-a5c7-4ec7-aff5-1d97842f37dc.png#clientId=udafc4441-48b7-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ub9038299&margin=%5Bobject%20Object%5D&name=6.host_20.png&originHeight=460&originWidth=1250&originalType=binary&ratio=1&rotation=0&showTitle=false&size=62991&status=done&style=stroke&taskId=ucee7dcd9-9b59-45e5-a443-05e9ee28e61&title=)

#### 新增短信通知对象；新增付费计划与账单短信费用统计

DataFlux支持用户管理发送告警的通知对象，目前支持添加钉钉机器人、企业微信机器人、飞书机器人、Webhook自定义、邮件组和短信组。更多配置详情参考文档 [通知对象管理](https://www.yuque.com/dataflux/doc/osstog) 。

**注意：**

- 短信通知的成员需要先在「管理」 - 「成员管理」中邀请加入到工作空间后才可选择。
- DataFlux 免费版无短信通知，其他版本短信通知100条/10元，按天计费。

![5.inform_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627568466895-e6490e4c-e6cb-48db-99eb-e7b0977df2f0.png#clientId=ube226d8b-7015-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3640a435&margin=%5Bobject%20Object%5D&name=5.inform_3.png&originHeight=457&originWidth=619&originalType=binary&ratio=1&rotation=0&showTitle=false&size=30907&status=done&style=stroke&taskId=u4990bef8-a405-4e55-9294-a836b590413&title=)

#### 新增场景视图幻灯片轮播模式

DataFlux 新增场景视图幻灯片放映，支持使用幻灯片模式浏览指定场景下的全部节点视图，并自定义幻灯片放映的时间间隔。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627551724574-907476c2-cb70-4d55-a710-92dc8702dacd.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=476&id=ue074dee8&margin=%5Bobject%20Object%5D&name=image.png&originHeight=476&originWidth=1104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=87812&status=done&style=stroke&taskId=u36b7eac5-e828-4faa-8140-a435a6cd6c1&title=&width=1104)
#### 新增工作空间更换 Token 功能

DataFlux 支持当前空间管理员变更空间内的Token，并自定义当前Token的失效时间。进入「管理」-「基本设置」-「更换Token」，选择失效时间并确认「更换」后，DataFlux会自动生成新的Token，旧的Token会在指定时间内失效。

**注意：**

- 更换Token后，原有Token会在指定时间内失效。如有任何代理使用该Token，都将立刻停止数据上报，请务必及时检查集成配置；
- 更换Token会触发「[操作事件](https://www.yuque.com/dataflux/doc/dlxizg)」和「[通知](https://www.yuque.com/dataflux/doc/tyqtg8)」。

![WX20210727-154205.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1627371791241-f2877b74-2d5a-41cc-8a46-6b850a57ec39.png#clientId=u7d349e3f-f552-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udddea1fe&margin=%5Bobject%20Object%5D&name=WX20210727-154205.png&originHeight=598&originWidth=991&originalType=binary&ratio=1&rotation=0&showTitle=false&size=61444&status=done&style=stroke&taskId=uf2e01a81-4068-4cef-885c-77ad2600d90&title=)

#### 新增指标DQL查询模式

DataFlux 支持在工作空间「指标」，切换「搜索」为「DQL 查询模式」后，直接输入 DQL 语句进行查询，查询可在左侧查看对应的标签和指标，在右侧查看查询语句返回的可视化图表。
![10.metric_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627552181227-85bf2856-c940-4556-879c-f9b334c46cb2.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8c7e3734&margin=%5Bobject%20Object%5D&name=10.metric_1.png&originHeight=775&originWidth=1244&originalType=binary&ratio=1&rotation=0&showTitle=false&size=117433&status=done&style=stroke&taskId=u959cf2c1-8401-4ee4-b51c-94d28959d5d&title=)

#### 优化日志查看器多行显示

DataFlux 支持在日志查看器的“设置”中选择日志显示“1行”、“3行”或“10行”来查看完整的日志内容。更多日志查看器的说明，可查看文档 [日志分析](https://www.yuque.com/dataflux/doc/ibg4fx) 。
![9.log_1.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627553028698-1c9df870-0df6-4bf9-aeb9-0fad6e7e7610.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf0834823&margin=%5Bobject%20Object%5D&name=9.log_1.1.png&originHeight=671&originWidth=1241&originalType=binary&ratio=1&rotation=0&showTitle=false&size=148417&status=done&style=stroke&taskId=u1af3fd74-0c00-41ab-b62e-a77f7357136&title=)
#### 优化应用性能监测服务和链路切换查看，优化响应时间折线图

DataFlux 支持「服务」和「链路」查看器互相切换时，默认保留当前的筛选条件（包括：环境、版本）和时间范围。 如：在应用性能监测「服务」选择「环境」为`production_a`  ，「时间范围」为`最近30分钟`。
![11.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627553498279-a0c0e578-8752-4393-8f69-6f3499f0a812.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uccb021f6&margin=%5Bobject%20Object%5D&name=11.changelog_1.png&originHeight=374&originWidth=1250&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70348&status=done&style=none&taskId=u6cb14861-b1b2-482f-91e0-6b2302304b5&title=)
切换至应用性能监测「链路」，筛选条件和「服务」保持一致。更多有关应用性能监测的说明，可参考文档 [链路分析](https://www.yuque.com/dataflux/doc/qp1efz) 。
![11.changelog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627553506397-a682515d-2679-47fd-ab68-a7d78f0bdf2c.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua7fb5465&margin=%5Bobject%20Object%5D&name=11.changelog_2.png&originHeight=569&originWidth=1243&originalType=binary&ratio=1&rotation=0&showTitle=false&size=126859&status=done&style=none&taskId=ua8262b09-8afc-4d7f-8d4f-9e6ae58da1c&title=)

#### 优化DataKit采集器安装指南

DataFlux 支持在安装 DataKit 的时候自定义安装选项，如云厂商、命名空间、全局 tag 等；DataKit 离线安装支持直接点击下载不同操作系统的离线安装包。 更多 DataKit 安装说明可参考文档 [DataKit 使用入门](https://www.yuque.com/dataflux/datakit/datakit-how-to) 。

![11.changelog_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627554637438-40383d6e-cdbb-4f59-8df2-49b7e02f1dbd.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u167a8bd7&margin=%5Bobject%20Object%5D&name=11.changelog_3.png&originHeight=753&originWidth=1126&originalType=binary&ratio=1&rotation=0&showTitle=false&size=135320&status=done&style=stroke&taskId=u992fb060-1343-41db-ab3b-414dc083d6f&title=)

#### 优化火焰图同步、异步调用展示

DataFlux 应用性能监测的火焰图支持查看服务同步和异步调用链路性能的数据详情。如通过火焰图可以清晰查看哪几条请求是异步进行的，从什么时候开始、什么时候结束以及总共花了多少时间。更多火焰图的详细说明，参考文档 [链路分析](https://www.yuque.com/dataflux/doc/qp1efz#709bc06a) 。
![2.trace_huoyantu.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627353393380-9c6884cc-e91f-4124-b144-f5b9b8769f82.png#clientId=uf9d22184-c601-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uffb1e9ae&margin=%5Bobject%20Object%5D&name=2.trace_huoyantu.png&originHeight=353&originWidth=1134&originalType=binary&ratio=1&rotation=0&showTitle=false&size=65532&status=done&style=stroke&taskId=uff2d85ba-5815-4db8-bcfa-8b1524a56f5&title=)
#### 优化查看器显示列自定义字段别名

DataFlux 支持为查看器显示的字段自定义别名，如在基础设施主机对象，用户可以在“添加显示列”修改字段别名，修改以后可以在查看器以及详情中查看。
![6.host_12.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627555422239-339b0582-de0e-4ae9-8be5-de87610abdea.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ucda8e722&margin=%5Bobject%20Object%5D&name=6.host_12.1.png&originHeight=450&originWidth=1253&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74818&status=done&style=stroke&taskId=u34095a3e-fe3a-475e-80a1-02a1d79ee9d&title=)

#### 优化云拨测自建节点

DataFlux 云拨测自建节点地理位置拆分成两个筛选框：国家和省份（或城市）。如果国家筛选框选中的是China，则后一个筛选框会过滤出省份的列表；如果国家选中的为非China，则后一个筛选框过滤显示城市的列表。筛选框默认显示 20条，支持模糊搜索。关于如何创建和管理云拨测自建节点，可参考文档 [自建节点管理](https://www.yuque.com/dataflux/doc/phmtep) 。
![11.changelog_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1627555696599-83496c77-46a4-4734-915b-29663162168f.png#clientId=u8ffd2239-34d5-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8e4555db&margin=%5Bobject%20Object%5D&name=11.changelog_4.png&originHeight=382&originWidth=532&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27423&status=done&style=stroke&taskId=ue4fcbbfb-33ce-4c77-89c6-dab0ab6637d&title=)

#### 优化 DQL 查询函数

DataFlux DQL 新增exists、wildcard、with_labels等多种查询函数，更多 DQL 函数使用说明，可参考文档 [DQL 函数](https://www.yuque.com/dataflux/doc/ziezwr) 。

## 2021 年 7 月 15 号
### DataFlux Studio

#### 新增用户访问第三方开发工具接入

DataFlux 新增基于uniapp开发框架的小程序接入，通过引入 sdk 文件，监控小程序的性能指标、错误 log 以及资源请求情况数据，并上报到 DataFlux 平台。更多配置详情可参考文档 [基于uniapp开发框架的小程序接入](https://www.yuque.com/dataflux/doc/vayk4z) 。

#### 新增无数据异常检测

DataFlux 新增无数据异常检测，基于配置自定义检测周期来触发产生事件，产生的无数据事件统一保存在事件中。

配置无数据检测规则生效后，第一次检测无数据且持续无数据，不产生无数据告警事件；若检测有数据且在配置的自定义检测周期内，数据上报发生断档，则产生无数据告警事件。
![12.changlog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626347875160-b5843f2c-fe84-4a02-8c00-fb8e11005eed.png#clientId=u793fad92-f61a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3e83b5c9&margin=%5Bobject%20Object%5D&name=12.changlog_1.png&originHeight=550&originWidth=1205&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57747&status=done&style=stroke&taskId=u46bf06ce-6af1-4711-b9f5-2f9e9d3cda9&title=)
#### 新增 Elasticsearch、Redis 和 Docker 内置检测库

DataFlux 目前支持 Elasticsearch、Redis、Host 和 Docker 监控 4个内置检测库，您无需手动配置，开箱即可使用。若需要了解更多详情，可直接点击对应的内置检测库。

- Redis 检测库：包括 Redis 等待阻塞命令的客户端连接数异常增加
- Host 监控：包括主机 CPU、内存、磁盘等多种数据指标
- Elasticsearch 检测库：包括 ES JVM 堆内存、线程池、搜索查询负载异常等指标
- Docker 监控：包括容器 CPU、内存等多种数据指标

![12.changlog_6.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626353607335-7ba94d0f-f9c0-4ab3-8f24-0b9cd764eb57.png#clientId=ud32bd13d-75e9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uca38a64d&margin=%5Bobject%20Object%5D&name=12.changlog_6.png&originHeight=342&originWidth=1234&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53219&status=done&style=stroke&taskId=u873e31af-daf7-4bc2-968c-2571ed88b96&title=)
#### 新增应用性能"所有Trace查看器"

DataFlux 提供三种链路筛选查看列表，分别为“所有Span”、“顶层Span”和“Traceid”。span 表示给定时间段内分布式系统中的逻辑工作单元，多个 span 会构成一条链路轨迹（trace）。

- 所有 Span：显示当前所选时间范围内，所有采集到Span数据
- 服务顶层 Span：筛选显示当前所选时间范围内，首次进入的所有Span数据
- 所有 Trace：筛选显示当前所选时间范围内，所有包含初始顶层span的trace数据

![12.changlog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626348466791-5e60f195-55c2-4b9f-8e86-ad49ddb48071.png#clientId=u793fad92-f61a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ufd643363&margin=%5Bobject%20Object%5D&name=12.changlog_2.png&originHeight=616&originWidth=1238&originalType=binary&ratio=1&rotation=0&showTitle=false&size=135606&status=done&style=stroke&taskId=uab4a1d88-55e4-4292-ae7e-f0278360e16&title=)
**新增链路详情查看拓扑调用关系图**

DataFlux 在应用性能监测详情页新增对应服务拓扑调用关系图用来查看各个服务之间的调用关系。
![3.trace_12.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626075704246-640629b1-5bc3-4d16-b6c3-27b555f105ab.png#clientId=u496eaf6e-cef9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u793109f2&margin=%5Bobject%20Object%5D&name=3.trace_12.png&originHeight=633&originWidth=1148&originalType=binary&ratio=1&rotation=0&showTitle=false&size=76030&status=done&style=stroke&taskId=ufdac3bfd-fdcd-46c2-b5cd-b4ee61aacef&title=)

#### 新增用户访问错误详情页

DataFlux 支持在用户访问详情页查看用户访问错误详情，可查看出现在该次用户访问时的错误数据信息、错误类型和错误发生时间。
![4.rum_5.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626143579066-3cd93ede-1104-46c8-924e-85489244ee6d.png#clientId=u8d04058b-caf0-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=Ph2wN&margin=%5Bobject%20Object%5D&name=4.rum_5.png&originHeight=530&originWidth=1074&originalType=binary&ratio=1&rotation=0&showTitle=false&size=93410&status=done&style=stroke&taskId=u8bf905a5-cced-4396-8bd7-ee4a7ce022e&title=)
点击错误信息，可跳转至对应错误的详情页。
![4.rum_5.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626143770838-3c3544f0-5f47-4b78-bd7a-f825d1518535.png#clientId=u8d04058b-caf0-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=FzNU2&margin=%5Bobject%20Object%5D&name=4.rum_5.1.png&originHeight=436&originWidth=1077&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97357&status=done&style=stroke&taskId=u58600e09-be28-4ab3-83c6-7af55ce425a&title=)
#### 新增安全巡检概览统计

在「安全巡检」-「概览」，可以通过筛选主机、安全巡检等级、安全巡检类别来查看不同主机发生安全巡检事件的概览情况，包括不同等级安全巡检事件发生的数量及可视化图表分析，不同类别和规则的安全巡检事件排行榜。
![9.security_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626334052420-475e3d13-c803-4eb2-906e-65740f4b378b.png#clientId=u5f0daca9-a803-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=XOBGW&margin=%5Bobject%20Object%5D&name=9.security_1.png&originHeight=557&originWidth=1234&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54887&status=done&style=stroke&taskId=uc9f67d8e-a26b-4c2b-b53b-a41b5194a7d&title=)

#### 新增安全巡检事件处理建议

在安全巡检查看器，点击想要查看的巡检事件，在划出详情页中，您可以查看对本次安全巡检事件的处理建议，包括安全巡检事件发生的理论基础、风险项、审计方法、补救措施等。
![9.security_7.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626335574553-f4516fc9-4853-465a-a11b-cd930fc39637.png#clientId=u4807469a-7b38-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8c11099e&margin=%5Bobject%20Object%5D&name=9.security_7.png&originHeight=1184&originWidth=1124&originalType=binary&ratio=1&rotation=0&showTitle=false&size=144457&status=done&style=stroke&taskId=ucf527676-b35a-49ca-819d-19af31dd373&title=)
#### 新增二级导航栏

DataFlux 新增支持通过“鼠标悬停“显示二级导航，进而缩短用户找寻目标数据的时间。
![12.changlog_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626349817975-a1af8a77-b8d1-4b0f-a37f-e2885cb1fb5c.png#clientId=u793fad92-f61a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=XNrBv&margin=%5Bobject%20Object%5D&name=12.changlog_3.png&originHeight=185&originWidth=404&originalType=binary&ratio=1&rotation=0&showTitle=false&size=13171&status=done&style=stroke&taskId=u3fce6fe8-8742-4df8-b5b4-a54a8c0bfe2&title=)

#### 新增成员管理搜索功能

DataFlux 支持在「成员管理」通过搜索功能，快速基于邮箱或姓名匹配当前工作空间的成员。![12.changlog_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626350129437-0edc8633-acc1-40b6-a862-0380374ae09d.png#clientId=u793fad92-f61a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u55edfeef&margin=%5Bobject%20Object%5D&name=12.changlog_4.png&originHeight=185&originWidth=1236&originalType=binary&ratio=1&rotation=0&showTitle=false&size=25855&status=done&style=stroke&taskId=u736b3bde-fe2c-447f-8eed-cec2155e5af&title=)
#### 新增绑定内置视图到基础设施对象

DataFlux 支持**当前空间管理员**绑定内置视图（系统视图、用户视图）到基础设施对象的详情页面。如下图中绑定了内置系统视图“Disk 监控视图”。更多配置详情，可参考文档 [绑定内置视图](https://www.yuque.com/dataflux/doc/dns233/) 。
![12.changlog_5.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626350986753-5e0f2998-121c-4ae5-aba0-678bec4dd58a.png#clientId=u793fad92-f61a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u4a02fff1&margin=%5Bobject%20Object%5D&name=12.changlog_5.png&originHeight=866&originWidth=1135&originalType=binary&ratio=1&rotation=0&showTitle=false&size=83924&status=done&style=stroke&taskId=udb931375-833f-47dd-8817-4b48f11d390&title=)

#### 优化事件列表按照检测库类型显示

DataFlux 支持在事件列表支持根据不同的检测库类型显示对应的事件信息。

- 当检测库规则类型为阈值、突变、区间、水位、应用性能指标、用户访问指标检测时，根据配置的触发条件显示对应的基线及其对应信息，包括紧急、错误、警告。
- 当检测库规则类型为日志、安全巡检、异常进程、云拨测检测时，查询异常事件统计的所有日志数据。

如下图中有三种不同的检测库类型，包括阈值检测、安全巡检检测和进程数据检测，更多检测库介绍和配置可参考文档 [自定义检测库 ](https://www.yuque.com/dataflux/doc/ytk7ug)。
![10.event_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626337336465-6588b3af-82fa-4d2e-92de-10f7b7097b21.png#clientId=u0800d891-0b14-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9d8172cf&margin=%5Bobject%20Object%5D&name=10.event_1.png&originHeight=1269&originWidth=1151&originalType=binary&ratio=1&rotation=0&showTitle=false&size=209668&status=done&style=stroke&taskId=ufb5e253e-9a67-49a5-888a-eb2f594f76e&title=)
#### 优化指标集删除

DataFlux 支持管理员删除空间内的指标集，进入「管理」-「基本设置」，点击「删除指标集」后，输入关键字查询并选择指标集名称，点击「确定」后进入删除队列等待删除。删除指标集时，会产生系统通知事件，如用户创建了删除指标集任务、删除指标集任务执行成功、删除指标集任务执行失败等。
![11.metric_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1626341582945-0136599b-6f0d-436f-b706-91ca18497831.png#clientId=ub5fa78bd-6b25-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=y7Q7l&margin=%5Bobject%20Object%5D&name=11.metric_1.png&originHeight=217&originWidth=449&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9810&status=done&style=stroke&taskId=ua5f38742-d4fa-4b69-b6ec-501ace9d002&title=)

#### 优化查看器内置视图查询时间范围

变更内置视图查询时间范围，包括基础设施对象、链路、日志详情页的「主机监控」视图和链路、日志详情页的「进程」视图。

- 查看链路、日志的详情页面时，「主机监控」默认展示关联的主机在选定时间组件范围内的性能数据
- 查看基础设施对象（主机、容器）的详情页面时，「主机监控」默认展示最近24小时内主机的性能数据
- 查看链路的详情页面时，「进程」默认展示该链路发生时间点的前后10分钟内的实时进程数据
- 查看日志的详情页面时，「进程」默认展示该日志产生时间点的前后10分钟内的实时进程数据

#### 优化查看器快捷筛选交互

DataFlux 各查看器快捷筛选若当前字段对应值过长，超出的部分用`···`显示，且鼠标移动到当前字段值区域，按照字段值长度向右拓展显示。

## 2021 年 7 月 1 号
### DataFlux Studio 

#### 新增未恢复事件统计查看器

DataFlux 新增未恢复事件统计查看器，在DataFlux工作空间的「事件」，通过切换左上角的查看器，您可以查看到空间内持续被触发的全部未恢复事件，及不同告警级别下未恢复事件的数据量统计、告警信息详情等。更多详情可参考文档 [未恢复事件统计](https://www.yuque.com/dataflux/doc/vzall6#wDArf) 。
![1.changelog_5.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625131898922-ed6b1619-74de-4c3b-939b-5955ca98c0ba.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ucc3c1098&margin=%5Bobject%20Object%5D&name=1.changelog_5.png&originHeight=745&originWidth=1161&originalType=binary&ratio=1&rotation=0&showTitle=false&size=102838&status=done&style=stroke&taskId=u9d45e7ef-6bc1-4d18-8970-3cc41d59990&title=)
#### 新增图表链接功能

DataFlux 新增时序图、柱状图、概览图、仪表盘、饼图、排行榜、散点图、气泡图、地图、蜂窝图的图表链接功能。图表链接可以帮助你实现从当前图表跳转至目标页面，支持通过模板变量修改链接中对应的变量值将数据信息传送过去，完成数据联动。
![1.changelog_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625130442588-be4972bc-a3ee-4420-9798-3a5704148e45.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc2b7a108&margin=%5Bobject%20Object%5D&name=1.changelog_2.png&originHeight=734&originWidth=1307&originalType=binary&ratio=1&rotation=0&showTitle=false&size=140888&status=done&style=none&taskId=u180b2409-512a-442a-b382-71d60087da1&title=)

图表链接支持通过查询获取模版变量，支持添加平台内部链接和外部链接，支持新页面、当前页面和划出详情页三种打开方式，支持为链接添加别名显示。
![1.changelog_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625130384710-0d3b04be-5912-4346-b4bc-0e5679d3cc36.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=r9y1e&margin=%5Bobject%20Object%5D&name=1.changelog_3.png&originHeight=444&originWidth=1570&originalType=binary&ratio=1&rotation=0&showTitle=false&size=87812&status=done&style=none&taskId=u09486b60-c47f-4788-ac9d-7cb2e451393&title=)
链接添加完成后，点击图表即可查看可以点击打开的“自定义链接”。更多详情可参考文档 [图表链接](https://www.yuque.com/dataflux/doc/nn6o31) 。
![1.changelog_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625130471987-302fa7ab-3346-4b40-835e-2360bb57c1de.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ub2eb767a&margin=%5Bobject%20Object%5D&name=1.changelog_1.png&originHeight=242&originWidth=711&originalType=binary&ratio=1&rotation=0&showTitle=false&size=25851&status=done&style=none&taskId=uffb4bfae-cc83-42be-9fc3-e971d0d0250&title=)

#### 新增应用性能监测绑定链接和内置视图

DataFlux 支持在单个服务详情中添加内置视图，包括[内置视图](https://www.yuque.com/dataflux/doc/gyl9vv)和可链接的网页地址。在服务列表中，点击「设置」，您可以可添加一个或多个跳转链接地址或[内置视图](https://www.yuque.com/dataflux/doc/gyl9vv)，并自定义名称。
![1.changelog_7.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625140452087-93a72f32-09e1-4fe0-83a4-eae972f81667.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue72a0e1c&margin=%5Bobject%20Object%5D&name=1.changelog_7.png&originHeight=430&originWidth=1182&originalType=binary&ratio=1&rotation=0&showTitle=false&size=62045&status=done&style=stroke&taskId=u24fff7b8-de9e-40ca-bcf4-0a4adfa2337&title=)

添加内置视面后，您可以通过查看服务详情，查看对应的内置页面。
![1.changelog_8.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625140502828-4558bd08-f247-4b8b-bb63-4d5a7b904dca.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u43cf12be&margin=%5Bobject%20Object%5D&name=1.changelog_8.png&originHeight=518&originWidth=1186&originalType=binary&ratio=1&rotation=0&showTitle=false&size=124260&status=done&style=stroke&taskId=u50d622bf-7087-4b5e-b2f5-0a17b864674&title=)

#### 新增用户访问监测场景PV/UV概览统计

DataFlux 新增用户访问监测的Web、iOS、Android和小程序场景PV/UV概览统计。可快速对比PV/UV的差异，了解实际访问用户数量。
![1.changelog_6.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625139092630-706ecb05-f02c-4d48-8794-2c73e65265d0.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9b0e02da&margin=%5Bobject%20Object%5D&name=1.changelog_6.png&originHeight=766&originWidth=1162&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134235&status=done&style=stroke&taskId=uf6194157-ff6b-447a-88b2-17207a5c01a&title=)

#### 新增通知对象：飞书机器人

DataFlux支持用户管理发送告警的通知对象，目前支持添加邮件、钉钉机器人、企业微信机器人、飞书机器人和Webhook自定义。更多配置详情参考文档 [通知对象管理](https://www.yuque.com/dataflux/doc/osstog) 。

![1.changelog_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625130906065-f32c865c-ad08-49fb-8d48-f385670b7d43.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&height=392&id=u699b7eb8&margin=%5Bobject%20Object%5D&name=1.changelog_4.png&originHeight=522&originWidth=714&originalType=binary&ratio=1&rotation=0&showTitle=false&size=30009&status=done&style=stroke&taskId=u810daf6a-3d7f-4dad-8142-1ec1e71f142&title=&width=536)

#### 优化基础设施自定义对象

基础设施除了主机、容器、进程以外的对象数据都可以通过DataFlux Function自定义上报数据到「基础设施」-「自定义」进行查看和分析。支持为自定义对象数据绑定内置视图，手动添加标签进行筛选。更多详情可参考文档 [基础设施自定义对象](https://www.yuque.com/dataflux/doc/ssyuyz) 。

![4.object_more_view_9.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625133947755-263a91ab-6723-4960-b5bd-7437962c13ce.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=Py0S3&margin=%5Bobject%20Object%5D&name=4.object_more_view_9.png&originHeight=260&originWidth=1242&originalType=binary&ratio=1&rotation=0&showTitle=false&size=47023&status=done&style=stroke&taskId=u3b73e522-4772-4a27-94ec-ba5b2f8b4ce&title=)
自定义对象数据上报需要先安装并连通 DataKIt 和 Function，再通过 Function 上报数据到 DataKit，最终 DataKit 上报数据到 DataFlux 工作空间。关于如何通过DataFlux Function上报数据，可参考文档 [自定义对象数据上报](https://www.yuque.com/dataflux/doc/nw9bxt) 。


#### 优化异常检测库的检测规则

DataFlux 新增异常事件恢复告警配置；新增筛选条件支持正则匹配样式调整，优化`＝～`为`match` ，新增`not match`；新增触发条件支持非数值型数据匹配，新增 `match`、`not match`正则匹配，新增`between`。更多检测规则说明可以参考文档 [自定义检测库](https://www.yuque.com/dataflux/doc/ytk7ug) 。
![4.1.changelog_10.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625142011045-1d0e13e0-17a8-4471-8378-51ee86f191eb.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0ab9fd44&margin=%5Bobject%20Object%5D&name=4.1.changelog_10.png&originHeight=833&originWidth=1128&originalType=binary&ratio=1&rotation=0&showTitle=false&size=97424&status=done&style=stroke&taskId=u45d073ce-86c3-4c8b-97fa-2d1b7470fca&title=)

#### 优化查看器详情页关联日志

DataFlux 支持在链路侧滑详情页中关联的日志页面基于`trace_id`做默认过滤筛选，查看相同`trace_id`条件下关联的日志详情。

在链路详情内，点击火焰图下方的「日志」，您可以基于当前链路关联的主机、链路ID（`trace_id` 字段）查看关联日志。同时，您可以对日志进行关键字搜索和多标签筛选。若您需要查看更详细的日志内容，您可以点击日志内容跳转到日志详情页面，或点击跳转按钮到日志页打开。
![1.changelog_11.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625142840147-8676059c-2c06-482d-9ee1-36d4acd06551.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf5567346&margin=%5Bobject%20Object%5D&name=1.changelog_11.png&originHeight=655&originWidth=1081&originalType=binary&ratio=1&rotation=0&showTitle=false&size=117225&status=done&style=stroke&taskId=u1c97f918-f355-4149-b941-bd2465c0ee3&title=)
用户访问监测Android/iOS的view查看器新增日志关联页面。
![1.changelog_12.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1625143745963-ab78f38f-0d8a-4eee-bbb8-bf56e238b99d.png#clientId=u47c50c73-881c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u7281a58c&margin=%5Bobject%20Object%5D&name=1.changelog_12.png&originHeight=492&originWidth=1188&originalType=binary&ratio=1&rotation=0&showTitle=false&size=126218&status=done&style=stroke&taskId=u7b96874e-42d7-4650-b101-7424657e864&title=)

#### 优化查看器搜索样式

调整新建场景、指标、应用性能监测、用户访问监测、异常检测库、主机静默管理、集成、管理/内置视图、快照等搜索样式。

#### 部署版本支持修改数据保留时长

工作空间管理的基本信息增加变更数据存储策略。


## 2021 年 6 月 17 号
### DataFlux Studio 

#### 新增日志分析模式

DataFlux 支持通过日志的分组功能，对庞大的原始数据基于**1-3个标签**进行分组处理，以反映出分组数据在不同时间的分布特征与趋势。DataFlux 支持三种分组数据浏览方式：折线图，面积图、柱状图。[了解更多日志分析模式](https://www.yuque.com/dataflux/doc/ibg4fx#FVX3T)。
![8.log_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623914227457-e22a8d9d-8c0b-4f99-92e4-73724cba8e18.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1fec8caa&margin=%5Bobject%20Object%5D&name=8.log_1.png&originHeight=895&originWidth=1191&originalType=binary&ratio=1&rotation=0&showTitle=false&size=79027&status=done&style=stroke&taskId=u8533ecbd-57a6-4b27-a2f6-6cbbbc1b01f&title=)

#### 新增日志过滤

新增日志过滤功能（日志黑名单），支持设置过滤规则过滤掉符合条件的日志，即配置日志过滤以后，符合条件的日志数据不再上报到DataFlux 工作空间，帮助用户节约日志数据存储费用。[了解更多日志过滤采集](https://www.yuque.com/dataflux/doc/ilhawc)。

在「日志」-「过滤规则」－「新建规则」，选择“日志来源”，添加一个或多个关系为**and（并且）** 的数据筛选条件，对采集的日志数据进行过滤。符合筛选条件的日志数据，将不会被上报到工作台。
![10.log_filter_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623916322788-e6d0ec71-ad49-4926-88b3-f19d67c5ec66.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6adb69e1&margin=%5Bobject%20Object%5D&name=10.log_filter_1.png&originHeight=454&originWidth=1144&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50501&status=done&style=none&taskId=uefc07f2a-57a4-4c1b-a5e9-e795dcbf3e2&title=)

#### 新增保存指标浏览快照，新增快照链接复制功能

DataFlux 支持为指标查看器创建可快捷访问的数据副本，并统一保存在“快照”目录中；新增生成快照分享链接，支持分享快照链接给空间内其他成员，可快速复现即时拷贝的数据副本信息，将数据恢复到某一时间点和某一数据展示逻辑。
![11.snap.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623916833519-83ad536c-ee14-4cf0-afed-8c7e015c2619.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue1eaf133&margin=%5Bobject%20Object%5D&name=11.snap.png&originHeight=689&originWidth=1102&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94770&status=done&style=stroke&taskId=u23fa8bb4-8d3e-440f-a08d-f7589a45390&title=)
#### 新增容器Pod查看器

DataFlux 在「基础设施」-「容器」新增Pod查看器，通过左上角的筛选可以切换至「Pod」查看采集的全部Pod的详尽信息，包括Pod名称、所属的节点Node、所包含的一个或多个容器、启动状态、运行状态及其相关联的指标等。可通过切换到蜂窝图进行查看。

![9.pod_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623914883066-c9c23fef-c166-411f-b147-845649eda8d1.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udba44ac2&margin=%5Bobject%20Object%5D&name=9.pod_1.png&originHeight=572&originWidth=1148&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53307&status=done&style=stroke&taskId=u8966bcdd-37e2-4cd2-9885-603fce4ea6d&title=)
点击蜂窝图的Pod，可查看该Pod的详情，包括Pod名称、命名空间、可视化监控图表等。
![9.pod_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623914895712-6eb585c9-3fc2-47af-bdb6-f699f5508a90.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6e2e6ed9&margin=%5Bobject%20Object%5D&name=9.pod_2.png&originHeight=861&originWidth=1059&originalType=binary&ratio=1&rotation=0&showTitle=false&size=107364&status=done&style=stroke&taskId=u057d79a8-9e3b-426e-822c-41ed86f9375&title=)

#### 新增免费额度预警通知

新增免费版使用额度预警通知及额度用完通知功能，支持发送邮件和产生系统通知。了解更多消息通知。系统消息通知可在DataFlux工作空间「账号」- 「通知」中查看。

![12.inform.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623916942526-9498aa0e-dd84-4589-85f1-2d393d872932.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0f4798ba&margin=%5Bobject%20Object%5D&name=12.inform.png&originHeight=225&originWidth=1096&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27411&status=done&style=stroke&taskId=u7c7e75ea-7692-4643-8798-c647fd6bb9e&title=)
#### 新增图表分享

DataFlux 支持图表分享，可用于在 DataFlux 以外的平台代码中插入图表进行可视化数据展示和分析，分享的图表会根据 DataFlux 中图表的变化而变化。DataFlux在场景视图分享的图表统一存储在「集成」-「内嵌分享」中。[了解更多图表分享嵌入代码。](https://www.yuque.com/dataflux/doc/fnsiyf)
![2.table_share_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623911666579-3df08ba5-5c06-4afe-afc9-6b21708b4e4c.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue4750c7e&margin=%5Bobject%20Object%5D&name=2.table_share_4.png&originHeight=173&originWidth=1188&originalType=binary&ratio=1&rotation=0&showTitle=false&size=36830&status=done&style=stroke&taskId=u622a13c8-cf64-4ff4-8b9b-4db534b9b33&title=)

#### 优化图表查询和图表样式及设置

调整优化场景视图中的可视化图表查询、样式和设置布局，新增图表标题隐藏、时间分片设置、概览图数据精度设置、排行榜基线设置、地图/蜂窝图色系填充设置等功能。[了解更多可视化图表](https://www.yuque.com/dataflux/doc/rttwsy)。
![6.view_shixu_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623912237223-75f76fe0-fc0f-4e51-85ad-5ec522eaee4d.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u21d5a20a&margin=%5Bobject%20Object%5D&name=6.view_shixu_1.png&originHeight=686&originWidth=1357&originalType=binary&ratio=1&rotation=0&showTitle=false&size=83433&status=done&style=stroke&taskId=u7a7ef0ec-2885-4578-96bf-89b5ba02b1e&title=)
#### 优化集成，新增DataKit和Function安装指导，新增内嵌分享

DataFlux支持在集成中查看所有支持的采集器、DataKit安装指令、DataKit升级命令、Function安装指令，以及内嵌分享的图表代码。

在 DataFlux 工作空间，点击 左侧「集成」菜单，即可查看目前支持的所有采集器，点击采集器即可查看该采集器的配置详情。更多采集器介绍，可参考文档 [采集器](https://www.yuque.com/dataflux/datakit/hostobject) 。
![3.intergrate_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623912334119-e99a9a92-329a-486b-a0ff-4c8a66db5af1.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u31f80b63&margin=%5Bobject%20Object%5D&name=3.intergrate_1.png&originHeight=632&originWidth=1087&originalType=binary&ratio=1&rotation=0&showTitle=false&size=76862&status=done&style=stroke&taskId=ua1c57ace-4cf0-4169-a83f-44bf8edd00f&title=)

在 DataFlux 工作空间，点击 「集成」- 「DataKit」，即可获取 DataKit 安装指令，包括Linux、Windows、MacOS三大操作系统以及离线安装方式。若 DataKit 已经安装但是版本不是最新，可以通过此处的“DataKit升级”获取更新脚本。更多 Datakit 使用介绍，可参考文档 [DataKit 使用入门](https://www.yuque.com/dataflux/datakit/datakit-how-to) 。
![4.intergrate_datakit.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623912644624-e3be5c09-1294-4a91-b1ad-82f2c54b37df.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud03901d3&margin=%5Bobject%20Object%5D&name=4.intergrate_datakit.png&originHeight=594&originWidth=1063&originalType=binary&ratio=1&rotation=0&showTitle=false&size=89997&status=done&style=stroke&taskId=u148e9f2e-e560-417f-a57c-9fa339f60fc&title=)

在 DataFlux 工作空间，点击 「集成」- 「Function」，即可获取 Function 安装指令。更多 Function 使用介绍，可参考文档 [DataFlux Func 快速开始](https://www.yuque.com/dataflux/func/quick-start) 。
![5.intergrate_function.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623913598746-1b60c668-2fe7-4309-a27b-ccf58ccc872f.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0b725756&margin=%5Bobject%20Object%5D&name=5.intergrate_function.png&originHeight=621&originWidth=1022&originalType=binary&ratio=1&rotation=0&showTitle=false&size=132040&status=done&style=stroke&taskId=ua59462d3-08de-418c-bbd2-79b9595ee2c&title=)

#### 优化主机详情页

在「基础设施」-「主机」，点击列表中的主机名称，即可划出详情页查看主机的基本信息、处理器、内存，网络，硬盘等。支持数据单位自动转换、支持基于不同操作系统展示不同主机监控视图。
![7.host.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1623913437079-0c4dc585-7086-4132-bbe5-c26dc5dfa1b6.png#clientId=u891adbb8-4f6b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u5d4976ab&margin=%5Bobject%20Object%5D&name=7.host.png&originHeight=888&originWidth=1104&originalType=binary&ratio=1&rotation=0&showTitle=false&size=115501&status=done&style=stroke&taskId=u10cf54c5-43a4-400f-8100-24595050ce7&title=)

## 2021 年 6 月 3 号
### DataFlux Studio 

#### 新增浏览器日志采集

DataFlux支持通过web浏览器或者javascript客户端主动发送不同等级的[日志数据](https://www.yuque.com/dataflux/datakit/logging)(`对应的source:browser_log`指标类型日志数据)到DataFlux。[了解更多浏览器日志采集](https://www.yuque.com/dataflux/doc/iirxfs)。

#### 新增用户访问监测Session查看器

DataFlux用户访问监测查看器新增查看与Web/小程序/Android/iOS应用相关的的用户访问行为监测数据（会话数据）和会话数据详情。在工作空间内打开「用户访问监测」-「选择任一应用」-「查看器」，可切换到会话查看器（Session）。会话查看器统计整个会话的时长、页面数、操作数、错误数等内容，点击单条会话可查看整个会话下的详情记录。通过对会话数据的查看和分析，可以从多维度了解用户真实访问数据情况，帮助提升应用性能体验。[了解更多用户访问监测查看器分析](https://www.yuque.com/dataflux/doc/dh5lg9)。
![1.session.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622702201026-6edf203d-e53e-4c12-b3c1-ad4941b55813.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u912b5de5&margin=%5Bobject%20Object%5D&name=1.session.png&originHeight=780&originWidth=1158&originalType=binary&ratio=1&rotation=0&showTitle=false&size=104461&status=done&style=stroke&taskId=u733f9121-4b61-41c0-ad18-b88cb5c9b77&title=)

#### 新增浏览器拨测、云拨测异常检测模版及优化自建节点

1. **浏览器拨测**

DataFlux新增浏览器拨测，在 DataFlux「云拨测」，点击「新建」-「Browser拨测」即可新建Browser拨测任务，实时获取Web页面的用户访问体验数据，包括页面加载时间、资源加载时间等。[了解更多浏览器拨测配置](https://www.yuque.com/dataflux/doc/qnfc4a)。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1622539831909-406a1e21-e9fb-4079-b116-2e102e934d8c.png#clientId=ub3a89d5e-f56e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=518&id=oFoQH&margin=%5Bobject%20Object%5D&name=image.png&originHeight=518&originWidth=677&originalType=binary&ratio=1&rotation=0&showTitle=false&size=28497&status=done&style=stroke&taskId=uf99c4c7c-667a-4163-bb96-a847b948f46&title=&width=677)

2. **异常检测模版**

「云拨测数据检测」用于监控工作空间内的云拨测数据，通过对一定时间段内拨测任务产生的指定数据量设置阈值（边界）范围，当数据量到达阈值范围后即可触发告警。同时您可以自定义告警等级，当指定数据量到达不同的阈值范围时，即可出发不同等级的告警事件。[了解更多云拨测异常检测配置](https://www.yuque.com/dataflux/doc/he412g)。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1622690783089-0da17ec8-6317-4e3c-a29a-185a1b435dd7.png#clientId=u06e49ab2-6596-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=438&id=YPp9S&margin=%5Bobject%20Object%5D&name=image.png&originHeight=438&originWidth=796&originalType=binary&ratio=1&rotation=0&showTitle=false&size=29645&status=done&style=stroke&taskId=u83399477-94c2-41a4-9d92-e6faf494052&title=&width=796)

3. **自建节点**

DataFlux云拨测自建节点新增“节点Code”，用于获取节点信息的Code码，在当前空间内节点Code不支持重复。[了解更多自建节点配置](https://www.yuque.com/dataflux/doc/phmtep)。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1622623911783-d3bf678e-903b-44ba-bf62-ca43ef04d09c.png#clientId=u608f56ef-9052-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=309&id=mMLht&margin=%5Bobject%20Object%5D&name=image.png&originHeight=309&originWidth=427&originalType=binary&ratio=1&rotation=0&showTitle=false&size=19364&status=done&style=stroke&taskId=u17a36dac-b206-4607-9429-510d7e49bbe&title=&width=427)
#### 新增注册欢迎页面

DataFlux账号注册登录后提示欢迎页面，可查看DataFlux介绍小视频，扫码可进入DataFlux微信和钉钉服务群。
![3.account_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622703733134-9cacf957-aadb-493e-a252-213384df88d4.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&height=802&id=ue8c1f173&margin=%5Bobject%20Object%5D&name=3.account_3.png&originHeight=1068&originWidth=862&originalType=binary&ratio=1&rotation=0&showTitle=false&size=554615&status=done&style=stroke&taskId=u167013b9-b5dd-4b5c-84bb-7fd2275bc09&title=&width=647)
#### 新增免费版支持DataFlux Func、调整计费项

DataFlux所有版本全面支持DataFlux Func平台自定义函数，DataFlux Func 是一个基于Python 的类ServerLess 的脚本开发、管理及执行平台。关于如何安装及使用，可参考文档 [DataFlux Func 快速开始](https://www.yuque.com/dataflux/func/quick-start) 。

同时为了降低用户使用DataFlux的费用成本，DataFlux调整了应用性能监测和用户访问监测的计费逻辑，调整后应用性能监测统计trace数量，用户访问监测统计每日session数量，更多计费逻辑可参考文档 [按量付费](https://www.yuque.com/dataflux/doc/ateans) 。 

#### 优化生成指标

新增用户性能监测、用户访问监测、安全巡检生成指标，优化日志生成指标。生成指标可以通过数据筛选、数据查询、生成指标三个步骤完成配置，包括配置维度、聚合时间、定义聚合频率、指标集和指标名生成指标。示例如下：

1. 应用性能监测

![6.create_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622707399068-4193980c-5dce-48ac-b88c-fd274a12f4e0.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=DKXeC&margin=%5Bobject%20Object%5D&name=6.create_1.png&originHeight=219&originWidth=1160&originalType=binary&ratio=1&rotation=0&showTitle=false&size=34548&status=done&style=stroke&taskId=u6e078d54-9db4-438a-bcb4-6589dd0501b&title=)

2. 用户访问监测

![6.create_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622707405821-49890917-0107-42f5-9f60-15ec13d27dc4.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=nTJBt&margin=%5Bobject%20Object%5D&name=6.create_2.png&originHeight=210&originWidth=1158&originalType=binary&ratio=1&rotation=0&showTitle=false&size=32320&status=done&style=stroke&taskId=uc05507df-b414-4141-be86-a4f3d7d4d40&title=)

3. 安全巡检

![6.create_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622707412733-0d6e3cae-6436-4a05-91b9-fd6ea6e9ed25.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=mwpWh&margin=%5Bobject%20Object%5D&name=6.create_3.png&originHeight=171&originWidth=1151&originalType=binary&ratio=1&rotation=0&showTitle=false&size=23019&status=done&style=stroke&taskId=ufcd460f1-eb02-45fd-9495-4fc525d3a8b&title=)

#### 优化内置视图，新增克隆功能

内置视图分成“系统视图”和“用户视图”，支持从“系统视图”克隆到“用户视图”，且允许系统视图与用户视图重名。点击系统视图上的 “查看” 跳转到系统视图详情。
![5.view_3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622705257340-786a1a96-1a82-4739-88fc-8346d295cbfb.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc5627e98&margin=%5Bobject%20Object%5D&name=5.view_3.png&originHeight=443&originWidth=1131&originalType=binary&ratio=1&rotation=0&showTitle=false&size=78978&status=done&style=stroke&taskId=u092d6dfe-de3f-4e34-8e30-a59add1f3d6&title=)
点击“克隆”，打开克隆视图弹窗，点击确定后根据当前视图模板创建对应的用户视图。
![5.view_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622704906536-5d32bef7-6fc7-49d9-ad8a-1ff22e81cd21.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u524a0ae7&margin=%5Bobject%20Object%5D&name=5.view_1.png&originHeight=640&originWidth=1145&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139211&status=done&style=stroke&taskId=u210b5023-fdb1-48a4-b409-3158a8ab954&title=)
创建成功后跳转到上面创建的用户视图页面。
![5.view_2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622704912623-bc9b8aee-a1d8-43b1-8b27-1647b2dd59a1.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u797821f6&margin=%5Bobject%20Object%5D&name=5.view_2.png&originHeight=268&originWidth=1120&originalType=binary&ratio=1&rotation=0&showTitle=false&size=99004&status=done&style=stroke&taskId=u3d527485-c7cf-40b0-bab9-3cb932f5eb6&title=)
若用户视图和系统视图重名，且系统视图应用在查看器详情视图，如“基础设施-主机-主机详情”下的主机视图，用户视图会代替系统视图在主机视图展示。
![5.view_4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622705566303-089f7589-b8d1-4161-9ed1-4aa5da0c474e.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc869e203&margin=%5Bobject%20Object%5D&name=5.view_4.png&originHeight=633&originWidth=1080&originalType=binary&ratio=1&rotation=0&showTitle=false&size=74253&status=done&style=none&taskId=uf8691ade-cf23-4bac-92ff-63ccb4519cf&title=)
#### 优化视图变量

DataFlux支持向视图中添加全局变量，当你想要在视图中，动态地完成图表的筛选时，你可以选择使用视图变量来实现。视图变量配置完成后，可通过“高级设置”选择是否需要开启“默认匹配所有”。
![2.vailable_1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622703972403-98c9a2b0-b8ee-4440-a7f1-e60848a11164.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6269404e&margin=%5Bobject%20Object%5D&name=2.vailable_1.png&originHeight=339&originWidth=1144&originalType=binary&ratio=1&rotation=0&showTitle=false&size=42939&status=done&style=stroke&taskId=uf4b606fc-7a76-4378-9e67-5c99f0c59be&title=)

开启后，可通过「*」查看所有主机的综合视图，可手动选择变量筛选查看。[了解更多视图变量配置方法](https://www.yuque.com/dataflux/doc/mgpxkf)。
![12.view_available.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1622704034337-9977aea4-126c-47ba-985c-4c3585b955a5.png#clientId=ud5fda077-f41a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uddcf9f5c&margin=%5Bobject%20Object%5D&name=12.view_available.png&originHeight=736&originWidth=1225&originalType=binary&ratio=1&rotation=0&showTitle=false&size=127158&status=done&style=stroke&taskId=u2eedf6e3-89a8-46e0-8bde-e45754025ef&title=)

#### 优化查看器

- 单列信息显示不全时，鼠标悬停延迟1s 后显示全部提示信息；
- 查看器搜索关键内容时，列表匹配到的内容高亮显示；
- 详情页标签支持复制功能；主机标签支持【查看相关日志】【查看相关容器】【查看相关进程】【查看相关链路】【查看相关巡检】；
- 日志、应用性能监测、用户访问监测、云拨测、安全巡检查看器统计图变更为状态统计；
- 新增开启用户性能监测、用户访问监测、安全巡检帮助链接。

## 2021 年 5 月 20 号
### DataFlux Studio 

#### 新增保存快照

DataFlux快照支持为基础设施、日志、事件、应用性能监测、用户访问监测、云拨测、安全巡检的查看器创建快照，通过快照，你可以快速查看和分析不同时间段、不同标签的数据及其异常情况。[了解更多保存快照](https://www.yuque.com/dataflux/doc/uuy378)。
![1.snapshot_save_name.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497065245-b101be2c-618d-4164-8a88-0c12edb7f151.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ub4756965&margin=%5Bobject%20Object%5D&name=1.snapshot_save_name.png&originHeight=733&originWidth=1220&originalType=binary&ratio=1&rotation=0&showTitle=false&size=132855&status=done&style=stroke&taskId=u69315e0e-8bfe-4983-ba0a-76abdabb376&title=)

#### 新增基础设施主机集成交互

基础设施主机的「集成运行情况」展示了该主机相关的采集器运行情况，运行情况共有两种状态：正常运行状态的集成和发生错误的集成。正常运行状态的集成默认展示为 ‘浅蓝色’，发生错误的集成默认展示为 ‘红色’且支持点击查看错误信息。

同时，通过点击带内置视图符号的集成（如下图），支持“查看监控视图”，点击即可查看相关内置视图。
![2.host.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497073061-717a1159-9f04-4c50-9926-b2b72277b857.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u501dcfd2&margin=%5Bobject%20Object%5D&name=2.host.png&originHeight=575&originWidth=1014&originalType=binary&ratio=1&rotation=0&showTitle=false&size=89538&status=done&style=stroke&taskId=ufe6a5b2e-1baa-4611-813c-82a8e18635e&title=)

#### 新增自建节点、优化云拨测节点展示

「云拨测」支持通过 DataFlux Studio 控制台自定义云拨测数据采集。通过新建探测点，您可以周期性的监控基于HTTP 协议下的网站、域名、后台接口等，随时随地分析站点质量情况。DataFlux 在全球已覆盖16个节点，按照国内、海外、自建节点进行分类选择。同时，支持自建拨测节点，充分保障服务的可用性。
![3.dailtest.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497079866-ed8ef523-0021-4c67-a452-f25d1987452a.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u22050aa4&margin=%5Bobject%20Object%5D&name=3.dailtest.png&originHeight=258&originWidth=1193&originalType=binary&ratio=1&rotation=0&showTitle=false&size=43064&status=done&style=stroke&taskId=uf9a97d7d-00e1-4b1d-bed3-d8701a48115&title=)

#### 新增进程、应用性能监测和用户访问监测检查规则

「进程异常检测」用于监控工作空间内的进程数据，支持对进程数据的一个或多个字段类型设置触发告警。如：你可以基于进程数据中 ‘host’ 字段为 ‘izaqbin’ 并且 ‘state’ 的字段为 ‘sleep’ 出现的次数设置告警。[了解更多进程异常检测](https://www.yuque.com/dataflux/doc/uskqmx)。
![13.changelog_process.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621513591157-64c56f4a-e0cd-4862-8ba8-9d0e8717bb4e.png#clientId=u56c4be89-9344-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u49c73c82&margin=%5Bobject%20Object%5D&name=13.changelog_process.png&originHeight=336&originWidth=769&originalType=binary&ratio=1&rotation=0&showTitle=false&size=35248&status=done&style=stroke&taskId=ue9a3131d-72b9-4d84-9814-15b4bd62655&title=)

「用户访问指标检测」用于监控工作空间内「用户访问监测」的指标数据，通过设置阈值范围，当指标到达阈值后触发告警，支持对单个指标设置告警和自定义告警等级。[了解更多用户访问指标检测](https://www.yuque.com/dataflux/doc/qnpqmm)。
![13.changelog_user.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621513613486-cccdacad-6b74-42c1-91f7-dc8ac3201453.png#clientId=u56c4be89-9344-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u24c050cc&margin=%5Bobject%20Object%5D&name=13.changelog_user.png&originHeight=435&originWidth=736&originalType=binary&ratio=1&rotation=0&showTitle=false&size=40160&status=done&style=stroke&taskId=u9a3f85ae-4ea4-41b2-9839-fcec025e412&title=)

「应用性能指标检测」用于监控工作空间内「应用性能监测」的指标数据，通过设置阈值范围，当指标到达阈值后触发告警，支持对单个指标设置告警和自定义告警等级。[了解更多应用性能指标检测](https://www.yuque.com/dataflux/doc/tag1nx)。
![13.changelog_performance.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621513624061-6c79197c-33dc-4149-90e6-e7931c422c4c.png#clientId=u56c4be89-9344-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u24347f31&margin=%5Bobject%20Object%5D&name=13.changelog_performance.png&originHeight=386&originWidth=735&originalType=binary&ratio=1&rotation=0&showTitle=false&size=34782&status=done&style=stroke&taskId=u5196f668-8d52-4b27-bc96-49b4f296802&title=)

#### 优化集成

登录DataFlux工作空间，进入「集成」页面，即可查看所有支持的采集器。同时可点击右上角的“快速获取 DataKit 安装命令”，直接获取DataKit的安装指令进行安装，安装完成后即可开启更多采集器收集数据指标。[了解更多如何安装DataKit](https://www.yuque.com/dataflux/datakit/datakit-how-to) 。
![7.metric.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497102895-5c8762b2-5d81-47f8-b15c-ee810222c8d9.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1249752c&margin=%5Bobject%20Object%5D&name=7.metric.png&originHeight=774&originWidth=1214&originalType=binary&ratio=1&rotation=0&showTitle=false&size=130338&status=done&style=stroke&taskId=u679cc813-2198-45bf-b533-40dfec30c5f&title=)

#### 优化日志生成指标

日志生成指标新增选择日志来源，可以通过选择日志来源、筛选日志、配置维度、聚合频率、定义指标集、指标名和聚合规则生成指标。[了解更多日志生成指标](https://www.yuque.com/dataflux/doc/mgcvm9) 。
![8.metric_overview.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497109207-fbbb48ec-201d-48ef-8990-986a014d246f.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u296c978b&margin=%5Bobject%20Object%5D&name=8.metric_overview.png&originHeight=210&originWidth=1225&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38765&status=done&style=stroke&taskId=uae28818a-a909-4933-bdfa-3c8249f3322&title=)

#### 优化日志查看器

日志数据采集到的 DataFlux 后，可以在 DataFlux Studio 控制台 「日志」中查看所有的日志来源及其内容，支持通过搜索日志来源选择需要查看的日志详情。
![9.log_all.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497116732-f73052ad-a469-427b-998b-2a9c51e1fcd5.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud1bf32c2&margin=%5Bobject%20Object%5D&name=9.log_all.png&originHeight=544&originWidth=1225&originalType=binary&ratio=1&rotation=0&showTitle=false&size=126388&status=done&style=stroke&taskId=ue2eae9f5-d072-4333-86e7-3423221b438&title=)

#### 优化用户访问监测查看器

在用户访问监测详情页「性能」，可以查看到前端页面性能，包括页面加载时间、内容绘制时间、交互时间、输入延时等。以下图为例，可以看出LCP（最大内容绘制时间）的指标达到了5.43秒，而推荐的时间在2.5秒以内，说明页面速度载入慢，需要进行优化。支持筛选和搜索，帮助用户快速定位资源和内容。
![13.changelog_user1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621579475443-ff78ba63-38d5-417d-99b0-59e8925296b7.png#clientId=u054d2d01-a62d-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf91e9a28&margin=%5Bobject%20Object%5D&name=13.changelog_user1.png&originHeight=785&originWidth=1143&originalType=binary&ratio=1&rotation=0&showTitle=false&size=145021&status=done&style=stroke&taskId=ufe26f0b1-74ba-4d32-8bec-c5d3b40e888&title=)
切换至「链路」时，支持查看向后端应用发出的请求，包括跳用资源的发生时间、内容和持续时间。如：你可以查看通过xhr对象返回的每一个ajax请求。

切换至「错误」时，你可以通过错误发生的详细信息，包括错误信息、错误类型和发生时间快速定位前端错误。[了解更多用户访问监测查看器](https://www.yuque.com/dataflux/doc/dh5lg9)。

#### 优化内置视图

内置视图分成系统视图和用户视图两种类型，可应用在场景。

系统视图为系统提供已集成的视图模版，支持修改，导出和还原。即用户可直接「导出」系统视图，也可「修改」系统视图。通过「还原」系统视图，可将修改后的系统视图转换为原始系统视图。还原后将无法恢复。
![11.view_system.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497132184-85e5aac8-223b-4c3f-8996-89e179f64de1.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u56ed1181&margin=%5Bobject%20Object%5D&name=11.view_system.png&originHeight=576&originWidth=1079&originalType=binary&ratio=1&rotation=0&showTitle=false&size=98307&status=done&style=stroke&taskId=ucd75a8ef-90fb-4169-be50-ae27ae2b349&title=)

用户视图为用户自定义视图后保存作为模版使用的视图，支持修改，导出和删除。在「内置视图」-「用户视图」，通过点击「新建用户视图」，可以创建用户自定义视图模版，具体配置可参考 场景和视图。
![12.view_person.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1621497137534-c1e5deca-3764-4a3e-8d80-94d80905d1dd.png#clientId=u6ae6ed71-bb0c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u41f9ec4f&margin=%5Bobject%20Object%5D&name=12.view_person.png&originHeight=401&originWidth=1069&originalType=binary&ratio=1&rotation=0&showTitle=false&size=174933&status=done&style=stroke&taskId=u1d2b40bb-aba1-4488-9f44-87870634cf1&title=)

#### 优化图表锁定时间优化

看板视图中支持锁定图表的时间范围，不受全局时间组件的限制。设置成功后的图表右上角会出现用户设定的时间，如「xx分钟」、「xx小时」、「xx天」。

#### 优化嵌套函数

所有图表组件的嵌套函数优化成内置函数，不再调用DataFlux Func的函数，通过DQL来实现，删除嵌套函数时间间隔选项。
## 2021 年 5 月 7 号
### DataFlux Studio 
#### 新增日志备份

DataFlux基础日志最多存储60天，如果需要更长时间的存储和查看需要对基础日志进行备份。DataFlux支持备份日志最多存储长达720天。

进入「日志」-[「备份日志」](https://www.yuque.com/dataflux/doc/tgl0i9)页面，默认数据为空，选择时间范围即可查看对应的备份日志，DataFlux 支持通过选择时间范围、搜索关键字，筛选等方式查询和分析日志。点击日志可查看该条日志详情包括日志产生的时间和内容等。

![1.5.7_backup_overveiw.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559530557-84b252c6-8a42-473b-9d15-5f6ce986e6cf.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u99f0b6ba&margin=%5Bobject%20Object%5D&name=1.5.7_backup_overveiw.png&originHeight=579&originWidth=1220&originalType=binary&ratio=1&rotation=0&showTitle=false&size=161544&status=done&style=none&taskId=u36436041-fbff-4a8a-acc9-37d69fe832f&title=)

#### 新增安全巡检

DataFlux 支持你通过「安全巡检」及时监控、查询和关联全部巡检事件。在及时发现漏洞，异常和风险的同时，帮助你提高巡检质量、问题分析和问题处理的能力。

在开始安全巡检之前需要先安装`[DataKit](https://www.yuque.com/dataflux/datakit/datakit-how-to)`及`[security-checker](https://www.yuque.com/dataflux/datakit/sec-checker)`，配置完成后即可进入「安全巡检」并通过选择时间范围、搜索关键字，筛选等方式查询和分析。。

![2.5.7_security_viewer.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559544119-567eec9b-8fd5-448c-8a9e-20ec11a13e92.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1e0ded9e&margin=%5Bobject%20Object%5D&name=2.5.7_security_viewer.png&originHeight=615&originWidth=972&originalType=binary&ratio=1&rotation=0&showTitle=false&size=131645&status=done&style=none&taskId=u88d9ae96-ce38-4a5a-8609-2574815842e&title=)

#### 新增新手指导

第一次注册登陆DataFlux时，可以通过新手引导的方式开启使用DataFlux，根据引导步骤，用户可以自行完成datakit的安装，nginx数据的采集，在日志可查看对应的数据。新手引导关闭后，可通过点击工作空间的用户名称 - 「新手引导」重新打开。

![3.5.7_guide.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559552813-70609e17-12ca-4200-8436-611681a96187.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udb2b46be&margin=%5Bobject%20Object%5D&name=3.5.7_guide.png&originHeight=707&originWidth=1342&originalType=binary&ratio=1&rotation=0&showTitle=false&size=146681&status=done&style=none&taskId=u95ece6ec-5598-45c7-b9e5-354436eed28&title=)

#### 新增柱状图分组堆叠显示

**图表堆叠柱状图**

柱状图支持【指标堆叠】和【分组堆叠】，默认关闭，开启后，默认选中【指标堆叠】。右侧出现“方式”选项，包含默认、百分比。

- 指标堆叠：以指标为维度堆叠对比查看分组的标签数据
- 分组堆叠：以分组的标签为维度堆叠对比查看指标数据

**事件查看器堆叠柱状图**

DataFlux 支持通过柱状图堆叠的方式查看不同时间点发生的、不同状态的事件统计。

![4.5.7_event_filter2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559561798-cd9a44ea-c728-4c7c-a961-0144a024fdb5.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud36a26f2&margin=%5Bobject%20Object%5D&name=4.5.7_event_filter2.png&originHeight=786&originWidth=1221&originalType=binary&ratio=1&rotation=0&showTitle=false&size=177209&status=done&style=none&taskId=u501167be-ee10-43a5-b689-676e5101113&title=)

#### 新增腾讯云、AWS云主机详情

若主机是云主机且配置了「云关联」，点击列表中的主机名称即可划出查看云主机对象的「云厂商信息」，包括云平台、实例名、实例ID、实例规格、地域、可用区、创建时间、网络类型、付费类型、IP地址等。

#### 新增主机运行情况集成

主机集成运行情况共有三种状态：正常运行状态的集成、正常运行且存在内置监控视图的集成以及发生错误的集成：

- 正常运行状态的集成点击无反应
- 内置监控视图的集成点击后下拉“查看监控视图”,点击即可查看对应的监控视图。

![5.5.7_host_detail2.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559578151-7484e4d5-c30b-4de9-a3e2-62edcddddefc.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u600a7e7c&margin=%5Bobject%20Object%5D&name=5.5.7_host_detail2.1.png&originHeight=119&originWidth=1139&originalType=binary&ratio=1&rotation=0&showTitle=false&size=28577&status=done&style=none&taskId=ude5d34c3-4f40-4dc4-a239-ec4cfdf9e76&title=)

- 发生错误的集成点击后可以查看最后一条错误反馈信息。

![6.5.7_host_detail2.2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559584945-85a3c8f5-84d1-44b5-b32b-a75aae851340.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u347a2a30&margin=%5Bobject%20Object%5D&name=6.5.7_host_detail2.2.png&originHeight=119&originWidth=1136&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27917&status=done&style=none&taskId=u67ee9fa9-a932-40bf-bb5c-b3745fd9bc4&title=)

#### 新增关联性分析内置页面

- 基础设施主机新增进程和容器内置页面
- 日志新增进程和链路内置页面
- 链路新增主机监控视图和日志内置页面

#### 优化应用性能监测拓扑图

在「应用性能监测」的[「服务」](https://www.yuque.com/dataflux/doc/te4k3x)列表中，可切换列表至拓扑图模式查看各个服务之间的调用关系。

- 新增按照时间轴选取时间范围
- 新增拓扑图放大缩小，放大状态可在左下角查看小缩略图
- 新增三种节点大小尺寸
- 新增选择服务后对应服务高亮显示，其他服务及连接线变灰

![7.5.7_trace.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559592305-b78d2c16-ef03-4e19-8d68-11b592a496db.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8f2bc54d&margin=%5Bobject%20Object%5D&name=7.5.7_trace.png&originHeight=789&originWidth=1224&originalType=binary&ratio=1&rotation=0&showTitle=false&size=136799&status=done&style=none&taskId=u4ab6e54c-4ccf-4b78-8af7-c269585f289&title=)

#### 优化操作事件和通知事件

- 操作事件移至「管理」-「基本设置」-「安全审计」，点击“查看”即可看到操作安全事件。
- 通知事件移至左侧菜单「通知」，点击“通知”即可查看所有的通知事件。

#### 优化付费计划与账单使用统计视图

- 付费计划与账单使用统计视图新增日志备份统计

## 2021 年 4 月 15 号

### DataFlux Studio

#### 启用新的 DataFlux Logo

采用机器人大脑的方式，不仅具有强烈的科技感官，突出 DataFlux 海量数据集成、处理、分析的强大能力，像机器人一样能实时、快速、无限扩展，为数据分析、业务运营分析等提供易于使用、灵活多样的可视化图表，提升运营效率。

![datafluxlogo1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559619065-4c9ce224-08dd-40ae-bb9e-4dd8c9a6c644.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc0a25984&margin=%5Bobject%20Object%5D&name=datafluxlogo1.png&originHeight=236&originWidth=237&originalType=binary&ratio=1&rotation=0&showTitle=false&size=32908&status=done&style=none&taskId=u01bfc1b1-123c-4f7e-8916-f72c9ada497&title=)

#### 新增云拨测

DataFlux 为用户提供开箱即用的云测解决方案，支持 HTTP 协议拨测，利用覆盖全球的监控网络，端到端的跟踪网页和应用性能等，记录所有拨测的实时反馈信息，提供DNS、SSL、TTFB等性能测试结果，帮助你提前发现问题，定位问题，提升用户体验。

![cloudtest_viewer.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559636485-08272d3b-421a-4ee8-ab5a-f9b690a4fc8b.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1aabb467&margin=%5Bobject%20Object%5D&name=cloudtest_viewer.png&originHeight=788&originWidth=1201&originalType=binary&ratio=1&rotation=0&showTitle=false&size=197253&status=done&style=none&taskId=u735f8cc5-f2c0-4f73-894b-1a2aea97266&title=)

DataFlux 云拨测支持从地理和趋势两个维度分析当前拨测任务的响应时间和可用率情况。更多详情参考文档 [云拨测分析](https://www.yuque.com/dataflux/doc/tglyg8) 。

![cloudtest_detail.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559646963-6c4f1690-133e-4a2b-99ad-77ab21ffdf4b.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ubc8663a5&margin=%5Bobject%20Object%5D&name=cloudtest_detail.png&originHeight=910&originWidth=1207&originalType=binary&ratio=1&rotation=0&showTitle=false&size=149795&status=done&style=none&taskId=ucfb71f7c-6602-43ea-ac9c-0e331494bac&title=)

#### 新增容器对象分布图

[容器对象](https://www.yuque.com/dataflux/doc/gy7lei) 新增蜂窝分布图。在容器列表页面，通过点击列表左侧的图标，即可切换到容器分布图显示。通过分布图，你能够可视化查询容器分布信息。分布图支持以下功能:

- 搜索：输入搜索关键词
- 筛选：筛选标签并选择过滤对象，可多选
- 分组：分组展示对象，可多选
- 填充：选择填充的指标，指标值的大小将决定填充的图例颜色。
- 填充规则：根据填充指标的结果填充图例颜色。将指标的最大和最小值五等分，得到5个区间，分别对应五个颜色。

![container_fengwotu.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559661237-3fd7181b-cc4a-4380-be4f-192ebc743d8d.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf2c6d2b7&margin=%5Bobject%20Object%5D&name=container_fengwotu.png&originHeight=784&originWidth=1220&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90155&status=done&style=none&taskId=u31b5c516-f45c-49bf-98f8-ea7e16889dc&title=)

#### 新增阿里云云主机详情

若主机是云主机且配置了 「云关联」，点击列表中的主机名称即可划出查看云主机对象的「云厂商信息」，包括云平台、实例名、实例ID、实例规格、地域、可用区、创建时间、网络类型、付费类型、IP地址等。

![host_detail3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559681235-27d6ef75-e649-4466-b51a-d85ddad1a099.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud3329b8a&margin=%5Bobject%20Object%5D&name=host_detail3.png&originHeight=787&originWidth=1428&originalType=binary&ratio=1&rotation=0&showTitle=false&size=167801&status=done&style=none&taskId=ue7419a77-4289-46da-baf5-b07c314fbc7&title=)

#### 新增表格图指标排序

表格图支持指标排序，默认按第一个查询的指标排序，点击表头切换升降序，对应查询中的 Top/Bottom 同步调整，点击其他查询的指标进行排序，对应查询中的 Top/Bottom 同步调整。

![ksh_biaoge7.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559696959-b6597630-7b29-4c9a-94c4-c3739fe3cabe.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ucfac4686&margin=%5Bobject%20Object%5D&name=ksh_biaoge7.png&originHeight=952&originWidth=1340&originalType=binary&ratio=1&rotation=0&showTitle=false&size=90896&status=done&style=none&taskId=uaffbe01c-7e3d-4837-9a45-73015296943&title=)

#### 新增链路快速筛选项「持续时间」

- 默认进度条最小值、最大值为 [链路](https://www.yuque.com/dataflux/doc/qp1efz) 数据列表里最小和最大的持续时间
- 支持拖动进度条调整最大/最小值，输入框中的值同步变化
- 支持手动输入最大/最小值，"按回车键"或"点击输入框外"进行过滤搜索
- 输入不规范时输入框变红，不进行搜索，正确格式：纯“数字”或“数字+ns/μs/ms/s/min”
- 若没有输入单位进行搜索，默认直接在输入的数字后面填入"s"然后进行过滤搜索
- 若手动输入单位，则直接进行搜索

![service3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559712498-7afe06a7-b4ee-42d9-8133-75bc6742ec27.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9575f78e&margin=%5Bobject%20Object%5D&name=service3.png&originHeight=787&originWidth=1407&originalType=binary&ratio=1&rotation=0&showTitle=false&size=213774&status=done&style=none&taskId=u27b7b29a-0467-47f4-8627-4d7be4c2ce4&title=)

#### 新增邮件组

在 [通知对象](https://www.yuque.com/dataflux/doc/osstog) 管理新增邮件组通知对象，邮件组可同时添加多个成员，添加完成后在异常检测库的“告警设置”选择该邮件组，告警邮件即可同时发送到添加的成员邮箱。

#### 优化异常检测库

DataFlux 内置多种检测库，开箱即用。支持主机等多种内置检测库，开启后，即可接收到相关的异常事件告警。详情可参考文档 [内置检测库](https://www.yuque.com/dataflux/doc/br0rm2) 。

![internal_input.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559733036-29cfc4f0-8d16-4e6f-8741-5e9df28b5f65.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u69b68264&margin=%5Bobject%20Object%5D&name=internal_input.png&originHeight=609&originWidth=1231&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116199&status=done&style=none&taskId=u8836c69c-2ea1-426e-9875-f2ea79f335f&title=)

在「检测库」中支持「导入/导出检测库」，配置完所有的检测规则后，可以通过 json 文件的方式导出检测库，导出的检测库可以导入其他的检测库，导入检测库时会验证是否存在重名检测项，可进行「替换」或「跳过」。

#### 优化对象查看器和详情

- 主机对象新增操作系统小图标显示
- 容器对象新增容器类型小图标显示
- 进程侧滑详情页新增显示「启动时间」

#### 优化数据存储策略、付费计划和账单

- 工作空间管理的基本信息增加变更数据存储策略
- 工作空间管理的使用统计优化为付费计划和账单

## 2021 年 4 月 7 号

### DataFlux Studio

#### 新增视图变量对象映射

使用「对象映射」时，必须先定义一个基于对象类字段的视图变量，在「视图变量」中配置完对象映射以后，需要在「图表查询」中以映射的标签字段作为分组，在「图表设置」中开启「字段映射」，然后就可以在视图图表中查看设置的对象映射显示。具体设置的步骤可参考帮助文档 [视图变量](https://www.yuque.com/dataflux/doc/mgpxkf) 。

![variable9.6.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559749599-b76f9138-464a-4ae9-9003-5ae0a1b72aed.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3d7ff7f3&margin=%5Bobject%20Object%5D&name=variable9.6.png&originHeight=559&originWidth=1224&originalType=binary&ratio=1&rotation=0&showTitle=false&size=64273&status=done&style=none&taskId=u39f3b6eb-9167-488a-b86d-99ad79d4f49&title=)

#### 优化事件分组

DataFlux 支持「异常事件」按照「检测项」分组聚合相关事件，点击查看「聚合事件」，可以快速查看关联事件列表、不同主机的异常事件状态分布和指标监控等。异常事件状态分布包括 `critial` 、 `error` 、 `warning` 、 `ok` 和 `静默` ，对应五种状态颜色，底色为绿色，按照事件发生的时间点向后填充对应状态颜色，填充范围即检测频率，当分组中存在`host`，且设置了主机静默，静默时间范围显示为灰色。更多可参考文档 [事件分析](https://www.yuque.com/dataflux/doc/vzall6) 和 [告警设置](https://www.yuque.com/dataflux/doc/qxz5xz) 。

![event_group1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559764779-dbfa9f44-57d9-4718-9ccc-843904679922.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc9029304&margin=%5Bobject%20Object%5D&name=event_group1.png&originHeight=735&originWidth=1147&originalType=binary&ratio=1&rotation=0&showTitle=false&size=89139&status=done&style=none&taskId=ucc176055-da81-4f56-adf6-7d648d2d582&title=)

#### 优化检测项查询

「异常检测库」中「检测规则」的「检测指标」只允许添加一条查询，默认添加「简单查询」，支持「简单查询」和「表达式查询」来回切换；统一将「检测规则」的「触发条件」`M1`修改为`Result`；支持为查询添加`AS`别名。更多可参考文档 [检测规则管理](https://www.yuque.com/dataflux/doc/hd5ior) 。

![event_check.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559774262-c7bbc442-a552-4288-9a58-7bec63287ed3.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ueabb1eb7&margin=%5Bobject%20Object%5D&name=event_check.png&originHeight=775&originWidth=1225&originalType=binary&ratio=1&rotation=0&showTitle=false&size=94836&status=done&style=none&taskId=ub7c55907-50a3-4af7-8be7-f83e111fac2&title=)

### DataKit（v1.1.4-rc2）

- 修复阿里云监控数据采集器（aliyuncms）频繁采集导致部分其它采集器卡死的问题。

## 2021 年 3 月 25 号

### DataFlux Studio

#### 新增云服务关联

DataFlux 支持通过通过「云关联」统一集中管理云服务账号的 AccessKey 信息，配置完成以后可在 [基础设施-主机](https://www.yuque.com/dataflux/doc/mwqbgr) 定期同步所属云账号下的云主机信息，展示所有云主机信息，如CPU、内存、网络、磁盘等。

![cloud_connect.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559790122-376080c1-d55f-4b77-ac0e-490e0e98b047.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u8ab9265c&margin=%5Bobject%20Object%5D&name=cloud_connect.png&originHeight=787&originWidth=1432&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75157&status=done&style=none&taskId=uc118edae-b863-4718-b0e4-73a520f10a8&title=)

若不再需要关联，可删除已关联的阿里云 RAM 子账号 AK 信息。关联信息删除后，会触发关联失效通知事件，可在 事件-通知事件 中查看。更多云关联的说明可参考文档 云关联 。

![cloud_invalid.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559800552-e26e56d2-9526-4e94-a483-a67b31ad12ee.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u69276b46&margin=%5Bobject%20Object%5D&name=cloud_invalid.png&originHeight=786&originWidth=1431&originalType=binary&ratio=1&rotation=0&showTitle=false&size=98130&status=done&style=none&taskId=u4eb403d0-fa13-42e5-94b5-277d1f647ac&title=)

#### 新增操作事件审计

DataFlux 支持对工作空间的操作事件进行安全审计，操作事件统一存储在「事件」-「操作事件」中。

![operation-detail1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559920706-10e0e4e8-7ac2-4d6a-aa03-1aeddd483edf.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud14567a7&margin=%5Bobject%20Object%5D&name=operation-detail1.png&originHeight=408&originWidth=838&originalType=binary&ratio=1&rotation=0&showTitle=false&size=58868&status=done&style=none&taskId=udd3227a9-2691-49f6-ad9e-33f4690dfd0&title=)

#### 新增主机静默

若需要对单个云主机进行如压测等操作，会触发频繁的告警，对于这种告警通知，可临时开启主机静默功能。在「基础设施」-「主机」，点击云主机详情即可选择主机静默时间。

![cloud_silent.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559937578-10ad8f2a-1b66-4417-ba8c-4eded1dd006c.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uef88bb71&margin=%5Bobject%20Object%5D&name=cloud_silent.png&originHeight=785&originWidth=1431&originalType=binary&ratio=1&rotation=0&showTitle=false&size=156099&status=done&style=none&taskId=u7a96cd6a-bddd-4b5b-a66b-51062defd6b&title=)

所有静默的主机列表可在「异常检测库」-「主机静默管理」中查看。删除静默的主机后，可以重新接收到对应主机的告警通知。更多详情可参考文档 [告警设置](https://www.yuque.com/dataflux/doc/qxz5xz) 。

![cloud_allsilent.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559955299-60373b49-6061-400f-a86f-469d64fc70f4.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9efe6d78&margin=%5Bobject%20Object%5D&name=cloud_allsilent.png&originHeight=492&originWidth=1430&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71499&status=done&style=none&taskId=u3f4ff6a2-2b4f-4cf8-a03e-d493f7eea7b&title=)

#### 新增通知对象：企业微信机器人

DataFlux支持用户管理发送告警的通知对象，目前支持添加邮件、钉钉机器人、企业微信机器人和Webhook自定义。更多配置详情参考文档 [通知对象管理](https://www.yuque.com/dataflux/doc/osstog) 。

#### 优化事件查看器，新增事件分组聚合查看

在事件列表查看器，通过分组功能，DataFlux支持快速依据分组标签聚合和统计相关事件。例如，在「异常事件」中，基于"检测项“分组，你可以快速获取基于该检测项触发的全部事件。通过切换聚合事件列表，你可以查看这些事件的详情。更多事件优化详情可查看文档 [事件分析](https://www.yuque.com/dataflux/doc/vzall6) 。

![exception-detail1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559969764-fb07d308-f459-46be-9af0-488ede16dbd8.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u55f5f659&margin=%5Bobject%20Object%5D&name=exception-detail1.png&originHeight=685&originWidth=1001&originalType=binary&ratio=1&rotation=0&showTitle=false&size=182937&status=done&style=none&taskId=ub3ee1119-8af1-42d6-b644-b07197800f9&title=)

#### 优化链路服务筛选及拓扑图

在「应用性能监测」的「服务」列表中，支持切换列表至拓扑图模式查看各个服务之间的调用关系。支持通过不同的性能指标进行筛选显示，并可自定义链路服务性能指标颜色区间。更多链路服务详情可查看文档 [链路服务](https://www.yuque.com/dataflux/doc/te4k3x) 。

![service_chart3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620559984618-04340ad4-1a30-4192-ae4a-dda3cd67af51.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uf828dd31&margin=%5Bobject%20Object%5D&name=service_chart3.png&originHeight=789&originWidth=1425&originalType=binary&ratio=1&rotation=0&showTitle=false&size=163223&status=done&style=none&taskId=u73f1b385-1b62-44a5-8db0-648ca1da930&title=)

#### 其他优化功能

-  优化日志、事件、基础设施、应用性能监测、用户访问检测查看器搜索和导出，新增导出到视图。优化日志、事件、链路、基础设施-容器、基础设施-进程详情页标签筛选、关联查询分析。 
-  优化时间组件，优化场景视图下单查询图表（概览图、仪表盘、排行榜）简单查询和表达式查询互相切换 
-  优化主机 offline 显示：当主机 offline 状态时，cpu使用率、mem使用率、负载均不作显示，值填充为“ - ” 
-  优化异常检测库检测规则，新增水位检测、区间检测和突变检测。 

### DataKit（v1.1.4-rc1）

- 进程采集器 message 字段增加更多信息，便于全文搜索
- 主机对象采集器支持自定义 tag，便于云属性同步

### DataKit（v1.1.4-rc0）

- 增加文件采集器、拨测采集器以及HTTP报文采集器
- 内置支持 ActiveMQ/Kafka/RabbitMQ/gin（Gin HTTP访问日志）/Zap（第三方日志框架）日志切割
- 丰富 [http://localhost:9529/stats](http://localhost:9529/stats) 页面统计信息，增加诸如采集频率（n/min），每次采集的数据量大小等
- DataKit 本身增加一定的缓存空间（重启即失效），避免偶然的网络原因导致数据丢失
- 改进 Pipeline 日期转换函数，提升准确性。另外增加了更多 Pipeline 函数（parse_duration()/parse_date()）
- trace 数据增加更多业务字段（project/env/version/http_method/http_status_code）
- 其它采集器各种细节改进

## 2021 年 3 月 4 号

### DataFlux Studio

#### 1. 优化时序图、柱状图、排行榜、日志流图、告警统计图、对象列表图

- 时序图：新增「显示密度」，包括「较低：60个点」、「低：180个点」、「中：360个点」、「高：720个点」。新增「堆叠显示」，仅支持柱状图，默认关闭
- 排行榜：图表显示优化
- 柱状图：图表显示优化
- 日志流图：增加搜索框，支持对message内容进行搜索
- 告警统计图：查询显示优化
- 对象列表图：查询显示优化

#### 2. 新增自动转换单位

- 默认查询结果值自动转换单位展示遵循「科学计数 K、M、B」，保留两位小数点（1千 = 1K，100万 = 1M，10亿 = 1B）
- 人民币自动转换单位「元、万、亿」，保留两位小数点
- 设置单位后，取消科学计数，按用户设置的单位显示

#### 3. 新增对象管理

DataFlux支持用户管理发送告警的通知对象，目前支持添加钉钉机器人通知配置和Webhook自定义通知配置两种方式。

![inform.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560009557-d2a26ff2-f15b-4f2c-9a08-df477d193184.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud83d3ebe&margin=%5Bobject%20Object%5D&name=inform.png&originHeight=785&originWidth=1434&originalType=binary&ratio=1&rotation=0&showTitle=false&size=82148&status=done&style=none&taskId=u386d64f3-ee77-4160-93ec-6056becb3a0&title=)

#### 4. 调整事件、日志、链路追踪、应用监测、对象主机、对象容器、对象进程、对象其他查看器，支持导出CSV文档，最大支持导出最近5000条数据。

- 事件

DataFlux 支持采集基于「异常检测库」所产生的所有事件数据。用户可在「事件」页面查看和搜索工作空间内所有的事件数据。

![changelog2.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560024826-b36b7419-adef-4ad2-9f1b-104806012162.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u68e92cba&margin=%5Bobject%20Object%5D&name=changelog2.png&originHeight=785&originWidth=1427&originalType=binary&ratio=1&rotation=0&showTitle=false&size=179412&status=done&style=none&taskId=u4e7f5d62-42af-4a82-8811-516cf7bfee9&title=)

- 对象主机

DataFlux 支持采集对象主机数据。在「对象」的主机列表，可以查看和搜索所有的主机对象数据信息。

![changelog3.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560039201-5a0f13ef-0d95-45d9-acc2-00a6f5d85603.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ufb9c37d2&margin=%5Bobject%20Object%5D&name=changelog3.png&originHeight=788&originWidth=1430&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116661&status=done&style=none&taskId=ud854b433-810e-48f3-b98c-8214039c302&title=)

点击列表中的主机名称即可划出详情页查看主机对象的详细信息，包括基本信息，CPU，内存，网络，硬盘等。

![changelog3.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560051275-8d9df2f6-c57a-4339-a22b-ca5716f14e2d.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uca16b1cc&margin=%5Bobject%20Object%5D&name=changelog3.1.png&originHeight=785&originWidth=1432&originalType=binary&ratio=1&rotation=0&showTitle=false&size=128780&status=done&style=none&taskId=u4b53e014-ba9e-4328-bf59-873f547efce&title=)

- 对象容器

DataFlux 支持采集对象容器数据。在「对象」的容器列表，可以查看和搜索所有的容器对象数据信息。点击列表中的容器名称即可划出详情页查看容器对象的详细信息。

![changelog4.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560062402-3aa7b226-41be-4e7b-bc03-3a43d62689e7.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u583311fc&margin=%5Bobject%20Object%5D&name=changelog4.png&originHeight=786&originWidth=1421&originalType=binary&ratio=1&rotation=0&showTitle=false&size=191408&status=done&style=none&taskId=ua83bc2ff-5a6f-4afb-ac50-d284c4a2766&title=)

- 对象进程

DataFlux 支持采集对象进程数据。在「对象」的进程列表，可以查看和搜索所有的进程对象数据信息。点击列表中的进程名称即可划出详情页查看进程对象的详细信息。

![changelog5.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560071133-801b5d01-c543-4fa0-93be-17703d87146d.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ue47653aa&margin=%5Bobject%20Object%5D&name=changelog5.png&originHeight=787&originWidth=1424&originalType=binary&ratio=1&rotation=0&showTitle=false&size=213333&status=done&style=none&taskId=uf8c2dce8-285b-4328-9e1d-f363427a269&title=)

- 对象其他

DataFlux 支持采集对象其他数据，如阿里云ECS等。在「对象」的其他列表，可以查看和搜索所有的其他对象数据信息。点击列表中的其他对象名称即可划出详情页查看其他对象的详细信息。

![changelog6.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560078340-0ebbc941-176f-4efb-bc92-82a5074f4364.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u53331961&margin=%5Bobject%20Object%5D&name=changelog6.png&originHeight=786&originWidth=1431&originalType=binary&ratio=1&rotation=0&showTitle=false&size=197463&status=done&style=none&taskId=u5a01c1ba-59e5-42aa-98f5-ecfeb9fdff3&title=)

- 日志

DataFlux 支持采集各种格式的日志数据，包括系统日志、Niginx 日志、Apache 日志在内的多种日志数据，可快速查看和分析当前工作空间所有日志数据。

![changelog7.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560086095-17594ef9-428f-4945-ae65-374b15af9ec5.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=udbca3166&margin=%5Bobject%20Object%5D&name=changelog7.png&originHeight=788&originWidth=1428&originalType=binary&ratio=1&rotation=0&showTitle=false&size=219804&status=done&style=none&taskId=u25d9151b-90c4-4dc7-87b9-4a757793708&title=)

- 链路追踪

DataFlux 支持在「链路追踪」查看链路服务和链路列表，在服务列表中，可以查看或搜索全部接受链路数据的服务。在链路列表中，可以查询链路数据，导出链路数据，查看链路详情并通过火焰图、span列表等对链路性能进行全量分析。

DataFlux 支持同时支持浅色和深色的主题显示，这里以深色为例。

**服务列表**

![changelog12.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560137033-761010c8-ab02-4278-a6d0-8685643631b5.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=uc046de5e&margin=%5Bobject%20Object%5D&name=changelog12.png&originHeight=780&originWidth=1422&originalType=binary&ratio=1&rotation=0&showTitle=false&size=184440&status=done&style=none&taskId=u796012b4-1d89-4e8f-971b-ad4395a2b10&title=)

**链路拓扑**

![changelog14.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560152828-37d7c1f1-7b8b-460a-a458-54b35f7c214c.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3c3c7df7&margin=%5Bobject%20Object%5D&name=changelog14.png&originHeight=786&originWidth=1424&originalType=binary&ratio=1&rotation=0&showTitle=false&size=145606&status=done&style=none&taskId=ue5e764f3-5fd5-4938-8e0c-a0c9309c66e&title=)

**链路列表**

![changelog13.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560159799-7c9dec1a-9171-4918-bb43-39e5fd2e17a1.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u9c778406&margin=%5Bobject%20Object%5D&name=changelog13.png&originHeight=792&originWidth=1428&originalType=binary&ratio=1&rotation=0&showTitle=false&size=215713&status=done&style=none&taskId=u0289e262-c6c4-4d47-a0a8-bc7557e633e&title=)

**火焰图**

![changelog11.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560173365-7b50a055-4e37-4306-b43e-593ef1560ee7.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud92992e6&margin=%5Bobject%20Object%5D&name=changelog11.png&originHeight=790&originWidth=1428&originalType=binary&ratio=1&rotation=0&showTitle=false&size=186839&status=done&style=none&taskId=u1d5fbc9f-3fc7-49f8-814d-10d055770cc&title=)

- 应用监测

DataFlux 支持采集Web、Android、iOS和小程序应用数据，并提供了应用监控场景，可快速查看和分析应用状况。以Web应用为例：

**Web应用查看器**

![changelog1.1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560187577-7f7705cc-a3dc-4711-9b20-4f6c272b0db2.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0c9695ef&margin=%5Bobject%20Object%5D&name=changelog1.1.png&originHeight=783&originWidth=1424&originalType=binary&ratio=1&rotation=0&showTitle=false&size=218990&status=done&style=none&taskId=ub37b587e-7f34-46de-8405-b39fda76a81&title=)

**Web应用详情**

![changelog1.png](https://cdn.nlark.com/yuque/0/2021/png/21511848/1620560195153-14d922b2-c945-42de-9d2b-4aeabd534c1c.png#clientId=u0e92d8b2-9f49-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ua5b702a4&margin=%5Bobject%20Object%5D&name=changelog1.png&originHeight=787&originWidth=1431&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134035&status=done&style=none&taskId=u2c37f089-5270-45ff-8e1d-2d74dc8b5f2&title=)

## 2021 年 2 月 2 号

### DataFlux Studio

-  新增时序图样式面积图 
-  新增对象主机、容器、进程，新增主机蜂窝图 
-  优化异常检测，新增内置检测库 
-  优化事件、对象、日志、链路、应用查看器及页面功能 
-  优化日志流图图表查询 
-  优化排行榜、仪表盘、概览图图表查询，新增表达式查询模式。 
-  优化可视化图表查询，简单查询和DQL查询支持互相切换 
-  优化分组逻辑，包括散点图、气泡图、地图、蜂窝图、表格图 
-  优化筛选条件支持实时过滤 

### DataKit

-  新增主机对象数据采集 
-  新增容器对象数据采集 
-  新增进程对象数据采集 

## 2021 年 1 月 14 号

### DataFlux Studio

-  新增Explorer布局，优化数据结构，支持对象/链路/RUM/日志等模块查询/分析 
-  新增小程序应用监测 
-  新增时序图，图表类型可以选择折线图或柱状图 
-  调整图表UI 
-  调整日志流图图表查询和设置 
-  优化柱状图、排行榜、表格图相关设置 
-  阈值检测调整为DQL的UI查询模式 

## 2020 年 12 月 29 号

### DataFlux Studio

-  新增内置视图 
-  新增图表类型：图片 
-  新增柱状图支持堆叠图和百分比堆叠图 
-  新增转换单位：流量、带宽、时间戳 
-  优化数据网关页面，新增选择开启主机监控 
-  优化DQL查询、DQL函数、DQL命令行客户端 
-  优化图表查询方式，支持普通查询、表达式查询、DQL查询 
-  优化视图变量管理方式，支持DQL查询 
-  优化预览/编辑视图，添加图表交互 
-  优化场景创建，支持基于视图模版进行创建 
-  优化对象监控视图，支持绑定视图 
-  关系图支持保存为图表，并优化绘制交互 
-  优化节点树的点击交互 

### DataKit

-  新增微信小程序应用监测数据采集 
-  新增默认开通主机监控配置文件 

## 2020 年 12 月 15 号

### DataFlux Studio

-  新增 RUM 应用监测模块，支持 Web、IOS、Android 应用监测 
-  新增 DQL 查询，支持远程 CLI 
-  新增组合图图表，最多支持5个图表组合 
-  新增排行榜图表，支持柱状图和表格图两种图表类型展现方式 
-  新增图表链接，支持折线图、饼图、柱状图、表格图从当前页面跳转至目标页面 
-  新增图表标题描述 
-  新增地图图表指标 Top5 排行榜及正/倒序排列 
-  优化散点图，增加气泡图，支持用散点大小来表示数据大小 

### DataKit

- 新增 Web、IOS、Android 应用监测数据采集

## 2020 年 11 月 26 号

### DataFlux Studio

-  调整计费模式为按量付费 
-  新增使用统计模块，用于查看版本信息及收费项目的使用情况 
-  新增添加对象功能，支持自定义对象的属性和标签 
-  对象新增关系图功能 
-  日志、事件、链路新增快捷筛选，支持用户自定义标签 
-  官网新增计费相关落地页 

### DataKit

- 新增阿里云、腾讯云、华为云、Docker 容器对象采集

## 2020 年 11 月 5 号

### DataFlux Studio

-  时间组件新增相对时间的选择，和数据刷新时间的调整 
-  支持针对不同视图设置不同的时间范围 
-  对象、链路新增标签筛选功能，可对数据进行过滤 
-  新增 2 个图表类型：对象列表图、告警统计图 
-  日志流图表新增单位设置和添加显示列功能 
-  新增指标查询复制功能 
-  异常检测新增日志检测 
-  优化事件页面的数据加载速度 
-  优化若干交互及前端界面，提升用户体验 

## 2020 年 10 月 15 号

### DataFlux Studio

-  优化了日志、事件、对象的详情页面，可以更清晰直观的查看详细信息 
-  视图变量新增搜索功能 
-  新增图表复制功能，支持复制图表，并粘贴至任意场景 
-  调整了对象的数据结构 
-  修复若干样式问题，提高了图表的加载速度 

### DataKit

-  优化CSV/Excel 指标采集 
-  新增华为云云监控指标、TIDB指标采集 

## 2020 年 9 月 22 号

### DataFlux Studio

- 新增「深色模式」主题

## 2020 年 9 月 17 号

### DataFlux Studio

-  对象新增监控视图功能，可用于IT基础设施等监控 
-  新增对象类型的视图变量 

## 2020 年 9 月 8 号

### DataFlux Studio

-  新增指标搜索功能 
-  新增面包屑功能 
-  优化若干交互及前端界面，提升用户体验 
-  修复已发现的 bug 

## 2020 年 8 月 20 号

### DataFlux Studio

-  优化场景创建流程，调整节点树的展示效果 
-  优化新建节点的流程及页面UI 
-  视图模板新增采集源配置功能，支持导入模板文件自动生成采集源配置。 
-  新增 1 个图表类：蜂窝图 
-  修复已发现的 bug 

## 2020 年 8 月 6 号

### DataFlux Studio

-  「链路追踪」新增服务拓扑图功能，用来展示服务间的调用关系 
-  「日志」「对象」和「链路」新增列表设置功能，支持自定义显示列以及列名；新增显示设置功能，支持隐藏“筛选栏”和“统计图” 
-  新增工单功能，可基于使用中遇到的问题提交工单进行提问和建议 

### DataKit

- 新增 15 个数据源：ASP .NET、.NET CLR、Druid、Envoy、Ansible、Kibana、Microsoft Exchange Server、ModBus、MQTT Consumer、Nfsstat、Puppet Agent、systemd_utils、Kong 监控指标、微信小程序运营指标以及 AWS CloudWatch 日志及事件采集

## 2020 年 7 月 16 号

### DataFlux Studio

-  调整左侧导航菜单栏，新增日志、链路追踪、对象功能模块 
-  新增日志的采集和管理功能，支持基于日志数据进行“提取标签”和“生成指标”数据 
-  新增链路追踪功能，用于链路数据的分析管理，适用于应用性能（APM）的监控 
-  新增对象的采集和分析功能，支持手动添加对象 
-  「关键事件」更名为「事件」，重构了业务逻辑，并对显示界面进行了调整，支持聚合相关事件；支持显示事件触发的相关指标折线图；支持在分析模式下基于图表新建事件 
-  场景新增 4 类视图分类，分别为「日志视图」「事件视图」「链路视图」和「对象视图」，支持将日志、事件、链路、对象保存到对应的视图进行查询分析 
-  新增标签的关联分析功能。支持针对标签查询相关指标、日志、对象、事件和链路 
-  「指标浏览」更名为「指标」，新增平铺模式，支持同时查看多个指标折线图 
-  「触发器」更名为「异常检测」，调整“基本检测”为“阈值检测”，“高级检测”为“自定义检测函数”，并新增事件检测、突变检测、区间检测、水位检测 4 种异常检测类型 
-  删除「触发历史」模块，告警历史数据将直接保存至「事件」中 
-  新增一个图表类型：日志流图，支持向视图中添加日志数据表 
-  指标查询 UI 模式下，新增 influxdb 自带的转换函数 
-  新增 5 个视图模板：etcd 监控视图、CoreDNS 监控视图、 Traefik 监控视图、Hadoop 监控视图、RaspberryPi（树莓派）监控视图 
-  其他优化调整 
-  优化导航菜单收起/展开样式 
-  集成页面新增是否已验证标示，包含「已验证」和「Bate」两种状态 
-  优化衍生节点的排序方式，默认按照节点名称首字母升序展示 
-  优化若干界面的 UI 设计，新增视图图表 hover 显示效果 
-  SaaS 版用户注册新增企业/团队信息 

### DataFlux Admin Console

-  调整 DataWay 网关使用逻辑，DataWay 安装移至管理后台，所有空间成员均可使用 
-  支持设置不同类型的数据保留时长 

### DataKit

-  DataKit 新增 15 个数据源：Containerd 、GitLab、Yarn、Harbor、Tailf、Rsyslog 、Jira 、AWS CloudWatch Log、、RaspberryPi（树莓派）、Go 运行时指标、Neo4j 监控指标、目录监控指标、阿里云安全指标、百度指数以及主机对象数据采集 
-  DataKit 支持通过 Zipkin 和 Jaeger 采集链路追踪的数据 
-  调整了 DataKit 安装命令，DataKit 安装支持更多的平台，同时支持离线安装（[DataKit 使用文档](03-%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86/02-datakit%E9%87%87%E9%9B%86%E5%99%A8/index.md)） 
-  调整了 DataKit 相关配置，部分采集器有一些字段上的调整，不建议 copy 原 conf.d 目录到新的采集器中，[点击查看详情](03-%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86/02-datakit%E9%87%87%E9%9B%86%E5%99%A8/changlog.md) 
-  整理了 DataKit 配置文件目录结构和默认安装路径，[点击查看详情](03-%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86/02-datakit%E9%87%87%E9%9B%86%E5%99%A8/changlog.md) 

### DataWay

- DataWay 新增写入日志数据、对象数据的接口同时调整了事件数据的写入接口（[DataWay API](12-API/01-DataWay/01-DataWay_API%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3.md)）

## 2020 年 5 月 7 号

### DataFlux Studio

-  图表新增散点图，可展示数据的分布情况 
-  指标浏览中 “指标集” 新增 「配置自动聚合规则」 功能，支持按照设定的聚合规则对采集的指标自动降精度 
-  移除视图中的数据集模式，优化了指标浏览的交互，并在浏览指标时新增了表格模式查看 
-  优化集成组件的展示效果 
-  修复登录后在一段时间后会自动登出的 bug 以及新建查询时某些情况下标签过滤条件未保存的 bug 和其他若干 bug，提高了产品可用性 

### DataFlux Admin Console

-  工作空间新增数据仓库配置，可配置指定的的指标集将数据同步到数据仓库中 
-  工作空间支持配置开启和关闭指标集自动聚合功能 

### DataFlux f(x)

- 《DataFlux.f(x)包学包会》更新到最新版
- 授权链接GET方式访问支持扁平形式（?kwargs_key=value）和简化形式（?key=value）

## 2020 年 4 月 29 号

### 数据采集

-  DataKit 新增 6 个数据源：Oracle 监控指标、CoreDNS、uWSGI、Traefik、Solr以及 阿里云 RDS 慢查询日志。新增对 Express 项目的监控指标采集 
-  新增四个视图模板，：自建MySQL监控、阿里云云数据库PolarDB MySQL监控、阿里云云数据库PolarDB PostgreSQL监控、和 阿里云云数据库RDS for PostgreSQL监控；优化了两个视图模板：MySQL监控、PostgreSQL监控 

## 2020 年 4 月 21 号

### DataFlux Studio

-  新增一个图表类型：自定义图表，支持基于自定义的背景图片绘制图表 
-  基础图表中新增“自动对齐时间间隔”功能。系统根据选择的时间范围和聚合时间计算出时间间隔后，将按照预设的自动对齐时间间隔（ 包含 1分钟、5分钟、10分钟、30分钟、1小时等 10 种时间间隔）就近向上动态的调整查询 
-  图表新增自适应视图窗口功能。当视图中仅存在一个图表时，支持选择「铺满视图」使图表一键自适应整个视图窗口 
-  添加节点时，衍生节点支持指定指标集和节点图标 
-  调整了左侧导航栏的分类及名称 
-  基本设置中支持查看当前工作空间的版本； 
-  调整了 SAAS 版本的数据网关界面 
-  修复若干 bug，提高了系统稳定性 

### DataKit（`v1.0.0-109-g13b2ced`）

-  新增 timezone、StatsD、SSH、lighttpd、etcd、以及 阿里云询价 六个数据源的数据采集支持 
-  支持 CentOS 6.7 及 Ubuntu 14.04 以上操作系统 
-  DataKit 支持级联以及 Lua 脚本清洗 

## 2020 年 4 月 14 号

### DataFlux Studio

-  DataFlux 线上新增产品版本限制，所有新增的工作空间默认为免费版（时间线500条、数据保留时长1天、触发规则数1个、触发规则有效期7天 ） 
-  重构和优化了触发器的底层逻辑；同时触发规则支持自定义无数据告警的消息内容，新增高级检测功能，支持在 DataFlux f（x）平台自主开发高级检测函数 
-  优化了图表的加载速度以及 SQL 的查询 
-  修复了图表别名及颜色显示出错的问题 
-  修复了指标集不能删除的问题 
-  修复了指标集中名称中如果存在英文点号数据无法查询的问题 

### DataFlux Admin Console

-  调整“添加工作空间”逻辑，删除“选择已有数据库”和“设置数据权限”的功能，所有新建工作空间均“自动创建新数据库” 
-  新建工作空间支持设置“数据保留时长”和“触发历史保留时长” 

### DataFlux.f(x)

-  增加官方脚本库在线更新功能，官方脚本不再需要导出后导入 
-  官方脚本库增加简单检测支持（需要安装最新版官方库） 
-  编辑器使用严格等宽字体，保证1个中文等于2个英文宽度 
-  修复了已知问题并提高了系统稳定性 

### DataWay（V1.0.1-401-ga917b59）

-  Lua 模块中 MongoDB/Redis/MySQL 增加连接池功能（默认启用） 
-  移除对 $flow_ 、 $alert 等指标的正确性验证 
-  **DataWay 增加数据上报安全认证机制，所有已部署的 DataWay 都必须进行升级，否则无法继续使用** 

## 2020 年 4 月 3 号

-  折线图、柱状图、饼图的图表「设置」中支持设置颜色，且支持分组后针对不多分组设置颜色 
-  图表设置中支持自定义指标单位 
-  修复 safari 兼容性问题 
-  优化侧边导航栏 

## 2020 年 3 月 31 号

### DataFlux Studio

-  帮助中心新增搜索功能，支持快速定位目标关键词 
-  场景节点新增分享功能，支持查看分享历史、编辑分享、取消分享和查看分享二维码。 
-  场景节点新增搜索功能，支持查看搜索历史 
-  调整基线功能，将原「查询」和「异常检测」中的“基线”移至“折线图”和“柱状图”的设置中 
-  「指标浏览」中支持查看指标集的 “数据类型” 
-  针对 IT 运维场景新增 37 个视图模板 
-  调整图表查询规则及 UI 样式，支持一个指标集选择多个 field ，支持聚合函数嵌套使用; 
-  优化场景节点树，记录展开状态的选择状态；修复了选中问题 
-  优化左侧导航栏，支持收缩显示，增加图表可视化面积 
-  优化了指标查询中“自定义SQL”功能，支持返回点数限制和时间限制 
-  优化界面中 tag key，tag value，measurement、fieldkey 查询慢的问题 

### DataFlux Mobile

-  新增“服务协议”确认功能，同意后才可使用 APP 
-  新增节点导入功能，支持直接查看节点图表 

### 数据采集

- 新增 PostgreSQL、MongoDB、网络旁路抓包（pcap）以及 阿里云 CDN 四个数据源的数据采集支持

## 2020 年 3 月 16 号

### DataFlux Studio

-  支持用户退出工作空间；支持管理员解散工作空间 
-  图表分析模式下，折线图支持调整查询条件；支持关键事件按时间聚合展示；支持关键事件列表展示 
-  新增概览图、折线图、柱状图同期对比功能 
-  新增两个图表类型：中国地图、世界地图 
-  新建图表中，别名支持格式化展示，包含“只显示分组名”、“只显示指标名”等 
-  新建子节点时允许不继承父节点标签筛选 
-  支持锁定图表的时间范围，不受全局时间范围的限制 
-  优化表格图，支持查询方式按分组显示 
-  DataFlux 现支持  Warehouse 功能 
-  修复饼图，表格图聚合模式，仪表盘，柱状图分组模式下查询的数据不正确的问题 
-  优化集成组件的筛选方式 
-  修复触发规则有时不产生触发历史的 bug 

### DataFlux Admin Console

-  添加工作空间支持“自动创建新数据库”和“选择已有数据库”两种方式 
-  优化默认工作空间的名称，统一为【用户名】的工作空间 

### DataFlux.f(x)

-  「简易调试面板」现已支持内置 DataWay 浏览工作空间列表 
-  「脚本列表」新增「快速查看面板」，可在编辑脚本时同时查看另一个脚本代码 
-  「DataWay 操作对象」现已支持指定 Token 进行数据写入 
-  「脚本编辑器」不再允许多个窗口编辑同一个脚本 
-  「@DFF.API」现已支持 cagetory='check' 选项，用于标示检测类函数 
-  修复已知问题并提高了系统稳定性 

### 数据采集

-  新增 5 个 DataWay API：`/v1/config`、`/v1/reload`、`/v1/lua`、`/v1/lua/list`、`/v1/license`； 
-  优化 `/v1/write/metrics` API 功能 
-  DataWay 升级，现已支持合并新老配置文件。包含 `remote_host`、`collect_second`、`lua_worker`、`access_key`、`secret_key` 等可以通过命令行传入的参数 
-  DataWay 安装新增两个参数支持：DW_ ENABLE_ CONFIG_ API 和 DW_ CONFIG_ PASSWORD，分别为允许开启 config API 及设置 config API 密码。一但开启 config API，如果没有指定密码，安装将失败。 
-  调整 DataWay Cache 清理行为：限制单次清理数量，提高清理频率 
-  DataWay Lua 脚本相关 
-  所有 Lua 文件统一放在 < DataWay-安装目录 >/lua 下，旧版本所有 Lua 配置需手动移至此目录下，必要情况下需更改路由配置 
-  不再支持绝对路径的 Lua 配置，若在旧版本已进行了配置，需手动做处理 
-  DataKit 允许通过 X-Token 头指定 token 向公共 DataWay 传送数据 

## 2020 年 3 月 13 号

### 数据采集

- 新增 DataWay Android SDK、DataWay iOS SDK、DataWay Python SDK、DataWay Javascript SDK

## 2020 年 3 月 11 号

### 数据采集

-  DataKit（`v1.0.0-44-gaa4a656`） 数据源新增支持 Azure Monitor、Zabbix、Promethues Exporter、NSQ 监控指标、网络端口扫描、Kubernetes 监控数据、Github 及 Java 中间件（Cassandra、Hadoop-HDFS、Java JVM、JBoss、Kafka、Tomcat、Weblogic、BitBucket）监控数据采集 
-  DataWay 新增对 Logstash、Promethues 数据采集器的支持 
-  发布 CSV 数据采集器 
-  新增对 Oracle 数据采集支持 

## 2020 年 3 月 5 号

### DataFlux Studio

- 指标集支持删除

### DataFlux Admin Console

- 后台添加管理员帐号和成员帐号增加密码强度要求

## 2020 年 2 月 28 号

### DataFlux Studio

-  图表查询新增自定义函数模式，支持使用 DataFlux.f(x) 开发自定义查询函数 
-  视图变量新增排序功能，在创建和修改视图变量时支持对变量值进行排序和预览 
-  优化 SQL 模式模式，支持 UI 模式直接映射 SQL 模式，增加执行按钮和错误提示反馈 
-  优化图表查询下函数的交互体验，增加函数说明的提示 
-  优化概览图的取值方式，支持选择聚合算法 
-  修复表格图表存在 null 数据界面不显示的问题 
-  修复柱状图 top 设置排序不对的问题 

### DataFlux Admin Console

- 管理后台账号新增角色功能，分为管理员和开发者角色，开发者只能登录 DataFlux.f(x) 平台

### DataFlux.f(x)

-  新增数据源结构浏览器 
-  代码编辑器可切换查看已发布，编辑中，DIFF 
-  UI/API增强异步调用支持 
-  增加查询函数支持（category=query） 
-  更新内置官方脚本包 
-  修复已知问题并提高系统稳定性 

### 数据采集

-  DataKit 新增阿里云日志服务（SLS）数据采集、阿里云操作审计（ActionTrail）数据采集、Kafka Consumer 数据采集、路由追踪指标采集、Kubernetes 监控指标、Kube Inventory 监控指标采集、HTTP 性能指标采集 
-  新增 Oracle 数据采集 
-  DataWay 兼容 DataX 数据同步工具 

## 2020 年 2 月 20 号

### DataFlux Studio

-  新增命令组件，图表中支持命令组件的创建与设置 
-  优化了图表添加的交互方式和图表的分类，包括基础图表和高级图表。 
-  新增图表的 PNG 图片导出功能 
-  概览图新增 maping 功能 
-  集成新增场景分类筛选 
-  添加、修改场景时，支持对场景数据范围的进行设置 
-  优化了图表数据的显示，所有 float 类型数据保留两位小数 
-  支持为节点添加自定义图标 
-  触发规则中的触发动作，新增动作函数的触发 
-  新增 DataFlux EBA Agent Builder，通过 DataFlux EBA Agent Builder 可打包生成针对企业行为分析场景的专用采集器 
-  系统部署时支持通过配置 Continuous Query 规则对指标进行降精度设置 

### DataKit

-  新增支持对 agent 的配置 
-  修复阿里云费用采集的相关 bug 
-  优化采集和上报性能 

## 2020 年 2 月 15 号

### DataFlux Studio

-  修复视图偶尔白屏的问题 
-  修复分析模式中预测函数无法输入自定义参数的问题 
-  修复 SQL 模式下柱状图无法显示的问题 
-  修复私有部署版本生成的场景二维码无法在移动端扫描添加的问题 
-  修复表格图上一页和下一页不能点击、定时刷新后回到第一页、重复数据被屏蔽、分页后数据为空则不显示分页条的问题 

### DataFlux.f(x)

-  脚本编辑器添加只读模式，点击开始编辑才进入编辑 
-  修复脚本函数返回非标准JSON时，API接口失败的问题 
-  修复文案、展示问题，补充页面提示 

## 2020 年 2 月 10 号

-  新增场景模板模板，创建场景支持基于模板创建，已创建的场景可导出为模板 
-  场景支持分享功能，分享后可通过 DataFlux APP 或小程序在移动端查看 
-  视图支持添加流程图、视频、实时视频流 
-  新增图表组合功能，柱状图与折线图组合、概览图与折线图组合 
-  图表查询的转换函数支持选择通过 DataFlux f(x) 开发的自定义转换函数 
-  发布 DataFlux 移动端 APP，场景发布后支持在 APP 中扫码查看 
-  柱状图支持 TopList 展示方式 
-  优化视图显示页面，支持动态加载图表 
-  优化 Dataway 管理界面的监控视图 
-  发布了 DataWay API 文档和 SDK 
-  指标集多 RP（数据保留策略） 支持 

## 2020 年 1 月 10 号

-  新增 Telegraf 采集器配置文档 
-  DataKit 采集器新增支持 `snmp`、`syslog`、`exec`、`varnish`、`NSQ Consumer` 采集源配置 
-  优化查询的返回数据点太多时页面加载性能 
-  优化字符串类型指标设置触发规则时的配置逻辑：去掉字符串不支持的聚合函数；优化字符串 count 聚合时的触发条件的设置 
-  修复将场景钉到首页后跳转错误的问题 
-  修复柱状图多个查询，显示错位的问题 
-  修复新建查询时删除自定义表达式后查询无数据的问题 

## 2019 年 12 月 29 号

-  新增关键事件功能，通过上报关键事件，可关联图表分析关键事件对数据指标影响 
-  优化图表渲染性能 
-  视图模板支持导出 
-  支持云端 DataWay，用户可直接使用云端 DataWay 地址上报数据；如需使用本地 DataWay 需购买授权 License 
-  修复放大分析模式下，数据刷新后预测数据清空的问题 
-  左侧导航和页面筛选栏支持收缩展开 
-  优化新建查询的交互体验 
-  优化时间选择控件交互体验 
-  自定义查询时的图表直接进入放大分析模式 
-  增加帮助中心入口 
-  优化 PaaS 版本用户登录UI 

## 2019 年 12 月 24 号

DataFlux 正式发布上线


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642755649859-32132b81-b29a-45d0-85cf-956d1215d4c2.png?x-oss-process=image%2Fresize%2Cw_746%2Climit_0%2Fresize%2Cw_746%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=Jq24x&margin=%5Bobject%20Object%5D&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
