# 创建一个查看器

---

<br />**POST /api/v1/viewer/add**

## 概述
创建一个查看器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ownerType | string |  | 视图分类类型, 默认为 viewer<br>例子: viewer <br>允许为空: False <br> |
| templateUUID | string |  | 视图模板UUID<br>允许为空: False <br>允许为空字符串: True <br>最大长度: 128 <br> |
| sourceDashboardUUID | string |  | 源视图ID<br>允许为空: False <br>允许为空字符串: True <br>最大长度: 128 <br> |
| name | string | Y | 查看器名称<br>允许为空: False <br>最大长度: 64 <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 2048 <br> |
| type | string |  | 类型, 默认为 CUSTOM<br>例子: CUSTOM <br>允许为空: False <br>最大长度: 32 <br> |
| extend | json |  | 查看器的额外数据, 默认为{}<br>例子: {} <br>允许为空: False <br> |
| templateInfos | json |  | 自定义模板数据<br>例子: {} <br>允许为空: False <br>允许为空字符串: False <br> |
| isImport | boolean |  | 是否为导入的查看器<br>允许为空: False <br> |
| tagNames | array |  | tag的name们<br>允许为空: False <br> |
| tagNames[*] | string |  | tag名<br>允许为空: False <br>最大长度: 128 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/viewer/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"add_viewer","templateInfos":{},"isImport":false,"tagNames":[],"extend":{"index":"tracing"}}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [],
        "createAt": 1677661673,
        "createdWay": "manual",
        "creator": "wsak_xxxxx",
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {
            "index": "tracing"
        },
        "iconSet": {},
        "id": null,
        "isPublic": 1,
        "mapping": [],
        "name": "add_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tag_info": [
            {
                "id": "tag_xxxx32",
                "name": "Function"
            },
            {
                "id": "tag_xxxx32",
                "name": "Host"
            },
            {
                "id": "tag_xxxx32",
                "name": "Profile"
            },
            {
                "id": "tag_xxxx32",
                "name": "data"
            },
            {
                "id": "tag_xxxx32",
                "name": "ok"
            },
            {
                "id": "tag_xxxx32",
                "name": "ui"
            },
            {
                "id": "tag_xxxx32",
                "name": "个人"
            },
            {
                "id": "tag_xxxx32",
                "name": "为"
            },
            {
                "id": "tag_xxxx32",
                "name": "内置"
            },
            {
                "id": "tag_xxxx32",
                "name": "安全巡检"
            },
            {
                "id": "tag_xxxx32",
                "name": "应用性能"
            },
            {
                "id": "tag_xxxx32",
                "name": "日志"
            },
            {
                "id": "tag_xxxx32",
                "name": "用户访问"
            },
            {
                "id": "tag_xxxx32",
                "name": "阿里"
            },
            {
                "id": "tag_xxxx32",
                "name": "阿里云监控"
            }
        ],
        "type": "CUSTOM",
        "updateAt": 1677661673,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7EB1D391-C7BA-47BA-A535-DEE932554366"
} 
```




