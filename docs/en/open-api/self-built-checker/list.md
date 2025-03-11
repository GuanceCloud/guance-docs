# List Self-built Checkers

---

<br />**GET /api/v1/self_built_checker/list**

## Overview
Paginate and list the self-built checkers in the current workspace



## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:-------------------|:-------|:-----|:----------------|
| monitorUUID | commaArray | No | Alert group UUID<br>Can be empty: False <br> |
| alertPolicyUUID | commaArray | No | Alert strategy UUID<br>Can be empty: False <br> |
| checkerUUID | commaArray | No | Self-built checker UUID<br>Can be empty: False <br> |
| refKey | commaArray | No | refKey, multiple values separated by English commas<br>Can be empty: False <br> |
| search | string | No | Search for self-built checker name<br>Can be empty: False <br> |
| pageIndex | integer | No | Page number<br>Can be empty: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer | No | Number of items per page<br>Can be empty: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/list?refKey=zyAy2l9v,zyAy897f' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "data": [
            {
                "alertPolicyInfos": [
                    {
                        "name": "0131",
                        "uuid": "altpl_xxxe62"
                    },
                    {
                        "name": "xxx's alert strategy - custom test",
                        "uuid": "altpl_xxx3b8"
                    },
                    {
                        "name": "ll-alert strategy - do not modify",
                        "uuid": "altpl_xxx400"
                    }
                ],
                "createAt": 1706174074,
                "createdWay": "manual",
                "creator": "xx",
                "creatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "crontabInfo": {},
                "deleteAt": -1,
                "extend": {},
                "id": 663,
                "isLocked": 0,
                "jsonScript": {
                    "callKwargs": {},
                    "name": "SSL certificate expiration check",
                    "refFuncInfo": {
                        "args": [
                            "name"
                        ],
                        "category": "general",
                        "definition": "run(name='')",
                        "description": "zh-CN: SSL certificate validity period check\n    title: SSL certificate validity period check\n    doc: |\n        Parameters:\n            No configuration required by default for the entire workspace\nen:\n    title: SSL Check\n    doc: |\n        Parameters:\n            No configuration is required by default for the entire workspace",
                        "funcId": "guance_monitor_user_example_obs__ssl.run",
                        "kwargs": {
                            "name": {
                                "default": ""
                            }
                        }
                    },
                    "title": "SSL certificate expiration check",
                    "type": "selfBuiltCheck"
                },
                "monitorName": "",
                "monitorUUID": "",
                "refKey": "xxxx",
                "secret": "",
                "status": 0,
                "type": "self_built_trigger",
                "updateAt": 1710760853,
                "updator": "xx",
                "updatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "uuid": "rul_xxxf2e",
                "workspaceUUID": "wksp_xxx15d"
            }
        ],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "64fe7b4062f74d0007b46676"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-506E20FA-553F-4FBC-9ACD-E1A400ACB790"
} 
```