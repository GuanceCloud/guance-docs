# 注册商业版
---

您可以在 [观测云官网](https://www.guance.com/) ，「[立即注册](https://auth.guance.com/businessRegister)」为观测云用户。

## 输入基本信息

在基本信息页面，选择站点、输入注册信息，点击“下一步”。

-  站点：观测云提供多个注册登录站点，您可以根据结算方式来选择合适站点进行注册登录，更多详情可参考文档 [选择注册站点](../getting-started/necessary-for-beginners/select-site.md) 。
- 用户名：注册时输入的「用户名」同时用来注册观测云费用中心的账号，费用中心的用户名账号会检查唯一性，一旦注册不能修改。

![](img/1-aliyun-register-1109.png)

## 输入企业信息

在企业信息页面，输入企业信息，点击“注册”。

![](img/11.account_center_4.png)

## 选择开通方式

观测云目前提供“中国区1（杭州）”、“中国区2（宁夏）”、“中国区4（广州）”以及“海外区1（俄勒冈）”四个站点，不同的站点对应不同的结算方式。关于结算方式的详情可参考文档  [观测云结算方式](../billing/billing-account/index.md) 。

> 注意：不同站点的账号和数据相互独立，无法互相共享和迁移数据，请谨慎选择。

| 站点              | 登录地址 URL                                                 | 结算方式           |
| ----------------- | ------------------------------------------------------------ | ------------------ |
| 中国区1（杭州）   | [https://auth.guance.com/](https://auth.guance.com/login/pwd) | 阿里云账号结算     |
| 中国区2（宁夏）   | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) | AWS 账号结算       |
| 中国区4（广州）   | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | 观测云企业账号结算 |
| 海外区1（俄勒冈） | [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS 账号结算       |

### 阿里云账号结算

若您在注册时选择 “中国区1（杭州）”站点，观测云默认提供阿里云账号结算，工作空间内产生的所有费用会直接从您的阿里云账户中进行结算。

您可以在「选择开通方式」，填写「工作空间名称」，点击「[前往阿里云免费开通观测云服务](https://market.aliyun.com/products/56838014/cmgj00053362.html)」获取并填写「[阿里用户 ID](../billing/billing-account/aliyun-account.md#uid)」、「[商品实例ID](../billing/billing-account/aliyun-account.md#entity-id)」，点击「确定」即可完成注册。

???+ attention

    对于阿里云用户来说，您也可以通过以下方式直接开通观测云进行使用。
    
    - 您可以直接在  [阿里云市场观测云](https://market.aliyun.com/products/56838014/cmgj00053362.html) ，购买观测云并直接通过免登注册开通观测云，更多详情步骤可参考文档 [阿里云市场开通观测云商业版](commercial-aliyun.md)
    - 若您是阿里云 SLS 用户，需要在观测云使用 SLS 存储方式，您可以直接在  [阿里云市场观测云专属版](https://market.aliyun.com/products/56838014/cmgj00060481.html) ，购买观测云专属版并直接通过免登注册开通观测云专属版，更多详情步骤可参考文档 [阿里云市场开通观测云专属版](commercial-aliyun-sls.md) 。

![](img/8.register_1.png)

### AWS 账号结算

若您在注册时选择 “中国区2（宁夏）”、“海外区1（俄勒冈）”站点，观测云默认提供 AWS 账号结算，工作空间内产生的所有费用会直接从您的 AWS 账户中进行结算。

您可以在「选择开通方式」，点击「 [前往亚马逊云市场订阅](../billing/billing-account/aws-account.md#subscribe) 」，在 AWS 订阅观测云。完成订阅以后，在下面的对话框输入「工作空间名称」，点击「确定」即可完成注册。

![](img/8.register_3.png)



### 观测云企业账号结算

若您在注册时选择 “中国区4（广州）”站点，观测云默认提供观测云企业账号结算，工作空间内产生的所有费用会直接从您的观测云费用中心中进行结算。更多详情可参考文档 [观测云企业账号结算](../billing/billing-account/enterprise-account.md) 。

您可以在「选择开通方式」，在下面的对话框输入「工作空间名称」，点击「确定」即可完成注册。

![](img/8.register_4.png)

### 开通体验版

若您想开通体验版，您可以在「选择开通方式」的右上角，点击切换到「开通体验版工作空间」，输入「工作空间名称」，点击「确定」即可完成注册。开通体验版以后，若您需要升级到商业版，您可以参考文档 [升级商业版](commercial-version.md) 。

> 注意：体验版工作空间仅支持部分核心功能，数据存储时长为 7 天，且每日数据上报存在上限。

![](img/8.register_5.png)

## 开通成功

选择开通方式后，若注册成功，提示成功开通观测云。

![](img/1.sls_8.png)

## 开始使用观测云

首次注册进入工作空间，可观看观测云介绍小视频，或者您可以点击“从安装 DataKit 开始”即可安装配置第一个 DataKit 。

![](img/1-free-start-1109.png)

您可以在观测云付费计划与账单，查看当前工作空间的版本。

![](img/12.billing_1.png)
