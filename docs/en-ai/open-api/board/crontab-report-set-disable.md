# Enable/Disable Scheduled Reports

---

<br />**POST /api/v1/crontab_report/set_disable**

## Overview




## Body Request Parameters

| Parameter Name    | Type     | Required | Description                                |
|:--------------|:-------|:-----|:-----------------------------------------|
| isDisable | boolean | Y | Set the enable status<br>Allow null: False <br> |
| reportUUIDs | array  | Y | UUIDs of scheduled reports<br>Allow null: False <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/crontab_report/set_disable' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: en' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw '{"isDisable":true,"reportUUIDs":["cron_xxxx32"]}' \
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
    "traceId": "TRACE-4C4BFE2F-C34B-4C17-B6FA-A340A4CA8585"
} 
```