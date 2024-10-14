# 新建单个数据转发规则

---

<br />**POST /api/v1/log_backup_cfg/add**

## 概述
新建单个数据转发规则




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| name | string | Y | 规则名字<br>例子: xxx <br>允许为空: False <br> |
| extend | json |  | 前端自定义数据<br>允许为空: True <br> |
| syncExtensionField | boolean |  | 同步备份扩展字段, true为同步, false不同步, 默认不同步<br>允许为空: False <br> |
| storeType | string | Y | 存储类型<br>允许为空: False <br>可选值: ['guanceObject', 's3', 'obs', 'oss', 'kafka'] <br> |
| dataType | string |  | 数据类型<br>允许为空: False <br>可选值: ['logging', 'tracing', 'rum'] <br> |
| duration | string |  | 数据保留时长,<br>例子: 180d <br>可选值: ['180d', '360d', '720d'] <br> |
| accessCfg | json |  | 外部资源访问配置信息<br>允许为空: False <br> |
| accessCfg.provider | string |  | 供应商<br>允许为空: False <br>可选值: ['aliyun', 'aws', 'huawei'] <br> |
| accessCfg.grantType | string |  | 授权类型<br>允许为空: False <br>可选值: ['role', 'ram'] <br> |
| accessCfg.cloudAccountId | string |  | 云账号ID<br>允许为空: False <br> |
| accessCfg.bucket | string |  | 存储桶<br>允许为空: False <br> |
| accessCfg.externalId | string |  | 外部唯一标识ID(aws的角色授权方式中的外部唯一标识ID)<br>允许为空: False <br> |
| accessCfg.role | string |  | 角色名称<br>允许为空: False <br> |
| accessCfg.ak | string |  | 密钥Id<br>允许为空: False <br> |
| accessCfg.sk | string |  | 密钥<br>允许为空: False <br> |
| accessCfg.topic | string |  | topic<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.url | string |  | 链接地址(应用于 kafka)<br>允许为空: False <br> |
| accessCfg.securityProtocol | string |  | 安全协议(应用于 kafka)<br>允许为空: False <br>可选值: ['plaintext', 'sasl_plaintext', 'sasl_ssl'] <br> |
| accessCfg.ca | string |  | 客户端 ssl 证书内容<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.mechanism | string |  | 认证方式<br>允许为空: False <br>允许为空字符串: True <br>可选值: ['plain', 'scram-sha-256', 'scram-sha-512'] <br> |
| accessCfg.username | string |  | 用户名<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.password | string |  | 密码<br>允许为空: False <br>允许为空字符串: True <br> |
| accessCfg.region | string |  | 地域(可选值，如果不输入则默认取与当前站点相匹配的对应厂商地域)<br>允许为空: False <br> |
| accessCfg.bucketPath | string |  | 存储桶路径<br>允许为空: False <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_backup_cfg/add' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"extend":{"filters":[],"filterLogic":"and"},"syncExtensionField":true,"storeType":"obs","name":"temp_test","dataType":"tracing","accessCfg":{"cloudAccountId":"f000ee4d7327428da2f53a081e7109bd","bucket":"test-obs01-418d","region":"cn-south-1","provider":"huawei"}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "",
        "createAt": 1697613651,
        "creator": "xxx",
        "dataType": "tracing",
        "deleteAt": -1,
        "extend": {
            "filterLogic": "and",
            "filters": []
        },
        "externalResourceAccessCfgUUID": "erac_xxxx32",
        "id": null,
        "name": "temp_test",
        "status": 0,
        "storeType": "obs",
        "syncExtensionField": true,
        "taskErrorCode": "",
        "taskStatusCode": -1,
        "updateAt": 1697613651,
        "updator": "xxx",
        "uuid": "lgbp_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-31D4417B-2665-4CFA-9BC9-60BD6A540744"
} 
```




