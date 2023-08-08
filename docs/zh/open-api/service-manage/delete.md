# 【服务清单】删除

---

<br />**POST /api/v1/service_manage/delete**

## 概述
删除服务清单配置




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| serviceUUIDs | array | Y | 服务列表<br>例子: ['ss', 'yy'] <br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/service_manage/delete' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-binary '{"serviceUUIDs":["sman_d4d1a628710240548bef465b8ca2613e", "sman_e8d40b472407428896f2c769af41fcfd"]}' \
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
    "traceId": "TRACE-83ED9066-842A-41E4-B693-5B8C98BD4FEC"
} 
```




