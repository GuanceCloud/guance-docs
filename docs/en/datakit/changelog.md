# Release Notes

## 1.65.2 (2024/12/31) {#cl-1.65.2}

This release is a hotfix repair, with some additional detailed features. The content is as follows:

### New Features {#cl-1.65.2-new}

- When collecting using OpenTelemetry, the sub-service name `service` is split by default (#2522)
- Added `ENV_INPUT_OTEL_COMPATIBLE_DDTRACE` configuration entry for OpenTelemetry (!3368)

### Bug Fixes {#cl-1.65.2-fix}

- In automatic discovery in Kubernetes for prom collection, fields `pod_name` and `namespace` are no longer forcibly added (#2524)
- Fixed an issue where configurations of `plugins` in SkyWalking were not taking effect (!3368)

---

## 1.65.1 (2024/12/25) {#cl-1.65.1}

This release is a hotfix repair, with some additional detailed features. The content is as follows:

### New Features {#cl-1.65.1-new}

- KubernetesPrometheus:
    - Selector supports glob matching (#2515)
    - Collected metrics data now appends global tags by default (#2519)
    - Optimized `prometheus.io/path` annotation (#2518)
- DCA added ARM image support (#2517)
- Pipeline function `http_request()` added IP whitelist configuration (#2521)

### Bug Fixes {#cl-1.65.1-fix}

- Adjusted Kafka built-in views, fixed issues where displayed data did not match actual data (#2468)
- Fixed vSphere collector crash issue (#2510)

---

## 1.65.0 (2024/12/19) {#cl-1.65.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.65.0-new}

- Object collection in Kubernetes added label selector support (#2492)
- Container objects added `message` field (#2508)
- Added [Log Collection Configuration Guide Document](datakit-logging.md)

### Bug Fixes {#cl-1.65.0-fix}

- Fixed an issue where environment variable `ENV_PIPELINE_DEFAULT_PIPELINE` was ineffective since version 1.64.2 (!3354)
- Fixed OceanBase slow log truncation issue (#2513)
- Fixed an issue where the last log line could not be collected since version 1.62.0 (!3352)

### Functional Optimization {#cl-1.65.0-opt}

- Metrics collected by KubernetesPrometheus support additional global-tag configuration (#2504)
- Log collector (*logging.conf*) now supports configuring the collection of over 500 files, versions after 1.62.0 do not support this configuration (#2516)
- Log collector (*logging.conf*) now supports configuring log whitelist fields, which previously only worked in Kubernetes (!3352)

### Compatibility Adjustments {#cl-1.65.0-brk}

- Environment variables `ENV_LOGGING_FIELD_WHITE_LIST/ENV_LOOGING_MAX_OPEN_FILES` only affect log collection in Kubernetes; configurations via *logging.conf* alone **are no longer influenced by these ENVs**, as this version has set corresponding entries for *logging.conf*.

---

## 1.64.3 (2024/12/16) {#cl-1.64.3}

This release is a hotfix repair, with the following content:

- Added APM Automatic Instrumentation uninstall entry (#2509)
- Fixed an issue where AWS lambda collector was unavailable since version 1.62 (#2505)
- Fixed crashes caused by concurrent read/write in Pipeline (#2503)
- Improved export of some built-in views (#2489)
- SNMP collector opened maximum OID collection number configuration (new versions default to a maximum of 1000, old versions only had 64), avoiding OID collection (#2488)
- Fixed negative network latency values in eBPF collector (#2467)
- Added [disclaimer](index.md#disclaimer) during Datakit usage
- Other adjustments and documentation updates (#2507/!3347/!3345/#2501)

---

## 1.64.2 (2024/12/09) {#cl-1.64.2}

This release is a hotfix repair, with the following content:

- Fixed some known security issues (#2502)
- Fixed excessive events listened by inotify, which led to unnecessary CPU usage in log collection (#2500)

---

## 1.64.1 (2024/12/05) {#cl-1.64.1}

This release is a hotfix repair, with the following content:

- Fixed some known security issues (#2497)
- Pipeline fixed `valid_json()` performance issue (#2494)
- Fixed Windows installation script issues on PowerShell 4 version (#2491)
- Fixed high CPU consumption in log collection in version 1.64.0 (#2498)

---

## 1.64.0 (2024/11/27) {#cl-1.64.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.64.0-new}

- Added disk information collection based on lsblk (#2408)
- Host object collection added configuration file information collection, supporting the collection of text file contents up to 4KiB in size (#2453)
- Log collection added a field whitelist mechanism, allowing selection of only interested fields to reduce network and storage costs (#2469)
- Refactored existing DCA implementation, changing HTTP (Datakit as server) to Websocket (Datakit as client) (#2333)
- Host objects added Volcengine support (#2472)

### Bug Fixes {#cl-1.64.0-fix}

- Fixed an issue where host object collection failed due to errors in partial information collection, preventing the entire host object from being reported (#2478)
- Other bug fixes (#2474)

### Functional Optimization {#cl-1.64.0-opt}

- Optimized Zabbix data import feature, optimized full update logic, and adjusted metric naming while syncing some tags read from MySQL to Zabbix data points (#2455)
- Optimized Pipeline processing performance (memory consumption reduced by 30%+); replacing a more efficient library in `load_json()` improved JSON handling by about 16% (#2459)
- Optimized file discovery strategy in log collection, adding inotify for more efficient new file detection to avoid delayed collection (#2462)
- Optimized mainstream metrics collection timestamp alignment mechanism to improve time series storage efficiency (#2445)

### Compatibility Adjustments {#cl-1.64.0-brk}

With the addition of API whitelist control, some default APIs in older versions will no longer work and need to be manually enabled (#2479)

---

## 1.63.1 (2024/11/21) {#cl-1.63.1}

This release is a hotfix repair, with the following content:

- Fixed issues with multi-line processing in socket logging collection (#2461)
- Fixed an issue where Datakit OOM would not restart on Windows (#2465)
- Fixed Oracle metrics missing issue (#2464)
- Fixed offline installation issue for APM Automatic Instrumentation (#2466)
- Restored the functionality of exposing Prometheus Exporter through Annotation marking for Pods (#2471)

    This feature was removed in version 1.63.0, but many existing services' Prometheus metrics were already collected this way, making it temporarily impossible to migrate to KubernetesPrometheus form.

---

## 1.63.0 (2024/11/13) {#cl-1.63.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.63.0-new}

- Added [remote job support for Datakit](datakit-conf.md#remote-job) (currently this feature requires manual activation, and Guance needs to be upgraded to version 1.98.181 or higher), currently supports issuing instructions to Datakit via the front-end page to obtain JVM Dump (#2367)

    When executing in Kubernetes, the latest *datakit.yaml* needs to be updated, requiring additional RBAC permissions here.

- Pipeline added [string extraction function](../pipeline/use-pipeline/pipeline-built-in-function.md#fn_slice_string) (#2436)

### Bug Fixes {#cl-1.63.0-fix}

- Fixed an issue where Datakit might fail to start due to WAL being enabled by default as the cache queue for data transmission, without proper process mutual exclusion during WAL initialization (#2457)
- Fixed installation program resetting some configurations already set in *datakit.conf* (#2454)

### Functional Optimization {#cl-1.63.0-opt}

- eBPF collector added data sampling rate configuration to reduce its data volume (#2394)
- KafkaMQ collector added SSL support (#2421)
- Graphite incoming data supports specifying measurement sets (#2448)
- Adjusted CRD Service Monitor collection granularity, finest granularity changed from Pod to [Endpoint](https://kubernetes.io/docs/concepts/services-networking/service/#endpoints){:target="_blank"}

### Compatibility Adjustments {#cl-1.63.0-brk}

- Removed experimental Kubernetes Self metrics feature, functionality can be achieved via KubernetesPrometheus (#2405)
- Removed container collector Discovery support for Datakit CRD
- Moved container collector's Discovery Prometheus function to KubernetesPrometheus collector, maintaining relative compatibility
- No longer supports Prometheus ServiceMonitor PodTargetLabel configuration field

---

## 1.62.2 (2024/11/09) {#cl-1.62.2}

This release is a hotfix repair, with the following content:

- Fixed an issue where tail data packets might be lost during data upload (#2453)

---

## 1.62.1 (2024/11/07) {#cl-1.62.1}

This release is a hotfix repair, with the following content:

- Fixed an issue where incorrect `message` setting in log collection caused truncation

---

## 1.62.0 (2024/11/06) {#cl-1.62.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.62.0-new}

- Adjusted log collection buffer to 64KB, optimizing performance in building data points for log collection (#2450)
- Added maximum log collection limit, defaulting to a maximum of 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Supports configuring default Pipeline scripts in *datakit.conf* (#2355)
- Synthetic Tests collector supports HTTP Proxy when pulling central synthetic test tasks (#2438)
- During Datakit upgrade, similar to installation, command-line environment variables can modify its main configuration (#2418)
- Added prom v2 collector, significantly improving parsing performance compared to v1 (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, setting specific switches allows restarting corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) added support for multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.62.0-fix}

- Fixed data conversion issues in SQLServer collection (#2429)
- Fixed potential crashes in HTTP service due to timeout components (#2423)
- Fixed time unit issues in New Relic collection (#2417)
- Fixed potential crashes in Pipeline `point_window()` function (#2416)
- Fixed protocol recognition issues in eBPF collection (#2451)

### Functional Optimization {#cl-1.62.0-opt}

- Data collected by KubernetesPrometheus adjusts timestamps according to the collection interval (#2441)
- Container log collection supports setting `from-beginning` attribute in Annotations/Labels (#2443)
- Optimized data point upload strategy, ignoring excessively large data points to prevent sending failure (#2440)
- Datakit API /v1/write/:category improved zlib format encoding support (#2439)
- Optimized DDTrace data point processing strategy, reducing memory usage (#2434)
- Optimized resource usage during eBPF collection (#2430)
- Optimized GZip efficiency during upload (#2428)
- Numerous performance optimizations in this version (#2414)
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default enabling of [HTTP API throttling](datakit-conf.md#set-http-api-limit) to avoid excessive memory usage due to sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle possible memory usage caused by upload blockage. The new disk queue *defaults to caching failed uploads*.
    - Detailed Datakit internal memory usage metrics, adding multiple dimensions of memory usage to the metrics
    - Added WAL panel display in `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Optimized container log collection performance (#2425)
    - Removed log debugging related fields to optimize network traffic and storage
- Other optimizations
    - Optimized *datakit.yaml*, image pull policy changed to `IfNotPresent` (!3264)
    - Optimized profiling-generated metrics documentation (!3224)
    - Updated Kafka views and monitors (!3248)
    - Updated Redis views and monitors (!3263)
    - Added Ligai version notifications (!3247)
    - Added SQLServer built-in views (!3272)

### Compatibility Adjustments {#cl-1.62.0-brk}

- Previous versions supported configuring collection intervals (`interval`) on different instances in KubernetesPrometheus. This feature has been removed in the current version. Global intervals can be set in the KubernetesPrometheus collector to achieve this.

<!--


NOTE: The following content has been merged into version 1.62.0 release

## 1.61.0 (2024/11/02) {#cl-1.61.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.61.0-new}

- Added maximum log collection limit, defaulting to a maximum of 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Supports configuring default Pipeline scripts in *datakit.conf* (#2355)
- Synthetic Tests collector supports HTTP Proxy when pulling central synthetic test tasks (#2438)
- During Datakit upgrade, similar to installation, command-line environment variables can modify its main configuration (#2418)

### Bug Fixes {#cl-1.61.0-fix}

- Adjusted the default directory for the data send disk queue (WAL). In version 1.60.0, during Kubernetes installation, this directory was incorrectly set under the *data* directory, which is not mounted to the host machine's disk by default, causing data loss upon Pod restart (#2444)

```yaml
        - mountPath: /usr/local/datakit/cache # Directory should be set under the cache directory
          name: cache
          readOnly: false
      ...
      - hostPath:
          path: /root/datakit_cache # WAL disk storage mounted under this directory on the host
        name: cache
```

- Fixed data conversion issues in SQLServer collection (#2429)
- Fixed several known issues in version 1.60.0 (#2437):
    - Fixed default point-pool functionality not being enabled in the upgrade program
    - Fixed double gzip issue on failed retransmitted data, which caused the center to fail parsing these data and discard them. This issue only triggers when data fails to send the first time
    - Potential memory leaks may occur during data encoding at certain boundary conditions

### Functional Optimization {#cl-1.61.0-opt}

- Data collected by KubernetesPrometheus adjusts timestamps according to the collection interval (#2441)
- Container log collection supports setting `from-beginning` attribute in Annotations/Labels (#2443)
- Optimized data point upload strategy, ignoring excessively large data points to prevent sending failure (#2440)
- Datakit API `/v1/write/:category` improved zlib format encoding support (#2439)
- Optimized DDTrace data point processing strategy, reducing memory usage (#2434)
- Added approximately 10MiB cache (dynamically allocated per currently collected file) during log collection to cache bursts of logs and avoid data loss (#2432)
- Optimized resource usage during eBPF collection (#2430)
- Optimized GZip efficiency during upload (#2428)
- Other optimizations
    - Optimized *datakit.yaml*, image pull policy changed to `IfNotPresent` (!3264)
    - Optimized profiling-generated metrics documentation (!3224)
    - Updated Kafka views and monitors (!3248/!3263)
    - Added Ligai version notifications (!3247)

### Compatibility Adjustments {#cl-1.61.0-brk}

- Previous versions supported configuring collection intervals (`interval`) on different instances in KubernetesPrometheus. This feature has been removed in the current version. Global intervals can be set in the KubernetesPrometheus collector to achieve this.

---

## 1.60.0 (2024/10/18) {#cl-1.60.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.60.0-new}

- Added prom v2 collector, significantly improving parsing performance compared to v1 (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, setting specific switches allows restarting corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) added support for multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.60.0-fix}

- Fixed potential crashes in HTTP service due to timeout components (#2423)
- Fixed time unit issues in New Relic collection (#2417)
- Fixed potential crashes in Pipeline `point_window()` function (#2416)

### Functional Optimization {#cl-1.60.0-opt}

- Numerous performance optimizations in this version (#2414)

    - Experimental point-pool functionality enabled by default
    - Optimized Prometheus exporter data collection performance, reducing memory consumption
    - Default enabling of [HTTP API throttling](datakit-conf.md#set-http-api-limit) to avoid excessive memory usage due to sudden traffic
    - Added [WAL disk queue](datakit-conf.md#dataway-wal) to handle possible memory usage caused by upload blockage. The new disk queue *defaults to caching failed uploads*.
    - Detailed Datakit internal memory usage metrics, adding multiple dimensions of memory usage to the metrics
    - Added WAL panel display in `datakit monitor -V` command
    - Optimized KubernetesPrometheus collection performance (#2426)
    - Optimized container log collection performance (#2425)
    - Removed log debugging related fields to optimize network traffic and storage

### Compatibility Adjustments {#cl-1.60.0-brk}

- Due to some performance-related adjustments, there are some compatibility differences in the following parts:

    - Maximum size of a single HTTP body upload adjusted to 1MB. Also, the maximum size of a single log line is reduced to 1MB. This adjustment aims to reduce the pooled memory usage of Datakit under low load
    - Deprecated the original failed retransmission disk queue (this feature was not enabled by default). The new version defaults to enabling a new failed retransmission disk queue

---

-->

## 1.39.0 (2024/09/25) {#cl-1.39.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.39.0-new}

- Added vSphere collector (#2322)
- Profiling collection supports extracting basic metrics from Profile files (#2335)

### Bug Fixes {#cl-1.39.0-fix}

- Fixed unnecessary collection at startup for KubernetesPrometheus (#2412)
- Fixed potential crashes in Redis collector (#2411)
- Fixed RabbitMQ crashes (#2410)
- Fixed issue where the `up` metric did not accurately reflect the status of collectors (#2409)

### Functional Optimization {#cl-1.39.0-opt}

- Enhanced compatibility for Redis big-key collection (#2404) - Synthetic Tests collector supports custom tag field extraction (#2402)
- Other documentation optimizations (#2401)

---

## 1.38.2 (2024/09/19) {#cl-1.38.2}

This release is a Hotfix release, fixing the following issues:

- Fixed global-tag addition error in Nginx collection (#2406)
- Fixed CPU core collection error on Windows for host object collector (#2398)
- Chrony collector added synchronization mechanism with Dataway to avoid data deviation due to local time offsets on Datakit (#2351)
    - This feature depends on Dataway version 1.6.0 (inclusive) or higher
- Fixed potential crashes in Datakit HTTP API under timeout conditions (#2091)

---

## 1.38.1 (2024/09/11) {#cl-1.38.1}

This release is a Hotfix release, fixing the following issues:

- Fixed `inside_filepath` and `host_filepath` tag errors in container log collection (#2403)
- Fixed special case anomalies in Kubernetes-Prometheus collector (#2396)
- Fixed numerous upgrade program issues (2372):
    - Offline installation directory error
    - Configuration of `dk_upgrader` can follow Datakit configuration during installation/upgrade (no manual configuration required), DCA does not need to distinguish between offline and online upgrades.
    - Injection of ENV related to `dk_upgrader` during installation stage, eliminating the need for manual configuration
    - `dk_upgrader` HTTP API added new parameters to specify version number and force upgrade (not yet supported by DCA end)

---

## 1.38.0 (2024/09/04) {#cl-1.38.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.38.0-new}

- Added Graphite data ingestion (#2337)
<!-- - Profiling collection supports real-time metric extraction from profiling files (#2335) -->

### Bug Fixes {#cl-1.38.0-fix}

- Fixed eBPF network data aggregation anomalies (#2395)
- Fixed DDTrace telemetry interface crash (#2387)
- Fixed Jaeger UDP binary format data collection issue (#2375)
- Fixed Synthetic Tests collector data sending address format issue (#2374)

### Functional Optimization {#cl-1.38.0-opt}

- Added multiple fields (`num_cpu/unicast_ip/disk_total/arch`) to host objects (#2362)
- Other optimizations and fixes (#2376/#2354/#2393)

### Compatibility Adjustments {#cl-1.38.0-brk}

- Adjusted Pipeline execution priority (#2386)

    In previous versions, for a specific `source`, such as `nginx`:

    1. If users specified a match for *nginx.p*
    1. If users also set a default Pipeline (*default.p*)

    Then Nginx logs would not pass through *nginx.p*, but instead through *default.p*. This setting was unreasonable. After adjustment, the priority order is as follows (decreasing):

    1. Pipeline specified for `source` on the Guance page
    1. Pipeline specified for `source` in the collector
    1. `source` value matches a corresponding Pipeline (e.g., logs with `source` as `my-app` find a *my-app.p* in the Pipeline directory)
    1. Finally, use *default.p*

    This adjustment ensures all data passes through the Pipeline, with at least *default.p* acting as a fallback.

---

## 1.37.0 (2024/08/28) {#cl-1.37.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.37.0-new}

- Added support for [Zabbix data import](../integrations/zabbix_exporter.md)(#2340)

### Functional Optimization {#cl-1.37.0-opt}

- Optimized process collector, now supports fd count collection by default (#2384)
- Completed RabbitMQ tags (#2380)
- Optimized Kubernetes-Prometheus collector performance (#2373)
- Redis collection added more metrics (#2358)

---

## 1.36.0 (2024/08/21) {#cl-1.36.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.36.0-new}

- Added Pipeline functions `pt_kvs_set`, `pt_kvs_get`, `pt_kvs_del`, `pt_kvs_keys`, and `hash` (#2353)
- Synthetic Tests collector supports custom tags and node English names (#2365)

### Bug Fixes {#cl-1.36.0-fix}

- Fixed memory leak issue in eBPF collector (#2352)
- Fixed duplicate collection issue in Kubernetes Events due to accepting Deleted data (#2363)
- Fixed target tag not found issue in KubernetesPrometheus collector for Service/Endpoints (#2349)
    - Note: Update *datakit.yaml*

### Functional Optimization {#cl-1.36.0-opt}

- Optimized time filter condition for Oracle slow logs (#2360)
- Optimized collection method for PostgreSQL metric `postgresql_size` (#2350)
- Improved return information of Synthetic Tests debug interface (#2347)
- Optimized Pipeline handling of `status` field for log-type data, new version supports any custom log level (#2371)
- BPF network logs added fields identifying client/server IPs, ports, and connection sides (#2357)
- TCP Socket log collection supports multiline configuration (#2364)
- Kubernetes deployment supports distinguishing `host` field values via [adding prefixes/suffixes](datakit-daemonset-deploy.md#env-rename-node) if same-named Nodes exist (#2361)
- Collector data reporting changed to global blocking mode by default to alleviate (note: only alleviate, **cannot avoid**) time-series data loss due to queue blockage (#2370)
    - Adjusted monitor information display, 1) displays collector data reporting block duration (P90); 2) displays each collector's single collection point count (P90) to clearly show specific collector collection volumes.

---

## 1.35.0 (2024/08/07) {#cl-1.35.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.35.0-new}

- Added [election whitelist](election.md#election-whitelist) functionality to specify specific hosts for Datakit participation in elections (#2261)

### Bug Fixes {#cl-1.35.0-fix}

- Fixed association of container ID in CentOS process collector (#2338)
- Fixed multiline judgment failure in logs (#2336)
- Fixed Jaeger Trace-ID length issue (#2329)
- Other bug fixes (#2343)

### Functional Optimization {#cl-1.35.0-opt}

- `up` measurement supports automatic addition of collector custom tags (#2334)
- Cloud information sync for host object collection supports specifying meta address for private cloud deployment environments (#2331)
- DDTrace collector supports collecting basic information of traced services, reporting it to resource objects (`CO::`), with object type `tracing_service` (#2307)
- Network Synthetic Tests data adds `node_name` field (#2324)
- Kubernetes-Prometheus metric collection added `__kubernetes_mate_instance` and `__kubernetes_mate_host` tag placeholders, optimizing tag addition strategy (#2341) [^2341]
- Optimized TLS configurations for multiple collectors (#2225/#2204/#2192/#2342)
- eBPF link plugin added PostgreSQL and AMQP protocol recognition (#2315/#2311)

[^2341]: If the service restarts, the corresponding `instance` and `host` may change entirely, doubling the time series.

---

## 1.34.0 (2024/07/24) {#cl-1.34.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.34.0-new}

- Added custom object collection for mainstream collectors, such as Oracle/MySQL/Apache (#2207)
- Remote collectors added `up` metric (#2304)
- Statsd collector added self-metrics exposure (#2326)
- Added [CockroachDB collector](../integrations/cockroachdb.md) (#2187)
- Added [AWS lambda collector](../integrations/awslambda.md) (#2258)
- Added [Kubernetes Prometheus collector](../integrations/kubernetesprometheus.md), achieving automatic Prometheus discovery (#2246)

### Bug Fixes {#cl-1.34.0-fix}

- Fixed excessive memory usage issues on certain Windows versions for bug reports and Datakit self-collection, temporarily removing some metric exposures to bypass (#2317)
- Fixed `datakit monitor` not showing collectors sourced from Confd (#2160)
- Fixed inability to collect container logs manually set as stdout via Annotations (#2327)
- Fixed K8s tag acquisition anomalies in eBPF network log collector (#2325)
- Fixed concurrency read/write errors in RUM collector (#2319)

### Functional Optimization {#cl-1.34.0-opt}

- Optimized OceanBase collector view templates, and added `cluster` Tag to metric `oceanbase_log` (#2265)
- Optimized task failure handling in Synthetic Tests collector (#2314)
- Pipeline supports adding script execution information to data, and `http_request` function supports body parameter (#2313/#2298)
- Optimized memory usage in eBPF collector (#2328)
- Other documentation optimizations (#2320)

---

## 1.33.1 (2024/07/11) {#cl-1.33.1}

This release is a Hotfix release, fixing the following issues:

- Fixed invalid trace sampling issue introduced since version 1.26. Simultaneously, added `dk_sampling_rate` field on root-span to indicate that the trace has been sampled. **Suggested upgrade** (#2312)
- Fixed IP processing bug in SNMP collection, simultaneously adding a batch of metrics exposed during SNMP collection process (#3099)

---

## 1.33.0 (2024/07/10) {#cl-1.33.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.33.0-new}

- Added [OpenTelemetry log collection](../integrations/opentelemetry.md#logging) (#2292)
- Restructured [SNMP collector](../integrations/snmp.md), adding Zabbix/Prometheus dual configuration support, while adding corresponding built-in views (#2290)

### Bug Fixes {#cl-1.33.0-fix}

- Fixed HTTP Synthetic Tests issues (#2293)
    - Response time (`response_time`) not including download time (`response_download`)
    - IPv6 recognition issue in HTTP Synthetic Tests
- Fixed Oracle collector crash and max-cursor issues (#2297)
- Fixed position record issues in log collection introduced since version 1.27, **Suggested upgrade** (#2301)
- Fixed issues where some customer-tags were ineffective in DDTrace/OpenTelemetry HTTP API data reception (#2308)

### Functional Optimization {#cl-1.33.0-opt}

- Redis big-key collection added 4.x version support (#2296)
- Optimized internal worker counts based on actual CPU core limits, greatly reducing some buffer memory overhead, **Suggested upgrade** (#2275)
- Datakit API receiving time-series data defaults to blocking form to avoid data point loss (#2300)
- Optimized performance of `grok()` function in Pipeline (#2310)
- Added eBPF related information and Pipeline information to [Bug report](why-no-data.md#bug-report) (#2289)
- k8s auto-discovery ServiceMonitor supports configuring TLS certificate paths (#1866)
- [Host process collector](../integrations/host_processes.md) objects and metric data collection added corresponding container ID field (`container_id`) (#2283)
- Trace data collection added Datakit fingerprint field (`datakit_fingerprint`, value is Datakit hostname), facilitating troubleshooting, while adding some collection process metrics exposure (#2295)
    - Added statistics for collected Trace counts
    - Added statistics for discarded sampled Traces

- Documentation optimization:
    - Added [explanation document](bug-report-how-to.md) regarding bug-report
    - Supplement [difference explanation](datakit-update.md#upgrade-vs-install) between Datakit installation and upgrade
    - Supplement documentation regarding parameter settings during [offline installation](datakit-offline-install.md#simple-install)
    - Optimized [MongoDB collector](../integrations/mongodb.md) field documentation (#2278)

---

## 1.32.0 (2024/06/26) {#cl-1.32.0}

This release is an iterative release, with the following updates:

### New Features {#cl-1.32.0-new}

- OpenTelemetry added histogram metrics (#2276)

### Bug Fixes {#cl-1.32.0-fix}

- Fixed localhost identification issue in meter reporting (#2281)
- Fixed `service` field assignment issue in log collection (#2286)
- Other defect fixes (#2284/#2282)

### Functional Optimization {#cl-1.32.0-opt}

- MySQL enhanced master-slave replication-related metrics and log collection (#2279)
- Optimized encryption-related documentation and installation options (#2274)
- Optimized memory consumption during DDTrace collection (#2272)
- Optimized data reporting strategy in health check collector (#2268)
- Optimized timeout control and TLS settings in SQLServer collection (#2264)
- Optimized handling of `job` field in Prometheus-related metrics collection (Push Gateway/Remote Write) (#2271)
- Perfected OceanBase slow query fields, added client IP information (#2280)
- Rewrote Oracle collector (#2186)
- Optimized target domain name values in eBPF collection (#2287)
- Default upload of collected data using v2 (Protobuf) protocol (#2269)
    - [Comparison between v1 and v2](pb-vs-lp.md)
- Other adjustments (#2267/#2255/#2237/#2270/#2248)

---

## 1.31.0 (2024/06/13) {#cl-1.31.0}
This release is an iterative release, with the following updates:

### New Features {#cl-1.31.0-new}

- Supported configuring sensitive information via [encryption methods](datakit-conf.md#secrets_management) (such as database passwords) (#2249)
- Added [Prometheus Push Gateway metrics push](../integrations/pushgateway.md) functionality (#2260)
- Supported appending corresponding Kubernetes Labels to container objects (#2252)
- eBPF link plugin added Redis protocol recognition (#2248)

### Bug Fixes {#cl-1.31.0-fix}

- Fixed incomplete SNMP collection issue (#2262)
- Fixed Kubernetes Autodiscovery duplicate Pod collection issue (#2259)
- Added protection measures to avoid duplicate collection of container-related metrics (#2253)
- Fixed Windows platform CPU metric anomaly (large invalid values) issue (#2028)

### Functional Optimization {#cl-1.31.0-opt}

- Optimized PostgreSQL metrics collection (#2263)
- Improved bpf-netlog collection fields (#2247)
- Perfected OceanBase data collection (#2122)
- Other adjustments (#2267/#2255/#2237)

--- 

## 1.30.0 (2024/06/04) {#cl-1.30.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.30.0-new}

- Pipeline
    - Added `gjson()` function, providing ordered JSON field extraction (#2167)
    - Added context cache functionality (#2157)

### Bug Fixes {#cl-1.30.0-fix}

- Fixed Prometheus Remote Write global-tag append issue [^2244] (#2244)

[^2244]: This issue was introduced in version 1.25.0. If Prometheus Remote Write collector is enabled, it is recommended to upgrade.

### Functional Optimization {#cl-1.30.0-opt}

- Optimized Datakit [`/v1/write/:category` API](apis.md#api-v1-write), with the following adjustments and features (#2130)
    - Added more API parameters ([`echo`](apis.md#preview-post-point)/`dry`) for debugging purposes
    - Supported more data formats
    - Supported fuzzy recognition of timestamp precision in data points (#2120)
- Optimized MySQL/Nginx/Redis/SQLServer Metrics collection (#2196)
    - Added master-slave replication related metrics for MySQL
    - Added time consumption metrics to Redis slow logs
    - Added more Nginx Plus related metrics for Nginx
    - Optimized SQLServer Performance-related metric structures
- Added low-version TLS support to the MySQL collector (#2245)
- Optimized Kubernetes etcd Metrics collection TLS certificate configuration (#2032)
- Prometheus Exporter Metrics collection supports "retain original metric name" configuration (#2231)
- Added taint-related information to Kubernetes Node objects (#2239)
- eBPF-Tracing added MySQL protocol recognition (#1768)
- Optimized performance of the ebpftrace collector (#2226)
- The status of the Testing collector can now be displayed on the `datakit monitor` command panel (#2243)
- Other view and documentation optimizations (#1976/#1977/#2194/#2195/#2221/#2235)

### Compatibility Adjustments {#cl-1.30.0-brk}

In this version, the data protocol has been extended. After upgrading from older versions of Datakit, if the central base is a private deployment, one of the following measures can be taken to maintain data compatibility:
  
- Upgrade the central base to [1.87.167](../deployment/changelog/2024.md#1.87.167), or
- Modify the [upload protocol configuration `content_encoding`](datakit-conf.md#dataway-settings) in *datakit.conf* to `v2`

#### Notes for InfluxDB Deployment Plan {#cl-1.30.0-brk-influxdb}

If the time-series storage of the central base is InfluxDB, **do not upgrade Datakit**. Stay at version 1.29.1. You will need to upgrade the central base before moving to a higher Datakit version.

Additionally, if the central base has been upgraded to a newer version (1.87.167+), then do **not use the `v2` upload protocol** with lower Datakit versions. Instead, use the `v1` upload protocol.

If you must upgrade to a newer Datakit version, replace the time-series engine with GuanceDB for metrics.

---

## 1.29.1 (2024/05/20) {#cl-1.29.1}

This release is a Hotfix release and fixes the following issues:

- Fixed potential crashes in the MongoDB collector (#2229)

---

## 1.29.0 (2024/05/15) {#cl-1.29.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.29.0-new}

- Container log collection supports configuring color character filtering via annotations (`remove_ansi_escape_codes`) (#2208)
- [Health Check collector](../integrations/host_healthcheck.md) supports command-line argument filtering (#2197)
- Added [Cassandra collector](../integrations/cassandra.md) (#1812)
- Added usage statistics feature (#2177)
- eBPF Tracing added HTTP2/gRPC support (#2017)

### Bug Fixes {#cl-1.29.0-fix}

- Fixed the issue where Kubernetes did not collect Pending Pods (#2214)
- Fixed the startup failure issue of logfwd (#2216)
- Fixed the issue where log collection did not perform color character filtering under special circumstances (#2209)
- Fixed the issue where Profile collection could not append Tags (#2205)
- Fixed Goroutine leakage issues that might occur in Redis/MongoDB collectors (#2199/#2215)

### Functional Optimization {#cl-1.29.0-opt}

- Supports `insecureSkipVerify` configuration item for Prometheus PodMonitor/ServiceMonitor TLSConfig (#2211)
- Enhanced security for Testing debug interfaces (#2203)
- Nginx collector supports specifying port ranges (#2206)
- Improved settings for TLS certificate-related ENVs (#2198)
- Other documentation optimizations (#2210/#2213/#2218/#2223/#2224/#2141/#2080)

### Compatibility Adjustments {#cl-1.29.0-brk}

- Removed certificate file path methods for Prometheus PodMonitor/ServiceMonitor TLSConfig (#2211)
- Optimized DCA routing parameters and reload logic (#2220)

---

## 1.28.1 (2024/04/22) {#cl-1.28.1}

This release is a Hotfix release and fixes the following issues:

- Fixed no-data problems caused by partial crashes (#2193)

---

## 1.28.0 (2024/04/17) {#cl-1.28.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.28.0-new}

- Pipeline added `cache_get()/cache_set()/http_request()` functions for expanding external data sources in Pipeline (#2128)
- Supports collecting Prometheus Metrics for Kubernetes system resources, currently in experimental stage (#2032)
    - Some cloud-hosted Kubernetes clusters may not be able to collect due to disabled corresponding authorization features

### Bug Fixes {#cl-1.28.0-fix}

- Fixed filter logic issues in container logs (#2188)

### Functional Optimization {#cl-1.28.0-opt}

- PrometheusCRD-ServiceMonitor supports TLS path configuration (#2168)
- Optimized NIC information collection under Bond mode (#1877)
- Further optimized Windows Event collection performance (#2172)
- Optimized field information extraction in Jaeger APM data collection (#2174)
- Removed disk cache functionality for log collection (#2191)
- Added `log_file_inode` field to log collection
- Added point-pool configuration to optimize Datakit's memory usage under high load (#2034)
    - Restructured some Datakit modules to optimize GC overhead; this optimization slightly increases memory usage under low load (additional memory is primarily used for memory pools)
- Other document adjustments and detail optimizations (#2191/#2189/#2185/#2181/#2180)

---

## 1.27.0 (2024/04/03) {#cl-1.27.0}

### New Features {#cl-1.27.0-new}

- Added Pipeline Offload collector, specifically for centralized Pipeline processing (#1917)
- Supports BPF-based HTTP/HTTP2/gRPC network data collection to cover lower versions of Linux kernels (#2017)

### Bug Fixes {#cl-1.27.0-fix}

- Fixed Point build default time disorder issue (#2163)
- Fixed possible crash during Kubernetes collection (#2176)
- Fixed Nodejs Profiling collection issue (#2149)

### Functional Optimization {#cl-1.27.0-opt}

- Prometheus Remote Write collection supports grouping Metrics by metric prefixes (#2165)
- Enhanced Datakit's own Metrics, adding Goroutine crash count statistics for each module (#2173)
- Enhanced bug report functionality to support direct uploading of info files to OSS (#2170)
- Optimized Windows Event collection performance (#2155)
- Optimized historical position recording in log collection (#2156)
- Testing collector supports disabling internal network testing (#2142)
- Other miscellaneous items and documentation updates (#2154/#2148/#1975/#2164)

---

## 1.26.1 (2024/03/27) {#cl-1.26.1}

This release is a Hotfix release and fixes the following issues:

- Fixed Redis TLS unsupported issue (#2161)
- Fixed Trace data timestamp issue (#2162)
- Fixed vmalert writing to Prometheus Remote Write issue (#2153)

---

## 1.26.0 (2024/03/20) {#cl-1.26.0}

### New Features {#cl-1.26.0-new}

- Added Doris collector (#2137)

### Bug Fixes {#cl-1.26.0-fix}

- Fixed DDTrace header sampling re-sampling issue (#2131)
- Fixed missing tag issue in SQLServer custom collection (#2144)
- Fixed repeated collection of Kubernetes Events (#2145)
- Fixed inaccurate collection of Kubernetes container counts (#2146)
- Fixed incorrect sampling of some Traces in Trace collection (#2135)

### Functional Optimization {#cl-1.26.0-opt}

- Added upgrade program configurations in *datakit.conf*, along with fields related to the upgrade program in the host object collector (#2124)
- Enhanced bug report functionality by attaching error messages as attachments (#2132)
- Optimized TLS settings and default collector configuration files for the MySQL collector (#2134)
- Optimized logic for global tag configurations in host cloud synchronization, allowing tags synchronized from the cloud not to be included in the global-host-tag (#2136)
- Added `redis-cli` command in the Datakit image to facilitate big-key/hot-key collection in Redis (#2138)
- Added `offset/partition` fields to Kafka-MQ collected data (#2140)
- Other miscellaneous items and documentation updates (#2133/#2143)

---

## 1.25.0 (2024/03/06) {#cl-1.25.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.25.0-new}

- Added dynamic update Global Tag related interfaces to the Datakit API (#2076)
- Added Kubernetes PersistentVolume / PersistentVolumeClaim collection, requiring additional [RBAC](../integrations/container.md#rbac-pv-pvc) (#2109)

### Bug Fixes {#cl-1.25.0-fix}

- Fixed SkyWalking RUM root-span issue (#2131)
- Fixed incomplete Windows Event collection (#2118)
- Fixed missing `host` field in Pinpoint collection (#2114)
- Fixed RabbitMQ Metrics collection (#2108)
- Fixed OpenTelemetry old version compatibility (#2089)
- Fixed Containerd log split parsing errors (#2121)

### Functional Optimization {#cl-1.25.0-opt}

- StatsD collects count type data and defaults to converting it into float (#2127)
- Container collector supports Docker 1.24+ versions (#2112)
- Optimized SQLServer collector (#2105)
- Optimized Health Check collector (#2105)
- Default log collection time values (#2116)
- Added ability to disable Kubernetes Job resource collection using environment variable `ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB` (#2129)
- Updated built-in views for a batch of collectors:
    - ssh (#2125)
    - etcd (#2101)
- Other miscellaneous items and documentation updates (#2119/#2123/#2115/#2113)

---

## 1.24.0 (2024/01/24) {#cl-1.24.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.24.0-new}

- Added [Host Health Check collector](../integrations/host_healthcheck.md) (#2061)

### Bug Fixes {#cl-1.24.0-fix}

- Fixed potential crash issues in Windows Event collection (#2087)
- Fixed data recording function issues and improved [related documentation](datakit-daemonset-deploy.md#env-recorder) (#2092)
- Fixed multi-link propagation issues in DDTrace (#2093)
- Fixed Socket log collection truncation issues (#2095)
- Fixed residual main configuration file issues during Datakit upgrades (#2096)
- Fixed script overwrite issues (#2085)

### Functional Optimization {#cl-1.24.0-opt}

- Optimized resource limit functionality during Linux non-root installation in host installations (#2011)
- Optimized diversion and blacklist matching performance, significantly (*10X*) reducing memory consumption (#2077)
- Log Streaming collection [supports FireLens](../integrations/logstreaming.md#firelens) type (#2090)
- Log Forward collection adds `log_read_lines` field (#2098)
- Optimized handling of `cluster_name_k8s` tag in K8s (#2099)
- Added restart count (`restarts`) metric to K8s Pod time-series indicators
- Optimized `kubernetes` time-series Metrics set, adding container count statistics
- Optimized Kubelet Metrics collection logic

---

## 1.23.1 (2024/01/12) {#cl-1.23.1}

This release is a Hotfix release and fixes the following issues:

- Fixed abnormal issues with Datakit service on Windows

---

## 1.23.0 (2024/01/11) {#cl-1.23.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.23.0-new}

- Kubernetes deployments support configuring any collector via environment variables (`ENV_DATAKIT_INPUTS`) (#2068)
- Container collector supports finer-grained configurations, converting Kubernetes object labels into tags for collected data (#2064)
    - `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2_FOR_METRIC`: Supports converting labels into tags for Metrics-type data
    - `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2` supports converting labels into tags for non-Metrics-type data (such as objects/logs, etc.)

### Bug Fixes {#cl-1.23.0-fix}

- Fixed occasional errors in `deployment` and `daemonset` fields in the container collector (#2081)
- Fixed losing the last few lines of logs after containers run briefly and exit (#2082)
- Fixed [Oracle](../integrations/oracle.md) collector slow query SQL time errors (#2079)
- Fixed Prom collector `instance` setting issues (#2084)

### Functional Optimization {#cl-1.23.0-opt}

- Optimized Prometheus Remote Write collection (#2069)
- eBPF collection supports setting resource usage (#2075)
- Optimized Profiling data collection process (#2083)
- [MongoDB](../integrations/mongodb.md) collector supports separate username and password configuration (#2073)
- [SQLServer](../integrations/sqlserver.md) collector supports configuring instance names (#2074)
- Optimized [ElasticSearch](../integrations/elasticsearch.md) collector views and monitors (#2058)
- [KafkaMQ](../integrations/kafkamq.md) collector supports multi-threaded mode (#2051)
- [SkyWalking](../integrations/skywalking.md) collector added support for Meter data types (#2078)
- Updated part of collector documentation and other bug fixes (#2074/#2067)
- Optimized Proxy proxy installation upgrade commands (#2033)
- Optimized resource limit functionality during non-root user installation (#2011)

---

## 1.22.0 (2023/12/28) {#cl-1.22.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.22.0-new}

- Added [OceanBase](../integrations/oceanbase.md) custom SQL collection (#2046)
- Added [Prometheus Remote](../integrations/prom_remote_write.md) blacklists/whitelists (#2053)
- Added `node_name` tag to Kubernetes resource quantity collection (only supported for Pod resources) (#2057)
- Added `cpu_limit_millicores/mem_limit/mem_used_percent_base_limit` fields to Kubernetes Pod Metrics
- Added `bpf-netlog` plugin to eBPF collector (#2017)
- Added support for configuring data recording in Kubernetes via environment variables

### Bug Fixes {#cl-1.22.0-fix}

- Fixed zombie process issues in [`external`](../integrations/external.md) collector (#2063)
- Fixed conflicts in container log tags (#2066)
- Fixed virtual NIC information retrieval failures (#2050)
- Fixed Pipeline Refer table and IPDB functionality issues (#2045)

### Optimization {#cl-1.22.0-opt}

- Optimized DDTrace and OTEL field extraction whitelist functionality (#2056)
- Optimized SQL for obtaining `sqlserver_lock_dead` Metrics in [SQLServer](../integrations/sqlserver.md) collector (#2049)
- Optimized connection library for [PostgreSQL](../integrations/postgresql.md) collector (#2044)
- Optimized configuration file for [ElasticSearch](../integrations/elasticsearch.md) collector, setting `local` default to `false` (#2048)
- Added more ENV configuration items during K8s installation (#2025)
- Optimized Datakit's own Metrics exposure
- Updated integration documentation for some collectors

---

## 1.21.1 (2023/12/21) {#cl-1.21.1}

This release is a Hotfix release and fixes the following issues:

- Fixed Prometheus Remote Write not adding Datakit host class Tags issue, mainly compatible with previous old configurations (#2055)
- Fixed missing host class Tags in a batch of middleware default log collections
- Fixed Chinese character color removal encoding issues in log collection

---

## 1.21.0 (2023/12/14) {#cl-1.21.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.21.0-new}

- Added [ECS Fargate collection mode](ecs-fargate.md) (#2018)
- Added [Prometheus Remote](../integrations/prom_remote_write.md) collector tag whitelist (#2031)

### Bug Fixes {#cl-1.21.0-fix}

- Fixed [PostgreSQL](../integrations/postgresql.md) collector version detection issue (#2040)
- Fixed [ElasticSearch](../integrations/elasticsearch.md) collector account permission settings issue (#2036)
- Fixed [Host Dir](../integrations/hostdir.md) collector crashing when collecting disk root directory issue (#2037)

### Optimization {#cl-1.21.0-opt}

- Optimized DDTrace collector: [Removed duplicate tags in `message.Mate`](../integrations/ddtrace.md#tags) (#2010)
- Optimized search strategy for log file paths inside containers (#2027)
- [Testing collector](../integrations/dialtesting.md) added `datakit_version` field and set collection time to task start execution time (#2029)
- Removed `datakit export` command to optimize binary package size (#2024)
- [Debugging collector configuration](why-no-data.md#check-input-conf) added number of time series in collection points (#2016)
- [Profile collection](../integrations/profile.md) implemented asynchronous reporting using disk cache (#2041)
- Optimized Windows Datakit installation script (#2026)
- Updated built-in views and monitors for a batch of collectors

### Breaking Changes {#cl-1.21.0-brk}

- DDTrace collection no longer extracts all fields by default, which may result in missing custom fields on certain pages. Specific fields can be extracted through Pipelines or new JSON viewing syntax (`message@json.meta.xxx`).

---

## 1.20.1 (2023/12/07) {#cl-1.20.1}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.20.1-fix}

- Fixed a sampling bug in DDTrace
- Fixed a bug where `error_message` lost information
- Fixed a bug where Kubernetes Pod object data did not correctly collect the `deployment` field

## 1.20.0 (2023/11/30) {#cl-1.20.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.20.0-new}

- [Redis](../integrations/redis.md) collector added hotkey Metrics (#2019)
- `monitor` command supports playing back [bug report](why-no-data.md#bug-report) Metrics data (#2001)
- [Oracle](../integrations/oracle.md) collector added custom queries (#1929)
- [Container](../integrations/container.md) log files within containers support wildcard collection (#2004)
- Kubernetes Pod Metrics support `network` and `storage` field collection (#2022)
- [RUM](../integrations/rum.md) added configuration support for filtering session replays (#1945)

### Bug Fixes {#cl-1.20.0-fix}

- Fixed panic errors in cgroup under certain environments (#2003)
- Fixed Windows installation scripts failing under low-version PowerShell (#1997)
- Fixed default disk cache being enabled issue (#2023)
- Adjusted naming style for Kubernetes Auto-Discovery Prom Metrics sets (#2015)

### Functional Optimization {#cl-1.20.0-opt}

- Optimized built-in collector template views and monitor views export logic and updated MySQL/PostgreSQL/SQLServer view templates (#2008/#2007/#2013/#2024)
- Optimized Prom collector's own Metrics name (#2014)
- Optimized Proxy collector, providing basic performance test benchmarks (#1988)
- Container log collection supports adding Labels from the owning Pod (#2006)
- When collecting Kubernetes data, uses `NODE_LOCAL` mode by default, requires additional [RBAC](../integrations/container.md#rbac-nodes-stats) (#2025)
- Optimized trace processing flow (#1966)
- Refactored PinPoint collector, optimizing hierarchical relationships (#1947)
- APM supports discarding `message` fields to save storage (#2021)

---

## 1.19.2 (2023/11/20) {#cl-1.19.2}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.19.2-fix}

- Fixed session replay data loss caused by disk cache bugs
- Added Prometheus Metrics regarding resource collection duration in Kubernetes

---

## 1.19.1 (2023/11/17) {#cl-1.19.1}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.19.1-fix}

- Fixed inability to start due to *.pos* file issues in disk cache ([issue](https://github.com/GuanceCloud/cliutils/pull/59){:target="_blank"} )

---

## 1.19.0 (2023/11/16) {#cl-1.19.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.19.0-new}

- Support [OceanBase](../integrations/oceanbase.md) MySQL mode collection (#1952)
- Added [Data Recording/Playback](datakit-tools-how-to.md#record-and-replay) functionality (#1738)

### Bug Fixes {#cl-1.19.0-fix}

- Fixed ineffective resource limits on low-version Windows issue (#1987)
- Fixed ICMP Testing issue (#1998)

### Functional Optimization {#cl-1.19.0-opt}

- Optimized statsd collection (#1995)
- Optimized Datakit installation script (#1979)
- Optimized MySQL built-in views (#1974)
- Enhanced Datakit self-exposed Metrics, added complete Golang runtime and multiple other Metrics (#1971/#1969)
- Other documentation optimizations and unit test optimizations (#1952/#1993)
- Enhanced Redis Metrics collection, added more Metrics (#1940)
- TCP Testing allows adding packets (only supports ASCII text) for detection (#1934)
- Optimized issues during non-root user installation:
    - May fail to start due to ulimit setting failure (#1991)
    - Enhanced documentation, added descriptions of restricted functions during non-root installation (#1989)
    - Adjusted pre-installation operations for non-root users to manual configuration by the user, avoiding possible command differences across operating systems (#1990)
- MongoDB collector added support for older version 2.8.0 (#1985)
- RabbitMQ collector added support for lower versions (3.6.X/3.7.X) (#1944)
- Optimized Pod Metrics collection in Kubernetes, replacing the original Metric Server method (#1972)
- When collecting Prometheus Metrics in Kubernetes, allowed adding Metrics set name configuration (#1970)

### Compatibility Adjustments {#cl-1.19.0-brk}

- Due to the addition of Data Recording/Playback functionality, removed the feature of writing data to files (#1738)

---

## 1.18.0 (2023/11/02) {#cl-1.18.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.18.0-new}

- Added OceanBase collection (#1924)

### Bug Fixes {#cl-1.18.0-fix}

- Fixed compatibility for larger Tag values in Tracing data, now increased to 32MB (#1932)
- Fixed dirty data issue in RUM session replay (#1958)
- Fixed Metrics information export issue (#1953)
- Fixed [v2 protocol version](datakit-conf.md#dataway-settings) construction error

### Functional Optimization {#cl-1.18.0-opt}

- Added mount point and other Metrics in host directory and disk collection (#1941)
- KafkaMQ supports OpenTelemetry Tracing data processing (#1887)
- Bug Report added more information collection (#1908)
- Enhanced self-exposure of Metrics during Prom collection (#1951)
- Updated default IP database to support IPv6 (#1957)
- Updated image download address to `pubrepo.guance.com` (#1949)
- Optimized log file location collection function (#1961)
- Kubernetes
    - Supports Node-Local Pod information collection to alleviate election node pressure (#1960)
    - Container log collection supports more granular filtering (#1959)
    - Added service-related Metrics collection (#1948)
    - Supports Label filtering on PodMonitor and ServiceMonitor (#1963)
    - Supports converting Node Labels into Tags for Node objects (#1962)

### Compatibility Adjustments {#cl-1.18.0-brk}

- Kubernetes no longer collects CPU/memory Metrics for Pods created by Jobs/CronJobs (#1964)

---

## 1.17.3 (2023/10/31) {#cl-1.17.3}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.17.3-fix}

- Fixed invalid Pipeline setting in log collection issue (#1954)
- Fixed eBPF running issues on arm64 platforms (#1955)

---

## 1.17.2 (2023/10/27) {#cl-1.17.2}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.17.2-fix}

- Fixed the issue where log collection did not carry global host tags (#1942)
- Optimized Session Replay data processing (#1943)
- Optimized Point encoding handling for non-UTF8 strings

---

## 1.17.1 (2023/10/26) {#cl-1.17.1}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.17.1-fix}

- Fixed the issue where Testing data could not be uploaded

### New Features {#cl-1.17.1-new}

- Added [eBPF-built call relationship data](../integrations/ebpftrace.md) representing Linux process/thread call relationships (#1836)
- Pipeline added function [`pt_name`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-pt-name) (#1937)

### Functional Optimization {#cl-1.17.1-opt}

- Optimized point data building, improving memory usage efficiency (#1792)

---

## 1.17.0(2023/10/19) {#cl-1.17.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.17.0-new}

- Added `cpu_limit` metric to Pod (#1913)
- Added `New Relic` APM data integration (#1834)

### Bug Fixes {#cl-1.17.0-fix}

- Fixed memory issues that could occur due to excessively long single-line log data (#1923)
- Fixed a failure in obtaining disk mount points in the [disk](../integrations/disk.md) collector (#1919)
- Fixed inconsistency between Service names in Helm and YAML files (#1910)
- Fixed missing `agentid` field in Pinpoint span (#1897)
- Fixed error handling for `goroutine group` in collectors (#1893)
- Fixed empty data reporting issue in the [MongoDB](../integrations/mongodb.md) collector (#1884)
- Fixed large numbers of 408 and 500 status codes appearing in requests in the [RUM](../integrations/rum.md) collector (#1915)

### Functional Improvements {#cl-1.17.0-opt}

- Optimized exit logic in `logfwd` to prevent program exits caused by configuration errors from affecting business Pods (#1922)
- Enhanced the [`ElasticSearch`](../integrations/elasticsearch.md) collector by adding shard and replica metrics to the `elasticsearch_indices_stats` index set (#1921)
- Added integration tests for [disk](../integrations/disk.md) (#1920)
- DataKit monitor supports HTTPS (#1909)
- Oracle collector adds slow query logs (#1906)
- Optimized point implementation in collectors (#1900)
- Added authorization detection functionality to integration tests for the [MongoDB](../integrations/mongodb.md) collector (#1885)
- Improved retry functionality for Dataway sending, with additional configurable parameters

---

## 1.16.1(2023/10/09) {#cl-1.16.1}

This release is a Hotfix release and fixes the following issues:

### Bug Fixes {#cl-1.16.1-fix}

- Fixed CPU metric acquisition failures and multiline log collection problems under containerd in the [K8s/Container Collector](../integrations/container.md) (#1895)
- Fixed excessive memory usage issues in the [Prom Collector](../integrations/prom.md) (#1905)

### Breaking Changes {#cl-1.16.1-bc}

- When collecting Tracing data, all meta information fields containing `-` will no longer be replaced with `_`. This modification was made to avoid association issues between Tracing data and LOG data (#1903)
- All [Prom Collectors](../integrations/prom.md) now default to stream-based collection to prevent significant memory consumption by unknown Exporters.

---

## 1.16.0(2023/09/21) {#cl-1.16.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.16.0-new}

- Added Neo4j collector (#1846)
- The [RUM](../integrations/rum.md#upload-delete) collector added sourcemap file upload, deletion, and validation interfaces, removing sourcemap upload and deletion interfaces from DCA services (#1860)
- Added monitoring views and detection libraries for the IBM Db2 collector (#1862)

### Bug Fixes {#cl-1.16.0-fix}

- Fixed an issue where using `__datakit_hostname` in the environment variable `ENV_GLOBAL_HOST_TAGS` failed to retrieve the hostname (#1874)
- Fixed the absence of the `open_files` field in the [host_processes](../integrations/host_processes.md) collector's metrics data (#1875)
- Fixed large numbers of empty resources and high memory usage in the Pinpoint collector (#1857 #1849)

### Functional Improvements {#cl-1.16.0-opt}

- Optimized Kubernetes metrics and object collection efficiency (#1854)
- Optimized metrics output for log collection (#1881)
- Added two new fields, `unschedulable` and `node_ready`, to Kubernetes Node object collection (#1886)
- [Oracle collector](../integrations/oracle.md) now supports Linux ARM64 architecture (#1859)
- Added integration tests to the `logstreaming` collector (#1570)
- Added content about the IBM Db2 collector to the [Datakit development documentation](development.md) (#1870)
- Enhanced documentation for the [Kafka](../integrations/kafka.md) and [MongoDB](../integrations/mongodb.md) collectors (#1883)
- When creating a monitoring account for the [MySQL](../integrations/mysql.md) collector, MySQL 8.0+ defaults to using the `caching_sha2_password` encryption method (#1882)
- Optimized the [`bug report`](why-no-data.md#bug-report) command to handle overly large syslog files (#1872)

### Breaking Changes {#cl-1.16.0-bc}

- Removed sourcemap file upload and deletion interfaces from DCA services, moving related interfaces to the [RUM](../integrations/rum.md#upload-delete) collector

---

## 1.15.1(2023/09/12) {#cl-1.15.1}

### Bug Fixes {#cl-1.15.1-fix}

- Fixed duplicate log collection in logfwd

---

## 1.15.0(2023/09/07) {#cl-1.15.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.15.0-new}

- [Windows](datakit-install.md#resource-limit) now supports memory/CPU limits (#1850)
- Added [IBM Db2 collector](../integrations/db2.md) (#1818)

### Bug Fixes {#cl-1.15.0-fix}

- Fixed the double star problem in the include/exclude configurations for container collection (#1855)
- Fixed a field error in k8s Service object data

### Functional Improvements {#cl-1.15.0-opt}

- [DataKit Lite Edition](datakit-install.md#lite-install) now supports [LOG](../integrations/logging.md) collection (#1861)
- [Bug Report](why-no-data.md#bug-report) now supports disabling profile data collection (to avoid putting pressure on the current DataKit instance) (#1868)
- Pipeline
    - Added functions `parse_int()` and `format_int()` (#1824)
    - Aggregation functions `agg_create()` and `agg_metric()` now support outputting any category of data (#1865)
- Optimized DataKit image size (#1869)
- Documentation
    - Added DataKit metrics performance test report](../integrations/datakit-metric-performance.md) (#1867)
    - Added [external collector usage documentation](../integrations/external.md) (#1851)
    - Added different Trace propagation explanations [documentation](../integrations/tracing-propagator.md) (#1824)

---

## 1.14.2(2023/09/04) {#cl-1.14.2}

### Bug Fixes {#cl-1.14.2-fix}

- Fixed the issue of Prometheus annotations on Kubernetes Pods lacking the `instance` tag
- Fixed the issue where Pod objects couldn't be collected

---

## 1.14.1(2023/08/30) {#cl-1.14.1}

### Bug Fixes {#cl-1.14.1-fix}

- Optimized Prometheus metric collection in Kubernetes (stream-based collection), avoiding potential high memory usage (#1853/#1845)
- Fixed [ANSI color character processing](../integrations/logging.md#ansi-decode)
    - Environment variable in Kubernetes is `ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES`

---

## 1.14.0(2023/08/24) {#cl-1.14.0}
This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.14.0-new}

- Added [NetFlow](../integrations/netflow.md) collector (#1821)
- Added [blacklist debugger](datakit-tools-how-to.md#debug-filter) (#1787)
- Added Kubernetes StatefulSet metrics and object collection, introducing the `replicas_desired` object field (#1822)
- Added [DK_LITE](datakit-install.md#lite-install) environment variable for installing the DataKit Lite Edition (#123)

### Bug Fixes {#cl-1.14.0-fix}

- Fixed the issue of HostTags and ElectionTags not being correctly added during Container and Kubernetes collection (#1833)
- Fixed the issue where custom tags for [MySQL](../integrations/mysql.md#input-config) were empty, preventing metrics collection (#1835)

### Functional Improvements {#cl-1.14.0-opt}

- Added the [process_count](../integrations/system.md#metric) metric in the System collector to represent the number of processes on the current machine (#1838)
- Removed the [open_files_list](../integrations/host_processes.md#object) field from the Process collector (#1838)
- Added a troubleshooting case for missing metrics in the [host object](../integrations/hostobject.md#faq) collector documentation (#1838)
- Optimized the Datakit view and enhanced the Datakit Prometheus metrics documentation
- Optimized the [mount method](../integrations/container-log.md#logging-with-inside-config) for Pod/container log collection (#1844)
- Added integration tests for Process and System collectors (#1841/#1842)
- Optimized etcd integration tests (#1847)
- Upgraded Golang to 1.19.12 (#1516)
- Added installation via the `ash` command [for DataKit](datakit-install.md#get-install) (#123)
- [RUM collection](../integrations/rum.md) now supports custom metrics sets; the default metrics set has been updated to include `telemetry` (#1843)

### Compatibility Adjustments {#cl-1.14.0-brk}

- Removed the Sinker function from Datakit, transferring its functionality to the [Dataway side implementation](../deployment/dataway-sink.md) (#1801)
- Removed the `pasued` and `condition` fields from Kubernetes Deployment metric data, introducing the `paused` object data field

---

## 1.13.2(2023/08/15) {#cl-1.13.2}

### Bug Fixes {#cl-1.13.2-fix}

- Fixed MySQL custom collection failures. (#1831)
- Fixed service scope and execution errors in Prometheus Export. (#1828)
- Fixed abnormal HTTP response codes and delays in eBPF collectors. (#1829)

### Functional Improvements {#cl-1.13.2-opt}

- Improved the value selection for the `image` field in container collection. (#1830)
- Optimized MySQL integration tests to enhance testing speed. (#1826)

---

## 1.13.1(2023/08/11) {#cl-1.13.1}

- Fixed naming issues with the `source` field in container logs (#1827)

---

## 1.13.0(2023/08/10) {#cl-1.13.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.13.0-new}

- Host object collector supports debugging commands. (#1802)
- KafkaMQ adds external plugin handle support. (#1797)
- Container collection supports cri-o runtime. (#1763)
- Pipeline adds the `create_point` function for metric generation. (#1803)
- Adds PHP language profiling support. (#1811)

### Bug Fixes {#cl-1.13.0-fix}

- Fixed NPE exceptions in the Cat collector.
- Fixed http response_download time in the Testing collector. (#1820)
- Fixed partial log concatenation issues in containerd log collection. (#1825)
- Fixed the probe failure issue in the `ebpf-conntrack` plugin of the eBPF collector. (#1793)

### Functional Improvements {#cl-1.13.0-opt}

- Optimized bug-report command. (#1810)
- RabbitMQ collector supports multiple simultaneous runs. (#1756)
- Adjusted host object collector. Removed the `state` field. (#1802)
- Optimized error reporting mechanisms to solve eBPF collector error reporting issues. (#1802)
- Added functionality to send information to the center when the Oracle external collector encounters errors. (#1802)
- Optimized Pythond documentation by adding module not found resolution cases. (#1807)
- Added global tag integration test cases to some collectors. (#1791)
- Optimized Oracle integration tests. (#1802)
- OpenTelemetry adds metric sets and dashboards.
- Adjusted k8s event fields. (#1766)
- Added new container collection fields. (#1819)
- Added traffic fields to `httpflow` in the eBPF collector. (#1790)

---

## 1.12.3(2023/08/03) {#cl-1.12.3}

- Fixed delayed log file release issues on Windows (#1805)
- Fixed the issue where initial logs from new containers were not collected
- Fixed several regular expressions that could lead to crashes (#1781)
- Fixed the issue of oversized installation package size (#1804)
- Fixed possible failures when enabling disk caching for log collection

---

## 1.12.2(2023/07/31) {#cl-1.12.2}

- Fixed OpenTelemetry Metric and Trace routing configuration issues

---

## 1.12.1(2023/07/28) {#cl-1.12.1}

- Fixed compatibility issues with older versions of DDTrace Python Profile (#1800)

---

## 1.12.0(2023/07/27) {#cl-1.12.0}

This release is an iterative release and mainly includes the following updates:

### New Features {#cl-1.12.0-new}

- [HTTP API](apis.md##api-sourcemap) adds sourcemap file upload (#1782)
- Added .net Profiling support (#1772)
- Added Couchbase collector (#1717)

### Bug Fixes {#cl-1.12.0-fix}

- Fixed the missing `owner` field issue in the Testing collector (#1789)
- Fixed the missing `host` issue in the DDTrace collector. Also changed the tag collection mechanism for various Traces to blacklist mode[^1776] (#1776)
- Fixed cross-origin issues in RUM API (#1785)

[^1776]: Various Traces carry business fields (referred to as Tags, Annotations, or Attributes). To collect more data, DataKit defaults to accepting these fields.

### Functional Improvements {#cl-1.12.0-opt}

- Optimized encryption algorithm recognition methods and documentation for the SNMP collector; added more examples (#1795)
- Added Kubernetes deployment examples and Git deployment examples for the Pythond collector (#1732)
- Added integration tests for InfluxDB, Solr, NSQ, Net collectors (#1758/#1736/#1759/#1760)
- Added Flink metrics (#1777)
- Extended Memcached and MySQL metrics collection (#1773/#1742)
- Updated DataKit self-exposed metrics (#1492)
- Pipeline added more operator support (#1749)
- Testing collector
    - Added built-in dashboards for the Testing collector (#1765)
    - Optimized Testing task startup to avoid concentrated resource consumption (#1779)
- Documentation updates (#1769/#1775/#1761/#1642)
- Other optimizations (#1777/#1794/#1778/#1783/#1775/#1774/#1737)

---

## 1.11.0(2023/07/11) {#cl-1.11.0}

This release is an iterative release and includes the following updates:

### New Features {#cl-1.11.0-new}

- Added dk collector, removed self collector (#1648)

### Bug Fixes {#cl-1.11.0-fix}

- Fixed timeline redundancy issues in the Redis collector (#1743), improved integration tests
- Fixed dynamic library security issues in the Oracle collector (#1730)
- Fixed DCA service startup failure (#1731)
- Fixed integration tests for MySQL/ElasticSearch collectors (#1720)

### Functional Improvements {#cl-1.11.0-opt}

- Optimized the etcd collector (#1741)
- StatsD collector supports configuring differentiation between different data sources (#1728)
- Tomcat collector supports version 10 and above, deprecated Jolokia (#1703)
- Container log collection supports configuring files inside the container (#1723)
- SQLServer collector improves metrics and refactors integration tests (#1694)

### Compatibility Adjustments {#cl-1.11.0-brk}

The following compatibility changes may cause issues with data collection. If you use any of the features below, consider whether to upgrade or adopt the corresponding new solution.

1. Removed the `deployment` tag from container logs
2. Removed the logic of naming `source` fields for container stdout logs based on `short_image_name`. Now only container name or Kubernetes label `io.kubernetes.container.name` is used for naming[^cl-1.11.0-brk-why-1].
3. Removed the feature of collecting external file paths through container labels (`datakit/logs/inside`), changing it to be implemented via [container environment variables (`DATAKIT_LOGS_CONFIG`)](../integrations/container-log.md)[^cl-1.11.0-brk-why-2].

[^cl-1.11.0-brk-why-1]: In Kubernetes, the value of `io.kubernetes.container.name` remains unchanged, and in host containers, the container name rarely changes. Therefore, the original image name is no longer used as the source of the `source` field.
[^cl-1.11.0-brk-why-2]: Compared to modifying container labels (which generally requires rebuilding the image), appending environment variables to the container is more convenient (environment variables can be injected at container startup).

---

## 1.10.2(2023/07/04) {#cl-1.10.2}

- Fixed identification issues with the prom collector in Kubernetes

## 1.10.1(2023/06/30) {#cl-1.10.1}

- Fixed OpenTelemetry HTTP route customization support
- Fixed the missing `started_duration` field in the host process object

---

## 1.10.0(2023/06/29) {#cl-1.10.0}

This release is an iterative release and includes the following updates:

### Bug Fixes {#cl-1.10.0-fix}

- Fixed Profiling data upload issues under Proxy environments (#1710)
- Fixed default collector activation issues during upgrades (#1709)
- Fixed truncated logs in SQLServer data collection (#1689)
- Fixed Kubernetes Metric Server metric collection issues (#1719)

### Functional Improvements {#cl-1.10.0-opt}

- KafkaMQ supports topic-level multi-line splitting configuration (#1661)
- Kubernetes DaemonSet installation supports modifying Datakit log shard count and shard size via ENV (#1711)
- Kubernetes Pod metrics and object collection adds `memory_capacity` and `memory_used_percent` fields (#1721)
- OpenTelemetry HTTP routes support customization (#1718)
- Oracle collector resolves `oracle_system` metric set loss issues, optimizes collection logic, and adds some metrics (#1693)
- Pipeline adds `in` operator, `value_type()` and `valid_json()` functions, adjusts `load_json()` function behavior when deserialization fails (#1712)
- Host process object collection adds `started_duration` field (#1722)
- Optimized Testing data sending logic (#1708)
- Updated more integration tests (#1666/#1667/#1668/#1693/#1599/#1573/#1572/#1563/#1512/#1715)
- Module restructuring and optimization (#1714/#1680/#1656)

### Compatibility Adjustments {#cl-1.10.0-brk}

- Changed the timestamp unit for Profile data from nanoseconds to microseconds (#1679)

<!-- markdown-link-check-disable -->

---

## 1.9.2(2023/06/20) {#cl-1.9.2}

This release is a mid-cycle iterative release, adding some functionalities for central alignment and fixing some bugs and optimizing others:

### New Features {#cl-1.9.2-new}

- Added [Chrony collector](../integrations/chrony.md) (#1671)
- Added RUM Headless support (#1644)
- Pipeline
    - Added [offload functionality](../pipeline/use-pipeline/pipeline-offload.md) (#1634)
    - Restructured existing documentation (#1686)

### Bug Fixes {#cl-1.9.2-fix}

- Fixed some potential crash issues (!2249)
- HTTP network Testing added Host header support and fixed random error reporting (#1676)
- Fixed automatic discovery issues for Pod Monitor and Service Monitor in Kubernetes (#1695)
- Fixed Monitoring issues (#1702/!2258)
- Fixed Pipeline data misoperation bugs (#1699)

### Functional Improvements {#cl-1.9.2-opt}

- Increased information in Datakit HTTP API returns to aid in error troubleshooting (#1697/#1701)
- Other restructurings (#1681/#1677)
- RUM collector exposes more Prometheus metrics (#1545)
- Enabled pprof functionality in Datakit by default to assist with troubleshooting (#1698)

### Compatibility Adjustments {#cl-1.9.2-brk}

- Removed logging collection support for Kubernetes CRD `guance.com/datakits v1bate1` (#1705)

---

## 1.9.1(2023/06/13) {#cl-1.9.1}

This release is a bug fix release, primarily addressing the following issues:

- Fixed DQL query issues (#1688)
- Fixed potential crash issues due to high-frequency writes in the HTTP interface (#1678)
- Fixed parameter override issues with the `datakit monitor` command (!2232)
- Fixed retry error reporting issues when uploading data via HTTP (#1687)

---

## 1.9.0(2023/06/08) {#cl-1.9.0}
This release is an iterative release and includes the following updates:

### New Features {#cl-1.9.0-new}

- Added [NodeJS Profiling](../integrations/profile-nodejs.md) support (#1638)
- Added support for [Cat](../integrations/cat.md) (#1593)
- Added [debugging methods](why-no-data.md#check-input-conf) for collector configurations (#1649)

### Bug Fixes {#cl-1.9.0-fix}

- Fixed connection leakage issues caused by Prometheus metric collection in K8s (#1662)

### Functional Improvements {#cl-1.9.0-opt}

- Added `age` field to K8s DaemonSet objects (#1670)
- Optimized [PostgreSQL](../integrations/postgresql.md) startup settings (#1658)
- SkyWalking added [`/v3/log/`](../integrations/skywalking.md) support (#1654)
- Optimized log collection handling (#1652/#1651)
- Optimized [upgrade documentation](datakit-update.md#prepare) (#1653)
- Other restructurings and optimizations (#1673/#1650/#1630)
- Added several integration tests (#1440/#1429)
    - PostgreSQL
    - Network Testing

---

## 1.8.1(2023/06/01) {#cl-1.8.1}
This release is a bug fix release, primarily addressing the following issues:

- Fixed KafkaMQ crashes in multi-instance scenarios (#1660)
- Fixed incomplete disk device collection in DaemonSet mode (#1655)

---

## 1.8.0(2023/05/25) {#cl-1.8.0}
This release is an iterative release and includes the following updates:

### New Features {#cl-1.8.0-new}

- Datakit added two debugging commands to help users write glob and regular expressions during configuration (#1635)
- Added bidirectional transmission functionality between DDTrace and OpenTelemetry Trace IDs (#1633)

### Bug Fixes {#cl-1.8.0-fix}

- Fixed pre-testing issues (#1629)
- Fixed two field issues in SNMP collection (#1632)
- Fixed default port conflicts during service upgrades (#1646)

### Functional Improvements {#cl-1.8.0-opt}

- eBPF collects Kubernetes network data and supports converting Cluster IP to Pod IP (manual activation required) (#1617)
- Added a batch of integration tests (#1430/#1574/#1575)
- Optimized container network-related metrics (#1397)
- Bug report functionality added crash information collection (#1625)
- PostgreSQL collector:
    - Added custom SQL metric collection (#1626)
    - Added DB-level tags (#1628)
- Optimized `host` field issues for localhost collection (#1637)
- Optimized Datakit self-metrics and added [Datakit self-metrics documentation](datakit-metrics.md) (#1639/#1492)
- Optimized Prometheus metric collection on Pods, automatically supporting all Prometheus metric types (#1636)
- Added [performance testing documentation](../integrations/datakit-trace-performance.md) for Trace-type collections (#1616)
- Added Kubernetes DaemonSet object collection (#1643)
- Pinpoint gRPC service supports `x-b3-traceid` Trace ID transmission (#1605)
- Optimized cluster election strategies (#1534)
- Other optimizations (#1609/#1624)

### Compatibility Adjustments {#cl-1.8.0-brk}

- Removed `kube_cluster_role` object collection from the container collector (#1643)

---

## 1.7.0(2023/05/11) {#cl-1.7.0}
This release is an iterative release and includes the following updates:

### New Features {#cl-1.7.0-new}

- RUM Sourcemap added Mini Program support (#1608)
- Added a new collection election strategy, supporting Cluster-level elections in K8s environments (#1534)

### Bug Fixes {#cl-1.7.0-fix}

- When uploading Datakit data, if the center returned a 5XX status code, it would increase the number of Layer 4 connections. This version fixes this issue while exposing more connection-related configuration parameters in [*datakit.conf*](datakit-conf.md#maincfg-example) (configurable via [environment variables](datakit-daemonset-deploy.md#env-dataway) in K8s) (DK001-15)

### Functional Improvements {#cl-1.7.0-opt}

- Optimized process object collection, defaulting to disabling some potentially high-consumption fields (e.g., open file counts/port counts). These fields can be manually enabled via collector configuration or environment variables. While these fields may be important, we believe they should not lead to unexpected performance overhead on the host by default (#1543)
- Optimized Datakit self-metrics:
    - Added Prometheus metric exposure for the Testing collector to troubleshoot potential issues within the Testing collector itself (#1591)
    - Added HTTP layer metric exposure for Datakit reporting (#1597)
    - Added metric exposure for KafkaMQ collection
- Optimized PostgreSQL metric collection, adding more related metrics (#1596)
- Optimized JVM-related metric collection, mainly updating documentation (#1600)
- Pinpoint:
    - Added more developer documentation (#1601)
    - Fixed gRPC Service support for Pinpoint (#1605)
- Optimized disk metric collection differences across platforms (#1607)
- Other engineering optimizations (#1621/#1611/#1610)
- Added several integration tests (#1438/#1561/#1585/#1435/#1513)

---

## 1.6.1(2023/04/27) {#cl-1.6.1}

This release is a Hotfix release and fixes the following issues:

- Blacklists might not take effect after upgrading from old versions (#1603)
- [Prom](../integrations/prom.md) collector had issues collecting `info` type data (#1544)
- Fixed data loss issues potentially caused by the Dataway Sinker module (#1606)

---

## 1.6.0(2023/04/20) {#cl-1.6.0}

This release is an iterative release and includes the following updates:

### New Features {#cl-1.6.0-new}

- Added [Pinpoint](../integrations/pinpoint.md) API integration (#973)

### Functional Improvements {#cl-1.6.0-opt}

- Optimized Windows installation script and upgrade script outputs, making them easier to copy directly into terminals (#1557)
- Optimized Datakit documentation build process (#1578)
- Optimized OpenTelemetry field processing (#1514)
- [Prom](prom.md) collector now supports collecting `info` type labels and appending them to all associated metrics (default enabled) (#1544)
- In the [system collector](system.md), added CPU and memory usage percentage metrics (#1565)
- Datakit now adds a data point count marker (`X-Points`) to sent data, aiding in building related metrics at the center (#1410)
    - Additionally, optimized the `User-Agent` marking in Datakit HTTP to the format `datakit-<os>-<arch>/<version>`
- [KafkaMQ](kafkamq.md):
    - Supports processing Jaeger data (#1526)
    - Optimized SkyWalking data processing flow (#1530)
    - Added third-party RUM integration functionality (#1581)
- [SkyWalking](skywalking.md) added HTTP integration functionality (#1533)
- Added the following integration tests:
    - [Apache](apache.md)(#1553)
    - [JVM](jvm.md)(#1559)
    - [Memcached](memcached.md)(#1552)
    - [MongoDB](mongodb.md)(#1525)
    - [RabbitMQ](rabbitmq.md)(#1560)
    - [Statsd](statsd.md)(#1562)
    - [Tomcat](tomcat.md)(#1566)
    - [etcd](etcd.md)(#1434)

### Bug Fixes {#cl-1.6.0-fix}

- Fixed issues with recognizing time precision when writing [JSON-formatted](apis.md#api-json-example) data (#1567)
- Fixed non-functional Testing collector issues (#1582)
- Fixed eBPF verifier issues on Euler systems (#1568)
- Fixed RUM sourcemap segmentation fault issues (#1458)
<!-- - Fixed high-CPU issues potentially caused by the process object collector; by default, disabled collection of some high-consumption fields (listening ports) (#1543) -->

### Compatibility Adjustments {#cl-1.6.0-brk}

- Removed old command-line styles, such as the original `datakit --version`, which will no longer work and must be replaced with `datakit version`. See [various command usages](datakit-tools-how-to.md).

---

<!-- markdownlint-disable -->

## 1.5.10(2023/04/13) {#cl-1.5.10}

This release is an emergency release and includes the following updates:

### New Features {#cl-1.5.10-new}

- Supported auto-discovery and collection of [Pod Prometheus metrics](kubernetes-prom.md#auto-discovery-metrics-with-prometheus) (#1564)
- Pipeline added aggregation functions (#1554)
    - [agg_create()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-agg-create)
    - [agg_metric()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-agg-metric)

### Functional Improvements {#cl-1.5.10-opt}

- Optimized Pipeline execution performance, improving it by approximately 30%
- Optimized historical position recording operations in log collection (#1550)

---

## 1.5.9 (2023/04/06) {#cl-1.5.9}
This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.9-new}

- Added [remote service](datakit-update.md#remote), used to manage Datakit upgrades (#1441)
- Added [troubleshooting feature](why-no-data.md#bug-report) (#1377)

### Issue Fixes {#cl-1.5.9-fix}

- Fixed CPU metrics collection for Datakit itself, ensuring synchronization between `monitor` and the `top` command (#1547)
- Fixed RUM collector panic error (#1548)

### Feature Optimization {#cl-1.5.9-opt}

- Optimized upgrade functionality, preventing corruption of *datakit.conf* files (#1449)
- Optimized [cgroup configuration](datakit-conf.md#resource-limit), removed CPU minimum value restriction (#1538)
- Optimized *self* collector; we can now choose whether to enable this collector and improved its performance (#1386)
- Simplified existing monitor display due to new troubleshooting methods (#1505)
- [Prometheus collector](prom.md) allows adding *instance tag* to maintain consistency with native Prometheus system (#1517)
- [DCA](dca.md) added Kubernetes deployment method (#1522)
- Optimized disk cache performance for log collection (#1487)
- Exposed more [Prometheus metrics](apis.md#api-metrics) by optimizing Datakit's own metric system (#1492)
- Optimized [/v1/write](apis.md#api-v1-write) (#1523)
- Improved token error prompt during installation (#1541)
- Monitor automatically retrieves connection address from *datakit.conf* (#1547)
- Removed mandatory kernel version checks for eBPF, supporting more kernel versions (#1542)
- [Kafka subscription collection](kafkamq.md) supports multi-line JSON function (#1549)
- Added a large number of integration tests (#1479/#1460/#1436/#1428/#1407)
- Optimized IO module configuration, added upload worker count configuration field (#1536)
    - [Kubernetes](datakit-daemonset-deploy.md#env-io)
    - [*datakit.conf*](datakit-conf.md#io-tuning)

### Compatibility Adjustments {#cl-1.5.9-brk}

- Removed most Sinker functions, retaining only the [Sinker function on Dataway](datakit-sink-dataway.md) (#1444). The [host installation configuration](datakit-install.md#env-sink) and [Kubernetes installation configuration](datakit-daemonset-deploy.md#env-sinker) for sinker have been adjusted. Please pay attention when upgrading.
- Due to performance issues, replaced the implementation of the old version's [failed send disk cache](datakit-conf.md#io-disk-cache). The new implementation no longer maintains compatibility in binary format. If upgrading, old data will not be recognized. It is recommended to **manually delete old cache data** (old data may affect the new version's disk cache), then upgrade to the new version of Datakit. Despite this, the new version's disk cache remains an experimental feature, use with caution.
- Updated Datakit's own metric system. There will be some missing metrics obtained by DCA, but it does not affect the normal operation of DCA.

---

## 1.5.8 (2023/03/24) {#cl-1.5.8}
This release is an iterative update, mainly focusing on issue fixes and feature improvements.

### Issue Fixes {#cl-1.5.8-fix}

- Fixed potential loss of container log collection (#1520)
- Automatically created Pythond directory after Datakit starts (#1484)
- Removed single-instance restrictions for the [HOST directory](hostdir.md) collector (#1498)
- Fixed an eBPF numeric construction issue (#1509)
- Fixed parameter recognition issue for Datakit monitor (#1506)

### Feature Optimization {#cl-1.5.8-opt}

- Added missing memory-related metrics for the Jenkins collector (#1489)
- Enhanced [cgroup v2](datakit-conf.md#resource-limit) support (#1494)
- Added environment variable (`ENV_CLUSTER_K8S_NAME`) to configure cluster name during Kubernetes installation (#1504)
- Pipeline
    - Added forced protection measures to [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) function to prevent data expansion (#1510)
    - Optimized deletion key functionality for [`json()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) and [`delete()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-delete) regarding JSON processing.
- Other engineering optimizations (#1500)

### Documentation Adjustments {#cl-1.5.8-doc}

- Added documentation for full offline Kubernetes installation [guide](datakit-offline-install.md#k8s-offline) (#1480)
- Enhanced StatsD and DDTrace-Java related documentation (#1481/#1507)
- Supplemented TDEngine related documentation (#1486)
- Removed outdated field descriptions in disk collector documentation (#1488)
- Enhanced Oracle collector documentation (#1519)

## 1.5.7 (2023/03/09) {#cl-1.5.7}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.7-new}

- Pipeline
    - Added [key deletion](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) functionality to `json` function (#1465)
    - Added [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) function (#1414)
    - Added [time functions](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-datetime) (#1411)
- Added [IPv6 support](datakit-conf.md#config-http-server) (#1454)
- Disk IO collection supports [io wait extended metrics](diskio.md#extend) (#1472)
- Container collection supports [coexistence of Docker and containerd](container.md#requrements) (#1401)
- Integrated [Datakit Operator configuration documentation](datakit-operator.md) (#1482)

### Issue Fixes {#cl-1.5.7-fix}

- Fixed Pipeline bugs (#1476/#1469/#1471/#1466)
- Fixed container Pending caused by missing `request` in *datakit.yaml* (#1470)
- Fixed repeated probing issues during cloud synchronization (#1443)
- Fixed encoding errors in log disk cache (#1474)

### Feature Optimization {#cl-1.5.7-opt}

- Optimized Point Checker (#1478)
- Optimized performance of Pipeline [`replace()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-replace.md) (#1477)
- Optimized Datakit installation process on Windows (#1404)
- Optimized configuration handling process for [configuration center](confd.md) (#1402)
- Added [Filebeat](beats_output.md) integration testing capability (#1459)
- Added [Nginx](nginx.md) integration testing capability (#1399)
- Refactored [OpenTelemetry Agent](opentelemetry.md) (#1409)
- Refactored [Datakit Monitor information](datakit-monitor.md#specify-module) (#1261)

---

## 1.5.6 (2023/02/23) {#cl-1.5.6}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.6-new}

- Command line added [parse line protocol function](datakit-tools-how-to.md#parse-lp) (#1412)
- Datakit yaml and helm support resource limit configuration (#1416)
- Datakit yaml and helm support CRD deployment (#1415)
- Added SQLServer integration testing (#1406)
- RUM supports [resource CDN annotation](rum.md#cdn-resolve) (#1384)

### Issue Fixes {#cl-1.5.6-fix}

- Fixed RUM request returning 5xx issue (#1412)
- Fixed log collection path error issue (#1447)
- Fixed K8s Pod(`restarts`) field issue (#1446)
- Fixed DataKit filter module crash issue (#1422)
- Fixed tag key naming issue in Point construction (#1413#1408)
- Fixed Datakit Monitor character set issue (#1405)
- Fixed OTEL tag coverage issue (#1396)
- Fixed public API whitelist issue (#1467)

### Feature Optimization {#cl-1.5.6-opt}

- Optimized handling of invalid tasks in Testing (#1421)
- Optimized Windows installation prompts (#1404)
- Optimized Powershell installation script template for Windows (#1403)
- Optimized association methods for Pod/ReplicaSet/Deployment in K8s (#1368)
- Refactored point data structure and functionality (#1400)
- Datakit includes [eBPF](ebpf.md) collector binary installation (#1448)
- Installation program address changed to CDN address, optimizing download issues (#1457)

### Compatibility Adjustments {#cl-1.5.6-brk}

- Removed redundant command `datakit install --datakit-ebpf` due to built-in eBPF collector (#1400)

---

## 1.5.5 (2023/02/09) {#cl-1.5.5}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.5-new}

- Customizable default collectors for Datakit HOST installation (#1392)
- Provided OTEL error tracking (#1309)
- Provided RUM Session replay capability (#1283)

### Issue Fixes {#cl-1.5.5-fix}

- Fixed log backlog issue (#1394)
- Fixed duplicate startup of collectors in conf.d (#1385)
- Fixed OTEL data association issue (#1364)
- Fixed OTEL data field coverage issue (#1383)
- Fixed Nginx Host recognition error (#1379)
- Fixed Testing timeout (#1378)
- Fixed cloud vendor instance recognition (#1382)

### Feature Optimization {#cl-1.5.5-opt}

- Datakit Pyroscope Profiling multi-program language recognition (#1374)
- Optimized CPU,Disk,eBPF,Net etc. Chinese and English documents (#1375)
- Optimized ElasticSearch, PostgreSQL, DialTesting etc. English documents (#1373)
- Optimized DCA,Profiling documents (#1371#1372)
- Optimized log collection process (#1366)
- [IP library installation document update](datakit-tools-how-to.md) configuration method document support (#1370)

---

## 1.5.4 (2023/01/13) {#cl-1.5.4}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.4-new}

- [Confd added Nacos backend](confd.md) (#1315#1327)
- Log collector added LocalCache feature (#1326)
- Supported [C/C++ Profiling](profile-cpp.md) (#1320)
- RUM Session Replay file reporting (#1283)
- WEB DCA supported remote config update (#1284)

### Issue Fixes {#cl-1.5.4-fix}

- Fixed K8S collection failure data loss (#1362)
- Fixed K8S Host field error (#1351)
- Fixed K8S Metrics Server timeout (#1353)
- Fixed Containerd environment annotation configuration issue (#1352)
- Fixed Datakit collector crash during reload (#1359)
- Fixed Golang Profiler function execution time calculation error (#1335)
- Fixed Datakit Monitor character set issue (#1321)
- Fixed async-profiler service display issue (#1290)
- Fixed Redis collector `slowlog` issue (#1360)

### Feature Optimization {#cl-1.5.4-opt}

- Optimized SQL data resource usage problem (#1358)
- Optimized Datakit Monitor (#1222)

---

## 1.5.3 (2022/12/29) {#cl-1.5.3}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.3-new}

- Prometheus collector supports data collection via Unix Socket (#1317)
- Allowed [non-root user to run DataKit](datakit-install.md#common-envs) (#1153)

### Issue Fixes {#cl-1.5.3-fix}

- Fixed netstat collector link count issue (#1276/#1336)
- Fixed Go profiler difference issue (#1328)
- Fixed Datakit restart timeout issue (#1297)
- Fixed Kafka subscription message truncation issue (#1338)
- Fixed Pipeline `drop()` function ineffective issue (#1343)

### Feature Optimization {#cl-1.5.3-opt}

- Optimized `httpflow` protocol judgment in eBPF (#1318)
- Optimized Datakit installation and upgrade commands on Windows (#1316)
- Optimized Pythond encapsulation usage (#1304)
- Pipeline provides more detailed operation error messages (#1262)
- Pipeline Ref-Table provides local storage implementation based on SQLite (#1158)
- Optimized SQLServer timeline issue (#1345)

---

## 1.5.2 (2022/12/15) {#cl-1.5.2}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.2-new}

- Added [Golang Profiling](profile-go.md) access (#1265)

### Issue Fixes {#cl-1.5.2-fix}

- logfwd fixed non-collection issue (#1288)
- Fixed cgroup ineffectiveness issue (#1293)
- Fixed DataKit service operation timeout issue (#1297)
- Fixed possible deadlock issue in SQLServer collection (#1289)

### Feature Optimization {#cl-1.5.2-opt}

- logfwd supports injection of image fields via `LOGFWD_TARGET_CONTAINER_IMAGE` (#1299)
- Trace collector:
    - Optimized error-stack/error-message format issue (#1307)
    - Adjusted SkyWalking compatibility to support 8.X series (#1296)
- eBPF `httpflow` added `pid/process_name` fields (#1218/#1124), optimized kernel version support (#1277)
- *datakit.yaml* has been updated, it is recommended to update to the new yaml (#1253)
- GPU card collection supports remote mode (#1312)
- Other detail optimizations (#1311/#1260/#1301/#1291/#1298/#1305)

### Compatibility Adjustments {#cl-1.5.2-brk}

- Removed `datakit --man` command

---

## 1.5.1 (2022/12/01) {#cl-1.5.1}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.1-new}

- Added Python Profiling access (#1146)
- Pythond added custom event reporting function (#1174)
- Netstat supports specific port metric collection (#1276)

### Issue Fixes {#cl-1.5.1-fix}

- Fixed timestamp precision issue in API write interface JSON write (#1264)
- Fixed Windows GPU data collection issue (#1268)
- Other issue fixes (#1273/#1278/#1279/#1285/#1281/#1282)

### Feature Optimization {#cl-1.5.1-opt}

- Optimized Redis collector CPU usage collection, added new metric fields (#1263)
- Optimized logfwd collector configuration (#1280)
- Completed host object field collection, added network, disk-related fields (#1252)

---

## 1.5.0 (2022/11/17) {#cl-1.5.0}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.5.0-new}

- Added [SNMP collector](snmp.md) (#1068)
- Added [IPMI collector](ipmi.md) (#1085)

### Issue Fixes {#cl-1.5.0-fix}

- Fixed unexpected collector start under Git-managed configuration file mode (#1250)
- Fixed Jaeger trace collection TraceID issue (#1251)
- Fixed potential memory leak issue in container collector under extreme conditions (#1256)
- Fixed Windows proxy installation issue (#1244)
- Other fixes (#1259)

### Feature Optimization {#cl-1.5.0-opt}

- Added batch injection of [DDTrace-Java tools](../developers/ddtrace-attach.md) (#786)
- Enhanced SQL desensitization function in the latest [DDTrace-Java SDK](../developers/ddtrace-guance.md) (#789)
- Remote Pipeline optimization (the following two features require Studio to be upgraded to the version after 2022/11/17):
    - Pipeline supports source mapping relationship configuration, facilitating batch configuration between Pipeline and data sources (#1211)
    - Pipeline provides function classification information, facilitating remote Pipeline writing (#1150)
- Optimized [Kafka message subscription](kafkamq.md), no longer limited to obtaining SkyWalking-related data, while supporting rate limiting, multi-version coverage, sampling, and load balancing settings (#1212)
- Alleviated short lifecycle Pod log collection issues by providing additional configuration parameters (`ENV_INPUT_CONTAINER_LOGGING_SEARCH_INTERVAL`) (#1255)
- Supported [label-based](container-log.md#logging-with-annotation-or-label) configuration of log collection inside containers in pure container environments (#1187)
- [SQLServer collector](sqlserver.md) added more measurement collection (#1216)
- Added Pipeline functions (#1220/#1224)
    - [sample()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-sample): Sampling function
    - [b64enc()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-b64enc): Base64 encoding function
    - [b64dec()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-b64dec): Base64 decoding function
    - [append()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-append): List append function
    - [url_parse()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-url-parse): HTTP URL parsing function

- Various document improvements (#1242/#1238/#1247)

## 1.4.20 (2022/11/03) {#cl-1.4.20}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.4.20-new}

- Improved Prometheus ecosystem compatibility, added [ServiceMonitor and PodMonitor collection identification](kubernetes-prometheus-operator-crd.md) (#1130)
- Added [Java Profiling access based on async-profiler](profile-java-async-profiler.md) (#1240)

### Issue Fixes {#cl-1.4.20-fix}

- Fixed Prom collector log chaos issue (#1226)
- Fixed DDTrace trace-id conversion overflow issue, which could lead to trace/span loss (#1235)
- Fixed ElasticSearch collector interruption issue (#1236)
- Fixed multiple open collector issue under Git mode (#1241)

### Feature Optimization {#cl-1.4.20-opt}

- Added [interval parameter](ebpf.md#config) to eBPF collection, facilitating adjustment of collected data volume (#1106)
- All remote collectors default to using their collection address as the value of the `host` field, avoiding possible misunderstanding of the `host` field value during remote collection (#1120)
- APM data collected by DDTrace can automatically extract error-related fields, facilitating better APM error tracking at the center (#1161)
- MySQL collector added extra fields (`Com_commit/Com_rollback`) collection (#1206)
- Optimized GPU collector to adapt to more graphics card vendors (#1232)
- Other improvements (#1204/#1231/#1233)

---

## 1.4.19 (2022/10/20) {#cl-1.4.19}

This release is an iterative update, with the following main updates:

### New Features {#cl-1.4.19-new}

- DataKit collector configuration and Pipeline support [sync through etcd/Consul configuration centers](confd.md) (#1090)

### Issue Fixes {#cl-1.4.19-fix}

- Fixed Windows Event collection data issue (#1200)
- Fixed prom debugger not working issue (#1192)

### Feature Optimization {#cl-1.4.19-opt}

- Prometheus Remote Write optimization
    - Collection supports filtering tags via regular expressions (#1197)
    - Supports filtering metric set names via regular expressions (#1196)

- Pipeline optimization (#1188)
    - Optimized [grok()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-grok) and other functions so they can be used in `if/else` statements to determine if operations are effective
    - Added [match()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-match) function
    - Added [cidr()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-cidr) function (#733)
    <!-- - Pipeline functions added category support, making it easier for users to quickly locate operation functions in the Studio page (#1150) -->

- Process collector added opened file list details field (#1173)
- Improved disk cache and queue processing for external access class data (T/R/L) (#971)
- Added overage warning on Monitor: In the bottom of the monitor, if current space usage exceeds limits, there will be a red text `Beyond Usage` warning (#1025)
- Optimized log collection position function, mounting the file to the host machine in container environments to avoid losing original position records after DataKit restarts (#1203)
- Optimized log collection delay issues in sparse log scenarios (#1202)


### Compatibility Adjustments {#cl-1.4.19-brk}

Due to changes in log collection position storage (both storage location and storage format have changed), after updating to this version, the original position will become invalid. During the upgrade gap, logs generated will not be collected. Please proceed cautiously.

---

## 1.4.18 (2022/10/13) {#cl-1.4.18}

This release is a Hotfix release, with the following main updates:

- Fixed Docker log 16k truncation issue (#1185)
- Fixed log swallowing in automatic multiline cases, leading to no log collection after container restarts (#1162)
- Optimized eBPF DNS data collection, automatically appending Kubernetes-related tags, pre-aggregating part of the data, reducing the amount of collected data (#1186)
- Supported subscribing to SkyWalking-based log data from Kafka (#1155)
- Optimized host object collection fields (#1171)
- Other minor optimizations (#1159/#1177/#1160)

---

## 1.4.17 (2022/10/8) {#cl-1.4.17}

This release is an iterative update, with the following main updates.

### New Features {#cl-1.4.17-new-features}

- Added [Promtail collector](promtail.md) (#644)
- Added [NVIDIA GPU metrics collector](nvidia_smi.md) (#1005)
- Supported discovering (manual activation required) services with Prometheus Service in Kubernetes clusters and implementing Prometheus metrics collection (#1123)
- Supported subscribing to SkyWalking-based metrics, logs, and Trace data from Kafka, uploading them separately as corresponding data types to Guance (#1127)

### Issue Fixes {#cl-1.4.17-fix}

- Fixed logging socket collector crash issue (#1129)
- Fixed Redis collection issue (#1134)
- Fixed MySQL collector interruption issue when collecting PolarDB due to errors (#1147)
- Fixed non-working default-enabled collectors in git mode issue (#1154)
- Fixed Kafka metrics set missing issue (#1170)
- Fixed Test collection data upload error issue (#1175)
- Fixed statsd collector log issue (#1164)

### Optimizations {#cl-1.4.17-opt}

- Replaced some potentially vulnerable third-party libraries (#1100)
- Added special HTTP headers in DataKit API responses to avoid CORB issues (#1136)

- Network Testing
    - Added IP field for TCP/HTTP (#1108)
    - Adjusted units for some fields (#1113)

- Adjusted remote Pipeline debugging API (#1128)
- Added [singleton operation control](datakit-input-conf.md#input-singleton) for collectors (#1109)
- Changed log-type data (all except metrics) reporting in IO module to blocking mode (#1121)
- Optimized terminal prompts during installation/upgrade (#1145)
- Other documentation and performance optimizations (#1152/#1149/#1148)

### Breaking Changes {#cl-1.4.17-bc}

- In Redis collector, latency time-series data was changed to log data (#1144)
- Removed environment variable `ENV_K8S_CLUSTER_NAME`, recommended to use global tag method to set Kubernetes cluster name (#1152)

---

## 1.4.16 (2022/09/15) {#cl-1.4.16}

This release is an iterative update, with the following main updates.

### New Features {#cl-1.4.16-new-features}

- Added automatic cloud synchronization function, no longer requiring manual specification of cloud vendors (#1074)
- Supported syncing k8s labels as tags to pod metrics and logs (#1101)
- Supported collecting various k8s yaml information to corresponding [object data](container.md#objects) (#1102)
- Trace collection supports automatically extracting some key meta information (#1092)
- Supported specifying installation source address during installation to simplify [offline installation](datakit-offline-install.md) process (#1065)
- [Pipeline](../pipeline/use-pipeline/index.md) added features:
    - Added support for for loops/dictionaries/arrays (#1037/#1093)
    - Added arithmetic expression support (#798)
    - Pipeline error messages will be displayed on the collected data (#784/#1091)
    - If time field segmentation fails, supports automatic correction of time field (`time`) to avoid inability to display time on the console page (#1091)
    - Added [len()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-len) function

### Issue Fixes {#cl-1.4.16-fix}

- Fixed DataKit service not auto-starting after OOM issue (#691)
- Fixed prom collector metric filtering issue (#1084)
- Fixed unit, documentation, and other issues in MySQL collector (#1122)
- Fixed MongoDB collector issues (#1096/#1098)
- Fixed collection of some invalid fields in Trace data (#1083)

---

## 1.4.15 (2022/09/13) {#cl-1.4.15}

This release is a Hotfix release, significantly improving the efficiency of log data collection and transmission.

---

## 1.4.14 (2022/09/09) {#cl-1.4.14}

This release is a Hotfix release, with the following main updates:

- Corrected [disk collector](disk.md) metric collection, automatically ignoring some non-physical disks; similar handling was done for disks on host objects (#1106)
- Fixed the issue of disk collector failing to collect metrics on Windows (#1114)
- Fixed data duplication collection caused by resource leaks in Git-managed configurations (#1107)
- Fixed [SQLServer collector](sqlserver.md) connection issues caused by complex passwords (#1119)
- Fixed missing `application/json` Content-Type in [DQL API requests](apis.md#api-raw-query) (#1119)
- Adjusted Pipeline-related documentation, moving it to the "Custom Development" section:

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.14-dk-docs.gif){ width="300"}
</figure>

---

## 1.4.13 (2022/09/01) {#cl-1.4.13}

### Collector Function Adjustments {#cl-1.4.13-features}

- Optimized data processing in the IO module, enhancing data throughput efficiency (#1078)
- Added disk caching functionality to various Traces (#1023)
- Added goroutine usage-related metrics (`datakit_goroutine`) to DataKit's own metrics set (#1039)
- Added `mysql_dbm_activity` metrics set to MySQL collector (#1047)
- Added [netstat collector](netstat.md) (#1051)
- Added log collection for TDengine (#1057/#1076)
- Optimized `fstype` filtering in disk collector, defaulting to collecting common file systems (#1063/#1066)
- Added `message_length` field to each log in log collector, indicating the length of the current log, facilitating filtering logs by length (#1086)
- Supported locating Pod scope via DaemonSet in CRD (#1064)
- Removed `go-bindata` dependency in eBPF (#1062)
- Default enabled k8s and container-related metrics in container collector, consuming additional timelines to some extent (#1095)
- Updated Datakit bundled DDTrace-Java SDK to the latest version (*[Datakit installation directory]/data/dd-java-agent-0.107.1.jar*)

### Bug Fixes {#cl-1.4.13-bugfix}

- Fixed incorrect calculation of DataKit's own CPU usage (#983)
- Fixed middleware recognition issue in SkyWalking (#1027)
- Fixed Oracle collector exit issue (#1042/#1048)
- Fixed Sink DataWay failure issue (#1056)
- Fixed JSON write issue in HTTP /v1/write/:category interface (#1059)

### Breaking Changes {#cl-1.4.13-br}

- Adjusted time fields related to CI/CD data in GitLab and Jenkins collectors to unify data display effects on the front-end page (#1089)

### Documentation Adjustments {#cl-1.4.13-docs}

- Added jump tags to almost every chapter, facilitating permanent references from other documents
- Moved Pythond documentation to the developer directory
- Moved collector documentation from the original "Integration" section to the "DataKit" documentation library (#1060)

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-docs.gif){ width="300"}
</figure>

- Adjusted DataKit documentation directory structure, reducing directory levels

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-dk-doc-dirs.gif){ width="300"}
</figure>

- Added k8s configuration entry points to almost every collector

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-install-selector.gif){ width="800" }
</figure>

- Adjusted document header display, adding election identifiers besides operating system identifiers for collectors that support elections

<figure markdown>
  ![](https://static.guance.com/images/datakit/cl-1.4.13-doc-header.gif){ width="800" }
</figure>

---

## 1.4.12 (2022/08/26) {#cl-1.4.12}

This release belongs to the Hotfix category, with the following updates:

- Adjusted CPU collection values under Windows to align with the numbers on the Windows Process Monitor (#1002)
- Adjusted locking behavior when sending Dataway, which could cause data transmission to slow down
- Log Collection:
    - Default I/O behavior changed to blocking mode
    - Multi-line recognition enabled by default
    - Adjusted file rotate tailing strategy to avoid potential large data packets (#1072)
    - Updated documentation related to environment variables (#1071)
    - Added `log_read_time` field in log line protocol to record UNIX timestamp during collection (#1077)

### Breaking Changes {#cl-1.4.12-brk}

- Removed global blocking (`blocking_mode`) and data classification-based blocking (`blocking_categories`) settings for the I/O module (both disabled by default). **If this option was manually turned on, it will no longer take effect in the new version**.

---

## 1.4.11 (2022/08/17) {#cl-1.4.11}

### New Features {#cl-1.4.11-newfeature}

- Added [Ref-Table Function](../pipeline/use-pipeline/pipeline-refer-table/) in Pipeline (#967)
- DataKit 9529 HTTP [supports binding to domain socket](datakit-conf.md#uds) (#925)
    - Corresponding changes required in [eBPF Collection](ebpf.md) and [Oracle Collection](oracle.md) configurations.
- RUM sourcemap added Android R8 support (#1040)
- CRD added log configuration support (#1000)
    - [Complete Example](kubernetes-crd.md#example)

### Optimization {#cl-1.4.11-optimize}

- Optimized [Container Collector](container.md) documentation
- Added [Common Tags](common-tags.md) documentation (#839)
- Optimized [election configuration](election.md#config) and some related naming (#1026)
- Election collectors still support disabling election functions on specific collectors even if DataKit election is enabled (#927)
- Supports specifying data type for [I/O block configuration](datakit-daemonset-deploy.md#env-io) (#1021)
- DDTrace collector sampling added meta information recognition (#927)
- DataKit's own metrics set added 9529 [HTTP request-related metrics](self.md#datakit_http) (#944)
- Optimized [Zipkin Collection](zipkin.md) memory usage (#1013)
- DDTrace collector defaults to blocking IO feed after enabling disk cache (#1038)
- [eBPF](ebpf.md#measurements) added process name (`process_name`) field (#1045)
- [DCA](dca.md) released a new version
- HTTP data writing for logs (Log Streaming/Jaeger/OpenTelemetry/Zipkin) all added queue support (#971)
- Log collection added automatic multi-line support (#1024)

### Bug Fixes {#cl-1.4.11-bugs}

- Fixed [MySQL Collector](mysql.md) connection leak issue (#1041)
- Fixed Pipeline JSON value issue (#1036)
- Fixed macOS ulimit setting ineffective issue (#1032)
- Fixed sinker-Dataway invalid in Kubernetes issue (#1031)
- Fixed [HTTP data write interface](apis.md#api-v1-write) data validation issue (#1046)
- Fixed eBPF collector failing due to kernel change structure offset calculation issue (#1049)
- Fixed DDTrace close-resource issue (#1035)

---

## 1.4.10 (2022/08/05) {#cl-1.4.10}

This release belongs to the iterative update category, with the following updates:

- Partial data types that fail to send now support caching to disk and resending later (#945)
- Support sending data satisfying conditions to different workspaces via different Dataway addresses (#896)
- Sourcemap added Android and iOS support (#886)

- Container Collector related updates:
    - Fixed incorrect collection of Node host operating system information in Kubernetes (#950)
    - Prom collection in Kubernetes no longer automatically appends pod-related information, avoiding excessive time series growth (#965)
    - Appended corresponding YAML information to Pod objects (#969)

- Pipeline related updates:
    - Optimized Pipeline execution steps (#1007)
    - [`grok()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-grok) and [`json()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) functions now perform trim-space operation by default (#1001)

- DDTrace related updates:
    - Fixed potential goroutine leakage issue (#1008)
    - Supported configuring disk cache to alleviate memory usage (#1014)

- Other Bug Fixes:
    - Optimized line protocol construction (#1016)
    - Removed regular cleanup of tail data in log collection to mitigate possible log truncation issues (#1012)

### Breaking Changes {#cl-1.4.10-break-changes}

Since the RUM added Sourcemap support with more configuration options, the RUM collector is no longer enabled by default and must be [manually enabled](rum.md#config).

---

## 1.4.9 (2022/07/26) {#cl-1.4.9}

This release belongs to the Hotfix category, with the following updates:

- eBPF `httpflow` added support for Linux 4.5 and above kernel versions (#985)
- Fixed external collector election mode issues (#976/#946)
- Fixed container collector crash issues (#956/#979/#980)
- Fixed Redis `slowlog` collection issues (#986)

---

## 1.4.8 (2022/07/21) {#cl-1.4.8}

This release belongs to the iterative update category, with the following updates:

- prom collector internal timeout changed to 3 seconds (#958)

- Log-related issue fixes:
    - Added `log_read_offset` field to log collection (#905)
    - Fixed the problem where rotated log files did not correctly read remaining content from the tail (#936)

- Container collection-related issue fixes:
    - Fixed incompatibility with `NODE_NAME` environment variable (#957)
    - Changed k8s auto-discovery prom collector to serial distributed collection, each k8s node only collects prom metrics from its own machine (#811/#957)
    - Added log source and multi-line [mapping configuration](container.md#env-config) (#937)
    - Fixed bug where containers replacing source still used previous multiline and Pipeline settings (#934/#923)
    - Corrected container log setting active file duration to 12 hours (#930)
    - Optimized docker container log image field (#929)
    - Optimized k8s pod object host field (#924)
    - Fixed missing host tag in container metrics and object collection (#962)

- eBPF related:
    - Fixed Uprobe event name conflict issue
    - Added more [environment variable configurations](ebpf.md#config) to facilitate deployment in k8s environments

- Optimized APM data reception interface to alleviate client freezing and high memory usage issues (#902)

- SQLServer collector fixes:
    - Restored TLS1.0 support (#909)
    - Supported filtering through instance to reduce time series consumption (#931)

- Pipeline function `adjust_timezone()` adjustments (#917)
- [IO module optimization](datakit-conf.md#io-tuning), improving overall data processing capability while maintaining relatively controlled memory consumption (#912)
- Monitor updates:
    - Fixed long-time freezing of Monitor during busy periods (#933)
    - Optimized Monitor display, adding IO module information for easier adjustment of IO module parameters
- Fixed Redis crash issue (#935)
- Removed some redundant logs (#939)
- Fixed issue where host tags were not appended in non-election mode for election collectors (#968)

---

## 1.4.7 (2022/07/11) {#cl-1.4.7}

This release belongs to the Hotfix category, mainly fixing the following problems:

- Election related:
    - Fixed `election_namespace` setting error issue (#915)
    - The setting of `enable_election_namespace` tag is turned off by default and needs to be [manually enabled](election.md#config)
    - The `namespace` field in *datakit.conf* will be deprecated (still usable), renamed to `election_namespace`

- Fixed collector blocking issue (#916)
    - DataKit removed the heartbeat interface call center
    - DataKit removed the Dataway list interface call center

- [Container Collector](container.md) supports modifying the log source (`source`) field for sidecar containers through additional configuration (`ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP`) (#903)
- Fixed blacklist display issue on Monitor (#904)

---

## 1.4.6 (2022/07/07) {#cl-1.4.6}

- Adjusted [global tag](datakit-conf.md#set-global-tag) behavior to avoid tag splitting in election collectors (#870)
- [SQLServer Collector](sqlserver.md) added election support (#882)
- [Line Protocol Filter](datakit-filter.md) supports all data types (#855)
- 9529 HTTP service added [timeout mechanism](datakit-conf.md#http-other-settings) (#900)
- MySQL:
    - Adjusted [dbm metric set name](mysql.md#logging) (#898)
    - Resolved `service` field conflict issue (#895)
- [Container Objects](container.md#docker_containers) added `container_runtime_name` field to differentiate container names at different levels (#891)
- Redis adjusted [`slowlog` collection](redis.md#redis_slowlog) to store its data as logs (#885)
- Optimized [TDEngine Collection](tdengine.md) (#877)
- Improved Containerd log collection, supporting automatic parsing of default format logs (#869)
- [Pipeline](../pipeline/use-pipeline/index.md) added [Profiling data](profile.md) support (#866)
- Container/Pod log collection supports [adding extra tags via Labels/Annotations](container-log.md#logging-with-annotation-or-label) (#861)
- Fixed [Jenkins CI](jenkins.md#jenkins_pipeline) data collection time precision issue (#860)
- Fixed Tracing resource-type value inconsistency issue (#856)
- eBPF added [HTTPS support](ebpf.md#https) (#782)
- Fixed potential crash issue in log collector (#893)
- Fixed prom collector leak issue (#880)
- Supported configuring [disk cache for I/O via environment variables](datakit-conf.md#using-cache) (#906)
- Added [Kubernetes CRD](kubernetes-crd.md) support (#726)
- Other bug fixes (#901/#899)

---

## 1.4.5 (2022/06/29) {#cl-1.4.5}

This release belongs to the Hotfix category, primarily fixing the interruption of log collection caused by rapid deletion and recreation of same-name files (#883).

If you have scheduled tasks regularly packaging logs, this bug may be triggered, **upgrade recommended**.

---

## 1.4.4 (2022/06/27) {#cl-1.4.4}

This release belongs to the Hotfix category, with the following main updates:

- Fixed log collection issue caused by improper handling of pos, introduced since 1.4.2, **upgrade recommended** (#873)
- Fixed TDEngine potential crash issue
- Optimized eBPF data sending flow to avoid consuming too much memory leading to OOM (#871)
- Fixed documentation errors in collectors

---

## 1.4.3 (2022/06/22) {#cl-1.4.3}

This release belongs to the iterative update category, with the following main updates:

- Git sync configuration supports passwordless mode (#845)
- Prom collector:
    - Supports log mode collection (#844)
    - Supports configuring HTTP request headers (#832)
- Supports collecting container logs exceeding 16KB length (#836)
- Supports TDEngine collector (#810)
- Pipeline:
    - Supports XML parsing (#804)
    - Remote debugging supports multiple data types (#833)
    - Supports calling external Pipeline scripts via `use()` function (#824)
- Added IP library (MaxMindIP) support (#799)
- Added DDTrace Profiling integration (#656)
- containerd log collection supports filtering rules via image and K8s Annotation configuration (#849)
- Documentation repository switched entirely to MkDocs (#745)
- Other miscellaneous items (#822)

### Bug Fixes {#cl-1.4.3-bugfix}

- Fixed socket collector crash issue (#858)
- Fixed crash issue caused by empty tags in some collector configurations (#852)
- Fixed IPDB update command issue (#854)
- Added `pod_ip` field to Kubernetes Pod logs and objects (#848)
- DDTrace collector restored recognition of trace SDK sampling settings (#834)
- Fixed `host` field inconsistency between external collectors (eBPF/Oracle) and DataKit itself in DaemonSet mode (#843)
- Fixed stdout multi-line log collection issue (#859)

---

## 1.4.2 (2022/06/16) {#cl-1.4.2}

This release belongs to the iterative update category, with the following main updates:

- Log collection supports recording collection positions to avoid data loss due to DataKit restarts (#812)
- Adjusted Pipeline settings for handling different data types (#806)
- Supports receiving SkyWalking metric data (#780)
- Optimized log blacklist debugging feature:
    - Displays filtered points in Monitor (#827)
    - Adds a *.pull* file under *datakit/data* directory to record fetched filters
- Added DataKit open file count display in Monitor (#828)
- Upgraded DataKit compiler to Golang 1.18.3 (#674)

### Bug Fixes {#1.4.2-bugfix}

- Fixed `ENV_K8S_NODE_NAME` not globally effective issue (#840)
- Fixed file descriptor leak issue in log collector, **strongly recommended upgrade** (#838)
- Fixed Pipeline `group_in` issue (#826)
- Fixed ElasticSearch collector configuration `http_timeout` parsing issue (#821)
- Fixed DCA API issue (#747)
- Fixed `dev_null` DataWay setting ineffective issue (#842)

----

## 1.4.1 (2022/06/07) {#cl-1.4.1}

This release belongs to the iterative update category, with the following main updates:

- Fixed TOML configuration file compatibility issue (#195)
- Added [TCP/UDP port detection](socket) collector (#743)
- Increased DNS detection between DataKit and DataWay, supporting dynamic switching of DataWay DNS (#758)
- L4/L7 traffic data from [eBPF](ebpf) added k8s deployment name field (#793)
- Optimized [OpenTelemetry](opentelemetry) metric data (#794)
- [ElasticSearch](elasticsearch) added AWS OpenSearch support (#797)
- [Line Protocol Limit](apis#2fc2526a) relaxed string length limit to 32MB (#801)
- [prom](prom) collector added extra configuration to ignore specified tag=value matches, reducing unnecessary time-series timelines (#808)
- Sink added Jaeger support (#813)
- Kubernetes-related [metrics](container#7e687515) collection defaulted to all off to avoid timeline explosion (#807)
- [DataKit Monitor](monitor) added refresh for dynamically discovered (e.g., prom) collectors (#711)

### Bug Fixes {#cl-1.4.1-bugfix}
- Fixed default Pipeline loading issue (#796)
- Fixed Pipeline handling regarding log status (#800)
- Fixed [Filebeat](beats_output) crash issue (#805)
- Fixed [Log Streaming](logstreaming) dirty data issue (#802)

----

## 1.4.0 (2022/05/26) {#cl-1.4.0}

This release belongs to the iterative update category, entering sub-version 1.4 sequence. Main updates include:

- Pipeline underwent significant adjustments (#761)
    - All data types can be processed via Pipeline configuration (#761/#739)
    - [grok()](pipeline#965ead3c) supports directly extracting fields as specified types, eliminating the need for additional type conversion using `cast()` (#760)
    - Pipeline added [multi-line string support](pipeline#3ab24547), enhancing readability for very long strings (such as grok regex splitting) by allowing them to be written over multiple lines (#744)
    - Each Pipeline's operational status can be viewed directly via `datakit monitor -V` (#701)
- Added Kubernetes [Pod Object](container#23ae0855-1) CPU/memory metrics (#770)
- Helm added more Kubernetes version installation adaptations (#783)
- Optimized [OpenTelemetry](opentelemetry), added JSON support to HTTP protocol (#781)
- DataKit added logging for auto-correcting line protocols, facilitating data issue debugging (#777)
- Removed all string metrics from time-series data (#773)
- In DaemonSet installation, if [election](election) namespace is configured, all participating collectors' data will have an additional specific tag (`election_namespace`) (#743)
- CI observability added [Jenkins](jenkins) support (#729)

### Bug Fixes {#cl-1.4.0-bugfix}

- Fixed DataWay statistics error in monitor (#785)
- Fixed log collector-related bugs (#783)
    - Certain probability of dirty data stream occurring in log collection
    - In file log collection scenarios (disk files/container logs/logfwd), fixed unstable collection issues caused by truncate/rename/remove factors affecting collected logs (data loss)
- Other bug fixes (#790)

----

## 1.2.20 (2022/05/22) {#cl-1.2.20}

This release belongs to the hotfix category, mainly fixing the following issues:

- Log collection function optimization (#775)
    - Removed 32KB limit (retained 32MB maximum limit) (#776)
    - Fixed possible loss of header logs issue
    - For newly created logs, default to start collection from the beginning (mainly container logs, currently unable to determine whether disk file logs are newly created)
    - Optimized Docker log handling, no longer relying on Docker log API

- Fixed [decode](pipeline#837c4e09) function issue in Pipeline (#769)
- OpenTelemetry gRPC method supports gzip (#774)
- Fixed [Filebeat](beats_output) collector issue where service could not be set (#767)

### Breaking Changes {#cl.1.2.20-bc}

For Docker container log collection, the host (Node) */varl/lib* path needs to be mounted into DataKit (because Docker logs default to the host’s */var/lib/* directory). Add the following configuration in *datakit.yaml* under `volumeMounts` and `volumes`:

```yaml
volumeMounts:
- mountPath: /var/lib
  name: lib

# Other parts omitted ...

volumes:
- hostPath:
    path: /var/lib
  name: lib
```

----

## 1.2.19 (2022/05/12) {#cl-1.2.19}

This release belongs to the iterative update category, with the following main updates:

- eBPF added arm64 support (#662)
- Line protocol construction supports automatic correction (#710)
- DataKit main configuration added example configuration (#715)
- [Prometheus Remote Write](prom_remote_write) supports tag renaming (#731)
- Fixed DCA client issue where workspace acquisition was incomplete (#747)
- Merged existing features from the community edition of DataKit, mainly including Sinker functionality and [Filebeat](beats_output) collector (#754)
- Adjusted container log collection, DataKit now directly supports collecting container stdout/stderr logs under containerd (#756)
- Fixed ElasticSearch collector timeout issue (#762)
- Fixed overly strict installation program checks (#763)
- Adjusted hostname acquisition strategy in DaemonSet mode (#648)
- Trace collector supports filtering resources (`resource`) by service name (`service`) wildcard (#759)
- Other detail issue fixes

----

## 1.2.18 (2022/05/06) {#cl-1.2.18}

This release belongs to the hotfix category, mainly fixing the following issues:

- Filtering function of [Process Collector](host_processes.md) only affects metric collection, object collection remains unaffected (#740)
- Alleviated DataKit sending DataWay timeout issue (#741)
- [GitLab Collector](gitlab.md) slightly adjusted (#742)
- Fixed log collection truncation issue (#749)
- Fixed partial configuration not taking effect after reload in various trace collectors (#750)

----

## 1.2.17 (2022/04/27) {#cl-1.2.17}

This release belongs to the iterative update category, mainly involving the following aspects:

- [Container Collector](container#7e687515) added more metrics (`kube_` prefix) collection (#668)
- DDTrace and OpenTelemetry collectors support filtering part of erroneous traces via HTTP Status Code (`omit_err_status`)
- Fixed reload configuration not taking effect in several Trace collectors (DDtrace/OpenTelemetry/Zipkin/SkyWalking/Jaeger) in git mode (#725)
- Fixed GitLab collector crash issue due to tagging failure (#730)
- Fixed Kubernetes eBPF collector not updating Pod tags (#736)
- [Prom collector](prom.md) supports [Tag Renaming](prom#e42139cb) (#719)
- Improved some documentation descriptions

----

## 1.2.16 (2022/04/24) {#cl-1.2.16}

This release belongs to the hotfix fix, mainly involving the following aspects (#728):

- Fixed possible errors in the installation program preventing further installation/upgrade, tolerating partial service operation errors in certain situations
- Fixed spelling errors in the Windows installation script causing 32-bit installer download failures
- Adjusted Monitor's display about election situations
- Under election activation, fixed MongoDB infinite loop causing inability to collect data

----

## 1.2.15 (2022/04/21) {#cl-1.2.15}

This release belongs to the iterative update category, containing numerous bug fixes:

- Pipeline module fixed Grok's [dynamic multi-line pattern](datakit-pl-how-to#88b72768) issue (#720)
- Removed some unnecessary DataKit event log uploads (#704)
- Fixed potential upgrade failure caused by the upgrade program (#699)
- DaemonSet added [pprof environment variable](datakit-daemonset-deploy#cc08ec8c) configuration (#697)
- All [default enabled collectors](datakit-input-conf#764ffbc2) in DaemonSet support configuration via environment variables (#693)
- Tracing collector initially supports Pipeline data processing (#675)
    - [DDtrace Configuration Example](ddtrace#69995abe)
- Dial test collector added failed task exit mechanism (#54)
- Optimized [Helm Installation](datakit-daemonset-deploy#e4d3facf) (#695)
- Logs added `unknown` level (status), all logs without specified levels are `unknown` (#685)
- Extensive fixes in container collector
    - Fixed cluster field naming issue (#542)
    - Renamed `kubernetes_clusters` metric set to `kubernetes_cluster_roles`
    - Renamed original `kubernetes.cluster` count to `kubernetes.cluster_role`
    - Fixed namespace field naming issue (#724)
    - If Pod Annotation does not specify log `source`, DataKit will deduce log source based on [this priority](container#6de978c3) (#708/#723)
    - Object reporting no longer restricted by 32KB character limit (due to Annotation content exceeding 32KB) (#709)
    - Removed `annotation` field from all Kubernetes objects
    - Fixed prom collector not stopping upon Pod exit (#716)
- Other issue fixes (#721)

---

## 1.2.14 (2022/04/12) {#cl-1.2.14}

This release belongs to the hotfix category, also containing some minor modifications and adjustments:

- Fixed monitor display issues and log level adjustment for some error logs in the log collector (#706)
- Fixed memory leak issue in dial test collector (#702)
- Fixed crash issue in host process collector (#700)
- Log collector option `ignore_dead_log = '10m'` enabled by default (#698)
- Optimized Git-managed configuration synchronization logic (#696)
- eBPF fixed incorrect IP protocol field in `netflow` (#694)
- Enriched GitLab collector fields

---

## 1.2.13 (2022/04/08) {#cl-1.2.13}

This release belongs to the iterative update category, with the following updates:

- Added [memory limits](datakit-conf#4e7ff8f3) for runtime on the host (#641)
    - Memory limit configuration supported during installation stage (#641)
- CPU collector added [load5s metric](cpu#13e60209) (#606)
- Improved *datakit.yaml* example (#678)
- Supported limiting memory usage during host installation via [cgroup](datakit-conf#4e7ff8f3) (#641)
- Enhanced log blacklist functionality, added `contain/notcontain` judgment rules (#665)
    - Supported configuring [blacklists for logs/objects/Tracing/time-series metrics](datakit-filter#045b45e3) in *datakit.conf*
    - Note: Upgrading to this version requires upgrading DataWay to 1.2.1+
- Further improved [container collection under containerd](container) (#402)
- Adjusted monitor layout, added blacklist filtering situation display (#634)
- DaemonSet installation added [Helm support](datakit-daemonset-deploy) (#653)
    - Added [DaemonSet installation best practices](datakit-daemonset-bp) (#673)
- Improved [GitLab collector](gitlab) (#661)
- Added [ulimit configuration item](datakit-conf#8f9f4364) to configure file opening limit (#667)
- Updated Pipeline [desensitization function](pipeline#52a4c41c), added [SQL desensitization function](pipeline#711d6fe4) (#670)
- Added `cpu_usage_top` field to process objects and time-series metrics to correspond with `top` command results (#621)
- eBPF added [HTTP protocol collection](ebpf#905896c5) (#563)
- During host installation, eBPF collector no longer installs by default (to reduce binary distribution size), requiring [specific installation instructions](ebpf#852abae7) if needed (#605)
    - DaemonSet installation unaffected
- Other bug fixes (#688/#681/#679/#680)

---

## 1.2.12 (2022/03/24) {#cl-1.2.12}

This release belongs to the iterative update category, with the following updates:

1. Added [DataKit command-line completion](datakit-tools-how-to#9e4e5d5f) function (#76)
1. Allowed DataKit [upgrades to non-stable versions](datakit-update#42d8b0e4) (#639)
1. Adjusted storage of Remote Pipeline in DataKit local to avoid filename case sensitivity issues caused by different file systems (#649)
1. (Alpha) Preliminary support for [Kubernetes/Containerd architecture data collection](container#b3edf30c) (#402)
1. Fixed unreasonable errors in Redis collector (#671)
1. Fine-tuned fields in OpenTelemetry collector (#672)
1. Fixed CPU calculation error in [DataKit self-collector](self) (#664)
1. Fixed IP association field absence in RUM collector due to missing IPDB (#652)
1. Pipeline supports uploading debug data to OSS (#650)
1. DataKit HTTP API includes [DataKit version number information](apis#be896a47)
1. [Network Dial Testing](dialtesting) added TCP/UDP/ICMP/Websocket protocol support (#519)
1. Fixed excessively long field issue in [Host Object Collector](hostobject) (#669)
1. Pipeline:
    - Added [decode()](pipeline#837c4e09) function (#559), avoiding encoding configuration in log collector, enabling encoding conversion within Pipeline
    - Fixed possible failure importing Pattern files in Pipeline (#666)
    - [add_pattern()](pipeline#89bd3d4e) added scope management

---

## 1.2.11 (2022/03/17) {#cl-1.2.11}

This release belongs to the hotfix category, also containing some minor modifications and adjustments:

- Fixed algorithm issue in Tracing collector resource filtering (`close_resource`), moving filtering mechanism to Entry Span level instead of previous Root Span
- Fixed [Log Collector](logging) file handle leak issue (#658), and added configuration (`ignore_dead_log`) to ignore files no longer updated (deleted)
- Added [Datakit self-metric documentation](self)
- DaemonSet installation:
    - [Supports installing IPDB](datakit-tools-how-to#11f01544) (#659)
    - Supports [setting HTTP rate limit (ENV_REQUEST_RATE_LIMIT)](datakit-daemonset-deploy#00c8a780) (#654)

---

## 1.2.10 (2022/03/11) {#cl-1.2.10}

Fixed potential crash issues in Tracing-related collectors

---

## 1.2.9(2022/03/10) {#cl-1.2.9}

This release is an iterative release, with the following updates:

- DataKit 9529 HTTP service added [API rate limiting measures](datakit-conf#39e48d64)(#637)
- Unified various Tracing data [sampling rate settings](datakit-tracing#64df2902)(#631)
- Released [DataKit log collection overview](datakit-logging)
- Supports [OpenTelemetry data ingestion](opentelemetry)(#609)
- Supports [disabling logs for certain images inside a Pod](container#2a6149d7)(#586)
- Process object collection [added listening port list](host_processes#a30fc2c1-1)(#562)
- eBPF collector [supports Kubernetes field association](ebpf#35c97cc9)(#511)

### Breaking Changes {#cl-1.2.9-bc}

- Significant adjustments were made to the Tracing data collection in this release, involving several areas of incompatibility:

    - The `ignore_resources` field configured in the [DDtrace](ddtrace) conf needs to be changed to `close_resource`, and the field type has been changed from the original array (`[...]`) form to dictionary array (`map[string][...]`) form (refer to [conf.sample](ddtrace#69995abe) for configuration)
    - The [tag `type` field collected in DDTrace data is changed to `source_type`](ddtrace#01b88adb)

---

## 1.2.8(2022/03/04) {#cl-1.2.8}

This release belongs to hotfix fixes, content as follows:

- When deploying in DaemonSet mode, the *datakit.yaml* file adds [taint tolerance configuration](datakit-daemonset-deploy#e29e678e)(#635)
- Fixed a bug when pulling Remote Pipeline updates (#630)
- Fixed memory leaks caused by DataKit IO module deadlocks (#646)
- Allowed modifying the `service` field in Pipelines (#645)
- Fixed the spelling error of `pod_namespace`
- Fixed some issues with logfwd (#640)
- Fixed multi-line sticky problems in the log collector under container environments (#633)

---

## 1.2.7(2022/02/22) {#cl-1.2.7}

This release is an iterative release, content as follows:

- Pipeline
    - Grok added [dynamic multi-line pattern](datakit-pl-how-to#88b72768) for easier handling of dynamic multi-line splitting (#615)
    - Supports centralized issuance of Pipelines (#524), thus Pipelines will have [three storage paths](pipeline#6ee232b2)
    - DataKit HTTP API added Pipeline debugging interface [`/v1/pipeline/debug`](apis#539fb60e)

<!--
- APM function adjustment (#610)
    - Refactored existing common Tracing data ingestion
    - Added APM Metrics calculation
    - Added [OTEL(OpenTelemetry) data ingestion]()

!!! Delay
-->

- To reduce the default installation package size, the default installation no longer includes the IP geographic information database. In collectors like RUM, you can additionally [install the corresponding IP library](datakit-tools-how-to#ab5cd5ad)
    - If you need to install the IP geographic information database during installation, it can be achieved through [extra supported command-line environment variables](datakit-install#f9858758)
- Container collector added [logfwd log ingestion](logfwd)(#600)
- Further standardized data uploads, line protocol added more strict [restrictions](apis#2fc2526a)(#592)
- [Log collector](logging) removed log length restriction (`maximum_length`) (#623)
- Optimized Monitor display during log collection (#587)
- Improved command-line parameter checks for the installation program (#573)
- Re-adjusted DataKit command-line parameters, most major commands are now supported. Additionally, **the old command-line parameters will still work within a certain time period** (#499)
    - You can view the new command-line parameter style via `datakit help`
- Re-implemented [DataKit Monitor](datakit-monitor)

### Other Bug Fixes {#cl-1.2.7-fix}

- Fixed Windows installation script issues (#617)
- Adjusted ConfigMap settings in *datakit.yaml* (#603)
- Fixed some HTTP services failing due to Reload in Git mode (#596)
- Fixed isp file loss in the installation package (#584/#585/#560)
- Fixed multi-line matching not working in Pod annotations (#620)
- Fixed `_service_` tag not working in TCP/UDP log collectors (#610)
- Fixed Oracle collector not collecting data (#625)

### Breaking Changes {#cl-1.2.7-brk}

- Old versions of DataKit that had the RUM feature enabled must [reinstall the IP library](datakit-tools-how-to#ab5cd5ad) after upgrading, as the old version of the IP library will no longer work.

---

## 1.2.6(2022/01/20) {#cl-1.2.6}

This release is an iterative release, content as follows:

- Enhanced [DataKit API secure access control](rum#b896ec48), it is recommended to upgrade if the old version of DataKit has deployed the RUM feature (#578)
- Increased more internal event log reporting for DataKit (#527)
- Viewing [DataKit runtime status](datakit-tools-how-to#44462aae) will no longer timeout (#555)

- Some detail issues fixed in the [container collector]

    - Fixed crash issue when deploying on the host in Kubernetes environment (#576)
    - Increased priority for Annotation collection configurations (#553)
    - Container logs support multi-line processing (#552)
    - Kubernetes Node objects added _role_ field (#549)
    - [Prom collectors](prom) annotated via [Annotation](kubernetes-prom) automatically add related attributes (_pod_name/node_name/namespace_) (#522/#443)
    - Other bug fixes

- Pipeline issues fixed

    - Fixed potential time disorder issues in log processing (#547)
    - Supported complex logic judgment for _if/else_ statements

- Fixed Windows path issues in the log collector (#423)
- Improved DataKit service management, optimized interaction prompts (#535)
- Optimized metric units in the existing DataKit documentation export (#531)
- Improved engineering quality (#515/#528)

---

## 1.2.5(2022/01/19) {#cl-1.2.5}

- Fixed Pipeline configuration issues in the [Log Stream collector](logstreaming) (#569)
- Fixed log confusion issues in the [container collector](container) (#571)
- Fixed bugs in the Pipeline module update logic (#572)

---

## 1.2.4(2022/01/12) {#cl-1.2.4}

- Fixed lost metrics issue in the log API interface (#551)
- Fixed partial network traffic statistics loss in [eBPF](ebpf) (#556)
- Fixed `$` wildcard issues in collector configuration files (#550)
- Pipeline _if_ statement supports null value comparison for Grok parsing (#538)

---

## 1.2.3(2022/01/10) {#cl-1.2.3}

- Fixed *datakit.yaml* format errors (#544)
- Fixed election issues in the [MySQL collector](mysql) (#543)
- Fixed the issue where logs were not collected due to missing Pipeline configurations (#546)

---

## 1.2.2(2022/01/07) {#cl-1.2.2}

- [Container collector](container) updates:
    - Fixed log processing efficiency issues (#540)
    - Optimized whitelist/blacklist configurations in configuration files (#536)
- Pipeline module added `datakit -M` metric exposure (#541)
- [ClickHouse](clickhousev1) collector config-sample issue fixed (#539)
- [Kafka](kafka) metric collection optimization (#534)

---

## 1.2.1(2022/01/05) {#cl-1.2.1}

- Fixed Pipeline usage issues in collectors (#529)
- Improved data issues in the [container collector](container) (#532/#530)
    - Fixed short-image collection issues
    - Improved Deployment/Replica-Set associations in k8s environments

---

## 1.2.0(2021/12/30) {#cl-1.2.0}

- Restructured the Kubernetes cloud-native collector, integrating it into the [container collector]. The original Kubernetes collector is no longer effective (#492)
- [Redis collector]
    - Supports configuring [Redis usernames](redis.md)(#260)
    - Added Latency and Cluster Metrics sets (#396)
- Enhanced [Kafka collector], supporting topic/broker/consumer/connection dimension metrics (#397)
- Added [ClickHouse] and [Flink] collectors (#458/#459)
- [Host object collector]
    - Supports reading cloud sync configurations from [`ENV_CLOUD_PROVIDER`](hostobject#224e2ccd)(#501)
    - Optimized disk collection, invalid disks will no longer be collected by default (e.g., disks with total size of 0) (#505)
- [Log collector] supports receiving TCP/UDP log streams (#503)
- [Prom collector] supports multi-URL collection (#506)
- Added [eBPF] collector, which integrates L4-network/DNS/Bash eBPF data collection (#507)
- [ElasticSearch collector] added [Open Distro](https://opendistro.github.io/for-elasticsearch/){:target="_blank"} branch ElasticSearch support (#510)

### Bug Fixes {#cl-1.2.0-fix}

- Fixed [Statsd]/[RabbitMQ] metrics issues (#497)
- Fixed [Windows Event] data collection issues (#521)
- [Pipeline]
    - Enhanced Pipeline parallel processing capabilities
    - Added [`set_tag()`](pipeline#6e8c5285) function (#444)
    - Added [`drop()`](pipeline#fb024a10) function (#498)
- Git Mode
    - In DaemonSet mode, Git supports recognizing `ENV_DEFAULT_ENABLED_INPUTS` and making it effective. In non-DaemonSet mode, it will automatically enable collectors enabled by default in *datakit.conf* (#501)
    - Adjusted folder [storage strategy] in Git mode (#509)
- Implemented new version number mechanism (#484)
    - New version number format is 1.2.3, where `1` is the major version number, `2` is the minor version number, and `3` is the patch version number
    - Minor version parity determines whether it is a stable version (even) or non-stable version (odd)
    - On the same minor version, there will be multiple different patch versions, mainly used for bug fixes and feature adjustments
    - New features are expected to be released in non-stable versions, and after the new features stabilize, a new stable version will be released. For example, after the new features in 1.3.x stabilize, a 1.4.0 stable version will be released, merging the new features from 1.3.x
    - Non-stable versions do not support direct upgrades, such as upgrading to 1.3.x versions, only direct installations of non-stable versions are allowed

### Breaking Changes {#cl-1.2.0-break-changes}

**Old versions of DataKit using `datakit --version` can no longer push new upgrade commands**, use the following commands directly:

- Linux/Mac:

```shell
DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Windows

```powershell
Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
$env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
Set-ExecutionPolicy Bypass -scope Process -Force;
Import-Module bitstransfer;
start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
powershell ./.install.ps1;
```

---

## 1.1.9-rc7.1(2021/12/22) {#cl-1.1.9-rc7.1}

- Fixed data issues in the MySQL collector due to partial collection failures.

---

## 1.1.9-rc7(2021/12/16) {#cl-1.1.9-rc7}

- Pipeline underwent significant refactoring (#339):

    - Added `if/elif/else` [syntax](pipeline#1ea7e5aa)
    - Temporarily removed `expr()/json_all()` functions
    - Optimized timezone handling, added `adjust_timezone()` function
    - Various Pipeline functions underwent comprehensive testing enhancements

- DataKit DaemonSet:

    - Git configuration DaemonSet [ENV injection](datakit-daemonset-deploy#00c8a780)(#470)
    - Default removal of container collector to avoid duplicate collection issues (#473)

- Others:
    - DataKit supports self-event reporting (in log form) (#463)
    - [ElasticSearch] collector Metrics set added `indices_lifecycle_error_count` metric (Note: To collect this metric, an `ilm` role must be added to ES [elasticsearch#852abae7])
    - DataKit automatically adds [cgroup restrictions] after installation
    - Interfaces communicating with the center have been upgraded to v2 versions, so Datakits connected to **non-SAAS nodes** that upgrade to the current version also require corresponding upgrades to their DataWay and Kodo, otherwise some interfaces will report 404 errors

### Breaking Changes {#cl-1.1.9-rc7brk}

When processing JSON data, if the top level is an array, indexing must be used to select elements. For example, given the JSON:

```
[
    {"abc": 123},
    {"def": true}
]
```

In previous versions, to access the `abc` resource of the first element, the syntax was:

```
[0].abc
```

In the current version, it should be:

```
# Add a preceding `.` character
.[0].abc
```

---

## 1.1.9-rc6.1(2021/12/10) {#cl-1.1.9-rc6.1}

- Fixed ElasticSearch and Kafka collector error issues (#486)

---

## 1.1.9-rc6(2021/11/30) {#cl-1.1.9-rc6}

- Made an emergency fix for Pipeline:
    - Removed `json_all()` function, this function had serious data issues with abnormal JSON, so it was disabled (#457)
    - Fixed timezone setting issues in the `default_time()` function (#434)
- Solved HTTPS access issues for the [`Prom`](prom) collector in Kubernetes environments (#447)
- [yaml file](https://static.guance.com/datakit/datakit.yaml){:target="_blank"} for DataKit DaemonSet installation is publicly downloadable

---

## 1.1.9-rc5.1(2021/11/26) {#cl-1.1.9-rc5.1}

- Fixed DDTrace collector crashing due to dirty data

---

## 1.1.9-rc5(2021/11/23) {#cl-1.1.9-rc5}

- Added [Pythond(alpha)](pythond) to facilitate writing custom collectors in Python3 (#367)
<!-- - Supports source map file processing to facilitate RUM collectors collecting JavaScript call stack information (#267) -->
- [SkyWalking V3](skywalking) now supports versions 8.5.0/8.6.0/8.7.0 (#385)
- DataKit initially supports [disk data caching(alpha)](datakit-conf#caa0869c)(#420)
- DataKit supports election state reporting (#427)
- DataKit supports Scheck state reporting (#428)
- Adjusted DataKit user guide documentation for better categorization

---

## 1.1.9-rc4.3(2021/11/19) {#cl-1.1.9-rc4.3}

- Fixed the issue where the container log collector could not start due to improper Pipeline configuration

---

## 1.1.9-rc4.2(2021/11/18) {#cl-1.1.9-rc4.2}

- Emergency fix (#446)
    - Fixed abnormal stdout log output levels in Kubernetes mode
    - Fixed MySQL collector looping issues in election mode
    - Completed DaemonSet documentation

---

## 1.1.9-rc4.1(2021/11/16) {#cl-1.1.9-rc4.1}

- Fixed Kubernetes Pod namespace collection issues (#439)

---

## 1.1.9-rc4(2021/11/09) {#cl-1.1.9-rc4}

- Supports [management via Git](datakit-conf#90362fd0) for various collector configurations (`datakit.conf` excluded) and Pipelines (#366)
- Supports [fully offline installation](datakit-offline-install#7f3c40b6)(#421)
<!--
- eBPF-network
    - Added [DNS data collection]()(#418)
    - Enhanced kernel compatibility, kernel version requirement lowered to Linux 4.4+(#416) -->
- Enhanced data debugging functionality, collected data can be written to local files while being sent to the center (#415)
- In K8s environments, default-enabled collectors support tags injection via environment variables; see individual default-enabled collector documents (#408)
- DataKit supports [one-click log upload](datakit-tools-how-to#0b4d9e46)(#405)
<!-- - MySQL collector added [SQL execution performance metrics]()(#382) -->
- Fixed root user setup bug in the installation script (#430)
- Enhanced Kubernetes collector:
    - Added [Pod log collection] via Annotation configuration (#380)
    - Added more Annotation keys [supporting multiple IPs](kubernetes-prom#b8ba2a9e)(#419)
    - Supported Node IP collection (#411)
    - Optimized Annotation usage in collector configurations (#380)
- Cloud synchronization added [Huawei Cloud and Microsoft Cloud support](hostobject#031406b2)(#265)

---

## 1.1.9-rc3(2021/10/26) {#cl-1.1.9-rc3}

- Optimized [Redis collector] DB configuration method (#395)
- Fixed [Kubernetes] collector tag value being empty issue (#409)
- Installation process fixed Mac M1 chip support (#407)
- [eBPF-network](net_ebpf) fixed connection count statistics error issue (#387)
- Log collection added [log data acquisition method], supporting [Fluentd/Logstash data ingestion](logstreaming)(#394/#392/#391)
- [ElasticSearch] collector added more metrics collection (#386)
- APM added [Jaeger data] ingestion (#383)
- [Prometheus Remote Write] collector supports data slicing debugging
- Optimized [Nginx proxy] function
- DQL query results support [CSV file export](datakit-dql-how-to#2368bf1d)

---

## 1.1.9-rc2(2021/10/14) {#cl-1.1.9-rc2}

- Added [collector] support for Prometheus Remote Write synchronizing data to DataKit (#381)
- Added [Kubernetes Event data collection](kubernetes#49edf2c4)(#296)
- Fixed Mac installation failure due to security policies (#379)
- [prom collector] debugging tool supports local file data slicing debugging (#378)
- Fixed [etcd collector] data issues (#377)
- DataKit Docker image added arm64 architecture support (#365)
- Installation stage added environment variable `DK_HOSTNAME` [support](datakit-install#f9858758)(#334)
- [Apache collector] added more metrics collection (#329)
- DataKit API added interface [`/v1/workspace`](apis#2a24dd46) to get workspace information (#324)
    - Supports obtaining workspace information via DataKit command-line arguments [datakit-tools-how-to#88b4967d]

---

## 1.1.9-rc1.1(2021/10/09) {#cl-1.1.9-rc1.1}

- Fixed Kubernetes election issues (#389)
- Fixed MongoDB configuration compatibility issues

---

## 1.1.9-rc1(2021/09/28) {#cl-1.1.9-rc1}

- Improved Prometheus-like metrics collection under the Kubernetes ecosystem (#368/#347)
- [eBPF-network](net_ebpf) optimization
- Fixed DataKit/DataWay connection leakage issues (#290)
- Fixed subcommand execution issues in container mode for DataKit (#375)
- Fixed raw data loss issues in the log collector due to Pipeline errors (#376)
- Improved DataKit-end [DCA] related functions, supports enabling DCA functions during installation [datakit-install#f9858758].
- Browser synthetic test functionality discontinued

---

## 1.1.9-rc0(2021/09/23) {#cl-1.1.9-rc0}

- [Log collector] added special character (such as color characters) filtering function (default off) (#351)
- [Improved container log collection], synchronized more existing ordinary log collector functions (multi-line matching/log level filtering/character encoding etc.) (#340)
- [Host object] collector field fine-tuning (#348)
- Added the following collectors:
    - [eBPF-network](net_ebpf)(alpha)(#148)
    - [Consul](consul)(#303)
    - [etcd](etcd)(#304)
    - [CoreDNS](coredns)(#305)
- Election functionality now covers the following collectors: (#288)
    - [Kubernetes]
    - [Prom]
    - [GitLab]
    - [NSQ]
    - [Apache]
    - [InfluxDB]
    - [ElasticSearch]
    - [MongoDB]
    - [MySQL]
    - [Nginx]
    - [PostgreSQL]
    - [RabbitMQ]
    - [Redis]
    - [Solr]

---

## 1.1.8-rc3(2021/09/10) {#cl-1.1.8-rc3}

- DDTrace added [resource filtering](ddtrace#224e2ccd) functionality (#328)
- Added [NSQ] collector (#312)
- During K8s DaemonSet deployment, some collectors support changing default configurations via environment variables, using [CPU] as an example (#309)
- Preliminary support for [SkyWalkingV3](skywalking)(alpha)(#335)
- [RUM] collector removed full-text fields to reduce network overhead (#349)
- [Log collector] added handling for file truncate situations (#271)
- Log field slicing error field compatibility (#342)
- Fixed possible TLS errors during [offline download](datakit-offline-install) (#330)
- Once log collector configuration succeeds, it triggers a notification log indicating that the corresponding file's log collection has started (#323)

---

## 1.1.8-rc2.4(2021/08/26) {#cl-1.1.8-rc2.4}

- Fixed the issue where enabling cloud synchronization during installation prevented installation

---

## 1.1.8-rc2.3(2021/08/26) {#cl-1.1.8-rc2.3}

- Fixed the issue where containers could not start during runtime

---

## 1.1.8-rc2.2(2021/08/26) {#cl-1.1.8-rc2.2}

- Fixed the issue where the [`hostdir`] configuration file did not exist

---

## 1.1.8-rc2.1(2021/08/25) {#cl-1.1.8-rc2.1}

- Fixed the issue of no data due to CPU temperature collection
- Fixed statsd collector crash upon exit (#321)
- Fixed the issue with the automatic upgrade command prompt under proxy mode

---

## 1.1.8-rc2(2021/08/24) {#cl-1.1.8-rc2}

- Supports syncing Kubernetes labels to various objects (pod/service/...) (#279)
- `datakit` Metrics set added data discard Metrics (#286)
- [Kubernetes cluster custom Metrics collection] optimization (#283)
- [ElasticSearch] collector improvement (#275)
- Added [host directory] collector (#264)
- [CPU] collector supports single CPU Metrics collection (#317)
- [DDTrace] supports multi-route configuration (#310)
- [DDTrace] supports custom business tag extraction (#316)
- [Host object] collector reports only errors within the last 30 seconds (inclusive) (#318)
- [DCA client] release
- Disabled some command-line helps on Windows (#319)
- Adjusted DataKit [installation method], adjusted [offline installation] method (#300)
    - After adjustment, it remains compatible with the old installation method

### Breaking Changes {#cl-1.1.8-rc2brk}

- Functionality to obtain hostname from environment variable `ENV_HOSTNAME` has been removed (supported in 1.1.7-rc8), hostname override functionality can be used instead [datakit-install#987d5f91]
- Removed command option `--reload`
- Removed DataKit API `/reload`, replaced by `/restart`
- Due to command-line option adjustments, the previous monitor viewing command now requires sudo privileges (to read *datakit.conf* automatically to obtain Datakit configurations)

---

## 1.1.8-rc1.1(2021/08/13) {#cl-1.1.8-rc1.1}

- Fixed the issue where `ENV_HTTP_LISTEN` was ineffective, causing abnormal HTTP service startup when deploying in containers (including K8s DaemonSet deployments).

---

## 1.1.8-rc1(2021/08/10) {#cl-1.1.8-rc1}

- Fixed the issue where host objects could not be reported when cloud synchronization was enabled.
- Fixed the issue where newly installed DataKit on Mac could not start.
- Fixed the "fake success" problem when non-`root` users operated services on Mac/Linux.
- Optimized data upload performance.
- [`proxy`] collector supports global proxy functionality, involving adjustments to installation, updates, and data upload methods in intranet environments.
- Performance optimization of the log collector.
- Document improvements.

---

## 1.1.8-rc0(2021/08/03) {#cl-1.1.8-rc0}

- Improved the [Kubernetes] collector by adding more Kubernetes object collections.
- Improved [hostname override functionality](datakit-install#987d5f91).
- Optimized Pipeline processing performance (approximately 15 times faster depending on Pipeline complexity).
- Strengthened [line protocol data validation](apis#2fc2526a).
- `system` collector added [`conntrack` and `filefd`](system) two Metrics sets.
- `datakit.conf` added IO tuning entries to optimize DataKit network outbound traffic (see the Breaking Changes below).
- DataKit supports [service uninstallation and recovery](datakit-service-how-to#9e00a535).
- Windows platform services support [command-line management](datakit-service-how-to#147762ed).
- DataKit supports dynamically obtaining the latest DataWay address to avoid default DataWay being attacked by DDos.
- DataKit logs support [output to terminal](datakit-daemonset-deploy#00c8a780) (not supported on Windows currently), facilitating log viewing and collection in k8s deployments.
- Adjusted DataKit main configuration, modularized each different configuration module (see the Breaking Changes below).
- Other bug fixes and document improvements.

### Breaking Changes {#cl-1.1.8-rc0brk}

The following changes will be *automatically adjusted* during the upgrade process, here just mentioning specific changes for your understanding.

- Main configuration modifications: added the following modules

```toml
[io]
  feed_chan_size                 = 1024  # IO pipeline buffer size
  hight_frequency_feed_chan_size = 2048  # High-frequency IO pipeline buffer size
  max_cache_count                = 1024  # Maximum local cache, original main configuration io_cache_count [this value and max_dynamic_cache_count simultaneously less than or equal to zero will infinitely use memory]
  cache_dump_threshold         = 512   # Local cache cleanup threshold after pushing [this value less than or equal to zero will not clean up cache, network interruption may lead to large memory usage]
  max_dynamic_cache_count      = 1024  # Maximum HTTP cache, [this value and max_cache_count simultaneously less than or equal to zero will infinitely use memory]
  dynamic_cache_dump_threshold = 512   # HTTP cache cleanup threshold after pushing, [this value less than or equal to zero will not clean up cache, network interruption may lead to large memory usage]
  flush_interval               = "10s" # Push interval
  output_file                  = ""    # Output io data to local file, original main configuration output_file

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

## 1.1.7-rc9.1 (2021/07/17) {#cl-1.1.7-rc9.1}

- Fixed an issue where file handle leaks caused possible failures when restarting DataKit on Windows platforms.

## 1.1.7-rc9 (2021/07/15) {#cl-1.1.7-rc9}

- Added support for cloud service providers, namespaces, and network card binding during installation.
- Introduced support for multi-namespace elections.
- Added [InfluxDB Collector](influxdb).
- Enhanced Datakit DQL with historical command storage.
- Other minor bug fixes.

---

## 1.1.7-rc8 (2021/07/09) {#cl-1.1.7-rc8}

- Supported metrics collection for MySQL [users](mysql#15319c6c) and [table levels](mysql#3343f732).
- Adjusted the monitor page display:
    - Separated collector configuration status from collection status.
    - Added election and automatic update status displays.
- Supported obtaining hostname from `ENV_HOSTNAME` to address issues with unavailable original hostnames.
- Added tag-level [Trace](ddtrace) filtering.
- [Container Collector](container) now supports collecting process objects within containers.
- Supported controlling DataKit CPU usage via [cgroup control](datakit-conf#4e7ff8f3) (Linux only).
- Added [IIS Collector](iis).
- Fixed upload issues caused by dirty data in cloud synchronization.

---

## 1.1.7-rc7 (2021/07/01) {#cl-1.1.7-rc7}

- DataKit API now supports [JSON Body](apis#75f8e5a2).
- Added features to the command line:

    - [DQL Query Functionality](datakit-dql-how-to#cb421e00)
    - [Command-line Monitor Viewing](datakit-tools-how-to#44462aae)
    - [Checking if Collector Configurations are Correct](datakit-tools-how-to#519a9e75)

- Optimized log performance (for built-in log collectors of various collectors; currently adapted for nginx/MySQL/Redis, with plans to adapt other built-in log collectors).
- The host object collector added two types of metrics: [`conntrack`](hostobject#2300b531) and [`filefd`](hostobject#697f87e2).
- Application performance metric collection supports [sampling rate settings](ddtrace#c59ce95c).
- K8s cluster Prometheus metric collection [general solution](kubernetes-prom).

### Breaking Changes {#cl-1.1.7-rc7brk}

- In *datakit.conf*, the `host` tag configured under `global_tags` will no longer take effect. This is mainly to avoid misunderstandings when configuring the host (i.e., configuring `host` might differ from the actual hostname, causing data misinterpretations).

---

## 1.1.7-rc6 (2021/06/17) {#cl-1.1.7-rc6}

- Added [Windows Event Collector](windows_event).
- Provided an option to disable the DataKit 404 page for public deployments of [RUM](rum).
- Optimized fields for the [Container Collector](container), primarily involving pod restart/ready/state fields.
- [Kubernetes Collector](kubernetes) added more metric collections.
- Supported log filtering at the DataKit end (blacklist).
    - Note: If multiple DataWay addresses are configured on DataKit, the log filtering function will not take effect.

### Breaking Changes {#cl-1.1.7-rc6brk}

For collectors without Yuzhu documentation support, all have been removed in this release (various cloud collectors, such as Alibaba Cloud monitoring data, cost, etc.). Upgrading is not recommended if these collectors are depended upon.

---

## 1.1.7-rc5 (2021/06/16) {#cl-1.1.7-rc5}

Fixed the issue where `/v1/query/raw` in [DataKit API](apis) could not be used.

---

## 1.1.7-rc4 (2021/06/11) {#cl-1.1.7-rc4}

Disabled the Docker collector, whose functionality is fully implemented by the [Container Collector](container).

Reasons:

- When both Docker and container collectors coexist (by default, DataKit automatically enables the container collector during installation or upgrades), it leads to duplicate data.
- The current Studio frontend, template views, etc., do not yet support the latest container fields, potentially causing users to see no container data after upgrading. This version's container collector redundantly collects a portion of the metrics originally collected by the Docker collector to ensure normal operation of Studio.

> Note: If additional configurations for Docker were made in older versions, it is recommended to manually migrate them to the [Container Collector](container). Their configurations are largely compatible.

---

## 1.1.7-rc3 (2021/06/10) {#cl-1.1.7-rc3}

- Added [Disk S.M.A.R.T. Collector](smart).
- Added [Hardware Temperature Collector](sensors).
- Added [Prometheus Collector](prom).
- Corrected the [Kubernetes Collector](kubernetes) to support more K8s object statistical metric collections.
- Improved the [Container Collector](container) to support image/container/pod filtering.
- Fixed issues with the [Mongodb Collector](mongodb).
- Fixed crashes in the MySQL/Redis collectors due to missing configurations.
- Fixed [offline installation issues](datakit-offline-install).
- Fixed some collector log setting issues.
- Fixed data issues in the [SSH](ssh)/[Jenkins](jenkins) collectors.

---

## 1.1.7-rc2 (2021/06/07) {#cl-1.1.7-rc2}

- Added [Kubernetes Collector](kubernetes).
- DataKit supports [DaemonSet deployment](datakit-daemonset-deploy).
- Added [SQL Server Collector](sqlserver).
- Added [PostgreSQL Collector](postgresql).
- Added [statsd Collector](statsd) to support collecting statsd data sent over the network.
- [JVM Collector](jvm) prioritizes DDTrace/StatsD collection.
- Added [Container Collector](container), enhancing k8s node (Node) collection to replace the existing [docker collector](docker) (the original docker collector remains available).
- [Dial Testing Collector](dialtesting) supports Headless mode.
- [Mongodb Collector](mongodb) supports collecting Mongodb logs.
- DataKit added DQL HTTP [API interface](apis) `/v1/query/raw`.
- Improved some collector documentation, adding middleware (such as MySQL/Redis/ES, etc.) log collection related documentation.

---

## 1.1.7-rc1 (2021/05/26) {#cl-1.1.7-rc1}

- Fixed Redis/MySQL collector data anomalies.
- Refactored MySQL InnoDB metrics; details refer to [MySQL Documentation](mysql#e370e857).

---

## 1.1.7-rc0 (2021/05/20) {#cl-1.1.7-rc0}

Added collectors:

- [Apache](apache)
- [Cloudprober Integration](cloudprober)
- [GitLab](gitlab)
- [Jenkins](jenkins)
- [Memcached](memcached)
- [Mongodb](mongodb)
- [SSH](ssh)
- [Solr](solr)
- [Tomcat](tomcat)

New feature-related updates:

- Network dial testing supports private node access.
- Linux platform defaults to enabling container object and log collection.
- CPU collector supports temperature data collection.
- [MySQL slow logs support Alibaba Cloud RDS format splitting](mysql#ee953f78).

Other various bug fixes.

### Breaking Changes {#cl-1.1.7-rc0brk}

[RUM Collection] data types were adjusted, and the original data types have been mostly deprecated. Corresponding SDK updates are required [(Update SDK)](/dataflux/doc/eqs7v2).

---

## 1.1.6-rc7 (2021/05/19) {#cl-1.1.6-rc7}

- Fixed Windows platform installation and upgrade issues.

---

## 1.1.6-rc6 (2021/05/19) {#cl-1.1.6-rc6}

- Fixed data processing issues in some collectors (MySQL/Redis) due to missing metrics.
- Other bug fixes.

---

## 1.1.6-rc5 (2021/05/18) {#cl-1.1.6-rc5}

- Fixed HTTP API precision parsing issues that led to some data timestamp parsing failures.

---

## 1.1.6-rc4 (2021/05/17) {#cl-1.1.6-rc4}

- Fixed potential crashes in container log collection.

---

## 1.1.6-rc3 (2021/05/13) {#cl-1.1.6-rc3}

This release includes the following updates:

- After installing/upgrading DataKit, the installation directory has changed:

    - Linux/Mac: `/usr/local/datakit`, log directory is `/var/log/datakit`
    - Windows: `C:\Program Files\datakit`, log directory is under the installation directory

- Supports [`/v1/ping` interface](apis#50ea0eb5).
- Removed RUM collector; RUM interface is [already supported by default](apis#f53903a9).
- Added monitor page: http://localhost:9529/monitor, replacing the previous /stats page. Automatically redirects to the monitor page after reload.
- Supports directly [installing sec-checker](datakit-tools-how-to#01243fef) and [updating ip-db](datakit-tools-how-to#ab5cd5ad) via commands.

---

## 1.1.6-rc2 (2021/05/11) {#cl-1.1.6-rc2}

- Fixed issues preventing startup in container deployments.

---

## 1.1.6-rc1 (2021/05/10) {#cl-1.1.6-rc1}

This release adjusts some details of DataKit:

- DataKit supports configuring multiple DataWays.
- [Cloud association](hostobject#031406b2) is achieved through corresponding meta interfaces.
- Adjusted the [filtering method](docker#a487059d) for docker log collection.
- [DataKit supports elections](election).
- Fixed issues with cleaning up historical dial test data.
- A large amount of documentation [published on Yuzhu](https://www.yuque.com/dataflux/datakit){:target="_blank"}.
- [DataKit supports command-line integration with Telegraf](datakit-tools-how-to#d1b3b29b).
- Single-instance run detection for DataKit.
- [Automatic update functionality for DataKit](datakit-update-crontab).

---

## 1.1.6-rc0 (2021/04/30) {#cl-1.1.6-rc0}

This release adjusts some details of DataKit:

- After installation on Linux/Mac, the `datakit` command can be executed directly from any directory without switching to the DataKit installation directory.
- Pipeline adds desensitization function `cover()`.
- Optimized command-line parameters for better convenience.
- Host object collection defaults to filtering out virtual devices (Linux support only).
- Datakit commands support `--start/--stop/--restart/--reload` several commands (require root privileges), making it easier for everyone to manage DataKit services.
- Process object collector enabled by default after installation/upgrade (currently default enabled list is `cpu/disk/diskio/mem/swap/system/hostobject/net/host_processes`).
- Log collector `tailf` renamed to `logging`; the old `tailf` name continues to be usable.
- Supports connecting Security data.
- Removed Telegraf installation integration. If Telegraf functionality is needed, refer to :9529/man page, which has dedicated documentation for Telegraf installation.
- Added Datakit How To documentation for beginners (:9529/man page shows this).
- Other adjustments to some collector metrics collection.

---

## v1.1.5-rc2 (2021/04/22) {#cl-1.1.5-rc2}

### Bug Fixes {#cl-1.1.5-rc2fix}

- Fixed the incorrect address requested by the `--version` command on Windows.
- Adjusted Huawei Cloud monitoring data collection configuration, releasing more configurable information for real-time adjustment.
- Adjusted Nginx error log (error.log) cutting script, while increasing default log level classification.

---

## v1.1.5-rc1 (2021/04/21) {#cl-1.1.5-rc1}

### Bug Fixes {#cl-1.1.5-rc1fix}

- Fixed compatibility issues with the `tailf` collector configuration file, which prevented the `tailf` collector from running.

---

## v1.1.5-rc0 (2021/04/20) {#cl-1.1.5-rc0}

This release makes significant adjustments to collectors.

### Breaking Changes {#cl-1.1.5-rc0brk}

The following collectors are involved:

| Collector       | Description                                                                                                                                                                                                 |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cpu`           | Built-in CPU collector in DataKit, removed Telegraf CPU collector, configuration files remain compatible. Additionally, Mac platform temporarily does not support CPU collection, to be added later.                  |
| `disk`          | Built-in disk collector in DataKit.                                                                                                                                                                      |
| `docker`        | Redesigned docker collector, supporting container objects, container logs, and container metrics collection (additional support for K8s container collection).                                              |
| `elasticsearch` | Built-in ES collector in DataKit, removed Telegraf ES collector. Additionally, ES logs can be directly configured for collection in this collector.                                                           |
| `jvm`           | Built-in JVM collector in DataKit.                                                                                                                                                                       |
| `kafka`         | Built-in Kafka metrics collector in DataKit, Kafka logs can be directly collected in this collector.                                                                                                     |
| `mem`           | Built-in memory collector in DataKit, removed Telegraf memory collector, configuration files remain compatible.                                                                                           |
| `mysql`         | Built-in MySQL collector in DataKit, removed Telegraf MySQL collector. MySQL logs can be directly collected in this collector.                                                                            |
| `net`           | Built-in network collector in DataKit, removed Telegraf network collector. On Linux, virtual NIC devices are no longer collected by default (manual activation required).                                      |
| `nginx`         | Built-in NGINX collector in DataKit, removed Telegraf NGINX collector. NGINX logs can be directly collected in this collector.                                                                              |
| `oracle`        | Built-in Oracle collector in DataKit. Oracle logs can be directly collected in this collector.                                                                                                           |
| `rabbitmq`      | Built-in RabbitMQ collector in DataKit. RabbitMQ logs can be directly collected in this collector.                                                                                                      |
| `redis`         | Built-in Redis collector in DataKit. Redis logs can be directly collected in this collector.                                                                                                             |
| `swap`          | Built-in swap memory collector in DataKit.                                                                                                                                                             |
| `system`        | Built-in system collector in DataKit, removed Telegraf system collector. The built-in system collector adds three new metrics: `load1_per_core/load5_per_core/load15_per_core`, facilitating direct single-core average load display without additional calculations. |

Most updates to the above collectors involve changes to measurement sets and metric names, specifically reference each collector's documentation.

Other compatibility issues:

- For security reasons, collectors no longer bind to all NICs by default, binding instead to `localhost:9529`. The previously bound `0.0.0.0:9529` is now invalid (`http_server_addr` field also deprecated); you can manually modify `http_listen` to set it to `http_listen = "0.0.0.0:9529"` (port can be changed).
- Some middlewares (like MySQL/Nginx/Docker) already integrate their corresponding log collection, which can be directly configured in their respective collectors without needing `tailf` (but `tailf` can still independently collect these logs).
- The following collectors are no longer effective, please use the built-in collectors mentioned above:
    - `dockerlog`: integrated into the docker collector.
    - `docker_containers`: integrated into the docker collector.
    - `mysqlMonitor`: integrated into the mysql collector.

### New Features {#cl-1.1.5-rc0new}

- Dial testing collector (`dialtesting`): supports centralized task distribution. There is a separate dial testing entry on the Studio homepage where you can create dial testing tasks to try out.
- All collector configurations support environment variable configuration, e.g., `host="$K8S_HOST"`, facilitating deployment in container environments.
- http://localhost:9529/stats adds more collector runtime statistics, including collection frequency (`frequency`), number of data reported per time (`avg_size`), and collection consumption per time (`avg_collect_cost`). Some collectors may lack certain fields, which is fine because each collector's collection method differs.
- http://localhost:9529/reload can be used to reload collectors. For example, after modifying the configuration file, you can directly execute `curl http://localhost:9529/reload`, which will not restart the service, similar to Nginx's `-s reload` function. You can also visit this reload address directly in the browser, and after a successful reload, it will automatically redirect to the stats page.
- Support browsing DataKit documentation on the http://localhost:9529/man page (only newly modified collector documentation is integrated here; other collector documentation needs to be viewed in the original help center). By default, remote viewing of DataKit documentation is not supported, but it can be viewed in the terminal (Mac/Linux only):

```shell
# Enter the collector installation directory, input the collector name (use `Tab` key for auto-completion) to view documentation
$ ./datakit -cmd -man
man > nginx
(Displays Nginx collector documentation)
man > mysql
(Displays MySQL collector documentation)
man > Q               # Input Q or exit to quit
```

---

## v1.1.4-rc2 (2021/04/07) {#cl-1.1.4-rc2}

### Bug Fixes {#cl-1.1.4-rc2fix}

- Fixed frequent data collection in the Aliyun CMS collector (`aliyuncms`) that caused some other collectors to freeze.

---

## v1.1.4-rc1 (2021/03/25) {#cl-1.1.4-rc1}

### Improvements {#cl-1.1.4-rc0opt}

- Added more information to the `message` field in the process collector for full-text search.
- Host object collector supports custom tags for cloud attribute synchronization.

---

## v1.1.4-rc0 (2021/03/25) {#cl-1.1.4-rc0}

### New Features {#cl-1.1.4-rc0new}

- Added file collector, dial testing collector, and HTTP message collector.
- Built-in support for ActiveMQ/Kafka/RabbitMQ/gin (Gin HTTP access logs)/Zap (third-party log framework) log slicing.

### Improvements {#cl-1.1.4-rc0fix}

- Enriched statistics on the `http://localhost:9529/stats` page, adding collection frequency (`n/min`), data size per collection, etc.
- DataKit itself added some cache space (cleared on restart) to prevent data loss due to occasional network issues.
- Improved Pipeline date conversion functions for greater accuracy. Also added more Pipeline functions (`parse_duration()/parse_date()`).
- Trace data added more business fields (`project/env/version/http_method/http_status_code`).
- Various detail improvements for other collectors.

---

## v1.1.3-rc4 (2021/03/16) {#cl-1.1.3-rc4}

### Bug Fixes {#cl-1.1.3-rc4fix}

- Process collector: Fixed the issue where missing usernames caused blank displays, using `nobody` as the username for processes where username retrieval fails.

---

## v1.1.3-rc3 (2021/03/04) {#cl-1.1.3-rc3}

### Bug Fixes {#cl-1.1.3-rc3fix}

- Fixed issues with some empty fields (missing process user and process command) in the process collector.
- Fixed potential panic in memory usage calculation in the Kubernetes collector.

---

## v1.1.3-rc2 (2021/03/01) {#cl-1.1.3-rc2}

### Bug Fixes {#cl-1.1.3-rc2fix}

- Fixed naming issues in the process object collector `name` field, renaming it with `hostname + pid`.
- Corrected Pipeline issues in the Huawei Cloud object collector.
- Fixed compatibility issues after upgrading Nginx/MySQL/Redis log collectors.

---

## v1.1.3-rc1 (2021/02/26) {#cl-1.1.3-rc1}

### New Features {#cl-1.1.3-rc1new}

- Added built-in Redis/Nginx.
- Improved analysis of MySQL slow query logs.

### Functional Improvements {#cl-1.1.3-rc1opt}

- Due to long single collection times, the process collector's collection frequency was restricted to a minimum value (30s).
- Collector configuration file names are no longer strictly limited; any file named like `xxx.conf` is considered valid.
- Version update prompt judgments have been updated so that if the git commit code differs from the online version, an update will be prompted.
- Container object collector (`docker_containers`), added memory/CPU ratio fields (`mem_usage_percent/cpu_usage`).
- K8s metrics collector (`kubernetes`), added CPU ratio field (`cpu_usage`).
- Tracing data collection improved handling of service type.
- Some collectors support custom writing of logs or metrics (default metrics).

### Bug Fixes {#cl-1.1.3-rc1fix}

- Fixed the issue where the process collector failed to obtain the default username on Mac platforms.
- Corrected the container object collector, which couldn't retrieve exited containers.
- Other detailed bug fixes.

### Breaking Changes {#cl-1.1.3-rc1brk}

- For certain collectors, if the original metrics contain `uint64` type fields, the new version may cause incompatibility. Original metric sets should be deleted to avoid type conflicts.

    - Previously, uint64 was automatically converted to string, which caused confusion during use. More precise control of integer removal can now be applied.
    - For uint integers exceeding max-int64, the collector discards such metrics since influx1.7 does not support uint64 metrics.

- Removed some original `dkctrl` command execution functionalities; configuration management will no longer rely on this method.

---

## v1.1.2 (2021/02/03) {#cl-1.1.2}

### Functional Improvements {#cl-1.1.0-opt}

- During container installation, the `ENV_UUID` environment variable must be injected.
- After upgrading from an old version, the host collector will be automatically enabled (the original *datakit.conf* will be backed up).
- Added caching functionality so that data collected during network fluctuations is not lost (data will still be lost during prolonged network outages).
- All logs collected using `tailf` must specify the time field to be split out in the Pipeline using the `time` field; otherwise, the log storage time field will differ from the actual log time.

### Bug Fixes {#cl-1.2.0-fix}

- Fixed the time unit issue in Zipkin.
- Added a `state` field to the host object collector.

---

## v1.1.1 (2021/02/01) {#cl-1.1.1}

### Bug Fixes {#cl-1.1.1-fix}

- Fixed the issue where the `status/variable` fields in the Mysql Monitor collector were of string type. Reverted to original field types. Simultaneously protected against int64 overflow issues.
- Changed some field names in the process collector to align with the host collector naming.

---

## v1.1.0 (2021/01/29) {#cl-1.1.0}

This version mainly involves bug fixes for some collectors and adjustments to the main Datakit configuration.

### Breaking Changes {#cl-1.1.0-brk}

- Adopted a new version numbering mechanism. Versions like `v1.0.0-2002-g1fe9f870` will no longer be used; instead, versions like `v1.2.3` will be adopted.
- Moved the `datakit.conf` configuration from the top-level DataKit directory into the `conf.d` directory.
- Moved the original `network/net.conf` into `host/net.conf`.
- Moved the original `pattern` directory to the `pipeline` directory.
- Converted all lowercase patterns in the original grok (e.g., `%{space}`) to uppercase forms (`%{SPACE}`). **All existing grok expressions must be replaced accordingly**.
- Removed the `uuid` field from `datakit.conf`, storing it separately in `.id` for unified management of all DataKit configuration files.
- Removed Ansible collector event data reporting.

### Bug Fixes {#cl-1.1.0-fix}

- Fixed issues where the `prom` and `oraclemonitor` collectors couldn't collect data.
- Renamed the hostname field in the `self` collector to `host` and placed it in the tag.
- Fixed conflicts between MySQL and MariaDB types in the `mysqlMonitor` collector.
- Fixed the issue where SkyWalking collector logs weren't split, leading to full disks.

### Features {#cl-1.1.0-new}

- Added whitelist/blacklist functionality for collectors/hosts (regex not yet supported).
- Restructured object collectors for hosts, processes, and containers.
- Added Pipeline/Grok debugging tools.
- The `-version` parameter not only shows the current version but also prompts for online new version information and update commands.
- Supported DDTrace data connection.
- Changed `tailf` collector log matching to forward matching.
- Other detailed issue fixes.
- Supported CPU data collection on the Mac platform.
