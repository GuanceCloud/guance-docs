---
title     : 'Fluent Bit'
summary   : 'Collect logs via Fluent Bit'
__int_icon: 'icon/fluentbit'
---

<!-- markdownlint-disable MD025 -->
# Fluent Bit Logs
<!-- markdownlint-enable -->

FluentBit log collection involves receiving log text data and reporting it to Guance.

## Installation and Deployment {#config}

### 1 Prerequisites

- Check if FluentBit data is being collected correctly

### 2 DataKit Collector Configuration

#### 2.1 [Install DataKit](../datakit/datakit-install.md)

#### 2.2 Enable the logstreaming collector

Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample`, and rename it to `logstreaming.conf`.

> `cp logstreaming.conf.sample logstreaming.conf`

#### 2.3 Restart DataKit

[Restart DataKit](../datakit/datakit-service-how-to.md#manage-service)


### 3 FluentBit Configuration

Mainly adjust the `OUTPUT` section of FluentBit:

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

Explanation of FluentBit's `OUTPUT` parameters:

- Name: Fixed as `http`
- Host: The host where DataKit resides
- Port: DataKit port number, default `9529`
- Format: Output in `json` format
- Header: Request headers
- URI: Receiving address for DataKit `logstreaming`

For more information on the configuration and parameters of `logstreaming`, refer to the [logstreaming](./logstreaming.md) documentation.

### 4 Verification

Once FluentBit collects the logs, it will send them through the `OUTPUT` to DataKit, and you can view the log information via the platform.