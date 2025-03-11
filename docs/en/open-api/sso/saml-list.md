# Get SAML SSO Login Configuration List

---

<br />**GET /api/v1/sso/saml_list**

## Overview
Retrieve the list of SAML SSO login configurations


## Query Request Parameters

| Parameter Name | Type   | Required | Description               |
|:--------------|:-------|:--------|:-------------------------|
| type          | string |         | Type<br>Example: <br>Can be empty: False <br>Optional values: ['saml', 'oidc'] <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/saml_list' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```


## Response
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
            "idpName": "LWC Test SSO",
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
                "name": "88 Test",
                "username": "Test"
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
            "idpName": "LWC Test SSO",
            "isOpenSAMLMapping": 0,
            "memberCount": 0,
            "remark": "lwc test",
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
                "name": "88 Test",
                "username": "Test"
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