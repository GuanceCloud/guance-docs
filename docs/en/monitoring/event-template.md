# Event Alert Templates
---


When specifying event content, template syntax is supported. Users can render dynamic texts using template variables.

## Template Variables

The syntax used for rendering variables is `{{ Field Name }}` and available event fields for text rendering are shown below:

| Template Variable                                | Type           | Description                                                                                                                                                                                                |
| ------------------------------------------------ | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `date`、`timestamp`                              | Integer        | Event generation time in seconds                                                                                                                                                                           |
| `df_date_range`                                  | Integer        | Event time range in seconds                                                                                                                                                                                |
| `df_check_range_start`                           | Integer        | Check range start Unix timestamp in seconds                                                                                                                                                                |
| `df_check_range_end`                             | Integer        | Check range end Unix timestamp in seconds                                                                                                                                                                  |
| `df_status`                                      | String(Enum)   | Event status, the possible values are:<br>critical`critical`<br>error`error`<br>warning`warning`<br>ok`ok`<br>notata`nodata`                                                                               |
| `df_event_id`                                    | String         | Event unique ID                                                                                                                                                                                            |
| `df_event_url`                                   | String         | Event detail page URL                                                                                                                                                                                      |
| `df_dimension_tags`                              | String         | Event dimension tags. used to identify the checked targets<br>for example:`{`host`:"web-001"}`                                                                                                             |
| `df_monitor_id`                                  | String         | Alarm policy ID<br>_If you have any questions about the monitor, please send this ID to us_                                                                                                                |
| `df_monitor_name`                                | String         | Alarm policy name                                                                                                                                                                                          |
| `df_monitor_checker_id`                          | String         | Monitor ID<br>_If you have any questions about the monitor, please send this ID to us_                                                                                                                     |
| `df_monitor_checker_name`                        | String         | Monitor name                                                                                                                                                                                               |
| `df_monitor_checker_value`                       | String         | The value checked by the monitor<br>Note: This value is cast to String type for compatibility reason                                                                                                       |
| `df_monitor_checker_event_ref`                   | String         | Monitor-Event reference key. Computed from Monitor ID and Event dimension tags                                                                                                                             |
| `df_fault_id`                                    | String         | Fault ID, Takes the value of the `df_event_id` of the first failure Event.                                                                                                                                 |
| `df_fault_status`                                | String(Enum)   | Fault status, A redundant field for `df_status` with possible values:<br>Normal `ok`<br>Fault `fault`                                                                                                      |
| `df_fault_start_time`                            | Integer        | Fault start Unix timestamp in seconds                                                                                                                                                                      |
| `df_fault_duration`                              | Integer        | Fault duration in seconds                                                                                                                                                                                  |
| `df_user_id`                                     | String         | Manual event recovery operation's user ID                                                                                                                                                                  |
| `df_user_name`                                   | String         | Manual event recovery operation's user name                                                                                                                                                                |
| `df_user_email`                                  | String         | Manual event recovery operation's user email                                                                                                                                                               |
| `df_crontab_exec_mode`                           | String(Enum)   | Execution mode of the Monitor. Possible values:<br>Crontab `crontab`<br>Manual `manual`                                                                                                                    |
| `df_site_name`                                   | String         | Guance site or node name                                                                                                                                                                                   |
| `df_workspace_name`                              | String         | Current Workspace name                                                                                                                                                                                     |
| `df_workspace_uuid`                              | String         | Current Workspace ID<br>_If you have any questions about the monitor, please send this ID to us_                                                                                                           |
| `df_label`                                       | List           | Label list of the Monitor                                                                                                                                                                                  |
| &#12288;`df_label[#]`                            | String         | Each label of the Monitor                                                                                                                                                                                  |
| `df_check_condition`                             | Dict           | Check condition met                                                                                                                                                                                        |
| &#12288;`df_check_condition.operator`            | String         | Operator of the check condition met, e.g. `>`, `>=`, etc.                                                                                                                                                  |
| &#12288;`df_check_condition.operands`            | List           | Operand list of the check condition met.<br>Usually there is only 1 operand<br>However, operators such as `between` have 2 operands                                                                        |
| &#12288;&#12288;`df_check_condition.operands[#]` | Integer, Float | Each operand of the check condition met                                                                                                                                                                    |
| `Result`                                         | Integer, Float | The instrumented value, like `df_monitor_checker_value`, is the value detected when this event was generated, but the field type is the original type obtained when instrumented and is not cast to String |
| {Key-values in `df_dimension_tags`}              | String         | Key-values in`df_dimension_tags` will be abstracted here                                                                                                                                                   |
| `df_event`                                       | Dict           | Entire event data                                                                                                                                                                                          |

