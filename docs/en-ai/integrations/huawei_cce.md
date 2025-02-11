---
title: 'Collecting Huawei Cloud CCE Metrics Data with Guance'
tags: 
  - Huawei Cloud
summary: 'Guance supports monitoring the operational status and service capabilities of various resources in CCE, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc.'
__int_icon: 'icon/huawei_cce'
dashboard:

  - desc: 'Huawei Cloud CCE Monitoring View'
    path: 'dashboard/en/huawei_cce'

monitor:
  - desc: 'Huawei Cloud CCE Monitoring Library'
    path: 'monitor/en/huawei_cce'
---

<!-- markdownlint-disable MD025 -->
# Collecting Huawei Cloud CCE Metrics Data with Guance
<!-- markdownlint-enable -->

Guance supports monitoring the operational status and service capabilities of various resources in CCE, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc. You can install `DataKit` via DaemonSet in Kubernetes to collect data from Kubernetes resources. Finally, monitor the operational status of various Kubernetes resources in real-time using Guance.

## Configuration {#config}

### Prerequisites

- Create a Guance account
- Create a Huawei Cloud CCE cluster

### Deployment Process

There are two methods to install `DataKit` via DaemonSet in Kubernetes:

- Helm installation
- YAML installation

#### **Helm Installation**

##### **Prerequisites**

- Kubernetes >= 1.14
- Helm >= 3.0+

##### 1. Add the `Datakit` Helm Repository

To install the `Datakit` collector using Helm, you need to first install Helm on your server. After installing Helm, add the Datakit Helm repository.

```Bash
helm repo add datakit https://pubrepo.guance.com/chartrepo/datakit 
helm repo update
```

> After adding the `Datakit` Helm repository, you must execute `helm repo update` to update the local repository.

![img](imgs/cce_im01.png)

##### 2. Download the `Datakit` Chart

```Bash
# Download the datakit chart
helm pull datakit/datakit
# Extract 
tar xvf datakit-1.14.2.tgz
```

![img](imgs/cce_im02.png)

##### 3. Customize the `Datakit` Installation Parameters

Uncomment the ENV_NAMESPACE under extraEnvs and modify the cluster name.

```YAML
extraEnvs:
#  - name: ENV_NAMESPACE # electoral
#    value: k8s
```

Change to

```YAML
extraEnvs:
  - name: ENV_NAMESPACE # electoral
    value: cluster_name_k8s=hwcce-k8s
  - name: ENV_GLOBAL_ELECTION_TAGS
    value: cluster_name_k8s=hwcce-k8s
```

##### 4. Install `Datakit` Using Helm

Modify the token data in `datakit.dataway_url`.

```Bash
helm install datakit -n datakit -f datakit/values.yaml  datakit --set datakit.dataway_url="https://openway.guance.com?token=tkn_1661b3cb5fc442719eae064edb979b5d" --create-namespace
```

The token can be obtained from the Guance workspace under "Integration" -> "Datakit".

![img](imgs/cce_im03.png)

After replacing the token, execute the Helm installation for Datakit.

![img](imgs/cce_im04.png)

##### 5. Check Deployment Status

After installing Datakit, you can check the deployment status using `helm -n datakit ls`.

![img](imgs/cce_im05.png)

##### 6. View and Analyze Collected K8S Data in the Guance Workspace

Once the `DataKit` deployment is successful, you can view and analyze the collected K8S data in the Guance workspace under "Infrastructure" -> "Containers".

![img](imgs/cce_im06.png)

##### 7. Add Dashboard

After K8S data can be collected normally, you can add a new dashboard in the Guance workspace under "Scenarios" -> "Dashboards" -> "Create New Dashboard". Search for the Kubernetes monitoring view, and you will see the following dashboard.

![img](imgs/cce_im07.png)

#### YAML Installation

##### 1. Download YAML File

Before enabling Kubernetes resource collection, use a terminal tool to log in to the server and execute the following script command to download the yaml file.

```Bash
wget https://static.guance.com/datakit/datakit.yaml
```

![img](imgs/cce_im08.png)

##### 2. Modify the `datakit.yaml` File

Edit the `datakit.yaml` file to configure the data gateway `dataway`, replacing the `token` with the workspace's `token`.

```yaml
1.  - name: ENV_DATAWAY
2.    value: https://openway.guance.com?token=<your-token> # Replace with the actual dataway URL
```

Add an environment variable `ENV_NAMESPACE` to set the cluster name. The name can be customized, such as setting it to `hwcce_k8s`:

```yaml
1. - name: ENV_NAMESPACE 
     value: hwcce_k8s # Replace with the cluster name
```

Add an environment variable `ENV_GLOBAL_ELECTION_TAGS` to differentiate election metrics by cluster:

```yaml
1. - name: ENV_GLOBAL_ELECTION_TAGS
2.   value: cluster_name_k8s=hwcce_k8s # Replace with the cluster name
```

Modify the environment variable `ENV_GLOBAL_TAGS` to set global tags for non-election metrics:

```yaml
1. - name: ENV_GLOBAL_TAGS
2.   value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=hwcce_k8s # Add cluster_name_k8s here
```

The `token` can be obtained from the Guance workspace under "Integration" -> "Datakit".

![img](imgs/cce_im09.png)

After making the replacements, save the `datakit.yaml` file.

![img](imgs/cce_im10.png)

##### 3. Install the YAML File

After modifying the data gateway configuration in the `datakit.yaml` file, use the command `kubectl apply -f datakit.yaml` to install the YAML file. The filename should match the one you saved.

![img](imgs/cce_im11.png)

##### 4. Check Datakit Running Status

After installing the YAML file, a `datakit` DaemonSet deployment will be created. Use the command `kubectl get pod -n datakit` to check the running status of `datakit`.

![img](imgs/cce_im12.png)

##### 5. View and Analyze Collected K8S Data in the Guance Workspace

![img](imgs/cce_im06.png)

##### 6. Add Dashboard

After K8S data can be collected normally, you can add a new dashboard in the Guance workspace under "Scenarios" -> "Dashboards" -> "Create New Dashboard". Search for the Kubernetes monitoring view, and you will see the following dashboard.

![img](imgs/cce_im07.png)