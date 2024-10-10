---
title     : 'Fluent Bit'
summary   : 'FluentBit log collection, accepting log text data reported to the Guance'
__int_icon: 'icon/fluentbit'
---

<!-- markdownlint-disable MD025 -->
# Fluent Bit log
<!-- markdownlint-enable -->

FluentBit log collection, accepting log text data reported to the Guance.

## Installation Deployment {#config}

### 1 Prerequisites

- Check if the Fluentd data is collected normally

### 2 DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Enabled logstreaming collector

Enter `conf.d/log` in the [DataKit installation directory](./datakit_dir.md) and copy `logstreaming.conf.sample` to `logstreaming.conf`.

> `cp logstreaming.conf.sample logstreaming.conf`

#### 2.3 Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)

### 3  FluentBit Configuration

Adjust the `OUTPUT` of FluentBit

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

Explanation of FluentBit's `OUTPUT` parameter

- Name：fixed `http`
- Host：DataKit host
- Port: DataKit port，default `9529`
- Format：use `json` for output data type
- Header：request header
- URI：DataKit `logstreaming` url

For the configuration and parameter instructions of `logstreaming`, please refer to the document [logstreaming](./logstreaming.md).


### 4 Check

After FluentBit collects the log, it will be sent to DataKit through `OUTPUT` and the log information can be viewed through the Guance platform.
