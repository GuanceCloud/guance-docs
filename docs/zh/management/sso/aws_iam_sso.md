# 通过 AWS IAM Identity Center 单点登录示例
---

AWS IAM Identity Center（原 AWS SSO）是 AWS 提供的集中式身份管理服务，支持通过**单点登录（SSO）**统一管控用户对多个 AWS 账户、云应用（如 Salesforce、GitHub）及混合云资源的访问权限。

**注意**：AWS IAM Identity Center 的 SAML 2.0 单点登录功能仅限于 AWS **国际站点**使用。

## 1、启用 IAM Identity Center

在本示例中，假设登录 AWS 平台的用户账号此前**未曾使用**过 IAM Identity Center 服务，此次为其首次使用。

1. 登录 AWS 控制台；
2. 在搜索栏中，输入 IAM Identity Center；
3. 点击“启用”。

<img src="../../img/aws_iam_sso-1.png" width="70%" >

<img src="../../img/aws_iam_sso-2.png" width="70%" >

**注意**：

- 在启用 IAM Identity Center时，需注意控制台顶部导航栏的**区域选择**。服务启用后将无法直接切换区域，需在新区域重新启用并重新配置所有设置；
- 若您的组织已有 AWS 主管理区域（如 us-east-1 或 ap-northeast-1），建议保持一致，便于统一管理。

## 2、创建自定义 SAML 2.0 应用程序

在应用程序管理页面，选择“客户托管”，并点击“添加应用程序”。

???- abstract "为什么选择“客户托管（Custom）"

    | 选项      | 适用场景                |
    | ----------- | ------------------ |
    | AWS 托管      | AWS 已预集成的第三方 SaaS 应用（如 Salesforce、Slack、Zoom 等）。AWS 自动提供元数据和配置模板。                |
    | 客户托管      | 需要手动配置 SAML 的第三方平台（非 AWS 预集成应用，如本文中的示例对象“<<< custom_key.brand_name >>>平台”），需自行提供 SAML 元数据或 ACS URL。                |


1. 选择应用程序类型为“我想设置应用程序”；
2. 继续选择 SAML 2.0，进入下一步。

<img src="../../img/aws_iam_sso-3.png" width="70%" >

<img src="../../img/aws_iam_sso-4.png" width="70%" >

### 配置应用程序 {#config}

1. 定义该应用程序的显示名称，如 `guance`；
2. 按需输入描述；
3. 在 “IAM Identity Center 元数据”下，点击下载 IAM Identity Center SAML 元数据文件和证书；
4. 在应用程序元数据，将“应用程序 ACS URL” 和“应用程序 SAML 受众”两个字段填写为：https://auth.guance.com/login/sso；
5. 提交当前配置；
6. 页面将提示应用程序添加成功。

<img src="../../img/aws_iam_sso-5.png" width="70%" >

<img src="../../img/aws_iam_sso-6.png" width="70%" >

## 3、编辑属性映射

属性映射是 SAML 集成的核心配置，用于将 AWS 用户属性传递至<<< custom_key.brand_name >>>。

回到应用程序详情页后，在页面右上方点击**操作 > 编辑属性映射**，在这里进行 AWS 的用户登录的身份与<<< custom_key.brand_name >>>的角色身份的映射关系。

1. 系统默认提供字段 `Subject`（用户唯一标识符），选择将其映射为 `${user:email}`；
2. 配置完毕后点击保存更改。

<img src="../../img/aws_iam_sso-18.png" width="70%" >

## 4、分配用户和组访问权限

您在 Identity Center 目录中创建的用户和组仅在 IAM Identity Center 中可用。后续可为其分配权限。在本示例中，默认**当前目录未添加过用户和组**。


### 步骤 1：添加用户 {#add_user}

1. 进入控制台 > 用户页面；
2. 点击“添加用户”；
3. 定义用户名，选择用户接受密码的方式，并输入邮箱、名字、姓氏、显示名称；
4. 进入下一步。


<img src="../../img/aws_iam_sso-7.png" width="70%" >

<img src="../../img/aws_iam_sso-8.png" width="70%" >

**注意**：此处的用户名、密码、邮箱均为后续该用户单点登录时会用到的必需配置。

### 步骤 2：将用户添加到组

1. 若当前目录中没有组，进入右侧创建入口；
2. 定义组名；
3. 点击右下角“创建”按钮；
4. 回到添加用户页面，选择该组，进入下一步；
5. 确认添加该用户。状态消息将通知您，您已成功添加该用户。

<img src="../../img/aws_iam_sso-9.png" width="70%" >

<img src="../../img/aws_iam_sso-10.png" width="70%" >


### 步骤 3：为应用程序分配用户和组

1. 进入应用程序，选择配置的程序（此处示例为上文配置的 `guance`），为其分配用户和组；
2. 搜索勾选需要分配权限的所有用户和组；
3. 审核通过后即可创分配成功。


<img src="../../img/aws_iam_sso-11.png" width="70%" >

<img src="../../img/aws_iam_sso-12.png" width="70%" >



## 5、在<<< custom_key.brand_name >>>创建用户 SSO 身份提供商

1. 登录进入<<< custom_key.brand_name >>>工作空间 > 管理 > 成员管理 > 用户 SSO；
2. 选择 SAML；
3. 点击添加身份提供商，开始配置；
4. 定义身份提供商名称为 `aws_sso`；
5. 上传配置应用程序时[下载的元数据文档](#config)；
6. 定义访问限制为 `guance.com`；
7. 选择角色和会话保持时间；
8. 点击确认。


<img src="../../img/aws_iam_sso-13.png" width="70%" >

> 此处的更多配置详情，可参考 [SSO 管理](./index.md#corporate)。

## 6、登录验证

1. 登录进入<<< custom_key.brand_name >>>单点登录页面：https://auth.guance.com/login/sso；
2. 在列表中选择在 AWS 侧创建的应用程序；
3. 登录地址；
4. 输入[用户名、密码](#add_user)；
5. 即可登录成功。


<img src="../../img/aws_iam_sso-14.png" width="70%" >

<img src="../../img/aws_iam_sso-15.png" width="70%" >