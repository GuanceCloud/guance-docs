# 创建一个事件

---

<br />**POST /api/v1/events/create**

## 概述
创建一个事件并指定事件内容, 通过该接口写入的事件其`df_source=custom`




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| date | integer | Y | 事件时间。Unix 时间戳，单位:毫秒<br>允许为空: False <br> |
| status | string | Y | 事件状态（可选项：critical/error/warning/ok/info/nodata）<br>允许为空: False <br>可选值: ['critical', 'error', 'warning', 'ok', 'info', 'nodata'] <br> |
| title | string | Y | 事件标题<br>允许为空: False <br> |
| message | string |  | 事件详细描述<br>允许为空: False <br> |
| origin | string |  | 事件来源<br>允许为空: False <br> |
| customTags | json |  | 用户自定义字段事件<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/events/create' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw $'{"date":1668141576000,"status":"info","title":"测试自定义事件01","message":"测试自定义事件-message","customTags":{"server":"自定义服务"}}' \
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
    "traceId": "TRACE-5EB2700B-52BF-40D7-A547-90FB7EC855DD"
} 
```




