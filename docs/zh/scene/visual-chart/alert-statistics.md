# 告警统计图
---

## 简介

异常检测的告警事件，告警统计图共分为两个部分，分别为统计图和告警列表。

- 统计图：将事件按等级分组并统计每个等级的事件数量，支持点击统计图跳转查询事件的详情；
- 告警列表：显示所选时间范围内未恢复的告警事件。
## 图表查询

- 搜索：输入关键字查询事件内容
- 筛选：支持添加标签筛选对日志数据进行过滤

## 图表样式
| 选项 | 说明 |
| --- | --- |
| 图表标题 | 为图表设置标题名称，设置完成后，在图表的左上方显示，支持隐藏 |
| 显示项 | 显示全部、仅统计图或者仅告警列表 |

## 图表设置
### 高级设置
| 选项 | 说明 |
| --- | --- |
| 锁定时间 | 支持锁定图表查询数据的时间范围，不受全局时间组件的限制。设置成功后的图表右上角会出现用户设定的时间，如【xx分钟】、【xx小时】、【xx天】。如锁定时间间隔30分钟，那么当调节时间组件无论查询什么时间范围视图，仍只会显示最近 30 分钟数据 |
| 图表说明 | 为图表添加描述信息，设置后图表标题后方会出现【i】的提示，不设置则不显示 |

## 示例图

下图为告警统计图示例。

![](../img/warning.png)
