# 获取某个Issue的所有回复信息

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
curl 'https://openapi.guance.com/api/v1/issue/reply/issue_db6629a4e2cd4f92a95dae0d6d5b44ec/list?ordering=-createAt' \
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
            "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "creatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "deleteAt": -1,
            "extend": {},
            "id": 313186,
            "is_modify": false,
            "issueUUID": "issue_db6629a4e2cd4f92a95dae0d6d5b44ec",
            "latest_modify_time": 1690278285,
            "status": 0,
            "type": "change",
            "updateAt": 1690278285,
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://testing-static-res.cloudcare.cn/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "repim_1c64c840aaa84535aad95a73c9d7c0fd",
            "workspaceUUID": "wksp_63107158c47c47f78ec222f51e3defef"
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




