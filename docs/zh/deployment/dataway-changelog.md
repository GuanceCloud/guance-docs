
## 更新历史 {#changelog}

### 1.3.5(2023/09/13) {#cl-1.3.5}

- Kubernetes 下支持通过[环境变量](dataway.md#img-envs)注入来安装 Dataway
- 新发布了 [dataway.yaml](https://static.guance.com/dataway/dataway.yaml){:target="_blank"}

---

### 1.3.4(2023/09/01) {#cl-1.3.4}

- 升级 Golang 到 1.9
- 修复 inner token 无数据问题
- 默认配置中调整如下配置：
    - 默认 API 限流增加到 100K
    - 默认最大 Body 增加到 64MB
    - 新增 HTTP 超时设置（Dataway 到中心），默认 30s
    - 新增配置以忽略 TLS 509 报错

### 1.3.3(2023/09/01) {#cl-1.3.3}

- 修复镜像打包 `curl` 问题

---

### 1.3.2(2023/08/30) {#cl-1.3.2}

- 镜像中增加 `curl` 命令，便于查看自身指标

---

### 1.3.1(2023/08/28) {#cl-1.3.1}

- 增加 URL 的 Sinker 功能

---

### 1.3.0(2023/08/24) {#cl-1.3.0}

- 重构整个 Dataway 实现，增加 Sinker 功能

---

### 1.2.12(2023/08/28) {#cl-1.2.12}

- 重构 CI 发布流程，实现 install 脚本双发布

---

### 1.2.8(2022/09/18) {#cl-1.2.8}

- /v1/wirte 接口更新：
    - 移除冗余的 /v1/write/xxx API，增加 /v1/write/:category 接口
    - 写入数据不再进行行协议解码，但仍然进行 Body 读取，用于签名

- 磁盘缓存：
    - 当缓存清理过程中发送中心失败，增加消费暂停策略，直到当前缓存的请求发送成功才清理下一个缓存
    - 更新 pbcache proto 文件