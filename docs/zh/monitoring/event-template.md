# 自定义事件通知模板
---


在指定事件内容时，支持模板语法。用户可以使用模板变量渲染动态文案。

## 模板变量

用于渲染变量的语法为 `{{ 字段名 }}`，可用于文案渲染的事件字段如下：

| 模板变量                                         | 类型           | 说明                                                                                                                        |
| ------------------------------------------------ | -------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `date`、`timestamp`                              | Integer        | 事件产生时间。单位为秒                                                                                                      |
| `df_date_range`                                  | Integer        | 时间范围。单位为秒                                                                                                          |
| `df_check_range_start`                           | Integer        | 检测范围开始时间。Unix 时间戳，单位为秒                                                                                     |
| `df_check_range_end`                             | Integer        | 检测范围结束时间。Unix 时间戳，单位为秒                                                                                     |
| `df_status`                                      | String(Enum)   | 事件状态，可能的值为：<br>紧急 `critical`<br>重要 `error`<br>警告 `warning`<br>正常 `ok`<br>数据断档 `nodata`                 |
| `df_event_id`                                    | String         | 事件唯一 ID                                                                                                                 |
| `df_event_link`                                  | String         | 事件详情页链接地址                                                                                                          |
| `df_dimension_tags`                              | String         | 事件维度。用于标识检测对象<br>如：`{"host":"web-001"}`                                                                      |
| `df_monitor_id`                                  | String         | 告警策略 ID<br>_如果对检测有疑问，可以将此 ID 发送给我们_                                                                   |
| `df_monitor_name`                                | String         | 告警策略名称                                                                                                                |
| `df_monitor_checker_id`                          | String         | 监控器 ID<br>_如果对检测有疑问，可以将此 ID 发送给我们_                                                                     |
| `df_monitor_checker_name`                        | String         | 监控器名称                                                                                                                  |
| `df_monitor_checker_value`                       | String         | 检测值，即被监控器检测的值<br>注意：检测值会强制转换为 String 类型以保证兼容性                                              |
| `df_monitor_checker_event_ref`                   | String         | 监控器事件关联。根据监控器 ID、事件`df_dimension_tags`计算所得                                                              |
| `df_fault_id`                                    | String         | 本轮故障 ID，取值为首次故障事件的`df_event_id`                                                                              |
| `df_fault_status`                                | String(Enum)   | 本轮故障状态，为`df_status`的冗余字段，可能的值为：<br>正常 `ok`<br>故障 `fault`                                            |
| `df_fault_start_time`                            | Integer        | 本轮故障发生时间。Unix 时间戳，单位为秒                                                                                     |
| `df_fault_duration`                              | Integer        | 本轮故障持续时间。单位为秒                                                                                                  |
| `df_user_id`                                     | String         | 手工恢复时，操作者用户 ID                                                                                                   |
| `df_user_name`                                   | String         | 手工恢复时，操作者用户名称                                                                                                  |
| `df_user_email`                                  | String         | 手工恢复时，操作者用户邮箱                                                                                                  |
| `df_crontab_exec_mode`                           | String(Enum)   | 监控器运行模式，可能的值为：<br>自动触发 `crontab`<br>手工执行 `manual`                                                     |
| `df_site_name`                                   | String         | 当前<<< custom_key.brand_name >>>节点名                                                                                                            |
| `df_workspace_name`                              | String         | 所属工作空间名                                                                                                              |
| `df_workspace_uuid`                              | String         | 所属工作空间 ID<br>_如果对检测有疑问，可以将此 ID 发送给我们_                                                               |
| `df_label`                                       | List           | 监控器标签列表                                                                                                              |
| `df_check_condition`                             | Dict           | 满足的检测条件                                                                                                              |
| &#12288;`df_check_condition.operator`            | String         | 满足检测条件的操作符，如：`>`、`>=` 等                                                                                      |
| &#12288;`df_check_condition.operands`            | List           | 满足检测条件的操作数列表。<br>一般只有 1 个操作数<br>但`between`等操作符具有 2 个操作数                                     |
| &#12288;&#12288;`df_check_condition.operands[#]` | Integer, Float | 满足检测条件的操作数                                                                                                        |
| `Result`                                         | Integer, Float | 检测值，与`df_monitor_checker_value`一样为产生本事件时，检测到的值，但字段类型为检测时获得的原始类型，不会强制转换为 String |
| {`df_dimension_tags`中的各字段}                  | String         | `df_dimension_tags`中的各字段会被提取                                                                                       |
| `df_event`                                       | Dict           | 完整事件数据                                                                                                                |

