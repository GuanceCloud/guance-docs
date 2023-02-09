# 公有云体验版
---

## 开通体验版

在[观测云官网](https://www.guance.com/)，点击「[免费开始](https://auth.guance.com/businessRegister)」，填写相关信息后即可成为观测云用户。

第一步「基本信息」的**选择注册站点**较为重要，请参考 [<站点说明>](../getting-started/necessary-for-beginners/select-site.md)后，按需谨慎选择。

![](img/commercial-register-1.png)

第三步「选择开通方式」，点击右上角切换到「开通体验版工作空间」，并输入「工作空间名称」，点击「确定」即可开通观测云公有云体验版。

![](img/8.register_5.png)


## 体验版与商业版区别 {#trail-vs-commercial}

公有云提供的体验版、商业版，均采用**按量付费**的计费方式。

体验版可接入数据量规模存在限制，[升级商业版](commercial-version.md)后可接入更大规模的数据量，更灵活地自定义数据存储时效。

???+ attention

    - 体验版不升级则不收费，**一旦升级到商业版，不可回退**；
    - 体验版若升级到商业版，采集数据会继续上报到观测云工作空间，但是**体验版时期采集的数据将无法查看**；
    - 升级商业版仅支持当前工作空间拥有者查看和操作；
    - 时间线和备份日志统计的是全量数据，其他计费项都为增量数据；增量数据统计每天 0 点重置免费配额，当天有效；
    - 体验版不同计费项目若存在数据额度使用满载的情况，数据将停止上报更新；基础设施、事件这两类数据依旧支持上报更新，您仍然可以看到基础设施列表数据，事件数据。

下面是体验版和商业版所支持服务范围的区别。

| **区别** | **项目**  | **体验版**    | **商业版**   |
| -------- | ---------------- | ---------- | --------- |
| 数据  | <div style="width: 150px"> DataKit 数量 </div>   | <div style="width: 240px"> 不限 </div>    | 不限    |
|          | 每日数据上报限制 | 有限数据上报，超额数据不再上报       | 不限 |
|          | 数据存储策略     | 7 天循环        |自定义存储策略，更多详情可参考文档 [数据存储策略](../billing/billing-method/data-storage.md) |
|          | 时间线数量 | 3000 条 | 不限    |
|          | 日志类数据数量 | 每天 100 万条<br/>日志类数据范围：事件、安全巡检、日志<br/>(不含可用性监测的日志数据) | 不限    |
|          | 应用性能 Trace 数量 | 每天 8000 个 | 不限    |
|          | 用户访问 PV 数量 | 每天 2000 个 | 不限    |
|          | 任务调用次数 | 每天 10 万次 |不限    |
| 功能      | 基础设施         | :white_check_mark: | :white_check_mark:    |
|          | 日志            | :white_check_mark:| :white_check_mark: | 
|          | 备份日志         | /     | :white_check_mark: | 
|          | 应用性能监测     | :white_check_mark: | :white_check_mark: | 
|          | 用户访问监测     | :white_check_mark: | :white_check_mark: | 
|          | CI 可视化监测    | :white_check_mark: | :white_check_mark: | 
|          | 安全巡检         | :white_check_mark: | :white_check_mark: | 
|          | 监控      | :white_check_mark: | :white_check_mark: | 
|          | 可用性监测       | 中国区拨测（每天 20 万次）      |全球拨测       |
|          | 短信告警通知     | /     | :white_check_mark: | 
|          | DataFlux Func    | :white_check_mark: | :white_check_mark: | 
|          | 账号权限         | 只读、标准权限提升到管理员，无需审核 | 只读、标准权限提升到管理员，需要费用中心管理员审核           |
| 服务     | 基础服务         | 社区、电话、工单支持(5 x 8 小时)     | 社区、电话、工单支持(5 x 8 小时)      |
|          | 培训服务         | 可观测性定期培训              | 可观测性定期培训      |
|          | 专家服务         | /     | 专业产品技术专家支持       |
|          | 增值服务         | /     | 互联网专业运维服务         |
|          | 监控数字作战屏   | /     | 可定制   |


## 体验额度查询

观测云工作空间的拥有者、管理员，可以在「控制台」-「付费计划与账单」模块，查看各个计费项目每天的体验额度及其使用情况。<br/>
若需要 [升级到商业版](commercial-version.md)，可以点击「升级」按钮。

![](img/9.upgrade_1.png)

## 更多阅读

<[快速入门](https://docs.guance.com/getting-started/)>

<[升级到商业版](commercial-version.md)>







