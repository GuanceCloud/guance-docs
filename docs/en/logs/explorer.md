# Log Explorer
---

After log data is collected in <<< custom_key.brand_name >>>, you can view all log content within the workspace through the **Log Explorer** in the <<< custom_key.brand_name >>> console.

**Note**: If the current logged-in account role has set the option **[Data Access](../management/logdata-access.md#list)** to "Show only rules related to me" under **Logs > Data Access**, the queried log content will be affected accordingly.


## View Modes

<<< custom_key.brand_name >>> Log Explorer supports three view modes, including:

- [All Logs](#all);
- [Pattern Analysis](#cluster);
- [Chart Analysis](#charts).

### All Logs {#all}

**All Logs**: Based on the raw log data for viewing and analysis.
    
![](img/5.log_1.png)

### Pattern Analysis {#cluster}

The Log Explorer provides efficient pattern analysis functionality, which involves similarity calculations on the raw log data.

By default, the system performs log clustering based on the `message` field, automatically displaying the most recent 50 log entries. You can also customize the clustering fields according to business needs. After selecting a time range using the [Time Widget](../getting-started/function-details/explorer-search.md#time) in the top-right corner, the system will filter and analyze up to 10,000 log entries within that period, automatically aggregating similar logs, summarizing, and finally displaying common characteristics.

![](img/4.log_2.png)

In the pattern analysis list, you can manage the data with the following actions:

1. Click the :octicons-triangle-up-16: & :octicons-triangle-down-16: icons to sort by document count, defaulting to descending order.
    
2. Click the :octicons-gear-24: button to choose display options of 1 row, 3 rows, 10 rows, or all.
    
3. Click the material-tray-arrow-up: button to export all clustered log data.

![](img/manage-cluster.gif)

### Chart Analysis {#charts}

In the **Analysis** mode of the explorer, the system groups and statistically analyzes the raw log data based on <u>1-3 tags</u>, reflecting the distribution characteristics and trends of log data across different groups over time.

![](img/manage-charts.png)

Upon entering analysis mode, four types of charts are available: Time Series, Top List, Pie Chart, and Treemap.

You can manage the chart analysis mode with the following operations:

1. Below the chart, you can perform filtering queries based on various fields;
2. In Time Series mode, you can choose between Area, Line, and Bar chart styles;
3. For displayed cluster data, in Time Series mode, you can set `slimit` to 5/10/20/50/100; in Top List/Pie Chart/Treemap modes, you can set `limit to` maximum or minimum of 5/10/20/50/100;
4. Click the :material-list-box: button to choose legend positions: hidden, bottom, or right;
5. Click the :art: button to customize the color style of the legend;
6. Click the :material-tray-arrow-up: button to export the current chart as a CSV file, to notes, dashboard, or directly copy the chart.
    
![](img/5.log_analysis.gif)