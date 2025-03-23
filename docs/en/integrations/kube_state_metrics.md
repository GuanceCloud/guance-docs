---
title     : 'Kube State Metrics'
summary   : 'Collect real-time information about cluster resources using Kube State Metrics'
__int_icon: 'icon/kube_state_metrics'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'Kube State Metrics'
    path  : 'dashboard/en/kube_state_metrics'
monitor   :
  - desc  : 'Kube State Metrics'
    path  : 'monitor/en/kube_state_metrics'
---

Collect real-time information about cluster resources using Kube State Metrics

## Configuration {#config}

### Deploy Kube-state-metrics

- Install Helm (this is the online installation mode)

```shell
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

- Install kube-prometheus

The kube-prometheus installation package uses the Bitnami Helm chart solution, [Bitnami Official Address](https://github.com/bitnami/charts/tree/main/bitnami/kube-prometheus)

Get the latest version of the Chart package from the community:

```shell
helm pull oci://registry-1.docker.io/bitnamicharts/kube-prometheus
```

Get the verified offline version:

```shell
docker.io/bitnami/kube-state-metrics:2.13.0-debian-12-r6
```

Run the following command to extract the file:

```shell
tar xf kube-prometheus-9.6.3.tgz
```

Values file configuration instructions:

```yaml
global:
  # Change to the private repository project address 
  imageRegistry: ""
  ## E.g.
  ## imagePullSecrets:
  ##   - myRegistryKeySecretName
  ##
  # This should be changed to the name of the secret for the private repository key
  imagePullSecrets: []
  
  # Here df-nfs-storage should be modified to a storageClass available within the cluster
  defaultstorageClass: "df-nfs-storage"
  # Here df-nfs-storage should be modified to a storageClass available within the cluster
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

Note: The namespace used for deployment must match the namespace configured in the datakit collector.

- Run the following command to deploy:

```shell
cd kube-prometheus

helm upgrade -i -n datakit --create-namespace  datakit . 
```

After deployment is complete, check whether it was successful using the following command:

```shell
kubectl get pod -n datakit
```

### Configure Datakit

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

- Mount `kubernetesprometheus.conf`
Add the following under `volumeMounts` in the `datakit.yaml` file:

```yaml
- mountPath: /usr/local/datakit/conf.d/kubernetesprometheus/kubernetesprometheus.conf
  name: datakit-conf
  subPath: kubernetesprometheus.conf
  readOnly: true
```

- Run the following commands to restart datakit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

## Metrics {#metric}

### Kube-State-Metrics Measurement Set

Metrics collected by kube-state-metrics are located under the kube-state-metrics measurement set; here we introduce related metric descriptions

