# 公有云商业版
---

## 开通商业版

- [在观测云直接注册商业版](commercial-register.md)
- [在华为云云商店开通观测云商业版](commercial-huaweiyun.md)
- [在阿里云云市场开通观测云商业版](commercial-aliyun.md)
- [在 AWS 云市场开通观测云商业版](commercial-aws.md)

## 计费与结算前提

观测云工作空间的商业版用户，需要成功注册<u>观测云控制台、观测云费用中心两个账号</u>，方可进行后续的用量计费与费用结算流程。

- [观测云控制台](https://console.guance.com/)账号，可统计当前空间的数据量接入规模、账单明细等，同步到指定的费用中心账号。
- [观测云费用中心](https://boss.guance.com/)账号，可通过 `工作空间 ID` 进行绑定，实现<u>工作空间级别的统一费用管理</u>，并提供了多种费用结算方式供您选择。

???+ warning

    - 若您已直接[注册商业版](./commercial-register.md)用户，注册时系统自动帮您注册相同用户名的观测云费用中心用户；  
    - 若您注册的是体验版用户，且尚未注册为观测云费用中心用户，[升级商业版](./trail.md#upgrade-commercial)操作中会提示您注册。

![](img/billing-index-1.png)


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 费用中心</font>](../billing/cost-center/index.md)

<br/>

</div>

## 付费计划与账单

观测云工作空间的拥有者查看费用情况的方法：

- 在控制台**付费计划与账单**模块，查看结算账户总览、使用统计、账单详情、使用量分析、数据转发使用分析等信息；  
- 登录[观测云费用中心](https://boss.guance.com/)，可查看更多详情信息。

???+ warning "工作空间角色差异说明"

    - 拥有者：在**付费计划与账单**，有**充值**、**费用中心**、**结算方式**、**更换绑定**按钮；<br/>
    - 管理员：在**付费计划与账单**，无上述按钮；<br/>
    - 其他成员：无**付费计划与账单**模块，即没有查看费用情况的权限。

![](img/12.billing_1.png)

### 结算账户总览 {#account}

在结算账户总览，可以查看结算账号名称、现金账户余额、代金券余额、预购卡余额，并对账户进行充值等操作。

- 充值：点击即可为账户进行充值；
- 费用中心：点击即可跳转打开观测云费用中心；
- 结算方式：点击即可更改结算方式，包括[观测云费用中心账号结算](../billing/billing-account/enterprise-account.md)、[亚马逊云账号结算](../billing/billing-account/aws-account.md)、[阿里云账号结算](../billing/billing-account/aliyun-account.md)和[华为云账号结算](../billing/billing-account/huawei-account.md)；
- 更换绑定：点击即可更换工作空间的观测云计费账号，<u>前提是当前账户与新账户必须隶属于同一企业，即在观测云费用中心两个账号的企业认证需为同一个</u>。
- 设置高消费预警：设置预警后，当计费项<u>日账单大于预警阈值</u>时，会向 Owner 和 Administrator 发送邮件通知。

    - 选择[计费项](./billing-method/index.md#item)，并选定**预警阈值**，点击**确定**，添加完成后，您将收到**观测云高消费预警通知**的邮件通知；计费项预警通知不会重复发送。

    ![](img/billing.gif)

???+ warning "操作权限"

    - **充值**、**费用中心**、**结算方式**、**更换绑定**按钮仅支持当前工作空间 Owner 查看并操作；  
    - **设置高消费预警**支持 Owner 和 Administrator 操作。

### 使用统计

在**使用统计**中，可查看计费项 DataKit、网络（主机）、时间线、日志类数据、备份日志数据容量、应用性能 Trace、应用性能 Profile、用户访问 PV、拨测次数、任务调度以及短信截止当前和截止昨日的统计数据。

### 账单详情

在**账单详情**中：可查看**累计消费金额**以及各计费项的的消费金额，同时可按今日、昨日、本周、上周、本月、上月、今年查看费用统计。

> 更多计费项的收费方式，可参考 [计费方式](billing-method/index.md)。

![](img/consumption-2.png)

### 使用量分析

在**使用量分析**中，可通过可视化的方式查看各个计费项目的使用情况。

![](img/consumption-1.png)

### 数据转发使用分析 {#transmit}

在**数据转发使用分析**模块，可查看当前工作空间所有数据转发规则的数据转发数量。同时可按今日、昨日、本周、上周、本月、上月、今年查看转发数量统计。

**注意**：

- 若转发规则是保存到观测云备份日志模块，显示对应的数据保存策略，其他的展示为 `-`。
- 此处仅列出工作空间内存在的数据转发规则且转发数量 > 0 的列表。

![](img/comm_01.png)



<!--
### 消费分析 {#consume}

在**消费分析**中，可查看昨日支出、累计支出，您也可以根据所选时间范围查看统计消费分析。


当前账单出账的指标生成逻辑：

- `bill` 表示总账单，即累计消费金额。


| 类型     | 名称     | 描述          |
| ----------- | ----------- |-------------- |
| 指标     | `money`     |应付金额          |
| 标签     | `type`     |计费项          |

- `bill_infos` 表示每日账单。


| 类型     | 名称     | 描述          |
| ----------- | ----------- | -------------- |
| 指标     | `originPrice`     | 原价          |
|      | `count`     | 使用量          |
|      | `billPrice`     | 应付金额          |
|      | `billDateTimeStamp`     | 账单日期对应的时间戳          |
|  标签| `type`     | 计费项          |
|      | `billDate`     | 账单日期          |


![](img/consumption.png)




<!--
**注意**：仅支持统计分析 6 月之后的消费数据；时间范围默认选中本月。
-->
