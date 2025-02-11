# How to Collect Kubernetes Resources

---

## Introduction

Guance supports monitoring the operational status and service capabilities of various resources in Kubernetes, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc. You can install DataKit via DaemonSet in Kubernetes to collect data from Kubernetes resources. Ultimately, you can monitor the operation of various Kubernetes resources in real-time using Guance.

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

To install DataKit for collecting Kubernetes resources using Helm, you need to [install Helm](https://helm.sh/zh/docs/intro/install/) on your server first. After installing Helm, you can add the DataKit Helm repository.

Note: After adding the DataKit Helm repository, you must run the upgrade command `helm repo update`.

```
$ helm repo add datakit https://pubrepo.guance.com/chartrepo/datakit
$ helm repo update 
```

![](img/2.helm_1.png)

#### Step 2: Install DataKit Using Helm

Modify the `datakit.dataway_url` token in the Helm installation command for DataKit.

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" --create-namespace 
```

You can obtain the token from the Guance workspace under "Management" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, execute the Helm installation command for DataKit.

![](img/2.helm_2.png)

#### Step 3: Check Deployment Status

After DataKit is installed, you can check the deployment status using `$ helm -n datakit list`.

![](img/2.helm_3.png)

#### Step 4: View and Analyze Collected K8S Data in the Guance Workspace

Once the DataKit deployment status is normal, you can view and analyze the collected K8S data in the Guance workspace under "Infrastructure" - "Containers".

![](img/2.helm_4.png)

### Yaml Installation

#### Step 1: Download the Yaml File

Before enabling Kubernetes resource collection, you need to log into the server using a terminal tool and execute the following script command to download the yaml file.

```
wget https://static.guance.com/datakit/datakit.yaml
```

![](img/3.yaml_3.png)

#### Step 2: Modify the datakit.yaml File

Edit the data gateway configuration in the datakit.yaml file and replace the token with your workspace token.

```
	- name: ENV_DATAWAY
		value: https://openway.guance.com?token=<your-token> # Replace this with your workspace token
```

You can obtain the token from the Guance workspace under "Management" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, save the datakit.yaml file.

![](img/3.yaml_2.png)

#### Step 3: Install the Yaml File

After modifying the data gateway configuration in the datakit.yaml file, use the command `kubectl apply -f datakit.yaml` to install the yaml file, where `datakit.yaml` is the filename (use the filename you saved it as).

![](img/3.yaml_4.png)

#### Step 4: Check DataKit Running Status

After installing the yaml file, a DataKit DaemonSet deployment will be created. You can check the running status of DataKit using the command `kubectl get pod -n datakit`.

![](img/3.yaml_5.png)

#### Step 5: View and Analyze Collected K8S Data in the Guance Workspace

Once the DataKit running status is normal, you can view and analyze the collected K8S data in the Guance workspace under "Infrastructure" - "Containers".

![](img/3.yaml_6.png)