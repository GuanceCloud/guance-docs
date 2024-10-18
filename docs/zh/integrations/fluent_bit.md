---
title     : 'Fluent Bit'
summary   : '通过 Fluent Bit 采集日志'
__int_icon: 'icon/fluentbit'
---

<!-- markdownlint-disable MD025 -->
# Fluent Bit 日志
<!-- markdownlint-enable -->

FluentBit 日志采集，接受日志文本数据上报至观测云。

## 安装部署 {#config}

### 1 前置条件

- 检查 FluentBit 数据是否正常采集

### 2 DataKit 采集器配置

#### 2.1 [安装 DataKit](../datakit/datakit-install.md)

#### 2.2 开启 logstreaming 采集器

进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logstreaming.conf.sample` 并命名为 `logstreaming.conf`。

> `cp logstreaming.conf.sample logstreaming.conf`

#### 2.3 重启 DataKit

[重启 DataKit](../datakit/datakit-service-how-to.md#manage-service)


### 3  FluentBit 配置

主要是调整 FluentBit 的 `OUTPUT`

``` toml
[OUTPUT]
    Name  http
    Match *
    Host  192.168.2.114
    Port  9529
    Format json
    Header Content-Type:application/json
    URI /v1/write/logstreaming?source=fluent-bit-log
```

FluentBit 的 `OUTPUT` 参数说明

- Name：固定 `http`
- Host：DataKit 所在主机
- Port: DataKit 端口号，默认 `9529`
- Format：输出为 `json` 格式
- Header：请求头
- URI：DataKit `logstreaming` 的接收地址

关于 `logstreaming`  的配置和参数说明，可以参考 [logstreaming](./logstreaming.md) 文档。

### 4 验证

当 FluentBit 采集到日志后，会通过 `OUTPUT` 发送到 DataKit，并通过平台可以查看日志信息。
