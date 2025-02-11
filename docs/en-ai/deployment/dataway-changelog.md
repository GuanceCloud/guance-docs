# Changelog

## 1.7.0 (2024/12/18)

### New Features

- Added AWS Firehose integration entry (#47)
- Supported passing token via `X-Token` (#43)

### Functional Improvements

- Adjusted default parameters for internal reclamation to optimize memory usage (#49)
- Optimized the default YAML in Kubernetes deployment, adjusting its cache disk mount configuration (#48)
- Adjusted and added some internal metrics, updating Dataway's default view

---

## 1.6.2 (2024/12/03)

### Functional Improvements

- Added HTTP-level connection configuration entry (#46)

---

## 1.6.1 (2024/11/19)

### Functional Improvements

- Added an option to disable the 404 page (#44)

---

## 1.6.0 (2024/09/19)

### Functional Improvements

- Optimized environment variable configurations related to disk caching [Environment Variable Configuration](dataway.md#env-diskcache)
- Increased exposure of more self-metrics and optimized memory usage at the HTTP forwarding level (#39)
- Dataway supports configuring its own SNI [Environment Variable Configuration](dataway.md#env-apis) (#42)
- Added a time synchronization interface to facilitate Datakit obtaining a more accurate Unix timestamp (#40)
- Sinker:
    - Filtering conditions support [`nil` checks](../datakit/datakit-filter.md#nil), i.e., determining whether a specific field exists (#41)
    - Added [default rule settings](dataway-sink.md#default-rule), i.e., requests that do not match existing分流 rules will be routed to the workspace corresponding to this default rule (#30)

---

## 1.5.0 (2024/07/05)

### Functional Improvements

- Optimized installation script (#33)

### Compatibility Changes

- The new version has removed direct support for Sinker configuration under host installation mode. This feature will be supported in a new way in the future.

---

## 1.4.1 (2024/06/19)

- Fixed the missing `DW_ENABLE_TLS` issue in Kubernetes installation mode
- Changed build image address

---

## 1.4.0 (2024/05/15)

- Added Datakit metering interface (#29)
- Fixed a potential data loss issue with cache (#31)
- Supported direct configuration of HTTP TLS certificates on the Dataway side (#32)
- Increased exposure of more metrics

---

## 1.3.9 (2024/03/28)

- When Sink discards requests, it now returns an HTTP `406 Not Acceptable` error to facilitate troubleshooting (#82)

---

## 1.3.8 (2024/01/24)

- Added exposure of more metrics
- Significantly improved Sinker rule matching performance (#26)

---

## 1.3.7 (2023/12/14)

- Added exposure of more metrics
- Optimized disk cache cleanup strategy, adhering to the principle of rapid consumption:
    - Avoid data being actively discarded due to exceeding storage limits
    - Send cached data as soon as possible
- Increased observability related to oversized request discarding ([metrics/logs](dataway.md#too-large-request-body))
- Adjusted [Dataway's own POD YAML](https://static.guance.com/dataway/dataway.yaml) to improve metric and log collection

---

## 1.3.6 (2023/10/24)

- Added Dataway `sink` [management commands](./dataway-sink.md#dw-sink-command)

---

## 1.3.5 (2023/09/13)

- Supported injecting Dataway through [environment variables](dataway.md#img-envs) in Kubernetes
- Released a new [dataway.yaml](https://static.guance.com/dataway/dataway.yaml){:target="_blank"}

---

## 1.3.4 (2023/09/01)

- Upgraded Golang to 1.9
- Fixed the issue of no data for inner token
- Adjusted the following configurations in the default configuration:
    - Increased default API rate limiting to 100K
    - Increased default maximum Body size to 64MB
    - Added HTTP timeout setting (from Dataway to center), default 30s
    - Added configuration to ignore TLS 509 errors

## 1.3.3 (2023/09/01)

- Fixed the `curl` issue in the image packaging

---

## 1.3.2 (2023/08/30)

- Added the `curl` command in the image to facilitate viewing self-metrics

---

## 1.3.1 (2023/08/28)

- Added URL Sinker functionality

---

## 1.3.0 (2023/08/24)

- Restructured the entire Dataway implementation, adding Sinker functionality

---

## 1.2.12 (2023/08/28)

- Restructured CI release process to achieve dual-release of install scripts

---

## 1.2.8 (2022/09/18)

- Updated /v1/write interface:
    - Removed redundant /v1/write/xxx APIs, added /v1/write/:category interface
    - Write data no longer decodes line protocol but still reads the Body for signing

- Disk Cache:
    - When cache cleanup fails to send to the center, added a pause consumption strategy until the current cached request is successfully sent before cleaning up the next cache
    - Updated pbcache proto file