# Log Explorer
---


After log data is collected in <<< custom_key.brand_name >>>, you can view all log content within the workspace using the Log Explorer.

**Note**: If the current logged-in account role has set "Only show rules related to me" in **Logs > [Data Access](../management/logdata-access.md#list)**, the queried log content will also be affected accordingly.


## View Modes

The Log Explorer supports three viewing modes, including:

- [All Logs](#all);
- [Pattern Analysis](#cluster);
- [Chart Analysis](#charts).

### All Logs {#all}

View and analyze based on the raw log data that has been collected.
    
![](img/log_explorer_all_logs.png)

### Pattern Analysis {#cluster}

The Log Explorer provides an efficient clustering function. It performs similarity analysis on logs based on the `message` field and automatically displays the most recent 50 logs.

You can also customize the clustering fields. After selecting a time range in the Time Widget, the system will analyze 10,000 logs within that period and aggregate similar entries.

![](img/log_explorer_patterns.png)


In the Pattern Analysis list, you can manage the data with the following actions:

- Click :octicons-triangle-up-16: & :octicons-triangle-down-16: to sort by document count (default descending order);
    
- Click :octicons-gear-24:, choose to display 1 line, 3 lines, 10 lines, or all content.
    
- Click :material-tray-arrow-up:, export all clustered log data.

![](img/manage-cluster.gif)

### Chart Analysis {#charts}

In the **Analysis** mode of the viewer, the system groups log data based on 1-3 tags and displays the distribution characteristics and trends at different times.

It supports four types of charts: time series charts, top lists, pie charts, and treemap charts.


You can manage the chart analysis mode with the following operations:

- Field-based filtering queries are supported below the chart;
- In time series chart mode, you can choose between area charts, line charts, or bar charts;
- For displayed cluster data:
    - In time series chart mode, you can select `slimit` as 5/10/20/50/100;
    - In top list/pie chart/treemap chart modes, you can select `limit to` maximum or minimum values of 5/10/20/50/100;
- Click :material-list-box:, choose legend display position (hidden, bottom, right side);
- Click :art:, customize legend colors;
- Click :material-tray-arrow-up:, export the chart as a CSV file, export to notes or dashboards, or copy the chart.
    
![](img/5.log_analysis.gif)