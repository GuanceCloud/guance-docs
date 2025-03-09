# Create a Note

---

<br />**POST /api/v1/notes/create**

## Overview
Create a note. `chartUUIDs` contains the chart information associated with this note.


## Body Request Parameters

| Parameter Name | Type   | Required | Description                                      |
|:--------------|:-------|:---------|:-------------------------------------------------|
| name          | string | Y        | Note name<br>Allow null: False <br>Max length: 128 <br> |
| chartUUIDs    | array  |          | Note type, default is CUSTOM<br>Example: CUSTOM <br>Allow null: False <br>Max length: 32 <br> |
| extend        | json   |          | Additional data for the note, default is {}<br>Example: {} <br>Allow null: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"openapi_note","chartUUIDs":["chrt_xxxx32","chrt_xxxx32"],"extend":{"fixedTime":"15m"}}' \
--compressed 
```


## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1677656782,
        "creator": "wsak_xxxxx",
        "deleteAt": -1,
        "extend": {
            "fixedTime": "15m"
        },
        "id": null,
        "isPublic": 1,
        "name": "jinlei_openapi",
        "pos": [
            {
                "chartUUID": "chrt_xxxx32"
            },
            {
                "chartUUID": "chrt_xxxx32"
            }
        ],
        "status": 0,
        "updateAt": 1677656782,
        "updator": "wsak_xxxxx",
        "uuid": "notes_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7FBE845D-2099-4403-A040-51782A27B02A"
} 
```