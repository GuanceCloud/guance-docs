# 批量自建巡检

---

<br />**post /api/v1/self_built_checker/batch_delete**

## 概述
根据`checker_uuid`删除自建巡检




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| ruleUUIDs | array |  | 自建巡检的UUID<br>例子: rul_xxxxx <br>允许为空: False <br> |
| refKey | string |  | 自建巡检的关联key<br>例子: xxx <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/self_built_checker/batch_delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"ruleUUIDs":["rul_8abfbf9a9a5a487aa4ba0cf90bf9d635","rul_8f2b0c759f3c47cc86e0e4ca042ca35a"]}' \
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



