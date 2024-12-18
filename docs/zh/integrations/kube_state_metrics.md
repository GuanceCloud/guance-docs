---
title     : 'Kube State Metrics'
summary   : '通过 Kube State Metrics 收集集群资源实时信息'
__int_icon: 'icon/kube_state_metrics'
dashboard :
  - desc  : 'Kube State Metrics'
    path  : 'dashboard/zh/kube_state_metrics'
monitor   :
  - desc  : 'Kube State Metrics'
    path  : 'monitor/zh/kube_state_metrics'
---

通过 Kube State Metrics 收集集群资源实时信息

## 配置 {#config}

### 部署 Kube-state-metrics

- 安装 Helm(此为在线安装模式)

```shell
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

- 安装 kube-promethues

kube-promethues  安装包采用了 Bitnami 的 Helm chart 方案，[Bitnami 官方地址](https://github.com/bitnami/charts/tree/main/bitnami/kube-prometheus)

通过社区获取最新版本Chart 包:

```shell
helm pull oci://registry-1.docker.io/bitnamicharts/kube-prometheus
```

获取已验证的离线版本:

```shell
docker.io/bitnami/kube-state-metrics:2.13.0-debian-12-r6
```

执行以下命令解压文件:

```shell
tar xf kube-prometheus-9.6.3.tgz
```

Values 文件配置说明:

```yaml
global:
  # 修改为私有仓库项目地址 
  imageRegistry: ""
  ## E.g.
  ## imagePullSecrets:
  ##   - myRegistryKeySecretName
  ##
  # 此处 修改为私有仓库密钥的secret 名称
  imagePullSecrets: []
  
  # 此处df-nfs-storage 修改为集群内可用的 storageClass
  defaultstorageClass: "df-nfs-storage"
  # 此处df-nfs-storage 修改为集群内可用的 storageClass
  storageClass: "df-nfs-storage"
  ## Compatibility adaptations for Kubernetes platforms
  ##
  compatibility:
    ## Compatibility adaptations for Openshift
    ##
    openshift:
      ## @param global.compatibility.openshift.adaptSecurityContext Adapt the securityContext sections of the deployment to make them compatible with Openshift restricted-v2 SCC: remove runAsUser, runAsGroup and fsGroup and let the platform use their allowed default IDs. Possible values: auto (apply if the detected running cluster is Openshift), force (perform the adaptation always), disabled (do not perform adaptation)
      ##
      adaptSecurityContext: auto
## @section Common parameters
....
```

注意: 部署的 namespace 需要与 datakit 采集器 配置的 namespace 保持一致

- 执行以下命令进行部署:

```shell
cd kube-prometheus

helm upgrade -i -n datakit --create-namespace  datakit . 
```

部署完成后，通过以下命令查看是否部署成功:

```shell
kubectl get pod -n datakit
```

### 配置Datakit

- 在 `datakit.yaml` 中的 `ConfigMap` 资源中添加 `kubernetesprometheus.conf`

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    kubernetesprometheus.conf: |-
      [inputs.kubernetesprometheus]
        
        [[inputs.kubernetesprometheus.instances]]
          role       = "service"
          namespaces = ["datakit"]
          selector   = "app.kubernetes.io/name=kube-state-metrics"

          scrape     = "true"
          scheme     = "http"
          port       = "__kubernetes_service_port_http_port"
          path       = "/metrics"
          params     = ""
          interval   = "15s"

          [inputs.kubernetesprometheus.instances.custom]
            measurement        = "kube-state-metrics"
            job_as_measurement = true
            [inputs.kubernetesprometheus.instances.custom.tags]
              cluster_name_k8s       = "promethues-cluster"
              job           = "kube-state-metrics"
              svc_name      = "__kubernetes_service_name"
              pod_name      = "__kubernetes_service_target_name"
              pod_namespace = "__kubernetes_service_target_namespace"
          [inputs.kubernetesprometheus.instances.auth]
            bearer_token_file      = "/var/run/secrets/kubernetes.io/serviceaccount/token"
            [inputs.kubernetesprometheus.instances.auth.tls_config]
              insecure_skip_verify = true
              cert     = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
```

- 挂载`kubernetesprometheus.conf`
在`datakit.yaml` 文件中 `volumeMounts`下添加

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- 执行以下命令，重启 datakit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## 指标 {#metric}

### kube-state-metrics 指标集

kube-state-metrics 采集的指标位于 kube-state-metrics 指标集下，这里介绍指标相关说明

