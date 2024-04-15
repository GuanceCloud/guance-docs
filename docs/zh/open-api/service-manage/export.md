# 【服务清单】导出

---

<br />**GET /api/v1/service_manage/export**

## 概述
服务清单导出




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| originStr | string |  | 原始字符串传1, 结构化数据传0, 默认为1<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/export?originStr=0' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -o 'serviceInfo.json'
  --compressed
```




## 响应
```shell
[
    {
        "colour": "#40C922",
        "createAt": 1693798688,
        "createType": "openapi",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "阿里云监控数据源",
            "username": "xxx"
        },
        "dfStatus": "ok",
        "isFavorite": false,
        "service": "test_02",
        "serviceCatelog": {
            "Docs": [
                {
                    "link": "https://www.docs.guance.com",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://func.guance.com/doc",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Related": {
                "AppId": "a138bcb0_47ef_11ee_9d75_31ea50b9d85a",
                "DashboardUUIDs": [
                    "dsbd_b7ded4391b5e497ba7112d81a922d14d"
                ],
                "Tags": [
                    "test"
                ]
            },
            "Repos": [
                {
                    "link": "https://www.guance.com",
                    "name": "guance",
                    "provider": "guanceyun"
                },
                {
                    "link": "https://func.guance.com",
                    "name": "func",
                    "provider": "guanceyun"
                }
            ],
            "Team": {
                "colour": "#40C922",
                "oncall": [
                    {
                        "emails": [
                            "test1@guance.com",
                            "test3@guance.com"
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
                "service": "test_02",
                "team": "group_a8caea614b2644549557b476cf2d946c",
                "type": "db"
            }
        },
        "type": "db",
        "updateAt": 1693805504,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "xxx",
            "iconUrl": "",
            "name": "阿里云监控数据源",
            "username": "xxx"
        },
        "uuid": "sman_eb3e3c7acaef4d53acab866b83410edb"
    },
    {
        "colour": "",
        "createAt": 1693728357,
        "createType": "manual",
        "creatorInfo": {
            "acntWsNickname": "",
            "email": "test@jiagouyun.com",
            "iconUrl": "",
            "name": "test",
            "username": "test@jiagouyun.com"
        },
        "dfStatus": "ok",
        "isFavorite": false,
        "service": "test-lml3",
        "serviceCatelog": {
            "Team": {
                "colour": "",
                "oncall": [],
                "service": "test-lml3",
                "team": "",
                "type": "custom"
            }
        },
        "type": "custom",
        "updateAt": 1693728357,
        "updatorInfo": {
            "acntWsNickname": "",
            "email": "test@jiagouyun.com",
            "iconUrl": "",
            "name": "test",
            "username": "test@jiagouyun.com"
        },
        "uuid": "sman_cb24ea0f1c694db08bfa6ee8afb05914"
    }
] 
```




