# 请求示例

---

本文列举了部分 Open API 的请求示例。 


## GET 请求

### 以获取仪表板列表接口为例
请求如下
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

响应结果如下:
```bash
{
    "code":200,
    "content":[
        {Object}
    ],
    "errorCode":"",
    "message":"",
    "pageInfo":{
        "count":10,
        "pageIndex":1,
        "pageSize":10,
        "totalCount":836
    },
    "success":true,
    "traceId":"1749091119335873001"
}
```

## POST 请求

### 以删除仪表板接口为例
请求如下
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/${dashboard_uuid}/delete" \
  -X "POST" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

响应结果如下:
```bash
{
    "code":200,
    "content":true,
    "errorCode":"",
    "message":"",
    "success":true,
    "traceId":"4250149955169518608"
}
```



## 说明

${DF_API_KEY}：  表示调用者 API KEY，获取方式见[API Key 管理](../management/api-key/open-api.md)