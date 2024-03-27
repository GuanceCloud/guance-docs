# 公有云体验版
---

## 体验版与商业版的区别 {#trail-vs-commercial}

公有云提供的体验版、商业版，均采用<font color=coral>**按量付费**</font>的计费方式。

体验版可接入数据量规模存在限制，[升级到商业版](#upgrade-commercial)后可接入更大规模的数据量，更灵活地自定义数据存储时效。

???+ warning "体验版使用须知"

    - 体验版不升级则不收费，<u>一旦升级到商业版，不可回退</u>；
    - 体验版若升级到商业版，采集数据会继续上报到观测云工作空间，但是<u>体验版时期采集的数据将无法查看</u>；
    - 升级商业版仅支持当前工作空间拥有者查看和操作；
    - 备份日志统计的是全量数据，其他计费项都为增量数据；增量数据统计每天 0 点重置免费配额，当天有效；
    - 体验版不同计费项目若存在数据额度使用满载的情况，数据将停止上报更新；基础设施、事件这两类数据依旧支持上报更新，您仍然可以看到基础设施列表数据，事件数据；
    - 因为涉及数据内容安全问题，体验版工作空间<u>不支持快照分享</u>功能使用。

体验版和商业版所支持服务范围的区别：

| **区别** | <div style="width: 200px">项目</div>  | **体验版**    | **商业版**   |
| -------- | ---------------- | ---------- | --------- |
| 数据         | 每日数据上报限制 | 上报有限数据，超额数据不再上报       | 不限 |
|          | 数据存储策略     | 7 天循环        |自定义存储策略，更多详情，可参考 [数据存储策略](../billing/billing-method/data-storage.md) |
|          | 时间线数量 | 3000 条 | 不限    |
|          | 日志类数据数量 | 每天 100 万条<br/>日志类数据范围：事件、安全巡检、日志<br/>(不含可用性监测的日志数据) | 不限    |
|          | 应用性能 Trace 数量 | 每天 8000 个 | 不限    |
|          | 应用性能 Profile 数量 | 每天 60 个 | 不限    |
|          | 用户访问 PV 数量 | 每天 2000 个 | 不限    |
|          | 任务调用次数 | 每天 10 万次 |不限    |
|          | 可用性监测拨测任务次数 | 每天 20 万次 |  不限    |
|          | 会话重放 Session 数量 | 每天 1000 个 | 不限    |
| 功能      | 基础设施         | :heavy_check_mark: | :heavy_check_mark:    |
|          | 日志            | :heavy_check_mark:| :heavy_check_mark: | 
|          | 备份日志         | /     | :heavy_check_mark: | 
|          | 应用性能监测     | :heavy_check_mark: | :heavy_check_mark: | 
|          | 用户访问监测     | :heavy_check_mark: | :heavy_check_mark: | 
|          | CI 可视化监测    | :heavy_check_mark: | :heavy_check_mark: | 
|          | 安全巡检         | :heavy_check_mark: | :heavy_check_mark: | 
|          | 监控      | :heavy_check_mark: | :heavy_check_mark: | 
|          | 可用性监测       | 中国区拨测（每天 20 万次）      |全球拨测       |
|          | 短信告警通知     | /     | :heavy_check_mark: | 
|          | DataFlux Func    | :heavy_check_mark: | :heavy_check_mark: | 
|          | 账号权限         | 只读、标准权限提升到管理员，无需审核 | 只读、标准权限提升到管理员，需要费用中心管理员审核           |
| 服务     | 基础服务         | 社区、电话、工单支持(5 x 8 小时)     | 社区、电话、工单支持(5 x 8 小时)      |
|          | 培训服务         | 可观测性定期培训              | 可观测性定期培训      |
|          | 专家服务         | /     | 专业产品技术专家支持       |
|          | 增值服务         | /     | 互联网专业运维服务         |
|          | 监控数字作战屏   | /     | 可定制   |

## 开通体验版 {#register-trail}

在[观测云官网](https://www.guance.com/)，点击[**免费开始**](https://auth.guance.com/businessRegister)，填写相关信息后即可成为观测云用户。

1. 填写[**基本信息**](./commercial-register.md#info)；
2. 填写[**企业信息**](./commercial-register.md#corporate)
3. 在**选择开通方式**，点击当前页面右上角切换到**开通体验版工作空间**。

![](img/switch.png)

输入**工作空间名称**，选择工作空间语言和工作空间风格，按需勾选后**同步创建费用中心账号**。

点击**确定**即可开通观测云公有云体验版。

![](img/8.register_5.png)

### 体验额度查询

观测云工作空间的拥有者、管理员可以在**付费计划与账单**模块，查看各个计费项目每天的体验额度及其使用情况。

![](img/9.upgrade_1.png)

## 体验版升级到商业版 {#upgrade-commercial}

???+ warning "体验版升级须知"

    - 体验版成功升级到商业版以后，<u>无法回退</u>；
    - 采集数据会继续上报到观测云工作空间，但是<u>体验版时期采集的数据将无法查看</u>。

### 前置条件

- 注册[观测云控制台](https://console.guance.com/)账号，已有体验版工作空间；
- 同步创建[观测云费用中心](https://boss.guance.com/)账号，对接后续费用结算功能。

### 进入升级页面

登录控制台**付费计划与账单**，点击**升级**，进入**套餐升级**页面：

![](img/9.upgrade_1.png)

在**套餐升级**页面，点击**升级**。观测云支持<u>按需购买，按量付费</u>。

> 更多版本计费逻辑，可参考 [计费方式](../billing/billing-method/index.md)。

![](img/9.upgrade_2.png)

### 绑定费用中心账号

输入已经在[观测云费用中心](https://boss.guance.com/)注册的账号进行绑定，此处会对**用户名**进行校验，<u>请输入已开通观测云费用中心账号的**用户名**</u>。

![](img/9.upgrade_3.png)

若尚未注册费用中心账号，需**注册新账号**后再绑定。

![](img/7.biling_account_5.png)

填写相关信息，查看开通协议并同意，协议同意后即可收到开通提醒邮件。

### 升级成功

阅读并选择同意协议后，该工作空间即成功升级到商业版。

![](img/9.upgrade_5.png)

<!--
### 选择结算方式

由体验版成功升级到商业版后，默认使用观测云费用中心账号结算。

若需要更改其他结算方式，可以点击上图的**绑定结算云账号**按钮。目前观测云支持[三种结算方式](./billing-account/index.md)。

![](img/1.upgrade_account.png)

若未登记过云账号，可选择**阿里云账号**或者 **AWS 云账号**，在弹出的对话框中选择结算方式，具体步骤可参考 [开通阿里云账号结算方式](../billing/billing-account/aliyun-account.md) 或 [在 AWS 订阅观测云](../billing/billing-account/aws-account.md)。

![](img/9.upgrade_7.png)

若选择使用观测云账号结算，可直接关闭**更改结算方式**对话框。后续若需要可在观测云费用中心**工作空间管理**更改结算方式。

![](img/9.upgrade_9.png)
-->

## 查看商业版

返回观测云付费计划与账单，可以看到当前工作空间已经升级到**商业版**。

点击右上角**费用中心**，即可自动跳转到观测云费用中心。

![](img/9.upgrade_10.png)

## 更多阅读


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **观测云产品服务快速入门**</font>](../getting-started/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **如何更改结算方式？**</font>](../billing/faq/settlement-bill.md#switch)

</div>