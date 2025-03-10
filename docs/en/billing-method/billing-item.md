# Billing Logic

---

This article will demonstrate the billing logic for various chargeable items and price calculation within the pay-as-you-go billing framework of <<< custom_key.brand_name >>> products.


## Concepts

| Term   | Description |
| -------- | ---------- |
| Data Storage   | Custom settings for data retention periods for different data types. |
| Basic Billing   | The unit price of a certain chargeable item is a **fixed value**. |
| Tiered Billing   | The unit price of a certain chargeable item is a **dynamic value**, which varies based on the selected data storage strategy for the current data type, resulting in **different unit prices**. |

## Billing Cycle {#cycle}

The billing cycle for <<< custom_key.brand_name >>> is **daily**. Usage statistics for each workspace are calculated daily, with settlement occurring at midnight the following day. Daily bills are generated and synchronized to the <<< custom_key.brand_name >>> [Billing Center](../billing-center/index.md), from which the consumption amount is deducted based on the actual payment method.

## Billing Items {#item}

### Time Series {#timeline}

<<< custom_key.brand_name >>>'s time series engine primarily involves the following basic concepts for storing data:

| Term   | Description |
| -------- | ---------- |
| Measurement   | Generally used to represent a collection corresponding to a statistical value, similar to the concept of a `table` in relational databases. |
| Data Point   | In the context of reporting metric data, it refers to a single sample of metric data, analogous to `row` data in relational databases. |
| Time   | Timestamp, representing the time when the data point was generated, which can also be understood as the time when DataKit collected and reported a row protocol for a specific metric data. |
| Metric   | Field, typically holding numerical data that changes over time. For example, common metrics in the CPU measurement include `cpu_total`, `cpu_use`, `cpu_use_percent`. |
| Tags   | Tags generally store attribute information that does not change with timestamps. For instance, fields like `host` and `project` in the CPU measurement are tag attributes used to identify the actual object properties of metrics. |

#### Example {#example}

![](../img/billing-2.png)

In the above diagram, the measurement CPU has a total of 6 data points based on a single metric. Each data point includes a time field: `time`, one metric: `cpu_use_percent`, and two tags: `host`, `project`. The first and fourth rows of data both have `host` named `Hangzhou_test1` and belong to the project `Guance`, indicating the CPU usage (`cpu_use_percent`). Similarly, the second and fifth rows represent CPU usage for `host` named `Ningxia_test1` and project `Guance`. The third and sixth rows have `host` named `Singapore_test1` and belong to the project `Guance_oversea`.

Based on the time series data shown above, there are three combinations of time series based on the `cpu_use_percent` metric:

`"host":"Hangzhou_test1","project":"Guance"`      
`"host":"Ningxia_test1","project":"Guance"`       
`"host":"Singapore_test1","project":"Guance_oversea"`

Similarly, to calculate all metrics' time series within the current workspace, sum up the number of time series actually counted.

Data is collected by DataKit and reported to a workspace. Specifically, this refers to data queried in DQL where NameSpace is **M**.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Time Series Billing Details</font>](../billing-method/index.md#timeline)


</div>

???+ abstract "Billing Item Statistics"

    New time series counts are tallied every hour within the same day.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 1000) * Unit price (based on the applied data storage strategy)

### Logs {#logs}

Any of the following scenarios will generate log data:

- Enabling log data collection and reporting;
- Configuring monitoring, intelligent inspection, SLO anomaly detection tasks or reporting custom events via OpenAPI;
- Initiating availability tests through self-built nodes and reporting test results.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Log Billing Details</font>](../billing-method/index.md#logs)


</div>

???+ abstract "Billing Item Statistics"

    Log data quantities added within an hour are counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 1,000,000) * Unit price (based on the applied data storage strategy)

???+ warning

    **For different storage types, extremely large log data will be split into multiple entries for billing**:

    **ES Storage**: If log size exceeds 10 KB, the number of billable entries for this log = integer part of (log size / 10 KB)

    **SLS Storage**: If log size exceeds 2 KB, the number of billable entries for this log = integer part of (log size / 2 KB)

    If a single entry is smaller than the above limits, it is still counted as 1 entry.

