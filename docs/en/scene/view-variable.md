# View Variables
---

View variables are crucial in dynamic visual data analysis. They allow users to update visualization results in real-time by changing the value of one or more view variables, thus dynamically filtering and analyzing data according to their needs.


## Start Adding {#add}


1. Variable Name: The name of the current set of view variables, which needs to be referenced in chart queries when adding charts to the dashboard. The format is: `#{variable_name}`;   
2. Display Name: The name displayed for the current set of view variables on the dashboard, for example: if the variable name is `host`, the display name could be `HOST`;   
3. [Query](#query); 

    - Sorting: Default sorting, ascending or descending order can be applied to the view variables returned by the query.

4. Display Options

    - Hide: When enabled, the variable will not be visible on the dashboard in non-edit mode.
    - Include * Option: Enabled by default.
    - Multi-value: Allows selecting multiple values simultaneously.

5. Default Value: The initial variable for the current view variable on the dashboard. The dropdown here will list variables based on the configuration in **Display Options**, allowing you to select the initial variable to view by default on the dashboard. If the default value is empty, the latest field data will be displayed on the dashboard.

    - *: Condition is empty (null), no filtering for `by` conditions;
    - All values: Treats the result values from the view variable query statement as parameters;
    - Custom: Directly input a value in the selection bar and press Enter to create it. You can search for your target variable in the selection bar.

Click **Select All** to select all values in the current list.

???+ warning "Note"

    If workspace data reporting has gaps, you may not be able to select data when configuring view variables. In such cases, you can preset fields during configuration, and once data reporting resumes normally, the fields will automatically match.

## Manage Variables

- Directly clone, re-edit, or delete variables;    
- If you choose to hide a variable while configuring view variables, that variable will display a :fontawesome-regular-eye-slash: Hidden button on the right side of the list.

![](img/variable-5.png)

### Variable Query {#query}

Query methods:

- [DQL Query](#dql) 
- [PromQL Query](#promql)     
- [UI Query](#ui)      
- [External Data Source](#external)    
- [Custom](#custom)    

#### Range of Values

The range of values for view variables can be defined in two ways:

- Linked with the dashboard, i.e., listing the data queried based on the time range selected by the dashboard's time widget;  
- Not linked with the dashboard, i.e., listing all data queried without being affected by the time range selected by the dashboard's time widget.

Below is an explanation of the range of values for different data sources:

<div class="grid" markdown>

=== "Metrics"

    | Data Type | Measurement Set   | Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Metrics     | SHOW_MEASUREMENT() function;<br>This function does not support adding time filters;<br>Range: all measurement sets in the current workspace. | SHOW_TAG_KEY(from=['measurement_set_name']) function;<br>This function does not support adding time filters;<br>Range: tags under the selected measurement set in the current workspace. | SHOW_TAG_VALUE(from=['measurement_set_name'], keyin=['tag_name']);<br>This function does not support adding time filters. |

=== "Base Objects"

    | Data Type | Classification   | Attributes/Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Base Objects | O::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**;<br>Range: all source values in the default index within the selected time period. | SHOW_OBJECT_FIELD('kubernetes_nodes');<br>This function **does not support** adding time filters;<br>Range: all fields under object data in the current workspace. | O::`kubernetes_nodes`:(DISTINCT_BY_COLLAPSE(`namespace`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**. |

=== "Resource Catalog"

    | Data Type | Classification   | Attributes/Tags   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Resource Catalog | CO::RE(`.*`):(DISTINCT_BY_COLLAPSE(`class`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**<br>Range: all source values in the default index within the selected time period. | SHOW_CUSTOM_OBJECT_FIELD('class_value');<br>This function **does not support** adding time filters;<br>Range: all fields under resource catalog data in the current workspace. | CO::`cdsmnl`:(DISTINCT_BY_COLLAPSE(`cds`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**. |

=== "Logs"

    | Data Type | Log Source   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | Logs     | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**;<br>Range: all source values in the default index within the selected time period. | SHOW_LOGGING_FIELD(index='default');<br>This function **does not support** adding time filters;<br>Range: all fields under log data in the current workspace. | L::RE(`.*`):(DISTINCT_BY_COLLAPSE(`trace_id`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**. |


=== "Application Performance"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | APM | SHOW_TRACING_FIELD();<br>This function **does not support** adding time filters;<br>Range: all fields under tracing data in the current workspace. | T::RE(`.*`):(DISTINCT_BY_COLLAPSE(`resource`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**. |

=== "User Access"

    | Data Type | Data Classification   | Attribute   | Default Value   |
    | ------  | -------- | -------- | -------- |
    | RUM | R::RE(`.*`):(DISTINCT_BY_COLLAPSE(`source`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**;<br>Range: all source values in the default index within the selected time period. | SHOW_RUM_FIELD('source_value');<br>This function **does not support** adding time filters;<br>Range: all fields under user access data in the current workspace. | R::`error`:(DISTINCT_BY_COLLAPSE(`province`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**. |

=== "Security Check"

    | Data Type | Attribute      | Default Value   |
    | ------  | -------- | -------- |
    | Security Check | SHOW_SECURITY_FIELD();<br>This function **does not support** adding time filters;<br>Range: all fields under security check data in the current workspace. | S::RE(`.*`):(DISTINCT_BY_COLLAPSE(`rule`));<br>This function **supports** adding time filters, **linked with the dashboard's time widget**. |

</div>

#### DQL Query {#dql}

In the DQL query process, users can directly write DQL statements to return corresponding data values. You can add time range filters and configure [cascading queries](#cascade) in your queries.

> Click [Learn More About DQL Definitions and Syntax](../dql/define.md).

*DQL Statement Query Example:*

???+ warning "Note"

    Infrastructure, logs, etc., <u>non-metrics data</u> are recommended to use this method.

| Syntax | Description |
| --- | --- |
| Data Source Type::Data Source:(distinct('Attribute Field Name')){Filter Conditions} | M/metric - Time series metrics data;<br>O/object - Object data;<br>L/logging - Log data;<br>E/event - Event data;<br>T/tracing - Tracing data;<br>R/rum - RUM data. |
| R::view:(distinct(`app_id`)) | Returns the `app_id` list for web application user access monitoring. |
| R::view:(distinct(`env`)){`app_id` = '8f05003ebccad062'} | Returns the `env` list corresponding to Web application user access monitoring `app_id=8f05003ebccad062`. | 
| R::view:(distinct(`env`)){`app_id` = `#{appid}`} | By using `#{variable_name}` in the DQL statement, it can be used for [cascading queries](#cascade), indicating that the variable name for the previous query is set to `app_id`, then returns the `env` list corresponding to the selected `app_id` in the previous variable. |

##### Adding Time Range Explanation

When querying view variables using DQL statements, you can add a time range in the format [xx:xx:xx]:

- If a time range is added in the DQL query, it takes precedence over the time range selected by the dashboard time widget;
- If no time range is added in the DQL query, it defaults to using the time range selected by the dashboard time widget.

*Example:*

```
# Query container host list for the last 10 minutes 
O::docker_containers:(distinct(`host`)) [10m]
```

##### Show Function Query {#show}

When using DQL queries, you can use the Show function to return corresponding data values. The Show function does not support adding time range filters.

> Click [Learn More About DQL Function Descriptions](../dql/funcs.md).

*Show Function Query Example:*

???+ warning "Note"

    If metrics data is enabled, it is recommended to use this query method.

| Syntax | Description |
| --- | --- |
| `show_measurement()` | Returns all measurement sets in the current workspace. |
| `show_tag_key(from=["cpu"])` | Returns the tags under the `cpu` measurement set in the current workspace. |
| `show_tag_key(from=["cpu"],keyin=["host"])` | Queries the `host` tag value list under the `cpu` measurement set in the current workspace. |

#### PromQL Query {#promql}

PromQL queries support manually written query statements, defaulting to using the time selected by the dashboard time widget for querying and returning data.

> For more information about PromQL queries, refer to [PromQL Quick Start](../dql/promql.md).

#### UI Query {#ui}

UI queries support selecting the following data sources: metrics, base objects, resource catalogs, logs, application performance, user access, security checks.

By clicking to select query variables in the UI interface, you can obtain corresponding data values. However, in this mode, you cannot add a time range or configure [cascading queries](#cascade).

#### External Data Source {#external}

Directly integrate various external data sources like MySQL, calling native query statements to retrieve data in real-time.

1. Select data source;
2. Input query statement;
3. Choose sorting method.

> For more details, refer to [External Data Sources](../dataflux-func/external_data.md).

#### Custom Query {#custom}

Custom queries allow users to directly define a set of values for view variables without needing to acquire them through query statements. Each option is separated by an English comma `,`. This query method does not support adding time ranges or configuring cascading queries.

<img src="../img/custom_query.png" width="60%" >

### Cascading Queries {#cascade}

When configuring two or more view variables and the second view variable needs to perform linked queries based on the results of the first view variable, cascading queries can be used.

Cascading queries support linking multiple view variables but only support configuration using DQL statements.

???+ warning "Note"

    Cascading queries only support DQL statement configurations.

| Logical Operator      | Variable Value Matching Type     | Example    |
| ------------- | -------------- | ------- |
| = 、!=      | Exact match, supports multi-select. | R::view:(distinct(`env`)) {`app_id` = `#{appid}`      |
| match（re）、not match（re）<br>wildcard、not wildcard | Fuzzy match, supports multi-select. | R::view:(distinct(`env`)) {`app_id` = re(`#{appid}`)} |

#### Example

Below is an example of configuring cascading filtering for view variables in the User Access Monitoring Web Application Overview, based on Application ID, Environment, and Version.

![](img/18.variable_3.png)

Three variable query statements need to be configured in the dashboard. The second and third query statements use the `#{variable_name}` from the previous level to complete the cascading query configuration.

![](img/18.variable_2.png)


- **Variable 1 (Application ID)**: Query the application list where the application name is `df_web_rum_sdk`:

```
R::view:(distinct(`app_id`)){sdk_name = `df_web_rum_sdk`}
```

- **Variable 2 (Environment)**: Query the environment list under the selected Application ID in Variable 1, where the application name is `df_web_rum_sdk`:

```
R::view:(distinct(`env`)) {app_id = `#{appid}` and sdk_name = `df_web_rum_sdk`}
```

- **Variable 3 (Version)**: Query the version list under the selected Environment in Variable 2, where the application name is `df_web_rum_sdk`:

```
R::view:(distinct(`version`)) {app_id = `#{appid}` and env = `#{env}`  and sdk_name = `df_web_rum_sdk`}
```



## Add Object Mapping

For infrastructure object data, field mappings can be set to improve the display effect without affecting the original field data.

To add object mapping, click to enter the creation page:

![](img/variable001.png)

Select the data source, object classification, and two attributes/fields that need mapping. For example: map `container_id` to `container_name`. On the dashboard, the view variable value will be displayed as `container_name (container_id)` but still pass the value of `container_id` during querying. Additionally, if the field mapping function is enabled in the chart settings, the chart's [legend](./visual-chart/timeseries-chart.md#legend) will display the mapped field value.

For already created object mappings, you can edit or delete them as needed.

![](img/variable-4.png)

## Use Case Examples

### View Variable Configuration Example

1. After creating the view variable, associate it with the chart to achieve联动筛选 between the chart and the view variable.

1) In the chart query, when filtering fields, select this variable for the `value`. (The dropdown displays the variable name)

![](img/8.variable_11.png)

2) Switch the variable value in the scene view, and the chart will filter and display based on the variable label.

![](img/8.variable_12.png)

2. In the chart, after selecting a specific timeline or data point, you can directly click to add in reverse, achieving global linkage to view related chart data analysis for the selected value.

**Note**:
    
- Prerequisite: There exists a `by` grouping condition in the corresponding [DQL](../scene/view-variable.md#dql);
- Chart scope involved: Time series chart, Summary chart, Pie chart, Top List, Dashboard, Bar chart, Scatter plot, Bubble chart, Table chart, Treemap, China map, World map, Honeycomb chart

1) After clicking on a specific timeline or data point, click the setting condition under **Apply to View Variable** in the displayed card. 

![](img/variables_2.png)

2) It will fill into the view variable in the dashboard. The effect is shown below:

![](img/variables_3.png)

### Object Mapping Configuration Example

Object mapping can be applied in two places: the dropdown display in view variables and the display in charts.

#### Applying in View Variables

When adding an object's [attribute field] in view variables, if the field has also been set for field mapping, it will be displayed in the view variable as: Mapped field (queried field).

*Example:*

1) Add the `container_id` variable in [View Variables] (as shown in the figure below).

![](img/variable002.png)

2) Set `container_id` to map to `container_name` in [Object Mapping].

![](img/variable001.png)

3) At this point, the variable in the view will be displayed as: `container_name(container_id)`.

![](img/x10.png)

#### Applying in Charts

When querying an object's attribute field in a chart and enabling field mapping in the settings, if the field has also been set for field mapping, it will be displayed in the chart variable as: Mapped field (queried field).

*Example:*

1) Set `host` to map to `name` in [Object Mapping] (as shown in the figure below):

![](img/variable003.png)


2) Use this field in the chart query and enable [Field Mapping] in the [Settings], so the chart will display in the format `name(host)`.

![](img/x12.png)

???+ warning "Note"

    - Object mapping only supports setting for object class data;   
    - When using object mapping, you must first define a view variable based on an object class field;           
    - For the same object classification query field, two mappings cannot be set, meaning the query field dropdown will not include fields already added for that object classification; 
    - When enabling field mapping, the chart will display the **grouped field** and the corresponding **mapped field**, unassigned grouped fields will not be displayed;   
    - When disabling field mapping, the chart will not display the mapped field, displaying normally instead.