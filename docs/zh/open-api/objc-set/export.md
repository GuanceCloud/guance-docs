# 【对象分类配置】导出

---

<br />**GET /api/v1/objc_cfg/\{objc_name\}/export**

## 概述
导出对象分类配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| objc_name | string | Y | 对象分类配置名称<br> |


## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceType | string | Y | 来源类型, 默认值为`custom_object`<br>允许为空: False <br>可选值: ['object', 'custom_object'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg/test/export?sourceType=custom_object' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "main": [
            {
                "class": "custom_object",
                "source": {
                    "key": "test",
                    "name": "test"
                },
                "groupCfg": {
                    "name": "demo"
                },
                "filters": [],
                "table": {
                    "columns": [],
                    "detail": {
                        "views": [
                            {
                                "keys": {},
                                "title": "viewer",
                                "required": true,
                                "viewName": "NtpQ 监控视图",
                                "viewType": "dashboard",
                                "timerange": "default"
                            }
                        ]
                    }
                },
                "fields": [
                    {
                        "name": "name"
                    }
                ],
                "groups": [],
                "fills": []
            }
        ],
        "title": "test",
        "summary": "",
        "iconSet": null
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "1713254191261321318"
} 
```




