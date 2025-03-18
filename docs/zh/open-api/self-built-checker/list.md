# 列出智能巡检列表

---

<br />**GET /api/v1/self_built_checker/list**

## 概述
分页列出当前工作空间的自建巡检列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| monitorUUID | commaArray |  | 告警分组UUID<br>允许为空: False <br> |
| alertPolicyUUID | commaArray |  | 告警策略UUID<br>允许为空: False <br> |
| checkerUUID | commaArray |  | 自建巡检UUID<br>允许为空: False <br> |
| refKey | commaArray |  | refKey，多值以英文逗号分割<br>允许为空: False <br> |
| search | string |  | 搜索自建巡检名<br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 1 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/list?refKey=zyAy2l9v,zyAy897f' \
  -H 'Content-Type: application/json' \
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
                "alertPolicyInfos": [
                    {
                        "name": "0131",
                        "uuid": "altpl_xxxe62"
                    },
                    {
                        "name": "xxx的告警策略-自定义测试",
                        "uuid": "altpl_xxx3b8"
                    },
                    {
                        "name": "ll-告警策略-勿动",
                        "uuid": "altpl_xxx400"
                    }
                ],
                "createAt": 1706174074,
                "createdWay": "manual",
                "creator": "xx",
                "creatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "crontabInfo": {},
                "deleteAt": -1,
                "extend": {},
                "id": 663,
                "isLocked": 0,
                "jsonScript": {
                    "callKwargs": {},
                    "name": "SSL证书过期时间巡检",
                    "refFuncInfo": {
                        "args": [
                            "name"
                        ],
                        "category": "general",
                        "definition": "run(name='')",
                        "description": "zh-CN: SSL 证书有效期巡检\n    title: SSL 证书有效期巡检\n    doc: |\n        参数：\n            无需配置，默认整个工作空间\nen:\n    title: SSL Check\n    doc: |\n        Parameters:\n            No configuration is required by default for the entire workspace",
                        "funcId": "guance_monitor_user_example_obs__ssl.run",
                        "kwargs": {
                            "name": {
                                "default": ""
                            }
                        }
                    },
                    "title": "SSL证书过期时间巡检",
                    "type": "selfBuiltCheck"
                },
                "monitorName": "",
                "monitorUUID": "",
                "refKey": "xxxx",
                "secret": "",
                "status": 0,
                "type": "self_built_trigger",
                "updateAt": 1710760853,
                "updator": "xx",
                "updatorInfo": {
                    "uuid": "xx",
                    "status": 0,
                    "username": "xx",
                    "name": "xx",
                    "iconUrl": "",
                    "email": "xx",
                    "acntWsNickname": "xx"
                },
                "uuid": "rul_xxxf2e",
                "workspaceUUID": "wksp_xxx15d"
            }
        ],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "64fe7b4062f74d0007b46676"
        }
    },
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 100,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-506E20FA-553F-4FBC-9ACD-E1A400ACB790"
} 
```




