# 图表分享
---

## 简介

“观测云” 支持对时序图、饼图，概览图等可视化图表进行分享，可用于在 “观测云” 以外的平台代码中插入图表进行可视化数据展示和分析。被分享的图表即使嵌入到其他平台，仍会与 “观测云” 中的图表变化实时同步。
## 分享图表

在「场景」-「仪表版」-「编辑」，即可对制作的可视化图表进行分享，分享的图表统一存储在「管理」-「分享管理」-「图表分享」。

**注意：分享图表功能仅支持空间拥有者、管理员和标准成员操作，只读成员无法查看到分享图表的功能。**

![](../img/5.table_1.1.png)

选择「图表查询时间」，点击「获取」，即可获取嵌入代码。

![](../img/2.table_share_2.png)

“观测云” 会按照图表查询时间生成嵌入代码，如图表查询时间为最近15分钟，即嵌入其他平台后，该图表按照最近15分钟显示查询结果。

**注意：**

- **若图表设置了「锁定时间」，「图表查询时间」则显示为该锁定时间且不能更改；**
- **图表分享的「宽度width」和「高度height」默认显示为视图中的尺寸大小，嵌入代码可进行修改；**
- **若图表关联了视图变量，按照当前选中的视图变量做图表分享，如当前关联视图变量主机（host），则按照当前选中的主机做图表分享，**

![](../img/2.table_share_3.png)

## 查看图表分享列表

“观测云”在场景视图分享的图表统一存储在「管理」-「分享管理」-「图表分享」中。更多详情可参看[ 分享管理](https://www.yuque.com/dataflux/doc/eybvlv)

![](../img/WX20210810-153516.png)

### 查看图表
点击「查看图表」，可放大预览分享的可视化图表。

![](../img/2.table_share_5.png)

### 查看嵌入代码
点击「查看嵌入代码」，可查看并复制可用于其他平台的嵌入代码。

![](../img/2.table_share_6.png)

### 取消分享
点击「取消分享」，分享并嵌入到其他平台的可视化图表将失效，被分享到其他的平台的图表会提示图表已失效。

![](../img/2.table_share_7.png)


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![](../img/logo_2.png)