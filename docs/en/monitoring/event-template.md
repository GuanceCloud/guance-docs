# Custom Event Notification Templates
---


When specifying event content, template syntax is supported. Users can use template variables to render dynamic text.

## Template Variables

The syntax for rendering variables is `{{ field_name }}`, and the following event fields can be used for text rendering:

| Template Variable                                         | Type           | Description                                                                                                                        |
| -------------------------------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `date`, `timestamp`                                      | Integer        | Event generation time. Unit is in seconds                                                                                          |
| `df_date_range`                                          | Integer        | Time range. Unit is in seconds                                                                                                    |
| `df_check_range_start`                                   | Integer        | Start time of the detection range. Unix timestamp, unit is in seconds                                                              |
| `df_check_range_end`                                     | Integer        | End time of the detection range. Unix timestamp, unit is in seconds                                                                |
| `df_status`                                              | String(Enum)   | Event status, possible values are:<br>Urgent `critical`<br>Important `error`<br>Warning `warning`<br>Normal `ok`<br>Data outage `nodata` |
| `df_event_id`                                            | String         | Unique event ID                                                                                                                   |
| `df_event_link`                                          | String         | Link address to the event details page                                                                                             |
| `df_dimension_tags`                                       | String         | Event dimensions. Used to identify the detection object<br>Example: `{"host":"web-001"}`                                             |
| `df_monitor_id`                                          | String         | Alert strategy ID<br>_If you have questions about the detection, you can send this ID to us_                                        |
| `df_monitor_name`                                        | String         | Alert strategy name                                                                                                               |
| `df_monitor_checker_id`                                  | String         | Monitor ID<br>_If you have questions about the detection, you can send this ID to us_                                               |
| `df_monitor_checker_name`                                | String         | Monitor name                                                                                                                      |
| `df_monitor_checker_value`                               | String         | Detection value, i.e., the value detected by the monitor<br>Note: The detection value will be forcibly converted to a String type to ensure compatibility |
| `df_monitor_checker_event_ref`                           | String         | Monitor event association. Calculated based on the monitor ID and event `df_dimension_tags`                                           |
| `df_fault_id`                                            | String         | Fault ID for this round, which takes the value of the first fault event's `df_event_id`                                            |
| `df_fault_status`                                        | String(Enum)   | Fault status for this round, redundant field of `df_status`, possible values are:<br>Normal `ok`<br>Fault `fault`                   |
| `df_fault_start_time`                                    | Integer        | Fault occurrence time for this round. Unix timestamp, unit is in seconds                                                            |
| `df_fault_duration`                                      | Integer        | Fault duration for this round. Unit is in seconds                                                                                  |
| `df_user_id`                                             | String         | User ID of the operator when manually restoring                                                                                     |
| `df_user_name`                                           | String         | User name of the operator when manually restoring                                                                                  |
| `df_user_email`                                          | String         | User email of the operator when manually restoring                                                                                 |
| `df_crontab_exec_mode`                                   | String(Enum)   | Monitor execution mode, possible values are:<br>Automatically triggered `crontab`<br>Manually executed `manual`                       |
| `df_site_name`                                           | String         | Current <<< custom_key.brand_name >>> node name                                                                                   |
| `df_workspace_name`                                       | String         | Name of the workspace it belongs to                                                                                                |
| `df_workspace_uuid`                                       | String         | ID of the workspace it belongs to<br>_If you have questions about the detection, you can send this ID to us_                        |
| `df_label`                                               | List           | Monitor label list                                                                                                                |
| `df_check_condition`                                      | Dict           | Satisfied detection conditions                                                                                                      |
| &#12288;`df_check_condition.operator`                     | String         | Operator that satisfies the detection condition, such as: `>`、`>=` etc                                                             |
| &#12288;`df_check_condition.operands`                    | List           | List of operands that satisfy the detection condition.<br>There is generally only 1 operand<br>But operators like `between` have 2 operands |
| &#12288;&#12288;`df_check_condition.operands[#]`         | Integer, Float | Operand that satisfies the detection condition                                                                                      |
| `Result`                                                 | Integer, Float | Detection value, same as `df_monitor_checker_value` which is the value detected at the time of this event, but the field type is the original type obtained during detection, not forcibly converted to String |
| {Each field in `df_dimension_tags`}                      | String         | Each field in `df_dimension_tags` will be extracted                                                                                |
| `df_event`                                               | Dict           | Complete event data                                                                                                               |

