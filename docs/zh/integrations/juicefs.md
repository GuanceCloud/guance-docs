---
title     : 'JuiceFS'
summary   : '采集 JuiceFS 数据大小、IO、事物、对象、客户端等相关组件指标信息'
__int_icon: 'icon/juicefs'
dashboard :
  - desc  : 'JuiceFS 监控视图'
    path  : 'dashboard/zh/juicefs'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# [JuiceFS](https://juicefs.com/docs/zh/community/introduction/)
<!-- markdownlint-enable -->

采集 JuiceFS 数据大小、IO、事物、对象、客户端等相关组件指标信息。

## 安装配置 {#config}


### JuiceFS 指标

JuiceFS 默认暴露指标端口为：`9567`，可通过浏览器查看指标相关信息：`http://clientIP:9567/metrics`。

### DataKit 采集器配置

由于`JuiceFS`能够直接暴露`metrics` url，所以可以直接通过[`prom`](./prom.md)采集器进行采集。



调整内容如下：

```toml

urls = ["http://localhost:9567/metrics"]

source = "juicefs"

interval = "10s"

```

<!-- markdownlint-disable MD033 -->
<font color="red">*其他配置按需调整*</font>
<!-- markdownlint-enable -->
，调整参数说明 ：

- urls：`prometheus`指标地址，这里填写对应组件暴露出来的指标 url
- source：采集器别名，建议做区分
- interval：采集间隔

### 重启 DataKit

```shell
systemctl restart datakit
```

## 指标 {#metric}

详细指标信息参考[官方文档](https://juicefs.com/docs/zh/community/p8s_metrics)


