# 删除一个智能巡检

---

<br />**POST /api/v1/self_built_checker/delete**

## 概述
根据`checker_uuid`删除自建巡检




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ruleUUID | string |  | 自建巡检的UUID<br>例子: rul_xxxxx <br>允许为空: False <br> |
| refKey | string |  | 自建巡检的关联key<br>例子: xxx <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/self_built_checker/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUID":"rule_xxx"}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": true,
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-0ABCD3FC-9441-4617-9301-A95299460890"
} 
```




