---
icon: zy/billing
---
# 付费计划与账单
---

观测云提供体验版、商业版、私有云部署版三个版本。在「付费计划与账单」，您可以查看观测云版本、[计费项](billing-method/index.md) 的使用情况，结算账户的余额情况，为账户充值、更换结算方式、更换绑定邮箱，查看账单列表，以及进入「[费用中心](cost-center/index.md)」查看更多账户详情。

## 体验版

您可以 [注册观测云体验版](https://auth.guance.com/businessRegister) ，注册完成后，在观测云工作空间「付费计划与账单」页面，查看体验版各个计费项目每天的体验额度以及其使用情况，若需要 [升级到商业版](commercial-version.md) ，可以点击「升级」按钮。

???+ attention

    - 升级商业版仅支持当前工作空间拥有者查看和操作；
    - 体验版不升级则不收费，一旦升级到商业版，不可回退；
    - 体验版若升级到商业版，采集数据会继续上报到观测云工作空间，但是体验版时期采集的数据将无法查看；
    - 时间线和备份日志统计的是全量数据，其他计费项都为增量数据；增量数据统计每天 0 点重置免费配额，当天有效；
    - 体验版不同计费项目若存在数据额度使用满载的情况，数据将停止上报更新；基础设施、事件这两类数据依旧支持上报更新，您仍然可以看到基础设施列表数据，事件数据。

![](img/9.upgrade_1.png)

## 商业版

您可以 [注册观测云商业版](https://auth.guance.com/businessRegister) ，注册完成后，在观测云工作空间「付费计划与账单」页面，查看结算账户的余额情况，为账户充值、更换结算方式、更换绑定邮箱，查看账单列表、使用统计视图，或进入「[费用中心](cost-center/index.md)」查看更多账户详情。

![](img/12.billing_1.png)

#### 结算账户总览

在结算账户总览，您可以查看结算账号名称、现金账户余额、代金券余额、储值卡余额，并对账户进行充值等操作。

- 充值：点击即可为账户进行充值。
- 费用中心：点击即可跳转打开观测云费用中心；
- 结算方式：点击即可更改结算方式，包括 [观测云企业账号结算](billing-account/enterprise-account.md)、[亚马逊云账号结算](billing-account/aws-account.md) 和 [阿里云账号结算](billing-account/aliyun-account.md) ；
- 更换绑定：点击即可更换工作空间的观测云计费账号，**前提是当前账户与新账户必须隶属于同一企业，即在观测云费用中心两个账号的企业认证需为同一个**；

> 注意：「充值」、「费用中心」、「结算方式」、「更换绑定」按钮仅支持当前工作空间拥有者查看并操作。

#### 使用统计

在「使用统计」中，可查看计费项 DataKit、网络（主机）、时间线、日志类数据、备份日志数据容量、应用性能 Trace、应用性能 Profile、用户访问 PV、拨测次数、任务调度以及短信截止当前和截止昨日的统计数据。

#### 账单列表

在「账单列表」中：可查看“累计消费金额”以及各计费项的的消费金额，同时可按不同月份查看每天的费用统计。更多计费项的收费方式可参考文档 [计费方式](billing-method/index.md) 。

#### 使用统计视图

在「使用统计视图」中，可通过可视化的方式查看各个计费项目的使用情况。


## 私有云部署版 {#cloudpaas}

若您需要体验观测云社区版，或者使用观测云私有云部署版，您可以在体验版的「付费计划与账单」页面，点击「升级」，进入套餐升级。在「套餐升级」页面，可查看观测云的私有云部署版和社区版的介绍。您可以点击“了解详情”获取更多版本详情。

![](img/10.account_3.png)

或者点击“联系我们”，填写公司和申请人信息后提交，稍后会有客户经理和您联系。

![](img/10.account_4.png)


