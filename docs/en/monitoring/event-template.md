# Event Notification Template
---

## Overview

When customizing the content of triggering actions, besides the fixed copy written by yourself, the event title and content itself also support template syntax. Users can use the fields in the event to render the copy.

## Template Variable

The syntax used to render event fields is `{{ field name }}`, and the event fields that can be used for copywriting rendering are as follows:

| Template Variable                                                      | Type           | Description                                                                                                                                                                                                |
| ---------------------------------------------------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `date`、`timestamp`                                                    | Integer        | Event generation time, unit: seconds                                                                                                                                                                       |
| `df_dimension_tags`                                                    | String         | Event dimension, that is, according to the permutation and combination after `by` configured in the monitor, used to identify the detected object<br>for example:`{"host":"web-001"}`                      |
| `df_event_id`                                                          | String         | Event ID (unique identity)                                                                                                                                                                                 |
| `df_monitor_checker_id`                                                | String         | Detector ID<br>_If you have any questions about the detection, you can feedback this ID to us_                                                                                                             |
| `df_monitor_checker_name`                                              | String         | Detector name, that is, the name filled in when creating the detector                                                                                                                                      |
| `df_monitor_checker_value`                                             | String         | Detection value, that is, the value detected when this event is generated<br>Note: The detected value is cast to String type to ensure compatibility                                                       |
| `df_monitor_id`                                                        | String         | Detection grouping ID<br>_If you have any questions about the detection, you can feedback this ID to us_                                                                                                   |
| `df_monitor_name`                                                      | String         | Detect the packet name, that is, the packet name specified when creating the detector                                                                                                                      |
| `df_status`                                                            | String(Enum)   | Event status, the possible values are:<br>critical`critical`<br>error`error`<br>warning`warning`<br>ok`ok`<br>notata`nodata`                                                                               |
| `df_workspace_name`                                                    | String         | Owning workspace name                                                                                                                                                                                      |
| `df_workspace_uuid`                                                    | String         | Owning workspace ID<br>_If you have any questions about the detection, you can feedback this ID to us_                                                                                                     |
| `Result`                                                               | Integer, Float | The instrumented value, like `df_monitor_checker_value`, is the value detected when this event was generated, but the field type is the original type obtained when instrumented and is not cast to String |
| {Detect the `by` or `dimension` fields specified in the configuration} | String         | If `by region, host` is specified during detection, the corresponding `region` and `host` fields will be generated at the same time.                                                                       |
| `df_event`                                                             | Dict           | Entire event data                                                                                                                                                                                          |

### Real User Metrics Monitoring (RUM)

In the Real User Metrics Monitoring (RUM) detector, in addition to the general template variables mentioned above, the following template variables are supported:

| Template Variable | Type   | Description      |
| ----------------- | ------ | ---------------- |
| `app_id`          | String | application ID   |
| `app_name`        | String | application name |
| `app_type`        | String | application type |

### Sample Template Variables

Suppose the configured monitor `by` is configured with `region` and `host`, and the template for alarm configuration is as follows:

Event name:

```
Monitor {{ df_monitor_checker_name }} found {{ df_dimension_tags }} faulty
```

Event content:

```
- region: {{ region }}
- host: {{ host }}
- status: {{ df_status }}
- detect result: {{ Result }}
- monitor: {{ df_monitor_checker_name }}（分组：{{ df_monitor_name }}）
```

Then, after the `error` event is generated, the rendered event output is as follows:

Output event name:

```
Monitor My monitor found a fault with {"region":"hangzhou","host":"web-001"}
```

Output event content:

```
- Area: hangzhou
- Host: web-001
- status: error
- detect result: 90.12345
- Monitor: My Monitor (Group: Default Group)
```

### Dimension fields that contain a dash `-`

In some cases, the `by` or `dimension` field specified in the configuration may contain a median `-`, e.g. `host-name`.

Due to syntax issues, the template engine will parse `host-name` as "`host` minus `name`", resulting in failure to render properly.

In this case, `df_event['host-name']` can be used instead of `host-name`, e.g.: `{{ df_event['host-name'] }}`

## Template Function

In addition to directly displaying the field values in the event, you can use template functions to further process the field values and optimize the output.

Function supports extra parameters, which can be used directly using the following syntax when no parameters are needed or not passed:

```
{{ <template variable> | <template function> }}
```

Specific examples are as follows:

```
Event generation time: {{ date | to_datetime }}
```

If you need to pass additional parameters to a function, you can use the following syntax:

```
Event generation time: {{ date | to_datetime('America/Chicago') }}
```

If you use template functions while operating on template variables, please pay attention to adding parentheses, such as:

```
CPU utilization: {{ (Result * 100) | to_round(2) }}%
```

The complete list of template functions is as follows:

| Template Function | Parameter            | Description                                                                                                                                      |
| ----------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `to_datetime`     | Time zone            | Convert a timestamp to a date (the default time zone is `Asia/Shanghai`)<br>such as: `{{ date | to_datetime }}`<br>output: `2022-01-01 01:23:45` |
| `to_status_human` |                      | Convert `df_status` to readable form<br>such as: `{{ df_status | to_status_human }}`<br>output: `critical`                                       |
| `to_fixed`        | Fixed decimal places | Output numbers to fixed decimal places (0 decimal places are reserved by default)<br>such as: `{{ Result | to_fixed(3) }}`<br>output: `1.230`    |
| `to_round`        | Maximum size digit   | Rounding numbers (0 decimal places are reserved by default)<br>such as: `{{ Result | to_round(2) }}`<br>output: `1.24`                           |
| `to_percent`      | Fixed decimal places | Output decimal as a percentage (0 decimal places are reserved by default)<br>such as: `{{ Result | to_percent(1) }}`<br>output: `12.3%`          |
| `to_pretty_tags`  |                      | Beautify the output label<br>such as: `{{ df_dimension_tags | to_pretty_tags }}`<br>output: `region=hanghzou, host=web-001`                      |

