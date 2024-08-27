# 【自定义映射规则】批量删除映射配置

---

<br />**POST /api/v1/login_mapping/field/batch_delete**

## 概述




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| lgmpUUIDs | array | Y | 映射配置UUID列表<br>例子: ['fdmp_xxx1', 'fdmp_xxx2'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/login_mapping/field/batch_delete' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"lgmpUUIDs": ["lgmp_xxxx32"]}' \
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
    "traceId": "16237433115105312000"
} 
```




