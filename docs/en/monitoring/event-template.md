# Custom Event Notification Templates
---

When specifying event content, template syntax is supported. Users can use template variables to render dynamic text.

## Template Variables

The syntax for rendering variables is `{{ field_name }}`, and the event fields available for text rendering are as follows:

| Template Variable                                | Type           | Description                                                                                                                        |
| ------------------------------------------------ | -------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `date`, `timestamp`                              | Integer        | Event generation time. Unit is in seconds                                                                                                      |
| `df_date_range`                                  | Integer        | Time range. Unit is in seconds                                                                                                          |
| `df_check_range_start`                           | Integer        | Start time of the detection range. Unix timestamp, unit is in seconds                                                                                     |
| `df_check_range_end`                             | Integer        | End time of the detection range. Unix timestamp, unit is in seconds                                                                                     |
| `df_status`                                      | String(Enum)   | Event status, possible values:<br>critical `critical`<br>important `error`<br>warning `warning`<br>normal `ok`<br>data interruption `nodata`                 |
| `df_event_id`                                    | String         | Unique event ID                                                                                                                 |
| `df_event_link`                                  | String         | Link to the event details page                                                                                                          |
| `df_dimension_tags`                              | String         | Event dimensions. Used to identify the monitored object<br>For example: `{"host":"web-001"}`                                                                      |
| `df_monitor_id`                                  | String         | Alert strategy ID<br>_If you have questions about the detection, you can send this ID to us_                                                                   |
| `df_monitor_name`                                | String         | Alert strategy name                                                                                                                |
| `df_monitor_checker_id`                          | String         | Monitor ID<br>_If you have questions about the detection, you can send this ID to us_                                                                     |
| `df_monitor_checker_name`                        | String         | Monitor name                                                                                                                  |
| `df_monitor_checker_value`                       | String         | Detection value, i.e., the value detected by the monitor<br>Note: The detection value will be forcibly converted to a string type to ensure compatibility                                              |
| `df_monitor_checker_event_ref`                   | String         | Monitor event association. Calculated based on the monitor ID and event `df_dimension_tags`                                                              |
| `df_fault_id`                                    | String         | Current fault ID, which is the `df_event_id` of the first fault event                                                                              |
| `df_fault_status`                                | String(Enum)   | Current fault status, redundant field of `df_status`, possible values:<br>normal `ok`<br>fault `fault`                                            |
| `df_fault_start_time`                            | Integer        | Fault occurrence time. Unix timestamp, unit is in seconds                                                                                     |
| `df_fault_duration`                              | Integer        | Duration of the current fault. Unit is in seconds                                                                                                  |
| `df_user_id`                                     | String         | User ID of the operator when manually recovering                                                                                                   |
| `df_user_name`                                   | String         | Name of the operator when manually recovering                                                                                                  |
| `df_user_email`                                  | String         | Email of the operator when manually recovering                                                                                                  |
| `df_crontab_exec_mode`                           | String(Enum)   | Monitor execution mode, possible values:<br>auto-triggered `crontab`<br>manual execution `manual`                                                     |
| `df_site_name`                                   | String         | Current <<< custom_key.brand_name >>> node name                                                                                                            |
| `df_workspace_name`                              | String         | Name of the workspace it belongs to                                                                                                              |
| `df_workspace_uuid`                              | String         | ID of the workspace it belongs to<br>_If you have questions about the detection, you can send this ID to us_                                                               |
| `df_label`                                       | List           | List of monitor labels                                                                                                              |
| &#12288;`df_label[#]`                            | String         | Monitor label                                                                                                                  |
| `df_check_condition`                             | Dict           | Satisfied detection conditions                                                                                                              |
| &#12288;`df_check_condition.operator`            | String         | Operator for satisfying detection conditions, such as `>`、`>=`                                                                                  |
| &#12288;`df_check_condition.operands`            | List           | Operand list for satisfying detection conditions.<br>Generally only 1 operand<br>But operators like `between` have 2 operands                                     |
| &#12288;&#12288;`df_check_condition.operands[#]` | Integer, Float | Operand for satisfying detection conditions                                                                                                        |
| `Result`                                         | Integer, Float | Detection value, same as `df_monitor_checker_value` but retains the original type obtained during detection, not forcibly converted to a string |
| {fields from `df_dimension_tags`}                | String         | Fields from `df_dimension_tags` are extracted                                                                                       |
| `df_event`                                       | Dict           | Complete event data                                                                                                                |

