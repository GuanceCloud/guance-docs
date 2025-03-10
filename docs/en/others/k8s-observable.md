# How to Collect Kubernetes Resources

---

## Introduction

<<< custom_key.brand_name >>> supports monitoring the operational status and service capabilities of various resources in Kubernetes, including Containers, Pods, Services, Deployments, Clusters, Nodes, Replica Sets, Jobs, Cron Jobs, etc. You can install DataKit via DaemonSet in Kubernetes to collect data from Kubernetes resources. Ultimately, you can monitor the operation of various Kubernetes resources in real-time within <<< custom_key.brand_name >>>.

## Prerequisites

You need to first create a [<<< custom_key.brand_name >>> account](https://www.guance.com/).

## Methods/Steps

There are two methods to install DataKit via DaemonSet in Kubernetes:

- Helm Installation
- Yaml Installation

### Helm Installation

#### Prerequisites

- Kubernetes >= 1.14
- Helm >= 3.0+

#### Step1: Add the DataKit Helm Repository

To install DataKit for collecting Kubernetes resources using Helm, you need to install Helm on your server first. After installing Helm, you can add the DataKit Helm repository.

Note: After adding the DataKit Helm repository, you must run the update command `helm repo update`.

```
$ helm repo add datakit https://pubrepo.guance.com/chartrepo/datakit
$ helm repo update 
```

![](img/2.helm_1.png)

#### Step2: Install DataKit Using Helm

Modify the token data in the `datakit.dataway_url` parameter in the Helm installation command for DataKit.

```
$ helm install datakit datakit/datakit -n datakit --set datakit.dataway_url="https://openway.guance.com?token=<your-token>" --create-namespace 
```

You can obtain the token from the <<< custom_key.brand_name >>> workspace under "Manage" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, execute the Helm installation command for DataKit.

![](img/2.helm_2.png)

#### Step3: Check Deployment Status

Once DataKit is installed, you can check the deployment status with `$ helm -n datakit list`.

![](img/2.helm_3.png)

#### Step4: View and Analyze Collected K8S Data in <<< custom_key.brand_name >>> Workspace

Once the DataKit deployment status is normal, you can view and analyze the collected K8S data in the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Containers".

![](img/2.helm_4.png)

### Yaml Installation

#### Step1: Download the Yaml File

Before starting the collection of Kubernetes resources, use a terminal tool to log into the server and execute the following script command to download the yaml file.

```
wget https://static.<<< custom_key.brand_main_domain >>>/datakit/datakit.yaml
```

![](img/3.yaml_3.png)

#### Step2: Modify the datakit.yaml File

Edit the datakit.yaml file to configure the data gateway (dataway) and replace the token with your workspace token.

```
	- name: ENV_DATAWAY
		value: https://openway.guance.com?token=<your-token> # Replace this with your workspace token
```

You can obtain the token from the <<< custom_key.brand_name >>> workspace under "Manage" - "Basic Settings".

![](img/1.contrainer_2.png)

After replacing the token, save the datakit.yaml file.

![](img/3.yaml_2.png)

#### Step3: Install the Yaml File

After modifying the data gateway configuration in the datakit.yaml file, use the command `kubectl apply -f datakit.yaml` to install the yaml file. The filename should match the one you saved.

![](img/3.yaml_4.png)

#### Step4: Check Datakit Running Status

After installing the yaml file, a DaemonSet deployment for datakit will be created. You can check the running status of datakit with the command `kubectl get pod -n datakit`.

![](img/3.yaml_5.png)

#### Step5: View and Analyze Collected K8S Data in <<< custom_key.brand_name >>> Workspace

Once the datakit running status is normal, you can view and analyze the collected K8S data in the <<< custom_key.brand_name >>> workspace under "Infrastructure" - "Containers".

![](img/3.yaml_6.png)