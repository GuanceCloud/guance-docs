# Request Examples

---

This article lists some request examples for Open API.

## GET Request

### Example of Getting the Dashboard List Interface
Request as follows:
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/list?pageIndex=1&pageSize=10" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response result as follows:
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

## POST Request

### Example of Deleting a Dashboard Interface
Request as follows:
```bash
curl "https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/dashboards/${dashboard_uuid}/delete" \
  -X "POST" \
  -H "Content-Type: application/json" \
  -H "DF-API-KEY: ${DF_API_KEY}" \
  --compressed \
  --insecure
```

Response result as follows:
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


## Notes

${DF_API_KEY}: Represents the caller's API KEY. For obtaining methods, see [API Key Management](../management/api-key/open-api.md)