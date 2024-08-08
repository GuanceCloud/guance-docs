# 获取数据转发规则列表

---

<br />**GET /api/v1/log_backup_cfg/list**

## 概述
列出数据转发规则




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 普通搜索字段<br>例子: xxxxx_text <br>允许为空: False <br>允许为空字符串: True <br> |
| storeType | string |  | 存储类型<br>允许为空: False <br>可选值: ['guanceObject', 's3', 'obs', 'oss', 'kafka'] <br> |
| dataType | string |  | 数据类型<br>允许为空: False <br>可选值: ['logging', 'tracing', 'rum'] <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明


数据说明.*

- 请求参数说明

| 参数名           | type | 说明                                                 |
| ---------------- | ---- | ---------------------------------------------------- |
| search       | string | 搜索规则名称 |
| storeType             | string | 过滤规则存储类型                                                 |
| dataType       | string  |  数据类型     |
| pageIndex |  string  |  N | 分页页码 |
| pageSize  |  string  |  N | 每页返回数量 |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_backup_cfg/list?pageIndex=1&pageSize=3' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "conditions": "",
            "createAt": 1697543205,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "dataType": "logging",
            "deleteAt": -1,
            "duration": "180d",
            "extend": {
                "filterLogic": "and",
                "filters": []
            },
            "externalResourceAccessCfgUUID": "erac_4451d3bad15a4c298d6cf593e4d83212",
            "id": 684,
            "name": "ssfda***",
            "status": 0,
            "storeType": "obs",
            "syncExtensionField": false,
            "taskErrorCode": "NoSuchBucket",
            "taskStatusCode": 404,
            "updateAt": 1697610912,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "uuid": "lgbp_4eb51e43647a4a7c8bbac69bec088275",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "",
            "createAt": 1694588429,
            "creator": "acnt_8775d346f997436c8918e9a5c8a3dffc",
            "dataType": "logging",
            "deleteAt": -1,
            "duration": "180d",
            "extend": {
                "filterLogic": "and",
                "filters": []
            },
            "externalResourceAccessCfgUUID": "erac_79258ec856d344179fb01855a4801fca",
            "id": 669,
            "name": "test-21-02",
            "status": 0,
            "storeType": "obs",
            "syncExtensionField": false,
            "taskErrorCode": "AccessDenied",
            "taskStatusCode": 403,
            "updateAt": 1695290409,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "uuid": "lgbp_c4241d62a1fb4e0dabe26ca6643d3f0a",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        },
        {
            "conditions": "{  `source` in [ 'mysql' ] }",
            "createAt": 1692686192,
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "dataType": "logging",
            "deleteAt": -1,
            "duration": "180d",
            "extend": {
                "filterLogic": "and",
                "filters": [
                    {
                        "condition": "and",
                        "name": "source",
                        "operation": "in",
                        "value": [
                            "mysql"
                        ]
                    }
                ]
            },
            "externalResourceAccessCfgUUID": "erac_e766355a7130427faffe766b015286d1",
            "id": 518,
            "name": "osstest-xjp",
            "status": 0,
            "storeType": "oss",
            "syncExtensionField": true,
            "taskErrorCode": "",
            "taskStatusCode": -1,
            "updateAt": 1695286731,
            "updator": "acnt_a71564d3390f486dba9f7c1580b9e02a",
            "uuid": "lgbp_42cca273b6594533936c072c1c85a5ae",
            "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 3,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 66
    },
    "success": true,
    "traceId": "TRACE-ADC98BC2-1772-4E2E-9737-F80D3CC5453F"
} 
```




