# SLO
---

## Introduction

SLO charts can directly select the set monitoring SLO for SLO data display.For more details, please refer to the document [What is SLO](../../monitoring/slo.md) 。

## Use Case

Guance's SLO charts are used for SLO data presentation. For example, you can view the remaining fault tolerable hours for SLOs with a period of the last month.

## Chart Search

The SLO list includes all created SLOs in the current workspace, and the SLO data results are displayed simultaneously by selecting different SLO names.

## Chart Linking

Links can help you jump from the current chart to the target page, support adding internal links and external links to the platform, and support modifying the corresponding variable values in the links through template variables to transfer data information over and complete data linkage.Please click [chart-link](chart-link.md) to view the relevant settings.
## Chart Style
| Options | Description |
| --- | --- |
| Chart Title | Set the title for the chart, after setting, it will be displayed on the top left of the chart, and it supports hiding |


## 图表设置
### 高级设置
| 选项 | 说明 |
| --- | --- |
| Lock Time | Supports locking the time range (last 7 days, last 30 days, last 90 days, last 360 days) of the chart query data, regardless of the global time component. The time set by the user will appear in the upper right corner of the chart after successful setting, such as 【xx minutes】, 【xx hours】, 【xx days】. If the time interval of 30 minutes is locked, then when the time component is adjusted, no matter what time range view is queried, only the last 30 minutes of data will be displayed. |
| Remaining Limit | For controlling whether to display remaining limit data |
| Year-round SLA | Control whether to achieve year-round SLA data |
|Chart Description | Add description information to the chart, after setting, an 【i】 prompt will appear behind the chart title, if not set, it will not be displayed |
| Workspace | The list of authorized workspaces, you can query and display the workspace data through the chart after you select it.

## Example Chart

The figure below shows the remaining fault tolerant hours for an SLO with a period of the last 7 days.

![](../img/slo001.png)

