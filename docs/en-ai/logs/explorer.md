# Log Explorer
---

After log data is collected into Guance, you can view all the log content within your workspace through the **Log Explorer** on the Guance console.

**Note**: If the current login account role has set the option 【Display only rules related to me】 in **Logs > [Data Access](../management/logdata-access.md#list)**, the queried log content will be affected accordingly.


## View Modes

The Guance Log Explorer supports three view modes, including:

- [All Logs](#all);
- [Cluster Analysis](#cluster);
- [Chart Analysis](#charts).

### All Logs {#all}

**All Logs**: Based on the raw log data for viewing and analysis.
    
![](img/5.log_1.png)

### Cluster Analysis {#cluster}

The Log Explorer provides efficient cluster analysis functionality, which involves similarity computation and analysis of raw log data.

By default, the system performs log clustering based on the `message` field and automatically displays the most recent 50 log entries. You can also customize the clustering fields according to business needs. After selecting a time range using the [time control](../getting-started/function-details/explorer-search.md#time) in the top-right corner, the system will filter and analyze up to 10,000 log entries within that period, automatically aggregating similar log items, summarizing, and finally displaying common characteristics.

![](img/4.log_2.png)


In the cluster analysis list, you can manage the data with the following operations:

1. Click the icon :octicons-triangle-up-16: & :octicons-triangle-down-16: to sort by document count, defaulting to descending order.
    
2. Click the :octicons-gear-24: button to choose display options of 1 row, 3 rows, 10 rows, or all.
    
3. Click the material-tray-arrow-up: button to export all clustered log data.

![](img/manage-cluster.gif)

### Chart Analysis {#charts}

In the **Analysis** mode of the explorer, the system groups and statistically analyzes the raw log data based on <u>1-3 labels</u>, reflecting the distribution characteristics and trends of log data across different groups over time.

![](img/manage-charts.png)

After entering the analysis mode, four types of charts are available: Time Series, Top List, Pie Chart, and Treemap.

You can manage the chart analysis mode with the following operations:

1. Below the chart, support filtering and querying based on various fields;
2. In Time Series mode, support choosing between Area Chart, Line Chart, and Bar Chart styles;
3. For displayed clustered data, in Time Series mode, you can choose `slimit` as 5/10/20/50/100; in Top List/Pie Chart/Treemap modes, you can choose `limit to` maximum or minimum of 5/10/20/50/100;
4. Click the :material-list-box: button to choose hiding, bottom, or right legend;
5. Click the :art: button to customize the color style of the legend;
6. Click the :material-tray-arrow-up: button to export the current chart as a CSV file, export to notes, dashboard, or directly copy the chart.
    
![](img/5.log_analysis.gif)