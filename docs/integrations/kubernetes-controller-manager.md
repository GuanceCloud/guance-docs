# Kubernetes Controller Manager 
---

## 视图预览

Controller Manager 性能指标展示：Service Controller Rate Limiter Use、Deployment Controller Rate Limiter Use、Daemon Controller Rate Limiter Use、Replicaset Controller Rate Limiter Use、CPU、Memory、Goroutines等。

## 版本支持

操作系统：Linux

Kubernetes 版本：1.18+

## 前置条件

- Kubernetes 集群 <[安装 Datakit](kube-metric-server.md)>

## 安装配置

说明：示例 Kubernetes 版本为 1.22.6，DataKit 版本为 1.2.17，各个不同版本指标可能存在差异。

### 部署实施

#### 指标采集 (必选)

1、 ConfigMap 增加controller-manager.conf 配置

在部署 DataKit 使用的 datakit.yaml 文件中，ConfigMap 资源中增加 controller-manager.conf。

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:    
    #### controller-manager  ## 下面是新增部分
    controller-manager.conf: |-    
        [[inputs.prom]]
          ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
          ## 文件路径各个操作系统下不同
          ## Windows example: C:\\Users
          ## UNIX-like example: /usr/local/
          urls = ["https://172.16.0.229:10257/metrics"]

          ## 采集器别名
          source = "prom-controller-manager"

          ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
          # 默认只采集 counter 和 gauge 类型的指标
          # 如果为空，则不进行过滤
          metric_types = ["counter", "gauge"]

          ## 指标名称过滤
          # 支持正则，可以配置多个，即满足其中之一即可
          # 如果为空，则不进行过滤
          #metric_name_filter = [""]

          ## 指标集名称前缀
          # 配置此项，可以给指标集名称添加前缀
          #measurement_prefix = ""

          ## 指标集名称
          # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
          # 如果配置measurement_name, 则不进行指标名称的切割
          # 最终的指标集名称会添加上measurement_prefix前缀
          measurement_name = "prom_controller_manager"

          ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
          interval = "60s"

          ## 过滤tags, 可配置多个tag
          # 匹配的tag将被忽略
          tags_ignore = ["action","build_date","clusterCIDR","code","compiler","completion_mode","git_commit","git_tree_state","git_version","go_version","major","method","minor","name","operation","platform","plugin_name","result","status","storage_class","username","version","volume_mode"]
          metric_name_filter = ["service_controller_rate_limiter_use","deployment_controller_rate_limiter_use","daemon_controller_rate_limiter_use","replicaset_controller_rate_limiter_use","cronjob_controller_rate_limiter_use","job_controller_rate_limiter_use","serviceaccount_controller_rate_limiter_use","endpoint_controller_rate_limiter_use","replication_controller_rate_limiter_use","gc_controller_rate_limiter_use","serviceaccount_tokens_controller_rate_limiter_use","token_cleaner_rate_limiter_use","node_ipam_controller_rate_limiter_use","node_collector_unhealthy_nodes_in_zone","job_controller_job_finished_total","process_resident_memory_bytes","process_cpu_seconds_total","go_goroutines"]

          ## TLS 配置
          tls_open = true
          #tls_ca = ""
          #tls_cert = ""
          #tls_key = ""

          ## 自定义指标集名称
          # 可以将包含前缀prefix的指标归为一类指标集
          # 自定义指标集名称配置优先measurement_name配置项
          #[[inputs.prom.measurements]]
          #  prefix = ""
          #  name = ""

          ## 自定义认证方式，目前仅支持 Bearer Token
          [inputs.prom.auth]
           type = "bearer_token"
          # token = "xxxxxxxx"
           token_file = "/var/run/secrets/kubernetes.io/serviceaccount/token"

          ## 自定义Tags
          [inputs.prom.tags]
            instance = "172.16.0.229:10257"   
```

参数说明：

- urls：controller-manager  metrics 地址

- source：采集器别名
- metric_types：指标类型过滤
- metric_name_filter：指标名称过滤
- measurement_prefix：指标集名称前缀
- measurement_name：指标集名称
- interval：采集间隔
- tags_ignore:  忽略的 tag
- metric_name_filter:  保留的指标名
- tls_open：是否忽略安全验证 (如果是 https，请设置为 true，并设置相应证书)，此处为 true
- tls_ca：ca 证书路径
- type：自定义认证方式，controller manager 使用 bearer_token 认证
-  token_file：认证文件路径
- [inputs.prom.tags]：请参考插件标签

2、 挂载 controller-manager.conf

在 datakit.yaml 文件的 volumeMounts 下面增加下面内容。

```
        - mountPath: /usr/local/datakit/conf.d/prom/controller-manager.conf
          name: datakit-conf
          subPath: controller-manager.conf
```

3、 重启 DataKit 

```
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```


指标预览

![1651903198(1).png](../imgs/kubernetes_controller_manager-1.png)

#### 插件标签 (必选）

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值

- 以下示例配置完成后，controller-manager 指标都会带有 app = oa 的标签，可以进行快速查询
- 采集 controller-manager 指标，必填的 key 是 instance，值是 controller-manager 的地址

    
```
          ## 自定义Tags
          [inputs.prom.tags]
            instance = "172.16.0.229:10257"   
```

重启datakit

```
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## 场景视图

<场景 - 新建仪表板 - 内置模板库 - Kubernetes Controller Manager 监控视图>

## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.{{.InputName}}.tags]` 指定其它标签：

``` toml
 [inputs.{{.InputName}}.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```

{{ range $i, $m := .Measurements }}

### `{{$m.Name}}`

-  标签

{{$m.TagsMarkdownTable}}

- 指标列表

{{$m.FieldsMarkdownTable}}

{{ end }}

## 常见问题排查

- [无数据上报排查](why-no-data.md)

## 进一步阅读

- [DataFlux Tag 应用最佳实践](/best-practices/guance-skill/tag.md)
