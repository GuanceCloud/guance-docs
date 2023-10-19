# 获取 SAML SSO 登录配置 列表

---

<br />**GET /api/v1/sso/saml_list**

## 概述
获取 SAML SSO 登录配置列表




## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/sso/saml_list' \
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
            "creator": "acnt_e52a5a7b6418464cb2acbeaa199e7fd1",
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
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "sso_7de25e969a714d7ab851a4cbf1263d50",
            "workspaceUUID": "wksp_66861dda6a6b4041ba9a50c50844c021"
        },
        {
            "createAt": 1697257231,
            "creator": "acnt_e52a5a7b6418464cb2acbeaa199e7fd1",
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
            "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
            "updatorInfo": {
                "acntWsNickname": "",
                "email": "88@qq.com",
                "iconUrl": "http://static.cloudcare.cn:10561/icon/acnt_349ee5f70a89442fa94b4f754b5acbfe.png",
                "name": "88测试",
                "username": "测试"
            },
            "uuid": "sso_98e73764a5144f41a2f5621120bff5b4",
            "workspaceUUID": "wksp_66861dda6a6b4041ba9a50c50844c021"
        }
    ],
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-4E238298-4DD2-4CA3-94A0-6F27F68F0C5F"
} 
```




