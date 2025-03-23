# Issue-回复 列出

---

<br />**GET /api/v1/issue/reply/\{issue_uuid\}/list**

## 概述




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| issue_uuid | string | Y | issueUUID<br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ordering | string |  | 排序方式 ordering=-createAt<br>允许为空: False <br> |
| pageSize | integer |  | 每页返回数量<br>允许为空: False <br>例子: 10 <br> |
| pageIndex | integer |  | 页码<br>允许为空: False <br>例子: 10 <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/issue/reply/issue_xxxx32/list?ordering=-createAt' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "attachmentsList": [],
            "content": "成员创建了Issue。",
            "createAt": 1690278285,
            "creator": "acnt_xxxx32",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_xxxx32.png",
                "name": "88测试",
                "username": "测试"
            },
            "deleteAt": -1,
            "extend": {},
            "id": 313186,
            "is_modify": false,
            "issueUUID": "issue_xxxx32",
            "latest_modify_time": 1690278285,
            "status": 0,
            "type": "change",
            "updateAt": 1690278285,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_xxxx32.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "repim_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "pageInfo": {
        "count": 1,
        "pageIndex": 1,
        "pageSize": 10,
        "totalCount": 1
    },
    "success": true,
    "traceId": "TRACE-463593F6-6084-4675-8EB5-F138D579EA0A"
} 
```




