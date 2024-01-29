# 列出工作空间下 SLO

---

<br />**GET /api/v1/slo/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| refSli | string |  | 指定 SLI UUID，返回包含该 SLI 的 SLO<br>允许为空: True <br> |
| search | string |  | SLO 名称<br>允许为空: True <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 10000 <br> |

## 参数补充说明







## 响应
```shell
 
```




