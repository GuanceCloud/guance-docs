# Error（错误）
---

可查看用户在使用应用期间，浏览器发出的前端错误，包括错误类型、错误内容等。

在 Error 查看器，您可以：

- 集中查看所有的错误类型，及其相关的错误详情；
- 通过 Sourcemap 转换，还原混淆后的代码，方便错误排查时定位源码，帮助用户更快解决问题。


## 查看器列表

### 所有错误

在 Error 查看器，您可以快速查看用户访问时的页面地址、代码错误类型、错误内容等。

- 错误内容 Load failed：即没有 `response` 的错误，默认 SDK 加了 Load failed；  
- 错误内容 Network request failed：即 `response` 返回错误。 

![](../img/12.rum_explorer_6.png)

### 聚类分析 {#analysis}

若您需要查看发生频次较高的错误，可以在<<< custom_key.brand_name >>>工作空间**用户访问监测 > 查看器 > Error**，选择**聚类分析**列表。

聚类分析是对所有错误的链路数据基于聚类字段进行相似度计算分析，根据右上方选择的时间范围固定当前时间段，并获取该时间段内 10000 条数据进行聚类分析，将近似度高的错误链路进行聚合，提取并统计共同的 Pattern 聚类，帮助快速发现异常链路和定位问题。

默认根据 `error_message` 字段进行聚合，可自定义输入聚类字段，最多可输入 3 个。

![](../img/error0725.png)

- 在聚类分析列表，您可以通过点击任意错误查看所有关联的 Error，点击链路即可进入详情页查看分析；  

- 聚类分析页面中，点击排序 icon :octicons-triangle-up-16: & :octicons-triangle-down-16:，您可对文档数量升/降序排序（默认倒序）。

## 详情页

点击列表中需要查看的数据详情页，您可以查看用户访问的错误详情，包括错误详情、扩展字段、关联的链路等。

![](../img/12.rum_explorer_2.5.png)

### 来源

在**来源**支持查看当前 Error 的 Session / View / Action 详情，筛选/复制查看当前的 Session ID / View ID / Action ID。

### 错误分布图

错误分布图将近似度高的错误进行聚合统计，并按照查看器选择的时间范围，自动选取相应的时间间隔展示错误的分布趋势，帮助您直观的查看频繁发生错误的时间点或者时间范围，快速定位错误问题。

### 错误详情 {#error}

在错误详情，您可以查看到错误的具体内容。

#### Sourcemap 转换

应用在生产环境中发布的时候，为了防止代码泄露等安全问题，一般打包过程中会针对文件做转换、压缩等操作。以上举措在保障代码安全的同时也致使收集到的错误堆栈信息是经过混淆后的，无法直接定位问题，为后续 Bug 排查带来了不便。

<<< custom_key.brand_name >>>为应用程序提供 Sourcemap 功能，支持还原混淆后的代码，方便错误排查时定位源码，帮助用户更快解决问题。

> 您可以通过 RUM [Sourcemap 配置](../sourcemap/set-sourcemap.md) 或 [Datakit 采集器 Sourcemap 转换](../../integrations/rum.md#sourcemap)进行配置，配置完成后，即可以在错误详情中查看解析后的代码和原始的代码。

**注意**：当前仅支持 Web 类型的应用在 RUM 进行 Sourcemap 配置。

##### 解析代码示例

在 RUM 配置 Sourcemap 转换，解析代码示例：

![](../img/1.rum_error_4.png)

##### 原始代码示例

![](../img/1.rum_error_5.png)

使用 Datakit 采集器配置 Sourcemap 转换，解析代码示例：

![](../img/sourcemap_02.png)

**注意**：若用户同时在 RUM 和 Datakit 采集器同时配置了 Sourcemap，展示 RUM 配置的解析格式。

### 扩展字段

:material-numeric-1-circle-outline: 在搜索栏，可输入字段名称或值快速搜索定位；

:material-numeric-2-circle-outline: 勾选字段别名后，可在字段名后查看；您可按需选择。

:material-numeric-3-circle-outline: 在链路详情页，你可以在**扩展字段**查看当前链路的相关字段属性：

| 字段      | 属性                          |
| ----------- | ------------------------------------ |
| 筛选字段值      | 即添加该字段至查看器，查看与该字段相关的全部数据，可在链路查看器筛选查看该字段相关的链路列表。                          |
| 反向筛选字段值      | 即添加该字段至查看器，查看除了该字段以外的其他数据。                          |
| 添加到显示列      | 即添加该字段到查看器列表进行查看。                          |
| 复制      | 即复制该字段至剪贴板。                          |


![](../img/extension-1.gif)

## Issue 自动发现 {#issue}

基于<<< custom_key.brand_name >>>对 RUM Error 进行监测而产生的数据，当您启用 **Issue 自动发现**这一配置后，系统会根据不同的分组维度统计对应异常数据，并对后续类似问题的产生进行堆栈跟踪，自动浓缩，最终产生 Issue。通过该入口产生的 Issue 会帮助您获取问题产生的上下文和根因，大量减少解决问题的平均时间。


![](../img/auto-issue-rum.png)

:material-numeric-1-circle-outline: 数据来源：即当前配置页面的启用入口。

:material-numeric-2-circle-outline: 组合维度：基于配置字段内容组合进行归类统计，包含 `app_name`、`env`、`version`、`error_type`。

基于组合维度，可添加筛选条件，<<< custom_key.brand_name >>>会针对符合条件的数据进一步作查询归类。


<img src="../img/issue-filter-rum.png" width="70%" >

:material-numeric-3-circle-outline: 检测频率：<<< custom_key.brand_name >>>会根据您选择的频率来查询数据的时间范围，包含 5 分钟、10 分钟、15 分钟、30 分钟和 1 小时。

:material-numeric-4-circle-outline: Issue 定义：启用该配置后，Issue 将以此处的定义对外呈现。为避免信息缺失，[需依次填写](../exception/issue.md#concepts)。

其中，在 Issue 的**标题**和**描述**两处，均支持使用以下模版变量：

| 变量 | 含义 |
| --- | --- |
| `count` | 统计数量 |
| `app_name` | 应用名称 |
| `env` | 环境 |
| `version` | 版本 |
| `error_type` | 错误类型 |
| `error_message` | 错误内容 |
| `error_stack` | 错误堆栈 |

### 查看 Issue {#display}

保存配置并启用后，由系统自动发现并产生的 Issue 会在**控制台 > [异常追踪](../../exception/issue.md#auto)**处显示。

![](../img/issue-auto.png)


## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **巧用 Issue 自动发现功能快捷响应异常**</font>](../../application-performance-monitoring/issue-auto-generate.md)

</div>