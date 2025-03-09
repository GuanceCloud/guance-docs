---
icon: zy/billing-method
---

# Billing Plan
---


This includes all billing items and pricing models for <<< custom_key.brand_name >>>, helping you fully understand the product pricing of <<< custom_key.brand_name >>> and anticipate cloud costs.

## Billing Items {#item}

All billing items for <<< custom_key.brand_name >>> are **billed separately**. For example, log data you report will incur log storage fees, and application performance trace data you report will incur APM Trace-related fees.

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
<td>￥0.1</td>

</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td>￥0.2</td>
</tr>

<tr >
<td width="40%" rowspan="2">Scheduled Reports</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2</td>
</tr>

<tr >
<td width="40%" rowspan="2">Data Forwarding</td>
<td>CN</td>
<td>￥0.35</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥0.7</td>
</tr>

<tr >
<td width="40%" rowspan="2">Network</td>
<td>CN</td>
<td>￥2</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥4</td>
</tr>

<tr >
<td width="40%" rowspan="2">Session Replay</td>
<td>CN</td>
<td>￥2.5</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2.5</td>
</tr>

<tr >
<td width="40%" rowspan="2">Synthetic Tests</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥10</td>
</tr>

<tr >
<td width="40%" rowspan="2">Triggers</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2</td>
</tr>

<tr >
<td width="40%" rowspan="2">SMS</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >-</td> 
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td width="40%" rowspan="2">Central Pipeline</td>
<td>CN</td>
<td>￥0.1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥0.2</td>
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
<td>￥0.6</td>
<td>￥0.7</td>
<td>￥0.8</td>
<td>￥1</td>
<td>-</td>
<td>￥4</td>
<td>￥7</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥1.6</td>
<td  bgcolor=#FBFBF9 >￥1.8</td>
<td  bgcolor=#FBFBF9 >￥2.2</td>
<td  bgcolor=#FBFBF9 >￥2.4</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >￥8</td>
<td  bgcolor=#FBFBF9 >￥14</td>
</tr>

<tr >
<td rowspan="2" >Logs</td>
<td>CN</td>
<td>￥1</td>
<td>￥1.2</td>
<td>￥1.5</td>
<td>￥2</td>
<td>￥2.5</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2</td>
<td  bgcolor=#FBFBF9 >￥2.4</td>
<td  bgcolor=#FBFBF9 >￥3</td>
<td  bgcolor=#FBFBF9 >￥4</td>
<td  bgcolor=#FBFBF9 >￥5</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td rowspan="2" width="30%" >APM Trace</td>
<td>CN</td>
<td>￥2</td>
<td>￥3</td>
<td>￥6</td>
<td>￥10.8</td>
<td>￥19.44</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥6</td>
<td  bgcolor=#FBFBF9 >￥10</td>
<td  bgcolor=#FBFBF9 >￥20</td>
<td  bgcolor=#FBFBF9 >￥36</td>
<td  bgcolor=#FBFBF9 >￥64.8</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td rowspan="2" width="30%" >APM Profile</td>
<td>CN</td>
<td>￥0.2</td>
<td>￥0.3</td>
<td>￥0.5</td>
<td>-</td>
<td>-</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥0.4</td>
<td  bgcolor=#FBFBF9 >￥0.6</td>
<td  bgcolor=#FBFBF9 >￥1</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td rowspan="2">RUM PV</td>
<td>CN</td>
<td>￥0.7</td>
<td>￥1</td>
<td>￥2</td>
<td>￥3.6</td>
<td>￥6.48</td>
<td>-</td>
<td>-</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2</td>
<td  bgcolor=#FBFBF9 >￥3</td>
<td  bgcolor=#FBFBF9 >￥5</td>
<td  bgcolor=#FBFBF9 >￥9</td>
<td  bgcolor=#FBFBF9 >￥16.2</td>
<td  bgcolor=#FBFBF9 >-</td>
<td  bgcolor=#FBFBF9 >-</td>
</tr>

</table>





### Sensitive Data Scan Traffic {#scanned-data}

Calculated based on the size of the original traffic of sensitive data detected by scan rules (per GB/day).

For example, if a log entry A needs to be scanned for three fields, each field's desensitization scan will be billed separately.

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥0.1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | ￥0.2 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | $ 0.014 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.028 |
---


### Scheduled Reports {#report}

