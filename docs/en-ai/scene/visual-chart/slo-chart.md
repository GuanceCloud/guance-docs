# SLO
---

You need to directly select the already configured SLO monitoring to display the related performance data.

![](../img/slo.png)

> For more detailed information, refer to [What is SLO](../../monitoring/slo.md).


## Chart Query

SLO List: Includes all SLOs created within the current workspace. By selecting different SLO names, the corresponding SLO data results are displayed synchronously.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Display Items

1. Downtime: The time when the monitor was in an abnormal state or the used quota.
2. Error Budget: Controls whether to display the remaining budget data.
3. Annual SLA: Controls whether to achieve annual SLA data.

<!--
## Chart Links

Links can help you jump from the current chart to the target page; internal and external links can be added; template variables can also modify the corresponding variable values in the link to pass data information, completing data linkage.

> For more relevant settings, refer to [Chart Links](chart-link.md).

## Common Configurations

| Option | Description |
| --- | --- |
| Title | Set a title for the chart, which will be displayed in the top-left corner of the chart after setting. Supports hiding. |
| Description | Add a description to the chart. After setting, an [i] prompt will appear after the chart title. If not set, it will not be displayed. |
| Display Items | Downtime: The time when the monitor was in an abnormal state or the used quota.<br />Error Budget: Controls whether to display the remaining budget data.<br />Annual SLA: Controls whether to achieve annual SLA data. |

## Advanced Configurations

| Option | Description |
| --- | --- |
| Locked Time | Fixes the time range for querying data on the current chart, independent of the global time component. After successful setup, the user-defined time will appear in the top-right corner of the chart, such as [xx minutes], [xx hours], [xx days]. For example, if the locked time interval is 30 minutes, regardless of what time range is queried via the time component, only the data from the last 30 minutes will be displayed. |
| Workspace Authorization | The list of authorized workspaces. After selection, you can query and display data from the selected workspace through the chart. |
-->