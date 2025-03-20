# 获取成员列表

---

<br />**GET /api/v1/workspace/members/list**

## 概述
列出当前工作空间中的所有成员




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 根据名称/邮箱搜索<br>例子: supper_workspace <br>允许为空: False <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br>$minValue: 1 <br>$maxValue: 100 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/members/list?pageIndex=1&pageSize=2' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1614149795,
            "creator": "extend",
            "deleteAt": -1,
            "email": "xxx@<<< custom_key.brand_main_domain >>>",
            "extend": {
                "user_icon": "acnt_xxxx32.png"
            },
            "exterId": "acnt-gtxSK4UrogwM3N2guGNGim",
            "id": 19,
            "mobile": "",
            "name": "测试",
            "nameSpace": "",
            "role": "owner",
            "status": 0,
            "updateAt": 1614149795,
            "updator": "external",
            "userIconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
            "userType": "common",
            "username": "xxx@<<< custom_key.brand_main_domain >>>",
            "uuid": "acnt_xxxx32",
            "waitAudit": 0
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 3,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-DA203788-B799-4BE2-9AB4-552047E01EED"
} 
```




