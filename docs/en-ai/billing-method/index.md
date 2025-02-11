---
icon: zy/billing-method
---

# Billing Plan
---


This includes all the billing items and pricing models of Guance, helping you fully understand the product prices of Guance and anticipate cloud costs in advance.

## Billing Items {#item}

All billing items of Guance are **billed separately**. For example, log data you report will incur log storage fees, and application performance tracing data you report will incur APM Trace-related fees.

<!--
<img src="img/billing-1.png" width="70%" >


## Pricing Model

**Note:**

1. `CN` stands for China region sites;
2. `Intl(incl HK)` stands for Hong Kong and international sites.

### Renminbi Settlement

<table>

<tr >
<th colspan="9">Basic Billing</th>
</tr>

<tr >
<th width="40%" > Billing Item </th> 
<th> Site </th>
<th> Price </th> 
<th>  </th> 
<th>  </th> 
<th>  </th> 
<th>  </th> 
<th> </th> 
<th>  </th> 
</tr>

<tr >
<td width="40%" rowspan="2">Sensitive Data Scan Traffic</td>
<td>CN</td>
<td>RMB 0.1</td>

</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td>RMB 0.2</td>
</tr>

<tr >
<td width="40%" rowspan="2">Scheduled Reports</td>
<td>CN</td>
<td>RMB 1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 2</td>
</tr>

<tr >
<td width="40%" rowspan="2">Data Forwarding</td>
<td>CN</td>
<td>RMB 0.35</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 0.7</td>
</tr>

<tr >
<td width="40%" rowspan="2">Network</td>
<td>CN</td>
<td>RMB 2</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 4</td>
</tr>

<tr >
<td width="40%" rowspan="2">Session Replay</td>
<td>CN</td>
<td>RMB 2.5</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 2.5</td>
</tr>

<tr >
<td width="40%" rowspan="2">Synthetic Tests</td>
<td>CN</td>
<td>RMB 1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 10</td>
</tr>

<tr >
<td width="40%" rowspan="2">Triggers</td>
<td>CN</td>
<td>RMB 1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 2</td>
</tr>

<tr >
<td width="40%" rowspan="2">SMS</td>
<td>CN</td>
<td>RMB 1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >-</td> 
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td width="40%" rowspan="2">Central Pipeline</td>
<td>CN</td>
<td>RMB 0.1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 0.2</td>
</tr>

<tr >
<th colspan="9">Tiered Billing</th>
</tr>

<tr >
<th> </th> 
<th>  </th> 
<th>3d</th>
<th>7d</th>
<th>14d</th>
<th>30d</th>
<th>60d</th>
<th>180d</th>
<th>360d</th>
</tr>

<tr >
<td rowspan="2">Time Series</td>
<td>CN</td>
<td>RMB 0.6</td>
<td>RMB 0.7</td>
<td>RMB 0.8</td>
<td>RMB 1</td>
<td>-</td>
<td>RMB 4</td>
<td>RMB 7</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 1.6</td>
<td  bgcolor=#FBFBF9 >RMB 1.8</td>
<td  bgcolor=#FBFBF9 >RMB 2.2</td>
<td  bgcolor=#FBFBF9 >RMB 2.4</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >RMB 8</td>
<td  bgcolor=#FBFBF9 >RMB 14</td>
</tr>

<tr >
<td rowspan="2" >Logs</td>
<td>CN</td>
<td>RMB 1</td>
<td>RMB 1.2</td>
<td>RMB 1.5</td>
<td>RMB 2</td>
<td>RMB 2.5</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 2</td>
<td  bgcolor=#FBFBF9 >RMB 2.4</td>
<td  bgcolor=#FBFBF9 >RMB 3</td>
<td  bgcolor=#FBFBF9 >RMB 4</td>
<td  bgcolor=#FBFBF9 >RMB 5</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td rowspan="2" width="30%" >APM Trace</td>
<td>CN</td>
<td>RMB 2</td>
<td>RMB 3</td>
<td>RMB 6</td>
<td>RMB 10.8</td>
<td>RMB 19.44</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 6</td>
<td  bgcolor=#FBFBF9 >RMB 10</td>
<td  bgcolor=#FBFBF9 >RMB 20</td>
<td  bgcolor=#FBFBF9 >RMB 36</td>
<td  bgcolor=#FBFBF9 >RMB 64.8</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td rowspan="2" width="30%" >APM Profile</td>
<td>CN</td>
<td>RMB 0.2</td>
<td>RMB 0.3</td>
<td>RMB 0.5</td>
<td>-</td>
<td>-</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 0.4</td>
<td  bgcolor=#FBFBF9 >RMB 0.6</td>
<td  bgcolor=#FBFBF9 >RMB 1</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td rowspan="2">User Visit PV</td>
<td>CN</td>
<td>RMB 0.7</td>
<td>RMB 1</td>
<td>RMB 2</td>
<td>RMB 3.6</td>
<td>RMB 6.48</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >RMB 2</td>
<td  bgcolor=#FBFBF9 >RMB 3</td>
<td  bgcolor=#FBFBF9 >RMB 5</td>
<td  bgcolor=#FBFBF9 >RMB 9</td>
<td  bgcolor=#FBFBF9 >RMB 16.2</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

