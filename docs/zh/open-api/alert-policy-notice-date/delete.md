# 告警策略-自定义通知日期 删除

---

<br />**POST /api/v1/notice/date/delete**

## 概述
告警策略-自定义通知日期 删除




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| noticeDatesUUIDs | array | Y | 告警策略-自定义通知日期的UUID<br>允许为空: False <br> |
| skipRefCheck | boolean |  | 是否跳过(告警策略)关联关系检测, 默认False, 进行检测,<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/notice/date/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"noticeDatesUUIDs": ["ndate_xxxx32", "ndate_xxxx32", "ndate_xxxx32"]}' \
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
    "traceId": "TRACE-E5C523B2-8CF1-4A37-A587-33C21C74DB26"
} 
```




