# Etcd
---

## 视图预览

Etcd 性能指标展示，包括接收 gRPC 客户端的总字节数、发送 gRPC 客户端的总字节数、领导者是否存在、领导者变更次数、当前处理提案的数量等。

![image](../imgs/etcd1.png)

## 版本支持

操作系统支持：Linux

## 安装部署

说明：示例 Etcd 版本为 etcd-v3.4.13(CentOS)，各个不同版本指标可能存在差异。

### 前置条件

- Etcd 所在服务器 <[安装 DataKit](../../datakit/datakit-install.md)>
- 检查是否能正常收集数据，默认的 metrics 接口是 http://localhost:2379/metrics

```
curl http://127.0.0.1:2379/metrics
```

![image](../imgs/etcd2.png)

### 配置实施

#### 二进制安装

通过二进制方式安装的 Etcd，推荐在宿主机上部署 DataKit，使用 [http://127.0.0.1:2379/metrics](http://127.0.0.1:2379/metrics) 采集指标数据。
**指标采集 (必选)**

1、 开启 Etcd 插件，复制 sample 文件

```
cd /usr/local/datakit/conf.d/etcd
cp etcd.conf.sample etcd.conf
```

2、 修改 `etcd.conf` 配置文件

```
vi etcd.conf
```

```
      [[inputs.prom]]
        ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
        ## 文件路径各个操作系统下不同
        ## Windows example: C:\\Users
        ## UNIX-like example: /usr/local/
        url = "http://172.16.0.229:2379/metrics"

      	## 采集器别名
      	source = "prom-etcd"

        ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
        # 默认只采集 counter 和 gauge 类型的指标
        # 如果为空，则不进行过滤
        metric_types = ["counter", "gauge"]

        ## 指标名称过滤
        # 支持正则，可以配置多个，即满足其中之一即可
        # 如果为空，则不进行过滤
        metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]

        ## 指标集名称前缀
        # 配置此项，可以给指标集名称添加前缀
        measurement_prefix = ""

        ## 指标集名称
        # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
        # 如果配置measurement_name, 则不进行指标名称的切割
        # 最终的指标集名称会添加上measurement_prefix前缀
        # measurement_name = "prom"

        ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
        interval = "60s"

        ## 过滤tags, 可配置多个tag
        # 匹配的tag将被忽略
        # tags_ignore = ["xxxx"]

        ## TLS 配置
        tls_open = false
        # tls_ca = "/tmp/ca.crt"
        #tls_cert = "/etc/kubernetes/pki/etcd/peer.crt"
        #tls_key = "/etc/kubernetes/pki/etcd/peer.key"

        ## 自定义指标集名称
        # 可以将包含前缀prefix的指标归为一类指标集
        # 自定义指标集名称配置优先measurement_name配置项
        [[inputs.prom.measurements]]
          prefix = "etcd_"
          name = "etcd"

        ## 自定义认证方式，目前仅支持 Bearer Token
        # [inputs.prom.auth]
        # type = "bearer_token"
        # token = "xxxxxxxx"
        # token_file = "/tmp/token"

        ## 自定义Tags
        [inputs.prom.tags]
          instance = "172.16.0.229:2379"


```

参数说明

- urls：etcd 内置的 metrics 接口地址，多个用逗号分割
- source：采集器别名
- metric_types：指标类型过滤
- metric_name_filter：指标名称过滤
- measurement_prefix：指标集名称前缀
- measurement_name：指标集名称
- interval：采集间隔
- tags_ignore：匹配的 tag 将被忽略
- metric_name_filter: 保留的指标名
- tls_open：是否忽略安全验证 (如果是 https，请设置为 true，并设置相应证书)
- prefix：自定义指标前缀
- name：自定义指标集名称，即把 prefix 开头的指标归为此 name 的指标集

3、 重启 DataKit

```
systemctl restart datakit
```

指标预览

![image](../imgs/etcd3.png)

**插件标签 (非必选)**

参数说明

- 该配置为自定义标签，可以填写任意 key-value 值
- 以下示例配置完成后，所有 Etcd 指标都会带有 `app = "oa"` 的标签，可以进行快速查询。
- 相关文档 <[TAG 在观测云中的最佳实践](../../best-practices/insight/tag.md)>

```
  ## 自定义Tags
  [inputs.prom.tags]
    instance = "172.16.0.229:2379"
```

重启 DataKit

```
systemctl restart datakit
```

#### Kubernetes 集群

在 Kubernetes 集群，推荐使用 Daemonset 部署 DataKit，通过证书的方式访问 Etc。<br />
下面的部署中，[https://172.16.0.229:2379/metrics](https://172.16.0.229:2379/metrics) 是 Etcd 的一个节点。

1、 下载 `datakit.yaml`

登录『[观测云](https://console.guance.com/)』，点击『集成』模块，再点击左上角『DataKit』，选择『Kubernetes』，下载 `datakit.yaml` ，然后按指引完成部署的配置。

2、 开启 Etcd 采集器

在 Kubernetes 集群，开通采集器需要使用 ConfigMap 定义配置，然后挂载到 DataKit 相应目录。<br />
采集使用了 HTTPS 协议，需要用到证书，下面是 Kubeadmin 部署的 Kubernetes 集群使用证书的配置方式。

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### etcd
  etcd.conf: |-
    [[inputs.prom]]
      ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
      ## 文件路径各个操作系统下不同
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "https://172.16.0.229:2379/metrics"

    	## 采集器别名
    	source = "prom-etcd"

      ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
      # 默认只采集 counter 和 gauge 类型的指标
      # 如果为空，则不进行过滤
      metric_types = ["counter", "gauge"]

      ## 指标名称过滤
      # 支持正则，可以配置多个，即满足其中之一即可
      # 如果为空，则不进行过滤
      metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]

      ## 指标集名称前缀
      # 配置此项，可以给指标集名称添加前缀
      measurement_prefix = ""

      ## 指标集名称
      # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
      # 如果配置measurement_name, 则不进行指标名称的切割
      # 最终的指标集名称会添加上measurement_prefix前缀
      # measurement_name = "prom"

      ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "60s"

      ## 过滤tags, 可配置多个tag
      # 匹配的tag将被忽略
      # tags_ignore = ["xxxx"]

      ## TLS 配置
      tls_open = true
      # tls_ca = "/tmp/ca.crt"
      tls_cert = "/etc/kubernetes/pki/etcd/peer.crt"
      tls_key = "/etc/kubernetes/pki/etcd/peer.key"

      ## 自定义指标集名称
      # 可以将包含前缀prefix的指标归为一类指标集
      # 自定义指标集名称配置优先measurement_name配置项
      [[inputs.prom.measurements]]
        prefix = "etcd_"
        name = "etcd"

      ## 自定义认证方式，目前仅支持 Bearer Token
      # [inputs.prom.auth]
      # type = "bearer_token"
      # token = "xxxxxxxx"
      # token_file = "/tmp/token"

      ## 自定义Tags
      [inputs.prom.tags]
        instance = "172.16.0.229:2379"
```

```
        volumeMounts:
        - mountPath: /usr/local/datakit/conf.d/etcd/etcd.conf
          name: datakit-conf
          subPath: etcd.conf
```

3、 完整 `datakit.yaml`

```yaml
#apiVersion: v1
#kind: Namespace
#metadata:
#  name: datakit
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
  - apiGroups:
      - rbac.authorization.k8s.io
    resources:
      - clusterroles
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - ""
    resources:
      - nodes
      - nodes/proxy
      - namespaces
      - pods
      - pods/log
      - events
      - services
      - endpoints
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - apps
    resources:
      - deployments
      - daemonsets
      - statefulsets
      - replicasets
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - batch
    resources:
      - jobs
      - cronjobs
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - guance.com
    resources:
      - datakits
    verbs:
      - get
      - list
  - apiGroups:
      - metrics.k8s.io
    resources:
      - pods
      - nodes
    verbs:
      - get
      - list
  - nonResourceURLs: ["/metrics"]
    verbs: ["get"]

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: datakit
  namespace: datakit

---
apiVersion: v1
kind: Service
metadata:
  name: datakit-service
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - protocol: TCP
      port: 9529
      targetPort: 9529

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: datakit
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: datakit
subjects:
  - kind: ServiceAccount
    name: datakit
    namespace: datakit

---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: daemonset-datakit
  name: datakit
  namespace: datakit
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: daemonset-datakit
  template:
    metadata:
      labels:
        app: daemonset-datakit
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
        - env:
            - name: HOST_IP
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: status.hostIP
            - name: ENV_K8S_NODE_NAME
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: spec.nodeName
            - name: ENV_DATAWAY
              value: https://openway.guance.com?token=tkn_9a49a7e9343c432eb0b99a297401c3bb
            - name: ENV_GLOBAL_HOST_TAGS
              value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-containerd
            - name: ENV_DEFAULT_ENABLED_INPUTS
              value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ebpf,profile
            - name: ENV_ENABLE_ELECTION
              value: enable
            - name: ENV_NAMESPACE # 选举用的
              value: k8s-containerd
            - name: ENV_GLOBAL_ELECTION_TAGS # 只对选举类的tag有用
              value: cluster_name_k8s=k8s-containerd
            #- name: ENV_LOG
            #  value: stdout
            - name: ENV_HTTP_LISTEN
              value: 0.0.0.0:9529
            - name: ENV_LOG_LEVEL
              value: debug
          image: pubrepo.jiagouyun.com/datakit/datakit:1.4.12
          imagePullPolicy: Always
          name: datakit
          ports:
            - containerPort: 9529
              hostPort: 9529
              name: port
              protocol: TCP
          securityContext:
            privileged: true
          volumeMounts:
            - mountPath: /var/run
              name: run
            - mountPath: /var/lib
              name: lib
            - mountPath: /var/log
              name: log
            - mountPath: /usr/local/datakit/conf.d/container/container.conf
              name: datakit-conf
              subPath: container.conf
            - mountPath: /usr/local/datakit/conf.d/etcd/etcd.conf
              name: datakit-conf
              subPath: etcd.conf
            - mountPath: /usr/lib
              name: usrlib
            - mountPath: /etc
              name: etc

            - mountPath: /rootfs
              name: rootfs
            - mountPath: /sys/kernel/debug
              name: debugfs
          #- mountPath: /usr/local/datakit/conf.d/db/mysql.conf
          #  name: datakit-conf
          #  subPath: mysql.conf
          #  readOnly: true
          #- mountPath: /usr/local/datakit/conf.d/db/redis.conf
          #  name: datakit-conf
          #  subPath: redis.conf
          #  readOnly: true
          workingDir: /usr/local/datakit
      hostIPC: true
      hostPID: true
      restartPolicy: Always
      serviceAccount: datakit
      serviceAccountName: datakit
      tolerations:
        - operator: Exists
      volumes:
        - configMap:
            name: datakit-conf
          name: datakit-conf
        - hostPath:
            path: /var/run
          name: run
        - hostPath:
            path: /var/lib
          name: lib
        - hostPath:
            path: /var/log
          name: log
        - hostPath:
            path: /usr/lib
          name: usrlib
        - hostPath:
            path: /etc
          name: etc
        - hostPath:
            path: /
          name: rootfs
        - hostPath:
            path: /sys/kernel/debug
          name: debugfs
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
  #### container
  container.conf: |-
    [inputs.container]
      docker_endpoint = "unix:///var/run/docker.sock"
      containerd_address = "/var/run/containerd/containerd.sock"

      enable_container_metric = true
      enable_k8s_metric = true
      enable_pod_metric = true

      ## Containers logs to include and exclude, default collect all containers. Globs accepted.
      container_include_log = []
      container_exclude_log = ["image:*"]
      #container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

      exclude_pause_container = true

      ## Removes ANSI escape codes from text strings
      logging_remove_ansi_escape_codes = false

      kubernetes_url = "https://kubernetes.default:443"

      ## Authorization level:
      ##   bearer_token -> bearer_token_string -> TLS
      ## Use bearer token for authorization. ('bearer_token' takes priority)
      ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
      ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
      bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
      # bearer_token_string = "<your-token-string>"

      [inputs.container.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"

  etcd.conf: |-
    [[inputs.prom]]
      ## Exporter地址或者文件路径（Exporter地址要加上网络协议http或者https）
      ## 文件路径各个操作系统下不同
      ## Windows example: C:\\Users
      ## UNIX-like example: /usr/local/
      url = "https://172.16.0.229:2379/metrics"

    	## 采集器别名
    	source = "prom-etcd"

      ## 指标类型过滤, 可选值为 counter, gauge, histogram, summary
      # 默认只采集 counter 和 gauge 类型的指标
      # 如果为空，则不进行过滤
      metric_types = ["counter", "gauge"]

      ## 指标名称过滤
      # 支持正则，可以配置多个，即满足其中之一即可
      # 如果为空，则不进行过滤
      metric_name_filter = ["etcd_server_proposals","etcd_server_leader","etcd_server_has","etcd_network_client"]

      ## 指标集名称前缀
      # 配置此项，可以给指标集名称添加前缀
      measurement_prefix = ""

      ## 指标集名称
      # 默认会将指标名称以下划线"_"进行切割，切割后的第一个字段作为指标集名称，剩下字段作为当前指标名称
      # 如果配置measurement_name, 则不进行指标名称的切割
      # 最终的指标集名称会添加上measurement_prefix前缀
      # measurement_name = "prom"

      ## 采集间隔 "ns", "us" (or "µs"), "ms", "s", "m", "h"
      interval = "60s"

      ## 过滤tags, 可配置多个tag
      # 匹配的tag将被忽略
      # tags_ignore = ["xxxx"]

      ## TLS 配置
      tls_open = true
      # tls_ca = "/tmp/ca.crt"
      tls_cert = "/etc/kubernetes/pki/etcd/peer.crt"
      tls_key = "/etc/kubernetes/pki/etcd/peer.key"

      ## 自定义指标集名称
      # 可以将包含前缀prefix的指标归为一类指标集
      # 自定义指标集名称配置优先measurement_name配置项
      [[inputs.prom.measurements]]
        prefix = "etcd_"
        name = "etcd"

      ## 自定义认证方式，目前仅支持 Bearer Token
      # [inputs.prom.auth]
      # type = "bearer_token"
      # token = "xxxxxxxx"
      # token_file = "/tmp/token"

      ## 自定义Tags
      [inputs.prom.tags]
        instance = "172.16.0.229:2379"
```

**注意**：由于版本不同，请下载最新 `datakit.yaml` ，并结合自己开通的采集器情况做相应改动。

#### 指标预览

![image](../imgs/etcd4.png)

## 场景视图

<场景 - 新建仪表板 - 模板库 - 系统视图 - Etcd 监控视图>

## [指标详解](/datakit/etcd/#measurements)

## 最佳实践

暂无

## 故障排查

<[无数据上报排查](../../datakit/why-no-data.md)>
