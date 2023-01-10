# 日志引擎部署


???+ warning "注意"
     OpenSearch 和 Elasticsearch 二选一即可。
     
     高可用 OpenSearch 部署可参考：[OpenSearch 高可用部署](ha-opensearch.md)

## 简介 {#intro}


|      |     |
| ---------- | ------- |
| **部署方式**    | Kubernetes 容器部署    |
| **日志引擎(二选一)**|      |
| **OpenSearch** | 版本：2.3.0 | 
| **Elasticsearch** | 版本：7.13.2 |        
| **部署前提条件** | 已部署 [Kubernetes](infra-kubernetes.md#kubernetes-install) <br> 已部署 [Kubernetes Storage](infra-kubernetes.md#kube-storage) |


## 部署默认配置信息

=== "OpenSearch"
    |      |     |
    | ---------- | ------- |
    |   **默认地址**  | opensearch-single.middleware |
    |   **默认端口**  | 9200 |
    |   **默认账号**  | elastic/4dIv4VJQG5t5dcJOL8R5  |

=== "Elasticsearch"
    |      |     |
    | ---------- | ------- |
    |   **默认地址**  | elasticsearch.middleware |
    |   **默认端口**  | 9200 |
    |   **默认账号**  | elastic/4dIv4VJQG5t5dcJOL8R5 |


## OpenSearch 部署 {#openes-install}

### 安装

???+ warning "注意" 
     高亮部分中的 `storageClassName` 需根据实际情况而定， JVM 最好设置物理内存的50%，如果我们节点物理内存为8G，则可以设置为 `-Xmx4g -Xms4g`。

保存 openes.yaml ，并部署。
???- note "openes.yaml (单击点开)" 
    ```yaml hl_lines='147 247'
    ---
    # Source: opensearch/templates/configmap.yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: opensearch-single-config
      namespace: middleware
      labels:
        app.kubernetes.io/name: opensearch
        app.kubernetes.io/instance: opensearch
        app.kubernetes.io/component: opensearch-single
    data:
      opensearch.yml: |
        cluster.name: opensearch-cluster

        # Bind to all interfaces because we don't know what IP address Docker will assign to us.
        network.host: 0.0.0.0
        action.auto_create_index: "+security*,.monitoring*,.watches,.triggered_watches,.watcher-history*,.ml*"
        # Setting network.host to a non-loopback address enables the annoying bootstrap checks. "Single-node" mode disables them again.
        # Implicitly done if ".singleNode" is set to "true".
        # discovery.type: single-node

        # Start OpenSearch Security Demo Configuration
        # WARNING: revise all the lines below before you go into production
        plugins:
          security:
            ssl:
              transport:
                pemcert_filepath: esnode.pem
                pemkey_filepath: esnode-key.pem
                pemtrustedcas_filepath: root-ca.pem
                enforce_hostname_verification: false
              http:
                enabled: true
                pemcert_filepath: esnode.pem
                pemkey_filepath: esnode-key.pem
                pemtrustedcas_filepath: root-ca.pem
            allow_unsafe_democertificates: true
            allow_default_init_securityindex: true
            authcz:
              admin_dn:
                - CN=kirk,OU=client,O=client,L=test,C=de
            audit.type: internal_opensearch
            enable_snapshot_restore_privilege: true
            check_snapshot_restore_write_privileges: true
            restapi:
              roles_enabled: ["all_access", "security_rest_api_access"]
            system_indices:
              enabled: true
              indices:
                [
                  ".opendistro-alerting-config",
                  ".opendistro-alerting-alert*",
                  ".opendistro-anomaly-results*",
                  ".opendistro-anomaly-detector*",
                  ".opendistro-anomaly-checkpoints",
                  ".opendistro-anomaly-detection-state",
                  ".opendistro-reports-*",
                  ".opendistro-notifications-*",
                  ".opendistro-notebooks",
                  ".opendistro-asynchronous-search-response*",
                ]
        ######## End OpenSearch Security Demo Configuration ########
    ---
    # Source: opensearch/templates/service.yaml
    kind: Service
    apiVersion: v1
    metadata:
      name: opensearch-single
      namespace: middleware
      labels:
        app.kubernetes.io/name: opensearch
        app.kubernetes.io/instance: opensearch
        app.kubernetes.io/component: opensearch-single
      annotations:
        {}
    spec:
      type: NodePort
      selector:
        app.kubernetes.io/name: opensearch
        app.kubernetes.io/instance: opensearch
      ports:
      - name: http
        protocol: TCP
        port: 9200
        nodePort: 31020
      - name: transport
        protocol: TCP
        port: 9300
    ---
    # Source: opensearch/templates/service.yaml
    kind: Service
    apiVersion: v1
    metadata:
      name: opensearch-single-headless
      namespace: middleware
      labels:
        app.kubernetes.io/name: opensearch
        app.kubernetes.io/instance: opensearch
        app.kubernetes.io/component: opensearch-single
      annotations:
        service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
    spec:
      clusterIP: None # This is needed for statefulset hostnames like opensearch-0 to resolve
      # Create endpoints also if the related pod isn't ready
      publishNotReadyAddresses: true
      selector:
        app.kubernetes.io/name: opensearch
        app.kubernetes.io/instance: opensearch
      ports:
      - name: http
        port: 9200
      - name: transport
        port: 9300
    ---
    # Source: opensearch/templates/statefulset.yaml
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: opensearch-single
      namespace: middleware
      labels:
        app.kubernetes.io/name: opensearch
        app.kubernetes.io/instance: opensearch
        app.kubernetes.io/component: opensearch-single
      annotations:
        majorVersion: "2"
    spec:
      serviceName: opensearch-single-headless
      selector:
        matchLabels:
          app.kubernetes.io/name: opensearch
          app.kubernetes.io/instance: opensearch
      replicas: 1
      podManagementPolicy: Parallel
      updateStrategy:
        type: RollingUpdate
      volumeClaimTemplates:
      - metadata:
          name: opensearch-single
        spec:
          accessModes:
          - "ReadWriteOnce"
          resources:
            requests:
              storage: "16Gi"
          storageClassName: "df-nfs-storage"
      template:
        metadata:
          name: "opensearch-single"
          labels:
            app.kubernetes.io/name: opensearch
            app.kubernetes.io/instance: opensearch
            app.kubernetes.io/component: opensearch-single
          annotations:
            configchecksum: ade8cb5132d9972348bbe109931f02350f3d7b8892a7f5dfac9250c4d969f27
        spec:
          securityContext:
            fsGroup: 1000
            runAsUser: 1000
          serviceAccountName: ""
          affinity:
            podAntiAffinity:
              preferredDuringSchedulingIgnoredDuringExecution:
              - weight: 1
                podAffinityTerm:
                  topologyKey: kubernetes.io/hostname
                  labelSelector:
                    matchExpressions:
                    - key: app.kubernetes.io/instance
                      operator: In
                      values:
                      - opensearch
                    - key: app.kubernetes.io/name
                      operator: In
                      values:
                      - opensearch
          terminationGracePeriodSeconds: 120
          volumes:
          - name: config
            configMap:
              name: opensearch-single-config
          enableServiceLinks: true
          initContainers:
          - name: fsgroup-volume
            image: "pubrepo.guance.com/googleimages/busybox:1.35.0"
            command: ['sh', '-c']
            args:
              - 'chown -R 1000:1000 /usr/share/opensearch/data'
            securityContext:
              runAsUser: 0
            resources:

              {}
            volumeMounts:
              - name: "opensearch-single"
                mountPath: /usr/share/opensearch/data

          containers:
          - name: "opensearch"
            securityContext:
              capabilities:
                drop:
                - ALL
              runAsNonRoot: true
              runAsUser: 1000

            image: "pubrepo.jiagouyun.com/base/opensearch:2.3.0-85eb7af9"
            imagePullPolicy: "IfNotPresent"
            readinessProbe:
              failureThreshold: 3
              periodSeconds: 5
              tcpSocket:
                port: 9200
              timeoutSeconds: 3
            startupProbe:
              failureThreshold: 30
              initialDelaySeconds: 5
              periodSeconds: 10
              tcpSocket:
                port: 9200
              timeoutSeconds: 3
            ports:
            - name: http
              containerPort: 9200
            - name: transport
              containerPort: 9300
            # resources:
            #   limits:
            #     cpu: 4
            #     memory: 8Gi
            #   requests:
            #     cpu: 4
            #     memory: 8Gi
            env:
            - name: node.name
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: discovery.seed_hosts
              value: "opensearch-single-headless"
            - name: cluster.name
              value: "opensearch"
            - name: network.host
              value: "0.0.0.0"
            - name: OPENSEARCH_JAVA_OPTS
              value: "-Xmx4g -Xms4g"
            - name: node.roles
              value: "master,ingest,data,remote_cluster_client,"
            - name: discovery.type
              value: "single-node"
            - name: plugins.security.ssl.http.enabled
              value: "false"               
            volumeMounts:
            - name: "opensearch-single"
              mountPath: /usr/share/opensearch/data
            - name: config
              mountPath: /usr/share/opensearch/config/opensearch.yml
              subPath: opensearch.yml
    ``` 

  执行命令安装：
```shell
kubectl create namespace middleware
kubectl apply -f openes.yaml
```

### 验证部署

- 查看 pod 状态

```shell
kubectl get pods -n middleware -l app.kubernetes.io/name=opensearch
```

成功结果:

```shell
NAME                  READY   STATUS    RESTARTS   AGE
opensearch-single-0   1/1     Running   0          4m37s
```

### 配置账号

#### 添加 elastic 密码 {#addpasswd}

???+ warning "注意" 
     高亮部分中的 `{"password": "4dIv4VJQG5t5dcJOL8R5"}` 可以修改你自己密码

```shell hl_lines='5'
kubectl exec -ti -n middleware opensearch-single-0 -- curl -u admin:admin \
       -XPUT "http://localhost:9200/_plugins/_security/api/internalusers/elastic" \
       -H 'Content-Type: application/json' \
       -d '{
            "password": "4dIv4VJQG5t5dcJOL8R5",
            "opendistro_security_roles": ["all_access"]
        }'
```

### 如何卸载

```shell
kubectl delete -f openes.yaml
kubectl delete -n middleware pvc  opensearch-single-opensearch-single-0
```

### 如何排错

#### 查看容器状态

```shell
kubectl describe -n middleware pods opensearch-single-0
```

#### 查看容器日志

```shell
kubectl logs -n middleware -f opensearch-single-0 -c opensearch
```



## Elasticsearch 部署 {#es-install}



### 安装

???+ warning "注意" 
     高亮部分中的 `storageClassName` 需根据实际情况而定，JVM 最好设置物理内存的50%，如果我们节点物理内存为8G，则可以设置为 `-Xmx4g -Xms4g`。

保存 es.yaml ，并部署。
???- note "es.yaml(单击点开)" 
    ```yaml hl_lines='88 140'
    ---
    apiVersion: v1
    data:
      elastic-certificates.p12: >-
        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
    kind: Secret
    metadata:
      name: es-keystore
      namespace: middleware
    type: Opaque


    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: elasticsearch
      namespace: middleware
      labels:
        app: elasticsearch
    spec:
      type: NodePort
      ports:
      - name:  web-9200
        port: 9200
        targetPort: 9200
        protocol: TCP
        nodePort: 30105
      - name:  web-9300
        port: 9300
        targetPort: 9300
        protocol: TCP
        nodePort: 30106
      selector:
        app: elasticsearch


    ---
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: es-cluster
      namespace: middleware
    spec:
      serviceName: elasticsearch
      replicas: 1
      selector:
        matchLabels:
          app: elasticsearch
      template:
        metadata:
          labels:
            app: elasticsearch
        spec:
          containers:
          - name: elasticsearch
            image: pubrepo.jiagouyun.com/base/elasticsearch:7.13.2
            imagePullPolicy: IfNotPresent
            resources:
                limits:
                  cpu: 1000m
                requests:
                  cpu: 100m
            ports:
            - containerPort: 9200
              name: rest
              protocol: TCP
            - containerPort: 9300
              name: inter-node
              protocol: TCP
            volumeMounts:
            - name: es-keystore
              mountPath: /usr/share/elasticsearch/config/elastic-certificates.p12
              readOnly: true
              subPath: elastic-certificates.p12        
            - name: data
              mountPath: /usr/share/elasticsearch/data
            env:
              - name: cluster.name
                value: dataflux-es
              - name: node.name
                valueFrom:
                  fieldRef:
                    fieldPath: metadata.name
              - name: discovery.type
                value: "single-node"
              - name: ES_JAVA_OPTS
                value: "-Xms4g -Xmx4g"
              - name: xpack.security.enabled
                value: "true"
              - name: xpack.security.transport.ssl.enabled
                value: "true"
              - name: xpack.security.transport.ssl.verification_mode
                value: "certificate"
              - name: xpack.security.transport.ssl.keystore.path
                value: "/usr/share/elasticsearch/config/elastic-certificates.p12"
              - name: xpack.security.transport.ssl.truststore.path
                value: "/usr/share/elasticsearch/config/elastic-certificates.p12"
              - name: xpack.license.self_generated.type
                value: "basic"
              - name: action.auto_create_index
                value: "+security*"      
          volumes:
          - name: es-keystore
            secret:
              secretName: es-keystore
              defaultMode: 0444 
          initContainers:
          - name: fix-permissions
            image: pubrepo.guance.com/googleimages/busybox:1.35.0
            imagePullPolicy: IfNotPresent
            command: ["sh", "-c", "chown -R 1000:1000 /usr/share/elasticsearch/data"]
            securityContext:
              privileged: true
            volumeMounts:
            - name: data
              mountPath: /usr/share/elasticsearch/data
          - name: increase-vm-max-map
            image: pubrepo.guance.com/googleimages/busybox:1.35.0
            imagePullPolicy: IfNotPresent
            command: ["sysctl", "-w", "vm.max_map_count=262144"]
            securityContext:
              privileged: true
          - name: increase-fd-ulimit
            image: pubrepo.guance.com/googleimages/busybox:1.35.0
            imagePullPolicy: IfNotPresent
            command: ["sh", "-c", "ulimit -n 65536"]
            securityContext:
              privileged: true
      volumeClaimTemplates:
      - metadata:
          name: data
          annotations:
            volume.beta.kubernetes.io/storage-provisioner: "kubernetes.io/nfs"
            volume.kubernetes.io/storage-provisioner: "kubernetes.io/nfs"
          labels:
            app: elasticsearch
        spec:
          accessModes: [ "ReadWriteOnce" ]
          storageClassName: df-nfs-storage ## 指定环境中存在的StorageClassName 若为空则使用默认storageclass （前提若配置有默认选项）##
          resources:
            requests:
              storage: 50Gi  ## 根据实际需求指定空间大小 ##
   
    ```
  执行命令安装：
```shell
kubectl create namespace middleware
kubectl apply -f es.yaml
```

### 验证部署

- 查看 pod 状态

```shell
kubectl get pods -n middleware -l app=elasticsearch
```

成功结果:

```shell
NAME           READY   STATUS    RESTARTS   AGE
es-cluster-0   1/1     Running   0          24h
```


### 配置账号

#### 创建管理员账号（需要开启认证）

通过kubectl 命令行客户端以交互方式登录到部署的es服务，执行创建超级用户操作

```shell
kubectl exec -ti -n middleware es-cluster-0 \
    -- bin/elasticsearch-users useradd copriwolf -p sayHi2Elastic -r superuser 
```

#### 修改 elastic 密码 {#changepasswd}
???+ warning "注意" 
     高亮部分中的 `{"password": "4dIv4VJQG5t5dcJOL8R5"}` 可以修改你自己密码

```shell hl_lines='4'
kubectl exec -ti -n middleware es-cluster-0 -- curl -u copriwolf:sayHi2Elastic \
       -XPUT "http://localhost:9200/_xpack/security/user/elastic/_password?pretty" \
       -H 'Content-Type: application/json' \
       -d '{"password": "4dIv4VJQG5t5dcJOL8R5"}'
```


### 如何卸载

```shell
kubectl delete -f es.yaml
kubectl delete -n middleware pvc data-es-cluster-0
```



## 控制面板部署


=== "OpenSearch"
    - 部署
    保存 opensearch-dashboards.yaml ，并部署。

    ???- note "opensearch-dashboards.yaml (单击点开)" 
        ```yaml
        ---
        # Source: opensearch-dashboards/templates/service.yaml
        apiVersion: v1
        kind: Service
        metadata:
          name: opensearch-dashboards
          namespace: middleware
          labels:
            app.kubernetes.io/name: opensearch-dashboards
            app.kubernetes.io/instance: dashboard
            app.kubernetes.io/version: "2.3.0"
        spec:
          type: NodePort
          ports:
          - port: 5601
            protocol: TCP
            name: http
            targetPort: 5601
            nodePort: 31601
          selector:
            app: opensearch-dashboards
            release: "dashboard"
        ---
        # Source: opensearch-dashboards/templates/deployment.yaml
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          name: opensearch-dashboards
          namespace: middleware
          labels:
            app.kubernetes.io/name: opensearch-dashboards
            app.kubernetes.io/instance: dashboard
            app.kubernetes.io/version: "2.3.0"
        spec:
          replicas: 1
          strategy:
            type: Recreate
          selector:
            matchLabels:
              app: opensearch-dashboards
              release: "dashboard"
          template:
            metadata:
              labels:
                app: opensearch-dashboards
                release: "dashboard"
              annotations:
            spec:
              securityContext:
                {}
              volumes:
              containers:
              - name: dashboards
                securityContext:
                  capabilities:
                    drop:
                    - ALL
                  runAsNonRoot: true
                  runAsUser: 1000
                image: "pubrepo.jiagouyun.com/base/opensearch-dashboards:2.3.0"
                imagePullPolicy: "IfNotPresent"
                readinessProbe:
                  failureThreshold: 10
                  initialDelaySeconds: 10
                  periodSeconds: 20
                  successThreshold: 1
                  tcpSocket:
                    port: 5601
                  timeoutSeconds: 5
                livenessProbe:
                  failureThreshold: 10
                  initialDelaySeconds: 10
                  periodSeconds: 20
                  successThreshold: 1
                  tcpSocket:
                    port: 5601
                  timeoutSeconds: 5
                startupProbe:
                  failureThreshold: 20
                  initialDelaySeconds: 10
                  periodSeconds: 10
                  successThreshold: 1
                  tcpSocket:
                    port: 5601
                  timeoutSeconds: 5
                env:
                - name: OPENSEARCH_HOSTS
                  value: "http://opensearch-single:9200"
                - name: SERVER_HOST
                  value: "0.0.0.0"
                ports:
                - containerPort: 5601
                  name: http
                  protocol: TCP
                resources:
                  limits:
                    cpu: 100m
                    memory: 512M
                  requests:
                    cpu: 100m
                    memory: 512M
        ```

    ```shell
    kubectl apply -f opensearch-dashboards.yaml
    ``` 

    - 访问
    
    可以使用 `NodePort` 类型访问，`节点IP`:31601
    ![](img/22.opensearch-dashboards-login.png)

=== "Elasticsearch"

    - 部署
    保存 kibana.yaml ，并部署。

    ???- note "kibana.yaml (单击点开)" 
        ```yaml
        ---
        apiVersion: apps/v1
        kind: Deployment
        metadata:
          labels:
            cattle.io/creator: norman
            workload.user.cattle.io/workloadselector: deployment-middleware-kibana
          name: kibana
          namespace: middleware
        spec:
          progressDeadlineSeconds: 600
          replicas: 1
          revisionHistoryLimit: 10
          selector:
            matchLabels:
              workload.user.cattle.io/workloadselector: deployment-middleware-kibana
          strategy:
            rollingUpdate:
              maxSurge: 1
              maxUnavailable: 0
            type: RollingUpdate
          template:
            metadata:
              labels:
                workload.user.cattle.io/workloadselector: deployment-middleware-kibana
            spec:
              containers:
              - image: pubrepo.guance.com/googleimages/kibana:7.13.2
                imagePullPolicy: IfNotPresent
                env:
                - name: ELASTICSEARCH_URL
                  value: http://elasticsearch:9200
                name: kibana
                ports:
                - containerPort: 5601
                  name: 5601tcp2
                  protocol: TCP
                - containerPort: 5601
                  name: 5601tcp1
                  protocol: TCP
                resources: {}
                securityContext:
                  allowPrivilegeEscalation: false
                  privileged: false
                  readOnlyRootFilesystem: false
                  runAsNonRoot: false
                stdin: true
                terminationMessagePath: /dev/termination-log
                terminationMessagePolicy: File
                tty: true
                volumeMounts:
                - mountPath: /usr/share/kibana/config/kibana.yml
                  name: kibana-cfg
                  subPath: kibana.yml
              dnsPolicy: ClusterFirst
              imagePullSecrets:
              - name: devops
              - name: registry-key
              restartPolicy: Always
              schedulerName: default-scheduler
              securityContext: {}
              terminationGracePeriodSeconds: 30
              volumes:
              - configMap:
                  defaultMode: 420
                  name: kibana-cfg
                  optional: false
                name: kibana-cfg


        ---
        apiVersion: v1
        data:
          kibana.yml: |-
            server.name: kibana
            server.host: "0.0.0.0"
            xpack.monitoring.ui.container.elasticsearch.enabled: true
            i18n.locale: "zh-CN"

            elasticsearch.hosts: ["http://elasticsearch:9200"]
            elasticsearch.username: "elastic"
            elasticsearch.password: "4dIv4VJQG5t5dcJOL8R5"
        kind: ConfigMap
        metadata:
          name: kibana-cfg
          namespace: middleware

        ---
        apiVersion: v1
        kind: Service
        metadata:
          name: kibana
          namespace: middleware
          labels:
            app: kibana
        spec:
          ports:
          - port: 5601
            protocol: TCP
            targetPort: 5601
            nodePort: 32601
          type: NodePort
          selector:
            workload.user.cattle.io/workloadselector: deployment-middleware-kibana

        ```

    ```shell
    kubectl apply -f kibana.yaml
    ```

    - 访问
    
    可以使用 `NodePort` 类型访问，`节点IP`:32601
    ![](img/22.kibana-login.png)