### 用户访问指标检测（RUM）

在**用户访问指标检测（RUM）**中，除了上述通用的模板变量外，额外支持下列模板变量：

| 模板变量   | 类型   | 说明     |
| ---------- | ------ | -------- |
| `app_id`   | String | 应用 ID  |
| `app_name` | String | 应用名称 |
| `app_type` | String | 应用类型 |

### 模板变量示例

假设监控器 `by` 配置了 `region` 和 `host`，且事件内容的模板如下：

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
- 监控器：{{ df_monitor_checker_name }}（告警策略：{{ df_monitor_name }}）
```

那么，产生 `error` 事件后，经过渲染的事件输出如下：

输出事件名称：

```
监控器 监控器001 发现 {"region":"hangzhou","host":"web-001"} 存在故障
```

输出事件内容：

```
- 地区：hangzhou
- 主机：web-001
- 级别：error
- 检测值：90.12345
- 监控器：监控器001（告警策略：团队001）
```

### 包含 -、@ 等特殊字符的字段

在某些情况下，检测配置中指定`维度`字段可能会包含`-`、`@`等特殊字符，如：`host-name`、`@level`。

根据模板语法，这种字段名无法作为正常的变量名，导致无法正常渲染。

此时，可以使用`{{ df_event['host-name'] }}`、`{{ df_event['@level'] }}`来替代`{{ host-name }}`、`{{ @level }}`。

## 模板函数

除了可以直接展示事件中的字段值外，还可以使用模板函数对字段值进行进一步处理，优化输出。

基本语法如下：

```
{{ <模板变量> | <模板函数> }}
```

具体实例如下：

```
事件产生时间：{{ date | to_datetime }}
```

如果模板函数需要传递参数，那么语法如下：

```
事件产生时间：{{ date | to_datetime('America/Chicago') }}
```

???+ warning

    如果需要在使用模板函数之前对模板变量进行运算，请不要忘记**添加括号**，如：

    ```
    CPU 使用率：{{ (Result * 100) | to_round(2) }}
    ```

可用的模板函数列表如下：

| 模板函数          | 参数     | 说明                                                                                                               |
| ----------------- | -------- | ------------------------------------------------------------------------------------------------------------------ |
| `to_datetime`     | 时区     | 将时间戳转换为日期（默认时区为`Asia/Shanghai`）<br>示例：`{{ date | to_datetime }}`<br>输出：`2022-01-01 01:23:45` |
| `to_status_human` |          | 将`df_status`转换为易读形式<br>示例：`{{ df_status | to_status_human }}`<br>输出：`紧急`                           |
| `to_fixed`        | 小数位数 | 将数字输出为固定小数位数（默认保留 0 位小数）<br>示例：`{{ Result | to_fixed(3) }}`<br>输出：`1.230`               |
| `to_round`        | 小数位数 | 将数字四舍五入（默认保留 0 位小数）<br>示例：`{{ Result | to_round(2) }}`<br>输出：`1.24`                          |
| `to_percent`      | 小数位数 | 将小数输出为百分比（默认保留 0 位小数）<br>示例：`{{ Result | to_percent(1) }}`<br>输出：`12.3%`                   |
| `to_pretty_tags`  |          | 美化输出标签<br>示例：`{{ df_dimension_tags | to_pretty_tags }}`<br>输出：`region:hanghzou, host:web-001`          |

### 模板函数示例

假设所配置的监控器 `by` 配置了 `region` 和 `host`，且告警配置的模板如下：

事件名称：

```
监控器 {{ df_monitor_checker_name }} 发现 {{ df_dimension_tags | to_pretty_tags }} 存在故障
```

事件内容：

```
- 对象：{{ df_dimension_tags | to_pretty_tags }}
- 时间：{{ date | to_datetime }}
- 级别：{{ df_status | to_status_human }}
- 检测值：{{ (Result * 100) | to_round(2) }}
```

那么，产生 `error` 事件后，经过渲染的事件输出如下：

输出事件名称：

```
监控器 我的监控器 发现 region:hangzhou, host:web-001 存在故障
```

输出事件内容：

```
- 检测对象：region:hangzhou, host:web-001
- 检测时间：2022-01-01 01:23:45
- 故障级别：重要
- 检测值：9012.35
```

## 模板分支

模板也支持使用分支语法根据条件渲染不同内容。

### 模板分支示例

可以使用以下语法实现分支功能：

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

更典型的例子如下：

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

在某些情况下，仅使用模板变量无法满足渲染需求。此时，可以使用内嵌 DQL 查询函数实现额外的数据查询。

内嵌 DQL 查询函数支持在本工作空间下**本次检测时间范围内**执行任意 DQL 语句，通常情况下，查询所得的第一条数据可在模板中作为模板变量使用，使用方式如下：

```
{% set dql_data = DQL("需要执行的 DQL 语句") %}

