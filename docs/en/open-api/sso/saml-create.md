# Add SAML SSO Login Configuration

---

<br />**POST /api/v1/sso/saml_create**

## Overview
Enable a SAML



## Body Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:---------------------|:---------|:-----------|:------------------------|
| type | string | Y | Type<br>Example: <br>Allow empty: False <br>Possible values: ['saml', 'oidc'] <br> |
| idpData | string | Y | XML document content (mandatory for saml type)<br>Example:  <br>Allow empty: False <br> |
| config | json |  | Access configuration table (mandatory for oidc type)<br>Example:  <br>Allow empty: False <br> |
| emailDomains | array | Y | Email domain<br>Example: ['<<< custom_key.brand_main_domain >>>'] <br> |
| idpName | string | Y | Provider<br>Example: Default provider <br>Maximum length: 64 <br>$matchRegExp: [a-zA-Z_一-龥-]* <br> |
| role | string | Y | Role<br>Allow empty: False <br>Possible values: ['general', 'readOnly'] <br> |
| remark | string |  | Note<br>Allow empty: False <br>Allow empty string: True <br> |
| tokenHoldTime | integer |  | Token holding duration, in seconds, default value 14400<br>Allow empty: False <br>Allow empty string: False <br>$minValue: 1800 <br>$maxValue: 86400 <br> |
| tokenMaxValidDuration | integer |  | Maximum validity period of the token, in seconds, default value 604800<br>Allow empty: False <br>Allow empty string: False <br>$minValue: 86400 <br>$maxValue: 604800 <br> |

## Additional Parameter Explanation


*OIDC Type config Configuration Explanation*

--------------
When type='oidc', the config field takes effect. Its data structure information is as follows:
<br/>
1. config Field Explanation

| Parameter Name        | type  | Required | Default Value | Description          |
|-----------------------|----------|----|-----|-----------------------|
| modeType     | enum  |   | easy  | Configuration file editing mode. Possible values:<br/>easy: Simple UI editing mode. In this mode, users only need to configure the basic data required by the OIDC interaction protocol, and other data are default values.<br/>expert: Expert configuration file mode, requiring users to upload an OIDC configuration file. This mode supports user-defined various request information in the OIDC protocol |
| wellKnowURL | string  |  Y |   | Standard service discovery address in the OIDC protocol.<br/>[For example Microsoft AAD](https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration)|
| clientId    | string  |  Y |   | Client ID created by the "authentication service" for "<<< custom_key.brand_name >>>" |
| clientSecret    | string  |  Y |    | Secret key corresponding to the client created by the "authentication service" for "<<< custom_key.brand_name >>>" |
| sslVerify    | boolean  |   |    | Whether SSL certification is enforced during service discovery configuration information requests;<br/> Defaults according to the protocol address of the wellKnowURL parameter, if it is https, then defaults to true; otherwise defaults to false |
| grantType    | string  |  Y | authorization_code   | Client ID created by the "authentication service" for "<<< custom_key.brand_name >>>" |
| scope    | array  |  Y | ["openid", "email"]   | Accessible data permissions<br/>One of the mandatory values: openid<br/>Other optional values, such as profile, email<br/>This value depends on the "authentication service" assigned scop for "<<< custom_key.brand_name >>>" |
| authSet    | dict  |   |    | This configuration serves the authentication request address acquisition in the OIDC protocol.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest) |
| getTokenSet    | dict  |   |    | This configuration serves the code exchange token request in the OIDC protocol.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#TokenRequest) |
| verifyTokenSet    | dict  |   |    | ID_token validation configuration.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation), [jwks_urls data structure protocol source](https://datatracker.ietf.org/doc/html/rfc7515)|
| getUserInfoSet    | dict  |   |    | This configuration serves the user information request acquisition in the OIDC protocol.<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo) |
| claimMapping    | dict  |   |    | User information/id_token field mapping configuration. Used by "<<< custom_key.brand_name >>>" to obtain corresponding information in the account based on this mapping configuration |

<br/>
2. config.authSet Internal Structure Parameter Explanation

| Parameter Name  | type  | Required  | Default Value  | Description  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  url | string  |   |   | Authentication request address.<br/>If not provided, the default value will be taken from the authorization_endpoint in the wellKnowURL configuration   |
|  verify | boolean  |   |   | Whether SSL verification needs to be enabled for this request; If not specified, when the URL uses the https protocol, it is enabled by default, otherwise it is disabled.  |
|  paramMapping | dict  |   |   | Mapping of request parameters fields, generally used by non-standard OIDC customers to adjust related parameter fields according to their own authentication process. Details see the following explanation |

