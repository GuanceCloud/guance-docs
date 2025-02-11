# Billing Logic

---

This article will demonstrate the billing generation and price calculation logic for each billing item within the pay-as-you-go billing framework of the Guance product.


## Concept Explanation

| Term   | Description |
| -------- | ---------- |
| Data Storage   | Custom setting of data retention periods for different data types. |
| Base Billing   | The unit price of a billing item is a **fixed value**. |
| Tiered Billing   | The unit price of a billing item is a **dynamic value**, which varies based on the selected data storage strategy for the current data type. |

## Billing Cycle {#cycle}

The Guance billing cycle is **daily**, meaning that the usage statistics for the workspace on that day are settled at midnight the next day, generating a daily bill that is synchronized to the [Billing Center](../billing-center/index.md) of Guance. Ultimately, the consumption amount is deducted from the corresponding account based on the actual bound settlement method.

## Billing Items {#item}

### Time Series {#timeline}

Guance's time series engine mainly involves the following basic concepts when storing data:

| Term   | Description |
| -------- | ---------- |
| Measurement   | Generally used to represent a set corresponding to a statistical value, similar to the `table` concept in relational databases. |
| Data Point   | In the context of reporting metric data, it refers to a single metric data sample, analogous to `row` data in relational databases. |
| Timestamp   | Represents the time when the data point was generated, or the time when DataKit collected and reported the metric data in line protocol format. |
| Metrics   | Field, generally storing numerical data that changes with the timestamp. For example, common metrics in the CPU measurement like `cpu_total`, `cpu_use`, `cpu_use_pencent` are all metrics. |
| Tags   | Tags, generally storing attribute information that does not change with the timestamp. For example, common fields like `host`, `project` in the CPU measurement are tag attributes used to identify the actual object properties of the metrics. |

#### Example {#example}

![](../img/billing-2.png)

In the above figure, the measurement CPU has 6 data points based on a single metric. Each data point has a time field: `time`, one metric: `cpu_use_pencent`, and two tags: `host`, `project`. The first and fourth rows of data both have a `host` name `Hangzhou_test1` and belong to the project `Guance`, representing the CPU utilization (`cpu_use_pencent`). Similarly, the second and fifth rows indicate the CPU utilization for `host` name `Ningxia_test1` under the project `Guance`, and the third and sixth rows represent the CPU utilization for `host` name `Singapore_test1` under the project `Guance_oversea`.

Based on the time series data for the `cpu_use_pencent` metric, there are three combinations:

`"host":"Hangzhou_test1","project":"Guance"`      
`"host":"Ningxia_test1","project":"Guance"`       
`"host":"Singapore_test1","project":"Guance_oversea"`       

Similarly, to calculate all the time series for metrics within the current workspace, sum up the number of time series actually counted.

