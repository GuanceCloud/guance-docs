# 获取 SAML SSO 登录配置 列表

---

<br />**GET /api/v1/sso/saml_list**

## 概述
获取 SAML SSO 登录配置列表




## Query 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string |  | 类型<br>例子:  <br>允许为空: False <br>可选值: ['saml', 'oidc'] <br> |

## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/saml_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```




## 响应
```shell
{
    "code": 200,
    "content": [
        {
            "createAt": 1697453127,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "id": 71,
            "idpMd5": "d178c9e1b52bd37bfa0595223439fec5",
            "idpName": "LWC测试SSO",
            "isOpenSAMLMapping": 1,
            "memberCount": 0,
            "remark": "",
            "role": "general",
            "status": 0,
            "tokenHoldTime": 10800,
            "tokenMaxValidDuration": 604800,
            "type": "saml-1",
            "updateAt": 1697627656,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "sso_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        },
        {
            "createAt": 1697257231,
            "creator": "acnt_xxxx32",
            "deleteAt": -1,
            "id": 49,
            "idpMd5": "d178c9e1b52bd37bfa0595223439fec5",
            "idpName": "LWC测试SSO",
            "isOpenSAMLMapping": 0,
            "memberCount": 0,
            "remark": "lwc测试",
            "role": "general",
            "status": 0,
            "tokenHoldTime": 10800,
            "tokenMaxValidDuration": 604800,
            "type": "saml-1",
            "updateAt": 1697625223,
            "updator": "acnt_xxxx32",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_xxxx32.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "sso_xxxx32",
            "workspaceUUID": "wksp_xxxx32"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E238298-4DD2-4CA3-94A0-6F27F68F0C5F"
} 
```




