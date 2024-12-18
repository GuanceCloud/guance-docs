---
title     : 'Kube State Metrics'
summary   : 'Collect real-time information on cluster resources through Kube State Metrics'
__int_icon: 'icon/kube_state_metrics'
dashboard :
  - desc  : 'Kube State Metrics'
    path  : 'dashboard/en/kube_state_metrics'
monitor   :
  - desc  : 'Kube State Metrics'
    path  : 'monitor/en/kube_state_metrics'
---

Collect real-time information on cluster resources through Kube State Metrics

## Config {#config}

### Deploy Kube-state-metrics

- Install Helm (this is an online installation mode)

```shell
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

- Install kube-promethues

The kube measurements installation package adopts Bitnami's Helm chart scheme，[Bitnami official address.](https://github.com/bitnami/charts/tree/main/bitnami/kube-prometheus)

Obtain the latest version of Chart package through the community:

```shell
helm pull oci://registry-1.docker.io/bitnamicharts/kube-prometheus
```

Get verified offline version:

```shell
docker.io/bitnami/kube-state-metrics:2.13.0-debian-12-r6
```

Execute the following command to decompress the file:

```shell
tar xf kube-prometheus-9.6.3.tgz
```

Values file configuration instructions:

```yaml
global:
  # Change to Private Warehouse Project Address 
  imageRegistry: ""
  ## E.g.
  ## imagePullSecrets:
  ##   - myRegistryKeySecretName
  ##
  # Change here to the secret name of the private repository key
  imagePullSecrets: []
  
  # Modify df-nfs-storage here to the storage class available within the cluster
  defaultstorageClass: "df-nfs-storage"
  # Modify df-nfs-storage here to the storage class available within the cluster
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

Note: The deployed namespace needs to be consistent with the namespace configured by the datakit collector

- Execute the following command to deploy:

```shell
cd kube-prometheus

helm upgrade -i -n datakit --create-namespace  datakit . 
```

After deployment is complete, check if the deployment is successful using the following command:

```shell
kubectl get pod -n datakit
```

### Config Datakit

- Add `kubernetesprometheus.conf` to the `ConfigMap` resource in `datakit.yaml`

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

