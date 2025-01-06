# DQL数据异步查询

---

<br />**POST /api/v1/df/asynchronous/query_data**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| queries | array |  | 多命令查询，其内容为 query 对象组成的列表<br>允许为空: False <br> |
| fieldTagDescNeeded | boolean |  | 是否需要field 或者tag描述信息<br>允许为空: False <br> |

## 参数补充说明

*查询说明*

--------------

1、 参数说明

| 参数名  | type  | 必选  | 说明  |
| :------------ | :------------ | :------------ | :------------ |
|  queries | array  |  Y |  多命令查询，其内容为 query 对象组成的列表  |
|  fieldTagDescNeeded  | boolean |   | 是否需要field 或者tag描述信息 |


2、 queries[\*]成员参数结构说明
*** 注意, 在「DQL数据查询」接口基础上添加了`async_id`参数 ***

| 参数名  | type  | 必选  | 说明  |
| :------------ | :------------ | :------------ | :------------ |
| `async_id` | string  |  N |  异步查询任务ID, 该值来自上次dql查询结果中的 content.data[\*].async_id; 如果上一次查询返回结果中存在该值, 则本次查询需要带上该值 |
|  qtype | string  |  Y |  查询语句的类型 <br/> dql: 表示dql类型查询语句; <br/> promql: 表示 PromQl类型查询语句   |
|  query | json  |  Y |  查询结构 |
|  query.q  | string |   | 与 qtype 类型保持一致的 查询语句，例如 dql 或者 promql 查询语句|
|  query.highlight  | boolean |   | 是否显示高亮数据 |
|  query.timeRange  | array  |   | 时间范围的时间戳列表 |
|  query.disableMultipleField  | bool  |   | 是否打开单列模式，默认为 `true` |
|  query.showLabel  | bool  |   | 是否显示对象的lables，默认无 |
|  query.funcList  | array  |   | 再次聚合修饰dql返回值，注意 disableMultipleField=Flse时, 当前参数无效 |
|  query.slimit  | integer  |   | 时间线分组大小，只针对指标查询有效 |
|  query.soffset  | integer  |   | 时间线分组偏移量 |
|  query.limit  | integer  |   | 分页大小 |
|  query.offset  | integer  |   | 分页偏移量 |
|  query.orderby  | array  |   | 排序列表，`{fieldName:method}` , 注意指标集查询的排序只支持 fieldName=time; method in ["desc", "asc"];注意指标集查询的排序只支持 fieldName=time|
|  query.sorderby  | array  |   | 排序列表，sorderby 的 column 是一个表达式，支持所有返回单个值的聚合函数min max last avg p90 p95 count, `{fieldName:method}`,结构和orderby一致 |
|  query.order_by  | array  |   | 排序列表，结构为[{"column": "field", "order": "DESC"}], doris引擎兼容字段|
|  query.sorder_by  | array  |   | 排序列表，结构为[{"column": "field", "order": "DESC"}], doris引擎兼容字段|
|  query.density  | string  |   | 响应的点密度, 优先级小于 autoDensity 且大于 dql语句中设置的密度 |
|  query.interval  | integer  |   | 单位是秒，时间分片间隔，用于计算响应点数；计算出的点数小于等于density=high时的点数，则有效，否则无效|
|  query.search_after  | array  |   | 分页查询标记。相同参数上次请求响应结果中的 search_after 值作为本次请求的参数。|
|  query.maxPointCount  | integer  |   | 最大点数 |
|  query.workspaceUUID  | string  |   | 要查询工作空间的uuid|
|  query.workspaceUUIDs  | array  |   | 要查询工作空间的uuids, 优先级 高于 query.workspaceUUID.|
|  query.output_format  | string  |   | lineprotocol: 行协议输出，默认不填的话，默认保持现有输出格式不变 |
|  query.cursor_time  | integer  |   | 分段查询阀值: 第一次分段查询时，需要把 cursor_time 设置为 end_time；之后的分段查询，需要把 cursor_time 设置为响应中的 next_cursor_time |
|  query.disable_sampling  | bool  |   | 采样禁用开关, 默认值为 false |


3、  响应点密度`density` 参数值说明

| 可选值  | 说明  |
| :------------ | :------------ |
|  lower |  较低，60个点  |
|  low   |  低，180个点 |
|  medium|   中等，360个点 |
|  high  |  低，720个点 |

* 注意点密度参数的优先级，最大密度`density[high]` * </br>
maxPointCount > interval > density > dql语句中的控制参数   

4、 常见查询说明

  - [未恢复事件查询](../../../studio-backend/unrecovered-event-query/)
</br>
注: openapi 接口进行数据查询时, 默认为 管理员 角色. 需注意可能受到 数据访问规则限制






## 响应
```shell
 
```




