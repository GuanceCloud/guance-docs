# 观测云自研时序数据库 —— GuanceDB
---

**GuanceDB** 是观测云研发的的分布式多模时序数据库，旨在为可观测场景的数据存储和查询提供更加高效和完善的一站式存储解决方案。

现在 GuanceDB 已经上线支持了指标数据的存储和查询，其他类型的存储支持也正在如火如荼地开发中，后续会陆续跟大家见面。

GuanceDB 在设计上具备如下特性：

**设计灵活**
  
GuanceDB 在设计上把 Schemaless 当成最重要的特征之一，我们可以支持任意字段的写入，也可以实时增删数据字段，无需手动维护数据模型。

GuanceDB 采用分布式架构部署，一方面可以保证自身的高可用，另一方面也可以通过动态增删节点实现集群的横向扩展。

**强大的查询引擎**
  
GuanceDB 查询基于火山模型，支持流式分批计算，可以实现无上限的原始数据计算。我们还利用 SIMD 指令集对查询进行加速，单机的极限计算性能可达每秒数十亿行。

GuanceDB 除了支持观测云自研的多模查询语言 DQL 查询语法之外，还对 Prometheus 的 PromQL 做了兼容。写入一份数据，用户可以自由挑选自己喜欢的语法来查询。

> 观测云控制台预计 5 月份支持 PromQL 语法查询入口。

**高性能指标引擎**
  
GuanceDB 的指标引擎在写入、查询性能和存储压缩效率方面表现优秀。对比此前观测云使用的时序数据库 InfluxDB，写入性能提升 3 倍，存储空间占用减少了 3 倍，查询性能提升 30 倍以上。

GuanceDB 指标引擎针对高基数指标在写入和查询时进行了优化，使用时可以不用担心高基数影响数据库的稳定性。

GuanceDB 同样延续支持了观测云以指标集粒度来配置数据的存储策略的功能，支持用户针对量大但相对临时的指标配置更短的保存时长，不仅能更快地释放存储空间来减少资源开销，还可以加速查询。


非常感谢 VictoriaMetrics 开源项目对 GuanceDB 的启发和帮助，观测云将继续努力为用户提供更优质的可观测解决方案。我们诚挚邀请您关注 GuanceDB 的发展进程，共同见证我们的成长。



