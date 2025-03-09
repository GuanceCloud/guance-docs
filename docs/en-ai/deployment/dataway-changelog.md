# Changelog

## 1.8.0 (2025/02/19)

### New Features

- In Sinker mode, Dataway supports processing data reporting requests sent by clients (such as Datakit/Function) simultaneously (#50)

---

## 1.7.0 (2024/12/18)

### New Features

- Added an AWS Firehose integration entry (#47)
- Supports passing tokens via `X-Token` (#43)

### Feature Enhancements

- Adjusted default parameters for internal reclamation to optimize memory usage (#49)
- Optimized the default YAML in Kubernetes deployments and adjusted its cache disk mount configuration (#48)
- Adjusted and added some internal metrics, updating the default Dataway view

---

## 1.6.2 (2024/12/03)

### Feature Enhancements

- Added HTTP connection configuration options (#46)

---

## 1.6.1 (2024/11/19)

### Feature Enhancements

- Added an option to disable the 404 page (#44)

---

## 1.6.0 (2024/09/19)

### Feature Enhancements

- Optimized [environment variable configuration](dataway.md#env-diskcache) for disk caching
- Exposed more internal metrics and optimized memory usage in HTTP forwarding (#39)
- Dataway supports configuring [its own SNI](dataway.md#env-apis) (#42)
- Added a time synchronization interface to help Datakit obtain more accurate Unix timestamps (#40)
- Sinker:
    - Filter conditions support [`nil` checks](../datakit/datakit-filter.md#nil), i.e., determining whether a specific field exists (#41)
    - Added [default rule settings](dataway-sink.md#default-rule), which route requests not matching existing分流 rules to the corresponding workspace (#30)

---

## 1.5.0 (2024/07/05)

### Feature Enhancements

- Optimized installation scripts (#33)

### Compatibility Changes

- Removed direct support for Sinker configuration in host installation mode. This feature will be supported through new methods in future versions.

---

## 1.4.1 (2024/06/19)

- Fixed the missing `DW_ENABLE_TLS` issue in Kubernetes installation mode
- Changed the build image URL

---

## 1.4.0 (2024/05/15)

- Added a Datakit metering interface (#29)
- Fixed potential data loss issues in cache (#31)
- Supported configuring HTTP TLS certificates directly on the Dataway side (#32)
- Exposed more metrics

---

## 1.3.9 (2024/03/28)

- When Sink discards requests, it now returns an HTTP `406 Not Acceptable` error to aid in troubleshooting (#82)

---

## 1.3.8 (2024/01/24)

- Exposed more metrics
- Significantly improved Sinker rule matching performance (#26)

---

## 1.3.7 (2023/12/14)

- Exposed more metrics
- Optimized disk cache cleanup policies to adhere to the principle of consuming data as soon as possible:
    - Avoid data being proactively discarded due to exceeding storage limits
    - Send cached data as early as possible
- Added observability for oversized request discards ([metrics/logs](dataway.md#too-large-request-body))
- Adjusted [Dataway POD yaml](https://<<< custom_key.static_domain >>>/dataway/dataway.yaml), enhancing metric and log collection

---

## 1.3.6 (2023/10/24)

- Added Dataway `sink` [management commands](./dataway-sink.md#dw-sink-command)

---

## 1.3.5 (2023/09/13)

- Supports installing Dataway via [environment variables](dataway.md#img-envs) in Kubernetes
- Released a new [dataway.yaml](https://<<< custom_key.static_domain >>>/dataway/dataway.yaml){:target="_blank"}

---

## 1.3.4 (2023/09/01)

- Upgraded Golang to version 1.9
- Fixed the issue of no data for inner tokens
- Default configurations were adjusted as follows:
    - Increased default API rate limiting to 100K
    - Increased default maximum Body size to 64MB
    - Added HTTP timeout settings (from Dataway to central), defaulting to 30s
    - Added configuration to ignore TLS 509 errors

## 1.3.3 (2023/09/01)

- Fixed the `curl` packaging issue in the image

---

## 1.3.2 (2023/08/30)

- Added the `curl` command to the image for easier viewing of internal metrics

---

## 1.3.1 (2023/08/28)

- Added URL-based Sinker functionality

---

## 1.3.0 (2023/08/24)

- Restructured the entire Dataway implementation, adding Sinker functionality

---

## 1.2.12 (2023/08/28)

- Restructured the CI release process to achieve dual-release of install scripts

---

## 1.2.8 (2022/09/18)

- /v1/write interface updates:
    - Removed redundant /v1/write/xxx APIs, added /v1/write/:category interface
    - Write operations no longer perform line protocol decoding but still read the Body for signing

- Disk Cache:
    - When the central server fails during cache cleanup, added a pause strategy until the current cached request is successfully sent before cleaning up the next cache
    - Updated pbcache proto file