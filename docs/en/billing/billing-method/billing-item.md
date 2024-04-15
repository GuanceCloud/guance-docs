# Logic Behind Billing 
---


???+ quote "Release Note"

    **October 19, 2023**: The billing item Data Forward will be charged based on the data forwarding rules, and the forwarded data volume will be separately counted for billing.

    **September 26, 2023**：

    - Add Span Quantity Statistics to APM billing items, where the billing data for the day is calculated as the maximum value between "Quantity/10" and the number of `trace_id` occurrences.
    - Add new statistics logic to RUM billing items: calculate the Resource, Long Task, Error, and Action data within the workspace, and the billing data for the day is calculated as the maximum value between "Quantity/100" and the number of PV occurrences.

    **April 20, 2023**

    I. Guance's self-developed timeseries database GuanceDB is newly launched, and the timeseries data storage and billing will be adjusted as follows:

    - The infrastructure (DataKit) billing item goes offline, and the original two billing modes of "DataKit + Timeline" and "Timeline Only" are used as billing logic according to GuanceDB Timeline Only;

    - GuanceDB timeline: count the number of active timelines on the same day, and the unit price is as low as 0.6/per thousand timelines. See [Timeline Description](#timeline)；
  
    II. RUM Session replay officially starts to charge, and charges according to the number of sessions actually collected Session playback data, namely ￥10/per thousand sessions. Refer to [Session Instruction](#session).

**Maybe you want to know:**

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Guance's Self-Developed Timeseries Database —— GuanceDB</font>](../billing-method/gauncedb.md)

<br/>

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Description of Timeseries Billing Items</font>](../billing-method/timeline.md)

<br/>

</div>

## Overview

This article mainly introduces the billing generation and price calculation logic of each billing item under the pay-as-you-go billing framework for Guance products.

## Concepts

| Glossary   | Description |
| -------- | ---------- |
| Data Storage Strategy   | Guance supports users to customize the saving time for different data types. The corresponding storage time option configuration can refer to [Data Storage Strategy](data-storage.md).|
| Basic Billing   | The unit price of a billing item is a <u>fixed value</u>. |
| Gradient Billing   | The unit price of a billing item is a <u>dynamic value</u>, which will have <u>different single value</u> according to the data storage strategy selected by the current data type. |

## Billing Cycle {#cycle}

The billing period of Guance is <font color=coral>days</font>, that is, according to the statistical usage of the workspace on the same day, the daily bill is generated and synchronized to Guance [Billing Center](../../billing/cost-center/index.md), and finally the consumption amount is deducted from the corresponding account according to the actual binding settlement method.

## Billing Methods {#account}

Guance supports various settlement methods such as Guance Billing Center account and cloud account. Cloud account settlement includes Alibaba Cloud account settlement, AWS account settlement and Huawei Cloud account settlement. In cloud account settlement mode, cloud bills from multiple sites are supported to be merged into one cloud account for settlement. 

> See [Guance Settlement Methods](../../billing/billing-account/index.md).



## Billing Items {#item}

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Items and Billing Detailss</font>](../billing-method/index.md)

<br/>

</div>

### Timeseries {#timeline}

The timing engine of Guance mainly involves the following basic concepts:

| Glossary   | Description |
| -------- | ---------- |
| Measurement   | In general, it is used to represent a set corresponding to a certain statistical value, which is more like the concept of `table` in relational database in principle. |
| Data Point   | When applied to the metric data reporting scenario, it refers to an metric data sample, which can be analogized to `row` data in relational database. |
| Time   | Time stamp represents the time when data points are generated, which can also be understood as the time when DataKit collects a certain index data generation row protocol and reports it. |
| Metrics   | Generally, data of numerical type will change with the change of timestamp. For example, `cpu_total`,`cpu_use`,`cpu_use_pencent`, etc., which are common in CPU measurement, are all metrics. |
| Tags   | Generally, attribute information that does not change with timestamp is stored. For example, the common fields such as `host`、`project` in CPU measurement are label attributes, which are used to identify the actual object attributes of metrics. |

#### <u>Example</u> {#example}

![](../img/billing-2.png)

Using the example above, the CPU measurement has a total of 6 data points based on a single metric, each with a time field: `time`, an metric: `cpu_use_pencent`, and two tags: `host` and `project`. The first and fourth rows of data show the CPU usage (`cpu_use_pencent`) for `host` named `Hangzhou_test1` and `project` belonging to Guance, followed by the second and fifth rows showing the CPU usage for `host` named `Ningxia_test1` and `project` belonging to Guance, and the third and sixth rows showing the CPU usage for `host` named `Singapore_test1` and `project` belonging to Guance_oversea.

Based on the statistical data on the timeline above, there are a total of 3 combinations of timelines based on the metric `cpu_use_pencent`, which are:

