# 服务管理

**服务管理**作为一个集中管理入口，以全局的视角访问和查看当前工作空间内所有服务下的关键信息；同时，其将业务属性与业务数据相串联，通过关联的仓库和文档，快速确定紧急问题的代码位置和问题解决方案。

进入**场景 > 服务管理**页面：

您可查看所有服务的状态、关联仓库及文档等信息。

<img src="../img/service-2.png" width="60%" >


## 添加服务清单

<img src="../img/service-1.png" width="60%" >

| 字段      | 说明         |
| ----------- | ------------------- |
| 名称      | 必填项，即服务名称。         |
| 类型      | 必填项，类型选择范围包括：`app`, `framework`, `cache`, `message_queue`, `custom`, `db`, `web`。 |
| 团队      | 即当前服务所属团队。 |
| 紧急联系人      | 即联系人的邮箱地址；若需多选，须按照逗号、分号、空格间隔。         |
| 仓库配置      | 依次填入显示名称、提供商名称及仓库代码 URL。        |
| 帮助文档      | 依次填入显示名称、提供商名称及其他关联文档 URL。        |

输入相关信息后，点击**确定**即可创建成功。

## 服务清单列表

创建完成后，您可以在清单列表查看所有服务：

**注意**：服务的**状态**包含正常、紧急、重要、无数据，取该服务 60 天范围内最后一次未恢复事件的状态，若无则显示【正常】。

![](img/service-3.png)

您可以通过以下操作来管理列表：

- 批量操作：点击服务旁的 :material-square-rounded-outline:，您可以批量删除特定服务；
- 在搜索栏，可输入关键词搜索服务名称；
- 在**关联**，Hover 至相应图标，点击可自动跳转至所关联的仓库或文档；

<img src="../img/service-4.png" width="70%" >

- 在**操作**，Hover 至头像图标，可查看该条服务的创建人、创建时间、更新人及更新时间。
- 点击 :octicons-star-24: 按钮，即可收藏当前服务；
- 点击 :material-dots-vertical: 按钮，可编辑或删除当前服务；
- 通过**我的收藏**、**我的创建**和**经常浏览**来快速过滤查找对应的服务。

## 清单列表详情

点击某条服务，可进入详情页。

默认打开概览页：

![](img/service-5.png)

点击页面上方 tab，即可进入日志、链路、错误追踪、事件查看器，查询关联服务下的所有相关信息。

|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**关于查看器更多信息，您可点击前往：**</font>                         |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | 
| [日志查看器](../logs/explorer.md){ .md-button .md-button--primary } | [链路查看器](../application-performance-monitoring/explorer.md){ .md-button .md-button--primary } |
|  [错误追踪查看器](../application-performance-monitoring/error.md){ .md-button .md-button--primary } | [事件查看器](../events/unrecovered-events.md){ .md-button .md-button--primary } |