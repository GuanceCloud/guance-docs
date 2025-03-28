---
icon: zy/billing-method
---

# 计费方案
---


包括<<< custom_key.brand_name >>>所有的计费项及其定价模型，助您全面了解<<< custom_key.brand_name >>>产品价格，提前了解云成本。

## 计费项 {#item}

<<< custom_key.brand_name >>>的所有计费项都是**单独计费**，例如您上报的日志数据会产生日志存储的费用，您上报的应用性能链路追踪数据会产生应用性能 Trace 相关费用。

<!--
<img src="img/billing-1.png" width="70%" >


## 价格模型

**注意：**

1. `CN` 表示中国区站点；
2. `Intl(incl HK)` 表示中国香港及海外站点。

### 以人民币结算

<table>

<tr >
<th colspan="9">基础计费</th>
</tr>

<tr >
<th width="40%" > 计费项 </th> 
<th> 站点 </th>
<th> 价格 </th> 
<th>  </th> 
<th>  </th> 
<th>  </th> 
<th>  </th> 
<th> </th> 
<th>  </th> 
</tr>

<tr >
<td width="40%" rowspan="2">敏感数据扫描流量</td>
<td>CN</td>
<td>￥0.1</td>

</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td>￥0.2</td>
</tr>

<tr >
<td width="40%" rowspan="2">定时报告</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2</td>
</tr>

<tr >
<td width="40%" rowspan="2">数据转发</td>
<td>CN</td>
<td>￥0.35</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥0.7</td>
</tr>

<tr >
<td width="40%" rowspan="2">网络</td>
<td>CN</td>
<td>￥2</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥4</td>
</tr>

<tr >
<td width="40%" rowspan="2">会话重放</td>
<td>CN</td>
<td>￥2.5</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2.5</td>
</tr>

<tr >
<td width="40%" rowspan="2">可用性监测</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥10</td>
</tr>

<tr >
<td width="40%" rowspan="2">任务调用</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥2</td>
</tr>

<tr >
<td width="40%" rowspan="2">短信</td>
<td>CN</td>
<td>￥1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >-</td> 
<td  bgcolor=#FBFBF9 >-</td>
</tr>

<tr >
<td width="40%" rowspan="2">中心 Pipeline</td>
<td>CN</td>
<td>￥0.1</td>
</tr>

<tr >
<td  bgcolor=#FBFBF9 >Intl(incl HK)</td> 
<td  bgcolor=#FBFBF9 >￥0.2</td>
</tr>

<tr >
<th colspan="9">梯度计费</th>
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
<td rowspan="2">时间线</td>
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
<td rowspan="2" >日志</td>
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
<td rowspan="2" width="30%" >应用性能 Trace</td>
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
<td rowspan="2" width="30%" >应用性能 Profile</td>
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
<td rowspan="2">用户访问 PV</td>
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





### 采用美元结算
-->

### 敏感数据扫描流量 {#scanned-data}

即基于扫描规则统计扫描到的敏感数据原始流量大小（每 GB / 天）。

比如：需要扫描某条日志数据 A，针对该数据内的三个字段均需进行脱敏规则处理，则会针对这三个字段的脱敏扫描分别计费。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥0.1 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 | ￥0.2 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | $ 0.014 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.028 |
---


### 定时报告 {#report}

即工作空间内定时报告每日发送的次数（每次 / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥1 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 | ￥2 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | $ 0.14 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.28 |
---


### 时间线 {#timeline}

