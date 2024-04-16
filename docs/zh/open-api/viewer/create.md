# 创建一个查看器

---

<br />**POST /api/v1/viewer/add**

## 概述
创建一个查看器




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ownerType | string |  | 视图分类类型, 默认为 viewer<br>例子: viewer <br>允许为空: False <br> |
| templateUUID | string |  | 视图模板UUID<br>允许为空: False <br>允许空字符串: True <br>最大长度: 128 <br> |
| sourceDashboardUUID | string |  | 源视图ID<br>允许为空: False <br>允许空字符串: True <br>最大长度: 128 <br> |
| name | string | Y | 查看器名称<br>允许为空: False <br>最大长度: 64 <br> |
| type | string |  | 类型, 默认为 CUSTOM<br>例子: CUSTOM <br>允许为空: False <br>最大长度: 32 <br> |
| extend | json |  | 查看器的额外数据, 默认为{}<br>例子: {} <br>允许为空: False <br> |
| templateInfos | json |  | 自定义模板数据<br>例子: {} <br>允许为空: False <br>允许空字符串: False <br> |
| isImport | boolean |  | 是否为导入的查看器<br>允许为空: False <br> |
| tagNames | array |  | tag的name们<br>允许为空: False <br> |
| tagNames[*] | string |  | tag名<br>允许为空: False <br>最大长度: 128 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/viewer/add' \
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
                "id": "tag_b43ad380619c46e0b9dd944d123ff377",
                "name": "Function"
            },
            {
                "id": "tag_7393bfabb4384fbb88e02c31bcdbc2bd",
                "name": "Host"
            },
            {
                "id": "tag_881a0f78253a451095b9394797954392",
                "name": "Profile"
            },
            {
                "id": "tag_8855190c400c443b92722ec3d477bec3",
                "name": "data"
            },
            {
                "id": "tag_9ba52e9e578d48afbb087d45a639e593",
                "name": "ok"
            },
            {
                "id": "tag_946e249609744288b126325a5c336015",
                "name": "ui"
            },
            {
                "id": "tag_35c1c83547144575abaf7ee1bf08738b",
                "name": "个人"
            },
            {
                "id": "tag_bc2b120ab9a5424298953d6211473fab",
                "name": "为"
            },
            {
                "id": "tag_484b5e1b6cd44868a9b1a15f3b059fb9",
                "name": "内置"
            },
            {
                "id": "tag_03db665b2a5a46bf809c59d1f7d025d8",
                "name": "安全巡检"
            },
            {
                "id": "tag_740834b7b7e94d1dbe1e764ee78039a3",
                "name": "应用性能"
            },
            {
                "id": "tag_70a4d7b7084e439f91d83480d356a737",
                "name": "日志"
            },
            {
                "id": "tag_a5cfed07d1a64f299aa4568ba53c09ce",
                "name": "用户访问"
            },
            {
                "id": "tag_9eec90bebbdc4bad9e9273e222d2d939",
                "name": "阿里"
            },
            {
                "id": "tag_16ecc5d334ef4408a988e2768d7c5316",
                "name": "阿里云监控"
            }
        ],
        "type": "CUSTOM",
        "updateAt": 1677661673,
        "updator": "wsak_xxxxx",
        "uuid": "dsbd_e493a3c17d3c456bb1febfcbbe4148d2",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-7EB1D391-C7BA-47BA-A535-DEE932554366"
} 
```




