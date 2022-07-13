# 事件标题、内容模板
---

## 概述

自定义触发动作的内容时，除了自己撰写的固定文案外，事件标题、内容本身也支持模板语法。用户可以使用事件中的字段实现文案的渲染。

## 模板变量

用于渲染事件字段的语法为`{{ 字段名 }}`，可用于文案渲染的事件字段如下：

| 模板变量                           | 类型           | 说明                                                                                                                        |
| ---------------------------------- | -------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `date`、`timestamp`                | Integer        | 事件产生时间，单位为秒                                                                                                      |
| `df_dimension_tags`                | String         | 事件维度，即根据监控器中配置的`by`后的排列组合，用于标识检测对象<br>如：`{"host":"web-001"}`                                |
| `df_event_id`                      | String         | 事件 ID（唯一标识）                                                                                                         |
| `df_monitor_checker_id`            | String         | 检测器 ID<br>_如果对检测有疑问，可以将此 ID 反馈给我们_                                                                     |
| `df_monitor_checker_name`          | String         | 检测器名称，即在创建检测器时填写的名称                                                                                      |
| `df_monitor_checker_value`         | String         | 检测值，即产生本事件时，检测到的值<br>注意：检测值会强制转换为 String 类型以保证兼容性                                      |
| `df_monitor_id`                    | String         | 检测分组 ID<br>_如果对检测有疑问，可以将此 ID 反馈给我们_                                                                   |
| `df_monitor_name`                  | String         | 检测分组名称，即在创建检测器时指定的分组名                                                                                  |
| `df_status`                        | String(Enum)   | 事件状态，可能的值为：<br>紧急`critical`<br>重要`error`<br>警告`warning`<br>正常`ok`<br>无数据`nodata`                      |
| `df_workspace_name`                | String         | 所属工作空间名                                                                                                              |
| `df_workspace_uuid`                | String         | 所属工作空间 ID<br>_如果对检测有疑问，可以将此 ID 反馈给我们_                                                               |
| `Result`                           | Integer, Float | 检测值，与`df_monitor_checker_value`一样为产生本事件时，检测到的值，但字段类型为检测时获得的原始类型，不会强制转换为 String |
| {检测配置中指定的`by`或`维度`字段} | String         | 如检测时指定指定了`by region, host`，那么此处同时会额外产生对应的`region`和`host`字段。                                     |

### 用户访问指标检测（RUM）

在「用户访问指标检测（RUM）」检测器中，除了上述通用的模板变量外，额外支持下列模板变量：

| 模板变量   | 类型   | 说明     |
| ---------- | ------ | -------- |
| `app_id`   | String | 应用 ID  |
| `app_name` | String | 应用名称 |
| `app_type` | String | 应用类型 |

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

除了直接展示事件中的字段值外，还可以使用模板函数对字段值进行进一步处理，优化输出。

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
CPU 使用率：{{ (Result * 100) | to_round(2) }}%
```

完整的模板函数列表如下：

| 模板函数          | 参数         | 说明                                                                                                               |
| ----------------- | ------------ | ------------------------------------------------------------------------------------------------------------------ |
| `to_datetime`     | 时区         | 将时间戳转换为日期（默认时区为`Asia/Shanghai`）<br>示例：`{{ date | to_datetime }}`<br>输出：`2022-01-01 01:23:45` |
| `to_status_human` |              | 将`df_status`转换为易读形式<br>示例：`{{ df_status | to_status_human }}`<br>输出：`紧急`                           |
| `to_fixed`        | 固定小数位数 | 将数字输出为固定小数位数（默认保留 0 位小数）<br>示例：`{{ Result | to_fixed(3) }}`<br>输出：`1.230`               |
| `to_round`        | 最大小数位数 | 将数字四舍五入（默认保留 0 位小数）<br>示例：`{{ Result | to_round(2) }}`<br>输出：`1.24`                          |
| `to_percent`      | 固定小数位数 | 将小数输出为百分比（默认保留 0 位小数）<br>示例：`{{ Result | to_percent(1) }}`<br>输出：`12.3%`                   |
| `to_pretty_tags`  |              | 美化输出标签<br>示例：`{{ df_dimension_tags | to_pretty_tags }}`<br>输出：`region=hanghzou, host=web-001`          |

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

### 模板分支示例

假设，我们需要根据`df_status`不同，输出不同的内容。

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
> 建议：当前 JVM 垃圾的收集已经跟不上 JVM 垃圾的产生请及时查看业务情况

{% else %}
> 等级：{{df_status}}
> 主机：{{host}}
> 内容：Elasticsearch JVM 堆内存告警已恢复

{% endif %}
```

