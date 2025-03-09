# 删除数据转发规则

---

<br />**POST /api/v1/log_backup_cfg/batch_delete**

## 概述
数据转发规则删除




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfgUUIDs | array | Y | 转发配置UUID列表<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_backup_cfg/batch_delete' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"cfgUUIDs":["lgbp_xxxx32"]}' \
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
    "traceId": "15728475467540703196"
} 
```




