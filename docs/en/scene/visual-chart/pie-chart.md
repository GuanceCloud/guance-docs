# Pie Chart
---

Generally used to represent the comparison of data groups.

The chart types include:

- Pie Chart: Displays the comparison of data groups, more suitable for scenarios with fewer sample metrics;   
- Donut Chart: More applicable for reflecting the proportion of each part of multiple sample metrics;    
- Rose Chart: The size of the arc radius represents the size of the data, suitable for scenarios with too many classifications, as well as similar numerical size proportions and comparison scenarios.

![](../img/pie.png)


## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Merge Data Items

If there are too many slices in the pie chart with a very small proportion of data, you can use merging to aggregate the data into the ["Other"] slice, allowing you to view slices with higher priority proportions and improve the readability of the pie chart.

After configuring the merge, the pie chart will add an "Other" slice, which represents the aggregated display of the merged data. 

- Not Merged:

<img src="../../img/pie-1.png" width="70%" >

- Merged:

<img src="../../img/pie-2.png" width="70%" >