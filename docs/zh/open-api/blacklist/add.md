# 创建一个黑名单

---

<br />**POST /api/v1/blacklist/add**

## 概述
创建一个黑名单




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 黑名单类型,枚举值类型有('object', 'custom_object', 'logging', 'keyevent', 'tracing', 'rum', 'network', 'security', 'profiling', 'metric')<br>允许为空: False <br> |
| source | string | Y | 数据来源<br>允许为空: True <br>$maxCharacterLength: 128 <br> |
| filters | array | Y | 过滤条件<br>允许为空: True <br> |


## 参数补充说明

*查询说明*

--------------

**1.filters 数组元素字段说明

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| name    |  string  |  N | 筛选条件名 |
| operation |  string  |  N | 进行对操作比如in、contain |
| condition    |  string  |  N | dql格式的过滤条件 |
| values    |  array  |  N | 查询条件具体数值 |

**2. operation 说明**

|key|说明|
|---|----|
|in|等于|
|not in|不等于|
|contain|正则匹配|
|not contain|正则不匹配|



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
                   "operation":"contain",
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
        "creator": "wsak_dca59c06eb144f10b6041c34ad1716a7",
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
        "updator": "wsak_dca59c06eb144f10b6041c34ad1716a7",
        "uuid": "blist_92c88afa154f44ca851e8465c8408481",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1C3DFE84-E7AD-4956-B363-8BB7EB3CD5A4"
} 
```




