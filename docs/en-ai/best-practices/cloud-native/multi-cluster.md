# Best Practices for Collecting Metrics from Multiple Kubernetes Clusters

---

## Introduction

When connecting multiple Kubernetes clusters to a workspace, you need to set the `ENV_NAMESPACE` environment variable with a non-empty value. The values for different clusters must not be the same.

```yaml
- name: ENV_NAMESPACE
  value: xxx
```  
  
For collecting metrics from multiple Kubernetes clusters in a single workspace, Guance provides a method using global Tags to differentiate between clusters. When there is only one collection object in the cluster, such as collecting **Kubernetes API Server** metrics, the number of DataKit instances in the cluster will be greater than one. To avoid duplicate metric collection, DataKit enables an **election** feature. In this case, the way to distinguish clusters is by adding `ENV_GLOBAL_ELECTION_TAGS`.

```yaml
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=k8s-prod
```

For non-election-based metric collection, such as collecting metrics by adding annotations to Pods, Guance provides a method to add global Tags in the `ENV_GLOBAL_HOST_TAGS` environment variable.

```yaml
- name: ENV_GLOBAL_HOST_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
```

The collected metric sets will all have the `cluster_name_k8s` Tag with the value `k8s-prod`, which is the principle behind distinguishing clusters.

Below, we will provide a detailed explanation using the example of collecting **Kubernetes API Server** metrics from multiple clusters.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+
- Guance account

## Steps

### Step 1 Deploy DataKit on Test Environment Cluster

#### 1.1 Download datakit.yaml

Log in to the [Guance Console](https://console.guance.com/), click on "Integrations" - "DataKit" - "Kubernetes", and download `datakit.yaml`.

#### 1.2 Replace Token

Log in to the [Guance Console](https://console.guance.com/), go to the "Management" module, copy the token from "Basic Settings", and replace `<your-token>` in the `ENV_DATAWAY` environment variable value in `datakit.yaml`.

#### 1.3 Add Global Tags

- In the `datakit.yaml` file, add `cluster_name_k8s=k8s-test` to the value of the `ENV_GLOBAL_HOST_TAGS` environment variable.
- Add the environment variable `ENV_GLOBAL_ELECTION_TAGS`, so the test environment cluster will be `k8s-test`.
- Set the `ENV_NAMESPACE` environment variable value to `k8s-test`. This enables DataKit election, ensuring that only one DataKit collects Kubernetes API Server metrics within the workspace + this namespace.

```yaml
- name: ENV_NAMESPACE
  value: k8s-test
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=k8s-test
```

![image](../images/multi-cluster-1.png)

#### 1.4 Configure Kubernetes API Server Metric Collection

Refer to the [Kubernetes API Server Integration Documentation](../../integrations/kubernetes-api-server.md).

#### 1.5 Deploy DataKit

Upload `datakit.yaml` to the Master node of the test cluster and execute the deployment command.

```yaml
kubectl apply -f datakit.yaml
```

### Step 2 Deploy DataKit on Production Environment Cluster

#### 2.1 Modify datakit.yaml

Use the `datakit.yaml` from **Step 1**, change `k8s-test` to `k8s-prod`, so the production environment cluster will be `k8s-prod`.  
You also need to modify the `url` in `api-server.conf`.

![image](../images/multi-cluster-2.png)

#### 2.2 Deploy DataKit

Upload `datakit.yaml` to the Master node of the production cluster and execute the deployment command.

```yaml
kubectl apply -f datakit.yaml
```

### Step 3 View Preview

#### 3.1 Metric Preview

Log in to the [Guance Console](https://console.guance.com/), click on "Metrics", search for `prom_api_server`, and under the `cluster_name_k8s` label, you should see the names of two clusters.

![image](../images/multi-cluster-3.png)

#### 3.2 Create New View

Log in to the [Guance Console](https://console.guance.com/), click on "Scenes" - "Create Dashboard", select **Kubernetes API Server Monitoring View**, and you can now distinguish clusters from the dropdown list of cluster names.

![image](../images/multi-cluster-4.png)