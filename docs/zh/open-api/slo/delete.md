# 删除某个 SLO

---

<br />**GET /api/v1/slo/\{slo_uuid\}/delete**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| slo_uuid | string | Y | 某个 SLO 的 UUID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/slo/monitor_xxxx32/delete' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-08DB4F4E-CDF4-4193-8809-E6980421084B"
} 
```




