# Create an Event

---

<br />**POST /api/v1/events/create**

## Overview
Create an event and specify its content. Events written via this API have `df_source=custom`.

## Body Request Parameters

| Parameter Name | Type   | Required | Description                                                                                   |
|:--------------|:-------|:--------|:----------------------------------------------------------------------------------------------|
| date          | integer| Y       | Event timestamp. Unix timestamp in milliseconds.<br>Allow null: False <br>                    |
| status        | string | Y       | Event status (options: critical/error/warning/ok/info/nodata)<br>Allow null: False <br>Optional values: ['critical', 'error', 'warning', 'ok', 'info', 'nodata'] <br> |
| title         | string | Y       | Event title<br>Allow null: False <br>                                                         |
| message       | string |         | Detailed description of the event<br>Allow null: False <br>                                   |
| origin        | string |         | Source of the event<br>Allow null: False <br>                                                 |
| customTags    | json   |         | User-defined fields for events<br>Allow null: False <br>                                      |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/events/create' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{"date":1668141576000,"status":"info","title":"Test Custom Event 01","message":"Test Custom Event - message","customTags":{"server":"Custom Service"}}' \
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