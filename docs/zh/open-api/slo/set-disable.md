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





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/slo/monitor_xxxx32/set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data '{
  "isDisable": false
}'
```




## 响应
```shell
{
    "code": 200,
    "content": [
        "slo-test8"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-219C5FF9-00E7-4072-9233-0D9FB49F9A10"
} 
```




