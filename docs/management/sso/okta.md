# Okta单点登录示例
---

## 操作场景

Okta 是身份识别与访问管理解决方案提供商。观测云支持基于 SAML 2.0（安全断言标记语言 2.0）的联合身份验证，SAML 2.0 是许多身份验证提供商（Identity Provider， IdP）使用的一种开放标准。您可以通过基于 SAML 2.0 联合身份验证将 Okta 与观测云进行集成，从而实现 Okta 帐户自动登录（单一登录）观测云平台访问对应工作空间资源，不必为企业/团队单独创建观测云账号。

## 操作步骤

### 1.创建 Okta 应用程序
注意：在创建应用程序前，您需要先在 [Okta网站](https://www.okta.com/) 注册账号并创建您的组织。<br />1）打开 Okta 网站并登录，点击右上角的用户，在下拉列表选择“Your Org”。<br />![](../img/04_okta_01.png)<br />2）在 Okta 组织页面，在右侧菜单点击“Application”，在打开的页面点击“Create App Integration”。<br />![](../img/04_okta_02.png)<br />3）选择“SAML 2.0”，创建一个新的应用程序。<br />![](../img/04_okta_03.png)


### 2.为 Okta 应用程序配置 SAML
注意：本步骤将 Okta 应用程序属性映射到观测云的属性，建立 Okta 和观测云之间的信任关系使之相互信任。<br />1）在新创建应用程序的“General Settings”，输入应用名称，如“okta”，然后点击“下一步”。<br />![](../img/04_okta_04.png)<br />2）在“Configure SAML”的“SAML Settings”部分，填入断言地址和Entity ID。

- Single sign on URL：断言地址，示例：[https://auth.guance.com/saml/assertion](https://auth.guance.com/saml/assertion/)
- Audience URI（SP Entity ID）：Entity ID，示例：[https://auth.guance.com/saml/metadata.xml](https://auth.guance.com/saml/metadata.xml)

**注意：此次配置仅为获取下一步的元数据文档使用，需要在观测云中启用SSO单点登录后，获取到正确的“实体ID”和“断言地址”后重新替换。关于如何获取观测云的断言地址和实体 ID，可参考文档 **[**新建SSO**](../../management/sso/index.md)** 。**<br />![](../img/04_okta_05.png)<br />3）在“Configure SAML”的“Attribute Statements(optional)”部分，填入 Name 和 Value。

- Name：观测云定义的字段，需填入“Email”，用于关联身份提供商的用户邮箱（即身份提供商将登录用户的邮箱映射到Email）；
- Value：根据身份提供商实际邮箱格式填写，此处 Okta 可填入“user.email”。

注意：此部分内容为必填项，如果不填，SSO单点登录时将提示无法登录。<br />![](../img/04_okta_06.png)<br />4）在“Feedback”，选择以下选项，点击“Finish”，完成 SAML 配置。<br />![](../img/04_okta_07.png)

### 3.获取 Okta 元数据文档
注意：本步骤可获取在观测云创建身份提供商的元数据文档。<br />1）在“Sign On”，单击“Identity Provider metadata”查看身份提供商元数据。<br />![](../img/04_okta_08.png)<br />2）在查看页面右键保存至本地。<br />注意：元数据文档为 xml  文件，如 “metadata.xml”。 <br />![](../img/04_okta_09.png)

### 4.配置 Okta 用户
注意：本步骤配置在观测云创建身份提供商的授权用户邮箱账号，通过配置的 Okta 用户邮箱账号可单点登录到观测云平台。<br />1）在“Assignments”-“Assign”，选择“Assign to People”。<br />![](../img/04_okta_10.png)<br />2）选择需要单点登录到观测云的用户，如“jd@qq.com”，点击“Assign”。<br />![](../img/04_okta_11.png)<br />3）点击“Save and Go Back”，完成用户配置。<br />![](../img/04_okta_12.png)<br />4）返回“Assignments”，可查看配置授权的 Okta 用户。<br />![](../img/04_okta_13.png)


### 5.在观测云启用SSO单点登录并在Okta替换SAML断言地址

1）启用 SSO 单点登录，在观测云工作空间“管理”-“SSO管理”，点击“启用”即可。可参考文档 [新建SSO](../../management/sso/index.md) 。<br />**注意：基于账号安全考虑，观测云支持工作空间仅配置一个 SSO，若您之前已经配置过 SAML 2.0，我们默认会将您最后一次更新的 SAML2.0 配置视为最终单点登录验证入口。**<br />![](../img/04_okta_14.png)<br />2）上传身份提供商的“元数据文档”，配置“邮箱域名”，选择“访问角色”，即可获取该身份提供商的“实体ID”和“断言地址”，支持直接复制“登录地址”进行登录。<br />**注意：启用 SSO 登录时，需要添加“邮箱域名”，用于观测云和身份提供商进行邮箱域名映射（用户邮箱域名需和观测云中添加的邮箱域名保持一致），实现单点登录。**<br />![](../img/04_okta_15.png)<br />3）返回更新 Okta 的 SAML 断言地址和 Entity ID，见[步骤2.2)](#j217u)。<br />**注意：在观测云配置单点登录时，身份提供商SAML中配置的断言地址必须和观测云中的保持一致，才能实现单点登录。**


### 6.使用 Okta 账号单点登录观测云

1）SSO配置完成后，通过 [观测云官网](https://www.dataflux.cn/) 或者 [观测云控制台](https://auth.dataflux.cn/loginpsw) 登录，在登录页面选择「单点登录」。<br />![](../img/04_okta_16.png)<br />2）输入在创建SSO的邮箱地址，点击「获取登录地址」。<br />![](../img/04_okta_17.png)<br />3）点击「链接」打开企业账号登录页面。<br />![](../img/04_okta_18.png)<br />4）输入企业通用邮箱和密码。<br />![](../img/04_okta_19.png)<br />5）登录到观测云对应的工作空间。<br />注意：若多个工作空间同时配置了相同的身份提供商 SSO 点单登录，用户通过 SSO 单点登录到工作空间后，可以点击观测云左上角的工作空间选项，切换不同的工作空间查看数据。<br />![](../img/04_okta_20.png)


---
