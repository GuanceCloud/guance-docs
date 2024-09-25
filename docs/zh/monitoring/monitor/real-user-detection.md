# 用户访问指标检测
---


**用户访问指标检测**用于监控工作空间内用户访问的指标数据，通过设置阈值范围，当指标到达阈值后触发告警，支持对单个指标设置告警和自定义告警等级。

## 应用场景

支持监控包括 Web、Android、iOS、Miniapp 应用类型的指标数据。例如可以监控 Web 端 基于城市维度的 JS 错误率。

## 新建

点击**监控器 > 新建监控器 > 用户访问指标检测**，进入规则的配置页面。

### 步骤一：检测配置

![](../img/5.monitor_10.png)

1）**检测频率**：检测规则的执行频率，包含 1m/5m/15/30m/1h/6h（默认选中 5m）。

2）**检测区间**：每次执行任务时，检测指标查询的时间范围。受检测频率影响，可选检测区间会有不同。

| 检测频率 | 检测区间（下拉可选项） |
| --- | --- |
| 1m | 1m/5m/15m/30m/1h/3h |
| 5m | 5m/15m/30m/1h/3h |
| 15m | 15m/30m/1h/3h/6h |
| 30m | 30m/1h/3h/6h |
| 1h | 1h/3h/6h/12h/24h |
| 6h | 6h/12h/24h |
| 12h | 12h/24h |
| 24h | 24h |

3）**检测指标**：设置检测数据的指标。支持设置当前工作空间内单一应用类型下全部/单个应用在一定时间范围内的指标数据。如：当前工作空间内，Web类型下全部应用的指标数据。

| 字段 | 说明 |
| --- | --- |
| 应用类型 | **用户访问监测**支持的应用类型，包括 Web、Android、iOS、Miniapp |
| 应用名称 | 基于应用类型获取对应的应用列表，支持全选和单选 |
| 指标 | 基于应用类型获取的指标列表，<br>**Web/Miniapp**（包括JS错误数、JS错误率、资源错误数、资源错误率、首次渲染平均时间、页面加载平均耗时、LCP(largest_contentful_paint)、FID(first_input_delay)、CLS(cumulative_layout_shift)、FCP(first_contentful_paint) 等）<br>**Android/IOS**（包括启动耗时、总崩溃数、总崩溃率、资源错误数、资源错误率、FPS、页面加载平均耗时等）。 |
| 筛选条件 | 基于指标的标签对检测指标的数据进行筛选，限定检测的数据范围。支持添加一个或多个标签筛选，支持模糊匹配和模糊不匹配的筛选条件。 |
| 检测维度 | 配置数据里对应的字符串类型（keyword）字段都可以作为检测维度进行选择，目前检测维度最多支持选择三个字段。通过多个检测维度的字段组合，可以确定一个确定的检测对象，观测云会判断某个检测对象对应的统计指标是否满足触发条件的阈值，若满足条件则产生事件。*（例如选择检测维度【host】与【host_ip】，则检测对象可以为 `{host: host1, host_ip: 127.0.0.1}`。）* |

[**Web**](../../real-user-monitoring/web/app-data-collection.md) / [**Miniapp**](../../real-user-monitoring/miniapp/app-data-collection.md) **指标说明**

<table>
<tr>
<td> 指标 </td> <td> 查询示例 </td>
</tr>

<tr>
<td> JS错误数 </td> 
<td> 

R::error:(count(`__docid`) as `JS 错误数`) { `app_id` = '<应用 ID>' }

</td>
</tr>

<tr>
<td> JS错误率 </td> 
<td> 

Web: eval(A/B, alias='页面 JS 错误率', A="R::view:(count(`view_url`)) {`view_error_count` > 0, `app_id` = '<应用 ID>'}",B="R::view:(count(`view_url`)) { `app_id` = '<应用 ID>'} ")

Miniapp: eval(A/B, alias='JS 错误率', A="R::view:(count(`view_name`)) {`view_error_count` > 0, `app_id` = '<应用 ID>' }",B="R::view:(count(`view_name`)) { `app_id` = '<应用 ID>' }")

</td>
</tr>

<tr>
<td> 资源错误数 </td> 
<td> 

R::resource:(count(`resource_url`) as `资源错误数`) {`resource_status` >=400, `app_id` = '<应用 ID>'}

</td>
</tr>

<tr>
<td> 资源错误率 </td> 
<td> 

