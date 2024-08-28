# 创建一个黑名单

---

<br />**POST /api/v1/blacklist/add**

## 概述
创建一个黑名单




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 黑名单类型,枚举值类型有('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric')<br>允许为空: False <br> |
| source | string | Y | 数据来源, type 字段为 logging支持全部来源,  tracing支持全部服务, 此时source为 re(`.*`)<br>允许为空: True <br>允许为空字符串: False <br>$maxCharacterLength: 128 <br> |
| filters | array | Y | 过滤条件<br>允许为空: True <br> |


## 参数补充说明

*查询说明*

--------------

**1.source 字段说明

黑名单的过滤条件生成时 会根据 type 类型, 对参数 source 字段的 key 进行替换
|  type        |   生成过滤条件时,source字段对应的key  |
|---------------|----------|
| object    |  class  |
| logging    |  source  |
| custom_object    |  class  |
| keyevent    |  source  |
| tracing    |  service  |
| rum    |  app_id  |
| network    |  source  |
| security    |  category  |
| profiling    |  service  |
| metric    |  measurement  |


**2.filters 数组元素字段说明

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| name    |  string  |  N | 筛选条件名 |
| operation |  string  |  N | 进行对操作比如in、not_in、match、not_match|
| condition    |  string  |  N | dql格式的过滤条件 |
| values    |  array  |  N | 查询条件具体数值 |

**3. operation 说明**
参考 行协议过滤器https://docs.guance.com/datakit/datakit-filter/

|key|说明|
|---|----|
|in|指定的字段在列表中|
|not_in|指定的字段不在列表中|
|match|正则匹配|
|not_match|正则不匹配|


**filters 示例如下
        ```filters:[
               {
                   "name":"host",
                   "value":[
                       "host1", "host2"
                   ],
                   "operation":"in",
                   "condition":"and"
               },
               {
                   "name":"status",
                   "value":[
                       "a*"
                   ],
                   "operation":"match",
                   "condition":"and"
               }
           ]
        ```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/blacklist/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"type":"logging","source":"kodo-log","filters":[{"name":"host","value":["127.0.0.1"],"operation":"in","condition":"and"}]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{ source =  'kodo-log'  and ( host in [ '127.0.0.1' ] )}",
        "createAt": 1678029404,
        "creator": "xxxx",
        "deleteAt": -1,
        "filters": [
            {
                "condition": "and",
                "name": "host",
                "operation": "in",
                "value": [
                    "127.0.0.1"
                ]
            }
        ],
        "id": null,
        "source": "kodo-log",
        "status": 0,
        "type": "logging",
        "updateAt": 1678029404,
        "updator": "xxxx",
        "uuid": "blist_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1C3DFE84-E7AD-4956-B363-8BB7EB3CD5A4"
} 
```




