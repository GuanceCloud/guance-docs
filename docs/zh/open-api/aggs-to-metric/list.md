# 【聚合生成指标】列出

---

<br />**GET /api/v1/aggs_to_metric/list**

## 概述
生成指标规则列出




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 根据生成指标的 指标集名,指标名搜素<br>允许为空: False <br>允许为空字符串: True <br> |
| scriptType | string |  | 类型<br>允许为空: False <br>可选值: ['rumToMetric', 'apmToMetric', 'logToMetric', 'securityToMetric', 'metricToMetric'] <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/aggs_to_metric/list?pageSize=100&pageIndex=1&scriptType=logToMetric' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
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




