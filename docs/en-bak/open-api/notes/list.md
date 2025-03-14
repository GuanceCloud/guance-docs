# Get a List of Notes

---

<br />**get /api/v1/notes/list**

## Overview
Lists all eligible notes. There is no paging in the current interface.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | Note name search<br>Allow null: False <br> |

## Supplementary Description of Parameters

Parameter description:




## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/notes/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "createAt": 1642588739,
                "creator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
                "creatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_5fc5bb139e474911b6d3d300863f0c8b.png",
                    "name": "66",
                    "username": "66@qq.com"
                },
                "deleteAt": -1,
                "id": 185,
                "isFavourited": false,
                "name": "我的笔记",
                "pos": [
                    {
                        "chartUUID": "chrt_dc6c1f939f5541bf8302c6d79f5f9800"
                    }
                ],
                "status": 0,
                "updateAt": 1642588739,
                "updator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
                "updatorInfo": {
                    "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_5fc5bb139e474911b6d3d300863f0c8b.png",
                    "name": "66",
                    "username": "66@qq.com"
                },
                "uuid": "notes_35018053b8864ec190b3a6dbd5b44ab0",
                "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
            }
        ]
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-123ADCD7-95F0-4EDC-A27A-649885FAF9CD"
} 
```




