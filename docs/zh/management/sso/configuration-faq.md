# 配置常见问题
---

:material-chat-question: **什么是<<< custom_key.brand_name >>> SSO 单点登录？**

单点登录（SSO）是整合企业系统的解决方案之一，用于统一用户身份认证，用户只需要登录一次就可以访问所有企业相互信任的应用系统。<<< custom_key.brand_name >>>的 SSO 单点登录基于 SAML 2.0（安全断言标记语言 2.0）和 OIDC/ Oauth2.0 协议的联合身份验证。

SAML 的英文全称为 Security Assertion Markup Language，即安全断言标记语言，是一个基于 XML 的开源标准数据格式，专门支持联合身份验证，在身份提供商（IdP）和服务提供商（SP）之间安全的交换身份验证和授权数据。

SAML 基本概念如下：

| 名词      | 解释                          |
| ----------- | ------------------------------------ |
| 身份提供商（IdP）       | 一个包含有关外部身份提供商元数据的实体，身份提供商可以提供身份管理服务。如 Azure AD、Authing、Okta、Keycloak 等等。  |
| 服务提供商（SP）     | 利用 IdP 的身份管理功能，为用户提供具体服务的应用，SP会使用 IdP 提供的用户信息。如<<< custom_key.brand_name >>>。 |
| 安全断言标记语言（SAML 2.0）  | 实现企业级用户身份认证的标准协议，它是 SP 和IdP之间实现互相信任的技术实现方式之一。 |
| SAML 断言（SAML assertion）      | SAML 协议中用来描述认证请求和认证响应的核心元素。如用户的具体属性（如<<< custom_key.brand_name >>>单点登录需要配置的邮箱信息）就包含在认证响应的断言里。                          |
| 信赖（Trust）      | 建立在 SP 和 IdP 之间的互信机制，通常由公钥和私钥来实现。SP 通过可信的方式获取 IdP 的 SAML 元数据，元数据中包含 IdP 签发 SAML 断言的签名验证公钥，SP 则使用公钥来验证断言的完整性。                          |


:material-chat-question: **如何获取用于在<<< custom_key.brand_name >>> SSO 管理创建身份提供商的云数据文档？**

在身份提供商配置完 SAML 单点登录的实体 ID 和回调地址（断言地址）以后，即可下载云数据文档。若无实体 ID和回调地址（断言地址），可填入以下示例获取元数据文档。

- 实体 ID：[https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)；  
- 断言地址，临时使用：[https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)。  

在<<< custom_key.brand_name >>>中启用 SSO 单点登录后，[获取到正确的实体 ID 和断言地址](../../management/sso/index.md#obtain)后重新替换。


:material-chat-question: **常见的 SAML 协议的 SSO 单点登录需要通过配置实体 ID 和回调地址（断言地址）进行登录，如何获取<<< custom_key.brand_name >>>的实体 ID 和回调地址（断言地址）？**

前往[获取 Entity ID 和 断言地址](../sso/index.md#obtain)。


:material-chat-question: **在身份提供商配置完成实体 ID 和回调地址（断言地址）以后，还是无法在<<< custom_key.brand_name >>>进行单点登录，如何解决？**

在配置身份提供商 SAML 时，需要配置邮箱映射，用于关联身份提供商的用户邮箱（即身份提供商将登录用户的邮箱映射到<<< custom_key.brand_name >>>的关联字段）。

<<< custom_key.brand_name >>>中定义了一个关联映射字段，必须填入 **Email** 来进行映射。如在 Azure AD 中，需要在**属性和索赔**中增加**属性声明**，见下图：

- 名称：<<< custom_key.brand_name >>>定义的字段，需填入 **Email**；  
- 源属性：根据身份提供商实际邮箱选择“user.mail”。

![](../img/9.azure_8.1.png)

:material-chat-question: **在身份提供商配置了邮箱映射声明以后，还是无法在<<< custom_key.brand_name >>>进行单点登录，如何解决？**

<<< custom_key.brand_name >>>定义的关联映射邮箱字段通过正则表达式来匹配身份提供商的邮箱规则，若配置的身份提供商邮箱规则不符合<<< custom_key.brand_name >>>支持的邮箱正则表达式，故无法进行单点登录，可[联系<<< custom_key.brand_name >>>售后](https://<<< custom_key.brand_main_domain >>>/#home)进行处理。

![](../img/contact-us.png)

目前<<< custom_key.brand_name >>>支持的邮箱正则表达式如下：

```
[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?
```

您可以如下通过测试网站进行正则测试：

[https://c.runoob.com/front-end/854/](https://c.runoob.com/front-end/854/)

:material-chat-question: **在身份提供商配置完成实体 ID、回调地址（断言地址）、邮箱映射及声明以后，还是无法在<<< custom_key.brand_name >>>进行单点登录，如何解决？**

若在<<< custom_key.brand_name >>>启用[角色映射](index.md#saml-mapping)，SSO 登录的用户账号将被剥夺其当前所在工作空间中的角色，并根据身份提供商提供的**属性字段**和**属性值**，匹配角色映射规则动态分配角色。若未匹配到角色映射规则，则用户账号将被剥夺所有角色，且不允许登录访问<<< custom_key.brand_name >>>工作空间。

若排除以上情况，请联系客户经理为您解决。


:material-chat-question: **在<<< custom_key.brand_name >>>是否可以配置多个 SSO 单点登录？**

可以。配置步骤参见[用户 SSO](./index.md#corporate)。


:material-chat-question: **通过 SSO 登录的账号有支持哪些访问权限？**

SSO单点登录配置时支持设置角色访问权限包括**标准成员**和**只读成员**，可以在**成员管理**设置升级到“管理员”，若工作空间内启用 [角色映射](index.md#saml-mapping)功能，成员登录时会优先分配映射规则中的角色。

> 详情可参考 [角色管理](../role-management.md)。


:material-chat-question: **通过 SSO 登录的账号是否可以在<<< custom_key.brand_name >>>删除？删除后是否可以再次登录？**

点击图中数字即可删除 SSO 登录成员。只要身份提供商未删除，该成员还可以继续登录<<< custom_key.brand_name >>>工作空间。若需要彻底删除且不让该成员通过 SSO 登录，需同时删除<<< custom_key.brand_name >>>和身份提供商的用户账号。

![](../img/12.sso_13.png)




