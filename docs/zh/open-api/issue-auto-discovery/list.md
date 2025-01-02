# 列表自动发现配置

---

<br />**GET /api/v1/issue_auto_discovery/list**

## 概述




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dqlNamespace | string |  | 数据范围,多值以英文逗号分隔<br>例子: keyevent <br>允许为空: False <br> |
| isDisable | string |  | 筛选条件<br>例子: [] <br>允许为空: False <br>可选值: ['true', 'false'] <br> |
| search | string |  | 根据规则名称搜索<br>例子: xxxxx_text <br>允许为空: False <br>允许为空字符串: True <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明







## 响应
```shell
 
```