### Real User Metrics Monitoring (RUM)

In the **Real User Metrics Monitoring (RUM)**, there are more available template variables as following:

| Template Variable | Type   | Description      |
| ----------------- | ------ | ---------------- |
| `app_id`          | String | Application ID   |
| `app_name`        | String | Application name |
| `app_type`        | String | Application type |

### Template Variables Example

Suppose there is a monitor with `by` option configured with `region` and `host`, and the template is shown blow:

Event name:

```
Monitor {{ df_monitor_checker_name }} found a fault with {{ df_dimension_tags }}
```

Event content:

```
- Region: {{ region }}
- Host: {{ host }}
- Status: {{ df_status }}
- Result: {{ Result }}
- Monitor: {{ df_monitor_checker_name }} (Alarm policy: {{ df_monitor_name }})
```

Then, once an `error` event is occured, the rendered output is shown blow:

Output event name:

```
Monitor monitor001 found a fault with {"region":"hangzhou",`host`:"web-001"}
```

Output event content:

```
- Region: hangzhou
- Host: web-001
- Status: error
- Result: 90.12345
- Monitor: monitor001 (Alarm policy: Team001)
```

### Fields Containing Special Characters

In some cases, the deimension tag key may contains special characters such as `-`, `@`, etc., e.g., `host-name`, `@level`.

According to the template syntax, such field names can't be used as normal variable names, resulting in rendering failure.

In this case, `{{ df_event['host-name'] }}`, `{{ df_event['@level'] }}` can be used instead of `{{ host-name }}`, `{{ @level }}`.

## Template Functions

In addition to displaying the variables in template directly, you can also use template functions to process the variables and beautify the output.

The basic syntax is the following:

```
{{ <template variable> | <template function> }}
```

Example is shown below:

```
Event time: {{ date | to_datetime }}
```

If the template function needs to pass parameters, then the syntax is shown below:

```
Event time: {{ date | to_datetime('America/Chicago') }}
```

???+ warning

    When you need to perform operations on variables before applying template functions, Please **DON'T FORGET** to add the brackets, such as:

    ```
    CPU Percent: {{ (Result * 100) | to_round(2) }}
    ```

Available template functions are shown blow:

| Template Function | Parameter                | Description                                                                                                                                     |
| ----------------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `to_datetime`     | Timezone                 | Convert a timestamp to a date (the default timezone is `Asia/Shanghai`)<br>Such as: `{{ date | to_datetime }}`<br>output: `2022-01-01 01:23:45` |
| `to_status_human` |                          | Convert `df_status` to readable form<br>Such as: `{{ df_status | to_status_human }}`<br>output: `critical`                                      |
| `to_fixed`        | Number of decimal places | Output numbers to fixed decimal places (Do not retain decimals by default)<br>Such as: `{{ Result | to_fixed(3) }}`<br>output: `1.230`          |
| `to_round`        | Number of decimal places | Rounding numbers (Do not retain decimals by default)<br>Such as: `{{ Result | to_round(2) }}`<br>output: `1.24`                                 |
| `to_percent`      | Number of decimal places | Output decimal as a percentage (Do not retain decimals by default)<br>Such as: `{{ Result | to_percent(1) }}`<br>output: `12.3%`                |
| `to_pretty_tags`  |                          | Beautify the tags<br>Such as: `{{ df_dimension_tags | to_pretty_tags }}`<br>output: `region:hanghzou, host:web-001`                             |

### Template Function Example

Suppose there is a monitor with `by` option configured with `region` and `host`, and the template is shown blow:

Event name:

```
Monitor {{ df_monitor_checker_name }} found a fault with {{ df_dimension_tags | to_pretty_tags }}
```

Event content:

