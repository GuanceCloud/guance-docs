# 禁用/启用某个 SLO

---

<br />**POST /api/v1/slo/\{slo_uuid\}/set_disable**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | 某个 SLO 的 UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 开启/禁用，false：开启，true：禁用<br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
 
```




