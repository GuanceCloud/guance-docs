# Delete a Team

---

<br />**GET /api/v1/workspace/member_group/\{group_uuid\}/delete**

## Overview
Delete a team


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| group_uuid    | string | Y       | Team                     |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/group_xxxx32/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-0D281839-1C53-42B1-8E67-915503DA495A"
} 
```