eval(A/B, alias='资源错误率', A="R::`resource`:(count(`resource_url`)) { `resource_status` >= '400',`app_id` = '<应用 ID>' }", B="R::`resource`:(count(`resource_url`)) { `app_id` = '<应用 ID>' }")

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

R::action:(avg(duration)) { `app_id` = '<应用 ID>' ,action_type='app_cold_launch'}

</td>
</tr>

<tr>
<td> 总崩溃数 </td> 
<td> 

R::error:(count(error_type)) {app_id='<应用 ID>',`error_source` = 'logger' and is_web_view !='true'} 

</td>
</tr>

<tr>
<td> 总崩溃率 </td> 
<td> 

eval(A.a1/B.b1, alias='总崩溃率',A="R::error:(count(error_type) as a1) {app_id='<应用 ID>',`error_source` = 'logger',is_web_view !='true'} ",B="R::action:(count(action_name) as b1)  { `app_id` = '<应用 ID>',`action_type` in [`launch_cold`,`launch_hot`,`launch_warm`]} ")

</td>
</tr>

<tr>
<td> 资源错误数 </td> 
<td> 

R::resource:(count(`resource_url`) as `资源错误数`) {`resource_status` >=400, `app_id` = '<应用 ID>'}

</td>
</tr>

<tr>
<td> 资源错误率 </td> 
<td> 

eval(A/B, alias='资源错误率', A="R::`resource`:(count(`resource_url`)) { `resource_status` >= '400',`app_id` = '<应用 ID>' }", B="R::`resource`:(count(`resource_url`)) { `app_id` = '<应用 ID>' }")

</td>
</tr>

<tr>
<td> 平均 FPS </td> 
<td> 

R::view:(avg(`fps_avg`))  { `app_id` = '<应用 ID>' }

</td>
</tr>


<tr>
<td> 页面加载平均耗时 </td> 
<td> 

R::view:(avg(`loading_time`))  { `app_id` = '<应用 ID>' }

</td>
</tr>

<tr>
<td> 资源加载平均耗时 </td> 
<td>

R::resource:(avg(`duration`))  { `app_id` = '<应用 ID>' }

</td>
</tr>

<tr>
<td> 卡顿次数 </td> 
<td> 

R::long_task:(count(`view_id`))  { `app_id` = '<应用 ID>' }

</td>
</tr>

<tr>
<td> 页面错误率 </td> 
<td> 

eval(A/B, alias='页面错误率',A="R::view:(count(`view_name`)) {`view_error_count` > 0, `app_id` = '<应用 ID>' }",B="R::view:(count(`view_name`)) { `app_id` = '<应用 ID>' }")

</td>
</tr>

</table>

4）**触发条件**：设置告警级别的触发条件：您可任意配置紧急、重要、警告、正常的其中一种触发条件。

配置触发条件及严重程度，当查询结果为多个值时，任一值满足触发条件则产生事件。

> 更多详情，可参考 [事件等级说明](event-level-description.md)。   



若**开启连续触发判断**，可配置连续多次判断触发条件生效后，再次触发生成事件。最大上限 10 次。

<img src="../../img/example10.png" width="60%" >


???- abstract "告警级别"

	1、**告警级别紧急（红色）、重要（橙色）、警告（黄色）**：基于配置条件判断运算符。

    > 更多详情，可参考 [运算符说明](operator-description.md)。

    2、**告警级别正常（绿色）**：基于配置检测次数，说明如下：

    - 每执行一次检测任务即为 1 次检测，如【检测频率 = 5 分钟】，则 1 次检测= 5 分钟；  
    - 可以自定义检测次数，如【检测频率 = 5 分钟】，则 3 次检测 = 15 分钟。  

    | 级别 | 描述 |
    | --- | --- |
    | 正常 | 检测规则生效后，产生紧急、重要、警告异常事件后，在配置的自定义检测次数内，数据检测结果恢复正常，则产生恢复告警事件。<br/> :warning: 恢复告警事件不受[告警沉默](../alert-setting.md)限制。若未设置恢复告警事件检测次数，则告警事件不会恢复，且一直会出现在[**事件 > 未恢复事件列表**](../../events/event-explorer/unrecovered-events.md)中。|

5）数据断档：针对数据断档状态，支持七种配置策略。

- 联动检测区间时间范围，判断检测指标最近分钟数的查询结果，**不触发事件**；

- 联动检测区间时间范围，判断检测指标最近分钟数的查询结果，**查询结果视为 0**；此时查询结果将重新与上方**触发条件**中配置的阈值做比较，从而判断是否触发异常事件。

