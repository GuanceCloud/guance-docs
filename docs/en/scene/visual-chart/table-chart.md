# Table Chart
---


A table chart is characterized by its ability to intuitively display statistical information and reflect relationships between data.


It includes two types of charts:

- Grouped Table Chart (default selected)
- Time Series Table Chart

![](../img/table.png)


## Chart Query

Supports adding multiple queries, but all queries must have consistent grouping labels. When the grouping label of any query is modified, the grouping labels of other queries will automatically synchronize and update.

### Metrics Sorting

By default, sorting is based on the first query's metrics.

- Clicking the column header switches between ascending or descending order, and the Top/Bottom settings in the query will automatically sync accordingly;         
- When sorting by the metrics of other queries, the corresponding Top/Bottom settings will also be updated to the currently selected metric.

> For more details, refer to [Chart Query](./chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Enable Pagination

After enabling pagination, you can choose the number of items displayed per page, including 10, 20, 50, and 100 entries.

### Display Columns

That is, you can choose which columns of query data to display. If there are many columns, you can customize them manually by entering column names. The final query result values can be used as [value variables](chart-link.md#z-variate) for link navigation;

In edit mode for the chart, you can manually adjust column widths. After saving the current chart, the list information will be displayed according to the column width settings. You can also **drag and drop** to adjust the display order of columns, and the list will be shown according to the configured sequence.

<img src="../../img/table-1.png" width="70%" >