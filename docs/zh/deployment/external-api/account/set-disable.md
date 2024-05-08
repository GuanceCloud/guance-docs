# 【账号】启用/禁用

---

<br />**POST /api/v1/account/set-disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | 账号UUID<br>例子: ['acnt_xxxx', 'acnt_yyyy'] <br>允许为空: False <br> |
| isDisable | boolean | Y | 是否禁用, true禁用, false启用<br>例子: True <br>允许为空: False <br>可选值: [True, False] <br> |

## 参数补充说明







## 响应
```shell
 
```




