# 线下环境部署手册
---

## 1 前言
### 1.1 产品简介
“观测云”是一款旨在解决云计算，以及云原生时代系统为每一个完整的应用构建全链路的可观测性的云服务平台。“观测云”是由驻云科技自2018年以来全力打造的产品，产品的目标是为中国的广大基于云计算的开发项目组提供服务，相较于复杂多变的开源产品，如ELK，Prometheus，Grafana，Skywalking等，“观测云”不单纯的只是提供一种监控类的产品，更重要的是提供整体可观测性的服务，我们除了在底层存储和系统架构上是一体化的基础上，也把所有关于云计算及云原生相关的技术栈进行了完整的分析和解构，任何项目团队可以非常轻松的使用我们的产品，无需再投入太多的精力去研究或者改造不成熟的开源产品，同时“观测云”是以服务方式，按需按量的方式收取费用，完全根据用户产生的数据量收取费用，无需投入硬件，同时对于付费客户，我们还会建立专业的服务团队，帮助客户构建基于数据的核心保障体系，具有实时性、灵活性、易扩展、易部署等特点，支持云端 SaaS 和本地部署模式。
### 1.2 本文档说明
本文档主要以在线下部署（包括但不限于物理服务器、IDC机房），介绍从资源规划、配置开始，到部署观测云、运行的完整步骤。

**说明：**

- 本文档以 **dataflux.cn** 为主域名示例，实际部署替换为相应的域名。

### 1.3 关键词
| **词条** | **说明** |
| --- | --- |
| Launcher | 用于部署安装 观测云 的 WEB 应用，根据 Launcher 服务的引导步骤来完成 观测云 的安装与升级 |
| 运维操作机 | 安装了 kubectl，与目标 Kubernetes 集群在同一网络的运维机器 |
| 部署操作机 | 在浏览器访问 launcher 服务来完成 观测云 引导、安装、调试的机器 |
| kubectl | Kubernetes 的命令行客户端工具，安装在运维操作机上 |

### 1.4 部署架构
![](img/8.deployment_1.png)

## 2 资源准备
### 2.1 资源清单

| **用途** | **资源类型** | **最低规格** | **推荐规格** | **数量** | **备注** |
| --- | --- | --- | --- | --- | --- |
| **Kubernetes 集群** | 物理服务器&#124;虚拟机 | 4C8GB 100GB | 8C16GB  100GB | 3 | k8s集群Master节点&#124;Etcd集群 **注：若是为虚拟机需适当提高资源规格** |
|  | 物理服务器&#124;虚拟机 | 4C8GB 100GB | 8C16GB  100GB | 4 | k8s集群worker节点，承载观测云应用、k8s组件、基础组件服务Mysql 5.7.18、Redis 6.0.6 |
|  | 物理服务器&#124;虚拟机 | 2C4GB  100GB | 4C8GB    200GB | 1 | 【可选】用于部署反向代理服务器部署，代理到ingress 边缘节点 **注： 出于安全考虑不直接将集群边缘节点直接暴露** |
|  | 物理服务器&#124;虚拟机 | 2C4GB 200G B | 4C8GB 1TB 高性能磁盘 | 1 | 部署网络文件系统、网络存储服务，默认NFS |
| **DataWay** | 物理服务器&#124;虚拟机 | 2C4GB  100GB | 4C8GB    100GB | 1 | 用户部署 DataWay |
| **ElasticSearch** | 物理服务器&#124;虚拟机 | 4C8GB 1TB | 8C16G   1TB | 3 | 独立二进制部署ES集群 版本：7.4+（**推荐7.10**） **注：需要开启密码认证，安装匹配版本分词插件 analysis-ik** |
| **InfluxDB** | 物理服务器&#124;虚拟机 | 4C8GB  500GB | 8C16G 1TB | 1 | k8s集群节点、承载Influxdb服务器 版本：1.7.8 |
| **其他** | 邮件服务器/短信 | - | - | 1 | 短信网关，邮件服务器，告警通道 |
|  | 已备案正式通配符域名 | - | - | 1 | 主域名需备案 |
|  | SSL/TLS证书 | 通配符域名证书 | 通配符域名证书 | 1 | 保障站点安全 |

注：

1. “最低配置” 适合 POC 场景部署，只作功能验证，不适合作为生产环境使用。
1. 作为生产部署以实际接入数据量做评估，接入的数据量越多，InfluxDB、Elasticsearch 的存储与规格配置相应也需要越高。

### 2.2 创建资源
#### 2.2.1 kubernetes 集群资源创建

**重要！！！**

- 部署之前需要给集群几点打上对应的节点标签，标签和yaml中nodeSelector 字段对应，否则通过实例yaml部署会报错。请仔细查看实例yaml文件。
- NFS 服务器节点需要安装server端和客户端，并验证服务状况，别的集群节点需要安装nfs客户端，并验挂载情况。
- 需要提前准备好所需镜像，或者使用阿里的镜像站点拉取镜像。

