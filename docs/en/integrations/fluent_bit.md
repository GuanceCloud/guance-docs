---
title     : 'Fluent Bit'
summary   : 'Collect logs via Fluent Bit'
__int_icon: 'icon/fluentbit'
---

<!-- markdownlint-disable MD025 -->
# Fluent Bit Logs
<!-- markdownlint-enable -->

FluentBit log collection accepts log text data reporting to <<< custom_key.brand_name >>>.

## Installation and Deployment {#config}

### 1. Prerequisites

- Check if FluentBit data is being collected properly

### 2. DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Enable the logstreaming collector

Go to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample` and rename it to `logstreaming.conf`.

> `cp logstreaming.conf.sample logstreaming.conf`

#### 2.3 Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


### 3. FluentBit Configuration

Mainly adjust FluentBit's `OUTPUT`

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

Parameters explanation for FluentBit's `OUTPUT`

- Name: fixed as `http`
- Host: The host where DataKit resides
- Port: DataKit port number, default is `9529`
- Format: Output in `json` format
- Header: Request header
- URI: Receiving address of DataKit `logstreaming`

For configuration and parameter explanations about `logstreaming`, refer to the [logstreaming](./logstreaming.md) documentation.

### 4. Verification

When FluentBit collects logs, it will send them to DataKit via `OUTPUT`, and the log information can be viewed through the platform.