# Add SAML SSO Login Configuration

---

<br />**POST /api/v1/sso/saml_create**

## Overview
Enable a SAML configuration.

## Body Request Parameters

| Parameter Name | Type   | Required | Description |
|:--------------|:-------|:--------|:------------|
| type | string | Y | Type<br>Example: <br>Allow empty: False <br>Optional values: ['saml', 'oidc'] <br> |
| idpData | string | Y | XML document content (required for SAML type)<br>Example: <br>Allow empty: False <br> |
| config | json |  | Access configuration table (required for OIDC type)<br>Example: <br>Allow empty: False <br> |
| emailDomains | array | Y | Email domain names<br>Example: ['jiagouyun.com', 'guance.com'] <br> |
| idpName | string | Y | Provider<br>Example: Default provider <br>Maximum length: 64 <br>$matchRegExp: [a-zA-Z_一-龥-]* <br> |
| role | string | Y | Role<br>Allow empty: False <br>Optional values: ['general', 'readOnly'] <br> |
| remark | string |  | Remarks<br>Allow empty: False <br>Allow empty string: True <br> |
| tokenHoldTime | integer |  | Token retention duration, in seconds, default value 14400<br>Allow empty: False <br>Allow empty string: False <br>$minValue: 1800 <br>$maxValue: 86400 <br> |
| tokenMaxValidDuration | integer |  | Maximum validity period of the token, in seconds, default value 604800<br>Allow empty: False <br>Allow empty string: False <br>$minValue: 86400 <br>$maxValue: 604800 <br> |

## Additional Parameter Explanation

*OIDC Type Config Explanation*

--------------
When `type='oidc'`, the `config` field is effective. The data structure information is as follows:
<br/>
1. Explanation of the `config` field

