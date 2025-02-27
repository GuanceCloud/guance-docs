# 添加 SAML SSO 登录配置

---

<br />**POST /api/v1/sso/saml_create**

## 概述
启用一个SAML




## Body 请求参数

| 参数名        | 类型     | 必选   | 说明              |
|:-----------|:-------|:-----|:----------------|
| type | string | Y | 类型<br>例子:  <br>允许为空: False <br>可选值: ['saml', 'oidc'] <br> |
| idpData | string | Y | xml文档内容(saml 类型必填)<br>例子:  <br>允许为空: False <br> |
| config | json |  | 访问配置表(oidc 类型必填)<br>例子:  <br>允许为空: False <br> |
| emailDomains | array | Y | 邮箱域名<br>例子: ['jiagouyun.com', 'guance.com'] <br> |
| idpName | string | Y | 供应商<br>例子: 默认供应商 <br>最大长度: 64 <br>$matchRegExp: [a-zA-Z_一-龥-]* <br> |
| role | string | Y | 角色<br>允许为空: False <br>可选值: ['general', 'readOnly'] <br> |
| remark | string |  | 备注<br>允许为空: False <br>允许为空字符串: True <br> |
| tokenHoldTime | integer |  | token 保持时长, 秒级时间戳，默认值 14400<br>允许为空: False <br>允许为空字符串: False <br>$minValue: 1800 <br>$maxValue: 86400 <br> |
| tokenMaxValidDuration | integer |  | token 最长的有效期, 秒级时间戳， 默认值 604800<br>允许为空: False <br>允许为空字符串: False <br>$minValue: 86400 <br>$maxValue: 604800 <br> |

## 参数补充说明


*OIDC 类型 config 配置说明*

--------------
当 type='oidc' 时， config 字段生效。其数据结构信息如下
<br/>
1.config 字段说明

