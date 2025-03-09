# Get a Team

---

<br />**GET /api/v1/workspace/member_group/get**

## Overview
Get a team


## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| groupUUID            | string   | No       | Team UUID, if it is to get member information for a new team, this value should not be passed <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/get?groupUUID=group_xxxx32' \
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
                "email": "88@qq.com",
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