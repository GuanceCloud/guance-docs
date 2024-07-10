# 修改

---

<br />**POST /api/v1/data_mask_rule/\{data_mask_rule_uuid\}/modify**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| data_mask_rule_uuid | string | Y | 数据脱敏规则的uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 规则名称<br>允许为空: False <br>最大长度: 128 <br>允许空字符串: False <br> |
| type | string | Y | 数据类型<br>例子: logging <br>允许为空: True <br>可选值: ['logging', 'metric', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'profiling'] <br> |
| field | string | Y | 字段名<br>允许为空: False <br>最大长度: 128 <br>允许空字符串: False <br> |
| reExpr | string | Y | 正则表达式<br>允许为空: False <br>最大长度: 5000 <br>允许空字符串: False <br> |
| roleUUIDs | array | Y | 该规则对空间哪些角色进行数据脱敏<br>例子: ['xxx', 'xxx'] <br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
 
```




