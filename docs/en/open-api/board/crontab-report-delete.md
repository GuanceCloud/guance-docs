# Delete Scheduled Report

---

<br />**POST /api/v1/crontab_report/delete**

## Overview




## Body Request Parameters

| Parameter Name  | Type   | Required | Description               |
|:--------------|:------|:-------|:-------------------------|
| reportUUIDs | array | Y     | UUIDs of scheduled reports<br>Allow null: False <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/crontab_report/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw '{"reportUUIDs":["cron_xxxx32"]}' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E439F775-18D6-487B-A554-5D74B6F54321"
} 
```