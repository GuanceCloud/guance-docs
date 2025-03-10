# Comparison of the same period
---

## Introduction
The comparison function can be used to show the development of something over a comparison period. It can be opened in 【Line Chart】 and 【Overview Chart】, and there are 4 comparison dimensions available, namely: comparison with one hour ago, daily comparison, weekly comparison, and monthly comparison.

Example of usage scenario: Counting the number of user visits (PV) today and comparing it with yesterday's PV.

## Time Series Chart
Show the trend comparison of the line graph query for the same time as the previous one. (The line graph for the same time comparison case is displayed as a dashed line graph)

![](../img/time01.png)

### 1）Contrast dimension description

Comparison dimensions support **multiple selection**. Comparison dimensions can be selected as: comparison with one hour ago, daily comparison, weekly comparison, monthly comparison.

- The line chart for the default query is displayed as a solid line.
- The line graph for the same period comparison is shown as a dashed line.

### 2）Description of comparison logic

**Line chart for default query:** Plotted according to the selected [Start Time - End Time].

**Line chart for contemporaneous comparison:** Plotted according to the selected **comparison dimension**, going forward the same time range.

### 3）Example

**Inquire about the CPU usage trend of host A for example**

- Select 【Hour】 for the comparison dimension: i.e., push forward one hour to query

If you query the CPU usage trend of host 【A in the last hour】(3/2 10:00 - 3/2 11:00), then the CPU usage trend of host A in the same period of comparison query is (3/2 09:00 - 3/2 10:00)

If the default query is 【Today】 (3/2 00:00 - 3/2 11:00) CPU usage trend of host A, then the comparison query is (3/1 23:00 - 3/2 10:00) CPU usage trend of host A for the same period

- Comparison dimension selection 【Day】: that is, forward one day (24h) query

If the default query is 【last one hour】 (3/2 10:00 - 3/2 11:00) CPU usage trend of host A, then the comparison query is (3/1 10:00 - 3/1 11:00) CPU usage trend of host A for the same period

If the default query is 【today】 (3/2 00:00 - 3/2 11:00) CPU usage trend of host A, then the comparison query is (3/1 00:00 - 3/1 11:00) CPU usage trend of host A for the same period

???+ warning

    When the comparison dimension selects 【Month】, if the default query 【3d】 (3/28 10:00 - 3/31 10:00) the CPU usage trend of host A, then the comparison query for the same period is (2/28 10:00:00 - 2/28 23:59:59) data, because there is no 29, 30, 31 in February



## Overview Chart

Compares the query trend with the previous data at the same time. Display query trend results as **increase/decrease percentage**.

![](../img/time02.png)

### 1）Contrast dimension description

Comparison dimension only supports **single selection**. Comparison dimensions can be selected as: comparison with one hour ago, daily comparison, weekly comparison, monthly comparison.

### 2）Explanation of comparison logic

The percentages are calculated as (current query result - comparison query result) / comparison query result *100%

### 3）Example Description

| Comparison Dimension | Comparison Query Logic | Time Range of 【Current】 Query | Time Range of 【Comparison】 Query | Percentage Display (Example) ｜
| --- | --- | --- | --- | --- |
| Hour | Forward **1 hour query** Time range for comparison | 【1h】3/2 10:00-3/2 11:00 | 3/2 09:00 - 3/2 10:00 | Comparison with one hour ago xx% ⬆|
| | | **Today/Yesterday/Last Week/This Week/Month/Last Month** | **No Comparison** | **None** |
| Day | Forward **24 hour query** Time range for comparison | 【1h】3/2 10:00-3/2 11:00 | 3/1 10:00 - 3/1 11:00 | Day-on-day xx% ⬆ |
| | | 【Today】3/2 00:00:00 - Current time | 3/1 00:00:00 - 23:59:59 | Day by day xx% ⬆ |
| | | **Last week/this week/this month/previous month** | **No comparison** | **None** |
| Week | Forward **7 days query** Comparison time range | 【1h】3/2 10:00 - 3/2 11:00 (Wed) | 2/23 10:00 - 2/23 11:00 (Wed) | Week-on-Week xx% ⬆ |
| | | 【Today】 3/2 00:00 - 3/2 11:00 （Wednesday） | 2/23 00:00:00-23:59:59 （All day last Wednesday） | Week-on-Week xx% ⬆ |
| | | 【This week】 2/28 00:00 - Current time (Monday to Wednesday) | 2/21 00:00:00 - 2/27 23:59:59 (Last week's full week) | Week-on-Week xx% ⬆ |
| | | **This month/previous month** | **No comparison** | **None** |
| Month | Forward **1 month query** Time range for comparison | 【3d】3/2 10:00 - 3/5 10:00 | 2/2 10:00 - 2/5 10:00 | Month-on-month xx% ⬆ |
| | | 【Today】 3/2 00:00:00 - Current time | 2/2 00:00:00 - 23:59:59 (Last month's 2nd full day) | Month-on-month xx% ⬆ |
| | | 【This month】 3/1 00:00:00 - Current time | 2/1 00:00:00 - 2/28 23:59:59 (Last month a full month) | Month-on-month xx% ⬆ |
| | | 【3d】3/26 10:00 - 3/29 10:00 | 2/26 10:00 - 2/28 23:59:59 (because the 29th does not exist in February) | Month-on-month xx% ⬆ |
| | | **Last week/this week** | **No comparison** | **None** |
| | |**【1d】3/29 10:00 - 3/30 10:00**| **No comparison (because 29 and 30 do not exist in February)** | **No** |