即用于统计用户当天通过 DataKit 上报的指标数据中，所有指标对应的标签组合数量（每千条 / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |     180 天   |    360 天     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | ￥0.6     | ￥0.7 | ￥0.8  |  ￥1  |    ￥4    |    ￥7    |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |     180 天   |    360 天     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | ￥1.6     | ￥1.8 | ￥2.2  |  ￥2.4  |    ￥8    |    ￥14    |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |     180 天   |    360 天     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | $ 0.09        | $ 0.1 | $ 0.12  |  $ 0.14  |    $ 0.58   |    $ 1   |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |     180 天   |    360 天     |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | $ 0.23        | $ 0.26 | $ 0.32  |  $ 0.35  |    $ 1.2   |    $ 2   |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 时间线计费逻辑</font>](../billing-method/billing-item.md#timeline)

<br/>

</div>



### 日志 {#logs}

#### 按数据条数计费

即日志、事件、安全巡检、可用性拨测等功能使用产生的数据（每百万条 / 天）。

??? warning

    - 日志若开启了 “自定义多索引” 功能，则会根据不同的索引统计当日数据增量，并对应数据存储策略的单价计算实际费用；    
    - 事件包含监控模块（监控器、SLO）配置检测任务产生的事件、智能巡检上报的事件、用户自定义上报的事件；     
    - 可用性拨测由自建拨测节点上报的拨测数据；        
    - 事件、安全巡检、可用性拨测这几类数据的费用默认取日志 “默认” 索引的数据存储策略对应单价计。     

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | ￥1        |   ￥1.2 | ￥1.5  | ￥2  | ￥2.5   |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | ￥2        |   ￥2.4 | ￥3 | ￥4  | ￥5   |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | $ 0.15       |   $ 0.17 | $ 0.22  | $ 0.28  | $ 0.36   |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | $ 0.3        |   $ 0.4 | $ 0.5  | $ 0.6  | $ 0.8   |
---

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 日志计费逻辑</font>](../billing-method/billing-item.md#logs)

<br/>

</div>

<!--
#### :material-numeric-2-circle-outline: 按写入流量计费 {#ingested-log}

即用户上报的原始日志写入流量大小（每 GB / 天）。

**注意**：日志数据默认按照条数计费，如需切换为按写入流量计费，请联系客户经理。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |    60 天   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | ￥0.6     | ￥0.85 | ￥1 |  ￥1.2  |    ￥1.5    |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |    60 天   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | ￥1.4     | ￥2.1 | ￥2.8  |  ￥3.08  |    ￥3.36    |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |    60 天   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | $ 0.1        | $ 0.15 | $ 0.2  |  $ 0.22  |    $ 0.24   |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天 |    60 天   |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | $ 0.2        | $ 0.3 | $ 0.4  |  $ 0.44  |    $ 0.48   |
---

-->

### 数据转发 {#backup}

:material-numeric-1-circle: 基于当前工作空间不同的数据转发外部存档类型统计汇总转发的流量大小，统计每日增量数据，并根据数据对应计费出账。（每 GB / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>   |     |
    | -------- | ---------- |
    | 中国站点   | ￥0.35        |

=== "中国香港及海外站点"

    | <font size=2>明细</font>   |     |
    | -------- | ---------- |
    | 中国香港及海外站点   | ￥0.7        |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   |  $ 0.05 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.1 |
---

:material-numeric-2-circle: 基于当前工作空间数据转发到<<< custom_key.brand_name >>>内部存储类型统计汇总转发的流量大小，统计全量数据，并根据数据对应计费出账。（每 GB / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥0.007 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  ￥0.014 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   |  $ 0.001 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.002 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 数据转发计费逻辑</font>](../billing-method/billing-item.md#backup)

<br/>

</div>


### 网络 {#network}

工作空间内 eBPF 上报网络数据中统计到的 host 的数量（每台上报网络数据主机 / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥2 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  ￥4 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   |  $ 0.29 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.6 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 上报网络数据主机计费逻辑</font>](../billing-method/billing-item.md#network)

<br/>

</div>


### 应用性能 Trace {#trace}

统计上报的链路数据中的 Trace 的数量，一般情况下如果 Span 数据中 `trace_id` 相同，这些 Span 都会被归类到一个 Trace 下面（每百万个 Traces / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | ￥2 |  ￥3  |  ￥6  |  ￥10.8  |  ￥19.44  |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | ￥6 |  ￥10  |  ￥20  |  ￥36  |  ￥64.8  |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | $ 0.29 |  $ 0.43 |  $ 0.86 |  $ 1.54 |  $ 2.78 |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | $ 0.9 |  $ 1.4 |  $ 2.8 |   $ 5.14 |  $ 9.26 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 应用性能 Trace 计费逻辑</font>](../billing-method/billing-item.md#trace)

<br/>

</div>


### 应用性能 Profile {#profile}

统计上报的应用性能 Profile 数据数量（每万条 Profiles / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  |
    | -------- | ---------- | ---------- | ---------- |
    | 中国站点   |￥0.2 |  ￥0.3  |  ￥0.5|

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  |
    | -------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 |￥0.4 |  ￥0.6  |  ￥1|

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  |
    | -------- | ---------- | ---------- | ---------- |
    | 中国站点   |$ 0.03 |  $ 0.04  |  $ 0.07|

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  |
    | -------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 |$ 0.06 |  $ 0.09  |  $ 0.14|
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 应用性能 Profile 计费逻辑</font>](../billing-method/billing-item.md#profile)

<br/>

</div>

### 用户访问 PV {#pv}

统计上报的用户访问的页面浏览数量，一般是通过统计每日产生的 Resource、Long Task、Error、Action 数据数量得出（每万个 PV / 天）。

**注意**：不管是 SPA（单页应用） 还是 MPA（多页应用），用户在每访问一次页面（包含刷新或者重新进入）都算做 1 个 PV。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | ￥0.7 | ￥1  |  ￥2| ￥3.6  |  ￥6.48|

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | ￥2 | ￥3  |  ￥5| ￥9  |  ￥16.2 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    | 中国站点   | $ 0.1 | $ 0.14  |  $ 0.29| $ 0.51  |  $ 0.93 |

=== "中国香港及海外站点"

    | 数据存储策略 |3 天         | 7 天   | 14 天  | 30 天   | 60 天  |
    | -------- | ---------- | ---------- | ---------- | ---------- | ---------- |
    |  中国香港及海外站点 | $ 0.29 | $ 0.43  |  $ 0.71 |  $ 1.29 |  $ 2.31 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 用户访问 PV 计费逻辑</font>](../billing-method/billing-item.md#pv)

<br/>

</div>

### 会话重放 {#session}

统计有实际产生会话回放数据的 Session 的数量。一般通过统计 Session 数据中存在 `has_replay: 
true` 的 `session_id` 数量得出（每千个 Sessions / 天）。


<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥2.5 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  ￥2.5 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | $ 0.35 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 | $ 0.35 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 会话重放计费逻辑</font>](../billing-method/billing-item.md#session)

<br/>

</div>



### 可用性监测 {#st}

即使用可用性监测功能使用产生的费用（每万次 API 拨测 / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥1 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 | ￥10 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | $ 0.143 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 1.43 |
---


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 可用性监测计费逻辑</font>](../billing-method/billing-item.md#st)

<br/>

</div>

### 任务调用 {#trigger}

即使用异常检测、生成指标等功能产生的费用（每万次 / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥1 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  ￥2 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   |  $ 0.14 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.3 |
---



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 任务调用计费逻辑</font>](../billing-method/billing-item.md#trigger)

<br/>

</div>

### 短信 {#sms}

统计当天发送的短信的数量（每 10 条 / 天）。

<font color=coral>**当采用人民币结算**：</font>

| <font size=2>明细</font>  |    |   |
|-------- | ---------- |---------- |
| 中国站点  | 人民币   |  ￥1 |

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 短信计费逻辑</font>](../billing-method/billing-item.md#sms)

<br/>

</div>

### 中心 pipeline {#pipeline}

统计所有命中中心 pipeline 处理的原始日志的数据大小（每 GB / 天）。

<font color=coral>**当采用人民币结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   | ￥0.1 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  ￥0.2 |

<font color=coral>**当采用美元结算**：</font>

=== "中国站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    | 中国站点   |  $ 0.014 |

=== "中国香港及海外站点"

    | <font size=2>明细</font>  |  |
    | -------- | ---------- |
    |  中国香港及海外站点 |  $ 0.028 |
---

