# 获取成员组列表

---

<br />**GET /api/v1/workspace/member_group/list**

## 概述
列出当前工作空间中的所有成员组




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| search | string |  | 成员组名称搜索<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "member_count": 1,
            "member_name_list": [
                "88测试"
            ],
            "name": "测试",
            "uuid": "group_1d6860295f6b4c5abd1f7b3e48a7ffbc"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-26F96A09-C4FC-434F-A818-6631AB72AD03"
} 
```




