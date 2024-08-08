# 修改一个仪表板

---

<br />**POST /api/v1/dashboards/\{dashboard_uuid\}/modify**

## 概述
修改仪表板的属性信息，




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 视图名称<br>例子: 测试视图1号 <br>允许为空: False <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 2048 <br> |
| extend | json |  | 视图额外信息<br>例子: {} <br>允许为空: False <br> |
| mapping | array |  | mapping, 默认为[]<br>例子: [] <br>允许为空: False <br> |
| tagNames | array |  | tag的name，注意此字段为全量更新<br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_1cbdbf10c1494c80b36b91b4e0e1ab90",
                "pos": {
                    "h": 11,
                    "i": "chrt_2e650ef84b1a4eb389011fd95f7db11e",
                    "w": 11,
                    "x": 0,
                    "y": 0
                }
            }
        ],
        "createAt": 1642587228,
        "createdWay": "import",
        "creator": "acnt_5fc5bb139e474911b6d3d300863f0c8b",
        "dashboardBidding": {},
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 2494,
        "mapping": [],
        "name": "testt",
        "old_name": "openapi",
        "ownerType": "node",
        "status": 0,
        "tag_info": {
            "sceneInfo": [],
            "tagInfo": []
        },
        "type": "CUSTOM",
        "updateAt": 1642587908.306098,
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "iconUrl": "",
            "name": "第一个key",
            "username": "AK(wsak_xxxxx)"
        },
        "uuid": "dsbd_541083cc19ec4d27ad597839a0477a97",
        "workspaceUUID": "wksp_c4201f4ef30c4a86b01a998e7544f822"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5F0F4D27-0A77-41B3-9E05-227648467853"
} 
```




