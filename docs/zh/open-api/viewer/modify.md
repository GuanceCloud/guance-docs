# 修改一个查看器

---

<br />**POST /api/v1/viewer/\{viewer_uuid\}/modify**

## 概述
修改查看器




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| viewer_uuid | string | Y | 查看器UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 查看器名称<br>例子: 查看器1号 <br>允许为空: False <br>最大长度: 64 <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 2048 <br> |
| type | string |  | 类型, 默认为 CUSTOM<br>例子: CUSTOM <br>允许为空: False <br>最大长度: 32 <br> |
| extend | json |  | 查看器的额外数据, 默认为{}<br>例子: {} <br>允许为空: False <br> |
| pathName | string |  | explorer 路径名<br>例子: tracing__profile <br>允许为空: False <br>最大长度: 32 <br> |
| tagNames | array |  | tag的name<br>允许为空: False <br> |
| tagNames[*] | string |  | tag名<br>允许为空: False <br>最大长度: 128 <br> |
| dashboardBindSet | array |  | 查看器绑定的视图信息<br>例子: [] <br>允许为空: False <br>允许为空字符串: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/viewer/dsbd_e493a3c17d3c456bb1febfcbbe4148d2/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"modify_viewer","tagNames":["应用性能"]}' \
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
        "dashboardBidding": {},
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {
            "analysisField": "message",
            "charts": [
                null,
                null,
                null
            ],
            "filters": [],
            "index": "tracing",
            "quickFilter": {
                "columns": []
            },
            "rumAppId": "",
            "rumType": "",
            "selectedIndex": "default",
            "source": "",
            "table": {
                "columns": []
            }
        },
        "iconSet": {},
        "id": 712,
        "isPublic": 1,
        "mapping": [],
        "name": "modify_viewer",
        "old_name": "add_viewer",
        "ownerType": "viewer",
        "status": 0,
        "tag_info": {
            "tagInfo": [
                {
                    "id": "tag_740834b7b7e94d1dbe1e764ee78039a3",
                    "name": "应用性能"
                }
            ]
        },
        "type": "CUSTOM",
        "updateAt": 1677662058.377045,
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "智能巡检测试",
            "username": "xxxx"
        },
        "uuid": "dsbd_e493a3c17d3c456bb1febfcbbe4148d2",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-AECCF8D3-29D3-431E-AB68-046688C30035"
} 
```




