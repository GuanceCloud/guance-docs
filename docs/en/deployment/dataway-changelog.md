# Changelog

## 1.8.0 (2025/02/19) {#cl-1.8.0}

### New Features {#cl-1.8.0-new}

- In Sinker mode, Dataway supports processing data reporting requests sent by clients (such as Datakit/Function) simultaneously (#50)

---

## 1.7.0 (2024/12/18) {#cl-1.7.0}

### New Features {#cl-1.7.0-new}

- Added AWS Firehose integration entry (#47)
- Support passing token via `X-Token` (#43)

### Feature Enhancements {#cl-1.7.0-opt}

- Adjusted default parameters for internal recycling to optimize memory usage (#49)
- Optimized the default YAML in Kubernetes deployments and adjusted cache disk mount configurations (#48)
- Adjusted and added some internal metrics, updated Dataway's default view

---

## 1.6.2 (2024/12/03) {#cl-1.6.2}

### Feature Enhancements {#cl-1.6.2-opt}

- Added HTTP-level connection configuration options (#46)

---

## 1.6.1 (2024/11/19) {#cl-1.6.1}

### Feature Enhancements {#cl-1.6.1-opt}

- Added an option to disable the 404 page (#44)

---

## 1.6.0 (2024/09/19) {#cl-1.6.0}

### Feature Enhancements {#cl-1.6.0-opt}

- Optimized [environment variable configuration](dataway.md#env-diskcache) for disk cache
- Exposed more self-monitoring metrics and optimized memory usage in HTTP forwarding (#39)
- Dataway supports [configuring its own SNI](dataway.md#env-apis) (#42)
- Added a time synchronization interface to facilitate Datakit obtaining accurate Unix timestamps (#40)
- Sinker:
    - Filtering conditions support [`nil` checks](../datakit/datakit-filter.md#nil), i.e., checking if a specific field exists (#41)
    - Added [default rule settings](dataway-sink.md#default-rule), meaning requests that do not match existing routing rules will be routed to the workspace specified by the default rule (#30)

---

## 1.5.0 (2024/07/05) {#cl-1.5.0}

### Feature Enhancements {#cl-1.5.0-opt}

- Optimized installation scripts (#33)

### Compatibility Changes {#cl-1.5.0-brk}

- Removed direct support for Sinker configuration in host installation mode. This feature will be supported in future versions through new methods.

---

## 1.4.1 (2024/06/19) {#cl-1.4.1}

- Fixed the missing `DW_ENABLE_TLS` issue in Kubernetes installation mode
- Changed the build image URL

---

## 1.4.0 (2024/05/15) {#cl-1.4.0}

- Added Datakit metering interface (#29)
- Fixed potential cache data loss issues (#31)
- Supported configuring HTTP TLS certificates directly on the Dataway side (#32)
- Exposed more metrics

---

## 1.3.9 (2024/03/28) {#cl-1.3.9}

- When Sink discards requests, it returns an HTTP `406 Not Acceptable` error to help troubleshoot issues (#82)

---

## 1.3.8 (2024/01/24) {#cl-1.3.8}

- Exposed more metrics
- Significantly improved Sinker rule matching performance (#26)

---

## 1.3.7 (2023/12/14) {#cl-1.3.7}

- Exposed more metrics
- Optimized disk cache cleanup policies to adhere to the principle of consuming as soon as possible:
    - Avoid data being proactively discarded due to exceeding storage limits
    - Send cached data as early as possible
- Increased observability related to large request discards ([metrics/logs](dataway.md#too-large-request-body))
- Adjusted [Dataway POD yaml](https://static.<<< custom_key.brand_main_domain >>>/dataway/dataway.yaml) to improve metric and log collection

---

## 1.3.6 (2023/10/24) {#cl-1.3.6}

- Added Dataway `sink` [management commands](./dataway-sink.md#dw-sink-command)

---

## 1.3.5 (2023/09/13) {#cl-1.3.5}

- Supports installing Dataway via [environment variables](dataway.md#img-envs) in Kubernetes
- Released a new [dataway.yaml](https://static.<<< custom_key.brand_main_domain >>>/dataway/dataway.yaml){:target="_blank"}

---

## 1.3.4 (2023/09/01) {#cl-1.3.4}

- Upgraded Golang to version 1.9
- Fixed inner token data issue
- Adjusted the following default configurations:
    - Increased default API rate limit to 100K
    - Increased default maximum Body size to 64MB
    - Added HTTP timeout settings (from Dataway to center), default 30s
    - Added configuration to ignore TLS 509 errors

## 1.3.3 (2023/09/01) {#cl-1.3.3}

- Fixed the `curl` issue in the image packaging

---

## 1.3.2 (2023/08/30) {#cl-1.3.2}

- Added the `curl` command in the image to facilitate viewing self-monitoring metrics

---

## 1.3.1 (2023/08/28) {#cl-1.3.1}

- Added URL-based Sinker functionality

---

## 1.3.0 (2023/08/24) {#cl-1.3.0}

- Restructured the entire Dataway implementation and added Sinker functionality

---

## 1.2.12 (2023/08/28) {#cl-1.2.12}

- Restructured the CI release process to achieve dual-release of install scripts

---

## 1.2.8 (2022/09/18) {#cl-1.2.8}

- /v1/write API updates:
    - Removed redundant /v1/write/xxx APIs and added /v1/write/:category API
    - Write data no longer performs line protocol decoding but still reads the Body for signing

- Disk cache:
    - Added a consumption pause strategy during cache cleanup until the current cached request is successfully sent before cleaning the next cache
    - Updated pbcache proto file