```
- Object: {{ df_dimension_tags | to_pretty_tags }}
- Time: {{ date | to_datetime }}
- Status: {{ df_status | to_status_human }}
- Result: {{ (Result * 100) | to_round(2) }}
```

Then, once an `error` event is occured, the rendered output is shown blow:

Output event name:

```
Monitor monitor001 found a fault with region:hangzhou, host:web-001
```

Output event content:

```
- Object: region:hangzhou, host:web-001
- Time: 2022-01-01 01:23:45
- Status: Error
- Result: 9012.35
```

## Template Branch

The template also supports the use of branching syntax to render different content according to conditions.

### Template Branch Sample

Branching can be implemented using the following syntax:

```
{% if df_status == 'critical' %}
Urgent problems, please deal with them immediately!
{% elif df_status == 'error' %}
Important problems, please deal with them
{% elif df_status == 'warning' %}
May be a problem, deal with it when free
{% elif df_status == 'nodata' %}
Data interrupted, please deal with it immediately!
{% else %}
No problem!
{% endif %}
```

A more typical example is shown below:

```
{% if  df_status != 'ok' %}
> Status: {{ df_status }}
> Host: {{ host }}
> Content: Elasticsearch JVM heap memory usage is {{ Result }}%
> Suggestion: The current JVM garbage collection can't keep up with the JVM garbage generation. Please check the business situation in time

{% else %}
> Status: {{df_status}}
> Host: {{host}}
> Content: Elasticsearch JVM heap memory alarm recovered

{% endif %}
```

## Embedded DQL Query Function {#dql}

In some cases, just using template variables will not satisfy the rendering requirements. In this case, additional data queries can be implemented using the embedded DQL query function.

The embedded DQL query function can perform any DQL statement in current workspace. Usually, the first element of data obtained from the query can be used as a template variable in the template as follows:

```
{% set dql_data = DQL("DQL statements to be performed") %}

some field: {{ dql_data.some_field }}
```

### Embedded DQL Query Example

The following embedded DQL statement queries for data with a `host` field equal to `"my_server"` and assigns the first item of data to the `dql_data` variable:

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }") %}

Host OS：{{ dql_data.os }}
```

And then `{{ dql_data.os }}` can be used in the template to output it's `os` field value.

### Passing Parameters to Embedded DQL

Sometimes the DQL statement to be performed needs passing parameters.

Suppose there is a monitor with `by` option configured with `region` and `host`, and the template is shown blow:

```
{% set dql_data = DQL("O::HOST:(host_ip, os) { region = ?, host = ? }", region, host) %}

Host information:
IP：{{ dql_data.host_ip }}
OS: {{ dql_data.os }}
```

Since the event only contains `region` and `host` template variables for identifying different data, it does not contain more information such as IP address, OS, etc.

Therefore, using embedded DQL, you can use `region` and `host` as DQL query parameters to get the related data, and use `{{ dql_data.host_ip }}` etc. to output the related information.

### Embedded DQL Query Function Details

The embedded DQL query function calling form is shown below:

```
DQL(dql, param_1, param_2, ...)
```

- The first parameter is a DQL statement and can contain the parameter placeholder `?`
- Following parameters are the parameter values or variables of the DQL statement

The parameter placeholder `? ` are automatically escaped when replaced with a particular value.

Suppose, the variable `host` has the value `"my_server"`, then the embedded DQL function and the actual DQL statement executed are shown below:

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = ? }",  host) %}
```

```
O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }
```

???+ warning

    - Embedded DQL queries should be placed at the beginning of the template
    - Query result names (`dql_data` here) follow general programming language naming requirements and can start with any English character and contain only strings of English, numbers, and underscores, and emoji is **NOT** recommended.
    - Query result names should **NOT** be duplicated with any existing template variables or template functions, or unexpected problems may occur.
    - If a function is used on the field in DQL, it is recommended to use `AS` to give an alias to the field for further use (e.g., `O::HOST:( last(host) AS last_host )`).
    - If the field names in DQL contain special characters, as with template variables, they should be rendered using `{{ dql_data['host-name'] }}`, `{{ dql_data['@level'] }}`.

### More about DQL

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **About DQL statement**</font>](../dql/index.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **About DQL namespace**</font>](../dql/define.md#namespace)

</div>
