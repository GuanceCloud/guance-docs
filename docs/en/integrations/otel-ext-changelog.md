---
skip: 'not-searchable-on-index-page'
---

# Update History

---

> *Authors: Liu Rui, Song Longqi*

## Introduction {#intro}

The native OTEL agent does not fully support some well-known mainstream frameworks. Based on this, we have made some improvements to support more mainstream frameworks and key data tracking.

The following technology stacks have currently been added to OTEL:

<!-- markdownlint-disable MD046 MD030 -->
<div class="grid cards" markdown>

-   :material-language-java: __Java__

    ---

    [SDK :material-download:](https://static.guance.com/dd-image/opentelemetry-javaagent.jar){:target="_blank"} ·
    [:material-github:](https://github.com/GuanceCloud/opentelemetry-java-instrumentation){:target="_blank"} ·
    [Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/new){:target="_blank"} ·
    [:octicons-history-16:](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/releases){:target="_blank"}

</div>
<!-- markdownlint-enable -->

## Update History {#changelog}

<!--

Update history can refer to Datakit's basic paradigm:

## 1.2.3(2022/12/12) {#cl-1.2.3}
This release mainly includes the following updates:

### New Features {#cl-1.2.3-new}
### Issue Fixes {#cl-1.2.3-fix}
### Feature Optimizations {#cl-1.2.3-opt}
### Compatibility Adjustments {#cl-1.2.3-brk}

--->

## 1.28.0-guance (2023/7/7) {#cl-1.28.0-guance}

### New Features {#cl-1.28.0-guance-new}

- Merged with the latest open-telemetry branch

---

## 1.26.3-guance (2023/7/7) {#cl-1.26.3-guance}

### New Features {#cl-1.26.3-guance-new}

- Added [guance-exporter](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/17){:target="_blank"}

---

## 1.26.2-guance (2023/6/15) {#cl-1.26.2-guance}
Download the jar package for this version: [v1.26.2-guance](https://static.guance.com/dd-image/opentelemetry-javaagent-1.26.2-guance.jar){:target="_blank"}

### New Features {#cl-1.26.2-guance-new}

- [Added DB statement desensitization](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/15){:target="_blank"}

---

## 1.26.1-guance (2023/6/9) {#cl-1.26.1-guance}

### New Features {#cl-1.26.1-guance-new}

- Non-intrusive support for obtaining parameter information of specific methods [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/12){:target="_blank"}
- Alibaba Cloud HSF framework integration [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/12){:target="_blank"}

---

## 1.26.0-guance (2023/6/1) {#cl-1.26.0-guance}

### New Features {#cl-1.26.0-guance-new}

- Merged with the latest OpenTelemetry branch v1.26.0
- Supported Dameng database [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/5){:target="_blank"}

---

## 1.25.0-guance (2023/5/10) {#cl-1.25.0-guance}

### New Features {#cl-1.25.0-guance-new}

- Merged with the latest OpenTelemetry branch v1.25.0
- Supported xxl-job 2.3 [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/1){:target="_blank"}
- Added support for Alibaba Dubbo and Dubbox frameworks [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/2){:target="_blank"}
- Supported thrift [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/3){:target="_blank"}

---