| Metrics | Description | Unit |
|:--------|:------------|:-----|
|`kube_configmap_created`|`Creation time of ConfigMap resources`| s |
|`kube_cronjob_created`|`Creation time of CronJob resources`| s |
|`kube_cronjob_next_schedule_time`|`Next scheduled execution time for CronJob`| s |
|`kube_cronjob_spec_failed_job_history_limit`|`Limit on the number of failed job histories in the CronJob specification`| count |
|`kube_cronjob_spec_successful_job_history_limit`|`Limit on the number of successful job histories in the CronJob specification`| count |
|`kube_cronjob_spec_suspend`|`Whether the CronJob is suspended`| boolean |
|`kube_cronjob_status_active`|`Number of currently active jobs in CronJob`| count |
|`kube_cronjob_status_last_schedule_time`|`Last scheduling time for CronJob`| s |
|`kube_cronjob_status_last_successful_time`|`Last successful execution time for CronJob`| s |
|`kube_daemonset_created`|`Creation time of DaemonSet resources`| s |
|`kube_daemonset_metadata_generation`|`Version number of DaemonSet metadata`| count |
|`kube_daemonset_status_current_number_scheduled`|`Current number of scheduled DaemonSets`| count |
|`kube_daemonset_status_desired_number_scheduled`|`Desired number of scheduled DaemonSets`| count |
|`kube_daemonset_status_number_available`|`Number of available DaemonSets`| count |
|`kube_daemonset_status_number_misscheduled`|`Number of mis-scheduled DaemonSets`| count |
|`kube_daemonset_status_number_ready`|`Number of ready DaemonSets`| count |
|`kube_daemonset_status_number_unavailable`|`Number of unavailable DaemonSets`| count |
|`kube_daemonset_status_observed_generation`|`Observed generation of DaemonSet`| count |
|`kube_daemonset_status_updated_number_scheduled`|`Number of updated DaemonSets`| count |
|`kube_deployment_created`|`Creation time of Deployment resources`| s |
|`kube_deployment_metadata_generation`|`Version number of Deployment metadata`| count |
|`kube_deployment_spec_paused`|`Whether Deployment is paused`| boolean |
|`kube_deployment_spec_replicas`|`Desired number of replicas in Deployment specification`| count |
|`kube_deployment_spec_strategy_rollingupdate_max_surge`|`Maximum additional replicas during Deployment rolling update`| count |
|`kube_deployment_spec_strategy_rollingupdate_max_unavailable`|`Maximum unavailable replicas during Deployment rolling update`| count |
|`kube_deployment_status_observed_generation`|`Observed generation of Deployment`| count |
|`kube_deployment_status_replicas`|`Current number of replicas in Deployment`| count |
|`kube_deployment_status_replicas_available`|`Current number of available replicas in Deployment`| count |
|`kube_deployment_status_replicas_ready`|`Current number of ready replicas in Deployment`| count |
|`kube_deployment_status_replicas_unavailable`|`Current number of unavailable replicas in Deployment`| count |
|`kube_deployment_status_replicas_updated`|`Current number of updated replicas in Deployment`| count |
|`kube_endpoint_address_available`|`Number of available Endpoint addresses`| count |
|`kube_endpoint_address_not_ready`|`Number of non-ready Endpoint addresses`| count |
|`kube_endpoint_created`|`Creation time of Endpoint resources`| s |
|`kube_endpoint_info`|`Detailed information about Endpoint resources`| - |
|`kube_endpoint_ports`|`Port information for Endpoints`| - |
|`kube_ingress_created`|`Creation time of Ingress resources`| s |
|`kube_ingress_info`|`Detailed information about Ingress resources`| -s |
|`kube_ingress_metadata_resource_version`|`Version number of Ingress resources`| count |
|`kube_ingress_path`|`Path information for Ingress`| - |
|`kube_job_complete`|`Whether Job is completed`| boolean |
|`kube_job_created`|`Creation time of Job resources`| s |
|`kube_job_info`|`Detailed information about Job resources`| - |
|`kube_job_spec_completions`|`Number of jobs expected to complete in Job specification`| count |
|`kube_job_spec_parallelism`|`Number of parallel jobs expected in Job specification`| count |
|`kube_job_status_active`|`Number of currently active jobs in Job`| count |
|`kube_job_status_completion_time`|`Completion time of Job`| s |
|`kube_job_status_failed`|`Number of failed jobs in Job`| count |
|`kube_job_status_start_time`|`Start time of Job`| s |
|`kube_job_status_succeeded`|`Number of successful jobs in Job`| count |
|`kube_lease_renew_time`|`Renewal time of Lease`| s |
|`kube_namespace_created`|`Creation time of Namespace resources`| s |
|`kube_namespace_status_phase`|`Phase status of Namespace`| count |
|`kube_networkpolicy_created`|`Creation time of NetworkPolicy resources`| s |
|`kube_networkpolicy_spec_egress_rules`|`Number of egress rules in NetworkPolicy specification`| count |
|`kube_networkpolicy_spec_ingress_rules`|`Number of ingress rules in NetworkPolicy specification`| count |
|`kube_node_created`|`Creation time of Node resources`| s |
|`kube_node_spec_unschedulable`|`Whether Node is unschedulable`| boolean |
|`kube_node_status_addresses`|`Address information for Node status`| count |
|`kube_node_status_capacity`|`Capacity information for Node`| count |
|`kube_node_status_condition`|`Condition information for Node status`| count |
|`kube_persistentvolume_capacity_bytes`|`Capacity of PersistentVolume`| byte |
|`kube_persistentvolume_created`|`Creation time of PersistentVolume resources`| s |
|`kube_persistentvolume_info`|`Detailed information about PersistentVolume resources`| count |
|`kube_persistentvolumeclaim_created`|`Creation time of PersistentVolumeClaim resources`| s |
|`kube_persistentvolumeclaim_resource_requests_storage_bytes`|`Storage resource requested by PersistentVolumeClaim`| byte |
|`kube_pod_completion_time`|`Completion time of Pod`| s |
|`kube_pod_container_state_started`|`Whether container in Pod has started`| boolean |
|`kube_pod_container_status_last_terminated_exitcode`|`Exit code of last termination of container in Pod`| count |
|`kube_pod_container_status_last_terminated_timestamp`|`Timestamp of last termination of container in Pod`| s |
|`kube_pod_container_status_ready`|`Whether container in Pod is ready`| boolean |
|`kube_pod_container_status_restarts_total`|`Total number of restarts for container in Pod`| count |
|`kube_pod_container_status_running`|`Whether container in Pod is running`| boolean |
|`kube_pod_container_status_terminated`|`Whether container in Pod has terminated`| boolean |
|`kube_pod_container_status_waiting`|`Whether container in Pod is waiting`| boolean |
|`kube_pod_created`|`Creation time of Pod resources`| s |
|`kube_pod_deletion_timestamp`|`Deletion timestamp of Pod resources`| s |
|`kube_pod_init_container_status_ready`|`Whether init container in Pod is ready`| boolean |
|`kube_pod_init_container_status_restarts_total`|`Total number of restarts for init container in Pod`| count |
|`kube_pod_init_container_status_running`|`Whether init container in Pod is running`| boolean |
|`kube_pod_init_container_status_terminated`|`Whether init container in Pod has terminated`| boolean |
|`kube_pod_init_container_status_waiting`|`Whether init container in Pod is waiting`| boolean |
|`kube_pod_spec_volumes_persistentvolumeclaims_readonly`|`Whether PersistentVolumeClaim in Pod specification is read-only`| boolean |
|`kube_pod_start_time`|`Start time of Pod`| s |
|`kube_pod_status_container_ready_time`|`Time when container in Pod becomes ready`| s |
|`kube_pod_status_initialized_time`|`Time when initialization of Pod is completed`| s |
|`kube_pod_status_ready`|`Whether Pod is ready`| boolean |
|`kube_pod_status_ready_time`|`Time when Pod becomes ready`| s |
|`kube_pod_status_scheduled`|`Whether Pod is scheduled`| boolean |
|`kube_poddisruptionbudget_status_current_healthy`|`Current number of healthy Pods in PodDisruptionBudget`| count |
|`kube_poddisruptionbudget_status_desired_healthy`|`Desired number of healthy Pods in PodDisruptionBudget`| count |
|`kube_poddisruptionbudget_status_expected_pods`|`Expected number of Pods in PodDisruptionBudget`| count |
|`kube_poddisruptionbudget_status_observed_generation`|`Observed generation in PodDisruptionBudget`| count |
|`kube_poddisruptionbudget_status_pod_disruptions_allowed`|`Allowed number of Pod disruptions in PodDisruptionBudget`| count |
|`kube_replicaset_created`|`Creation time of ReplicaSet resources`| s |
|`kube_replicaset_spec_replicas`|`Desired number of replicas in ReplicaSet specification`| count |
|`kube_replicaset_status_fully_labeled_replicas`|`Number of fully labeled replicas in ReplicaSet`| count |
|`kube_replicaset_status_observed_generation`|`Observed generation in ReplicaSet`| count |
|`kube_replicaset_status_ready_replicas`|`Number of ready replicas in ReplicaSet`| count |
|`kube_replicaset_status_replicas`|`Current number of replicas in ReplicaSet`| count |
|`kube_secret_created`|`Creation time of Secret resources`| s |
|`kube_service_created`|`Creation time of Service resources`| s |
|`kube_statefulset_created`|`Creation time of StatefulSet resources`| s |
|`kube_statefulset_replicas`|`Current number of replicas in ReplicaSet`| count |
|`kube_statefulset_status_observed_generation`|`Observed generation in StatefulSet`| count |
|`kube_statefulset_status_replicas`|`Current number of replicas in StatefulSet`| count |
|`kube_statefulset_status_replicas_available`|`Number of available replicas in StatefulSet`| count |
|`kube_statefulset_status_replicas_current`|`Current number of replicas in ReplicaSet`| count |
|`kube_statefulset_status_replicas_ready`|`Number of ready replicas in StatefulSet`| count |
|`kube_statefulset_status_replicas_updated`|`Number of updated replicas in StatefulSet`| count |
|`kube_storageclass_created`|`Creation time of StorageClass resources`| s |