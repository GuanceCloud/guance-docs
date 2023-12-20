# 列出智能巡检列表

---

<br />**ET /api/v1/self_built_checker/list**

## 概述
分页列出当前工作空间的自建巡检列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | commaArray |  | 告警策略UUID<br>允许为空: False <br> |
| checkerUUID | commaArray |  | 自建巡检UUID<br>允许为空: False <br> |
| refKey | commaArray |  | refKey，多值以英文逗号分割<br>允许为空: False <br> |
| search | string |  | 搜索自建巡检名<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/list?refKey=zyAy2l9v,zyAy897f' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{} 
```




