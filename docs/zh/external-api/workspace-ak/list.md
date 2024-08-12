# 【工作空间AK】列出

---

<br />**GET /api/v1/workspace/accesskey/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 根据名称搜素<br>例子: supper_workspace <br>允许为空: False <br> |
| workspaceUUID | string |  | 指定工作空间UUID<br>例子: wksp_xxxxx <br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明







## 响应
```shell
 
```




