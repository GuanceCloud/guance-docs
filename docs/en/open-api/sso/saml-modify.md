# Update SAML SSO Login Configuration

---

<br />**POST /api/v1/sso/saml_modify/\{sso_uuid\}**

## Overview
Update a SAML configuration information


## Route Parameters

| Parameter Name | Type   | Required | Description              |
|:--------------|:-------|:--------|:-------------------------|
| sso_uuid      | string | Y       | SSO configuration item ID <br> |


## Body Request Parameters

| Parameter Name  | Type   | Required | Description              |
|:---------------|:-------|:--------|:-------------------------|
| idpName        | string |         | Provider <br>Example: Default provider <br>Maximum length: 64 <br>$matchRegExp: [a-zA-Z_一-龥-]* <br> |
| idpData        | string |         | XML document content (required for SAML type) <br>Example:  <br>Allow empty: False <br> |
| config         | json   |         | Access configuration table (required for OIDC type) <br>Example:  <br>Allow empty: False <br> |
| emailDomains   | array  | Y       | Email domain <br>Example: ['jiagouyun.com', 'guance.com'] <br> |
| role           | string | Y       | Role <br>Allow empty: False <br>Optional values: ['general', 'readOnly'] <br> |
| remark         | string |         | Remarks <br>Allow empty: False <br>Allow empty string: True <br> |
| tokenHoldTime  | integer|         | Token hold duration, in seconds, default value 14400 <br>Allow empty: False <br>Allow empty string: False <br>$minValue: 1800 <br>$maxValue: 86400 <br> |
| tokenMaxValidDuration | integer|         | Token maximum validity period, in seconds, default value 604800 <br>Allow empty: False <br>Allow empty string: False <br>$minValue: 86400 <br>$maxValue: 604800 <br> |

## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/saml_modify/sso_xxxx32' \
-H 'DF-API-KEY: <DF-API-KEY>' \
-H 'Content-Type: application/json;charset=UTF-8' \
--data-raw '{"idpData":"<?xml version=\\\"1.0\\\" encoding=\\\"UTF-8\\\"?><md:EntityDescriptor entityID=\\\"http://www.okta.com/exk4snorvlVZsqus25d7\\\" xmlns:md=\\\"urn:oasis:names:tc:SAML:2.0:metadata\\\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\\\"false\\\" protocolSupportEnumeration=\\\"urn:oasis:names:tc:SAML:2.0:protocol\\\"><md:KeyDescriptor use=\\\"signing\\\"><ds:KeyInfo xmlns:ds=\\\"http://www.w3.org/2000/09/xmldsig#\\\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXy+xOGoMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMjYyMjQxMjZaFw0zMTEwMjYyMjQyMjZaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAKBt7aed/3A+gHtfmNSATeaaNo1LR/WPH9TIso3foT5dMXYRtlW57/YPNzBpii8+Gs/I6xL7\nkXzbRy9lnhpbBVTCLstWpuxYNr7zXuxICoSCW/b+5bYNkvKFmYd1dGkd0j7L8ZbHDKFzGkCS4a/D\nKUn6Ac/HlmML9GIOzPNyz514c6cAGd4zcpYiXFhlpzFLpElUOEedWVU4eZ48k91pPLf2guWpU/OD\nmKQisIOL5uqQqLsK1DXV+miSfB8Mm4jXSPLBE73mD7EfYidY1FQELqsrLshkXJGbhlkNnoEocCLH\nz9COzi9+jeecGvZGUw+l8hkxMsqH+0U3wM7ueVLMtgECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nUQrFTpRmneWUuok3L1CWgTeuwakErxB2NZtvpGkD5HrJE/eeyCEp81atOH6EU6mJamSLuFtJu5wl\nArV9c7lfFliArtg3+d0NM9mV/6E+RYn5ELDK44Qc3M1wkf4BhcQWNVUR4tiTIS3EeFVEdo1e/xqg\n2sqj7WE+6BMMae4mjmXzrQ57+a+WzWKjKQfIuVzdy2ss+8ZnOpiU+sntd1DwXKCl1jMlDYQi9NYU\nHKIqtVkLsv0ooOoXygw7t9PD8iLHBEzAsoAyON15oUIEw4mahstkOA14yERzQQyII3gilZeANebf\npkg8N9/m3HBhfHh65KpQTHh9MTU41Bcvf2KZRg==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService></md:IDPSSODescriptor></md:EntityDescriptor>","emailDomains":["guance.com"],"role":"general","remark":"","tokenHoldTime":1800,"tokenMaxValidDuration":604800}' \
--compressed 
```


## Response
```shell
{
    "code": 200,
    "content": {
        "createAt": 1678020614,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "id": 7,
        "idpMd5": "54a3b7441fba3bdb555ae854745f576f",
        "idpName": "",
        "isOpenSAMLMapping": 0,
        "remark": "",
        "role": "general",
        "status": 0,
        "tokenHoldTime": 1800,
        "tokenMaxValidDuration": 604800,
        "type": "saml-1",
        "updateAt": 1678020877.5301163,
        "updator": "acnt_xxxx32",
        "uploadData": "<?xml version=\"1.0\" encoding=\"UTF-8\"?><md:EntityDescriptor entityID=\"http://www.okta.com/exk4snorvlVZsqus25d7\" xmlns:md=\"urn:oasis:names:tc:SAML:2.0:metadata\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\"false\" protocolSupportEnumeration=\"urn:oasis:names:tc:SAML:2.0:protocol\"><md:KeyDescriptor use=\"signing\"><ds:KeyInfo xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXy+xOGoMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMjYyMjQxMjZaFw0zMTEwMjYyMjQyMjZaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAKBt7aed/3A+gHtfmNSATeaaNo1LR/WPH9TIso3foT5dMXYRtlW57/YPNzBpii8+Gs/I6xL7\nkXzbRy9lnhpbBVTCLstWpuxYNr7zXuxICoSCW/b+5bYNkvKFmYd1dGkd0j7L8ZbHDKFzGkCS4a/D\nKUn6Ac/HlmML9GIOzPNyz514c6cAGd4zcpYiXFhlpzFLpElUOEedWVU4eZ48k91pPLf2guWpU/OD\nmKQisIOL5uqQqLsK1DXV+miSfB8Mm4jXSPLBE73mD7EfYidY1FQELqsrLshkXJGbhlkNnoEocCLH\nz9COzi9+jeecGvZGUw+l8hkxMsqH+0U3wM7ueVLMtgECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nUQrFTpRmneWUuok3L1CWgTeuwakErxB2NZtvpGkD5HrJE/eeyCEp81atOH6EU6mJamSLuFtJu5wl\nArV9c7lfFliArtg3+d0NM9mV/6E+RYn5ELDK44Qc3M1wkf4BhcQWNVUR4tiTIS3EeFVEdo1e/xqg\n2sqj7WE+6BMMae4mjmXzrQ57+a+WzWKjKQfIuVzdy2ss+8ZnOpiU+sntd1DwXKCl1jMlDYQi9NYU\nHKIqtVkLsv0ooOoXygw7t9PD8iLHBEzAsoAyON15oUIEw4mahstkOA14yERzQQyII3gilZeANebf\npkg8N9/m3HBhfHh65KpQTHh9MTU41Bcvf2KZRg==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\" Location=\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\"/><md:SingleSignOnService Binding=\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\" Location=\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\"/></md:IDPSSODescriptor></md:EntityDescriptor>",
        "uuid": "sso_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "5246429743533759438"
} 
```