### User Access Metrics Detection (RUM)

In **User Access Metrics Detection (RUM)**, in addition to the general template variables mentioned above, the following additional template variables are supported:

| Template Variable   | Type   | Description     |
| ---------- | ------ | -------- |
| `app_id`   | String | Application ID  |
| `app_name` | String | Application Name |
| `app_type` | String | Application Type |

### Template Variable Examples

Assuming the monitor `by` has configured `region` and `host`, and the event content template is as follows:

Event Name:

```
Monitor {{ df_monitor_checker_name }} found a fault in {{ df_dimension_tags }}
```

Event Content:

```
- Region: {{ region }}
- Host: {{ host }}
- Level: {{ df_status }}
- Detection Value: {{ Result }}
- Monitor: {{ df_monitor_checker_name }} (Alert Strategy: {{ df_monitor_name }})
```

After an `error` event is generated, the rendered event output is as follows:

Rendered Event Name:

```
Monitor Monitor001 found a fault in {"region":"hangzhou","host":"web-001"}
```

Rendered Event Content:

```
- Region: hangzhou
- Host: web-001
- Level: error
- Detection Value: 90.12345
- Monitor: Monitor001 (Alert Strategy: Team001)
```

### Fields Containing Special Characters Such as `-`, `@`

In some cases, the specified `dimension` fields in the detection configuration may contain special characters such as `-`, `@`, e.g., `host-name`, `@level`.

According to the template syntax, these field names cannot be used as normal variable names, leading to rendering issues.

In such cases, you can use `{{ df_event['host-name'] }}`, `{{ df_event['@level'] }}` instead of `{{ host-name }}`, `{{ @level }}`.

## Template Functions

In addition to directly displaying field values from events, template functions can be used to further process field values and optimize output.

Basic syntax:

```
{{ <template_variable> | <template_function> }}
```

Specific examples:

```
Event generation time: {{ date | to_datetime }}
```

If the template function requires parameters, the syntax is as follows:

```
Event generation time: {{ date | to_datetime('America/Chicago') }}
```

???+ warning

    If you need to perform operations on template variables before using template functions, do not forget to **add parentheses**, such as:

    ```
    CPU Usage: {{ (Result * 100) | to_round(2) }}
    ```

Available template functions include:

| Template Function          | Parameter     | Description                                                                                                               |
| ----------------- | -------- | ------------------------------------------------------------------------------------------------------------------ |
| `to_datetime`     | Timezone     | Converts a timestamp to a date (default timezone is `Asia/Shanghai`)<br>Example: `{{ date | to_datetime }}`<br>Output: `2022-01-01 01:23:45` |
| `to_status_human` |          | Converts `df_status` to a human-readable form<br>Example: `{{ df_status | to_status_human }}`<br>Output: `Critical`                           |
| `to_fixed`        | Decimal Places | Outputs numbers with fixed decimal places (defaults to 0 decimal places)<br>Example: `{{ Result | to_fixed(3) }}`<br>Output: `1.230`               |
| `to_round`        | Decimal Places | Rounds numbers (defaults to 0 decimal places)<br>Example: `{{ Result | to_round(2) }}`<br>Output: `1.24`                          |
| `to_percent`      | Decimal Places | Converts decimals to percentages (defaults to 0 decimal places)<br>Example: `{{ Result | to_percent(1) }}`<br>Output: `12.3%`                   |
| `to_pretty_tags`  |          | Beautifies tag output<br>Example: `{{ df_dimension_tags | to_pretty_tags }}`<br>Output: `region:hangzhou, host:web-001`          |

### Template Function Example

Assuming the configured monitor `by` has configured `region` and `host`, and the alert configuration template is as follows:

Event Name:

```
Monitor {{ df_monitor_checker_name }} found a fault in {{ df_dimension_tags | to_pretty_tags }}
```

Event Content:

