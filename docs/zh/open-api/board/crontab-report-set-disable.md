# 启用/禁用 定时报告

---

<br />**POST /api/v1/crontab_report/set_disable**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| isDisable | boolean | Y | 设置启用状态<br>允许为空: False <br> |
| reportUUIDs | array | Y | 定时报告的uuids<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/crontab_report/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw '{"isDisable":true,"reportUUIDs":["cron_xxxx32"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4C4BFE2F-C34B-4C17-B6FA-A340A4CA8585"
} 
```




