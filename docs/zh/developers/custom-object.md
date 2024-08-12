# 资源目录
---

观测云支持通过 DataFlux Func 上报资源目录数据，除了主机、容器、进程、网络等，观测云基础设施自定义功能支持上报任意自定义数据。

- 任意对象数据：自定义基础设施、云产品对象数据、业务类对象数据
- 统一管理：各种不同类型的对象数据按照相同的格式收集起来统一管理。
- 关联分析：添加标签进行数据筛选、分类汇总，对数据进行关联分析。

## 前提条件

资源目录数据上报需要先安装并连通 DataKit 和 DataFlux Func ，再通过 DataFlux Func 上报数据到 DataKit，最终 DataKit 上报数据到观测云工作空间。

- [安装 DataKit](../datakit/datakit-install.md)
- [安装 DataFlux Func](https://func.guance.com/doc/quick-start/)
- [连接 DataFlux Func 和 DataKit](https://func.guance.com/doc/practice-connect-to-datakit/)

## 上报资源目录数据

DataFlux Func 和 DataKit 连通以后，可以在 DataFlux Func 中撰写函数来完成上报资源目录数据。

- 关于 DataFlux Func 函数调用的接口说明可参考文档 [DataKit API](../datakit/apis.md)。
- 关于 DataFlux Func 如何写入数据到 DataKit 的说明可参考文档 [通过DataKit 写入数据](https://func.guance.com/doc/practice-write-data-via-datakit/)。