|  参数名        |   type  | 必选  |  默认值  |          说明          |
|---------------|----------|----|-----|-----------------------|
| modeType     |  enum  |   | easy  | 配置文件编辑模式。可选值如下：<br/> easy：简单UI编辑模式。此模式下，用户仅须配置 OIDC 交互协议中必须的基础数据即可，其他数据均为默认值.<br/>expert：专家配置文件模式，要求用户上传 OIDC 配置文件。该模式支持用户自定义 OIDC 协议中的各种请求信息|
| wellKnowURL |  string  |  Y |   | OIDC 协议中的标准服务发现地址.<br/> [例如微软 AAD](https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration)|
| clientId    |  string  |  Y |   |「认证服务」为「<<< custom_key.brand_name >>>」创建的客户端ID |
| clientSecret    |  string  |  Y |    |「认证服务」为「<<< custom_key.brand_name >>>」创建的客户端对应的密钥 |
| sslVerify    |  boolean  |   |    | 服务发现配置信息请求时是否强制进行 ssl 认证；<br/> 默认根据 wellKnowURL 参数值的协议地址进行区分，如果是 https, 则默认为 true; 否则默认为 false|
| grantType    |  string  |  Y | authorization_code   | 「认证服务」为「<<< custom_key.brand_name >>>」创建的客户端ID |
| scope    |  array  |  Y | ["openid", "email"]   | 可访问的数据权限<br/>其中必选值为：openid<br/>其他可选值， 例如 profile, email<br/>该值取决于「认证服务」为「<<< custom_key.brand_name >>>」分配的 scop |
| authSet    |  dict  |   |    | 该配置服务于 OIDC 协议中的获取认证请求地址。<br/>[协议来源](https://openid.net/specs/openid-connect-core-1_0.html#AuthRequest) |
| getTokenSet    |  dict  |   |    | 该配置服务于 OIDC 协议中的 code 换 token 请求. <br/>[协议来源](https://openid.net/specs/openid-connect-core-1_0.html#TokenRequest) |
| verifyTokenSet    |  dict  |   |    | id_token 的验证配置. <br/>[协议来源](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation),  [jwks_urls 数据结构协议来源](https://datatracker.ietf.org/doc/html/rfc7515)|
| getUserInfoSet    |  dict  |   |    | 该配置服务于 OIDC 协议中的获取用户信息请求. <br/>[协议来源](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo) |
| claimMapping    |  dict  |   |    | 用户信息/id_token 中的字段映射配置。用于「<<< custom_key.brand_name >>>」根据该映射配置获取账号中对应的信息 |

<br/>
2. config.authSet 配置内部结构参数说明

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  url | string  |   |   |  认证请求地址。<br/>如果未提供，则默认取 wellKnowURL 指向配置中的 authorization_endpoint 值   |
|  verify | boolean  |   |   |  针对该请求是否需要开启 ssl 验证；未指定的情况下，url 使用 https 协议时，默认开启，否则关闭。  |
|  paramMapping | dict  |   |   |  请求中参数字段的映射，一般用于非标准OIDC客户根据自己的认证流程调整相关参数字段。详情下见下文中的说明 |

<br/>
3. config.getTokenSet 配置内部结构参数说明

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  url | string  |   |   |  code换取token的请求地址。<br/>如果未提供，则默认取 wellKnowURL 指向配置中的 token_endpoint 值   |
|  method | enum  |   |  post |  请求方法, 可选值：post, get  |
|  verify | boolean  |   |   |  针对该请求是否需要开启 ssl 验证；未指定的情况下，url 使用 https 协议时，默认开启，否则关闭。  |
|  authMethod | enum  |   | basic  |  签名数据位置及方法。可选值如下<br/>client_secret_basic 或者 basic: 认证信息位于请求头中的 Authorization 中，为 basic 认证 <br/>client_secret_post: client_id 和 client_secret 位于 body 中 <br/>none: client_id 和 client_secret 位于 query 中 |
|  paramMapping | dict  |   |   |  请求中参数字段的映射，一般用于非标准OIDC客户根据自己的认证流程调整相关参数字段。详情下见下文中的说明 |

<br/>
4. config.verifyTokenSet 配置内部结构参数说明

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  url | string  |   |   |  code换取token的请求地址。<br/>如果未提供，则默认取 wellKnowURL 指向配置中的 token_endpoint 值   |
|  verify | boolean  |   |   |  针对该请求是否需要开启 ssl 验证；未指定的情况下，url 使用 https 协议时，默认开启，否则关闭。  |
|  keys | array  |   |   |  url 指向的 JWT 算法数据信息<br/>[协议来源](https://openid.net/specs/openid-connect-core-1_0.html#IDTokenValidation),  [jwks_urls 数据结构协议来源](https://datatracker.ietf.org/doc/html/rfc7515)|

<br/>
5. config.getUserInfoSet 配置内部结构参数说明

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  source | enum  |   |  id_token |  获取用户信息的来源方式。可选值如下<br/>id_token: 从 id_token 中解析数据得来; <br/> origin: 调用「认证服务」接口获取用户信息|
|  url | string  |   |   |  获取用户信息的请求地址。<br/>如果未提供，则默认取 wellKnowURL 指向配置中的 userinfo_endpoint 值. <br/>source=origin 时该参数有效。   |
|  verify | boolean  |   |   |  针对该请求是否需要开启 ssl 验证；未指定的情况下，url 使用 https 协议时，默认开启，否则关闭。  |
|  method | enum  |   |  post |  请求方法, 可选值：post, get;<br/>source=origin 时该参数有效  |
|  authMethod | enum  |   | bearer  |  签名数据位置及方法。可选值如下:<br/>bearer: HTTP Bearer认证 <br/>client_secret_basic 或者 basic: 认证信息位于请求头中的 Authorization 中，为 basic 认证 <br/>client_secret_post: client_id 和 client_secret 位于 body 中 <br/>none: client_id 和 client_secret 位于 query 中 |
|  paramMapping | dict  |   |   |  请求中参数字段的映射，一般用于非标准OIDC客户根据自己的认证流程调整相关参数字段。详情下见下文中的说明 |

<br/>
6. config.claimMapping 配置内部结构参数说明

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  email | string  | Y  |  email |  代表用户的邮箱字段|
|  username | string  |  Y | preferred_username  |  代表用户的用户名字段  |
|  mobile | string  |   |   |  用户的手机号 |

<br/>
7. 针对 getTokenSet、getTokenSet、getUserInfoSet 配置中 paramMapping 参数内部结构说明
注意，当 paramMapping 存在时, 将直接走自定义请求参数流程。

| 参数名  | type  | 必选  | 默认值  | 说明  |
| :------------ | :------------ | :-----| :---------- | :------------ |
|  client_id | string  |   |  $client_id |  客户端ID， 与协议中的 client_id 对应 |
|  scope | string  |   |  $scope |  数据范围。以空格分隔数据范围字符串；<br/>注意，此处是请求参数中的 scope, 其与外部配置中的数据类型不同。外部配置中的 scope 作为默认配置存在，是数组类型；<br/>而此处的 scope 作为请求参数存在，是字符串类型。<br/> 例如：“openid email profile” |
|  code | string  |   |  $code |  「认证服务」传递过来用于换取 token 的 code |
|  state | string  |   |  $state |  类似与 CSRF 的作用 |
|  redirect_uri | string  |   |  $redirect_uri |  响应将被发送到的重定向URI。 |
|  response_type | string  |   |  $response_type |  响应类型, 授权码流程的值为 code |




## 请求例子
```shell
curl 'https://openapi.guance.com/api/v1/sso/saml_create' \
  -H 'DF-API-KEY: <DF-API-KEY>' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"idpData":"<?xml version=\\\"1.0\\\" encoding=\\\"UTF-8\\\"?><md:EntityDescriptor entityID=\\\"http://www.okta.com/exk4snorvlVZsqus25d7\\\" xmlns:md=\\\"urn:oasis:names:tc:SAML:2.0:metadata\\\"><md:IDPSSODescriptor WantAuthnRequestsSigned=\\\"false\\\" protocolSupportEnumeration=\\\"urn:oasis:names:tc:SAML:2.0:protocol\\\"><md:KeyDescriptor use=\\\"signing\\\"><ds:KeyInfo xmlns:ds=\\\"http://www.w3.org/2000/09/xmldsig#\\\"><ds:X509Data><ds:X509Certificate>MIIDqDCCApCgAwIBAgIGAXy+xOGoMA0GCSqGSIb3DQEBCwUAMIGUMQswCQYDVQQGEwJVUzETMBEG\nA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU\nMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEcMBoGCSqGSIb3DQEJ\nARYNaW5mb0Bva3RhLmNvbTAeFw0yMTEwMjYyMjQxMjZaFw0zMTEwMjYyMjQyMjZaMIGUMQswCQYD\nVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsG\nA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDGRldi0zODQzNjMzODEc\nMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC\nggEBAKBt7aed/3A+gHtfmNSATeaaNo1LR/WPH9TIso3foT5dMXYRtlW57/YPNzBpii8+Gs/I6xL7\nkXzbRy9lnhpbBVTCLstWpuxYNr7zXuxICoSCW/b+5bYNkvKFmYd1dGkd0j7L8ZbHDKFzGkCS4a/D\nKUn6Ac/HlmML9GIOzPNyz514c6cAGd4zcpYiXFhlpzFLpElUOEedWVU4eZ48k91pPLf2guWpU/OD\nmKQisIOL5uqQqLsK1DXV+miSfB8Mm4jXSPLBE73mD7EfYidY1FQELqsrLshkXJGbhlkNnoEocCLH\nz9COzi9+jeecGvZGUw+l8hkxMsqH+0U3wM7ueVLMtgECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEA\nUQrFTpRmneWUuok3L1CWgTeuwakErxB2NZtvpGkD5HrJE/eeyCEp81atOH6EU6mJamSLuFtJu5wl\nArV9c7lfFliArtg3+d0NM9mV/6E+RYn5ELDK44Qc3M1wkf4BhcQWNVUR4tiTIS3EeFVEdo1e/xqg\n2sqj7WE+6BMMae4mjmXzrQ57+a+WzWKjKQfIuVzdy2ss+8ZnOpiU+sntd1DwXKCl1jMlDYQi9NYU\nHKIqtVkLsv0ooOoXygw7t9PD8iLHBEzAsoAyON15oUIEw4mahstkOA14yERzQQyII3gilZeANebf\npkg8N9/m3HBhfHh65KpQTHh9MTU41Bcvf2KZRg==</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService><md:SingleSignOnService Binding=\\\"urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect\\\" Location=\\\"https://dev-38436338.okta.com/app/dev-38436338__5/exk4snorvlVZsqus25d7/sso/saml\\\"></md:SingleSignOnService></md:IDPSSODescriptor></md:EntityDescriptor>","emailDomains":["qq.com"],"role":"general","remark":"","tokenHoldTime":1800,"tokenMaxValidDuration":604800}' \
  --compressed \
  --insecure
```




## 响应
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




