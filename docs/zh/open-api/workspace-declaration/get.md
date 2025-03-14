# 获取声明信息

---

<br />**GET /api/v1/workspace/declaration/get**

## 概述




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/workspace/declaration/get' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "子部门": "子部门1",
        "business": [
            "事业部",
            "产业一部"
        ],
        "declaration": null,
        "organization": "88"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-5E647E30-769E-419C-BE5B-348824B41A42"
} 
```




