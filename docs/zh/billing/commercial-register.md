# 注册商业版
---

在 [观测云官网](https://www.guance.com/) ，点击「[免费开始](https://auth.guance.com/businessRegister)」，填写相关信息后即可成为观测云用户。

## 第一步：基本信息

在「基本信息」页面，选择站点、输入注册信息，点击「下一步」。

- **站点**：观测云提供多个注册登录站点，请根据适合您的结算方式，选择对应站点。<br/>
> 请参考 [<站点说明>](../getting-started/necessary-for-beginners/select-site.md)后，按需谨慎选择。

- **用户名**：此页面输入的观测云控制台账号的「用户名」，同时会帮您自动注册观测云费用中心的账号。费用中心的用户名账号会检查唯一性，一旦注册不能修改。<br/>
> 账号体系说明，请参考 [<付费计划与账单-费用中心>](../billing/index.md#_3)

![](img/commercial-register-1.png)

## 第二步：企业信息

在「企业信息」页面，输入相关信息，点击「注册」。

![](img/11.account_center_4.png)

## 第三步：选择开通方式

根据[「第一步：基本信息」](#_2)中所选择的站点，第三步会显示对应的开通方式页面。

费用结算方式详情，可参考文档 [<观测云费用结算方式>](../billing/billing-account/index.md) 。

???+ attention

    注意：不同站点的账号和数据相互独立，无法互相共享和迁移数据，请谨慎选择。

| 站点              | 登录地址 URL                                                 | 结算方式           |
| ----------------- | ------------------------------------------------------------ | ------------------ |
| 中国区1（杭州）   | [https://auth.guance.com/](https://auth.guance.com/login/pwd) | [阿里云账号结算](#aliyun)    |
| 中国区2（宁夏）   | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) | [AWS 账号结算](#aws)        |
| 中国区4（广州）   | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | [观测云企业账号结算](#guanceyun) |
| 海外区1（俄勒冈） | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | [AWS 账号结算](#aws)      |

### 阿里云账号结算 {#aliyun}

若您在注册时选择 “中国区1（杭州）”站点，观测云默认提供阿里云账号结算，工作空间内产生的所有费用会直接从您的阿里云账户中进行结算。

您可以在「选择开通方式」，填写「工作空间名称」，点击「[前往阿里云免费开通观测云服务](https://market.aliyun.com/products/56838014/cmgj00053362.html)」获取并填写「[阿里用户 ID](../billing/billing-account/aliyun-account.md#uid)」、「[商品实例ID](../billing/billing-account/aliyun-account.md#entity-id)」，点击「确定」即可完成注册。

???+ attention

    对于阿里云用户来说，您也可以通过以下方式直接开通观测云进行使用。
    
    - 您可以直接在  [阿里云市场观测云](https://market.aliyun.com/products/56838014/cmgj00053362.html) ，购买观测云并直接通过免登注册开通观测云，更多详情步骤可参考文档 [阿里云市场开通观测云商业版](commercial-aliyun.md)
    - 若您是阿里云 SLS 用户，需要在观测云使用 SLS 存储方式，您可以直接在  [阿里云市场观测云专属版](https://market.aliyun.com/products/56838014/cmgj00060481.html) ，购买观测云专属版并直接通过免登注册开通观测云专属版，更多详情步骤可参考文档 [阿里云市场开通观测云专属版](commercial-aliyun-sls.md) 。

![](img/8.register_1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 阿里云账号结算 文档</font>](./billing-account/aliyun-account.md)

<br/>

</div>

### AWS 账号结算 {#aws}

若您在注册时选择 “中国区2（宁夏）”、“海外区1（俄勒冈）”站点，观测云默认提供 AWS 账号结算，工作空间内产生的所有费用会直接从您的 AWS 账户中进行结算。

您可以在「选择开通方式」，点击「 [前往亚马逊云市场订阅](../billing/billing-account/aws-account.md#subscribe) 」，在 AWS 订阅观测云。完成订阅以后，在下面的对话框输入「工作空间名称」，点击「确定」即可完成注册。

![](img/8.register_3.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; AWS账号结算 文档</font>](./billing-account/aws-account.md)

<br/>

</div>

### 观测云企业账号结算 {#guanceyun}

若您在注册时选择 “中国区4（广州）”站点，观测云默认提供观测云企业账号结算，工作空间内产生的所有费用会直接从您的观测云费用中心中进行结算。更多详情可参考文档 [观测云企业账号结算](../billing/billing-account/enterprise-account.md) 。

您可以在「选择开通方式」，在下面的对话框输入「工作空间名称」，点击「确定」即可完成注册。

![](img/8.register_4.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 观测云企业账号账号结算 文档</font>](./billing-account/enterprise-account.md)

<br/>

</div>

## 第四步：开通成功

选择开通方式后，若注册成功，提示成功开通观测云。

![](img/1.sls_8.png)

登陆工作空间后，可以在观测云「付费计划与账单」模块，查看当前工作空间的版本信息。

![](img/12.billing_1.png)
## 开始使用观测云

首次注册进入工作空间，可观看观测云介绍小视频，或者您可以点击“从安装 DataKit 开始”即可安装配置第一个 DataKit 。

![](img/1-free-start-1109.png)