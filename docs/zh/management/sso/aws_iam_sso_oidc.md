# 通过 AWS IAM Identity Center 单点登录示例（OIDC）
---

OIDC 是基于 OAuth 2.0 的协议，允许用户用 AWS 账号直接登录观测云，无需重复密码。AWS 验证用户后生成 ID Token，观测云验证后自动登录。相比传统协议，OIDC 更轻量化，简化了跨平台认证流程，适合云原生应用。

???+ warning "注意"

    AWS IAM Identity Center 的 OAuth 2.0 单点登录功能仅限于 AWS **国际站点**使用。

## 1、启用 IAM Identity Center

> 更多详情，可参考 [启用服务](./aws_iam_sso_saml.md#get_started)。

## 2、添加应用程序

1. 在应用程序管理页面，选择“客户托管”，并点击“添加应用程序”；
2. 选择应用程序类型为“我想设置应用程序”；
3. 继续选择 OAuth 2.0，进入下一步。

<img src="../../img/aws_iam_oidc.png" width="70%" >

### 配置应用程序 {#config}

1. 定义该应用程序的显示名称，如 `guance_oidc`；
2. 按需输入描述；
3. 选择“需要分配”；
4. 输入用户可以访问应用程序的 URL：https://<<< custom_key.studio_main_site_auth >>>/login/sso；
5. 选择在 AWS 访问门户中“可见”此应用程序。
6. 进入下一步。

<img src="../../img/aws_iam_oidc_1.png" width="70%" >


## 3、指定身份验证设置

要将支持 OAuth 2.0 的客户托管应用程序添加到 IAM Identity Center，需指定可信令牌颁发者。它是创建签名令牌的 OAuth 2.0 授权服务器。这些令牌用于授权请求端应用程序访问 AWS 托管的应用程序（接收端应用程序）。

若应用程序内尚无可信任的令牌发布者，需先创建。

1. 填入发布者 URL：https://<<< custom_key.studio_main_site_auth >>>/login/sso；
2. 定义可信令牌发布者名称，如 `GUANCE`；
3. 选择身份提供者属性 `电子邮件(email)` 映射为 `电子邮件`；
4. 点击创建；
5. 创建成功后，自动进入身份验证页面，您可按需针对相关设置进行修改；
6. 回到“指定身份验证设置”页面，刷新，选定可信任的令牌发布者；
7. 填入 Aud 声明；
8. 进入下一步。

**<img src="../../img/aws_iam_oidc_2.png" width="70%" >**//暂无

> 更多详情，可参考 [通过可信令牌发布者使用应用程序](https://docs.aws.amazon.com/zh_cn/singlesignon/latest/userguide/using-apps-with-trusted-token-issuer.html?icmpid=docs_sso_console)。

## 4、指定应用程序凭证

IAM 角色是您创建的具有特定权限的身份，其凭证在短期内有效。

1. 选择“输入一个或多个 IAM 角色”；
2. 选择查看 “IAM 角色”，进入新页后点击进入角色页；
3. 复制其 ARN；
4. 填入该角色的 ARN；
5. 进入下一步。

<img src="../../img/aws_iam_oidc_3.png" width="70%" >

<img src="../../img/aws_iam_oidc_4.png" width="70%" >

<img src="../../img/aws_iam_oidc_5.png" width="70%" >

## 5、查看和配置

确认配置无误后，提交。提示应用程序添加成功页面。

## 6、分配用户和组访问权限

> 更多详情，可参考 [分配用户和组](./aws_iam_sso_saml.md#assign_permisson)。

## 7、登录验证

1. 登录进入<<< custom_key.brand_name >>>单点登录页面：https://<<< custom_key.studio_main_site_auth >>>/login/sso；
2. 在列表中选择在 AWS 侧创建的应用程序；
3. 登录地址；
4. 输入[用户名、密码](./aws_iam_sso_saml.md#add_user)；
5. 即可登录成功。


<img src="../../img/aws_iam_sso-14.png" width="70%" >

<img src="../../img/aws_iam_sso-15.png" width="70%" >