kubernetes 集群部署参考 [https://kubernetes.io/zh/docs/home/](https://kubernetes.io/zh/docs/home/)
集群资源创建完成后进行集群功能验证，确保集群在正常运行。包括节点状态、集群状态、服务解析情况等。参考下图：

![](img/8.deployment_2.png)

默认情况下 kube-proxy 使用iptables 模式，该模式下宿主机无法ping通 svc 地址，ipvs 模式下可以直接ping通 svc 地址

![](img/8.deployment_3.png)

在未使用 Node Local  DNS 配置时，容器获取的 dns 服务地址和 svc 地址段一致
kubernetes ingress  组件部署参考 [https://github.com/kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx)

```yaml
# 某些k8s版本无法创建ingress资源，需要删除资源执行命令 kubectl  delete  validatingwebhookconfigurations.admissionregistration.k8s.io  ingress-nginx-admission
apiVersion: v1
kind: Namespace
metadata:
  name: ingress-nginx
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx

---
# Source: ingress-nginx/templates/controller-serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx
  namespace: ingress-nginx
automountServiceAccountToken: true
---
# Source: ingress-nginx/templates/controller-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx-controller
  namespace: ingress-nginx
data:
---
# Source: ingress-nginx/templates/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
  name: ingress-nginx
rules:
  - apiGroups:
      - ''
    resources:
      - configmaps
      - endpoints
      - nodes
      - pods
      - secrets
    verbs:
      - list
      - watch
  - apiGroups:
      - ''
    resources:
      - nodes
    verbs:
      - get
  - apiGroups:
      - ''
    resources:
      - services
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - extensions
      - networking.k8s.io   # k8s 1.14+
    resources:
      - ingresses
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - ''
    resources:
      - events
    verbs:
      - create
      - patch
  - apiGroups:
      - extensions
      - networking.k8s.io   # k8s 1.14+
    resources:
      - ingresses/status
    verbs:
      - update
  - apiGroups:
      - networking.k8s.io   # k8s 1.14+
    resources:
      - ingressclasses
    verbs:
      - get
      - list
      - watch
---
# Source: ingress-nginx/templates/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
  name: ingress-nginx
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ingress-nginx
subjects:
  - kind: ServiceAccount
    name: ingress-nginx
    namespace: ingress-nginx
---
# Source: ingress-nginx/templates/controller-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx
  namespace: ingress-nginx
rules:
  - apiGroups:
      - ''
    resources:
      - namespaces
    verbs:
      - get
  - apiGroups:
      - ''
    resources:
      - configmaps
      - pods
      - secrets
      - endpoints
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - ''
    resources:
      - services
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - extensions
      - networking.k8s.io   # k8s 1.14+
    resources:
      - ingresses
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - extensions
      - networking.k8s.io   # k8s 1.14+
    resources:
      - ingresses/status
    verbs:
      - update
  - apiGroups:
      - networking.k8s.io   # k8s 1.14+
    resources:
      - ingressclasses
    verbs:
      - get
      - list
      - watch
  - apiGroups:
      - ''
    resources:
      - configmaps
    resourceNames:
      - ingress-controller-leader-nginx
    verbs:
      - get
      - update
  - apiGroups:
      - ''
    resources:
      - configmaps
    verbs:
      - create
  - apiGroups:
      - ''
    resources:
      - events
    verbs:
      - create
      - patch
---
# Source: ingress-nginx/templates/controller-rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx
  namespace: ingress-nginx
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ingress-nginx
subjects:
  - kind: ServiceAccount
    name: ingress-nginx
    namespace: ingress-nginx
---
# Source: ingress-nginx/templates/controller-service-webhook.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx-controller-admission
  namespace: ingress-nginx
spec:
  type: ClusterIP
  ports:
    - name: https-webhook
      port: 443
      targetPort: webhook
  selector:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/component: controller
---
# Source: ingress-nginx/templates/controller-service.yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx-controller
  namespace: ingress-nginx
spec:
  type: NodePort
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: http
      nodePort: 31257
    - name: https
      port: 443
      protocol: TCP
      targetPort: http
      nodePort: 31256
  selector:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/component: controller
---
# Source: ingress-nginx/templates/controller-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: controller
  name: ingress-nginx-controller
  namespace: ingress-nginx
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: ingress-nginx
      app.kubernetes.io/instance: ingress-nginx
      app.kubernetes.io/component: controller
  revisionHistoryLimit: 10
  minReadySeconds: 0
  template:
    metadata:
      labels:
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/component: controller
    spec:
     
      tolerations:
      - key: ''
        operator: 'Exists'
      dnsPolicy: ClusterFirstWithHostNet
      hostNetwork: true
      containers:
        - name: controller
          image:  pollyduan/ingress-nginx-controller:v0.47.0
          imagePullPolicy: IfNotPresent
          lifecycle:
            preStop:
              exec:
                command:
                  - /wait-shutdown
          args:
            - /nginx-ingress-controller
            - --election-id=ingress-controller-leader
            - --ingress-class=nginx
            - --configmap=$(POD_NAMESPACE)/ingress-nginx-controller
            - --validating-webhook=:8443
            - --validating-webhook-certificate=/usr/local/certificates/cert
            - --validating-webhook-key=/usr/local/certificates/key
          securityContext:
            capabilities:
              drop:
                - ALL
              add:
                - NET_BIND_SERVICE
            runAsUser: 101
            allowPrivilegeEscalation: true
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: LD_PRELOAD
              value: /usr/local/lib/libmimalloc.so
          livenessProbe:
            failureThreshold: 5
            httpGet:
              path: /healthz
              port: 10254
              scheme: HTTP
            initialDelaySeconds: 10
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
          readinessProbe:
            failureThreshold: 3
            httpGet:
              path: /healthz
              port: 10254
              scheme: HTTP
            initialDelaySeconds: 10
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
            - name: https
              containerPort: 443
              protocol: TCP
            - name: webhook
              containerPort: 8443
              protocol: TCP
          volumeMounts:
            - name: webhook-cert
              mountPath: /usr/local/certificates/
              readOnly: true
          resources:
            requests:
              cpu: 100m
              memory: 90Mi
      nodeSelector:
        app02: ingress
      serviceAccountName: ingress-nginx
      terminationGracePeriodSeconds: 300
      volumes:
        - name: webhook-cert
          secret:
            secretName: ingress-nginx-admission
---
# Source: ingress-nginx/templates/admission-webhooks/validating-webhook.yaml
# before changing this value, check the required kubernetes version
# https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#prerequisites
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
  name: ingress-nginx-admission
webhooks:
  - name: validate.nginx.ingress.kubernetes.io
    matchPolicy: Equivalent
    rules:
      - apiGroups:
          - networking.k8s.io
        apiVersions:
          - v1beta1
        operations:
          - CREATE
          - UPDATE
        resources:
          - ingresses
    failurePolicy: Fail
    sideEffects: None
    admissionReviewVersions:
      - v1
      - v1beta1
    clientConfig:
      service:
        namespace: ingress-nginx
        name: ingress-nginx-controller-admission
        path: /networking/v1beta1/ingresses
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ingress-nginx-admission
  annotations:
    helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
  namespace: ingress-nginx
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: ingress-nginx-admission
  annotations:
    helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
rules:
  - apiGroups:
      - admissionregistration.k8s.io
    resources:
      - validatingwebhookconfigurations
    verbs:
      - get
      - update
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: ingress-nginx-admission
  annotations:
    helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ingress-nginx-admission
subjects:
  - kind: ServiceAccount
    name: ingress-nginx-admission
    namespace: ingress-nginx
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ingress-nginx-admission
  annotations:
    helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
  namespace: ingress-nginx
rules:
  - apiGroups:
      - ''
    resources:
      - secrets
    verbs:
      - get
      - create
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ingress-nginx-admission
  annotations:
    helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
  namespace: ingress-nginx
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ingress-nginx-admission
subjects:
  - kind: ServiceAccount
    name: ingress-nginx-admission
    namespace: ingress-nginx
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/job-createSecret.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: ingress-nginx-admission-create
  annotations:
    helm.sh/hook: pre-install,pre-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
  namespace: ingress-nginx
spec:
  template:
    metadata:
      name: ingress-nginx-admission-create
      labels:
        helm.sh/chart: ingress-nginx-3.33.0
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 0.47.0
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
    spec:
      containers:
        - name: create
          image: docker.io/jettech/kube-webhook-certgen:v1.5.1
          imagePullPolicy: IfNotPresent
          args:
            - create
            - --host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.$(POD_NAMESPACE).svc
            - --namespace=$(POD_NAMESPACE)
            - --secret-name=ingress-nginx-admission
          env:
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
      restartPolicy: OnFailure
      serviceAccountName: ingress-nginx-admission
      securityContext:
        runAsNonRoot: true
        runAsUser: 2000
---
# Source: ingress-nginx/templates/admission-webhooks/job-patch/job-patchWebhook.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: ingress-nginx-admission-patch
  annotations:
    helm.sh/hook: post-install,post-upgrade
    helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
  labels:
    helm.sh/chart: ingress-nginx-3.33.0
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/version: 0.47.0
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/component: admission-webhook
  namespace: ingress-nginx
spec:
  template:
    metadata:
      name: ingress-nginx-admission-patch
      labels:
        helm.sh/chart: ingress-nginx-3.33.0
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 0.47.0
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
    spec:
      containers:
        - name: patch
          image: docker.io/jettech/kube-webhook-certgen:v1.5.1
          imagePullPolicy: IfNotPresent
          args:
            - patch
            - --webhook-name=ingress-nginx-admission
            - --namespace=$(POD_NAMESPACE)
            - --patch-mutating=false
            - --secret-name=ingress-nginx-admission
            - --patch-failure-policy=Fail
          env:
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
      restartPolicy: OnFailure
      serviceAccountName: ingress-nginx-admission
      securityContext:
        runAsNonRoot: true
        runAsUser: 2000

```
kubernetes  nfs subdir external provisioner  组件部署参考 [https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)

```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: nfs-client-provisioner-runner
rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["persistentvolumes"]
    verbs: ["get", "list", "watch", "create", "delete"]
  - apiGroups: [""]
    resources: ["persistentvolumeclaims"]
    verbs: ["get", "list", "watch", "update"]
  - apiGroups: ["storage.k8s.io"]
    resources: ["storageclasses"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["create", "update", "patch"]
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: run-nfs-client-provisioner
subjects:
  - kind: ServiceAccount
    name: nfs-client-provisioner
    # replace with namespace where provisioner is deployed
    namespace: default
roleRef:
  kind: ClusterRole
  name: nfs-client-provisioner-runner
  apiGroup: rbac.authorization.k8s.io
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: leader-locking-nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
rules:
  - apiGroups: [""]
    resources: ["endpoints"]
    verbs: ["get", "list", "watch", "create", "update", "patch"]
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: leader-locking-nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
subjects:
  - kind: ServiceAccount
    name: nfs-client-provisioner
    # replace with namespace where provisioner is deployed
    namespace: default
roleRef:
  kind: Role
  name: leader-locking-nfs-client-provisioner
  apiGroup: rbac.authorization.k8s.io

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-client-provisioner
  labels:
    app: nfs-client-provisioner
  # replace with namespace where provisioner is deployed
  namespace: default
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: nfs-client-provisioner
  template:
    metadata:
      labels:
        app: nfs-client-provisioner
    spec:
      serviceAccountName: nfs-client-provisioner
      containers:
        - name: nfs-client-provisioner
          image: dyrnq/nfs-subdir-external-provisioner:v4.0.2
          volumeMounts:
            - name: nfs-client-root
              mountPath: /persistentvolumes
          env:
            - name: PROVISIONER_NAME
              value: k8s-sigs.io/nfs-subdir-external-provisioner
            - name: NFS_SERVER
              value: 10.90.14.175   # 填写实际nfs server
            - name: NFS_PATH
              value: /home/zhuyun   # 实际共享目录       
      volumes:
        - name: nfs-client-root
          nfs:
            server: 10.90.14.175 # 填写实际nfs server地址
            path: /home/zhuyun  # 实际共享目录
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: df-nfs-storage
  annotations:
    storageclass.beta.kubernetes.io/is-default-class: "true"  # 配置该 storageclass 为默认
    storageclass.kubernetes.io/is-default-class: "true"
provisioner: k8s-sigs.io/nfs-subdir-external-provisioner # or choose another name, must match deployment's env PROVISIONER_NAME'
allowVolumeExpansion: true 
reclaimPolicy: Delete
parameters:
  archiveOnDelete: "false"            

```


#### 2.2.2 基础资源及中间件资源创建
##### **Mysql、Redis、InfluxDB、Elasticsearch、NFS 存储**按配置要求创建。
### 2.3 资源配置
#### 2.3.1 MySQL

- 创建管理员账号（必须是**管理员账号**，后续安装初始化需要用此账号去创建和初始化各应用 DB，若需要远程连接需自行开启）
```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: middleware

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    volume.beta.kubernetes.io/storage-provisioner: "kubernetes.io/nfs"
  #  volume.beta.kubernetes.io/storage-class: "managed-nfs-storage"
  name: mysql-data
  namespace: middleware
spec:
  accessModes:
  - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 10Gi
  storageClassName:  standard-nfs-storage ## 指定实际存在StorageClass #


---
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: middleware
  labels:
    app: mysql
data:
  mysqld.cnf: |-
        [mysqld]
        pid-file        = /var/run/mysqld/mysqld.pid
        socket          = /var/run/mysqld/mysqld.sock
        datadir         = /var/lib/mysql
        symbolic-links=0
        max_connections=5000



---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: mysql
  name: mysql
  namespace: middleware
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 2
  selector:
    matchLabels:
      app: mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - env:
        - name: MYSQL_ROOT_PASSWORD
          value: rootPassw0rd
        - name: MYSQL_DATABASE
          value: FT2.0
        - name: MYSQL_USER
          value: admin
        - name: MYSQL_PASSWORD
          value: admin@123
        image: mysql:5.7
        imagePullPolicy: IfNotPresent
        name: mysql
        ports:
        - containerPort: 3306
          name: dbport
          protocol: TCP
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/lib/mysql
          name: db
        - mountPath: /etc/mysql/mysql.conf.d/mysqld.cnf
          name: config
          subPath: mysqld.cnf
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - name: db
        persistentVolumeClaim:
          claimName: mysql-data
      - name: config
        configMap:
          name: mysql-config
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
  namespace: middleware
spec:
  ports:
  - name: mysqlport
    nodePort: 32306
    port: 3306
    protocol: TCP
    targetPort: dbport
  selector:
    app: mysql
  sessionAffinity: None
  type: NodePort

```
**注：如果部署不成功，可以使用docker部署mysql的方式进行部署**
#### 2.3.2 Redis

- 需设置 Redis 密码
```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: middleware

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: redis-config
  namespace: middleware
data:
  redis.conf: |
    requirepass viFRKZiZkoPmXnyF
    appendonly yes

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
  namespace: middleware
  labels:
    app: redis
spec:
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
        - command:
            - redis-server
            - /usr/local/etc/redis/redis.conf
          name: redis
          image: redis:5.0.7
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 6379
              name: redis-port
          volumeMounts:
            - name: data
              mountPath: /data
            - name: config
              mountPath: /usr/local/etc/redis
      volumes:
        - name: data
          emptyDir: {}
        - name: config
          configMap:
            name: redis-config
---
apiVersion: v1
kind: Service
metadata:
  name: redis
  namespace: middleware
spec:
  selector:
    app: redis
  type: NodePort
  ports:
    - name: redis-port
      protocol: TCP
      port: 6379
      targetPort: redis-port
```

#### 2.3.3 InfluxDB

- 部署InfluxDB之前需先给选定节点打上标签:

```shell
$ kubectl label nodes <node名称> app01: influxdb
```

- 创建管理员账号（必须是**管理员账号**，后续安装初始化需要用此账号去创建和初始化 DB 及 RP等信息）

```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    volume.beta.kubernetes.io/storage-provisioner: "kubernetes.io/nfs"
  name: influx-data
  namespace: middleware
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  volumeMode: Filesystem
  storageClassName: standard-nfs-storage 
  # 此处配置实际存在的storageclass，若配置有默认storageclass 可以不配置该字段 #



---
apiVersion: v1
kind: ConfigMap
metadata:
  name: influxdb-config
  namespace: middleware
  labels:
    app: influxdb
data:
  influxdb.conf: |-
    [meta]
      dir = "/var/lib/influxdb/meta"

    [data]
      dir = "/var/lib/influxdb/data"
      engine = "tsm1"
      wal-dir = "/var/lib/influxdb/wal"
      max-values-per-tag = 0
      max-series-per-database = 0


---

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: influxdb
  name: influxdb
  namespace: middleware
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: influxdb
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: influxdb
    spec:
      nodeSelector:     ## 配置该容器调度到指定节点，前提是将指定节点打好标签  ##
        app01: influxdb
      containers:
      - env:
        - name: INFLUXDB_ADMIN_ENABLED
          value: "true"
        - name: INFLUXDB_ADMIN_PASSWORD
          value: admin@influxdb
        - name: INFLUXDB_ADMIN_USER
          value: admin
        - name: INFLUXDB_GRAPHITE_ENABLED
          value: "true"
        - name: INFLUXDB_HTTP_AUTH_ENABLED
          value: "true"
        image: influxdb:1.7.8
        imagePullPolicy: IfNotPresent
        name: influxdb
        ports:
        - containerPort: 8086
          name: api
          protocol: TCP
        - containerPort: 8083
          name: adminstrator
          protocol: TCP
        - containerPort: 2003
          name: graphite
          protocol: TCP
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/lib/influxdb
          name: db
        - mountPath: /etc/influxdb/influxdb.conf
          name: config
          subPath: influxdb.conf
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - name: db
        #hostPath: /influx-data
        persistentVolumeClaim:
          claimName: influx-data
      - name: config
        configMap:
          name: influxdb-config
---
apiVersion: v1
kind: Service
metadata:
  name: influxdb
  namespace: middleware
spec:
  ports:
  - name: api
    nodePort: 32086
    port: 8086
    protocol: TCP
    targetPort: api
  - name: adminstrator
    nodePort: 32083
    port: 8083
    protocol: TCP
    targetPort: adminstrator
  - name: graphite
    nodePort: 32003
    port: 2003
    protocol: TCP
    targetPort: graphite
  selector:
    app: influxdb
  sessionAffinity: None
  type: NodePort
```
#### 2.3.4 Elasticsearch
k8s集群中部署es参考示例
注：该yaml适用于poc环境，便于测试。

```yaml
## ConfigMap 可根据实际测试需要自行更改
## Namespace 为elastic 可根据实际测试需要自行更改
## Volume 使用自动存储，需要提前确认。若未配置自动存储可以按需修改为使用宿主机目录。
---
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: elastic
  name: elasticsearch-master-config
  labels:
    app: elasticsearch
    role: master
data:
  elasticsearch.yml: |-
    cluster.name: ${CLUSTER_NAME}
    node.name: ${NODE_NAME}
    discovery.seed_hosts: ${NODE_LIST}
    cluster.initial_master_nodes: ${MASTER_NODES}
    network.host: 0.0.0.0
    node.master: true
    node.data: true
    node.ingest: true
    xpack.security.enabled: true
    xpack.security.transport.ssl.enabled: true
---
apiVersion: v1
kind: Service
metadata:
  namespace: elastic
  name: elasticsearch-master
  labels:
    app: elasticsearch
    role: master
spec:
  clusterIP: None
  ports:
  - port: 9200
    name: http
  - port: 9300
    name: transport
  selector:
    app: elasticsearch
    role: master
---
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: elastic
  name: elasticsearch-master
  labels:
    app: elasticsearch
    role: master
spec:
  replicas: 1
  selector:
    matchLabels:
      app: elasticsearch
      role: master
  template:
    metadata:
      labels:
        app: elasticsearch
        role: master
    spec:
      initContainers:
      - name: fix-permissions
        image: busybox:1.30.0
        imagePullPolicy: IfNotPresent
        args:
        - chown -R 1000:1000 /usr/share/elasticsearch/data; chown -R 1000:1000 /usr/share/elasticsearch/logs;
          chown -R 1000:1000 /usr/share/elasticsearch/plugins
        command:
        - /bin/sh
        - -c
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: /usr/share/elasticsearch/data
          name: es-data
        - mountPath: /usr/share/elasticsearch/plugins
          name: plugins
        - mountPath: /usr/share/elasticsearch/logs
          name: logs
      - name: increase-vm-max-map
        image: busybox:1.30.0
        imagePullPolicy: IfNotPresent
        command: ["sysctl", "-w", "vm.max_map_count=262144"]
        securityContext:
          privileged: true
      - name: increase-fd-ulimit
        image: busybox:1.30.0
        imagePullPolicy: IfNotPresent
        command: ["sh", "-c", "ulimit -n 65536"]
        securityContext:
          privileged: true 
      nodeName: cf-standard-02003 #配置需要调度机器的主机名，以实际环境为准
      containers:
      - name: elasticsearch-master
        image: docker.elastic.co/elasticsearch/elasticsearch:7.5.1
        env:
        - name: CLUSTER_NAME
          value: dataflux-es
        - name: NODE_NAME
          value: elasticsearch-master
        - name: NODE_LIST
          value: elasticsearch-master
        - name: MASTER_NODES
          value: elasticsearch-master
        - name: "ES_JAVA_OPTS"
          value: "-Xms512m -Xmx512m" #根据测试需要调整
        - name: xpack.security.enabled
          value: "true"
        - name: xpack.security.transport.ssl.enabled
          value: "true"
        ports:
        - containerPort: 9200
          name: http
          protocol: TCP
        - containerPort: 9300
          name: transport
          protocol: TCP
        volumeMounts:
        - mountPath: /usr/share/elasticsearch/data
          name: es-data
        - name: logs
          mountPath: /usr/share/elasticsearch/logs
        - name: plugins 
          mountPath: /usr/share/elasticsearch/plugins
        - name: config
          mountPath: /usr/share/elasticsearch/config/elasticsearch.yml
          readOnly: true
          subPath: elasticsearch.yml
      volumes:
      - name: es-data
        persistentVolumeClaim:
          claimName: es-data
        # hostPath:
        #   path: /alidata/elasticsearch_data
        #   type: DirectoryOrCreate
      - name: plugins
        persistentVolumeClaim:
          claimName: es-plugins
        # hostPath:
        #   path: /alidata/elasticsearch_plugins
        #   type: DirectoryOrCreate
      - name: logs
        persistentVolumeClaim:
          claimName: es-logs
        # hostPath:
        #   path: /alidata/elasticsearch_logs
        #   type: DirectoryOrCreate    
      - name: config
        configMap:
          name: elasticsearch-master-config
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    # volume.beta.kubernetes.io/storage-class: "df-nfs-storage"
    # volume.beta.kubernetes.io/storage-provisioner: kubernetes.io/nfs
  name: es-plugins
  namespace: elastic
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: "df-nfs-storage"
  volumeMode: Filesystem      
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    # volume.beta.kubernetes.io/storage-class: "df-nfs-storage"
    # volume.beta.kubernetes.io/storage-provisioner: kubernetes.io/nfs
  name: es-data
  namespace: elastic
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: "df-nfs-storage"
  volumeMode: Filesystem   
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    # volume.beta.kubernetes.io/storage-class: "df-nfs-storage"
    # volume.beta.kubernetes.io/storage-provisioner: kubernetes.io/nfs
  name: es-logs
  namespace: elastic
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: "df-nfs-storage"
  volumeMode: Filesystem           
```

- 服务部署完成后创建管理员账号（需要开启认证）。 

       通过kubectl 命令行客户端以交互方式登录到部署的es服务，执行创建超级用户操作
```shell
$  kubectl exec -ti -n middleware es-cluster-0 -- bin/elasticsearch-users useradd copriwolf -p sayHi2Elastic -r superuser 
```

**注： 需要将相关账号信息保存（使用内置账号需自行持久化elasticsearch.keystore文件避免重启之后无法正常使用|或使用自行创建的管理员账号）**

- 修改elastic密码

```shell
$  kubectl exec -ti -n middleware es-cluster-0 -- curl -u copriwolf:sayHi2Elastic \
       -XPUT "http://localhost:9200/_xpack/security/user/elastic/_password?pretty" \
       -H 'Content-Type: application/json' \
       -d '{"password": "4dIv4VJQG5t5dcJOL8R5"}'
```

- 安装ES 安装中文分词插件

```shell
$  kubectl exec -ti es-cluster-0 bash -n middleware
$  ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.5.1/elasticsearch-analysis-ik-7.5.1.zip
```

- 设置禁止自动创建索引

```shell
 $  kubectl exec -ti -n middleware es-cluster-0 -- curl -X PUT -u elastic:4dIv4VJQG5t5dcJOL8R5 "elasticsearch.middleware:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'{
  "persistent": {
    "action.auto_create_index": "false"
  }
}'
```

- 便于UI管理建议部署 cerebro 或别的UI管理方案。部署参考 [https://github.com/lmenezes/cerebro/releases](https://github.com/lmenezes/cerebro/releases)
- 安装中文分词插件：
   1. 下载对应 ES 版本的分词插件：[https://github.com/medcl/elasticsearch-analysis-ik/releases](https://github.com/medcl/elasticsearch-analysis-ik/releases)（有网络的情况可以通过 bin/elasticsearch-plugin install [plugin_name] 方式安装(需将config目录下插件名称目录下config配置文件移动到插件持久化目录)]
   1. 解压后，放到 elasticsearch 目录的 plugins 目录内，如：

```shell
[root@ft-elasticsearch-867fb8d9bb-xchnm plugins]# find .
.
./analysis-ik
./analysis-ik/commons-codec-1.9.jar
./analysis-ik/commons-logging-1.2.jar
./analysis-ik/config
./analysis-ik/config/IKAnalyzer.cfg.xml
./analysis-ik/config/extra_main.dic
./analysis-ik/config/extra_single_word.dic
./analysis-ik/config/extra_single_word_full.dic
./analysis-ik/config/extra_single_word_low_freq.dic
./analysis-ik/config/extra_stopword.dic
./analysis-ik/config/main.dic
./analysis-ik/config/preposition.dic
./analysis-ik/config/quantifier.dic
./analysis-ik/config/stopword.dic
./analysis-ik/config/suffix.dic
./analysis-ik/config/surname.dic
./analysis-ik/elasticsearch-analysis-ik-7.10.1.jar
./analysis-ik/elasticsearch-analysis-ik-7.10.1.zip
./analysis-ik/httpclient-4.5.2.jar
./analysis-ik/httpcore-4.4.4.jar
./analysis-ik/plugin-descriptor.properties
./analysis-ik/plugin-security.policy
```
#### 2.3.5 外部服务导入到集群内部（可选）

- 如何将外部服务导入到集群内部使用，参考： [https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/](https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/)

```yaml
apiVersion: v1
kind: Service
metadata:
 name: mysql
spec:
 type: ClusterIP
 ports:
 - port: 3306 # 定义集群内部使用的服务端口
   targetPort: 23306 # 服务真实使用的端口

---
apiVersion: v1
kind: Endpoints
metadata:
 name: mysql
subsets:
 - addresses:
     - ip: 10.90.15.32   #外部服务真实提供的地址
   ports:
     - port: 23306  # 外部服务真实提供的端口

```
## 3 kubectl 安装及配置
### 3.1 安装 kubectl
kubectl 是一个 kubernetes 的一个命令行客户端工具，可以通过此命令行工具去部署应用、检查和管理集群资源等。
我们的 Launcher 就是基于此命令行工具，去部署应用的，具体安装方式可以看官方文档：

[https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 3.2 配置 kube config
kubectl 要获得管理集群的能力，需要将集群的 kubeconfig 利用kubeadm部署的集群完成后  kubeconfig 文件魔默认文件为 /etc/kubernetes/admin.conf   需将文件内容写入到客户端用户路劲  **$HOME/.kube/config** 文件内。

## 4 开始安装 观测云
### 4.1 观测云离线安装镜像下载地址

如果是离线网络环境下安装，需要先手工下载最新的观测云镜像包，通过  docker load  命令将所有镜像导入到各个 kubernetes 工作节点上后，再进行后续的引导安装。

最新的观测云 Docker 镜像包下载地址：[https://static.guance.com/dataflux/package/guance-latest.tar.gz](https://static.guance.com/dataflux/package/guance-latest.tar.gz)

1. 通过以下命令，将 Docker 镜像包下载到本地：
```shell
$ wget https://static.guance.com/dataflux/package/guance-latest.tar.gz
```

2. 下载后，将 Docker 镜像包上传到 kubernetes 的每一个 node 主机上后，执行以下命令，导入 Docker 镜像：
- **Docker 环境导入镜像命令：**
```shell
$ gunzip -c guance-latest.tar.gz | docker load
```

- **Containterd 环境导入镜像命令：**
```shell
$ gunzip guance-latest.tar.gz
$ ctr -n=k8s.io images import guance-latest.tar
```
**注：如果 kubernetes 节点主机可以访问公网，不需要通过以上离线导入的方式导入镜像，安装程序会自动下载镜像。**
### 4.2 Launcher 服务安装配置
#### 4.2.1 Launcher 安装
Launcher 安装有2种方式：

- Helm 安装
- 原始  YAML 安装

**!! 注意选一种安装方式即可**
##### 4.2.1.1 Helm 安装
前提条件：

- 已安装[Helm3](https://helm.sh/zh/docs/intro/install/)
- 已完成存储配置
###### 4.2.1.1.1 安装
```shell
# 添加仓库
$ helm repo add launcher https://pubrepo.guance.com/chartrepo/launcher

# 更新仓库
$ helm repo update 

# helm 安装 Launcher
$ helm install <RELEASE_NAME> launcher/launcher -n launcher --create-namespace  \
        --set-file configyaml="<Kubeconfig Path>" \
  --set ingress.hostName="<Hostname>",storageClassName=<Stroageclass>
```

**注意：** `<RELEASE_NAME>` 为发布名称，可设置为 launcher,`<Kubeconfig Path>` 为 2.3 章节的 kube config 文件路径可设置为 /root/.kube/config，`<Hostname> `为 Launcher ingress 域名，`<Stroageclass>` 为 4.1.2章节存储类名称，可执行` kubectl get sc` 获取。

```shell
# 此命令为演示命令，请根据自身需求修改内容
$ helm install my-launcher launcher/launcher -n launcher --create-namespace  \
        --set-file configyaml="/Users/buleleaf/.kube/config" \
  --set ingress.hostName="launcher.my.com",storageClassName=nfs-client
```
###### 4.2.1.1.2 社区版安装

如果部署社区版，可以先获取[社区版部署镜像](https://www.yuque.com/dataflux/rtm/cfvi8s) ，添加 --set image.repository=<镜像地址>，--set image.tag=<镜像tag> 参数进行部署。

```shell
# 此命令为演示命令，请根据自身需求修改内容
$ helm install my-launcher launcher/launcher -n launcher --create-namespace  \
        --set-file configyaml="/Users/buleleaf/.kube/config" \
  --set ingress.hostName="launcher.my.com",storageClassName=nfs-client \
 --set image.repository=pubrepo.jiagouyun.com/dataflux/1.40.93,image.tag=launcher-aa97377-1652102035
```
###### 4.2.1.1.3 如何卸载

Launcher 安装成功，非正常情况请勿卸载。

```shell
helm uninstall <RELEASE_NAME> -n launcher
```
##### 4.2.1.2 YAML 安装

Launcher YAML 下载：
 https://static.guance.com/launcher/launcher.yaml

将上面的 YAML 内容保存为 **launcher.yaml** 文件，放到**运维操作机**上，然后替换文档内的变量部分：

- {{ launcher_image }} 替换为最新版的 Launcher 应用的镜像地址
   - 如果是离线安装，上述通过 docker load 离线镜像导入后，通过 docker images | grep launcher 命令，拿到已导入到 Worker 节点中的最新版本 Launcher 镜像地址。
   - 如果是在线安装，可以在 [私有化部署版本镜像](changelog.md) 文档中获取到最新版本的 Launcher 安装镜像地址。
- {{ domain }} 替换为主域名，如使用 dataflux.cn
- {{ storageClassName }}替换为storage class name，必须和kubernetes  nfs subdir external provisioner   中配置的 name 一致。 (在配置了默认storageclass的前提下 storageClassName 字段可删除)

配置了默认storageclass 的资源会显示defalut 参考下图：

![](img/8.deployment_4.png)

#### 4.2.2 导入 Launcher 服务
在**运维操作机**上执行以下 **kubectl** 命令，在导入 **Launcher** 服务：
kubectl apply -f ./laucher.yaml

#### 4.2.3 解析 launcher 域名到 launcher 服务
因为 launcher 服务为部署和升级 观测云 使用，不需要对用户开放访问，所以域名不要在公网解析，可以在**安装操作机**上，绑定 host 的方式，模拟域名解析，在 /etc/hosts 中添加 **launcher.dataflux.cn** 的域名绑定：

192.168.0.1  launcher.dataflux.cn
实际以边缘节点ingress的地址为准（或通过修改 launcher 服务为 NodePort 形式 通过 集群节点IP+Port的方式访问）

### 4.3 应用安装引导步骤
在**安装操作机**的浏览器中访问 **launcher.dataflux.cn**，根据引导步骤一步一步完成安装配置。
#### 4.3.1 数据库配置

- 集群内部服务通过服务名进行连接，集群为服务建议到如到集群内部使用。
- 账号必须使用管理员账号，因为需要此账号去初始化多个子应用的数据库及数据库访问账号
#### 4.3.2 Redis 配置

- Redis 连接地址必须与集群物理节点能通信。
- 集群内部服务通过服务名进行连接，集群为服务建议到如到集群内部使用。
#### 4.3.3 InfluxDB 配置

- 集群内部服务通过服务名进行连接
- 账号必须使用管理员账号，因为需要使用此账号去初始化 DB 以及 RP 待信息
- 可添加多个 InfluxDB 实例
#### 4.3.4 其他设置

- 观测云管理后台的管理员账号初始账号名与邮箱（默认密码为 **admin，**建议登录后立即修改默认密码）
- 集群节点内网 IP（会自动获取，需要确认是否正确）
- 主域名及各子应用的子域名配置，默认子域名如下，可根据需要修改：
   - dataflux 【**用户前台**】
   - df-api 【**用户前台 API**】
   - df-management 【**管理后台**】
   - df-management-api 【**管理后台 API**】
   - df-websocket 【**Websocket 服务**】
   - df-func 【**Func 平台**】
   - df-openapi 【OpenAPI】
   - df-static-res 【**静态资源站点**】
   - df-kodo 【**kodo**】

- TLS 域名证书填写
#### 4.3.5 安装信息
汇总显示刚才填写的信息，如有信息填写错误可返回上一步修改
#### 4.3.6 应用配置文件
安装程序会自动根据前面步骤提供的安装信息，初始化应用配置模板，但还是需要逐个检查所有应用模板，修改个性化应用配置，具体配置说明见安装界面。

确认无误后，提交创建配置文件。
#### 4.3.7 应用镜像

- 选择正确的**共享存储**，即你前面步骤中创建的 **storage class** 名称
- 应用镜像会根据你选的 **Launcher** 版本，自动填写无需修改，确认无误后开始 **创建应用**
#### 4.3.8 应用状态
此处会列出所有应用服务的启动状态，此过程需要下载所有镜像，可能需要几分钟到十几分钟，待全部服务都成功启动之后，即表示已安装成功。

**注意：服务启动过程中，必须停留在此页面不要关闭，到最后看到“版本信息写入成功”的提示，且没有弹出错误窗口，才表示安装成功！**
### 4.4 域名解析
将除 **df-kodo.dataflux.cn** 之外的其他所有子域名，都解析到 边缘节点 ingress 地址：

- dataflux.dataflux.cn
- df-api.dataflux.cn
- df-management.dataflux.cn
- df-management-api.dataflux.cn
- df-websocket.dataflux.cn
- df-func.dataflux.cn
- df-openapi.dataflux.cn
- df-static-res.dataflux.cn
- df-kodo.dataflux.cn

当前版本Launcher安装器需要手动配置kodo ingress 服务。参考：
```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: df-kodo
  namespace: forethought-kodo
spec:
  rules:
  - host: df-kodo.dataflux.cn
    http:
      paths:
      - backend:
          serviceName: kodo-nginx
          servicePort: http
        path: /
        pathType: ImplementationSpecific
---
apiVersion: v1
kind: Service
metadata:
  name: kodo-nginx
  namespace: forethought-kodo
spec:
  ports:
  - name: https
    nodePort: 31841
    port: 443
    protocol: TCP
    targetPort: 80
  - name: http
    nodePort: 31385
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: deployment-forethought-kodo-kodo-nginx
  sessionAffinity: None
  type: NodePort


```

配置完成后可部署haproxy或nginx等服务在集群外的机器上进行域名代理。

```bash
 #---------------------------------------------------------------------
# Example configuration for a possible web application.  See the
# full configuration options online.
#
#   http://haproxy.1wt.eu/download/1.4/doc/configuration.txt
#
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

# 443 https 端口配置 可以不配 配就放开注释
#frontend https_frontend
#        bind *:443 ssl crt /etc/ssl/certs/dataflux.cn.pem # ssl证书
#        mode http
#        option httpclose
#        option forwardfor
#        reqadd X-Forwarded-Proto:\ https
#        #default_backend web_server
#        # 不走ingress
#        acl kodo           hdr(Host)  -i df-kodo.test.com
#
#        acl launcher       hdr(Host)  -i launcher.test.com
#        acl dataflux       hdr(Host)  -i dataflux.test.com
#        acl func           hdr(Host)  -i df-func.test.com
#        acl api            hdr(Host)  -i df-api.test.com
#        acl management     hdr(Host)  -i df-management.test.com
#        acl management-api hdr(Host)  -i df-management-api.test.com
#        acl static         hdr(Host)  -i df-static-res.test.com
#
#        use_backend vip_1_servers if dataflux
#        use_backend vip_1_servers if func
#        use_backend vip_1_servers if launcher
#        use_backend vip_1_servers if static
#        use_backend vip_1_servers if api
#        use_backend vip_1_servers if management
#        use_backend vip_1_servers if management-api
#
#       # 不走ingress
#        use_backend vip_2_servers if kodo

# dynamic-static separation
frontend http_web
        mode http
        bind *:80
#        redirect scheme https if !{ ssl_fc}
        option httpclose
        option forwardfor
        ###### 请修改你的域名 test.com 改为你域名
        acl kodo           hdr(Host)  -i df-kodo.test.com

        acl launcher       hdr(Host)  -i launcher.test.com
        acl dataflux       hdr(Host)  -i dataflux.test.com
        acl func           hdr(Host)  -i df-func.test.com
        acl api            hdr(Host)  -i df-api.test.com
        acl management     hdr(Host)  -i df-management.test.com
        acl management-api hdr(Host)  -i df-management-api.test.com
        acl static         hdr(Host)  -i df-static-res.test.com

        acl dataway         hdr(Host)  -i df-dataway.test.com
        use_backend vip_1_servers if dataflux
        use_backend vip_1_servers if func
        use_backend vip_1_servers if launcher
        use_backend vip_1_servers if static
        use_backend vip_1_servers if api
        use_backend vip_1_servers if management
        use_backend vip_1_servers if management-api
        use_backend vip_1_servers if kodo
        
        use_backend vip_2_servers if dataway
# ingress 端口 ip是k8s的集群的 请替换ip
backend vip_1_servers
        balance roundrobin
        server ingress_1 172.16.1.186:31257 check inter 1500 rise 3 fall 3
        server ingress_2 172.16.1.187:31257 check inter 1500 rise 3 fall 3
        server ingress_3 172.16.1.188:31257 check inter 1500 rise 3 fall 3

# kodo 端口和ip是dataway的，dataway需要在下一步4.5进行配置。
backend vip_2_servers
        balance roundrobin
        server ingress_1 172.16.1.190:9528 check inter 1500 rise 3 fall 3
#        server ingress_2 172.16.1.187:31465 check inter 1500 rise 3 fall 3
#        server ingress_3 172.16.1.188:31465 check inter 1500 rise 3 fall 3

```

### 4.5 安装完成后
部署成功手，可以参考手册 [如何开始使用](how-to-start.md) 

如果安装过程中发生问题，需要重新安装，可参考手册 [维护手册](faq.md)
### 4.6 很重要的步骤！！！
### 4.6.1 安装器服务下线
经过以上步骤，观测云安装完毕，可以进行验证，验证无误后一个很重要的步骤，将 launcher 服务下线，防止被误访问而破坏应用配置，可在**运维操作机**上执行以下命令，将 launcher 服务的 pod 副本数设为 0：

```shell
kubectl scale deployment -n launcher --replicas=0  launcher
```

或

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 0}}' -n launcher
```