- Mount`kubernetesprometheus.conf`
Add under `volumeMounts` in the `datakit. yaml`file

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- Execute the following command to restart the datakit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metrics {#metric}

### kube-state-metrics metrics set

The metrics collected by kube state metrics are located under the kube state metrics metric set. Here is an introduction to the relevant metrics

| Metrics | description | unit |
|:--------|:-----|:--|
|`kube_configmap_created`|`The creation time of the Config Map resource`| s |
|`kube_cronjob_created`|`Creation time of CronJob resource`| s |
|`kube_cronjob_next_schedule_time`|`CronJob's next scheduled execution time`| s |
|`kube_cronjob_spec_failed_job_history_limit`|`The limit on the number of failed job history records in the CronJob specification`| count |
|`kube_cronjob_spec_successful_job_history_limit`|`The limit on the number of successful job history records in the CronJob specification`| count |
|`kube_cronjob_spec_suspend`|`Is CronJob suspended`| boolean |
|`kube_cronjob_status_active`|`The current number of active jobs for CronJob`| count |
|`kube_cronjob_status_last_schedule_time`|`CronJob's Last Scheduling Time`| s |
|`kube_cronjob_status_last_successful_time`|`Last successful execution time of CronJob`| s |
|`kube_daemonset_created`|`The creation time of DaemonSet resource`| s |
|`kube_daemonset_metadata_generation`|`Version number of DaemonSet metadata`| count |
|`kube_daemonset_status_current_number_scheduled`|`The current number of scheduled DaemonSets`| count |
|`kube_daemonset_status_desired_number_scheduled`|`Expected number of scheduled DaemonSets`| count |
|`kube_daemonset_status_number_available`|`Number of available DaemonSets`| count |
|`kube_daemonset_status_number_misscheduled`|`Number of DaemonSets with scheduling errors`| count |
|`kube_daemonset_status_number_ready`|`Number of ready DaemonSets`| count |
|`kube_daemonset_status_number_unavailable`|`Number of unavailable DaemonSets`| count |
|`kube_daemonset_status_observed_generation`|`Observed DaemonSet Algebra`| count |
|`kube_daemonset_status_updated_number_scheduled`|`Number of updated DaemonSets`| count |
|`kube_deployment_created`|`Creation time of Deployment resource`| s |
|`kube_deployment_metadata_generation`|`Version number of deployment metadata`| count |
|`kube_deployment_spec_paused`|`Has the deployment been paused`| boolean |
|`kube_deployment_spec_replicas`|`Expected number of replicas in Deployment specification`| count |
|`kube_deployment_spec_strategy_rollingupdate_max_surge`|`Maximum additional replicas in Deployment rolling update strategy`| count |
|`kube_deployment_spec_strategy_rollingupdate_max_unavailable`|`The maximum number of unavailable replicas in the Deployment rolling update strategy`| count |
|`kube_deployment_status_observed_generation`|`Observed Deployment Algebra`| count |
|`kube_deployment_status_replicas`|`Deploy the current number of replicas`| count |
|`kube_deployment_status_replicas_available`|`Number of currently available replicas for deployment`| count |
|`kube_deployment_status_replicas_ready`|`The current number of ready replicas for deployment`| count |
|`kube_deployment_status_replicas_unavailable`|`Number of replicas currently unavailable for deployment`| count |
|`kube_deployment_status_replicas_updated`|`The current number of updated replicas for Deployment`| count |
|`kube_endpoint_address_available`|`Number of available Endpoint addresses`| count |
|`kube_endpoint_address_not_ready`|`Number of Endpoint addresses not yet ready`| count |
|`kube_endpoint_created`|`Creation time of Endpoint resource`| s |
|`kube_endpoint_info`|`Details of Endpoint Resources`| - |
|`kube_endpoint_ports`|`Endpoint port information`| - |
|`kube_ingress_created`|`Creation time of Ingress resource`| s |
|`kube_ingress_info`|`Detailed information about Ingress resources`| -s |
|`kube_ingress_metadata_resource_version`|`Version number of Ingress resource`| count |
|`kube_ingress_path`|`Ingress's path information`| - |
|`kube_job_complete`|`Has the job been completed`| boolean |
|`kube_job_created`|`The creation time of job resources`| s |
|`kube_job_info`|`Detailed information of job resources`| - |
|`kube_job_spec_completions`|`The expected number of tasks to be completed in job specifications`| count |
|`kube_job_spec_parallelism`|`Expected number of parallel jobs in Job specifications`| count |
|`kube_job_status_active`|`The current number of active jobs in the job`| count |
|`kube_job_status_completion_time`|`Job completion time`| s |
|`kube_job_status_failed`|`Number of job failures`| count |
|`kube_job_status_start_time`|`The start time of the job`| s |
|`kube_job_status_succeeded`|`The number of successful jobs in the job`| count |
|`kube_lease_renew_time`|`Lease's renewal period`| s |
|`kube_namespace_created`|`Creation time of namespace resource`| s |
|`kube_namespace_status_phase`|`Status stage of namespace`| count |
|`kube_networkpolicy_created`|`Creation time of NetworkPolicy resource`| s |
|`kube_networkpolicy_spec_egress_rules`|`The number of outbound rules in the NetworkPolicy specification`| count |
|`kube_networkpolicy_spec_ingress_rules`|`The number of inbound rules in the NetworkPolicy specification`| count |
|`kube_node_created`|`Creation time of Node resource`| s |
|`kube_node_spec_unschedulable`|`Is the node schedulable`| boolean |
|`kube_node_status_addresses`|`Node's status address information`| count |
|`kube_node_status_capacity`|`Capacity information of Node`| count |
|`kube_node_status_condition`|`Node's state conditions`| count |
|`kube_persistentvolume_capacity_bytes`|`The capacity of PersistentVolume`| byte |
|`kube_persistentvolume_created`|`Creation time of PersistentVolume resource`| s |
|`kube_persistentvolume_info`|`Details of PersistentVolume resources`| count |
|`kube_persistentvolumeclaim_created`|`The creation time of PersistentVolumeClaim resource`| s |
|`kube_persistentvolumeclaim_resource_requests_storage_bytes`|`PersistentVolumeClaim requests storage resources`| byte |
|`kube_pod_completion_time`|`Pod completion time`| s |
|`kube_pod_container_state_started`|`Has the container in Pod been started`| boolean |
|`kube_pod_container_status_last_terminated_exitcode`|`Last termination exit code of container in Pod`| count |
|`kube_pod_container_status_last_terminated_timestamp`|`The timestamp of the last termination of the container in Pod`| s |
|`kube_pod_container_status_ready`|`Is the container in Pod ready`| boolean |
|`kube_pod_container_status_restarts_total`|`The total number of restarts of containers in Pod`| count |
|`kube_pod_container_status_running`|`Is the container running in Pod`| boolean |
|`kube_pod_container_status_terminated`|`Has the container in Pod terminated`| boolean |
|`kube_pod_container_status_waiting`|`Is the container in Pod waiting`| boolean |
|`kube_pod_created`|`Creation time of Pod resource`| s |
|`kube_pod_deletion_timestamp`|`Delete timestamp of Pod resources`| s |
|`kube_pod_init_container_status_ready`|`Is the Pod initialization container ready`| boolean |
|`kube_pod_init_container_status_restarts_total`|`The total number of restarts for Pod initialization container`| count |
|`kube_pod_init_container_status_running`|`Is the Pod initialization container running`| boolean |
|`kube_pod_init_container_status_terminated`|`Has the Pod initialization container terminated`| boolean |
|`kube_pod_init_container_status_waiting`|`Is the Pod initialization container waiting`| boolean |
|`kube_pod_spec_volumes_persistentvolumeclaims_readonly`|`Is PersistentVolumeClaim read-only in Pod specification`| boolean |
|`kube_pod_start_time`|`Pod start time`| s |
|`kube_pod_status_container_ready_time`|`Time for container readiness in Pod`| s |
|`kube_pod_status_initialized_time`|`Time of Pod initialization completion`| s |
|`kube_pod_status_ready`|`Is Pod ready`| boolean |
|`kube_pod_status_ready_time`|`Pod readiness time`| s |
|`kube_pod_status_scheduled`|`Has the Pod been scheduled`| boolean |
|`kube_poddisruptionbudget_status_current_healthy`|`PodDisruptionBudget: The current number of healthy Pods`| count |
|`kube_poddisruptionbudget_status_desired_healthy`|`PodDisruptionBudget expects a healthy number of Pods`| count |
|`kube_poddisruptionbudget_status_expected_pods`|`Expected number of Pods for PodDisruptionBudget`| count |
|`kube_poddisruptionbudget_status_observed_generation`|`Algebraic observations from PodDisruptionBudget`| count |
|`kube_poddisruptionbudget_status_pod_disruptions_allowed`|`The number of Pod interruptions allowed by PodDisruptionBudget`| count |
|`kube_replicaset_created`|`Creation time of ReplicaSet resource`| s |
|`kube_replicaset_spec_replicas`|`Expected number of replicas in ReplicaSet specification`| count |
|`kube_replicaset_status_fully_labeled_replicas`|`Number of fully labeled replicas in ReplicaSet`| count |
|`kube_replicaset_status_observed_generation`|`Algebra observed by ReplicaSet`| count |
|`kube_replicaset_status_ready_replicas`|`Number of ReplicaSet ready replicas`| count |
|`kube_replicaset_status_replicas`|`ReplicaSet current number of replicas`| count |
|`kube_secret_created`|`Creation time of Secret resource`| s |
|`kube_service_created`|`Creation time of Service resource`| s |
|`kube_statefulset_created`|`The creation time of StatefulSet resource`| s |
|`kube_statefulset_replicas`|`ReplicaSet current number of replicas`| count |
|`kube_statefulset_status_observed_generation`|`Algebraic observations of StatefulSet`| count |
|`kube_statefulset_status_replicas`|`The current number of replicas in StatefulSet`| count |
|`kube_statefulset_status_replicas_available`|`Number of available replicas for StatefulSet`| count |
|`kube_statefulset_status_replicas_current`|`ReplicaSet current number of replicas`| count |
|`kube_statefulset_status_replicas_ready`|`Number of replicas ready for StatefulSet`| count |
|`kube_statefulset_status_replicas_updated`|`Number of updated copies of StatefulSet`| count |
|`kube_storageclass_created`|`Creation time of Storage Class resources`| s |