Data collection through DataKit reports metric data to a specific workspace. Specifically, this refers to data obtained by querying with DQL where NameSpace is **M**.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Time Series Billing Details</font>](../billing-method/index.md#timeline)


</div>

???+ abstract "Billing Item Statistics"

    Count the number of new time series added within the day at hourly intervals.

    Billing formula: Daily cost = Actual billed quantity/1000 * Unit price (based on the applied data storage strategy)

### Logs {#logs}

Any of the following situations will generate corresponding log data:

- Enabling log data collection and reporting;
- Configuring monitoring tasks, intelligent inspections, SLO anomaly detection tasks, or reporting custom events via OpenAPI;
- Initiating availability dial testing tasks and reporting test data through user-defined nodes.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Log Billing Details</font>](../billing-method/index.md#logs)


</div>

???+ abstract "Billing Item Statistics"

    Count the number of new log entries added within an hour at hourly intervals.

    Billing formula: Daily cost = Actual billed quantity/1000000 * Unit price (based on the applied data storage strategy)

???+ warning

    **Depending on the chosen storage type, large logs may be split into multiple entries for billing**:

    **ES Storage**: If the log size exceeds 10 KB, the number of billable entries for that log = integer division of (log size / 10 KB).

    **SLS Storage**: If the log size exceeds 2 KB, the number of billable entries for that log = integer division of (log size / 2 KB).

    If a single entry is smaller than the above limit, it is still counted as 1 entry.


### Data Forwarding {#backup}

Supports forwarding log data to Guance or four other external storage methods. Based on data forwarding rules, the volume of forwarded data is aggregated for billing.

**Note**: Data forwarded to Guance provided storage still retains records.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Data Forwarding Billing Details</font>](../billing-method/index.md#backup)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the volume of data forwarded according to the data storage strategy. Default unit: Bytes.

    Billing formula: Daily cost = Actual billed volume/1000000000 * Corresponding unit price

### Network {#network}

- Enabling eBPF network data collection

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Reported Network Data Host Billing Details</font>](../billing-method/index.md#network)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new hosts added within the day.

    Billing formula: Daily cost = Actual billed quantity * Corresponding unit price

### Application Performance Trace {#trace}

- Daily statistics on the number of Span data generated within the workspace.

**Note**: In Guance's new billing adjustments, the larger of "quantity/10" and the number of `trace_id`s will be used for billing.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Application Performance Trace Quantity Billing Details</font>](../billing-method/index.md#trace)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new `trace_id`s added within an hour.

    Billing formula: Daily cost = Actual billed quantity/1000000 * Corresponding unit price

### Application Performance Profile {#profile}

- Enabling application performance monitoring Profile data collection

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Application Performance Profile Quantity Billing Details</font>](../billing-method/index.md#profile)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new Profile data entries added within an hour.

    Billing formula: Daily cost = Actual billed quantity/10000 * Corresponding unit price

???+ warning

    Profile data consists of two main parts: **base attribute data** + **Profile analysis files**.

    If there are oversized Profile analysis files, Profile data will be split into multiple entries for billing.

    If the Profile analysis file size is greater than 300 KB, the number of billable entries = integer division of (Profile analysis file size / 300 KB).

    If the analysis file size is below the limit, it is still counted as 1 entry.


### User Access PV {#pv}

- Daily statistics on the number of Resource, Long Task, Error, Action data entries generated within the workspace.

**Note**: In Guance's new billing adjustments, the larger of "quantity/100" and the PV will be used for billing.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; User Access PV Quantity Billing Details</font>](../billing-method/index.md#pv)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new PV data entries added within an hour.

    Billing formula: Daily cost = Actual billed quantity/10000 * Price (based on the applied data storage strategy)

### Session Replay {#session}

- Enabling session replay collection

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Billing Details</font>](../billing-method/index.md#session)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new sessions added within the day.

    Billing formula: Daily cost = Actual billed quantity/1000 * Corresponding unit price

???+ warning

    If there are excessively long active sessions, they will be split into multiple entries for billing based on `time_spent`.

    If `time_spent` > 4 hours, the number of billable entries = integer division of (`time_spent` / 4 hours).

    If `time_spent` is less than 4 hours, it is still counted as 1 session.


### Synthetic Tests {#st}

- Enabling synthetic tests and receiving results through Guance-provided dial testing nodes.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Synthetic Testing Data Billing Details</font>](../billing-method/index.md#st)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new dial test data entries added within an hour.

    Billing formula: Daily cost = Actual billed quantity/10000 * Corresponding unit price

???+ warning

    Since synthetic test data is currently stored in the default log index, DQL queries or statistics need to include the following filter conditions to query dial test data.
    
    `index = ['default'], source = ['http_dial_testing','tcp_dial_testing','icmp_dial_testing','websocket_dial_testing']`.

### Triggers {#trigger}

- Enabling monitors, SLOs, and other periodic detection tasks. Among these, monitor anomaly detection, range detection, outlier detection, and log detection count as 5 trigger calls per detection, while other detection types count as 1 trigger call. Additionally, if the detection interval exceeds 15 minutes, the excess part is charged at 1 trigger call every 15 minutes;

- Intelligent monitoring: host, log, and application intelligent detection count as 10 trigger calls per execution; user access intelligent detection counts as 100 trigger calls per execution.

???+ abstract "Calculation Example"
     
    :material-numeric-1-circle-outline: Monitor call counts:

    1. Normal case: executing one [anomaly detection] counts as 5 trigger calls.
    2. Exceeding detection interval: if the detection interval is 30 minutes, the excess part adds 1 call every 15 minutes. For example, executing one [outlier detection] counts as 6 trigger calls.
    3. Multiple detections exceeding detection interval: executing two [range detections] with a total detection interval of 60 minutes counts as 13 trigger calls (2 detections * 5 + 3 extra intervals).

    :material-numeric-2-circle-outline: Intelligent monitoring call counts: executing one [host intelligent monitoring] counts as 10 trigger calls.

- Each DataKit/OpenAPI query counts as 1 trigger call;
- Each metric generation query counts as 1 trigger call;
- Each advanced function query from Func counts as 1 trigger call.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Trigger Call Count Billing Details</font>](../billing-method/index.md#trigger)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new trigger calls added within an hour.

    Billing formula: Daily cost = Actual billed quantity/10000 * Corresponding unit price


### SMS {#sms}

- Alarm policy configuration sends SMS notifications.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SMS Send Count Billing Details</font>](../billing-method/index.md#sms)


</div>

???+ abstract "Billing Item Statistics"

    At hourly intervals, count the number of new SMS messages sent within an hour.

    Billing formula: Daily cost = Actual billed quantity/10 * Unit price


## Billing Example {#example}

Assume Company A uses Guance to monitor its IT infrastructure and application systems comprehensively.

Assume Company A has a total of 10 hosts (each host has a default daily active timeline of 600), generating 6,000 timelines, 2 million log entries, 2 million Trace entries, 20,000 PV entries, and 20,000 task schedules daily, using the following data storage strategy:

| Billing Item       | Metrics (Timeline) | Logs | APM Trace | User Access PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| Data Storage Strategy | 3 days           | 7 days | 3 days           | 3 days        |

Specific details:

| Billing Item   | Daily Billing Quantity | Billing Unit Price        | Billing Logic                                                     | Daily Billing Cost |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| Timeline   | 6,000 entries     | 0.6 RMB/thousand entries     | (Actual billed quantity/1000) * Unit price<br> i.e., (6,000 entries/1,000 entries) * 0.6 RMB | 3.6 RMB       |
| Logs     | 2 million entries   | 1.2 RMB/million entries | (Actual counted quantity/billing unit) * Unit price<br> i.e., (2 million/1 million) * 1.2 RMB | 2.4 RMB     |
| Trace    | 2 million entries   | 2 RMB/million entries   | (Actual counted quantity/billing unit) * Unit price<br/> i.e., (2 million/1 million) * 2 RMB | 4 RMB       |
| PV       | 20,000 entries     | 0.7 RMB/ten thousand entries   | (Actual counted quantity/billing unit) * Unit price<br/> i.e., (20,000/10,000) * 0.7 RMB | 1.4 RMB     |
| Task Schedule | 20,000 times     | 1 RMB/ten thousand times     | (Actual counted quantity/billing unit) * Unit price<br/> i.e., (20,000/10,000) * 1 RMB | 2 RMB       |

**Note**: Since timelines are incrementally billed, changes in the number of timelines generated by the company will affect the costs.

> More timeline quantity calculations can be found in [Timeline Example](#timeline).


## Further Reading

<font size=2>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Guance's Self-developed Time Series Database</font>](./gauncedb.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Time Series Billing Item Explanation</font>](./timeline.md)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; An Introduction to Time Series Database Storage</font>](https://www.infoq.cn/article/storage-in-sequential-databases)


</div>


</font>