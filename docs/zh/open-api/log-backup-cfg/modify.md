# 修改单个数据转发规则

---

<br />**POST /api/v1/log_backup_cfg/\{cfg_uuid\}/modify**

## 概述
修改单个数据转发规则




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| cfg_uuid | string | Y | 配置uuid<br> |


## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| extend | json |  | 前端自定义数据<br>允许为空: True <br> |
| syncExtensionField | boolean |  | 同步备份扩展字段, true为同步, false不同步, 默认不同步<br>允许为空: False <br> |
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

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/log_backup_cfg/lgbp_20454675957b4337b9d953b089b2b06c/modify' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--data-raw '{"extend":{"filters":[],"filterLogic":"and"},"syncExtensionField":true,"accessCfg":{"cloudAccountId":"f000ee4d7327428da2f53a081e7109bd","bucket":"test-obs01","region":"cn-south-1","provider":"huawei"}}' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "conditions": "{}",
        "createAt": 1697613651,
        "creator": "xxx",
        "dataType": "tracing",
        "deleteAt": -1,
        "extend": {
            "filterLogic": "and",
            "filters": []
        },
        "externalResourceAccessCfgUUID": "erac_d22a3f47c12d4ae5bb37518702f4878a",
        "id": 686,
        "name": "temp_test",
        "status": 0,
        "storeType": "obs",
        "syncExtensionField": true,
        "taskErrorCode": "",
        "taskStatusCode": -1,
        "updateAt": 1697613856.5497322,
        "updator": "wsak_xxxxx",
        "uuid": "lgbp_20454675957b4337b9d953b089b2b06c",
        "workspaceUUID": "wksp_ed134a6485c8484dbd0e58ce9a9c6115"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-599A0794-3DD7-4731-BA2F-0A3655C09684"
} 
```




