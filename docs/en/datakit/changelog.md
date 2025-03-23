# Release Notes

## 1.65.2 (2024/12/31) {#cl-1.65.2}

This release is a hotfix, with some additional detail features added. Content as follows:

### New Features {#cl-1.65.2-new}

- OpenTelemetry collection now defaults to splitting sub-service names `service` (#2522)
- OpenTelemetry adds the `ENV_INPUT_OTEL_COMPATIBLE_DDTRACE` configuration entry (!3368)

### Bug Fixes {#cl-1.65.2-fix}

- Kubernetes auto-discovery prometheus collection no longer forcibly adds `pod_name` and `namespace` fields (#2524)
- Fix SkyWalking plugin not taking effect issue (!3368)

---

## 1.65.1 (2024/12/25) {#cl-1.65.1}

This release is a hotfix, with some additional detail features added. Content as follows:

### New Features {#cl-1.65.1-new}

- KubernetesPrometheus:
    - selector supports glob matching (#2515)
    - Collected metrics data default appends global tag (#2519)
    - Optimize `prometheus.io/path` annotation (#2518)
- DCA adds ARM image support (#2517)
- Pipeline function `http_request()` adds IP whitelist configuration (#2521)

### Bug Fixes {#cl-1.65.1-fix}

- Adjust Kafka built-in views, fix mismatch between displayed data and actual data (#2468)
- Fix vSphere collector crash issue (#2510)

---

## 1.65.0 (2024/12/19) {#cl-1.65.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.65.0-new}

- Add disk information collection based on `lsblk` (#2408)
- Host object collection increases configuration file information collection, supporting text files up to 4KiB in size (#2453)
- Add new [log collection configuration guide document](datakit-logging.md)

### Bug Fixes {#cl-1.65.0-fix}

- Fix host object collection failing due to partial information collection errors causing entire host objects not being reported (#2478)
- Other bug fixes (#2474)

### Function Optimization {#cl-1.65.0-opt}

- Optimize Zabbix data import function, optimize full update logic, while adjusting metric naming, also synchronize some tags read from MySQL to Zabbix data points (#2455)
- Optimize Pipeline processing performance (memory consumption reduced by 30%+), where the `load_json()` function replaced a more efficient library, improving JSON processing performance by approximately 16% (#2459)
- Optimize log collection file discovery strategy, add inotify mechanism for more efficient handling of new files, avoiding delayed collection (#2462)
- Optimize mainstream metrics collection time alignment mechanism to improve time-series storage efficiency (#2445)

### Compatibility Adjustment {#cl-1.65.0-brk}

Due to adding API whitelist control, some default APIs enabled in older versions will no longer be effective and need to be manually enabled (#2479)

---

## 1.64.3 (2024/12/16) {#cl-1.64.3}

This release is a hotfix, content as follows:

- Add APM Automatic Instrumentation uninstall entry (#2509)
- Fix AWS lambda collector unavailable since version 1.62 issue (#2505)
- Fix Pipeline concurrent read/write crash issue (#2503)
- Improve part of built-in view exports (#2489)
- SNMP collector opens maximum OID count configuration (new version defaults to max 1000, old version only 64), avoiding OID collection issues (#2488)
- Fix eBPF collector network latency appearing as negative values issue (#2467)
- Add [disclaimer] during Datakit usage process (index.md#disclaimer)
- Other adjustments and documentation updates (#2507/!3347/!3345/#2501)

---

## 1.64.2 (2024/12/09) {#cl-1.64.2}

This release is a hotfix, content as follows:

- Fix several known security issues (#2502)
- Fix excessive CPU usage caused by inotify monitoring unnecessary events in log collection (#2500)

---

## 1.64.1 (2024/12/05) {#cl-1.64.1}

This release is a hotfix, content as follows:

- Fix truncation problem caused by incorrect `message` setting in log collection
- Pipeline fixes `valid_json()` performance issue (#2494)
- Fix Windows installation script not restarting after OOM issue (#2491)
- Fix log collection consuming high CPU in version 1.64.0 (#2498)

---

## 1.64.0 (2024/11/27) {#cl-1.64.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.64.0-new}

- Log collection buffer adjusted to 64KB, optimizing data point construction performance in log collection (#2450)
- Added limit for maximum log collection, default maximum collection is 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Support configuring default Pipeline scripts in *datakit.conf* (#2355)
- Synthetic Tests collector supports HTTP Proxy when pulling central synthetic testing tasks (#2438)
- During Datakit upgrade, environment variables passed through command-line can modify main configurations similarly to installation (#2418)
- Add prom v2 collector, compared to v1, its parsing performance has been significantly optimized (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, set specific switches and restart corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) adds support for multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.64.0-fix}

- Fix SQLServer data conversion issues during collection (#2429)
- Fix potential crash in HTTP service caused by timeout components (#2423)
- Fix time unit issues in New Relic collection (#2417)
- Fix potential crash in Pipeline `point_window()` function (#2416)
- Fix protocol recognition issues in eBPF collection (#2451)

### Function Optimization {#cl-1.64.0-opt}

- Data collected by KubernetesPrometheus will adjust each data point's timestamp according to the collection interval (#2441)
- Container log collection supports setting `from-beginning` attribute in Annotation/Label (#2443)
- Optimize data point upload strategy, support ignoring overly large data points to prevent entire data packet transmission failure (#2440)
- Datakit API /v1/write/:category improves zlib format encoding support (#2439)
- Optimize DDTrace data point processing strategy, reducing memory footprint (#2434)
- Optimize resource usage during eBPF collection (#2430)
- Optimize GZip efficiency during uploads (#2428)
- This version includes numerous performance optimizations (#2414)
    - Optimize Prometheus exporter data collection performance, reducing memory consumption
    - Default enable [HTTP API throttling](datakit-conf.md#set-http-api-limit), preventing excessive sudden traffic consuming too much memory
    - Add [WAL disk queue](datakit-conf.md#dataway-wal), handling possible memory consumption caused by upload blockage. The newly added disk queue *defaults to caching failed upload data*.
    - Refine Datakit self-memory usage metrics, adding multiple dimensions of memory usage to metrics
    - `datakit monitor -V` command adds WAL panel display
    - Optimize KubernetesPrometheus collection performance (#2426)
    - Optimize container log collection performance (#2425)
    - Remove log debugging-related fields to optimize network traffic and storage
- Other optimizations
    - Optimize *datakit.yaml*, changing image pull policy to `IfNotPresent` (!3264)
    - Optimize indicators documentation generated based on Profiling (!3224)
    - Update Kafka views and monitors (!3248)
    - Update Redis views and monitors (!3263)
    - Add Ligai version notifications (!3247)
    - Add SQLServer built-in views (!3272)

### Compatibility Adjustment {#cl-1.64.0-brk}

KubernetesPrometheus previously supported configuring collection intervals on different instances (`interval`), this feature has been removed in the current version. Global intervals can be set in the KubernetesPrometheus collector to achieve similar functionality.

---

## 1.63.1 (2024/11/21) {#cl-1.63.1}

This release is a hotfix, content as follows:

- Fix multi-line processing issues in socket logging collection (#2461)
- Fix Windows Datakit not restarting again after OOM (#2465)
- Fix Oracle metric missing issues (#2464)
- Fix APM Automatic Instrumentation offline installation issues (#2466)
- Restore the functionality of exposing Prometheus Exporter collection through Pod Annotations that was removed in version 1.63.0. Actually, many existing businesses' Prometheus metrics are already being collected in this way, and temporarily cannot be migrated to KubernetesPrometheus form.

    This feature was removed in version 1.63.0 but is restored here.

---

## 1.63.0 (2024/11/13) {#cl-1.63.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.63.0-new}

- Add Datakit [task dispatch support](datakit-conf.md#remote-job) (currently requires manual activation, and Guance needs to be upgraded to version 1.98.181 or higher), currently supports issuing commands to Datakit from the front-end page to obtain JVM Dump (#2367)

    When executing in Kubernetes, you need to update the latest *datakit.yaml*, which requires additional RBAC permissions.

- Pipeline adds [string extraction function](../pipeline/use-pipeline/pipeline-built-in-function.md#fn_slice_string) (#2436)

### Bug Fixes {#cl-1.63.0-fix}

- Fix potential Datakit startup issues, caused by WAL being default-enabled as a data sending cache queue without proper process mutual exclusion during WAL initialization (#2457)
- Fix reset of already configured settings in *datakit.conf* during installation (#2454)

### Function Optimization {#cl-1.63.0-opt}

- eBPF collector adds data sampling rate configuration to reduce its generated data volume (#2394)  
- KafkaMQ collector adds SSL support (#2421)
- Graphite ingested data supports specifying measurement sets (#2448)
- Adjust CRD Service Monitor collection granularity, finest grain changed from Pod to [Endpoint](https://kubernetes.io/docs/concepts/services-networking/service/#endpoints){:target="_blank"}

### Compatibility Adjustment {#cl-1.63.0-brk}

- Removed experimental Kubernetes Self metrics feature, its functionality can be achieved via KubernetesPrometheus (#2405)
- Removed DCA Discovery support for Datakit CRD
- Moved container collector Discovery Prometheus functionality to KubernetesPrometheus collector, maintaining relative compatibility
- No longer supports PodTargetLabel configuration field in Prometheus ServiceMonitor

---

## 1.62.2 (2024/11/09) {#cl-1.62.2}

This release is a hotfix, content as follows:

- Fix data packet loss at the tail end during data upload (#2453)

---

## 1.62.1 (2024/11/07) {#cl-1.62.1}

This release is a hotfix, content as follows:

- Fix message truncation caused by incorrect `message` setting in log collection

---

## 1.62.0 (2024/11/06) {#cl-1.62.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.62.0-new}

- Adjust log reading buffer to 64KB, optimizing performance in constructing data points in log collection (#2450)
- Increase maximum log collection limit, default maximum collection is 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Support configuring default Pipeline scripts in *datakit.conf* (#2355)
- Synthetic Tests collector supports HTTP Proxy when pulling center synthetic test tasks (#2438)
- During Datakit upgrades, similarly to installation, passing command-line environment variables also supports modifying main configurations (#2418)
- Add prom v2 collector, compared to v1, its parsing performance has been greatly optimized (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, set specific switches and restart corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports linking blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) adds support for multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.62.0-fix}

- Fix data conversion issues in SQLServer collection (#2429)
- Fix potential crash in HTTP service caused by timeout components (#2423)
- Fix time unit issues in New Relic collection (#2417)
- Fix potential crash in Pipeline `point_window()` function (#2416)
- Fix protocol recognition issues in eBPF collection (#2451)

### Function Optimization {#cl-1.62.0-opt}

- Data collected by KubernetesPrometheus adjusts timestamps according to the collection interval (#2441)
- Container log collection supports setting `from-beginning` attribute in Annotation/Label (#2443)
- Optimize data point upload strategy, support ignoring overly large data points to prevent entire data packet transmission failure (#2440)
- Datakit API `/v1/write/:category` improves zlib format encoding support (#2439)
- Optimize DDTrace data point processing strategy, reducing memory footprint (#2434)
- Optimize resource usage during eBPF collection (#2430)
- Optimize GZip efficiency during uploads (#2428)
- This version includes numerous performance optimizations (#2414)
    - Optimize Prometheus exporter data collection performance, reducing memory consumption
    - Default enable [HTTP API throttling](datakit-conf.md#set-http-api-limit), preventing excessive sudden traffic consuming too much memory
    - Add [WAL disk queue](datakit-conf.md#dataway-wal), handling possible memory consumption caused by upload blockage. The newly added disk queue *defaults to caching failed upload data*.
    - Refine Datakit self-memory usage metrics, adding multiple dimensions of memory usage to metrics
    - `datakit monitor -V` command adds WAL panel display
    - Optimize KubernetesPrometheus collection performance (#2426)
    - Optimize container log collection performance (#2425)
    - Remove log debugging-related fields to optimize network traffic and storage
- Other optimizations
    - Optimize *datakit.yaml*, change image pull policy to `IfNotPresent` (!3264)
    - Optimize indicators documentation generated based on Profiling (!3224)
    - Update Kafka views and monitors (!3248)
    - Update Redis views and monitors (!3263)
    - Add Ligai version notifications (!3247)
    - Add SQLServer built-in views (!3272)

### Compatibility Adjustment {#cl-1.62.0-brk}

KubernetesPrometheus previously supported configuring collection intervals on different instances (`interval`), this feature has been removed in the current version. Global intervals can be set in the KubernetesPrometheus collector to achieve similar functionality.

---

## 1.61.0 (2024/11/02) {#cl-1.61.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.61.0-new}

- Add maximum log collection limit, default maximum collection is 500 files, adjustable via `ENV_LOGGING_MAX_OPEN_FILES` in Kubernetes (#2442)
- Support configuring default Pipeline scripts in *datakit.conf* (#2355)
- Synthetic Tests collector supports HTTP Proxy when pulling center synthetic test tasks (#2438)
- During Datakit upgrades, similarly to installation, passing command-line environment variables also supports modifying main configurations (#2418)

### Bug Fixes {#cl-1.61.0-fix}

- Adjust default directory for data sending disk queue (WAL) in version 1.60.0. In Kubernetes installations, the directory was incorrectly set under *data* directory, which is not mounted to the host machine's disk by default. Data would be lost when Pod restarted (#2444)

```yaml
        - mountPath: /usr/local/datakit/cache # Directory should be set under cache directory
          name: cache
          readOnly: false
      ...
      - hostPath:
          path: /root/datakit_cache # WAL disk storage mounted under this directory on the host machine
        name: cache
```

- Fix data conversion issues in SQLServer collection (#2429)
- Fix several known issues in version 1.60.0 (#2437):
    - Fix upgrade program not enabling point-pool feature by default
    - Fix double gzip issue for failed retransmitted data, which would cause the center unable to parse these data, leading to data discard. This issue would only trigger if the data failed to send the first time.
    - Fix memory leak during data encoding due to certain boundary conditions

### Function Optimization {#cl-1.61.0-opt}

- Data collected by KubernetesPrometheus adjusts each data point's timestamp according to the collection interval (#2441)
- Container log collection supports setting `from-beginning` attribute in Annotation/Label (#2443)
- Optimize data point upload strategy, support ignoring overly large data points to prevent entire data packet transmission failure (#2440)
- Datakit API `/v1/write/:category` improves zlib format encoding support (#2439)
- Optimize DDTrace data point processing strategy, reducing memory footprint (#2434)
- Log collection process adds about 10MiB cache (dynamically allocated for each currently collected file) to avoid data loss (#2432)
- Optimize resource usage during eBPF collection (#2430)
- Optimize GZip efficiency during uploads (#2428)
- Numerous other performance optimizations (#2414)
    - Optimize Prometheus exporter data collection performance, reducing memory consumption
    - Default enable [HTTP API throttling](datakit-conf.md#set-http-api-limit), preventing excessive sudden traffic consuming too much memory
    - Add [WAL disk queue](datakit-conf.md#dataway-wal), handling possible memory consumption caused by upload blockage. The newly added disk queue *defaults to caching failed upload data*.
    - Refine Datakit self-memory usage metrics, adding multiple dimensions of memory usage to metrics
    - `datakit monitor -V` command adds WAL panel display
    - Optimize KubernetesPrometheus collection performance (#2426)
    - Optimize container log collection performance (#2425)
    - Remove log debugging-related fields to optimize network traffic and storage

---

## 1.60.0 (2024/10/18) {#cl-1.60.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.60.0-new}

- Add prom v2 collector, compared to v1, its parsing performance has been greatly optimized (#2427)
- [APM Automatic Instrumentation](datakit-install.md#apm-instrumentation): During Datakit installation, set specific switches and restart corresponding applications (Java/Python) to automatically inject APM (#2139)
- RUM Session Replay data supports linking blacklist rules configured centrally (#2424)
- Datakit [`/v1/write/:category` interface](apis.md#api-v1-write) adds support for multiple compression formats (HTTP `Content-Encoding`) (#2368)

### Bug Fixes {#cl-1.60.0-fix}

- Fix potential crash in HTTP service caused by timeout components (#2423)
- Fix time unit issues in New Relic collection (#2417)
- Fix potential crash in Pipeline `point_window()` function (#2416)

### Function Optimization {#cl-1.60.0-opt}

- Numerous performance optimizations in this version (#2414)

    - Experimental feature point-pool is default-enabled
    - Optimize Prometheus exporter data collection performance, reducing memory consumption
    - Default enable [HTTP API throttling](datakit-conf.md#set-http-api-limit), preventing excessive sudden traffic consuming too much memory
    - Add [WAL disk queue](datakit-conf.md#dataway-wal), handling possible memory consumption caused by upload blockage. The newly added disk queue *defaults to caching failed upload data*.
    - Refine Datakit self-memory usage metrics, adding multiple dimensions of memory usage to metrics
    - `datakit monitor -V` command adds WAL panel display
    - Optimize KubernetesPrometheus collection performance (#2426)
    - Optimize container log collection performance (#2425)
    - Remove log debugging-related fields to optimize network traffic and storage

### Compatibility Adjustment {#cl-1.60.0-brk}

- Due to some performance adjustments, there are some compatibility differences in the following parts:

    - Maximum single HTTP body upload size adjusted to 1MB. Meanwhile, the maximum single log size is also reduced to 1MB. This adjustment aims to reduce memory pool usage in low-load scenarios.
    - Deprecated previous failed retransmission disk queue (default not enabled). The new version defaults to enabling the new failed retransmission disk queue.

---

## 1.39.0 (2024/09/25) {#cl-1.39.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.39.0-new}

- Add vSphere collector (#2322)
- Profiling collection supports extracting basic metrics from Profile files (#2335)

### Bug Fixes {#cl-1.39.0-fix}

- Fix unnecessary collection starting in KubernetesPrometheus collection (#2412)
- Fix potential crash in Redis collector (#2411)
- Fix RabbitMQ crash issue (#2410)
- Fix `up` metric not truly reflecting collector operation status (#2409)

### Function Optimization {#cl-1.39.0-opt}

- Perfect Redis big-key collection compatibility (#2404) - Synthetic Tests collector supports custom tag field extraction (#2402)
- Other documentation optimizations (#2401)

---

## 1.38.2 (2024/09/19) {#cl-1.38.2}

This release is a Hotfix release, fixing the following issues:

- Fix Nginx collection error in global-tag addition (#2406)
- Fix Windows CPU core collection error in host object collector (#2398)
- Chrony collector adds synchronization with Dataway timing mechanism, avoiding collection data affected by local Datakit time deviation (#2351)
    - This feature depends on Dataway version 1.6.0 (inclusive) and above
- Fix potential crash in Datakit HTTP API under timeout conditions (#2091)

---

## 1.38.1 (2024/09/11) {#cl-1.38.1}

This release is a Hotfix release, fixing the following issues:

- Fix label errors in `inside_filepath` and `host_filepath` in container log collection (#2403)
- Fix special case collection anomalies in Kubernetes-Prometheus collector (#2396)
- Fix various issues in the upgrade program (2372):
    - Offline installation directory error issue
    - Configuration of `dk_upgrader` itself can sync with Datakit configuration during installation/upgrade (no manual configuration required), DCA does not need to concern whether it's offline or online upgrade.
    - Installation stage can inject some ENV related to `dk_upgrader` without requiring extra manual configuration
    - `dk_upgrader` HTTP API adds new parameters, allowing specifying version number and forced upgrade (DCA side temporarily does not support this feature)

---

## 1.38.0 (2024/09/04) {#cl-1.38.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.38.0-new}

- Add Graphite data ingestion (#2337)
<!-- - Profiling collection supports real-time metric extraction from profiling files (#2335) -->

### Bug Fixes {#cl-1.38.0-fix}

- Fix abnormal network data aggregation in eBPF (#2395)
- Fix DDTrace telemetry interface crash issue (#2387)
- Fix Jaeger UDP binary format data collection issue (#2375)
- Fix address format issues in synthetic tests collection (#2374)

### Function Optimization {#cl-1.38.0-opt}

- Host object adds multiple fields (`num_cpu/unicast_ip/disk_total/arch`) collection (#2362)
- Other optimizations and fixes (#2376/#2354/#2393)

### Compatibility Adjustment {#cl-1.38.0-brk}

- Adjust Pipeline execution priority (#2386)

    In previous versions, for a specific `source`, such as `nginx`:

    1. If users specify a match *nginx.p* on the page,
    1. If users also set a default Pipeline (*default.p*)

    Then Nginx logs would not be split using *nginx.p*, but instead use *default.p*. This setting was unreasonable, and the adjusted priority order is as follows (priority decreases):

    1. Pipeline specified for `source` on the Guance page
    1. Pipeline specified for `source` in the collector
    1. Find corresponding Pipeline for `source` value (for example, find *my-app.p* for logs with `source` as `my-app`)
    1. Finally use *default.p*

    This adjustment ensures all data can be split by Pipeline, at least having *default.p* as fallback.

---

## 1.37.0 (2024/08/28) {#cl-1.37.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.37.0-new}

- Add collector support for [Zabbix data import](../integrations/zabbix_exporter.md)(#2340)

### Function Optimization {#cl-1.37.0-opt}

- Optimize process collector, default support opening fd count collection (#2384)
- Complete RabbitMQ tag (#2380)
- Optimize Kubernetes-Prometheus collector performance (#2373)
- Redis collection adds more metrics (#2358)

---

## 1.36.0 (2024/08/21) {#cl-1.36.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.36.0-new}

- Pipeline adds functions `pt_kvs_set`, `pt_kvs_get`, `pt_kvs_del`, `pt_kvs_keys`, and `hash` (#2353)
- Synthetic Tests collector supports custom tags and node English names (#2365)

### Bug Fixes {#cl-1.36.0-fix}

- Fix memory leak in eBPF collector (#2352)
- Fix duplicate collection issue in Kubernetes Events accepting Deleted data (#2363)
- Fix target tag not found in KubernetesPrometheus collector for Service/Endpoints (#2349)
    - Note, here requires updating *datakit.yaml*

### Function Optimization {#cl-1.36.0-opt}

- Optimize slow query time filter condition in Oracle collector (#2360)
- Optimize collection method for metric `postgresql_size` in PostgreSQL collector (#2350)
- Improve return information of synthetic test debug interface (#2347)
- Optimize Pipeline handling of `status` field for log-type data, new versions support any custom log levels (#2371)
- BPF network logs add fields indicating client/server IPs, ports, and connection sides (#2357)
- TCP Socket log collection supports multiline configuration (#2364)
- Kubernetes deployment supports distinguishing `host` field values by [adding prefixes/suffixes](datakit-daemonset-deploy.md#env-rename-node) if there are same-name Nodes (#2361)
- Change collector data reporting to default global blocking mode to alleviate (note only alleviate, **cannot prevent**) time-series data loss due to queue blockage (#2370)
    - Adjusted some monitor information displays: 1) Displays blocked duration for collectors reporting data (P90); 2) Displays the number of data points per collection for each collector (P90), clearly showing the collection volume of specific collectors.

---

## 1.35.0 (2024/08/07) {#cl-1.35.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.35.0-new}

- Add [election whitelist](election.md#election-whitelist) functionality, facilitating the specification of particular hosts for Datakit election participation (#2261)

### Bug Fixes {#cl-1.35.0-fix}

- Fix association of container ID in CentOS process collector (#2338)
- Fix multiline judgment failure in log collection (#2336)
- Fix Jaeger Trace-ID length issue (#2329)
- Other bug fixes (#2343)

### Function Optimization {#cl-1.35.0-opt}

- `up` Metrics supports automatic addition of collector custom tags (#2334)
- Host object collection cloud information sync supports specifying meta address, convenient for private cloud deployment environments (#2331)
- DDTrace collector supports collecting basic information of traced services, reporting them to resource objects (`CO::`), whose object type is `tracing_service` (#2307)
- Network synthetic test data collection adds `node_name` field (#2324)
- Kubernetes-Prometheus metrics collection adds `__kubernetes_mate_instance` and `__kubernetes_mate_host` placeholder tags, optimizing tag addition strategy (#2341) [^2341]
- Optimize TLS configurations for multiple collectors (#2225/#2204/#2192/#2342)
- eBPF link plugin adds PostgreSQL and AMQP protocol identification (#2315/#2311)

[^2341]: If the service restarts, the corresponding `instance` and `host` may completely change, resulting in doubled timelines.

---

## 1.34.0 (2024/07/24) {#cl-1.34.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.34.0-new}

- Add custom object collection for mainstream collectors like Oracle/MySQL/Apache etc. (#2207)
- Remote collectors add `up` metrics (#2304)
- Statsd collector exposes its own metrics (#2326)
- Add [CockroachDB collector](../integrations/cockroachdb.md) (#2187)
- Add [AWS Lambda collector](../integrations/awslambda.md) (#2258)
- Add [Kubernetes Prometheus collector](../integrations/kubernetesprometheus.md), achieving automatic Prometheus discovery (#2246)

### Bug Fixes {#cl-1.34.0-fix}

- Fix excessive memory usage of certain Windows versions in bug report and Datakit self-collector, temporarily removing some metrics exposure to bypass (#2317)
- Fix `datakit monitor` not displaying collectors originating from Confd (#2160)
- Fix container logs not being collected if manually specified as stdout in Annotations (#2327)
- Fix eBPF network log collector obtaining K8s labels abnormally (#2325)
- Fix RUM collector concurrent read/write error (#2319)

### Function Optimization {#cl-1.34.0-opt}

- Optimize OceanBase collector view templates, and add `cluster` Tag to metric `oceanbase_log` (#2265)
- Optimize synthetic test collector task failure exceeding threshold leading to task termination issue (#2314)
- Pipeline supports adding script execution information into data, and `http_request` function supports body parameter (#2313/#2298)
- Optimize eBPF collector memory usage (#2328)
- Other documentation optimizations (#2320)

---

## 1.33.1 (2024/07/11) {#cl-1.33.1}

This release is a Hotfix release, fixing the following issues:

- Fix trace sampling invalid issue, adding `dk_sampling_rate` field on root-span to indicate the trace has been sampled. **It is recommended to upgrade** (#2312)
- Fix IP handling bug in SNMP collection, simultaneously exposing a batch of SNMP collection metrics during collection (#3099)

---

## 1.33.0 (2024/07/10) {#cl-1.33.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.33.0-new}

- Add [OpenTelemetry log collection](../integrations/opentelemetry.md#logging) (#2292)
- Restructure [SNMP collector](../integrations/snmp.md), adding Zabbix/Prometheus two configuration supports, while adding its corresponding built-in views (#2290)

### Bug Fixes {#cl-1.33.0-fix}

- Fix HTTP synthetic test issues (#2293)
    - Issue where response time (`response_time`) did not include download time (`response_download`)
    - IPv6 recognition issue in HTTP synthetic tests
- Fix Oracle collector crash and max-cursor issues (#2297)
- Fix position record issues in log collection, introduced since version 1.27, **it is recommended to upgrade** (#2301)
- Fix some customer-tags not taking effect when receiving data in DDTrace/OpenTelemetry HTTP API (#2308)

### Function Optimization {#cl-1.33.0-opt}

- Redis big-key collection adds 4.x version support (#2296)
- Adjust internal worker counts based on actual restricted CPU cores, greatly reducing buffer memory overhead, **it is recommended to upgrade** (#2275)
- Datakit API changes default to blocking form when receiving time-series data, avoiding data point loss (#2300)
- Optimize performance of `grok()` function in Pipeline (#2310)
- [Bug report](why-no-data.md#bug-report) adds eBPF related information and Pipeline information (#2289)
- k8s auto-discovery ServiceMonitor supports configuring TLS certificate paths (#1866)
- Object and metrics data collection in [Host Process collector](../integrations/host_processes.md) adds corresponding container ID field (`container_id`) (#2283)
- Trace data collection adds Datakit fingerprint field (`datakit_fingerprint`, value is Datakit's hostname), facilitating troubleshooting, while exposing some collection process metrics (#2295)
    - Add statistics for the number of collected Traces
    - Add statistics for discarded sampled Traces

- Documentation optimization:
    - Add [explanation documentation](bug-report-how-to.md) related to bug-report
    - Supplement [difference explanation](datakit-update.md#upgrade-vs-install) between Datakit installation and upgrade
    - Supplement documents regarding parameter settings during [offline installation](datakit-offline-install.md#simple-install)
    - Optimize [MongoDB collector](../integrations/mongodb.md) field documentation (#2278)

---

## 1.32.0 (2024/06/26) {#cl-1.32.0}

This release is an iterative release, mainly with thefollowing updates:

### New Features {#cl-1.32.0-new}

- OpenTelemetry adds histogram metrics (#2276)

### Bug Fixes {#cl-1.32.0-fix}

- Fix localhost recognition issue in metric reporting (#2281)
- Fix `service` field assignment issue in log collection (#2286)
- Other defect fixes (#2284/#2282)

### Function Optimization {#cl-1.32.0-opt}

- Improve main/sub replication related metrics and log collection in MySQL (#2279)
- Optimize encryption-related documentation and installation options (#2274)
- Optimize memory consumption during DDTrace collection (#2272)
- Health check collector optimizes data reporting strategy (#2268)
- Optimize timeout control and TLS settings in SQLServer collection (#2264)
- Optimize handling of the `job` field in Prometheus-related metrics collection (Push Gateway/Remote Write) (#2271)
- Complete slow query fields in OceanBase, add client IP information (#2280)
- Rewrite Oracle collector (#2186)
- Optimize target domain value acquisition in eBPF collection (#2287)
- Default upload of collected data using v2 (Protobuf) protocol (#2269)
    - [Comparison between v1 and v2](pb-vs-lp.md)
- Other adjustments (#2267/#2255/#2237/#2270/#2248)

---

## 1.31.0 (2024/06/13) {#cl-1.31.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.31.0-new}

- Container objects support appending corresponding Kubernetes Labels (#2252)
- eBPF link plugin adds Redis protocol identification (#2248)

### Bug Fixes {#cl-1.31.0-fix}

- Fix incomplete SNMP collection issues (#2262)
- Fix repeated Pod collection issues in Kubernetes Autodiscovery (#2259)
- Add protection measures to avoid duplicate collection of container-related metrics (#2253)
- Fix Windows platform CPU metric anomaly (huge invalid values) issue (#2028)

### Function Optimization {#cl-1.31.0-opt}

- Optimize PostgreSQL metrics collection (#2263)
- Optimize bpf-netlog collection fields (#2247)
- Complete OceanBase data collection (#2122)
- Other adjustments (#2267/#2255/#2237)

---

## 1.30.0 (2024/06/04) {#cl-1.30.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.30.0-new}

- Pipeline
    - Add `gjson()` function, providing ordered JSON field extraction (#2167)
    - Add context caching functionality (#2157)

### Bug Fixes {#cl-1.30.0-fix}

- Fix global-tag append issue in Prometheus Remote Write (#2244)

[^2244]: This issue was introduced since version 1.25.0. If you have enabled Prometheus Remote Write collector, it is recommended to upgrade.

### Function Optimization {#cl-1.30.0-opt}

- Optimize Datakit [`/v1/write/:category` API](apis.md#api-v1-write), making the following adjustments and functionalities (#2130)
    - Add more API parameters (`echo`/`dry`), facilitating debugging
    - Support more types of data formats
    - Support fuzzy recognition of timestamp precision in data points (#2120)
- Optimize MySQL/Nginx/Redis/SQLServer metrics collection (#2196)
    - MySQL adds master-slave replication related metrics
    - Redis slow logs add time-consuming metrics
    - Nginx adds more Nginx Plus related metrics
    - SQLServer optimizes Performance-related metric structure
- MySQL collector adds low-version TLS support (#2245)
- Optimize TLS certificate configuration for Kubernetes self etcd metrics collection (#2032)
- Prometheus Exporter metrics collection supports "preserve original metric name" configuration (#2231)
- Kubernetes Node object adds taint-related information (#2239)
- eBPF-Tracing adds MySQL protocol identification (#1768)
- Optimize ebpftrace collector performance (#2226)
- Synthetic Tests collector running status can be displayed on `datakit monitor` command panel (#2243)
- Other view and documentation optimizations (#1976/#1977/#2194/#2195/#2221/#2235)

### Compatibility Adjustment {#cl-1.30.0-brk}

In this version, the data protocol has been extended. After upgrading from older versions of Datakit, if the central base is a private deployment, one of the following measures can be taken to maintain data compatibility:

- Upgrade the central base to [1.87.167](../deployment/changelog/2024.md#1.87.167), or
- Modify *datakit.conf* [upload protocol configuration `content_encoding`](datakit-conf.md#dataway-settings), changing it to `v2`

#### Explanation for InfluxDB Deployment Version {#cl-1.30.0-brk-influxdb}

If the central base's time-series storage is InfluxDB, **do not upgrade Datakit**, remain at version 1.29.1. Central upgrades are required before upgrading to higher Datakit versions.

Additionally, if the center has been upgraded to a newer version (1.87.167+), then lower versions of Datakit should **not use the `v2` upload protocol**, revert to the `v1` upload protocol.

If you indeed need to upgrade to a newer Datakit version, replace the time-series engine with GuanceDB for metrics.

---

## 1.29.1 (2024/05/20) {#cl-1.29.1}

This release is a Hotfix release, fixing the following issues:

- Fix potential crash in MongoDB collector (#2229)

---

## 1.29.0 (2024/05/15) {#cl-1.29.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.29.0-new}

- Container log collection supports configuring color character filtering `remove_ansi_escape_codes` in Annotations (#2208)
- [Health Check collector](../integrations/host_healthcheck.md) supports command-line parameter filtering (#2197)
- Add [Cassandra collector](../integrations/cassandra.md) (#1812)
- Add usage statistics feature (#2177)
- eBPF Tracing adds HTTP2/gRPC support (#2017)

### Bug Fixes {#cl-1.29.0-fix}

- Fix Kubernetes not collecting Pending Pods issue (#2214)
- Fix logfwd existence of startup failure issue (#2216)
- Fix special cases where color character filtering was not executed in log collection (#2209)
- Fix Profile collection not being able to append Tag issue (#2205)
- Fix Goroutine leak potentially caused by Redis/MongoDB collectors (#2199/#2215)

### Function Optimization {#cl-1.29.0-opt}

- Support insecureSkipVerify configuration item for Prometheus PodMonitor/ServiceMonitor TLSConfig (#2211)
- Strengthen security of synthetic test debug interface (#2203)
- Nginx collector supports port range specification (#2206)
- Improve TLS certificate-related ENV settings (#2198)
- Other documentation optimizations (#2210/#2213/#2218/#2223/#2224/#2141/#2080)

### Compatibility Adjustment {#cl-1.29.0-brk}

- Remove file path method for Prometheus PodMonitor/ServiceMonitor TLSConfig certificates (#2211)
- Optimize DCA routing parameter and reload logic (#2220)

---

## 1.28.1 (2024/04/22) {#cl-1.28.1}

This release is a Hotfix release, fixing the following issues:

- Fix some crashes leading to no data issue (#2193)

---

## 1.28.0 (2024/04/17) {#cl-1.28.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.28.0-new}

- Pipeline adds `cache_get()/cache_set()/http_request()` functions for external data source expansion (#2128)
- Support collecting Kubernetes system resource Prometheus metrics, currently experimental (#2032)
    - Some cloud-managed Kubernetes might not be collectible due to corresponding authorization being turned off

### Bug Fixes {#cl-1.28.0-fix}

- Fix filter logic issue in container logs (#2188)

### Function Optimization {#cl-1.28.0-opt}

- PrometheusCRD-ServiceMonitor supports TLS path configuration (#2168)
- Optimize NIC information collection under Bond mode (#1877)
- Further optimize Windows Event collection performance (#2172)
- Optimize field information extraction in Jaeger APM data collection (#2174)
- Remove disk cache functionality in log collection (#2191)
- Log collection adds `log_file_inode` field
- Add point-pool configuration to optimize Datakit's memory usage under high load (#2034)
    - Restructure some Datakit modules to optimize GC costs; this optimization slightly increases memory usage in low-load situations (extra memory is primarily used for memory pooling).
- Other documentation adjustments and detail optimizations (#2191/#2189/#2185/#2181/#2180)

---

## 1.27.0 (2024/04/03) {#cl-1.27.0}

### New Features {#cl-1.27.0-new}

- Add Pipeline Offload collector, specifically for centralized Pipeline processing (#1917)
- Support BPF-based HTTP/HTTP2/gRPC network data collection to cover lower Linux kernel versions (#2017)

### Bug Fixes {#cl-1.27.0-fix}

- Fix default time chaos issue in Point construction (#2163)
- Fix potential crash in Kubernetes collection (#2176)
- Fix Nodejs Profiling collection issue (#2149)

### Function Optimization {#cl-1.27.0-opt}

- Prometheus Remote Write collection supports grouping metrics by metric prefixes (#2165)
- Perfect Datakit self-metrics, adding crash count statistics for each module's Goroutines (#2173)
- Perfect bug report functionality, supporting direct upload of info files to OSS (#2170)
- Optimize Windows Event collection performance (#2155)
- Optimize historical position record function in log collection (#2156)
- Synthetic Tests collector supports disabling internal network tests (#2142)
- Other miscellaneous items and documentation updates (#2154/#2148/#1975/#2164)

---

## 1.26.1 (2024/03/27) {#cl-1.26.1}

This release is a Hotfix release, fixing the following issues:

- Fix Redis not supporting TLS issue (#2161)
- Fix time unit issue in Trace data (#2162)
- Fix vmalert writing to Prometheus Remote Write issue (#2153)

---

## 1.26.0 (2024/03/20) {#cl-1.26.0}

### New Features {#cl-1.26.0-new}

- Add Doris collector (#2137)

### Bug Fixes {#cl-1.26.0-fix}

- Fix DDTrace header sampling followed by repeated resampling issue (#2131)
- Fix missing tag issue in custom SQLServer collection (#2144)
- Fix repeated collection issue in Kubernetes Events (#2145)
- Fix inaccurate collection of container counts in Kubernetes (#2146)
- Fix incorrect sampling of some Traces in Trace collection (#2135)

### Function Optimization {#cl-1.26.0-opt}

- *datakit.conf* adds upgrade program configurations, while the host object collector also adds fields related to the upgrade program (#2124)
- Perfect bug report functionality, attaching error information to attachments (#2132)
- Optimize TLS settings and default collector configuration file in MySQL collector (#2134)
- Optimize host cloud sync global tag configuration logic, allowing cloud-synced tags not to be added to global-host-tags (#2136)
- Add `redis-cli` command in Datakit image, facilitating big-key/hot-key collection in Redis (#2138)
- Add `offset/partition` fields in Kafka-MQ collected data (#2140)
- Other miscellaneous items and documentation updates (#2133/#2143)

---

## 1.25.0 (2024/03/06) {#cl-1.25.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.25.0-new}

- Datakit API adds dynamic update interfaces for Global Tags (#2076)
- Add Kubernetes PersistentVolume / PersistentVolumeClaim collection, requiring additional [RBAC](../integrations/container.md#rbac-pv-pvc) (#2109)

### Bug Fixes {#cl-1.25.0-fix}

- Fix SkyWalking RUM root-span issue (#2131)
- Fix incomplete Windows Event collection issue (#2118)
- Fix missing `host` field in Pinpoint collection (#2114)
- Fix RabbitMQ metrics collection issue (#2108)
- Fix OpenTelemetry old version compatibility issue (#2089)
- Fix Containerd log line parsing error (#2121)

### Function Optimization {#cl-1.25.0-opt}

- StatsD count-type data defaults to converting into floats (#2127)
- Container collector supports Docker 1.24+ versions (#2112)
- Optimize SQLServer collector (#2105)
- Optimize Health Check collector (#2105)
- Default time value in log collection (#2116)
- Add the ability to disable Kubernetes Job resource collection using environment variable `ENV_INPUT_CONTAINER_DISABLE_COLLECT_KUBE_JOB` (#2129)
- Update a batch of collector built-in views:
    - ssh (#2125)
    - etcd (#2101)
- Other miscellaneous items and documentation updates (#2119/#2123/#2115/#2113)

---

## 1.24.0 (2024/01/24) {#cl-1.24.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.24.0-new}

- Add new [Host Health Check collector](../integrations/host_healthcheck.md) (#2061)

### Bug Fixes {#cl-1.24.0-fix}

- Fix potential crash in Windows Event collection (#2087)
- Fix data recording feature issues and improve [related documentation](datakit-daemonset-deploy.md#env-recorder) (#2092)
- Fix multi-link propagation concatenation issue in DDTrace (#2093)
- Fix truncation issue in Socket log collection (#2095)
- Fix residual main configuration file issue during Datakit upgrade (#2096)
- Fix script overwrite issue (#2085)

### Function Optimization {#cl-1.24.0-opt}

- Optimize resource limit functionality for non-root installations on Linux (#2011)
- Optimize performance of分流and blacklist matching, significantly reducing memory consumption by up to 10X (#2077)
- Log Streaming collection [supports FireLens type](../integrations/logstreaming.md#firelens) (#2090)
- Log Forward collection adds `log_read_lines` field (#2098)
- Optimize handling of `cluster_name_k8s` tag in K8s (#2099)
- K8s Pod time-series metrics add restart count (`restarts`) metric
- Optimize time-series measurement set `kubernetes`, adding container statistics
- Optimize Kubelet metrics collection logic

---

## 1.23.1 (2024/01/12) {#cl-1.23.1}

This release is a Hotfix release, fixing the following issues:

- Fix abnormal Datakit service issue on Windows

---

## 1.23.0 (2024/01/11) {#cl-1.23.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.23.0-new}

- Kubernetes deployment supports configuring any collector through environment variables (`ENV_DATAKIT_INPUTS`) (#2068)
- Container collector supports finer-grained configurations, converting Kubernetes object labels into data tags (#2064)
    - `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2_FOR_METRIC`: Supports converting labels into metric-type data tags
    - `ENV_INPUT_CONTAINER_EXTRACT_K8S_LABEL_AS_TAGS_V2` supports converting labels into non-metric-type (e.g., object/logs etc.) data tags

### Bug Fixes {#cl-1.23.0-fix}

- Fix occasional errors in `deployment` and `daemonset` fields in container collector (#2081)
- Fix losing last few lines of logs after short-lived containers exit (#2082)
- Fix Oracle collector slow query SQL time error (#2079)
- Fix Prom collector `instance` setting issue (#2084)

### Function Optimization {#cl-1.23.0-opt}

- Optimize Prometheus Remote Write collection (#2069)
- eBPF collection supports setting resource usage (#2075)
- Optimize Profiling data collection process (#2083)
- [MongoDB](../integrations/mongodb.md) collector supports separate username and password configuration (#2073)
- [SQLServer](../integrations/sqlserver.md) collector supports instance name configuration (#2074)
- Optimize [ElasticSearch](../integrations/elasticsearch.md) collector views and monitors (#2058)
- [KafkaMQ](../integrations/kafkamq.md) collector supports multithreaded mode (#2051)
- [SkyWalking](../integrations/skywalking.md) collector adds support for Meter data type (#2078)
- Update some collector documents and other bug fixes (#2074/#2067)
- Optimize Proxy agent installation upgrade commands (#2033)
- Optimize resource restriction functionality for non-root user installations (#2011)

---

## 1.22.0 (2023/12/28) {#cl-1.22.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.22.0-new}

- Add [OceanBase](../integrations/oceanbase.md) custom SQL collection (#2046)
- Add blacklist/whitelist for [Prometheus Remote](../integrations/prom_remote_write.md) (#2053)
- Kubernetes resource count collection adds `node_name` tag (only supported for Pod resources) (#2057)
- Kubernetes Pod metrics add `cpu_limit_millicores/mem_limit/mem_used_percent_base_limit` fields
- eBPF collector adds `bpf-netlog` plugin (#2017)
- Kubernetes data recording function supports configuration via environment variables

### Bug Fixes {#cl-1.22.0-fix}

- Fix zombie process issue in [`external`](../integrations/external.md) collector (#2063)
- Fix conflict issue in container log tags (#2066)
- Fix virtual NIC information retrieval failure (#2050)
- Fix Pipeline Refer table and IPDB functionality loss issue (#2045)

### Optimization {#cl-1.22.0-opt}

- Optimize whitelist functionality for DDTrace and OTEL field extraction (#2056)
- Optimize SQL for obtaining `sqlserver_lock_dead` metrics in [SQLServer](../integrations/sqlserver.md) collector (#2049)
- Optimize connection library in [PostgreSQL](../integrations/postgresql.md) collector (#2044)
- Optimize configuration file in [ElasticSearch](../integrations/elasticsearch.md) collector, setting `local` default to `false` (#2048)
- Kubernetes installation adds more ENV configuration items (#2025)
- Optimize Datakit self-metrics exposure
- Update some collector integration documents

---

## 1.21.1 (2023/12/21) {#cl-1.21.1}

This release is a Hotfix release, fixing the following issues:

- Fix Prometheus Remote Write not adding Datakit host-class Tag issue, mainly compatible with previous old configurations (#2055)
- Fix several middleware default log collections not adding host-class Tag issue
- Fix Chinese character color erase garbled issue in log collection

---

## 1.21.0 (2023/12/14) {#cl-1.21.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.21.0-new}

- Add [ECS Fargate collection mode](ecs-fargate.md) (#2018)
- Add tag whitelist for [Prometheus Remote](../integrations/prom_remote_write.md) collector (#2031)

### Bug Fixes {#cl-1.21.0-fix}

- Fix version detection issue in [PostgreSQL](../integrations/postgresql.md) collector (#2040)
- Fix account permission settings issue in [ElasticSearch](../integrations/elasticsearch.md) collector (#2036)
- Fix crash on disk root directory collection in [Host Dir](../integrations/hostdir.md) collector (#2037)

### Optimization {#cl-1.21.0-opt}

- Optimize DDTrace collector: [Remove duplicate tags in `message.Mate`](../integrations/ddtrace.md#tags) (#2010)
- Optimize search strategy for log file paths inside containers (#2027)
- [Synthetic Tests collector](../integrations/dialtesting.md) adds `datakit_version` field and sets collection time as task execution start time (#2029)
- Remove `datakit export` command to optimize binary package size (#2024)
- Debugging configuration [adds number of time-series points](why-no-data.md#check-input-conf) (#2016)
- [Profile collection](../integrations/profile.md) implements asynchronous reporting via disk cache (#2041)
- Optimize Windows Datakit installation script (#2026)
- Update a batch of collector built-in views and monitors

### Breaking Changes {#cl-1.21.0-brk}

- DDTrace collection no longer extracts all fields by default, which may lead to missing custom fields on certain pages. This can be achieved by writing Pipeline or using new JSON view syntax (`message@json.meta.xxx`) to extract specific fields.

---

## 1.20.1 (2023/12/07) {#cl-1.20.1}

This release is a Hotfix release, fixing the following issues:

### Bug Fixes {#cl-1.20.1-fix}

- Fix a sampling bug in DDTrace
- Fix bug causing `error_message` information loss
- Fix bug where Kubernetes Pod object data did not correctly collect deployment field

## 1.20.0 (2023/11/30) {#cl-1.20.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.20.0-new}

- [Redis](../integrations/redis.md) collector adds hotkey metrics (#2019)
- Monitor command supports playing [bug report](why-no-data.md#bug-report) metrics data (#2001)
- [Oracle](../integrations/oracle.md) collector adds custom queries (#1929)
- [Container](../integrations/container.md) log files inside containers support glob collection (#2004)
- Kubernetes Pod metrics support `network` and `storage` field collection (#2022)
- [RUM](../integrations/rum.md) adds configuration support for session replay filtering (#1945)

### Bug Fixes {#cl-1.20.0-fix}

- Fix panic error in cgroup environments (#2003)
- Fix Windows installation script failing on older PowerShell versions (#1997)
- Fix default disk cache enabling issue (#2023)
- Adjust naming style of Kubernetes Auto-Discovery Prometheus measurement sets (#2015)

### Function Optimization {#cl-1.20.0-opt}

- Optimize built-in collector template view and monitor view export logic and update MySQL/PostgreSQL/SQLServer view templates (#2008/#2007/#2013/#2024)
- Optimize Prom collector metric names (#2014)
- Optimize Proxy collector, providing basic performance testing benchmarks (#1988)
- Container log collection supports adding Labels of the associated Pod (#2006)
- Collect Kubernetes data using `NODE_LOCAL` mode by default, requiring additional [RBAC](../integrations/container.md#rbac-nodes-stats) (#2025)
- Optimize tracing processing flow (#1966)
- Restructure PinPoint collector, optimizing hierarchical relationships (#1947)
- APM supports discarding `message` fields to save storage (#2021)

---

## 1.19.2 (2023/11/20) {#cl-1.19.2}

This release is a Hotfix release, mainly with the following updates:

### Bug Fixes {#cl-1.19.2-fix}

- Fix disk cache bug leading to session replay data loss
- Add Prometheus metrics regarding resource collection duration in Kubernetes

---

## 1.19.1 (2023/11/17) {#cl-1.19.1}

This release is a Hotfix release, fixing the following issues:

### Bug Fixes {#cl-1.19.1-fix}

- Fix inability to start due to *.pos* file issues in disk cache ([issue](https://github.com/GuanceCloud/cliutils/pull/59){:target="_blank"})

---

## 1.19.0 (2023/11/16) {#cl-1.19.0}
This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.19.0-new}

- Support [OceanBase](../integrations/oceanbase.md) MySQL mode collection (#1952)
- Add [data recording/playback](datakit-tools-how-to.md#record-and-replay) functionality (#1738)

### Bug Fixes {#cl-1.19.0-fix}

- Fix invalid resource limit problem on Windows low versions (#1987)
- Fix ICMP synthetic test issues (#1998)

### Function Optimization {#cl-1.19.0-opt}

- Optimize statsd collection (#1995)
- Optimize Datakit installation script (#1979)
- Optimize MySQL built-in views (#1974)
- Perfect Datakit self-metrics exposure, adding complete Golang runtime and multiple metrics (#1971/#1969)
- Other document optimizations and unit test optimizations (#1952/#1993)
- Perfect Redis metric collection, adding more metrics (#1940)
- TCP synthetic test allows adding ASCII text packet checks (#1934)
- Optimize issues during non-root user installation:
    - May fail to start due to ulimit setting failures (#1991)
    - Perfect documentation, adding restricted functionality descriptions for non-root installations (#1989)
    - Adjust pre-install operations for non-root installations to manual configuration, avoiding possible command differences across operating systems (#1990)
- MongoDB collector adds support for older versions 2.8.0 (#1985)
- RabbitMQ collector adds support for older versions (3.6.X/3.7.X) (#1944)
- Optimize Pod metrics collection in Kubernetes to replace original Metric Server method (#1972)
- Kubernetes Prometheus metrics collection allows adding measurement set name configuration (#1970)

### Compatibility Adjustment {#cl-1.19.0-brk}

- Due to the addition of data recording/playback functionality, the function that writes data to files has been removed (#1738)

---

## 1.18.0 (2023/11/02) {#cl-1.5.10}

This release is an urgent release, mainly with the following updates:

### New Features {#cl-1.18.0-new}

- Automatically discover and collect [Pod Prometheus metrics](kubernetes-prom.md#auto-discovery-metrics-with-prometheus)(#1564)
- Pipeline adds aggregation functions (#1554)
    - [agg_create()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-agg-create)
    - [agg_metric()](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-agg-metric)

### Function Optimization {#cl-1.18.0-opt}

- Optimize Pipeline execution performance, approximately 30% improvement
- Optimize history position record operation in log collection (#1550)

---

## 1.17.0 (2023/10/19) {#cl-1.17.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.17.0-new}

- Pipeline
    - `json` function adds [key deletion](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) functionality (#1567)
    - Adds function [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) (#1414)
    - Adds [datetime functions](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-datetime) (#1411)
- Add [IPv6 support](datakit-conf.md#config-http-server) (#1454)
- Disk IO collection supports [io wait extended metrics](diskio.md#extend) (#1472)
- Container collection supports [Docker and containerd coexistence](container.md#requrements) (#1401)
- Integrate [Datakit Operator configuration documentation](datakit-operator.md) (#1482)

### Bug Fixes {#cl-1.17.0-fix}

- Fix Pipeline bugs (#1476/#1469/#1471/#1466)
- Fix *datakit.yaml* missing `request` causing container Pending (#1470)
- Fix repeated probing during cloud synchronization (#1443)
- Fix encoding error in log disk cache (#1474)

### Function Optimization {#cl-1.17.0-opt}

- Optimize Point Checker (#1478)
- Optimize performance of [`replace()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-replace.md) in Pipeline (#1477)
- Optimize Windows Datakit installation process (#1404)
- Optimize [cgroup v2](datakit-conf.md#resource-limit) support (#1494)
- Kubernetes installation adds environment variable (`ENV_CLUSTER_K8S_NAME`) to configure cluster name (#1504)
- Pipeline
    - [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) adds mandatory protection measures to avoid data inflation (#1510)
    - About JSON handling, optimize [`json()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) and [`delete()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-delete) key deletion functionality.
- Other engineering optimizations (#1500)

### Documentation Adjustments {#cl-1.17.0-doc}

- Add Kubernetes fully offline installation [documentation](datakit-offline-install.md#k8s-offline) (#1480)
- Perfect StatsD and DDTrace-Java related documentation (#1481/#1507)
- Supplement TDEngine related documentation (#1486)
- Remove outdated field descriptions in disk collector documentation (#1488)
- Perfect Oracle collector documentation (#1519)

---

## 1.16.1 (2023/10/09) {#cl-1.16.1}

This release is a Hotfix release, mainly with the following updates:

### Bug Fixes {#cl-1.16.1-fix}

- Fix lost container log collection issue (#1520)
- Datakit automatically creates Pythond directory upon startup (#1484)
- Remove single-instance restriction for [host directory](hostdir.md) collector (#1498)
- Fix an eBPF numerical construction issue (#1509)
- Fix Datakit monitor parameter recognition issue (#1506)

### Function Optimization {#cl-1.16.1-opt}

- Jenkins collector complements memory-related metrics (#1489)
- Perfect [cgroup v2](datakit-conf.md#resource-limit) support (#1494)
- Kubernetes installation adds environment variable (`ENV_CLUSTER_K8S_NAME`) to configure cluster name (#1504)
- Pipeline
    - [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) adds forced protection measures to avoid data bloating (#1510)
    - Regarding JSON handling, optimize [`json()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) and [`delete()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-delete) key deletion functionality.
- Other engineering optimizations (#1500)

### Documentation Adjustments {#cl-1.16.1-doc}

- Add Kubernetes full offline installation [documentation](datakit-offline-install.md#k8s-offline) (#1480)
- Perfect StatsD and DDTrace-Java related documentation (#1481/#1507)
- Supplement TDEngine related documentation (#1486)
- Remove outdated field descriptions in disk collector documentation (#1488)
- Perfect Oracle collector documentation (#1519)

---

## 1.15.7 (2023/10/09) {#cl-1.15.7}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.7-new}

- Pipeline
    - `json` function adds [key deletion](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-json) functionality (#1465)
    - Add function [`kv_split()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-kv_split) (#1414)
    - Add [time functions](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-datetime) (#1411)
- Add [IPv6 support](datakit-conf.md#config-http-server) (#1454)
- Disk IO collection supports [io wait extended metrics](diskio.md#extend) (#1472)
- Container collection supports [Docker and containerd coexistence](container.md#requrements) (#1401)
- Integrate [Datakit Operator configuration documentation](datakit-operator.md) (#1482)

### Bug Fixes {#cl-1.15.7-fix}

- Fix Pipeline bugs (#1476/#1469/#1471/#1466)
- Fix *datakit.yaml* missing `request` causing container Pending (#1470)
- Fix repeated probing during cloud synchronization (#1443)
- Fix encoding error in log disk cache (#1474)

### Function Optimization {#cl-1.15.7-opt}

- Optimize Point Checker (#1478)
- Optimize Pipeline [`replace()`](../pipeline/use-pipeline/pipeline-built-in-function.md#fn-replace.md) performance (#1477)
- Optimize Windows Datakit installation process (#1404)
- Optimize [configuration center](confd.md) configuration processing (#1402)
- Add [Filebeat](beats_output.md) integration testing capability (#1459)
- Add [Nginx](nginx.md)integration testing capability (#1399)
- Restructure [OpenTelemetry Agent](opentelemetry.md) (#1409)
- Restructure [Datakit Monitor information](datakit-monitor.md#specify-module) (#1261)

---

## 1.15.6 (2023/02/23) {#cl-1.15.6}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.6-new}

- Command-line adds [LP parsing functionality](datakit-tools-how-to.md#parse-lp) (#1412)
- Datakit yaml and helm support resource limit configuration (#1416)
- Datakit yaml and helm support CRD deployment (#1415)
- Add SQLServer integration tests (#1406)
- RUM supports [resource CDN tagging](rum.md#cdn-resolve) (#1384)

### Bug Fixes {#cl-1.15.6-fix}

- Fix RUM request returning 5xx issue (#1412)
- Fix log collection path error issue (#1447)
- Fix K8s Pod (`restarts`) field issue (#1446)
- Fix DataKit filter module crash issue (#1422)
- Fix Point construction tag key naming issue (#1413/#1408)
- Fix Datakit Monitor character set issue (#1405)
- Fix OTEL tag overwrite issue (#1396)
- Fix public API whitelist issue (#1467)

### Function Optimization {#cl-1.15.6-opt}

- Optimize handling of invalid tasks in synthetic tests (#1421)
- Optimize Windows Datakit installation process (#1404)
- Optimize Windows Powershell installation script template (#1403)
- Optimize association methods for Pod/ReplicaSet/Deployment in K8s (#1368)
- Restructure point data structure and functionality (#1400)
- Datakit built-in [eBPF](ebpf.md) collector binary installation (#1448)
- Installation program address changed to CDN address, optimizing download issues (#1457)

### Compatibility Adjustment {#cl-1.15.6-brk}

- Since the eBPF collector is now integrated, remove extra command `datakit install --datakit-ebpf` (#1400)

---

## 1.15.5 (2023/02/09) {#cl-1.15.5}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.5-new}

- Datakit host installation allows custom default collectors to be enabled (#1392)
- Provide OTEL error tracing (#1309)
- Provide RUM Session replay capability (#1283)

### Bug Fixes {#cl-1.15.5-fix}

- Fix log stacking issue (#1394)
- Fix conf.d repeated start of collector issue (#1385)
- Fix OTEL data association issue (#1364)
- Fix OTEL collected data field overwrite issue (#1383)
- Fix Nginx Host recognition error (#1379)
- Fix synthetic test timeout (#1378)
- Fix cloud vendor instance recognition (#1382)

### Function Optimization {#cl-1.15.5-opt}

- Datakit Pyroscope Profiling multi-language recognition (#1374)
- Optimize CPU, Disk, eBPF, Net Chinese and English documentation (#1375)
- Optimize ElasticSearch, PostgreSQL, DialTesting English documentation (#1373)
- Optimize DCA, Profiling documentation (#1371/#1372)
- Optimize log collection process (#1366)
- [IP library installation documentation update](datakit-tools-how-to.md) configuration method documentation support (#1370)

---

## 1.15.4 (2023/01/13) {#cl-1.15.4}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.4-new}

- [Confd adds Nacos backend](confd.md) (#1315/#1327)
- Log collector adds LocalCache feature (#1326)
- Support [C/C++ Profiling](profile-cpp.md) (#1320)
- RUM Session Replay file reporting (#1283)
- WEB DCA supports remote config update (#1284)

### Bug Fixes {#cl-1.15.4-fix}

- Fix K8S failed data collection loss (#1362)
- Fix K8S Host field error (#1351)
- Fix K8S Metrics Server timeout (#1353)
- Fix Containerd environment Annotation configuration issue (#1352)
- Fix Datakit reload crash during restart (#1359)
- Fix Golang Profiler function execution time calculation error (#1335)
- Fix Datakit Monitor character set issue (#1321)
- Fix async-profiler service display issue (#1290)
- Fix Redis collector `slowlog` issue (#1360)

### Function Optimization {#cl-1.15.4-opt}

- Optimize SQL resource usage problem (#1358)
- Optimize Datakit Monitor (#1222)

---

## 1.15.3 (2022/12/29) {#cl-1.15.3}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.3-new}

- Prometheus collector supports collecting data via Unix Socket (#1317)
- Allow [non-root user to run DataKit](datakit-install.md#common-envs) (#1153)

### Bug Fixes {#cl-1.15.3-fix}

- Fix netstat collector link count issue (#1276/#1336)
- Fix Go profiler difference issue (#1328)
- Fix Datakit restart timeout issue (#1297)
- Fix Kafka message truncation issue (#1338)
- Fix Pipeline `drop()` function inefficiency issue (#1343)

### Function Optimization {#cl-1.15.3-opt}

- Optimize eBPF `httpflow` protocol determination (#1318)
- Optimize Windows Datakit installation upgrade command (#1316)
- Optimize Pythond encapsulation (#1304)
- Pipeline provides more detailed operation error messages (#1262)
- Pipeline Ref-Table provides local storage implementation based on SQLite (#1158)
- Optimize SQLServer timeline issue (#1345)

---

## 1.15.2 (2022/12/15) {#cl-1.15.2}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.2-new}

- Add [Golang Profiling](profile-go.md) access (#1265)

### Bug Fixes {#cl-1.15.2-fix}

- logfwd fixes uncollected logs issue (#1288)
- Fix cgroup ineffectiveness issue (#1293)
- Fix DataKit service operation timeout issue (#1297)
- Fix Kafka subscription message truncation issue (#1338)
- Fix Pipeline `drop()` function inefficiency issue (#1343)

### Function Optimization {#cl-1.15.2-opt}

- Optimize format issues in error-stack/error-message (#1307)
- SkyWalking compatibility adjustment, supports full series 8.X (#1296)
- eBPF `httpflow` adds `pid/process_name` fields (#1218/#1124), optimizes kernel version support (#1277)
- Suggest updating *datakit.yaml* as it has been adjusted (#1253)
- GPU card collection supports remote mode (#1312)
- Other detail optimizations (#1311/#1260/#1301/#1291/#1298/#1305)

### Compatibility Adjustment {#cl-1.15.2-brk}

- Remove `datakit --man` command

---

## 1.15.1 (2022/12/01) {#cl-1.15.1}

This release is a Hotfix release, mainly with the following updates:

- Fix logfwd duplicate collection issue

---

## 1.15.0 (2022/11/17) {#cl-1.15.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.15.0-new}

- Prometheus collector supports collecting data via Unix Socket (#1317)
- Allow [non-root user to run DataKit](datakit-install.md#common-envs) (#1153)

### Bug Fixes {#cl-1.15.0-fix}

- Fix netstat collector link count issue (#1276/#1336)
- Fix Go profiler difference issue (#1328)
- Fix Datakit restart timeout issue (#1297)
- Fix Kafka message truncation issue (#1338)
- Fix Pipeline `drop()` function inefficiency issue (#1343)

### Function Optimization {#cl-1.15.0-opt}

- Optimize eBPF `httpflow` protocol judgment (#1318)
- Optimize Windows Datakit installation upgrade command (#1316)
- Optimize Pythond encapsulation (#1304)
- Pipeline provides more detailed operation error messages (#1262)
- Pipeline Ref-Table provides local storage implementation based on SQLite (#1158)
- Optimize SQLServer timeline issue (#1345)

---

## 1.14.2 (2022/09/04) {#cl-1.14.2}

### Bug Fixes {#cl-1.14.2-fix}

- Fix missing `instance` tag in Prometheus Annotation on Kubernetes Pods (#1250)
- Fix Pod object not being collected issue (#1251)

---

## 1.14.1 (2022/08/30) {#cl-1.14.1}

### Bug Fixes {#cl-1.14.1-fix}

- Kubernetes Prometheus metrics collection optimization (streaming collection), avoiding possible excessive memory usage (#1853/#1845)
- Fix log [color character processing](../integrations/logging.md#ansi-decode)
    - Environment variable in Kubernetes is `ENV_INPUT_CONTAINER_LOGGING_REMOVE_ANSI_ESCAPE_CODES`

---

## 1.14.0 (2022/08/24) {#cl-1.14.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.14.0-new}

- Add [NetFlow collector](../integrations/netflow.md) (#1821)
- Add [debugging filter](datakit-tools-how-to.md#debug-filter) (#1787)
- Add Kubernetes StatefulSet metrics and object collection, add `replicas_desired` object field (#1822)
- Add [DK_LITE environment variable](datakit-install.md#lite-install) for lightweight DataKit installation (#123)

### Bug Fixes {#cl-1.14.0-fix}

- Fix container and Kubernetes collections not correctly adding HostTags and ElectionTags issue (#1833)
- Fix MySQL custom collection Tags being empty causing metrics not being collected issue (#1835)

### Function Optimization {#cl-1.14.0-opt}

- Add [process_count metric](../integrations/system.md#metric) to System collector indicating the number of processes on the current machine (#1838)
- Remove [open_files_list field](../integrations/host_processes.md#object) from Process collector (#1838)
- Add handling cases for lost metrics in [Host Object collector documentation](../integrations/hostobject.md#faq) (#1838)
- Optimize Datakit views, improve Datakit Prometheus metrics documentation
- Optimize Pod/container log collection [mount method](../integrations/container-log.md#logging-with-inside-config) (#1844)
- Add integration tests for Process and System collectors (#1841/#1842)
- Optimize etcd integration tests (#1847)
- Upgrade Golang 1.19.12 (#1516)
- Add [installation via `ash` command](datakit-install.md#get-install) (#123)
- [RUM collection](../integrations/rum.md) supports custom metrics sets, default metrics set adds `telemetry` (#1843)

### Compatibility Adjustment {#cl-1.14.0-brk}

- Remove Sinker functionality from Datakit side, move its functionality to [Dataway side implementation](../deployment/dataway-sink.md) (#1801)
- Remove `pasued` and `condition` fields from Kubernetes Deployment metrics data, add `paused` object field

---

## 1.13.2 (2022/08/15) {#cl-1.13.2}

### Bug Fixes {#cl-1.13.2-fix}

- Fix MySQL custom collection failure (#1831)
- Fix Service scope and execution errors in Prometheus Export (#1828)
- Fix abnormal HTTP response codes and delays in eBPF collector (#1829)

### Function Optimization {#cl-1.13.2-opt}

- Improve image field value acquisition in container collection (#1830)
- Optimize MySQL integration tests to enhance test speed (#1826)

---

## 1.13.1 (2022/08/11) {#cl-1.13.1}

- Fix container log `source` field naming issue (#1827)

---

## 1.13.0 (2022/08/10) {#cl-1.13.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.13.0-new}

- Host object collector supports debugging commands (#1802)
- KafkaMQ adds external plugin handle support (#1797)
- Container collection supports cri-o runtime (#1763)
- Pipeline adds `create_point` function for metric generation (#1803)
- Add PHP language Profiling support (#1811)

### Bug Fixes {#cl-1.13.0-fix}

- Fix Cat collector NPE exception.
- Fix `response_download` time in synthetic test collector (#1820)
- Fix partial log concatenation issue in containerd log collection (#1825)
- Fix `ebpf-conntrack` plugin probe failure in eBPF collector (#1793)

### Function Optimization {#cl-1.13.0-opt}

- Optimize bug-report command (#1810)
- RabbitMQ collector supports multiple simultaneous operations (#1756)
- Adjust host object collector. Remove `state` field (#1802)
- Optimize error reporting mechanism. Resolve eBPF collector inability to report errors (#1802)
- Oracle external collector sends information to the center upon errors (#1802)
- Optimize Python documentation, add module not found resolution case (#1807)
- Optimize Oracle integration tests (#1802)
- OpenTelemetry adds measurement sets and dashboards
- Adjust k8s event fields (#1766)
- Add new container collection fields (#1819)
- eBPF collector adds traffic fields to `httpflow` (#1790)

---

## 1.12.3 (2022/08/03) {#cl-1.12.3}

- Fix delayed log file release issue on Windows (#1805)
- Fix no collection of new container header logs issue
- Fix potential crashes caused by some regular expressions (#1781)
- Fix excessively large package size issue (#1804)
- Fix potential failure of enabling log collection disk cache

---

## 1.12.2 (2022/07/31) {#cl-1.12.2}

- Fix OpenTelemetry Metric and Trace routing configuration issue

---

## 1.12.1 (2022/07/28) {#cl-1.12.1}

- Fix old version DDTrace Python Profile connection issue (#1800)

---

## 1.12.0 (2022/07/27) {#cl-1.12.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.12.0-new}

- [HTTP API](apis.md##api-sourcemap) adds sourcemap file upload (#1782)
- Add .net Profiling access support (#1772)
- Add Couchbase collector (#1717)

### Bug Fixes {#cl-1.12.0-fix}

- Fix missing `owner` field issue in synthetic test collector (#1789)
- Fix DDTrace collector missing `host` issue, while changing various Trace tag collection to blacklist mechanism [#1776] (#1776)

[#1776]: Various Traces carry business fields (called Tags, Annotations, or Attributes). Datakit collects these fields by default to gather more data.

### Function Optimization {#cl-1.12.0-opt}

- Optimize SNMP collector encryption algorithm identification method; improve SNMP collector documentation with more examples (#1795)
- Add Kubernetes deployment example and Git deployment example for Pythond collector (#1732)
- Add InfluxDB, Solr, NSQ, Net collector integration tests (#1758/#1736/#1759/#1760)
- Add Flink metrics (#1777)
- Extend Memcached, MySQL metrics collection (#1773/#1742)
- Update Datakit self-exposure (#1492)
- Pipeline adds more operator support (#1749)
- Synthetic Tests Collector:
    - Add built-in dashboard for synthetic test collector (#1765)
    - Optimize synthetic test task startup to avoid concentrated resource consumption (#1779)
- Documentation updates (#1769/#1775/#1761/#1642)
- Other optimizations (#1777/#1794/#1778/#1783/#1775/#1774/#1737)

---

## 1.11.0 (2023/07/11) {#cl-1.11.0}

This release is an iterative release, including the following updates:

### New Features {#cl-1.11.0-new}

- Add dk collector, remove self collector (#1648)

### Bug Fixes {#cl-1.11.0-fix}

- Fix redundant timeline issue in Redis collector and improve integration tests (#1743)
- Fix dynamic library security issue in Oracle collector (#1730)
- Fix DCA service startup failure (#1731)
- Fix integration test issues in MySQL/ElasticSearch collectors (#1720)

### Function Optimization {#cl-1.11.0-opt}

- Optimize etcd collector (#1741)
- StatsD collector supports distinguishing different data sources via regex (#1728)
- Tomcat collector supports versions 10 and above, deprecating Jolokia (#1703)
- Container log collection supports configuring container internal files (#1723)
- SQLServer collector improves metrics and restructures integration tests (#1694)

### Compatibility Adjustment {#cl-1.11.0-brk}

The following compatibility changes may cause data collection issues. If you use any of these features, consider whether to upgrade or adopt new corresponding solutions.

1. Remove `deployment` tag from container logs
2. Remove `source` field naming logic for stdout logs based on `short_image_name`. Now only container name or Kubernetes label `io.kubernetes.container.name` is used for naming [#cl-1.11.0-brk-why-1].
3. Remove functionality for collecting mounted file paths via container labels (`datakit/logs/inside`), replace with [container environment variables (`DATAKIT_LOGS_CONFIG`)](../integrations/container-log.md) [#cl-1.11.0-brk-why-2].

[#cl-1.11.0-brk-why-1]: In Kubernetes, the value of `io.kubernetes.container.name` does not change, and neither does the container name in host containers, so the original image name is no longer used as the source field's origin.
[#cl-1.11.0-brk-why-2]: Compared to modifying container labels (which usually requires rebuilding the image), adding environment variables to containers is more convenient (inject environment variables when starting the container).

---

## 1.10.2 (2022/07/04) {#cl-1.10.2}

- Fix Kubernetes prom collector recognition issue

## 1.10.1 (2022/06/30) {#cl-1.10.1}

- Fix custom HTTP route support for OpenTelemetry
- Fix missing `started_duration` field in host process objects

---

## 1.10.0 (2022/06/29) {#cl-1.10.0}

This release is an iterative release, mainly with the following updates:

### Bug Fixes {#cl-1.10.0-fix}

- Fix Proxy environment Profiling data upload issue (#1710)
- Fix default collector enablement during upgrades (#1709)
- Fix SQLServer log truncation issue (#1689)
- Fix Kubernetes Metric Server metrics collection issue (#1719)

### Function Optimization {#cl-1.10.0-opt}

- KafkaMQ supports topic-level multiline split configuration (#1661)
- Kubernetes DaemonSet installation supports modifying Datakit log shard count and shard size via ENV (#1711)
- Kubernetes Pod metrics and object collection add `memory_capacity` and `memory_used_percent` fields (#1721)
- OpenTelemetry HTTP route supports custom configuration (#1718)
- Oracle collector optimizes `oracle_system` measurement set loss issue and refines collection logic adding some metrics (#1693)
- Pipeline adds `in` operator, `value_type()`, and `valid_json()` functions, adjusts behavior of `load_json()` function when deserialization fails (#1712)
- Host process objects add `started_duration` field (#1722)
- Optimize synthetic test data sending logic (#1708)
- Update more integration tests (#1666/#1667/#1668/#1693/#1599/#1573/#1572/#1563/#1512/#1715)
- Module restructuring and optimizations (#1714/#1680/#1656)

### Compatibility Adjustment {#cl-1.10.0-brk}

- Change timestamp unit for Profile data from nanoseconds to microseconds (#1679)

<!-- markdown-link-check-disable -->

---

## 1.9.2 (2023/06/20) {#cl-1.9.2}

This release is a mid-term iterative release, adding some functionalities related to central对接and fixing several bugs:

### New Features {#cl-1.9.2-new}

- Add [Chrony collector](../integrations/chrony.md) (#1671)
- Add RUM Headless support (#1644)
- Pipeline:
    - Add [offload functionality](../pipeline/use-pipeline/pipeline-offload.md) (#1634)
    - Reorganize existing document structure (#1686)

### Bug Fixes {#cl-1.9.2-fix}

- Fix potential crash issues (!2249)
- HTTP network synthetic test adds Host header support and fixes random error reporting (#1676)
- Fix automatic discovery of Pod Monitor and Service Monitor in Kubernetes (#1695)
- Fix monitor issues (#1702/!2258)
- Fix Pipeline data misoperation bug (#1699)

### Function Optimization {#cl-1.9.2-opt}

- Add more information in Datakit HTTP API returns for easier error troubleshooting (#1697/#1701)
- Other restructurings (#1681/#1677)
- RUM collector exposes more Prometheus metrics (#1545)
- Default enable Datakit pprof functionality for easier troubleshooting (#1698)

### Compatibility Adjustment {#cl-1.9.2-brk}

- Remove logging support for Kubernetes CRD `guance.com/datakits v1bate1` (#1705)

---

## 1.9.1 (2023/06/13) {#cl-1.9.1}

This release is a bug fix, mainly addressing the following issues:

- Fix DQL query issue (#1688)
- Fix potential crash in HTTP interface high-frequency writes (#1678)
- Fix parameter overwrite issue in `datakit monitor` command (!2232)
- Fix retry error during HTTP data uploads (#1687)

---

## 1.9.0 (2023/06/08) {#cl-1.9.0}

This release is an iterative release, mainly with the following updates:

### New Features {#cl-1.9.0-new}

- Add [NodeJS Profiling](../integrations/profile-nodejs.md) support (#1638)
- Add [Cat](../integrations/cat.md) support (#1593)
- Add collector configuration [debugging method](why-no-data.md#check-input-conf) (#1649)

### Bug Fixes {#cl-1.9.0-fix}

- Fix connection leak issue in K8s Prometheus metrics collection (#1662)

### Function Optimization {#cl-1.9.0-opt}

- Add `age` field to K8s DaemonSet objects (#1670)
- Optimize [PostgreSQL](../integrations/postgresql.md) startup settings (#1658)
- SkyWalking adds [`/v3/log/`](../integrations/skywalking.md) support (#1654)
- Optimize log collection handling (#1652/#1651)
- Optimize [upgrade documentation](datakit-update.md#prepare) (#1653)
- Other restructurings and optimizations (#1673/#1650/#1630)
- Add several integration tests (#1440/#1429)
    - PostgreSQL
    - Network synthetic tests

---

## 1.8.1 (2023/06/01) {#cl-1.8.1}

This release is a bug fix, mainly addressing the following issues:

- Fix KafkaMQ crashing under multiple instances (#1660)
- Fix DaemonSet mode incomplete disk device collection issue (#1655)

---

## 1.8.0 (2023/05/25) {#cl-1.8.0}

This release is an iterative release, mainly with the following updates:

- Prom collector's internal timeout changed to 3 seconds (#958)

- Log-related issue fixes:
    - Add `log_read_offset` field to log collection (#905)
    - Fix issue where rotated log files were not read correctly at the tail (#936)

- Container collection-related issue fixes:
    - Fix incompatibility with environment variable `NODE_NAME` (#957)
    - Kubernetes auto-discovery Prom collector changed to serial dispersed collection, each K8s node collects only its own machine's Prom metrics (#811/#957)
    - Add log source and multiline [mapping configuration](container.md#env-config) (#937)
    - Fix bug where after replacing log source, previous multiline and Pipeline configurations were still used (#934/#923)
    - Correct container logs setting active file duration to 12 hours (#930)
    - Optimize docker container log `image` field (#929)
    - Optimize K8s pod object `host` field (#924)
    - Fix container metrics and object collections not adding host tag issue (#962)

- eBPF related:
    - Fix Uprobe event name conflict issue
    - Add more [environment variable configurations](ebpf.md#config) for Kubernetes deployment

- Optimize APM data receiving interface handling to alleviate client freezing and memory usage issues (#902)

- SQLServer collector fixes:
    - Restore TLS1.0 support (#909)
    - Add filtering by instance to reduce timeline consumption (#931)

- Pipeline function `adjust_timezone()` has been adjusted (#917)
- [IO module optimization](datakit-conf.md#io-tuning) improves overall data processing ability while keeping memory usage relatively controlled (#912)
- Monitor updates:
    - Fix long-term freezing of Monitor under busy conditions (#933)
    - Optimize Monitor display, add IO module information for users to adjust IO module parameters
- Fix Redis crash issue (#935)
- Remove some redundant verbose logs (#939)
- Fix election collectors not appending host tags in non-election modes (#968)

---

## 1.7.0 (2023/05/11) {#cl-1.7.0}

This release is a Hotfix release, mainly fixing the following issues:

- Elections related:
    - Fix `election_namespace` setting error issue (#915)
    - Setting for `enable_election_namespace` tag defaults to off, needs [manual activation](election.md#config)
    - The `namespace` field in *datakit.conf* will be deprecated (still usable), renamed to `election_namespace`

- Fix collector blockage issue (#916)
    - DataKit removes heartbeat interface calls to the center
    - DataKit removes DataWay list interface calls to the center

- [Container collector](container.md) supports modifying sidecar container log source (`source`) field through additional configuration (`ENV_INPUT_CONTAINER_LOGGING_EXTRA_SOURCE_MAP`) (#903)
- Fix blacklist display issue on Monitor (#904)

---

## 1.6.6 (2023/07/07) {#cl-1.6.6}

- Adjust [global tag](datakit-conf.md#set-global-tag) behavior to avoid tag splitting in election collectors (#870)
- [SQLServer collector](sqlserver.md) adds election support (#882)
- [Line protocol filter](datakit-filter.md) supports all data types (#855)
- 9529 HTTP service adds [timeout mechanism](datakit-conf.md#http-other-settings) (#900)
- MySQL:
    - Rename [dbm measurement set](mysql.md#logging) (#898)
    - `service` field conflict issue (#895)
- [Container object](container.md#docker_containers) adds `container_runtime_name` field to distinguish different levels of container names (#891)
- Redis adjusts [`slowlog` collection](redis.md#redis_slowlog), changing its data to log storage (#885)
- Optimize [TDEngine collection](tdengine.md) (#877)
- Perfect Containerd log collection, supporting automatic parsing of default format logs (#869)
- [Pipeline](../pipeline/use-pipeline/index.md) adds [Profiling data](profile.md) support (#866)
- Container/Pod log collection supports [additional tag appending](container-log.md#logging-with-annotation-or-label) in Label/Annotation (#861)
- Fix [Jenkins CI](jenkins.md#jenkins_pipeline) data collection time precision issue (#860)
- Fix inconsistent Tracing `resource-type` values issue (#856)
- eBPF adds [HTTPS support](ebpf.md#https) (#782)
- Fix possible crash in log collector (#893)
- Fix Prom collector leak issue (#880)
- Support configuring io disk cache via [environment variables](datakit-conf.md#using-cache) (#906)
- Add [Kubernetes CRD](kubernetes-crd.md) support (#726)
- Other bug fixes (#901/#899)

---

## 1.6.5 (2023/06/29) {#cl-1.6.5}

This release is a Hotfix release, mainly fixing the issue where log collectors could stop due to rapid deletion and recreation of same-name files.

If you have scheduled tasks regularly packaging logs, this bug might be triggered. **It is recommended to upgrade**.

---

## 1.6.4 (2023/06/27) {#cl-1.6.4}

This release is a Hotfix release, mainly with the following content:

- Fix log collection not collecting due to improper pos handling, this issue was introduced since 1.4.2, **it is recommended to upgrade** (#873)
- Fix TDEngine potential crash issue
- Optimize eBPF data sending process to avoid excessive memory usage leading to OOM (#871)
- Fix collector documentation errors

---

## 1.6.3 (2023/06/22) {#cl-1.6.3}

This release is an iterative release, mainly with the following content:

- Git sync configuration supports passwordless mode (#845)
- Prom collector:
    - Supports log mode collection (#844)
    - Supports configuring HTTP request headers (#832)
- Supports over 16KB length container log collection (#836)
- Supports TDEngine collector (#810)
- Pipeline:
    - Supports XML parsing (#804)
    - Remote debugging supports multiple data types (#833)
    - Supports calling external Pipeline scripts using `use()` function (#824)
- Add [IP database (MaxMindIP) support](../ipdb/ipdb-how-to.md) (#799)
- Add DDTrace Profiling integration (#656)
- Containerd log collection supports filtering rules via image and K8s Annotation configuration (#849)
- Entire documentation repository switches to MkDocs (#745)
- Other miscellaneous items (#822)

### Bug Fixes {#cl-1.6.3-bugfix}

- Fix socket collector crash issue (#858)
- Fix crash caused by empty tags configuration in some collectors (#852)
- Fix IPDB update command issue (#854)
- Add `pod_ip` field to Kubernetes Pod logs and objects (#848)
- DDTrace collector restores recognition of trace SDK sampling settings (#834)
- Fix `host` field inconsistency between DaemonSet mode and DataKit itself in external collectors (eBPF/Oracle) (#843)
- Fix multiline stdout log collection issue (#859)

---

## 1.6.2 (2023/06/16) {#cl-1.6.2}

This release is an iterative release, mainly with the following content:

- Log collection supports recording collection positions to avoid data loss due to DataKit restarts (#812)
- Adjust Pipeline settings for different data types (#806)
- Support receiving SkyWalking metrics data (#780)
- Optimize log blacklist debugging functionality:
    - Monitor displays filtered points (#827)
    - In *datakit/data* directory, a *.pull* file is added to record fetched filters
- Monitor adds DataKit open file count display (#828)
- DataKit compiler upgraded to Golang 1.18.3 (#674)

### Bug Fixes {#1.6.2-bugfix}

- Fix `ENV_K8S_NODE_NAME` not globally effective issue (#840)
- Fix file descriptor leakage in log collector, **strongly recommend upgrading** (#838)
- Fix Pipeline `group_in` issue (#826)
- Fix ElasticSearch collector `http_timeout` parsing issue (#821)
- Fix DCA API issue (#747)
- Fix ineffective `dev_null` DataWay setting issue (#842)

----

## 1.6.1 (2023/06/07) {#cl-1.6.1}

This release is an iterative release, mainly with the following content:

- Fix TOML configuration file compatibility issue (#195)
- Add [TCP/UDP port detection](socket) collector (#743)
- DataKit and DataWay add DNS detection, supporting dynamic DataWay DNS switching (#758)
- [eBPF](ebpf) L4/L7 traffic data adds k8s deployment name field (#793)
- Optimize [OpenTelemetry](opentelemetry) metrics data (#794)
- [ElasticSearch](elasticsearch) adds AWS OpenSearch support (#797)
- [Line protocol limits](apis#2fc2526a) increase string length limit to 32MB (#801)
- [Prometheus](prom) collector adds extra configuration, supporting ignoring specified `tag=value` matches to reduce unnecessary time-series timelines (#808)
- Sink adds Jaeger support (#813)
- Kubernetes-related [metrics](container#7e687515) collection defaults to all off to avoid timeline explosion issues (#807)
- [DataKit Monitor](monitor) adds dynamic discovery (e.g., Prometheus) collector list refresh (#711)

### Bug Fixes {#cl-1.6.1-bugfix}

- Fix default Pipeline loading issue (#796)
- Fix log status handling in Pipeline (#800)
- Fix [Filebeat](beats_output) crash issue (#805)
- Fix dirty data issue caused by [Log Streaming](logstreaming) (#802)

----

## 1.6.0 (2022/05/26) {#cl-1.6.0}

This release is an iterative release, entering the 1.6 series for sub-version numbers. Main updates include:

- Pipeline underwent significant adjustments (#761):
    - All data types can be processed via configured Pipelines (#761/#739)
    - [grok()](pipeline#965ead3c) supports extracting fields directly as specified types, eliminating the need for additional type conversion using the `cast()` function (#760)
    - Pipeline adds [multiline string support](pipeline#3ab24547), improving readability by writing long strings (e.g., grok regular expressions) across multiple lines (#744)
    - Each Pipeline's runtime status can be viewed directly via `datakit monitor -V` (#701)
- Add Kubernetes [Pod object](container#23ae0855-1) CPU/memory metrics (#770)
- Helm adds more Kubernetes version installation compatibility (#783)
- Optimize [OpenTelemetry](opentelemetry), adding JSON support to HTTP protocol (#781)
- DataKit logs detailed information during automatic line protocol correction, aiding in debugging data issues (#777)
- Remove all string metrics from time-series data (#773)
- In DaemonSet installations, if the election namespace is configured, participating collectors will have a specific tag (`election_namespace`) added to their data (#743)
- CI observability adds [Jenkins](jenkins) support (#729)

### Bug Fixes {#cl-1.6.0-bugfix}

- Fix incorrect DataWay statistics in monitor (#785)
- Fix several bugs related to the log collector (#783):
    - Certain probabilities of log streams being corrupted due to mismatched data
    - Fix instability in log collection (loss of data) caused by factors like truncate/rename/remove in file log collection scenarios (disk files/container logs/logfwd)
- Other bug fixes (#790)

----

## 1.4.20 (2022/05/22) {#cl-1.4.20}

This release is a hotfix release, mainly fixing the following issues:

- Log collection feature optimizations (#775):
    - Remove 32KB limit (retain 32MB maximum limit) (#776)
    - Fix potential loss of header logs
    - For newly created logs, default collection starts from the beginning (mainly container logs; disk file logs currently cannot determine whether they are new creations)
    - Optimize Docker log processing, no longer relying on Docker log API

- Fix the [decode](pipeline#837c4e09) function in Pipeline (#769)
- OpenTelemetry gRPC method supports gzip (#774)
- Fix [Filebeat](beats_output) collector not setting service issue (#767)

### Breaking Changes {#cl-1.4.20-bc}

For Docker container log collection, it is necessary to mount the host’s (Node) `/var/lib` path into DataKit (since Docker logs default to the host's `/var/lib/`). In *datakit.yaml*, add the following configurations for `volumeMounts` and `volumes`:

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

----

## 1.4.19 (2022/05/12) {#cl-1.4.19}

This release is an iterative release, mainly with the following updates:

- eBPF adds arm64 support (#662)
- Line protocol construction supports automatic error correction (#710)
- DataKit main configuration adds example settings (#715)
- [Prometheus Remote Write](prom_remote_write) supports tag renaming (#731)
- Fix DCA client not getting full workspace information issue (#747)
- Merge community edition DataKit existing features, mainly including Sinker functionality and [Filebeat](beats_output) collector (#754)
- Adjust container log collection, DataKit directly supports collecting stdout/stderr logs under containerd (#756)
- Fix ElasticSearch collector timeout issue (#762)
- Fix overly strict installation program checks (#763)
- Adjust hostname acquisition strategy in DaemonSet mode (#648)
- Trace collector supports filtering resources (`resource`) through service name (`service`) wildcards (#759)
- Several other detail issue fixes

----

## 1.4.18 (2022/05/06) {#cl-1.4.18}

This release is a hotfix release, mainly fixing the following issues:

- [Process collector](host_processes.md) filter only applies to metric collection, leaving object collection unaffected (#740)
- Alleviate DataKit sending DataWay timeout issues (#741)
- [GitLab collector](gitlab.md) slightly adjusted (#742)
- Fix log truncation issues (#749)
- Fix partial configuration reload inefficiencies in various trace collectors (#750)

----

## 1.4.17 (2022/04/27) {#cl-1.4.17}

This release is an iterative release, mainly involving the following aspects:

- [Container collector](container#7e687515) adds more metrics (`kube_` prefix) collection (#668)
- DDTrace and OpenTelemetry collectors support filtering some erroneous traces via HTTP Status Code (`omit_err_status`)
- Fix reload ineffectiveness for several trace collectors (DDtrace/OpenTelemetry/Zipkin/SkyWalking/Jaeger) in Git mode (#725)
- Fix GitLab collector crash due to missing tags (#730)
- Fix Pod label (tag) update issues in Kubernetes for eBPF collector (#736)
- [Prom collector](prom.md) supports [Tag renaming](prom#e42139cb) (#719)
- Improve some document descriptions

----

## 1.4.16 (2022/04/24) {#cl-1.4.16}

This release is a hotfix, mainly involving the following aspects (#728):

- Fix possible errors in installation programs preventing further installation/upgrade, now tolerating partial service operation errors
- Fix spelling errors in Windows installation scripts causing 32-bit installation program download failure
- Adjust Monitor display regarding election situations
- Fix MongoDB infinite loop leading to inability to collect when elections are enabled

----

## 1.4.15 (2022/04/21) {#cl-1.15.0}

This release is an iterative release, containing numerous bug fixes:

- Pipeline module fixes Grok [dynamic multiline pattern](datakit-pl-how-to#88b72768) issues (#720)
- Remove some unnecessary DataKit event log reporting (#704)
- Fix upgrade program potentially causing upgrade failures (#699)
- Add [pprof enabling environment variable](datakit-daemonset-deploy#cc08ec8c) configuration in DaemonSet (#697)
- All [default enabled collectors](datakit-input-conf#764ffbc2) in DaemonSet support configuration via environment variables (#693)
- Tracing collector preliminarily supports Pipeline data processing (#675)
    - [DDtrace configuration example](ddtrace#69995abe)
- Synthetic test collector adds task exit mechanism for failed tasks (#54)
- Optimize [Helm installation](datakit-daemonset-deploy#e4d3facf) (#695)
- Logs add `unknown` level (status), logs without specified levels are `unknown` (#685)
- Container collector undergoes extensive fixes:
    - Fix cluster field naming issue (#542)
    - Metric set `kubernetes_clusters` renamed to `kubernetes_cluster_roles`
    - Original `kubernetes.cluster` count renamed to `kubernetes.cluster_role`
    - Fix namespace field naming issue (#724)
    - If Pod Annotation does not specify log `source`, DataKit deduces log source based on this priority order (#708/#723)
    - Object reporting no longer constrained by 32KB character length limit (due to Annotations exceeding 32KB) (#709)
    - All Kubernetes objects remove `annotation` field
    - Fix prom collector not stopping upon Pod exit issue (#716)
- Other bug fixes (#721)

---

## 1.4.14 (2022/04/12) {#cl-1.4.14}

This release is a hotfix, containing partial small modifications and adjustments:

- Fix monitor display issues in log collector and adjust some error log levels (#706)
- Fix memory leak in synthetic test collector (#702)
- Fix crash in host process collector (#700)
- Default enable log collection option `ignore_dead_log = '10m'` (#698)
- Optimize Git-managed configuration synchronization logic (#696)
- Fix incorrect IP protocol field in `netflow` within eBPF (#694)
- Enrich GitLab collector fields

---

## 1.4.13 (2022/04/08) {#cl-1.4.13}

This release is an iterative release, with the following updates:

- Add runtime [memory limitation](datakit-conf#4e7ff8f3) for host machines (#641)
    - Installation phase supports [memory limitation configuration](datakit-install#03be369a)
- CPU collector adds [load5s metric](cpu#13e60209) (#606)
- Improve *datakit.yaml* examples (#678)
- Support limiting memory usage via [cgroup](datakit-conf#4e7ff8f3) during host installation (#641)
- Improve blacklist functionality for logs, adding `contain/notcontain` judgment rules (#665)
    - Support configuring blacklists for [logs/objects/Tracing/time-series metrics](datakit-filter#045b45e3) in *datakit.conf*
    - Note: Upgrading this version requires DataWay to be upgraded to 1.2.1+
- Further improve [containerd-based container collection](container) (#402)
- Adjust monitor layout, add blacklist filtering situation display (#634)
- Add [Helm support](datakit-daemonset-deploy) for DaemonSet installation (#653)
    - Add [DaemonSet installation best practices](datakit-daemonset-bp) (#673)
- Improve [GitLab collector](gitlab) (#661)
- Add [ulimit configuration item](datakit-conf#8f9f4364) for file descriptor limit (#667)
- Pipeline [desensitization functions](pipeline#52a4c41c) updated, adding [SQL desensitization functions](pipeline#711d6fe4) (#670)
- Process objects and time-series metrics [add `cpu_usage_top` field](host_processes#a30fc2c1-1) to align with `top` command results (#621)
- eBPF adds [HTTP protocol collection](ebpf#905896c5) (#563)
- Host installation no longer installs eBPF collector by default (reduces binary distribution size); if needed, use [specific installation commands](ebpf#852abae7) (#605)
    - DaemonSet installation remains unaffected
- Other bug fixes (#688/#681/#679/#680)

---

## 1.4.12 (2022/03/24) {#cl-1.4.12}

This release is an iterative release, with updates as follows:

1. Add [DataKit command-line completion](datakit-tools-how-to#9e4e5d5f) functionality (#76)
1. Allow DataKit [upgrades to non-stable versions](datakit-update#42d8b0e4) (#639)
1. Adjust local storage of Remote Pipeline in DataKit to avoid case sensitivity issues caused by different file systems (#649)
1. (Alpha) Preliminary support for [Kubernetes/Containerd architecture data collection](container#b3edf30c) (#402)
1. Fix unreasonable errors in Redis collector (#671)
1. Fine-tune OpenTelemetry collector fields (#672)
1. Fix [self-collector](self) CPU calculation errors (#664)
1. Fix RUM collector missing IP association fields due to IPDB absence (#652)
1. Pipeline supports uploading debug data to OSS (#650)
1. DataKit HTTP API includes [DataKit version number information](apis#be896a47)
1. [Network synthetic tests](dialtesting) add TCP/UDP/ICMP/Websocket protocol support (#519)
1. Fix excessively long fields in [host object collector](hostobject) (#669)
1. Pipeline:
    - Add [decode()](pipeline#837c4e09) function (#559), avoiding configuring encoding in log collectors, enabling encoding conversion in Pipeline
    - Fix possible failure in importing Pipeline patterns (#666)
    - [add_pattern()](pipeline#89bd3d4e) adds scope management

---

## 1.4.11 (2022/03/17) {#cl-1.4.11}

This release is a hotfix, containing partial small modifications and adjustments:

- Fix Tracing collector resource filtering (`close_resource`) algorithm issue, moving filtering mechanism down to Entry Span level rather than previous Root Span.
- Fix [log collector](logging) file handle leakage issue (#658), while adding configuration (`ignore_dead_log`) to ignore no-longer-updated (deleted) files.
- Add [Datakit self-metrics documentation](self).
- During DaemonSet installation:
    - [Support installing IPDB](datakit-tools-how-to#11f01544) (#659)
    - Support [setting HTTP throttling (ENV_REQUEST_RATE_LIMIT)](datakit-daemonset-deploy#00c8a780) (#654)

---

## 1.4.10 (2022/03/11) {#cl-1.4.10}

Fix potential crashes in Tracing-related collectors.

---

## 1.4.9 (2022/03/10) {#cl-1.4.9}

This release is an iterative release, with updates as follows:

- DataKit 9529 HTTP service adds [API throttling measures](datakit-conf#39e48d64) (#637)
- Unify sampling rate settings for various Tracing data [collection](datakit-tracing#64df2902) (#631)
- Publish [DataKit log collection overview](datakit-logging).
- Support [OpenTelemetry data ingestion](opentelemetry) (#609).
- Support [disabling logging for certain Pod images](container#2a6149d7) (#586).
- Process object collection [adds listening port list](host_processes#a30fc2c1-1) (#562).
- eBPF collector [supports Kubernetes field association](ebpf#35c97cc9) (#511).

### Breaking Changes {#cl-1.4.9-brk}

- Significant adjustments were made to Tracing data collection, involving several incompatible changes:

    - [DDtrace](ddtrace): Change `ignore_resources` field in existing conf to `close_resource`, changing its type from original array (`[...]`) to dictionary array (`map[string][...]`) format (refer to [conf.sample](ddtrace#69995abe) for configuration).
    - DDTrace original data changed [tag `type` to `source_type`](ddtrace#01b88adb).

---

## 1.4.8 (2022/03/04) {#cl-1.4.8}

This release is a hotfix, with the following content:

- DaemonSet mode deployment adds [taint tolerance configuration](datakit-daemonset-deploy#e29e678e) (#635).
- Fix Remote Pipeline pull update bug (#630).
- Fix memory leaks caused by DataKit IO module freezing (#646).
- Allow modifying `service` field in Pipeline (#645).
- Fix `pod_namespace` typo.
- Fix some issues in logfwd (#640).
- Fix multiline sticking issue in log collection in container environments (#633).

---

## 1.4.7 (2022/02/22) {#cl-1.4.7}

This release is an iterative release, with the following content:

- Pipeline:
    - Grok adds [dynamic multiline pattern](datakit-pl-how-to#88b72768), facilitating dynamic multiline splitting (#615).
    - Supports central Pipeline issuance (#524), thus Pipeline now has [three storage paths](pipeline#6ee232b2).
    - DataKit HTTP API adds Pipeline debugging interface [`/v1/pipeline/debug`](apis#539fb60e).

<!--
- APM function adjustment (#610)
    - Reconstruct existing common Tracing data access
    - Add APM metric calculations
    - Add new [OTEL (OpenTelemetry) data access]()

!!! Delay
-->

- To reduce default installation package size, default installations no longer include IP geographic information databases. Collectors like RUM can install corresponding IP libraries separately (#609).
    - To include IP geographic information during installation, use [extra supported command-line environment variables](datakit-install#f9858758).
- Container collector adds [logfwd log access](logfwd) (#600).
- To further standardize data uploads, line protocol increases more stringent [restrictions](apis#2fc2526a) (#592).
- [Log collector](logging) removes log length restriction (`maximum_length`) (#623).
- Optimize Monitor display during log collection (#587).
- Optimize command-line parameter checks in the installation program (#573).
- Reorganize DataKit command-line parameters, most major commands are now supported. Additionally, **old command-line parameters remain effective for a period** (#499).
    - Use `datakit help` to view new command-line parameter styles.
- Completely re-implement [DataKit Monitor](datakit-monitor).

### Other Bug Fixes {#cl-1.4.7-fix}

- Fix Windows installation script issues (#617).
- Adjust ConfigMap settings in *datakit.yaml* (#603).
- Fix part of HTTP services becoming abnormal due to Reload in Git mode (#596).
- Fix isp file loss in installation packages (#584/#585/#560).
- Fix ineffective multiline matching in Pod annotations (#620).
- Fix `_service_` tag ineffectiveness in TCP/UDP log collectors (#610).
- Fix Oracle collector data collection issues (#625).

### Breaking Changes {#cl-1.4.7-brk}

- Old versions of DataKit that had RUM functionality enabled require [reinstalling the IP library](datakit-tools-how-to#ab5cd5ad) after upgrading, as old IP libraries will no longer work.

---

## 1.4.6 (2022/01/20) {#cl-1.4.6}

This release is an iterative release, with the following content:

- Enhance [DataKit API secure access control](rum#b896ec48). It is recommended to upgrade older versions of DataKit if RUM functionality is deployed (#578).
- Increase internal event log reporting for DataKit (#527).
- Viewing [DataKit operational status](datakit-tools-how-to#44462aae) no longer times out (#555).

- Some detailed issue fixes for the [container collector](container):

    - Fix crashes during host deployments in Kubernetes environments (#576).
    - Boost Annotation collection configuration priority (#553).
    - Container logs support multiline processing (#552).
    - Kubernetes Node objects add `_role_` field (#549).
    - [Annotated](kubernetes-prom) [Prom collector](prom) automatically adds relevant attributes (`pod_name/node_name/namespace`) (#522/#443).
    - Other bug fixes.

- Pipeline issue fixes:

    - Fix potential time disorder issues in log processing (#547).
    - Support complex logic judgments in _if/else_ statements [for Grok slicing](pipeline#1ea7e5aa).

- Fix Windows path issues in log collectors (#423).
- Perfect DataKit service management, optimizing interaction prompts (#535).
- Optimize units exposed in existing DataKit documentation (#531).
- Enhance engineering quality (#515/#528).

---

## 1.4.5 (2022/01/19) {#cl-1.4.5}

- Fix [Log Stream collector](logstreaming) Pipeline configuration issue (#569).
- Fix log jumbling issue in [container collector](container) (#571).
- Fix update logic bug in Pipeline module (#572).

---

## 1.4.4 (2022/01/12) {#cl-1.4.4}

- Fix lost metrics in log API interface (#551).
- Fix partial network traffic statistic losses in [eBPF](ebpf) (#556).
- Fix `$` wildcard issue in collector configuration files (#550).
- Pipeline _if_ statement supports null value comparisons, facilitating Grok slicing judgments (#538).

---

## 1.4.3 (2022/01/10) {#cl-1.4.3}

- Fix *datakit.yaml* formatting error (#544).
- Fix election issue in [MySQL collector](mysql) (#543).
- Fix log not being collected due to unconfigured Pipeline (#546).

---

## 1.4.2 (2022/01/07) {#cl-1.4.2}

- [Container collector](container) updates:
    - Fix log processing efficiency issue (#540).
    - Optimize whitelist/blacklist configuration in configuration files (#536).
- Pipeline module adds `datakit -M` metrics exposure (#541).
- [ClickHouse](clickhousev1) collector config-sample issue fix (#539).
- [Kafka](kafka) metrics collection optimization (#534).

---

## 1.4.1 (2022/01/05) {#cl-1.4.1}

- Fix Pipeline usage issues in collectors (#529).
- Improve [container collector](container) data issues (#532/#530):
    - Fix short-image collection issue.
    - Perfect Deployment/Replica-Set associations in K8s environments.

---

## 1.4.0 (2021/12/30) {#cl-1.4.0}

- Restructure Kubernetes cloud-native collector, integrating it into the [container collector](container.md). The original Kubernetes collector is no longer effective (#492).
- [Redis collector](redis.md):
    - Supports configuring [Redis username](redis.md) (#260).
    - Adds Latency and Cluster measurement sets (#396).
- [Kafka collector](kafka.md) enhancement, supports topic/broker/consumer/connection dimension metrics (#397).
- Add [ClickHouse](clickhousev1.md) and [Flink](flinkv1.md) collectors (#458/#459).
- [Host object collector](hostobject):
    - Supports reading cloud sync configurations from [`ENV_CLOUD_PROVIDER`](hostobject#224e2ccd) (#501).
    - Optimize disk collection, default no longer collects invalid disks (e.g., disks with total size 0) (#505).
- [Log collector](logging) supports receiving TCP/UDP log streams (#503).
- [Prom collector](prom) supports multi-URL collection (#506).
- Add [eBPF](ebpf) collector, integrating L4-network/DNS/Bash etc. eBPF data collection (#507).
- [ElasticSearch collector](elasticsearch) adds [Open Distro](https://opendistro.github.io/for-elasticsearch/){:target="_blank"} branch ElasticSearch support (#510).

### Bug Fixes {#cl-1.4.0-fix}

- Fix Statsd/RabbitMQ metrics issues (#497).
- Fix Windows Event collection data issues (#521).
- [Pipeline](pipeline):
    - Enhance parallel processing capabilities in Pipeline.
    - Add [`set_tag()`](pipeline#6e8c5285) function (#444).
    - Add [`drop()`](pipeline#fb024a10) function (#498).
- Git mode:
    - In DaemonSet mode, Git supports recognizing `ENV_DEFAULT_ENABLED_INPUTS` and making it effective; in non-DaemonSet modes, it automatically enables collectors set to default in *datakit.conf* (#501).
    - Adjust folder [storage strategy] in Git mode (#509).
- Implement new version numbering mechanism (#484):
    - New version format is 1.2.3, where `1` is the major version, `2` is the minor version, and `3` is the patch version.
    - Minor version odd/even determines stable/non-stable versions.
    - Multiple different patch versions exist on the same minor version, mainly for bug fixes and functional adjustments.
    - New features expected to be released in non-stable versions, merging into stable versions after stabilization.
    - Non-stable versions do not support direct upgrades (e.g., cannot upgrade to 1.3.x; only direct installations of non-stable versions are supported).

### Breaking Changes {#cl-1.4.0-break-changes}

**Old versions of DataKit using `datakit --version` no longer push new upgrade commands**. Use the following commands directly:

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

## 1.1.9-rc7.1 (2021/12/22) {#cl-1.1.9-rc7.1}

- Fix MySQL collector data issues caused by partial collection failures.

---

## 1.1.9-rc7 (2021/12/16) {#cl-1.1.9-rc7}

- Pipeline underwent significant restructuring (#339):

    - Add `if/elif/else` [syntax](pipeline#1ea7e5aa).
    - Temporarily remove `expr()/json_all()` functions.
    - Optimize timezone handling, add `adjust_timezone()` function.
    - Overall testing improvements for each Pipeline function.

- DataKit DaemonSet:

    - Git configuration DaemonSet [ENV injection](datakit-daemonset-deploy#00c8a780) (#470).
    - Default disable container collector to avoid duplicate collection issues (#473).

- Others:
    - DataKit supports self-event reporting (as logs) (#463).
    - [ElasticSearch](elasticsearch) collector adds `indices_lifecycle_error_count` to metrics (note: to collect this metric, add `ilm` role in ES [configuration](elasticsearch#852abae7)).
    - After DataKit installation, automatically add [cgroup restrictions](datakit-conf#4e7ff8f3).
    - Some interfaces connecting to the center have been upgraded to v2 versions, so if Datakit is upgraded to the current version, the corresponding DataWay and Kodo also need upgrades, otherwise some interfaces may report 404 errors.

### Breaking Changes {#cl-1.1.9-rc7brk}

When handling JSON data, if the top-level is an array, indexing is required to select elements, e.g., for JSON:

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

In the current version, change it to:

```
# Add a preceding `.` character
.[0].abc
```

---

## 1.1.9-rc6.1 (2021/12/10) {#cl-1.1.9-rc6.1}

- Fix ElasticSearch and Kafka collection error issues (#486).

---

## 1.1.9-rc6 (2021/11/30) {#cl-1.1.9-rc6}

- Emergency fixes for Pipeline:
    - Remove `json_all()` function due to severe data issues with malformed JSON, hence disabling it (#457).
    - Correct timezone setting issue in `default_time()` function (#434).
- Solve HTTPS access issues for [`Prom`](prom) collector in Kubernetes environments (#447).
- DataKit DaemonSet installation [yaml file](https://static.guance.com/datakit/datakit.yaml){:target="_blank"} is publicly downloadable.

---

## 1.1.9-rc5.1 (2021/11/26) {#cl-1.1.9-rc5.1}

- Fix DDTrace collector crashing due to dirty data.

---

## 1.1.9-rc5 (2021/11/23) {#cl-1.1.9-rc5}

- Add [Pythond (alpha)](pythond) to facilitate custom collector development in Python3 (#367).
<!-- - Support source map file processing to gather JavaScript call stack information in RUM collector (#267) -->
- DataKit initially supports [disk data caching (alpha)](datakit-conf#caa0869c) (#420).
- DataKit supports election state reporting (#427).
- DataKit supports Scheck state reporting (#428).
- Adjust DataKit user guide documentation, making new categories easier to find specific documents.

---

## 1.1.9-rc4.3 (2021/11/19) {#cl-1.1.9-rc4.3}

- Fix container log collector unable to start due to improper Pipeline configuration.

---

## 1.1.9-rc4.2 (2021/11/18) {#cl-1.1.9-rc4.2}

- Emergency fixes (#446):
    - Fix incorrect log level output in Kubernetes DaemonSet mode.
    - Fix MySQL collector looping infinitely when not elected.
    - Complete DaemonSet documentation.

---

## 1.1.9-rc4.1 (2021/11/16) {#cl-1.1.9-rc4.1}

- Fix Kubernetes Pod namespace collection issue (#439).

---

## 1.1.9-rc4 (2021/11/09) {#cl-1.1.9-rc4}

- Support managing various collector configurations (excluding `datakit.conf`) and Pipeline via [Git](datakit-conf#90362fd0) (#366).
- Support fully offline installation (#421).
<!--
- eBPF-network
    - Add [DNS data collection] (#418).
    - Strengthen kernel compatibility, lowering kernel requirements to Linux 4.4+ (#416). -->
- Enhance data debugging functionality, allowing data collected to be written to local files while simultaneously sent to the center (#415).
- In K8s environments, default-enabled collectors support injecting tags via environment variables, see individual default-enabled collector documents (#408).
- DataKit supports [one-click log upload](datakit-tools-how-to#0b4d9e46) (#405).
<!-- - MySQL collector adds [SQL execution performance metrics] (#382). -->
- Fix root user setting bug in installation scripts (#430).
- Enhance Kubernetes collector:
    - Add log collection configuration via Annotation for [Pod logs](kubernetes-podlogging) (#380).
    - Add more Annotation keys, [supporting multiple IPs](kubernetes-prom#b8ba2a9e) (#419).
    - Support collecting Node IP (#411).
    - Optimize Annotation usage in collector configurations (#380).
- Cloud sync adds Huawei Cloud and Microsoft Cloud support (#265).

---

## 1.1.9-rc3 (2021/10/26) {#cl-1.1.9-rc3}

- Optimize [Redis collector](redis) DB configuration method (#395).
- Fix empty tag values in [Kubernetes](kubernetes) collector (#409).
- Fix Mac M1 chip support during installation (#407).
- [eBPF-network](net_ebpf) fixes connection count statistical errors (#387).
- Log collection adds [log data acquisition methods](logstreaming), supporting [Fluentd/Logstash data ingestion](logstreaming) (#394/#392/#391).
- [ElasticSearch](elasticsearch) collector adds more metric collections (#386).
- APM adds [Jaeger data](jaeger) ingestion (#383).
- [Prometheus Remote Write](prom_remote_write) collector supports data slice debugging.
- Optimize [Nginx proxy](proxy#a64f44d8) functionality.
- DQL query results support [CSV file export](datakit-dql-how-to#2368bf1d).

---

## 1.1.9-rc2 (2021/10/14) {#cl-1.1.9-rc2}

- Add collector support for [Prometheus Remote Write](prom_remote_write) synchronizing data to DataKit (#381).
- Add [Kubernetes Event data collection](kubernetes#49edf2c4) (#296).
- Fix Mac installation failing due to security policies (#379).
- Debugging tool for [Prom collector](prom) supports local file debugging (#378).
- Fix data issues in [etcd collector](etcd) (#377).
- DataKit Docker image adds arm64 architecture support (#365).
- Installation stage adds environment variable `DK_HOSTNAME` [support](datakit-install#f9858758) (#334).
- [Apache collector](apache) adds more metric collections (#329).
- DataKit API adds interface [`/v1/workspace`](apis#2a24dd46) to retrieve workspace information (#324).
    - Supports obtaining workspace information via command-line parameters [for DataKit](datakit-tools-howto#88b4967d)

---

## 1.1.9-rc1.1 (2021/10/09) {#cl-1.1.9-rc1.1}

- Fix Kubernetes election issues (#389)
- Fix MongoDB configuration compatibility issues

---

## 1.1.9-rc1 (2021/09/28) {#cl-1.1.9-rc1}

- Improve Prometheus metric collection under Kubernetes ecosystem (#368/#347)
- Optimize [eBPF-network](net_ebpf)
- Fix connection leak issue between DataKit and DataWay (#290)
- Fix inability to execute various subcommands in container mode (#375)
- Fix log collector losing original data due to Pipeline errors (#376)
- Improve [DCA](dca) functionality on the DataKit side, supporting enabling DCA during installation (#334)
- Remove browser synthetic test functionality

---

## 1.1.9-rc0 (2021/09/23) {#cl-1.1.9-rc0}

- [Log collector](logging) adds special character (such as color characters) filtering function (default off) (#351)
- [Improve container log collection](container#6a1b31bb), synchronizing more existing standard log collector functions (multiline matching/log level filtering/character encoding, etc.) (#340)
- [Host object](hostobject) collector field adjustments (#348)
- Add several new collectors:
    - [eBPF-network](net_ebpf) (alpha) (#148)
    - [Consul](consul) (#303)
    - [etcd](etcd) (#304)
    - [CoreDNS](coredns) (#305)
- Election functionality now covers the following collectors: (#288)
    - [Kubernetes](kubernetes)
    - [Prom](prom)
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

## 1.1.8-rc3 (2021/09/10) {#cl-1.1.8-rc3}

- DDTrace adds [resource filtering](ddtrace#224e2ccd) functionality (#328)
- Add [NSQ](nsq) collector (#312)
- In K8s DaemonSet deployments, some collectors support changing default configurations via environment variables, e.g., [CPU example](cpu#1b85f981) (#309)
- Preliminary support for [SkyWalkingV3](skywalking) (alpha) (#335)
- [RUM](rum) collector removes full-text fields to reduce network overhead (#349)
- [Log collector](logging) adds handling for file truncation scenarios (#271)
- Compatibility with log field slicing error fields (#342)
- Fix potential TLS errors during [offline downloads](datakit-offline-install) (#330)
- Once log collection is configured successfully, trigger a notification log indicating that log collection for the corresponding file has started (#323)

---

## 1.1.8-rc2.4 (2021/08/26) {#cl-1.1.8-rc2.4}

- Fix installation program enabling cloud sync leading to inability to install issues

---

## 1.1.8-rc2.3 (2021/08/26) {#cl-1.1.8-rc2.3}

- Fix container runtime unable to start issues

---

## 1.1.8-rc2.2 (2021/08/26) {#cl-1.1.8-rc2.2}

- Fix [`hostdir`](hostdir) configuration file non-existence issues

---

## 1.1.8-rc2.1 (2021/08/25) {#cl-1.1.8-rc2.1}

- Fix CPU temperature collection leading to no data issues
- Fix statsd collector crash upon exit (#321)
- Fix proxy mode auto-prompted upgrade command issues

---

## 1.1.8-rc2 (2021/08/24) {#cl-1.1.8-rc2}

- Support syncing Kubernetes labels to various objects (pod/service/...) (#279)
- `datakit` metrics set adds data discard metrics (#286)
- [Kubernetes cluster custom metrics collection](kubernetes-prom) optimization (#283)
- [ElasticSearch](elasticsearch) collector improvement (#275)
- Add [host directory](hostdir) collector (#264)
- [CPU](cpu) collector supports individual CPU metric collection (#317)
- [DDTrace](ddtrace) supports multiple route configurations (#310)
- [DDTrace](ddtrace#fb3a6e17) supports custom business tag extraction (#316)
- [Host object](hostobject) reports only errors within the last 30 seconds (#318)
- [DCA client](dca) release
- Disable some Windows command-line help (#319)
- Adjust [DataKit installation method](datakit-install), [offline installation](datakit-offline-install) method adjusted (#300)
    - Still compatible with previous old installation methods after adjustment

### Breaking Changes {#cl-1.1.8-rc2brk}

- Functionality to obtain hostname from environment variable `ENV_HOSTNAME` has been removed (supported in 1.1.7-rc8), use [hostname override function](datakit-install#987d5f91) instead.
- Remove command option `--reload`
- Remove DataKit API `/reload`, replace it with `/restart`
- Due to command-line option adjustments, previous monitor viewing commands now require sudo privileges (as they need to read *datakit.conf* to automatically retrieve Datakit configurations).

---

## 1.1.8-rc1.1 (2021/08/13) {#cl-1.1.8-rc1.1}

- Fix `ENV_HTTP_LISTEN` ineffectiveness issue, which caused abnormal HTTP service startup in container deployments (including K8s DaemonSet deployments).

---

## 1.1.8-rc1 (2021/08/10) {#cl-1.1.8-rc1}

- Fix cloud sync being enabled but unable to report host objects issue
- Fix Mac new installation of DataKit not starting issue
- Fix "fake success" issues for non-`root` users operating services on Mac/Linux
- Optimize performance of data uploads
- [`proxy`](proxy) collector supports global proxy functionality, involving adjustments to internal network environments for installations, updates, and data uploads
- Optimize log collector performance
- Document improvements

---

## 1.1.8-rc0 (2021/08/03) {#cl-1.1.8-rc0}

- Improve [Kubernetes](kubernetes) collector, add more Kubernetes object collections
- Improve [hostname override function](datakit-install#987d5f91)
- Optimize Pipeline processing performance (approximately 15 times improvement depending on different Pipeline complexities)
- Strengthen [line protocol data validation](apis#2fc2526a)
- `system` collector adds [`conntrack` and `filefd`](system) two measurement sets
- `datakit.conf` adds IO tuning entry points, facilitating user optimization of DataKit's network outbound traffic (see below Breaking Changes section)
- DataKit supports [service uninstallation and restoration](datakit-service-how-to#9e00a535)
- Windows platform services support [command-line management](datakit-service-how-to#147762ed)
- DataKit supports dynamically obtaining the latest DataWay address, avoiding default DataWay being DDoS attacked
- DataKit logs support [outputting to terminal](datakit-daemonset-deploy#00c8a780) (not supported on Windows), facilitating log inspection and collection during k8s deployments
- Adjust main DataKit configuration, modularize different configuration sections (see below Breaking Changes section)
- Other bug fixes and documentation enhancements

### Breaking Changes {#cl-1.1.8-rc0brk}

The following changes will be automatically adjusted during upgrades, mentioned here for clarity:

- Main configuration modifications: Add the following modules

```toml
[io]
  feed_chan_size                 = 1024  # IO pipeline buffer size
  hight_frequency_feed_chan_size = 2048  # High-frequency IO pipeline buffer size
  max_cache_count                = 1024  # Maximum local cache size, original main configuration's io_cache_count [this value along with max_dynamic_cache_count being less than or equal to zero allows unlimited memory usage]
  cache_dump_threshold         = 512   # Local cache cleanup threshold after pushing [this value less than or equal to zero prevents cache cleanup, possible network interruption may lead to excessive memory usage]
  max_dynamic_cache_count      = 1024  # HTTP cache maximum size [this value along with max_cache_count being less than or equal to zero allows unlimited memory usage]
  dynamic_cache_dump_threshold = 512   # HTTP cache cleanup threshold after pushing [this value less than or equal to zero prevents cache cleanup, possible network interruption may lead to excessive memory usage]
  flush_interval               = "10s" # Push interval
  output_file                  = ""    # Output IO data to local file, original main configuration's output_file

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

## 1.1.7-rc9.1 (2021/07/17) {#cl-1.1.7-rc9.1}

- Fix file handle leakage potentially causing failure to restart DataKit on Windows platforms.

## 1.1.7-rc9 (2021/07/15) {#cl-1.1.7-rc9}

- Installation stage supports filling cloud provider, namespace, and NIC binding
- Multi-namespace election support
- Add [InfluxDB collector](influxdb)
- Datakit DQL adds historical command storage
- Other minor bug fixes and document enhancements

---

## 1.1.7-rc8 (2021/07/09) {#cl-1.1.7-rc8}

- Support MySQL [user](mysql#15319c6c) and [table-level](mysql#3343f732) metric collection
- Adjust monitor page display:
    - Separate collector configuration status and collection status displays
    - Add election and automatic update status displays
- Support obtaining hostname from `ENV_HOSTNAME` to handle cases where original hostname is unavailable
- Support tag-level [Trace](ddtrace) filtering
- [Container collector](container) supports collecting processes inside containers
- Support controlling DataKit CPU usage via [cgroup] (Linux only) (#365)
- Add [IIS collector](iis)
- Fix upload issues caused by dirty data in cloud sync

---

## 1.1.7-rc7 (2021/07/01) {#cl-1.1.7-rc7}

- DataKit API supports [JSON Body](apis#75f8e5a2)
- Command-line adds functionality:
    - [DQL query feature](datakit-dql-how-to#cb421e00)
    - [Command-line monitor view](datakit-tools-how-to#44462aae)
    - [Check if collector configuration is correct](datakit-tools-how-to#519a9e75)

- Log performance optimization (for built-in log collectors like nginx/MySQL/Redis; other built-in log collectors will follow)
- Host object collector adds [`conntrack`](hostobject#2300b531) and [`filefd`](hostobject#697f87e2) two types of metrics
- Application performance metrics collection supports [sampling rate setting](ddtrace#c59ce95c)
- General Kubernetes cluster Prometheus metrics collection solution [kubernetes-prom]

### Breaking Changes {#cl-1.1.7-rc7brk}

- In *datakit.conf*, `global_tags`'s `host` tag will no longer take effect. This mainly avoids misunderstandings when configuring `host` (configured `host` may differ from actual hostname, leading to data misinterpretations).

---

## 1.1.7-rc6 (2021/06/17) {#cl-1.1.7-rc6}

- Add [Windows Event collector](windows_event)
- Provide options to disable DataKit's 404 page for public RUM DataKit deployment
- [Container collector](container) field optimizations mainly involve Pod's `restart/ready/state` fields
- [Kubernetes collector](kubernetes) adds more metric collections
- Support log blacklisting on the DataKit side
    - Note: If DataKit is configured with multiple DataWay addresses, log filtering will not take effect.

### Breaking Changes {#cl-1.1.7-rc6brk}

For collectors without Yuzhuo documentation support, all have been removed in this release (various cloud collectors like Alibaba Cloud monitoring data and cost data). If dependent on these collectors, upgrading is not recommended.

---

## 1.1.7-rc5 (2021/06/16) {#cl-1.1.7-rc5}

Fix [DataKit API](apis) `/v1/query/raw` being unusable issue.

---

## 1.1.7-rc4 (2021/06/11) {#cl-1.1.7-rc4}

Disable Docker collector, its functionality is fully implemented by the [container collector].

Reasons:

- Coexistence of Docker and container collectors (DataKit defaults to enabling container collector during installation/upgrade) leads to duplicate data.
- Current Studio frontend/templates do not yet support the latest container fields, potentially causing users to see no container data after upgrading. This version's container collector redundantly retains metrics collected by the original Docker collector to ensure normal Studio operation.

> Note: If additional Docker configurations exist in older versions, it is recommended to manually migrate them to the [container collector]. Their configurations are largely compatible.

---

## 1.1.7-rc3 (2021/06/10) {#cl-1.1.7-rc3}

- Add [disk S.M.A.R.T collector](smart)
- Add [hardware temperature collector](sensors)
- Add [Prometheus collector](prom)
- Correct [Kubernetes collector](kubernetes), support more K8s object statistic metric collections
- Perfect [container collector](container), support image/container/pod filtering
- Correct [Mongodb collector](mongodb) issues
- Correct MySQL/Redis collector crashes potentially caused by missing configurations
- Correct [offline installation issues](datakit-offline-install)
- Correct part of collector log settings issues
- Correct data issues in [SSH](ssh)/[Jenkins](jenkins) collectors

---

## 1.1.7-rc2 (2021/06/07) {#cl-1.1.7-rc2}

- Add [Kubernetes collector](kubernetes)
- DataKit supports [DaemonSet deployment](datakit-daemonset-deploy)
- Add [SQL Server collector](sqlserver)
- Add [PostgreSQL collector](postgresql)
- Add [statsd collector](statsd) to support collecting statsd data sent over the network
- [JVM collector](jvm) prioritizes DDTrace/StatsD collection
- Add [container collector](container), enhancing k8s node (Node) collection to replace the original [docker collector](docker) (original docker collector remains usable)
- [Synthetic test collector](dialtesting) supports Headless mode
- [Mongodb collector](mongodb) supports collecting Mongodb's own logs
- DataKit adds DQL HTTP [API interface](apis) `/v1/query/raw`
- Improve documentation for some collectors, adding middleware (like MySQL/Redis/ES, etc.) log collection-related documentation

---

## 1.1.7-rc1 (2021/05/26) {#cl-1.1.7-rc1}

- Fix Redis/MySQL collector data anomalies
- MySQL InnoDB metrics restructured, details refer to [MySQL documentation](mysql#e370e857)

---

## 1.1.7-rc0 (2021/05/20) {#cl-1.1.7-rc0}

New collectors added:

- [Apache](apache)
- [Cloudprober access](cloudprober)
- [GitLab](gitlab)
- [Jenkins](jenkins)
- [Memcached](memcached)
- [Mongodb](mongodb)
- [SSH](ssh)
- [Solr](solr)
- [Tomcat](tomcat)

New features related:

- Network synthetic tests support private node access
- Linux platform defaults to enabling container object and log collection
- CPU collector supports temperature data collection
- [MySQL slow log supports cutting according to AliCloud RDS format](mysql#ee953f78)

Other various bug fixes.

### Breaking Changes {#cl-1.1.7-rc0brk}

[RUM collection] data types have been adjusted, original data types are mostly deprecated, requiring [updating corresponding SDKs](/dataflux/doc/eqs7v2).

---

## 1.1.6-rc7 (2021/05/19) {#cl-1.1.6-rc7}

- Fix Windows platform installation and upgrade issues

---

## 1.1.6-rc6 (2021/05/19) {#cl-1.1.6-rc6}

- Fix data processing issues in some collectors (MySQL/Redis) due to missing metrics
- Other minor bug fixes

---

## 1.1.6-rc5 (2021/05/18) {#cl-1.1.6-rc5}

- Fix HTTP API precision parsing issues leading to failed timestamp parsing for certain data

---

## 1.1.6-rc4 (2021/05/17) {#cl-1.1.6-rc4}

- Fix potential crashes in container log collection

---

## 1.1.6-rc3 (2021/05/13) {#cl-1.1.6-rc3}

This release includes the following updates:

- After DataKit installation/upgrade, the installation directory changes to:

    - Linux/Mac: `/usr/local/datakit`, log directory is `/var/log/datakit`
    - Windows: `C:\Program Files\datakit`, log directory is under the installation directory

- Support [`/v1/ping` interface](apis#50ea0eb5)
- Remove RUM collector, RUM interface [already supported by default](apis#f53903a9)
- Add monitor page: http://localhost:9529/monitor, replacing the previous /stats page. Automatically redirects to the monitor page after reload.
- Support directly [installing sec-checker](datakit-tools-how-to#01243fef) and [updating ip-db](datakit-tools-how-to#ab5cd5ad) via commands

---

## 1.1.6-rc2 (2021/05/11) {#cl-1.1.6-rc2}

- Fix container deployment not starting issues

---

## 1.1.6-rc1 (2021/05/10) {#cl-1.1.6-rc1}

This release makes some detailed adjustments to DataKit:

- DataKit supports configuring multiple DataWays
- [Cloud association](hostobject#031406b2) achieved through corresponding meta interfaces
- Adjust the filtering method for docker log collection [filtering method](docker#a487059d)
- [DataKit supports elections](election)
- Fix historical data cleanup issues in synthetic tests
- Large amounts of documentation [published to Yuzhuo](https://www.yuque.com/dataflux/datakit){:target="_blank"}
- [DataKit supports integrating Telegraf via command line](datakit-tools-how-to#d1b3b29b)
- DataKit single-instance run detection
- DataKit [automatic update function](datakit-update-crontab)

---

## 1.1.6-rc0 (2021/04/30) {#cl-1.1.6-rc0}

This release makes some detailed adjustments to DataKit:

- Linux/Mac installations allow running `datakit` commands directly in any directory without switching to the DataKit installation directory
- Pipeline adds desensitization function `cover()`
- Optimize command-line parameters for better convenience
- Host object collection defaults to filtering virtual devices (only supported on Linux)
- Datakit command supports `--start/--stop/--restart/--reload` commands (requires root privileges), making it easier for users to manage DataKit services
- After installation/upgrade, default-enable process object collector (currently default-enabled list includes `cpu/disk/diskio/mem/swap/system/hostobject/net/host_processes`)
- Rename log collector `tailf` to `logging`; original `tailf` name remains available
- Support accessing Security data
- Remove Telegraf installation integration. If Telegraf functionality is required, refer to :9529/man pages for specific Telegraf installation documentation
- Add Datakit How To documentation to facilitate initial learning (:9529/man pages can be viewed)
- Other metric collection adjustments for some collectors

---

## v1.1.5-rc2 (2021/04/22) {#cl-1.1.5-rc2}

### Bug Fixes {#cl-1.1.5-rc2fix}

- Fix Windows `--version` command requesting incorrect online version information address
- Adjust Huawei Cloud monitoring data collection configuration, exposing more configurable information for real-time adjustments
- Adjust Nginx error log (error.log) cutting script, while adding default log level classifications

---

## v1.1.5-rc1 (2021/04/21) {#cl-1.1.5-rc1fix}

- Fix compatibility issue in `tailf` collector configuration files, preventing `tailf` collector from running

---

## v1.1.5-rc0 (2021/04/20) {#cl-1.1.5-rc0}

This release makes significant adjustments to collectors.

### Breaking Changes {#cl-1.1.5-rc0brk}

The following collectors are affected:

| Collector          | Description                                                                                                                                                                                      |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cpu`             | Built-in DataKit CPU collector, remove Telegraf CPU collector, configuration file remains compatible. Additionally, Mac platform temporarily does not support CPU collection, which will be resolved later.                                                                 |
| `disk`            | Built-in DataKit disk collector                                                                                                                                                                    |
| `docker`          | Redesigned Docker collector, supporting both container objects, container logs, and container metrics (with additional support for K8s containers)                                                                                           |
| `elasticsearch`    | Built-in ES collector in DataKit, simultaneously removing ES collector from Telegraf. Directly configure ES log collection within this collector.                                                                                        |
| `jvm`             | Built-in JVM collector in DataKit                                                                                                                                                                   |
| `kafka`           | Built-in Kafka metrics collector in DataKit, directly collect Kafka logs within this collector                                                                                                                          |
| `mem`             | Built-in DataKit memory collector, remove Telegraf memory collector, configuration file remains compatible                                                                                                                        |
| `mysql`           | Built-in MySQL collector in DataKit, remove Telegraf MySQL collector. Directly configure MySQL log collection within this collector                                                                                                  |
| `net`             | Built-in DataKit network collector, remove Telegraf network collector. By default, virtual NICs are no longer collected on Linux (manual enable required)                                                                               |
| `nginx`           | Built-in NGINX collector in DataKit, remove Telegraf NGINX collector. Directly configure NGINX log collection within this collector                                                                                                  |
| `oracle`          | Built-in Oracle collector in DataKit. Directly configure Oracle log collection within this collector                                                                                                                            |
| `rabbitmq`        | Built-in RabbitMQ collector in DataKit. Directly configure RabbitMQ log collection within this collector                                                                                                                        |
| `redis`           | Built-in Redis collector in DataKit. Directly configure Redis log collection within this collector                                                                                                                              |
| `swap`            | Built-in DataKit swap memory collector                                                                                                                                                              |
| `system`          | Built-in system collector in DataKit, remove Telegraf system collector. Add three new metrics: `load1_per_core/load5_per_core/load15_per_core`, allowing clients to directly display per-core average load without extra calculations |

Most updates to these collectors involve metric set and metric name changes, refer to each collector’s documentation for specifics.

Other compatibility issues:

- For security reasons, collectors no longer bind to all NICs by default, binding to `localhost:9529`. Previously bound `0.0.0.0:9529` is no longer effective (`http_server_addr` field also deprecated), manually modify `http_listen` to `http_listen = "0.0.0.0:9529"` (port can be changed).
- Some middleware (e.g., MySQL/Nginx/Docker) already integrates corresponding log collection. These logs can be directly configured within their respective collectors without needing an additional `tailf` collector (though `tailf` can still be used independently).
- The following collectors are no longer effective, use the built-in collectors mentioned above:
    - `dockerlog`: Integrated into the Docker collector
    - `docker_containers`: Integrated into the Docker collector
    - `mysqlMonitor`: Integrated into the MySQL collector

### New Features {#cl-1.1.5-rc0new}

- Synthetic test collector (`dialtesting`): Supports centralized task issuance. On the Studio homepage, there is a separate synthetic test entry point to create synthetic test tasks for trials.
- All collector configurations support environment variable settings, such as `host="$K8S_HOST"`, facilitating container environment deployments.
- http://localhost:9529/stats adds more collector operational statistics, including collection frequency (`frequency`), average number of data points reported per time (`avg_size`), and average collection consumption (`avg_collect_cost`). Some collectors might lack certain fields, which doesn’t affect functionality since each collector collects differently.
- http://localhost:9529/reload can reload collectors, such as after modifying configuration files, directly execute `curl http://localhost:9529/reload` without restarting services, similar to Nginx’s `-s reload` function. You can also visit the reload address directly via the browser, automatically redirecting to the stats page upon successful reload.
- Support browsing DataKit documentation on http://localhost:9529/man (only newly modified collector documentation integrated, other collector documents remain accessible from the original help center). Default disables remote viewing of DataKit documentation, terminal viewing supported (Mac/Linux only):

```shell
# Enter the collector installation directory and input the collector name (use `Tab` key for auto-completion).
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

- Fix frequent collection of AliCloud CMS data causing some other collectors to freeze (#2317)

---

## v1.1.4-rc1 (2021/03/25) {#cl-1.1.4-rc1opt}

- Process collector `message` field adds more information for full-text search
- Host object collector supports custom tags for cloud attribute synchronization

---

## v1.1.4-rc0 (2021/03/25) {#cl-1.1.4-rc0}

### New Features {#cl-1.1.4-rc0new}

- Add file collector, synthetic test collector, and HTTP packet collector
- Built-in support for ActiveMQ/Kafka/RabbitMQ/gin (Gin HTTP access logs)/Zap (third-party log framework) log cutting

### Improvements {#cl-1.1.4-rc0fix}

- Enrich statistical information on `http://localhost:9529/stats` page, adding collection frequency (`n/min`) and amount of data collected each time
- DataKit itself adds some caching space (cleared upon restart) to avoid data loss due to occasional network issues
- Improve Pipeline date conversion functions for higher accuracy. Also add more Pipeline functions (`parse_duration()/parse_date()`).
- Trace data adds more business fields (`project/env/version/http_method/http_status_code`)
- Various detail improvements for other collectors

---

## v1.1.3-rc4 (2021/03/16) {#cl-1.1.3-rc4fix}

- Process collector: Fix blank username display issue, use `nobody` as username for processes failing to retrieve usernames.

---

## v1.1.3-rc3 (2021/03/04) {#cl-1.1.3-rc3fix}

- Fix empty field issues (process user and process command missing) in process collector
- Fix potential panic in memory usage rate calculation in Kubernetes collector

---

## v1.1.3-rc2 (2021/03/01) {#cl-1.1.3-rc2fix}

- Fix naming issue in process object collector `name` field, using `hostname + pid` to name `name` field
- Fix Pipeline issues in Huawei Cloud object collector
- Fix compatibility issues after upgrading Nginx/MySQL/Redis log collectors

---

## v1.1.3-rc1 (2021/02/26) {#cl-1.1.3-rc1}

### New Features {#cl-1.1.3-rc1new}

- Add built-in Redis/Nginx collectors
- Improve MySQL slow query log analysis

### Functional Improvements {#cl-1.1.3-rc1opt}

- Process collector restricts collection frequency to a minimum value of 30 seconds due to long single-collection durations
- Collector configuration filenames are no longer strictly limited, any filename resembling `xxx.conf` is valid
- Update version prompt judgment, prompting updates if Git commit hash differs from the online version
- Container object collector (`docker_containers`) adds memory/CPU ratio fields (`mem_usage_percent/cpu_usage`) (#562)
- K8s metrics collector (`kubernetes`) adds CPU ratio field (`cpu_usage`) (#562)
- Tracing data collection improves service type handling
- Some collectors support custom log or metric writing (default metrics)

### Bug Fixes {#cl-1.1.3-rc1fix}

- Fix Mac platform process collector retrieving default username incorrectly (#2028)
- Correct container object collector to capture exited containers (#2186)
- Other minor bug fixes

### Breaking Changes {#cl-1.1.3-rc1brk}

- For certain collectors, if original metrics contain `uint64` type fields, the new version may cause incompatibility, delete existing metric sets to avoid type conflicts.

    - Originally, `uint64` was automatically converted to string, leading to usage confusion. More precise control of integer removal is now feasible.
    - Metrics exceeding max-int64 will be discarded by collectors because InfluxDB 1.7 does not support uint64 metrics.

- Remove some original `dkctrl` command execution functionalities; subsequent configuration management will no longer rely on this approach.

---

## v1.1.2 (2021/02/03) {#cl-1.1.2}

### Functional Improvements {#cl-1.1.0-opt}

- During container installation, inject `ENV_UUID` environment variable
- After upgrading from old versions, host collectors are automatically enabled (backup of original *datakit.conf* created)
- Add cache functionality to avoid losing collected data during network fluctuations (data would still be lost during prolonged network outages)
- All logs collected using `tailf` must specify the `time` field in Pipeline to indicate the extracted time field, otherwise log insertion time may differ from actual log times

### Bug Fixes {#cl-1.2.0-fix}

- Fix time unit issues in Zipkin
- Add `state` field to host object collectors

---

## v1.1.1 (2021/02/01) {#cl-1.1.1}

### Bug Fixes {#cl-1.1.1-fix}

- Fix `status/variable` fields being string types in Mysql Monitor collector. Revert to original field types. Protect against int64 overflow issues.
- Change part of process collector field names to align with host collector naming conventions

---

## v1.1.0 (2021/01/29) {#cl-1.1.0}

This version mainly involves bug fixes for some collectors and adjustments to Datakit's main configuration.

### Breaking Changes {#cl-1.1.0-brk}

- Adopt a new version numbering mechanism. Version numbers like `v1.0.0-2002-g1fe9f870` will no longer be used, changing to `v1.2.3`.
- Move `datakit.conf` from top-level DataKit directory into `conf.d` directory.
- Move original `network/net.conf` into `host/net.conf`.
- Transfer original `pattern` directory to `pipeline` directory.
- Convert built-in patterns in Grok (e.g., `%{space}`) to uppercase forms `%{SPACE}`. **All previously written Groks need to be fully replaced**.
- Remove `uuid` field from `datakit.conf`, store it separately in `.id` file for unified DataKit configuration management.
- Remove Ansible collector event data reporting.

### Bug Fixes {#cl-1.1.0-fix}

- Fix `prom` and `oraclemonitor` collectors not collecting data issues.
- Rename `self` collector's `hostname` field to `host` and place it in the tag.
- Fix `mysqlMonitor` concurrent MySQL and MariaDB collection type conflict issues.
- Fix SkyWalking collector log splitting causing disk full issues.

### Features {#cl-1.1.0-new}

- Add whitelist/blacklist functionality for collectors/hosts (no regex support currently)
- Restructure collectors for hosts, processes, containers, etc.
- Add Pipeline/Grok debugging tools
- `-version` parameter shows current version and prompts online new version information and update commands.
- Support DDTrace data ingestion.
- `tailf` collector switches new log matching to forward matching.
- Other minor issue fixes.
- Support CPU data collection on Mac platforms.

--- 

## v1.0.5-rc2 (2021/04/22) {#cl-1.0.5-rc2}

### Bug Fixes {#cl-1.0.5-rc2fix}

- Fix Windows `--version` command requesting wrong online version information address
- Adjust Huawei Cloud monitoring data collection configuration, expose more configurable information for real-time adjustments
- Adjust Nginx error log (error.log) cutting script, add default log level classification

---

## v1.0.5-rc1 (2021/04/21) {#cl-1.0.5-rc1fix}

- Fix `tailf` collector configuration file compatibility issues, preventing the collector from running

---

## v1.0.5-rc0 (2021/04/20) {#cl-1.0.5-rc0}

This release significantly adjusts collectors.

### Breaking Changes {#cl-1.0.5-rc0brk}

Affected collectors include:

| Collector          | Description                                                                                                                                                                                      |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cpu`             | Built-in CPU collector in DataKit, remove Telegraf CPU collector, configuration files remain compatible. Mac platform temporarily does notsupport CPU collection, which will be addressed later. |
| `disk`            | Built-in disk collector in DataKit.                                                                                                                                   |
| `docker`          | Redesigned Docker collector supporting both container objects, container logs, and container metrics (with additional support for K8s containers).                                                   |
| `elasticsearch`    | Built-in Elasticsearch collector in DataKit, simultaneously removing the Elasticsearch collector from Telegraf. Directly configure Elasticsearch log collection within this collector.                                     |
| `jvm`             | Built-in JVM collector in DataKit.                                                                                                                                 |
| `kafka`           | Built-in Kafka metrics collector in DataKit, directly collecting Kafka logs within this collector.                                                                                           |
| `mem`             | Built-in memory collector in DataKit, remove Telegraf memory collector, configuration files remain compatible.                                                                                     |
| `mysql`           | Built-in MySQL collector in DataKit, remove Telegraf MySQL collector. Directly configure MySQL log collection within this collector.                                                                                   |
| `net`             | Built-in network collector in DataKit, remove Telegraf network collector. On Linux, virtual NICs are no longer collected by default (manual enable required).                                                         |
| `nginx`           | Built-in NGINX collector in DataKit, remove Telegraf NGINX collector. Directly configure NGINX log collection within this collector.                                                                                   |
| `oracle`          | Built-in Oracle collector in DataKit. Directly configure Oracle log collection within this collector.                                                                                                 |
| `rabbitmq`        | Built-in RabbitMQ collector in DataKit. Directly configure RabbitMQ log collection within this collector.                                                                                                   |
| `redis`           | Built-in Redis collector in DataKit. Directly configure Redis log collection within this collector.                                                                                                                 |
| `swap`            | Built-in swap memory collector in DataKit.                                                                                                                                                 |
| `system`          | Built-in system collector in DataKit, remove Telegraf system collector. Add three new metrics: `load1_per_core/load5_per_core/load15_per_core`, allowing clients to directly display per-core average load without extra calculations. |

The updates to these collectors involve significant changes in metric sets and metric names. Refer to each collector's documentation for specifics.

Other compatibility issues:

- For security reasons, collectors no longer bind to all NICs by default, binding only to `localhost:9529`. The previously bound `0.0.0.0:9529` is no longer effective (`http_server_addr` has also been deprecated), manually modify `http_listen` to `http_listen = "0.0.0.0:9529"` (port can be changed).
- Some middleware (e.g., MySQL/Nginx/Docker) already integrates corresponding log collection. These logs can be directly configured within their respective collectors without needing an additional `tailf` collector (though `tailf` can still be used independently).
- The following collectors are no longer effective; use the built-in collectors mentioned above:
  - `dockerlog`: Integrated into the Docker collector.
  - `docker_containers`: Integrated into the Docker collector.
  - `mysqlMonitor`: Integrated into the MySQL collector.

### Bug Fixes {#cl-1.0.5-rc0fix}

- Fix `prom` and `oraclemonitor` collectors not collecting data issues.
- Rename the `self` collector’s hostname field from `hostname` to `host` and place it in the tag.
- Fix `mysqlMonitor` concurrently collecting MySQL and MariaDB causing type conflicts.
- Fix SkyWalking collector log splitting leading to full disk issues.

### Features {#cl-1.0.5-rc0new}

- Add whitelist/blacklist functionality for collectors/hosts (currently does not support regex).
- Restructure collectors for hosts, processes, containers, etc.
- Add Pipeline/Grok debugging tools.
- `-version` parameter shows current version and prompts online new version information and update commands.
- Support DDTrace data ingestion.
- Change `tailf` collector new log matching to forward matching.

---

## v1.0.4-rc2 (2021/04/07) {#cl-1.0.4-rc2}

### Bug Fixes {#cl-1.0.4-rc2fix}

- Fix frequent collection of AliCloud CMS data causing some other collectors to freeze (#2317).

---

## v1.0.4-rc1 (2021/03/25) {#cl-1.0.4-rc1}

### Improvements {#cl-1.0.4-rc1opt}

- Process collector `message` field adds more information for full-text search.
- Host object collector supports custom tags for cloud attribute synchronization.

---

## v1.0.4-rc0 (2021/03/25) {#cl-1.0.4-rc0}

### New Features {#cl-1.0.4-rc0new}

- Add file collector, synthetic test collector, and HTTP packet collector.
- Built-in support for ActiveMQ/Kafka/RabbitMQ/gin (Gin HTTP access logs)/Zap (third-party log framework) log cutting.

### Improvements {#cl-1.0.4-rc0fix}

- Enrich statistical information on `http://localhost:9529/stats` page, adding collection frequency (`n/min`) and amount of data collected each time.
- DataKit itself adds some caching space (cleared upon restart) to avoid data loss due to occasional network issues.
- Improve Pipeline date conversion functions for higher accuracy. Also add more Pipeline functions (`parse_duration()/parse_date()`).
- Trace data adds more business fields (`project/env/version/http_method/http_status_code`).
- Various detail improvements for other collectors.

---

## v1.0.3-rc4 (2021/03/16) {#cl-1.0.3-rc4fix}

- Process collector: Fix blank username display issue, using `nobody` as the username for processes failing to retrieve usernames.

---

## v1.0.3-rc3 (2021/03/04) {#cl-1.0.3-rc3fix}

- Fix empty field issues (process user and process command missing) in the process collector.
- Fix potential panic in memory usage rate calculation in the Kubernetes collector.

---

## v1.0.3-rc2 (2021/03/01) {#cl-1.0.3-rc2fix}

- Fix naming issue in process object collector `name` field, naming `name` field with `hostname + pid`.
- Correct Huawei Cloud object collector Pipeline issues.
- Fix compatibility issues after upgrading Nginx/MySQL/Redis log collectors.

---

## v1.0.3-rc1 (2021/02/26) {#cl-1.0.3-rc1}

### New Features {#cl-1.0.3-rc1new}

- Add built-in Redis/Nginx collectors.
- Improve MySQL slow query log analysis.

### Functional Improvements {#cl-1.0.3-rc1opt}

- Limit process collector collection frequency to a minimum value of 30 seconds due to long single-collection durations.
- Collector configuration filenames are no longer strictly limited; any filename resembling `xxx.conf` is valid.
- Update version prompt judgment; if Git commit hash differs from the online version, it will prompt updates.
- Container object collector (`docker_containers`) adds memory/CPU ratio fields (`mem_usage_percent/cpu_usage`).
- K8s metrics collector (`kubernetes`) adds CPU ratio field (`cpu_usage`).
- Tracing data collection improves service type handling.
- Some collectors support custom log or metric writing (default metrics).

### Bug Fixes {#cl-1.0.3-rc1fix}

- Fix Mac platform process collector retrieving default username incorrectly.
- Correct container object collector to capture exited containers.
- Other minor bug fixes.

### Breaking Changes {#cl-1.0.3-rc1brk}

- For certain collectors, if original metrics contain `uint64` type fields, the new version may cause incompatibility. Delete existing metric sets to avoid type conflicts.

    - Originally, `uint64` was automatically converted to string, leading to usage confusion. More precise control over integer removal is now feasible.
    - Metrics exceeding max-int64 will be discarded by collectors because InfluxDB 1.7 does not support uint64 metrics.

- Remove some original `dkctrl` command execution functionalities; subsequent configuration management will no longer rely on this approach.

---

## v1.0.2 (2021/02/03) {#cl-1.0.2}

### Functional Improvements {#cl-1.0.2-opt}

- During container installation, inject `ENV_UUID` environment variable.
- After upgrading from old versions, host collectors are automatically enabled (original *datakit.conf* is backed up).
- Add cache functionality to avoid losing collected data during network fluctuations (data would still be lost during prolonged network outages).
- All logs collected using `tailf` must specify the `time` field in Pipeline to indicate the extracted time field; otherwise, log insertion times may differ from actual log times.

### Bug Fixes {#cl-1.0.2-fix}

- Fix time unit issues in Zipkin.
- Add `state` field to host object collectors.

---

## v1.0.1 (2021/02/01) {#cl-1.0.1}

### Bug Fixes {#cl-1.0.1-fix}

- Fix Mysql Monitor collector `status/variable` fields being string types. Revert to original field types. Protect against int64 overflow issues.
- Change part of process collector field names to align with host collector naming conventions.

---

## v1.0.0 (2021/01/29) {#cl-1.0.0}

This version primarily involves bug fixes for some collectors and adjustments to Datakit main configuration.

### Breaking Changes {#cl-1.0.0-brk}

- Adopt a new version numbering mechanism. Version numbers like `v1.0.0-2002-g1fe9f870` will no longer be used, changing to `v1.2.3`.
- Move `datakit.conf` from top-level DataKit directory into `conf.d` directory.
- Move original `network/net.conf` into `host/net.conf`.
- Transfer original `pattern` directory to `pipeline` directory.
- Convert built-in Grok patterns (e.g., `%{space}`) to uppercase forms `%{SPACE}`. **All previously written Groks need to be fully replaced**.
- Remove `uuid` field from `datakit.conf`, store it separately in `.id` file for unified DataKit configuration management.
- Remove Ansible collector event data reporting.

### Bug Fixes {#cl-1.0.0-fix}

- Fix `prom` and `oraclemonitor` collectors not collecting data issues.
- Rename `self` collector's `hostname` field to `host` and place it in the tag.
- Fix `mysqlMonitor` concurrently collecting MySQL and MariaDB causing type conflict issues.
- Fix SkyWalking collector log splitting leading to full disk issues.

### Features {#cl-1.0.0-new}

- Add whitelist/blacklist functionality for collectors/hosts (no regex support currently).
- Restructure collectors for hosts, processes, containers, etc.
- Add Pipeline/Grok debugging tools.
- `-version` parameter shows current version and prompts online new version information and update commands.
- Support DDTrace data ingestion.
- Change `tailf` collector new log matching to forward matching.
- Other minor issue fixes.
- Support CPU data collection on Mac platforms.