# 【工作空间成员】更换指定工作空间的拥有者(旧拥有者账号将直接移出当前工作空间)

---

<br />**POST /api/v1/workspace/\{workspace_uuid\}/owner/transfer**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| workspace_uuid | string | Y | 工作空间UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUID | string | Y | 账号uuid, 将拥有者者角色 转移给该账号<br>例子: acnt_xxx <br>允许为空: True <br>允许空字符串: False <br> |

## 参数补充说明







## 响应
```shell
 
```




