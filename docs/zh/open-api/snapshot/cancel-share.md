# 取消快照/图表分享

---

<br />**GET /api/v1/share_config/delete**

## 概述
根据`share_uuid`删除指定的快照或者图表分享




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| shareConfigUUIDs | commaArray | Y | 分享配置UUID<br>允许为空: False <br>允许为空字符串: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/share_config/delete?shareConfigUUIDs=share_xxxx32,share_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
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
    "traceId": "TRACE-43A558A0-F157-4D00-8546-26DB8F0AFF09"
} 
```




