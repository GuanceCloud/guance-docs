# SSO 管理
---

<<< custom_key.brand_name >>>支持基于 SAML、OIDC/ Oauth2.0 协议的 SSO 管理，支持企业在本地 IdP（身份提供商） 中管理员工信息，无需进行<<< custom_key.brand_name >>>和企业 IdP 之间的用户同步，企业员工即可通过指定的角色登录访问<<< custom_key.brand_name >>>。

在 SSO 管理，您可以：

- [基于企业域名配置单点登录](#corporate)
- [基于企业域名，并开启角色映射，提供更精细的单点登录方案](#saml-mapping)

## 用户 SSO {#corporate}

<<< custom_key.brand_name >>>支持基于企业域名的单点登录配置。只要员工的邮箱符合企业统一身份认证的域名后缀，即可通过该邮箱直接登录到<<< custom_key.brand_name >>>，并根据配置的权限访问系统。

1. 进入**管理 > 成员管理 > SSO 管理 > 用户 SSO**；
2. 按需选择 [SAML](#saml) 或 [OIDC](#oidc)；
3. 开始配置。

???+ warning "注意"

    - 可创建多个 SSO 的 IDP 配置，每个工作空间 SSO 配置最多不超过 10 个；
    - 若多个工作空间同时配置了相同的身份提供商 SSO 点单登录，用户通过 SSO 单点登录到工作空间后，可以点击左上角的工作空间选项，切换不同的工作空间查看数据。


### SAML {#saml}

![](../img/5.sso_mapping_7.png)

| 输入域      | 描述                          |
| ----------- | ------------------------------------ |
| 身份提供商      | 提供身份管理服务的平台，用于管理用户身份和认证信息。在此处定义名称。                          |
| 元数据文档       | 由 IdP (身份提供商)提供的 XML 文档。 |
| 备注       | 自定义添加的描述信息，用于记录身份提供商的相关说明。  |
| 访问限制    | 校验登录邮箱的域名后缀是否与配置的域名匹配。匹配的邮箱才有权限访问 SSO 登录链接。用户首次登录时可动态创建<<< custom_key.brand_name >>>成员账号，无需提前在工作空间内创建。 |
| 角色授权       | 为首次登录的 SSO 账号分配角色，非首次登录的账号不受影响。<br/>:warning: 若工作空间内启用 [SAML 映射](#saml-mapping)，则优先按映射规则分配角色。<br/>关于角色权限，可参考 [角色管理](../role-management.md)。  |
| [会话保持](#login-hold-time)       | 设置 SSO 登录会话的无操作保持时间和最大保持时间。超时后，登录会话将失效。  |


#### 获取 Entity ID 和 断言地址 {#obtain}

身份提供商添加成功后，点击右侧**更新**按钮，即可获取 **Entity ID** 和**断言地址**，根据身份提供商的要求在对应的 SAML 配置完成后即可。

| 字段      | 描述                  |
| ----------- | ------------------- |
| 登录地址       | 由用户上传的元数据文档生成的<<< custom_key.brand_name >>> SSO 登录地址。每个登录地址仅限访问一个工作空间。  |
| Metadata      | 由用户上传的元数据文档生成的<<< custom_key.brand_name >>> SSO 元数据文件。                  |
| Entity ID      | 由用户上传的元数据文档生成的<<< custom_key.brand_name >>> SSO 登录的实体 ID。用于在身份提供商（IdP）中标识服务提供商（SP），例如 << custom_key.brand_name >>>。    |
| 断言地址      | 由用户上传的元数据文档生成的<<< custom_key.brand_name >>> SSO 登录的断言目标地址。用于身份提供商（IdP）调用以完成单点登录。                  |


![](../img/5.sso_mapping_8.png)

#### 会话保持 {#login-hold-time}

在配置 SSO 单点登录时，您可以为通过 SSO 登录的企业成员设置统一的登录保持时间，包括“无操作登录会话保持时间”和“登录会话最大保持时间”。

- 无操作登录会话保持时间：支持设置范围为 180～1440 分钟，默认值为 180 分钟。
- 登录会话最大保持时间：支持设置范围为 0～7 天，其中 0 表示永不超时，默认值为 7 天。

???+ abstract "举例说明"

    在更新 SSO 登录保持时间后：

    - 已登录的成员：其登录会话过期时间保持不变。
    - 新登录的成员：按照最新的登录保持时间设置生效。

    例如：  
    - 初始配置 SSO 时，无操作会话过期时间为 30 分钟。成员 A 此时登录后，其无操作会话过期时间为 30 分钟。
    - 管理员随后将无操作会话过期时间更新为 60 分钟。成员 A 的无操作会话过期时间仍为 30 分钟，而在此之后登录的成员 B，其无操作会话过期时间将为 60 分钟，依此类推。

### OIDC {#oidc}

进入**管理 > 成员管理 > SSO 管理 > OIDC > 新建身份提供商**，默认为**标准的 OIDC 配置**。如果您不是标准的 OIDC 配置，您可[切换页面进行配置](#non-standard)。

![](../img/oidc.png)

#### 连接配置

![](../img/oidc-1.png)

| 输入域      | 描述                          |
| ----------- | ------------------------------------ |
| 身份提供商名称      | 提供身份管理服务的平台名称。                          |
| 备注       | 用户可自定义添加的描述信息，用于记录身份提供商的相关说明。  |
| 身份提供商 URL       | 身份提供商的完整 URL，也是服务发现地址。例如：https://guance.example.com<br/>注意：如果链接无法访问，请检查 URL 的合法性或稍后重试。 |
| 客户端 ID    | 由认证服务提供的唯一标识符，用于识别客户端应用程序。 |
| 客户端密钥       | 与客户端 ID 联合使用，用于对客户端应用程序进行身份验证。  |
| 授权请求 Scope      | 授权请求的范围。默认包含 `openid`、`profile` 和 `email`，可根据需要额外添加 `address` 和 `phone` 声明。|


#### 映射配置

要实现 SSO 登录，需将身份提供商（IdP）的账号信息与<<< custom_key.brand_name >>>账号信息进行字段映射。主要字段如下：

<img src="../img/oidc-2.png" width="70%" >

1. 用户名：必填；身份提供商的 “用户名” 字段，例如 `referred_username`；
2. 邮件：必填；身份提供商的 “邮箱” 字段，例如 `email`；
3. 手机号：非必填；身份提供商的 “手机号” 字段，例如 `phone`。

#### 登录配置

<img src="../img/oidc-3.png" width="70%" >

| 字段      | 描述                          |
| ----------- | -------------------------- |
| 访问限制    | 校验登录邮箱的域名后缀是否与配置的域名匹配。只有匹配的邮箱才有权限访问 SSO 登录链接。用户首次登录时可动态创建<<< custom_key.brand_name >>>成员账号，无需提前在工作空间内创建。 |
| 角色授权       | 为首次登录的 SSO 账号分配角色，非首次登录的账号不受影响。<br/>:warning: 若工作空间内启用[角色映射](#saml-mapping)，则优先按映射规则分配角色。<br/>关于角色权限，可参考 [角色管理](../role-management.md)。  |
| [会话保持](#login-hold-time)       | 设置 SSO 登录会话的无操作保持时间和最大保持时间。超时后，登录会话将失效。  |


???- abstract "用户侧配置 OIDC 相关注意事项"

    1. 授权模式：仅支持 `authorization_code` 授权模式；其返回类型必须是 `code`；
    2. `id_token` 签名算法：目前只支持 `HS256`；
    3. `code` 换取 `token` 身份验证方式：

        - 默认支持：`client_secret_basic`  
        - 自定义方式支持: `client_secret_post`、`client_secret_basic`、`none`

    4. `scope` 范围：
        - 默认范围：openid profile email phone

        - 自定义要求：必须包含 `openid`，其他可自定义，但返回结果中必须包含 `email`，可选返回 `phone_number`。


### 非 OIDC 标准配置 {#non-standard}

???- abstract "如何理解 OIDC 非标准配置？"

    非标准配置情况的发生一般是由于客户侧使用的 Oauth2 进行身份认证，然而 Oauth2 协议并没有约定**获取账号信息的接口**，这导致获取用户信息这一步存在千差万别，毕竟信息是成功建立映射关系的关键；另外，由于各个客户侧接口设计的规则不同，可能导致协议中约定的**参数大小写风格不一致**，此种情况下也是非标准。

1. 进入**管理 > 成员管理 > SSO 管理 > OIDC > 新建身份提供商**；
2. 点击右上角即可切换进入标准的 OIDC 配置页面：

<img src="../img/oidc-5.png" width="70%" >

![](../img/oidc-4.png)

#### 连接配置

| 输入域      | 描述                          |
| ----------- | ------------------------------------ |
| 身份提供商名称      | 提供身份管理服务的平台名称。                          |
| 配置文件上传      | 点击下载模板，补充相关信息后上传即可。                          |
| 备注       | 自定义添加的描述信息，用于记录身份提供商的相关说明。  |

#### 登录配置

| 输入域      | 描述                          |
| ----------- | -------------------------- |
| 访问限制    | 校验登录邮箱的域名后缀是否与配置的域名匹配。只有匹配的邮箱才有权限访问 SSO 登录链接。用户首次登录时可动态创建<<< custom_key.brand_name >>>成员账号，无需提前在工作空间内创建。 |
| 角色授权       | 为首次登录的 SSO 账号分配角色，非首次登录的账号不受影响。<br/>:warning: 若工作空间内启用[角色映射](#saml-mapping)，则优先按映射规则分配角色。角色权限详情可参考 [角色管理](../role-management.md)。  |
| [会话保持](#login-hold-time)       | 设置 SSO 登录会话的无操作保持时间和最大保持时间。超时后，登录会话将失效。  |

#### 获取 URL

身份提供商添加成功后，可获取**回调 URL** 和**发起登录 URL**。

| 字段      | 描述                  |
| ----------- | ------------------- |
| 回调 URL      | OIDC 协议中约定的认证通过后的回调地址，用于接收身份提供商的认证响应。       |
| 发起登录 URL      | 从<<< custom_key.brand_name >>>端启动 OIDC 登录流程的入口地址，由身份提供商提供。     |

获取上述两个 URL 后，需将其提供给身份提供商。

## SSO 列表

### 启用角色映射

您可以针对单个身份提供商（IDP）启用或禁用角色映射功能：

- 启用角色映射：
    - SSO 登录的用户账号将根据身份提供商提供的 `属性字段` 和 `属性值` 匹配角色映射规则，动态分配角色。
    - 若未匹配到角色映射规则，用户账号将被剥夺所有角色，并且无法登录访问工作空间。
- 禁用角色映射：SSO 登录用户将继续保留之前分配的角色，该角色不受身份提供商侧的断言更改影响。


### 启用/更新/删除/导入/导出 SSO

添加身份提供商后，您可以按需启用或禁用当前 SSO 配置。启用后，支持以下操作：

- 更新 SSO 配置：更新操作将影响现有 SSO 成员的登录体验，请谨慎操作。
- 删除 SSO 配置：删除操作将移除当前 SSO 配置，所有相关成员将无法通过该 SSO 配置登录，请谨慎操作。
- 导入/导出身份提供商：支持导入和导出身份提供商配置，便于快速复制到多个工作空间。

**注意**：  

- 导出文件时，文件名不能与当前工作空间中已存在的身份提供商同名。
- 导出文件需符合 JSON 格式规范。


### 查看 SSO 成员

- 成员数量：显示所有通过 SSO 登录的成员总数。  
- 成员名单：点击成员数量，可查看具体已授权的 SSO 成员名单。


## 登录验证 {#login}

1. 邮箱登录进入<<< custom_key.brand_name >>> SSO 页面：https://<<< custom_key.studio_main_site_auth >>>/login/sso；
2. 输入创建 SSO 时配置的邮箱地址，即可进入该身份提供商授权的所有工作空间；
3. 登录地址；
4. 输入用户名、密码等信息；
5. 登录成功。


<img src="../img/sso_login.png" width="70%" >


<img src="../img/sso_login_1.png" width="70%" >

???+ warning "注意"

    - 如果工作空间启用了[角色映射](./role_mapping.md)，但当前用户未匹配到角色或角色映射被禁用，将提示“无访问权限”；   
    - 如果工作空间删除了身份提供商，用户选择 SSO 登录时，将看不到未授权的工作空间。


## 邮件通知

启用、配置、删除 SSO 时，工作空间的 Owner 和 Administrator 会收到相关邮件通知。

## 审计事件

启用、配置、删除 SSO 操作都会生成[审计](../operation-audit.md)事件。



## SSO 配置示例

- [阿里云 IDaaS](aliyun-idaas.md)
- [Authing](authing.md)
- [Azure AD](azure-ad.md)
- [IAM Identity Center](./aws_iam_sso.md)
- [Okta](okta.md)
- [Keycloak](keycloak.md)
