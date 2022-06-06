---

## 简介

工作空间的全部监控器可通过“观测云”平台的「监控」进行查看和管理。您不仅可以创建新的监控器，还可以对现有分组、监控器进行管理、删除、批量操作等。

## 新建监控器

“观测云” 支持您从主机、Docker、Elasticsearch等监控模版快速创建监控器，或自定义新的监控器和触发条件并配置告警。

### 从模版新建

“观测云”内置多种开箱即用的监控模版，支持一键创建主机、Docker、Elasticsearch、Redis、阿里云 RDS、阿里云 SLB、Flink 监控。即自动添加对应的官方监控器至当前工作空间。详情可参考文档 [模版](https://www.yuque.com/dataflux/doc/br0rm2) 。

注意：反复从模版创建监控器会导致监控器列表内出现重复的监控器，“观测云” 支持检测重复的监控器，您可以通过在弹窗提示中选择“是”正常创建模板库中所有的监控器，或选择“否”仅创建不重复的监控器。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1639557923125-33cb9944-dc9f-402e-bba1-c09d875a2d94.png#clientId=u040364b4-8b22-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=229&id=ub323b6e2&margin=%5Bobject%20Object%5D&name=image.png&originHeight=207&originWidth=413&originalType=binary&ratio=1&rotation=0&showTitle=false&size=21309&status=done&style=stroke&taskId=u7ce3cc1e-98ea-4fe4-9753-efe8fcf78c6&title=&width=456)
### 新建监控器

在监控器中，支持通过「+新建监控器」添加新的监控器，并自定义触发规则。
![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1635925030208-4b762f13-783f-45f3-a6f6-bc5eb62201fa.png#clientId=u03a2e2d0-1707-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=654&id=u90f03cc0&margin=%5Bobject%20Object%5D&name=image.png&originHeight=654&originWidth=1028&originalType=binary&ratio=1&rotation=0&showTitle=false&size=56808&status=done&style=stroke&taskId=u5324e227-8568-4f2c-b50b-f553d1d31d1&title=&width=1028)

- [阈值检测](https://www.yuque.com/dataflux/doc/zdeogm)：基于设置的阈值对指标数据进行异常检测，当数据达到阈值时，触发告警并通知用户。
- [日志检测](https://www.yuque.com/dataflux/doc/usqo8y)：基于工作空间内的日志数据进行异常检测，多适用于 IT 监控场景下的代码异常或任务调度检测等。
- [突变检测](https://www.yuque.com/dataflux/doc/dgk8e5)：基于历史数据对指标的突发反常表现进行异常检测，多适用于业务数据、时间窗短的场景。
- [区间检测](https://www.yuque.com/dataflux/doc/kcngg6)：基于动态阈值范围对指标的异常数据点进行检测，当数据超出设定的区间范围后，产生告警并通知用户，多适用于趋势稳定时间线的场景。
- [水位检测](https://www.yuque.com/dataflux/doc/wbi2y4)：基于历史数据对指标的持续反常表现进行异常检测，可避免突发检测的毛刺告警。
- [安全巡检](https://www.yuque.com/dataflux/doc/bbp4o4)：基于工作空间内安全巡检数据进行异常检测，用于监控工作空间内系统、容器、网络等存在的漏洞、异常和风险。
- [应用性能指标检测](https://www.yuque.com/dataflux/doc/tag1nx)：基于工作空间内「应用性能监测」的指标数据，当指标到达设置的阈值范围后触发告警。
- [用户访问指标检测](https://www.yuque.com/dataflux/doc/qnpqmm)：基于工作空间内「用户访问监测」的指标数据，当指标到达设置的阈值范围后触发告警。
- [进程异常检测](https://www.yuque.com/dataflux/doc/uskqmx)：基于工作空间内的进程数据，支持对进程数据的一个或多个字段类型设置触发告警。
- [可用性监测数据检测](https://www.yuque.com/dataflux/doc/he412g)：基于工作空间内的可用性监测数据，通过对一定时间段内可用性监测任务产生的指定数据量设置阈值范围后触发告警。

## 分组管理

分组功能支持您在设定监控器时，自定义创建有意义的监测器组合，支持通过「分组」筛选出对应监控器，方便分组管理各项监控器。
注意：

- 每个监控器创建时必须选择一个分组，默认选中「默认分组」；
- 当某个分组被删除时，删除分组下的监控器将自动归类到「默认分组」下。

### 新建分组

在观测云工作空间「监控」-「监控器」，点击右上角「分组管理」，即可添加新的监控器分组。
![2.monitor_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642417041778-6d2fd1ba-c65a-4048-a734-c3957cdd6cb9.png#clientId=ub663233b-8a61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u07c5f138&margin=%5Bobject%20Object%5D&name=2.monitor_1.png&originHeight=498&originWidth=1247&originalType=binary&ratio=1&rotation=0&showTitle=false&size=75514&status=done&style=stroke&taskId=ub843dbde-b2bc-4083-b579-b5c0d7a2558&title=)
### 配置分组告警

创建分组以后，可以为分组配置告警对象和告警沉默。更多详情可参考文档 [告警设置](https://www.yuque.com/dataflux/doc/qxz5xz) 。
![2.monitor_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642417116294-5ea3839b-385c-4dfa-9d4a-fb867a60c31e.png#clientId=ub663233b-8a61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u5e8c11f7&margin=%5Bobject%20Object%5D&name=2.monitor_2.png&originHeight=542&originWidth=1251&originalType=binary&ratio=1&rotation=0&showTitle=false&size=88310&status=done&style=stroke&taskId=u1d1247d3-9771-4d6f-87e0-e4c01d3c7ba&title=)
### 配置监视器分组

创建分组以后，可以为监视器选择分组。在观测云工作空间「监控」-「监控器」，点击「新建监控器」，即可在创建监控器时选择分组。
![2.monitor_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642417309778-d1bcb624-05a3-4503-871c-b824900f545a.png#clientId=ub663233b-8a61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u29b7dcd8&margin=%5Bobject%20Object%5D&name=2.monitor_3.png&originHeight=653&originWidth=1236&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60488&status=done&style=stroke&taskId=u528e2a36-2afb-46e7-b641-7a0abd710ac&title=)
## 监控器列表

「监控器」列表中，保存有当前工作空间内的全部监控器。支持查看监控器名称、 分组、状态、操作和是否被添加到 SLO 的 SLI 目标列表中。被添加至 SLO 作为 SLI 的监控器将以特殊标识![image.png](https://cdn.nlark.com/yuque/0/2021/png/12569107/1635930437873-ada9fa2e-b863-4cd8-82ac-1dff666bfc92.png#clientId=u220359dc-df09-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=14&id=ue9a6f279&margin=%5Bobject%20Object%5D&name=image.png&originHeight=14&originWidth=13&originalType=binary&ratio=1&rotation=0&showTitle=false&size=544&status=done&style=none&taskId=u0d82f34c-f878-4414-9abd-12ac2ed3a33&title=&width=13)展示。
![2.monitor_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642483899918-c1775f14-9c7a-42e9-8188-622587438d6f.png#clientId=ub663233b-8a61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u193e7c97&margin=%5Bobject%20Object%5D&name=2.monitor_4.png&originHeight=585&originWidth=1246&originalType=binary&ratio=1&rotation=0&showTitle=false&size=152997&status=done&style=stroke&taskId=uc79b99c4-a5b8-409a-9c23-46198f24d10&title=)
### 查询

监控器列表支持基于监控器名称、分组名称进行搜索。

- 搜索框🔍，支持监控器名称、分组名称搜索；
- 选择「分组」支持基于指定分组筛选出对应监控器。

### 批量操作

「批量操作」功能支持用户在 监控器列表中  “批量导出监控器” 和 “批量删除监控器”。通过选定批量操作，您可以同时选定多个监控器进行删除和导入。

![2.monitor_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642484024106-d7182a9f-fed4-4fd0-b216-180eca5812f8.png#clientId=ub663233b-8a61-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3ea021bd&margin=%5Bobject%20Object%5D&name=2.monitor_5.png&originHeight=283&originWidth=1250&originalType=binary&ratio=1&rotation=0&showTitle=false&size=71205&status=done&style=stroke&taskId=u199cd106-8b05-4daf-9f05-dd360d6a227&title=)
### 导入/导出监控器

在「监控器」中支持「导入/导出监控器」，即通过导入/导出监控器配置 json 文件的方式创建监控器。导入的json文件将直接导入为监控器，并默认分组。

**注意**：导入的 json 文件需要是来自“观测云”的配置json文件。

## 操作说明
| **操作** | **说明** |
| --- | --- |
| 状态 | 当前监控器的状态，共 已启用/禁用 两种状态，可以通过操作栏来启用或禁用监控器; |
| 启动/禁用 | “观测云”支持启用/禁用已有的监控器。新建的监控器将默认启动，您可以「禁用」监控器，或重新「启动」被禁用的监控器。
**注意**：「禁用」的监控器将不再生效；被禁用的监控器可以通过「启用」重新开启。 |
| 编辑 | “观测云”支持对已有的监控器进行重新编辑，通过点击监控器名称或「编辑」即可对监控器的触发条件进行重新编辑。 |
| 删除 | “观测云”支持对已有的监控器进行「删除」。当不需要某个监控器时，可以通过「删除」按钮删除对应监控器。
**注意**：一旦删除监控器，将无法恢复监控器数据，事件数据仍做保留。 |
| 查看相关事件 | 由同一监控器触发的告警事件统一存储在对应「监控器」下，通过「查看相关事件」操作，可直接跳转由该规则触发的全部未恢复事件，详情可参考 [事件管理](https://www.yuque.com/dataflux/doc/aisb71) 。 |
| 查看相关视图（关联仪表板） | 每一个监控器都支持关联一个仪表板，编辑监控器，即可通过「关联仪表板」功能关联对应所需的仪表板。 |



---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642760892203-e9a59abf-a25a-4021-b12b-3484390ff7a3.png#clientId=u021b010b-be8a-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u553f180d&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=u28fb2c38-b02e-4a71-82dd-b7171e179cd&title=)
