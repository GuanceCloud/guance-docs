# 图表链接
---

通过图表关联链接实现数据联动，支持从当前图表跳转至目标页面并传递数据信息。系统提供以下模板变量：


## 变量类型

支持 4 种模板变量：

- 时间变量
- 标签变量
- 视图变量
- 值变量

### 时间变量 {#time}

| <div style="width: 180px">变量<div style="width: 160px"> | 说明 |
| --- | --- |
| `#{TR}` | 当前图表查询的时间范围。例如，若查询时间为最近`最近 1 小时`，则模板变量 `&time=#{TR}` 等同于 `&time=1h`  |
| `#{timestamp.start}` | 当前图表查询所选数据点的开始时间  |
| `#{timestamp.end}` | 当前图表查询所选数据点的结束时间  |
| `#{startTime}` | 未锁定时间时为图表右上角时间控件的开始时间，已锁定时为锁定时间的开始时间  |
| `#{endTime}` | 未锁定时间时为图表右上角时间控件的结束时间，已锁定时为锁定时间的结束时间  |

???+ warning "注意"

    在进行实际查询时，可利用时间变量 `#{startTime}` 和 `#{endTime}` 以及视图变量作为占位符。系统会根据全局设置的变量值进行替换。

### 标签变量

| 变量 | 说明 |
| --- | --- |
| `#{T}` | 当前图表查询的所有分组标签集合。例如，若查询为<br />`M::'datakit':(LAST('cpu_usage'))  BY 'host','os'`<br />查询结果为：host=abc、os=linux<br /><br />则：<br /><li>模板变量：`&query=#{T} `等同为 `&query=host:abc os:linux` |
| `#{T.name}` | 某个标签的值。例如，若查询为<br />`M::'datakit':(LAST('cpu_usage')) BY 'host', 'os'`<br />查询结果为：host=abc、os=linux<br /><br />则：<br /><li>模板变量 `#{T.host} = abc`<br />`&query=hostname:#{T.host}` 等同为 `&query=hostname:abc` |

### 视图变量

| 变量 | 说明 |
| --- | --- |
| `#{V}` | 当前仪表板中所有视图变量的集合。例如，若视图变量为：<br />version=V1.7.0 和 region=cn-hangzhou<br /><br />则：<br /><li>模板变量` &query=#{V}  `等同为 `&query=version:V1.7.0 region:cn-hangzhou` |
| `#{V.name}`| 当前仪表板中某一个视图变量的值，name 可替换为任意变量名。<br />假设当前仪表板的视图变量 version=V1.7.0<br /><br />则：<br /><li>模板变量  `#{V.version} = V1.7.0`<br /><li> `&query=version:#{V.version}` 等同为 `&query=version:V1.7.0`<br /> |

### 值变量 {#z-variate}

| 图表类型 | <div style="width: 160px">变量</div> | 说明 |
| --- | --- | --- |
| 时序图<br />概览图<br />饼图<br />柱状图<br />排行榜<br />仪表板<br />漏斗图 | `#{Value}` | 当前图表查询返回的数据值变量。例如，若查询 `M::cpu:(AVG(load5s))` 查询结果为：AVG(load5s)=a<br /><br />则：<br /><li>值变量：`&query=#{Value}` 等同为 `&query=AVG(load5s):a` |
| 散点图 | `#{Value.X}` | 当前图表查询返回的 X 轴数据值变量。假设当前图表查询为：<br />`M::cpu:(AVG(load5s))`<br />查询结果为：X:AVG(load5s)=abc<br /><br />则：<br /><li>值变量：`&query=#{Value.X} `等同为 `&query=X:abc` |
|  | `#{Value.Y}` | 当前图表查询返回的 Y 轴数据值变量。例如，若查询 `M::backuplog:(AVG(lru_add_cache_success_count))`<br />查询结果为：Y:AVG(lru_add_cache_success_count)=dca<br /><br />则：<br /><li>值变量 `&query=Y:#{Value.Y}` 等同为 `&query=Y:dca` |
| 气泡图 | `#{Value.X}` | 当前图表查询返回的 X 轴数据值变量。例如，若查询 `T::RE(.*):(FIRST(duration)) BY service`<br />查询结果为：X:first(duration)=98<br /><br />则：<br /><li>值变量：`&query=X:#{Value.X} `等同为 `&query=X:98` |
|  | `#{Value.Y}` | 当前图表查询返回的 Y 轴数据值变量。例如，若查询 `T::RE(.*):(LAST(duration)) BY service`<br />查询结果为：Y:last(duration)=8500<br /><br />则：<br /><li>值变量 `&query=Y:#{Value.Y}` 等同为 `&query=Y:8500` |
|  | `#{Value.Size}` | 当前图表查询返回的 Size 数据值变量。例如，若查询 `T::RE(.*):(MAX(duration)) BY service`<br />查询结果为：Size:Max(duration)=1773<br /><br />则：<br /><li>值变量 `&query=Size:#{Value.Size}` 等同为 `&query=Size:1773` |
| 表格图 | `#{Value.column_name}` | 当前图表选中的列值变量，`name` 可替换为任意列变量名。例如，若查询 `L::RE(.*):(COUNT(*)) { index = default }`<br />查询结果为：count(*)=40813<br /><br />则：<br /><li>值变量` &query=#{Value.count(*)} `等同为 `&query=count(*):40813` |
| 矩形树图<br />蜂窝图<br />世界地图<br />中国地图 | `#{Value.metric_name}` | 当前图表选中的查询数据值变量，`name` 可替换为任意列变量名。例如，若查询 `L::RE(.*):(MAX(response_time)) { index = default } BY country`<br />查询结果为：max(response_time)=16692<br /><br />则：<br /><li>值变量` &query=#{Value.max(response_time)}  `等同为 `&query=max(response_time):16692` |

