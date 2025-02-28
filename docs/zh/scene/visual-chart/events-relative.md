# 事件关联
---


<<< custom_key.brand_name >>>支持通过添加筛选字段匹配与选定字段相关的异常事件，将查询的数据与事件相关联，从而在查看趋势的同时，帮助感知数据波动期间是否有相关事件产生，多视角定位问题。

**注意**：该功能目前仅支持时序图、直方图。

## 示例

下图中，筛选条件为： 

```
M::`system`:(last(`cpu_total_usage`) AS `5m`) BY `host`
```

即查询最近最近 15 分钟内，当前工作空间返回最新的各主机 CPU 使用率。

此时添加的事件关联的筛选条件为 `-host:ivan-centos`、`df_status:critical`。即筛选出除了主机名为 `ivan-centos` 之外的所有主机，且事件等级为 `critical` 的相关联事件。


<img src="../../img/event_related_case.png" width="70%" >

在时间轴上，若存在事件记录就会用阴影色块标注显示。点击高亮的阴影色块下的某条查询，即可查看包含当前字段相关的异常事件。

<img src="../../img/event_related_case-1.png" width="70%" >

