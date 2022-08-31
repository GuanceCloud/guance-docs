# 用户访问指标检测
---

## 概述

「用户访问指标检测」用于监控工作空间内「用户访问监测」的指标数据，通过设置阈值范围，当指标到达阈值后触发告警，支持对单个指标设置告警和自定义告警等级。

## 规则说明

在「监控器」中，点击「+新建监控器」，选择「用户访问指标检测」，进入检测规则的配置页面。

### 步骤1.基本信息

![](../img/6.monitor01.png)

1）**规则名称：**检测规则的名称。

2）**关联仪表板：**每一个监控器都支持关联一个仪表板，即通过「关联仪表板」功能能够自定义快速跳转的仪表板（监控器关联的仪表板，支持快速跳转查看监控视图）。

### 步骤2.检测配置

![](../img/6.monitor07.png)

3）**检测频率：**检测规则的执行频率，包含1m/5m/15/30m/1h/6h（默认选中5m）。

4）**检测区间：**下拉选项与检测频率有联动，支持用户自定义。

| 检测频率 | 检测区间（下拉可选项） | 自定义区间限制 |
| --- | --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h | <=3h |
| 5m | 5m/15m/30m/1h/3h | <=3h |
| 15m | 15m/30m/1h/3h/6h | <=6h |
| 30m | 30m/1h/3h/6h | <=6h |
| 1h | 1h/3h/6h/12h/24h | <=24h |
| 6h | 6h/12h/24h | <=24h |

6）**检测指标：**设置检测数据的指标。支持设置当前工作空间内单一应用类型下全部/单个应用在一定时间范围内的指标数据。如：当前工作空间内，Web类型下全部应用的指标数据。

| 字段 | 说明 |
| --- | --- |
| 应用类型 | 「用户访问监测」支持的应用类型，包括Web、Android、iOS、Miniapp |
| 应用名称 | 基于应用类型获取对应的应用列表，支持全选和单选 |
| 指标 | 基于应用类型获取的指标列表，<br>**Web/Miniapp**（包括JS错误数、JS错误率、资源错误数、资源错误率、首次渲染平均时间、页面加载平均耗时、LCP(largest_contentful_paint)、FID(first_input_delay)、CLS(cumulative_layout_shift)、FCP(first_contentful_paint) 等）<br>**Android/IOS**（包括启动耗时、总崩溃数、总崩溃率、资源错误数、资源错误率、FPS、页面加载平均耗时等） |
| 筛选条件 | 基于指标的标签对检测指标的数据进行筛选，限定检测的数据范围。支持添加一个或多个标签筛选，支持模糊匹配和模糊不匹配的筛选条件。 |
| 维度 | 检测指标的触发维度，即触发对象。任意一个触发对象的指标满足告警条件则触发告警，不支持 int 型字段为触发维度，且最多支持选择三个字段 |

[**Web**](../../real-user-monitoring/web/app-data-collection.md) / [**Miniapp**](../../real-user-monitoring/miniapp/app-data-collection.md) **指标说明**

<table>
<tr>
<td> 指标 </td> <td> 查询示例 </td>
</tr>

<tr>
<td> JS错误数 </td> 
<td> 

