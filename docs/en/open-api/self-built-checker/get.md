# Get an Intelligent Inspection Info

---

<br />**get /api/v1/self_built_checker/get**

## Overview
Obtain monitor details based on the given intelligent inspection identification.




## Query Request Parameter

| Parameter Name        | Type     | Required   | Description              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | UUID of intelligent inspection<br>Example: rul_xxxxx <br>Allow null: False <br> |
| refKey | string |  | Association key of intelligent inspection<br>Example: xxx <br>Allow null: False <br> |

## Supplementary Description of Parameters





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
        "creator": "acnt_4c47698da848440b8d1ca92e9f296ac1",
        "crontabInfo": {},
        "deleteAt": -1,
        "extend": {},
        "id": 88,
        "jsonScript": {
            "name": "自建巡检-20220907T162421bymvlx",
            "type": "selfBuiltCheck"
        },
        "monitorUUID": "monitor_c0d21959e3724dccbf50aead796cee39",
        "refKey": "zyAy2l9v",
        "status": 0,
        "type": "self_built_trigger",
        "updateAt": 1662539061,
        "updator": "",
        "uuid": "rul_ef77a9eccbcc4171a017c65c1b827f89",
        "workspaceUUID": "wksp_ff0e31161a1a47faabc36b5ff66c160a"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E353D55D-A6FD-497E-82D2-3DA04E703A6D"
} 
```