## 内嵌 DQL 查询函数 {#dql}

在某些情况下，单纯的模板变量不足以展示所需的信息。此时，可以使用内嵌 DQL 查询函数实现额外的查询。

内嵌 DQL 查询函数支持在本工作空间下执行任意 DQL 语句，通常情况下，查询所得的第一条数据可在模板种作为模板变量使用，使用方式如下：

```
{% set dql_data = DQL("需要执行的 DQL 语句") %}

xxx 字段：{{ dql_data.xxx }}
```

### 典型 DQL 查询示例

执行 DQL 查询时，一个典型示例如下：

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }") %}

主机 OS：{{ dql_data.os }}
```

表示：使用 DQL 语句查询`host`为`"my_server"`的主机，并将返回的第一条数据赋值给`dql_data`变量。

此后的模板中即可使用`{{ dql_data.xxx }}`输出查询结果中的具体字段。

*注意：变量名遵循一般变成语言的命名要求，可以为任意英文开头，且仅包含英文、数字、下划线的字符串。不建议使用 emoji*

*注意：如果在 DQL 中对字段使用了函数（如：`O::HOST:( last(host) )`，建议使用`AS`为字段取别名来方便后续使用（如：`O::HOST:( last(host) AS last_host )`）*

### 使用模板变量传递 DQL 参数

本功能更常见的用法，则是使用模板变量作为参数，查询对应监控对象的相关数据。

假设监控器配置如下：

> 针对`cpu`指标，按`host`、`project`分组，对`load5s`大于`10`的主机进行告警

所产生事件的模板变量中会存在`host`和`project`字段用于标记不同的主机，但模板变量中并不包含主机 IP 地址、操作系统等信息。

那么，结合内嵌 DQL 查询功能，可以使用如下方式展示`load5s`大于`10`的主机的其他相关信息：

```
{% set dql_data = DQL("O::HOST:(host_ip, os) { host = ?, project = ? }",  host, project) %}

主机信息：
IP：{{ dql_data.host_ip }}
OS: {{ dql_data.os }}
```

### 内嵌 DQL 查询函数细节

内嵌 DQL 查询函数调用格式如下：

```
DQL(dql, param_1, param_2, ...)
```

即：

- 第 1 个参数为 DQL 语句
- 后续为 DQL 语句中用于依次替换参数占位符`?`的参数

其中，参数占位符`?`在替换为具体值的时候，系统会自动进行转义。

假设，变量`host`值为`"my_server"`，那么：

```
DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = ? }",  host)
```

所执行的最终 DQL 语句为：

```
O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }
```

### 注意事项

1. 内嵌 DQL 查询函数所赋值的变量名，*不要*与现有的任何模板变量、模板函数重名，否则会产生不可预料的问题
2. 由于内嵌 DQL 查询函数位于事件内容模板中，建议写在整个内容模板的最开头，系统会自动去除内容前后的空行
3. 如果在 DQL 中对字段使用了函数（如：`O::HOST:( last(host) )`，建议使用`AS`为字段取别名来方便后续使用（如：`O::HOST:( last(host) AS last_host )`）

### 附录

- 有关 DQL 语句帮助文档，请参考 [帮助 - DQL](/dql/)
- 所有可用`namespace`，请参考 [帮助 - DQL - DQL 定义 - namespace](/dql/define/#namespace)