- 自定义填充检测区间值，**触发数据断档事件、触发紧急事件、触发重要事件、触发警告事件及触发恢复事件**；选择该类配置策略，自定义数据断档时间配置建议 **>= 检测区间时间间隔**，若配置时间 <= 检测区间时间间隔，可能存在同时满足数据断档和异常情况，此情况下仅会应用数据断档处理结果。


6）信息生成：开启此选项后，将未匹配到以上触发条件的检测结果生成 “信息” 事件写入。


**注意**：若同时配置触发条件、数据断档、信息生成时，按照如下优先级判断触发：数据断档 > 触发条件 > 信息事件生成。

### 步骤二：事件通知

![](../img/8.monitor_1.png)

1）**事件标题**：设置告警触发条件的事件名称，支持使用预置的[模板变量](../event-template.md)。

2）**事件内容**：满足触发条件时发送的事件通知内容。支持输入 Markdown 格式文本信息并预览效果，支持使用关联链接、[模板变量](../event-template.md)。

???+ warning

    最新版本中**监控器名称**将由**事件标题**输入后同步生成。旧的监控器中可能存在**监控器名称**和**事件标题**不一致的情况，为了给您更好的使用体验，请尽快同步至最新。
    
    不同告警通知对象支持的 Markdown 语法不同，例如：企业微信不支持无序列表。

**数据断档通知配置**：支持自定义数据断档通知内容，若没有配置，则自动使用官方默认的通知模版。

![](../img/8.monitor_2.png)


3）**关联异常追踪**：开启关联后，若该监控器下产生了异常事件，将同步创建 Issue。选择 Issue 的等级以及需要投递的目标频道，产生的 Issue 可以前往[异常追踪](../../exception/index.md) > 您选定的[频道](../../exception/channel.md)进行查看。

在事件恢复后，可以同步关闭 Issue。

![](../img/issue-create.png)

#### 事件内容自定义高级配置 {#advanced-settings}

观测云支持在事件内容中通过高级配置添加关联日志或错误堆栈，以便查看异常情况发生时的上下文数据情况：

![](../img/advanced-settings.png)

- 添加关联日志：

查询：

如：获取一条索引为 `default` 的日志 `message`：

```
{% set dql_data = DQL("L::RE(`.*`):(`message`) { `index` = 'default' } LIMIT 1") %}
```

关联日志：



```
{{ dql_data.message | limit_lines(10) }}
```

- 添加关联错误堆栈
  
查询：

```
{% set dql_data = DQL("T::re(`.*`):(`error_message`,`error_stack`){ (`source` NOT IN ['service_map', 'tracing_stat', 'service_list_1m', 'service_list_1d', 'service_list_1h', 'profile']) AND (`error_stack` = exists()) } LIMIT 1") %}
```

关联错误堆栈：

```
{{ dql_data.error_message | limit_lines(10) }}

{{ dql_data.error_stack | limit_lines(10) }}
```




### 步骤三：告警配置

[**告警策略**](../alert-setting.md)：监控满足触发条件后，立即发送告警消息给指定的通知对象。告警策略中包含需要通知的事件等级、通知对象、以及告警沉默周期。

告警策略支持单选或多选，点击策略名可展开详情页。若需修改策略点击**编辑告警策略**即可。

![](../img/policy-create.png)

### 步骤四：关联

![](../img/5.monitor_4.png)

**关联仪表板**：每一个监控器都支持关联一个仪表板，可快速跳转查看。


### 步骤五：权限

设置监控器的操作权限后，您当前工作空间的角色、团队成员以及空间用户将根据分配的权限，对监控器执行相应的操作。这确保了不同用户根据其角色和权限级别进行符合配置的操作。
 
<img src="../img/monitor_permission.png" width="70%" >


- 不开启该配置：跟随【监控器配置管理】的[默认权限](../management/role-list.md)；
- 开启该配置并选定自定义权限对象：此刻仅创建人和被赋予权限的对象可对该监控器设置的规则进行启用/禁用、编辑、删除操作；
- 开启该配置，但并未选定自定义权限对象：则仅创建人拥有此监控器的启用/禁用、编辑、删除权限。

**注意**：当前工作空间的 Owner 角色不受此处操作权限配置影响。


### 示例

监控 Skywalking-web-demo 的 Web 端基于服务维度的 JS 错误数。

![](../img/example08.png)