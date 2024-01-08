# 智能监控
---

智能监控对于业务分析、用户行为的分析、以及出现故障的根因分析能力，提供了一套快速定位异常节点的机制。适用于业务类指标、波动性比较强的指标。通过分析场景构建对多维指标做关键维度的定位；在定位到业务的维度范围后，围绕着微服务中服务的调用，服务的资源依赖，快速定位分析异常。

通过[主机智能检测](host-intelligent-detection.md)、[日志智能检测](log-intelligent-monitoring.md)、[应用智能检测](application-intelligent-detection.md)、[用户访问智能检测](rum-intelligent-detection.md)等检测规则配置监控。设置检测范围和通知人，基于智能检测算法，识别异常数据并预测未来走势。

**注意**：区别于传统的监控模式，智能监控无需配置检测阈值及触发规则，只需设定检测范围及通知人即可一键开启监控，通过智能算法识别定位异常，支持异常区间的分析与报告。

工作空间的智能监控器可通过观测云平台的**智能监控**进行查看和管理。

![](../img/intelligent-detection01.png)

## 新建 {#new}

您可以通过**智能监控**设置不同监控场景下的检测规则。

![](../img/intelligent-detection02.png)

### 检测规则 {#detect}

目前观测云支持 4 种智能检测规则，不同的规则覆盖不同的数据范围。

| 规则名称 | 数据范围 | 基本描述 |
| --- | --- | --- |
| 主机智能检测 | 指标(M)  | 通过智能算法自动检测主机，发现主机 CPU、内存异常情况。 |
| 日志智能检测 | 日志(L) | 通过智能算法自动检测日志中的异常，检测指标包含日志数量，错误日志数。 |
| 应用智能检测 | 链路(T)  | 通过智能算法自动检测应用中的异常，检测指标包含应用请求数量，错误请求数，以及请求延迟。 |
| 用户访问智能检测 | 用户访问数据(R) | 通过智能算法自动检测网站/APP 中的异常，包含页面性能分析，错误分析，相关检测指标有 LCP、FID、CLS、Loading Time等。 |


|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**了解更多**</font>                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [主机智能检测](host-intelligent-detection.md){ .md-button .md-button--primary } | [日志智能检测](log-intelligent-monitoring.md){ .md-button .md-button--primary } | [应用智能检测](application-intelligent-detection.md){ .md-button .md-button--primary } | 
| [用户访问智能检测](rum-intelligent-detection.md){ .md-button .md-button--primary } | 

### 计费说明

智能监控器每执行一次检测算 100 次。

> 更多详情，可查看 [任务调用](../../billing/billing-method/billing-item.md#trigger)。