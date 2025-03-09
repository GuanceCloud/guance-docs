# [Service Performance] Get

---

<br />**GET /api/v1/service_manage/performance/get**

## Overview
Retrieve performance information for a single service


## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| start | integer | Y | Start time, unit ms<br> |
| end | integer | Y | End time, unit ms<br> |
| serviceName | string | Y | Service name<br>Allow empty: False <br>Allow empty string: False <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/performance/get?end=1693810693999&start=1693767493000&serviceName=anypath' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```



## Response
```shell
{
    "code": 200,
    "content": {
        "__docid": "a3d7f56895c1476a411986f1bf59c6d0",
        "avg_per_second": 1.5411574074074075,
        "avg_resp_time": 192929.50521193186,
        "checkerInfo": [
            {
                "name": "Test {host}",
                "type": "simpleCheck",
                "uuid": "rul_xxxx32"
            },
            {
                "name": "Host {host} High",
                "type": "simpleCheck",
                "uuid": "rul_xxxx32"
            },
            {
                "name": "dcl test",
                "type": "simpleCheck",
                "uuid": "rul_xxxx32"
            }
        ],
        "dfStatus": "critical",
        "env": "test1",
        "error_count": 132,
        "error_rate": 0.001982636907086425,
        "isFavorite": 0,
        "key": "anypath",
        "max_duration": 212448,
        "p50": 192983,
        "p75": 192983,
        "p90": 192983,
        "p95": 192983,
        "p99": 192983,
        "service": "anypath",
        "source_type": "web",
        "sum_resp_time": 12844860598,
        "total_count": 66578,
        "type": "web",
        "uuid": "sman_xxxx32",
        "version": "gin1.1"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-9590059F-463F-4669-859F-3E53F020AAEA"
} 
```