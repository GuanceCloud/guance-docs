# Logic Behind Billing 
---


???- quote "Release Notes"

    **November 2, 2023**:

    1. Support for data forwarding to internal storage of Guance, with daily billing based on the size of data saved to Guance storage objects within the workspace;
    2. Adjustment to the billing item "Trigger" logic:
        - The "Mutation Detection," "Interval Detection," "Outlier Detection," and "Log Detection" monitors are adjusted to "5 Task Triggers" per detection, with other detection types remaining unchanged;
        - Add DataKit/OpenAPI query count statistics, with each query counted as "One Task Trigger."


    **October 19, 2023**: The billing item Data Forward will be charged based on the data forwarding rules, and the forwarded data volume will be separately counted for billing.

    **September 26, 2023**：

    1. Add Span Quantity Statistics to APM billing items, where the billing data for the day is calculated as the maximum value between "Quantity/10" and the number of `trace_id` occurrences.
    2. Add new statistics logic to RUM billing items: calculate the Resource, Long Task, Error, and Action data within the workspace, and the billing data for the day is calculated as the maximum value between "Quantity/100" and the number of PV occurrences.

    **April 20, 2023**

    1. Guance's self-developed timeseries database GuanceDB is newly launched, and the timeseries data storage and billing will be adjusted as follows:

        - The infrastructure (DataKit) billing item goes offline, and the original two billing modes of "DataKit + Timeline" and "Timeline Only" are used as billing logic according to GuanceDB Timeline Only;

        - GuanceDB timeline: count the number of active timelines on the same day, and the unit price is as low as 0.6/per thousand timelines. See [Timeline Description](#timeline)；
  
    2. RUM Session replay officially starts to charge, and charges according to the number of sessions actually collected Session playback data, namely ￥10/per thousand sessions. Refer to [Session Instruction](#session).

**Maybe you want to know:**

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Guance's Self-Developed Timeseries Database —— GuanceDB</font>](../billing-method/gauncedb.md)


</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Description of Timeseries Billing Items</font>](../billing-method/timeline.md)


</div>


This article mainly introduces the billing generation and price calculation logic of each billing item under the pay-as-you-go billing framework for Guance products.

## Concepts

| <div style="width: 130px">Glossary</div>   | Description |
| -------- | ---------- |
| [Storage Strategy](data-storage.md)   | Guance supports users to customize the saving time for different data types. |
| Basic Billing   | The unit price of a billing item is a **fixed value**. |
| Gradient Billing   | The unit price of a billing item is a **dynamic value**, which will have **different single value** according to the data storage strategy selected by the current data type. |

## Billing Cycle {#cycle}

The billing period of Guance is **days**, that is, according to the statistical usage of the workspace on the same day, the daily bill is generated and synchronized to Guance [Billing Center](../../billing-center/index.md), and finally the consumption amount is deducted from the corresponding account according to the actual binding settlement method.

## Billing Methods {#account}

Guance supports various settlement methods such as Guance Billing Center account and cloud account. Cloud account settlement includes Alibaba Cloud account settlement, AWS account settlement and Huawei Cloud account settlement. In cloud account settlement mode, cloud bills from multiple sites are supported to be merged into one cloud account for settlement. 

> See [Guance Settlement Methods](../../billing/billing-account/index.md).



## Billing Items {#item}

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Items and Billing Detailss</font>](../billing-method/index.md)


</div>

### Timeseries {#timeline}

The timing engine of Guance mainly involves the following basic concepts:

