# 智能巡检
---

智能巡检基于观测云的智能检测算法，支持自动检测基础设施和应用程序问题，帮助用户发现 IT 系统运行过程中发生的问题，通过根因分析，快速定位异常问题原因；通过观测云的智能预测算法，帮助用户提前预见基础设施和应用程序的潜在问题，评估问题对系统运行的影响等级，更好的确定排障工作的优先级，减少排障过程的不确定性。

智能巡检目前支持三种巡检模板以及自建巡检：

- [内存泄漏](memory-leak.md)：检测当前工作空间主机是否存在内存泄漏问题
- [磁盘使用率](disk-usage.md)：检测当前工作空间主机的磁盘是否存在使用率过高问题
- [应用性能检测](apm.md)：检测当前工作空间服务 QPS、平均响应时间、P90响应时间以及错误率是否存在波动变化
- [自建巡检](../../developers/custom-bot-obs.md)：支持使用脚本市场中的「观测云自建巡检 Core 核心包」脚本包在 DataFlux Func 中自定义巡检函数

![](../img/9.bot_obs_1.png)

## 操作说明

| **操作**     | **说明**                                                     |
| ------------ | ------------------------------------------------------------ |
| 启动/禁用    | 观测云支持启用/禁用已有的智能巡检。<br><li>禁用：将不再触发巡检事件；<br><li>启动：将基于启动时间重新开始智能巡检并触发相关事件。 |
| 导出    | 观测云支持“导出 JSON 配置”。导出文件名格式：智能巡检名称.json |
| 编辑         | 观测云支持对已有的智能巡检进行重新编辑，通过点击「编辑」按钮即可对智能巡检的筛选条件、告警策略进行重新编辑。 |
| 查看相关事件 | 通过「查看相关事件」操作按钮，可直接跳转到由该智能巡检触发的全部事件列表，详情可参考 [事件管理](../../events/explorer.md) 。<br>注意：触发的智能巡检事件都是 status = error 的状态。 |