```
- Object: {{ df_dimension_tags | to_pretty_tags }}
- Time: {{ date | to_datetime }}
- Level: {{ df_status | to_status_human }}
- Detection Value: {{ (Result * 100) | to_round(2) }}
```

After an `error` event is generated, the rendered event output is as follows:

Rendered Event Name:

```
Monitor My Monitor found a fault in region:hangzhou, host:web-001
```

Rendered Event Content:

```
- Detected Object: region:hangzhou, host:web-001
- Detection Time: 2022-01-01 01:23:45
- Fault Level: Important
- Detection Value: 9012.35
```

## Template Branches

Templates also support branch syntax to render different content based on conditions.

### Template Branch Example

You can use the following syntax to implement branching:

```
{% if df_status == 'critical' %}
Critical issue, please handle immediately!
{% elif df_status == 'error' %}
Important issue, please handle.
{% elif df_status == 'warning' %}
Possible issue, handle when free.
{% elif df_status == 'nodata' %}
Data interruption, please handle immediately!
{% else %}
No issues!
{% endif %}
```

A more typical example is as follows:

```
{% if  df_status != 'ok' %}
> Level: {{ df_status }}
> Host: {{ host }}
> Content: Elasticsearch JVM heap memory usage is {{ Result }}%
> Suggestion: Current JVM garbage collection is not keeping up with garbage generation, please check business conditions promptly

{% else %}
> Level: {{ df_status }}
> Host: {{ host }}
> Content: Elasticsearch JVM heap memory alert has been resolved

{% endif %}
```

## Embedded DQL Query Functions {#dql}

In some cases, template variables alone cannot meet the rendering requirements. In such situations, embedded DQL query functions can be used to perform additional data queries.

Embedded DQL query functions support executing any DQL statement within the current workspace's detection time range. Typically, the first result of the query can be used as a template variable in the template, as follows:

```
{% set dql_data = DQL("DQL statement to execute") %}

Some Field: {{ dql_data.some_field }}
```

### Embedded DQL Query Example

The following embedded DQL statement queries data where the `host` field is `"my_server"` and assigns the first result to the `dql_data` variable:

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }") %}

Host OS: {{ dql_data.os }}
```

Subsequent templates can then use `{{ dql_data.os }}` to output specific fields from the query results.

### Passing Parameters to Embedded DQL

Sometimes, the DQL statement needs to pass parameters.

Assuming the monitor `by` has configured `region` and `host`, and the event content template is as follows:

```
{% set dql_data = DQL("O::HOST:(host_ip, os) { region = ?, host = ? }", region, host) %}

Host Information:
IP: {{ dql_data.host_ip }}
OS: {{ dql_data.os }}
```

Since the event only contains `region` and `host` template variables to mark different data, it does not include IP address, operating system, or other information.

Using embedded DQL, you can obtain corresponding data by passing `region` and `host` as DQL query parameters and use `{{ dql_data.host_ip }}` etc. to output associated information.

### Details of Embedded DQL Query Functions

The format for calling embedded DQL query functions is as follows:

```
DQL(dql, param_1, param_2, ...)
```

- The first parameter is the DQL statement, which can contain parameter placeholders `?`
- Subsequent parameters are the parameter values or variables for the DQL statement

Parameter placeholders `?` are automatically escaped when replaced with actual values.

Assuming the value of the variable `host` is `"my_server"`, the embedded DQL function and the final executed DQL statement are as follows:

```
DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = ? }", host)
```

```
O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }
```

???+ warning

    - Embedded DQL queries should be placed at the beginning of the template
    - Query result names (here `dql_data`) follow general programming language naming conventions, starting with English letters and containing only English letters, numbers, and underscores. **Avoid** using emojis.
    - Query result names **should not** conflict with existing template variables or template functions, as this can cause unpredictable issues
    - If you use functions on fields in the DQL, it is recommended to alias the fields using `AS` for easier subsequent use (e.g., `O::HOST:( last(host) AS last_host )`).
    - If DQL field names contain special characters, similar to template variables, they should be rendered using `{{ dql_data['host-name'] }}`, `{{ dql_data['@level'] }}`.

### More DQL Documentation

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **About DQL Statements**</font>](../dql/index.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **About DQL Namespace**</font>](../dql/define.md#namespace)

</div>