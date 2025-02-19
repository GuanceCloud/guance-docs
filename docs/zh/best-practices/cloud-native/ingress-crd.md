# 使用 CRD 开启您的 Ingress 可观测之路

---

## 简介

CRD 全称是 Custom Resource Definition，是 Kubernetes 的一种内置资源类型，允许用户自定义新的资源类型。**{{{ custom_key.brand_name }}}实现了 CRD 资源的自定义**，然后通过 CRD 控制器实现对自定义的 CRD 对象的管理。使用 CRD 采集指标，可以实现与应用的解耦。

以 Ingress 指标采集来说，采集指标需要在部署 Ingress 的 yaml 文件中的 Deployment 资源上增加 annotations，这样 DataKit 就可以通过自定义的 annotations ，来采集 Ingress Pod 的指标。有个不好的地方就是 annotations 与 Pod 耦合性太强，使用 CRD 就方便多了，只需要知道 Ingress 的 namespace 和 Deployment 的 name 就可以了。

接下来就使用 CRD 一步一步实现 Ingress 的可观测。

## 前置条件

- Kubernetes 集群
- {{{ custom_key.brand_name }}}账号

## 操作步骤

???+ warning

    本次示例使用版本为 DataKit `1.4.11` 、 Nginx Ingress Controller  `1.1.1`

### 1 部署 DataKit

#### 1.1 获取 Token

