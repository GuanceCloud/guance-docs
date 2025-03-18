# Status Page
---

<<< custom_key.brand_name >>>提供 Status Page，帮助用户实时查看<<< custom_key.brand_name >>>不同站点的服务状态，以及历史上发生的问题和处理记录。

<<< custom_key.brand_name >>>会实时关注各个站点的服务状态，若发生服务问题，会第一时间进行处理解决。若您在使用<<< custom_key.brand_name >>>的过程中发现异常，您可以及时查看<<< custom_key.brand_name >>>的服务状态来判断异常原因，如您发现日志无法上报，可以关注<<< custom_key.brand_name >>>的日志服务是否正常。

## 服务站点

若您已经登录到<<< custom_key.brand_name >>>，您可以通过点击左下角的**帮助 > Status Page** 来查看<<< custom_key.brand_name >>>各个站点的服务状态。

<img src="../img/6.status_page_1.png" width="50%" >

点击订阅图标，即可监测当前站点的服务运行状态。订阅成功后，若服务运行状态出现异常会向您发送邮件通知。

**注意**：<<< custom_key.brand_name >>>将对站点下工作空间的各功能模块以 1 分钟/次的频率进行检测，5 分钟进行一次检测汇总。5 分钟内，存在一次异常即判定此次汇总为异常。若连续 6 次（即 30 分钟）为连续的异常事件，则会触发告警通知邮件。第一次异常告警通知后，若第一次检测该功能模块（即 5 分钟一次的检测汇总）为正常，则判定异常事件已恢复正常。

您也可以直接点击以下链接查看<<< custom_key.brand_name >>>各个站点的服务状态。

| 站点              | 服务状态 URL            | 运营商       |
| :---------------- | :-------------------- | :----------- |
| 中国区1（杭州）   | [https://status.<<< custom_key.brand_main_domain >>> ](https://status.<<< custom_key.brand_main_domain >>> /)        | 阿里云（中国杭州） |
| 中国区2（宁夏）   | [https://aws-status.<<< custom_key.brand_main_domain >>> ](https://aws-status.<<< custom_key.brand_main_domain >>> /) | AWS（中国宁夏）    |
| 中国区3（张家口） | [https://cn3-status.<<< custom_key.brand_main_domain >>> ](https://cn3-status.<<< custom_key.brand_main_domain >>> ) | 阿里云（中国杭州） |
| 中国区4（广州）   | [https://cn4-status.<<< custom_key.brand_main_domain >>> ](https://cn4-status.<<< custom_key.brand_main_domain >>> /) | 华为云（中国广州） |
| 海外区1（俄勒冈） | [https://us1-status.<<< custom_key.brand_main_domain >>> ](https://us1-status.<<< custom_key.brand_main_domain >>> /) | AWS（美国俄勒冈）  |

## 服务状态

<<< custom_key.brand_name >>>支持实时查看不同站点的服务状态，包括正常、异常、延迟和维护。

| 服务状态 | 状态说明                                         |
| :------- | :--------------------------------------------- |
| 正常     | 表示当前站点的服务正常工作，数据断档丢失。             |
| 异常     | 表示当前站点的服务发生异常，存在数据丢失的可能   |
| 延迟     | 表示当前站点的服务发生延时，数据断档丢失，查询数据延迟 |
| 维护     | 表示<<< custom_key.brand_name >>>技术人员正在对当前站点进行维护          |

### 异常/延迟判断逻辑

在 Status Page，您可以查看事件、基础实施、用户访问监测、应用性能监测、指标、日志、可用性监测、安全巡检、CI 可视化等功能模块的状态，下图是各个功能模块的数据处理过程，主要包括数据采集、数据处理和数据存储。

![](img/2.status_page.png)

<<< custom_key.brand_name >>>的 Status Page 基于以上的数据处理过程，在数据处理和数据存储这两个过程进行服务状态的判断，如下表所示：

| 判断项       | 判断条件      |   服务状态     |    示例说明      |
| :----------- | :----------- |:------------- |:-------------- |
| 数据推送失败率     | 大于 90%       | 异常             |  采集日志数据，从 Kodo 推送数据到消息队列的失败率大于 90%，此时日志服务的状态为异常。        | 
| 数据入库失败率       | 大于 90%       | 异常             |  采集日志数据，从 Kodo-x 写入数据库的失败率大于 90%，此时日志服务的状态为异常。        | 
| 消息订阅延迟 P99   | 大于 5 分钟     | 延迟             |  采集应用性能数据，消息队列发送到 Kodo-x 的数据延迟 P99 超过 5 分钟，此时应用性能监测服务的状态为延迟。        | 

### 查看服务状态

在<<< custom_key.brand_name >>>服务状态页面，您可以：

- 点击切换查看所有站点的服务状态； 

- 实时刷新服务状态； 

- 查看事件、基础实施、用户访问监测、应用性能监测、指标、日志、可用性监测、安全巡检、CI 功能模块的当前状态和最近 24 小时状态；       

- 切换查看历史事故。

![](img/2.status_page_2.png)

## 历史事故

在历史事故页面，您可以：

- 查看每月发生的所有服务故障；
 
- 切换查看服务状态。

![](img/6.status_page_3.png)









