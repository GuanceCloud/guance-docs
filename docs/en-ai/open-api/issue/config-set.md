# Modify Default Configuration Status of Issue

---

<br />**POST /api/v1/issue-level/config/set**

## Overview




## Body Request Parameters

| Parameter Name | Type   | Required | Description                                  |
|:--------------|:-------|:--------|:--------------------------------------------|
| isDisabled    | bool   | Y       | Whether to enable or disable, false for enable, true for disable<br>Example: True <br>Allow null: False <br> |

## Additional Parameter Explanation





## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/issue-level/config/set' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"isDisabled": false}'\
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "isDisabled": false
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CDE3B645-7CE4-43E1-B06B-090F72A3902C"
} 
```




## Response Explanation

The response indicates the status of the request. The `isDisabled` field in the content section shows whether the Issue default configuration has been set to disabled or enabled. In this case, it is set to `false`, meaning it is enabled.