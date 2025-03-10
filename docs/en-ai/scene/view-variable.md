# View Variables
---

In dynamic data visualization analysis, view variables play a crucial role. They allow users to update the visualization results in real time by changing one or more view variable values. This real-time interactivity helps users dynamically filter and analyze data according to their needs, thereby gaining deeper insights into the stories behind the data.

![](img/18.variable_1.png)

## Adding View Variables {#add}

Click to enter the view variables tab page:

![](img/variable-1.png)

To add a view variable, click to enter the create page:

<img src="../img/variable-2.png" width="70%" >

:material-numeric-1-circle: Variable Name: The name of the current set of view variables, which needs to be referenced in chart queries when adding charts to the dashboard. Format: `#{Variable Name}`.

:material-numeric-2-circle: Display Name: The name displayed for the current set of view variables in the dashboard, for example, if the variable name is `host`, the display name is `Hostname`.

:material-numeric-3-circle: [Query](#query)

- Sorting: Default sorting, ascending/descending order for the returned view variables.

:material-numeric-4-circle: Display Options

- Hide: When enabled, the variable will not be visible on the dashboard in non-edit mode.
- Include * Option: Enabled by default.
- Multi-value: Allows selecting multiple values simultaneously.

:material-numeric-5-circle: Default Value: The initial value of the current view variable in the dashboard. The dropdown list here is based on your configuration in **Display Options**, allowing you to select the initial variable to view on the dashboard. If no default value is set, it will show the latest field data.

- *: Condition is null (empty), meaning no filtering for `by` conditions;
- All Values: Treats the results of the view variable query as parameters;
- Custom: Directly enter values in the selection bar and press Enter to create. You can search for your target variable in the selection bar.

Click **Select** to choose all values in the current list.

**Note**: If workspace data reporting is interrupted, you cannot select data when configuring view variables. You can preset fields during configuration, and they will automatically match once data reporting resumes.

For already created view variables, you can clone, edit, or delete them as needed.

![](img/variable-3.png)

If you hide a variable while configuring view variables, it will show a :fontawesome-regular-eye-slash: hidden button on the right side of the list.

![](img/variable-5.png)

### Variable Query {#query}

View variables support four query methods: DQL Query, PromQL Query, UI Query, and Custom.

#### Value Range

View variables have two types of value ranges:

:material-numeric-1-circle-outline: Follow Dashboard Time Widget, i.e., lists data queried based on the selected time range of the dashboard's time widget;
:material-numeric-2-circle-outline: Do Not Follow Dashboard Time Widget, i.e., lists all queried data without being affected by the selected time range of the dashboard's time widget.

Below are explanations of value ranges for different data sources:

<div class="grid" markdown>

=== "Metrics"

    | Data Type | Measurement   | Tag   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Metrics     | SHOW_MEASUREMENT() function;<br>This function does not support time filtering;<br>Value range: all mearsurements in the current workspace. | SHOW_TAG_KEY(from=['mearsurement_name']) function;<br>This function does not support time filtering;<br>Value range: tags under the selected measurement in the current workspace. | SHOW_TAG_VALUE(from=['mearsurement_name'], keyin=['tag_name']);<br>This function does not support time filtering. |

=== "Base Object"

    | Data Type | Class   | Attribute/Tag   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Base Object | O::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**;<br>Value range: all source values under the default index within the selected time. | SHOW_OBJECT_FIELD('kubernetes_nodes')；<br>This function **does not support** adding time filters;<br>Value range: all fields under object data in the current workspace. | O::`kubernetes_nodes`:(DISTINCT_BY_COLLAPSE(`namespace`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**. |

=== "Resource Catalog"

    | Data Type | Class   | Attribute/Tag   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Resource Catalog | CO::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**<br>Value range: all source values under the default index within the selected time. | SHOW_CUSTOM_OBJECT_FIELD('class_value')；<br>This function **does not support** adding time filters;<br>Value range: all fields under resource catalog data in the current workspace. | CO::`cdsmnl`:(DISTINCT_BY_COLLAPSE(`cds`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**. |

=== "Logs"

    | Data Type | Log Source   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Logs     | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**;<br>Value range: all source values under the default index within the selected time. | SHOW_LOGGING_FIELD(index='default')；<br>This function **does not support** adding time filters;<br>Value range: all fields under log data in the current workspace. | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`trace_id`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**. |

=== "APM"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | APM | SHOW_TRACING_FIELD()；<br>This function **does not support** adding time filters;<br>Value range: all fields under tracing data in the current workspace. | T::RE(`.*`):(DISTINCT_BY_COLLAPSE(`resource`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**. |

=== "RUM PV"

    | Data Type | Data Classification   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | RUM PV | R::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**;<br>Value range: all source values under the default index within the selected time. | SHOW_RUM_FIELD('source_value')；<br>This function **does not support** adding time filters;<br>Value range: all fields under RUM data in the current workspace. | R::`error`:(DISTINCT_BY_COLLAPSE(`province`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**. |

=== "Security Check"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | Security Check | SHOW_SECURITY_FIELD()；<br>This function **does not support** adding time filters;<br>Value range: all fields under security check data in the current workspace. | S::RE(`.*`):(DISTINCT_BY_COLLAPSE(`rule`))；<br>This function **supports** adding time filters and **follows the dashboard time widget**. |

</div>

#### DQL Query {#dql}

During DQL queries, users can directly write DQL statements to query corresponding data values. You can add time range filters and configure [cascade queries](#cascade) in your queries.

> Click [Learn More About DQL Definitions and Syntax](../dql/define.md).

*DQL Statement Query Example:*

**Note**: Non-metrics data such as infrastructure and logs are recommended to use this method.

| Syntax | Description |
| --- | --- |
| Data Source Type::Data Source:(distinct('Attribute Field Name')){Filter Conditions} | M/metric - Time Series Metrics Data;<br>O/object - Object Data;<br>L/logging - Log Data;<br>E/event - Event Data;<br>T/tracing - Tracing Data;<br>R/rum - RUM Data. |
| R::view:(distinct(`app_id`)) | Returns a list of `app_id` from web application RUM PV. |
| R::view:(distinct(`env`)){`app_id` = '8f05003ebccad062'} | Returns a list of `env` for the web application with `app_id=8f05003ebccad062`. |
| R::view:(distinct(`env`)){`app_id` = `#{appid}`} | Using `#{variable_name}` in DQL statements for [cascade queries](#cascade). If the previous query variable name is set to `app_id`, it returns a list of `env` corresponding to the selected `app_id` from the previous variable.

##### Adding Time Range Explanation

When using DQL statements to query view variables, you can add a time range in the format `[xx:xx:xx]`:

- If a time range is added in the DQL query, it takes precedence over the time range selected in the dashboard time widget.
- If no time range is added in the DQL query, it defaults to using the time range selected in the dashboard time widget.

*Example:*

```
# Query container host list in the last 10 minutes 
O::docker_containers:(distinct(`host`)) [10m]
```

##### Show Function Query {#show}

When using DQL queries, you can use the Show function to return corresponding data values. The Show function does not support adding time range filters.

> Click [Learn More About DQL Functions](../dql/funcs.md).

*Show Function Query Example:*

**Note**: Metrics data is recommended to use this query method.

| Syntax | Description |
| --- | --- |
| `show_measurement()` | Returns all mearsurements in the current workspace. |
| `show_tag_key(from=["cpu"])` | Returns tags under the `cpu` measurement in the current workspace. |
| `show_tag_key(from=["cpu"],keyin=["host"])` | Queries the list of `host` tag values under the `cpu` measurement in the current workspace.

#### PromQL Query {#promql}

PromQL queries support manually writing query statements. By default, it uses the time range selected in the dashboard time widget and returns corresponding data values.

> Refer to [PromQL Quick Start](../dql/promql.md) for more information about PromQL queries.

#### UI Query

UI queries support selecting data sources such as metrics, base objects, resource catalogs, logs, APM, RUM PV, and security checks. You can directly click and select query variables on the UI to return corresponding data values.

In UI queries, you cannot add time ranges or configure [cascade queries](#cascade).

#### Custom Query

Custom queries allow users to define a set of values for view variables directly without querying through statements. Each option in custom queries is separated by an English comma `,`. Custom queries do not support adding time ranges or configuring cascade queries.

![](img/11.variable_10.png)

### Cascade Queries {#cascade}

When configuring two or more view variables, and the second view variable depends on the result of the first view variable for联动查询, cascade queries can be used. Cascade queries can support multiple view variables' linked queries.

**Note**: Cascade queries only support DQL statements for query configuration.

#### Example

Using RUM PV configuration for web application overview view variables as an example, it requires cascading queries based on **App ID**, **Environment**, and **Version**.

![](img/18.variable_3.png)

**Configuration Explanation:**

**App ID**, **Environment**, and **Version** require three variable query statements in the dashboard configuration. In the second and third query statements, using the previously configured `#{variable_name}` completes the cascade query configuration.

![](img/18.variable_2.png)

- **Variable 1 (App ID)**: Query the application list named `df_web_rum_sdk`:

```
R::view:(distinct(`app_id`)){sdk_name = `df_web_rum_sdk`}
```

- **Variable 2 (Environment)**: Query the environment list under the selected App ID in Variable 1 for applications named `df_web_rum_sdk`:

```
R::view:(distinct(`env`)) {app_id = `#{appid}` and sdk_name = `df_web_rum_sdk`}
```

- **Variable 3 (Version)**: Query the version list under the selected environment in Variable 2 for applications named `df_web_rum_sdk`:

```
R::view:(distinct(`version`)) {app_id = `#{appid}` and env = `#{env}` and sdk_name = `df_web_rum_sdk`}
```

#### Logical Operators

| Logical Operator      | Match Type     | Example    |
| ------------- | -------------- | ------- |
| = 、!=      | Exact match, supports multi-select. | R::view:(distinct(`env`)) {`app_id` = `#{appid}`      |
| match（re）、not match（re）<br>wildcard、not wildcard | Fuzzy match, supports multi-select. | R::view:(distinct(`env`)) {`app_id` = re(`#{appid}`)} |

## Adding Object Mapping

Field mapping for infrastructure object data can be set to improve display effects without affecting the original field data.

To add object mapping, click to enter the create page:

![](img/variable001.png)

Select the data source, object class, and two attribute fields that need mapping. For example, map `container_id` to display as `container_name`. In the dashboard, the view variable value will display as `container_name (container_id)`, but during queries, it still passes the `container_id` value. Additionally, if field mapping is enabled in chart settings, the chart [legend](./visual-chart/timeseries-chart.md#legend) will display the mapped field value.

For already created object mappings, you can edit or delete them as needed.

![](img/variable-4.png)

## Scenario Examples

### View Variable Configuration Example

1. After creating view variables, associate them with charts to achieve interactive filtering between charts and view variables.

1) In the chart query, select the variable as the `value` when filtering fields (the dropdown shows the variable name).

![](img/8.variable_11.png)

2) Switching variable values in the scene view will filter and display the chart based on the variable label.

![](img/8.variable_12.png)

2. In charts, clicking specific timelines or data points can directly add them in reverse, achieving global linked viewing of related chart data analysis.

**Note**:

- Prerequisite: The corresponding [DQL](../scene/view-variable.md#dql) contains a `by` grouping condition.
- Chart Scope: Time series chart, summary chart, pie chart, top list, gauge chart, bar chart, scatter plot, bubble chart, table chart, treemap, China map, world map, hexbin map

1) After clicking a specific timeline or data point, click the settings condition under **Apply to View Variables** in the displayed card.

![](img/variables_2.png)

2) It will populate the dashboard's view variables. The effect is shown below:

![](img/variables_3.png)

### Object Mapping Configuration Example

Object mapping can be applied in two places: view variable dropdowns and chart displays.

#### Application in View Variables

Adding an object's **attribute field** in view variables will display as: mapped field (queried field).

*Example:*

1) Add the `container_id` variable in **View Variables** (as shown below).

![](img/variable002.png)

2) Set `container_id` to map to `container_name` in **Object Mapping**.

![](img/variable001.png)

3) The view variable now displays as: `container_name(container_id)`.

![](img/x10.png)

#### Application in Charts

When querying an object's attribute field in charts and enabling field mapping in settings, if the field has been mapped, it will display as: mapped field (queried field).

*Example:*

1) In **Object Mapping**, set `host` to map to `name` (as shown below):

![](img/variable003.png)

2) Use this field in chart queries and enable **field mapping** in **settings**, so the chart will display as `name(host)`.

![](img/x12.png)

???+ warning "Note"

    - Object mapping only supports object class data;
    - When using object mapping, you must first define a view variable based on an object class field;
    - For the same object class, query fields do not support setting two mappings, i.e., the query field dropdown does not include fields already added for the object class;
    - When field mapping is enabled, the chart displays the **grouped fields** and corresponding **mapped fields**; unmapped grouped fields are not displayed;
    - When field mapping is disabled, the chart does not display mapped fields and shows normally.