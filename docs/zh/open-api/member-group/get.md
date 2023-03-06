# 获取一个成员组

---

<br />**get /api/v1/workspace/member_group/get**

## 概述
获取一个成员组




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| groupUUID | string |  | 成员组UUID, 如果是新增获取成员信息,不传该值<br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/get?groupUUID=group_1d6860295f6b4c5abd1f7b3e48a7ffbc' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "groupMembers": [
            {
                "email": "88@qq.com",
                "name": "88测试",
                "uuid": "acnt_349ee5f70a89442fa94b4f754b5acbfe"
            }
        ],
        "membersNotInGroup": []
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-A85FB294-8E44-4A00-ACE4-D91DCD2414D8"
} 
```




