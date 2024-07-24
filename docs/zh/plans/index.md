---
icon: zy/plans
---
# 开始观测


![](img/background.png)


## 工作空间产生的流量如何结算？

在工作空间内调用各项服务时，会产生对应流量数据。这部分的结算涉及两个流程：

:material-numeric-1-circle: 统计工作空间产生的数据量规模。  
:material-numeric-2-circle: 根据实际流量生成账单明细。

流量数据在工作空间中产生，并**以工作空间为单位单独进行存储，并同步到费用中心生成账单**。

因此：两个流程分别在工作空间和费用中心独立进行，通过关联费用中心帐号 ID 实现费用同步。

<img src="img/background-1.png" width="60%" >

## 费用结算时必备的两个账号


:material-numeric-1-circle: 观测云控制台帐号：与工作空间绑定，统计此帐号下空间的数据量接入规模、账单明细等；可同步到指定的费用中心账号。

:material-numeric-2-circle: 观测云费用中心帐号：可与一个/多个工作空间绑定，实现统一的费用管理。

**注意**：工作空间可以单个进行计费，也可以多个工作空间绑定共同计费。

### 为什么需要两个账号？

结算流程主要包括两个方面。一方面，在观测云控制台账号下创建工作空间，并在该工作空间内进行数据流量的存储和统计。另一方面，将费用中心账号与工作空间进行绑定，从而能够获取对应工作空间下的账单数据，最后根据用户选定的方式进行结算。

<img src="img/background-2.png" width="70%" >


案例说明：

![](img/background-3.png)

## 观测云支持哪些结算方式？


:material-numeric-1-circle: 进入[费用中心](https://boss.guance.com/)，直接使用费用中心帐号进行结算。您只需在费用中心账号中进行充值、购买预购卡等，就可以完成账单支付。

:material-numeric-1-circle: 支持云厂商帐号结算，目前支持华为云、阿里云、亚马逊三大云平台。


## 如何开通观测云？

| 账号注册入口 |  |  |
| --- | --- | --- |
| [观测云官网注册](./commercial-register.md) |  |  |
| 云厂商注册 | [华为云云商店开通](./commercial-huaweiyun.md) | [AWS 云市场开通](./commercial-aws.md) |
|  | [阿里云云市场开通](./commercial-aliyun.md) | [阿里云海外云市场开通](./en-alicloud.md) |

## 常见问题

:material-chat-question: 在观测云官网和云厂商开通观测云服务有什么区别？

两个渠道都能正常开通观测云服务，主要区别在于**开通服务后结算方式的可选性**。

- 在观测云官网开通时，您可以选择观测云费用中心或云厂商帐号结算；     
- 在对应的云厂商开通时，您只能以该云厂商帐号进行结算。

所以，如果您已经有了意向的结算方式，可以根据结算方式来选择开通渠道。


:material-chat-question: 费用中心账号和工作空间如何绑定？

- 如果您是新注册用户，在观测云官网注册流程中，您会同时创建好观测云控制台账号、费用中心账号和工作空间，工作空间会自动与账号进行绑定。

- 如果您是通过云厂商渠道进行结算的，那么在云厂商订购观测云服务成功后，会有绑定工作空间的流程，您可以根据需要选择可绑定的工作空间。


:material-chat-question: 为什么需要使用两个账号？

工作空间在控制台账号下进行创建，而工作空间进行费用结算时可以多个工作空间合并结算，两个流程单独进行，因此需要两个账号分别管控。

                                        
:material-chat-question: 如何确定自己有没有观测云控制台账号和费用中心账号？

观测云控制台账号用于官网登录：https://www.guance.com。**账号的唯一凭证是邮箱**。

费用中心账号可在**观测云工作空间 > 付费计划与账单**查看。如有费用中心帐号，则结算账号可以正常显示；或者直接登录费用中心平台：https://boss.guance.com。**费用中心账号的唯一凭证是用户名**。


:material-chat-question: 我已开通观测云体验版，如何升级商业版？

可查看[文档](./trail.md)。

<!--
<div class="grid cards" markdown>

-   __公有云商业版__

    ---

    包括[`在观测云注册商业版`](./commercial-register.md)、[`阿里云云市场开通商业版`](./commercial-aliyun.md)、[`AWS 云市场开通商业版`](./commercial-aws.md)、[`华为云云市场开通商业版`](./commercial-huaweiyun.md) 等内容。

    <br/>
    [**:octicons-arrow-right-24: 更多**](./commercial.md)


-   __公有云体验版__

    ---

    包括[`体验版与商业版的区别`](./trail.md#trail-vs-commercial)、[`开通体验版`](./trail.md#register-trail)、[`从体验版升级到商业版`](./trail.md#upgrade-commercial) 等内容。

    <br/>
    [**:octicons-arrow-right-24: 更多**](./trail.md)

-   __私有云部署版__

    ---

    介绍[`私有云部署版`](./deployment.md)相关内容。

    <br/>
    [**:octicons-arrow-right-24: 更多**](./deployment.md)

-   __专属存储版__

    ---

    介绍 [`SaaS 专属存储版`](./independent-storage.md)相关内容。

    <br/>
    [**:octicons-arrow-right-24: 更多**](./independent-storage.md)

</div>

<br/>

<br/>
-->