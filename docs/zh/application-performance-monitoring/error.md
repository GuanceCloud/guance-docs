# 错误追踪
---


观测云提供应用性能监测错误数据分析查看器，您可以在**应用性能监测 > 错误追踪**快速查看链路中的类似错误的产生历史趋势及其分布情况，帮助快速定位性能问题。

错误追踪查看器包括**所有错误**和**聚类分析**两个列表：

- [所有错误](#errors)：用于<u>需要整体查看所有</u>在项目应用中发生的链路错误；  

- [聚类分析](#analysis)：用于<u>快速查看最频繁发生</u>的需要被解决的链路错误

> 观测云查看器提供强大的查询和分析功能，可参考 [查看器说明](../getting-started/function-details/explorer-search.md)。

## 所有错误 {#errors}

在观测云工作空间**应用性能监测 > 错误追踪**，选择**所有错误**列表，即可查看和分析所有链路的错误数据。

**注意：**所有错误的数据统计的是基于错误状态 `status=error`，且含有错误类型 `error_type` 字段的 Span。

![](img/1.apm_error_12.png)

### 关联分析

在错误追踪查看器，您可以通过点击任意错误查看对应的错误链路详情，包括服务、错误类型、错误内容、错误分布图、错误详情、链路详情、扩展属性以及关联的日志、主机、网络等。

<div class="grid" markdown>

=== "错误分布图"

    在错误查看器详情页 > 错误分布图，基于错误信息 `error_message` 和错误类型 `error_type` 两个字段，**聚合统计近似度高的错误链路，并按照错误查看器选择的时间范围，自动选取相应的时间间隔展示错误的分布趋势**，帮助您直观地查看频繁发生错误的时间点或者时间范围，快速定位链路问题。

    ![](img/1.apm_error_11.1.png)

=== "错误详情"

    借助错误详情信息快速定位错误问题。

    ![](img/1.apm_error_14.png)

=== "链路详情"

    该 tab 页为您展示当前链路服务下发生的错误信息。

    ![](img/1.apm_error_13.png)

</div>

## 聚类分析 {#analysis}

若您需要查看发生频次较高的错误，可以在观测云工作空间**应用性能监测 > 错误追踪**，选择**聚类分析**列表。

聚类分析是对所有错误的链路数据基于聚类字段进行相似度计算分析，根据右上方选择的时间范围固定当前时间段，并获取该时间段内 10000 条数据进行聚类分析，将近似度高的错误链路进行聚合，提取并统计共同的 Pattern 聚类，帮助快速发现异常链路和定位问题。

默认根据 `error_message` 字段进行聚合，可自定义输入聚类字段，最多可输入 3 个。

![](img/1.apm_error_10.0.png)


### 聚类分析详情

- 在聚类分析列表，您可以通过点击任意错误查看所有关联的错误链路，点击链路即可进入错误链路详情页查看分析；  

![](img/1.apm_error_10.png)

- 聚类分析页面中，点击排序 icon :octicons-triangle-up-16: & :octicons-triangle-down-16:，您可对文档数量升/降序排序（默认倒序）。

![](img/error-1.png)

- 如果需要导出某条数据，打开该条数据详情页，点击右上角 :material-tray-arrow-up: 图标即可。

<img src="../img/error-0809.png" width="70%" >

## Issue 自动发现 {#issue}

基于观测云对 APM 错误追踪进行监测而产生的数据，当您启用 **Issue 自动发现**这一配置后，系统会根据不同的分组维度统计对应异常数据，并对后续类似问题的产生进行堆栈跟踪，自动浓缩，最终产生 Issue。通过该入口产生的 Issue 会帮助您直观获取问题产生的上下文和根因，大量减少解决问题的平均时间。

### 开始配置

<font size=2>**注意**：在启用该配置之前，需**先配置规则**。否则不支持启用。</font>

![](img/auto-issue.png)

:material-numeric-1-circle-outline: 数据来源：即当前配置页面的启用入口。

:material-numeric-2-circle-outline: 组合维度：基于配置字段内容组合进行归类统计，包含 `service`、`version`、`resource`、`error_type`。

针对数据来源，您可以添加筛选条件来过滤数据，观测云会针对符合条件的数据进一步作查询，缩小可用数据的范围。

<img src="../img/issue-filter.png" width="70%" >

:material-numeric-3-circle-outline: 检测频率：观测云会根据您选择的频率来查询数据的时间范围，包含 5 分钟、10 分钟、15 分钟、30 分钟和 1 小时。

:material-numeric-4-circle-outline: Issue 定义：启用该配置后，Issue 将以此处的定义对外呈现。为避免信息缺失，[需依次填写](../exception/issue.md#concepts)。

其中，在 Issue 的**标题**和**描述**两处，均支持使用以下模版变量：

| 变量 | 含义 |
| --- | --- |
| `count` | 统计数量 |
| `service` | 服务名称 |
| `version` | 版本 |
| `resource` | 资源名称 |
| `error_type` | 错误类型 |
| `error_message` | 错误内容 |
| `error_stack` | 错误堆栈 |

### 查看 Issue {#display}

保存配置并启用后，由系统自动发现并产生的 Issue 会在**控制台 > [异常追踪](../exception/issue.md#auto)**处显示。

![](img/issue-auto.png)

## 更多阅读

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **巧用 Issue 自动发现功能快捷响应异常**</font>](./issue-auto-generate.md)

</div>


<!--
同时，根据组合维度的不同，基于该来源产生的 Issue 会以新问题、重复问题、回归问题这三种标识进行区分，方便您的辨别。

- 新问题：与历史 Issue **不存在相同组合维度**。

![](img/auto-issue-1.png)

- 重复问题：与历史 Issue **存在有相同组合维度且 Issue 状态为 Open 或者 Pending**。同时，通过自动发现的新的数据内容会直接追加到此 Issue 回复区。

![](img/auto-issue-2.png)

- 回归问题：与历史 Issue **存在相同组合维度且 Issue 状态为 Resolved**，系统会将该 Issue 状态从 Resolved 变更为 Open。同时，通过自动发现的新的数据内容会直接追加到此 Issue 回复区。

-->