R::js_error:(count(`error_message`)) {`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> JS错误率 </td> 
<td> 

F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::page:(count(`page_url`) as count) {`app_id` = '#{appid}',`page_js_error_count` > 0}"),
data2 = dql("R::page:(count(`page_url`) as count) {`app_id` = '#{appid}'}")
))

</td>
</tr>

<tr>
<td> 资源错误数 </td> 
<td> 

R::resource:(count(`resource_url`)) {`app_id` = '#{appid}',( `resource_status_group` = '4xx' || `resource_status_group` = '5xx')}

</td>
</tr>

<tr>
<td> 资源错误率 </td> 
<td> 

F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::resource:(count(`page_url`) as count) {`app_id` = '#{appid}',`resource_status` >= 400}"),
data2 = dql("R::resource:(count(`page_url`) as count) {`app_id` = '#{appid}'}")
))

</td>
</tr>

<tr>
<td> 首次渲染平均时间 </td> 
<td> 

R::page:(avg(page_fpt)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> 页面加载平均耗时 </td> 
<td> 

R::view:(avg(loading_time)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> 页面慢加载次数 </td> 
<td> 

R::resource:(count(resource_load)){`app_id` = '#{appid}',`resource_load`>8000000000,resource_type='document'}

</td>
</tr>

<tr>
<td> 资源加载平均耗时 </td> 
<td> 

R::resource:(avg(`resource_load`) as `加载耗时` ) {`app_id` = '#{appid}',resource_type!='document'}

</td>
</tr>

<tr>
<td> LCP
(largest_contentful_paint) </td> 
<td> 

包括聚合函数: avg、P75、P90、P99
R::view:(avg(largest_contentful_paint)){`app_id` = '#{appid}'}
R::view:(percentile(`largest_contentful_paint`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`largest_contentful_paint`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`largest_contentful_paint`,99)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> FID
(first_input_delay) </td> 
<td> 

包括聚合函数: avg、P75、P90、P99
R::view:(avg(first_input_delay)){`app_id` = '#{appid}'}
R::view:(percentile(`first_input_delay`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`first_input_delay`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`first_input_delay`,99)){`app_id` = '#{appid}'}

</td>
</tr>

<tr>
<td> CLS
(cumulative_layout_shift) </td> 
<td> 

包括聚合函数: avg、P75、P90、P99
R::view:(avg(cumulative_layout_shift)){`app_id` = '#{appid}'}
R::view:(percentile(`cumulative_layout_shift`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`cumulative_layout_shift`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`cumulative_layout_shift`,99)){`app_id` = '#{appid}'}

</td>
</tr>


<tr>
<td> FCP
(first_contentful_paint)  </td> 
<td> 

包括聚合函数: avg、P75、P90、P99
R::view:(avg(first_contentful_paint)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,75)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,90)){`app_id` = '#{appid}'}
R::view:(percentile(`first_contentful_paint`,99)){`app_id` = '#{appid}'}

</td>
</tr>

</table>

[**Android**](../../real-user-monitoring/android/app-data-collection.md) **/** [**IOS**](../../real-user-monitoring/ios/app-data-collection.md) **指标说明**

<table>

<tr>
<td> 指标 </td> <td> 查询示例 </td>
</tr>

<tr>
<td> 启动耗时 </td> 
<td> 

```
M::rum_app_startup:(AVG(`app_startup_duration`)) { `app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> 总崩溃数 </td> 
<td> 

```
R::crash:(count(`crash_type`)) {`app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> 总崩溃率 </td> 
<td> 

```
F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::crash:(count(`crash_type`) as count) {`app_id` = '#{appid}'}"),
data2 = dql("M::rum_app_startup:(count(`app_startup_duration`) as count) {`app_id` = '#{appid}'}")
))
```

</td>
</tr>

<tr>
<td> 资源错误数 </td> 
<td> 

```
R::resource:(count(`resource_url`) as count) {`app_id` = '#{appid}',`resource_status` >= 400}
```

</td>
</tr>

<tr>
<td> 资源错误率 </td> 
<td> 

```
F::dataflux__dql:(exec_expr
(expr='data1.count/data2.count*100',
pre_func='SUM',
data1 = dql("R::resource:(count(`resource_url`) as count) {`app_id` = '#{appid}',`resource_status` >= 400}"),
data2 = dql("R::resource:(count(`resource_url`) as count) {`app_id` = '#{appid}'}")
))
```

</td>
</tr>

<tr>
<td> FPS </td> 
<td> 

```
R::view:(avg(`view_fps`)) {`app_id` = '#{appid}'}
```

</td>
</tr>


<tr>
<td> 页面加载平均耗时 </td> 
<td> 

```
R::view:(avg(`view_load`)) {`app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> 资源加载平均耗时 </td> 
<td>

```
R::resource:(avg(`resource_load`)) { `app_id` = '#{appid}'}
```

</td>
</tr>

<tr>
<td> 卡顿次数 </td> 
<td> 

```
R::freeze:(count(`freeze_type`) as count) {`app_id` = '#{appid}'}
```

</td>
</tr>

</table>


5）**触发条件：**设置告警级别的触发条件。

- 告警级别：包含紧急（红色）、重要（橙色）、警告（黄色）、无数据（灰色）、正常（绿色）五个等级，每个等级只能设置一个触发条件。
- 触发条件：基于配置条件判断操作符和检测周期。若查询结果带单位，则提示单位进位后的结果。

**告警级别紧急（红色）、重要（橙色）、警告（黄色）基于配置条件判断操作符，说明如下：**

| 操作符 | 说明 | 支持的判断类型 |
| --- | --- | --- |
| `=` | 等于 | `Integer`、`Float`、`String` |
| `!=` | 不等于 | `Integer`、`Float`、`String` |
| `>=` | 大于等于 | `Integer`、`Float`、`String` |
| `<=` | 小于等于 | `Integer`、`Float`、`String` |
| `>` | 大于 | `Integer`、`Float`、`String` |
| `<` | 小于 | `Integer`、`Float`、`String` |
| `between` | 大于等于且小于等于（闭区间） | `Integer`、`Float`、`String` |


**告警级别无数据（灰色）、正常（绿色）基于配置检测周期，说明如下：**

- 检测周期＝检测频率
- 自定义检测周期＝检测频率 * N

1.无数据（灰色）：无数据状态支持「触发无数据事件」、「触发恢复事件」、「不触发事件」三种配置，需要手动配置无数据处理策略。

检测规则生效后，第一次检测无数据且持续无数据，不产生无数据告警事件；若检测有数据且在配置的自定义检测周期内，数据上报发生断档，则产生无数据告警事件。可参考以下场景：

| 场景 | 最后一次无数据事件 | 最后一次事件状态 | 结果 |
| --- | --- | --- | --- |
| 数据始终正常 | - | - | 数据无断档，正常 |
| 数据发生断档 | - | - | 数据存在断档，产生无数据事件 |
| 数据新上报 | 不存在 | - | 首次上报数据，正常 |
| 数据新上报 | 存在 | 正常 | 重新上报数据，且已经发送过数据恢复上报事件，不再产生告警事件 |
| 数据新上报 | 存在 | 无数据 | 重新上报数据，产生数据恢复上报事件 |
| 始终没有数据 | - | - | 持续无数据，不产生告警事件 |


2.正常（绿色）：检测规则生效后，产生紧急、重要、警告异常事件后，在配置的自定义检测周期内，数据检测结果恢复正常，则产生恢复告警事件。可参考以下场景：

| 场景 | 最后一次事件产生时间 | 结果 |
| --- | --- | --- |
| 从未发生异常 | - | 无恢复事件 |
| 异常已恢复 | 若自定义检测周期为15分钟，最后一次事件产生时间不到15分钟时 | 无恢复事件 |
| 异常已恢复 | 若自定义检测周期为15分钟，最后一次事件产生时间在15分钟时 | 产生恢复事件 |

注意：恢复告警事件不受[告警沉默](../alert-setting.md)限制。若未设置恢复告警事件检测周期，则告警事件不会恢复，且一直会出现在「事件」-「未恢复事件列表」中。

### 步骤3.事件通知

![](../img/6.monitor03.png)

7）**事件标题：**设置告警触发条件的事件名称，支持使用预置的模板变量，详情参考 [模板变量](../event-template.md) 。

8）**事件内容：**设置告警触发条件的事件内容，支持添加链接并点击打开新页跳转，支持使用预置的模板变量，详情参考 [模板变量](../event-template.md) 。

9）**告警策略：**监控满足触发条件后，立即发送告警消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、以及告警沉默周期。
