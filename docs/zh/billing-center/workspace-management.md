# 工作空间管理
---

在<<< custom_key.brand_name >>>费用中心，一个账户可绑定多个<<< custom_key.brand_name >>>工作空间。在**管理工作空间**，支持查看账户下绑定的所有工作空间、修改已绑定工作空间的结算方式，包括<<< custom_key.brand_name >>>费用中心账号、AWS 账号、阿里云账号、华为云账号 4 种结算方式。

**注意**：工作空间的结算方式仅支持一个月更改一次。

![](img/15.aws_3.png)

## 更改结算方式

在<<< custom_key.brand_name >>>费用中心**管理工作空间**，点击右侧的**更改结算方式**，即可为当前的工作空间更改 [结算方式](../billing-account/index.md)，支持<<< custom_key.brand_name >>>费用中心账号、AWS 账号、阿里云账号、华为云账号 4 种结算方式。

![](img/10.account_11.png)

### <<< custom_key.brand_name >>>费用中心账号结算

<<< custom_key.brand_name >>>费用中心账号是<<< custom_key.brand_name >>>费用中心专用于管理使用<<< custom_key.brand_name >>>产品产生的计费相关的独立账号，一个费用中心账号可以关联多个工作空间计费。

> 更多详情，可参考 [<<< custom_key.brand_name >>>费用中心账号结算](../../billing/billing-account/enterprise-account.md)。


### 云账号结算

云账号结算包括 [AWS 账号结算](../../billing/billing-account/aws-account.md)、[阿里云账号结算](../../billing/billing-account/aliyun-account.md)和[华为云账号结算](../../billing/billing-account/huawei-account.md)。


### 更改结算方式任意选择

默认情况下，通过**阿里云站点**注册登录的工作空间只能选择**<<< custom_key.brand_name >>>费用中心账号**和**阿里云账号**结算方式，通过**AWS 站点**注册登录的工作空间只能选择**<<< custom_key.brand_name >>>费用中心账号**和 **AWS 账号**结算方式。

> 更多站点选择可参考文档 [站点说明](../commercial-register.md#site)。

若需要任意更改结算方式，需要开启**结算方式任意选择**。开启以后，<<< custom_key.brand_name >>>所有用户工作空间，都可以任意选择**<<< custom_key.brand_name >>>费用中心账号**、**阿里云账号**、**AWS 账号**及**华为云账号**结算方式。

**注意**：开启**结算方式任意选择**需要联系<<< custom_key.brand_name >>>客户经理在<<< custom_key.brand_name >>>计费平台会员管理进行更改。


## 工作空间锁定 {#workspace-lock}

### 锁定 {#lock}

<<< custom_key.brand_name >>>商业版工作空间通过绑定<<< custom_key.brand_name >>>[费用中心](../billing-center/index.md)账号或者云账号进行费用结算。

若出现费用中心<u>账号欠费或云市场订阅异常</u>等情况，则会触发锁定工作空间的动作。<<< custom_key.brand_name >>>提供为期 <font color=coral>14</font> 天的缓冲期倒计时，14 天后工作空间会被完全锁定，新数据将停止上报。


- 在 14 天倒计时内，您可以继续查看和分析历史数据，且可以[解除锁定状态](#unlock)，继续使用<<< custom_key.brand_name >>>；

![](img/9.workspace_lock_1.png)

- 在 14 天倒计时结束后，提示工作空间锁定，此时工作空间的数据会被一键清除。如果还有使用<<< custom_key.brand_name >>>产品的需要，可以选择切换工作空间，或直接点击下方新建工作空间。

![](img/9.workspace_lock_2.png)
    
???+ abstract "工作空间锁定说明"

    - <<< custom_key.brand_name >>>费用中心账号按照[账单](../cost-center/billing-management.md)周期结算。账单生成后，您将收到<u>账单生成通知</u>的电子邮件。如果您的账户欠费，则会同时提供 <font color=coral>14</font> 天结算周期，临近 14 天结束会再次向您发送倒计时电子邮件通知。若 14 天后仍未结算，相关工作空间将被锁定。


### 解锁 {#unlock}

如上所述，在工作空间锁定提示页面，点击**立即解锁**跳转到观测费用中心的**工作空间管理**页面，无需登录。您可以[更改结算方式](../../billing/billing-account/index.md)为当前工作空间，或者点击左上角的**观测费用中心**进入主页为当前账户充值。

> 更多充值方式，请参见文档 [账户钱包](../../billing/cost-center/account-wallet/index.md)。

???+ abstract "不同的解锁场景"

    - 企业认证账户充值后将按照账单结算。结算后，将解锁相关工作空间；   

    - 对于云账户结算，在**工作空间管理 > 更改结算方式**中，您可以重新绑定云账户，重新订阅相关云账户，或选择观测费用中心进行结算，操作完成后相关工作空间将自动解锁。

![](img/9.workspace_lock_3.png)

### 解散

在 14 天缓冲期倒计时内，您可以在工作空间锁定提示页面，通过点击**解散**手动删除工作空间。工作空间删除后无法恢复，请谨慎操作。

![](img/9.workspace_lock_4.png)
