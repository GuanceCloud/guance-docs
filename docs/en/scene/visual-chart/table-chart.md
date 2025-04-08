# Table Chart
---


The table chart has the characteristic of intuitively displaying statistical information attributes and reflecting the relationships between data.


It includes two types of charts:

- Grouped table chart (default selected)
- Time series table chart

![](../img/table.png)


## Chart Query

1. Supports adding multiple queries, but the grouping labels must be consistent; modifying one will automatically synchronize changes to the others;
2. Supports Metrics sorting, default sorting by the first query's metrics. Clicking on the column header switches between ascending and descending order. The Top/Bottom in the corresponding query synchronizes adjustments. When you click on other query metrics for sorting, the Top/Bottom in the corresponding query synchronizes adjustments.

> For more details, refer to [Chart Query](./chart-query.md).

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Table Configuration 


#### Enable Pagination

After enabling pagination, you can choose the number of items displayed per page in the chart, including 10, 20, 50, and 100 items.

#### Display Columns

That is, you can select the display columns for the queried data. If there are many columns, you can customize and manually input column names. The final query result values can be used as [value variables](chart-link.md#z-variate) for link redirection;

In edit mode of the chart, you can manually adjust column width, and after saving the current chart, the list information will be displayed according to the column width; you can also **drag and drop** to adjust the order of the display columns, and the list will display according to the configured sequence.

<img src="../../img/table-1.png" width="70%" >