| Metrics | 描述 |单位 |
|:--------|:-----|:--|
|`kube_configmap_created`|`ConfigMap资源的创建时间`| s |
|`kube_cronjob_created`|`CronJob资源的创建时间`| s |
|`kube_cronjob_next_schedule_time`|`CronJob下一次计划执行时间`| s |
|`kube_cronjob_spec_failed_job_history_limit`|`CronJob规范中失败作业历史记录的限制数量`| count |
|`kube_cronjob_spec_successful_job_history_limit`|`CronJob规范中成功作业历史记录的限制数量`| count |
|`kube_cronjob_spec_suspend`|`CronJob是否被挂起`| boolean |
|`kube_cronjob_status_active`|`CronJob当前活跃的作业数量`| count |
|`kube_cronjob_status_last_schedule_time`|`CronJob最后一次调度时间`| s |
|`kube_cronjob_status_last_successful_time`|`CronJob最后一次成功执行时间`| s |
|`kube_daemonset_created`|`DaemonSet资源的创建时间`| s |
|`kube_daemonset_metadata_generation`|`DaemonSet元数据的版本号`| count |
|`kube_daemonset_status_current_number_scheduled`|`当前已调度的DaemonSet数量`| count |
|`kube_daemonset_status_desired_number_scheduled`|`期望已调度的DaemonSet数量`| count |
|`kube_daemonset_status_number_available`|`可用的DaemonSet数量`| count |
|`kube_daemonset_status_number_misscheduled`|`调度错误的DaemonSet数量`| count |
|`kube_daemonset_status_number_ready`|`就绪的DaemonSet数量`| count |
|`kube_daemonset_status_number_unavailable`|`不可用的DaemonSet数量`| count |
|`kube_daemonset_status_observed_generation`|`观察到的DaemonSet代数`| count |
|`kube_daemonset_status_updated_number_scheduled`|`已更新的DaemonSet数量`| count |
|`kube_deployment_created`|`Deployment资源的创建时间`| s |
|`kube_deployment_metadata_generation`|`Deployment元数据的版本号`| count |
|`kube_deployment_spec_paused`|`Deployment是否被暂停`| boolean |
|`kube_deployment_spec_replicas`|`Deployment规范中期望的副本数量`| count |
|`kube_deployment_spec_strategy_rollingupdate_max_surge`|`Deployment滚动更新策略中的最大额外副本数`| count |
|`kube_deployment_spec_strategy_rollingupdate_max_unavailable`|`Deployment滚动更新策略中的最大不可用副本数`| count |
|`kube_deployment_status_observed_generation`|`观察到的Deployment代数`| count |
|`kube_deployment_status_replicas`|`Deployment当前的副本数量`| count |
|`kube_deployment_status_replicas_available`|`Deployment当前可用的副本数量`| count |
|`kube_deployment_status_replicas_ready`|`Deployment当前就绪的副本数量`| count |
|`kube_deployment_status_replicas_unavailable`|`Deployment当前不可用的副本数量`| count |
|`kube_deployment_status_replicas_updated`|`Deployment当前已更新的副本数量`| count |
|`kube_endpoint_address_available`|`可用的Endpoint地址数量`| count |
|`kube_endpoint_address_not_ready`|`未就绪的Endpoint地址数量`| count |
|`kube_endpoint_created`|`Endpoint资源的创建时间`| s |
|`kube_endpoint_info`|`Endpoint资源的详细信息`| - |
|`kube_endpoint_ports`|`Endpoint的端口信息`| - |
|`kube_ingress_created`|`Ingress资源的创建时间`| s |
|`kube_ingress_info`|`Ingress资源的详细信息`| -s |
|`kube_ingress_metadata_resource_version`|`Ingress资源的版本号`| count |
|`kube_ingress_path`|`Ingress的路径信息`| - |
|`kube_job_complete`|`Job是否完成`| boolean |
|`kube_job_created`|`Job资源的创建时间`| s |
|`kube_job_info`|`Job资源的详细信息`| - |
|`kube_job_spec_completions`|`Job规范中期望完成的工作数量`| count |
|`kube_job_spec_parallelism`|`Job规范中期望的并行工作数量`| count |
|`kube_job_status_active`|`Job当前活跃的工作数量`| count |
|`kube_job_status_completion_time`|`Job完成的时间`| s |
|`kube_job_status_failed`|`Job失败的工作数量`| count |
|`kube_job_status_start_time`|`Job开始的时间`| s |
|`kube_job_status_succeeded`|`Job成功的工作数量`| count |
|`kube_lease_renew_time`|`Lease的续订时间`| s |
|`kube_namespace_created`|`Namespace资源的创建时间`| s |
|`kube_namespace_status_phase`|`Namespace的状态阶段`| count |
|`kube_networkpolicy_created`|`NetworkPolicy资源的创建时间`| s |
|`kube_networkpolicy_spec_egress_rules`|`NetworkPolicy规范中的出站规则数量`| count |
|`kube_networkpolicy_spec_ingress_rules`|`NetworkPolicy规范中的入站规则数量`| count |
|`kube_node_created`|`Node资源的创建时间`| s |
|`kube_node_spec_unschedulable`|`Node是否不可调度`| boolean |
|`kube_node_status_addresses`|`Node的状态地址信息`| count |
|`kube_node_status_capacity`|`Node的容量信息`| count |
|`kube_node_status_condition`|`Node的状态条件`| count |
|`kube_persistentvolume_capacity_bytes`|`PersistentVolume的容量`| byte |
|`kube_persistentvolume_created`|`PersistentVolume资源的创建时间`| s |
|`kube_persistentvolume_info`|`PersistentVolume资源的详细信息`| count |
|`kube_persistentvolumeclaim_created`|`PersistentVolumeClaim资源的创建时间`| s |
|`kube_persistentvolumeclaim_resource_requests_storage_bytes`|`PersistentVolumeClaim请求的存储资源`| byte |
|`kube_pod_completion_time`|`Pod完成的时间`| s |
|`kube_pod_container_state_started`|`Pod中容器是否已启动`| boolean |
|`kube_pod_container_status_last_terminated_exitcode`|`Pod中容器上次终止的退出码`| count |
|`kube_pod_container_status_last_terminated_timestamp`|`Pod中容器上次终止的时间戳`| s |
|`kube_pod_container_status_ready`|`Pod中容器是否就绪`| boolean |
|`kube_pod_container_status_restarts_total`|`Pod中容器的总重启次数`| count |
|`kube_pod_container_status_running`|`Pod中容器是否正在运行`| boolean |
|`kube_pod_container_status_terminated`|`Pod中容器是否已终止`| boolean |
|`kube_pod_container_status_waiting`|`Pod中容器是否正在等待`| boolean |
|`kube_pod_created`|`Pod资源的创建时间`| s |
|`kube_pod_deletion_timestamp`|`Pod资源的删除时间戳`| s |
|`kube_pod_init_container_status_ready`|`Pod初始化容器是否就绪`| boolean |
|`kube_pod_init_container_status_restarts_total`|`Pod初始化容器的总重启次数`| count |
|`kube_pod_init_container_status_running`|`Pod初始化容器是否正在运行`| boolean |
|`kube_pod_init_container_status_terminated`|`Pod初始化容器是否已终止`| boolean |
|`kube_pod_init_container_status_waiting`|`Pod初始化容器是否正在等`| boolean |
|`kube_pod_spec_volumes_persistentvolumeclaims_readonly`|`Pod规范中PersistentVolumeClaim是否为只读`| boolean |
|`kube_pod_start_time`|`Pod开始的时间`| s |
|`kube_pod_status_container_ready_time`|`Pod中容器就绪的时间`| s |
|`kube_pod_status_initialized_time`|`Pod初始化完成的时间`| s |
|`kube_pod_status_ready`|`Pod是否就绪`| boolean |
|`kube_pod_status_ready_time`|`Pod就绪的时间`| s |
|`kube_pod_status_scheduled`|`Pod是否已调度`| boolean |
|`kube_poddisruptionbudget_status_current_healthy`|`PodDisruptionBudget当前健康的Pod数量`| count |
|`kube_poddisruptionbudget_status_desired_healthy`|`PodDisruptionBudget期望健康的Pod数量`| count |
|`kube_poddisruptionbudget_status_expected_pods`|`PodDisruptionBudget期望的Pod数量`| count |
|`kube_poddisruptionbudget_status_observed_generation`|`PodDisruptionBudget观察到的代数`| count |
|`kube_poddisruptionbudget_status_pod_disruptions_allowed`|`PodDisruptionBudget允许的Pod中断数量`| count |
|`kube_replicaset_created`|`ReplicaSet资源的创建时间`| s |
|`kube_replicaset_spec_replicas`|`ReplicaSet规范中期望的副本数量`| count |
|`kube_replicaset_status_fully_labeled_replicas`|`ReplicaSet完全标签化的副本数量`| count |
|`kube_replicaset_status_observed_generation`|`ReplicaSet观察到的代数`| count |
|`kube_replicaset_status_ready_replicas`|`ReplicaSet就绪的副本数量`| count |
|`kube_replicaset_status_replicas`|`ReplicaSet当前的副本数量`| count |
|`kube_secret_created`|`Secret资源的创建时间`| s |
|`kube_service_created`|`Service资源的创建时间`| s |
|`kube_statefulset_created`|`StatefulSet资源的创建时间`| s |
|`kube_statefulset_replicas`|`ReplicaSet当前的副本数量`| count |
|`kube_statefulset_status_observed_generation`|`StatefulSet观察到的代数`| count |
|`kube_statefulset_status_replicas`|`StatefulSet当前的副本数量`| count |
|`kube_statefulset_status_replicas_available`|`StatefulSet可用的副本数量`| count |
|`kube_statefulset_status_replicas_current`|`ReplicaSet当前的副本数量`| count |
|`kube_statefulset_status_replicas_ready`|`StatefulSet就绪的副本数量`| count |
|`kube_statefulset_status_replicas_updated`|`StatefulSet已更新的副本数量`| count |
|`kube_storageclass_created`|`StorageClass资源的创建时间`| s |