| Glossary   | Description |
| -------- | ---------- |
| Measurements   | In general, it is used to represent a set corresponding to a certain statistical value, which is more like the concept of `table` in relational database in principle. |
| Data Points   | When applied to the metric data reporting scenario, it refers to an metric data sample, which can be analogized to `row` data in relational database. |
| Time   | Time stamp represents the time when data points are generated, which can also be understood as the time when DataKit collects a certain index data generation row protocol and reports it. |
| Metrics   | Generally, data of numerical type will change with the change of timestamp. For example, `cpu_total`,`cpu_use`,`cpu_use_pencent`, etc., which are common in CPU measurement, are all metrics. |
| Tags   | Generally, attribute information that does not change with timestamp is stored. For example, the common fields such as `host`、`project` in CPU measurement are label attributes, which are used to identify the actual object attributes of metrics. |

#### Example {#example}

![](../img/billing-2.png)

Using the example above, the CPU measurement has a total of 6 data points based on a single metric, each with a time field: `time`, an metric: `cpu_use_pencent`, and two tags: `host` and `project`. The first and fourth rows of data show the CPU usage (`cpu_use_pencent`) for `host` named `Hangzhou_test1` and `project` belonging to Guance, followed by the second and fifth rows showing the CPU usage for `host` named `Ningxia_test1` and `project` belonging to Guance, and the third and sixth rows showing the CPU usage for `host` named `Singapore_test1` and `project` belonging to Guance_oversea.

Based on the statistical data on the timeline above, there are a total of 3 combinations of timelines based on the metric `cpu_use_pencent`, which are:

`"host":"Hangzhou_test1","project":"Guance"`

`"host":"Ningxia_test1","project":"Guance"`

`"host":"Singapore_test1","project":"Guance_oversea"`

Similarly, if you need to calculate the timeline for all metrics in the current workspace, simply add up the actual timelines for each metric to get the total.


