---
title     : 'Kubernetes 审计日志采集'
summary   : 'Kubernetes 审计日志采集'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'kubernetes Audit'
    path  : 'dashboard/zh/kubernetes_audit'
monitor   :
  - desc  : '暂无'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Kubernetes 审计日志采集
<!-- markdownlint-enable -->

Kubernetes 审计（Audit）提供了安全相关的时序操作记录（包括时间、来源、操作结果、发起操作的用户、操作的资源以及请求/响应的详细信息等）。

## 配置 {#config}

### 前置条件

- [x] 安装 K8S 环境
- [x] 安装 [DataKit](../datakit/datakit-daemonset-deploy.md)

### 开启审计日志策略

❗如已开启，请忽略

以 Kubernetes `1.24` 为例，开启审计日志策略


<!-- markdownlint-disable MD031 MD032 MD009 MD034 MD046-->
- 登陆主节点服务器

> `cd /etc/kubernetes`

- 新增 audit-policy.yml

???- info "audit-policy.yml"
    ```yaml        
    # Copyright © 2022 sealos.
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    #     http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.

    apiVersion: audit.k8s.io/v1 # This is required.
    kind: Policy
    # Don't generate audit events for all requests in RequestReceived stage.
    omitStages:
    - "RequestReceived"
    rules:
    # The following requests were manually identified as high-volume and low-risk,
    # so drop them.
    - level: None
        users: [ "system:kube-proxy" ]
        verbs: [ "watch" ]
        resources:
        - group: "" # core
            resources: [ "endpoints", "services" ]
    - level: None
        users: [ "system:unsecured" ]
        namespaces: [ "kube-system" ]
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "configmaps" ]
    - level: None
        users: [ "kubelet" ] # legacy kubelet identity
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "nodes" ]
    - level: None
        userGroups: [ "system:nodes" ]
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "nodes" ]
    - level: None
        users:
        - system:kube-controller-manager
        - system:kube-scheduler
        - system:serviceaccount:kube-system:endpoint-controller
        verbs: [ "get", "update" ]
        namespaces: [ "kube-system" ]
        resources:
        - group: "" # core
            resources: [ "endpoints" ]
    - level: None
        users: [ "system:apiserver" ]
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "namespaces" ]
    # Don't log these read-only URLs.
    - level: None
        nonResourceURLs:
        - /healthz*
        - /version
        - /swagger*
    # Don't log events requests.
    - level: None
        resources:
        - group: "" # core
            resources: [ "events" ]
    # Secrets, ConfigMaps, and TokenReviews can contain sensitive & binary data,
    # so only log at the Metadata level.
    - level: Metadata
        resources:
        - group: "" # core
            resources: [ "secrets", "configmaps" ]
        - group: authentication.k8s.io
            resources: [ "tokenreviews" ]
    # Get repsonses can be large; skip them.
    - level: Request
        verbs: [ "get", "list", "watch" ]
        resources:
        - group: "" # core
        - group: "admissionregistration.k8s.io"
        - group: "apps"
        - group: "authentication.k8s.io"
        - group: "authorization.k8s.io"
        - group: "autoscaling"
        - group: "batch"
        - group: "certificates.k8s.io"
        - group: "extensions"
        - group: "networking.k8s.io"
        - group: "policy"
        - group: "rbac.authorization.k8s.io"
        - group: "settings.k8s.io"
        - group: "storage.k8s.io"
    # Default level for known APIs
    - level: RequestResponse
        resources:
        - group: "" # core
        - group: "admissionregistration.k8s.io"
        - group: "apps"
        - group: "authentication.k8s.io"
        - group: "authorization.k8s.io"
        - group: "autoscaling"
        - group: "batch"
        - group: "certificates.k8s.io"
        - group: "extensions"
        - group: "networking.k8s.io"
        - group: "policy"
        - group: "rbac.authorization.k8s.io"
        - group: "settings.k8s.io"
        - group: "storage.k8s.io"
        - group: "autoscaling.alibabacloud.com"
    # Default level for all other requests.
    - level: Metadata
    ```
<!-- markdownlint-enable -->

💡对应的策略信息可以按照实际需求进行调整。

