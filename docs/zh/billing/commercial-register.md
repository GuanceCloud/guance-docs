# 注册商业版
---

在 [观测云官网](https://www.guance.com/) ，点击「[免费注册](https://auth.guance.com/businessRegister)」，填写相关信息后即可成为观测云用户。

## 第一步：基本信息 {#info}

在「基本信息」页面，选择站点、输入注册信息，点击「下一步」。

![](img/commercial-register-1.png)

### 站点说明 {#site}

观测云提供多个注册站点，可根据您当前云环境或者结算方式等实际情况，选择对应站点。

???+ attention

    - 不同站点的账号和数据相互独立，无法互相共享和迁移数据，请谨慎选择。
    - 注册商业版的同时，会根据您所选择的站点，设置对应的默认结算方式，后续也可按需修改。<br/>
    > 更多详情可参考文档 [<费用结算方式>](../billing/billing-account/index.md)。

| 站点    | 登录地址 URL    |  运营商 |默认结算方式           |
| ----------------- | ---------------- | ------------------ |--- |
| 中国区1（杭州）   | [https://auth.guance.com/](https://auth.guance.com/login/pwd) |阿里云（中国杭州） | [阿里云账号结算](#aliyun)    |
| 中国区2（宁夏）   | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) |AWS（中国宁夏） | [AWS 账号结算](#aws)        |
| 中国区4（广州）   | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | 华为云（中国广州） |[观测云企业账号结算](#guanceyun) |
| 海外区1（俄勒冈） | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS（美国俄勒冈） |[AWS 账号结算](#aws)      |

### 用户名说明

在此页面注册「[观测云控制台账号](https://auth.guance.com/businessRegister)」的同时，会为您注册**相同「用户名」**的「[观测云费用中心账号](https://boss.guance.com/)」，费用中心的用户名账号会检查唯一性，一旦注册不能修改。

> 更多详情可参考文档 [<费用中心>](../billing/cost-center/index.md)。

#### 绑定费用中心用户名账号

在此页面注册时，您可以直接绑定费用中心用户名账号，输入用户名以后，在提示框中选择“仍想使用此用户名注册？”。

![](img/9.billing_account_1.png)

输入费用中心的用户名账号和密码。

![](img/9.billing_account_2.png)

绑定完成后**用户名**不能再修改，请谨慎操作。

![](img/9.billing_account_3.png)

## 第二步：企业信息

在「企业信息」页面，输入相关信息，点击「注册」。

![](img/11.account_center_4.png)

## 第三步：选择开通方式

根据[「第一步：基本信息」](#info)中所选择的站点，第三步会显示对应默认的开通方式页面。

> 费用结算方式详情，可参考文档 [<观测云费用结算方式>](../billing/billing-account/index.md) 。

### 工作空间名称

工作空间即为观测云数据洞察的协作空间，用户可以在工作空间进行数据查询与分析，支持自定义工作空间名称。

### 工作空间语言

工作空间语言选项会影响工作空间内事件、告警、短信等模板。若选择英文，上述对应模板将默认使用英文模板，一旦创建，此工作空间的模版语言不可修改，请谨慎选择。

### 阿里云账号结算 {#aliyun}

若您在注册时选择 “**中国区1（杭州）**” 站点，观测云默认提供阿里云账号结算，工作空间内产生的所有费用会直接从您的阿里云账户中进行结算。

您可以在「选择开通方式」，填写「工作空间名称」，选择「工作空间语言」，点击「[前往阿里云免费开通观测云服务](https://market.aliyun.com/products/56838014/cmgj00053362.html)」获取并填写「[阿里用户 ID](../billing/billing-account/aliyun-account.md#uid)」、「[商品实例ID](../billing/billing-account/aliyun-account.md#entity-id)」，点击「确定」即可完成注册。

???+ attention

    对于阿里云用户来说，您也可以通过以下方式直接开通观测云进行使用。
    
    - 您可以直接在 [阿里云市场观测云](https://market.aliyun.com/products/56838014/cmgj00053362.html) ，购买观测云，并直接通过免登注册开通观测云。<br/>
    > 更多详情步骤可参考文档 [<阿里云市场开通观测云商业版>](commercial-aliyun.md)
    - 若您是阿里云 SLS 用户，且需要在观测云使用 SLS 存储方式，您可以直接在 [阿里云市场观测云专属版](https://market.aliyun.com/products/56838014/cmgj00060481.html) ，购买观测云专属版，并直接通过免登注册开通观测云专属版。<br/>
    > 更多详情步骤可参考文档 [<阿里云市场开通观测云专属版>](commercial-aliyun-sls.md) 、[<观测云商业版和观测云专属版的区别>](../billing/faq.md#_5)。

![](img/4.register_language_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 阿里云账号结算 文档</font>](./billing-account/aliyun-account.md)

<br/>

</div>

### AWS 账号结算 {#aws}

若您在注册时选择 “**中国区2（宁夏）**”、“**海外区1（俄勒冈）**”站点，观测云默认提供观测云企业账号结算，您可以在「[观测云费用中心](https://boss.guance.com/)」，进入「工作空间管理」更换结算方式为 AWS 账号结算，更换以后，工作空间内产生的所有费用会直接从您的 AWS 账户中进行结算。

您可以在「选择开通方式」，点击「 [前往亚马逊云市场订阅](../billing/billing-account/aws-account.md#subscribe) 」，在 AWS 订阅观测云。完成订阅以后，在下面的对话框输入「工作空间名称」，选择「工作空间语言」，点击「确定」即可完成注册。

![](img/4.register_language_2.1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; AWS账号结算 文档</font>](./billing-account/aws-account.md)

<br/>

</div>

### 观测云企业账号结算 {#guanceyun}

若您在注册时选择 “**中国区4（广州）**”站点，观测云默认提供观测云企业账号结算，工作空间内产生的所有费用会直接从您的「[观测云费用中心](https://boss.guance.com/)」所购买的代金券、华为云储值卡余额等进行结算。

您可以在「选择开通方式」，在下面的对话框输入「工作空间名称」，选择「工作空间语言」，点击「确定」即可完成注册。

![](img/4.register_language_2.2.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 观测云企业账号结算 文档</font>](./billing-account/enterprise-account.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 华为云储值卡结算 文档</font>](./billing-account/huaweicloud-account.md)

</div>

## 第四步：开通成功

成功选择开通方式后，将会提示成功开通观测云商业版。

![](img/1.sls_8.png)

登陆工作空间后，可以在观测云「付费计划与账单」模块，查看当前工作空间的版本信息。

![](img/12.billing_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 商业版「付费计划与账单」模块介绍</font>](../billing/commercial.md#_4)

<br/>

</div>

若您注册时，只完成了第二步，登录时会提示创建工作空间，选择需要创建的工作空间类型即可完成注册登录。

![](img/4.register_language_3.png)


## 开始使用观测云

首次注册进入工作空间，可观看观测云介绍小视频，或者您可以点击“从安装 DataKit 开始”即可安装配置第一个 DataKit 。

![](img/1-free-start-1109.png)