某字段：{{ dql_data.some_field }}
```

### 内嵌 DQL 查询示例

以下内嵌 DQL 语句查询`host`字段为`"my_server"`的数据，并将第一条数据赋值给`dql_data`变量：

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }") %}

主机 OS：{{ dql_data.os }}
```

此后的模板中即可使用`{{ dql_data.os }}`输出查询结果中的具体字段。

### 向内嵌 DQL 传递参数

有时，所需执行的 DQL 语句需要传递参数。

假设监控器 `by` 配置了 `region` 和 `host`，且事件内容的模板如下：

```
{% set dql_data = DQL("O::HOST:(host_ip, os) { region = ?, host = ? }", region, host) %}

主机信息：
IP：{{ dql_data.host_ip }}
OS: {{ dql_data.os }}
```

由于事件仅包含 `region` 和 `host` 模板变量用于标记不同的数据，不包含 IP 地址、操作系统等更多信息。

那么，使用内嵌 DQL 可以通过 `region` 和 `host` 作为 DQL 查询参数获取对应数据，并使用 `{{ dql_data.host_ip }}` 等输出关联信息。

### 内嵌 DQL 查询函数细节

内嵌 DQL 查询函数调用格式如下：

```
DQL(dql, param_1, param_2, ...)
```

- 第 1 个参数为 DQL 语句，可以包含参数占位符 `?`
- 后续参数为 DQL 语句的参数值或变量

参数占位符 `?` 在替换为具体值的时候，系统会自动进行转义。

假设，变量 `host` 值为 `"my_server"`，那么内嵌 DQL 函数和所执行的最终 DQL 语句如下：

```
DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = ? }",  host)
```

```
O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }
```

???+ warning

    - 内嵌 DQL 查询应当放在模板开头
    - 查询结果名（这里是`dql_data`）遵循一般编程语言的命名要求，可以为任意英文开头，且仅包含英文、数字、下划线的字符串，**不建议**使用 emoji。
    - 查询结果名**不要**与现有的任何模板变量、模板函数重名，否则会产生不可预料的问题
    - 如果在 DQL 中对字段使用了函数，建议使用`AS`为字段取别名来方便后续使用（如：`O::HOST:( last(host) AS last_host )`）。
    - 如果 DQL 中字段名包含特殊字符，和模板变量一样，应当使用`{{ dql_data['host-name'] }}`、`{{ dql_data['@level'] }}`进行渲染。

### 更多 DQL 文档

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **关于 DQL 语句**</font>](../dql/index.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **关于 DQL namespace**</font>](../dql/define.md#namespace)

</div>
