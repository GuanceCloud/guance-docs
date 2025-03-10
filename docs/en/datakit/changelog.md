# Changelog

## 1.68.1 (2025/02/28) {#cl-1.68.1}

This release is a hotfix, including some additional minor features. The contents are as follows:

### Bug Fixes {#cl-1.68.1-fix}

- Fixed memory consumption issues with OpenTelemetry metrics collection (#2568)
- Fixed crashes caused by eBPF parsing PostgreSQL protocol (!3420)

---

## 1.68.0 (2025/02/27) {#cl-1.68.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.68.0-new}

- Added multi-step Dial Testing functionality (#2482)

### Bug Fixes {#cl-1.68.0-fix}

- Fixed log collection multiline cache cleanup issues (!3419)
- Fixed default configuration issues for xfsquota (!3419)

### Functionality Improvements {#cl-1.68.0-opt}

- Zabbix Exporter collector now supports compatibility with lower versions (v4.2+) (#2555)
- Pipeline processing now provides `setopt()` function to customize log level handling (#2545)
- OpenTelemetry collector converts histogram type metrics to Prometheus-style histograms by default during collection (#2556)
- Adjusted CPU quota method when installing Datakit on hosts; newly installed Datakits use CPU core-based limit mechanisms by default (#2557)
- Proxy collector added source IP whitelist mechanism (#2558)
- Kubernetes container and Pod metric collection now allows targeted collection based on namespace/image methods (#2562)
- Kubernetes container and Pod memory/CPU completion based on Limit and Request percentage collection (#2563)
- AWS cloud synchronization added IPv6 support (#2559)
- Other bug fixes (!3418/!3416)

### Compatibility Adjustments {#cl-1.68.0-brk}

- Adjusted metric set names in OpenTelemetry metric collection; the original `otel-service` has been changed to `otel_service` (!3412)

---

## 1.67.0 (2025/02/12) {#cl-1.67.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.67.0-new}

- Added multiple step dial testing feature (#2482)
- Increased support for custom object collection in mainstream collectors such as Oracle/MySQL/Apache (#2207)
- Added HTTP header settings during KubernetesPrometheus collection, also supporting string configuration of bearer token (#2554)
- Added xfsquota collector (#2550)
- Added IMDSv2 support in AWS cloud synchronization (#2539)
- Added Pyroscope collector for collecting profiling data based on Pyroscope for Java/Golang/Python (#2496)

### Bug Fixes {#cl-1.67.0-fix}

### Functionality Improvements {#cl-1.67.0-opt}

- Enhanced DCA configuration documentation (#2553)
- OpenTelemetry collector supports extracting event fields as top-level fields (#2551)
- Enhanced DDTrace-Golang documentation, adding compilation-time instrumentation instructions (#2549)

---

## 1.66.2 (2025/01/17) {#cl-1.66.2}

This release is a hotfix, including some additional minor features. The contents are as follows:

### Bug Fixes {#cl-1.66.2-fix}

- Fixed compatibility issues with the Pipeline debugging interface (!3392)
- Fixed UDS listening problems (#2544)
- UOS images added `linux/arm64` support (#2529)
- Fixed tag priority issues and Bearer Token problems in prom v2 collector (#2546)

---

## 1.66.1 (2025/01/10) {#cl-1.66.1}

This release is a hotfix, including some additional minor features. The contents are as follows:

### Bug Fixes {#cl-1.66.1-fix}

- Fixed known security issues (#2502)
- Fixed excessive CPU usage in log collection under certain conditions (#2500)

---

## 1.66.0 (2025/01/08) {#cl-1.66.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.66.0-new}

- Added [NFS Collector](../integrations/nfs.md) (#2499)
- Pipeline debug interface test data now supports more HTTP `Content-Type` (#2526)
- APM Automatic Instrumentation added Docker container support (#2480)

### Bug Fixes {#cl-1.66.0-fix}

- Fixed issues with OpenTelemetry collector failing to connect micrometer data (#2495)

### Functionality Improvements {#cl-1.66.0-opt}

- Optimized disk metric collection and object collection (#2523)
- Optimized Redis slow log collection, adding client information in slow logs. Additionally, selective support was added for older versions (<4.0) of Redis like Codis (#2525)
- Adjusted error retry mechanism for KubernetesPrometheus collector during metric collection. When target services are briefly offline, they are no longer excluded from collection (#2530)
- Optimized default configuration of PostgreSQL collector (#2532)
- Added entry for trimming metric names in KubernetesPrometheus collector (#2533)
- Supported active extraction of `pod_namespace` tag in DDTrace/OpenTelemetry collectors (#2534)
- Enhanced log collection scan mechanism, forcing the addition of a 1-minute scan mechanism to avoid missing log files under extreme conditions (#2536)

---

## 1.65.2 (2024/12/31) {#cl-1.65.2}

This release is a hotfix, including some additional minor features. The contents are as follows:

### New Features {#cl-1.65.2-new}

- OpenTelemetry collector now defaults to splitting sub-service names `service` (#2522)
- OpenTelemetry added `ENV_INPUT_OTEL_COMPATIBLE_DDTRACE` configuration option (!3368)

### Bug Fixes {#cl-1.65.2-fix}

- Fixed issues where Kubernetes auto-discovery of prom collection would forcibly add `pod_name` and `namespace` fields (#2524)
- Fixed issues with `plugins` configuration not taking effect in SkyWalking (!3368)

---

## 1.65.1 (2024/12/25) {#cl-1.65.1}

This release is a hotfix, including some additional minor features. The contents are as follows:

### New Features {#cl-1.65.1-new}

- KubernetesPrometheus:
    - Selector supports glob matching (#2515)
    - Collected metric data now appends global tags by default (#2519)
    - Optimized `prometheus.io/path` annotation (#2518)
- DCA added ARM image support (#2517)
- Pipeline function `http_request()` added IP whitelist configuration (#2521)

### Bug Fixes {#cl-1.65.1-fix}

- Adjusted Kafka built-in views, fixing issues with mismatched data display (#2468)
- Fixed crash issues with vSphere collector (#2510)

---

## 1.65.0 (2024/12/19) {#cl-1.65.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.65.0-new}

- Added label selector support for object collection in Kubernetes (#2492)
- Added `message` field to container objects (#2508)
- Added [log collection configuration guide document](datakit-logging.md)

### Bug Fixes {#cl-1.65.0-fix}

- Fixed issues where environment variables `ENV_PIPELINE_DEFAULT_PIPELINE` did not take effect since version 1.64.2 (!3354)
- Fixed truncation issues in OceanBase slow logs (#2513)
- Fixed issues where the last log line could not be collected since version 1.62.0 (!3352)

### Functionality Improvements {#cl-1.65.0-opt}

- KubernetesPrometheus collector can adjust timestamps of collected data points according to the collection interval (#2441)
- Container log collection now supports setting the `from-beginning` attribute in Annotation/Label (#2443)
- Optimized strategy for uploading data points to ignore excessively large data points and prevent entire data packets from failing to send (#2440)
- Enhanced zlib format encoding support for Datakit API `/v1/write/:category` (#2439)
- Reduced memory usage in DDTrace data point processing (#2434)
- Optimized resource utilization during eBPF collection (#2430)
- Improved GZip efficiency during uploads (#2428)
- Performed numerous performance optimizations (#2414)

### Compatibility Adjustments {#cl-1.65.0-brk}

- Environment variables `ENV_LOGGING_FIELD_WHITE_LIST/ENV_LOOGING_MAX_OPEN_FILES` only affect log collection within Kubernetes. Collection configured via *logging.conf* **no longer affected by these ENVs** because this version has already provided corresponding entries for *logging.conf*.

---

## 1.64.3 (2024/12/16) {#cl-1.64.3}

This release is a hotfix, including the following changes:

- Added APM Automatic Instrumentation uninstallation entry (#2509)
- Fixed issues with AWS lambda collector being unavailable since version 1.62 (#2505)
- Fixed crashes caused by concurrent read/write in Pipeline (#2503)
- Enhanced export of some built-in views (#2489)
- SNMP collector opened maximum OID count configuration (default max 1000 in new version, only 64 in old versions), avoiding OID collection issues (#2488)
- Fixed issues with negative network latency values in eBPF collector (#2467)
- Added [disclaimer for Datakit usage](index.md#disclaimer)
- Other adjustments and documentation updates (#2507/!3347/!3345/#2501)

---

## 1.64.2 (2024/12/09) {#cl-1.64.2}

This release is a hotfix, including the following changes:

- Fixed known security issues (#2502)
- Fixed extra events listened by inotify causing unnecessary CPU usage in log collection (#2500)

---

## 1.64.1 (2024/12/05) {#cl-1.64.1}

This release is a hotfix, including the following changes:

- Fixed known security issues (#2497)
- Fixed performance issues with `valid_json()` in Pipeline (#2494)
- Fixed Windows installation script issues under PowerShell 4 (#2491)
- Fixed high CPU consumption issues in log collection since version 1.64.0 (#2498)

---

## 1.64.0 (2024/11/27) {#cl-1.64.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.64.0-new}

- Added disk information collection based on lsblk (#2408)
- Host object collection now includes configuration file content collection, supporting up to 4KiB text files (#2453)
- Log collection added a field whitelist mechanism to selectively retain interested fields, reducing network and storage overhead (#2469)
- Restructured existing DCA implementation, changing HTTP (Datakit as server) to WebSocket (Datakit as client) (#2333)
- Added Volcano Cloud support in host objects (#2472)

### Bug Fixes {#cl-1.64.0-fix}

- Fixed issues where partial information collection errors led to the failure of reporting entire host objects (#2478)
- Other bug fixes (#2474)

### Functionality Improvements {#cl-1.64.0-opt}

- Optimized Zabbix data import functionality, optimizing bulk update logic and adjusting metric naming while synchronizing some tags read from MySQL to Zabbix data points (#2455)
- Optimized Pipeline processing performance (reduced memory consumption by over 30%), where the `load_json()` function replaced a more efficient library, improving JSON processing performance by about 16% (#2459)
- Optimized file discovery strategy in log collection using inotify for more efficient handling of new files, avoiding delayed collection (#2462)
- Optimized timestamp alignment mechanism for mainstream metrics to improve time series storage efficiency (#2445)

### Compatibility Adjustments {#cl-1.64.0-brk}

Due to the addition of API whitelist control, some APIs that were enabled by default in older versions will no longer work and need to be manually enabled (#2479)

---

## 1.63.1 (2024/11/21) {#cl-1.63.1}

This release is a hotfix, including the following changes:

- Fixed issues with multi-line processing in socket logging collection (#2461)
- Fixed issues with Datakit not restarting after OOM on Windows (#2465)
- Fixed Oracle metric absence issues (#2464)
- Fixed offline installation issues with APM Automatic Instrumentation (#2466)
- Restored functionality for exposing Prometheus Exporter through Pod annotations which was removed in version 1.63.0 (#2471)

    This feature was removed in version 1.63.0 but many existing services had already been collecting Prometheus metrics this way and temporarily cannot migrate to KubernetesPrometheus form.

---

## 1.63.0 (2024/11/13) {#cl-1.63.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.63.0-new}

- Added [remote job support for Datakit](datakit-conf.md#remote-job) (this feature requires manual activation and Guance needs to be upgraded to version 1.98.181 or higher), currently supporting obtaining JVM Dump via commands issued on the front-end page (#2367)

    In Kubernetes execution, the latest *datakit.yaml* needs to be updated, requiring additional RBAC permissions.

- Pipeline added [string extraction functions](../pipeline/use-pipeline/pipeline-built-in-function.md#fn_slice_string) (#2436)

### Bug Fixes {#cl-1.63.0-fix}

- Fixed potential startup issues with Datakit due to WAL being enabled by default for data sending queue initialization without proper process mutual exclusion handling (#2457)
- Fixed issues where the installer reset some already configured settings in *datakit.conf* (#2454)

### Functionality Improvements {#cl-1.63.0-opt}

- Added data sampling rate configuration in eBPF collector to reduce generated data volume (#2394)  
- Added SSL support in KafkaMQ collector (#2421)
- Graphite data now supports specifying metric sets (#2448)
- Adjusted Service Monitor collection granularity in CRD from Pod to [Endpoint](https://kubernetes.io/docs/concepts/services-networking/service/#endpoints){:target="_blank"}

### Compatibility Adjustments {#cl-1.63.0-brk}

- Removed experimental Kubernetes Self metrics feature, its functionality can be achieved via KubernetesPrometheus (#2405)
- Removed Discovery of container collector's support for Datakit CRD
- Moved Discovery Prometheus functionality of container collector to KubernetesPrometheus collector, maintaining relative compatibility
- No longer supports `PodTargetLabel` configuration fields in Prometheus ServiceMonitor

---

## 1.62.2 (2024/11/09) {#cl-1.62.2}

This release is a hotfix, including the following changes:

- Fixed issues with potential loss of tail data packets during data upload (#2453)

---

## 1.62.1 (2024/11/07) {#cl-1.62.1}

This release is a hotfix, including the following changes:

- Fixed issues with incorrect `message` setting leading to log truncation

---

## 1.62.0 (2024/11/06) {#cl-1.62.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.62.0-new}

- Adjusted log collection buffer to 64KB, optimizing performance for constructing data points (#2450)
- Added log maximum collection limits, defaulting to a maximum of 500 files. In Kubernetes, this can be adjusted via `ENV_LOGGING_MAX_OPEN_FILES` (#2442)
- Supported configuring default Pipeline scripts in *datakit.conf* (#2355)
- Dial Testing collector now supports HTTP Proxy when pulling central dial testing tasks (#2438)
- Datakit can modify main configurations during upgrades similarly to installations by passing command-line environment variables (#2418)
- Added prom v2 collector version, significantly improving parsing performance compared to v1 (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, setting specific switches allows automatic injection of APM by restarting corresponding applications (Java/Python) (#2139)
- RUM Session Replay data now supports blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) now supports multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.62.0-fix}

- Fixed data conversion issues during SQLServer collection (#2429)
- Fixed potential crashes caused by timeout components in HTTP services (#2423)
- Fixed time unit issues in New Relic collection (#2417)
- Fixed potential crashes caused by `point_window()` function in Pipeline (#2416)
- Fixed protocol identification issues in eBPF collection (#2451)

### Functionality Improvements {#cl-1.62.0-opt}

- KubernetesPrometheus collector adjusts timestamps of collected data points based on collection intervals (#2441)
- Container log collection supports setting `from-beginning` attributes in Annotation/Label (#2443)
- Optimized data point upload strategy to ignore overly large data points and prevent entire data packets from failing to send (#2440)
- Enhanced zlib format encoding support for Datakit API `/v1/write/:category` (#2439)
- Reduced memory usage in DDTrace data point processing (#2434)
- Optimized resource utilization during eBPF collection (#2430)
- Improved GZip efficiency during uploads (#2428)
- Numerous performance optimizations in this version (#2414)
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default enabled [HTTP API rate limiting](datakit-conf.md#set-http-api-limit) to avoid excessive memory consumption from sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle blocked uploads and resulting memory consumption. The new disk queue *defaults to caching failed upload data*.
    - Detailed Datakit self-memory usage metrics, increasing multiple dimensions of memory usage in metrics
    - Added WAL panel display in `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Optimized container log collection performance (#2425)
    - Removed log debugging-related fields to optimize network traffic and storage
- Other improvements
    - Optimized *datakit.yaml*, changing image pull policy to `IfNotPresent` (!3264)
    - Optimized documentation for metrics generated based on Profiling (!3224)
    - Updated Kafka views and monitors (!3248)
    - Updated Redis views and monitors (!3263)
    - Added Ligai version notifications (!3247)
    - Added SQLServer built-in views (!3272)

### Compatibility Adjustments {#cl-1.62.0-brk}

- Removed support for configuring different collection intervals (`interval`) on different instances in KubernetesPrometheus. Global intervals can be set in KubernetesPrometheus collector to achieve this.

<!--


NOTE: The following content has been merged into the 1.62.0 version release notes

## 1.61.0 (2024/11/02) {#cl-1.61.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.61.0-new}

- Added log maximum collection limits, defaulting to a maximum of 500 files. In Kubernetes, this can be adjusted via `ENV_LOGGING_MAX_OPEN_FILES` (#2442)
- Supported configuring default Pipeline scripts in *datakit.conf* (#2355)
- Dial Testing collector now supports HTTP Proxy when pulling central dial testing tasks (#2438)
- Datakit can modify main configurations during upgrades similarly to installations by passing command-line environment variables (#2418)

### Bug Fixes {#cl-1.61.0-fix}

- Adjusted default directory for data sending disk queue (WAL); in version 1.60.0, when installing on Kubernetes, the directory was incorrectly set to the *data* directory. This directory is not typically mounted to the host machine's disk, leading to data loss upon Pod restart (#2444)

```yaml
        - mountPath: /usr/local/datakit/cache # Directory should be set to cache directory
          name: cache
          readOnly: false
      ...
      - hostPath:
          path: /root/datakit_cache # WAL disk storage mounted to this directory on the host machine
        name: cache
```

- Fixed data conversion issues during SQLServer collection (#2429)
- Fixed several known issues in version 1.60.0 (#2437):
    - Fixed upgrade program not enabling point-pool by default
    - Fixed double gzip issue on failed retransmissions which led to discarded data by the center. This only occurred if data failed to send on the first attempt
    - Data encoding during transmission could cause memory leaks under certain boundary conditions

### Functionality Improvements {#cl-1.61.0-opt}

- KubernetesPrometheus collector adjusts timestamps of collected data points based on collection intervals (#2441)
- Container log collection supports setting `from-beginning` attributes in Annotation/Label (#2443)
- Optimized data point upload strategy to ignore overly large data points and prevent entire data packets from failing to send (#2440)
- Enhanced zlib format encoding support for Datakit API `/v1/write/:category` (#2439)
- Reduced memory usage in DDTrace data point processing (#2434)
- Added approximately 10MiB cache (dynamically allocated for each currently collected file) for burst log volumes to prevent data loss (#2432)
- Optimized resource utilization during eBPF collection (#2430)
- Improved GZip efficiency during uploads (#2428)
- Other improvements
    - Optimized *datakit.yaml*, changing image pull policy to `IfNotPresent` (!3264)
    - Optimized documentation for metrics generated based on Profiling (!3224)
    - Updated Kafka views and monitors (!3248/!3263)
    - Added Ligai version notifications (!3247)

### Compatibility Adjustments {#cl-1.61.0-brk}

- Removed support for configuring different collection intervals (`interval`) on different instances in KubernetesPrometheus. Global intervals can be set in KubernetesPrometheus collector to achieve this.

---

## 1.60.0 (2024/10/18) {#cl-1.60.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.60.0-new}

- Added prom v2 collector version, significantly improving parsing performance compared to v1 (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, setting specific switches allows automatic injection of APM by restarting corresponding applications (Java/Python) (#2139)
- RUM Session Replay data now supports blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) now supports multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.60.0-fix}

- Fixed potential crashes caused by timeout components in HTTP services (#2423)
- Fixed time unit issues in New Relic collection (#2417)
- Fixed potential crashes caused by `point_window()` function in Pipeline (#2416)

### Functionality Improvements {#cl-1.60.0-opt}

- Numerous performance optimizations (#2414)

    - Experimental feature point-pool enabled by default
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default enabled [HTTP API rate limiting](datakit-conf.md#set-http-api-limit) to avoid excessive memory consumption from sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle blocked uploads and resulting memory consumption. The new disk queue *defaults to caching failed upload data*.
    - Detailed Datakit self-memory usage metrics, increasing multiple dimensions of memory usage in metrics
    - Added WAL panel display in `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Optimized container log collection performance (#2425)
    - Removed log debugging-related fields to optimize network traffic and storage

### Compatibility Adjustments {#cl-1.60.0-brk}

- Due to some performance adjustments, there are some compatibility differences:

    - Maximum size of a single HTTP body upload has been adjusted to 1MB. Similarly, the maximum size of a single log has also been reduced to 1MB. This adjustment aims to reduce Datakit's pooled memory usage under low load conditions
    - Deprecated the original failed retransmission disk queue (which was disabled by default). The new version defaults to enabling a new failed retransmission disk queue

---

-->

## 1.39.0 (2024/09/25) {#cl-1.39.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.39.0-new}

- Added vSphere collector (#2322)
- Profiling collection now supports extracting basic metrics from Profile files (#2335)

### Bug Fixes {#cl-1.39.0-fix}

- Fixed unnecessary collection at startup in KubernetesPrometheus collection (#2412)
- Fixed possible crashes in Redis collector (#2411)
- Fixed RabbitMQ crashes (#2410)
- Fixed issues with `up` metric not accurately reflecting collector operation status (#2409)

### Functionality Improvements {#cl-1.39.0-opt}

- Enhanced compatibility of Redis big-key collection (#2404)
- Dial Testing collector supports custom tag field extraction (#2402)
- Other documentation enhancements (#2401)

---

## 1.38.2 (2024/09/19) {#cl-1.38.2}

This release is a Hotfix, fixing the following issues:

- Fixed global-tag addition errors in Nginx collection (#2406)
- Fixed CPU core collection errors in Windows host object collector (#2398)
- Chrony collector added Dataway synchronization mechanism to avoid time deviation impacts (#2351)
    - This feature depends on Dataway version 1.6.0 (inclusive) and above
- Fixed potential crashes in Datakit HTTP API under timeout conditions (#2091)

---

## 1.38.1 (2024/09/11) {#cl-1.38.1}

This release is a Hotfix, fixing the following issues:

- Fixed `inside_filepath` and `host_filepath` tag errors in container log collection (#2403)
- Fixed special case collection anomalies in Kubernetes-Prometheus collector (#2396)
- Fixed numerous issues in the upgrade program (2372):
    - Offline installation directory errors
    - Configuration of `dk_upgrader` can now follow Datakit configuration changes (no manual configuration required), DCA no longer needs to distinguish between offline and online upgrades.
    - Injection of `dk_upgrader` related ENVs during installation (no additional manual configuration required)
    - `dk_upgrader` HTTP API added new parameters allowing version number specification and forced upgrades (not supported by DCA side yet)

---

## 1.38.0 (2024/09/04) {#cl-1.38.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.38.0-new}

- Added Graphite data ingestion (#2337)
<!-- - Profiling collection supports real-time metric extraction from profiling files (#2335) -->

### Bug Fixes {#cl-1.38.0-fix}

- Fixed abnormal network data aggregation in eBPF (#2395)
- Fixed crashes in DDTrace telemetry interface (#2387)
- Fixed Jaeger UDP binary format data collection issues (#2375)
- Fixed address format issues in dial testing collector data transmission (#2374)

### Functionality Improvements {#cl-1.38.0-opt}

- Host objects added multiple fields (`num_cpu/unicast_ip/disk_total/arch`) collection (#2362)
- Other optimizations and fixes (#2376/#2354/#2393)

### Compatibility Adjustments {#cl-1.38.0-brk}

- Adjusted Pipeline execution priority (#2386)

    In previous versions, for a specific `source`, such as `nginx`:

    1. If users specified a match for *nginx.p* on the Guance web page,
    1. If users also set a default Pipeline (*default.p*)

    Then Nginx logs would not be processed by *nginx.p* but instead by *default.p*. This setting was unreasonable. The adjusted priority order is now (decreasing priority):

    1. Pipeline specified for `source` on the Guance web page
    1. Pipeline specified for `source` in the collector
    1. Pipeline found for `source` value (e.g., logs for `source` value `my-app` would find a *my-app.p* in the Pipeline storage directory)
    1. Finally, using *default.p*

    This ensures all data can be processed by the Pipeline, at least having *default.p* as a fallback.

---

## 1.37.0 (2024/08/28) {#cl-1.37.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.37.0-new}

- Added support for [Zabbix data import](../integrations/zabbix_exporter.md)(#2340)

### Functionality Improvements {#cl-1.37.0-opt}

- Optimized Process collector, default support for collecting open fd counts (#2384)
- Completed RabbitMQ tags (#2380)
- Optimized Kubernetes-Prometheus collector performance (#2373)
- Added more metrics to Redis collection (#2358)

---

## 1.36.0 (2024/08/21) {#cl-1.36.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.36.0-new}

- Added Pipeline functions `pt_kvs_set`, `pt_kvs_get`, `pt_kvs_del`, `pt_kvs_keys`, and `hash` (#2353)
- Dial Testing collector supports custom tags and English node names (#2365)

### Bug Fixes {#cl-1.36.0-fix}

- Fixed memory leak in eBPF collector (#2352)
- Fixed duplicate collection of Kubernetes Events due to accepting Deleted data (#2363)
- Fixed target tag not found issues in KubernetesPrometheus collector for Service/Endpoints (#2349)
    - Note: Requires updating *datakit.yaml*

### Functionality Improvements {#cl-1.36.0-opt}

- Optimized slow log time filtering conditions in Oracle collector (#2360)
- Optimized collection method for `postgresql_size` metric in PostgreSQL collector (#2350)
- Enhanced return information of dial testing debug interface (#2347)
- Optimized handling of `status` field in log data by Pipeline, now supporting any custom log levels (#2371)
- Added fields identifying client/server IPs and ports and connection sides in BPF network logs (#2357)
- Multi-line configuration support for TCP Socket log collection (#2364)
- When deploying Kubernetes, if there are same-name Nodes, supports adding prefixes/suffixes to distinguish `host` field values (#2361)
- Changed default behavior to global blocking mode when reporters submit data to alleviate (note: only alleviates, **cannot prevent**) time series data loss due to queue blockage (#2370)
    - Adjusted monitor information display:
        - Displays data reporter block duration (P90)
        - Displays number of data points per collection for each collector (P90) to better showcase the collection volume of specific collectors

---

## 1.35.0 (2024/08/07) {#cl-1.35.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.35.0-new}

- Added [election whitelist](election.md#election-whitelist) functionality, facilitating Datakit participation in elections on specific hosts (#2261)

### Bug Fixes {#cl-1.35.0-fix}

- Fixed association of container IDs in CentOS process collector (#2338)
- Fixed multiline judgment failure in log collection (#2336)
- Fixed Jaeger Trace-ID length issues (#2329)
- Other bug fixes (#2343)

### Functionality Improvements {#cl-1.35.0-opt}

- `up` metric set automatically adds custom tags from collectors (#2334)
- Cloud information synchronization in host object collection now supports specifying meta addresses for private cloud deployment environments (#2331)
- DDTrace collector now collects basic information of traced services and reports it to resource objects (`CO::`), with object type `tracing_service` (#2307)
- Network dial testing data now includes `node_name` field (#2324)
- Added `__kubernetes_mate_instance` and `__kubernetes_mate_host` placeholder labels in Kubernetes-Prometheus metric collection, optimizing tag addition strategies (#2341) [^2341]
- Optimized TLS configuration for multiple collectors (#2225/#2204/#2192/#2342)
- Added PostgreSQL and AMQP protocol recognition in eBPF link plugin (#2315/#2311)

[^2341]: If the service restarts, corresponding `instance` and `host` might change entirely, doubling the timeline.

---

## 1.34.0 (2024/07/24) {#cl-1.34.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.34.0-new}

- Added custom object collection for mainstream collectors like Oracle/MySQL/Apache (#2207)
- Remote collectors now include `up` metrics (#2304)
- Statsd collector now exposes its own metrics (#2326)
- Added [CockroachDB collector](../integrations/cockroachdb.md) (#2187)
- Added [AWS Lambda collector](../integrations/awslambda.md) (#2258)
- Added [Kubernetes Prometheus collector](../integrations/kubernetesprometheus.md) for automatic Prometheus discovery (#2246)

### Bug Fixes {#cl-1.34.0-fix}

- Fixed excessive memory usage issues with certain Windows versions in bug report and self-collector, temporarily removing some exposed metrics to bypass (#2317)
- Fixed non-display of collectors originating from Confd in `datakit monitor` (#2160)
- Fixed inability to collect logs if Annotation manually set to stdout in containers (#2327)
- Fixed K8s label anomaly in eBPF network log collector (#2325)
- Fixed concurrent read/write errors in RUM collector (#2319)

### Functionality Improvements {#cl-1.34.0-opt}

- Optimized OceanBase collector view templates and added `cluster` Tag to `oceanbase_log` metric (#2265)
- Optimized task failure handling in dial testing collector (#2314)
- Pipeline supports adding script execution information to data, and `http_request` function now supports body parameters (#2313/#2298)
- Optimized memory usage in eBPF collector (#2328)
- Other documentation improvements (#2320)

---

## 1.33.1 (2024/07/11) {#cl-1.33.1}

This release is a Hotfix, fixing the following issues:

- Fixed invalid trace sampling issues introduced since version 1.26. At the same time, added `dk_sampling_rate` field on root-spans to indicate that the trace has been sampled. **Recommended upgrade** (#2312)
- Fixed IP processing bugs in SNMP collection, while exposing additional SNMP collection metrics (#3099)

---

## 1.33.0 (2024/07/10) {#cl-1.33.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.33.0-new}

- Added [OpenTelemetry log collection](../integrations/opentelemetry.md#logging) (#2292)
- Restructured [SNMP collector](../integrations/snmp.md), adding Zabbix/Prometheus configuration support and corresponding built-in views (#2290)

### Bug Fixes {#cl-1.33.0-fix}

- Fixed HTTP dial testing issues (#2293):
    - Response time (`response_time`) did not include download time (`response_download`)
    - IPv6 recognition issues in HTTP dial testing
- Fixed Oracle collector crash and max-cursor issues (#2297)
- Fixed position record issues in log collection, introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed partial customer-tags not taking effect when DDTrace/OpenTelemetry HTTP API received data (#2308)

### Functionality Improvements {#cl-1.33.0-opt}

- Redis big-key collection added 4.x version support (#2296)
- Adjusted internal worker counts based on actual CPU core limits, significantly reducing buffer memory overhead, **recommended upgrade** (#2275)
- Datakit API changed to blocking mode when receiving time series data to avoid data point loss (#2300)
- Optimized performance of the `grok()` function in Pipeline (#2310)
- Added eBPF-related information and Pipeline information to [bug reports](why-no-data.md#bug-report) (#2289)
- k8s auto-discovery ServiceMonitor now supports configuring TLS certificate paths (#1866)
- Host process collector objects and metric data collection now include corresponding container ID fields (`container_id`) (#2283)
- Trace data collection added Datakit fingerprint field (`datakit_fingerprint`, value is Datakit hostname), facilitating issue diagnosis, along with exposure of more collection metrics (#2295)
    - Added statistics for collected Trace quantities
    - Added statistics for discarded sampled Traces

- Documentation improvements:
    - Added [instructions for bug reporting](bug-report-how-to.md)
    - Supplemented differences between installation and upgrade in Datakit [installation and upgrade](datakit-update.md#upgrade-vs-install)
    - Added instructions for setting installation parameters during [offline installation](datakit-offline-install.md#simple-install)
    - Optimized [MongoDB collector](../integrations/mongodb.md) field documentation (#2278)

---

## 1.32.0 (2024/06/26) {#cl-1.32.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.32.0-new}

- OpenTelemetry added histogram metrics (#2276)

### Bug Fixes {#cl-1.32.0-fix}

- Fixed localhost recognition issues in metering reporting (#2281)
- Fixed `service` field assignment issues in log collection (#2286)
- Other defect fixes (#2284/#2282)

### Functionality Improvements {#cl-1.32.0-opt}

- Enhanced master-slave replication-related metrics and log collection in MySQL (#2279)
- Optimized encryption-related documentation and installation options (#2274)
- Reduced memory consumption in DDTrace collection (#2272)
- Optimized data reporting strategy in health check collector (#2268)
- Improved timeout control and TLS settings in SQLServer collection (#2264)
- Optimized `job` field handling in Prometheus-related metrics collection (Push Gateway/Remote Write) (#2271)
- Enhanced OceanBase slow query fields by adding client IP information (#2280)
- Rewrote Oracle collector (#2186)
- Optimized target domain name extraction in eBPF collection (#2287)
- Default protocol for uploading collected data changed to v2 (Protobuf) (#2269)
    - Comparison between [v1 and v2 protocols](pb-vs-lp.md)
- Other adjustments (#2267/#2255/#2237/#2270/#2248)

---

## 1.31.0 (2024/06/13) {#cl-1.31.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.31.0-new}

- Support for configuring sensitive information via [encryption methods](datakit-conf.md#secrets_management) (e.g., database passwords) (#2249)
- Added [Prometheus Push Gateway metric push functionality](../integrations/pushgateway.md) (#2260)
- Container objects now support appending corresponding Kubernetes Labels (#2252)
- eBPF link plugin added Redis protocol recognition (#2248)

### Bug Fixes {#cl-1.31.0-fix}

- Fixed incomplete SNMP collection issues (#2262)
- Fixed duplicate Pod collection issues in Kubernetes Autodiscovery (#2259)
- Added protection measures to prevent duplicate collection of container-related metrics (#2253)
- Fixed abnormal Windows platform CPU metrics (huge invalid values) (#2028)

### Functionality Improvements {#cl-1.31.0-opt}

- Optimized PostgreSQL metric collection (#2263)
- Optimized bpf-netlog collection fields (#2247)
- Enhanced OceanBase data collection (#2122)
- Other adjustments (#2267/#2255/#2237)

---

## 1.30.0 (2024/06/04) {#cl-1.30.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.30.0-new}

- Pipeline
    - Added `gjson()` function for ordered JSON field extraction (#2167)
    - Added context caching functionality (#2157)

### Bug Fixes {#cl-1.30.0-fix}

- Fixed global-tag append issues in Prometheus Remote Write introduced since version 1.25.0 (#2244)

### Functionality Improvements {#cl-1.30.0-opt}

- Optimized Datakit [`/v1/write/:category` API](apis.md#api-v1-write), making the following adjustments and functionalities (#2130)
    - Added more API parameters (like [`echo`](apis.md#preview-post-point)/`dry`), facilitating debugging
    - Supported more types of data formats
    - Supported fuzzy timestamp precision recognition in data points (#2120)
- Optimized MySQL/Nginx/Redis/SQLServer metric collection (#2196)
    - MySQL added master-slave replication-related metrics
    - Redis slow logs added duration metrics
    - Nginx added more Nginx Plus-related metrics
    - SQLServer optimized Performance-related metric structure
- Added low-version TLS support in MySQL collector (#2245)
- Optimized TLS certificate configuration for Kubernetes' own etcd metric collection (#2032)
- Prometheus Exporter metric collection now supports configuring "preserve original metric names" (#2231)
- Kubernetes Node objects added taint-related information (#2239)
- eBPF-Tracing added MySQL protocol recognition (#1768)
- Optimized ebpftrace collector performance (#2226)
- Running status of dial testing collector now displayed on `datakit monitor` command panel (#2243)
- Other view and documentation enhancements (#1976/#1977/#2194/#2195/#2221/#2235)

### Compatibility Adjustments {#cl-1.30.0-brk}

In this version, the data protocol has been extended. After upgrading from older versions of Datakit, if the central base is privately deployed, one of the following measures can be taken to maintain data compatibility:

- Upgrade the central base to [1.87.167](../deployment/changelog/2024.md#1.87.167), or
- Modify *datakit.conf* to change the upload protocol configuration `content_encoding` to `v2`

#### Notes for InfluxDB Deployment Plan {#cl-1.30.0-brk-influxdb}

If the central base's time series storage is InfluxDB, **do not upgrade Datakit**, stay at version 1.29.1. Future upgrades to Datakit require subsequent central upgrades.

Additionally, if the central has been upgraded to a newer version (1.87.167+), then lower versions of Datakit should **not use the `v2` upload protocol**, switch to `v1` instead.

If you must upgrade to a newer Datakit version, replace the time series engine with GuanceDB for metrics.

---

## 1.29.1 (2024/05/20) {#cl-1.29.1}

This release is a Hotfix, fixing the following issues:

- Fixed potential crashes in MongoDB collector (#2229)

---

## 1.29.0 (2024/05/15) {#cl-1.29.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.29.0-new}

- Container log collection now supports color character filtering `remove_ansi_escape_codes` in Annotations (#2208)
- [Health Check collector](../integrations/host_healthcheck.md) now supports command-line parameter filtering (#2197)
- Added [Cassandra collector](../integrations/cassandra.md) (#1812)
- Added usage statistics functionality (#2177)
- eBPF Tracing added HTTP2/gRPC support (#2017)

### Bug Fixes {#cl-1.29.0-fix}

- Fixed Kubernetes not collecting Pending Pods (#2214)
- Fixed logfwd startup failure (#2216)
- Fixed special case lack of color character filtering in log collection (#2209)
- Fixed Profile collection unable to append Tags (#2205)
- Fixed Goroutine leaks in Redis/MongoDB collectors (#2199/#2215)

### Functionality Improvements {#cl-1.29.0-opt}

- Supported `insecureSkipVerify` configuration item in Prometheus PodMonitor/ServiceMonitor TLSConfig (#2211)
- Enhanced security for dial testing debug interface (#2203)
- Nginx collector now supports port range specification (#2206)
- Enhanced TLS certificate ENV settings (#2198)
- Other documentation optimizations (#2210/#2213/#2218/#2223/#2224/#2141/#2080)

### Compatibility Adjustments {#cl-1.29.0-brk}

- Removed file path method for Prometheus PodMonitor/ServiceMonitor TLSConfig certificates (#2211)
- Optimized DCA route parameters and reload logic (#2220)

---

## 1.28.1 (2024/04/22) {#cl-1.28.1}

This release is a Hotfix, fixing the following issues:

- Fixed data absence issues caused by some crashes (#2193)

---

## 1.28.0 (2024/04/17) {#cl-1.28.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.28.0-new}

- Pipeline added functions `cache_get()/cache_set()/http_request()`, expanding external data sources for Pipeline (#2128)
- Supported collecting Kubernetes system resource Prometheus metrics, currently experimental (#2032)

### Bug Fixes {#cl-1.28.0-fix}

- Fixed filter logic issues in container logs (#2188)

### Functionality Improvements {#cl-1.28.0-opt}

- PrometheusCRD-ServiceMonitor now supports TLS path configuration (#2168)
- Optimized NIC information collection under Bond mode (#1877)
- Further optimized Windows Event collection performance (#2172)
- Optimized field information extraction in Jaeger APM data collection (#2174)
- Removed disk cache functionality in log collection (#2191)
- Log collection added `log_file_inode` field
- Added point-pool configuration to optimize Datakit's memory usage under high load (#2034)
    - Restructured some Datakit modules to optimize GC costs; this optimization may slightly increase memory usage under low load conditions (additional memory is mainly used for memory pools)
- Other documentation adjustments and minor optimizations (#2191/#2189/#2185/#2181/#2180)

---

## 1.27.0 (2024/04/03) {#cl-1.27.0}

### New Features {#cl-1.27.0-new}

- Added Pipeline Offload collector, dedicated to centralized Pipeline processing (#1917)
- Supported BPF-based HTTP/HTTP2/gRPC network data collection, covering lower Linux kernel versions (#2017)

### Bug Fixes {#cl-1.27.0-fix}

- Fixed default time chaos in Point construction (#2163)
- Fixed potential crashes in Kubernetes collection (#2176)
- Fixed Nodejs Profiling collection issues (#2149)

### Functionality Improvements {#cl-1.27.0-opt}

- Prometheus Remote Write collection now supports prefix-based metric set attribution (#2165)
- Enhanced Datakit's own metrics, adding crash count statistics for each module's Goroutines (#2173)
- Enhanced bug report functionality, supporting direct upload of info files to OSS (#2170)
- Optimized Windows Event collection performance (#2155)
- Optimized historical position record feature in log collection (#2156)
- Dial Testing collector now supports disabling internal network dial tests (#2142)
- Other miscellaneous and documentation updates (#2154/#2148/#1975/#2164)

---

## 1.26.1 (2024/03/27) {#cl-1.26.1}

This release is a Hotfix, fixing the following issues:

- Fixed Redis not supporting TLS (#2161)
- Fixed timestamp issues in Trace data (#2162)
- Fixed writing to Prometheus Remote Write in vmalert (#2153)

---

## 1.26.0 (2024/03/20) {#cl-1.26.0}

### New Features {#cl-1.26.0-new}

- Added Doris collector (#2137)

### Bug Fixes {#cl-1.26.0-fix}

- Fixed repeated resampling after DDTrace header sampling (#2131)
- Fixed missing tags in custom SQLServer collection (#2144)
- Fixed duplicate collection of Kubernetes Events (#2145)
- Fixed inaccurate collection of container counts in Kubernetes (#2146)
- Fixed incorrect sampling of some Traces in Trace collection (#2135)

### Functionality Improvements {#cl-1.26.0-opt}

- *datakit.conf* added upgrade program configuration, and host object collector also added fields related to the upgrade program (#2124)
- Enhanced bug report functionality by attaching error information to attachments (#2132)
- Optimized TLS settings and default configuration files for MySQL collector (#2134)
- Optimized logic for global tag configuration in host cloud synchronization, allowing cloud-synced tags not to be added to global-host-tags (#2136)
- Added `redis-cli` command in Datakit image to facilitate collection of big-key/hot-key in Redis (#2138)
- Kafka-MQ data now includes `offset/partition` fields (#2140)
- Other miscellaneous and documentation updates (#2133/#2143)

---

## 1.25.0 (2024/03/06) {#cl-1.25.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.25.0-new}

- Datakit API added dynamic Global Tag update interfaces (#2076)
- Added Kubernetes PersistentVolume / PersistentVolumeClaim collection, requiring additional [RBAC](../integrations/container.md#rbac-pv-pvc) (#2109)

### Bug Fixes {#cl-1.25.0-fix}

- Fixed SkyWalking RUM root-span issues (#2131)
- Fixed incomplete Windows Event collection (#2118)
- Fixed missing `host` field in Pinpoint collection (#2114)
- Fixed RabbitMQ metric collection issues (#2108)
- Fixed OpenTelemetry old version compatibility issues (#2089)
- Fixed line parsing errors in Containerd logs (#2121)

### Functionality Improvements {#cl-1.25.0-opt}

- StatsD collector converts count-type data to float by default (#2127)
- Container collector now supports Docker 1.24+ versions (#2112)
- Optimized SQLServer collector (#2105)
- Optimized Health Check collector (#2105)
- Default time setting for log collection (#2116)
- Added environment variable `ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB` to disable Kubernetes Job resource collection (#2129)
- Updated several built-in views for collectors:
    - ssh (#2125)
    - etcd (#2101)
- Other miscellaneous and documentation updates (#2119/#2123/#2115/#2113)

---

## 1.24.0 (2024/01/24) {#cl-1.24.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.24.0-new}

- Added [Host Health Check collector](../integrations/host_healthcheck.md) (#2061)

### Bug Fixes {#cl-1.24.0-fix}

- Fixed potential crashes in Windows Event collection (#2087)
- Fixed data recording feature issues and enhanced [related documentation](datakit-daemonset-deploy.md#env-recorder) (#2092)
- Fixed multi-link propagation issues in DDTrace (#2093)
- Fixed truncation issues in Socket log collection (#2095)
- Fixed leftover main configuration file issues during Datakit upgrade (#2096)
- Fixed script overwrite issues (#2085)

### Functionality Improvements {#cl-1.24.0-opt}

- Optimized resource limit functionality for Linux non-root installations (#2011)
- Optimized blacklist matching performance, drastically reducing memory consumption (by 10X) (#2077)
- Log Streaming collection [supports FireLens](../integrations/logstreaming.md#firelens) type (#2090)
- Log Forward collection added `log_read_lines` field (#2098)
- Optimized handling of `cluster_name_k8s` tag in K8s (#2099)
- K8s Pod time series metrics added restart count (`restarts`) field
- Optimized `kubernetes` time series metric set, adding container statistics
- Optimized Kubelet metric collection logic

---

## 1.23.1 (2024/01/12) {#cl-1.23.1}

This release is a Hotfix, fixing the following issues:

- Fixed service anomalies on Windows for Datakit

---

## 1.23.0 (2024/01/11) {#cl-1.23.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.23.0-new}

- Kubernetes deployment now supports configuring any collector via environment variables (`ENV_DATAKIT_INPUTS`) (#2068)
- Container collector now supports finer-grained configurations, converting Kubernetes object labels to tags in collected data (#2064)
    - `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2_FOR_METRIC`: Supports converting labels to tags for metric data
    - `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2`: Supports converting labels to tags for non-metric data (such as objects/logs)

### Bug Fixes {#cl-1.23.0-fix}

- Fixed occasional errors in `deployment` and `daemonset` fields in container collectors (#2081)
- Fixed losing last few log lines in short-lived containers (#2082)
- Fixed incorrect time in slow SQL queries in [Oracle](../integrations/oracle.md) collector (#2079)
- Fixed `instance` setting issues in Prom collector (#2084)

### Functionality Improvements {#cl-1.23.0-opt}

- Optimized Prometheus Remote Write collection (#2069)
- eBPF collection supports setting resource utilization (#2075)
- Optimized Profiling data collection flow (#2083)
- [MongoDB](../integrations/mongodb.md) collector now supports separate username and password configuration (#2073)
- [SQLServer](../integrations/sqlserver.md) collector now supports specifying instance names (#2074)
- Enhanced [ElasticSearch](../integrations/elasticsearch.md) collector views and monitors (#2058)
- [KafkaMQ](../integrations/kafkamq.md) collector supports multi-threaded mode (#2051)
- [SkyWalking](../integrations/skywalking.md) collector added Meter data type support (#2078)
- Updated some collector documents and other bug fixes (#2074/#2067)
- Enhanced upgrade command for Proxy proxy installation (#2033)
- Optimized resource limit functionality for non-root user installations (#2011)

---

## 1.22.0 (2023/12/28) {#cl-1.22.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.22.0-new}

- Added [OceanBase](../integrations/oceanbase.md) custom SQL collection (#2046)
- Added blacklist/whitelist for [Prometheus Remote](../integrations/prom_remote_write.md) (#2053)
- Added `node_name` tag for resource quantity collection in Kubernetes (only for Pod resources) (#2057)
- Kubernetes Pod metrics added `cpu_limit_millicores/mem_limit/mem_used_percent_base_limit` fields
- eBPF collector added `bpf-netlog` plugin (#2017)
- Data recording function in Kubernetes supports configuration via environment variables

### Bug Fixes {#cl-1.22.0-fix}

- Fixed zombie process issues in [`external`](../integrations/external.md) collector (#2063)
- Fixed conflicts in container log tags (#2066)
- Fixed virtual network card information retrieval failures (#2050)
- Fixed Pipeline Refer table and IPDB functionality issues (#2045)

### Optimization {#cl-1.22.0-opt}

- Optimized whitelist functionality for extracting DDTrace and OTEL fields (#2056)
- Optimized SQLServer `sqlserver_lock_dead` metric SQL retrieval (#2049)
- Optimized connection library for [PostgreSQL](../integrations/postgresql.md) collector (#2044)
- Set `local` to `false` by default in [ElasticSearch](../integrations/elasticsearch.md) collector configuration (#2048)
- Increased more ENV configuration items during K8s installation (#2025)
- Enhanced Datakit's own metrics exposure
- Updated some collector integration documents

---

## 1.21.1 (2023/12/21) {#cl-1.21.1}

This release is a Hotfix, fixing the following issues:

- Fixed issues where Prometheus Remote Write did not add Datakit host-class Tags, maintaining compatibility with old configurations (#2055)
- Fixed missing host-class Tags in some middleware default log collections
- Fixed Chinese character color erase garbling issues in log collection

---

## 1.21.0 (2023/12/14) {#cl-1.21.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.21.0-new}

- Added [ECS Fargate collection mode](ecs-fargate.md) (#2018)
- Added tag whitelist for [Prometheus Remote](../integrations/prom_remote_write.md) collector (#2031)

### Bug Fixes {#cl-1.21.0-fix}

- Fixed version detection issues in [PostgreSQL](../integrations/postgresql.md) collector (#2040)
- Fixed account permission settings in [ElasticSearch](../integrations/elasticsearch.md) collector (#2036)
- Fixed crash issues in [Host Dir](../integrations/hostdir.md) collector when collecting disk root directories (#2037)

### Optimization {#cl-1.21.0-opt}

- Optimized DDTrace collector: [Removed duplicate tags in `message.Mate`](../integrations/ddtrace.md#tags) (#2010)
- Optimized search strategy for log file paths within containers (#2027)
- Added `datakit_version` field and set collection time to task start time in [Dial Testing collector](../integrations/dialtesting.md) (#2029)
- Removed `datakit export` command to reduce binary size (#2024)
- Added number of time series points to [debugging collector configuration](why-no-data.md#check-input-conf) (#2016)
- Used disk cache for asynchronous reporting in [Profile collection](../integrations/profile.md) (#2041)
- Optimized Windows installation scripts (#2026)
- Updated built-in views and monitors for multiple collectors

### Breaking Changes {#cl-1.21.0-brk}

- DDTrace collector no longer extracts all fields by default, which might lead to missing custom fields on some pages. Specific fields can be extracted using Pipeline or new JSON lookup syntax (`message@json.meta.xxx`)

---

## 1.20.1 (2023/12/07) {#cl-1.20.1}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.20.1-fix}

- Fixed a sampling bug in DDTrace
- Fixed a bug causing `error_message` information loss
- Fixed a bug where Kubernetes Pod object data did not correctly collect deployment fields

---

## 1.20.0 (2023/11/30) {#cl-1.20.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.20.0-new}

- [Redis](../integrations/redis.md) collector added hotkey metrics (#2019)
- Monitor command supports playing back [bug report](why-no-data.md#bug-report) metrics (#2001)
- [Oracle](../integrations/oracle.md) collector added custom queries (#1929)
- Container log files within [containers](../integrations/container.md) support wildcard collection (#2004)
- Kubernetes Pod metrics support `network` and `storage` field collection (#2022)
- [RUM](../integrations/rum.md) added configuration support for session replay filtering (#1945)

### Bug Fixes {#cl-1.20.0-fix}

- Fixed panic errors in cgroup environments (#2003)
- Fixed execution failure of Windows installation script under low PowerShell versions (#1997)
- Fixed default enabling of disk cache (#2023)
- Adjusted naming style of Prom metrics sets in Kubernetes Auto-Discovery (#2015)

### Functionality Improvements {#cl-1.20.0-opt}

- Optimized built-in collector template views and monitor views, updating MySQL/PostgreSQL/SQLServer view templates (#2008/#2007/#2013/#2024)
- Optimized Prom collector's own metric names (#2014)
- Provided basic performance benchmarks for [Proxy](../integrations/proxy.md) collector (#1988)
- Container log collection now supports adding Pod Labels (#2006)
- Default usage of `NODE_LOCAL` mode for collecting Kubernetes data, requiring additional [RBAC](../integrations/container.md#rbac-nodes-stats) (#2025)
- Optimized link processing flow (#1966)
- Restructured PinPoint collector, optimizing hierarchical relationships (#1947)
- APM supports discarding `message` fields to save storage (#2021)

---

## 1.19.2 (2023/11/20) {#cl-1.19.2}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.19.2-fix}

- Fixed session replay data loss due to disk cache bugs
- Added Prometheus metrics for resource collection duration in Kubernetes

---

## 1.19.1 (2023/11/17) {#cl-1.19.1}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.19.1-fix}

- Fixed disk cache startup issues due to `.pos` file problems ([issue](https://github.com/GuanceCloud/cliutils/pull/59){:target="_blank"}) 

---

## 1.19.0 (2023/11/16) {#cl-1.19.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.19.0-new}

- Supported [OceanBase](../integrations/oceanbase.md) MySQL mode collection (#1952)
- Added [data recording/playback](datakit-tools-how-to.md#record-and-replay) functionality (#1738)

### Bug Fixes {#cl-1.19.0-fix}

- Fixed ineffective resource restrictions on low-version Windows (#1987)
- Fixed ICMP dial testing issues (#1998)

### Functionality Improvements {#cl-1.19.0-opt}

- Optimized statsd collection (#1995)
- Enhanced Datakit installation scripts (#1979)
- Improved MySQL built-in views (#1974)
- Enhanced Datakit's own metrics exposure, adding complete Golang runtime and multiple metrics (#1971/#1969)
- Other documentation and unit test optimizations (#1952/#1993)
- Enhanced Redis metric collection, adding more metrics (#1940)
- Allowed adding packet (ASCII text only) detection in TCP dial testing (#1934)
- Optimized issues with non-root user installations:
    - Potential failure to start due to ulimit setting failure (#1991)
    - Enhanced documentation, adding restricted function descriptions for non-root installations (#1989)
    - Adjusted pre-installation operations for non-root installations to manual configuration, avoiding command differences across operating systems (#1990)
- MongoDB collector added support for older versions 2.8.0 (#1985)
- RabbitMQ collector added support for older versions (3.6.X/3.7.X) (#1944)
- Optimized Kubernetes Pod metric collection to replace the original Metric Server method (#1972)
- Allowed configuring metric set names when collecting Prometheus metrics in Kubernetes (#1970)

### Compatibility Adjustments {#cl-1.19.0-brk}

- Removed the write-to-file feature due to the addition of data recording/playback functionality (#1738)

---

## 1.18.0 (2023/11/02) {#cl-1.18.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.18.0-new}

- Added OceanBase collection (#1924)

### Bug Fixes {#cl-1.18.0-fix}

- Fixed large Tag value compatibility in Tracing data, now adjusted to 32MB (#1932)
- Fixed dirty data issues in RUM session replay (#1958)
- Fixed metric export issues (#1953)
- Fixed build errors in [v2 protocol](datakit-conf.md#dataway-settings)

### Functionality Improvements {#cl-1.18.0-opt}

- Host directory and disk collection added mount point and other metrics (#1941)
- KafkaMQ supported OpenTelemetry Tracing data processing (#1887)
- Bug Report added more information collection (#1908)
- Enhanced self-metric exposure in Prom collection process (#1951)
- Updated default IP library to support IPv6 (#1957)
- Changed image download address to `pubrepo.guance.com` (#1949)
- Optimized file position functionality in log collection (#1961)
- Kubernetes
    - Supported Node-Local Pod information collection to alleviate election node pressure (#1960)
    - Container log collection supports more granular filtering (#1959)
    - Added service-related metrics (#1948)
    - Supported filtering Labels on PodMonitor and ServiceMonitor (#1963)
    - Supported converting Node Labels to Node object Tags (#1962)

### Compatibility Adjustments {#cl-1.18.0-brk}

- Kubernetes no longer collects CPU/memory metrics for Pods created by Job/CronJob (#1964)

---

## 1.17.3 (2023/10/31) {#cl-1.17.3}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.17.3-fix}

- Fixed invalid Pipeline configuration in log collection (#1954)
- Fixed eBPF running issues on arm64 platforms (#1955)

---

## 1.17.2 (2023/10/27) {#cl-1.17.2}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.17.2-fix}

- Fixed missing global host tags in log collection (#1942)
- Optimized Session Replay data processing (#1943)
- Improved handling of non-UTF8 strings in Point encoding

---

## 1.17.1 (2023/10/26) {#cl-1.17.1}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.17.1-fix}

- Fixed dial testing data upload issues

### New Features {#cl-1.17.1-new}

- Added [eBPF-based trace data](../integrations/ebpftrace.md) to represent Linux process/thread call relationships (#1836)
- Pipeline added function [`pt_name`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-pt-name) (#1937)

### Functionality Improvements {#cl-1.17.1-opt}

- Optimized point data construction, improving memory usage efficiency (#1792)

---

## 1.17.0 (2023/10/19) {#cl-1.17.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.17.0-new}

- Added `cpu_limit` metric to Pods (#1913)
- Integrated [New Relic](../integrations/newrelic.md) trace data (#1834)

### Bug Fixes {#cl-1.17.0-fix}

- Fixed potential memory issues caused by excessively long single-line logs (#1923)
- Fixed disk mount point retrieval failure in [disk](../integrations/disk.md) collector (#1919)
- Fixed mismatched Service names between helm and YAML (#1910)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting in [MongoDB](../integrations/mongodb.md) collector (#1884)
- Fixed numerous 408 and 500 status codes in [RUM](../integrations/rum.md) requests (#1915)

### Functionality Improvements {#cl-1.17.0-opt}

- Optimized exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](../integrations/elasticsearch.md) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](../integrations/disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

---

## 1.16.1 (2023/10/09) {#cl-1.16.1}

This release is a Hotfix, fixing the following issues:

### Bug Fixes {#cl-1.16.1-fix}

- Fixed CPU metric retrieval failures and multiline log collection issues in [K8s/container collector](../integrations/container.md) (#1895)
- Fixed excessive memory usage in [Prom collector](../integrations/prom.md) (#1905)

### Breaking Changes {#cl-1.16.1-bc}

- Tracing data collection no longer replaces meta field names containing `-` with `_`. This change avoids association issues between tracing data and log data (#1903)
- All [Prom collectors](../integrations/prom.md) now default to stream collection mode to avoid large memory consumption from unknown Exporters.

---

## 1.16.0 (2023/09/21) {#cl-1.6.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.16.0-new}

- Added Neo4j collector (#1846)
- [RUM](../integrations/rum.md#upload-delete) collector added sourcemap file upload, deletion, and validation interfaces, and removed sourcemap upload and delete interfaces from DCA service (#1860)
- Added monitoring views and detection libraries for [IBM Db2 collector](../integrations/db2.md) (#1862)

### Bug Fixes {#cl-1.16.0-fix}

- Fixed inability to retrieve hostname using `ENV_GLOBAL_HOST_TAGS` (#1874)
- Fixed missing `open_files` field in [host_processes](../integrations/host_processes.md) collector (#1875)
- Fixed high memory usage in Pinpoint collector resource fields and pinpoint (#1857 #1849)

### Functionality Improvements {#cl-1.16.0-opt}

- Optimized Kubernetes metric and object collection efficiency (#1854)
- Enhanced metrics output in log collection (#1881)
- Added `unschedulable` and `node_ready` fields to Kubernetes Node objects (#1886)
- [Oracle collector](../integrations/oracle.md) now supports Linux ARM64 architecture (#1859)
- Added integration tests for [logstreaming](../integrations/logstreaming.md) (#1570)
- Added content about [IBM Db2 collector](../integrations/db2.md) to [Datakit development documentation](development.md) (#1870)
- Enhanced documentation for [Kafka](../integrations/kafka.md) and [MongoDB](../integrations/mongodb.md) collectors (#1883)
- MySQL collector's monitoring account creation now defaults to `caching_sha2_password` encryption for MySQL 8.0+ (#1882)
- Optimized [bug report](why-no-data.md#bug-report) command to handle oversized syslog files (#1872)

### Breaking Changes {#cl-1.16.0-bc}

- Removed sourcemap file upload and delete interfaces from DCA service, moving them to [RUM](../integrations/rum.md#upload-delete) collector

---

## 1.15.1 (2023/09/12) {#cl-1.15.1}

### Bug Fixes {#cl-1.15.1-fix}

- Fixed duplicate collection issues in logfwd

---

## 1.15.0 (2023/09/07) {#cl-1.15.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.15.0-new}

- [Windows](datakit-install.md#resource-limit) supports memory/CPU limits (#1850)
- Added [IBM Db2 collector](../integrations/db2.md) (#1818)

### Bug Fixes {#cl-1.15.0-fix}

- Fixed double star issue in include/exclude configurations for container and Kubernetes collection (#1855)
- Fixed field error in k8s Service objects

### Functionality Improvements {#cl-1.15.0-opt}

- [Confd](confd.md) added Nacos backend support (#1315 #1327)
- Log collection added LocalCache feature (#1326)
- Supported [C/C++ Profiling](profile-cpp.md) (#1320)
- RUM Session Replay file reporting (#1283)
- WEB DCA supports remote config updates (#1284)

### Compatibility Adjustments {#cl-1.15.0-brk}

- Removed `datakit --man` command

---

## 1.14.2 (2023/09/04) {#cl-1.14.2}

### Bug Fixes {#cl-1.14.2-fix}

- Fixed missing `instance` tag in Prometheus annotations on Kubernetes Pods
- Fixed Pod object collection issues

---

## 1.14.1 (2023/08/30) {#cl-1.14.1}

### Bug Fixes {#cl-1.14.1-fix}

- Optimized (stream collection) Prometheus metric collection in Kubernetes to avoid potential high memory usage (#1853/#1845)
- Fixed [color character processing](../integrations/logging.md#ansi-decode) in logs
    - Environment variable for Kubernetes: `ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES`

---

## 1.14.0 (2023/08/24) {#cl-1.14.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.14.0-new}

- Added [NetFlow](../integrations/netflow.md) collector (#1821)
- Added [debugging filter](datakit-tools-how-to.md#debug-filter) (#1787)
- Added Kubernetes StatefulSet metrics and object collection, introducing `replicas_desired` object field (#1822)
- Added [DK_LITE](datakit-install.md#lite-install) environment variable for installing DataKit Lite version (#123)

### Bug Fixes {#cl-1.14.0-fix}

- Fixed issues with HostTags and ElectionTags not being correctly added in Container and Kubernetes collection (#1833)
- Fixed issues with custom Tags being empty when collecting [MySQL](../integrations/mysql.md#input-config) metrics (#1835)

### Functionality Improvements {#cl-1.14.0-opt}

- Added [process_count](../integrations/system.md#metric) metric in System collector indicating the current machine's process count (#1838)
- Removed [open_files_list](../integrations/host_processes.md#object) field in Process collector (#1838)
- Added handling cases for lost metrics in [host object collector](../integrations/hostobject.md#faq) documentation (#1838)
- Enhanced DataKit Prometheus metrics documentation
- Optimized [mount method](../integrations/container-log.md#logging-with-inside-config) for Pod/container logs (#1844)
- Added integration tests for Process and System collectors (#1841/#1842)
- Enhanced etcd integration tests (#1847)
- Upgraded Golang to 1.19.12 (#1516)
- Added option to install DataKit via `ash` command (#123)
- [RUM collection](../integrations/rum.md) now supports custom metrics sets; default metrics set added `telemetry` (#1843)

### Compatibility Adjustments {#cl-1.14.0-brk}

- Removed Sinker functionality from DataKit side, transferring it to [Dataway side](../deployment/dataway-sink.md) (#1801)
- Removed `pasued` and `condition` fields from Kubernetes Deployment metrics data, adding `paused` field to object data

---

## 1.13.2 (2023/08/15) {#cl-1.13.2}

### Bug Fixes {#cl-1.13.2-fix}

- Fixed MySQL custom collection failures (#1831)
- Fixed scope and execution errors in Prometheus Exporter (#1828)
- Fixed HTTP response code and latency anomalies in eBPF collector (#1829)

### Functionality Improvements {#cl-1.13.2-opt}

- Enhanced image field values in container collection (#1830)
- Optimized MySQL integration test speed (#1826)

---

## 1.13.1 (2023/08/11) {#cl-1.13.1}

- Fixed naming issues in the `source` field of container logs (#1827)

---

## 1.13.0 (2023/08/10) {#cl-1.13.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.13.0-new}

- Host object collector supports debug commands (#1802)
- KafkaMQ added external plugin handle support (#1797)
- Container collection now supports cri-o runtime (#1763)
- Pipeline added `create_point` function for metric generation (#1803)
- Added PHP language profiling support (#1811)

### Bug Fixes {#cl-1.13.0-fix}

- Fixed Cat collector NPE exceptions.
- Fixed `response_download` time in dial testing collector (#1820)
- Fixed partial log concatenation issues in containerd log collection (#1825)
- Fixed `ebpf-conntrack` probe failure in eBPF collector (#1793)

### Functionality Improvements {#cl-1.13.0-opt}

- Enhanced bug-report command (#1810)
- RabbitMQ collector now supports multiple concurrent runs (#1756)
- Removed `state` field from host object collector (#1802)
- Resolved eBPF collector's inability to report errors (#1802)
- Added error reporting mechanism in Oracle external collector (#1802)
- Enhanced Python documentation, adding module not found resolution cases (#1807)
- OpenTelemetry added metrics sets and dashboards
- Adjusted `k8s event` fields (#1766)
- Added new container collection fields (#1819)
- Added traffic fields to `httpflow` in eBPF collector (#1790)

---

## 1.12.3 (2023/08/03) {#cl-1.12.3}

- Fixed Windows log file delay release issue (#1805)
- Fixed initial log collection issues in new containers
- Fixed potential crashes due to certain regular expressions (#1781)
- Reduced installation package size (#1804)
- Fixed possible failure in enabling disk cache for log collection

---

## 1.12.2 (2023/07/31) {#cl-1.12.2}

- Fixed OpenTelemetry Metric and Trace routing configuration issues

---

## 1.12.1 (2023/07/28) {#cl-1.12.1}

- Fixed old-version DDTrace Python Profile integration issues (#1800)

---

## 1.12.0 (2023/07/27) {#cl-1.12.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.12.0-new}

- [HTTP API](apis.md##api-sourcemap) added sourcemap file upload (#1782)
- Added .net Profiling support (#1772)
- Added Couchbase collector (#1717)

### Bug Fixes {#cl-1.12.0-fix}

- Fixed missing `owner` field in dial testing collector (#1789)
- Fixed missing `host` field in DDTrace collector, and switched Tag collection to blacklist mechanism for various Traces (#1776)
- Fixed CORS issues in RUM API (#1785)

### Functionality Improvements {#cl-1.12.0-opt}

- Enhanced SNMP collector encryption algorithm recognition methods; improved SNMP collector documentation with more examples (#1795)
- Added Kubernetes deployment examples for [Pythond collector](../integrations/pythond.md), including Git deployment examples (#1732)
- Added InfluxDB, Solr, NSQ, Net integration tests (#1758/#1736/#1759/#1760)
- Added Flink metrics (#1777)
- Expanded Memcached, MySQL metrics collection (#1773/#1742)
- Updated Datakit self-exposure metrics (#1492)
- Pipeline added more operator support (#1749)
- Dial Testing:
    - Added IP fields for TCP/HTTP (#1108)
    - Adjusted units for some fields (#1113)

- Adjusted Remote Pipeline debugging API (#1128)
- Added singleton control for collectors (#1109)
- Changed log class data (except metrics) reporting to blocking mode in IO module (#1121)
- Enhanced terminal prompts during installation/upgrade (#1145)
- Other optimizations (#1777/#1794/#1778/#1783/#1775/#1774/#1737)

---

## 1.11.0 (2023/07/11) {#cl-1.11.0}

This release is an iterative update, including the following changes:

### New Features {#cl-1.11.0-new}

- Added dk collector, removing self collector (#1648)

### Bug Fixes {#cl-1.11.0-fix}

- Fixed Redis timeline redundancy issues, enhancing integration tests (#1743)
- Fixed dynamic library security issues in Oracle collector (#1730)
- Fixed DCA service startup failures (#1731)
- Fixed integration test issues in MySQL/ElasticSearch collectors (#1720)

### Functionality Improvements {#cl-1.11.0-opt}

- Optimized etcd collector (#1741)
- StatsD collector supports configuring different data sources (#1728)
- Tomcat collector supports versions 10 and above, deprecating Jolokia (#1703)
- Container log collection supports configuring internal files (#1723)
- SQLServer collector enhanced metrics and restructured integration tests (#1694)

### Compatibility Adjustments {#cl-1.11.0-brk}

- CI/CD data-related time fields in GitLab and Jenkins collectors were adjusted for unified frontend display (#1089)

### Documentation Adjustments {#cl-1.11.0-docs}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entry for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## 1.10.2 (2023/07/04) {#cl-1.10.2}

- Adjusted CPU collection values on Windows to align with Windows process monitor (#1002)
- Adjusted locking behavior during DataWay transmission, which might slow down data sending
- Log collection:
    - IO behavior changed to blocking by default
    - Default enabled multiline recognition
    - Adjusted tail end collection strategy for rotated files to avoid huge data packets (#1072)
    - Adjusted environmental variable documentation (#1071)
    - Added `log_read_time` field to record UNIX timestamp at collection time (#1077)

### Breaking Changes {#cl-1.10.2-brk}

- Removed global blocking (`blocking_mode`) and per-category blocking (`blocking_categories`) settings in IO module (both are disabled by default). **These options will no longer take effect if manually enabled in the new version**.

---

## 1.10.1 (2023/06/30) {#cl-1.10.1}

- Fixed [Log Stream collector](logstreaming) Pipeline configuration issues (#569)
- Fixed log disorder issues in [container collector](container) (#571)
- Fixed bugs in Pipeline module update logic (#572)

---

## 1.10.0 (2023/06/29) {#cl-1.10.0}

This release is an iterative update, mainly including the following updates:

### Bug Fixes {#cl-1.10.0-fix}

- Fixed DataKit not restarting after OOM on Windows (#691)
- Fixed Prom collector metric filtering issues (#1084)
- Fixed unit, documentation, and other issues in [MySQL collector](mysql.md) (#1122)
- Fixed [MongoDB collector](mongodb.md) issues (#1096/#1098)
- Fixed collection of invalid fields in Trace data (#1083)

### Functionality Improvements {#cl-1.10.0-opt}

- Enhanced Pipeline parallel processing capabilities
- Added [`set_tag()`](pipeline#6e8c5285) function (#444)
- Added [`drop()`](pipeline#fb024a10) function (#498)
- Git mode:
    - In DaemonSet mode, Git recognizes `ENV_DEFAULT_ENABLED_INPUTS` and applies it, while non-DaemonSet mode automatically enables collectors specified in *datakit.conf* (#501)
    - Adjusted folder storage strategy in Git mode (#509)

- New version numbering scheme (#484)
    - New version format is 1.2.3, where `1` is the major version number, `2` is the minor version number, and `3` is the patch version number
    - Minor version numbers with even numbers indicate stable releases, odd numbers indicate non-stable releases
    - Multiple patch versions may exist under the same minor version for bug fixes and functional adjustments
    - New features will be released in non-stable versions, and once stabilized, a new stable version (e.g., 1.4.0) will merge features from the non-stable version (e.g., 1.3.x)
    - Non-stable versions do not support direct upgrades, e.g., cannot upgrade directly to 1.3.x; only direct installations of non-stable versions are supported

### Breaking Changes {#cl-1.10.0-break-changes}

**Old versions of DataKit using `datakit --version` can no longer push new upgrade commands**, use the following commands instead:

- Linux/Mac:

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Windows:

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

---

## 1.9.2 (2023/06/20) {#cl-1.9.2}

This release is an intermediate iteration, adding some center对接 functionalities and several bug fixes and optimizations:

### New Features {#cl-1.9.2-new}

- Added [Chrony collector](../integrations/chrony.md) (#1671)
- Added RUM Headless support (#1644)
- Pipeline:
    - Added [offload feature](../pipeline/use-pipeline/pipeline-offload.md) (#1634)
    - Restructured existing documentation (#1686)

### Bug Fixes {#cl-1.9.2-fix}

- Fixed potential crash issues (!2249)
- Added Host header support in HTTP network dial testing and fixed random error reports (#1676)
- Fixed auto-discovery issues for Pod Monitor and Service Monitor in Kubernetes (#1695)
- Fixed Monitor issues (#1702/!2258)
- Fixed Pipeline data operation bugs (#1699)

### Functionality Improvements {#cl-1.9.2-opt}

- Added more information in DataKit HTTP API responses for easier debugging (#1697/#1701)
- Other refactoring (#1681/#1677)
- Increased Prometheus metrics exposure in RUM collector (#1545)
- Enabled pprof by default in DataKit for easier debugging (#1698)

### Breaking Changes {#cl-1.9.2-brk}

- Removed logging support from Kubernetes CRD `guance.com/datakits v1bate1` (#1705)

---

## 1.9.1 (2023/06/13) {#cl-1.9.1}

This release is a bug fix, mainly addressing the following issues:

- Fixed DQL query issues (#1688)
- Fixed potential crashes in HTTP interface due to high-frequency writes (#1678)
- Fixed parameter override issues in `datakit monitor` command (!2232)
- Fixed retry errors during HTTP data uploads (#1687)

---

## 1.9.0 (2023/06/08) {#cl-1.9.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.9.0-new}

- Added [NodeJS Profiling](../integrations/profile-nodejs.md) support (#1638)
- Added support for [Cat](../integrations/cat.md) (#1593)
- Added [collector configuration debugging methods](why-no-data.md#check-input-conf) (#1649)

### Bug Fixes {#cl-1.9.0-fix}

- Fixed connection leak issues in prom metrics collection in K8s environments (#1662)

### Functionality Improvements {#cl-1.9.0-opt}

- Added `age` field to K8s DaemonSet objects (#1670)
- Optimized [PostgreSQL](../integrations/postgresql.md) startup settings (#1658)
- Added [`/v3/log/`](../integrations/skywalking.md) support in SkyWalking (#1654)
- Optimized log collection handling (#1652/#1651)
- Optimized [upgrade documentation](datakit-update.md#prepare) (#1653)
- Added several integration tests (#1440/#1429)
    - PostgreSQL
    - Network dial testing

---

## 1.8.1 (2023/06/01) {#cl-1.8.1}
This release is a bug fix, mainly addressing the following issues:

- Fixed crashes in KafkaMQ when running multiple instances (#1660)
- Fixed incomplete disk device collection in DaemonSet mode (#1655)

---

## 1.8.0 (2023/05/25) {#cl-1.8.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.8.0-new}

- Prom collector's built-in timeout changed to 3 seconds (#958)

### Log-related Bug Fixes

- Added `log_read_offset` field to log collection (#905)
- Fixed issues with not reading residual content at the end of rotated log files (#936)

### Container Collection-related Bug Fixes

- Fixed compatibility issues with environment variable `NODE_NAME` (#957/#979/#980)
- Changed k8s auto-discovered prom collectors to serial distributed collection, each k8s node only collects its own prom metrics (#811/#957)
- Added source and multiline mapping configurations for logs (#937)
- Fixed bugs in replacing source after container logs and still using previous multiline and Pipeline configurations (#934/#923)
- Set active file duration for container logs to 12 hours (#930)
- Optimized image field in Docker container logs (#929)
- Optimized `host` field in k8s pod objects (#924)
- Fixed issues with container metrics and objects not adding host tags (#962)

### eBPF-related Updates

- Fixed Uprobe event name conflict issues
- Added more [environment variable configurations](ebpf.md#config) for easier deployment in Kubernetes

### APM Data Reception Interface Optimization

- Alleviated client hanging and memory consumption issues (#902)

### SQLServer Collector Fixes

- Restored TLS1.0 support (#909)
- Added instance-based filtering to reduce time series consumption (#931)

### Pipeline Function Adjustments

- Adjusted `adjust_timezone()` function (#917)

### IO Module Optimization

- Enhanced overall data processing capability, keeping memory consumption relatively controlled (#912)

### Monitor Updates

- Fixed long-term hanging issues in Monitor during busy periods (#933)
- Enhanced Monitor display, adding IO module information for easier adjustment of IO module parameters
- Fixed Redis crash issues (#935)
- Removed redundant verbose logs (#939)
- Fixed issues with host tags not being appended in non-election modes for election collectors (#968)

---

## 1.7.0 (2023/05/11) {#cl-1.7.0}
This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.7.0-new}

- RUM Sourcemap added support for Android and iOS (#886)
- Added new cluster-level election strategy for K8s environments (#1534)

### Bug Fixes {#cl-1.7.0-fix}

- Fixed increased fourth-layer connection counts when DataKit returned 5XX status codes (#983)
- Added more connection-related configuration parameters in [*datakit.conf*](datakit-conf.md#maincfg-example) for K8s environments (#915)

### Functionality Improvements {#cl-1.7.0-opt}

- Optimized process object collection, default disabling high-consumption fields (like open file count/port count) to avoid unexpected performance overhead on hosts (#1543)
- Enhanced DataKit self-metrics:
    - Added Prometheus metrics exposure for dial testing collector to help troubleshoot potential issues (#1591)
    - Exposed HTTP layer metrics in DataKit reporting (#1597)
    - Added KafkaMQ collection metrics exposure
- Enhanced [TDEngine collection](tdengine.md) (#877)
- Perfected Containerd log collection, supporting default format log auto-parsing (#869)
- Added [Profiling data](profile.md) support in Pipeline (#866)
- Container/Pod log collection supports appending extra tags via Label/Annotation (#861)
- Fixed time precision issues in [Jenkins CI](jenkins.md#jenkins_pipeline) data collection (#860)
- Unified `resource-type` values in Tracing (#856)
- Added [HTTPS support](ebpf.md#https) in eBPF (#782)
- Fixed potential crash issues in log collection (#893)
- Fixed leaks in prom collector (#880)
- Supported configuring IO disk cache via [environment variables](datakit-conf.md#using-cache) (#906)
- Added [Kubernetes CRD](kubernetes-crd.md) support (#726)
- Other bug fixes (#901/#899)

---

## 1.6.1 (2023/04/27) {#cl-1.6.1}

This release is a Hotfix, fixing the following issues:

- Fixed log collection interruption issues caused by rapid deletion and recreation of same-name files (#883)

If you have scheduled tasks that periodically archive logs, this bug might trigger the issue, **recommended upgrade**.

---

## 1.6.0 (2023/04/20) {#cl-1.6.0}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.6.0-new}

- Added [Pinpoint](../integrations/pinpoint.md) API support (#973)

### Functionality Improvements {#cl-1.6.0-opt}

- Optimized Windows installation scripts and upgrade script outputs for easier terminal copy-paste (#1557)
- Optimized DataKit documentation build process (#1578)
- Optimized OpenTelemetry field handling (#1514)
- [Prom](prom.md) collector now supports collecting `info` type labels and appending them to all associated metrics (enabled by default) (#1544)
- Added CPU and memory percentage metrics in [system collector](system.md) (#1565)
- DataKit adds data point count marking (`X-Points`) to facilitate related metric construction at the center (#1410)
    - Also optimized DataKit HTTP `User-Agent` marking to `datakit-<os>-<arch>/<version>` format
- [KafkaMQ](kafkamq.md):
    - Supports processing Jaeger data (#1526)
    - Optimized SkyWalking data processing flow (#1530)
    - Added third-party RUM integration (#1581)
- [SkyWalking](skywalking.md) added HTTP integration support (#1533)
- Added several integration tests (#1430/#1574/#1575)
- Optimized eBPF data sending flow to avoid excessive memory consumption leading to OOM (#871)
- Fixed collector documentation errors

---

## 1.5.10 (2023/04/13) {#cl-1.5.10}

This release is an emergency release, mainly including the following updates:

### New Features {#cl-1.5.10-new}

- Added automatic discovery and collection of [Prometheus metrics on Pods](kubernetes-prom.md#auto-discovery-metrics-with-prometheus) (#1564)
- Pipeline added aggregation functions:
    - [agg_create()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-agg-create)
    - [agg_metric()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-agg-metric) (#1554)

### Functionality Improvements {#cl-1.5.10-opt}

- Optimized Pipeline execution performance, achieving approximately 30% improvement
- Optimized historical position recording in log collection (#1550)

---

## 1.5.9 (2023/04/06) {#cl-1.5.9}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.5.9-new}

- Added [remote service management](datakit-update.md#remote) for DataKit upgrades (#1441)
- Added [troubleshooting features](why-no-data.md#bug-report) (#1377)

### Bug Fixes {#cl-1.5.9-fix}

- Fixed CPU metric synchronization between monitor and `top` command (#1547)
- Fixed panic errors in RUM collector (#1548)

### Functionality Improvements {#cl-1.5.9-opt}

- Optimized upgrade functionality to prevent corruption of *datakit.conf* (#1449)
- Optimized [cgroup configuration](datakit-conf.md#resource-limit), removing minimum CPU limit (#1538)
- Optimized [self collector](self.md), allowing selective enablement and optimizing collection performance (#1386)
- Simplified existing monitor display due to new troubleshooting methods (#1505)
- [Prom collector](prom.md) now supports adding `instance tag`, maintaining consistency with native Prometheus (#1517)
- [DCA](dca.md) added Kubernetes deployment support (#1522)
- Optimized disk cache performance in log collection (#1487)
- Enhanced DataKit's own metrics system, exposing more [Prometheus metrics](apis.md#api-metrics) (#1492)
- Optimized [/v1/write](apis.md#api-v1-write) (#1523)
- Enhanced token error prompts during installation (#1541)
- Monitor automatically retrieves connection addresses from *datakit.conf* (#1547)
- Removed mandatory kernel version checks in eBPF, aiming to support more kernel versions (#1542)
- [Kafka subscription collection](kafkamq.md) now supports multi-line JSON (#1549)
- Added a batch of integration tests (#1479/#1460/#1436/#1428/#1407)
- Optimized IO module configuration, adding upload worker count configuration fields (#1536)
    - [Kubernetes](datakit-daemonset-deploy.md#env-io)
    - [*datakit.conf*](datakit-conf.md#io-tuning)

### Compatibility Adjustments {#cl-1.5.9-brk}

- Removed most Sinker functionalities, retaining only the Sinker functionality on [Dataway](datakit-sink-dataway.md) (#1444). The corresponding host installation configurations ([datakit-install.md#env-sink](datakit-install.md#env-sink)) and [Kubernetes installation configurations](datakit-daemonset-deploy.md#env-sinker) have been adjusted. Users should note these changes when upgrading.
- The old [disk cache implementation](datakit-conf.md#io-disk-cache) has been replaced due to performance issues. The new binary format of cached data is incompatible with the old one. If upgrading, users should **manually delete old cache data** (which could affect the new version's disk cache) before proceeding. Despite this, the new disk cache remains an experimental feature and should be used cautiously.
- Updated DataKit's own metrics system; some metrics previously obtained by DCA may be missing but will not impact DCA's overall functionality.

---

## 1.5.8 (2023/03/24) {#cl-1.5.8}

This release is an iterative update, primarily addressing several bug fixes and functional improvements.

### Bug Fixes {#cl-1.5.8-fix}

- Log collection optimization:
    - Removed 32KB limit (retained 32MB maximum limit) (#776)
    - Fixed potential loss of initial logs
    - For newly created logs, default behavior is to start collecting from the beginning (mainly for container logs; disk file logs currently cannot determine if they are newly created)
    - Optimized Docker log processing, no longer relying on Docker's log API

- Fixed [decode](pipeline#837c4e09) function issues in Pipeline (#769)
- Supported gzip for OpenTelemetry gRPC (#774)
- Fixed [Filebeat](beats_output) inability to set service (#767)

### Breaking Changes {#cl-1.5.8-bc}

For Docker container log collection, the host (`Node`) */var/lib* path must be mounted into DataKit (as Docker logs default to */var/lib/* on the host). In *datakit.yaml*, add the following configuration under `volumeMounts` and `volumes`:

```yaml
volumeMounts:
- mountPath: /var/lib
  name: lib

# Omit other parts ...

volumes:
- hostPath:
    path: /var/lib
  name: lib
```

---

## 1.5.7 (2023/03/09) {#cl-1.5.7}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.5.7-new}

- Pipeline:
    - Added key deletion functionality to `json` function ([Pipeline Built-in Function Documentation](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json)) (#1465)
    - Added [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) function (#1414)
    - Added [time functions](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-datetime) (#1411)
- Added [IPv6 support](datakit-conf.md#config-http-server) (#1454)
- Disk I/O collection added [io wait extended metrics](diskio.md#extend) (#1472)
- Container collection supports coexistence of Docker and containerd (#1401)
- Consolidated [DataKit Operator configuration documentation](datakit-operator.md) (#1482)

### Bug Fixes {#cl-1.5.7-fix}

- Fixed several Pipeline bugs (#1476/#1469/#1471/#1466)
- Fixed cgroup ineffectiveness issue (#1470)
- Fixed a numerical construction issue in eBPF (#1509)
- Fixed DataKit monitor parameter recognition issue (#1506)

### Functionality Improvements {#cl-1.5.7-opt}

- Completed Jenkins memory-related metrics in [process collector](host_processes.md) (#1489)
- Improved [cgroup v2](datakit-conf.md#resource-limit) support (#1494)
- Added environment variable (`ENV_CLUSTER_K8S_NAME`) to configure cluster name during Kubernetes installation (#1504)
- Pipeline:
    - Added forced protection measures to [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) to prevent data inflation (#1510)
    - Optimized key deletion functionality in [`json()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) and [`delete()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-delete)
- Other minor optimizations (#1500)

### Documentation Adjustments {#cl-1.5.7-doc}

- Added Kubernetes full offline installation [documentation](datakit-offline-install.md#k8s-offline) (#1480)
- Enhanced StatsD and DDTrace-Java related documentation (#1481/#1507)
- Supplemented TDEngine related documentation (#1486)
- Removed outdated field descriptions in disk collector documentation (#1488)
- Enhanced Oracle collector documentation (#1519)

---

## 1.5.6 (2023/02/23) {#cl-1.5.6}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.5.6-new}

- Command-line added [line protocol parsing functionality](datakit-tools-how-to.md#parse-lp) (#1412)
- Datakit YAML and Helm support resource limit configuration (#1416)
- Datakit YAML and Helm support CRD deployment (#1415)
- Added SQLServer integration testing (#1406)
- RUM supports [resource CDN annotation](rum.md#cdn-resolve) (#1384)

### Bug Fixes {#cl-1.5.6-fix}

- Fixed API write interface time precision issues for JSON format data (#1412)
- Fixed log collection path errors (#1447)
- Fixed K8s Pod (`restarts`) field issues (#1446)
- Fixed partial configuration reload failures in various trace collectors (DDtrace/OpenTelemetry/Zipkin/SkyWalking/Jaeger) in Git mode (#725)
- Fixed GitLab collector crashing due to missing tags (#730)
- Fixed Kubernetes eBPF collector not updating Pod tags (#736)
- [Prom collector](prom.md) supports [tag renaming](prom#e42139cb) (#719)

### Functionality Improvements {#cl-1.5.6-opt}

- Optimized Helm installation (#695)
- Optimized [Helm installation](datakit-daemonset-deploy#e4d3facf) (#695)
- Logs added `unknown` status level; logs without specified status levels are considered `unknown` (#685)
- Extensive fixes in container collection:
    - Fixed cluster field naming issues (#542)
    - Renamed object `kubernetes_clusters` metric set to `kubernetes_cluster_roles`
    - Changed original `kubernetes.cluster` count to `kubernetes.cluster_role`
    - Fixed namespace field naming issues (#724)
    - DataKit follows [this priority](container#6de978c3) to infer log sources when Pod Annotation does not specify log `source` (#708/#723)
    - Object reporting no longer limited by 32KB string length (due to Annotations exceeding 32KB) (#709)
    - Removed all `annotation` fields from Kubernetes objects
    - Fixed prom collector not stopping upon Pod exit (#716)

### Other Bug Fixes {#cl-1.5.6-other-fixes}

- Fixed MongoDB infinite loop causing failure to collect (#721)

---

## 1.5.5 (2023/02/09) {#cl-1.5.5}

This release is an iterative update, containing numerous bug fixes:

- Pipeline module fixed Grok dynamic multiline pattern issues (#720)
- Removed unnecessary DataKit event log reporting (#704)
- Fixed potential upgrade failures in the upgrade program (#699)
- Added [pprof environment variable](datakit-daemonset-deploy#cc08ec8c) configuration for DaemonSet (#697)
- All [default enabled collectors](datakit-input-conf#764ffbc2) in DaemonSet can now be configured via environment variables (#693)
- Tracing collectors initially support Pipeline data processing (#675)
    - [DDtrace configuration example](ddtrace#69995abe)
- Dial testing collector added mechanism for exiting failed tasks (#54)
- Enhanced [Helm installation](datakit-daemonset-deploy#e4d3facf) (#695)
- Added `unknown` log level; logs without specified levels are considered `unknown` (#685)
- Extensive fixes in container collection:
    - Fixed cluster field naming issues (#542)
    - Renamed `kubernetes_clusters` metric set to `kubernetes_cluster_roles`
    - Changed original `kubernetes.cluster` count to `kubernetes.cluster_role`
    - Fixed namespace field naming issues (#724)
    - If Pod Annotation does not specify log `source`, DataKit infers log sources based on [this priority](container#6de978c3) (#708/#723)
    - Object reporting no longer constrained by 32KB string length (due to Annotations exceeding 32KB) (#709)
    - Removed all `annotation` fields from Kubernetes objects
    - Fixed prom collector not stopping upon Pod exit (#716)

### Other Bug Fixes {#cl-1.5.5-other-fixes}

- Fixed miscellaneous issues (#721)

---

## 1.5.4 (2023/02/12) {#cl-1.5.4}

This release is a hotfix, including small modifications and adjustments:

- Fixed log collection monitor display issues and adjusted some error log levels (#706)
- Fixed memory leak issues in dial testing collector (#702)
- Fixed crash issues in host process collector (#700)
- Enabled log collection option `ignore_dead_log = '10m'` by default (#698)
- Optimized Git-managed configuration synchronization logic (#696)
- Fixed IP protocol field errors in eBPF `netflow` (#694)
- Enriched GitLab collector fields

---

## 1.5.3 (2023/02/08) {#cl-1.5.3}

This release is an iterative update, with the following changes:

- Added runtime [memory limits](datakit-conf#4e7ff8f3) for host installations (#641)
    - Installation phase supports [memory limit configuration](datakit-install#03be369a)
- CPU collector added [load5s metric](cpu#13e60209) (#606)
- Enhanced *datakit.yaml* examples (#678)
- Host installations support [cgroup memory limits](datakit-conf#4e7ff8f3) (#641)
- Enhanced log blacklist functionality, adding `contain/notcontain` rules (#665)
    - Support configuring blacklists for logs/objects/traces/time series metrics in *datakit.conf*
    - Note: Upgrading this version requires DataWay to be upgraded to 1.2.1+
- Further enhanced [containerd-based container collection](container) (#402)
- Adjusted monitor layout, adding blacklist filtering display (#634)
- Added [Helm support](datakit-daemonset-deploy) for DaemonSet installation (#653)
    - New [best practices for DaemonSet installation](datakit-daemonset-bp) (#673)
- Enhanced [GitLab collector](gitlab) (#661)
- Added [ulimit configuration](datakit-conf#8f9f4364) for file descriptor limits (#667)
- Added [SQL obfuscation functions](pipeline#711d6fe4) to Pipeline [desensitization functions](pipeline#52a4c41c) (#670)
- Added `cpu_usage_top` field to process objects and time series metrics to match `top` command results (#621)
- eBPF added [HTTP protocol collection](ebpf#905896c5) (#563)
- Host installations no longer install eBPF collector by default (reducing binary distribution size); if needed, use specific installation commands (#605)
    - DaemonSet installations remain unaffected
- Other bug fixes (#688/#681/#679/#680)

---

## 1.5.2 (2023/02/23) {#cl-1.5.2}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.5.2-new}

1. Added [DataKit command-line completion](datakit-tools-how-to#9e4e5d5f) functionality (#76)
2. Allowed DataKit to [upgrade to non-stable versions](datakit-update#42d8b0e4) (#639)
3. Adjusted local storage of Remote Pipeline in DataKit to avoid case sensitivity issues caused by different filesystems (#649)
4. (Alpha) Initial support for [Kubernetes/Containerd architecture data collection](container#b3edf30c) (#402)
5. Fixed unreasonable error reporting in Redis collector (#671)
6. Minor adjustments in OpenTelemetry collector fields (#672)
7. Fixed CPU calculation errors in [DataKit self-collector](self) (#664)
8. Resolved IPDB absence leading to missing IP association fields in RUM collector (#652)
9. Pipeline supports uploading debugging data to OSS (#650)
10. DataKit HTTP APIs include DataKit version information (#650)
11. [Network dial testing](dialtesting) added TCP/UDP/ICMP/Websocket protocol support (#519)
12. Fixed excessively long field issues in [host object collector](hostobject) (#669)
13. Pipeline:
    - Added [decode()](pipeline#837c4e09) function (#559), avoiding configuring encoding in log collectors and enabling encoding conversion within Pipeline
    - Fixed possible failures in importing pattern files in Pipeline (#666)
    - Added scope management to [add_pattern()](pipeline#89bd3d4e)

---

## 1.5.1 (2023/02/17) {#cl-1.5.1}

This release is a hotfix, containing part of small modifications and adjustments:

- Fixed tracing collector resource filtering (close_resource) algorithm, moving it down to Entry Span level instead of Root Span
- Fixed [log collector](logging) file handle leakage (#658), added configuration (`ignore_dead_log`) to ignore no longer updated (deleted) files
- Added [DataKit self-metric documentation](self)
- DaemonSet installations:
    - [Support installing IPDB](datakit-tools-how-to#11f01544) (#659)
    - Added setting for HTTP rate limiting (`ENV_REQUEST_RATE_LIMIT`) (#654)

---

## 1.5.0 (2023/02/10) {#cl-1.5.0}

This release is an iterative update, mainly including the following updates:

- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- Unified sampling rate settings for various Tracing data (#631)
- Released [DataKit log collection overview](datakit-logging)
- Supported [OpenTelemetry data ingestion](opentelemetry) (#609)
- Supported disabling logs for certain images inside Pods (#586)
- Process object collection added listening port list (#562)
- eBPF collector supported [Kubernetes field associations](ebpf#35c97cc9) (#511)

### Breaking Changes {#cl-1.5.0-brk}

- Significant adjustments were made to Tracing data collection, involving several areas of incompatibility:

    - [DDtrace](ddtrace): Existing config's `ignore_resources` field needs to be changed to `close_resource`, and the field type changes from array (`[...]`) to dictionary array (`map[string][...]`)
    - Original `type` tag in DDTrace data is renamed to `source_type`

---

## 1.4.20 (2023/03/24) {#cl-1.4.20}

This release is an iterative update, mainly including the following updates:

1. Added [DataKit command-line completion](datakit-tools-how-to#9e4e5d5f) functionality (#76)
2. Allowed DataKit to [upgrade to non-stable versions](datakit-update#42d8b0e4) (#639)
3. Adjusted local storage of Remote Pipeline in DataKit to avoid case sensitivity issues caused by different filesystems (#649)
4. (Alpha) Initial support for [Kubernetes/Containerd architecture data collection](container#b3edf30c) (#402)
5. Fixed unreasonable error reporting in Redis collector (#671)
6. Minor adjustments in OpenTelemetry collector fields (#672)
7. Fixed CPU calculation errors in [DataKit self-collector](self) (#664)
8. Fixed missing IP association fields in RUM collector due to IPDB absence (#652)
9. Pipeline supports uploading debugging data to OSS (#650)
10. DataKit HTTP APIs now include DataKit version information
11. [Network dial testing](dialtesting) added TCP/UDP/ICMP/Websocket protocol support (#519)
12. Fixed excessively long field issues in [host object collector](hostobject) (#669)
13. Pipeline:
    - Added [decode()](pipeline#837c4e09) function (#559), avoiding configuring encoding in log collectors and enabling encoding conversion within Pipeline
    - Fixed possible failures in importing pattern files in Pipeline (#666)
    - Added scope management to [add_pattern()](pipeline#89bd3d4e)

---

## 1.4.19 (2023/03/17) {#cl-1.4.19}

This release is an iterative update, mainly including the following updates:

- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- Unified sampling rate settings for various Tracing data (#631)
- Published [DataKit log collection overview](datakit-logging)
- Supported [OpenTelemetry data ingestion](opentelemetry) (#609)
- Supported disabling logs for certain images inside Pods (#586)
- Process object collection added listening port list (#562)
- eBPF collector supported [Kubernetes field associations](ebpf#35c97cc9) (#511)

### Breaking Changes {#cl-1.4.19-brk}

- Significant adjustments were made to Tracing data collection, involving several areas of incompatibility:

    - [DDtrace](ddtrace): Existing config's `ignore_resources` field needs to be changed to `close_resource`, and the field type changes from array (`[...]`) to dictionary array (`map[string][...]`)
    - Original `type` tag in DDTrace data is renamed to `source_type`

---

## 1.4.18 (2023/03/04) {#cl-1.4.18}

This release is a hotfix, mainly fixing the following issues:

- DaemonSet mode deployment: Added [toleration configuration](datakit-daemonset-deploy#e29e678e) in *datakit.yaml* (#635)
- Fixed bugs in Remote Pipeline updates (#630)
- Fixed memory leaks caused by DataKit IO module hanging (#646)
- Allowed modifying `service` field in Pipeline (#645)
- Fixed `pod_namespace` spelling errors
- Fixed several issues in logfwd (#640)
- Fixed multiline stickiness issues in log collection within containers (#633)

---

## 1.4.17 (2023/02/22) {#cl-1.4.17}

This release is an iterative update, mainly including the following updates:

- Pipeline:
    - Grok added [dynamic multiline pattern](datakit-pl-how-to#88b72768) for better handling of dynamic multiline splitting (#615)
    - Supported remote Pipeline configuration from center (#524), thus Pipeline now has [three storage paths](pipeline#6ee232b2)
    - DataKit HTTP API added Pipeline debug interface [`/v1/pipeline/debug`](apis#539fb60e)

- Reduced default installation package size by excluding IP geolocation database. Collectors like RUM can optionally [install the corresponding IP library](datakit-tools-how-to#ab5cd5ad)
    - To install with IP geolocation database, use [additional command-line environment variables](datakit-install#f9858758)
- Added [logfwd log ingestion](logfwd) (#600)
- Row protocol added stricter [restrictions](apis#2fc2526a) to further standardize data uploads (#592)
- [Log collector](logging) removed log length restriction (`maximum_length`) (#623)
- Optimized Monitor display during log collection (#587)
- Optimized command-line argument checking during installation (#573)
- Restructured DataKit command-line parameters; most major commands are now supported. Additionally, **old command-line parameters will still work for a period of time** (#499)
    - Use `datakit help` to view new command-line parameter styles
- Reimplemented [DataKit Monitor](datakit-monitor)

### Other Bug Fixes {#cl-1.4.17-fix}

- Fixed Windows installation script issues (#617)
- Adjusted ConfigMap settings in *datakit.yaml* (#603)
- Fixed HTTP service anomalies caused by Reload in Git mode (#596)
- Fixed missing ISP files in installation packages (#584/#585/#560)
- Fixed ineffective multiline matching in Pod annotations (#620)
- Fixed `_service` tag ineffectiveness in TCP/UDP log collectors (#610)
- Fixed data retrieval issues in Oracle collector (#625)

### Breaking Changes {#cl-1.4.17-brk}

- For older DataKit versions with RUM enabled, after upgrading, you need to [reinstall the IP library](datakit-tools-how-to#ab5cd5ad) as the old IP library will no longer be usable.

---

## 1.4.16 (2023/01/20) {#cl-1.4.16}

This release is an iterative update, mainly including the following updates:

- Enhanced [DataKit API security access control](rum#b896ec48), especially for RUM functionality. It is recommended to upgrade if using RUM (#578)
- Increased internal event log reporting in DataKit (#527)
- Viewing [DataKit running status](datakit-tools-how-to#44462aae) no longer times out (#555)

- Several detail fixes in [container collector](container):

    - Fixed crashes in Kubernetes host deployments (#576)
    - Elevated Annotation configuration priority (#553)
    - Container logs support multiline processing (#552)
    - Added _role_ field to Kubernetes Node objects (#549)
    - Automatically added relevant attributes (pod_name/node_name/namespace) to [Prom collectors annotated via Annotation](kubernetes-prom) (#522/#443)
    - Other bug fixes

- Pipeline fixes:

    - Fixed potential time disorder issues in log processing (#547)
    - Supported complex logic relationships in `if/else` statements for Grok splitting (#538)

- Fixed Windows path issues in log collector (#423)
- Enhanced DataKit service management, optimizing interaction prompts (#535)
- Optimized existing DataKit metric units in documentation (#531)
- Improved engineering quality (#515/#528)

---

## 1.4.15 (2023/01/19) {#cl-1.4.15}

- Fixed [Log Stream collector](logstreaming) Pipeline configuration issues (#569)
- Fixed log misalignment issues in [container collector](container) (#571)
- Fixed bugs in Pipeline module update logic (#572)

---

## 1.4.14 (2023/01/12) {#cl-1.4.14}

- Fixed lost metrics in log API interface (#551)
- Fixed partial network traffic statistics losses in [eBPF](ebpf) (#556)
- Fixed wildcard `$` character issues in collector configuration files (#550)
- Pipeline `if` statement supports null value comparisons, aiding Grok slicing judgments (#538)

---

## 1.4.13 (2023/01/10) {#cl-1.4.13}

- Fixed *datakit.yaml* formatting issues (#544)
- Fixed election issues in [MySQL collector](mysql) (#543)
- Fixed log non-collection issues due to unconfigured Pipeline (#546)

---

## 1.4.12 (2023/01/07) {#cl-1.4.12}

- [Container collector](container) updates:
    - Fixed efficiency issues in log processing (#540)
    - Optimized configuration file blacklist/whitelist settings (#536)
- Pipeline module added `datakit -M` metrics exposure (#541)
- [ClickHouse](clickhousev1) collector config-sample issue fixed (#539)
- [Kafka](kafka) metric collection optimized (#534)

---

## 1.4.11 (2023/01/05) {#cl-1.4.11}

- Fixed Pipeline usage issues in collectors (#529)
- Enhanced data issues in [container collector](container) (#532/#530)
    - Fixed short-image collection issues
    - Improved Deployment/ReplicaSet associations in k8s environments

---

## 1.4.10 (2023/01/03) {#cl-1.4.10}

- Refactored Kubernetes cloud-native collectors, integrating them into the [container collector](container.md). The original Kubernetes collector is no longer effective (#492)
- [Redis collector](redis.md):
    - Supports configuring [Redis username](redis.md) (#260)
    - Added Latency and Cluster metrics sets (#396)
- [Kafka collector](kafka.md) enhancements, supporting topic/broker/consumer/connection dimensions (#397)
- Added [ClickHouse](clickhousev1.md) and [Flink](flinkv1.md) collectors (#458/#459)
- [Host object collector](hostobject):
    - Supports reading cloud sync configurations from [`ENV_CLOUD_PROVIDER`](hostobject#224e2ccd) (#501)
    - Optimized disk collection, default no longer collects invalid disks (like those with total size 0) (#505)
- [Log collector](logging) supports receiving TCP/UDP log streams (#503)
- [Prom collector](prom) supports multiple URL collections (#506)
- Added [eBPF collector](ebpf), integrating L4-network/DNS/Bash eBPF data collection (#507)
- [ElasticSearch collector](elasticsearch) added support for Open Distro branch of ElasticSearch (#510)

### Bug Fixes {#cl-1.4.10-fix}

- Fixed [Statsd](statsd)/[RabbitMQ](rabbitmq) metrics issues (#497)
- Fixed data issues in [Windows Event](windows_event) collection (#521)
- [Pipeline](pipeline):
    - Enhanced parallel processing capabilities
    - Added [`set_tag()`](pipeline#6e8c5285) function (#444)
    - Added [`drop()`](pipeline#fb024a10) function (#498)
- Git mode:
    - In DaemonSet mode, Git recognizes `ENV_DEFAULT_ENABLED_INPUTS` and applies it, while non-DaemonSet mode automatically enables collectors specified in *datakit.conf* (#501)
    - Adjusted folder storage strategy in Git mode (#509)

### Breaking Changes {#cl-1.4.10-break-changes}

**Old versions of DataKit using `datakit --version` can no longer fetch new upgrade commands**, use the following commands instead:

- Linux/Mac:

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Windows:

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

---

## 1.4.9 (2023/01/16) {#cl-1.4.9}

- Fixed MySQL collector partial collection failure issues leading to data problems.

---

## 1.4.8 (2023/01/10) {#cl-1.4.8}

This release is an iterative update, mainly including the following updates:

### New Features {#cl-1.4.8-new}

- Added automatic cloud synchronization, no longer requiring manual cloud provider specification (#1074)
- Supported syncing Kubernetes labels to Pod metrics and logs (#1101)
- Supported syncing various YAML information to corresponding [object data](container.md#objects) in Kubernetes (#1102)
- Trace collection supports automatic extraction of critical meta information (#1092)
- Installation process supports specifying installation source address to simplify [offline installation](datakit-offline-install.md) (#1065)
- [Pipeline](../pipeline/use-pipeline/index.md) added:
    - `if/elif/else` syntax (#339)
    - Temporarily removed `expr()/json_all()` functions
    - Optimized timezone handling, added `adjust_timezone()` function
    - Enhanced overall testing for each Pipeline function

- DataKit DaemonSet:
    - Git configuration DaemonSet [ENV injection](datakit-daemonset-deploy#00c8a780) (#470)
    - Default enabled collectors removed container collector to avoid duplicate collection (#473)

- Others:
    - DataKit supports event reporting (in log form) (#463)
    - [ElasticSearch](elasticsearch) collector metrics set added `indices_lifecycle_error_count` metric (requires adding `ilm` role in ES for this metric) (#510)
- DataKit installation automatically adds [cgroup limits](datakit-conf#4e7ff8f3) (#463)
- Some interfaces interacting with the center were upgraded to v2 versions, so for DataKit instances connecting to non-SaaS nodes, if upgraded to this version, the corresponding DataWay and Kodo also need to be upgraded to avoid 404 errors.

### Breaking Changes {#cl-1.4.9-brk}

Handling JSON data where the top-level is an array now requires indexed selection. For example, given the JSON:

```
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## 1.4.7 (2023/02/22) {#cl-1.4.7}

This release is an iterative update, mainly including the following updates:

- Pipeline:
    - Grok added [dynamic multiline pattern](datakit-pl-how-to#88b72768) for easier dynamic multiline splitting (#615)
    - Supported central issuance of Pipeline configurations (#524), making Pipeline configurations have [three storage paths](pipeline#6ee232b2)
    - DataKit HTTP API added Pipeline debugging interface `/v1/pipeline/debug` for direct browser access (#541)

- Removed redundant middlewares that caused conflicts, such as:
    - `dockerlog`: integrated into docker collector
    - `docker_containers`: integrated into docker collector
    - `mysqlMonitor`: integrated into mysql collector

### Bug Fixes {#cl-1.4.7-fix}

- Fixed empty username causing blank display in process collector, using `nobody` as the username for processes where username retrieval fails (#576)
- Fixed potential panics in Kubernetes collector memory utilization calculations (#571)

### Functionality Improvements {#cl-1.4.7-opt}

- Process collector added more information to `message` field for better full-text search (#576)
- Host object collector supports custom tags for cloud attribute synchronization (#501)

---

## 1.4.6 (2023/01/30) {#cl-1.4.6}

### Bug Fixes {#cl-1.4.6-fix}

- Fixed issues with `ENV_HTTP_LISTEN` being ineffective, which caused abnormal HTTP service startup in container deployments (including K8s DaemonSet deployments).

---

## 1.4.5 (2023/01/26) {#cl-1.4.5}

### New Features {#cl-1.4.5-new}

- Enhanced [Redis/Nginx collectors](nginx.md) with built-in support for ActiveMQ/Kafka/RabbitMQ/gin/Zap log parsing
- Improved MySQL slow query log analysis

### Functionality Improvements {#cl-1.4.5-opt}

- Set a minimum frequency limit (30 seconds) for process collector due to high single collection duration
- Collector configuration file names no longer strictly require the `.conf` extension; any file named `xxx.conf` is valid
- Updated version prompt logic: if the git commit hash does not match the online version, it will also prompt for an update
- Container object collector ([docker_containers](container.md)) added memory/CPU percentage fields (`mem_usage_percent/cpu_usage`)
- Kubernetes metrics collector (`kubernetes`) added CPU percentage field (`cpu_usage`)
- Tracing data collection improved handling of service type
- Some collectors now support custom log or metric output (default is metrics)

### Bug Fixes {#cl-1.4.5-fix}

- Fixed issues with default username retrieval on Mac for process collector (#576)
- Corrected issues with retrieving exited containers in container object collector (#571)
- Other minor bug fixes

### Breaking Changes {#cl-1.4.5-brk}

- For certain collectors, if original metrics contain `uint64` type fields, the new version may cause field incompatibility. Such fields should be removed to avoid conflicts.

    - Previously, `uint64` types were automatically converted to strings, which could lead to confusion during usage.
    - Metrics exceeding max-int64 will be discarded by the collector because InfluxDB 1.7 does not support `uint64` metrics.

- Removed some original `dkctrl` command functionalities; configuration management will no longer depend on this method.

---

## 1.4.4.3 (2023/01/19) {#cl-1.4.4.3}

- Fixed issues with container log collection failing due to misconfigured Pipeline settings

---

## 1.4.4.2 (2023/01/18) {#cl-1.4.4.2}

- Emergency fix:
    - Fixed level anomalies in stdout logs in Kubernetes environments
    - Fixed infinite loop issues in MySQL collector under non-election modes
    - Completed DaemonSet documentation

---

## 1.4.4.1 (2023/01/16) {#cl-1.4.4.1}

- Fixed namespace issues in Kubernetes Pod collection (#439)

---

## 1.4.4 (2023/01/09) {#cl-1.4.4}

- Supported managing various collector configurations (`datakit.conf` excluded) and Pipeline via Git (#366)
- Supported fully offline installations (#421)
- <!-- eBPF-network
    - Added [DNS data collection]()(#418)
    - Enhanced kernel compatibility, reducing requirements to Linux 4.4+ (#416) -->
- Enhanced data debugging functionality, allowing collected data to be written to local files while being sent to the center (#415)
- Default enabled collectors in K8s environments can inject tags via environment variables; see individual default enabled collector documentation (#408)
- DataKit supports one-click log uploads (#405)
- <!-- MySQL collector added [SQL execution performance metrics]()(#382) -->
- Fixed root user setting bugs in installation scripts (#430)
- Enhanced Kubernetes collector:
    - Added [Pod log collection via Annotation](kubernetes-podlogging) (#380)
    - Added more Annotation keys supporting multiple IPs (#419)
    - Supported collecting Node IP (#411)
    - Optimized Annotation usage in collector configurations (#380)
- Cloud synchronization added support for Huawei Cloud and Microsoft Azure (#265)

---

## 1.4.3 (2023/10/26) {#cl-1.4.3}

- Optimized [Redis collector](redis) DB configuration method (#395)
- Fixed empty tag value issues in [Kubernetes collector](kubernetes) (#409)
- Fixed installation failures on Mac M1 due to security policies (#379)
- [Prometheus collector](prom) debug tool supports testing data splitting from local files (#378)
- Fixed data issues in [etcd collector](etcd) (#377)
- DataKit Docker image added arm64 architecture support (#365)
- Installation phase added support for environment variable `DK_HOSTNAME` (#334)
- [Apache collector](apache) added more metric collections (#329)
- DataKit API added [`/v1/workspace`](apis#2a24dd46) interface to retrieve workspace information (#324)
    - Supports DataKit retrieving workspace information via command-line parameters

---

## 1.4.2 (2023/10/14) {#cl-1.4.2}

- Added [collector](prom_remote_write) support for Prometheus Remote Write to synchronize data to DataKit (#381)
- Added [Kubernetes Event data collection](kubernetes#49edf2c4) (#296)
- Fixed Mac installation failure due to security policies (#379)
- [Prometheus collector](prom) debug tool supports testing data splitting from local files (#378)
- Fixed data issues in [etcd collector](etcd) (#377)
- DataKit Docker image added arm64 architecture support (#365)
- Added environment variable `DK_HOSTNAME` support during installation (#334)
- [Apache collector](apache) added more metric collections (#329)
- DataKit API added [`/v1/workspace`](apis#2a24dd46) interface to retrieve workspace information (#324)
    - Supports DataKit retrieving workspace information via command-line parameters

---

## 1.4.1.1 (2023/10/09) {#cl-1.4.1.1}

- Fixed Kubernetes election issues (#389)
- Fixed MongoDB configuration compatibility issues

---

## 1.4.1 (2023/09/28) {#cl-1.4.1}

- Improved Kubernetes ecosystem [Prometheus metric collection](kubernetes-prom) (#368/#347)
- [eBPF-network](net_ebpf) optimizations
- Fixed connection leaks between DataKit and DataWay (#290)
- Fixed inability to execute subcommands in container mode (#375)
- Fixed log loss in log collectors due to Pipeline errors (#376)
- Enhanced [DCA](dca) related functions on the DataKit side, supporting enabling DCA during installation (#374)
- Discontinued browser-based dial testing functionality

---

## 1.4.0 (2023/09/23) {#cl-1.4.0}

- [Log collector](logging) added special character (such as color characters) filtering function (default disabled) (#351)
- [Container log collection](container#6a1b31bb) synchronized more existing common log collection features (multiline matching/log level filtering/character encoding, etc.) (#340)
- Adjusted fields in [host object](hostobject) collector (#348)
- Added several new collectors:
    - [eBPF-network](net_ebpf) (alpha) (#148)
    - [Consul](consul) (#303)
    - [etcd](etcd) (#304)
    - [CoreDNS](coredns) (#305)
- Election functionality extended to the following collectors (#288):
    - [Kubernetes](kubernetes)
    - [Prometheus](prom)
    - [GitLab](gitlab)
    - [NSQ](nsq)
    - [Apache](apache)
    - [InfluxDB](influxdb)
    - [ElasticSearch](elasticsearch)
    - [MongoDB](mongodb)
    - [MySQL](mysql)
    - [Nginx](nginx)
    - [PostgreSQL](postgresql)
    - [RabbitMQ](rabbitmq)
    - [Redis](redis)
    - [Solr](solr)

---

## 1.3.8 (2023/09/10) {#cl-1.3.8}

- [DDTrace](ddtrace) added [resource filtering](ddtrace#224e2ccd) functionality (#328)
- Added [NSQ](nsq) collector (#312)
- K8s DaemonSet deployment allows changing default configurations via environment variables, e.g., CPU configuration (#309)
- Preliminary support for [SkyWalkingV3](skywalking) (alpha) (#335)
- [RUM](rum) collector removed full-text fields to reduce network overhead (#349)
- [Log collector](logging) added handling for file truncation (#271)
- Compatible error handling for incorrectly parsed log fields (#342)
- Fixed TLS errors that might occur during [offline downloads](datakit-offline-install) (#330)
- Log collector triggers a notification log upon successful configuration, indicating that log collection has started for the corresponding file (#323)

---

## 1.3.7 (2023/08/26) {#cl-1.3.7}

This release is a hotfix, mainly addressing the following issues:

- Fixed missing global host tags in log collection (#658)
- Optimized multiline processing in container logs (#666)
- Fixed potential crashes caused by certain regular expressions (#671)
- Reduced the size of the installation package (#679)
- Fixed potential failures in enabling disk cache for log collection (#683)

### Breaking Changes {#cl-1.3.7-brk}

- The option to obtain hostname from the environment variable `ENV_HOSTNAME` has been removed (supported in 1.1.7-rc8), use the [hostname override feature](datakit-install#987d5f91) instead.
- Removed command option `--reload`
- Removed DataKit API `/reload`, replaced by `/restart`
- Due to changes in command-line options, previous monitor viewing commands now require sudo privileges to read *datakit.conf* and fetch DataKit configurations.

---

## 1.3.6 (2023/08/24) {#cl-1.3.6}

### New Features {#cl-1.3.6-new}

- Added support for syncing Kubernetes labels to various objects (pod/service/...) (#279)
- `datakit` metrics set added data discard metrics (#286)
- Optimized [Kubernetes cluster custom metric collection](kubernetes-prom) (#283)
- [ElasticSearch](elasticsearch) collector improvements (#275)
- Added [host directory](hostdir) collector (#264)
- [CPU](cpu) collector supports per-CPU metrics collection (#317)
- [DDTrace](ddtrace) supports multi-route configuration (#310)
- [DDTrace](ddtrace#fb3a6e17) supports custom business tag extraction (#316)
- [Host object](hostobject) only reports errors within the last 30 seconds (#318)
- Released [DCA client](dca)
- Disabled some command-line help on Windows (#319)
- Adjusted [DataKit installation methods](datakit-install), [offline installation](datakit-offline-install) was modified (#300)
    - Still compatible with old installation methods after adjustment

### Breaking Changes {#cl-1.3.6-brk}

- Removed the feature to obtain hostname from environment variable `ENV_HOSTNAME` (supported in 1.1.7-rc8), use [hostname override feature](datakit-install#987d5f91) instead.
- Removed command option `--reload`
- Removed DataKit API `/reload`, replaced by `/restart`
- Due to changes in command-line options, previous monitor viewing commands now require sudo privileges to read *datakit.conf* and fetch DataKit configurations.

---

## 1.3.5 (2023/08/17) {#cl-1.3.5}

- Added [Pythond (alpha)](pythond) to facilitate writing custom collectors in Python3 (#367)
<!-- - Added source map file handling to facilitate JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

---

## 1.3.4.3 (2023/08/16) {#cl-1.3.4.3}

- Fixed container log collector startup failures due to misconfigured Pipeline

---

## 1.3.4.2 (2023/08/16) {#cl-1.3.4.2}

- Emergency fix:
    - Fixed incorrect log levels in stdout logs in Kubernetes mode
    - Fixed infinite loops in MySQL collectors when not elected
    - Completed DaemonSet documentation

---

## 1.3.4.1 (2023/08/15) {#cl-1.3.4.1}

- Fixed CPU temperature collection leading to no data on Windows (#430)

---

## 1.3.4 (2023/08/14) {#cl-1.3.4}

### New Features {#cl-1.3.4-new}

- Added support for [managing collector configurations via Git](datakit-conf#90362fd0) (excluding `datakit.conf` and Pipeline) (#366)
- Added [fully offline installation](datakit-offline-install#7f3c40b6) (#421)
<!-- - eBPF-network
    - Added [DNS data collection]()(#418)
    - Enhanced kernel compatibility, reducing requirements to Linux 4.4+ (#416) -->
- Enhanced data debugging functionality, allowing collected data to be written to local files and simultaneously sent to the center (#415)
- K8s environment default enabled collectors support injecting tags via environment variables, see individual default enabled collector documentation (#408)
- DataKit supports [one-click log uploads](datakit-tools-how-to#0b4d9e46) (#405)
- Adjusted DataKit main configuration, modularizing different configuration sections (see below Breaking Changes)
- Other bug fixes, and enhancements to existing documentation

### Breaking Changes {#cl-1.3.4-brk}

The following changes will be **automatically adjusted** during upgrade, mentioned here for clarity:

- Main configuration modifications: Added the following modules

```toml
[io]
  feed_chan_size                 = 1024  # IO channel buffer size
  hight_frequency_feed_chan_size = 2048  # High-frequency IO channel buffer size
  max_cache_count                = 1024  # Local cache maximum, original main config io_cache_count [this value and max_dynamic_cache_count both less than or equal to zero will infinitely use memory]
  cache_dump_threshold         = 512   # Local cache cleanup threshold post-push [this value less than or equal to zero will not clean up cache, network interruption can lead to excessive memory usage]
  max_dynamic_cache_count      = 1024  # HTTP cache maximum, [this value and max_cache_count both less than or equal to zero will infinitely use memory]
  dynamic_cache_dump_threshold = 512   # HTTP cache cleanup threshold post-push, [this value less than or equal to zero will not clean up cache, network interruption can lead to excessive memory usage]
  flush_interval               = "10s" # Push interval
  output_file                  = ""    # Output IO data to local file, original main config output_file

[http_api]
    listen          = "localhost:9529" # Original http_listen
    disable_404page = false            # Original disable_404page

[logging]
    log           = "/var/log/datakit/log"     # Original log
    gin_log       = "/var/log/datakit/gin.log" # Original gin.log
    level         = "info"                     # Original log_level
    rotate        = 32                         # Original log_rotate
    disable_color = false                      # New configuration
```

---

## 1.3.3 (2023/07/17) {#cl-1.3.3}

- Fixed issues with file handles leaking causing DataKit restart failures on Windows (#389)
- Fixed MongoDB configuration compatibility issues

---

## 1.3.2 (2023/07/15) {#cl-1.3.2}

- Enhanced [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Installed on Mac M1 chip successfully (#407)
- [eBPF-network](net_ebpf) fixed connection count statistics errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

---

## 1.3.1 (2023/07/10) {#cl-1.3.1}

- Fixed Kubernetes election issues (#389)
- Fixed MongoDB configuration compatibility issues

---

## 1.3.0 (2023/07/06) {#cl-1.3.0}

### New Features {#cl-1.3.0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-refer-table/) (#1634)
- DataKit 9529 HTTP [supports binding to domain socket](datakit-conf.md#uds) (#925)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Functionality Improvements {#cl-1.3.0-opt}

- Optimized [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Installed successfully on Mac M1 chip (#407)
- [eBPF-network](net_ebpf) fixed connection count statistics errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

### Bug Fixes {#cl-1.3.0-fix}

- Fixed connection leaks between DataKit and DataWay (#290)
- Fixed subprocess commands not executing in container deployments (#375)
- Fixed log collection losing original data due to Pipeline errors (#376)
- Fixed cloud sync issues leading to upload problems (#384)

---

## 1.2.20 (2023/05/22) {#cl-1.2.20}

This release is a hotfix, mainly addressing the following issues:

- Optimized log collection performance (#775)
    - Removed 32KB limit (retained 32MB maximum limit) (#776)
    - Fixed possible loss of initial logs
    - For newly created logs, default behavior is to start collection from the beginning (mainly for container logs; disk file logs currently cannot determine if they are newly created)
    - Optimized Docker log processing, no longer relying on Docker's log API

- Fixed issues with the [decode](pipeline#837c4e09) function in Pipeline (#769)
- OpenTelemetry gRPC supports gzip (#774)
- Fixed [Filebeat](beats_output) issue where it could not set service (#767)

### Breaking Changes {#cl-1.2.20-brk}

For Docker container log collection, the */var/lib* path on the host machine must be mounted into DataKit (as Docker logs default to */var/lib/* on the host). In *datakit.yaml*, add the following configuration under `volumeMounts` and `volumes`:

```yaml
volumeMounts:
- mountPath: /var/lib
  name: lib

# Omit other parts ...

volumes:
- hostPath:
    path: /var/lib
  name: lib
```

---

## 1.2.19 (2023/05/12) {#cl-1.2.19}

This release is an iterative update, mainly including the following updates:

- Added ARM64 support in eBPF (#662)
- Row protocol construction supports automatic correction (#777)
- Strengthened [row protocol data validation](apis#2fc2526a)
- `system` collector added [`conntrack` and `filefd`](system) metrics sets (#348)
- `datakit.conf` added IO tuning entries to optimize DataKit's network outbound traffic and maintain relatively controlled memory consumption (#773)
- DataKit supports [service uninstallation and recovery](datakit-service-how-to#9e00a535)
- Windows platform services can be managed via [command line](datakit-service-how-to#147762ed)
- DataKit supports dynamically obtaining the latest DataWay address to avoid default DataWay being affected by DDoS attacks
- DataKit logs can be output to terminal (not supported on Windows), facilitating log viewing and collection in k8s deployments (#758)
- Adjusted DataKit main configuration, modularizing different configuration sections (see below Breaking Changes)
- Other bug fixes and enhancements to existing documentation

### Breaking Changes {#cl-1.2.19-brk}

The following changes will be **automatically adjusted** during upgrade, mentioned here for clarity:

- Main configuration modifications: Added the following modules

```toml
[io]
  feed_chan_size                 = 1024  # IO channel buffer size
  hight_frequency_feed_chan_size = 2048  # High-frequency IO channel buffer size
  max_cache_count                = 1024  # Local cache maximum, original main config io_cache_count [this value and max_dynamic_cache_count both less than or equal to zero will infinitely use memory]
  cache_dump_threshold         = 512   # Local cache cleanup threshold post-push [this value less than or equal to zero will not clean up cache, network interruption can lead to excessive memory usage]
  max_dynamic_cache_count      = 1024  # HTTP cache maximum, [this value and max_cache_count both less than or equal to zero will infinitely use memory]
  dynamic_cache_dump_threshold = 512   # HTTP cache cleanup threshold post-push, [this value less than or equal to zero will not clean up cache, network interruption can lead to excessive memory usage]
  flush_interval               = "10s" # Push interval
  output_file                  = ""    # Output IO data to local file, original main config output_file

[http_api]
    listen          = "localhost:9529" # Original http_listen
    disable_404page = false            # Original disable_404page

[logging]
    log           = "/var/log/datakit/log"     # Original log
    gin_log       = "/var/log/datakit/gin.log" # Original gin.log
    level         = "info"                     # Original log_level
    rotate        = 32                         # Original log_rotate
    disable_color = false                      # New configuration
```

---

## 1.2.18 (2023/05/06) {#cl-1.2.18}

This release is a hotfix, mainly addressing the following issues:

- Fixed Redis/MySQL collector data handling issues due to missing metrics (#783)
- Other bug fixes

---

## 1.2.17 (2023/04/27) {#cl-1.2.17}

This release is an iterative update, mainly involving the following aspects:

- [Container collector](container#7e687515) added more metrics (starting with `kube_`) (#668)
- DDTrace and OpenTelemetry collectors support filtering traces via HTTP Status Code (`omit_err_status`)
- Fixed reload ineffectiveness for several tracing collectors (DDtrace/OpenTelemetry/Zipkin/SkyWalking/Jaeger) in Git mode (#725)
- Fixed GitLab collector crashes due to missing tags (#730)
- Fixed Pod label (tag) updates in Kubernetes eBPF collector (#736)
- [Prometheus collector](prom.md) supports [tag renaming](prom#e42139cb) (#719)
- Enhanced partial documentation descriptions

---

## 1.2.16 (2023/04/24) {#cl-1.2.16}

This release is a hotfix, mainly addressing the following issues (#728):

- Fixed installation script potential errors preventing further installation/upgrade
- Fixed spelling errors in Windows installation scripts causing 32-bit installation download failures
- Adjusted Monitor display regarding election situations
- Fixed MongoDB infinite loop causing failure to collect under election mode

---

## 1.2.15 (2023/04/21) {#cl-1.2.15}

This release is an iterative update, containing numerous bug fixes:

- Pipeline module fixed Grok [dynamic multiline pattern](datakit-pl-how-to#88b72768) issues (#720)
- Removed unnecessary event logs reported by DataKit (#704)
- Fixed upgrade program potential upgrade failures (#699)
- DaemonSet added [pprof environment variable](datakit-daemonset-deploy#cc08ec8c) configuration (#697)
- All [default enabled collectors](datakit-input-conf#764ffbc2) in DaemonSet support environment variable configuration (#693)
- Initial support for [Tracing data processing in Pipeline](pipeline) (#675)
    - [DDtrace configuration example](ddtrace#69995abe)
- Dial Testing collector added failure task exit mechanism (#54)
- Optimized [Helm installation](datakit-daemonset-deploy#e4d3facf) (#695)
- Logs added `unknown` status level; logs without specified levels are considered `unknown` (#685)
- Log collection renamed from `tailf` to `logging`; the original `tailf` name remains usable
- Supported accessing Security data
- Removed Telegraf installation integration. If Telegraf functionality is needed, refer to :9529/man page for installation instructions
- Added Datakit How To documentation for beginners (:9529/man page)
- Other adjustments to collector metrics

---

## 1.2.14 (2023/04/12) {#cl-1.2.14}

This release is a hotfix, including part of small modifications and adjustments:

- Fixed startup issues in container deployments (#744)
- Added [support for multiple DataWays](datakit-update-crontab)
- [Cloud association](hostobject#031406b2) implemented through corresponding meta interfaces
- Adjusted Docker log collection filter method (#708)
- [DataKit supports elections](election)
- Fixed historical data cleanup issues in dial testing
- Published extensive documentation to [Yuque](https://www.yuque.com/dataflux/datakit){:target="_blank"}
- [DataKit supports command-line integration with Telegraf](datakit-tools-how-to#d1b3b29b)
- Single-instance run detection for DataKit
- Automatic update functionality for DataKit

---

## 1.2.13 (2023/04/08) {#cl-1.2.13}

This release is an iterative update, with the following changes:

- Added [disk S.M.A.R.T. collector](smart) (#268)
- Added [hardware temperature collector](sensors) (#269)
- Added [Prometheus collector](prom) (#270)
- Corrected upload issues caused by dirty data in cloud synchronization

---

## 1.2.12 (2023/03/24) {#cl-1.2.12}

This release is an iterative update, with the following changes:

1. Added [DataKit command-line completion](datakit-tools-how-to#9e4e5d5f) functionality (#76)
2. Allowed DataKit [upgrades to non-stable versions](datakit-update#42d8b0e4) (#639)
3. Adjusted local storage of Remote Pipeline in DataKit to avoid case sensitivity issues caused by different filesystems (#649)
4. (Alpha) Initial support for [Kubernetes/Containerd architecture data collection](container#b3edf30c) (#402)
5. Fixed unreasonable reporting of some collectors leading to duplicate data
6. Existing Studio frontend, template views, etc., do not yet support the latest container fields, potentially causing users to not see container data after upgrading. This version’s container collector redundantly includes original Docker collector metrics to ensure normal operation in Studio.
7. If there are additional Docker configurations in older versions, it is recommended to manually migrate them to the [container collector](container). Configuration is mostly compatible between the two.

---

## 1.2.11 (2023/03/17) {#cl-1.2.11}

This release is a hotfix, mainly addressing the following issues:

- Fixed trace sampling issues introduced since version 1.26. Sampling now occurs at Entry Span level rather than Root Span level, **recommended upgrade** (#2312)
- Fixed potential crashes in Windows due to file handle leaks (#1805)
- Optimized multiline processing in container logs (#633)
- Fixed time precision issues in JSON format data writes (#1567)

---

## 1.2.10 (2023/03/11) {#cl-1.2.10}

Fixed potential crashes in various Tracing collectors

---

## 1.2.9 (2023/03/10) {#cl-1.2.9}

This release is an iterative update, mainly including the following updates:

- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- Unified sampling rate settings for various Tracing data (#631)
- Published [DataKit log collection overview](datakit-logging)
- Supported [OpenTelemetry data ingestion](opentelemetry) (#609)
- Supported disabling logs for certain images inside Pods (#586)
- Process object collector added listening port list (#562)
- eBPF collector added [HTTP protocol collection](ebpf#905896c5) (#563)
- Host object collector added `conntrack` and `filefd` metrics (#348)
- Application performance metrics collection supports configuring sampling rates (#621)
- MySQL slow log supports cutting according to Alibaba Cloud RDS format (#276)

Other bug fixes.

### Breaking Changes {#cl-1.2.9-brk}

[RUM collection](rum) data types have been adjusted; the original data types are deprecated and need to [update the corresponding SDK](/dataflux/doc/eqs7v2).

---

## 1.2.8 (2023/03/04) {#cl-1.2.8}

This release is a hotfix, mainly addressing the following issues:

- DaemonSet mode deployment fixed issues with HTTP API precision parsing, leading to timestamp parsing failures for some data
- Other bug fixes

---

## 1.2.7 (2023/02/22) {#cl-1.2.7}

This release is an iterative update, mainly including the following updates:

- Pipeline:
    - Grok added [dynamic multiline pattern](datakit-pl-how-to#88b72768) for easier dynamic multiline splitting (#615)
    - Supported central issuance of Pipeline configurations (#524); Pipeline configurations now have [three storage paths](pipeline#6ee232b2)
    - DataKit HTTP API added Pipeline debugging interface `/v1/pipeline/debug` (#541)

- Other improvements:
    - Network dial testing added TCP/UDP/ICMP/Websocket protocol support (#519)
    - Adjusted units for some fields (#1113)
- Adjusted Remote Pipeline debugging API (#1128)
- Added singleton control for collectors (#1109)
- Changed log class data (except metrics) reporting to blocking mode in IO module (#1121)
- Enhanced terminal prompts during installation/upgrade (#1145)
- Other optimizations (#1777/#1794/#1778/#1783/#1775/#1774/#1737)

---

## 1.2.6 (2023/01/20) {#cl-1.2.6}

This release is an iterative update, mainly including the following updates:

- Enhanced [DataKit API security access control](rum#b896ec48), especially for RUM functionality. It is recommended to upgrade older DataKit versions (#578)
- Increased internal event log reporting (#527)
- Viewing [DataKit running status](datakit-tools-how-to#44462aae) no longer times out (#555)

- [Container collector](container) detailed bug fixes:

    - Fixed crashes during Kubernetes host deployments (#576)
    - Elevated priority of Annotation configurations (#553)
    - Container logs support multiline processing (#552)
    - Kubernetes Node objects added `_role_` field (#549)
    - [Prometheus collector](prom) annotations automatically add relevant attributes (_pod_name/node_name/namespace_) (#522/#443)
    - Other bug fixes

- Pipeline bug fixes:

    - Fixed potential time disorder issues in log processing (#547)
    - Supported complex logic judgments in `if/else` statements for Grok slicing (#538)

- Fixed Windows path issues in log collector (#423)
- Enhanced DataKit service management, optimizing interaction prompts (#535)
- Optimized unit definitions in existing DataKit documentation exports (#531)
- Improved engineering quality (#515/#528)

---

## 1.2.5 (2023/01/19) {#cl-1.2.5}

- Fixed [Log Stream collector](logstreaming) Pipeline configuration issues (#569)
- Fixed log disorder issues in [container collector](container) (#571)
- Fixed bugs in Pipeline module update logic (#572)

---

## 1.2.4 (2023/01/12) {#cl-1.2.4}

- Fixed lost metrics in log API interface (#551)
- Fixed partial data loss in eBPF network traffic statistics (#556)
- Fixed configuration file `$` character wildcard issues (#550)
- Pipeline `if` statement supports null value comparisons, aiding Grok slicing judgments (#538)

---

## 1.2.3 (2023/01/10) {#cl-1.2.3}

- Fixed *datakit.yaml* formatting issues (#544)
- Fixed election issues in [MySQL collector](mysql) (#543)
- Fixed log non-collection due to unconfigured Pipeline (#546)

---

## 1.2.2 (2023/01/07) {#cl-1.2.2}

This release is an iterative update, mainly addressing the following issues:

- [Container collector](container) updates:
    - Fixed efficiency issues in log processing (#540)
    - Optimized configuration file blacklist/whitelist settings (#536)
- Pipeline module added `datakit -M` metrics exposure (#541)
- [ClickHouse](clickhousev1) collector config-sample issue fixed (#539)
- [Kafka](kafka) metric collection optimized (#534)

---

## 1.2.1 (2023/01/05) {#cl-1.2.1}

This release is a hotfix, mainly addressing the following issues:

- Fixed usage issues with collectors' Pipelines (#529)
- Enhanced data handling in [container collector](container) (#532/#530)
    - Fixed short-image collection issues
    - Improved k8s environment Deployment/ReplicaSet associations

---

## 1.2.0 (2021/12/30) {#cl-1.2.0}

This release involves partial collector bug fixes and adjustments to DataKit's main configuration.

### Breaking Changes {#cl-1.2.0-brk}

- Adopted a new version numbering scheme; versions like `v1.0.0-2002-g1fe9f870` will no longer be used, switching to `v1.2.3` style versions.
- Moved original top-level `datakit.conf` configuration into the `conf.d` directory.
- Moved `network/net.conf` into `host/net.conf`.
- Moved the original `pattern` directory to the `pipeline` directory.
- Changed grok built-in patterns from lowercase (e.g., `%{space}`) to uppercase (e.g., `%{SPACE}`). **All existing Grok patterns need to be updated accordingly**.
- Removed `uuid` field from `datakit.conf`, storing it separately in a `.id` file for consistency across all DataKit configuration files.
- Removed Ansible event data reporting.

### Bug Fixes {#cl-1.2.0-fix}

- Fixed issues with `prom` and `oraclemonitor` not collecting data (#2457)
- Moved `hostname` field of `self` collector to tags as `host` (#2173)
- Fixed type conflicts in `mysqlMonitor` when collecting both MySQL and MariaDB (#2441)
- Fixed SkyWalking collector log aggregation leading to disk full issues (#2426)

### Features {#cl-1.2.0-new}

- Added blacklisting/whitelisting functionality for collectors/hosts
- Restructured host, process, container object collectors
- Added Pipeline/Grok debugging tools
- `-version` parameter now shows current version and prompts online new version information along with update commands
- Supported DDTrace data ingestion
- Changed `tailf` collector's new log matching to positive matching
- Other minor bug fixes
- Supported Mac platform CPU data collection

---

## v1.1.5-rc2 (2021/04/22) {#cl-1.1.5-rc2}

### Bug Fixes {#cl-1.1.5-rc2fix}

- Fixed Windows `--version` command fetching online version information address errors
- Adjusted Huawei Cloud monitoring data collection configuration, exposing more configurable information for real-time adjustments
- Adjusted Nginx error log (`error.log`) splitting scripts and added default log level categorization

---

## v1.1.5-rc1 (2021/04/21) {#cl-1.1.5-rc1}

### Bug Fixes {#cl-1.1.5-rc1fix}

- Fixed compatibility issues in `tailf` collector configuration files, which caused the `tailf` collector to fail to run

---

## v1.1.5-rc0 (2021/04/20) {#cl-1.1.5-rc0}

This release made significant adjustments to collectors.

### Breaking Changes {#cl-1.1.5-rc0brk}

The following collectors were affected:

| Collector          | Description                                                                                                                                                                                      |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cpu`              | Built-in CPU collector in DataKit, removed Telegraf CPU collector, configurations remain compatible. Mac platform temporarily does not support CPU collection, to be addressed later. (#2068) |
| `disk`             | Built-in disk collector in DataKit                                                                                                                                                               |
| `docker`           | Redesigned Docker collector, supporting container objects, container logs, and container metrics collection (including K8s containers)                                                           |
| `elasticsearch`    | Built-in ES collector in DataKit, removed Telegraf ES collector. Directly configure ES log collection within this collector                                                                       |
| `jvm`              | Built-in JVM collector in DataKit                                                                                                                                                                |
| `kafka`            | Built-in Kafka metrics collector in DataKit, directly collect Kafka logs within this collector                                                                                                    |
| `mem`              | Built-in memory collector in DataKit, removed Telegraf memory collector, configurations remain compatible                                                                                        |
| `mysql`            | Built-in MySQL collector in DataKit, removed Telegraf MySQL collector. Directly configure MySQL log collection within this collector                                                               |
| `net`              | Built-in network collector in DataKit, removed Telegraf network collector. Default no longer collects virtual NIC devices on Linux (manual enable required)                                          |
| `nginx`            | Built-in NGINX collector in DataKit, removed Telegraf NGINX collector. Directly configure NGINX log collection within this collector                                                              |
| `oracle`           | Built-in Oracle collector in DataKit. Directly configure Oracle log collection within this collector                                                                                             |
| `rabbitmq`         | Built-in RabbitMQ collector in DataKit. Directly configure RabbitMQ log collection within this collector                                                                                        |
| `redis`            | Built-in Redis collector in DataKit. Directly configure Redis log collection within this collector                                                                                              |
| `swap`             | Built-in swap memory collector in DataKit                                                                                                                         |
| `system`           | Built-in system collector in DataKit, removed Telegraf system collector. Added three new metrics: `load1_per_core/load5_per_core/load15_per_core` for single-core average load display without additional calculations |

Most of these collector updates involve changes to metric sets and metric names. Refer to individual collector documentation for specifics.

Other compatibility issues:

- For security reasons, collectors no longer bind to all NICs by default. They now bind to `localhost:9529`. The original binding `0.0.0.0:9529` is deprecated (the `http_server_addr` field has also been deprecated), use `http_listen = "0.0.0.0:9529"` instead.
- Some middleware (like MySQL/Nginx/Docker) have integrated corresponding log collections. These log collections can be configured directly within their respective collectors, eliminating the need for separate `tailf` configurations (though `tailf` can still be used independently).
- The following collectors are no longer effective and should be replaced by the built-in collectors listed above:
    - `dockerlog`: Integrated into the Docker collector
    - `docker_containers`: Integrated into the Docker collector
    - `mysqlMonitor`: Integrated into the MySQL collector

### New Features {#cl-1.1.5-rc0new}

- Dial Testing collector (`dialtesting`): Supports centralized task issuance. In the Studio homepage, there is a dedicated dial testing entry to create and manage dial testing tasks.
- All collectors support environment variable configurations, e.g., `host="$K8S_HOST"`, facilitating deployment in container environments.
- HTTP://localhost:9529/stats added more collector runtime statistics, including collection frequency (`frequency`), average number of data points per upload (`avg_size`), and average collection cost (`avg_collect_cost`). Some collectors may lack certain fields due to different collection methods.
- HTTP://localhost:9529/reload can reload collectors after configuration changes without restarting services, similar to Nginx’s `-s reload` function. You can use `curl http://localhost:9529/reload` or access the reload URL directly via browser, which redirects to the stats page upon success.
- HTTP://localhost:9529/man supports browsing DataKit documentation (only newly modified collector documentation is included here; other collector documentation remains in the original help center). By default, remote viewing of DataKit documentation is disabled. On Mac/Linux terminals, you can view documentation as follows:

```shell
# Navigate to the collector installation directory and input the collector name (use `Tab` for auto-completion)
$ ./datakit -cmd -man
man > nginx
(Displays NGINX collection documentation)
man > mysql
(Displays MySQL collection documentation)
man > Q               # Type Q or exit to quit
```

---

## v1.1.4-rc2 (2021/04/07) {#cl-1.1.4-rc2}

### Bug Fixes {#cl-1.1.4-rc2fix}

- Fixed frequent collection by the Alibaba Cloud Monitoring Data collector (`aliyuncms`), which led to some other collectors becoming unresponsive (#635)

---

## v1.1.4-rc1 (2021/03/25) {#cl-1.1.4-rc1}

### Improvements {#cl-1.1.4-rc1opt}

- Process collector `message` field added more information for better full-text search (#2161)
- Host object collector supports custom tags for cloud attribute synchronization (#2165)

---

## v1.1.4-rc0 (2021/03/25) {#cl-1.1.4-rc0}

### New Features {#cl-1.1.4-rc0new}

- Added file collector, dial testing collector, and HTTP packet collector
- Built-in support for ActiveMQ/Kafka/RabbitMQ/gin/Zap log parsing

### Improvements {#cl-1.1.4-rc0fix}

- Enriched `http://localhost:9529/stats` page statistics, adding collection frequency (`n/min`), average data size per collection (`avg_size`), and average collection time (`avg_collect_cost`)
- DataKit added a limited cache space (cleared on restart) to avoid data loss due to occasional network issues
- Enhanced Pipeline date conversion functions for accuracy. Added more Pipeline functions (`parse_duration()/parse_date()`)
- Trace data added more business fields (`project/env/version/http_method/http_status_code`)
- Various minor improvements in other collectors

---

## v1.1.3-rc4 (2021/03/16) {#cl-1.1.3-rc4}

### Bug Fixes {#cl-1.1.3-rc4fix}

- Process collector: Fixed missing usernames causing blank displays, using `nobody` for processes where username retrieval fails.
- Fixed potential panic in Kubernetes collector during memory utilization calculation (#2118)

---

## v1.1.3-rc3 (2021/03/04) {#cl-1.1.3-rc3}

### Bug Fixes {#cl-1.1.3-rc3fix}

- Fixed partial empty fields (process user and command) in process collector (#2118)
- Fixed potential panic in Kubernetes collector during memory utilization calculation (#2118)

---

## v1.1.3-rc2 (2021/03/01) {#cl-1.1.3-rc2}

### Bug Fixes {#cl-1.1.3-rc2fix}

- Fixed naming issues in process object collector `name` field, now named using `hostname + pid`
- Corrected Pipeline issues in Huawei Cloud object collector
- Fixed upgrade compatibility issues in Nginx/MySQL/Redis log collectors

---

## v1.1.3-rc1 (2021/02/26) {#cl-1.1.3-rc1}

### New Features {#cl-1.1.3-rc1new}

- Added built-in Redis/Nginx collectors
- Enhanced MySQL slow query log analysis

### Functionality Improvements {#cl-1.1.3-rc1opt}

- Limited process collector's minimum collection frequency to 30 seconds due to long single collection times
- Collector configuration file names no longer strictly require the `.conf` extension; any `xxx.conf` is valid
- Updated version prompt logic to include git commit mismatches
- Container object collector (`docker_containers`) added memory/CPU percentage fields (`mem_usage_percent/cpu_usage`)
- Kubernetes metrics collector (`kubernetes`) added CPU percentage field (`cpu_usage`)
- Tracing data collection improved service type handling
- Partial collectors support custom log or metric output (default is metrics)

### Bug Fixes {#cl-1.1.3-rc1fix}

- Fixed Mac platform process collector's inability to retrieve default usernames (#2161)
- Corrected issues with retrieving exited containers in container object collector (#2118)
- Other minor bug fixes

### Breaking Changes {#cl-1.1.3-rc1brk}

- For certain collectors, if the original metrics contain `uint64` fields, the new version might cause field incompatibility. Such fields should be removed to avoid conflicts.

    - Previously, `uint64` types were automatically converted to strings, which could lead to confusion during usage.
    - Metrics exceeding max-int64 will be discarded by the collector because InfluxDB 1.7 does not support `uint64` metrics.

- Removed some original `dkctrl` command functionalities; configuration management will no longer depend on this method.

---

## v1.1.2 (2021/02/03) {#cl-1.1.2}

### Functionality Improvements {#cl-1.1.2-opt}

- Container installations must inject the `ENV_UUID` environment variable
- After upgrading from old versions, the host collector is automatically enabled (original *datakit.conf* is backed up)
- Added caching functionality to avoid data loss due to occasional network issues (data would still be lost if network outages persist for too long)
- All log collectors using `tailf` must specify the `time` field in Pipeline to accurately reflect log timestamps
- Other minor optimizations

### Bug Fixes {#cl-1.1.2-fix}

- Fixed time unit issues in Zipkin (#2162)
- Added `state` field to host objects (#2165)

---

## v1.1.1 (2021/02/01) {#cl-1.1.1}

### Bug Fixes {#cl-1.1.1-fix}

- Fixed issues with `status/variable` fields being string types in Mysql Monitor collector. Reverted to original field types while protecting against int64 overflow.
- Aligned field naming in process collector with host collector

---

## v1.1.0 (2021/01/29) {#cl-1.1.0}

This release primarily involved bug fixes and Datakit main configuration adjustments.

### Breaking Changes {#cl-1.1.0-brk}

- Adopted a new versioning mechanism; versions like `v1.0.0-2002-g1fe9f870` will no longer be used, switching to `v1.2.3` style versions.
- Original top-level `datakit.conf` configuration moved into the `conf.d` directory.
- Original `network/net.conf` moved into `host/net.conf`.
- Original `pattern` directory moved to `pipeline` directory.
- Original Grok built-in patterns like `%{space}` changed to uppercase `%{SPACE}`. **All existing Grok patterns need to be updated**.
- Removed `uuid` field from `datakit.conf`, storing it separately in a `.id` file for consistency across all DataKit configuration files.
- Removed Ansible event data reporting.

### Bug Fixes {#cl-1.1.0-fix}

- Fixed issues with `prom` and `oraclemonitor` collectors not collecting data (#2457)
- Moved `hostname` field of `self` collector to tag as `host` (#2173)
- Fixed type conflicts in `mysqlMonitor` when collecting both MySQL and MariaDB (#2441)
- Fixed SkyWalking collector log aggregation leading to disk full issues (#2426)

### Features {#cl-1.1.0-new}

- Added blacklisting/whitelisting functionality for collectors/hosts (currently does not support regex)
- Restructured host, process, container object collectors
- Added Pipeline/Grok debugging tools
- `-version` parameter now shows current version and prompts online new version information along with update commands
- Supported DDTrace data ingestion
- Changed `tailf` collector's new log matching to positive matching
- Other minor bug fixes
- Supported Mac platform CPU data collection

---

## v1.0.9-rc7.1 (2021/12/22) {#cl-1.0.9-rc7.1}

- Fixed MySQL collector local collection failure issues leading to data problems.

---

## v1.0.9-rc7 (2021/12/16) {#cl-1.0.9-rc7}

### Bug Fixes {#cl-1.0.9-rc7fix}

- Fixed issues with `plugins` configuration not taking effect in SkyWalking (#3368)
- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.9-rc7opt}

- Optimized exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](../integrations/elasticsearch.md) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](../integrations/disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

---

## v1.0.9-rc6.1 (2021/12/10) {#cl-1.0.9-rc6.1}

- Fixed ElasticSearch and Kafka collection errors (#2317)

---

## v1.0.9-rc6 (2021/11/30) {#cl-1.0.9-rc6}

- Made emergency fixes to Pipeline:

    - Added `if/elif/else` [syntax](pipeline#1ea7e5aa)
    - Temporarily removed `expr()/json_all()` functions
    - Enhanced timezone handling, adding `adjust_timezone()` function
    - Strengthened overall testing for each Pipeline function

- DataKit DaemonSet:

    - Git configuration DaemonSet [ENV injection](datakit-daemonset-deploy#00c8a780) (#470)
    - Default disabled container collector to avoid duplicate collection (#473)

- Others:
    - DataKit supports self-event logging (in log form) (#463)
    - [ElasticSearch](elasticsearch) metrics set added `indices_lifecycle_error_count` metric (note: requires adding `ilm` role in ES for this metric) (#510)
- Installation phase automatically adds cgroup limits (#501)
- Some interfaces interacting with the center were upgraded to v2 versions, so for Datakit instances connecting to non-SaaS nodes, if upgraded to this version, the corresponding DataWay and Kodo also need to be upgraded to avoid 404 errors.

### Breaking Changes {#cl-1.0.9-rc6brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, accessing the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.9-rc5.1 (2021/11/26) {#cl-1.0.9-rc5.1}

- Fixed DDTrace collector crashing due to dirty data

---

## v1.0.9-rc5 (2021/11/23) {#cl-1.0.9-rc5}

- Added [Pythond (alpha)](pythond), facilitating writing custom collectors in Python3 (#367)
<!-- - Supported source map file processing for JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

### Documentation Adjustments {#cl-1.0.9-rc5-doc}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entries for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.8-rc3 (2021/11/10) {#cl-1.0.8-rc3}

- Optimized [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Installed successfully on Mac M1 chip (#407)
- [eBPF-network](net_ebpf) fixed connection count statistical errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

---

## v1.0.8-rc2 (2021/10/14) {#cl-1.0.8-rc2}

- Added [collector](prom_remote_write) support for Prometheus Remote Write to synchronize data to DataKit (#381)
- Added [Kubernetes Event data collection](kubernetes#49edf2c4) (#296)
- Fixed Mac installation script issues due to security policies (#379)
- [Prometheus collector](prom) debug tool supports testing data slicing from local files (#378)
- Fixed data issues in [etcd collector](etcd) (#377)
- DataKit Docker image added arm64 architecture support (#365)
- Installation phase added support for environment variable `DK_HOSTNAME` (#334)
- [Apache collector](apache) added more metric collections (#329)
- DataKit API added interface [`/v1/workspace`](apis#2a24dd46) to get workspace information (#324)
    - Supported getting workspace information via command-line parameters

---

## v1.0.8-rc1.1 (2021/10/09) {#cl-1.0.8-rc1.1}

- Fixed Kubernetes election issues (#389)
- Fixed MongoDB configuration compatibility issues

---

## v1.0.8-rc1 (2021/09/28) {#cl-1.0.8-rc1}

- Enhanced Kubernetes ecosystem [Prometheus metric collection](kubernetes-prom) (#368/#347)
- [eBPF-network](net_ebpf) optimization
- Fixed potential crashes caused by timeout components in HTTP services (#2423)
- Fixed time unit issues in New Relic collection (#2417)
- Fixed potential crashes caused by `point_window()` function in Pipeline (#2416)
- Fixed protocol identification issues in eBPF collection (#2451)

### Functionality Improvements {#cl-1.0.8-rc1-opt}

- Optimized Zabbix data import functionality, optimizing bulk update logic and adjusting metric naming while synchronizing some tags read from MySQL to Zabbix data points (#2455)
- Optimized Pipeline processing performance (reduced memory consumption by over 30%), where the `load_json()` function replaced a more efficient library, improving JSON processing performance by about 16% (#2459)
- Optimized file discovery strategy in log collection using inotify for more efficient handling of new files, avoiding delayed collection (#2462)
- Optimized timestamp alignment mechanism for mainstream metrics to improve time series storage efficiency (#2445)

### Compatibility Adjustments {#cl-1.0.8-rc1-brk}

- Environment variables `ENV_LOGGING_FIELD_WHITE_LIST/ENV_LOOGING_MAX_OPEN_FILES` only affect log collection within Kubernetes. Collection configured via *logging.conf* **no longer affected by these ENVs** because this version has already provided corresponding entries for *logging.conf*.

---

## v1.0.7-rc9.1 (2021/07/17) {#cl-1.0.7-rc9.1}

- Fixed issues with file handle leaks causing DataKit restart failures on Windows (#389)

---

## v1.0.7-rc9 (2021/07/15) {#cl-1.0.7-rc9}

- Installation phase supports specifying cloud provider, namespace, and NIC binding
- Multi-namespace election support
- Added [InfluxDB collector](influxdb)
- Datakit DQL added historical command storage
- Other detailed bug fixes

---

## v1.0.7-rc8 (2021/07/09) {#cl-1.0.7-rc8}

- Supported obtaining hostname from `ENV_HOSTNAME` to handle cases where the original hostname is unavailable
- Adjusted monitor page display:
    - Separated collector configuration status from collection status
    - Added election and auto-update status display
- Supported extracting basic information from Profile files in Profiling collection (#2335)
- Added resource filtering based on Tag levels in tracing (#2335)
- [Container collector](container) supports collecting internal process objects
- Supported controlling DataKit CPU usage via cgroup (Linux only) (#2011)
- Added [IIS collector](iis)
- Fixed upload issues caused by dirty data in cloud synchronization

---

## v1.0.7-rc7 (2021/07/01) {#cl-1.0.7-rc7}

- DataKit API now supports [JSON Body](apis#75f8e5a2)
- Command-line added features:

    - [DQL query functionality](datakit-dql-how-to#cb421e00)
    - [Command-line view of monitor](datakit-tools-how-to#44462aae)
    - [Checking correctness of collector configurations](datakit-tools-how-to#519a9e75)

- Performance optimization for logs (for built-in log collectors like nginx/MySQL/Redis)
- Host object collector added [`conntrack` and `filefd`](hostobject#2300b531) metrics
- Application performance metrics collection supports setting sampling rates
- General solution for Kubernetes cluster Prometheus metrics collection

### Breaking Changes {#cl-1.0.7-rc7brk}

- In *datakit.conf*, the `global_tags` `host` tag will no longer take effect. This change avoids misunderstandings when configuring `host` (i.e., configured `host` might differ from the actual hostname, leading to data misinterpretation).

---

## v1.0.7-rc6 (2021/06/17) {#cl-1.0.7-rc6}

- Added [Windows event collector](windows_event)
- Provided an option to disable DataKit's 404 page for easier public DataKit RUM deployment
- [Container collector](container) fields were optimized, mainly involving `restart/ready/state` fields for pods
- [Kubernetes collector](kubernetes) added more metrics
- Supported log filtering on the DataKit side
    - Note: If DataKit is configured with multiple DataWay addresses, log filtering will not take effect.

### Breaking Changes {#cl-1.0.7-rc6brk}

For collectors without Yuzhi documentation support, they have been removed in this release (various cloud collectors like Alibaba Cloud monitoring data, billing data, etc.). If you depend on these collectors, it is not recommended to upgrade.

---

## v1.0.7-rc5 (2021/06/16) {#cl-1.0.7-rc5}

Fixed DataKit API `/v1/query/raw` unusability issues.

---

## v1.0.7-rc4 (2021/06/11) {#cl-1.0.7-rc4}

Disabled Docker collector as its functionality is fully covered by the [container collector](container).

Reasons:

- Coexistence of Docker and container collectors (automatically enabled by DataKit default installation/upgrades) led to duplicate data.
- Current Studio frontend, template views, etc., do not yet support the latest container fields, potentially causing users to not see container data after upgrades. This version's container collector redundantly includes original Docker collector metrics to ensure normal operation in Studio.

> Note: If you have additional Docker configurations in older versions, it is recommended to manually migrate them to the [container collector](container). Configuration between the two collectors is mostly compatible.

---

## v1.0.7-rc3 (2021/06/10) {#cl-1.0.7-rc3}

- Added [disk S.M.A.R.T. collector](smart)
- Added [hardware temperature collector](sensors)
- Added [Prometheus collector](prom)
- Corrected [Kubernetes collector](kubernetes), supporting more K8s object statistical metric collections
- Enhanced [container collector](container), supporting image/container/pod filtering
- Corrected [MongoDB collector](mongodb) issues
- Corrected potential crashes in MySQL/Redis collectors due to missing configurations
- Fixed offline installation issues
- Corrected log setting issues in some collectors
- Corrected data issues in [SSH](ssh)/[Jenkins](jenkins) collectors

---

## v1.0.7-rc2 (2021/06/07) {#cl-1.0.7-rc2}

- Added [Kubernetes collector](kubernetes)
- DataKit supports [DaemonSet deployment](datakit-daemonset-deploy)
- Added [SQL Server collector](sqlserver)
- Added [PostgreSQL collector](postgresql)
- Added [statsd collector](statsd) to support collecting statsd data sent over the network
- [JVM collector](jvm) prioritizes DDTrace/StatsD collection
- Added [container collector](container), enhancing k8s node (Node) collection to replace the original [docker collector](docker) (original docker collector remains usable)
- [Dial testing collector](dialtesting) supports Headless mode
- [MongoDB collector](mongodb) supports collecting MongoDB logs
- DataKit added DQL HTTP [API interface](apis) `/v1/query/raw`
- Enhanced documentation for some collectors, adding related log collection documentation for middlewares like MySQL/Redis/ES

---

## v1.0.7-rc1 (2021/05/26) {#cl-1.0.7-rc1}

- Fixed Redis/MySQL collector data anomalies (#2429)
- MySQL InnoDB metrics were restructured; specific details refer to [MySQL documentation](mysql#e370e857)

---

## v1.0.7-rc0 (2021/05/20) {#cl-1.0.7-rc0}

Added collectors:

- [Apache](apache)
- [Cloudprober integration](cloudprober)
- [GitLab](gitlab)
- [Jenkins](jenkins)
- [Memcached](memcached)
- [MongoDB](mongodb)
- [SSH](ssh)
- [Solr](solr)
- [Tomcat](tomcat)

New features:

- Network dial testing supports private node access
- Linux platform defaults to enabling container object and log collection
- CPU collector supports temperature data collection
- [MySQL slow log supports Aliyun RDS format parsing](mysql#ee953f78)

Other various bug fixes.

### Breaking Changes {#cl-1.0.7-rc0brk}

[RUM collection](rum) data types were adjusted; the original data types are deprecated and require [updating the corresponding SDK](/dataflux/doc/eqs7v2).

---

## v1.0.6-rc7 (2021/05/19) {#cl-1.0.6-rc7}

- Fixed Windows platform installation and upgrade issues

---

## v1.0.6-rc6 (2021/05/19) {#cl-1.0.6-rc6}

- Fixed data processing issues in some collectors (MySQL/Redis) due to missing metrics
- Other bug fixes

---

## v1.0.6-rc5 (2021/05/18) {#cl-1.0.6-rc5}

- Fixed HTTP API precision parsing issues, leading to timestamp parsing failures for some data

---

## v1.0.6-rc4 (2021/05/17) {#cl-1.0.6-rc4}

- Fixed potential crashes in container log collection

---

## v1.0.6-rc3 (2021/05/13) {#cl-1.0.6-rc3}

This release contains the following updates:

- DataKit installation/upgrade directories changed to:

    - Linux/Mac: `/usr/local/datakit`, log directory `/var/log/datakit`
    - Windows: `C:\Program Files\datakit`, log directory under installation directory

- Supported [`/v1/ping` interface](apis#50ea0eb5)
- Removed RUM collector; RUM interface is [supported by default](apis#f53903a9)
- Added monitor page: http://localhost:9529/monitor, replacing the previous /stats page. Automatically redirects to the monitor page after reload.
- Supported direct commands to [install sec-checker](datakit-tools-how-to#01243fef) and [update ip-db](datakit-tools-how-to#ab5cd5ad)

---

## v1.0.6-rc2 (2021/05/11) {#cl-1.0.6-rc2}

- Fixed container deployment startup issues

---

## v1.---

## v1.0.6-rc2 (2021/05/11) {#cl-1.0.6-rc2}

- Fixed startup issues in container deployments

---

## v1.0.6-rc1 (2021/05/10) {#cl-1.0.6-rc1}

This release made adjustments to some DataKit details:

- DataKit supports configuring multiple DataWays
- [Cloud association](hostobject#031406b2) is implemented via corresponding meta interfaces
- Adjusted Docker log collection [filtering method](docker#a487059d)
- [DataKit supports elections](election)
- Fixed historical data cleanup issues in dial testing
- Extensive documentation [published to Yuque](https://www.yuque.com/dataflux/datakit){:target="_blank"}
- [DataKit supports command-line integration with Telegraf](datakit-tools-how-to#d1b3b29b)
- Added single-instance runtime detection for DataKit
- Added [automatic update functionality](datakit-update-crontab)

---

## v1.0.6-rc0 (2021/04/30) {#cl-1.0.6-rc0}

This release made several detailed adjustments to DataKit:

- Linux/Mac installations now allow running `datakit` commands from any directory without switching to the DataKit installation directory
- Pipeline added desensitization function `cover()`
- Optimized command-line parameters for better usability
- Host object collection defaults to filtering virtual devices (Linux only)
- Datakit commands support `--start/--stop/--restart/--reload` options (requires root privileges), making it easier to manage DataKit services
- After installation/upgrade, default enabled process object collector (`cpu/disk/diskio/mem/swap/system/hostobject/net/host_processes`)
- Log collector `tailf` renamed to `logging`; the original `tailf` name remains usable
- Supported Security data ingestion
- Removed Telegraf installation integration. If Telegraf functionality is needed, refer to :9529/man page for specific installation instructions.
- Added Datakit How To documentation for beginners (:9529/man page)

### Breaking Changes {#cl-1.0.6-rc0-brk}

For certain collectors, if original metrics contain `uint64` type fields, the new version may cause field incompatibility. Such fields should be removed to avoid conflicts.

- Previously, `uint64` types were automatically converted to strings, which could lead to confusion during usage.
- Metrics exceeding max-int64 will be discarded by the collector because InfluxDB 1.7 does not support `uint64` metrics.

Removed some original `dkctrl` command functionalities; configuration management will no longer depend on this method.

---

## v1.0.5-rc2 (2021/04/22) {#cl-1.0.5-rc2}

### Bug Fixes {#cl-1.0.5-rc2fix}

- Fixed incorrect request address in Windows `--version` command (#617)
- Adjusted Huawei Cloud monitoring data collection configuration, exposing more configurable information for real-time adjustments
- Adjusted Nginx error log (`error.log`) splitting scripts and added default log level categorization

---

## v1.0.5-rc1 (2021/04/21) {#cl-1.0.5-rc1}

### Bug Fixes {#cl-1.0.5-rc1fix}

- Fixed compatibility issues in `tailf` collector configuration files that caused the `tailf` collector to fail to run

---

## v1.0.5-rc0 (2021/04/20) {#cl-1.0.5-rc0}

This release made significant adjustments to collectors.

### Breaking Changes {#cl-1.0.5-rc0brk}

The following collectors were affected:

| Collector          | Description                                                                                                                                                                                      |
|--------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cpu`              | Built-in CPU collector in DataKit, removed Telegraf CPU collector, configurations remain compatible. Mac platform temporarily does not support CPU collection, to be addressed later. (#2068) |
| `disk`             | Built-in disk collector in DataKit                                                                                                                                                               |
| `docker`           | Redesigned Docker collector, supporting container objects, container logs, and container metrics collection (including K8s containers)                                                           |
| `elasticsearch`    | Built-in ES collector in DataKit, removed Telegraf ES collector. Directly configure ES log collection within this collector                                                                       |
| `jvm`              | Built-in JVM collector in DataKit                                                                                                                                                                |
| `kafka`            | Built-in Kafka metrics collector in DataKit, directly collect Kafka logs within this collector                                                                                                    |
| `mem`              | Built-in memory collector in DataKit, removed Telegraf memory collector, configurations remain compatible                                                                                        |
| `mysql`            | Built-in MySQL collector in DataKit, removed Telegraf MySQL collector. Directly configure MySQL log collection within this collector                                                               |
| `net`              | Built-in network collector in DataKit, removed Telegraf network collector. Default no longer collects virtual NIC devices on Linux (manual enable required)                                          |
| `nginx`            | Built-in NGINX collector in DataKit, removed Telegraf NGINX collector. Directly configure NGINX log collection within this collector                                                              |
| `oracle`           | Built-in Oracle collector in DataKit. Directly configure Oracle log collection within this collector                                                                                             |
| `rabbitmq`         | Built-in RabbitMQ collector in DataKit. Directly configure RabbitMQ log collection within this collector                                                                                        |
| `redis`            | Built-in Redis collector in DataKit. Directly configure Redis log collection within this collector                                                                                                 |
| `swap`             | Built-in swap memory collector in DataKit                                                                                                                         |
| `system`           | Built-in system collector in DataKit, removed Telegraf system collector. Added three new metrics: `load1_per_core/load5_per_core/load15_per_core` for displaying single-core average load without additional calculations

These updates mean that most non-host-type collectors have undergone changes in metric sets and metric names. Refer to individual collector documentation for specifics.

Other compatibility issues:

- For security reasons, collectors no longer bind to all NICs by default. They now bind to `localhost:9529`. The previous binding `0.0.0.0:9529` has been deprecated (the `http_server_addr` field is also deprecated). Use `http_listen = "0.0.0.0:9529"` instead.
- Some middleware (like MySQL/Nginx/Docker) have integrated their respective log collections. These log collections can be configured directly within their respective collectors, eliminating the need for separate `tailf` configurations (though `tailf` can still be used independently).
- The following collectors are no longer effective and should be replaced by the built-in collectors listed above:
    - `dockerlog`: Integrated into Docker collector
    - `docker_containers`: Integrated into Docker collector
    - `mysqlMonitor`: Integrated into MySQL collector

### New Features {#cl-1.0.5-rc0-new}

- Dial Testing collector (`dialtesting`): Supports centralized task issuance. In the Studio homepage, there is a dedicated entry for creating and managing dial testing tasks.
- All collectors' configurations support environment variable settings, e.g., `host="$K8S_HOST"`, facilitating deployment in container environments.
- HTTP://localhost:9529/stats added more collector runtime statistics, including collection frequency (`frequency`), average number of data points per upload (`avg_size`), and average collection time (`avg_collect_cost`). Some collectors may lack certain fields due to different collection methods.
- HTTP://localhost:9529/reload can reload collectors after configuration changes without restarting services, similar to Nginx’s `-s reload` function. You can use `curl http://localhost:9529/reload` or access the reload URL directly via browser, which redirects to the stats page upon success.
- Supported viewing DataKit documentation on http://localhost:9529/man page (only newly modified collector documentation is included here; other collector documentation remains in the original help center). By default, remote viewing of DataKit documentation is disabled. On Mac/Linux terminals, you can view documentation as follows:

```shell
# Navigate to the collector installation directory and input the collector name (use `Tab` for auto-completion)
$ ./datakit -cmd -man
man > nginx
(Displays NGINX collection documentation)
man > mysql
(Displays MySQL collection documentation)
man > Q               # Type Q or exit to quit
```

---

## v1.0.4-rc2 (2021/04/07) {#cl-1.0.4-rc2}

### Bug Fixes {#cl-1.0.4-rc2fix}

- Fixed frequent collection issues in the Alibaba Cloud Monitoring Data collector (`aliyuncms`), leading to some other collectors becoming unresponsive.

---

## v1.0.4-rc1 (2021/03/25) {#cl-1.0.4-rc1}

### Bug Fixes {#cl-1.0.4-rc1fix}

- Fixed compatibility issues in `tailf` collector configuration files, causing the `tailf` collector to fail to run.

---

## v1.0.4-rc0 (2021/03/25) {#cl-1.0.4-rc0}

### New Features {#cl-1.0.4-rc0new}

- Added file collector, dial testing collector, and HTTP packet collector
- Built-in support for ActiveMQ/Kafka/RabbitMQ/gin/Zap log parsing

### Improvements {#cl-1.0.4-rc0opt}

- Enhanced [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Installed successfully on Mac M1 chip (#407)
- [eBPF-network](net_ebpf) fixed connection count statistical errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

### Breaking Changes {#cl-1.0.4-rc0brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, accessing the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.3-rc4 (2021/03/16) {#cl-1.0.3-rc4}

### Bug Fixes {#cl-1.0.3-rc4fix}

- Process collector: Fixed missing usernames causing blank displays, using `nobody` for processes where username retrieval fails (#576).

---

## v1.0.3-rc3 (2021/03/04) {#cl-1.0.3-rc3}

### Bug Fixes {#cl-1.0.3-rc3fix}

- Fixed partial empty fields (process user and command) in process collector (#576)
- Fixed potential panic in Kubernetes collector during memory utilization calculation (#571)

---

## v1.0.3-rc2 (2021/03/01) {#cl-1.0.3-rc2}

### Bug Fixes {#cl-1.0.3-rc2fix}

- Fixed naming issues in process object collector `name` field, now named using `hostname + pid` (#576)
- Corrected Pipeline issues in Huawei Cloud object collector (#730)
- Fixed upgrade compatibility issues in Nginx/MySQL/Redis log collectors (#620)

---

## v1.0.3-rc1 (2021/02/26) {#cl-1.0.3-rc1}

### New Features {#cl-1.0.3-rc1new}

- Added built-in Redis/Nginx collectors
- Enhanced MySQL slow query log analysis

### Functionality Improvements {#cl-1.0.3-rc1opt}

- Set a minimum frequency limit (30 seconds) for process collector due to long single collection duration (#576)
- Collector configuration file names no longer strictly require the `.conf` extension; any `xxx.conf` is valid
- Updated version prompt logic to include git commit mismatches (#576)
- Container object collector ([docker_containers](container)) added memory/CPU percentage fields (`mem_usage_percent/cpu_usage`)
- Kubernetes metrics collector (`kubernetes`) added CPU percentage field (`cpu_usage`)
- Tracing data collection improved handling of service type
- Some collectors now support custom log or metric output (default is metrics)

### Bug Fixes {#cl-1.0.3-rc1fix}

- Fixed Mac platform process collector's inability to retrieve default usernames (#576)
- Corrected issues with retrieving exited containers in container object collector (#571)
- Other minor bug fixes

### Breaking Changes {#cl-1.0.3-rc1brk}

For certain collectors, if original metrics contain `uint64` type fields, the new version might cause field incompatibility. Such fields should be removed to avoid conflicts.

- Previously, `uint64` types were automatically converted to strings, which could lead to confusion during usage.
- Metrics exceeding max-int64 will be discarded by the collector because InfluxDB 1.7 does not support `uint64` metrics.
- Removed some original `dkctrl` command functionalities; configuration management will no longer depend on this method.

---

## v1.0.2 (2021/02/03) {#cl-1.0.2}

### Functionality Improvements {#cl-1.0.2-opt}

- Container installations must inject the `ENV_UUID` environment variable
- After upgrading from old versions, the host collector is automatically enabled (original *datakit.conf* is backed up)
- Added caching functionality to avoid data loss due to occasional network issues (data would still be lost if network outages persist for too long)
- All log collectors using `tailf` must specify the `time` field in Pipeline to accurately reflect log timestamps
- Supported accessing Security data
- Removed Telegraf installation integration. If Telegraf functionality is needed, refer to :9529/man page for specific installation instructions.
- Added Datakit How To documentation for beginners (:9529/man page)

### Bug Fixes {#cl-1.0.2-fix}

- Fixed time unit issues in Zipkin (#2423)
- Added `state` field to host objects (#2426)

---

## v1.0.1 (2021/02/01) {#cl-1.0.1}

### Bug Fixes {#cl-1.0.1-fix}

- Fixed issues with `status/variable` fields being string types in [Mysql Monitor collector](mysql). Reverted to original field types while protecting against int64 overflow.
- Aligned field naming in process collector with host collector

---

## v1.0.0 (2021/01/29) {#cl-1.0.0}

This version primarily involved bug fixes and Datakit main configuration adjustments.

### Breaking Changes {#cl-1.0.0-brk}

- Adopted a new version numbering scheme; versions like `v1.0.0-2002-g1fe9f870` will no longer be used, switching to `v1.2.3` style versions.
- Original top-level `datakit.conf` configuration moved into the `conf.d` directory.
- Original `network/net.conf` moved into `host/net.conf`.
- Original `pattern` directory moved to `pipeline` directory.
- Original Grok built-in patterns like `%{space}` changed to uppercase `%{SPACE}`. **All existing Grok patterns need to be updated**.
- Removed `uuid` field from `datakit.conf`, storing it separately in a `.id` file for consistency across all DataKit configuration files.
- Removed Ansible event data reporting.

### Bug Fixes {#cl-1.0.0-fix}

- Fixed issues with `prom` and `oraclemonitor` collectors not collecting data (#2457)
- Moved `hostname` field of `self` collector to tags as `host` (#2173)
- Fixed type conflicts in `mysqlMonitor` when collecting both MySQL and MariaDB (#2441)
- Fixed SkyWalking collector log aggregation leading to disk full issues (#2426)

### Features {#cl-1.0.0-new}

- Added blacklisting/whitelisting functionality for collectors/hosts (currently does not support regex)
- Restructured host, process, container object collectors
- Added Pipeline/Grok debugging tools
- `-version` parameter now shows current version and prompts online new version information along with update commands
- Supported DDTrace data ingestion
- Changed `tailf` collector's new log matching to positive matching
- Other minor bug fixes
- Supported Mac platform CPU data collection

---

## v1.0.0-rc7.1 (2021/12/22) {#cl-1.0.0-rc7.1}

- Fixed MySQL collector local collection failure issues leading to data problems.

---

## v1.0.0-rc7 (2021/12/16) {#cl-1.0.0-rc7}

### Bug Fixes {#cl-1.0.0-rc7fix}

- Fixed frequent collection issues in the Alibaba Cloud Monitoring Data collector (`aliyuncms`), leading to some other collectors becoming unresponsive (#635).

### Improvements {#cl-1.0.0-rc7opt}

- Enhanced [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Successfully installed on Mac M1 chip (#407)
- [eBPF-network](net_ebpf) fixed connection count statistical errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

---

## v1.0.0-rc4 (2021/03/16) {#cl-1.0.0-rc4}

### Bug Fixes {#cl-1.0.0-rc4fix}

- Fixed process collector issues with missing usernames causing blank display, using `nobody` for processes where username retrieval fails.
- Fixed potential panics in Kubernetes collector during memory utilization calculation.
- Fixed Nginx/MySQL/Redis log collection compatibility issues post-upgrade.

### Functionality Improvements {#cl-1.0.0-rc4opt}

- Process collector `message` field added more information for better full-text search.
- Host object collector supports custom tags for cloud attribute synchronization.
- Enhanced MySQL slow query log analysis.
- Set a minimum frequency limit (30 seconds) for process collector due to long single collection duration.
- Collector configuration file names no longer strictly require the `.conf` extension; any `xxx.conf` is valid.
- Updated version prompt logic: if the git commit hash does not match the online version, it will also prompt for an update.
- Container object collector ([docker_containers](container)) added memory/CPU percentage fields (`mem_usage_percent/cpu_usage`).
- Kubernetes metrics collector (`kubernetes`) added CPU percentage field (`cpu_usage`).
- Tracing data collection improved handling of service type.
- Some collectors support custom log or metric output (default is metrics).

### Documentation Adjustments {#cl-1.0.0-rc4doc}

- Almost every chapter added jump labels for permanent references.
- Pythond documentation moved to developer directory.
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060).

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure.

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entries for almost every collector.

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections.

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc3 (2021/03/10) {#cl-1.0.0-rc3}

- Added [disk S.M.A.R.T. collector](smart) (#268)
- Added [hardware temperature collector](sensors) (#269)
- Added [Prometheus collector](prom) (#270)
- Corrected upload issues caused by dirty data in cloud synchronization

### Breaking Changes {#cl-1.0.0-rc3-brk}

- Removed the feature to obtain hostname from environment variable `ENV_HOSTNAME` (supported in 1.1.7-rc8), use [hostname override feature](datakit-install#987d5f91) instead.
- Removed command option `--reload`
- Removed DataKit API `/reload`, replaced by `/restart`
- Due to changes in command-line options, previous monitor viewing commands now require sudo privileges to read *datakit.conf* and fetch DataKit configurations.

---

## v1.0.0-rc2 (2021/03/01) {#cl-1.0.0-rc2}

### Bug Fixes {#cl-1.0.0-rc2-fix}

- Fixed username absence leading to blank display in process collector, setting `nobody` as the username for failed username retrieval processes.
- Fixed potential panics in Kubernetes collector during memory utilization calculation.

### Functionality Improvements {#cl-1.0.0-rc2-opt}

- Process collector `message` field added more information for better full-text search.
- Host object collector supports custom tags for cloud attribute synchronization.
- Enhanced MySQL slow query log analysis.
- Set a minimum frequency limit (30 seconds) for process collector due to long single collection duration.
- Collector configuration file names no longer strictly require the `.conf` extension; any `xxx.conf` is valid.
- Updated version prompt logic: if the git commit hash does not match the online version, it will also prompt for an update.
- Container object collector ([docker_containers](container)) added memory/CPU percentage fields (`mem_usage_percent/cpu_usage`).
- Kubernetes metrics collector (`kubernetes`) added CPU percentage field (`cpu_usage`).
- Tracing data collection improved handling of service type.
- Some collectors support custom log or metric output (default is metrics).

### Documentation Adjustments {#cl-1.0.0-rc2-doc}

- Almost every chapter added jump labels for permanent references.
- Pythond documentation moved to developer directory.
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060).

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure.

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entries for almost every collector.

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections.

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc1 (2021/02/26) {#cl-1.0.0-rc1}

### New Features {#cl-1.0.0-rc1-new}

- Added [Pythond (alpha)](pythond), facilitating writing custom collectors in Python3 (#367)
<!-- - Added source map file handling for JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

### Documentation Adjustments {#cl-1.0.0-rc1-doc}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entry for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added file collector, dial testing collector, and HTTP packet collector
- Built-in support for ActiveMQ/Kafka/RabbitMQ/gin/Zap log parsing

### Improvements {#cl-1.0.0-rc0-opt}

- Enhanced [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Installed successfully on Mac M1 chip (#407)
- [eBPF-network](net_ebpf) fixed connection count statistical errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Apache](apache)
- [Cloudprober integration](cloudprober)
- [GitLab](gitlab)
- [Jenkins](jenkins)
- [Memcached](memcached)
- [MongoDB](mongodb)
- [SSH](ssh)
- [Solr](solr)
- [Tomcat](tomcat)

New features related:

- Network dial testing supports private node access
- Linux platform defaults to enabling container object and log collection
- CPU collector supports temperature data collection
- [MySQL slow log supports Aliyun RDS format parsing](mysql#ee953f78)

Other various bug fixes.

### Breaking Changes {#cl-1.0.0-rc0-brk}

[RUM collection](rum) data types were adjusted; the original data types are deprecated and require [updating the corresponding SDK](/dataflux/doc/eqs7v2).

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-refer-table/) (#1634)
- DataKit 9529 HTTP [supports binding to domain socket](datakit-conf.md#uds) (#925)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced [Redis collector](redis) DB configuration method (#395)
- Fixed tag value emptiness issues in [Kubernetes collector](kubernetes) (#409)
- Installed successfully on Mac M1 chip (#407)
- [eBPF-network](net_ebpf) fixed connection count statistical errors (#387)
- Log collection added [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391)
- [ElasticSearch collector](elasticsearch) added more metric collections (#386)
- APM added [Jaeger data](jaeger) ingestion (#383)
- [Prometheus Remote Write](prom_remote_write) collector supported data slicing debugging
- Optimized [Nginx proxy](proxy#a64f44d8) functionality
- DQL query results supported [CSV file export](datakit-dql-how-to#2368bf1d)

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Pythond (alpha)](pythond), facilitating writing custom collectors in Python3 (#367)
<!-- - Added source map file handling for JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

### Documentation Adjustments {#cl-1.0.0-rc0-doc}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entry for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Apache](apache)
- [Cloudprober integration](cloudprober)
- [GitLab](gitlab)
- [Jenkins](jenkins)
- [Memcached](memcached)
- [MongoDB](mongodb)
- [SSH](ssh)
- [Solr](solr)
- [Tomcat](tomcat)

New features related:

- Network dial testing supports private node access
- Linux platform defaults to enabling container object and log collection
- CPU collector supports temperature data collection
- [MySQL slow log supports Aliyun RDS format parsing](mysql#ee953f78)

Other various bug fixes.

### Breaking Changes {#cl-1.0.0-rc0-brk}

[RUM collection](rum) data types were adjusted; the original data types are deprecated and require [updating the corresponding SDK](/dataflux/doc/eqs7v2).

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Pythond (alpha)](pythond), facilitating writing custom collectors in Python3 (#367)
<!-- - Added source map file handling for JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

### Documentation Adjustments {#cl-1.0.0-rc0-doc}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entries for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Apache](apache) collector
- Added [Cloudprober integration](cloudprober)
- Added [GitLab](gitlab) collector
- Added [Jenkins](jenkins) collector
- Added [Memcached](memcached) collector
- Added [MongoDB](mongodb) collector
- Added [SSH](ssh) collector
- Added [Solr](solr) collector
- Added [Tomcat](tomcat) collector

New features related:

- Network dial testing supports private node access
- Linux platform defaults to enabling container object and log collection
- CPU collector supports temperature data collection
- [MySQL slow log supports Aliyun RDS format parsing](mysql#ee953f78)

Other various bug fixes.

### Breaking Changes {#cl-1.0.0-rc0-brk}

[RUM collection](rum) data types were adjusted; the original data types are deprecated and require [updating the corresponding SDK](/dataflux/doc/eqs7v2).

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-refer-table/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed issues with `plugins` configuration not taking effect in SkyWalking (#3368)
- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Optimized Zabbix data import functionality, optimizing bulk update logic and adjusting metric naming while synchronizing some tags read from MySQL to Zabbix data points (#2455)
- Optimized Pipeline processing performance (reduced memory consumption by over 30%), where the `load_json()` function replaced a more efficient library, improving JSON processing performance by about 16% (#2459)
- Optimized file discovery strategy in log collection using inotify for more efficient handling of new files, avoiding delayed collection (#2462)
- Optimized timestamp alignment mechanism for mainstream metrics to improve time series storage efficiency (#2445)

### Compatibility Adjustments {#cl-1.0.0-rc0-brk}

- Environment variables `ENV_LOGGING_FIELD_WHITE_LIST/ENV_LOOGING_MAX_OPEN_FILES` only affect log collection within Kubernetes. Collection configured via *logging.conf* **no longer affected by these ENVs** because this version has already provided corresponding entries for *logging.conf*.
- Removed support for configuring different collection intervals (`interval`) on different instances in KubernetesPrometheus. Global intervals can be set in KubernetesPrometheus collector to achieve this.

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Pythond (alpha)](pythond), facilitating writing custom collectors in Python3 (#367)
<!-- - Added source map file handling for JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

### Documentation Adjustments {#cl-1.0.0-rc0-doc}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entries for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Pythond (alpha)](pythond), facilitating writing custom collectors in Python3 (#367)
<!-- - Added source map file handling for JavaScript call stack collection in RUM collector (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit preliminarily supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420)
- DataKit supports reporting election status (#427)
- DataKit supports reporting Scheck status (#428)
- Adjusted DataKit introductory documentation for better categorization and easier navigation

### Documentation Adjustments {#cl-1.0.0-rc0-doc}

- Almost every chapter added jump labels for permanent references
- Pythond documentation moved to developer directory
- Collector documentation relocated from "Integration" to "DataKit" repository (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

- Reduced directory levels in DataKit documentation structure

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entries for almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted header display in documentation, adding election icons for collectors supporting elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, selecting the first element's `abc` field was done as:

```
[0].abc
```

In the current version, it should be:

```
.[0].abc
```

---

## v1.0.0-rc0 (2021/02/20) {#cl-1.0.0-rc0}

### New Features {#cl-1.0.0-rc0-new}

- Added [Chrony collector](chrony) (#1671)
- Added headless support for RUM (#1644)
- Pipeline added [offload functionality](../pipeline/use-pipeline/pipeline-offload/) (#1634)
- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64) (#637)
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete example](kubernetes-crd.md#example)

### Bug Fixes {#cl-1.0.0-rc0-fix}

- Fixed position record issues in log collection introduced since version 1.27, **recommended upgrade** (#2301)
- Fixed missing `agentid` field in Pinpoint spans (#1897)
- Fixed incorrect handling of `goroutine group` errors in collectors (#1893)
- Fixed empty data reporting issues in MongoDB collector (#1884)
- Fixed numerous 408 and 500 status codes in RUM requests (#1915)

### Functionality Improvements {#cl-1.0.0-rc0-opt}

- Enhanced exit logic for `logfwd` to prevent program exits affecting business Pods due to configuration errors (#1922)
- Enhanced [ElasticSearch](elasticsearch) collector with additional metrics set `elasticsearch_indices_stats`, covering shards and replicas (#1921)
- Added integration tests for [disk](disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector added slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Enhanced authorization detection in MongoDB collector integration tests (#1885)
- Enhanced retry functionality for Dataway sending with configurable parameters

### Breaking Changes {#cl-1.0.0-rc0-brk}

Handling JSON data with top-level arrays now requires indexed selection. For example, given the JSON:

```json
[