### API Server 开启审计日志

❗如已开启，请忽略

进入目录 `/etc/kubernetes/manifests`，先备份 `kube-apiserver.yaml` 文件，并且备份的文件不能放在 `/etc/kubernetes/manifests/` 下，调整文件内容

- 在 `spec.containers.command` 下添加命令：

```yaml
  - command:
    - kube-apiserver
    - --advertise-address=10.0.16.204
    - --allow-privileged=true
    - --audit-log-format=json
    - --audit-log-maxage=7
    - --audit-log-maxbackup=10
    - --audit-log-maxsize=100
    - --audit-log-path=/var/log/kubernetes/audit.log
    - --audit-policy-file=/etc/kubernetes/audit-policy.yml
```

- 在`spec.containers.volumeMounts`下添加：

```yaml
    - mountPath: /etc/kubernetes
      name: audit
    - mountPath: /var/log/kubernetes
      name: audit-log
```

- 在`spec.volumes`下添加：

```yaml
  - hostPath:
      path: /etc/kubernetes
      type: DirectoryOrCreate
    name: audit
  - hostPath:
      path: /var/log/kubernetes
      type: DirectoryOrCreate
    name: audit-log
```

- 生效

API Server 被改动后，会自动重启，耐心等待几分钟即可。

- 验证

执行以下命令，看看是否有 `audit.log` 文件产生，如果有则证明已经生效。

> `ls /var/log/kubernetes`


### 采集 K8S 审计日志

K8S 审计日志存储在对应`master`节点的`/var/log/kubernetes`目录下，这里采用 `annotation`的方式进行采集

- 创建 pod：k8s-audit-log.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: kube-audit-log
  annotations:
        datakit/logs: |
          [
            {
              "disable": false,
              "type": "file",
              "path":"/var/log/kubernetes/audit.log",
              "source":  "k8s-audit",
              "tags" : {
                "atype": "kube-audit-log"
              }
            }
          ]

spec:
  containers:
  - name: kube-audit-log
    image: busybox
#    command: ["sleep", "1"]
    args:
    - /bin/sh
    - -c
    - >
      i=0;
      while true;
      do
        i=$((i+1));
        sleep 10;
      done
    volumeMounts:
    - mountPath: /var/log/kubernetes
      name: datakit-vol-opt
  volumes:
  - name: datakit-vol-opt
    hostPath: 
      path: /var/log/kubernetes
  nodeSelector:
     kubernetes.io/hostname: k8s-master
  tolerations:
  - key: "node-role.kubernetes.io/master"
    operator: "Exists"
    effect: "NoSchedule"
  - key: "node-role.kubernetes.io/control-plane"
    operator: "Exists"
    effect: "NoSchedule"
```

❗需要注意当前 pod 只能运行在 master 节点上。

- 执行

```shell
kubectl apply -f k8s-audit-log.yaml 
```

- 查看

等几分钟后就可以在观测云上查看到对应的日志。由于是`json`格式，观测云支持通过`@+json`字段名的方式进行搜索，如`@verb:update⁠`。

### 审计日志字段提取

审计日志采集上来后，通过观测云 `pipeline` 的能力，可以对审计日志关键字段进行提取，从而对审计日志进行进一步数据分析

- 在观测云，`日志` - `pipeline` - `新建`
- 选择对应的日志来源 `k8s-audit`
- `Pipeline` 名称：`kubelet-audit`
- 定义解析规则

```python
abc = load_json(_)

add_key(kind, abc["kind"])
add_key(level, abc["level"])
add_key(stage, abc["stage"])
add_key(verb, abc["verb"])
add_key(auditID, abc["auditID"])
add_key(username, abc["user"]["username"])
add_key(responseCode, abc["responseStatus"]["code"])
if abc["responseStatus"]["code"]==200 {
  add_key(status, "OK")
}else{
  add_key(status, "FAIL")
}
add_key(sourceIP_0,abc["sourceIPs"][0])
  
add_key(namespace,abc["objectRef"]["namespace"])
add_key(node,abc["objectRef"]["name"])
```

- 点击获取脚本测试
- 保存
