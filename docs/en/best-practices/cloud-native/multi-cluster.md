# Best Practices for Collecting Metrics from Multiple Kubernetes Clusters

---

## Introduction

When a workspace connects to multiple Kubernetes clusters, the ENV_NAMESPACE environment variable must be set to a non-empty string, and the values for different clusters must not be the same.

```yaml
- name: ENV_NAMESPACE
  value: xxx
```  
  
For a workspace connecting to multiple Kubernetes clusters metrics, <<< custom_key.brand_name >>> provides a method using global Tags to distinguish them. When there is only one collection target in the cluster, such as collecting **Kubernetes API Server** metrics, the number of DataKits in the cluster will be greater than one. To avoid duplicate metric collection, DataKit enables an **election** feature. At this point, the way to differentiate clusters is by adding `ENV_GLOBAL_ELECTION_TAGS`.

```yaml
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=k8s-prod
```

For non-election-based metric collections, such as collecting metrics by adding annotations to Pods, <<< custom_key.brand_name >>> provides a method to add global Tags in the `ENV_GLOBAL_HOST_TAGS` environment variable.

```yaml
- name: ENV_GLOBAL_HOST_TAGS
  value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
```

The collected metric sets will all have the `cluster_name_k8s` Tag with the value `k8s-prod`. This is the principle of distinguishing clusters.

Below, we will provide a detailed explanation using the example of collecting **Kubernetes API Server** metrics from multiple clusters.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+
- <<< custom_key.brand_name >>> account

## Procedure Steps

### Step 1 Deploy DataKit on Test Environment Cluster

#### 1.1 Download datakit.yaml

Log in to the [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/), click on 「Integration」 - 「DataKit」 - 「Kubernetes」, and download `datakit.yaml`.

#### 1.2 Replace Token

Log in to the [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/), go to the 「Management」 module, copy the token under 「Basic Settings」, and replace `<your-token>` in the `ENV_DATAWAY` environment variable value in the `datakit.yaml` file.

#### 1.3 Add Global Tags

- In the `datakit.yaml` file, add `cluster_name_k8s=k8s-test` to the `ENV_GLOBAL_HOST_TAGS` environment variable value.
- Also add the environment variable `ENV_GLOBAL_ELECTION_TAGS`, so the test environment cluster becomes k8s-test.
- Set the `ENV_NAMESPACE` environment variable value to `k8s-test`. This activates DataKit's election, ensuring that only one DataKit in the workspace + this namespace collects Kubernetes API Server metrics.

```yaml
- name: ENV_NAMESPACE
  value: k8s-test
- name: ENV_GLOBAL_ELECTION_TAGS
  value: cluster_name_k8s=k8s-test
```

![image](../images/multi-cluster-1.png)

#### 1.4 Configure Kubernetes API Server Metric Collection

See details in the [Kubernetes API Server Integration Documentation](../../integrations/kubernetes-api-server.md).

#### 1.5 Deploy DataKit

Upload the `datakit.yaml` to the Master node of the test cluster and execute the deployment command.

```yaml
kubectl apply -f datakit.yaml
```

### Step 2 Deploy DataKit on Production Environment Cluster

#### 2.1 Modify datakit.yaml

Use the `datakit.yaml` from **Step 1**, change `k8s-test` to `k8s-prod`, so the production environment cluster becomes `k8s-prod`.<br/>
You also need to modify the `url` in `api-server.conf`.

![image](../images/multi-cluster-2.png)

#### 2.2 Deploy DataKit

Upload the `datakit.yaml` to the Master node of the production cluster and execute the deployment command.

```yaml
kubectl apply -f datakit.yaml
```

### Step 3 View Preview

#### 3.1 Metric Preview

Log in to the [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/), click on 「Metrics」, search for 「prom_api_server」, and under the `cluster_name_k8s` label, you can already see the names of two clusters.

![image](../images/multi-cluster-3.png)

#### 3.2 Create New Views

Log in to the [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/), click on 「Scenarios」 - 「Create Dashboard」, select **Kubernetes API Server Monitoring View**, and the dropdown box for cluster names can now distinguish between clusters.

![image](../images/multi-cluster-4.png)