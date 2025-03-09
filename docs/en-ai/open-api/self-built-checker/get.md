# Get Self-built Checker Information

---

<br />**GET /api/v1/self_built_checker/get**

## Overview
Retrieve the details of a self-built checker based on the provided identifier.

## Query Request Parameters

| Parameter Name | Type   | Required | Description                          |
|:--------------|:-------|:--------|:------------------------------------|
| ruleUUID      | string |         | UUID of the self-built checker<br>Example: rul_xxxxx <br>Can be empty: False <br> |
| refKey        | string |         | Associated key of the self-built checker<br>Example: xxx <br>Can be empty: False <br> |

## Additional Parameter Notes

## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/get?refKey=zyAy2l9v' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```

## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1662539061,
        "creator": "acnt_xxxx32",
        "crontabInfo": {},
        "deleteAt": -1,
        "extend": {},
        "id": 88,
        "jsonScript": {
            "name": "self-built check-20220907T162421bymvlx",
            "type": "selfBuiltCheck"
        },
        "monitorUUID": "monitor_xxxx32",
        "refKey": "zyAy2l9v",
        "status": 0,
        "type": "self_built_trigger",
        "updateAt": 1662539061,
        "updator": "",
        "uuid": "rul_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E353D55D-A6FD-497E-82D2-3DA04E703A6D"
} 
```