</table>



### Sensitive Data Scan Traffic {#scanned-data}

This is based on the original traffic size of sensitive data scanned according to scan rules (per GB per day).

For example, if a log entry A needs to be scanned, and three fields within this data require desensitization rule processing, then each field's desensitization scan will be billed separately.

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 0.1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | RMB 0.2 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.014 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.028 |
---


### Scheduled Reports {#report}

This refers to the number of scheduled reports sent daily within the workspace (per time per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | RMB 2 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.14 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.28 |
---


### Time Series {#timeline}

This counts the number of unique label combinations for metrics reported through DataKit by users on that day (per thousand per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | RMB 0.6     | RMB 0.7 | RMB 0.8  |  RMB 1  |    RMB 4    |    RMB 7    |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | RMB 1.6     | RMB 1.8 | RMB 2.2  |  RMB 2.4  |    RMB 8    |    RMB 14    |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.09        | $ 0.1 | $ 0.12  |  $ 0.14  |    $ 0.58   |    $ 1   |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.23        | $ 0.26 | $ 0.32  |  $ 0.35  |    $ 1.2   |    $ 2   |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Time Series Billing Logic</font>](../billing-method/billing-item.md#timeline)

<br/>

</div>



### Logs {#logs}

#### Charged by Data Volume

This includes data generated from features such as logs, events, security checks, synthetic tests (per million entries per day).

??? warning

    - If logs have "Custom Multi-index" enabled, the data increment of different indexes will be counted, and the actual cost will be calculated based on the corresponding data retention policy price.
    - Events include those generated by monitoring configurations (monitors, SLOs), intelligent inspections, and user-defined events.
    - Synthetic tests are reported by user-defined nodes.
    - The fees for events, security checks, and synthetic tests default to the price of the "default" index of logs.

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | RMB 1        |   RMB 1.2 | RMB 1.5  | RMB 2  | RMB 2.5   |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | RMB 2        |   RMB 2.4 | RMB 3 | RMB 4  | RMB 5   |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.15       |   $ 0.17 | $ 0.22  | $ 0.28  | $ 0.36   |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.3        |   $ 0.4 | $ 0.5  | $ 0.6  | $ 0.8   |
---

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Log Billing Logic</font>](../billing-method/billing-item.md#logs)

<br/>

</div>

<!--
#### :material-numeric-2-circle-outline: Ingested Log Billing {#ingested-log}

This is based on the volume of raw log data ingested (per GB per day).

**Note**: Logs are charged by volume by default. If you need to switch to ingest-based billing, please contact your account manager.

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | RMB 0.6     | RMB 0.85 | RMB 1 |  RMB 1.2  |    RMB 1.5    |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | RMB 1.4     | RMB 2.1 | RMB 2.8  |  RMB 3.08  |    RMB 3.36    |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.1        | $ 0.15 | $ 0.2  |  $ 0.22  |    $ 0.24   |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.2        | $ 0.3 | $ 0.4  |  $ 0.44  |    $ 0.48   |
---

-->

### Data Forwarding {#backup}

:material-numeric-1-circle: Based on the type of external archiving for data forwarding in the current workspace, it aggregates the forwarded traffic volume and bills based on the incremental data reported daily (per GB per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>   |     |
    | -------- | ---------- |
    | China Site   | RMB 0.35        |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>   |     |
    | -------- | ---------- |
    | Hong Kong and International Sites   | RMB 0.7        |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.05 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.1 |
---

:material-numeric-2-circle: Based on the internal storage type of Guance for data forwarding in the current workspace, it aggregates the forwarded traffic volume and bills based on the total data reported (per GB per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 0.007 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  RMB 0.014 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.001 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.002 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Data Forwarding Billing Logic</font>](../billing-method/billing-item.md#backup)

<br/>

</div>


### Network {#network}

The number of hosts reporting network data within the workspace (per host per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 2 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  RMB 4 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.29 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.6 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Host Reporting Network Data Billing Logic</font>](../billing-method/billing-item.md#network)

<br/>

</div>


### APM Trace {#trace}

This counts the number of Traces in the reported trace data. Generally, if Span data has the same `trace_id`, these Spans are grouped under one Trace (per million Traces per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | RMB 2 |  RMB 3  |  RMB 6  |  RMB 10.8  |  RMB 19.44  |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | RMB 6 |  RMB 10  |  RMB 20  |  RMB 36  |  RMB 64.8  |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.29 |  $ 0.43 |  $ 0.86 |  $ 1.54 |  $ 2.78 |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.9 |  $ 1.4 |  $ 2.8 |   $ 5.14 |  $ 9.26 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; APM Trace Billing Logic</font>](../billing-method/billing-item.md#trace)

<br/>

</div>


### APM Profile {#profile}

This counts the number of APM Profile data points reported (per ten thousand Profiles per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    | China Site   |RMB 0.2 |  RMB 0.3  |  RMB 0.5|

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites |RMB 0.4 |  RMB 0.6  |  RMB 1|

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    | China Site   |$ 0.03 |  $ 0.04  |  $ 0.07|

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites |$ 0.06 |  $ 0.09  |  $ 0.14|
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; APM Profile Billing Logic</font>](../billing-method/billing-item.md#profile)

<br/>

</div>

### User Visit PV {#pv}

This counts the number of page views from user visits, generally derived from the number of Resource, Long Task, Error, and Action data points reported daily (per ten thousand PVs per day).

**Note**: Whether it's an SPA (Single Page Application) or MPA (Multi-page Application), each visit to a page (including refreshes or re-entry) counts as 1 PV.

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | RMB 0.7 | RMB 1  |  RMB 2| RMB 3.6  |  RMB 6.48|

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | RMB 2 | RMB 3  |  RMB 5| RMB 9  |  RMB 16.2 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Site   | $ 0.1 | $ 0.14  |  $ 0.29| $ 0.51  |  $ 0.93 |

=== "Hong Kong and International Sites"

    | Data Retention Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.29 | $ 0.43  |  $ 0.71 |  $ 1.29 |  $ 2.31 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; User Visit PV Billing Logic</font>](../billing-method/billing-item.md#pv)

<br/>

</div>

### Session Replay {#session}

This counts the number of Sessions with actual session replay data. It is generally derived from the count of `session_id` where `has_replay: true` (per thousand Sessions per day).


<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 2.5 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  RMB 2.5 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.35 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | $ 0.35 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Billing Logic</font>](../billing-method/billing-item.md#session)

<br/>

</div>



### Synthetic Tests {#st}

This is the fee incurred from using the synthetic testing feature (per ten thousand API dial tests per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | RMB 10 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | $ 0.143 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 1.43 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Synthetic Tests Billing Logic</font>](../billing-method/billing-item.md#st)

<br/>

</div>

### Triggers {#trigger}

This is the fee incurred from using anomaly detection, metric generation, and other features (per ten thousand times per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  RMB 2 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.14 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.3 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Trigger Billing Logic</font>](../billing-method/billing-item.md#trigger)

<br/>

</div>

### SMS {#sms}

This counts the number of SMS messages sent on that day (per ten messages per day).

<font color=coral>**When settled in RMB**:</font>

| <font size=2>Details</font>  |    |   |
|-------- | ---------- |---------- |
| China Site  | RMB   |  RMB 1 |

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SMS Billing Logic</font>](../billing-method/billing-item.md#sms)

<br/>

</div>

### Central Pipeline {#pipeline}

This counts the size of raw log data processed by the central pipeline (per GB per day).

<font color=coral>**When settled in RMB**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   | RMB 0.1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  RMB 0.2 |

<font color=coral>**When settled in USD**:</font>

=== "China Site"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Site   |  $ 0.014 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.028 |
---

</input_content>
<target_language>英语</target_language>
</input>