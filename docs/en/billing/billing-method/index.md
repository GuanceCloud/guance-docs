# Billing Methods
---

???+ quote "Release Note"

    **October 11, 2023**: The Hong Kong site of China is now online, following the existing overseas pricing system.

    **August 24, 2023**: 

    - New billing item: [Data Forward](#backup) are saved to external storage.
    - [APM Trace](#trace) and [RUM PV](#pv) add 30-day/60-day data storage policy.

    **August 17, 2023**

    - New billing item: [Sensitive Data Scanner](#scanned-data).


    **August 10, 2023**

    - New billing items: [Report](#report)、[Ingested Log](#ingested-log).


## Overview

When you open the workspace of Commercial Plan and start using it, Guance provides a <font color=coral>pay-as-you-go billing method</font>. This article will introduce all the current billing items and their pricing models for Guance.


## Billing Items {#item}

All charging items of Guance are <font color=coral>charged separately</font>. For example, the log data you report will incur the cost of log storage, and the application performance link tracking data you report will incur the cost related to application performance trace.

Detailed billing items of Guance and their corresponding statistical scope and billing types are as follows:

![](../img/billing-1.png)

**Note**: You can view the statistics of each billing item, historical billing, usage statistical trends and other information of the previous day in the Guance **Console > Billing**.

### Sensitive Data Scanner {#scanned-data}

Based on the scanning rules, the statistics of the original traffic size of the scanned data (per GB/day).

For example, if a piece of log data A needs to be scanned, and the three fields in the data need to be processed with desensitization rules, the desensitization scan of these three fields will be billed separately.

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | ￥ 0.1 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 0.2 |

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.014 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  $ 0.028 |
---

### Regular Report {#report}

Number of times a report is sent per day in the workspace (each time/day).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | ￥ 1 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 2 |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.14 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  $ 0.28 |
---

<!--
### Ingested Log {#ingested-log}

The amount of original ingested log reported by users (per GB/day).

**Note**: Please contact your account manager about how to issue this billing item.

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | ￥ 0.6     | ￥ 0.85 | ￥ 1 |  ￥ 1.2  |    ￥ 1.5    |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 1.4     | ￥ 2.1 | ￥ 2.8  |  ￥ 3.08  |    ￥ 3.36    |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.1        | $ 0.15 | $ 0.2  |  $ 0.22  |    $ 0.24   |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 0.2        | $ 0.3 | $ 0.4  |  $ 0.44  |    $ 0.48   |
---

-->
### Timeseries {#timeline}

It is used to count the number of tag combinations corresponding to all metric in the metric data reported by the user through DataKit in days (per thousand records/days).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | ￥ 0.6     | ￥ 0.7 | ￥ 0.8  |  ￥ 1  |    ￥ 4    |    ￥ 7    |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 1.6     | ￥ 1.8 | ￥ 2.2  |  ￥ 2.4  |    ￥ 8    |    ￥ 14    |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.09        | $ 0.1 | $ 0.12  |  $ 0.14  |    $ 0.58   |    $ 1   |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 0.23        | $ 0.26 | $ 0.32  |  $ 0.35  |    $ 1.2   |    $ 2   |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of Timeseries</font>](../billing-method/billing-item.md#timeline)

<br/>

</div>



### Logs {#logs}

#### Billed by the number of data pieces.

The data generated by the use of functions such as logs, events, security check, and availability dialing (per million records/days).

???+ warning

    - If the Custom Multi-Index feature is enabled for logs, the data will be counted based on different indexes to calculate the actual cost according to the corresponding data storage pricing strategy.    
    - Events include events generated by monitoring modules (monitoring, SLO) configuration detection tasks, events reported by intelligent inspections, and events reported by users.     
    - Availability testing data is reported by self-built testing nodes.        
    - The cost of events, security inspections, and availability testing data is calculated based on the data storage pricing strategy of the "Default" index for logs.    

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days | 60 Days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | ￥ 1        |   ￥ 1.2 | ￥ 1.5  | ￥ 2  | ￥ 2.5   |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days | 60 Days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 2        |   ￥ 2.4 | ￥ 3 | ￥ 4  | ￥ 5   |

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days | 60 Days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.15       |   $ 0.17 | $ 0.22  | $ 0.28  | $ 0.36   |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days | 60 Days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 0.3        |   $ 0.4 | $ 0.5  | $ 0.6  | $ 0.8   |
---

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of Logs</font>](../billing-method/billing-item.md#logs)

<br/>

</div>

<!--

#### :material-numeric-2-circle-outline: Billed by ingested traffic {#ingested-log}

The original log writing traffic size reported by users (per GB/Days).

**Note**: Log data is billed according to the number of records by default. If you need to switch to billing by ingested traffic, please contact the account manager.

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days |    60 Days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | ￥ 0.6     | ￥ 0.85 | ￥ 1 |  ￥ 1.2  |    ￥ 1.5    |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days |    60 Days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 1.4     | ￥ 2.1 | ￥ 2.8  |  ￥ 3.08  |    ￥ 3.36    |

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days |    60 Days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.1        | $ 0.15 | $ 0.2  |  $ 0.22  |    $ 0.24   |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 Days         | 7 Days   | 14 Days  | 30 Days |    60 Days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 0.2        | $ 0.3 | $ 0.4  |  $ 0.44  |    $ 0.48   |
---
-->


### Data Forward {#backup}

Based on the different types of external archives of backup logs in the current workspace, the forwarded traffic volume is counted and summarized, and billed according to the data (per GB/day).

<font color=coral>**When settled in RMB**：</font>

=== "China Site"

    | <font size=2>Details</font>   |     |
    | -------- | ---------- |
    | China Site   | ￥ 0.35        |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Details</font>   |     |
    | -------- | ---------- |
    | Chinese Hong Kong and Overseas Sites   | ￥ 0.7        |

<font color=coral>**When settled in USD**：</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.05 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  $ 0.1 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of Data Forward</font>](../billing-method/billing-item.md#backup)

<br/>

</div>


### Network Monitoring {#network}

The number of hosts statistically reported by network data uploaded by eBPF in the workspace（each reporting network data host / day).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | ￥ 2 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  ￥ 4 |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.29 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  $ 0.6 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of report network data host</font>](../billing-method/billing-item.md#network)

<br/>

</div>


### APM Traces {#trace}

The number of traces in the uploaded link data is statistically counted. In general, if the `trace_id` of the span data is the same, these spans will be classified under one trace（per million traces / day).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | ￥ 2 |  ￥ 3  |  ￥ 6  |  ￥ 18  |  ￥ 60  |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |￥ 6 |  ￥ 10  |  ￥ 20  |  ￥ 60  |  ￥ 200  |

<font color=coral>**当采用美元结算**：</font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.29 |  $ 0.43 |  $ 0.86 |  $ 2.58 |  $ 8.58 |

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 0.9 |  $ 1.4 |  $ 2.8 |   $ 8.4 |  $ 28 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of APM Traces</font>](../billing-method/billing-item.md#trace)

<br/>

</div>


### APM Profiles {#profile}

The number of application performance profile data uploaded is statistically counted.（per 10,000 profiles / day).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    | China Site   |￥0.2 |  ￥ 0.3  |  ￥ 0.5|

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |￥0.4 |  ￥ 0.6  |  ￥ 1|


<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    | China Site   |$ 0.03 |  $ 0.04  |  $ 0.07|

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |$ 0.06 |  $ 0.09  |  $ 0.14|
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of APM Profiles</font>](../billing-method/billing-item.md#profile)

<br/>

</div>

### RUM PV {#pv}

Statistical number of page views accessed by users that is reported. Generally, the number of view_id in the View data is used（every 10k PV / day).

