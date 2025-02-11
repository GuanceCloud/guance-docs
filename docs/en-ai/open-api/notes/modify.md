# Modify a Note

---

<br />**POST /api/v1/notes/\{notes_uuid\}/modify**

## Overview
Modify a note. `chartUUIDs` contains the chart information bound to this note.

## Route Parameters

| Parameter Name | Type   | Required | Description             |
|:--------------|:-------|:---------|:------------------------|
| notes_uuid    | string | Y        | Note UUID               |

## Body Request Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:---------|:-------------------------|
| name          | string | Y        | Note name<br>Allow null: False <br>Maximum length: 128 <br> |
| chartUUIDs    | array  |          | Note type, default is CUSTOM<br>Example: CUSTOM <br>Allow null: False <br>Maximum length: 32 <br> |
| extend        | json   |          | Additional data of the note, defaults to {}<br>Example: {} <br>Allow null: False <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"modify_openapi","chartUUIDs":["chrt_xxxx32","chrt_xxxx32"],"extend":{"fixedTime":"15m"}}' \
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
        "id": 45,
        "isPublic": 1,
        "name": "modify_openapi",
        "oldName": "jinlei_openapi",
        "status": 0,
        "updateAt": 1677657052.321672,
        "updator": "wsak_xxxxx",
        "uuid": "notes_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7AF32A96-2D61-4711-B8DF-5276F5912453"
} 
```