<br/>
3. config.getTokenSet Internal Structure Parameter Explanation

| Parameter Name  | type  | Required  | Default Value  | Description  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  url | string  |   |   | Code-to-token exchange request address.<br/>If not provided, the default value will be taken from the token_endpoint in the wellKnowURL configuration   |
|  method | enum  |   |  post | Request method, possible values: post, get  |
|  verify | boolean  |   |   | Whether SSL verification needs to be enabled for this request; If not specified, when the URL uses the https protocol, it is enabled by default, otherwise it is disabled.  |
|  authMethod | enum  |   | basic  | Signature data position and method. Possible values:<br/>client_secret_basic or basic: Authentication information is located in the Authorization header of the request, which is basic authentication<br/>client_secret_post: client_id and client_secret are located in the body<br/>none: client_id and client_secret are located in the query |
|  paramMapping | dict  |   |   | Mapping of request parameters fields, generally used by non-standard OIDC customers to adjust related parameter fields according to their own authentication process. Details see the following explanation |

<br/>
4. config.verifyTokenSet Internal Structure Parameter Explanation

| Parameter Name  | type  | Required  | Default Value  | Description  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  url | string  |   |   | Code-to-token exchange request address.<br/>If not provided, the default value will be taken from the token_endpoint in the wellKnowURL configuration   |
|  verify | boolean  |   |   | Whether SSL verification needs to be enabled for this request; If not specified, when the URL uses the https protocol, it is enabled by default, otherwise it is disabled.  |
|  keys | array  |   |   | URL pointing to JWT algorithm data information<br/>[Protocol source](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation), [jwks_urls data structure protocol source](https://datatracker.ietf.org/doc/html/rfc7515)|

<br/>
5. config.getUserInfoSet Internal Structure Parameter Explanation

| Parameter Name  | type  | Required  | Default Value  | Description  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  source | enum  |   |  id_token | Source of user information acquisition. Possible values:<br/>id_token: Data parsed from id_token; <br/>origin: Call the "authentication service" interface to get user information |
|  url | string  |   |   | User information request address.<br/>If not provided, the default value will be taken from the userinfo_endpoint in the wellKnowURL configuration. Effective when source=origin.   |
|  verify | boolean  |   |   | Whether SSL verification needs to be enabled for this request; If not specified, when the URL uses the https protocol, it is enabled by default, otherwise it is disabled.  |
|  method | enum  |   |  post | Request method, possible values: post, get; Effective when source=origin |
|  authMethod | enum  |   | bearer  | Signature data position and method. Possible values:<br/>bearer: HTTP Bearer authentication<br/>client_secret_basic or basic: Authentication information is located in the Authorization header of the request, which is basic authentication<br/>client_secret_post: client_id and client_secret are located in the body<br/>none: client_id and client_secret are located in the query |
|  paramMapping | dict  |   |   | Mapping of request parameters fields, generally used by non-standard OIDC customers to adjust related parameter fields according to their own authentication process. Details see the following explanation |

<br/>
6. config.claimMapping Internal Structure Parameter Explanation

| Parameter Name  | type  | Required  | Default Value  | Description  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  email | string  | Y  |  email | Represents the user's email field |
|  username | string  |  Y | preferred_username  | Represents the user's username field |
|  mobile | string  |   |   | User's phone number |

<br/>
7. Explanation of the internal structure of the paramMapping parameter in the getTokenSet, getUserInfoSet configurations
Note that when paramMapping exists, the customized request parameter process will be followed directly.

| Parameter Name  | type  | Required  | Default Value  | Description  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  client_id | string  |   |  $client_id | Client ID, corresponding to the client_id in the protocol |
|  scope | string  |   |  $scope | Data range. Space-separated data range string;<br/>Note that this is the scope in the request parameter, its data type differs from the external configuration. The scope in the external configuration exists as a default configuration and is an array type;<br/>However, the scope here exists as a request parameter and is a string type.<br/> For example: “openid email profile” |
|  code | string  |   |  $code | Code passed by the "authentication service" used to exchange tokens |
|  state | string  |   |  $state | Similar to CSRF function |
|  redirect_uri | string  |   |  $redirect_uri | Redirect URI where the response will be sent to. |
|  response_type | string  |   |  $response_type | Response type, the value for the authorization code flow is code |



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