# 修改一个Pipeline

---

<br />**post /api/v1/pipeline/\{pl_uuid\}/modify**

## 概述
修改一个Pipeline




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| pl_uuid | string | Y | Pipeline的ID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | Pipeline文件名称，也是其source类型值<br>允许为空: False <br>最大长度: 256 <br>$notSearchRegExp: [^a-zA-Z0-9_\u4e00-\u9fa5-]+ <br> |
| source | array |  | 选取的source列表<br>允许为空: False <br> |
| content | string | Y | pipeline文件内容(base64编码)<br>允许为空: False <br> |
| testData | string |  | 测试数据(base64编码)<br>允许为空: False <br>允许空字符串: True <br> |
| isForce | boolean |  | 具体类型存在default时, 是否进行替换<br>允许为空: False <br> |
| asDefault | int |  | 是否作为该类型的默认pipeline, 1为设为默认<br>允许为空: False <br> |
| category | string | Y | 类别<br>允许为空: False <br>允许空字符串: False <br>可选值: ['logging', 'object', 'custom_object', 'network', 'tracing', 'rum', 'security', 'keyevent', 'metric'] <br> |
| extend | json |  | 类别<br>允许为空: False <br> |
| extend.appID | array |  | appID<br>允许为空: True <br> |
| extend.measurement | array |  | source来源<br>允许为空: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/pipeline/pl_d221f03ac39d468d8d7fb262b5792607/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_modify","category":"logging","asDefault":0,"content":"YWRkX2tleShjaXR5LCAic2hhbmdoYWkiKQ==","testData":"W10=","source":["nsqlookupd"]}' \
--compressed \
--insecure
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
        "creator": "wsak_dca59c06eb144f10b6041c34ad1716a7",
        "deleteAt": -1,
        "extend": {},
        "id": 86,
        "isSysTemplate": 0,
        "name": "test_modify",
        "source": [],
        "status": 0,
        "testData": "W10=\n",
        "updateAt": 1678026808.95266,
        "updator": "wsak_dca59c06eb144f10b6041c34ad1716a7",
        "uuid": "pl_d221f03ac39d468d8d7fb262b5792607",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1EA80DD4-EB2C-4A9B-A146-D00606CC50E0"
} 
```



