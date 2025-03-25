# 【Aggregation Generated Metrics】Acquisition

---

<br />**GET /api/v1/aggs_to_metric/\{rule_uuid\}/get**

## Overview
Acquisition of generated metrics rules



## Route Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-----|:----------------|
| rule_uuid | string | Y | ID of the aggregation generated metric<br> |


## Supplementary Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/aggs_to_metric/rul_xxxx/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## Response
```shell
{
    "code": 200,
    "content": {
        "workspaceUUID": "wksp_xxxx",
        "monitorUUID": "",
        "updator": "",
        "type": "aggs",
        "refKey": "",
        "secret": "",
        "jsonScript": {
            "type": "logToMetric",
            "query": {
                "q": "L('default')::RE(`.*`):(count(`*`)) { `host`='hangzhou123' and `region`='guanzhou'  } BY `host_ip`",
                "qtype": "dql"
            },
            "metricInfo": {
                "desc": "",
                "unit": "custom/[\"timeStamp\",\"ms\"]",
                "every": "1m",
                "metric": "test",
                "metricField": "001-test"
            }
        },
        "crontabInfo": {
            "id": "cron-xxxx",
            "crontab": null
        },
        "extend": {
            "index": "default",
            "source": "*",
            "filters": [],
            "groupBy": [
                "host_ip"
            ],
            "fieldKey": "*",
            "funcName": "count",
            "filterString": "host:hangzhou123 region:guanzhou"
        },
        "createdWay": "manual",
        "isLocked": 0,
        "openPermissionSet": false,
        "permissionSet": [],
        "id": 2573,
        "uuid": "rul_xxxx",
        "status": 0,
        "creator": "acnt_xxxx",
        "createAt": 1734594428,
        "deleteAt": -1,
        "updateAt": -1,
        "creatorInfo": {
            "uuid": "acnt_xxxx",
            "status": 0,
            "wsAccountStatus": 0,
            "username": "xxxx",
            "name": "xxxx",
            "iconUrl": "",
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "mobile": "xxxx",
            "acntWsNickname": ""
        },
        "updatorInfo": {}
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "9600305647351992736"
} 
```