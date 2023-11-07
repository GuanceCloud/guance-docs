# 【自定义映射规则】添加一个映射配置

---

<br />**POST /api/v1/login_mapping/field/add**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceField | string | Y | 源字段<br>例子: sourceField <br>允许为空: False <br>最大长度: 256 <br> |
| sourceValue | string | Y | 源字段值<br>例子:  <br>允许为空: False <br>最大长度: 256 <br> |
| targetValues | array | Y | 目标字段值（目前默认为 角色的UUID 值列表）<br>例子: readOnly <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/add' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"sourceField":"name","sourceValue":"lisa","targetValues":["wsAdmin","role_5608f6a479264afb9daf34812feeba15"]}' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1697427020,
        "creator": "mact_738b7d961dfa464dxxxxxx",
        "deleteAt": -1,
        "id": null,
        "isSystem": true,
        "sourceField": "name",
        "sourceValue": "lisa",
        "status": 0,
        "targetValues": [
            "wsAdmin",
            "role_xxxxxxxx"
        ],
        "updateAt": 1697427020,
        "updator": "mact_xxxxxx",
        "uuid": "lgmp_xxxxxxxxxxxxxx",
        "workspaceUUID": "wksp_bb191037aa7exxxxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12119540197801491096"
} 
```




