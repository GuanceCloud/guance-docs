# Changelog

## 1.66.1 (2025/01/10) {#cl-1.66.1}

This release is a hotfix and includes some minor feature additions. Changes are as follows:

### Issue Fixes {#cl-1.66.1-fix}

- Fixed timestamp precision issues in the promv2 collector (#2540)
- Resolved conflicts between the PostgreSQL index tag and DQL keywords (#2537)
- Addressed missing `service_instance` field in SkyWalking collection (#2542)
- Removed unnecessary configuration fields in OpenTelemetry and fixed missing units (`unit`) tags for certain metrics (#2541)

---

## 1.66.0 (2025/01/08) {#cl-1.66.0}

This release introduces new features and updates, mainly including:

### New Features {#cl-1.66.0-new}

- Added KV mechanism support for updating collection configurations via pull (#2449)
- Enhanced storage type support in task distribution to include AWS/Huawei Cloud storage (#2475)
- Introduced [NFS Collector](../integrations/nfs.md) (#2499)
- Expanded test data support for more HTTP `Content-Type` in Pipeline debugging interface (#2526)
- APM Automatic Instrumentation added Docker container support (#2480)

### Issue Fixes {#cl-1.66.0-fix}

- Fixed inability of the OpenTelemetry collector to connect with micrometer data (#2495)

### Function Optimization {#cl-1.66.0-opt}

- Optimized disk metric collection and object handling (#2523)
- Improved Redis slow log collection by adding client information to slow logs. Additionally, selective support was added for low-version Redis (e.g., Codis) (#2525)
- Adjusted error retry mechanisms in KubernetesPrometheus collector during metric collection to prevent temporary offline services from being excluded (#2530)
- Optimized default configuration for PostgreSQL collector (#2532)
- Added metric name trimming configuration entry for Prometheus metrics collected by KubernetesPrometheus (#2533)
- Enabled active extraction of the `pod_namespace` tag in DDTrace/OpenTelemetry collectors (#2534)
- Enhanced scan mechanism for log collection, enforcing a mandatory 1-minute scan interval to avoid log file omissions under extreme conditions (#2536)

---

## 1.65.2 (2024/12/31) {#cl-1.65.2}

This release is a hotfix and includes some minor feature additions. Changes are as follows:

### New Features {#cl-1.65.2-new}

- Default splitting of sub-service names `service` in OpenTelemetry collection (#2522)
- Added `ENV_INPUT_OTEL_COMPATIBLE_DDTRACE` configuration entry for OpenTelemetry (#!3368)

### Issue Fixes {#cl-1.65.2-fix}

- Prevented Kubernetes auto-discovery of prom collection from forcibly adding `pod_name` and `namespace` fields (#2524)
- Fixed ineffective `plugins` configuration in SkyWalking (#!3368)

---

## 1.65.1 (2024/12/25) {#cl-1.65.1}

This release is a hotfix and includes some minor feature additions. Changes are as follows:

### New Features {#cl-1.65.1-new}

- KubernetesPrometheus:
    - Selector supports glob patterns (#2515)
    - Metrics data default addition of global tags (#2519)
    - Optimized `prometheus.io/path` annotation (#2518)
- Added ARM image support for DCA (#2517)
- Added IP whitelist configuration for `http_request()` function in Pipeline (#2521)

### Issue Fixes {#cl-1.65.1-fix}

- Adjusted Kafka built-in views to fix discrepancies between displayed and actual data (#2468)
- Fixed vSphere collector crash issue (#2510)

---

## 1.65.0 (2024/12/19) {#cl-1.65.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.65.0-new}

- Added label selector support for object collection in Kubernetes (#2492)
- Added `message` field to container objects (#2508)
- Introduced [Log Collection Configuration Guide Document](datakit-logging.md)

### Issue Fixes {#cl-1.65.0-fix}

- Fixed issues preventing entire host objects from reporting due to partial information collection failures (#2478)
- Other bug fixes (#2474)

### Function Optimization {#cl-1.65.0-opt}

- Optimized Zabbix data import functionality, improved bulk update logic, and synchronized tags from MySQL to Zabbix data points (#2455)
- Enhanced Pipeline processing performance (reduced memory consumption by 30%+), where the `load_json()` function saw a 16% performance improvement due to a more efficient library (#2459)
- Optimized file discovery strategy in log collection using inotify for faster new file detection, avoiding delayed collection (#2462)
- Optimized mainstream metric collection timestamp alignment to enhance time series storage efficiency (#2445)

### Compatibility Adjustments {#cl-1.65.0-brk}

- APIs that were previously enabled by default now require manual activation due to API whitelist control (#2479)

---

## 1.64.3 (2024/12/16) {#cl-1.64.3}

This release is a hotfix with the following changes:

- Added an APM Automatic Instrumentation uninstallation entry (#2509)
- Fixed AWS lambda collector unavailability since version 1.62 (#2505)
- Resolved crashes caused by concurrent read/write in Pipeline (#2503)
- Enhanced export of some built-in views (#2489)
- Opened configuration for the maximum number of OID collections in SNMP collector (default max is 1000 in new versions, 64 in old versions), avoiding OID collection issues (#2488)
- Fixed negative network latency values in eBPF collector (#2467)
- Added [Disclaimer](index.md#disclaimer) for DataKit usage
- Other adjustments and documentation updates (#2507/!3347/!3345/#2501)

---

## 1.64.2 (2024/12/09) {#cl-1.64.2}

This release is a hotfix with the following changes:

- Fixed known security issues (#2502)
- Resolved excessive CPU usage due to redundant events in inotify for log collection (#2500)

---

## 1.64.1 (2024/12/05) {#cl-1.64.1}

This release is a hotfix with the following changes:

- Fixed known security issues (#2497)
- Resolved performance issues with the `valid_json()` function in Pipeline (#2494)
- Fixed installation script issues on PowerShell 4 for Windows (#2491)
- Addressed high CPU consumption in log collection in version 1.64.0 (#2498)

---

## 1.64.0 (2024/11/27) {#cl-1.64.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.64.0-new}

- Added lsblk-based disk information collection (#2408)
- Host object collection now includes configuration file content collection, supporting text files up to 4KiB (#2453)
- Added field whitelist mechanism to log collection to reduce network and storage overhead (#2469)
- Restructured existing DCA implementation from HTTP (DataKit as server) to WebSocket (DataKit as client) (#2333)
- Added support for Volcano Cloud (#2472)

### Issue Fixes {#cl-1.64.0-fix}

- Fixed host object collection issues caused by partial information collection failures (#2478)
- Other bug fixes (#2474)

### Function Optimization {#cl-1.64.0-opt}

- Optimized Zabbix data import functionality, improved bulk update logic, and synchronized tags from MySQL to Zabbix data points (#2455)
- Enhanced Pipeline processing performance (reduced memory consumption by 30%+), where the `load_json()` function saw a 16% performance improvement due to a more efficient library (#2459)
- Optimized file discovery strategy in log collection using inotify for faster new file detection, avoiding delayed collection (#2462)
- Optimized mainstream metric collection timestamp alignment to enhance time series storage efficiency (#2445)

### Compatibility Adjustments {#cl-1.64.0-brk}

- Environment variables `ENV_LOGGING_FIELD_WHITE_LIST/ENV_LOOGING_MAX_OPEN_FILES` only affect Kubernetes log collection; standalone configurations via *logging.conf* no longer inherit these settings because this version has set specific entries for *logging.conf*.

---

## 1.63.1 (2024/11/21) {#cl-1.63.1}

This release is a hotfix with the following changes:

- Fixed issues caused by multi-line processing in socket logging collection (#2461)
- Restored the ability to expose Prometheus Exporter collection via Pod Annotation marking which was removed in version 1.63.0 (#2471)

    This feature was removed in version 1.63.0, but many existing services already collect Prometheus metrics in this manner and cannot be migrated to KubernetesPrometheus format temporarily.

---

## 1.63.0 (2024/11/13) {#cl-1.63.0}

This release is an iterative update with the following changes:

### New Features {#cl-1.63.0-new}

- Added support for [remote job dispatching in Datakit](datakit-conf.md#remote-job) (requires manual start, and Guance needs to be upgraded to version 1.98.181 or higher), currently supporting fetching JVM Dump by issuing commands to Datakit from the frontend page (#2367)

    When executing in Kubernetes, the latest *datakit.yaml* must be updated with additional RBAC permissions.

- Added [string extraction functions in Pipeline](../pipeline/use-pipeline/pipeline-built-in-function.md#fn_slice_string) (#2436)

### Issue Fixes {#cl-1.63.0-fix}

- Resolved potential startup issues in Datakit due to WAL being enabled by default as a data transmission cache queue without proper process mutual exclusion handling during initialization (#2457)
- Fixed resetting of already configured settings in *datakit.conf* during installation (#2454)

### Function Optimization {#cl-1.63.0-opt}

- Added data sampling rate configuration to eBPF collector to reduce data volume (#2394)  
- Added SSL support to KafkaMQ collector (#2421)
- Graphite data can specify measurement sets (#2448)
- Adjusted Service Monitor collection granularity in CRD from Pod level to [Endpoint](https://kubernetes.io/docs/concepts/services-networking/service/#endpoints){:target="_blank"}

### Compatibility Adjustments {#cl-1.63.0-brk}

- Removed experimental Kubernetes Self metrics feature, which can now be achieved through KubernetesPrometheus (#2405)
- Removed Discovery support for Datakit CRD in container collectors
- Moved Discovery Prometheus functionality of container collectors to KubernetesPrometheus collector while maintaining relative compatibility
- No longer supports the `PodTargetLabel` configuration field for Prometheus ServiceMonitor

---

## 1.62.2 (2024/11/09) {#cl-1.62.2}

This release is a hotfix with the following changes:

- Fixed data packet loss at the tail end during data upload (#2453)

---

## 1.62.1 (2024/11/07) {#cl-1.62.1}

This release is a hotfix with the following changes:

- Fixed truncation issues caused by incorrect `message` setting in log collection

---

## 1.62.0 (2024/11/06) {#cl-1.62.0}

This release is an iterative update with the following changes:

### New Features {#cl-1.62.0-new}

- Increased buffer size for log collection to 64KB, optimizing the performance of constructing data points (#2450)
- Added a limit on the maximum number of log files collected, defaulting to a maximum of 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Supported configuring default Pipeline scripts in *datakit.conf* (#2355)
- Added HTTP Proxy support for dial testing tasks pulled from the center (#2438)
- Allowed modification of main configurations during Datakit upgrades via command-line environment variables (#2418)
- Introduced prom v2 collector, offering significant parsing performance improvements over v1 (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, setting specific switches allows restarting corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports联动中心配置的黑名单规则（#2424）
- The Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) now supports multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Issue Fixes {#cl-1.62.0-fix}

- Resolved data conversion issues during SQLServer collection (#2429)
- Fixed potential crashes in HTTP service due to timeout components (#2423)
- Corrected time unit issues in New Relic collection (#2417)
- Fixed potential crashes in the Pipeline `point_window()` function (#2416)
- Addressed protocol recognition issues in eBPF collection (#2451)

### Function Optimization {#cl-1.62.0-opt}

- Adjusted timestamps in data collected by KubernetesPrometheus based on collection intervals (#2441)
- Supported setting `from-beginning` attributes in Annotations/Labels for container log collection (#2443)
- Optimized data point upload strategy to ignore overly large data points, preventing entire data packets from failing to send (#2440)
- Enhanced zlib format encoding support for Datakit API /v1/write/:category (#2439)
- Reduced memory usage in DDTrace data point processing (#2434)
- Lowered resource consumption in eBPF collection (#2430)
- Improved GZip efficiency during uploads (#2428)
- Numerous performance optimizations were made in this version (#2414)
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default-enabled [HTTP API rate limiting](datakit-conf.md#set-http-api-limit) to prevent excessive memory consumption from sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle memory consumption caused by blocked uploads. The new disk queue will cache failed upload data by default.
    - Detailed Datakit's internal memory usage metrics, adding multiple dimensions of memory consumption
    - Added a WAL panel display in the `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Enhanced container log collection performance (#2425)
    - Removed log debugging-related fields to optimize network traffic and storage
- Other optimizations
    - Changed the image pull policy in *datakit.yaml* to `IfNotPresent` (!3264)
    - Optimized Profiling-generated metrics documentation (!3224)
    - Updated Kafka views and monitors (!3248)
    - Updated Redis views and monitors (!3263)
    - Added Ligai version notifications (!3247)
    - Added SQLServer built-in views (!3272)

### Compatibility Adjustments {#cl-1.62.0-brk}

- Removed the previous feature of configuring different instances with varying collection intervals (`interval`). Global intervals can now be set in the KubernetesPrometheus collector.

<!--


NOTE: The following content has been merged into the 1.62.0 version release

## 1.61.0 (2024/11/02) {#cl-1.61.0}

This release is an iterative update with the following changes:

### New Features {#cl-1.61.0-new}

- Added a limit on the maximum number of log files collected, defaulting to a maximum of 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Supported configuring default Pipeline scripts in *datakit.conf* (#2355)
- Added HTTP Proxy support for dial testing tasks pulled from the center (#2438)
- Allowed modification of main configurations during Datakit upgrades via command-line environment variables (#2418)

### Issue Fixes {#cl-1.61.0-fix}

- Adjusted the default directory for the data sending disk queue (WAL). In version 1.60.0, when installing on Kubernetes, the directory was incorrectly set to *data*, which does not mount the host machine's disk by default. This would lead to data loss upon Pod restarts (#2444)

```yaml
        - mountPath: /usr/local/datakit/cache # Should set the directory to cache
          name: cache
          readOnly: false
      ...
      - hostPath:
          path: /root/datakit_cache # Mount WAL disk storage on the host machine
        name: cache
```

- Resolved data conversion issues during SQLServer collection (#2429)
- Fixed several known issues in version 1.60.0 (#2437):
    - Resolved the issue of the upgrade program not enabling the point-pool feature by default
    - Fixed the issue of double gzip compression during failed retransmission, leading to discarded data. This only occurred when data was sent unsuccessfully for the first time.
    - Handled potential memory leaks during data encoding

### Function Optimization {#cl-1.61.0-opt}

- Adjusted timestamps in data collected by KubernetesPrometheus based on collection intervals (#2441)
- Supported setting `from-beginning` attributes in Annotations/Labels for container log collection (#2443)
- Optimized data point upload strategy to ignore overly large data points, preventing entire data packets from failing to send (#2440)
- Enhanced zlib format encoding support for Datakit API `/v1/write/:category` (#2439)
- Reduced memory usage in DDTrace data point processing (#2434)
- Allocated approximately 10MiB cache dynamically for each current collected log file to handle burst log volumes and prevent data loss (#2432)
- Optimized resource consumption during eBPF collection (#2430)
- Improved GZip efficiency during uploads (#2428)
- This version included numerous performance optimizations (#2414)
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default-enabled [HTTP API rate limiting](datakit-conf.md#set-http-api-limit) to prevent excessive memory consumption from sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle memory consumption caused by blocked uploads. The new disk queue will cache failed upload data by default.
    - Detailed Datakit's internal memory usage metrics, adding multiple dimensions of memory consumption
    - Added a WAL panel display in the `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Enhanced container log collection performance (#2425)
    - Removed log debugging-related fields to optimize network traffic and storage
- Other optimizations
    - Changed the image pull policy in *datakit.yaml* to `IfNotPresent` (!3264)
    - Optimized Profiling-generated metrics documentation (!3224)
    - Updated Kafka views and monitors (!3248)
    - Updated Redis views and monitors (!3263)
    - Added Ligai version notifications (!3247)
    - Added SQLServer built-in views (!3272)

### Compatibility Adjustments {#cl-1.61.0-brk}

- Removed the previous feature of configuring different instances with varying collection intervals (`interval`). Global intervals can now be set in the KubernetesPrometheus collector.

---

## 1.60.0 (2024/10/18) {#cl-1.60.0}

This release is an iterative update with the following changes:

### New Features {#cl-1.60.0-new}

- Introduced prom v2 collector, offering significant parsing performance improvements over v1 (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, setting specific switches allows restarting corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports interaction with central blacklist rules (#2424)
- The Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) now supports multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Issue Fixes {#cl-1.60.0-fix}

- Fixed potential crashes in HTTP service due to timeout components (#2423)
- Resolved time unit issues in New Relic collection (#2417)
- Fixed potential crashes in the Pipeline `point_window()` function (#2416)

### Function Optimization {#cl-1.60.0-opt}

- Numerous performance optimizations were made in this version (#2414)

    - Experimentally enabled point-pool by default
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default-enabled [HTTP API rate limiting](datakit-conf.md#set-http-api-limit) to prevent excessive memory consumption from sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle memory consumption caused by blocked uploads. The new disk queue will cache failed upload data by default.
    - Detailed Datakit's internal memory usage metrics, adding multiple dimensions of memory consumption
    - Added a WAL panel display in the `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Enhanced container log collection performance (#2425)
    - Removed log debugging-related fields to optimize network traffic and storage
- Other optimizations
    - Changed the image pull policy in *datakit.yaml* to `IfNotPresent` (!3264)
    - Optimized Profiling-generated metrics documentation (!3224)
    - Updated Kafka views and monitors (!3248)
    - Updated Redis views and monitors (!3263)
    - Added Ligai version notifications (!3247)
    - Added SQLServer built-in views (!3272)

### Compatibility Adjustments {#cl-1.60.0-brk}

- Due to some performance adjustments, there are compatibility differences in certain parts:

    - Maximum size of a single HTTP body upload adjusted to 1MB. Simultaneously, the maximum size of a single log reduced to 1MB. This adjustment aims to reduce pool memory usage under low load conditions.
    - Deprecated the previous failed retransmission disk queue (not enabled by default). The new version defaults to enabling a new failed retransmission disk queue.

---

## 1.39.0 (2024/09/25) {#cl-1.39.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.39.0-new}

- Introduced vSphere collector (#2322)
- Profiling collection now supports extracting basic metrics from Profile files (#2335)

### Issue Fixes {#cl-1.39.0-fix}

- Fixed unnecessary collection during KubernetesPrometheus startup (#2412)
- Resolved potential crashes in Redis collector (#2411)
- Fixed RabbitMQ crashes (#2410)
- Corrected the `up` metric not accurately reflecting collector runtime status (#2409)

### Function Optimization {#cl-1.39.0-opt}

- Enhanced Redis big-key collection compatibility (#2404) - Dial testing collector now supports custom tag field extraction (#2402)
- Other documentation optimizations (#2401)

---

## 1.38.2 (2024/09/19) {#cl-1.38.2}

This release is a Hotfix addressing the following issues:

- Fixed incorrect addition of global-tags in Nginx collection (#2406)
- Resolved CPU core collection errors on Windows for host object collector (#2398)
- Added synchronization with Dataway for Chrony collection to avoid data bias due to Datakit local time deviation (#2351)
    - This feature depends on Dataway version 1.6.0 or higher
- Resolved potential crashes in Datakit HTTP API due to timeouts (#2091)

---

## 1.38.1 (2024/09/11) {#cl-1.38.1}

This release is a Hotfix addressing the following issues:

- Fixed tag errors for `inside_filepath` and `host_filepath` in container log collection (#2403)
- Resolved special case anomalies in Kubernetes-Prometheus collector (#2396)
- Fixed numerous issues in the upgrade program (2372):
    - Offline installation directory errors
    - Configuration of `dk_upgrader` can now synchronize with Datakit configuration (no need for manual configuration), DCA no longer needs to consider whether it's an offline or online upgrade.
    - Additional ENV can be injected for `dk_upgrader` configuration (no need for extra manual configuration)
    - HTTP API of `dk_upgrader` added new parameters allowing version specification and forced upgrades (temporarily unsupported on DCA side)

---

## 1.38.0 (2024/09/04) {#cl-1.38.0}

This release is an iterative update with the following changes:

### New Features {#cl-1.38.0-new}

- Added Graphite data ingestion (#2337)
<!-- - Profiling collection supports real-time metric extraction from profiling files (#2335) -->

### Issue Fixes {#cl-1.38.0-fix}

- Fixed abnormal network data aggregation in eBPF (#2395)
- Resolved crashes in DDTrace telemetry interface (#2387)
- Fixed Jaeger UDP binary format data collection issues (#2375)
- Corrected address format issues in dial testing collector (#2374)

### Function Optimization {#cl-1.38.0-opt}

- Added multiple fields (`num_cpu/unicast_ip/disk_total/arch`) to host objects (#2362)
- Supported custom tag and node English name configuration in dial testing collector (#2365)

### Compatibility Adjustments {#cl-1.38.0-brk}

- Adjusted Pipeline execution priority (#2386)

    In previous versions, for a specific `source`, such as `nginx`:

    1. If users specified matching *nginx.p* on the Guance page,
    1. If users also set a default Pipeline (*default.p*)

    Then Nginx logs would not be parsed using *nginx.p* but instead use *default.p*. This setting was unreasonable. After adjustment, the priorities are as follows (decreasing order):

    1. Pipeline specified for `source` on the Guance page
    1. Pipeline specified for `source` in the collector
    1. Pipeline found for `source` value (e.g., logs from `source` `my-app` would match *my-app.p*)
    1. Finally, using *default.p*

    This ensures all data can be processed by the Pipeline, with at least *default.p* as a fallback.

---

## 1.37.0 (2024/08/28) {#cl-1.37.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.37.0-new}

- Added [Zabbix data import support](../integrations/zabbix_exporter.md)(#2340)

### Function Optimization {#cl-1.37.0-opt}

- Optimized process collector to default support open fd count collection (#2384)
- Supplemented RabbitMQ tags (#2380)
- Enhanced Kubernetes-Prometheus collector performance (#2373)
- Added more Redis metrics (#2358)

---

## 1.36.0 (2024/08/21) {#cl-1.36.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.36.0-new}

- Added Pipeline functions `pt_kvs_set`, `pt_kvs_get`, `pt_kvs_del`, `pt_kvs_keys`, and `hash` (#2353)
- Dial testing collector supports custom tags and node English names (#2365)

### Issue Fixes {#cl-1.36.0-fix}

- Resolved memory leak issues in eBPF collector (#2352)
- Fixed duplicate collection of Kubernetes Events due to receiving Deleted data (#2363)
- Resolved target label issues in KubernetesPrometheus collector for Service/Endpoints (#2349)
    - Note: *datakit.yaml* needs to be updated

### Function Optimization {#cl-1.36.0-opt}

- Optimized slow query time filtering conditions in Oracle collector (#2360)
- Optimized method of collecting `postgresql_size` in PostgreSQL collector (#2350)
- Enhanced return information for dial testing debug interfaces (#2347)
- Supported any custom log levels in the `status` field of log data in Pipeline (#2371)
- Added client/server IP and port fields and connection-side related fields in BPF network logs (#2357)
- Supported multiline configuration for TCP Socket log collection (#2364)
- When deploying in Kubernetes, if there are same-name Nodes, prefixes/suffixes can be added to distinguish `host` field values (#2361)
- Modified collector data reporting to default block globally to alleviate (note: can only alleviate, **cannot prevent**) loss of time series data due to queue blocking (#2370)
    - Adjusted monitor information display: 1) Displayed collector data reporting blocking duration (P90); 2) Displayed each collector's single collection point count (P90) to better illustrate specific collector collection volume.

---

## 1.35.0 (2024/08/07) {#cl-1.35.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.35.0-new}

- Added [election whitelist](election.md#election-whitelist) functionality to facilitate specific host Datakit participation in elections (#2261)

### Issue Fixes {#cl-1.35.0-fix}

- Fixed association of container ID in CentOS process collector (#2338)
- Resolved multiline judgment failure in log collection (#2336)
- Fixed length issues in Jaeger Trace-ID (#2329)
- Other bug fixes (#2343)

### Function Optimization {#cl-1.35.0-opt}

- Automatically added custom tags to `up` metric set (#2334)
- Supported specifying meta address for cloud information synchronization in host object collection (#2331)
- Collected basic information of traced services in DDTrace collector and reported them to resource objects (`CO::`), with object type `tracing_service` (#2307)
- Added `node_name` field in dial testing collected data (#2324)
- Added placeholder labels `__kubernetes_mate_instance` and `__kubernetes_mate_host` in KubernetesPrometheus metric collection, optimizing tag addition strategies (#2341) [^2341]
- Optimized TLS configuration for multiple collectors (#2225/#2204/#2192/#2342)
- Added PostgreSQL and AMQP protocol recognition in eBPF link plugin (#2315/#2311)

[^2341]: If a service restarts, the corresponding `instance` and `host` may change entirely, doubling the timeline.

---

## 1.34.0 (2024/07/24) {#cl-1.34.0}

This release is an iterative update with the following changes:

### New Features {#cl-1.34.0-new}

- Added custom object collection support for mainstream collectors like Oracle/MySQL/Apache (#2207)
- Added `up` metrics to remote collectors (#2304)
- Statsd collector now exposes its own metrics (#2326)
- Introduced [CockroachDB collector](../integrations/cockroachdb.md) (#2187)
- Introduced [AWS Lambda collector](../integrations/awslambda.md) (#2258)
- Introduced [Kubernetes Prometheus collector](../integrations/kubernetesprometheus.md) to achieve automatic Prometheus discovery (#2246)

### Issue Fixes {#cl-1.34.0-fix}

- Fixed excessive memory usage in certain Windows versions for bug reports and self-collectors, temporarily removing some metric exposures to bypass (#2317)
- Resolved non-display of collectors originating from Confd in `datakit monitor` (#2160)
- Fixed the issue where container logs manually specified as stdout via Annotations would not be collected (#2327)
- Resolved K8s label anomalies in eBPF network log collection (#2325)
- Fixed concurrent read/write errors in RUM collector (#2319)

### Function Optimization {#cl-1.34.0-opt}

- Optimized OceanBase view templates and added `cluster` Tag to `oceanbase_log` (#2265)
- Optimized excessive task failure exits in dial testing collector (#2314)
- Added script execution information to Pipeline data and supported body parameters in `http_request` function (#2313/#2298)
- Optimized memory usage in eBPF collector (#2328)
- Other documentation optimizations (#2320)

---

## 1.33.1 (2024/07/11) {#cl-1.33.1}

This release is a Hotfix addressing the following issues:

- Fixed invalid trace sampling issues introduced since version 1.26. Suggested upgrade. Added `dk_sampling_rate` field on root-span to indicate sampled traces. **Recommended Upgrade** (#2312)
- Fixed IP handling bugs in SNMP collection and exposed a batch of new SNMP collection metrics (#3099)

---

## 1.33.0 (2024/07/10) {#cl-1.33.0}
This release is an iterative update with the following changes:

### New Features {#cl-1.33.0-new}

- Added [OpenTelemetry log collection](../integrations/opentelemetry.md#logging) (#2292)
- Restructured [SNMP collector](../integrations/snmp.md), adding Zabbix/Prometheus configuration support and corresponding built-in views (#2290)

### Issue Fixes {#cl-1.33.0-fix}

- Fixed response time (`response_time`) not including download time (`response_download`) in HTTP dial testing (#2293)
- Resolved IPv6 identification issues in HTTP dial testing
- Fixed crashes and max-cursor issues in Oracle collector (#2297)
- Resolved position record issues in log collection introduced since version 1.27. Suggested upgrade. (#2301)
- Fixed some customer-tags not taking effect in DDTrace/OpenTelemetry HTTP API data reception (#2308)

### Function Optimization {#cl-1.33.0-opt}

- Added 4.x version support for Redis big-key collection (#2296)
- Optimized internal worker counts based on actual CPU core limits, significantly reducing buffer memory overhead. **Suggested Upgrade** (#2275)
- Defaulted Datakit API to blocking mode when receiving time series data to prevent data point losses (#2300)
- Enhanced performance of the `grok()` function in Pipeline (#2310)
- Added eBPF-related information and Pipeline information to [bug report](why-no-data.md#bug-report) (#2289)
- Supported TLS certificate path configuration for k8s auto-discovery ServiceMonitor (#1866)
- Added `container_id` field to [host process collector](../integrations/host_processes.md) objects and metrics data collection (#2283)
- Added Datakit fingerprint field (`datakit_fingerprint`, value is Datakit's hostname) to trace data collection for easier problem tracing. Also, added exposure of some metrics during collection (#2295