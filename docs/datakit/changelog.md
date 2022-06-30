# DataKit 版本历史
---

## 1.4.4(2022/06/27) {#cl-1.4.4}

本次发布属于 Hotfix 发布，主要更新如下内容：

- 修复日志采集因 pos 处理不当导的不采集问题，该问题自 1.4.2 引入，**建议升级** (#873)
- 修复 TDEngine 可能导致的 crash 问题
- 优化 eBPF 数据发送流程，避免积攒过多消耗太多内存导致 OOM(#871)
- 修复采集器文档错误

---

## 1.4.3(2022/06/22) {#cl-1.4.3}

本次发布属于迭代发布，主要更新如下内容：

- gitrepo 支持无密码模式(#845)
- prom 采集器
    - 支持日志模式采集(#844)
    - 支持配置 HTTP 请求头(#832)
- 支持超 16KB 长度的容器日志采集(#836)
- 支持 TDEngine 采集器(810)
- Pipeline
    - 支持 XML 解析(#804)
    - 远程调试支持多类数据类型(#833)
    - 支持 Pipeline 通过 `use()` 函数调用外部 Pipeline 脚本(#824)
- 新增 IP 库（MaxMindIP）支持(#799)
- 新增 DDTrace Profile 集成(#656)
- Containerd 日志采集支持通过 image 和 K8s Annotation 配置过滤规则(#849)
- 文档库整体切换到 MkDocs(#745)
- 其它杂项(#822)

### Bug 修复 {#cl-1.4.3-bugfix}

- 修复 socket 采集器奔溃问题(#858)
- 修复部分采集器配置中空 tags 配置导致的奔溃问题(#852)
- 修复 ipdb 更新命令问题(#854)
- Kubernetes Pod 日志和对象上增加 `pod_ip` 字段(848)
- DDTrace 采集器恢复识别 trace SDK 上的采样设定(#834)
- 修复 DaemonSet 模式下，外部采集器（eBPF/Oracle）上的 `host` 字段可能跟 DataKit 自身不一致的问题(#843)
- 修复 stdout 多行日志采集问题(#859)
---

## 1.4.2(2022/06/16)

本次发布属于迭代发布，主要更新如下内容：

- 日志采集支持记录采集位置，避免因为 DataKit 重启等情况导致的数据漏采(#812)
- 调整 Pipeline 在处理不同类数据时的设定(#806)
- 支持接收 SkyWalking 指标数据(#780)
- 优化日志黑名单调试功能：
    - 在 Monitor 中会展示被过滤掉的点数(#827)
    - 在 datakit/data 目录下会增加一个 *.filter* 文件，用来记录拉取到的过滤器
- Monitor 中增加 DataKit 打开文件数显示(#828)
- DataKit 编译器升级到 golang 1.18.3(#674)

### Bug 修复

- 修复 `ENV_K8S_NODE_NAME` 未全局生效的问题(#840)
- 修复日志采集器中文件描述符泄露问题，**强烈推荐升级**(#838)
- 修复 Pipeline `group_in` 问题(#826)
- 修复 ElasticSearch 采集器配置的 `http_timeout` 解析问题(#821)
- 修复 DCA API 问题(#747)
- 修复 `dev_null` DataWay 设置无效问题(#842)

----

## 1.4.1(2022/06/07)

本次发布属于迭代发布，主要更新如下内容：

- 修复 toml 配置文件兼容性问题(#195)
- 增加 [TCP/UDP 端口检测](socket)采集器(#743)
- DataKit 跟 DataWay 之间增加 DNS 检测，支持 DataWay DNS 动态切换(#758)
- [eBPF](ebpf) L4/L7 流量数据增加 k8s deployment name 字段(#793)
- 优化 [OpenTelemetry](opentelemetry) 指标数据(#794)
- [ElasticSearch](elasticsearch) 增加 AWS OpenSearch 支持(#797)
- [行协议限制](apis#2fc2526a)中，字符串长度限制放宽到 32MB(#801)
- [prom](prom) 采集器增加额外配置，支持忽略指定的 tag=value 的匹配，以减少不必要的时序时间线(#808)
- Sink 增加 Jaeger 支持(#813)
- Kubernetes 相关的[指标](container#7e687515)采集，默认全部关闭，以避免时间线暴增问题(#807)
- [DataKit Monitor](monitor)增加动态发现（比如 prom）的采集器列表刷新(#711)

### Bug 修复
- 修复默认 Pipeline 加载问题(#796)
- 修复 Pipeline 中关于日志 status 的处理(#800)
- 修复 [Filebeat](beats_output) 奔溃问题(#805)
- 修复 [logstreaming](logstreaming) 导致的脏数据问题(#802)

----

## 1.4.0(2022/05/26)

本次发布属于迭代发布， 次版本号进入 1.4 序列。主要更新如下内容：

- Pipeline 做了很大调整(#761)
    - 所有数据类型，均可通过配置 Pipeline 来额外处理数据(#761/#739)
    - [grok()](pipeline#965ead3c) 支持直接将字段提取为指定类型，无需再额外通过 `cast()` 函数进行类型转换(#760)
    - Pipeline 增加[多行字符串支持](pipeline#3ab24547)，对于很长的字符串（比如 grok 中的正则切割），可以通过将它们写成多行，提升了可读性(#744)
    - 每个 Pipeline 的运行情况，通过 datakit monitor -V 可直接查看(#701)
- 增加 Kubernetes [Pod 对象](container#23ae0855-1) CPU/内存指标(#770)
- Helm 增加更多 Kubernetes 版本安装适配(#783)
- 优化 [OpenTelemetry](opentelemetry)，HTTP 协议增加 JSON 支持(#781)
- DataKit 在自动纠错行协议时，对纠错行为增加了日志记录，便于调试数据问题(#777)
- 移除时序类数据中的所有字符串指标(#773)
- 在 DaemonSet 安装中，如果配置了[选举](election)的命名空间，对参与选举的采集器，其数据上均会新增特定的 tag（`election_namespace`）(#743)
- CI 可观测，增加 [Jenkins](jenkins) 支持(#729)

### Bug 修复

- 修复 monitor 中 DataWay 统计错误(#785)
- 修复日志采集器相关 bug(#783)
    - 有一定概率，日志采集会导致脏数据串流的情况
    - 在文件日志采集的场景下（磁盘文件/容器日志/logfwd），修复被采集日志因为 truncate/rename/remove 等因素导致的采集不稳定问题（丢失数据）
- 其它 Bug 修复(#790)

----

## 1.2.20(2022/05/22) {#cl-1.2.20}

本次发布属于 hotfix 发布，主要修复如下问题：

- 日志采集功能优化(#775)
    - 去掉 32KB 限制（保留 32MB 最大限制）(#776)
    - 修复可能丢失头部日志的问题
    - 对于新创建的日志，默认从头开始采集（主要是容器类日志，磁盘文件类日志目前无法判定是否是新创建的日志）
    - 优化 Docker 日志处理，不再依赖 Docker 日志 API

- 修复 Pipeline 中的 [decode](pipeline#837c4e09) 函数问题(#769)
- OpenTelemetry gRPC 方式支持 gzip(#774)
- 修复 [filebeat](beats_output) 采集器不能设置 service 的问题(#767)

## Breaking changes

对于 Docker 类容器日志的采集，需要将宿主机（Node）的 */varl/lib* 路径挂载到 DataKit 里面（因为 Docker 日志默认落在宿主机的 */var/lib/* 下面），在 *datakit.yaml* 中，`volumeMounts` 和 `volumes` 中新增如下配置：

```yaml
volumeMounts:
- mountPath: /var/lib
  name: lib

# 省略其它部分...

volumes:
- hostPath:
    path: /var/lib
  name: lib
```

----

## 1.2.19(2022/05/12) {#cl-1.2.19}

本次发布属于迭代发布，主要更新如下内容：

- eBPF 增加 arm64 支持(#662)
- 行协议构造支持自动纠错(#710)
- DataKit 主配置增加示例配置(#715)
- [Prometheus Remote Write](prom_remote_write) 支持 tag 重命名(#731)
- 修复 DCA 客户端获取工作空间不全的问题(#747)
- 合并社区版 DataKit 已有的功能，主要包含 Sinker 功能以及 [filebeat](beats_output) 采集器(#754)
- 调整容器日志采集，DataKit 直接支持 containerd 下容器 stdout/stderr 日志采集(#756)
- 修复 ElasticSearch 采集器超时问题(#762)
- 修复安装程序检查过于严格的问题(#763)
- 调整 DaemonSet 模式下主机名获取策略(#648)
- Trace 采集器支持通过服务名（`service`）通配来过滤资源（`resource`）(#759)
- 其它一些细节问题修复

----

## 1.2.18(2022/05/06)

本次发布属于 hotfix 发布，主要修复如下问题：

- [进程采集器](host_processes)的过滤功能仅作用于指标采集，对象采集不受影响(#740)
- 缓解 DataKit 发送 DataWay 超时问题(#741)
- [Gitlab 采集器](gitlab) 稍作调整(#742)
- 修复日志采集截断的问题(#749)
- 修复各种 trace 采集器 reload 后部分配置不生效的问题(#750)

----

## 1.2.17(2022/04/27)

本次发布属于迭代发布，主要涉及如下几个方面：

- [容器采集器](container#7e687515)增加更多指标（`kube_` 开头）采集(#668)
- DDTrace 和 OpenTelemetry 采集器支持通过 HTTP Status Code（`omit_err_status`）来过滤部分错误的 trace
- 修复几个 Trace 采集器（DDtrace/OpenTelemetry/Zipkin/SkyWalking/Jaeger）在 git 模式下配置 reload 不生效的问题(#725)
- 修复 Gitlab 采集器不能 tag 导致的奔溃问题(#730)
- 修复 Kubernetes 下 eBPF 采集器对 Pod 标签（tag）不更新的问题(#736)
- [prom 采集器](prom) 支持 [Tag 重命名](prom#e42139cb)(#719)
- 完善部分文档描述

----

## 1.2.16(2022/04/24)

本次发布属于 hotfix 修复，主要涉及如下几个方面(#728)：

- 修复安装程序可能的报错导致无法继续安装/升级，目前选择容忍部分情况的服务操作错误
- 修复 Windows 安装脚本的拼写错误，该错误导致 32 位安装程序下载失败
- 调整 Monitor 关于选举情况的展示
- 开启选举的情况下，修复 MongoDB 死循环导致无法采集的问题

----

## 1.2.15(2022/04/21)

本次发布属于迭代发布，含大量问题修复：

- Pipeline 模块修复 Grok 中[动态多行 pattern](datakit-pl-how-to#88b72768) 问题(#720)
- 移除掉一些不必要的 DataKit 事件日志上报(#704)
- 修复升级程序可能导致的升级失败问题(#699)
- DaemonSet 增加[开启 pprof 环境变量](datakit-daemonset-deploy#cc08ec8c)配置(#697)
- DaemonSet 中所有[默认开启采集器](datakit-input-conf#764ffbc2)各个配置均支持通过环境变量配置(#693)
- Tracing 采集器初步支持 Pipeline 数据处理(#675)
    - [DDtrace 配置示例](ddtrace#69995abe)
- 拨测采集器增加失败任务退出机制(#54)
- 优化 [Helm 安装](datakit-daemonset-deploy#e4d3facf)(#695)
- 日志新增 `unknown` 等级（status），对于未指定等级的日志均为 `unknown`(#685)
- 容器采集器大量修复
    - 修复 cluster 字段命名问题(#542)
    - 对象 `kubernetes_clusters` 这个指标集改名为 `kubernetes_cluster_roles`
    - 原 `kubernetes.cluster` 这个 count 改名为 `kubernetes.cluster_role`
    - 修复 namespace 字段命名问题(#724)
    - 容器日志采集中，如果 Pod Annotation 不指定日志 `source`，那么 DataKit 将按照[此优先级来推导日志来源](container#6de978c3)(#708/#723)
    - 对象上报不再受 32KB 字长限制（因 Annotation 内容超 32KB）(#709)
	  - 所有 Kubernetes 对象均删除 `annotation` 这一 field
    - 修复 prom 采集器不会随 Pod 退出而停止的问题(#716)
- 其它问题修复(#721)

---

## 1.2.14(2022/04/12)

本次发布属于 hotfix 发布，同时包含部分小的修改和调整：

- 修复日志采集器的 monitor 展示问题以及部分出错日志等级调整(#706)
- 修复拨测采集器内存泄露问题(#702)
- 修复主机进程采集器奔溃问题(#700)
- 日志采集器采集选项 `ignore_dead_log = '10m'` 默认开启(#698)
- 优化 Git 管理的配置同步逻辑(#696)
- eBPF 修复 netflow 中错误的 ip 协议字段(#694)
- 丰富 Gitlab 采集器字段

---

## 1.2.13(2022/04/08)

本次发布属于迭代发布，更新内容如下：

- 增加宿主机运行时的[内存限制](datakit-conf#4e7ff8f3)(#641)
    - 安装阶段即支持[内存限制配置](datakit-install#03be369a)
- CPU 采集器增加 [load5s 指标](cpu#13e60209)(#606)
- 完善 datakit.yaml 示例(#678)
- 支持主机安装时通过 [cgroup 限制内存](datakit-conf#4e7ff8f3)使用(#641)
- 完善日志黑名单功能，新增 contain/notcontain 判定规则(#665)
    - 支持在 datakit.conf 中[配置日志/对象/Tracing/时序指标这几类黑名单](datakit-filter#045b45e3)
	- 注意：升级该版本，要求 DataWay 升级到 1.2.1+
- 进一步完善 [containerd 下的容器采集](container)(#402)
- 调整 monitor 布局，增加黑名单过滤情况展示(#634)
- DaemonSet 安装增加 [Helm 支持](datakit-daemonset-deploy)(#653)
    - 新增 [DaemonSet 安装最佳实践](datakit-daemonset-bp)(#673)
- 完善 [Gitlab 采集器](gitlab)(#661)
- 增加 [ulimit 配置项](datakit-conf#8f9f4364)用于配置文件打开数限制(#667)
- Pipeline [脱敏函数](pipeline#52a4c41c)有更新，新增 [SQL 脱敏函数](pipeline#711d6fe4)(#670)
- 进程对象和时序指标[新增 `cpu_usage_top` 字段](host_processes#a30fc2c1-1)，以跟 `top` 命令的结果对应(#621)
- eBPF 增加 [HTTP 协议采集](ebpf#905896c5)(#563)
- 主机安装时，eBPF 采集器默认不再会安装（减少二进制分发体积），如需安装[需用特定的安装指令](ebpf#852abae7)(#605)
    - DaemonSet 安装不受影响
- 其它 Bug 修复（#688/#681/#679/#680）

---

## 1.2.12(2022/03/24)

本次发布属于迭代发布，更新内容如下：

1. 增加 [DataKit 命令行补全](datakit-tools-how-to#9e4e5d5f)功能(#76)
1. 允许 DataKit [升级到非稳定版](datakit-update#42d8b0e4)(#639)
1. 调整 Remote Pipeline 的在 DataKit 本地的存储，避免不同文件系统差异导致的文件名大小写问题(#649)
1. (Alpha)初步支持 [Kubernetes/Containerd 架构的数据采集](container#b3edf30c)(#402)
1. 修复 Redis 采集器的不合理报错(#671) 
1. OpenTelemetry 采集器字段微调(#672)
1. 修复 [DataKit 自身采集器](self) CPU 计算错误(#664)
1. 修复 RUM 采集器因 IPDB 缺失导致的 IP 关联字段缺失问题(#652)
1. Pipeline 支持调试数据上传至 OSS(#650)
1. DataKit HTTP API 上均会[带上 DataKit 版本号信息](apis#be896a47)
1. [网络拨测](dialtesting)增加 TCP/UDP/ICMP/Websocket 几种协议支持(#519)
1. 修复[主机对象采集器](hostobject)字段超长问题(#669)
1. Pipeline
    - 新增 [decode()](pipeline#837c4e09) 函数(#559)，这样可以避免在日志采集器中去配置编码，可以在 Pipeline 中实现编码转换
    - 修复 Pipeline 导入 pattern 文件可能失败的问题(#666)
    - [add_pattern()](pipeline#89bd3d4e) 增加作用域管理

---

## 1.2.11(2022/03/17)

本次发布属于 hotfix 发布，同时包含部分小的修改和调整：

- 修复 Tracing 采集器资源过滤（`close_resource`）的算法问题，将过滤机制下放到 Entry Span 级别，而非之前的 Root Span
- 修复[日志采集器](logging)文件句柄泄露问题(#658)，同时新增配置（`ignore_dead_log`），以忽略不再更新（删除）的文件
- 新增[DataKit 自身指标文档](self)
- DaemonSet 安装时
    - [支持安装 IPDB](datakit-tools-how-to#11f01544)(#659)
    - 支持[设定 HTTP 限流（ENV_REQUEST_RATE_LIMIT）](datakit-daemonset-deploy#00c8a780)(#654)

---

## 1.2.10(2022/03/11)

修复 Tracing 相关采集器可能的奔溃问题

---

## 1.2.9(2022/03/10)

本次发布属于迭代发布，更新内容如下：

- DataKit 9529 HTTP 服务添加 [API 限流措施](datakit-conf#39e48d64)(#637)
- 统一各种 Tracing 数据的[采样率设置](datakit-tracing#64df2902)(#631)
- 发布 [DataKit 日志采集综述](datakit-logging)
- 支持 [OpenTelemetry 数据接入](opentelemetry)(#609)
- 支持[禁用 Pod 内部部分镜像的日志](container#2a6149d7)(#586)
- 进程对象采集[增加监听端口列表](host_processes#a30fc2c1-1)(#562)
- eBPF 采集器[支持 Kubernetes 字段关联](ebpf#35c97cc9)(#511)

### Breaking Changes

- 本次对 Tracing 数据采集做了较大的调整，涉及几个方面的不兼容：

    - [DDtrace](ddtrace) 原有 conf 中配置的 `ignore_resources` 字段需改成 `close_resource`，且字段类型由原来的数组（`[...]`）形式改成了字典数组（`map[string][...]`）形式（可参照 [conf.sample](ddtrace#69995abe) 来配置）
    - DDTrace 原数据中采集的 [tag `type` 字段改成 `source_type`](ddtrace#01b88adb)

---

## 1.2.8(2022/03/04) {#cl-1.2.8}

本次发布属于 hotfix 修复，内容如下：

- DaemonSet 模式部署时， datakit.yaml 添加[污点容忍度配置](datakit-daemonset-deploy#e29e678e)(#635)
- 修复 Remote Pipeline 拉取更新时的 bug(#630)
- 修复 DataKit IO 模块卡死导致的内存泄露(#646)
- 在 Pipeline 中允许修改 `service` 字段(#645)
- 修复 `pod_namespace` 拼写错误
- 修复 logfwd 的一些问题(#640)
- 修复日志采集器在容器环境下采集时多行粘滞问题(#633)

---

## 1.2.7(2022/02/22) {#cl-1.2.7}

本次发布属于迭代发布，内容如下：

- Pipeline
    - Grok 中增加[动态多行 pattern](datakit-pl-how-to#88b72768)，便于处理动态多行切割(#615)
    - 支持中心下发 Pipeline(#524)，这样一来，Pipeline 将有[三种存放路径](pipeline#6ee232b2)
    - DataKit HTTP API 增加 Pipeline 调试接口 [/v1/pipeline/debug](apis#539fb60e)

<!--
- APM 功能调整(#610)
	- 重构现有常见的 Tracing 数据接入
	- 增加 APM 指标计算
	- 新增 [otel(OpenTelemetry)数据接入]()

!!! Delay
-->

- 为减少默认安装包体积，默认安装不再带 IP 地理信息库。RUM 等采集器中，可额外[安装对应的 IP 库](datakit-tools-how-to#ab5cd5ad)
    - 如需安装时就带上 IP 地理信息库，可通过[额外支持的命令行环境变量](datakit-install#f9858758)来实现
- 容器采集器增加 [logfwd 日志接入](logfwd)(#600)
- 为进一步规范数据上传，行协议增加了更多严格的[限制](apis#2fc2526a)(#592)
- [日志采集器](logging)中，放开日志长度限制（`maximum_length`）(#623)
- 优化日志采集过程中的 Monitor 显示(#587)
- 优化安装程序的命令行参数检查(#573)
- 重新调整 DataKit 命令行参数，大部分主要的命令已经支持。另外，**老的命令行参数在一定时间内依然生效**(#499)
    - 可通过 `datakit help` 查看新的命令行参数风格
- 重新实现 [ DataKit Monitor](datakit-monitor)

### 其它 Bug 修复

- 修复 Windows 下安装脚本问题(#617)
- 调整 datakit.yaml 中的 ConfigMap 设定(#603)
- 修复 Git 模式下 Reload 导致部分 HTTP 服务异常的问题(#596)
- 修复安装包 isp 文件丢失问题(#584/#585/#560)
- 修复 Pod annotation 中日志多行匹配不生效的问题(#620)
- 修复 TCP/UDP 日志采集器 _service_ tag 不生效的问题(#610)
- 修复 Oracle 采集器采集不到数据的问题(#625)

### Breaking Changes

- 老版本的 DataKit 如果开启了 RUM 功能，升级上来后，需[重新安装 IP 库](datakit-tools-how-to#ab5cd5ad)，老版本的 IP 库将无法使用。

---

## 1.2.6(2022/01/20)

本次发布属于迭代发布，内容如下：

- 增强 [DataKit API 安全访问控制](rum#b896ec48)，老版本的 DataKit 如果部署了 RUM 功能，建议升级(#578)
- 增加更多 DataKit 内部事件日志上报(#527)
- 查看 [DataKit 运行状态](datakit-tools-how-to#44462aae)不再会超时(#555)

- [容器采集器](container)一些细节问题修复

    - 修复在 Kubernetes 环境主机部署时崩溃问题(#576)
    - 提升 Annotation 采集配置优先级(#553)
    - 容器日志支持多行处理(#552)
    - Kubernetes Node 对象增加 _role_ 字段(#549)
    - [通过 Annotation 标注](kubernetes-prom)的 [Prom 采集器](prom) 会自动增加相关属性（_pod_name/node_name/namespace_）(#522/#443)
    - 其它 Bug 修复

- Pipeline 问题修复

    - 修复日志处理中可能导致的时间乱序问题(#547)
    - 支持 _if/else_ 语句[复杂逻辑关系判断支持](pipeline#1ea7e5aa)

- 修复日志采集器 Windows 中路径问题(#423)
- 完善 DataKit 服务管理，优化交互提示(#535)
- 优化现有 DataKit 文档导出的指标单位(#531)
- 提升工程质量(#515/#528)

---

## 1.2.5(2022/01/19)

- 修复[Log Stream 采集器](logstreaming) Pipeline 配置问题(#569)
- 修复[容器采集器](container)日志错乱的问题(#571)
- 修复 Pipeline 模块更新逻辑的 bug(#572)

---

## 1.2.4(2022/01/12)

- 修复日志 API 接口指标丢失问题(#551)
- 修复 [eBPF](ebpf) 网络流量统计部分丢失问题(#556)
- 修复采集器配置文件中 `$` 字符通配问题(#550)
- Pipeline _if_ 语句支持空值比较，便于 Grok 切割判断(#538)

---

## 1.2.3(2022/01/10)

- 修复 datakit.yaml 格式错误问题(#544)
- 修复 [MySQL 采集器](mysql)选举问题(#543)
- 修复因 Pipeline 不配置导致日志不采集的问题(#546)

---

## 1.2.2(2022/01/07)

- [容器采集器](container)更新：
    - 修复日志处理效率问题(#540)
    - 优化配置文件黑白名单配置(#536)
- Pipeline 模块增加 `datakit -M` 指标暴露(#541)
- [ClickHouse](clickhousev1) 采集器 config-sample 问题修复(#539)
- [Kafka](kafka) 指标采集优化(#534)

---

## 1.2.1(2022/01/05)

- 修复采集器 Pipeline 使用问题(#529)
- 完善[容器采集器](container)数据问题(#532/#530)
    - 修复 short-image 采集问题
    - 完善 k8s 环境下 Deployment/Replica-Set 关联

---

## 1.2.0(2021/12/30) {#cl-1.2.0}

### 采集器更新

- 重构 Kubernetes 云原生采集器，将其整合进[容器采集器](container.md)。原有 Kubernetes 采集器不再生效(#492)
- [Redis 采集器](redis.md)
    - 支持配置 [Redis 用户名](redis.md)(#260)
    - 增加 Latency 以及 Cluster 指标集(#396)
- [Kafka 采集器](kafka)增强，支持 topic/broker/consumer/connnetion 等维度的指标(#397)
- 新增 [ClickHouse](clickhousev1) 以及 [Flink](flinkv1) 采集器(#458/#459)
- [主机对象采集器](hostobject)
    - 支持从 [`ENV_CLOUD_PROVIDER`](hostobject#224e2ccd) 读取云同步配置(#501)
    - 优化磁盘采集，默认不会再采集无效磁盘（比如总大小为 0 的一些磁盘）(#505)
- [日志采集器](logging) 支持接收 TCP/UDP 日志流(#503)
- [Prom 采集器](prom) 支持多 URL 采集(#506)
- 新增 [eBPF](ebpf) 采集器，它集成了 L4-network/DNS/Bash 等 eBPF 数据采集(507)
- [ElasticSearch 采集器](elasticsearch) 增加 [Open Distro](https://opendistro.github.io/for-elasticsearch/){:target="_blank"} 分支的 ElasticSearch 支持(#510)

### Bug 修复

- 修复 [Statsd](statsd)/[Rabbitmq](rabbitmq) 指标问题(#497)
- 修复 [Windows Event](windows_event) 采集数据问题(#521)

### 其它

- [Pipeline](pipeline)
    - 增强 Pipeline 并行处理能力
    - 增加 [`set_tag()`](pipeline#6e8c5285) 函数(#444)
    - 增加 [`drop()`](pipeline#fb024a10) 函数(#498)
- Git 模式
    - 在 DaemonSet 模式下的 Git，支持识别 `ENV_DEFAULT_ENABLED_INPUTS` 并将其生效，非 DaemonSet 模式下，会自动开启 datakit.conf 中默认开启的采集器(#501)
    - 调整 Git 模式下文件夹[存放策略]()(#509)
- 推行新的版本号机制(#484)
    - 新的版本号形式为 1.2.3，此处 `1` 为 major 版本号，`2` 为 minor 版本号，`3` 为 patch 版本号
    - 以 minor 版本号的奇偶性来判定是稳定版（偶数）还是非稳定版（奇数）
    - 同一个 minor 版本号上，会有多个不同的 patch 版本号，主要用于问题修复以及功能调整
    - 新功能预计会发布在非稳定版上，待新功能稳定后，会发布新的稳定版本。如 1.3.x 新功能稳定后，会发布 1.4.0 稳定版，以合并 1.3.x 上的新功能
    - 非稳定版不支持直接升级，比如，不能升级到 1.3.x 这样的版本，只能直接安装非稳定版

### Breaking Changes {cl-1.2.0-break-changes}

**老版本的 DataKit 通过 `datakit --version` 已经无法推送新升级命令**，直接使用如下命令：

- Linux/Mac:

```shell
DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
```

- Windows

```powershell
$env:DK_UPGRADE="1"; Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1; powershell .install.ps1;
```

---

## 1.1.9-rc7.1(2021/12/22)

- 修复 MySQL 采集器因局部采集失败导致的数据问题。

---

## 1.1.9-rc7(2021/12/16)

- Pipeline 总体进行了较大的重构(#339)：

    - 添加 `if/elif/else` [语法](pipeline#1ea7e5aa)
    - 暂时移除 `expr()/json_all()` 函数
    - 优化时区处理，增加 `adjust_timezone()` 函数
    - 各个 Pipeline 函数做了整体测试加强

- DataKit DaemonSet：

    - Git 配置 DaemonSet [ENV 注入](datakit-daemonset-deploy#00c8a780)(#470)
    - 默认开启采集器移除容器采集器，以避免一些重复的采集问题(#473)

- 其它：
    - DataKit 支持自身事件上报（以日志形式）(#463)
    - [ElasticSearch](elasticsearch) 采集器指标集下增加 `indices_lifecycle_error_count` 指标（注意： 采集该指标，需在 ES [增加 `ilm` 角色](elasticsearch#852abae7)）
    - DataKit 安装完成后自动增加 [cgroup 限制](datakit-conf#4e7ff8f3)
    - 部分跟中心对接的接口升级到了 v2 版本，故对接**非 SAAS 节点**的 DataKit，如果升级到当前版本，其对应的 DataWay 以及 Kodo 也需要升级，否则部分接口会报告 404 错误

### Breaking Changes

处理 json 数据时，如果最顶层是数组，需要使用下标方式进行选择，例如 JSON

```
[
	{"abc": 123},
	{"def": true}
]
```

经过 Pipeline 处理完之后，如果取第一个元素的 `abc` 资源，之前版本做法是：

```
[0].abc
```

当前版本需改为：

```
# 在前面加一个 . 字符
.[0].abc
```

---

## 1.1.9-rc6.1(2021/12/10)

- 修复 ElasticSearch 以及 Kafka 采集报错问题(#486)

---

## 1.1.9-rc6(2021/11/30)

- 针对 Pipeline 做了一点紧急修复：
    - 移除 `json_all()` 函数，这个函数对于异常的 json 有严重的数据问题，故选择禁用之(#457)
    - 修正 `default_time()` 函数时区设置问题(#434)
- 解决 [prom](prom) 采集器在 Kubernetes 环境下 HTTPS 访问问题(#447)
- DataKit DaemonSet 安装的 [yaml 文件](https://static.guance.com/datakit/datakit.yaml){:target="_blank"} 公网可直接下载

---

## 1.1.9-rc5.1(2021/11/26)

- 修复 ddtrace 采集器因脏数据挂掉的问题

---

## 1.1.9-rc5(2021/11/23)

- 增加 [pythond(alpha)](pythond) ，便于用 Python3 编写自定义采集器(#367)
<!-- - 支持 source map 文件处理，便于 RUM 采集器收集 JavaScript 调用栈信息(#267) -->
- [SkyWalking V3](skywalking) 已支持到 8.5.0/8.6.0/8.7.0 三个版本(#385)
- DataKit 初步支持[磁盘数据缓存(alpha)](datakit-conf#caa0869c)(#420)
- DataKit 支持选举状态上报(#427)
- DataKit 支持 scheck 状态上报(#428)
- 调整 DataKit 使用入门文档，新的分类更便于找到具体文档

---

## 1.1.9-rc4.3(2021/11/19)

- 修复容器日志采集器因 pipeline 配置失当无法启动的问题

---

## 1.1.9-rc4.2(2021/11/18)

- 紧急修复(#446)
    - 修复 Kubernetes 模式下 stdout 日志输出 level 异常
    - 修复选举模式下，未选举上的 MySQL 采集器死循环问题
    - DaemonSet 文档补全

---

## 1.1.9-rc4.1(2021/11/16)

- 修复 Kubernetes Pod 采集 namespace 命名空间问题(#439)

---

## 1.1.9-rc4(2021/11/09)

- 支持[通过 Git 来管理](datakit-conf#90362fd0) 各种采集器配置（`datakit.conf` 除外）以及 Pipeline(#366)
- 支持[全离线安装](datakit-offline-install#7f3c40b6)(#421)
<!--
- eBPF-network
    - 增加[DNS 数据采集]()(#418)
    - 增强内核适配性，内核版本要求已降低至 Linux 4.4+(#416) -->
- 增强数据调试功能，采集到的数据支持写入本地文件，同时发送到中心(#415)
- K8s 环境中，默认开启的采集器支持通过环境变量注入 tags，详见各个默认开启的采集器文档(#408)
- DataKit 支持[一键上传日志](datakit-tools-how-to#0b4d9e46)(#405)
<!-- - MySQL 采集器增加[SQL 语句执行性能指标]()(#382) -->
- 修复安装脚本中 root 用户设定的 bug(#430)
- 增强 Kubernetes 采集器：
    - 添加通过 Annotation 配置 [Pod 日志采集](kubernetes-podlogging)(#380)
    - 增加更多 Annotation key，[支持多 IP 情况](kubernetes-prom#b8ba2a9e)(#419)
    - 支持采集 Node IP(#411)
    - 优化 Annotation 在采集器配置中的使用(#380)
- 云同步增加[华为云与微软云支持](hostobject#031406b2)(#265)

---

## 1.1.9-rc3(2021/10/26)

- 优化 [Redis 采集器](redis) DB 配置方式(#395)
- 修复 [Kubernetes](kubernetes) 采集器 tag 取值为空的问题(#409)
- 安装过程修复 Mac M1 芯片支持(#407)
- [eBPF-network](net_ebpf) 修复连接数统计错误问题(#387)
- 日志采集新增[日志数据获取方式](logstreaming)，支持 [Fluentd/Logstash 等数据接入](logstreaming)(#394/#392/#391)
- [ElasticSearch](elasticsearch) 采集器增加更多指标采集(#386)
- APM 增加 [Jaeger 数据](jaeger)接入(#383)
- [Prometheus Remote Write](prom_remote_write)采集器支持数据切割调试
- 优化 [Nginx 代理](proxy#a64f44d8)功能
- DQL 查询结果支持 [CSV 文件导出](datakit-dql-how-to#2368bf1d)

---

## 1.1.9-rc2(2021/10/14)

- 新增[采集器](prom_remote_write)支持 Prometheus Remote Write 将数据同步给 DataKit(#381)
- 新增[Kubernetes Event 数据采集](kubernetes#49edf2c4)(#296)
- 修复 Mac 因安全策略导致安装失败问题(#379)
- [prom 采集器](prom) 调试工具支持从本地文件调试数据切割(#378)
- 修复 [etcd 采集器](etcd)数据问题(#377)
- DataKit Docker 镜像增加 arm64 架构支持(#365)
- 安装阶段新增环境变量 `DK_HOSTNAME` [支持](datakit-install#f9858758)(#334)
- [Apache 采集器](apache) 增加更多指标采集 (#329)
- DataKit API 新增接口 [`/v1/workspace`](apis#2a24dd46) 以获取工作空间信息(#324)
    - 支持 DataKit 通过命令行参数[获取工作空间信息](datakit-tools-how-to#88b4967d)

---

## 1.1.9-rc1.1(2021/10/09)

- 修复 Kubernetes 选举问题(#389)
- 修复 MongoDB 配置兼容性问题

---

## 1.1.9-rc1(2021/09/28)

- 完善 Kubernetes 生态下 [Prometheus 类指标采集](kubernetes-prom)(#368/#347)
- [eBPF-network](net_ebpf) 优化
- 修复 DataKit/DataWay 之间连接数泄露问题(#290)
- 修复容器模式下 DataKit 各种子命令无法执行的问题(#375)
- 修复日志采集器因 Pipeline 错误丢失原始数据的问题(#376)
- 完善 DataKit 端 [DCA](dca) 相关功能，支持在安装阶段[开启 DCA 功能](datakit-install#f9858758)。
- 下线浏览器拨测功能

---

## 1.1.9-rc0(2021/09/23)

- [日志采集器](logging)增加特殊字符（如颜色字符）过滤功能（默认关闭）(#351)
- [完善容器日志采集](container#6a1b31bb)，同步更多现有普通日志采集器功能（多行匹配/日志等级过滤/字符编码等）(#340)
- [主机对象](hostobject)采集器字段微调(#348)
- 新增如下几个采集器
    - [eBPF-network](net_ebpf)(alpha)(#148)
    - [Consul](consul)(#303)
    - [etcd](etcd)(#304)
    - [CoreDNS](coredns)(#305)
- 选举功能已经覆盖到如下采集器：(#288)
    - [Kubernetes](kubernetes)
    - [Prom](prom)
    - [Gitlab](gitlab)
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

<!--
- [DCA](dca) 相关功能完善
	- 独立端口分离(#341)
	- 远程重启功能调整(#345)
	- 白名单功能(#244) -->

---

## 1.1.8-rc3(2021/09/10)

- ddtrace 增加 [resource 过滤](ddtrace#224e2ccd)功能(#328)
- 新增 [NSQ](nsq) 采集器(#312)
- K8s daemonset 部署时，部分采集器支持通过环境变量来变更默认配置，以[CPU 为例](cpu#1b85f981)(#309)
- 初步支持 [SkyWalkingV3](skywalking)(alpha)(#335)

### Bugs

- [RUM](rum) 采集器移除全文字段，减少网络开销(#349)
- [日志采集器](logging)增加对文件 truncate 情况的处理(#271)
- 日志字段切割错误字段兼容(#342)
- 修复[离线下载](datakit-offline-install)时可能出现的 TLS 错误(#330)

### 改进

- 日志采集器一旦配置成功，则触发一条通知日志，表明对应文件的日志采集已经开启(#323)

---

## 1.1.8-rc2.4(2021/08/26)

- 修复安装程序开启云同步导致无法安装的问题

---

## 1.1.8-rc2.3(2021/08/26)

- 修复容器运行时无法启动的问题

---

## 1.1.8-rc2.2(2021/08/26)

- 修复 [hostdir](hostdir) 配置文件不存在问题

---

## 1.1.8-rc2.1(2021/08/25)

- 修复 CPU 温度采集导致的无数据问题
- 修复 statsd 采集器退出崩溃问题(#321)
- 修复代理模式下自动提示的升级命令问题

---

## 1.1.8-rc2(2021/08/24)

- 支持同步 Kubernetes labels 到各种对象上（pod/service/...）(#279)
- `datakit` 指标集增加数据丢弃指标(#286)
- [Kubernetes 集群自定义指标采集](kubernetes-prom) 优化(#283)
- [ElasticSearch](elasticsearch) 采集器完善(#275)
- 新增[主机目录](hostdir)采集器(#264)
- [CPU](cpu) 采集器支持单个 CPU 指标采集(#317)
- [ddtrace](ddtrace) 支持多路由配置(#310)
- [ddtrace](ddtrace#fb3a6e17) 支持自定义业务 tag 提取(#316)
- [主机对象](hostobject)上报的采集器错误，只上报最近 30s(含)以内的错误(#318)
- [DCA 客户端](dca)发布
- 禁用 Windows 下部分命令行帮助(#319)
- 调整 DataKit [安装形式](datakit-install)，[离线安装](datakit-offline-install)方式做了调整(#300)
    - 调整之后，依然兼容之前老的安装方式

### Breaking Changes

- 从环境变量 `ENV_HOSTNAME` 获取主机名的功能已移除（1.1.7-rc8 支持），可通过[主机名覆盖功能](datakit-install#987d5f91) 来实现
- 移除命令选项 `--reload`
- 移除 DataKit API `/reload`，代之以 `/restart`
- 由于调整了命令行选项，之前的查看 monitor 的命令，也需要 sudo 权限运行（因为要读取 datakit.conf 自动获取 DataKit 的配置）

---

## 1.1.8-rc1.1(2021/08/13)

- 修复 `ENV_HTTP_LISTEN` 无效问题，该问题导致容器部署（含 K8s DaemonSet 部署）时，HTTP 服务启动异常。

---

## 1.1.8-rc1(2021/08/10)

- 修复云同步开启时，无法上报主机对象的问题
- 修复 Mac 上新装 DataKit 无法启动的问题
- 修复 Mac/Linux 上非 `root` 用户操作服务「假成功」的问题
- 优化数据上传的性能
- [`proxy`](proxy) 采集器支持全局代理功能，涉及内网环境的安装、更新、数据上传方式的调整
- 日志采集器性能优化
- 文档完善

---

## 1.1.8-rc0(2021/08/03)

- 完善 [Kubernetes](kubernetes) 采集器，增加更多 Kubernetes 对象采集
- 完善[主机名覆盖功能](datakit-install#987d5f91)
- 优化 Pipeline 处理性能（约 15 倍左右，视不同 Pipeline 复杂度而定）
- 加强[行协议数据检查](apis#2fc2526a)
- `system` 采集器，增加 [`conntrack`以及`filefd`](system) 两个指标集
- `datakit.conf` 增加 IO 调参入口，便于用户对 DataKit 网络出口流量做优化（参见下面的 Breaking Changes）
- DataKit 支持[服务卸载和恢复](datakit-service-how-to#9e00a535)
- Windows 平台的服务支持通过[命令行管理](datakit-service-how-to#147762ed)
- DataKit 支持动态获取最新 DataWay 地址，避免默认 DataWay 被 DDos 攻击
- DataKit 日志支持[输出到终端](datakit-daemonset-deploy#00c8a780)（Windows 暂不不支持），便于 k8s 部署时日志查看、采集
- 调整 DataKit 主配置，各个不同配置模块化（详见下面的 Breaking Changes）
- 其它一些 bug 修复，完善现有的各种文档

### Breaking Changes

以下改动，在升级过程中会*自动调整*，这里只是提及具体变更，便于大家理解

- 主配置修改：增加如下几个模块

```toml
[io]
  feed_chan_size                 = 1024  # IO管道缓存大小
  hight_frequency_feed_chan_size = 2048  # 高频IO管道缓存大小
  max_cache_count                = 1024  # 本地缓存最大值，原主配置中 io_cache_count [此数值与max_dynamic_cache_count同时小于等于零将无限使用内存]
  cache_dump_threshold         = 512   # 本地缓存推送后清理剩余缓存阈值 [此数值小于等于零将不清理缓存，如遇网络中断可导致内存大量占用]
  max_dynamic_cache_count      = 1024  # HTTP缓存最大值，[此数值与max_cache_count同时小于等于零将无限使用内存]
  dynamic_cache_dump_threshold = 512   # HTTP缓存推送后清理剩余缓存阈值，[此数值小于等于零将不清理缓存，如遇网络中断可导致内存大量占用]
  flush_interval               = "10s" # 推送时间间隔
  output_file                  = ""    # 输出io数据到本地文件，原主配置中 output_file

[http_api]
	listen          = "localhost:9529" # 原 http_listen
	disable_404page = false            # 原 disable_404page

[logging]
	log           = "/var/log/datakit/log"     # 原 log
	gin_log       = "/var/log/datakit/gin.log" # 原 gin.log
	level         = "info"                     # 原 log_level
	rotate        = 32                         # 原 log_rotate
	disable_color = false                      # 新增配置
```

---

## 1.1.7-rc9.1(2021/07/17)

### 发布说明

- 修复因文件句柄泄露，导致 Windows 平台上重启 DataKit 可能失败的问题

## 1.1.7-rc9(2021/07/15)

### 发布说明

- 安装阶段支持填写云服务商、命名空间以及网卡绑定
- 多命名空间的选举支持
- 新增 [InfluxDB 采集器](influxdb)
- datakit DQL 增加历史命令存储
- 其它一些细节 bug 修复

---

## 1.1.7-rc8(2021/07/09)

### 发布说明

- 支持 MySQL [用户](mysql#15319c6c)以及[表级别](mysql#3343f732)的指标采集
- 调整 monitor 页面展示
    - 采集器配置情况和采集情况分离显示
    - 增加选举、自动更新状态显示
- 支持从 `ENV_HOSTNAME` 获取主机名，以应付原始主机名不可用的问题
- 支持 tag 级别的 [Trace](ddtrace) 过滤
- [容器采集器](container)支持采集容器内进程对象
- 支持通过 [cgroup 控制 DataKit CPU 占用](datakit-conf#4e7ff8f3)（仅 Linux 支持）
- 新增 [IIS 采集器](iis)

### Bug 修复

- 修复云同步脏数据导致的上传问题

---

## 1.1.7-rc7(2021/07/01) {#cl-1.1.7-rc7}

### 发布说明

- DataKit API 支持，且支持 [JSON Body](apis#75f8e5a2)
- 命令行增加功能：

    - [DQL 查询功能](datakit-dql-how-to#cb421e00)
    - [命令行查看 monitor](datakit-tools-how-to#44462aae)
    - [检查采集器配置是否正确](datakit-tools-how-to#519a9e75)

- 日志性能优化（对各个采集器自带的日志采集而言，目前仅针对 nginx/MySQL/Redis 做了适配，后续将适配其它各个自带日志收集的采集器）

- 主机对象采集器，增加 [conntrack](hostobject#2300b531) 和 [filefd](hostobject#697f87e2) 俩类指标
- 应用性能指标采集，支持[采样率设置](ddtrace#c59ce95c)
- K8s 集群 Prometheus 指标采集[通用方案](kubernetes-prom)

### Breaking Changes

- 在 datakit.conf 中配置的 `global_tags` 中，`host` tag 将不生效，此举主要为了避免大家在配置 host 时造成一些误解（即配置了 `host`，但可能跟实际的主机名不同，造成一些数据误解）

---

## 1.1.7-rc6(2021/06/17)

### 发布说明

- 新增[Windows 事件采集器](windows_event)
- 为便于用户部署 [RUM](rum) 公网 DataKit，提供禁用 DataKit 404 页面的选项
- [容器采集器](container)字段有了新的优化，主要涉及 pod 的 restart/ready/state 等字段
- [Kubernetes 采集器](kubernetes) 增加更多指标采集
- 支持在 DataKit 端对日志进行（黑名单）过滤
    - 注意：如果 DataKit 上配置了多个 DataWay 地址，日志过滤功能将不生效。

### Breaking Changes

对于没有语雀文档支持的采集器，在这次发布中，均已移除（各种云采集器，如阿里云监控数据、费用等采集）。如果有对这些采集器有依赖，不建议升级。

---

## 1.1.7-rc5(2021/06/16)

### 问题修复

修复 [DataKit API](apis) `/v1/query/raw` 无法使用的问题。

---

## 1.1.7-rc4(2021/06/11)

### 问题修复

禁用 Docker 采集器，其功能完全由[容器采集器](container) 来实现。

原因：

- Docker 采集器和容器采集器并存的情况下（DataKit 默认安装、升级情况下，会自动启用容器采集器），会导致数据重复
- 现有 Studio 前端、模板视图等尚不支持最新的容器字段，可能导致用户升级上来之后，看不到容器数据。本版本的容器采集器会冗余一份原 Docker 采集器中采集上来的指标，使得 Studio 能正常工作。

> 注意：如果在老版本中，有针对 Docker 的额外配置，建议手动移植到 [容器采集器](container) 中来。它们之间的配置基本上是兼容的。

---

## 1.1.7-rc3(2021/06/10)

### 发布说明

- 新增 [磁盘 S.M.A.R.T 采集器](smart)
- 新增 [硬件 温度采集器](sensors)
- 新增 [Prometheus 采集器](prom)

### 问题修复

- 修正 [Kubernetes 采集器](kubernetes)，支持更多 K8s 对象统计指标收集
- 完善[容器采集器](container)，支持 image/container/pod 过滤
- 修正 [Mongodb 采集器](mongodb)问题
- 修正 MySQL/Redis 采集器可能因为配置缺失导致崩溃的问题
- 修正[离线安装问题](datakit-offline-install)
- 修正部分采集器日志设置问题
- 修正 [SSH](ssh)/[Jenkins](jenkins) 等采集器的数据问题

---

## 1.1.7-rc2(2021/06/07)

### 发布说明

- 新增 [Kubernetes 采集器](kubernetes)
- DataKit 支持 [DaemonSet 方式部署](datakit-daemonset-deploy)
- 新增 [SQL Server 采集器](sqlserver)
- 新增 [PostgreSQL 采集器](postgresql)
- 新增 [statsd 采集器](statsd)，以支持采集从网络上发送过来的 statsd 数据
- [JVM 采集器](jvm) 优先采用 ddtrace + statsd 采集
- 新增[容器采集器](container)，增强对 k8s 节点（Node）采集，以替代原有 [docker 采集器](docker)（原 docker 采集器仍可用）
- [拨测采集器](dialtesting)支持 Headleass 模式
- [Mongodb 采集器](mongodb) 支持采集 Mongodb 自身日志
- DataKit 新增 DQL HTTP [API 接口](apis) `/v1/query/raw`
- 完善部分采集器文档，增加中间件（如 MySQL/Redis/ES 等）日志采集相关文档

---

## 1.1.7-rc1(2021/05/26)

### 发布说明

- 修复 Redis/MySQL 采集器数据异常问题
- MySQL InnoDB 指标重构，具体细节参考 [MySQL 文档](mysql#e370e857)

---

## 1.1.7-rc0(2021/05/20)

### 发布说明

新增采集器：

- [Apache](apache)
- [Cloudprober 接入](cloudprober)
- [Gitlab](gitlab)
- [Jenkins](jenkins)
- [Memcached](memcached)
- [Mongodb](mongodb)
- [SSH](ssh)
- [Solr](solr)
- [Tomcat](tomcat)

新功能相关：

- 网络拨测支持私有节点接入
- Linux 平台默认开启容器对象、日志采集
- CPU 采集器支持温度数据采集
- [MySQL 慢日志支持阿里云 RDS 格式切割](mysql#ee953f78)

其它各种 Bug 修复。

### Breaking Changes

[RUM 采集](rum)中数据类型做了调整，原有数据类型基本已经废弃，需[更新对应 SDK](/dataflux/doc/eqs7v2)。

---

## 1.1.6-rc7(2021/05/19)

### 发布说明

- 修复 Windows 平台安装、升级问题

---

## 1.1.6-rc6(2021/05/19)

### 发布说明

- 修复部分采集器（MySQL/Redis）数据处理过程中， 因缺少指标导致的数据问题
- 其它一些 bug 修复

---

## 1.1.6-rc5(2021/05/18)

### 发布说明

- 修复 HTTP API precision 解析问题，导致部分数据时间戳解析失败

---

## 1.1.6-rc4(2021/05/17)

### 发布说明

- 修复容器日志采集可能崩溃的问题

---

## 1.1.6-rc3(2021/05/13)

### 发布说明

本次发布，有如下更新：

- DataKit 安装/升级后，安装目录变更为

    - Linux/Mac: `/usr/local/datakit`，日志目录为 `/var/log/datakit`
    - Windows: `C:\Program Files\datakit`，日志目录就在安装目录下

- 支持 [`/v1/ping` 接口](apis#50ea0eb5)
- 移除 RUM 采集器，RUM 接口[默认已经支持](apis#f53903a9)
- 新增 monitor 页面：http://localhost:9529/monitor，以替代之前的 /stats 页面。reload 之后自动跳转到 monitor 页面
- 支持命令直接[安装 sec-checker](datakit-tools-how-to#01243fef) 以及[更新 ip-db](datakit-tools-how-to#ab5cd5ad)

---

## 1.1.6-rc2(2021/05/11)

### Bug 修复

- 修复容器部署情况下无法启动的问题

---

## 1.1.6-rc1(2021/05/10)

### 发布说明

本次发布，对 DataKit 的一些细节做了调整：

- DataKit 上支持配置多个 DataWay
- [云关联](hostobject#031406b2)通过对应 meta 接口来实现
- 调整 docker 日志采集的[过滤方式](docker#a487059d)
- [DataKit 支持选举](election)
- 修复拨测历史数据清理问题
- 大量文档[发布到语雀](https://www.yuque.com/dataflux/datakit)
- [DataKit 支持命令行集成 Telegraf](datakit-tools-how-to#d1b3b29b)
- DataKit 单实例运行检测
- DataKit [自动更新功能](datakit-update-crontab)

---

## 1.1.6-rc0(2021/04/30)

### 发布说明

本次发布，对 DataKit 的一些细节做了调整：

- Linux/Mac 安装完后，能直接在任何目录执行 `datakit` 命令，无需切换到 DataKit 安装目录
- Pipeline 增加脱敏函数 `cover()`
- 优化命令行参数，更加便捷
- 主机对象采集，默认过滤虚拟设备（仅 Linux 支持）
- datakit 命令支持 `--start/--stop/--restart/--reload` 几个命令（需 root 权限），更加便于大家管理 DataKit 服务
- 安装/升级完成后，默认开启进程对象采集器（目前默认开启列表为 `cpu/disk/diskio/mem/swap/system/hostobject/net/host_processes`）
- 日志采集器 `tailf` 改名为 `logging`，原有的 `tailf` 名称继续可用
- 支持接入 Security 数据
- 移除 Telegraf 安装集成。如果需要 Telegraf 功能，可查看 :9529/man 页面，有专门针对 Telegraf 安装使用的文档
- 增加 datakit-how-to 文档，便于大家初步入门（:9529/man 页面可看到）
- 其它一些采集器的指标采集调整

---

## v1.1.5-rc2(2021/04/22)

### Bug 修复

- 修复 Windows 上 `--version` 命令请求线上版本信息的地址错误
- 调整华为云监控数据采集配置，放出更多可配置信息，便于实时调整
- 调整 Nginx 错误日志（error.log）切割脚本，同时增加默认日志等级的归类

---

## v1.1.5-rc1(2021/04/21)

### Bug 修复

- 修复 tailf 采集器配置文件兼容性问题，该问题导致 tailf 采集器无法运行

---

## v1.1.5-rc0(2021/04/20)

### 发布说明

本次发布，对采集器做了较大的调整。

### Breaking Changes

涉及的采集器列表如下：

| 采集器          | 说明                                                                                                                                                                                      |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cpu`           | DataKit 内置 CPU 采集器，移除 Telegraf CPU 采集器，配置文件保持兼容。另外，Mac 平台暂不支持 CPU 采集，后续会补上                                                                          |
| `disk`          | DataKit 内置磁盘采集器                                                                                                                                                                    |
| `docker`        | 重新开发了 docker 采集器，同时支持容器对象、容器日志以及容器指标采集（额外增加对 K8s 容器采集）                                                                                           |
| `elasticsearch` | DataKit 内置 ES 采集器，同时移除 Telegraf 中的 ES 采集器。另外，可在该采集器中直接配置采集 ES 日志                                                                                        |
| `jvm`           | DataKit 内置 JVM 采集器                                                                                                                                                                   |
| `kafka`         | DataKit 内置 Kafka 指标采集器，可在该采集器中直接采集 Kafka 日志                                                                                                                          |
| `mem`           | DataKit 内置内存采集器，移除 Telegraf 内存采集器，配置文件保持兼容                                                                                                                        |
| `mysql`         | DataKit 内置 MySQL 采集器，移除 Telegraf MySQL 采集器。可在该采集器中直接采集 MySQL 日志                                                                                                  |
| `net`           | DataKit 内置网络采集器，移除 Telegraf 网络采集器。在 Linux 上，对于虚拟网卡设备，默认不再采集（需手动开启）                                                                               |
| `nginx`         | DataKit 内置 Nginx 采集器，移除 Telegraf Ngxin 采集器。可在该采集器中直接采集 Nginx 日志                                                                                                  |
| `oracle`        | DataKit 内置 Oracle 采集器。可在该采集器中直接采集 Oracle 日志                                                                                                                            |
| `rabbitmq`      | DataKit 内置 RabbitMQ 采集器。可在该采集器中直接采集 RabbitMQ 日志                                                                                                                        |
| `redis`         | DataKit 内置 Redis 采集器。可在该采集器中直接采集 Redis 日志                                                                                                                              |
| `swap`          | DataKit 内置内存 swap 采集器                                                                                                                                                              |
| `system`        | DataKit 内置 system 采集器，移除 Telegraf system 采集器。内置的 system 采集器新增三个指标： `load1_per_core/load5_per_core/load15_per_core`，便于客户端直接显示单核平均负载，无需额外计算 |

以上采集器的更新，非主机类型的采集器，绝大部分涉均有指标集、指标名的更新，具体参考各个采集器文档。

其它兼容性问题：

- 出于安全考虑，采集器不再默认绑定所有网卡，默认绑定在 `localhost:9529` 上。原来绑定的 `0.0.0.0:9529` 已失效（字段 `http_server_addr` 也已弃用），可手动修改 `http_listen`，将其设定成 `http_listen = "0.0.0.0:9529"`（此处端口可变更）
- 某些中间件（如 MySQL/Nginx/Docker 等）已经集成了对应的日志采集，它们的日志采集可以直接在对应的采集器中配置，无需额外用 `tailf` 来采集了（但 `tailf` 仍然可以单独采集这些日志）
- 以下采集器，将不再有效，请用上面内置的采集器来采集
    - `dockerlog`：已集成到 docker 采集器
    - `docker_containers`：已集成到 docker 采集器
    - `mysqlMonitor`：以集成到 mysql 采集器

### 新增特性

- 拨测采集器（`dialtesting`）：支持中心化任务下发，在 Studio 主页，有单独的拨测入口，可创建拨测任务来试用
- 所有采集器的配置项中，支持配置环境变量，如 `host="$K8S_HOST"`，便于容器环境的部署
- http://localhost:9529/stats 新增更多采集器运行信息统计，包括采集频率（`frequency`）、每次上报数据条数（`avg_size`）、每次采集消耗（`avg_collect_cost`）等。部分采集器可能某些字段没有，这个不影响，因为每个采集器的采集方式不同
- http://localhost:9529/reload 可用于重新加载采集器，比如修改了配置文件后，可以直接 `curl http://localhost:9529/reload` 即可，这种形式不会重启服务，类似 Nginx 中的 `-s reload` 功能。当然也能在浏览器上直接访问该 reload 地址，reload 成功后，会自动跳转到 stats 页面
- 支持在 http://localhost:9529/man 页面浏览 DataKit 文档（只有此次新改的采集器文档集成过来了，其它采集器文档需在原来的帮助中心查看）。默认情况下不支持远程查看 DataKit 文档，可在终端查看（仅 Mac/Linux 支持）：

```shell
	# 进入采集器安装目录，输入采集器名字（通过 `Tab` 键选择自动补全）即可查看文档
	$ ./datakit -cmd -man
	man > nginx
	(显示 Nginx 采集文档)
	man > mysql
	(显示 MySQL 采集文档)
	man > Q               # 输入 Q 或 exit 退出
```

---

## v1.1.4-rc2(2021/04/07)

### Bug 修复

- 修复阿里云监控数据采集器（`aliyuncms`）频繁采集导致部分其它采集器卡死的问题。

---

## v1.1.4-rc1(2021/03/25)

### 改进

- 进程采集器 `message` 字段增加更多信息，便于全文搜索
- 主机对象采集器支持自定义 tag，便于云属性同步

---

## v1.1.4-rc0(2021/03/25)

### 新增功能

- 增加文件采集器、拨测采集器以及 HTTP 报文采集器
- 内置支持 ActiveMQ/Kafka/RabbitMQ/gin（Gin HTTP 访问日志）/Zap（第三方日志框架）日志切割

### 改进

- 丰富 `http://localhost:9529/stats` 页面统计信息，增加诸如采集频率（`n/min`），每次采集的数据量大小等
- DataKit 本身增加一定的缓存空间（重启即失效），避免偶然的网络原因导致数据丢失
- 改进 Pipeline 日期转换函数，提升准确性。另外增加了更多 Pipeline 函数（`parse_duration()/parse_date()`）
- trace 数据增加更多业务字段（`project/env/version/http_method/http_status_code`）
- 其它采集器各种细节改进

---

## v1.1.3-rc4(2021/03/16)

### Bug 修复

- 进程采集器：修复用户名缺失导致显示空白的问题，对用户名获取失败的进程，以 `nobody` 当做其用户名。

---

## v1.1.3-rc3(2021/03/04)

### Bug 修复

- 修复进程采集器部分空字段（进程用户以及进程命令缺失）问题
- 修复 kubernetes 采集器内存占用率计算可能 panic 的问题

<!--
### 新增功能
- `http://datakit:9529/reload` 会自动跳转到 `http://datakit:9529/stats`，便于查看 reload 后 datakit 的运行情况
- `http://datakit:9529/reload` 页面增加每分钟采集频率（`frequency`）以及每次采集的数据量大小统计
- `kubernetes` 指标采集器增加 node 的内存使用率（`mem_usage_percent`）采集 -->

---

## v1.1.3-rc2(2021/03/01)

### Bug 修复

- 修复进程对象采集器 `name` 字段命名问题，以 `hostname + pid` 来命名 `name` 字段
- 修正华为云对象采集器 pipeline 问题
- 修复 Nginx/MySQL/Redis 日志采集器升级后的兼容性问题

---

## v1.1.3-rc1(2021/02/26)

### 新增功能

- 增加内置 Redis/Nginx
- 完善 MySQL 慢查询日志分析

### 功能改进

- 进程采集器由于单次采集耗时过长，对采集器的采集频率做了最小值（30s）限制
- 采集器配置文件名称不再严格限制，任何形如 `xxx.conf` 的文件，都是合法的文件命名
- 更新版本提示判断，如果 git 提交码跟线上不一致，也会提示更新
- 容器对象采集器（`docker_containers`），增加内存/CPU 占比字段（`mem_usage_percent/cpu_usage`）
- K8s 指标采集器（`kubernetes`），增加 CPU 占比字段（`cpu_usage`）
- Tracing 数据采集完善对 service type 处理
- 部分采集器支持自定义写入日志或者指标（默认指标）

### Bug 修复

- 修复 Mac 平台上，进程采集器获取默认用户名无效的问题
- 修正容器对象采集器，获取不到*已退出容器*的问题
- 其它一些细节 bug 修复

### Breaking Changes

- 对于某些采集器，如果原始指标中带有 `uint64` 类型的字段，新版本会导致字段不兼容，应该删掉原有指标集，避免类型冲突

    - 原来对于 uint64 的处理，将其自动转成了 string，这会导致使用过程中困扰。实际上可以更为精确的控制这个整数移除的问题
    - 对于超过 max-int64 的 uint 整数，采集器会丢弃这样的指标，因为目前 influx1.7 不支持 uint64 的指标

- 移除部分原 dkctrl 命令执行功能，配置管理功能后续不再依赖该方式实现

---

## v1.1.2(2021/02/03)

### 功能改进

- 容器安装时，必须注入 `ENV_UUID` 环境变量
- 从旧版本升级后，会自动开启主机采集器（原 datakit.conf 会备份一个）
- 添加缓存功能，当出现网络抖动的情况下，不至于丢失采集到的数据（当长时间网络瘫痪的情况下，数据还是会丢失）
- 所有使用 tailf 采集的日志，必须在 pipeline 中用 `time` 字段来指定切割出来的时间字段，否则日志存入时间字段会跟日志实际时间有出入

### Bug 修复

- 修复 zipkin 中时间单位问题
- 主机对象出采集器中添加 `state` 字段

---

## v1.1.1(2021/02/01)

### Bug 修复

- 修复 mysqlmonitor 采集器 status/variable 字段均为 string 类型的问题。回退至原始字段类型。同时对 int64 溢出问题做了保护。
- 更改进程采集器部分字段命名，使其跟主机采集器命名一致

---

## v1.1.0(2021/01/29)

### 发布说明

本版本主要涉及部分采集器的 bug 修复以及 datakit 主配置的调整。

### Breaking Changes

- 采用新的版本号机制，原来形如 `v1.0.0-2002-g1fe9f870` 这样的版本号将不再使用，改用 `v1.2.3` 这样的版本号
- 原 DataKit 顶层目录的 `datakit.conf` 配置移入 `conf.d` 目录
- 原 `network/net.conf` 移入 `host/net.conf`
- 原 `pattern` 目录转移到 `pipeline` 目录下
- 原 grok 中内置的 pattern，如 `%{space}` 等，都改成大写形式 `%{SPACE}`。**之前写好的 grok 需全量替换**
- 移除 `datakit.conf` 中 `uuid` 字段，单独用 `.id` 文件存放，便于统一 DataKit 所有配置文件
- 移除 ansible 采集器事件数据上报

### Bug 修复

- 修复 `prom`、`oraclemonitor` 采集不到数据的问题
- `self` 采集器将主机名字段 hostname 改名成 host，并置于 tag 上
- 修复 `mysqlMonitor` 同时采集 MySQL 和 MariaDB 类型冲突问题
- 修复 Skywalking 采集器日志不切分导致磁盘爆满问题

### 特性

- 新增采集器/主机黑白名单功能（暂不支持正则）
- 重构主机、进程、容器等对象采集器采集器
- 新增 pipeline/grok 调试工具
- `-version` 参数除了能看当前版本，还将提示线上新版本信息以及更新命令
- 支持 DDTrace 数据接入
- `tailf` 采集器新日志匹配改成正向匹配
- 其它一些细节问题修复
- 支持 Mac 平台的 CPU 数据采集
