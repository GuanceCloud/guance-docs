# 获取一个SAML配置信息

---

<br />**get /api/v1/sso/saml_get/\{sso_uuid\}**

## 概述
获取一个SAML配置信息




## 路由参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| sso_uuid | string | Y | sso配置项id<br> |


## 参数补充说明





## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/sso/saml_get/sso_dcbddede142844058fe64baed58ed580' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed \
--insecure
```




## 响应
```shell
{
    "code": 200,
    "content": {
        "assertionURL": "None/saml/assertion/sso_dcbddede142844058fe64baed58ed580",
        "createAt": 1678020614,
        "creator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "deleteAt": -1,
        "emails": [
            "qq.com"
        ],
        "entiryID": "None/saml/metadata.xml",
        "id": 7,
        "idpMd5": "54a3b7441fba3bdb555ae854745f576f",
        "idpName": "",
        "isOpenSAMLMapping": 0,
        "loginURL": "None/saml/login/sso_dcbddede142844058fe64baed58ed580",
        "metadataURL": "None/saml/metadata/sso_dcbddede142844058fe64baed58ed580",
        "remark": "",
        "role": "general",
        "status": 0,
        "tokenHoldTime": 1800,
        "tokenMaxValidDuration": 604800,
        "type": "saml-1",
        "updateAt": 1678020614,
        "updator": "acnt_349ee5f70a89442fa94b4f754b5acbfe",
        "uploadData": "<?xml version=\\\"1.0\\\" encoding=\\\"UTF-8\\\"?><md:EntityDescriptor entityID=\\\"http://www.okta.com/exk4snorvlVZsqus25d7\\\" xmlns:md=\\\"urn:oasis:names:tc:SAML:2.0:metadata\\\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\\\"false\\\" protocolSupportEnumeration=\\\"urn:oasis:names:tc:SAML:2.0:protocol\\\"><md:KeyDescriptor use=\\\"signing\\\"><ds:KeyInfo xmlns:ds=\\\"http://www.w3.org/2000/09/xmldsig#\\\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXy+xOGoMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMjYyMjQxMjZaFw0zMTEwMjYyMjQyMjZaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAKBt7aed/3A+gHtfmNSATeaaNo1LR/WPH9TIso3foT5dMXYRtlW57/YPNzBpii8+Gs/I6xL7\nkXzbRy9lnhpbBVTCLstWpuxYNr7zXuxICoSCW/b+5bYNkvKFmYd1dGkd0j7L8ZbHDKFzGkCS4a/D\nKUn6Ac/HlmML9GIOzPNyz514c6cAGd4zcpYiXFhlpzFLpElUOEedWVU4eZ48k91pPLf2guWpU/OD\nmKQisIOL5uqQqLsK1DXV+miSfB8Mm4jXSPLBE73mD7EfYidY1FQELqsrLshkXJGbhlkNnoEocCLH\nz9COzi9+jeecGvZGUw+l8hkxMsqH+0U3wM7ueVLMtgECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nUQrFTpRmneWUuok3L1CWgTeuwakErxB2NZtvpGkD5HrJE/eeyCEp81atOH6EU6mJamSLuFtJu5wl\nArV9c7lfFliArtg3+d0NM9mV/6E+RYn5ELDK44Qc3M1wkf4BhcQWNVUR4tiTIS3EeFVEdo1e/xqg\n2sqj7WE+6BMMae4mjmXzrQ57+a+WzWKjKQfIuVzdy2ss+8ZnOpiU+sntd1DwXKCl1jMlDYQi9NYU\nHKIqtVkLsv0ooOoXygw7t9PD8iLHBEzAsoAyON15oUIEw4mahstkOA14yERzQQyII3gilZeANebf\npkg8N9/m3HBhfHh65KpQTHh9MTU41Bcvf2KZRg==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService></md:IDPSSODescriptor></md:EntityDescriptor>",
        "uuid": "sso_dcbddede142844058fe64baed58ed580",
        "workspaceUUID": "wksp_8ea5c78a71e64298bffd4d3ec03f1a5f"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "TRACE-58D8B077-66A7-4C80-9748-46FD1E19000D"
} 
```



