# Chart Links
---

Enable data association through chart-related links, allowing for navigation from the current chart to a target page while passing data information. The system provides the following template variables: 


## Variable Types

Supports 4 types of template variables:

- Time variables
- Label variables
- View variables
- Value variables

### Time Variables {#time}

| <div style="width: 180px">Variable<div style="width: 160px"> | Description |
| --- | --- |
| `#{TR}` | The time range of the current chart query. For example, if the query time is "last 1 hour", then the template variable `&time=#{TR}` is equivalent to `&time=1h` |
| `#{timestamp.start}` | The start time of the selected data point in the current chart query |
| `#{timestamp.end}` | The end time of the selected data point in the current chart query |
| `#{startTime}` | When time is not locked, it is the start time of the time widget in the top right corner of the chart; when locked, it is the start time of the locked period |
| `#{endTime}` | When time is not locked, it is the end time of the time widget in the top right corner of the chart; when locked, it is the end time of the locked period |

???+ warning "Note"

    During actual queries, you can use the time variables `#{startTime}` and `#{endTime}` as placeholders along with view variables. The system will replace them based on globally set variable values.

### Label Variables

| Variable | Description |
| --- | --- |
| `#{T}` | A collection of all grouped label sets from the current chart query. For example, if the query is<br />`M::'datakit':(LAST('cpu_usage')) BY 'host','os'`<br />Query result: host=abc, os=linux<br /><br />Then:<br /><li>Template variable: `&query=#{T} `is equivalent to `&query=host:abc os:linux` |
| `#{T.name}` | The value of a specific label. For example, if the query is<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />Query result: host=abc, os=linux<br /><br />Then:<br /><li>Template variable `#{T.host} = abc`<br />`&query=hostname:#{T.host}` is equivalent to `&query=hostname:abc` |

### View Variables

| Variable | Description |
| --- | --- |
| `#{V}` | A collection of all view variables in the current dashboard. For example, if the view variables are:<br />version=V1.7.0 and region=cn-hangzhou<br /><br />Then:<br /><li>Template variable `&query=#{V}` is equivalent to `&query=version:V1.7.0 region:cn-hangzhou` |
| `#{V.name}` | The value of a specific view variable in the current dashboard, where `name` can be replaced by any variable name.<br />Assume the current dashboard's view variable is version=V1.7.0<br /><br />Then:<br /><li>Template variable `#{V.version} = V1.7.0`<br /><li>`&query=version:#{V.version}` is equivalent to `&query=version:V1.7.0` |

### Value Variables {#z-variate}

| Chart Type | <div style="width: 160px">Variable</div> | Description |
| --- | --- | --- |
| Time series chart<br />Summary chart<br />Pie chart<br />Bar chart<br />Top list<br />Dashboard<br />Funnel chart | `#{Value}` | Data value variable returned by the current chart query. For example, if querying `M::cpu:(AVG(load5s))` results in AVG(load5s)=a<br /><br />Then:<br /><li>Value variable: `&query=#{Value}` is equivalent to `&query=AVG(load5s):a` |
| Scatter plot | `#{Value.X}` | X-axis data value variable returned by the current chart query. Assume the current chart query is:<br />`M::cpu:(AVG(load5s))`<br />Query result: X:AVG(load5s)=abc<br /><br />Then:<br /><li>Value variable: `&query=#{Value.X}` is equivalent to `&query=X:abc` |
|  | `#{Value.Y}` | Y-axis data value variable returned by the current chart query. For example, if querying `M::backuplog:(AVG(lru_add_cache_success_count))`<br />Query result: Y:AVG(lru_add_cache_success_count)=dca<br /><br />Then:<br /><li>Value variable `&query=Y:#{Value.Y}` is equivalent to `&query=Y:dca` |
| Bubble chart | `#{Value.X}` | X-axis data value variable returned by the current chart query. For example, if querying `T::RE(.*):(FIRST(duration)) BY service`<br />Query result: X:first(duration)=98<br /><br />Then:<br /><li>Value variable: `&query=X:#{Value.X}` is equivalent to `&query=X:98` |
|  | `#{Value.Y}` | Y-axis data value variable returned by the current chart query. For example, if querying `T::RE(.*):(LAST(duration)) BY service`<br />Query result: Y:last(duration)=8500<br /><br />Then:<br /><li>Value variable `&query=Y:#{Value.Y}` is equivalent to `&query=Y:8500` |
|  | `#{Value.Size}` | Size data value variable returned by the current chart query. For example, if querying `T::RE(.*):(MAX(duration)) BY service`<br />Query result: Size:Max(duration)=1773<br /><br />Then:<br /><li>Value variable `&query=Size:#{Value.Size}` is equivalent to `&query=Size:1773` |
| Table chart | `#{Value.column_name}` | Selected column value variable from the current chart, where `name` can be replaced by any column variable name. For example, if querying `L::RE(.*):(COUNT(*)) { index = default }`<br />Query result: count(*)=40813<br /><br />Then:<br /><li>Value variable `&query=#{Value.count(*)}` is equivalent to `&query=count(*):40813` |
| Rectangular treemap<br />Hexbin chart<br />World map<br />China map | `#{Value.metric_name}` | Selected query data value variable from the current chart, where `name` can be replaced by any column variable name. For example, if querying `L::RE(.*):(MAX(response_time)) { index = default } BY country`<br />Query result: max(response_time)=16692<br /><br />Then:<br /><li>Value variable `&query=#{Value.max(response_time)}` is equivalent to `&query=max(response_time):16692` |