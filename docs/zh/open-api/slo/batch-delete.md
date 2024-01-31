# 批量删除 SLO

---

<br />**POST /api/v1/slo/batch_delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sloUUIDs | array | Y | SLO 的 UUID 列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/batch_delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data '{
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
    "traceId": "TRACE-DD059943-258A-4203-92FC-D4E207BF18ED"
} 
```




