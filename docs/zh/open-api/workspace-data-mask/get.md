# 获取

---

<br />**GET /api/v1/data_mask_rule/\{data_mask_rule_uuid\}/get**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| data_mask_rule_uuid | string | Y | 数据脱敏规则的uuid<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/data_mask_rule/wdmk_xxxx/get' \
-H 'Content-Type: application/json' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1715571687,
        "creator": "acnt_xxxx",
        "deleteAt": -1,
        "field": "aaabbb",
        "id": 150,
        "name": "gary-test123321",
        "reExpr": "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)",
        "roleUUIDs": [
            "wsAdmin"
        ],
        "status": 0,
        "type": "logging",
        "updateAt": 1715910622,
        "updator": "acnt_xxxx",
        "uuid": "wdmk_xxxx",
        "workspaceUUID": "wksp_xxxxx"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2CAD23A8-815F-4A9F-A57D-2066AB3FD164"
} 
```




