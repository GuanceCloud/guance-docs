---
icon: integrations/coredns
---
# CoreDNS

---

## 视图预览

CoreDNS 性能指标展示，包括请求次数、对每个 Zone 和 RCODE 的响应总数、缓存总数、缓存命中说、缓存 Miss 数等。

![image](../imgs/input-coredns-1.png)

## 版本支持

操作系统支持：Linux

## 前置条件

- CoreDNS 所在 Kubernetes 集群 <[安装 DataKit](../../datakit/datakit-daemonset-deploy.md)>
- 检查是否能正常收集数据

Kubernetes 集群 Master 节点执行：

```
kubectl get svc -n kube-system
```

![image](../imgs/input-coredns-2.png)

得到 DNS Service 域名是：

```
http://kube-dns.kube-system.svc.cluster.local
```

登录任意一个 Kubernetes 集群中的容器，执行如下命令：

```
curl http://kube-dns.kube-system.svc.cluster.local:9153/metrics
```

显示有如下信息，说明可以正常接收数据：

![image](../imgs/input-coredns-3.png)

## 安装部署

说明：示例 CoreDNS 版本为 coredns:1.7.0（CentOS 环境下 Kubeadmin 部署），各个不同版本指标可能存在差异。

### 指标采集 (必选)

1、 下载 `datakit.yaml`

登录观测云控制台，点击「集成」 -「DataKit」 - 「Kubernetes」，下载 `datakit.yaml`。

2、 修改 `datakit.yaml` 配置文件

```
vi datakit.yaml
```

在 `env` 下面增加环境变量 

```
        - name: ENV_GLOBAL_ELECTION_TAGS
          value: cluster_name_k8s=k8s-dsp
```

在 `datakit.yaml` 的 `volumeMounts` 下面增加如下 3 行：

```yaml
volumeMounts:
  - mountPath: /usr/local/datakit/conf.d/coredns/coredns.conf
    name: datakit-conf
    subPath: k8s_core_dns.conf
```

在 ConfigMap 资源文件中增加 `#### k8s core dns` 以下的部分：

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### k8s core dns
  k8s_core_dns.conf: |-
    [[inputs.prom]]
    ## Exporter 地址
    # 此处修改成CoreDNS的prom监听地址
    url = "http://kube-dns.kube-system.svc.cluster.local:9153/metrics"

    ## 采集器别名
    source = "coredns"

    ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
    # 默认只采集 counter 和 gauge 类型的指标
    # 如果为空，则不进行过滤
    metric_types = ["counter", "gauge"]

    ## 指标名称过滤
    # 支持正则，可以配置多个，即满足其中之一即可
    # 如果为空，则不进行过滤
    # CoreDNS的prom默认提供大量Go运行时的指标，这里忽略
    metric_name_filter = ["^coredns_(acl|cache|dnssec|forward|grpc|hosts|template|dns)_([a-z_]+)$"]

    ## 指标集名称前缀
    # 配置此项，可以给指标集名称添加前缀
    # measurement_prefix = ""

    ## 指标集名称
    # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
    # 如果配置measurement_name, 则不进行指标名称的切割
    # 最终的指标集名称会添加上measurement_prefix前缀
    # measurement_name = "prom"

    ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
    interval = "60s"

    ## 过滤tags, 可配置多个tag
    # 匹配的tag将被忽略
    # tags_ignore = [""]

    ## TLS 配置
    tls_open = false
    # tls_ca = "/tmp/ca.crt"
    # tls_cert = "/tmp/peer.crt"
    # tls_key = "/tmp/peer.key"

    ## 自定义指标集名称
    # 可以将包含前缀prefix的指标归为一类指标集
    # 自定义指标集名称配置优先measurement_name配置项

    [[inputs.prom.measurements]]
        prefix = "coredns_acl_"
        name = "coredns_acl"
    [[inputs.prom.measurements]]
        prefix = "coredns_cache_"
        name = "coredns_cache"
    [[inputs.prom.measurements]]
        prefix = "coredns_dnssec_"
        name = "coredns_dnssec"
    [[inputs.prom.measurements]]
        prefix = "coredns_forward_"
        name = "coredns_forward"
    [[inputs.prom.measurements]]
        prefix = "coredns_grpc_"
        name = "coredns_grpc"
    [[inputs.prom.measurements]]
        prefix = "coredns_hosts_"
        name = "coredns_hosts"
    [[inputs.prom.measurements]]
        prefix = "coredns_template_"
        name = "coredns_template"
    [[inputs.prom.measurements]]
        prefix = "coredns_dns_"
        name = "coredns"
    [inputs.prom.tags]
      #cluster_name="k8s-dns"
```

参数说明：

- url：CoreDNS 的 Prom 监听地址
- source：采集器别名
- metric_types：指标类型过滤
- metric_name_filter：指标名称过滤
- measurement_prefix：指标集名称前缀
- measurement_name：指标集名称
- interval：采集间隔
- tags_ignore：匹配的 tag 将被忽略
- tls_open：是否忽略安全验证 (如果是 HTTPS ，请设置为 true，并设置相应证书)
- prefix：自定义指标前缀
- name：自定义指标集名称，即把 prefix 开头的指标归为此 name 的指标集

3、 部署 DataKit

```
kubectl apply -f datakit.yaml
```

4、 指标预览

![image](../imgs/input-coredns-4.png)

### 插件标签 (非必选)

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 CoreDNS 指标都会带有 `cluster_name_k8s="k8s-dns"` 的标签，可以进行快速查询，如果通过环境变量配置 `cluster_name_k8s` 后，这里不需要配置
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
[inputs.prom.tags]
  cluster_name_k8s="k8s-dns"
```


## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - CoreDNS 监控视图>

## [指标详解](../../../datakit/coredns#metrics)

## 最佳实践

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>
