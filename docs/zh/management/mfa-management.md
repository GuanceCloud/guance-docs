# MFA 管理
---

{{{ custom_key.brand_name }}}提供强制双因子 MFA 安全认证，从而在账号用户名和密码之外再额外增加一层安全保护，开启 MFA 认证后，开启后，所有工作空间的成员必须完成 MFA 绑定和认证，否则将无法进入工作空间。

## 绑定 MFA

在{{{ custom_key.brand_name }}}工作空间，点击左下角**您的账号 > 账号管理 > 安全设置**下的 **MFA 认证**，点击右侧的**绑定**。

<img src="../img/6.mfa_1.png" width="80%" >

绑定 MFA 认证支持通过邮箱进行验证，点击获取验证码输入后，点击**确定**。

<img src="../img/1.mfa_2.1.png" width="50%" >

手机端下载并安装 Google Authenticator 和阿里云等身份验证器 APP，扫描并获取 MFA 安全码。

![](img/1.mfa_4.1.png)

输入获取的 6 位动态安全码，并点击**确定**。

<img src="../img/1.mfa_11.1.png" width="40%" >

点击**确定**后，提示 MFA 绑定成功，并返回到**账号管理**页面，在 **MFA 认证**提示“已绑定”。

![](img/6.mfa_1.1.png)

## 登录 MFA 认证账号

当开启 MFA 强制认证后，若该工作空间的成员登录前未绑定 MFA，需要按照以下步骤完成身份认证：

![](img/mfa-1.png)

若当前账号已绑定 MFA，在登录{{{ custom_key.brand_name }}}时，需输入 6 位动态安全码登录进入：

![](img/mfa-2.png)

<!--
会提示如下对话框，输入通过 Google Authenticator 获取的 6 位动态安全码，并点击**确定**进行登录。

![](img/1.mfa_6.1.png)
-->

## 解绑 MFA

### 方法一

若您不再需要使用 MFA 认证，可以为账号解除绑定 MFA。在{{{ custom_key.brand_name }}}工作空间，点击左下角**账号 > 账号管理**，在**安全设置**下的 **MFA 认证**，点击右侧的**解绑**，输入动态码，点击**确定**。

![](img/1.mfa_8.png)

解绑后，您可以看到 **MFA 认证**提示为未绑定。

![](img/6.mfa_1.png)

<!--
同时您会收到一封来自{{{ custom_key.brand_name }}}的解绑邮件提醒。

![](img/1.mfa_10.png)
-->

### 方法二

若在登录时，安装 MFA 验证的设备不在身边，无法生成安全码进行登录，您可以联系{{{ custom_key.brand_name }}}客服申请解绑。在登录页面，点击**解除 MFA 绑定**，选择工单类型为**解绑 MFA**，填入工单标题、描述和邮箱验证码，提交工单。

{{{ custom_key.brand_name }}}客服收到申请后，会尽快为您处理。

> 更多详情，可参考 [工单管理](work-order-management.md)。

<img src="../img/1.work_order_2.png" width="60%" >




