# Release Note
---

<!--
[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) · [:octicons-beaker-24: Experimental](index.md#experimental)
[:fontawesome-solid-flag-checkered:](index.md#legends "支持选举")

    ```toml
        
    ```

# 外链的添加方式
[some text](http://external-host.com){:target="_blank"}

本次发布属于迭代发布，主要有如下更新：

### 新加功能 {#cl-1.4.19-new}
### 问题修复 {#cl-1.4.19-fix}
### 功能优化 {#cl-1.4.19-opt}
### 兼容调整 {#cl-1.4.19-brk}
-->

## 1.5.4(2022/12/29) {#cl-1.5.4}

### New Features {#cl-1.5.4-new}

- [confd support Nacos](confd.md)(#1315#1327)
- Add disk cache for logging(#1326)
- Session Replay for RUM(#1283)
- Remote update configures for WEB DCA(#1284)

### Fix {#cl-1.5.4-fix}

- Fix collect fail under K8s(#1362)
- Fix K8S Host field(#1351)
- Fix K8S Metrics Server timeout(#1353)
- Fix annotation configure under Containerd(#1352)
- Fix panic when Datakit reload(#1359)
- Fix Golang profiler calculate error on functions(#1335)
- Fix Datakit monitor character set(#1321)
- Fix async-profiler(#1290)
- Fix Redis slowlog(#1360)

### Optimization {#cl-1.5.4-opt}
- Optimize SQLServer too-many-metrics (#1358)
- Optimize Datakit monitor usage(1222)
