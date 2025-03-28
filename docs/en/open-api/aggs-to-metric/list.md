# 【Aggregation Generation Metrics】List

---

<br />**GET /api/v1/aggs_to_metric/list**

## Overview
List of generated metrics rules



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-----------------|:-------|:-----|:----------------|
| search | string |  | Search by name of Measurement or Metric in the generated metric.<br>Allow null: False <br>Allow empty string: True <br> |
| scriptType | string |  | Type<br>Allow null: False <br>Optional values: ['rumToMetric', 'apmToMetric', 'logToMetric', 'securityToMetric', 'metricToMetric'] <br> |
| pageIndex | integer |  | Page number<br>Allow null: False <br>Example: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | Number of items returned per page<br>Allow null: False <br>Example: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## Additional Parameter Notes





## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/aggs_to_metric/list?pageSize=100&pageIndex=1&scriptType=logToMetric' \
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
            }
        ],
        "pageInfo": {
            "pageIndex": 1,
            "pageSize": 100,
            "count": 1,
            "totalCount": 1
        }
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "4874159640411139200"
} 
```