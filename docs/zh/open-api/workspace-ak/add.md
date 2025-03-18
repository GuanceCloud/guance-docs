# 创建一个Key

---

<br />**POST /api/v1/workspace/accesskey/add**

## 概述
创建一个Key




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | AK名称信息<br>例子: xxx <br>允许为空: False <br> |
| roleUUIDs | array |  | 指定 API key 的角色 列表 (不包含 owner)<br>允许为空: False <br> |

## 参数补充说明


**1. 请求参数说明*

| 参数名 | type| 必选 | 说明|
| :---- | :-- | :--- | :------- |
| name   | string | 必选 | API Key 名|
| roleUUIDs   | array | | 指定API Key 的角色 UUID (不包含 owner, 默认为['wsAdmin']), 2025-03-12迭代新增 |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/accesskey/add' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"name": "88"}' \
  --compressed \
  --insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1678024319,
        "creator": "xxxx",
        "deleteAt": -1,
        "id": null,
        "name": "88",
        "sk": "xxx",
        "status": 0,
        "updateAt": 1678024319,
        "updator": "xxx",
        "uuid": "xxx",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A294E29E-33DE-48A5-A379-0BAA1519D256"
} 
```




