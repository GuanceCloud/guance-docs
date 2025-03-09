---
skip: 'not-searchable-on-index-page'
---

# Changelog

---

> *Authors: Liu Rui, Song Longqi*

## Introduction {#intro}

The native OTEL agent has inadequate support for some mainstream frameworks. On this basis, we have made some improvements to support more mainstream frameworks and critical data tracing.

The current OTEL has added extensions for the following technology stacks:

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

## Changelog {#changelog}

<!--

The changelog can refer to the basic paradigm of Datakit:

## 1.2.3(2022/12/12) {#cl-1.2.3}
This release mainly includes the following updates:

### New Features {#cl-1.2.3-new}
### Bug Fixes {#cl-1.2.3-fix}
### Enhancements {#cl-1.2.3-opt}
### Compatibility Changes {#cl-1.2.3-brk}

--->

## 1.28.0-guance (2023/7/7) {#cl-1.28.0-guance}

### New Features {#cl-1.28.0-guance-new}

- Merge the latest branch from OpenTelemetry

---

## 1.26.3-guance (2023/7/7) {#cl-1.26.3-guance}

### New Features {#cl-1.26.3-guance-new}

- Add [guance-exporter](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/17){:target="_blank"}

---

## 1.26.2-guance (2023/6/15) {#cl-1.26.2-guance}
Download the jar file for this version: [v1.26.2-guance](https://static.guance.com/dd-image/opentelemetry-javaagent-1.26.2-guance.jar){:target="_blank"}

### New Features {#cl-1.26.2-guance-new}

- [Add DB statement desensitization](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/15){:target="_blank"}

---

## 1.26.1-guance (2023/6/9) {#cl-1.26.1-guance}

### New Features {#cl-1.26.1-guance-new}

- Non-intrusive support for capturing method input parameters [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/12){:target="_blank"}
- Integration with Alibaba Cloud HSF framework [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/12){:target="_blank"}

---

## 1.26.0-guance (2023/6/1) {#cl-1.26.0-guance}

### New Features {#cl-1.26.0-guance-new}

- Merge the latest OpenTelemetry branch v1.26.0
- Support for Dameng Database [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/5){:target="_blank"}

---

## 1.25.0-guance (2023/5/10) {#cl-1.25.0-guance}

### New Features {#cl-1.25.0-guance-new}

- Merge the latest OpenTelemetry branch v1.25.0
- Support for xxl-job 2.3 [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/1){:target="_blank"}
- Add support for Alibaba Dubbo and Dubbox frameworks [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/2){:target="_blank"}
- Support for Thrift [GitHub-Issue](https://github.com/GuanceCloud/opentelemetry-java-instrumentation/issues/3){:target="_blank"}

---