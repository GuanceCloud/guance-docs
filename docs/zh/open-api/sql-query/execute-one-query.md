# 数据查询

---

<br />**POST /api/v1/sql_query/execute_one_query**

## 概述
DQL数据查询




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| identify | string |  | sql查询唯一标识<br>允许为空: False <br> |
| start | integer | Y | 开始时间点, 单位：秒<br>例子: 1718690380 <br>允许为空: False <br> |
| end | integer | Y | 结束时间点, 单位：秒<br>例子: 1718690380 <br>允许为空: False <br> |
| queryKwargs | json |  | 查询的额外参数<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明

*查询说明*

--------------


可选的 identify 说明

|  identify     |          说明          |
|---------------|-----------------------|
| issue.total_by_status_type    | 根据 issue 的状态分组统计数量 |
| issue.total_by_level    | 根据 issue 的等级分组统计数量 |
| issue.total_by_resource    | 根据 issue 的来源分组统计数量 |
| issue.max_resolve_duration    | 已恢复 issue 的最大处理时长统计|
| issue.avg_resolve_duration    | 已恢复 issue 的平均处理时长统计|
| issue.count_by_assignee    | issue 处理数量 TOP N 负责人|
| issue.duration_by_assignee    | issue 处理时长 TOP N 负责人|
| issue.unresolved_list    | 未恢复 issue 列表|

</br>

1、`statusType`(Issue 状态可选值)

|  值  |         说明          |
|------|---------------|
| 10   | Open 状态 |
| 20   | Resolved 状态 |
| 30   | Pending 状态 |

</br>

2、identify=`issue.count_by_assignee`(issue 处理数量 TOP N 负责人)时，`queryKwargs` 内可选参数

|  queryKwargs 内参数名  |   type  | 必选 |  默认值  |         说明          |
|--------------------------|---------|-----|---------|---------------|
| top   |   integer  |    |  10 | 默认前N个 |
| statusType   |   array  |    |  无 | issue 状态类型 |

</br>

3、identify=`issue.unresolved_list`(未恢复 issue 列表)时，`queryKwargs` 内可选参数

|  queryKwargs 内参数名  |   type  | 必选 |  默认值  |         说明          |
|--------------------------|---------|-----|---------|---------------|
| cursorId   |   integer  |    |  无 | 分页标记开始位置 |






## 响应
```shell
 
```




