# 修改单个绑定索引配置

---

<br />**POST /api/v1/external_log_index_cfg/\{cfg_uuid\}/modify**

## 概述
修改一个自定义存储绑定索引配置




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | 配置uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| exterStoreName | string | Y | 与name互为映射的外部存储的名字<br>允许为空: False <br> |
| accessCfg | json | Y | 外部资源访问配置信息<br>允许为空: False <br> |
| accessCfg.ak | string |  | 密钥Id<br>允许为空: False <br> |
| accessCfg.sk | string |  | 密钥<br>允许为空: False <br> |
| accessCfg.url | string |  | 链接地址<br>允许为空: False <br> |
| accessCfg.username | string |  | 用户名<br>允许为空: False <br> |
| accessCfg.password | string |  | 密码<br>允许为空: False <br> |
| fields | array |  | 待更新的字段映射配置列表<br>允许为空: False <br> |
| fields[*] | None |  | <br> |
| fields[*].field | string | Y | 字段名<br>例子: message <br>允许为空: False <br> |
| fields[*].originalField | string | Y | 原始字段名<br>例子: content <br>允许为空: False <br>允许空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/external_log_index_cfg/lgim_1145381480dd4a4f95bccdb1f0889141/modify' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"accessCfg":{"url":"aabb.com","username":"test33"},"exterStoreName":"aa_uuid","fields":[{"field":"time","originalField":"time"},{"field":"__docid","originalField":"__docid"},{"field":"message","originalField":"message"}]}' \
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
    "traceId": "TRACE-63EE56F5-8EFB-4FF9-994D-11848B6EFA80"
} 
```




