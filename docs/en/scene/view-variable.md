# View Variables
---

In dynamic visual data analysis, view variables play a key role. They allow users to update visualization results in real time by changing the value of one or more view variables. This real-time interactivity helps users dynamically filter and analyze data according to their needs, thereby gaining deeper insights into the stories behind the data.


## Adding View Variables {#add}

Click to enter the view variable tab page:

![](img/variable-1.png)

To add a view variable, click to enter the create page:

<img src="../img/variable-2.png" width="70%" >

:material-numeric-1-circle: Variable Name: The name of the variable in the current set of view variables. When adding a chart in the dashboard, it needs to be referenced in the chart query, with the format: `#{variable name}`.

:material-numeric-2-circle: Display Name: The name displayed for the current set of view variables in the dashboard, for example: if the variable name is `host`, the display name would be `HOST`.

:material-numeric-3-circle: [Query](#query)

- Sorting: Default sorting, ascending/descending arrangement of returned view variables.

:material-numeric-4-circle: Display Options

- Hide: If enabled, the variable will not be visible in the dashboard outside of edit mode.
- Include * Option: Enabled by default.
- Multi-value: Allows selecting multiple values simultaneously.

:material-numeric-5-circle: Default Value: The initial variable of the current view variable in the dashboard. The dropdown here will list variables based on the configuration in **Display Options**, allowing selection of the initial variable to view in the dashboard. If the default value is empty, the latest field data will be displayed in the dashboard.

- *: Condition is empty (null), no filtering applied for `by` conditions;
- All values: Treats the result values from the view variable query statement as parameters;
- Custom: Enter a value directly in the selection bar and press Enter to create. You can search for your target variable in the selection bar.

Click **Select** to select all values in the current list.

**Note**: If workspace data reporting is interrupted, you cannot select data when configuring view variables. You can preset fields during configuration, and once data reporting resumes normally, the fields will automatically match.

For already created view variables, you can clone, re-edit, or delete them as needed.

![](img/variable-3.png)

If you choose to hide a variable while configuring view variables, it will show :fontawesome-regular-eye-slash: a hidden button on the right side of the list.

![](img/variable-5.png)

### Variable Query {#query}

View variables support four types of queries: DQL Query, PromQL Query, UI Query, and Custom.

#### Value Range

There are two ways to define the value range of view variables:

:material-numeric-1-circle-outline: Follow dashboard interactivity, i.e., list variable query data based on the time range selected in the dashboard's time widget;  
:material-numeric-2-circle-outline: Do not follow dashboard interactivity, i.e., list all data from the variable query, unaffected by the time range selected in the dashboard's time widget.

Below is an explanation of the value ranges for different data sources:

<div class="grid" markdown>

=== "Metrics"

    | Data Type | Measurement Set   | Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Metrics     | SHOW_MEASUREMENT() function;<br>This function does not support adding time filters;<br>Value range: all measurement sets in the current workspace. | SHOW_TAG_KEY(from=['measurement set name']) function;<br>This function does not support adding time filters;<br>Value range: tags under the selected measurement set in the current workspace. | SHOW_TAG_VALUE(from=['measurement set name'], keyin=['tag name']);<br>This function does not support adding time filters. |

=== "Base Objects"

    | Data Type | Category   | Properties/Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Base Objects | O::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**;<br>Value range: all source values under the default index within the selected time. | SHOW_OBJECT_FIELD('kubernetes_nodes');<br>This function **does not support** adding time filters;<br>Value range: all fields under the object data in the current workspace. | O::`kubernetes_nodes`:(DISTINCT_BY_COLLAPSE(`namespace`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**. |

=== "Resource Catalog"

    | Data Type | Category   | Properties/Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Resource Catalog | CO::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**<br>Value range: all source values under the default index within the selected time. | SHOW_CUSTOM_OBJECT_FIELD('class value');<br>This function **does not support** adding time filters;<br>Value range: all fields under the resource catalog data in the current workspace. | CO::`cdsmnl`:(DISTINCT_BY_COLLAPSE(`cds`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**. |

=== "Logs"

    | Data Type | Log Source   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Logs     | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**;<br>Value range: all source values under the default index within the selected time. | SHOW_LOGGING_FIELD(index='default');<br>This function **does not support** adding time filters;<br>Value range: all fields under the log data in the current workspace. | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`trace_id`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**. |

=== "Application Performance"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | APM | SHOW_TRACING_FIELD();<br>This function **does not support** adding time filters;<br>Value range: all fields under the tracing data in the current workspace. | T::RE(`.*`):(DISTINCT_BY_COLLAPSE(`resource`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**. |

=== "User Access"

    | Data Type | Data Classification   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | RUM PV | R::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**;<br>Value range: all source values under the default index within the selected time. | SHOW_RUM_FIELD('source value');<br>This function **does not support** adding time filters;<br>Value range: all fields under the user access data in the current workspace. | R::`error`:(DISTINCT_BY_COLLAPSE(`province`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**. |

=== "Security Check"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | Security Check | SHOW_SECURITY_FIELD();<br>This function **does not support** adding time filters;<br>Value range: all fields under the security check data in the current workspace. | S::RE(`.*`):(DISTINCT_BY_COLLAPSE(`rule`));<br>This function **supports** adding time filters, **follows dashboard time widget interactivity**. |

</div>

#### DQL Query {#dql}

During the DQL query process, users can directly write DQL statements to query and return corresponding data values. You can add time range filters and configure [cascading queries](#cascade) in your queries.

> Click [Learn More About DQL Definitions and Syntax](../dql/define.md).

*DQL Statement Query Example:*

**Note**: It is recommended to use this method for non-Metrics data such as infrastructure and logs.

| Syntax | Description |
| --- | --- |
| Data Source Type::Data Source:(distinct('property field name')){filter conditions} | M/metric - Time Series Metric Data;<br>O/object - Object Data;<br>L/logging - Logging Data;<br>E/event - Event Data;<br>T/tracing - Tracing Data;<br>R/rum - RUM Data. |
| R::view:(distinct(`app_id`)) | Returns the `app_id` list for web application user access monitoring. |
| R::view:(distinct(`env`)){`app_id` = '8f05003ebccad062'} | Returns the `env` list corresponding to Web application user access monitoring `app_id=8f05003ebccad062`. | 
| R::view:(distinct(`env`)){`app_id` = `#{appid}`} | By using `#{variable name}` in the DQL statement, it can be used for [cascading queries](#cascade), indicating that the variable name of the previous query is set to `app_id`, thus returning the `env` list corresponding to the selected `app_id` in the previous query. |

##### Adding Time Range Explanation

When querying view variables using DQL statements, you can add a time range in the [xx:xx:xx] format:

- If a time range is added in the DQL query, it takes precedence over the time range selected in the dashboard time widget;
- If no time range is added in the DQL query, it defaults to using the time range selected in the dashboard time widget.

*Example:*

```
# Query the container host list from the last 10 minutes 
O::docker_containers:(distinct(`host`)) [10m]
```

##### Show Function Query {#show}

When using DQL queries, you can use the Show function to return corresponding data values. The Show function does not support adding time range filters.

> Click [Learn More About DQL Function Descriptions](../dql/funcs.md).

*Show Function Query Example:*

**Note**: It is recommended to use this query method for Metrics data.

| Syntax | Description |
| --- | --- |
| `show_measurement()` | Returns all measurement sets in the current workspace. |
| `show_tag_key(from=["cpu"])` | Returns the tags under the `cpu` measurement set in the current workspace. |
| `show_tag_key(from=["cpu"],keyin=["host"])` | Queries the `host` tag value list under the `cpu` measurement set in the current workspace. |

#### PromQL Query {#promql}

In PromQL queries, handwritten query statements are supported. The queries default to using the time range selected in the dashboard time widget and return corresponding data values.

> Refer to [PromQL Quick Start](../dql/promql.md) for more information about PromQL queries.

#### UI Query

In UI queries, you can select data sources such as metrics, base objects, resource catalogs, logs, application performance, user access, and security checks. You can directly click to select query variables on the UI to return corresponding data values.

In UI queries, you cannot add a time range or configure [cascading queries](#cascade).



#### Custom Query

Custom refers to users being able to directly define a set of numerical values for use as view variables without needing to obtain related values through query statements. Content in custom variable options should be separated by English commas `,`. Custom queries do not support adding time ranges or configuring cascading queries.

![](img/11.variable_10.png)

### Cascading Query {#cascade}

When configuring two or more view variables, and the second view variable requires querying based on the result of the first view variable, you can use a cascading query. Similarly, cascading queries can support multiple view variables linked together.

**Note**: Cascading queries only support DQL statements for query configurations.

#### Example

Below is an example of configuring a cascading filter for Web application overview view variables in user access monitoring, which requires linking queries based on **Application ID**, **Environment**, and **Version**.

![](img/18.variable_3.png)

**Configuration Explanation:**

There are three variables: **Application ID**, **Environment**, and **Version**, so three variable query statements need to be configured in the dashboard. In the second and third query statements, use the `#{variable name}` from the previous configuration to complete the cascading query configuration.

![](img/18.variable_2.png)


- **Variable 1 (Application ID)**: Query the application list named `df_web_rum_sdk`:

```
R::view:(distinct(`app_id`)){sdk_name = `df_web_rum_sdk`}
```

- **Variable 2 (Environment)**: Query the environment list under the selected Application ID from Variable 1 for applications named `df_web_rum_sdk`:

```
R::view:(distinct(`env`)) {app_id = `#{appid}` and sdk_name = `df_web_rum_sdk`}
```

- **Variable 3 (Version)**: Query the version list under the selected Environment from Variable 2 for applications named `df_web_rum_sdk`:

```
R::view:(distinct(`version`)) {app_id = `#{appid}` and env = `#{env}`  and sdk_name = `df_web_rum_sdk`}
```

#### Logical Operators

| Logical Operator      | Variable Value Match Type     | Example    |
| ------------- | -------------- | ------- |
| = 、!=      | Exact match, supports multi-select. | R::view:(distinct(`env`)) {`app_id` = `#{appid}`      |
| match（re）、not match（re）<br>wildcard、not wildcard | Fuzzy match, supports multi-select. | R::view:(distinct(`env`)) {`app_id` = re(`#{appid}`)} |


## Adding Object Mapping

Field mapping can be set for infrastructure object data. Field mapping **is solely for improving display effects and will not affect the original field data.**

To add object mapping, click to enter the create page:

![](img/variable001.png)

Select the data source, object category, and two property fields that need mapping. For example: map `container_id` to display as `container_name`. In the dashboard, the view variable value will be displayed as `container_name (container_id)` but during queries, the value passed will still be `container_id`. Additionally, if the field mapping feature is enabled in chart settings, the [legend](./visual-chart/timeseries-chart.md#legend) in the chart will display the mapped field value.

For already created object mappings, you can re-edit or delete them as needed.

![](img/variable-4.png)

## Use Case Examples

### View Variable Configuration Example

1. After creating the view variable, associate it with the chart to enable联动筛选 between the chart and the view variable.

1) In the chart query, select the variable for the `value` field. (The dropdown shows the variable name.)

![](img/8.variable_11.png)

2) Switching the variable value in the scene view will cause the chart to filter and display based on the variable tag.

![](img/8.variable_12.png)

2. In the chart, clicking on a specific timeline or data point can directly add in reverse, enabling global联动查看of charts related to the selected value.

**Note**:
    
- Prerequisite: There exists a `by` grouping condition in the corresponding [DQL](../scene/view-variable.md#dql);
- Chart scope involved: Time series chart, summary chart, pie chart, top list, gauge, bar chart, scatter plot, bubble chart, table chart, rectangle tree chart, China map, world map, hexbin chart

1) After clicking on a specific timeline or data point, click the setting condition under **Apply to View Variable** in the displayed card. 

![](img/variables_2.png)

2) This will populate the dashboard’s view variable. The effect is shown below:

![](img/variables_3.png)

### Object Mapping Configuration Example

Object mapping can be applied in two places: the dropdown display in view variables and the display in charts.

#### Applying in View Variables

When adding an object's [property field] in view variables, if the field also has a field mapping set, then in the view variables, it displays as: mapped field (queried field).

*Example:*

1) Add a `container_id` variable in [View Variables] (as shown below).

![](img/variable002.png)

2) Set `container_id` to map to `container_name` in [Object Mapping].

![](img/variable001.png)

3) At this point, the variable in the view will display as: `container_name(container_id)`.

![](img/x10.png)

#### Applying in Charts

When querying an object's attribute field in charts and enabling field mapping in the settings, if the field also has a field mapping set, then in the chart variables, it displays as: mapped field (queried field).

*Example:*

1) In [Object Mapping], set `host` to map to `name` (as shown below):

![](img/variable003.png)


2) Use this field in the chart query and enable [Field Mapping] in the [Settings], then in the chart, it displays as `name(host)`.

![](img/x12.png)

???+ warning "Note"

    - Object mapping only supports setting object class data;   
    - When using object mapping, you must first define a view variable based on object class fields;           
    - For queries of the same object category, two mappings cannot be set, i.e., the query field dropdown will not include fields already added for that object category; 
    - When field mapping is enabled, the chart displays the **grouped field** and the corresponding **mapped field**, un-mapped grouped fields are not displayed;   
    - When field mapping is disabled, the chart does not display mapped fields, showing normal fields instead.