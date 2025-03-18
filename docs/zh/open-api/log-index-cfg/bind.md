# 创建单个绑定索引配置

---

<br />**POST /api/v1/log_index_cfg/bind**

## 概述
创建一个自定义存储绑定索引




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| extend | json |  | 前端自定义数据<br>允许为空: True <br> |
| name | string | Y | 索引名字<br>例子: xxx <br>允许为空: False <br> |
| storeType | string | Y | 存储类型<br>例子: xxx <br>允许为空: False <br> |
| exterStoreName | string | Y | 与name互为映射的外部存储的名字(SLS 类型对应 StoreName, 火山云的TLS对应 topic_name)<br>允许为空: False <br> |
| exterStoreProject | string |  | 外部存储索引对应的project(SLS类型对应 StoreProject, 火山云的TLS对应 project_name)<br>允许为空: False <br> |
| region | string |  | 指定外部资源的地域<br>允许为空: False <br> |
| isPublicNetworkAccess | boolean |  | 是否公网访问, storeType 为 sls 时生效, 默认为 False(2024-07-10迭代添加)<br>允许为空: True <br> |
| accessCfg | json | Y | 外部资源访问配置信息<br>允许为空: False <br> |
| accessCfg.ak | string |  | 密钥Id<br>允许为空: False <br> |
| accessCfg.sk | string |  | 密钥<br>允许为空: False <br> |
| accessCfg.url | string |  | 链接地址<br>允许为空: False <br> |
| accessCfg.username | string |  | 用户名<br>允许为空: False <br> |
| accessCfg.password | string |  | 密码<br>允许为空: False <br> |
| accessCfg.iamProjectName | string |  | 火山云TLS的 iam_project_name<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.iamProjectDisplayName | string |  | 火山云TLS的 iam_project_name 的显示名<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.projectId | string |  | 火山云TLS project_id<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.topicId | string |  | 火山云TLS topic_id<br>允许为空: False <br>允许为空字符串: True <br> |
| fields | array |  | 待更新的字段映射配置列表<br>允许为空: False <br> |
| fields[*] | None |  | <br> |
| fields[*].field | string | Y | 字段名<br>例子: message <br>允许为空: False <br> |
| fields[*].originalField | string | Y | 原始字段名<br>例子: content <br>允许为空: False <br>允许为空字符串: True <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/log_index_cfg/bind' \
  -H 'Content-Type: application/json' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  --data-raw '{"accessCfg":{"url":"aa.com","password":"test","username":"test"},"exterStoreName":"aa_uuid","fields":[{"field":"time","originalField":"time"},{"field":"__docid","originalField":"__docid"},{"field":"message","originalField":"message"}],"storeType":"es","name":"openapi_test"}' \
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
    "traceId": "TRACE-31E0802B-E53A-4D9B-8FD7-57A0CA4C2D66"
} 
```




