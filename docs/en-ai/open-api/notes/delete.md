# Delete a Note

---

<br />**GET /api/v1/notes/\{notes_uuid\}/delete**

## Overview
Delete a note



## Route Parameters

| Parameter Name   | Type     | Required | Description              |
|:-------------|:-------|:-----|:----------------|
| notes_uuid | string | Y | Note UUID<br> |


## Additional Parameter Notes

Parameter description:




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/notes_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "noteName": "modify_openapi"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-3D1E2066-B798-4CE2-AE8C-756E347D7F7F"
} 
```