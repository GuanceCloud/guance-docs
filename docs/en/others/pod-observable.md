# How to Collect Pod Objects
---

## Introduction

<<< custom_key.brand_name >>> supports collecting Kubelet Pod metrics and objects on the current host, and reporting them to <<< custom_key.brand_name >>>. In the workspace under "Infrastructure" - "Containers" - "Pods", you can quickly view and analyze pod data information. Collecting Pod object data in Kubernetes can be done by installing DataKit via DaemonSet.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).

## Methods/Steps

There are two ways to install DataKit in Kubernetes using DaemonSet:

- Helm Installation
- Yaml Installation

### Helm Installation

#### Prerequisites

- Kubernetes >= 1.14
- Helm >= 3.0+

#### Step 1: Add the DataKit Helm Repository

To install DataKit using Helm for collecting Kubernetes resources, you must first install Helm on your server [Install Helm](https://helm.sh/zh/docs/intro/install/). After completing the Helm installation, you can add the DataKit Helm repository.

Note: After adding the DataKit Helm repository, you must perform an update operation `helm repo update`.

```
$ helm repo add datakit https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/datakit
$ helm repo update 
```

![](img/2.helm_1.png)

#### Step 2: Install DataKit with Helm

Modify the token data in the `datakit.dataway_url` section of the Helm command used to install DataKit.

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token>" --create-namespace 
```

The token can be obtained from the <<< custom_key.brand_name >>> workspace under "Manage" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, execute the Helm command to install DataKit.

![](img/2.helm_2.png)


#### Step 3: Check Deployment Status

After successfully installing DataKit, you can check the deployment status with `$ helm -n datakit list`.

![](img/2.helm_3.png)


#### Step 4: View and Analyze Collected Pod Data in <<< custom_key.brand_name >>> Workspace

If the DataKit deployment status is normal, you can view and analyze the collected K8S data in the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Containers".

![](img/3.yaml_7.png)

### Yaml Installation

#### Step 1: Download the yaml File

Before starting Kubernetes resource collection, use a terminal tool to log in to the server and execute the following script command to download the yaml file.

```
wget https://static.<<< custom_key.brand_main_domain >>>/datakit/datakit.yaml
```

![](img/3.yaml_3.png)

#### Step 2: Modify the datakit.yaml File

Edit the datakit.yaml file to configure the data gateway (dataway) settings, replacing the token with your workspace token.

```
	- name: ENV_DATAWAY
		value: https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token> # Replace this with your workspace token
```

The token can be obtained from the <<< custom_key.brand_name >>> workspace under "Manage" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, save the datakit.yaml file.

![](img/3.yaml_2.png)

#### Step 3: Install the yaml File

After modifying the data gateway settings in the datakit.yaml file, use the command `kubectl apply -f datakit.yaml` to install the yaml file. Note that `datakit.yaml` is the filename; use the actual filename where you saved it.

![](img/3.yaml_4.png)

#### Step 4: Check the Datakit Running Status

After installing the yaml file, a DaemonSet deployment named datakit will be created. You can check its running status using the command `kubectl get pod -n datakit`.

![](img/3.yaml_5.png)

#### Step 5: View and Analyze Collected K8S Data in <<< custom_key.brand_name >>> Workspace

If the datakit is running normally, you can view and analyze the collected K8S data in the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Containers".

![](img/3.yaml_7.png)


## Others

After collecting Pod object data, metric data collection is disabled by default. To collect Pod metric data, refer to [Containers](../integrations/container.md).