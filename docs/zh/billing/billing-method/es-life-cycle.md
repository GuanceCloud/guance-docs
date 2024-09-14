# 观测云 ES 多租户生命周期管理实践
---


## 生命周期管理(ilm) 


### 数据阶段

| **阶段名称** | **描述** | **写入** | **查询** |
| --- | --- | --- | --- |
| hot | 热数据阶段 | 频繁写入 | 频繁查询 |
| warm | 温数据阶段 | 不能写入 | 较频繁查询 |
| cold | 冷数据阶段 | 不能写入 | 不频繁查询，查询较慢 |
| frozen | 冻结数据阶段 | 不能写入 | 很少查询，查询非常慢 |
| delete | 删除数据阶段 | 不能写入 | 无法查询 |


### 索引操作

**注意**：

1. 热数据阶段，滚动时间起始点为索引创建时间；

2. 其他数据阶段（除了热数据阶段），时间计算起始点为滚动结束时间。

### 示例

![](../img/es-1.png)

## 观测云实际应用


| **保存策略** | **描述** | **热数据阶段** | **温数据阶段** | **删除数据阶段** |
| --- | --- | --- | --- | --- |
| es_rp0 | 数据保存 1 天 | min_age = 0<br />rollover {30gb, 1d}  | min_age = 6h<br />forcemerge {1}<br />shrink {1} | min_age = 1d <br />delete |
| es_rp2d | 数据保存 2 天 | min_age = 0<br />rollover {30gb, 2d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 2d <br />delete |
| es_rp1 | 数据保存 7天 （1 周） | min_age = 0<br />rollover {30gb, 7d}  | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 7d <br />delete |
| es_rp2 | 数据保存 14天 （2 周） | min_age = 0<br />rollover {30gb, 14d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 14d <br />delete |
| es_rp3 | 数据保存 30 天（1 个月） | min_age = 0<br />rollover {30gb, 30d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 30d <br />delete |
| es_rp60d | 数据保存 60 天（2 个月） | min_age = 0<br />rollover {30gb, 60d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 60d <br />delete |
| es_rp4 | 数据保存 90 天（3 个月） | min_age = 0<br />rollover {30gb, 90d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 90d <br />delete |
| es_rp5 | 数据保存 180 天（半年） | min_age = 0<br />rollover {30gb, 180d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 180d <br />delete |
| es_rp6 | 数据保存 360 天（1 年） | min_age = 0<br />rollover {30gb, 360d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 360d <br />delete |
| es_rp720d | 数据保存 720 天（近 2 年） | min_age = 0<br />rollover {30gb, 720d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age=720d <br />delete |
| es_rp7 | 数据保存 1095 天（3 年） | min_age = 0<br />rollover {30gb, 1095d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age=1095d <br />delete |


## 常见问题

### 数据保存时间缩短

修改保存策略后，会滚动出新的索引，之前索引数据不会被删除，一直到满足删除日期条件才会被删除，也即之前索引数据会一直计量收费。

![](../img/image.png)

### 数据保存时间变长

修改保存策略后，会滚动出新的索引，之前索引数据保存时间不会变长，新的索引保存时间使用新的配置。

![](../img/image_0.png)

## 更多阅读



<font size=3>

<div class="grid cards" markdown>


- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **ILM: Manage the index lifecycleedit**</font>](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-lifecycle-management.html))

</div>



<div class="grid cards" markdown>


- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **使用索引生命周期管理实现热温冷架构**</font>](https://www.elastic.co/cn/blog/implementing-hot-warm-cold-in-elasticsearch-with-index-lifecycle-management)

</div>



<div class="grid cards" markdown>


- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **【最新】Elasticsearch 6.6 Index Lifecycle Management 尝鲜**</font>](https://elasticsearch.cn/article/6358)

</div>

</font>