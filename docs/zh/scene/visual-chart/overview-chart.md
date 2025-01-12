# 概览图
---


概览图可清晰显示一个关键的数值或指标的结果值，并且支持显示折线混合图，帮助了解指标趋势。

![](../img/overview.png)

## 应用场景

1. 直观显示数据结果值；  
2. 查看一个关键的数据点，例如：PV/UV。

## 图表配置

> 更多详情，可参考 [图表配置](./chart-config.md)。

### 同环比

即与上一同等时间的数据进行对比；默认显示为关闭状态。若对比的时间范围内数据断档，最直接显示为 N/A，例如：周同比 N/A。  


#### 对比维度

开启后，对比维度支持以下选项：

- 小时（与一小时前对比）
- 日（与一天前对比）
- 周（与一周前对比）
- 月（与一个月前对比）
- 环比

#### 对比逻辑

概览图的值下方会显示**升/降百分比**。

百分比计算结果为：（当前查询结果 - 对比查询结果）/ 对比查询结果 *100%。

#### 示例

| 维度 | 对比查询逻辑 | 当前查询的时间范围 | 对比查询的时间范围 | 百分比显示 |
| --- | --- | --- | --- | --- |
| 小时 | 向前推 **1h** | 【1h】3/2 10:00-3/2 11:00 | 3/2 09:00 - 3/2 10:00 | 与一小时前对比 xx% ⬆ |
| | | **今日/昨日/上周/本周/本月/上月** | **不对比** | **无** |
| 日 | 向前推 **24h** | 【1h】3/2 10:00-3/2 11:00 | 3/1 10:00 - 3/1 11:00 | 日同比 xx% ⬆ |
| | | 【今日】3/2 00:00:00 - 当前时间 | 3/1 00:00:00 - 23:59:59 | 日同比 xx% ⬆ |
| | | **上周/本周/本月/上月** | **不对比** | **无** |
| 周 | 向前推 **7d** | 【1h】3/2 10:00 - 3/2 11:00 （周三） | 2/23 10:00 - 2/23 11:00 （上周三）| 周同比 xx% ⬆ |
| | | 【今日】3/2 00:00 - 3/2 11:00 （周三） | 2/23 00:00:00-23:59:59 （上周三全天） | 周同比 xx% ⬆ |
| | | 【本周】2/28 00:00 - 当前时间 （周一到周三） | 2/21 00:00:00 - 2/27 23:59:59（上周一整周） | 周同比 xx% ⬆ |
| | | **本月/上月** | **不对比** | **无** |
| 月 | 向前推 **1mo** | 【3d】3/2 10:00 - 3/5 10:00 | 2/2 10:00 - 2/5 10:00 | 月同比 xx% ⬆ |
| | | 【今日】3/2 00:00:00 - 当前时间 | 2/2 00:00:00 - 23:59:59（上月2号全天） | 月同比 xx% ⬆ |
| | | 【本月】3/1 00:00:00-当前时间 | 2/1 00:00:00 - 2/28 23:59:59 （上月一整月） | 月同比 xx% ⬆ |
| | | 【3d】3/26 10:00 - 3/29 10:00 | 2/26 10:00 - 2/28  23:59:59（因为2月不存在29号） | 月同比 xx% ⬆ |
| | | **上周/本周** | **不对比** | **无** |
| | | **【1d】3/29 10:00 - 3/30 10:00**| **不对比（2 月不存在29、30号）** | **无** |

### 混合图

开启后，可选择面积图或柱状图同时展示在当前图表中，帮助同时查询当前指标值和指标趋势。

您还可以按需勾选显示图表的坐标轴。 

![](../img/overview-1.png)

<!--
## 图表查询

图表查询支持**简单查询**、**表达式查询**、**DQL 查询**和 **PromQL 查询**；默认添加简单查询。

> 更多图表查询条件详细说明，可参考 [图表查询](chart-query.md)。

**注意**：

- 单图表查询仅支持一条查询语句，默认为**简单查询**，点击**转换为表达式查询**切换为表达式查询，并将简单查询作为“查询A”，支持相互切换。**DQL 查询**同样适用互相切换；
- 若简单查询中使用了表达式查询不支持的转换函数，切换后，不会将函数带入到表达式查询。

## 图表链接

链接可以帮助您实现从当前图表跳转至目标页面。您可以添加平台内部链接或外部链接，能通过模板变量修改链接中对应的变量值将数据信息传送过去，实现数据联动。

> 更多相关设置说明，可参考 [图表链接](chart-link.md)。

## 常用配置

