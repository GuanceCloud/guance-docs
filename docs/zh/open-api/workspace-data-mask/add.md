# 新建

---

<br />**POST /api/v1/data_mask_rule/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 规则名称<br>允许为空: False <br>最大长度: 128 <br>允许空字符串: False <br> |
| type | string | Y | 数据类型<br>例子: logging <br>允许为空: True <br>可选值: ['logging', 'metric', 'object', 'custom_object', 'keyevent', 'tracing', 'rum', 'security', 'network', 'profiling'] <br> |
| field | string | Y | 字段名<br>允许为空: False <br>最大长度: 128 <br>允许空字符串: False <br> |
| reExpr | string | Y | 正则表达式<br>允许为空: False <br>最大长度: 5000 <br>允许空字符串: False <br> |
| roleUUIDs | array | Y | 该规则对空间哪些角色进行数据脱敏<br>例子: ['xxx', 'xxx'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/data_mask_rule/add' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"lwcTest","type":"logging","reExpr":"\\b(?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})\\b","roleUUIDs":["readOnly"],"field":"message"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "workspaceUUID": "wksp_xxxx",
        "name": "lwcTest",
        "type": "logging",
        "field": "message",
        "reExpr": "\\b(?:[0-9A-Fa-f]{2}[:-]){5}(?:[0-9A-Fa-f]{2})\\b",
        "roleUUIDs": [
            "readOnly"
        ],
        "id": 153,
        "uuid": "wdmk_xxx",
        "status": 0,
        "creator": "acnt_xxxx",
        "updator": "acnt_xxxx",
        "createAt": 1718107343,
        "deleteAt": -1,
        "updateAt": 1718107343
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-953C271A-768B-4123-9B7C-D13B621C552B"
} 
```




