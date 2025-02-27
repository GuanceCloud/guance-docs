# 错误追踪


日志错误追踪查看器旨在呈现{{{ custom_key.brand_name }}}收集的所有错误日志数据。该查看器筛选并展示包含 `error_stack` 或 `error_message` 字段的日志条目，以便您进行精确查询和深入分析。

## 错误列表

在错误追踪列表中，您可以检视特定时间范围内的错误信息。您也可以利用左侧的快速筛选根据业务需求筛选数据，或者在搜索栏中输入筛选条件来快速定位所需数据。

<img src="../img/log-tracing-1.png" width="80%" >

> 关于列表更多相关操作，可参考 [日志列表](./manag-explorer.md)。

## 错误详情

点击某条日志数据，进入详情页。您可以：

- 查看与该条 `error` 数据相关的详细信息，如来源和涉及的服务；
- 利用错误分布图直观地了解错误趋势的变化情况；
- 查看与该条数据关联的扩展字段信息；
- 浏览与该条数据相关的上下文日志，以获取更多背景信息。

<img src="../img/log-tracing.png" width="80%" >

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **日志查看器**</font>](./explorer.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **查看器的强大之处**</font>](../getting-started/function-details/explorer-search.md)

</div>

</font>