# Billing Method
---


## Overview

When you open the business workspace of Guance and start using it, Guance provides a pay-as-you-go billing method. This article mainly introduces the detailed information of pay-as-you-go for Guance products, including [billing cycle](#cycle), [billing method](#account), [billing item](#item), [billing price](#price), [billing mode](#method) and [billing example](#example).

## Billing Cycle {#cycle}

The billing period of Guance is "days", that is, according to the statistical usage of the workspace on the same day, the daily bill is generated and synchronized to Guance [expense center](../../billing/cost-center/index.md), and finally the consumption amount is deducted from the corresponding account according to the actual binding settlement method.

## Settlement Method {#account}

Guance supports various settlement methods such as Guance enterprise account and cloud account. Cloud account settlement includes Alibaba Cloud account and AWS account settlement. In cloud account settlement mode, cloud bills from multiple sites are supported to be merged into one cloud account for settlement. Please refer to [Guance settlement method](../../billing/billing-account/index.md).

## Billing Item {#item}

All charging items of Guance are charged separately. For example, the log data you report will incur the cost of log storage, and the application performance link tracking data you report will incur the cost related to application performance Trace.

???+ attention

    - The statistical range of Guance billing items can be divided into "incremental statistics" and "full statistics", and the statistical range corresponding to different billing items is different. Please refer to [statistical range](#count) for detailed logic.
    
    - Guance metric data is charged according to the number of "timeline". For detailed logic, please refer to [timeline example](#time-example)
    
    - You can view the statistics of each billing item, historical billing, usage statistical trends and other information of the previous day in the Guance workspace payment plan and billing.

### Statistical Range {#count}

**Total Statistics**

In the current workspace, count the amount of all data within the current data storage policy as of now.

Note: Data storage policies for different types of data in Guance support custom selection. Please refer to [data storage policy](../../billing/billing-method/data-storage.md) for details.

**Incremental Statistic**

Under the current workspace, count the amount of data generated on that day.

### Billing Item Description

Detailed billing items for Guance are shown below, and the specific price is shown in [billing price](#price).

| **Billing Item**       | **Billing Instructions**                                                 | **Statistical Range** | **Billing Type** |
| ---------------- | ------------------------------------------------------------ | ------------ | ------------ |
| DataKit          | Count the number of DataKits in the workspace that have historically survived for 12 hours or more and still survived on the same day, and the survival time is calculated from the start of DataKit.<br><br>**Note:** <br><li>DataKit quantity statistics is the maximum value within 24 hours<li>After the host installs DataKit and starts collecting data, changing the host name `host_name` will add a new host by default, so it will be counted as 2 hosts for charging in this charging period. | Incremental Statistics     | Basic Billing     |
| Timeseries           | Count the number of timelines generated by all metric data in the workspace.<br><br>**Note:** Metric data is composed of four parts: time, measurement, metrics and label. The timeline number of a single measurement is equal to how many label combinations exist under the current measurement in a certain period of time. The number of timelines in the Guance workspace = the sum of timelines of all measurements in the workspace. For details, please refer to [timeseries example](#time-example). | Total Statistics     | Basic Billing     |
| Network (host)     | Count the number of hosts with network data reported on the same day in the workspace.           | Incremental Statistics     | Basic Billing     |
| Log data       | Statistics the amount of log data reported in the workspace on the same day.<br>Scope of statistics:<br><li>Log data<br><li>Self-built node dial test data（ `source= [‘http_dial_testing',‘tcp_dial_testing’,'icmp_dial_testing','websocket_dial_testing'] ` and `owner != default` ）<br><li>scheck<br><li>event data<br>-Events generated by monitoring and intelligent check（`source=monitor`）<br>- User-defined escalation events（`source=custom`）<br><br>**Note:**Oversized log data will be split into multiple pieces for charging, and the calculation logic is different according to different storage methods, including ES storage and SLS storage.<br><li>ES storage: Log size exceeds 10 KB, number of log billing = integer (log size/10 KB)<br><li>SLS storage: Log size exceeds 2 KB, number of log charges = integer (log size/2 KB). For more information on storage, please refer to the doc [data storage policy](../../billing/billing-method/data-storage.md). | Incremental Statistics      | Gradient Billing     |
| Backup log capacity     | Statistics the storage capacity of backup logs in the workspace                             | Total Statistics     | Basic Billing     |
| AP Trace   | Count the number of trace_id with unique application performance reported in the workspace on the same day<br>Statistical data range: trace data of application performance link tracing | Incremental Statistics      | Gradient Billing     |
| AP Profile | Statistical data range: trace data of application performance link tracing<br>Data statistics range: Profile basic data + data of each Profile analysis file<br><br>**Note:**Oversized Profile analysis file data will be split into multiple pieces for billing.<br><li> Profile profiling file data less than 300 KB, count by 1<br><li> Profile profiling file data larger than 300 KB, billing number = integer (Profile profiling file size/300 KB) | Incremental Statistics      | Gradient Billing     |
| User Access PV      | Count the number of page views visited by users reported on the same day in the workspace<br>Statistical data range: view data accessed by users | Incremental Statistics      | Gradient Billing     |
| Usability dialing test       | Count the number of dialing data reported on the same day in the workspace (only count the data returned by dialing nodes provided by Guance)<br>Scope of statistics: dailing statistics of `source= [‘http_dial_testing',‘tcp_dial_testing’,'icmp_dial_testing','websocket_dial_testing'] ` | Incremental Statistics      | Basic Billing     |
| Task Scheduling         | Count the number of task calls generated in the workspace on the same day<br>Statistical data range: Monitor timing detection task, generating index timing task, and sending alarm notification will all generate task call | Incremental Statistics      | Basic Billing     |
| SMS             | Count the number of short messages sent in the workspace on the same day                             | Incremental Statistics      | Basic Billing     |

## Billing Price {#price}

### Basic Billing

| **Billing Item**   | **Billing Unit** | **Price** |
| ------------ | ------------ | -------- |
| DataKit      | Each 1 unit      | 3 yuan     |
| Timeseries       | Per 1,000   | 3 yuan     |
| Network (host) | Each 1 unit      | 2 yuan     |
| Backup log capacity | Every 1 GB      | 0.007 yuan |
| Usability dialing test   | Every 10,000 times    | 1 yuan     |
| Task invocation     | Every 10,000 times   | 1 yuan     |
| SMS         | Every 10 times     | 1 yuan     |

### Gradient Billing

Guance enables you to select different [data storage policies](../../billing/billing-method/data-storage.md) for different data types, and gradient billing is based on the billing statistics of your selected data storage policies.

#### Log Data {#log}

| **Billing Item**   | **Billing Unit** | **Gradient Price** |        |       |        |
| ------------ | ------------ | ------------ | ------ | ----- | ------ |
| Data storage strategy |              | 7 days         | 14 days  | 30 days | 60 days  |
| Log data   | Per million     | 1.2 yuan       | 1.5 yuan | 2 yuan  | 2.5 yuan |

Note: The saving strategy of log data finally determines the unit price according to the saving strategy of log data.

#### AP Trace {#trace}

| **Billing Item**       | **Billing Unit** | **Gradient Price** |        |        |
| ---------------- | ------------ | ------------ | ------ | ------ |
| Data storage strategy     |              | 3 days         | 7 days   | 14 days  |
| AP Trace   | Per million     | 2 yuan         | 3 yuan   | 6 yuan   |
| AP Profile | Every 10,000 articles    | 0.2 yuan       | 0.3 yuan | 0.5 yuan |

#### User Access PV {#pv}

| **Billing Item**   | **Billing Unit** | **Gradient Price** |      |       |
| ------------ | ------------ | ------------ | ---- | ----- |
| Data storage strategy |              | 3 days         | 7 days | 14 days |
| User access PV  | Every 10,000 articles    | 0.7 yuan       | 1 yuan | 2 yuan  |

## Billing Mode {#method}

Under SaaS billing-by-volume mode, users can freely choose the billing mode according to the characteristics of reported data.

### Default Billing Logic {#default}

Calculate the bill of the day according to the Billing Item listed above, and both DataKit and Timeline are charged. In this mode, each DataKit will come with 300 free timelines by default. Therefore, the actual timeline quantity will be charged after deducting the free quantity. The calculation logic is as follows:

- Billing Timeline Quantity = Timeline Quantity-DataKit Quantity * 300
- Billing Timeline Quantity Billing = (Timeline Quantity-DataKit Quantity * 300)/1000 * Unit Price.

Note: If the calculated number of billing timelines is less than 0, it will be calculated according to 0.

### Timeline Only + Data Billing Logic {#time-data}

In this mode, DataKit does not charge, and there is no free timeline logic. Except for DataKit and timeline billing logic changes, other data Billing Item logic remains unchanged. The calculation logic is as follows:

- Billing Timeline Quantity = Timeline Quantity
- Billing Timeline Quantity Billing = Timeline Quantity/1000 * Unit Price


### Billing Logic {#gradient}

- Billing Item Bill = Billing Unit Quantity * Unit Price
- Billing Item Item Units = Actual Statistical Number / Billing Unit(Note: the result value is not carried here, and two decimal places of the value are reserved)

## Billing Sample {#example}

### Timeline Number Measurement Example {#time-example}

**Basic Conceptual**

Metric data is composed of four parts: time, measurement, metrics and label. The timeline number of a single measurement is equal to how many label combinations exist under the current measurement in a certain period of time. The number of timelines in Guance workspace = the sum of timelines of all measurement in the workspace.

**Timeline of Statistical Measurements**

DataKit collects host and K8s cluster metric data generation timeline estimation:

| Measurement   | Metrics                                               | Timeseries Estimation                                        |
| -------- | -------------------------------------------------- | ------------------------------------------------- |
| Host     | Single disk and single network card per host                             | About 20 ~ 30 timeseries                            |
| K8S cluster | 16 Node<br>300 POD<br>Meric data saving strategy: 14 days | About 6409 timeseries<br>![](../img/2.billing_1.png) |

You can also estimate your timeline data based on the following example:

Suppose you collect the metric `http_response` from two hosts ( `host: A` and `host: B`) simultaneously to monitor application access. There are two labels here:

- `host`: Including `host: A` and `host: B` 
- `status_code`: Including `status_code: 200`, `status_code: 404` and `status_code: 500`

Suppose ` host: A ` has two requests that return status codes and ` host: B ` has three requests that return status codes, as shown in the following diagram:

<img src="../img/3.billing_time_1.png" width=800px />

According to the diagram above, the measurement  `http_response` will produce five timelines.

```
 host: A ， status_code: 200 
 host: A ， status_code: 404 
 host: B ， status_code: 200 
 host: B ， status_code: 404 
 host: B ， status_code: 500 
```

**Label-based Timeseries of Change Statistics Measurement**

Based on the above schematic diagram, we add a label `url` to the measurement `http_response`, including two values `https://docs.guance.com/` and `https://www.guance.com/`, and then the measurement  `http_response` will produce 10 timelines (i.e. 5*2=10).

```
 host: A ， status_code: 200 ， url: https://docs.guance.com/
 host: A ， status_code: 200 ， url: https://www.guance.com/
 host: A ， status_code: 404 ， url: https://docs.guance.com/
 host: A ， status_code: 404 ， url: https://www.guance.com/
 host: B ， status_code: 200 ， url: https://docs.guance.com/
 host: B ， status_code: 200 ， url: https://www.guance.com/
 host: B ， status_code: 404 ， url: https://docs.guance.com/
 host: B ， status_code: 404 ， url: https://www.guance.com/
 host: B ， status_code: 500 ， url: https://docs.guance.com/
 host: B ， status_code: 500 ， url: https://www.guance.com/
```

Based on the above example, we add a tag `host_ip` to the measurement `http_response`. Since the values of `host_ip` and `host` are one-to-one, the measurement `http_response` will not generate more timelines, that is, although a tag attribute is added, only 10 timelines will be generated.

```
 host: A ， status_code: 200 ， url: https://docs.guance.com/ ， host_ip: 192.168.0.1
 host: A ， status_code: 200 ， url: https://www.guance.com/ ， host_ip: 192.168.0.1
 host: A ， status_code: 404 ， url: https://docs.guance.com/ ， host_ip: 192.168.0.1
 host: A ， status_code: 404 ， url: https://www.guance.com/ ， host_ip: 192.168.0.1
 host: B ， status_code: 200 ， url: https://docs.guance.com/ ， host_ip: 192.168.0.2
 host: B ， status_code: 200 ， url: https://www.guance.com/ ， host_ip: 192.168.0.2
 host: B ， status_code: 404 ， url: https://docs.guance.com/ ， host_ip: 192.168.0.2
 host: B ， status_code: 404 ， url: https://www.guance.com/ ， host_ip: 192.168.0.2
 host: B ， status_code: 500 ， url: https://docs.guance.com/ ， host_ip: 192.168.0.2
 host: B ， status_code: 500 ， url: https://www.guance.com/ ， host_ip: 192.168.0.2
```

### Other Expense Related Examples

Suppose Company A uses Guance to observe the IT infrastructure and application systems of the company as a whole.

#### Example One

Suppose Company A has 10 hosts and produces 500 timelines, 2 million log data, 2 million Trace data, 20,000 PV data and 20,000 task schedules every day. The data storage strategy used is as follows:

| Billing Item       | Metric (timeline) | Log | AP Trace | User access PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| Data storage strategy | 3 days           | 7 days | 3 days           | 3 days        |

Using [default billing logic](#default), the daily cost is 39.8 yuan, and the specific details are as follows:

| Billing Item   | Daily Billing Quantity | Billing Unit Price        | Billing Logic                                                     | Daily Billing Fee |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| Host     | 10 sets      | 3 yuan / per host       | (Actual statistical quantity / Billing Unit) * unit price<br/>（10台 / 1 台） * 3 yuan | 30 yuan      |
| Timeline   | 500 articles     | 3 元 / 千条     | （时间线数量 - DataKit数量 * 300）/ 1000 * unit price<br>即 （500 条 - 10 台 * 300 条） / 1000 条 * 3 元 | 0 yuan       |
| Log     | 2 million  | 1.2 元 / 百万条 | (Actual statistical quantity / Billing Unit) * unit price<br>即 （2 百万 / 1 百万） * 1.2 元 | 2.4 yuan     |
| Trace    | 2 million   | 2 元 / 百万个   | (Actual statistical quantity / Billing Unit) * unit price<br/>即 （2 百万 / 1 百万） * 2 元 | 4 yuan       |
| PV       | 20,000     | 0.7 元 / 万个   | (Actual statistical quantity / Billing Unit) * unit price<br/>即 （2 万 / 1 万） * 0.7 元 | 1.4 yuan     |
| Task scheduling |20,000     | 1 元 / 万次     | (Actual statistical quantity / Billing Unit) * unit price<br/>即 （2 万 / 1 万） * 1 元 | 2 yuan       |

Note: Because the timeline is a full Billing Item, the change of the timeline may lead to an increase in the number of timelines and incur expenses. For more timeline quantity measurements, please refer to the doc [timeline example](#time-example).



#### Example 2

Suppose that Company A has a total of 10 hosts, generating 500 timelines, 2 million log data, 2 million Trace data, 20,000 PV data and 20,000 task schedules every day. The data storage strategy used is as follows:

| Billing Item       | Metric (timeline) | Log | AP Trace | User access PV |
| ------------ | -------------- | ---- | -------------- | ----------- |
| Data storage strategy | 3 days           | 7 days | 3 days           | 3 days        |

Using [timeline only + data billing logic](#time-data), the daily cost is 11.3 yuan, and the details are as follows:

| Billing Item   | Daily Billing Quantity | Billing Unit Price        | Billing Logic                                                     | Daily Billing Fee |
| -------- | ---------- | --------------- | ------------------------------------------------------------ | ---------- |
| Host     | 10      | /               | /                                                            | /          |
| Timeseries   | 500 条     | 3 元 / 千条     | 时间线数量  / 1000 * 单价<br>即 500 条 / 1000 条 * 3 元      | 1.5 元     |
| Log     | 200 万条   | 1.2 元 / 百万条 | (实际统计数量 / Billing Unit) * 单价<br>即 （2 百万 / 1 百万） * 1.2 元 | 2.4 元     |
| Trace    | 200 万个   | 2 元 / 百万个   | (实际统计数量 / Billing Unit) * 单价<br/>即 （2 百万 / 1 百万） * 2 元 | 4 元       |
| PV       | 2 万个     | 0.7 元 / 万个   | (实际统计数量 / Billing Unit) * 单价<br/>即 （2 万 / 1 万） * 0.7 元 | 1.4 元     |
| Task scheduling | 2 万次     | 1 元 / 万次     | (实际统计数量 / Billing Unit) * 单价<br/>即 （2 万 / 1 万） * 1 元 | 2 元       |

Note: Because the timeline is a full Billing Item, the change of the timeline may lead to an increase in the number of timelines and incur expenses. For more timeline quantity measurements, please refer to the doc [timeline example](#time-example).
