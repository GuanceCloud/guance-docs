# Enable Ingress Observability Using CRD

---

## Introduction

CRD stands for Custom Resource Definition, a built-in resource type in Kubernetes that allows users to define new resource types. **<<< custom_key.brand_name >>> implements the customization of CRD resources**, and then manages these customized CRD objects through a CRD controller. Using CRD to collect metrics can decouple the collection process from the application.

For collecting Ingress metrics, annotations need to be added to the Deployment resource in the YAML file where Ingress is deployed. This way, DataKit can collect metrics from the Ingress Pod via these custom annotations. However, annotations are tightly coupled with Pods, which can be inconvenient. Using CRD simplifies this process; you only need to know the namespace of the Ingress and the name of the Deployment.

Next, let's walk through enabling observability for Ingress using CRD step by step.

## Prerequisites

- Kubernetes cluster
- <<< custom_key.brand_name >>> account

## Procedure

???+ warning

    This example uses DataKit version `1.4.11` and Nginx Ingress Controller version `1.1.1`.

### 1 Deploy DataKit

#### 1.1 Obtain Token

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the "Manage" module, find the Token in the basic settings interface, and click the "Copy Icon".

![1643275020(1).png](../images/ingress-crd/1.png)

#### 1.2 Download DataKit Deployment File

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the "Integration" module - "DataKit" - "Kubernetes", and download the `datakit.yaml` file.

![1643275020(1).png](../images/ingress-crd/2.png)

#### 1.3 Deploy DataKit

Open the `datakit.yaml` file, replace `<your-token>` with the copied Token. To distinguish clusters and facilitate elections, add a few environment variables. You can define `k8s-containerd` yourself.

```yaml
- name: ENV_GLOBAL_HOST_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-containerd
- name: ENV_NAMESPACE
  value: k8s-containerd
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=k8s-containerd
```

![1643275020(1).png](../images/ingress-crd/3.png)

Upload the `datakit.yaml` file to the master node of the Kubernetes cluster and deploy DataKit using the command:

```shell
kubectl apply -f datakit.yaml
```

### 2 Deploy Ingress

#### 2.1 Write ingress-deployment.yaml

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

#### 2.2 Deploy Ingress

Upload the `ingress-deployment.yaml` file to the master node of the Kubernetes cluster and deploy Ingress using the command:

```shell
kubectl apply -f ingress-deployment.yaml
```

### 3 Deploy Nginx

#### 3.1 Write nginx-deployment.yaml

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

#### 3.2 Write nginx-ingress.yaml

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

#### 3.3 Deploy Nginx

Upload the `nginx-deployment.yaml` and `nginx-ingress.yaml` files to the master node of the Kubernetes cluster and execute the commands.

```shell
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-ingress.yaml
```

### 4 Create CRD

#### 4.1 Write datakit-crd.yaml

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

#### 4.2 Write ingress-crd.yaml

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

#### 4.3 Deploy CRD

Upload the files to the master node of the Kubernetes cluster and execute the commands.

```shell
kubectl apply -f datakit-crd.yaml
kubectl apply -f ingress-crd.yaml
```

### 5 Scenario View

#### 5.1 Access Nginx

Execute `kubectl get svc -n ingress-nginx` to get the node port corresponding to port 80, which is 30049.

![1643275020(1).png](../images/ingress-crd/4.png)

Use the node [8.136.207.182](http://8.136.207.182) to access Nginx.

```shell
while true; do sleep 1;curl -v http://8.136.207.182 -H 'host: mynginx.com'; done
```

#### 5.2 Ingress Observability

Log in to [<<< custom_key.brand_name >>>](https://console.guance.com/), click on the "Scenarios" module, create a new dashboard, search for ingress, and click "Confirm".

![1643275020(1).png](../images/ingress-crd/5.png)

The while loop command executed above will simulate visits to `mynginx.com`, and the monitoring view will display the usage of Ingress.

![1643275020(1).png](../images/ingress-crd/6.png)