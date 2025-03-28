# 查看器
---


<<< custom_key.brand_name >>>的**场景 > 自定义查看器**为您提供了可快速搭建的日志查看器，您可以与空间成员共同搭建基于自定义的日志查看器，定制化您的查看需求，还可以将制作完成的查看器导出分享给他人，共享查看器模板。

> 点击了解更多[查看器的强大之处](../../getting-started/function-details/explorer-search.md)。

## 新建查看器

1、进入**场景 > 查看器**，点击**新建查看器**，即可开始创建自定义查看器。

![](../img/5.explorer_custom_2.png)

- 空白查看器：即创建一个空白的查看器，后续可自定义设置该查看器；
- 自定义模板：导入自定义的查看器模板进行使用；
- 内置查看器模板：系统提供的查看器模板，无需配置，即选即用。

![](../img/9.logviewer_2.png)

2、选择**新建空白查看器**并完成自定义查看器名称及标签后，即可创建一个新的查看器。

- 查看器名称：工作空间内查看器名称不可重复，且支持最大长度 64 个字符；

- 自定义标签：支持用户创建专属标签。<<< custom_key.brand_name >>>的仪表板与查看器共用一套标签数据，点击**标签**即可搜索对应的查看器；

- 数据类型：用户需要选择查看器的数据类型，可以选择日志、应用性能、用户访问、安全巡检、Profile 这 5 种数据类型。**保存后不可更改**；

    - 当选择用户访问类型时，需要先选定应用，选定保存后不可更改。

- 可见范围：查看器创建者可自定义当前查看器的查看权限，包括**公开**和**仅自己可见**；

    - 公开：对空间内所有成员开放的查看器，其他成员的查看和编辑权限不受影响；
    - 仅自己可见：仅查看器创建人可查看的非公开查看器，其他成员不具备查看权限。

**注意**：以链接形式分享的非公开查看器，非创建人不可见。

![](../img/5.explorer_custom_1.png)

## 配置查看器

创建查看器后，即可对其进行配置。：

<u>下文以日志查看器为例：</u>

![](../img/explorer001.png)

- 数据范围：用于选择日志的来源，需先安装 DataKit，并配置对应的日志采集器；
- 搜索/筛选：基于日志来源和筛选的结果进行关键字，筛选日志的展示内容；  
- [时序图](../visual-chart/timeseries-chart.md)图表：用于显示数据在相等时间间隔下的趋势变化，还可用来分析多组指标数据之间的作用及影响。您可以自定义[图表查询](../visual-chart/chart-query.md)，并展示为折线图、面积图或柱状图；   
- 图表同步搜索：用于筛选搜索的内容是否同步到图表，默认开启。当搜索框有内容时，关闭开关，即图表查询回到默认状态；开启开关，即图表查询受到筛选内容的影响；       
- 快捷筛选：默认显示 `主机、状态` 两个字段；支持用户自定义快捷筛选列表；    
- 数据列表：默认配置 `时间、内容` 两个字段，支持用户自定义显示列表字段；     
- 配置显示列：自定义配置显示列，支持手动输入或者下拉选择；支持选择**近似文本分析**查看器字段，默认使用 `message` 字段对应内容做近似文本分析。

<img src="../img/6.log_explorer_6.png" width="60%" >


## 列表操作

您可以通过以下操作对查看器列表进行管理：

### 搜索 & 筛选

在查看器列表，可通过顶部**搜索栏**和左侧**过滤**、**标签筛选**对查看器进行分组查看，以便快速获取查询结果。

### 批量操作

在查看器列表，您可以针对特定查看器进行批量删除或导出。

![](../img/explorer-1.gif)

### 添加查看器导航菜单 {#menu}

在场景查看器列表，支持将当前查看器添加至基础设施、指标、日志、应用性能监测、用户访问监测、可用性监测、安全巡检、CI 可视化导航菜单。

<u>示例说明：</u>

1、在查看器列表，选择需要添加的查看器，如 **MySQL 查看器模板**，点击右侧**操作**菜单下的**编辑**，选择**添加至菜单**；

![](../img/10.custom_explorer_1.png)

2、选择添加到**日志**菜单；

<img src="../img/10.custom_explorer_2.png" width="60%" >

3、添加完成后，即可在**日志**导航菜单，查看添加的自定义查看器；

![](../img/10.custom_explorer_3.png)

4、若您具有[场景配置管理的权限](../../management/role-list.md)，可点击**编辑自定义查看器**，跳转回自定义查看器进行编辑。



## 跨工作空间查询 {#cross-workspace}

工作空间若是被授予了其他工作空间，则可在当前查看器切换工作空间查看对应的图表信息。

![](../img/explorer-workspace.png)

## 设置 

<img src="../img/0809-op.png" width="60%" >

### 新建 Issue

您可以将当前仪表板内观测到的异常现象创建为 Issue。
 
> 更多相关操作，可参考[如何在视图级别手动创建 Issue](../../exception/issue.md#dashboards)。关于 Issue 更多相关信息，可参考[异常追踪](../../exception/index.md)。

### 保存快照

在仪表板用快捷键 `(Windows: Ctrl+K / Mac OS: Cmd+K)` 快速保存快照，即可为当前仪表板保存快照，或者选择在**设置**按钮点击**保存快照**进行保存。

![](../img/explorer004.png)

快照保存以后，可以在查看器左上角点击快照小图标查看已经保存的快照列表，支持分享、复制链接和删除快照。

![](../img/explorer005.png)

> 更多介绍，可参考 [快照](../../getting-started/function-details/snapshot.md)。


### 导入/导出/复制查看器

<<< custom_key.brand_name >>>支持复制当前查看器为新的查看器进行编辑；支持导出 JSON 文件为模板，以共享当前查看器的数据监测方案，实现反复使用模板的价值，导出的查看器 JSON 文件可以通过导入新建或者覆盖原先的模板进行编辑。


## 使用查看器分析数据

查看器配置完成后，在数据列表，您可以通过以下功能查询和分析日志数据，帮助您快速定位问题。

| 操作      | 说明        |
| ----------- | ------------------ |
| 搜索      | 基于字段标签、日志文本进行关键词搜索、字段筛选、关联搜索、模糊搜索。        |
| 分析      | 基于分析维度进行筛选搜索。        |
| 快捷筛选      | 基于字段标签，快捷筛选日志数据。        |
| 显示列      | 自定义数据列表显示列。        |
| 格式化配置      | 隐藏敏感日志数据内容或者突出需要查看的日志数据内容，还可以通过替换原有日志内容进行快速筛选。        |
| 导出到 CSV 文件      | 如果需要导出某条数据，打开该条数据详情页，点击右上角 :material-tray-arrow-up: 图标即可。        |
| 导出到仪表板/笔记      | 即将当前日志数据导出到仪表板/笔记显示查看。        |
   

![](../img/explorer02.png)

