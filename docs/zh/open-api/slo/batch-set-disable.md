# 批量禁用/启用 SLO

---

<br />**POST /api/v1/slo/batch_set_disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 开启/禁用，false：开启，true：禁用<br>允许为空: False <br> |
| sloUUIDs | array | Y | SLO 的 UUID 列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/batch_set_disable' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data '{
  "isDisable": false,
  "sloUUIDs": [
    "monitor_3953537fddac4227a669e4712bd95181",
    "monitor_0d001b9cf7f34f879177ddc5e4c4b3a9"
  ]
}'
```




## 响应
```shell
{
    "code": 200,
    "content": [
        "slo_1",
        "slo_2"
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-EBF6D62D-E134-494C-B664-85B3AF0AE7ED"
} 
```




