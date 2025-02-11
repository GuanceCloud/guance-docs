# View Variables
---

In dynamic data visualization analysis, view variables play a critical role. They allow users to update visualization results in real-time by changing the value of one or more view variables. This real-time interactivity helps users dynamically filter and analyze data according to their needs, leading to a deeper understanding of the data.

![](img/18.variable_1.png)

## Adding View Variables {#add}

Click to enter the view variables tab page:

![](img/variable-1.png)

To add a view variable, click to enter the new page:

<img src="../img/variable-2.png" width="70%" >

:material-numeric-1-circle: Variable Name: The name of the current set of view variables, which needs to be referenced in chart queries when adding charts to the dashboard. The format is: `#{variable_name}`.

:material-numeric-2-circle: Display Name: The name displayed for the current set of view variables on the dashboard, for example, if the variable name is `host`, the display name is `hostname`.

:material-numeric-3-circle: [Query](#query)

- Sorting: Default sorting, ascending/descending order for the returned view variables.

:material-numeric-4-circle: Display Options

- Hide: When this option is enabled, the variable is not visible on the dashboard in non-edit mode.
- Include * Option: Enabled by default.
- Multi-value: Allows selecting multiple values simultaneously.

:material-numeric-5-circle: Default Value: The initial variable of the current view variable on the dashboard. The dropdown list here is based on the configuration in **Display Options**, allowing you to choose the initial variable to view by default on the dashboard. If the default value is empty, the latest field data will be displayed on the dashboard.

- *: Condition is empty (null), no filtering for `by` condition;
- All values: Treats the result values from the view variable query as parameters;
- Custom: Directly input the value in the selection bar and press Enter to create. You can search for your target variable in the selection bar.

Click **Select** to select all values in the current list.

**Note**: If there is a data interruption in the workspace during reporting, you cannot select data when configuring view variables. You can preset fields during configuration, and they will automatically match after data reporting resumes.

For created view variables, you can clone, edit, or delete them as needed.

![](img/variable-3.png)

If you choose to hide a variable while configuring view variables, it will show a :fontawesome-regular-eye-slash: hidden button on the right side of the list.

![](img/variable-5.png)

### Variable Query {#query}

View variables support four query methods: DQL Query, PromQL Query, UI Query, and Custom.

#### Value Range

There are two ways to determine the value range of view variables:

:material-numeric-1-circle-outline: Follow Dashboard Linkage: Lists data queried based on the time range selected by the dashboard's time control.
:material-numeric-2-circle-outline: Do Not Follow Dashboard Linkage: Lists all queried data without being affected by the time range selected by the dashboard's time control.

Below are explanations of the value ranges for different data sources:

<div class="grid" markdown>

=== "Metrics"

    | Data Type | Measurement Set   | Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Metrics     | SHOW_MEASUREMENT() function;<br>This function does not support adding time filters;<br>Value range: All measurement sets in the current workspace. | SHOW_TAG_KEY(from=['measurement_set_name']) function;<br>This function does not support adding time filters;<br>Value range: Tags under the selected measurement set in the current workspace. | SHOW_TAG_VALUE(from=['measurement_set_name'], keyin=['tag_name']);<br>This function does not support adding time filters. |

=== "Base Object"

    | Data Type | Classification   | Attributes/Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Base Object | O::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**;<br>Value range: All source values under the default index within the selected time. | SHOW_OBJECT_FIELD('kubernetes_nodes');<br>This function **does not support** adding time filters;<br>Value range: All fields under object data in the current workspace. | O::`kubernetes_nodes`:(DISTINCT_BY_COLLAPSE(`namespace`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**. |

=== "Resource Catalog"

    | Data Type | Classification   | Attributes/Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Resource Catalog | CO::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**<br>Value range: All source values under the default index within the selected time. | SHOW_CUSTOM_OBJECT_FIELD('class_value');<br>This function **does not support** adding time filters;<br>Value range: All fields under resource catalog data in the current workspace. | CO::`cdsmnl`:(DISTINCT_BY_COLLAPSE(`cds`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**. |

=== "Logs"

    | Data Type | Log Source   | Attributes   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Logs     | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**;<br>Value range: All source values under the default index within the selected time. | SHOW_LOGGING_FIELD(index='default');<br>This function **does not support** adding time filters;<br>Value range: All fields under log data in the current workspace. | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`trace_id`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**. |

=== "Application Performance"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | APM | SHOW_TRACING_FIELD();<br>This function **does not support** adding time filters;<br>Value range: All fields under tracing data in the current workspace. | T::RE(`.*`):(DISTINCT_BY_COLLAPSE(`resource`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**. |

=== "User Access"

    | Data Type | Data Classification   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | RUM | R::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**;<br>Value range: All source values under the default index within the selected time. | SHOW_RUM_FIELD('source_value');<br>This function **does not support** adding time filters;<br>Value range: All fields under user access data in the current workspace. | R::`error`:(DISTINCT_BY_COLLAPSE(`province`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**. |

=== "Security Check"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | Security Check | SHOW_SECURITY_FIELD();<br>This function **does not support** adding time filters;<br>Value range: All fields under security check data in the current workspace. | S::RE(`.*`):(DISTINCT_BY_COLLAPSE(`rule`));<br>This function **supports** adding time filters and **follows dashboard time control linkage**. |

</div>

#### DQL Query {#dql}

During DQL queries, users can directly write DQL statements to query corresponding data values. You can add time range filters and configure [cascade queries](#cascade) in your queries.

> Click [Learn more about DQL definitions and syntax](../dql/define.md).

*DQL Statement Query Example:*

**Note**: Non-metric data such as infrastructure and logs are recommended to use this method.

| Syntax | Description |
| --- | --- |
| Data Source Type::Data Source:(distinct('property_field')){filter_conditions} | M/metric - Time series metric data;<br>O/object - Object data;<br>L/logging - Log data;<br>E/event - Event data;<br>T/tracing - Tracing data;<br>R/rum - RUM data. |
| R::view:(distinct(`app_id`)) | Returns a list of `app_id` for web application user access monitoring. |
| R::view:(distinct(`env`)){`app_id` = '8f05003ebccad062'} | Returns a list of `env` for web application user access monitoring where `app_id=8f05003ebccad062`. |
| R::view:(distinct(`env`)){`app_id` = `#{appid}`} | By using `#{variable_name}` in the DQL statement, it can be used for [cascade queries](#cascade). It indicates that the previous query's variable name is set to `app_id`, returning the list of `env` corresponding to the selected `app_id` in the previous variable. |

##### Adding Time Range Explanation

When using DQL statements to query view variables, you can add a time range in the format [xx:xx:xx]:

- If a time range is added in the DQL query, it takes precedence over the time range selected by the dashboard time control.
- If no time range is added in the DQL query, it defaults to using the time range selected by the dashboard time control.

*Example:*

```
# Query container host list for the last 10 minutes 
O::docker_containers:(distinct(`host`)) [10m]
```

##### Show Function Query {#show}

When using DQL queries, you can use the Show function to query and return corresponding data values. The Show function does not support adding time range filters.

> Click [Learn more about DQL function descriptions](../dql/funcs.md).

*Show Function Query Example:*

**Note**: Metric data is recommended to use this query method.

| Syntax | Description |
| --- | --- |
| `show_measurement()` | Returns all measurement sets in the current workspace. |
| `show_tag_key(from=["cpu"])` | Returns tags under the `cpu` measurement set in the current workspace. |
| `show_tag_key(from=["cpu"],keyin=["host"])` | Queries the list of `host` tag values under the `cpu` measurement set in the current workspace. |

#### PromQL Query {#promql}

In PromQL queries, you can manually write query statements. By default, it uses the time range selected by the dashboard time control and returns corresponding data values.

> For more information about PromQL queries, refer to [PromQL Quick Start](../dql/promql.md).

#### UI Query

In UI queries, you can select data sources such as metrics, base objects, resource catalogs, logs, APM, RUM, and security checks, and directly click to select query variables on the UI to return corresponding data values.

In UI queries, you cannot add time ranges or configure [cascade queries](#cascade).

#### Custom Query

Custom refers to defining a set of values directly for view variables without needing to obtain related values through query statements. Content in custom variable options is separated by English commas `,`. Custom queries do not support adding time ranges or configuring cascade queries.

![](img/11.variable_10.png)

### Cascade Query {#cascade}

When configuring two or more view variables, and the second view variable needs to be linked based on the result of the first view variable, you can use cascade queries. Similarly, cascade queries can support multiple view variables for linked queries.

**Note**: Cascade queries only support DQL statements for query configurations.

#### Example

Let's take an example of configuring cascade filters for a Web Application Overview in user access monitoring, which requires linking queries based on **Application ID**, **Environment**, and **Version**.

![](img/18.variable_3.png)

**Configuration Explanation:**

**Application ID**, **Environment**, and **Version** have three variables, so you need to configure three variable query statements in the dashboard. In the second and third query statements, use `#{variable_name}` from the previous configuration to complete the cascade query configuration.

![](img/18.variable_2.png)

- **Variable 1 (Application ID)**: Query the list of applications with the application name `df_web_rum_sdk`:

```
R::view:(distinct(`app_id`)){sdk_name = `df_web_rum_sdk`}
```

- **Variable 2 (Environment)**: Query the list of environments under the selected Application ID from Variable 1, with the application name `df_web_rum_sdk`:

```
R::view:(distinct(`env`)) {app_id = `#{appid}` and sdk_name = `df_web_rum_sdk`}
```

- **Variable 3 (Version)**: Query the list of versions under the selected environment from Variable 2, with the application name `df_web_rum_sdk`:

```
R::view:(distinct(`version`)) {app_id = `#{appid}` and env = `#{env}` and sdk_name = `df_web_rum_sdk`}
```

#### Logical Operators

| Logical Operator      | Variable Value Matching Type     | Example    |
| ------------- | -------------- | ------- |
| = , !=      | Exact match, supports multi-selection. | R::view:(distinct(`env`)) {`app_id` = `#{appid}`      |
| match (re), not match (re)<br>wildcard, not wildcard | Fuzzy match, supports multi-selection. | R::view:(distinct(`env`)) {`app_id` = re(`#{appid}`)} |


## Adding Object Mapping

Field mapping can be set for infrastructure object data to improve display effects without affecting the original field data.

To add object mapping, click to enter the new page:

![](img/variable001.png)

Select data source, object classification, and the two attribute fields that need to be mapped. For example, map `container_id` to display as `container_name`. On the dashboard, the view variable value will be displayed as `container_name (container_id)` but still passes the value of `container_id` during querying. Additionally, if the field mapping feature is enabled in chart settings, the [legend](./visual-chart/timeseries-chart.md#legend) in the chart will display the mapped field value.

For created object mappings, you can edit or delete them as needed.

![](img/variable-4.png)

## Scenario Examples

### View Variable Configuration Example

1. After creating view variables, associate them with charts to achieve interactive filtering between charts and view variables.

1) In the chart query, select the variable in the `value` field. (The dropdown shows the variable name)

![](img/8.variable_11.png)

2) Switching variable values in the scene view will filter and display the chart based on the variable tags.

![](img/8.variable_12.png)

2. In the chart, clicking on a specific timeline or data point can directly add the selected value globally, achieving global interactive viewing of chart data analysis.

**Note**:
    
- Prerequisite: The corresponding [DQL](../scene/view-variable.md#dql) contains a `by` grouping condition;
- Involved chart types: Time Series Chart, Summary Chart, Pie Chart, Top List, Dashboard, Bar Chart, Scatter Plot, Bubble Chart, Table Chart, Rectangular Tree Map, China Map, World Map, Hexbin Map

1) After clicking on a specific timeline or data point, click the settings conditions under **Apply to View Variable** in the displayed card.

![](img/variables_2.png)

2) It will fill into the view variables of the dashboard. The effect is shown as follows:

![](img/variables_3.png)

### Object Mapping Configuration Example

Object mapping can be applied in two places: the drop-down display of view variables and the display of charts.

#### Applying in View Variables

Adding an object's **attribute field** in the view variables will display as: mapped field (queried field) if the field has also been set for field mapping.

*Example:*

1) Add the `container_id` variable in the **View Variables** (as shown in the figure below).

![](img/variable002.png)

2) Set `container_id` to map to `container_name` in **Object Mapping**.

![](img/variable001.png)

3) At this point, the view variable displays as: `container_name(container_id)`.

![](img/x10.png)

#### Applying in Charts

When querying an object's attribute field in the chart and enabling field mapping in settings, if the field has also been set for field mapping, it will display as: mapped field (queried field) in the chart variable.

*Example:*

1) Set `host` to map to `name` in **Object Mapping** (as shown in the figure below):

![](img/variable003.png)

2) Use this field in the chart query and enable **field mapping** in **Settings**, then the chart will display as `name(host)`.

![](img/x12.png)

???+ warning "Note"

    - Object mapping only supports setting object class data;
    - When using object mapping, you must first define a view variable based on an object class field;
    - For the same object classification, query fields do not support setting two mappings, i.e., the query field dropdown does not contain fields already added for that object classification;
    - When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not displayed;
    - When field mapping is disabled, the chart does not display the mapped fields and shows normally.