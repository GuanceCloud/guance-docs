# Release Notes

## 1.69.1 (2025/03/18) {#cl-1.69.1}

This release is a hotfix, with the following content:

### Issue Fixes {#cl-1.69.1-fix}

- Fixed an issue where Docker CONTAINERS CPU collection was incorrect (#2589)
- Fixed memory leak caused by script execution in multi-step TESTING collectors (#2588)
- Improved error messages for multi-step TESTING (#2567)
- Updated some documents (#2590)

---

## 1.69.0 (2025/03/12) {#cl-1.69.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.69.0-new}

- Added statsd support to APM automatic instrumentation (#2573)
- Added key event data processing in Pipeline (#2585)

### Issue Fixes {#cl-1.69.0-fix}

- Fixed the issue of not being able to retrieve `host_ip` after HOST reboot (#2543)

### Functional Improvements {#cl-1.69.0-opt}

- Optimized process collectors by adding several process-related Metrics (#2366)
- Improved DDTrace trace-id field handling (#2569)
- Added `base_service` field in OpenTelemetry collection (#2575)
- Adjusted WAL default settings; worker count is now set to CPU core limit * 8. Also added support for specifying worker count and disk cache size during installation/upgrade (#2582)
- Removed pid detection when running Datakit in container environments (#2586)

### Compatibility Adjustments {#cl-1.69.0-brk}

- Optimized disk collectors by default ignoring certain file system types and mount points (#2566)

    Adjusted disk Metrics collection, and updated disk list collection in HOST objects, with the following differences:

    1. Added mount point ignore options: This adjustment mainly optimizes Datakit disk list acquisition in Kubernetes, filtering out unnecessary mount points such as ConfigMap mounts (`/usr/local/datakit/.*`) and Pod log collection mounts (`/run/containerd/.*`). It also avoids creating invalid Time Series caused by different mount points.
    1. Added file system ignore options: Ignored file systems that are less necessary to collect (such as `tmpfs/autofs/devpts/overlay/proc/squashfs`) by default.
    1. In HOST object collection, applied the same default ignore strategy as disk Metrics collection.

    After this adjustment, the number of Time Series can be significantly reduced. Additionally, when configuring monitoring, it becomes easier to understand and avoids confusion caused by numerous mount points.


---

## 1.68.1 (2025/02/28) {#cl-1.68.1}

This release is a hotfix, with the following content:

### Issue Fixes {#cl-1.68.1-fix}

- Fixed memory consumption issues in OpenTelemetry Metrics collection (#2568)
- Fixed crash caused by eBPF parsing PostgreSQL protocol (!3420)

---

## 1.68.0 (2025/02/27) {#cl-1.68.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.68.0-new}

- Added Multistep Tests functionality (#2482)

### Issue Fixes {#cl-1.68.0-fix}

- Fixed multiline buffer cleanup issue in LOG collection (!3419)
- Fixed default configuration issue for xfsquota (!3419)

### Functional Improvements {#cl-1.68.0-opt}

- Zabbix Exporter collector added compatibility for older versions (v4.2+) (#2555)
- Provided `setopt()` function in Pipeline to customize LOG level processing (#2545)
- Default conversion of Histogram type Metrics collected by OpenTelemetry into Prometheus-style histograms (#2556)
- Adjusted CPU limit mechanism for Datakit installations on HOSTs, using a new limit based on CPU core count (#2557)
- Added source IP whitelist mechanism for Proxy collectors (#2558)
- Allowed targeted collection of CONTAINERS and Pods metrics based on namespace/image methods in Kubernetes (#2562)
- Added percentage collection for CONTAINERS and Pods memory/CPU based on Limit and Request in Kubernetes (#2563)
- Added IPv6 support in AWS cloud sync (#2559)
- Other fixes (!3418/!3416)

### Compatibility Adjustments {#cl-1.68.0-brk}

- Adjusted Metrics set names during OpenTelemetry collection, renaming `otel-service` to `otel_service` (!3412)

---

## 1.67.0 (2025/02/12) {#cl-1.67.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.67.0-new}

- Added HTTP header settings for KubernetesPrometheus collection, along with bearer token string configuration support (#2554)
- Added xfsquota collector (#2550)
- Added IMDSv2 support in AWS cloud sync (#2539)
- Added Pyroscope collector for collecting Java/Golang/Python Profiling data based on Pyroscope (#2496)

### Issue Fixes {#cl-1.67.0-fix}
### Functional Improvements {#cl-1.67.0-opt}

- Enhanced DCA configuration documentation (#2553)
- OpenTelemetry collection supports extracting event fields as top-level fields (#2551)
- Enhanced DDTrace-Golang documentation, adding compile-time instrumentation instructions (#2549)

---

## 1.66.2 (2025/01/17) {#cl-1.66.2}

This release is a hotfix, with additional minor feature additions. Content includes:

### Issue Fixes {#cl-1.66.2-fix}

- Fixed compatibility issues with Pipeline debugging interfaces (!3392)
- Fixed UDS listening problems (#2544)
- Added `linux/arm64` support to UOS images (#2529)
- Fixed tag priority issues in prom v2 collector (#2546) and Bearer Token issues (#2547)

---

## 1.66.1 (2025/01/10) {#cl-1.66.1}

This release is a hotfix, with additional minor feature additions. Content includes:

### Issue Fixes {#cl-1.66.1-fix}

- Fixed timestamp precision issues in prom v2 collector (#2540)
- Fixed conflict between PostgreSQL index tag and DQL keywords (#2537)
- Fixed missing `service_instance` field in SkyWalking collection (#2542)
- Removed unused configuration fields in OpenTelemetry and fixed missing unit tags (`unit`) in some Metrics (#2541)

---

## 1.66.0 (2025/01/08) {#cl-1.66.0}

This release is an iterative release, with the following main updates:

### New Features {#cl-1.66.0-new}

- Added KV mechanism, supporting fetching updated collection configurations via pull (#2449)
- Added AWS/Huawei Cloud storage support in task dispatching functions (#2475)
- Added [NFS Collector](../integrations/nfs.md) (#2499)
- Added support for more HTTP `Content-Type` in Pipeline debugging interface test data (#2526)
- Added Docker CONTAINERS support in APM Automatic Instrumentation (#2480)

### Issue Fixes {#cl-1.66.0-fix}

- Fixed inability to connect micrometer data in OpenTelemetry collector (#2495)

### Functional Improvements {#cl-1.66.0-opt}

- Optimized disk Metrics collection and disk collection in objects (#2523)
- Improved Redis slow log collection, adding client information in slow logs. Also selectively supported lower versions (<4.0) of Redis (e.g., Codis) (#2525)
- Adjusted retry mechanisms in KubernetesPrometheus collector when collecting Metrics, no longer excluding targets temporarily offline (#2530)
- Optimized default configurations for PostgreSQL collector (#2532)
- Added metric name trimming configuration entry for Prometheus Metrics collected by KubernetesPrometheus (#2533)
- Supported active extraction of `pod_namespace` tag in DDTrace/OpenTelemetry collectors (#2534)
- Enhanced scan mechanism for LOG collection, forcing a 1-minute scan mechanism to avoid missing log files in extreme cases (#2536)

---