### User Access Metrics Detection (RUM)

In **User Access Metrics Detection (RUM)**, in addition to the general template variables mentioned above, the following additional template variables are supported:

| Template Variable   | Type       | Description     |
| ------------------- | ---------- | -------------- |
| `app_id`            | String     | Application ID |
| `app_name`          | String     | Application name |
| `app_type`          | String     | Application type |

### Template Variable Example

Assume the monitor `by` is configured with `region` and `host`, and the event content template is as follows:

Event Name:

```
Monitor {{ df_monitor_checker_name }} found a failure in {{ df_dimension_tags }}
```

Event Content:

```
- Region: {{ region }}
- Host: {{ host }}
- Level: {{ df_status }}
- Detection Value: {{ Result }}
- Monitor: {{ df_monitor_checker_name }} (Alert Strategy: {{ df_monitor_name }})
```

Then, after generating an `error` event, the rendered event output would be as follows:

Output Event Name:

```
Monitor Monitor001 found a failure in {"region":"hangzhou","host":"web-001"}
```

Output Event Content:

```
- Region: hangzhou
- Host: web-001
- Level: error
- Detection Value: 90.12345
- Monitor: Monitor001 (Alert Strategy: Team001)
```

### Fields Containing Special Characters Such as -, @

In some cases, the specified `dimension` fields in the detection configuration may contain special characters such as `-`, `@`, like `host-name`, `@level`.

According to the template syntax, these field names cannot be used as normal variable names, causing them to fail to render properly.

In this case, you can use `{{ df_event['host-name'] }}`, `{{ df_event['@level'] }}` instead of `{{ host-name }}`, `{{ @level }}`.

## Template Functions

In addition to directly displaying field values from events, template functions can also be used to further process field values and optimize output.

Basic syntax is as follows:

```
{{ <template_variable> | <template_function> }}
```

Specific examples are as follows:

```
Event generation time: {{ date | to_datetime }}
```

If the template function requires parameters, the syntax is as follows:

```
Event generation time: {{ date | to_datetime('America/Chicago') }}
```

???+ warning

    If you need to perform calculations on template variables before using template functions, don't forget to **add parentheses**, for example:

    ```
    CPU Usage: {{ (Result * 100) | to_round(2) }}
    ```

List of available template functions:

| Template Function          | Parameter     | Description                                                                                                               |
| ------------------------- | ------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `to_datetime`             | Timezone      | Converts a timestamp to a date (default timezone is `Asia/Shanghai`)<br>Example: `{{ date | to_datetime }}`<br>Output: `2022-01-01 01:23:45` |
| `to_status_human`        |              | Converts `df_status` to a human-readable form<br>Example: `{{ df_status | to_status_human }}`<br>Output: `Critical`               |
| `to_fixed`               | Decimal places | Outputs numbers with fixed decimal places (defaults to retaining 0 decimal places)<br>Example: `{{ Result | to_fixed(3) }}`<br>Output: `1.230` |
| `to_round`               | Decimal places | Rounds numbers (defaults to retaining 0 decimal places)<br>Example: `{{ Result | to_round(2) }}`<br>Output: `1.24`       |
| `to_percent`             | Decimal places | Outputs decimals as percentages (defaults to retaining 0 decimal places)<br>Example: `{{ Result | to_percent(1) }}`<br>Output: `12.3%` |
| `to_pretty_tags`         |              | Beautifies tag output<br>Example: `{{ df_dimension_tags | to_pretty_tags }}`<br>Output: `region:hanghzou, host:web-001`    |

### Template Function Example

Assume the configured monitor `by` is set with `region` and `host`, and the alert configuration template is as follows:

Event Name:

```
Monitor {{ df_monitor_checker_name }} found a failure in {{ df_dimension_tags | to_pretty_tags }}
```