### Sample Template Function

Suppose the configured monitor `by` is configured with `region` and `host`, and the template for alarm configuration is as follows:

Event name:

```
Monitor {{ df_monitor_checker_name }} found a fault {{ df_dimension_tags | to_pretty_tags }}
```

Event content:

```
- Detect object: {{ df_dimension_tags | to_pretty_tags }}
- Detection time: {{ date | to_datetime }}
- Failure level: {{ df_status | to_status_human }} ({{ df_status }})
- Detected value: {{ Result | to_round(2) }}
- Monitor: {{ df_monitor_checker_name }}（分组：{{ df_monitor_name }}）
```

Then, after the `error` event is generated, the rendered event output is as follows:

Output event name:

```
Monitor My monitor found a fault with region=hangzhou, host=web-001
```

Output event content:

```
- Detection object: region=hangzhou, host=web-001
- Detection time: 2022-01-01 01:23:45
- Failure level: error
- Detection value: 90.12
- Monitor: My Monitor (Group: Default Group)
```

## Template Branch

In some cases, you may need to render different content in different situations. At this point, you can use template branching syntax.

### Template Branch Sample

Suppose we need to output something different depending on the `df_status`.

```
{% if df_status == 'critical' %}
Urgent problems, please deal with them immediately!
{% elif df_status == 'error' %}
Important problems, please deal with them
{% elif df_status == 'warning' %}
May be a problem, deal with it when free
{% elif df_status == 'nodata' %}
Data interruption, please deal with it immediately!
{% else %}
No problem!
{% endif %}
```

```
{% if  df_status != 'ok' %}
> status: {{ df_status }}
> host: {{ host }}
> content: Elasticsearch JVM heap memory usage is {{ Result }}%
> Suggestion: The current JVM garbage collection can't keep up with the JVM garbage generation. Please check the business situation in time

{% else %}
> status: {{df_status}}
> host: {{host}}
> Content: Elasticsearch JVM heap memory alarm recovered

{% endif %}
```

## Embedded DQL Query Function {#dql}

In some cases, template variables alone are not enough to show the required information. At this point, you can use the embedded DQL query function to implement additional queries.

The embedded DQL query function supports the execution of any DQL statement in this workspace. Usually, the first piece of data obtained from the query can be used as a template variable in the template as follows:

```
{% set dql_data = DQL("DQL statements to be executed") %}

xxx field: {{ dql_data.xxx }}
```

### Typical DQL Query Example

When executing a DQL query, a typical example is as follows:

```
{% set dql_data = DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }") %}

Host OS：{{ dql_data.os }}
```

Represents: Query the host with `host` as `"my_server"` using a DQL statement and assign the first piece of data returned to the `dql_data` variable.

You can then use `{{ dql_data.xxx }}` in the template to output specific fields in the query results.

*Note: Variable names follow the naming requirements of general programming languages, and can be any string that starts in English and contains only English, numbers and underscores. emoji is not recommended.*

*Note: If you use a function for a field in the DQL (e.g. `O::HOST:( last(host) )`), it is recommended to use `AS` to alias the field for subsequent use (e.g. `O::HOST:( last(host) AS last_host )`)*

### Passing DQL parameters using template variables

The more common usage of this function is to use template variables as parameters to query the relevant data of the corresponding monitoring objects.

Suppose the monitor is configured as follows:

> For the `cpu` metrics, group by`host`, `project` and alarm hosts with `load5s` greater than `10`.

The template variable for the resulting event will have `host` and `project` fields to mark different hosts, but the template variable does not contain information such as host IP address, operating system.

Then, combined with the embedded DQL query function, you can show other relevant information about hosts where `load5s` is greater than `10` in the following way:

```
{% set dql_data = DQL("O::HOST:(host_ip, os) { host = ?, project = ? }",  host, project) %}

Host information:
IP：{{ dql_data.host_ip }}
OS: {{ dql_data.os }}
```

### Embedded DQL Query Function Details

The format of the embedded DQL query function call is as follows:

```
DQL(dql, param_1, param_2, ...)
```

Namely:

- The first parameter is the DQL statement
- Followed by the DQL statement used to replace the parameter placeholder `?`

Where the parameter placeholder `?` When replaced with a specific value, the system automatically escapes.

Assuming that the variable `host` has a value of `"my_server"`, then:

```
DQL("O::HOST:(host, host_ip, os, datakit_ver) { host = ? }",  host)
```

The final DQL statement executed is:

```
O::HOST:(host, host_ip, os, datakit_ver) { host = 'my_server' }
```

### Notes:

1. Embed the variable name assigned by DQL query function, *don't* duplicate the name with any existing template variable and template function, otherwise it will cause unexpected problems.
2. Because the embedded DQL query function is located in the event content template, it is recommended to write it at the beginning of the whole content template, and the system will automatically remove the blank lines before and after the content.
3. If you use a function for a field in your DQL (e.g. `O::HOST:( last(host) )`), it is recommended to use `AS` to alias the field for subsequent use (e.g. `O::HOST:( last(host) AS last_host )`)

### Appendix

- -Refer to [help - DQL](/dql/) on DQL statements
- For all available `namespace`, refer to [help - DQL - DQL definition - namespace](/dql/define/#namespace)
