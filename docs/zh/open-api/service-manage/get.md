# 【服务清单】获取

---

<br />**GET /api/v1/service_manage/\{service_uuid\}/get**

## 概述
获取单个服务清单信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| service_uuid | string | Y | 服务对应的uuid<br>例子: xxxx <br>允许为空字符串: False <br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| originStr | string |  | 原始字符串传1, 结构化数据传0, 默认为1<br>允许为空: False <br> |

## 参数补充说明


**请求主体结构说明**

|  参数名        |   type  | 必选  |          说明          |
|---------------|----------|----|------------------------|
| service_uuid    |  string  |  Y | 服务清单的唯一uuid, 前缀为 sman_ |
| originStr |  string  |  N | 是否需要返回的 serviceCatelog 为原始字符串, 1为是, 0为否. 默认为1 |

**响应主体结构说明**

|  参数名                |   type  |          说明          |
|-----------------------|----------|------------------------|
|serviceCatelog         |string,dict |  服务清单的原始字符串或者结构化数据 |
|service         |string |  服务名称 |
|type         |string |  服务类型 |




## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/service_manage/sman_xxxx32/get?originStr=0' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "colour": "#40C9C9",
        "createAt": 1693798688,
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "阿里云监控数据源",
            "username": "xxx"
        },
        "service": "test",
        "serviceCatelog": {
            "Docs": [
                {
                    "link": "https://www.docs.guance.com",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://<<< custom_key.func_domain >>>/doc",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Related": {
                "AppId": "a138bcb0_47ef_11ee_9d75_31ea50b9d85a",
                "DashboardUUIDs": [
                    "dsbd_xxxx32",
                    "dsbd_xxxx32"
                ],
                "Tags": [
                    "mysql",
                    "test"
                ]
            },
            "Repos": [
                {
                    "link": "https://<<< custom_key.brand_main_domain >>>",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://<<< custom_key.func_domain >>>",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Team": {
                "colour": "#40C9C9",
                "oncall": [
                    {
                        "emails": [
                            "test1@guance.com",
                            "test2@guance.com"
                        ],
                        "name": "guanceyun",
                        "type": "email"
                    },
                    {
                        "mobiles": [
                            "xxxxxxx5786",
                            "xxxxxxx4231"
                        ],
                        "name": "zhuyun",
                        "type": "mobile"
                    },
                    {
                        "name": "test",
                        "slack": "#test",
                        "type": "slack"
                    }
                ],
                "service": "jinlei_1",
                "team": "group_xxxx32",
                "type": "db"
            }
        },
        "type": "db",
        "updateAt": 1693798688,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "阿里云监控数据源",
            "username": "xxx"
        },
        "uuid": "sman_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-1255F7E2-9035-4696-B7EE-9DDBB2BC13D2"
} 
```




