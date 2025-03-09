# 【对象分类配置】删除

---

<br />**POST /api/v1/objc_cfg/delete**

## 概述
删除对象分类配置




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sourceType | string | Y | 来源类型, 默认值为`custom_object`<br>允许为空: False <br>可选值: ['custom_object'] <br> |
| objc_name | string | Y | 对象分类配置名称<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/objc_cfg_template/delete' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"sourceType":"custom_object","objc_name":"test"}' \
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
    "traceId": "15398639142845104508"
} 
```




