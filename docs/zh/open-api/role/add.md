# 新建角色

---

<br />**POST /api/v1/role/add**

## 概述
新建角色




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 角色名<br>例子: 角色1号 <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 角色的描述信息<br>例子: CUSTOM <br>允许为空: False <br>允许空字符串: True <br>最大长度: 3000 <br> |
| keys | array | Y | 选中的权限列表<br>例子: [] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/role/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"name":"自定义管理","desc":"test","keys":["workspace.readMember","label.labelCfgManage","log.externalIndexManage"]}' \
--compressed

```




## 响应
```shell
{
    "code": 200,
    "content": {
        "createAt": 1722827399,
        "creator": "wsak_d19aaf8a1faa42cc9f788ce86b5f81a1",
        "declaration": {
            "asd": "aa,bb,cc,1,True",
            "asdasd": "dawdawd",
            "business": "aaa",
            "fawf": "afawf",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "desc": "test",
        "id": null,
        "isSystem": 0,
        "name": "自定义管理",
        "status": 0,
        "updateAt": 1722827399,
        "updator": "wsak_d19aaf8a1faa42cc9f788ce86b5f81a1",
        "uuid": "role_01c7f2ef0f164d609c65006d3db9e602",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "9008386843384026938"
} 
```