| 选项 | 说明 |
| --- | --- |
| 标题 | 为图表设置标题名称，设置完成后，在图表的左上方显示，支持隐藏。|
| 描述 | 为图表添加描述信息，设置后图表标题后方会出现【i】的提示，不设置则不显示。 |
| 单位 | **:material-numeric-1-box: 默认单位显示**：<br /><li>若查询的数据为指标数据，且您在[指标管理](../../metrics/dictionary.md)中为指标设置了单位，则默认按照指标的单位进行进位显示；<br /><li>若您在**指标管理**内无相关单位配置，则按照 [千分位](chart-query.md#thousand) 逗号间隔的数值进位方式显示。<br />**:material-numeric-2-box: 配置单位后**：<br />优先使用您自定义配置的单位进行进位显示，指标类数据支持针对数值提供两种选项：<br /><br />**科学计数说明**<br /><u>默认进位</u>：单位为万、百万，如10000 展示为 1 万，1000000 展示为 1 百万。保留两位小数点；<br /><u>短级差制</u>：单位为 K, M, B。即以 thousand、million、billion、trillion 等依次表示中文语境下的千、百万、十亿、万亿等。如 1000 为 1 k，10000 为 10 k，1000000 为 1 million；保留两位小数点。|
| 颜色 | 可为图表设置字体颜色和背景颜色。 |
| 数据格式 | 您可以选择【小数位数】以及【千分位分隔符】。<br /><li>千位分隔符默认开启，关闭后将显示原始值，无分隔符。更多详情，可参考 [数据千分位格式](../visual-chart/chart-query.md#thousand)。 |

## 高级配置

| 选项 | 说明 |
| --- | --- |
| 规则映射 | <li> 设置指标范围和对应的背景颜色、字体颜色。在范围内的指标将按设置的样式进行显示；<br /><li> 设置指标范围及映射值，当指标值在设置的数据范围内时将显示为对应的映射值；<br /><li> 当指标值同时满足多个设置时，显示为最后一个满足条件的设置样式。<br /><br />设置值映射时，【显示为】和【颜色】都不是必选/必填项：<br />&nbsp; &nbsp; &nbsp;【显示为】默认为空，即代表不做映射值显示；<br />&nbsp; &nbsp; &nbsp;【颜色】默认为空，即不做颜色映射显示其原本颜色。<br /> |
| 锁定时间 | 即固定当前图表查询数据的时间范围，不受全局时间组件的限制。设置成功后的图表右上角会出现用户设定的时间，如【xx分钟】、【xx小时】、【xx天】。 |
| 时间分片 | 开启时间分片后，会先对原始数据按照一定的时间间隔进行分段聚合，再对聚合后数据集进行第二次聚合得到结果值，默认关闭。<br /><br />若时间分片关闭，无时间间隔选项；若时间分片开启，时间间隔选项如下：<br /><li>自动对齐：开启后，将按选择的时间范围和聚合时间间隔动态的调整查询，根据计算的时间间隔就近向上取整。<br /> &nbsp; &nbsp; &nbsp;系统预设了多种时间间隔：1毫秒、10毫秒、50毫秒、100毫秒、500毫秒、1秒、5秒、15秒、30秒、1分钟、5分钟，10分钟、30分钟、1小时，6小时，12小时、1天、1周、1月；<br /><li>自定义时间间隔：当选择【锁定时间】时，根据锁定时间的长短，自动匹配不同的可选时间间隔查询显示数据。（*例如：时间间隔选择 1 分钟，那么实际将按照 1 分钟的时间间隔发起查询*）<br /><br /><br />更多详情，可参考 [时间分片说明](chart-query.md#time-slicing)。 |




| 空间授权 | 被授权的工作空间列表，选择后即可通过图表查询并展示该工作空间数据。 |
| 数据采样 | 仅针对 Doris 日志数据引擎的工作空间；开启后，会对除“指标”外的其他数据进行采样查询，采样率不固定，会根据数据量大小动态调整。 |
| 时间偏移 | 非时序数据在入库后存在至少 1 分钟的查询延迟。选择相对时间查询时，可能导致最近几分钟的数据未能被采集，从而出现数据丢失的情况。<br />启用时间偏移后，当查询相对时间区间时，实际查询时间范围向前偏移 1 分钟，以防止入库延迟导致数据获取为空。如：当前为 12:30，查询最近 15 分钟的数据，开启时间偏移后，实际查询的时间是：12:14-12:29。<br />:warning: <br /><li>该设置仅针对相对时间生效，若查询时间区间为“绝对时间范围”，时间偏移不生效。<br /><li>针对有时间间隔的图表，如时序图，设定时间间隔超出 1min 则时间偏移不生效，<= 1m 的情况下才偏移生效。针对没有时间间隔的图表，如概览图、柱状图等，时间偏移保持生效。|


-->