### Data Forwarding {#backup}

Supports forwarding log data to <<< custom_key.brand_name >>> or four other external storage methods. Based on data forwarding rules, the volume of forwarded data is aggregated and billed.

**Note**: Data forwarded to <<< custom_key.brand_name >>> is still retained in records.
<!--
The console can configure backup rules to synchronize reported log data for backup operations. Data matching backup rules will be stored in the index for data forwarding, and <<< custom_key.brand_name >>> will base its data forwarding capacity statistics on the data under this index.
-->

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Data Forwarding Billing Details</font>](../billing-method/index.md#backup)


</div>

???+ abstract "Billing Item Statistics"

    The capacity of data forwarded within the data storage strategy is counted hourly. Default capacity unit: Bytes.

    Cost Calculation Formula: Daily cost = (Actual billed capacity / 1,000,000,000) * Corresponding unit price

### Network {#network}

- Enabling eBPF network data collection

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Host Reporting Network Data Billing Details</font>](../billing-method/index.md#network)


</div>

???+ abstract "Billing Item Statistics"

    The number of new hosts added within the day is counted hourly.

    Cost Calculation Formula: Daily cost = Actual billed quantity * Corresponding unit price

### Application Performance Trace {#trace}

- Daily Span data count within the workspace.

**Note**: In <<< custom_key.brand_name >>>'s new billing adjustment, the larger value between "quantity/10" and `trace_id` count will be used as the daily billing data.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Application Performance Trace Quantity Billing Details</font>](../billing-method/index.md#trace)


</div>

???+ abstract "Billing Item Statistics"

    The number of new `trace_id` entries added within an hour is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 1,000,000) * Corresponding unit price

### Application Performance Profile {#profile}

- Enabling APM Profile data collection

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Application Performance Profile Quantity Billing Details</font>](../billing-method/index.md#profile)


</div>

???+ abstract "Billing Item Statistics"

    The number of new Profile data entries added within an hour is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 10,000) * Corresponding unit price

???+ warning

    Profile data mainly consists of two parts: **basic attribute data** + **Profile analysis files**.

    If there are oversized Profile analysis files, Profile data will be split into multiple entries for billing.

    If the Profile analysis file size exceeds 300 KB, the billing count = integer part of (Profile analysis file size / 300 KB).

    If the analysis file is smaller than the limit, it is still counted as 1 entry.

### User Access PV {#pv}

- Daily count of Resource, Long Task, Error, Action data within the workspace.

**Note**: In <<< custom_key.brand_name >>>'s new billing adjustment, the larger value between "quantity/100" and PV will be used as the daily billing data.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; User Access PV Quantity Billing Details</font>](../billing-method/index.md#pv)


</div>

???+ abstract "Billing Item Statistics"

    The number of new PV data entries added within an hour is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 10,000) * Price (based on the applied data storage strategy)

### Session Replay {#session}

- Enabling session replay collection

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Billing Details</font>](../billing-method/index.md#session)


</div>

???+ abstract "Billing Item Statistics"

    The number of new sessions added within the day is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 1,000) * Corresponding unit price

???+ warning

    If there are overly active sessions, they will be split into multiple entries for billing based on `time_spent`.

    If `time_spent` > 4 hours, billing count = integer part of (`time_spent` / 4 hours);

    If `time_spent` is less than 4 hours, it is still counted as 1 session.

### Availability Monitoring {#st}

- Initiating availability tests and returning test results via <<< custom_key.brand_name >>> provided testing nodes

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Availability Monitoring Data Billing Details</font>](../billing-method/index.md#st)


</div>

???+ abstract "Billing Item Statistics"

    The number of new test data entries added within an hour is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 10,000) * Corresponding unit price

???+ warning

    Since availability test data is currently stored in the default log index, DQL queries or statistics need to add the following filter conditions to query test data:
    
    `index = ['default'], source = ['http_dial_testing', 'tcp_dial_testing', 'icmp_dial_testing', 'websocket_dial_testing']`.

### Task Triggers {#trigger}

