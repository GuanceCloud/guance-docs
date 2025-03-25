# Get a Team

---

<br />**GET /api/v1/workspace/member_group/get**

## Overview
Get a team




## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| groupUUID            | string   |            | Team UUID, if getting member information for a new entry, do not pass this value<br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member_group/get?groupUUID=group_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## Response
```shell
{
    "code": 200,
    "content": {
        "groupMembers": [
            {
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "name": "88 Test",
                "uuid": "acnt_xxxx32"
            }
        ],
        "membersNotInGroup": []
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A85FB294-8E44-4A00-ACE4-D91DCD2414D8"
} 
```