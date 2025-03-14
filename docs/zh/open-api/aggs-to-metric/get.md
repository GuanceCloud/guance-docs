# 【聚合生成指标】获取

---

<br />**GET /api/v1/aggs_to_metric/\{rule_uuid\}/get**

## 概述
生成指标规则获取




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| rule_uuid | string | Y | 聚合生成指标的ID<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/aggs_to_metric/rul_xxxx/get' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
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
            "email": "xxxx@guance.com",
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




