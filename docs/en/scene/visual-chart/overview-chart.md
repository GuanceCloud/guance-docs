# Overview Chart
---


The overview chart can clearly display a key numerical value or the result of a metric, and supports displaying mixed line charts to help understand the trend of metrics.

![](../img/overview.png)

## Use Cases

1. Intuitively display data result values;  
2. View a critical data point, such as: RUM PV / Unique Visitors.

## Chart Configuration

> For more details, refer to [Chart Configuration](./chart-config.md).

### Year-over-Year and Month-over-Month Comparison

This involves comparing with data from the same period in the previous time frame; it is turned off by default. If there is a data gap within the comparison time range, it will directly display as N/A, for example: Week-over-week N/A.


#### Comparison Dimensions

After enabling, the comparison dimensions support the following options:

- Hour (compared to one hour ago)
- Day (compared to one day ago)
- Week (compared to one week ago)
- Month (compared to one month ago)
- Sequential comparison

#### Comparison Logic

Below the value in the overview chart, the **increase/decrease percentage** will be displayed.

The percentage calculation result is: (current query result - comparison query result) / comparison query result * 100%.

#### Example

| Dimension | Comparison Query Logic | Current Query Time Range | Comparison Query Time Range | Percentage Display |
| --- | --- | --- | --- | --- |
| Hour | Shift forward by **1h** | 【1h】3/2 10:00-3/2 11:00 | 3/2 09:00 - 3/2 10:00 | Compared to one hour ago xx% ⬆ |
| | | **Today/Yesterday/Last Week/This Week/This Month/Last Month** | **No comparison** | **None** |
| Day | Shift forward by **24h** | 【1h】3/2 10:00-3/2 11:00 | 3/1 10:00 - 3/1 11:00 | Day-over-day xx% ⬆ |
| | | 【Today】3/2 00:00:00 - current time | 3/1 00:00:00 - 23:59:59 | Day-over-day xx% ⬆ |
| | | **Last Week/This Week/This Month/Last Month** | **No comparison** | **None** |
| Week | Shift forward by **7d** | 【1h】3/2 10:00 - 3/2 11:00 (Wednesday) | 2/23 10:00 - 2/23 11:00 (last Wednesday)| Week-over-week xx% ⬆ |
| | | 【Today】3/2 00:00 - 3/2 11:00 (Wednesday) | 2/23 00:00:00-23:59:59 (all day last Wednesday) | Week-over-week xx% ⬆ |
| | | 【This Week】2/28 00:00 - current time (Monday to Wednesday) | 2/21 00:00:00 - 2/27 23:59:59 (entire last week Monday) | Week-over-week xx% ⬆ |
| | | **This Month/Last Month** | **No comparison** | **None** |
| Month | Shift forward by **1mo** | 【3d】3/2 10:00 - 3/5 10:00 | 2/2 10:00 - 2/5 10:00 | Month-over-month xx% ⬆ |
| | | 【Today】3/2 00:00:00 - current time | 2/2 00:00:00 - 23:59:59 (entire day 2nd of last month) | Month-over-month xx% ⬆ |
| | | 【This Month】3/1 00:00:00-current time | 2/1 00:00:00 - 2/28 23:59:59 (entire last month) | Month-over-month xx% ⬆ |
| | | 【3d】3/26 10:00 - 3/29 10:00 | 2/26 10:00 - 2/28  23:59:59 (since February does not have 29th or 30th) | Month-over-month xx% ⬆ |
| | | **Last Week/This Week** | **No comparison** | **None** |
| | | **【1d】3/29 10:00 - 3/30 10:00**| **No comparison (February does not have 29th or 30th)** | **None** |

### Mixed Charts

When enabled, you can choose to display an area chart or bar chart simultaneously on the current chart, which helps query both the current metric value and its trend at the same time.

You can also check the coordinate axes of the chart as needed.

![](../img/overview-1.png)