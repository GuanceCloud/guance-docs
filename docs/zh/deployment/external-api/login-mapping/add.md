# 【Login Mapping】添加一个映射配置

---

<br />**POST /api/v1/login_mapping/field/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspaceUUID | string | Y | 工作空间UUID<br>例子: 工作空间UUID <br>允许为空: False <br> |
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br>最大长度: 40 <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br>最大长度: 40 <br> |
| targetValues | array | Y | 目标字段值（目前默认为 角色的UUID 值）<br>例子: ['readOnly'] <br> |

## 参数补充说明







## 响应
```shell
 
```