`"host":"Hangzhou_test1","project":"Guance"`

`"host":"Ningxia_test1","project":"Guance"`

`"host":"Singapore_test1","project":"Guance_oversea"`

Similarly, if you need to calculate the timeline for all metrics in the current workspace, simply add up the actual timelines for each metric to get the total.

#### Billing Generation

Metric data is collected through DataKit and reported to a workspace. This specifically refers to the data obtained by querying the NameSpace in DQL that starts with **M**.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Timeseries Billing Details</font>](../billing-method/index.md#timeline)

<br/>

</div>

#### Billing Statistics

The number of newly added timelines within each hour of <u>a day</u> is calculated, and the maximum value of the 24 data points is taken as the actual billing quantity.

#### Billing Formula

Daily cost = actual billing quantity / 1000 * unit price (corresponding to the data storage strategy above)

### Logs


#### Billing Generation

Any of the following situations will generate corresponding log data:

- Log data collection and reporting is enabled.  
- Exception detection tasks such as monitoring, intelligent inspections, SLO configuration, or custom events are enabled or reported through OpenAPI.  
- Availability testing tasks are enabled, and testing data is triggered to be reported through self-built testing nodes.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Logs Billing Details</font>](../billing-method/index.md#logs)

<br/>

</div>

#### Billing Statistics

The number of log data points added in each hour is calculated in increments of 1 hour and the sum of the 24 resulting data points is used as the actual billing quantity.

???+ warning

    <u>For ultra-large log data, it will be split into multiple pieces for billing according to different storage types</u>:

    **ES Storage**: If the log size exceeds 10 KB, the number of logs billed for this log is equal to the integer value of (log size / 10 KB).  

    **SLS Storage**: If the log size exceeds 2 KB, the number of logs billed for this log is equal to the integer value of (log size / 2 KB).

    If the size of a single data is less than the above limits, it will still be counted as 1 piece.

#### Billing Formula

Daily Cost = Actual billing quantity / 1000000 * Unit price (corresponding unit price applied based on the above data storage pricing strategy)

### Data Forward {#backup}

#### Billing Generation

Guance supports four ways to forward log data to external storage. Based on the data forwarding rules, the size of the forwarded traffic is counted for billing purposes.

**Notes**: The data forwarded to the Observation Cloud for storage will still be kept as records.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Backup Log Data Billing Details</font>](../billing-method/index.md#backup)

<br/>

</div>

#### Billing Statistics

The capacity size of the backup log is calculated in increments of each hour within the data storage strategy. The maximum value of the 24 resulting data points is used as the actual billing quantity. The default capacity unit is Bytes.

#### Billing Formula

Daily Cost = Actual billing capacity / 1000000000 * Corresponding unit price

### Network Monitoring

#### Billing Generation

- Enable EBPF network data collection.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Report Network Data Host Billing Details</font>](../billing-method/index.md#network)

<br/>

</div>

#### Billing Statistics

The number of new hosts added within each day is calculated in increments of each hour. The maximum value of the 24 resulting data points is used as the actual billing quantity.

#### Billing Formula

Daily Cost = Actual billing quantity * Corresponding unit price

### Application Performance Trace

#### Billing Generation

- Statistics of the daily number of Span data generated in the workspace.

**Note**: In the new billing adjustment of Guance, the larger value between "quantity/10" and the number of `trace_id` will be used as the billing data for the day.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Application Performance Trace Billing Details</font>](../billing-method/index.md#trace)

<br/>

</div>

#### Billing Statistics

The number of new `trace_id` added within each hour is calculated in increments of each hour. The sum of the 24 resulting data points is used as the actual billing quantity.

#### Billing Formula

Daily Cost = Actual billing quantity / 1000000 * Corresponding unit price

### Application Performance Profile


#### Billing Generation

- Enable application performance Profile data collection.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Application Performance Profile Billing Details</font>](../billing-method/index.md#pv)

<br/>

</div>

#### Billing Statistics

The number of new profile data added within each hour is calculated in increments of each hour. The sum of the 24 resulting data points is used as the actual billing quantity.

???+ warning

    Profile data consists of two parts: **Basic Properties Data + Profile Analysis File**:

    If there is an ultra-large profile analysis file, the profile data will be split into multiple pieces for billing.

    If the profile analysis file data is greater than 300 KB, the number of billing items is equal to the integer value of (Profile analysis file size / 300 KB).

    If the analysis file is less than the above limit, it will still be counted as 1 piece.

#### Billing Formula

Daily Cost = Actual billing quantity / 10000 * Corresponding unit price

### Real User Monitoring PV


#### Billing Generation

- Daily statistics of the quantity of Resources, Long Tasks, Errors, and Actions generated within the workspace.

**Note**: In the new billing adjustment of Guance, the "Quantity/100" will be used along with the larger value in PV as the billing data for the day.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Real User Monitoring PV Billing Details</font>](../billing-method/index.md#pv)

<br/>

</div>

#### Billing Statistics

The number of new PV data added within each hour is calculated in increments of each hour. The sum of the 24 resulting data points is used as the actual billing quantity.

#### Billing Formula

Daily Cost = Actual billing quantity / 10000 * Unit price (*corresponding unit price applied based on the above data storage pricing strategy*)

### Session Replay {#session}


#### Billing Generation

- Enable Session Replay collection.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Billing Details</font>](../billing-method/index.md#session)

<br/>

</div>

#### Billing Statistics

The number of new Sessions added within each day is calculated in increments of each hour. The maximum value of the 24 resulting data points is used as the actual billing quantity.

???+ warning

    If there is an ultra-long active Session, the Session will be split into multiple pieces for billing according to `time_spent`.

    If the Session `time_spent` > 4 hours, the number of billing items is equal to the integer value of (time_spent / 4 hours).

    If the Session `time_spent` is less than the above 4 hours, it will still be counted as 1 Session.

#### Billing Formula

Daily Cost = Actual billing quantity / 1000 * Corresponding unit price

### Synthetic Tests {#st} 

#### Billing Generation

- Enable availability test tasks and return test results through the provided testing nodes of Guance.
  
#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Synthetic Tests Billing Details</font>](../billing-method/index.md#st)

<br/>

</div>

#### Billing Statistics

The number of newly added dialing and testing data within one hour is counted at an hourly interval, and 24 data points are finally obtained, which are summed as the actual billing number.

???+ warning

    Because the dialing data is currently stored in the log **default** index, DQL queries or statistics need to add the following filters to query the dialing data.
    
    `index = ['default'], source = [‘http_dial_testing',‘tcp_dial_testing’,'icmp_dial_testing','websocket_dial_testing']`.

#### Billing Formula

Daily Cost = Actual billing quantity / 10000 * Corresponding unit price

### Triggers

#### Billing Generation

- Turn on regular detection tasks such as monitor and SLO;

- Open the generation index;

- Start the alarm notification sending;

- Select the advanced function query provided by the central Func.      

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Triggers Billing Details</font>](../billing-method/index.md#trigger)

<br/>

</div>

#### Billing Statistics

The number of new tasks in one hour is counted at an hourly interval, and after 24 data points are finally obtained, the sum is taken as the actual billing quantity.

#### Billing Formula

Daily Cost = Actual billing quantity / 10000 * Corresponding unit price

### SMS {#sms}


#### Billing Generation

- Alarm policy configuration SMS notification sending.

#### Billing Details

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SMS Billing Details</font>](../billing-method/index.md#sms)

<br/>

</div>

#### Billing Statistics 

The number of new short messages sent within one hour is counted at an hourly interval, and after 24 data points are finally obtained, the sum is taken as the actual billing quantity.

#### Billing Formula

Daily Cost = Actual billing quantity / 10 * Corresponding unit price


## Billing Example {#example}


Suppose Company A uses Guance to observe the IT infrastructure and application systems of the company as a whole.


Assuming that Company A has a total of 10 hosts (the default daily active timeline of each host is 600), it generates 6,000 timelines, 2 million log data, 2 million Trace data, 20,000 PV data and 20,000 task schedules every day. The data storage strategy used is as follows:


| Billing Item       | Metric (timeseries) | Log | AP Trace | User access PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| Data storage strategy | 3 days           | 7 days | 3 days           | 3 days        |

The details are as follows:

| Billing Item   | Daily Billing Quantity | Billing Unit Price        | Billing Logic                                                     | Daily Billing Fee |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| Timeseries   | 6000     | 0.6 / per thousand     | (actual statistical quantity  / 1000 * Unit price<br>namely 6000 / 1000 * 0.6      | 3.6     |
| Log     | 2 million   | 1.2 / per million | (actual statistical quantity / billing unit) * unit price<br>namely (2 million / 1 million * 1.2 | 2.4     |
| Trace    | 200,000   | 2 /per  million   | (actual statistical quantity / billing unit) * unit price<br/>namely (2 million / 1 million * 2 | 4       |
| PV       | 200,000     | 0.7 / 10,000   | (actual statistical quantity / billing unit) * unit price<br/>namely （20,000 / 10,000） * 0.7 | 1.4     |
| Task scheduling | 20,000     | 1 / 10,000    | (actual statistical quantity / Billing Unit) * unit price<br/>namely (20,000 / 10,000） * 1 | 2       |

**Note**: Because the timeseries is a full Billing Item, the change of the timeseries may lead to an increase in the number of timeseries and incur expenses. 

> For more timeseries quantity measurements, see [Timeseries Example](#timeline).
