# 获取图表图片

---

<br />**GET /api/v1/chart_image/get**

## 概述
获取图表图片内容




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| clientToken | string | Y | 工作空间内 clientToken<br>例子: wctn_xxx <br>允许为空: False <br> |
| qtype | string |  | 查询语句类型, 默认为 dql<br>允许为空: False <br>可选值: ['dql', 'promql'] <br> |
| q | string | Y | 查询语句<br>例子:  <br>允许为空: False <br> |
| startTime | integer | Y | 开始时间点, 时间戳，单位秒<br>例子:  <br>允许为空: False <br> |
| endTime | integer | Y | 结束时间点, 时间戳，单位秒<br>例子:  <br>允许为空: False <br> |
| interval | integer |  | 数据点间隔，单位秒<br>例子:  <br>允许为空: False <br> |
| tz | string |  | 时区名称，默认值 `Asia/Shanghai`<br>例子: Asia/Shanghai <br>允许为空: False <br> |

## 参数补充说明

*查询说明*

--------------

注意, 当前接口通过 clientToken 进行鉴权。仅当 clientToken 有效时才会生效。当前接口可不添加请求头`DF-API-KEY`






## 响应
```shell
 
```