**Note**: Whether it is an SPA (single-page application) or an MPA (multi-page application), every time a user visits a page (including refresh or re-entry), it counts as 1 PV.



<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | ￥ 0.7 | ￥ 1  |  ￥ 2| ￥ 6  |  ￥ 20|

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 2 | ￥ 3  |  ￥ 5| ￥ 15  |  ￥ 50 |

<font color=coral>**When settled in USD**：</font>

=== "China Site"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.1 | $ 0.14  |  $ 0.29| $ 0.87  |  $ 2.9|

=== "Chinese Hong Kong and Overseas Sites"

    | Data Storage Strategy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 0.29 | $ 0.43  |  $ 0.71|  $ 2.13|  $ 7.1|
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of RUM PV </font>](../billing-method/billing-item.md#pv)

<br/>

</div>

### Session Replay {#session}

Statistical number of Sessions that actually generated session replay data. Generally, the number of session_id in the Session data that has has_replay: true is used（per thousand Sessions / days).


<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | ￥ 10 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  ￥ 15.4 |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 1.43 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | $ 2.2 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of Session Replay</font>](../billing-method/billing-item.md#session)

<br/>

</div>



### Synthetic Monitoring {#st}

Enable availability test tasks and return test results through the provided testing nodes of Guance（every 10k API dails / days).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | ￥ 1 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites | ￥ 10 |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.143 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  $ 1.43 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of Synthetic Monitoring</font>](../billing-method/billing-item.md#st)

<br/>

</div>

### Triggers {#trigger}

The cost incurred by using functions such as anomaly detection and generate metrics (per 10k times/days).

<font color=coral>**When settled in RMB**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   | ￥ 1 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  ￥ 2 |
---

<font color=coral>**When settled in USD**: </font>

=== "China Site"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.14 |

=== "Chinese Hong Kong and Overseas Sites"

    | <font size=2>Detail</font>  |  |
    | -------- | ---------- |
    |  Chinese Hong Kong and Overseas Sites |  $ 0.3 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of Triggers</font>](../billing-method/billing-item.md#trigger)

<br/>

</div>

### SMS {#sms}

Count the number of short messages sent on the same day(every 10 times / days).

<font color=coral>**When settled in RMB**: </font>

| <font size=2>Detail</font>  |    |   |
|-------- | ---------- |---------- |
| China Site  | RMB   |  ￥ 1 |

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Logic of SMS</font>](../billing-method/billing-item.md#sms)

<br/>

</div>


## FAQ

:material-numeric-1-circle: Why should we distinguish between RMB settlement and USD settlement?

In response to the different needs of customers domestic and overseas，Guance has launched two sets of settlement center systems, [the domestic version](https://boss.guance.com/) and [Chinese Hong Kong and overseas version](https://bill.guance.one/). The former is settled in RMB, while the latter is settled in US dollars. In each system, there will be different pricing for different site logins, see above for details.

:material-numeric-2-circle: What should I do if I want to change the currency settlement method, for example, from RMB settlement to USD settlement?

Please contact your account manager directly.

