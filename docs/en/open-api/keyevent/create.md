# Create an Event

---

<br />**post /api/v1/events/create**

## Overview
Create an event and specify the event content. Events written through this interface have `df_source=custom`.




## Body Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| date | integer | Y | Event time. Unix timestamp in milliseconds.<br>Allow null: False <br> |
| status | string | Y | Event status (optional: critical/error/warning/ok/info/nodata）<br>Allow null: False <br>Optional value: ['critical', 'error', 'warning', 'ok', 'info', 'nodata'] <br> |
| title | string | Y | Event title<br>Allow null: False <br> |
| message | string |  | Detailed description of events<br>Allow null: False <br> |
| origin | string |  | Source of events<br>Allow null: False <br> |
| customTags | json |  | User-defined field events<br>Allow null: False <br> |

## Supplementary Description of Parameters





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/events/create' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{"date":1668141576000,"status":"info","title":"测试自定义事件01","message":"测试自定义事件-message","customTags":{"server":"自定义服务"}}' \
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
    "traceId": "TRACE-5EB2700B-52BF-40D7-A547-90FB7EC855DD"
} 
```




