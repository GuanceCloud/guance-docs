# 修改一个黑名单

---

<br />**post /api/v1/blacklist/\{blist_uuid\}/modify**

## 概述
修改一个黑名单




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| blist_uuid | string | Y | 日志过滤规则uuid<br>允许为空: False <br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 黑名单类型,枚举值类型有('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric')<br>允许为空: False <br> |
| source | string |  | 数据来源<br>允许为空: True <br> |
| filters | array |  | 过滤条件<br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/blist_58770f806d104f63bdee9bc1941bed36/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type":"logging","source":"kodo-log","filters":[{"name":"hostname","value":["127.0.0.1"],"operation":"in","condition":"and"}]}' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ source =  'kodo-log'  and ( hostname in [ '127.0.0.1' ] )}",
        "createAt": 1677653414,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "filters": [
            {
                "condition": "and",
                "name": "hostname",
                "operation": "in",
                "value": [
                    "127.0.0.1"
                ]
            }
        ],
        "id": 24,
        "source": "kodo-log",
        "status": 0,
        "type": "logging",
        "updateAt": 1678029845.282458,
        "updator": "wsak_dca59c06eb144f10b6041c34ad1716a7",
        "uuid": "blist_58770f806d104f63bdee9bc1941bed36",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BC365EB4-B4BA-4194-B0BB-B1AC8FA29804"
} 
```



