---
title: 'DDTrace Java Extension Changelog'
skip: 'not-searchable-on-index-page'
---

> *Authors: Liu Rui, Song Longqi*

## Introduction {#intro}

Native DDTrace has incomplete support for some mainstream frameworks. On this basis, we have made some improvements to support more mainstream frameworks and critical data tracing.

The current DDTrace has added extensions for the following technology stacks:

<!-- markdownlint-disable MD046 MD030 -->
<div class="grid cards" markdown>

-   :material-language-java: __Java__

    ---

    [SDK :material-download:](https://static.guance.com/dd-image/dd-java-agent.jar){:target="_blank"} ·
    [:material-github:](https://github.com/GuanceCloud/dd-trace-java){:target="_blank"} ·
    [Issue](https://github.com/GuanceCloud/dd-trace-java/issues/new){:target="_blank"} ·
    [:octicons-history-16:](https://github.com/GuanceCloud/dd-trace-java/releases){:target="_blank"}

</div>
<!-- markdownlint-enable -->

## Change Log {#changelog}

<!--

The change log can refer to the basic paradigm of Datakit:

## 1.2.3(2022/12/12) {#cl-1.2.3}
This release mainly includes the following updates:

### New Features {#cl-1.2.3-new}
### Bug Fixes {#cl-1.2.3-fix}
### Optimization {#cl-1.2.3-opt}
### Compatibility Adjustments {#cl-1.2.3-brk}

--->

## v1.42.7-guance {#cl-1.42.7-guance}

### Bug Fixes {#cl-1.42.7-guance-fix}

- Fixed a bug where environment variables in Response Body functionality were not taking effect.
- Merged the latest DDTrace tag v1.42.1 version.

## v1.36.1-guance {#cl-1.36.1-guance}

### Bug Fixes {#cl-1.36.1-guance-fix}

- Merged the latest DataDog Java Agent branch 1.36.0.
- Added `dd-guance-version` tag for easier version identification.
- Recorded SQL statements executed by `mybatis-plus batch` as `span` information.

## v1.34.2-guance {#cl-1.34.2-guance}

### Bug Fixes {#cl-1.34.2-guance-fix}

- Removed the [add response_body](ddtrace-ext-java.md#response_body) feature due to excessive memory usage.

## v1.34.0-guance {#cl-1.34.0-guance}

### Updates {#cl-1.34.0-guance-fix}

- Merged the latest `v1.34.0` code.

## v1.30.5-guance v1.30.6-guance {#cl-1.30.5-guance}

### Updates {#cl-1.30.5-guance-fix}

- Fixed the `trace_id` extraction issue under the `W3C` protocol.
- Resolved the `Pulsar OOM` issue.
- Obtained `peer_ip` in `Lettuce5` cluster mode.

## v1.30.4-guance (2024/4/25) {#cl-1.30.4-guance}

### Updates {#cl-1.30.4-guance-fix}

- Resolved the chain interruption issue caused by continuous Dubbo service transmission.
- Resolved the memory leak issue in `Pulsar`.

## v1.30.2-guance (2024/4/3) {#cl-1.30.2-guance}

### Updates {#cl-1.30.2-guance-fix}

- Added support for viewing `Command` parameters in Redis SDK `Lettuce`.

## v1.30.1-guance (2024/2/6) {#cl-1.30.1-guance}

### Updates {#cl-1.30.1-guance-fix}

- Merged the latest DataDog Java Agent branch 1.30.0.
- Added HTTP Response Body information to trace data, [enable using commands](ddtrace-ext-java.md#response_body).

## v1.25.2-guance (2024/1/10) {#cl-1.25.2-guance}

### Updates {#cl-1.25.2-guance-fix}

- Added HTTP Header information to trace data, [enable using commands](ddtrace-ext-java.md#trace_header).

## v1.25.1-guance (2024/1/4) {#cl-1.25.1-guance}

### Updates {#cl-1.25.1-guance-fix}

- Placed `Guance_trace_id` in the HTTP response header.

## v1.21.1-guance (2023/11/1) {#cl-1.21.1-guance}

### Updates {#cl-1.21.1-guance-fix}

- Added support for batch consumption in Apache Pulsar.

## v1.21.0-guance (2023/10/24) {#cl-1.21.0-guance}

### Updates {#cl-1.21.0-guance-fix}

- Merged the latest DDTrace branch v1.21.0 and released a new version.

## v1.20.3-guance (2023/10/13) {#cl-1.20.3-guance}

### New Features {#cl-1.20.3-guance-fix}

- Added support for xxl-job probe version 2.2.

## v1.20.2-guance (2023/9/25) {#cl-1.20.2-guance}

### New Features {#cl-1.20.2-guance-fix}

- Added support for Apache Pulsar probes.

## v1.20.1-guance (2023/9/8) {#cl-1.20.1-guance}

### Updates {#cl-1.20.1-guance-fix}

- Merged the latest DDTrace branch v1.20.1 and released a new version.

## v1.17.4-guance (2023/7/27) {#cl-1.17.4-guance}

### Bug Fixes {#cl-1.17.4-guance-fix}

- Fixed Span loss issues with RocketMQ under high concurrency.

## v1.17.2-guance v1.17.3-guance (2023/7/20) {#cl-1.17.3-guance}

### Bug Fixes {#cl-1.17.3-guance-fix}

- Fixed the issue of missing trace information in Redis.
- Removed extensive debug logs in Dubbo.
- Added 4 JVM metrics, details see [GitHub-Issue](https://github.com/GuanceCloud/dd-trace-java/issues/46){:target="_blank"}

## v1.17.1-guance (2023/7/11) {#cl-1.17.1-guance}

### Bug Fixes {#cl-1.17.1-guance-new}

- NPE exception caused by return values when sending asynchronous messages in RocketMQ.
- Replaced message cache span with local cache in RocketMQ, users no longer need to close traceContext function.

### Optimizations {#cl-1.17.1-guance-opt}

- Optimized log output

## v1.17.0-guance (2023/7/7) {#cl-1.17.0-guance}

### Bug Fixes {#cl-1.17.0-guance-new}

- Merged the latest Datadog v1.17.0 version


## v1.15.4-guance (2023/6/12) {#cl-1.15.4-guance}

### Bug Fixes {#cl-1.15.4-guance-new}

- Merged the latest Datadog v1.15.3 version
- [Supported PowerJob](https://github.com/GuanceCloud/dd-trace-java/issues/42){:target="_blank"}


## v1.14.0-guance (2023/5/18) {#cl-1.14.0-guance}

### Bug Fixes {#cl-1.14.0-guance-new}

- Merged the latest Datadog v1.14.0 version
- [Supported 128-bit trace ID](https://github.com/GuanceCloud/dd-trace-java/issues/37){:target="_blank"}


## v1.12.1-guance (2023/5/11) {#cl-1.12.1-guance}

### Bug Fixes {#cl-1.12.1-guance-new}

- Supported MongoDB desensitization, [MongoDB desensitization issue](https://github.com/GuanceCloud/dd-trace-java/issues/38){:target="_blank"}
- [Supported Dameng domestic database](https://github.com/GuanceCloud/dd-trace-java/issues/39){:target="_blank"}


## v1.12.0 (2023/4/20) {#cl-1.12.0}

### Bug Fixes {#cl-1.12.0-new}

- Merged the latest DDTrace Tag:1.12.0
- Supported [Dubbox](https://github.com/GuanceCloud/dd-trace-java/issues/32){:target="_blank"}
- Resolved [confusion between jax-rs and Dubbo traces](https://github.com/GuanceCloud/dd-trace-java/issues/34){:target="_blank"}
- Resolved [incorrect order in Dubbo Service Map](https://github.com/GuanceCloud/dd-trace-java/issues/35){:target="_blank"}
- Resolved [RocketMQ custom trace data conflict](https://github.com/GuanceCloud/dd-trace-java/issues/29){:target="_blank"}
- Resolved [RocketMQ Resource Name issue](https://github.com/GuanceCloud/dd-trace-java/issues/33){:target="_blank"}

## v1.10.2 (2023/4/10) {#cl-1.10.2}

### Bug Fixes {#cl-1.10.2-new}

- Merged the latest DDTrace Tag: 1.10
- Fixed non-support for `@DubboReference` nesting in Dubbo probe
- Fixed failure to retrieve RocketMQ custom context after user-defined context

## v1.8.0, v1.8.1, v1.8.3(2023/2/27) {#cl-1.8.0}

### New Features {#cl-1.8.0-new}

- Merged the latest DDTrace branch
- Added feature to [retrieve input parameters of specific functions](https://github.com/GuanceCloud/dd-trace-java/issues/26){:target="_blank"}

## v1.4.1(2023/2/27) {#cl-1.4.1}

### New Features {#cl-1.4.1-new}

- Added support for Alibaba Cloud RocketMQ 4.0 series

## v1.4.0(2023/1/12) {#cl-1.4.0}

### New Features {#cl-1.4.0-new}

- Merged the latest DDTrace branch v1.4.0

## v1.3.2(2023/1/12) {#cl-1.3.2}

### New Features {#cl-1.3.2-new}

- Added support for viewing parameters in Redis [parameters viewing](https://github.com/GuanceCloud/dd-trace-java/issues/19){:target="_blank"})
- Modified default port for DDTrace-Java-Agent [default port](https://github.com/GuanceCloud/dd-trace-java/issues/18){:target="_blank"})
- Corrected single-end chain [issue](https://github.com/GuanceCloud/dd-trace-java/issues/22){:target="_blank"}) for Alibaba Cloud RocketMQ

## v1.3.0(2022/12/28) {#cl-1.3.0}

### New Features {#cl-1.3.0-new}

- Merged the latest DataDog branch v1.3.0
- Added Log Pattern support
- Added HSF framework support
- Added Axis 1.4 support
- Added Alibaba Cloud RocketMQ 5.0 support

## v1.0.1(2022/12/23) {#cl-1.0.1}

### New Features {#cl-1.0.1-new}

- Merged the latest DataDog branch v1.0.1.
- Merged custom attach content.

## v0.113.0-attach(2022/11/16) {#cl-0.113.0}

### New Features {#cl-0.113.0-new}

- Added SQL placeholder (`?`) probe support for desensitization ([#7](https://github.com/GuanceCloud/dd-trace-java/issues/7){:target="_blank"})

## 0.113.0(2022-10-25) {#cl-0.113.0}

- [GitHub download link](https://github.com/GuanceCloud/dd-trace-java/releases/tag/v0.113.0-guance){:target="_blank"}

### Feature Adjustment Description {#cl-0.113.0-new}

- Based on tag 0.113.0, merged previous code

- Fixed Thrift `TMultipexedProtocol` model support

## 0.108.1(2022-10-14) {#cl-0.118.0}

Merged DataDog v0.108.1 version, compiled while retaining 0.108.1

- [GitHub download link](https://github.com/GuanceCloud/dd-trace-java/releases/tag/v0.108.1){:target="_blank"}

### Feature Adjustment Description {#cl-0.118.0-new}

- Added thrift instrumentation (thrift version >=0.9.3)

---

## 0.108.1(2022-09-06) {#cl-0.108.1}

Merged DataDog v0.108.1 version, compiled.

- [GitHub download link](https://github.com/GuanceCloud/dd-trace-java/releases/tag/v0.108.1){:target="_blank"}

### Feature Adjustment Description {#cl-0.108.1-new}

- Added xxl_job probe (xxl_job version >= 2.3.0)

---

## guance-0.107.0((2022-08-30)) {#cl-0.107.0}

Merged DataDog 107 version, compiled.

- [GitHub download link](https://github.com/GuanceCloud/dd-trace-java/releases/tag/guance-107){:target="_blank"}

---

## guance-0.105.0(2022-08-23) {#cl-0.105.0}

[GitHub download link](https://static.guance.com/ddtrace/dd-java-agent-guance-0.106.0-SNAPSHOT.jar){:target="_blank"}

### Feature Adjustment Description {#cl-0.105.0}

- Added support for RocketMq probe versions (>= 4.8.0).
- Added support for Dubbo probe versions (>= 2.7.0).
- Added SQL desensitization feature: After enabling, it adds the original SQL statement to the trace for easier troubleshooting. Add configuration parameter `-Ddd.jdbc.sql.obfuscation=true` when starting the Agent