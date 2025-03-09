# 删除一个/多个成员

---

<br />**POST /api/v1/workspace/member/batch_delete**

## 概述
删除一个/多个成员




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| accountUUIDs | array | Y | 账号列表<br>例子: ['xxx', 'xxx'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/member/batch_delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accountUUIDs": ["acnt_xxxx32"]}' \
--compressed 
```




## 响应
```shell
{
    "code": 200,
    "content": null,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-598B9B3D-B612-49F2-B3A9-92013D91BB0D"
} 
```




