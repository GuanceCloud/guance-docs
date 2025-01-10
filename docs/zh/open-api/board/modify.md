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
| identifier | string |  | 标识id   --2024.12.25 新增标识id<br>例子: xxxx <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 128 <br> |
| extend | json |  | 视图额外信息<br>例子: {} <br>允许为空: False <br> |
| mapping | array |  | mapping, 默认为[]<br>例子: [] <br>允许为空: False <br> |
| tagNames | array |  | tag的name，注意此字段为全量更新<br>允许为空: False <br> |
| isPublic | int |  | 是否公开展示, 1为公开, 0为非公开, -1表示自定义<br>例子: 1 <br>允许为空: False <br> |
| permissionSet | array |  | 自定义时 isPublic 为-1时候的 操作权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |
| readPermissionSet | array |  | 自定义时 isPublic 为-1时候的 读取权限配置, 可配置(角色(除拥有者), 成员uuid, 团队uuid)<br>例子: ['wsAdmin', 'acnt_xxxx', 'group_yyyy'] <br>允许为空: False <br> |

## 参数补充说明







## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 11,
                    "i": "chrt_xxxx32",
                    "w": 11,
                    "x": 0,
                    "y": 0
                }
            }
        ],
        "createAt": 1642587228,
        "createdWay": "import",
        "creator": "acnt_xxxx32",
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
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5F0F4D27-0A77-41B3-9E05-227648467853"
} 
```




