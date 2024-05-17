
## Update History {#changelog}

### 1.4.0(2024/05/15) {#cl-1.4.0}

- Add a new Datakit metering API (#29).
- Fix the issue where data might be lost in the cache (#31).
- Support direct configuration of HTTP TLS certificates on the Dataway side (#32).
- Increase the exposure of additional metrics.

---

### 1.3.9(2024/03/28) {#cl-1.3.9}

- When the Sink discards a request, it should return an HTTP `406 Not Acceptable` error to facilitate troubleshooting (#82).

---

### 1.3.8(2024/01/24) {#cl-1.3.8}

- Export more Prometheus metrics
- Significantly enhance the performance of Sinker rule matching (#26)
---

### 1.3.7(2023/12/14) {#cl-1.3.7}

- Export more Prometheus metrics
- Optimize disk cache cleaning strategy, adhere to the principle of collecting and consuming data as soon as possible:
    - Prevent data from being actively discarded due to storage limits being exceeded.
    - At the same time, ensure that cached data is sent out as early as possible.
- Increase observability related to discarding of oversized requests (Metrics/Logs).
- Adjust the [Dataway's own POD yaml](https://static.guance.com/dataway/dataway.yaml) to improve its metrics and log collection.

---

### 1.3.6(2023/10/24) {#cl-1.3.6}

- Added Dataway [`sink` command](./dataway-sink.md#dw-sink-command)

---

### 1.3.5(2023/09/13) {#cl-1.3.5}

- Dataway installation via [environment variable](dataway.md#img-envs) injection is supported under Kubernetes
- Update [dataway.yaml](https://static.guance.com/dataway/dataway.yaml){:target="_blank"}

---

### 1.3.4(2023/09/01) {#cl-1.3.4}

- Upgrade Golang to 1.9
- Fixed the issue that the inner token has no data
- Adjust the following configuration in the default configuration:
    - Default API throttling increased to 100K
    - The default maximum Body is increased to 64MB
    - Added HTTP timeout setting (Dataway to Center), default 30s
    - Added configuration to ignore TLS 509 errors

### 1.3.3(2023/09/01) {#cl-1.3.3}

- Fixed image packaging 'curl' issue

---

### 1.3.2(2023/08/30) {#cl-1.3.2}

- Added 'curl' command to the image to make it easier to view its own indicators

---

### 1.3.1(2023/08/28) {#cl-1.3.1}

- Added Sinker functionality for URLs

---

### 1.3.0(2023/08/24) {#cl-1.3.0}

- Refactoring the entire Dataway implementation to add sinker functionality

---

### 1.2.12(2023/08/28) {#cl-1.2.12}

- Refactor the CI release process to achieve dual release of install scripts

---

### 1.2.8(2022/09/18) {#cl-1.2.8}

- /v1/wirte interface update:
    - Remove redundant /v1/write/xxx APIs and add /v1/write/:category interface
    - Write data is no longer line protocol decoded, but still body read for signature

- Disk cache:
    - When the sending center fails during cache cleanup, increase the consumption pause policy until the current cached request is sent successfully
    - Update the pbcache proto file
