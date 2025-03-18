# 获取一个智能巡检信息

---

<br />**GET /api/v1/self_built_checker/get**

## 概述
根据给定的自建巡检标识获取监控器详情




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | 自建巡检的UUID<br>例子: rul_xxxxx <br>允许为空: False <br> |
| refKey | string |  | 自建巡检的关联key<br>例子: xxx <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/get?refKey=zyAy2l9v' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1662539061,
        "creator": "acnt_xxxx32",
        "crontabInfo": {},
        "deleteAt": -1,
        "extend": {},
        "id": 88,
        "jsonScript": {
            "name": "自建巡检-20220907T162421bymvlx",
            "type": "selfBuiltCheck"
        },
        "monitorUUID": "monitor_xxxx32",
        "refKey": "zyAy2l9v",
        "status": 0,
        "type": "self_built_trigger",
        "updateAt": 1662539061,
        "updator": "",
        "uuid": "rul_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-E353D55D-A6FD-497E-82D2-3DA04E703A6D"
} 
```