The number of scheduled reports sent daily within the workspace (per report/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | ￥2 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | $ 0.14 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.28 |
---


### Time Series {#timeline}

Counts the number of unique label combinations for all metrics reported through DataKit on a given day (per thousand/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | ￥0.6     | ￥0.7 | ￥0.8  |  ￥1  |    ￥4    |    ￥7    |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | ￥1.6     | ￥1.8 | ￥2.2  |  ￥2.4  |    ￥8    |    ￥14    |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | $ 0.09        | $ 0.1 | $ 0.12  |  $ 0.14  |    $ 0.58   |    $ 1   |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |     180 days   |    360 days     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.23        | $ 0.26 | $ 0.32  |  $ 0.35  |    $ 1.2   |    $ 2   |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Time Series Billing Logic</font>](../billing-method/billing-item.md#timeline)

<br/>

</div>



### Logs {#logs}

#### Billed by Data Volume

Includes data generated by logs, events, security checks, synthetic tests, etc. (per million entries/day).

??? warning

    - If the "Custom Multi-Index" feature is enabled for logs, the actual cost will be calculated based on different indexes' data increment and corresponding storage policy prices.
    - Events include those generated by monitoring tasks, intelligent inspections, and user-defined reports.
    - Synthetic test data is reported by user-defined nodes.
    - The cost for events, security checks, and synthetic tests defaults to the price of the default log index's storage policy.

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | ￥1        |   ￥1.2 | ￥1.5  | ￥2  | ￥2.5   |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | ￥2        |   ￥2.4 | ￥3 | ￥4  | ￥5   |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | $ 0.15       |   $ 0.17 | $ 0.22  | $ 0.28  | $ 0.36   |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.3        |   $ 0.4 | $ 0.5  | $ 0.6  | $ 0.8   |
---

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Log Billing Logic</font>](../billing-method/billing-item.md#logs)

<br/>

</div>

<!--
#### :material-numeric-2-circle-outline: Billed by Ingested Traffic {#ingested-log}

Based on the volume of raw log data ingested (per GB/day).

**Note**: By default, log data is billed by volume. To switch to ingestion-based billing, please contact your account manager.

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | ￥0.6     | ￥0.85 | ￥1 |  ￥1.2  |    ￥1.5    |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | ￥1.4     | ￥2.1 | ￥2.8  |  ￥3.08  |    ￥3.36    |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | $ 0.1        | $ 0.15 | $ 0.2  |  $ 0.22  |    $ 0.24   |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days |    60 days   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.2        | $ 0.3 | $ 0.4  |  $ 0.44  |    $ 0.48   |
---

-->

### Data Forwarding {#backup}

:material-numeric-1-circle: Based on the type of external archival storage used in the current workspace, the forwarded traffic size is summarized and counted daily (per GB/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>   |     |
    | -------- | ---------- |
    | China Sites   | ￥0.35        |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>   |     |
    | -------- | ---------- |
    |  Hong Kong and International Sites   | ￥0.7        |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   |  $ 0.05 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.1 |
---

:material-numeric-2-circle: Based on the internal storage type within <<< custom_key.brand_name >>>, the forwarded traffic size is summarized and counted daily (per GB/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥0.007 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  ￥0.014 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   |  $ 0.001 |

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

Counts the number of hosts reporting network data within the workspace (per host/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥2 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  ￥4 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   |  $ 0.29 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.6 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Network Host Billing Logic</font>](../billing-method/billing-item.md#network)

<br/>

</div>


### APM Trace {#trace}

Counts the number of Traces in the reported tracing data. Generally, if Span data has the same `trace_id`, these Spans are grouped under one Trace (per million Traces/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | ￥2 |  ￥3  |  ￥6  |  ￥10.8  |  ￥19.44  |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | ￥6 |  ￥10  |  ￥20  |  ￥36  |  ￥64.8  |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | $ 0.29 |  $ 0.43 |  $ 0.86 |  $ 1.54 |  $ 2.78 |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.9 |  $ 1.4 |  $ 2.8 |   $ 5.14 |  $ 9.26 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; APM Trace Billing Logic</font>](../billing-method/billing-item.md#trace)

<br/>

</div>


### APM Profile {#profile}

Counts the number of APM Profile data entries reported (per ten thousand Profiles/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    | China Sites   |￥0.2 |  ￥0.3  |  ￥0.5|

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites |￥0.4 |  ￥0.6  |  ￥1|

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    | China Sites   |$ 0.03 |  $ 0.04  |  $ 0.07|

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  |
    | -------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites |$ 0.06 |  $ 0.09  |  $ 0.14|
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; APM Profile Billing Logic</font>](../billing-method/billing-item.md#profile)

<br/>

</div>

### RUM PV {#pv}

Counts the number of page views from user visits, generally derived from Resource, Long Task, Error, Action data (per ten thousand PVs/day).

**Note**: Whether it's an SPA (Single Page Application) or MPA (Multi-Page Application), each visit to a page (including refreshes or re-entry) counts as one PV.

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | ￥0.7 | ￥1  |  ￥2| ￥3.6  |  ￥6.48|

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | ￥2 | ￥3  |  ￥5| ￥9  |  ￥16.2 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | China Sites   | $ 0.1 | $ 0.14  |  $ 0.29| $ 0.51  |  $ 0.93 |

=== "Hong Kong and International Sites"

    | Data Storage Policy |3 days         | 7 days   | 14 days  | 30 days   | 60 days  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  Hong Kong and International Sites | $ 0.29 | $ 0.43  |  $ 0.71 |  $ 1.29 |  $ 2.31 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; RUM PV Billing Logic</font>](../billing-method/billing-item.md#pv)

<br/>

</div>

### Session Replay {#session}

Counts the number of Sessions that have actual session replay data. This is generally derived from the count of `session_id` with `has_replay: true` (per thousand Sessions/day).


<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥2.5 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  ￥2.5 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | $ 0.35 |

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

Charges for using the Synthetic Tests feature (per ten thousand API tests/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites | ￥10 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | $ 0.143 |

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

Charges for using anomaly detection, metric generation, etc. (per ten thousand triggers/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  ￥2 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   |  $ 0.14 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.3 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Triggers Billing Logic</font>](../billing-method/billing-item.md#trigger)

<br/>

</div>

### SMS {#sms}

Counts the number of SMS messages sent on a given day (per ten messages/day).

<font color=coral>**When settled in Renminbi**:</font>

| <font size=2>Details</font>  |    |   |
|-------- | ---------- |---------- |
| China Sites  | RMB   |  ￥1 |

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; SMS Billing Logic</font>](../billing-method/billing-item.md#sms)

<br/>

</div>

### Central Pipeline {#pipeline}

Counts the size of the original log data processed by the central pipeline (per GB/day).

<font color=coral>**When settled in Renminbi**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   | ￥0.1 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  ￥0.2 |

<font color=coral>**When settled in US Dollars**:</font>

=== "China Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    | China Sites   |  $ 0.014 |

=== "Hong Kong and International Sites"

    | <font size=2>Details</font>  |  |
    | -------- | ---------- |
    |  Hong Kong and International Sites |  $ 0.028 |
---