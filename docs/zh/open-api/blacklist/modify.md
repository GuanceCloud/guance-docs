# 修改一个黑名单

---

<br />**POST /api/v1/blacklist/\{blist_uuid\}/modify**

## 概述
修改一个黑名单




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| blist_uuid | string | Y | 黑名单规则uuid<br>允许为空: False <br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 名称 (2024-11-27 迭代新增)<br>允许为空: False <br>允许为空字符串: False <br>最大长度: 50 <br> |
| desc | string |  | 描述 (2024-11-27 迭代新增)<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 256 <br> |
| type | string | Y | 黑名单类型,枚举值类型有('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric')<br>允许为空: False <br> |
| source | string |  | 数据来源, 全部来源时候, 此时source为 re(`.*`)<br>允许为空: True <br>允许为空字符串: False <br>$maxCharacterLength: 128 <br> |
| sources | array |  | 数据来源, 多个来源时使用该字段,非全部来源时(全部来源使用 source 字段 re(`.*`))<br>允许为空: True <br> |
| filters | array |  | 过滤条件<br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/blacklist/blist_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"规则1","desc":"","type":"logging","source":"kodo-log","filters":[{"name":"hostname","value":["127.0.0.1"],"operation":"in","condition":"and"}]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ source =  'kodo-log'  and ( hostname in [ '127.0.0.1' ] )}",
        "createAt": 1677653414,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "desc": "",
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
        "name": "规则1",
        "source": "kodo-log",
        "status": 0,
        "type": "logging",
        "updateAt": 1678029845.282458,
        "updator": "xxxx",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-BC365EB4-B4BA-4194-B0BB-B1AC8FA29804"
} 
```




