# 新建 Pipeline 规则

---

<br />**POST /api/v1/pipeline/add**

## 概述
创建一个Pipeline

当类型 category 为 profiling 时, 空间配置的字段 CentralPLServiceSwitch(/workspace/get 接口返回) 为true 该规则才会实际生效




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | Pipeline文件名称<br>允许为空: False <br>最大长度: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| type | string | Y | Pipeline文件类型<br>允许为空: False <br>可选值: ['local', 'central'] <br> |
| source | array |  | 选取的source列表<br>允许为空: False <br> |
| content | string | Y | pipeline文件内容(base64编码)<br>允许为空: False <br> |
| testData | string |  | 测试数据(base64编码)<br>允许为空: False <br>允许空字符串: True <br> |
| isForce | boolean |  | 具体类型存在default时, 是否进行替换<br>允许为空: False <br> |
| category | string | Y | 类别<br>允许为空: False <br>允许空字符串: False <br>可选值: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric', 'profiling'] <br> |
| asDefault | int |  | 是否作为该类型的默认pipeline, 1设为默认, 0为非默认<br>允许为空: False <br> |
| extend | json |  | 类别<br>允许为空: False <br> |
| extend.appID | array |  | appID<br>允许为空: True <br> |
| extend.measurement | array |  | source来源<br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notes/create' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"openapi_test","category":"logging","asDefault":0,"content":"YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==","testData":"W10=","source":["nsqlookupd"]}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "asDefault": 0,
        "category": "logging",
        "content": "YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==\n",
        "createAt": 1678026470,
        "creator": "xxxx",
        "deleteAt": -1,
        "extend": {},
        "id": null,
        "isSysTemplate": null,
        "name": "openapi_test",
        "status": 0,
        "testData": "W10=\n",
        "updateAt": 1678026470,
        "updator": "xxxx",
        "uuid": "pl_d221f03ac39d468d8d7fb262b5792607",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-74509B6F-DE3D-4905-AC9F-4FD96ED78EC3"
} 
```




