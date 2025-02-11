# How to Collect Pod Objects
---

## Introduction

Guance supports collecting Kubelet Pod Metrics and objects from the current host and reporting them to Guance. In the workspace under "Infrastructure" - "Containers" - "Pods", you can quickly view and analyze Pod data information. Collecting Pod object data in Kubernetes can be done by installing DataKit via a DaemonSet.

## Prerequisites

You need to first create a [Guance account](https://www.guance.com/).

## Methods/Steps

There are two methods to install DataKit via DaemonSet in Kubernetes:

- Helm Installation
- Yaml Installation

### Helm Installation

#### Prerequisites

- Kubernetes >= 1.14
- Helm >= 3.0+

#### Step 1: Add the DataKit Helm Repository

To install DataKit for collecting Kubernetes resources using Helm, you need to install Helm on your server first. After completing the Helm installation, you can add the DataKit Helm repository.

Note: After adding the DataKit Helm repository, you must run the upgrade command `helm repo update`.

```
$ helm repo add datakit https://pubrepo.guance.com/chartrepo/datakit
$ helm repo update 
```

![](img/2.helm_1.png)

#### Step 2: Install DataKit via Helm

Modify the token data in the `datakit.dataway_url` field of the Helm installation command for DataKit.

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" --create-namespace 
```

The token can be obtained from the Guance workspace under "Management" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, execute the Helm installation command for DataKit.

![](img/2.helm_2.png)

#### Step 3: Check Deployment Status

After DataKit is installed, you can check the deployment status with `$ helm -n datakit list`.

![](img/2.helm_3.png)

#### Step 4: View and Analyze Collected Pod Data in the Guance Workspace

Once the DataKit deployment status is normal, you can view and analyze the collected K8S data in the Guance workspace under "Infrastructure" - "Containers".

![](img/3.yaml_7.png)

### Yaml Installation

#### Step 1: Download the Yaml File

Before enabling Kubernetes resource collection, use a terminal tool to log into the server and execute the following script command to download the yaml file.

```
wget https://static.guance.com/datakit/datakit.yaml
```

![](img/3.yaml_3.png)

#### Step 2: Modify the datakit.yaml File

Edit the data gateway configuration for dataway in the datakit.yaml file and replace the token with your workspace token.

```
	- name: ENV_DATAWAY
		value: https://openway.guance.com?token=<your-token> # Replace this with your workspace token
```

The token can be obtained from the Guance workspace under "Management" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, save the datakit.yaml file.

![](img/3.yaml_2.png)

#### Step 3: Install the Yaml File

After modifying the data gateway configuration in the datakit.yaml file, use the command `kubectl apply -f datakit.yaml` to install the yaml file. The filename should match what you saved it as.

![](img/3.yaml_4.png)

#### Step 4: Check DataKit Running Status

After installing the yaml file, a DataKit DaemonSet deployment will be created. You can check the DataKit running status with the command `kubectl get pod -n datakit`.

![](img/3.yaml_5.png)

#### Step 5: View and Analyze Collected K8S Data in the Guance Workspace

Once DataKit is running normally, you can view and analyze the collected K8S data in the Guance workspace under "Infrastructure" - "Containers".

![](img/3.yaml_7.png)

## Additional Information

After collecting Pod object data, the collection of Metrics data is disabled by default. To collect Pod Metrics data, refer to [Containers](../integrations/container.md).