# 获取一个团队

---

<br />**GET /api/v1/workspace/member_group/get**

## 概述
获取一个团队




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| groupUUID | string |  | 团队UUID, 如果是新增获取成员信息,不传该值<br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member_group/get?groupUUID=group_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "groupMembers": [
            {
                "email": "xxx@<<< custom_key.brand_main_domain >>>",
                "name": "88测试",
                "uuid": "acnt_xxxx32"
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