- Enabling monitors, SLO, etc., for periodic detection tasks, where monitor anomaly detection, interval detection, outlier detection, and log detection each count as 5 task triggers per detection, while other detection types count as 1 trigger. Additionally, if the **detection interval** exceeds 15 minutes, any excess is charged at 1 trigger for every additional 15 minutes;

- Intelligent monitoring: Host, log, application intelligent detection counts as 10 triggers per execution; user access intelligent detection counts as 100 triggers per execution.

???+ abstract "Calculation Examples"
     
    :material-numeric-1-circle-outline: Monitor Trigger Counts:

    1. Normal scenario example: Executing one mutation detection counts as 5 task triggers.
    2. Exceeding detection interval example: If the detection interval is 30 minutes, exceeding parts are added incrementally every 15 minutes. For instance, executing one outlier detection counts as 6 task triggers.
    3. Multiple detections and exceeding detection interval example: Executing two interval detections with a combined detection interval of 60 minutes counts as 13 triggers (2 detections * 5 + 3 extra intervals).

    :material-numeric-2-circle-outline: Intelligent Monitoring Trigger Count Example: Executing one host intelligent monitoring counts as 10 task triggers.

- Each DataKit/OpenAPI query counts as 1 task trigger;
- Each metric generation query counts as 1 task trigger;                  
- Each advanced function query provided by Func center counts as 1 task trigger.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Task Trigger Count Billing Details</font>](../billing-method/index.md#trigger)


</div>

???+ abstract "Billing Item Statistics"

    The number of new task triggers added within an hour is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 10,000) * Corresponding unit price

### SMS {#sms}

- Configuring alert strategies for SMS notifications

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SMS Sending Count Billing Details</font>](../billing-method/index.md#sms)


</div>

???+ abstract "Billing Item Statistics"

    The number of new SMS sent within an hour is counted hourly.

    Cost Calculation Formula: Daily cost = (Actual billed quantity / 10) * Unit price


## Billing Example {#example}

Assume Company A uses <<< custom_key.brand_name >>> to monitor its IT infrastructure and application systems comprehensively.

Assume Company A has a total of 10 hosts (each host has a default daily active timeline of 600), generating 6,000 timelines, 2 million log entries, 2 million Trace entries, 20,000 PV entries, and 20,000 task schedules daily. The data storage strategy used is as follows:

| Chargeable Item       | Metrics (Timeline) | Logs | APM Trace | User Access PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| Data Storage Strategy | 3 days           | 7 days | 3 days           | 3 days        |

Specific details are as follows:

| Chargeable Item   | Daily Billing Quantity | Billing Unit Price        | Billing Logic                                                     | Daily Billing Cost |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| Timeline   | 6,000 entries     | $0.6 per thousand entries     | (Actual billed quantity / 1,000) * Unit price<br> i.e., (6,000 entries / 1,000 entries) * $0.6 | $3.6      |
| Logs     | 2 million entries   | $1.2 per million entries | (Actual counted quantity / billing unit) * Unit price<br> i.e., (2 million / 1 million) * $1.2 | $2.4     |
| Trace    | 2 million entries   | $2 per million entries   | (Actual counted quantity / billing unit) * Unit price<br/> i.e., (2 million / 1 million) * $2 | $4       |
| PV       | 20,000 entries     | $0.7 per ten thousand entries   | (Actual counted quantity / billing unit) * Unit price<br/> i.e., (20,000 / 10,000) * $0.7 | $1.4     |
| Task Scheduling | 20,000 times     | $1 per ten thousand times     | (Actual counted quantity / billing unit) * Unit price<br/> i.e., (20,000 / 10,000) * $1 | $2       |

**Note**: Since timelines are incremental billing items, changes in the number of timelines generated by the company will lead to changes in costs.

> More examples of timeline quantity calculations can be found in [Timeline Example](#timeline).

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; <<< custom_key.brand_name >>> Self-developed Time Series Database</font>](./gauncedb.md)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Time Series Billing Item Explanation</font>](./timeline.md)


</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Deep Dive into Time Series Database Storage</font>](https://www.infoq.cn/article/storage-in-sequential-databases)


</div>

</font>