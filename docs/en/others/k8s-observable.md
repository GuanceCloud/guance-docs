# How to Collect Kubernetes Resources
---

## Introduction

<<< custom_key.brand_name >>> supports monitoring the operational status and service capabilities of various resources in Kubernetes, including CONTAINERS, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc. You can install DataKit via DaemonSet in Kubernetes to collect data from Kubernetes resources. Ultimately, you can monitor the operational conditions of various Kubernetes resources in <<< custom_key.brand_name >>> in real time.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).

## Methods/Steps

There are two ways to install DataKit via DaemonSet in Kubernetes:

- Helm Installation
- Yaml Installation

### Helm Installation

#### Prerequisites

- Kubernetes >= 1.14
- Helm >= 3.0+

#### Step1: Add the DataKit Helm Repository

To install DataKit using Helm for collecting Kubernetes resources, you first need to [install Helm](https://helm.sh/zh/docs/intro/install/) on your server. After installing Helm, you can add the DataKit Helm repository.

Note: After adding the DataKit Helm repository, you must run the update command `helm repo update`.

```
$ helm repo add datakit https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/datakit
$ helm repo update 
```

![](img/2.helm_1.png)

#### Step2: Helm Install DataKit

Modify the token data in the `datakit.dataway_url` when executing the Helm installation command for DataKit.

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token>" --create-namespace 
```

The token can be obtained in the "Manage" - "Basic Settings" section of the <<< custom_key.brand_name >>> workspace.

![](img/1.contrainer_2.png)

After replacing the token, execute the Helm installation command for DataKit.

![](img/2.helm_2.png)


#### Step3: Check Deployment Status

Once DataKit is installed, you can check the deployment status by running `$ helm -n datakit list`.

![](img/2.helm_3.png)


#### Step4: View and Analyze Collected K8S Data in <<< custom_key.brand_name >>> Workspace

If the DataKit deployment status is normal, you can view and analyze the collected K8S data in the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Containers".

![](img/2.helm_4.png)

### Yaml Installation

#### Step1: Download the yaml File

Before starting the collection of Kubernetes resources, use a terminal tool to log into the server and execute the following script command to download the yaml file.

```
wget https://static.<<< custom_key.brand_main_domain >>>/datakit/datakit.yaml
```

![](img/3.yaml_3.png)

#### Step2: Modify the datakit.yaml File

Edit the configuration for the data gateway (dataway) in the datakit.yaml file and replace the token with the workspace token.

```
	- name: ENV_DATAWAY
		value: https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token> # Enter your workspace token here
```

The token can be obtained in the "Manage" - "Basic Settings" section of the <<< custom_key.brand_name >>> workspace.

![](img/1.contrainer_2.png)

After replacing the token, save the datakit.yaml file.

![](img/3.yaml_2.png)

#### Step3: Install the yaml File

After modifying the data gateway in the datakit.yaml file, use the command `kubectl apply -f datakit.yaml` to install the yaml file. The filename should match what you saved it as.

![](img/3.yaml_4.png)

#### Step4: Check the Running Status of Datakit

After installing the yaml file, a DaemonSet deployment of datakit will be created, and you can check the running status of datakit using the command `kubectl get pod -n datakit`.

![](img/3.yaml_5.png)

#### Step5: View and Analyze Collected K8S Data in <<< custom_key.brand_name >>> Workspace

If the datakit is running normally, you can view and analyze the collected K8S data in the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Containers".

![](img/3.yaml_6.png)