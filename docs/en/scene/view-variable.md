# View Variables
---

## Overview

Observation Cloud supports adding global variables to the view. When you want to dynamically complete the filtering of the chart in the dashboard, you can choose to use view variables to do so.

Note: When switching view variables, only the first 50 are supported in the drop-down, so you can search to see the rest of the variables.

## Adding view variables

In the dashboard, if you have not added a view variable, the 「Add View Variable」 button is displayed in the top navigation bar, click it to enter the Add View Variable.

![](img/2.view_variable_2.png)

If you have already added a view variable, the name of the view variable will be displayed under the top navigation bar, click the 「Edit」 button on the right to enter the view variable editing page.

![](img/2.view_variable_1.png)

In the view variable editing page, you can select 「Data Source」, enter/select 「Variable Query」, 「Default Value」, 「Variable Name」, 「Display Name」, set whether to hide, sort, delete, and other operations. Data sources include metrics, DQL, system objects, custom objects, logs, application performance, user access, security patrol, and custom

![](img/variable.png)

### Variable queries

#### DQL Query

Query variables and associative variables can be implemented using DQL. ([Learn more about DQL functions] (../dql/funcs.md))

##### Show Function Query

> 【Indicator data】 Suggested use of this query

| Grammar | Description |
| --- | --- |
| show_measurement() | Return a collection of indicators for time-series data |
| show_tag_key(from=["Indicator set name"]) | Returns a list of indicator set tags, which can be specified for specific indicators |
| show_tag_value(from=['Indicator set name'], keyin=['Label Name']) | Returns a list of tag values for the specified tag key in the database |
| show_object_source()    <br /> `object `Can be replaced with logging/event/tracing/rum | Return object /log/keyevent/tracing /rum data collection of indicators, the function does not require parameters |

`SHOW_TAG_VALUE` Function Example：

```
##Query the list of host tag values for the indicator set cpu
SHOW_TAG_VALUE(from=["cpu"],keyin=["host"])
```

##### DQL statement query

> Infrastructure, logs, etc. 【non-metric data】 are recommended to use this method

| Grammar | Description |
| --- | --- |
| Data Source Type::Data source:(distinct('Attribute Field Name')){Filter criteria} | M/metric - Time series index data ；O/object - Object data；L/logging - Log Data ；E/event - Event Data ；T/tracing - Tracking Data  ；R/rum - RUM Data |
| R::view:(distinct('app_id')) | Returns a list of app_id's monitored by web application users |
| R::view:(distinct('env')) {'app_id' = '#{appid}'} | Variable linkage, if the variable name of the previous query is set to app_id, the list of env corresponding to the app_id selected in the previous variable is returned |
| R::view:(distinct('env')) {'app_id' = '8f05003ebccad062'} | Return the env list corresponding to `app_id=8f05003ebccad062` |

##### Variable linkage query

> 使Use scenario: two variables host (host), container_name (container), select host, automatically display the Host corresponding to all Container list

Variable 1 (host name): _query the list of container hosts in the last 10 minutes_

```
O::docker_containers:(distinct(`host`)) [10m]
```

Variable 2 (container name): _query the list of containers under the host selected in variable 1_

```
O::docker_containers:(distinct(`container_name`)) {`host`=`#{host}`}[10m]
```


![](img/11.variable_3.png)

#### Indicator Search

Select 【Indicator Set】 and the corresponding 【Label】.

![](img/11.variable_4.png)

#### Infrastructure Inquiry

Select 【Category】 and the corresponding 【Label/Property】.

![](img/11.variable_5.png)

#### Log query

Select 【Log Source】 and the corresponding 【Properties】.

![](img/11.variable_6.png)

#### Apply performance queries

Select 【Properties】

![](img/11.variable_7.png)

#### User access query

Select 【Data Category】 and the corresponding 【Property】

![](img/11.variable_8.png)

#### Safety inspection inquiry

Select 【Properties】

![](img/11.variable_9.png)

#### Custom Queries

Customize the content in the variable options, each option is separated by an English ",".

![](img/11.variable_10.png)

### Variable Settings

#### Field Description
| Fields | Description |
| --- | --- |
| Default Value | Initial variables in the dashboard for the current view variable. Support for previewing all variables of the current view variable and selecting the initial variables to be viewed in the dashboard by default. The list of default values shows up to 50 variables, with support for searching to find more |
| Variable Name | The name of the variable to which the current set of view variables belongs, which needs to be referenced in the chart query when adding a chart in the dashboard, in the format: #{variable name} |
| Display Name | Name of the current set of view variables displayed in the dashboard, e.g. variable named "host", displayed as "hostname" |

#### Advanced settings

The following advanced configurations can be made for view variables.

| Function | Description |
| --- | --- |
| Drag and drop sorting | Hover to the icon with the mouse, click and drag the view variables to adjust the order |
| Sort by | Default, ascending and descending, sorting arrangement for view variables returned by the query. |
| Whether to hide | When this feature is enabled, the variable is not visible in non-editing mode, and the 「Add View Variable」 button is displayed in the top navigation bar |

## How to use view variables

After the view variable is created, you have to associate this variable in the chart to achieve the linked filtering between the chart and the view variable.

1) In the chart query, when filtering the field, value value check the variable. (The variable name is shown in the drop-down here)

![](img/8.variable_11.png)

2) Switching variable values in the scene view, the chart will be filtered and displayed according to the variable labels

![](img/8.variable_12.png)

## Modify/delete view variables

Click 「Edit」, click the view variable edit icon to enter the variable management page, then you can 「Modify」, and click the delete icon to 「Delete」.

## Object Mapping

Field mapping can be set for infrastructure object data, and the field mapping is only used for display and will not affect the original field data.

### Adding mapping

Select 【Data Source】 【Object Category】 and the two 【Property Fields】 that need to be mapped. As shown in the following figure: `container_id` is mapped to `container_name`.

![](img/variable001.png)

### How to use object mapping

The results of field mapping can be applied in two places: 1) in the drop-down display of view variables and 2) in the display of charts.

#### Apply in the view variable

Add the object's 【Property Field】 to the view variable, and if the field is also set to field mapping, then it will be displayed in the view variable as: Mapped Field (Query Field).

Examples.

1) The `container_id` variable is added to the 【view variable】 (as shown in the figure below).

![](img/variable002.png)

2) Set `container_id` to be mapped to `container_name` in 【Object Mapping】.

![](img/variable001.png)

3) At this time, the variable is displayed in the view as: `container_name(container_id)`.


![](img/x10.png)

#### Apply in the chart

If you have queried the object's 【Property Field】 in the chart and turned on 【Field Mapping】 in the settings, if the field is also set to field mapping, it will be displayed in the chart variable as: Mapped Field (Query Field).

Examples.

1) Set `host` mapped to `name` in 【Object Mapping】 (as shown below).

![](img/variable003.png)


2) Use the field in the chart query and turn on 【Field Mapping】 in 【Settings】, then display the format `name(host)` in the chart.

![](img/x12.png)

Caution.

- Object mapping only supports setting object class data
- When using object mapping, you must first define a view variable based on the object class fields
- Two mappings are not supported for query fields of the same object class, i.e. there are no fields added to the object class in the query field drop-down
- When field mapping is turned on, the 「grouped fields」 of the query and the corresponding 「mapped fields」 are displayed in the chart, and the grouped fields without specified mapping are not displayed.
- When field mapping is turned off, the mapped fields are not displayed in the chart, but are displayed normally.

