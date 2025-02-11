# 【Logmine Logs】Send Logmine Query Task

---

<br />**POST /api/v1/logmine/send_task**

## Overview
Send a log clustering query task



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| query | string | No | DQL query statement. If this value exists, the `namespace` and `conditions` parameters will be ignored. 【Format Requirement】:L::`*`:(`__docid`, analysis_field){}<br> |
| namespace | string | No | Full namespace in the DQL query statement. Default value is `logging`. <br>Possible values: ['object', 'object_history', 'custom_object', 'logging', 'keyevent', 'unrecovered_event', 'tracing', 'rum', 'network', 'security', 'backup_log', 'profiling', 'billing'] <br> |
| highlight | boolean | No | Whether to highlight the query string <br> |
| conditions | string | No | DQL query filter conditions <br>Example:  `source` IN ['kube-controller']  <br>Can be empty: False <br>Can be an empty string: True <br> |
| timeRange | array | No | Data time range, two elements, <br>Example: [1573646935000, 1573646960000] <br>Can be empty: False <br> |
| analysisField | string | Yes | Approximate text analysis field <br>Example: message <br>Can be empty: True <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/logmine/send_task' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"namespace":"logging","conditions":"index in [`default`]","highlight":true,"timeRange":[1683534635416,1683535535416],"analysisField":"message"}' \
--compressed 
```



## Response
```shell
{
    "code": 200,
    "content": {
        "taskId": "logminetaskchcbedk24lokg5cqfdb0"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "10594577704924482412"
} 
```