# 事件名称/内容模版
---

## 概述

自定义触发动作的内容时，除了自己撰写的固定文案外，事件标题、内容本身也支持模板语法。用户可以使用事件中的字段实现文案的渲染。

## 模版变量

用于渲染事件字段的语法为`{{ 字段名 }}`，可用于文案渲染的事件字段如下：

| 模板变量 | 类型 | 说明 |
| --- | --- | --- |
| `date`、`timestamp` | Integer | 事件产生时间，单位为秒 |
| `df_dimension_tags` | String | 事件维度，即根据监控器中配置的`by`后的排列组合，用于标识检测对象<br>如：`{"host":"web-001"}` |
| `df_event_id` | String | 事件ID（唯一标识） |
| `df_monitor_checker_id` | String | 检测器ID<br>_如果对检测有疑问，可以将此ID反馈给我们_ |
| `df_monitor_checker_name` | String | 检测器名称，即在创建检测器时填写的名称 |
| `df_monitor_checker_value` | String | 检测值，即产生本事件时，检测到的值<br>注意：检测值会强制转换为String类型以保证兼容性 |
| `df_monitor_id` | String | 检测分组ID<br>_如果对检测有疑问，可以将此ID反馈给我们_ |
| `df_monitor_name` | String | 检测分组名称，即在创建检测器时指定的分组名 |
| `df_status` | String(Enum) | 事件状态，可能的值为：<br>紧急`critical`<br>重要`error`<br>警告`warning`<br>正常`ok`<br>无数据`nodata` |
| `df_workspace_name` | String | 所属工作空间名 |
| `df_workspace_uuid` | String | 所属工作空间ID<br>_如果对检测有疑问，可以将此ID反馈给我们_ |
| `Result` | Integer, Float | 检测值，与`df_monitor_checker_value`一样为产生本事件时，检测到的值，但字段类型为检测时获得的原始类型，不会强制转换为String |
| 其他在检测时，指定的`by`字段 | String | 如检测时指定指定了`by region, host`，那么此处同时会额外产生对应的`region`和`host`字段。 |


### 模板变量示例

假设所配置的监控器`by`配置了`region`和`host`，且告警配置的模板如下：

事件名称：

```
监控器 {{ df_monitor_checker_name }} 发现 {{ df_dimension_tags }} 存在故障
```

事件内容：

```
- 地区：{{ region }}
- 主机：{{ host }}
- 级别：{{ df_status }}
- 检测值：{{ Result }}
- 监控器：{{ df_monitor_checker_name }}（分组：{{ df_monitor_name }}）
```

那么，产生`error`事件后，经过渲染的事件输出如下：

输出事件名称：

```
监控器 我的监控器 发现 {"region":"hangzhou","host":"web-001"} 存在故障
```

输出事件内容：

```
- 地区：hangzhou
- 主机：web-001
- 级别：error
- 检测值：90.12345
- 监控器：我的监控器（分组：默认分组）
```

## 模板函数

除了除了直接展示事件中的字段值外，还可以使用模板函数对字段值进行进一步处理，优化输出。

函数支持额外参数，当无需或不传递参数时，可以直接使用以下语法进行使用：

```
{{ <模板变量> | <模板函数> }}
```

具体实例如下：

```
事件产生时间：{{ date | to_datetime }}
```

如需要额外为函数传递参数，则可以使用以下语法进行使用：

```
事件产生时间：{{ date | to_datetime('America/Chicago') }}
```

如果对模板变量进行运算的同时，使用模板函数，请注意添加括号，如：

```
CPU使用率：{{ (Result * 100) | to_round(2) }}%
```

完整的模板函数列表如下：

| 模板函数 | 参数 | 说明 |
| --- | --- | --- |
| `to_datetime` | 时区 | 将时间戳转换为日期（默认时区为`Asia/Shanghai`）<br>示例：`{{ date &#124; to_datetime }}`<br>输出：`2022-01-01 01:23:45` |
| `to_status_human` |  | 将`df_status`转换为易读形式<br>示例：`{{ df_status &#124; to_status_human }}`<br>输出：`紧急` |
| `to_fixed` | 固定小数位数 | 将数字输出为固定小数位数（默认保留0位小数）<br>示例：`{{ Result &#124; to_fixed(3) }}`<br>输出：`1.230` |
| `to_round` | 最大小数位数 | 将数字四舍五入（默认保留0位小数）<br>示例：`{{ Result &#124; to_round(2) }}`<br>输出：`1.24` |
| `to_percent` | 固定小数位数 | 将小数输出为百分比（默认保留0位小数）<br>示例：`{{ Result &#124; to_percent(1) }}`<br>输出：`12.3%` |
| `to_pretty_tags` |  | 美化输出标签<br>示例：`{{ df_dimension_tags &#124; to_pretty_tags }}`<br>输出：`region=hanghzou, host=web-001` |

### 模板函数示例

假设所配置的监控器`by`配置了`region`和`host`，且告警配置的模板如下：

事件名称：

```
监控器 {{ df_monitor_checker_name }} 发现 {{ df_dimension_tags | to_pretty_tags }} 存在故障
```

事件内容：

```
- 检测对象：{{ df_dimension_tags | to_pretty_tags }}
- 检测时间：{{ date | to_datetime }}
- 故障级别：{{ df_status | to_status_human }} ({{ df_status }})
- 检测值：{{ Result | to_round(2) }}
- 监控器：{{ df_monitor_checker_name }}（分组：{{ df_monitor_name }}）
```

那么，产生`error`事件后，经过渲染的事件输出如下：

输出事件名称：

```
监控器 我的监控器 发现 region=hangzhou, host=web-001 存在故障
```

输出事件内容：

```
- 检测对象：region=hangzhou, host=web-001
- 检测时间：2022-01-01 01:23:45
- 故障级别：重要 (error)
- 检测值：90.12
- 监控器：我的监控器（分组：默认分组）
```

## 模板分支

某些情况下，您可能需要在不同情况下渲染不同的内容。此时，可以使用模板分支语法。

假设，我们需要根据`df_status`不同，输出不同的内容。

### 模板分支示例

```
{% if df_status == 'critical' %}
紧急问题，请立即处理！
{% elif df_status == 'error' %}
重要问题，请处理
{% elif df_status == 'warning' %}
可能有问题，有空处理
{% elif df_status == 'nodata' %}
数据中断，请立即处理！
{% else %}
没问题！
{% endif %}
```

```
{% if  df_status != 'ok' %}
> 等级：{{ df_status }}  
> 主机：{{ host }}  
> 内容：Elasticsearch JVM 堆内存的使用量为 {{ Result }}%
> 建议：当前JVM垃圾的收集已经跟不上JVM垃圾的产生请及时查看业务情况

{% else %}
> 等级：{{df_status}}  
> 主机：{{host}}  
> 内容：Elasticsearch JVM 堆内存告警已恢复

{% endif %}
```
