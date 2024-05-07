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
| dashboardBidding | json |  | mapping, 默认为{}<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明

**请求主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|name         |list |  视图名称 |
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
curl 'https://openapi.guance.com/api/v1/dashboard/dsbd_c66d57c9f10149378b1fd36977145713/modify' \
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
            "chtg_604d4d14191c405a968a7c939d6b5571",
            "chtg_3c5c604f8968431e8746e1c5762ae1fc",
            "chtg_c488448f830a441a96f424f429402e21"
        ],
        "chartPos": [
            {
                "chartUUID": "chrt_9c2790887e1a44b0832ed8d71db9c60b",
                "pos": {
                    "h": 8,
                    "i": "chrt_a6f8e55f3cfb4dc2bbdcc38581a05eab",
                    "w": 8,
                    "x": 0,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_f6278e8f5fca4a26976ae00a6eb5277b",
                "pos": {
                    "h": 8,
                    "i": "chrt_816ca46b56384fcc8515e090b3b8abfb",
                    "w": 6,
                    "x": 0,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_a033b14d9de645f6bc2e99ecb27c0874",
                "pos": {
                    "h": 8,
                    "i": "chrt_eacb38b490404c23814b154f1ab4e031",
                    "w": 8,
                    "x": 0,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_2763b9633e254263b9a8fa528e62397e",
                "pos": {
                    "h": 8,
                    "i": "chrt_db849e7b76854cfdbeeabe1153fdc769",
                    "w": 6,
                    "x": 18,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_d4cf5b8bc9d64d218735e064d71e2c2e",
                "pos": {
                    "h": 8,
                    "i": "chrt_b5bef611199a47a3b0956375b8f138c6",
                    "w": 8,
                    "x": 8,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_69c5b03dadb74cef98cd267d14c1f014",
                "pos": {
                    "h": 8,
                    "i": "chrt_e24cf24645a94711aaf6cb6ae75fa78b",
                    "w": 8,
                    "x": 8,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_c825f5133bbb4fadbfa4a38a5138031b",
                "pos": {
                    "h": 8,
                    "i": "chrt_02ca9c11c7d144909f34623c0decc0f2",
                    "w": 8,
                    "x": 0,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_450f5a9f797f4392ab634a59a8f50e57",
                "pos": {
                    "h": 8,
                    "i": "chrt_c83aeefe8d074a1881062fe54288883c",
                    "w": 8,
                    "x": 16,
                    "y": 23
                }
            },
            {
                "chartUUID": "chrt_2502ecaf8dd0429db806863a2e64c71e",
                "pos": {
                    "h": 8,
                    "i": "chrt_500d78453cf14573b14ed70251dd4da2",
                    "w": 6,
                    "x": 12,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_b5f2e4e572af4ba6bc968e20c0ed78d5",
                "pos": {
                    "h": 8,
                    "i": "chrt_5608460e97d5475d8f30c4341a2b4334",
                    "w": 8,
                    "x": 16,
                    "y": 31
                }
            },
            {
                "chartUUID": "chrt_40dbab36ff5c42c6925164c4f4744846",
                "pos": {
                    "h": 8,
                    "i": "chrt_1e1dfc92bd5a47eda4f1fee21bbc1823",
                    "w": 6,
                    "x": 6,
                    "y": 12.5
                }
            },
            {
                "chartUUID": "chrt_3332e1dff57440f1835cbf39b3045c72",
                "pos": {
                    "h": 8,
                    "i": "chrt_8b047120b2f44c0bba86a9268d51b65e",
                    "w": 8,
                    "x": 16,
                    "y": 2
                }
            },
            {
                "chartUUID": "chrt_b77e35cc911e426d8ee205da075eb5bc",
                "pos": {
                    "h": 8,
                    "i": "chrt_1fbf1f6e0e51495dbab1b9f69d04995c",
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
        "uuid": "dsbd_c66d57c9f10149378b1fd36977145713",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-CEA33BA0-68C7-499B-83D7-F59015192DBB"
} 
```




