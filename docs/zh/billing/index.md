---
icon: zy/billing
---
# 付费计划与账单
---
## 版本说明

观测云现有体验版、商业版、私有云部署版三种版本。

- 公有云提供的体验版、商业版，均采用<font color=coral>**按量付费**</font>的计费方式，在核心功能上并无差异。

    - [体验版的可接入数据量规模](trail.md#trail-vs-commercial)存在限制，<u>商业版用户支持接入更大规模的数据量，及更灵活的数据存储时效</u>。

- 私有云部署版，也提供了社区版（即体验版）、商业版。

    - 商业版可灵活选择<u>按量付费、订阅制、许可证制</u>多种计费方式。

???+ abstract "当前工作空间版本的查看方式"

    - 所有成员角色：可以在观测云控制台**管理 > 设置 > 基本信息 > 当前版本**中查看；
    - 拥有者、管理员：还可以在观测云控制台**付费计划与账单**中查看。

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 公有云商业版</font>](commercial.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 公有云体验版</font>](trail.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 私有云部署版</font>](../deployment/deployment-description.md#_4)

</div>

## 费用中心

现有两套独立运行、统计数据量相关连的账号体系，共同为<u>商业版用户</u>实现用量计费与费用结算流程：

- [观测云控制台](https://console.guance.com/)账号，可统计当前工作空间的数据量接入规模、账单明细等，同步到指定的费用中心账号。
- [观测云费用中心](https://boss.guance.com/)账号，可通过 `工作空间 ID` 进行绑定，实现<u>工作空间级别的统一费用管理</u>，并提供了多种费用结算方式供您选择。

![](img/billing-index-1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 费用中心</font>](./cost-center/index.md)

<br/>

</div>

## 用量计费方式

观测云工作空间的商业版用户，采用的是<font color=coral>**按量付费**</font>的计费方式，通过计费周期、计费项、计费价格、计费模式等不同的纬度，综合计算出当前的费用情况。

工作空间的拥有者、管理员，可以在观测云控制台**付费计划与账单**模块，查看该工作空间的数据量接入情况及对应的账单明细；其他成员角色，暂不开放**付费计划与账单**模块。

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 用量计费方式</font>](./billing-method/index.md)

<br/>

</div>

## 费用结算方式

观测云控制台计算出当前工作空间的账单详情后，会同步推送到所绑定的观测云费用中心账号，进行后续费用结算流程。

现支持观测云费用中心账号、云账号等多种结算方式，云账号结算包括阿里云账号、AWS 账号结算和华为云账号结算，在云账号结算模式下支持多个站点的云账单合并到一个云账号下进行结算。

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 费用结算方式</font>](./billing-account/index.md)

<br/>

</div>