Event Content:

```
- Object: {{ df_dimension_tags | to_pretty_tags }}
- Time: {{ date | to_datetime }}
- Level: {{ df_status | to_status_human }}
- Detection Value: {{ (Result * 100) | to_round(2) }}
```

Then, after generating an `error` event, the rendered event output would be as follows:

Output Event Name:

```
Monitor MyMonitor found a failure in region:hangzhou, host:web-001
```

Output Event Content:

```
- Detection Object: region:hangzhou, host:web-001
- Detection Time: 2022-01-01 01:23:45
- Failure Level: Important
- Detection Value: 9012.35
```

## Template Branches

Templates also support branch syntax to render different content based on conditions.

### Template Branch Example

You can use the following syntax to implement branching functionality:

```
{% if df_status == 'critical' %}
Urgent issue, please handle immediately!
{% elif df_status == 'error' %}
Important issue, please handle
{% elif df_status == 'warning' %}
Possible issue, handle when free
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
> Suggestion: Current JVM garbage collection cannot keep up with JVM garbage production, please check business conditions promptly

{% else %}
> Level: {df_status}
> Host: {host}
> Content: Elasticsearch JVM heap memory alert has been restored

{% endif %}
```

## Embedded DQL Query Function {#dql}

In some cases, using only template variables does not meet rendering requirements. In such cases, embedded DQL query functions can be used to perform additional data queries.

Embedded DQL query functions support executing any DQL statement within the current workspace and detection time range. In most cases, the first piece of queried data can be used as a template variable in the template, and the usage method is as follows:

```
{% set dql_data = DQL("DQL statement to execute") %}

Some Field: {{ dql_data.some_field }}
```

### Embedded DQL Query Example

The following embedded DQL statement queries data where the `host` field is `"my_server"` and assigns the first piece of data to the `dql_data` variable:

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }") %}

Host OS: {{ dql_data.os }}
```

Subsequent templates can then use `{{ dql_data.os }}` to output specific fields from the query results.

### Passing Parameters to Embedded DQL

Sometimes, the DQL statement to be executed requires passing parameters.

Assume the monitor `by` is configured with `region` and `host`, and the event content template is as follows:

```
{% set dql_data = DQL("O::HOST:(host_ip, os) { region = ?, host = ? }", region, host) %}

Host Information:
IP: {{ dql_data.host_ip }}
OS: {{ dql_data.os }}
```

Since the event contains only `region` and `host` template variables used to mark different data, it does not include IP addresses, operating systems, or other more detailed information.

Thus, using embedded DQL allows you to obtain corresponding data by passing `region` and `host` as DQL query parameters and use `{{ dql_data.host_ip }}` etc. to output associated information.

### Details of Embedded DQL Query Function

The call format of the embedded DQL query function is as follows:

```
DQL(dql, param_1, param_2, ...)
```

- The first parameter is the DQL statement, which can contain parameter placeholders `?`
- Subsequent parameters are the parameter values or variables for the DQL statement

Parameter placeholders `?` will be automatically escaped when replaced with specific values.

Assuming the variable `host` has the value `"my_server"`, the embedded DQL function and the final executed DQL statement are as follows:

```
DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = ? }",  host)
```

```
O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }
```

???+ warning

    - Embedded DQL queries should be placed at the beginning of the template.
    - The result name (here `dql_data`) follows the general programming language naming requirements, can start with English letters, and can only contain English letters, numbers, and underscores. Using emojis is **not recommended**.
    - The result name **should not** conflict with any existing template variables or template functions, otherwise unpredictable problems may occur.
    - If functions are used on fields in DQL, it is suggested to use `AS` to alias fields for easier subsequent use (e.g., `O::HOST:( last(host) AS last_host )`).
    - If field names in DQL contain special characters, similar to template variables, they should be rendered using `{{ dql_data['host-name'] }}`, `{{ dql_data['@level'] }}`.

### More DQL Documentation

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **About DQL Statements**</font>](../dql/index.md)

</div>


<div class="grid cards" markdown

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **About DQL Namespace**</font>](../dql/define.md#namespace)

</div>