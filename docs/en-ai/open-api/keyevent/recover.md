# Manually Restore an Event

---

<br />**GET /api/v1/keyevent/restore**

## Overview
Restore a specified event based on `monitorCheckerEventRef`



## Query Request Parameters

| Parameter Name        | Type     | Required | Description              |
|:---------------------|:---------|:---------|:-------------------------|
| monitorCheckerEventRef | string   | Y        | Unique identifier for the triggering object (df_monitor_checker_event_ref)<br>Allow empty: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/keyevent/restore?monitorCheckerEventRef=09e6fdaa5235f1e49014254f7b1653fc' \
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
    "traceId": "TRACE-EE0CCB94-DE13-4EBE-A89F-49D12CD996C6"
} 
```