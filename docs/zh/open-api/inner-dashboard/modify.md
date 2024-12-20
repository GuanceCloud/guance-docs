# 修改单个用户视图

---

<br />**POST /api/v1/dashboard/\{dashboard_uuid\}/modify**

## 概述
修改单个用户视图




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| dashboard_uuid | string | Y | 视图UUID<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string |  | 视图名称<br>例子: 测试视图1号 <br>允许为空: False <br>最大长度: 256 <br> |
| desc | string |  | 描述<br>例子: 描述1 <br>允许为空: False <br>最大长度: 2048 <br> |
| customIdentityId | string |  | 标识id   --2024.12.25 新增标识id<br>例子: xxxx <br>允许为空: False <br>允许为空字符串: True <br>最大长度: 128 <br> |
| dashboardBidding | json |  | mapping, 默认为{}<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明

**请求主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|name         |string |  视图名称 |
|desc         |string |  描述 |
|customIdentityId         |string |  标识id  --2024.12.25新增 |
|dashboardBidding         |dict |   仪表板绑定的信息|


**绑定内置视图字段 dashboardBidding 说明**

内部支持 op 值 in/wildcard

**dashboardBidding 字段示例:**
```
{
    "service": [
        {
            "value": [
                "*"
            ],
            "op": "in"
        }
    ],
    "app_id": [
        {
            "value": [
                "test0"
            ],
            "op": "wildcard"
        }
    ],
    "label": [
        {
            "value": [
                "勿删"
            ],
            "op": "in"
        }
    ]
}
```




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/dashboard/dsbd_xxxx32/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"name":"test_Redis 监控视图","dashboardBidding":{"app_id":[{"value":["cccc"],"op":"in"}]}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [
            "chtg_xxxx32",
            "chtg_xxxx32",
            "chtg_xxxx32"
        ],
        "chartPos": [
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 0,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 0,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 0,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 18,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 8,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 8,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 0,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 16,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 12,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 16,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 6,
                    "x": 6,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 16,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_xxxx32",
                "pos": {
                    "h": 8,
                    "i": "chrt_xxxx32",
                    "w": 8,
                    "x": 8,
                    "y": 31
                }
            }
        ],
        "createAt": 1698732345,
        "createdWay": "manual",
        "creator": "wsak_xxxxx",
        "dashboardBidding": {
            "app_id": [
                {
                    "op": "in",
                    "value": [
                        "cccc"
                    ]
                }
            ]
        },
        "dashboardBindSet": [],
        "deleteAt": -1,
        "extend": {},
        "iconSet": {
            "icon": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/aliyun_redis/icon.svg",
            "url": "http://testing-static-res.dataflux.cn/dataflux-template/dashboard/zh/aliyun_redis/aliyun_redis.png"
        },
        "id": 4615,
        "isPublic": 1,
        "mapping": [],
        "name": "test_Redis 监控视图",
        "old_name": "test_Redis 监控视图",
        "ownerType": "inner",
        "status": 0,
        "tag_info": {
            "tagInfo": []
        },
        "type": "CUSTOM",
        "updateAt": 1698732854,
        "updator": "wsak_xxxxx",
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "wsak_xxxxx",
            "iconUrl": "",
            "name": "a",
            "username": "xxx"
        },
        "uuid": "dsbd_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CEA33BA0-68C7-499B-83D7-F59015192DBB"
} 
```




