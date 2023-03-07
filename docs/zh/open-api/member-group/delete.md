# 删除一个成员组

---

<br />**get /api/v1/workspace/member_group/\{group_uuid\}/delete**

## 概述
删除一个成员组




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| group_uuid | string | Y | 成员组<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/workspace/member_group/group_1d6860295f6b4c5abd1f7b3e48a7ffbc/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0D281839-1C53-42B1-8E67-915503DA495A"
} 
```




