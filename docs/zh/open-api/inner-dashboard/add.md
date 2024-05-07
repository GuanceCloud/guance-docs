# 新建单个用户视图

---

<br />**POST /api/v1/dashboard/add**

## 概述
新建单个用户视图




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceDashboardUUID | string |  | 源视图ID<br>允许为空: False <br>允许空字符串: True <br>最大长度: 128 <br> |
| name | string | Y | 视图名称<br>允许为空: False <br>最大长度: 256 <br> |
| templateInfos | json |  | 自定义模板数据<br>例子: {} <br>允许为空: False <br>允许空字符串: False <br> |
| dashboardBidding | json |  | mapping, 默认为{}<br>例子: {} <br>允许为空: False <br> |

## 参数补充说明

**请求主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|name         |list |  视图名称 |
|dashboardBidding         |dict |   仪表板绑定的信息|
|sourceDashboardUUID         |string |  克隆 仪表板 或者 内置用户视图 的UUID|
|templateInfos         |dict |  克隆 内置系统视图 的模板信息 |

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
curl 'https://openapi.guance.com/api/v1/dashboard/add' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Accept-Language: zh' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Accept: application/json, text/plain, */*' \
--data-raw '{"name":"001绑定内置视图","dashboardBidding":{"service":[{"value":["*"],"op":"in"}],"app_id":[{"value":["test0"],"op":"wildcard"}],"label":[{"value":["勿删"],"op":"in"}]}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "chartGroupPos": [],
        "chartPos": [],
        "createAt": 1713513331,
        "createdWay": "manual",
        "creator": "wsak_a7c3e790436d448cb6bb10f884ce2217",
        "dashboardBidding": {
            "app_id": [
                {
                    "op": "wildcard",
                    "value": [
                        "test0"
                    ]
                }
            ],
            "label": [
                {
                    "op": "in",
                    "value": [
                        "勿删"
                    ]
                }
            ],
            "service": [
                {
                    "op": "in",
                    "value": [
                        "*"
                    ]
                }
            ]
        },
        "dashboardBindSet": [],
        "declaration": {
            "b": [
                "asfawfgajfasfafgafwba",
                "asfgahjfaf"
            ],
            "business": "aaa",
            "organization": "64fe7b4062f74d0007b46676"
        },
        "deleteAt": -1,
        "extend": {},
        "iconSet": {},
        "id": 5091,
        "isPublic": 1,
        "mapping": [],
        "name": "001绑定内置视图",
        "ownerType": "inner",
        "status": 0,
        "type": "CUSTOM",
        "updateAt": 1713513331,
        "updator": "wsak_a7c3e790436d448cb6bb10f884ce2217",
        "uuid": "dsbd_0512f5e6305f4ea0a69909f5e7bef772",
        "workspaceUUID": "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-2FB0228E-1660-4557-AF7B-688176108C28"
} 
```