| Parameter Name | Type  | Required | Default Value | Description |
|---------------|----------|----|-----|-----------------------|
| modeType     | enum  |   | easy  | Configuration file editing mode. Optional values:<br/> easy: Simple UI editing mode. In this mode, users only need to configure the basic data required by the OIDC interaction protocol; other data are set to default values.<br/>expert: Expert configuration file mode, requiring users to upload an OIDC configuration file. This mode supports user-defined request information in the OIDC protocol. |
| wellKnowURL | string  |  Y |   | Standard service discovery address in the OIDC protocol.<br/> [For example, Microsoft AAD](https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration)|
| clientId    | string  |  Y |   | Client ID created by the authentication service for «<<< custom_key.brand_name >>>» |
| clientSecret    | string  |  Y |    | Secret key corresponding to the client ID created by the authentication service for «<<< custom_key.brand_name >>>» |
| sslVerify    | boolean  |   |    | Whether SSL verification is enforced when requesting service discovery configuration information;<br/> Defaults based on the protocol address of the wellKnowURL parameter, if it is https, then defaults to true; otherwise, defaults to false |
| grantType    | string  |  Y | authorization_code   | Grant type created by the authentication service for «<<< custom_key.brand_name >>>» |
| scope    | array  |  Y | ["openid", "email"]   | Data access permissions<br/>Required value: openid<br/>Other optional values, such as profile, email<br/>This depends on the scopes allocated by the authentication service for «<<< custom_key.brand_name >>>» |
| authSet    | dict  |   |    | Configuration serving the OIDC protocol's authentication request URL.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest) |
| getTokenSet    | dict  |   |    | Configuration serving the OIDC protocol's code-to-token request.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#TokenRequest) |
| verifyTokenSet    | dict  |   |    | ID_token validation configuration.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation), [jwks_urls data structure protocol source](https://datatracker.ietf.org/doc/html/rfc7515)|
| getUserInfoSet    | dict  |   |    | Configuration serving the OIDC protocol's user information request.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo) |
| claimMapping    | dict  |   |    | Field mapping configuration for user information/id_token. Used by «<<< custom_key.brand_name >>>» to obtain corresponding information from the account based on this mapping configuration |

<br/>
2. Internal structure parameter explanation of `config.authSet`

| Parameter Name | Type  | Required | Default Value | Description |
| :------------ | :------------ | :-----| :---------- | :------------ |
| url | string  |   |   | Authentication request URL.<br/>If not provided, it defaults to the `authorization_endpoint` value pointed to by wellKnowURL configuration |
| verify | boolean  |   |   | Whether SSL verification is enabled for this request; if not specified, it defaults to true if the URL uses the https protocol, otherwise it defaults to false. |
| paramMapping | dict  |   |   | Mapping of request parameter fields, generally used by non-standard OIDC clients to adjust relevant parameter fields according to their own authentication process. Detailed explanation below |

<br/>
3. Internal structure parameter explanation of `config.getTokenSet`

| Parameter Name | Type  | Required | Default Value | Description |
| :------------ | :------------ | :-----| :---------- | :------------ |
| url | string  |   |   | Code-to-token request URL.<br/>If not provided, it defaults to the `token_endpoint` value pointed to by wellKnowURL configuration |
| method | enum  |   | post | Request method, options: post, get |
| verify | boolean  |   |   | Whether SSL verification is enabled for this request; if not specified, it defaults to true if the URL uses the https protocol, otherwise it defaults to false. |
| authMethod | enum  |   | basic  | Signature data location and method. Options:<br/>client_secret_basic or basic: Authentication information is located in the Authorization header of the request, using basic authentication<br/>client_secret_post: client_id and client_secret are located in the body<br/>none: client_id and client_secret are located in the query |
| paramMapping | dict  |   |   | Mapping of request parameter fields, generally used by non-standard OIDC clients to adjust relevant parameter fields according to their own authentication process. Detailed explanation below |

<br/>
4. Internal structure parameter explanation of `config.verifyTokenSet`

| Parameter Name | Type  | Required | Default Value | Description |
| :------------ | :------------ | :-----| :---------- | :------------ |
| url | string  |   |   | Code-to-token request URL.<br/>If not provided, it defaults to the `token_endpoint` value pointed to by wellKnowURL configuration |
| verify | boolean  |   |   | Whether SSL verification is enabled for this request; if not specified, it defaults to true if the URL uses the https protocol, otherwise it defaults to false. |
| keys | array  |   |   | JWT algorithm data information pointed to by the URL<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation), [jwks_urls data structure protocol source](https://datatracker.ietf.org/doc/html/rfc7515)|

<br/>
5. Internal structure parameter explanation of `config.getUserInfoSet`

| Parameter Name | Type  | Required | Default Value | Description |
| :------------ | :------------ | :-----| :---------- | :------------ |
| source | enum  |   | id_token | Method of obtaining user information. Options:<br/>id_token: Parsed from id_token<br/>origin: Obtained by calling the authentication service interface |
| url | string  |   |   | User information request URL.<br/>If not provided, it defaults to the `userinfo_endpoint` value pointed to by wellKnowURL configuration. Valid when source=origin |
| verify | boolean  |   |   | Whether SSL verification is enabled for this request; if not specified, it defaults to true if the URL uses the https protocol, otherwise it defaults to false. |
| method | enum  |   | post | Request method, options: post, get; valid when source=origin |
| authMethod | enum  |   | bearer  | Signature data location and method. Options:<br/>bearer: HTTP Bearer authentication<br/>client_secret_basic or basic: Authentication information is located in the Authorization header of the request, using basic authentication<br/>client_secret_post: client_id and client_secret are located in the body<br/>none: client_id and client_secret are located in the query |
| paramMapping | dict  |   |   | Mapping of request parameter fields, generally used by non-standard OIDC clients to adjust relevant parameter fields according to their own authentication process. Detailed explanation below |

<br/>
6. Internal structure parameter explanation of `config.claimMapping`

| Parameter Name | Type  | Required | Default Value | Description |
| :------------ | :------------ | :-----| :---------- | :------------ |
| email | string  | Y  | email | Represents the user's email field |
| username | string  | Y | preferred_username  | Represents the user's username field |
| mobile | string  |   |   | User's phone number |

<br/>
7. Internal structure parameter explanation of `paramMapping` in `getTokenSet`, `getUserInfoSet` configurations
Note: When `paramMapping` exists, it directly follows the custom request parameter flow.

| Parameter Name | Type  | Required | Default Value | Description |
| :------------ | :------------ | :-----| :---------- | :------------ |
| client_id | string  |   | $client_id | Client ID, corresponding to the `client_id` in the protocol |
| scope | string  |   | $scope | Data scope. Space-separated string of data scopes;<br/>Note: This is the scope in the request parameters, different from the external configuration's scope which is an array type;<br/>Here, the scope as a request parameter is a string type.<br/>For example: "openid email profile" |
| code | string  |   | $code | Code passed by the authentication service for token exchange |
| state | string  |   | $state | Similar to CSRF functionality |
| redirect_uri | string  |   | $redirect_uri | Redirect URI where the response will be sent to. |
| response_type | string  |   | $response_type | Response type, value for authorization code flow is code |

## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/sso/saml_create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"idpData":"<?xml version=\\\"1.0\\\" encoding=\\\"UTF-8\\\"?><md:EntityDescriptor entityID=\\\"http://www.okta.com/exk4snorvlVZsqus25d7\\\" xmlns:md=\\\"urn:oasis:names:tc:SAML:2.0:metadata\\\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\\\"false\\\" protocolSupportEnumeration=\\\"urn:oasis:names:tc:SAML:2.0:protocol\\\"><md:KeyDescriptor use=\\\"signing\\\"><ds:KeyInfo xmlns:ds=\\\"http://www.w3.org/2000/09/xmldsig#\\\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXy+xOGoMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMjYyMjQxMjZaFw0zMTEwMjYyMjQyMjZaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAKBt7aed/3A+gHtfmNSATeaaNo1LR/WPH9TIso3foT5dMXYRtlW57/YPNzBpii8+Gs/I6xL7\nkXzbRy9lnhpbBVTCLstWpuxYNr7zXuxICoSCW/b+5bYNkvKFmYd1dGkd0j7L8ZbHDKFzGkCS4a/D\nKUn6Ac/HlmML9GIOzPNyz514c6cAGd4zcpYiXFhlpzFLpElUOEedWVU4eZ48k91pPLf2guWpU/OD\nmKQisIOL5uqQqLsK1DXV+miSfB8Mm4jXSPLBE73mD7EfYidY1FQELqsrLshkXJGbhlkNnoEocCLH\nz9COzi9+jeecGvZGUw+l8hkxMsqH+0U3wM7ueVLMtgECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nUQrFTpRmneWUuok3L1CWgTeuwakErxB2NZtvpGkD5HrJE/eeyCEp81atOH6EU6mJamSLuFtJu5wl\nArV9c7lfFliArtg3+d0NM9mV/6E+RYn5ELDK44Qc3M1wkf4BhcQWNVUR4tiTIS3EeFVEdo1e/xqg\n2sqj7WE+6BMMae4mjmXzrQ57+a+WzWKjKQfIuVzdy2ss+8ZnOpiU+sntd1DwXKCl1jMlDYQi9NYU\nHKIqtVkLsv0ooOoXygw7t9PD8iLHBEzAsoAyON15oUIEw4mahstkOA14yERzQQyII3gilZeANebf\npkg8N9/m3HBhfHh65KpQTHh9MTU41Bcvf2KZRg==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService></md:IDPSSODescriptor></md:EntityDescriptor>","emailDomains":["qq.com"],"role":"general","remark":"","tokenHoldTime":1800,"tokenMaxValidDuration":604800}' \
  --compressed \
  --insecure
```

## Response
```shell
{
    "code": 200,
    "content": {
        "assertionURL": "http://testing-ft2x-auth.cloudcare.cn/saml/assertion/sso_xxxx32",
        "createAt": 1678020614,
        "creator": "acnt_xxxx32",
        "deleteAt": -1,
        "emails": [
            "qq.com"
        ],
        "entiryID": "http://testing-ft2x-auth.cloudcare.cn/saml/metadata.xml",
        "id": null,
        "idpMd5": "54a3b7441fba3bdb555ae854745f576f",
        "idpName": null,
        "isOpenSAMLMapping": 0,
        "loginURL": "http://testing-ft2x-auth.cloudcare.cn/saml/login/sso_xxxx32",
        "metadataURL": "http://testing-ft2x-auth.cloudcare.cn/saml/metadata/sso_xxxx32",
        "remark": "",
        "role": "general",
        "status": 0,
        "tokenHoldTime": 1800,
        "tokenMaxValidDuration": 604800,
        "type": "saml-1",
        "updateAt": 1678020614,
        "updator": "acnt_xxxx32",
        "uploadData": "<?xml version=\\\"1.0\\\" encoding=\\\"UTF-8\\\"?><md:EntityDescriptor entityID=\\\"http://www.okta.com/exk4snorvlVZsqus25d7\\\" xmlns:md=\\\"urn:oasis:names:tc:SAML:2.0:metadata\\\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\\\"false\\\" protocolSupportEnumeration=\\\"urn:oasis:names:tc:SAML:2.0:protocol\\\"><md:KeyDescriptor use=\\\"signing\\\"><ds:KeyInfo xmlns:ds=\\\"http://www.w3.org/2000/09/xmldsig#\\\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXy+xOGoMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMjYyMjQxMjZaFw0zMTEwMjYyMjQyMjZaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAKBt7aed/3A+gHtfmNSATeaaNo1LR/WPH9TIso3foT5dMXYRtlW57/YPNzBpii8+Gs/I6xL7\nkXzbRy9lnhpbBVTCLstWpuxYNr7zXuxICoSCW/b+5bYNkvKFmYd1dGkd0j7L8ZbHDKFzGkCS4a/D\nKUn6Ac/HlmML9GIOzPNyz514c6cAGd4zcpYiXFhlpzFLpElUOEedWVU4eZ48k91pPLf2guWpU/OD\nmKQisIOL5uqQqLsK1DXV+miSfB8Mm4jXSPLBE73mD7EfYidY1FQELqsrLshkXJGbhlkNnoEocCLH\nz9COzi9+jeecGvZGUw+l8hkxMsqH+0U3wM7ueVLMtgECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nUQrFTpRmneWUuok3L1CWgTeuwakErxB2NZtvpGkD5HrJE/eeyCEp81atOH6EU6mJamSLuFtJu5wl\nArV9c7lfFliArtg3+d0NM9mV/6E+RYn5ELDK44Qc3M1wkf4BhcQWNVUR4tiTIS3EeFVEdo1e/xqg\n2sqj7WE+6BMMae4mjmXzrQ57+a+WzWKjKQfIuVzdy2ss+8ZnOpiU+sntd1DwXKCl1jMlDYQi9NYU\nHKIqtVkLsv0ooOoXygw7t9PD8iLHBEzAsoAyON15oUIEw4mahstkOA14yERzQQyII3gilZeANebf\npkg8N9/m3HBhfHh65KpQTHh9MTU41Bcvf2KZRg==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService></md:IDPSSODescriptor></md:EntityDescriptor>",
        "uuid": "sso_xxxx32",
        "workspaceUUID": "wksp_xxxx32"
    },
    "errorCode": "",
    "message": "",
    "success": true,
    "traceId": "12755949048553864357"
} 
```