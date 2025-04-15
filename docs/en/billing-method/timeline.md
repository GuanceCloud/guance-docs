# Billing Item for Time Series

---

<!--
## Update Notes

<<< custom_key.brand_name >>> completed the upgrade and launch of **[GuanceDB Self-developed Time Series Database](./gauncedb.md)** on April 23, 2023. The new GuanceDB differs from the old time series engine as it is a single-metric time series engine. Although the concept of Measurement still exists, each metric will have its own independent timeline.

As a result, <<< custom_key.brand_name >>>'s **statistical logic for timelines** has also changed:

![](../img/timeline-1.png)

Under the new logic:

- **Full statistics changed to incremental statistics**: That is, instead of previously counting all historical data stored by users, we now count <u>the number of active timelines that may occur each day</u>;

- **Fixed price changed to tiered pricing**: That is, tiered pricing will correspond to different prices based on the selected data retention strategy;

- **Statistical dimension changed from Measurement to Metrics**: Previously, the statistical dimension was based on the tag combinations under the Measurement. In the new GuanceDB timeline, <<< custom_key.brand_name >>> counts the number of all tag combinations generated in the data reported on the day, based on the metric dimension.

*It no longer counts the number of timelines corresponding to the data stored by users in the time-series database, which had relatively fixed unit prices; and counted all tag combinations under the Measurement based on the Measurement dimension.*
-->
## What You Need to Know First

Two diagrams explain the difference between full statistics and incremental statistics:

![](../img/all.png)

![](../img/add.png)

The time-series database of <<< custom_key.brand_name >>> mainly involves the following basic concepts:

| Term         | Description |
| --------------- | ------------------ |
| Daily Active Timelines | Refers to the number of timelines that generate new metric data on the day. We use the timelines that generate data on the day as the basis for statistics. That is, if you stop collecting data, the timeline fee will not be charged on a new day, but the previously collected metric data can still be queried. |
| Measurements    | Generally used to represent a set corresponding to some statistical value, more like the table concept in relational databases. |
| Data Points     | In the context of metric data reporting, it refers to a single metric data sample, specifically analogous to row data in relational databases. |
| Time           | Timestamp, representing the time when the data point is generated. This can also be understood as the time when DataKit collects a certain metric data and reports it via line protocol. |
| Metrics        | Field, generally storing numerical data that changes with the timestamp. For example, cpu_total, cpu_use, and cpu_use_pencent commonly found in the CPU Measurement are all metrics. |
| Tags           | Generally stores attribute information that does not change with the timestamp. For example, fields such as host and project commonly found in the CPU Measurement are all tag attributes, used to identify the actual object properties of the metrics. |

## Billing Generation

Metric data is collected through DataKit and reported to a specific workspace. Specifically, this refers to the data obtained by querying NameSpace in DQL.


<font color=coral>**When settled in Renminbi (RMB):**</font>

<div class="grid" markdown>

=== "China Site"

    | Data Retention Strategy | 3 Days | 7 Days | 14 Days | 30 Days | 180 Days | 360 Days |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site | ¥ 0.6 | ¥ 0.7 | ¥ 0.8 | ¥ 1 | ¥ 4 | ¥ 7 |

=== "Hong Kong and Overseas Sites"

    | Data Retention Strategy | 3 Days | 7 Days | 14 Days | 30 Days | 180 Days | 360 Days |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | Hong Kong and Overseas Sites | ¥ 1.6 | ¥ 1.8 | ¥ 2.2 | ¥ 2.4 | ¥ 8 | ¥ 14 |

</div>


<font color=coral>**When settled in US dollars:**</font>

<div class="grid" markdown>

=== "China Site"

    | Data Retention Strategy | 3 Days | 7 Days | 14 Days | 30 Days | 180 Days | 360 Days |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site | $ 0.09 | $ 0.1 | $ 0.12 | $ 0.14 | $ 0.58 | $ 1 |

=== "Hong Kong and Overseas Sites"

    | Data Retention Strategy | 3 Days | 7 Days | 14 Days | 30 Days | 180 Days | 360 Days |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | Hong Kong and Overseas Sites | $ 0.23 | $ 0.26 | $ 0.32 | $ 0.35 | $ 1.2 | $ 2 |

</div>



## Billing Item Statistics

Statistics are taken every hour to calculate the number of new timelines within <u>that day</u>, resulting in 24 data points. The maximum value among these is taken as the actual billing quantity.

## Example

![](../img/timeline-2.png)

In the above diagram:

In the old timeline statistical logic, there were no concepts of metrics or data points, only the number of label combinations for the current Measurement was counted. Therefore, it was difficult to help users quantify the exact number of timelines.

After the change, the GuanceDB timeline logic is based on the statistics of label combinations for each metric. According to the latest logic, we can deduce that there are a total of 6 data points in the CPU Measurement based on a single metric. Each data point has a time field: `time`, one metric: `cpu_use_pencent`, and two tags: `host` and `project`. The first and fourth rows of data both represent the CPU usage rate (`cpu_use_pencent`) situation where the "host" name is Hangzhou_test1 and "project" belongs to Guance. Similarly, the second and fifth rows indicate the CPU usage rate where the "host" name is Ningxia_test1 and "project" belongs to Guance. The third and sixth rows represent the CPU usage rate where the "host" name is Singapore_test1 and "project" belongs to Guance_oversea.

Based on the aforementioned timeline statistics, there are 3 types of timeline combinations for the `cpu_use_pencent` metric:

`"host":"Hangzhou_test1","project":"Guance"`      
`"host":"Ningxia_test1","project":"Guance"`       
`"host":"Singapore_test1","project":"Guance_oversea"`       

Similarly, to calculate all timelines for the current workspace's metrics, simply sum up the actual number of timelines for each metric.

**Therefore, regarding the number of timelines:**

After the timeline logic change in <<< custom_key.brand_name >>>, the number of daily timeline combinations may increase. However, in terms of actual data representation, the number of timelines charged daily may decrease. The reason is that when the scope of timeline statistics is full statistics, assuming the data retention period is 7 days, then by the seventh, eighth, ninth, and tenth days, the data reaches a relatively stable state. This means that if you want to assess the number of timelines later, it will always be calculated based on the total number of timelines within this interval.

However, after changing to incremental statistics, <<< custom_key.brand_name >>> calculates the number of daily active timelines based on the day's metric data. Therefore, overall, while the number of timeline combinations at the single-metric level may increase, the amount that needs to be billed tends to decrease. Considering the increase in numbers, the pricing for GuanceDB timelines has been adjusted from a flat rate to tiered pricing, i.e., from 3 RMB per thousand to 0.6 RMB per thousand, depending on the user’s choice of different data retention strategies. Thus, **overall, the billing for timelines has decreased compared to before.**

## Cost Calculation Formula

Daily cost = Actual billing quantity / 1000 * Unit price (according to the data retention strategy)

Assume a user installs one HOST DataKit and enables default metric data collection. This HOST generates 600 daily active timelines. The estimation can be done in the following steps:

1. How many HOSTs are installing DK?

2. Quantity * 600 = Number of daily active timelines

3. Unit price for corresponding data retention strategy * Number of daily active timelines / 1000 = **Daily Estimated Cost**