Metric data is collected through DataKit and reported to a workspace. This specifically refers to the data obtained by querying the NameSpace in DQL that starts with **M**.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Timeseries</font>](../billing-method/index.md#timeline)



</div>

???+ abstract "Billing Statistics"

    The number of newly added timelines within each hour of **a day** is calculated, and the maximum value of the 24 data points is taken as the actual billing quantity.

    Formula: Daily cost = actual billing quantity/1,000 * unit price (corresponding to the data storage strategy above)

### Logs



Any of the following situations will generate corresponding log data:

- Log data collection and reporting is enabled.  
- Exception detection tasks such as monitoring, intelligent inspections, SLO configuration, or custom events are enabled or reported through OpenAPI.  
- Availability testing tasks are enabled, and testing data is triggered to be reported through self-built testing nodes.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Logs</font>](../billing-method/index.md#logs)



</div>

???+ abstract "Billing Statistics"

    The number of log data points added in each hour is calculated in increments of 1 hour and the sum of the 24 resulting data points is used as the actual billing quantity.

    Formula: Daily Cost = Actual billing quantity/1,000,000 * Unit price (corresponding unit price applied based on the above data storage pricing strategy)

???+ warning

    **For ultra-large log data, it will be split into multiple pieces for billing according to different storage types**:

    **ES Storage**: If the log size exceeds 10 KB, the number of logs billed for this log is equal to the integer value of (log size/10 KB).  

    **SLS Storage**: If the log size exceeds 2 KB, the number of logs billed for this log is equal to the integer value of (log size/2 KB).

    If the size of a single data is less than the above limits, it will still be counted as 1 piece.
    


### Data Forward {#backup}

Support for forwarding log data to Guance or four other types of external storage. Based on data forwarding rules, the traffic size of the forwarded data is aggregated and billed accordingly.


**Notes**: The data forwarded to Guance for storage will still be kept as records.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Data Forwarding</font>](../billing-method/index.md#backup)



</div>

???+ abstract "Billing Statistics"

    The capacity size of the backup log is calculated in increments of each hour within the data storage strategy. The maximum value of the 24 resulting data points is used as the actual billing quantity. The default capacity unit is Bytes.
    
    Formula: Daily Cost = Actual billing capacity/1,000,000,000 * Corresponding unit price

### Network Monitoring


- Enable EBPF network data collection.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing for the host reporting network data</font>](../billing-method/index.md#network)



</div>

???+ abstract "Billing Statistics"

    The number of new hosts added within each day is calculated in increments of each hour. The maximum value of the 24 resulting data points is used as the actual billing quantity.
    
    Formula: Daily Cost = Actual billing quantity * Corresponding unit price

### APM Trace


- Statistics of the daily number of Span data generated in the workspace.

**Note**: In the new billing adjustment of Guance, the larger value between "quantity/10" and the number of `trace_id` will be used as the billing data for the day.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; APM Trace</font>](../billing-method/index.md#trace)



</div>

???+ abstract "Billing Statistics"

    The number of new `trace_id` added within each hour is calculated in increments of each hour. The sum of the 24 resulting data points is used as the actual billing quantity.
    
    Formula: Daily Cost = Actual billing quantity/1,000,000 * Corresponding unit price

### APM Profile



- Enable application performance Profile data collection.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; APM Profile</font>](../billing-method/index.md#pv)



</div>

???+ abstract "Billing Statistics"

    The number of new profile data added within each hour is calculated in increments of each hour. The sum of the 24 resulting data points is used as the actual billing quantity.
        
    Formula: Daily Cost = Actual billing quantity/10000 * Corresponding unit price

???+ warning

    Profile data consists of two parts: **Basic Properties Data + Profile Analysis File**:

    If there is an ultra-large profile analysis file, the profile data will be split into multiple pieces for billing.

    If the profile analysis file data is greater than 300 KB, the number of billing items is equal to the integer value of (Profile analysis file size/300 KB).

    If the analysis file is less than the above limit, it will still be counted as 1 piece.


### RUM PV



- Daily statistics of the quantity of Resources, Long Tasks, Errors, and Actions generated within the workspace.

**Note**: In the new billing adjustment of Guance, the "Quantity/100" will be used along with the larger value in PV as the billing data for the day.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Real User Monitoring PV</font>](../billing-method/index.md#pv)



</div>

???+ abstract "Billing Statistics"

    The number of new PV data added within each hour is calculated in increments of each hour. The sum of the 24 resulting data points is used as the actual billing quantity.
    
    Formula: Daily Cost = Actual billing quantity/10,000 * Unit price (*corresponding unit price applied based on the above data storage pricing strategy*)

### Session Replay {#session}



- Enable Session Replay collection.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay</font>](../billing-method/index.md#session)



</div>

???+ abstract "Billing Statistics"

    The number of new Sessions added within each day is calculated in increments of each hour. The maximum value of the 24 resulting data points is used as the actual billing quantity.

    Formula: Daily Cost = Actual billing quantity/1,000 * Corresponding unit price

???+ warning

    If there is an ultra-long active Session, the Session will be split into multiple pieces for billing according to `time_spent`.

    If the Session `time_spent` > 4 hours, the number of billing items is equal to the integer value of (time_spent/4 hours).

    If the Session `time_spent` is less than the above 4 hours, it will still be counted as 1 Session.
    


### Synthetic Tests {#st} 


- Enable availability test tasks and return test results through the provided testing nodes of Guance.
  

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Synthetic Tests</font>](../billing-method/index.md#st)



</div>

???+ abstract "Billing Statistics"

    The number of newly added dialing and testing data within one hour is counted at an hourly interval, and 24 data points are finally obtained, which are summed as the actual billing number.

    Formula: Daily Cost = Actual billing quantity/10,000 * Corresponding unit price

???+ warning

    Because the dialing data is currently stored in the log **default** index, DQL queries or statistics need to add the following filters to query the dialing data.
    
    `index = ['default'], source = [‘http_dial_testing',‘tcp_dial_testing’,'icmp_dial_testing','websocket_dial_testing']`.
    


### Triggers

- Activate monitoring tasks such as monitors and SLOs, where mutation detection, interval detection, outlier detection, and log detection in monitors are counted as 5 triggers per detection, and other detection types are counted as 1 trigger. Additionally, if the **detection interval** exceeds 15 minutes, the excess is counted as an additional 1 trigger for every 15 minutes exceeded;

- Intelligent Monitoring: Each execution of host, log, and application intelligent detection is counted as 10 triggers; each execution of user access intelligent detection is counted as 100 triggers.

???+ abstract "Calculation Example"
     
    :material-numeric-1-circle-outline: Monitor Trigger Count:

    1. Normal condition calculation example: Assuming one execution of **mutation detection**, it is calculated as 5 triggers.
    2. Calculation example when exceeding the detection interval: If the detection interval is 30 minutes, the excess is rounded up by 1 for every 15 minutes. For example, one execution of **outlier detection** is calculated as 6 triggers.
    3. Calculation example when multiple detection types and exceeding the detection interval: Two executions of **interval detection**, with a cumulative detection interval of 60 minutes, is calculated as 13 triggers (2 detections * 5 + 3 intervals exceeded).

    :material-numeric-2-circle-outline: Intelligent Monitoring Trigger Count Calculation Example: Assuming one execution of **host intelligent monitoring**, it is calculated as 10 triggers.

- Each DataKit/OpenAPI query is counted as 1 trigger;
- Each query to generate metrics is counted as 1 trigger;                  
- Each query using advanced functions provided by the central Func is counted as 1 trigger.
   


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Triggers</font>](../billing-method/index.md#trigger)



</div>

???+ abstract "Billing Statistics"

    The number of new tasks in one hour is counted at an hourly interval, and after 24 data points are finally obtained, the sum is taken as the actual billing quantity.
    
    Formula: Daily Cost = Actual billing quantity/10,000 * Corresponding unit price

### SMS {#sms}



- Alert strategy configuration SMS notification sending.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SMS</font>](../billing-method/index.md#sms)



</div>

???+ abstract "Billing Statistics"

    The number of new short messages sent within one hour is counted at an hourly interval, and after 24 data points are finally obtained, the sum is taken as the actual billing quantity.
    
    Formula: Daily Cost = Actual billing quantity/10 * Corresponding unit price


## Use Case {#example}


Suppose Company A uses Guance to observe the IT infrastructure and application systems of the company as a whole.


Assuming that Company A has a total of 10 hosts (the default daily active timeline of each host is 600), it generates 6,000 timelines, 2 million log data, 2 million Trace data, 20,000 PV data and 20,000 task schedules every day. The data storage strategy used is as follows:


| Billing Item       | Metric (timeseries) | Log | AP Trace | User access PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| Data storage strategy | 3 days           | 7 days | 3 days           | 3 days        |

The details are as follows:

| Billing Item   | Daily Billing Quantity | Billing Unit Price        | Billing Logic                                                     | Daily Billing Fee |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| Timeseries   | 6,000     | 0.6/per thousand     | (actual statistical quantity /1000 * Unit price<br>namely (6,000/1,000) * 0.6      | 3.6     |
| Logs     | 2 million   | 1.2/per million | (actual statistical quantity/billing unit) * unit price<br>namely (2 million/1 million) * 1.2 | 2.4     |
| Trace    | 200,000   | 2 /per  million   | (actual statistical quantity/billing unit) * unit price<br/>namely (2 million/1 million) * 2 | 4       |
| PV       | 200,000     | 0.7/10,000   | (actual statistical quantity/billing unit) * unit price<br/>namely （20,000/10,000) * 0.7 | 1.4     |
| Triggers | 20,000     | 1/10,000    | (actual statistical quantity/Billing Unit) * unit price<br/>namely (20,000/10,00) * 1 | 2       |

**Note**: Because the timeseries is a full Billing Item, the change of the timeseries may lead to an increase in the number of timeseries and incur expenses. 

> For more timeseries quantity measurements, see [Timeseries Example](#timeline).