登录「[{{{ custom_key.brand_name }}}](https://console.guance.com/)」，点击「管理」模块，在基本设置界面找到 Token，点击后面的「复制图标」。

![1643275020(1).png](../images/ingress-crd/1.png)

#### 1.2 下载 DataKit 部署文件

登录「[{{{ custom_key.brand_name }}}](https://console.guance.com/)」，点击「集成」模块 - 「DataKit」 - 「Kubernetes」，下载 `datakit.yaml` 文件。

![1643275020(1).png](../images/ingress-crd/2.png)

#### 1.3 部署 DataKit

打开 `datakit.yaml` 文件，把复制的 Token 替换文件中的 <your-token>，为了区分集群和选举，增加几个环境变量，`k8s-containerd` 可以自己定义。

```yaml
- name: ENV_GLOBAL_HOST_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-containerd
- name: ENV_NAMESPACE
  value: k8s-containerd
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=k8s-containerd
```

![1643275020(1).png](../images/ingress-crd/3.png)

把 `datakit.yaml` 上传到 Kubernetes 集群的 master 节点，执行命令部署 DataKit。

```shell
kubectl apply -f datakit.yaml
```

### 2 部署 Ingress

#### 2.1 编写 ingress-deployment.yaml

??? quote "`ingress-deployment.yaml`"

    ```yaml

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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: controller
      name: ingress-nginx-controller
      namespace: ingress-nginx
    data:
      allow-snippet-annotations: 'true'
    ---
    # Source: ingress-nginx/templates/clusterrole.yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
          - namespaces
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
          - networking.k8s.io
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
          - networking.k8s.io
        resources:
          - ingresses/status
        verbs:
          - update
      - apiGroups:
          - networking.k8s.io
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
          - networking.k8s.io
        resources:
          - ingresses
        verbs:
          - get
          - list
          - watch
      - apiGroups:
          - networking.k8s.io
        resources:
          - ingresses/status
        verbs:
          - update
      - apiGroups:
          - networking.k8s.io
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
          - ingress-controller-leader
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
          appProtocol: https
      selector:
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/component: controller
    ---
    # Source: ingress-nginx/templates/controller-service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      #annotations:
      #  prometheus.io/scrape: "true"
      #  prometheus.io/port: "10254"
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: controller
      name: ingress-nginx-controller
      namespace: ingress-nginx
    spec:
      type: NodePort
      # externalTrafficPolicy: Local
      # ipFamilyPolicy: SingleStack
      # ipFamilies:
      #   - IPv4
      ports:
        - name: http
          port: 80
          protocol: TCP
          targetPort: http
          appProtocol: http
          nodePort: 30049
        - name: https
          port: 443
          protocol: TCP
          targetPort: https
          appProtocol: https
        #- name: prometheus
        #  port: 10254
        #  targetPort: prometheus
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
          annotations:

        spec:
          dnsPolicy: ClusterFirst
          nodeName: k8s-node2
          containers:
            - name: controller
              image: registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-ingress-controller:v1.1.1
              imagePullPolicy: IfNotPresent
              lifecycle:
                preStop:
                  exec:
                    command:
                      - /wait-shutdown
              args:
                - /nginx-ingress-controller
                - --publish-service=$(POD_NAMESPACE)/ingress-nginx-controller
                - --election-id=ingress-controller-leader
                - --controller-class=k8s.io/ingress-nginx
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
                  hostPort: 80
                  protocol: TCP
                - name: https
                  containerPort: 443
                  hostPort: 443
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
            kubernetes.io/os: linux
          serviceAccountName: ingress-nginx
          terminationGracePeriodSeconds: 300
          volumes:
            - name: webhook-cert
              secret:
                secretName: ingress-nginx-admission
    ---
    # Source: ingress-nginx/templates/controller-ingressclass.yaml
    # We don't support namespaced ingressClass yet
    # So a ClusterRole and a ClusterRoleBinding is required
    apiVersion: networking.k8s.io/v1
    kind: IngressClass
    metadata:
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: controller
      name: nginx
      namespace: ingress-nginx
    spec:
      controller: k8s.io/ingress-nginx
    ---
    # Source: ingress-nginx/templates/admission-webhooks/validating-webhook.yaml
    # before changing this value, check the required kubernetes version
    # https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#prerequisites
    apiVersion: admissionregistration.k8s.io/v1
    kind: ValidatingWebhookConfiguration
    metadata:
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
              - v1
            operations:
              - CREATE
              - UPDATE
            resources:
              - ingresses
        failurePolicy: Fail
        sideEffects: None
        admissionReviewVersions:
          - v1
        clientConfig:
          service:
            namespace: ingress-nginx
            name: ingress-nginx-controller-admission
            path: /networking/v1/ingresses
    ---
    # Source: ingress-nginx/templates/admission-webhooks/job-patch/serviceaccount.yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: ingress-nginx-admission
      namespace: ingress-nginx
      annotations:
        helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
        helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
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
      namespace: ingress-nginx
      annotations:
        helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
        helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
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
      namespace: ingress-nginx
      annotations:
        helm.sh/hook: pre-install,pre-upgrade,post-install,post-upgrade
        helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
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
      namespace: ingress-nginx
      annotations:
        helm.sh/hook: pre-install,pre-upgrade
        helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
    spec:
      template:
        metadata:
          name: ingress-nginx-admission-create
          labels:
            helm.sh/chart: ingress-nginx-4.0.15
            app.kubernetes.io/name: ingress-nginx
            app.kubernetes.io/instance: ingress-nginx
            app.kubernetes.io/version: 1.1.1
            app.kubernetes.io/managed-by: Helm
            app.kubernetes.io/component: admission-webhook
        spec:
          containers:
            - name: create
              image: registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v1.1.1
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
              securityContext:
                allowPrivilegeEscalation: false
          restartPolicy: OnFailure
          serviceAccountName: ingress-nginx-admission
          nodeSelector:
            kubernetes.io/os: linux
          securityContext:
            runAsNonRoot: true
            runAsUser: 2000
    ---
    # Source: ingress-nginx/templates/admission-webhooks/job-patch/job-patchWebhook.yaml
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: ingress-nginx-admission-patch
      namespace: ingress-nginx
      annotations:
        helm.sh/hook: post-install,post-upgrade
        helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
      labels:
        helm.sh/chart: ingress-nginx-4.0.15
        app.kubernetes.io/name: ingress-nginx
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/version: 1.1.1
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/component: admission-webhook
    spec:
      template:
        metadata:
          name: ingress-nginx-admission-patch
          labels:
            helm.sh/chart: ingress-nginx-4.0.15
            app.kubernetes.io/name: ingress-nginx
            app.kubernetes.io/instance: ingress-nginx
            app.kubernetes.io/version: 1.1.1
            app.kubernetes.io/managed-by: Helm
            app.kubernetes.io/component: admission-webhook
        spec:
          containers:
            - name: patch
              image: registry.cn-hangzhou.aliyuncs.com/google_containers/kube-webhook-certgen:v1.1.1
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
              securityContext:
                allowPrivilegeEscalation: false
          restartPolicy: OnFailure
          serviceAccountName: ingress-nginx-admission
          nodeSelector:
            kubernetes.io/os: linux
          securityContext:
            runAsNonRoot: true
            runAsUser: 2000

    ```

#### 2.2 部署 Ingress

把 `ingress-deployment.yaml` 文件上传到 Kubernetes 集群的 master 节点，执行命令部署 Ingress。

```shell
kubectl apply -f ingress-deployment.yaml
```

### 3 部署 Nginx

#### 3.1 编写 nginx-deployment.yaml

??? quote "`nginx-deployment.yaml`"

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      selector:
        matchLabels:
          app: backend
      replicas: 1
      template:
        metadata:
          labels:
            app: backend
        spec:
          nodeName: k8s-node2
          containers:
          - name: nginx
            image: nginx:latest
            resources:
              limits:
                memory: "128Mi"
                cpu: "128m"
            ports:
            - containerPort: 80

    ---

    apiVersion: v1
    kind: Service
    metadata:
      name: nginx-service
    spec:
      selector:
        app: backend
      ports:
        - port: 80
          targetPort: 80

    ```

#### 3.2 编写 nginx-ingress.yaml

??? quote "`nginx-ingress.yaml`"

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: nodeport-ingress
      namespace: default
      annotations:
        kubernetes.io/ingress.class: "nginx"
    spec:
      rules:
      - host: mynginx.com
        http:
          paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: nginx-service
                port:
                  number: 80

    ```

#### 3.3 部署 Nginx

把 `nginx-deployment.yaml` 和 `nginx-ingress.yaml` 上传到 Kubernetes 集群的 master 节点，执行命令。

```shell
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-ingress.yaml
```

### 4 创建 CRD

#### 4.1 编写 datakit-crd.yaml

??? quote "`datakit-crd.yaml`"

    ```yaml
    apiVersion: apiextensions.k8s.io/v1
    kind: CustomResourceDefinition
    metadata:
      name: datakits.guance.com
    spec:
      group: guance.com
      versions:
        - name: v1beta1
          served: true
          storage: true
          schema:
            openAPIV3Schema:
              type: object
              properties:
                spec:
                  type: object
                  properties:
                    instances:
                      type: array
                      items:
                        type: object
                        properties:
                          k8sNamespace:
                            type: string
                          k8sDeployment:
                            type: string
                          datakit/logs:
                            type: string
                          inputConf:
                            type: string
      scope: Namespaced
      names:
        plural: datakits
        singular: datakit
        kind: Datakit
        shortNames:
        - dk

    ```

#### 4.2 编写 ingress-crd.yaml

??? quote "`ingress-crd.yaml`"

    ```yaml
    apiVersion: "guance.com/v1beta1"
    kind: Datakit
    metadata:
      name: prom-ingress
      namespace: datakit
    spec:
      instances:
        - k8sNamespace: "ingress-nginx"
          k8sDeployment: "ingress-nginx-controller"
          inputConf: |
            [[inputs.prom]]
              url = "http://$IP:10254/metrics"
              source = "prom-ingress"
              metric_types = ["counter", "gauge","histogram"]
              # metric_name_filter = ["cpu"]
              # measurement_prefix = ""
              measurement_name = "prom_ingress"
              interval = "60s"
              tags_ignore = ["build","le","path","method","release","repository"]
              metric_name_filter = ["nginx_process_cpu_seconds_total","nginx_process_resident_memory_bytes","request_size","response_size","requests","success","config_last_reload_successful"]
              [[inputs.prom.measurements]]
                prefix = "nginx_ingress_controller_"
                name = "prom_ingress"
              [inputs.prom.tags]
                namespace = "$NAMESPACE"
    ```

#### 4.3 部署 CRD

把文件上传到 Kubernets 集群的 master 节点，执行命令。

```shell
kubectl apply -f datakit-crd.yaml
kubectl apply -f ingress-crd.yaml
```

### 5 场景视图

#### 5.1 访问 Nginx

执行 `kubectl get svc -n ingress-nginx` 获取到 80 对应的节点端口是 30049。

![1643275020(1).png](../images/ingress-crd/4.png)

使用节点 [8.136.207.182](http://8.136.207.182) 来访问 Nginx。

```shell
while true; do sleep 1;curl -v http://8.136.207.182 -H 'host: mynginx.com'; done
```

#### 5.2 Ingress 可观测

登录「[{{{ custom_key.brand_name }}}](https://console.guance.com/)」，点击「场景」模块，新建仪表板，搜索 ingress，点击「确定」。

![1643275020(1).png](../images/ingress-crd/5.png)

上步执行的 while 命令会模拟访问 `mynginx.com` ，监控视图展示出 Ingress 的使用情况。

![1643275020(1).png](../images/ingress-crd/6.png)
