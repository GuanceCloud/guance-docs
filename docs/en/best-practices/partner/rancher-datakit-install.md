# Best Practices for Deploying DataKit on Rancher

---

> _Author: Liu Yujie_

## Introduction

Rancher is an open-source platform for managing Kubernetes clusters at the enterprise level. To simplify the deployment of DataKit in Kubernetes clusters, DataKit supports deployment via the Rancher application marketplace. Additionally, DataKit provides a feature to manage collector configuration files using Git repositories.

Deploying DataKit on Rancher and managing collector configurations with Git is one of the best practices for deploying DataKit in Kubernetes clusters. By deploying DataKit using DaemonSet, the Container collector is enabled by default. For more flexible configuration of the Container collector, this guide will use a custom approach to enable the Container collector, specifically by managing the `container.conf` file through a Git repository, then deploying DataKit via the Rancher application marketplace, and finally verifying the collected metrics to ensure that the collector configuration from the Git repository has taken effect.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/), with permissions to operate Kubernetes clusters
- Install [GitLab](https://about.gitlab.com/)
- Install [Helm](https://github.com/helm/helm) 3.0+

## Procedure

???+ warning

    The version information used in this example is as follows: DataKit `1.4.5`, Kubernetes `1.22.6`, Rancher `2.6.3`, GitLab `14.9.4`

### Step 1: Create the dk-config Repository

Log in to **GitLab**, click on **Create blank project**

![image](../images/rancher-install-1.png)

Enter `datakit-conf` as the Project name, and click **Create Project**.

![image](../images/rancher-install-2.png)

Navigate into the dk-config project, create a new `container.conf` file with the following content. This configuration enables metric collection for containers and disables stdout log collection for all images.

??? quote "`container.conf`"

    ```toml
    [inputs.container]
      docker_endpoint = "unix:///var/run/docker.sock"
      containerd_address = "/var/run/containerd/containerd.sock"

      enable_container_metric = true
      enable_k8s_metric = true
      enable_pod_metric = true

      ## Containers logs to include and exclude, default collect all containers. Globs accepted.
      container_include_log = []
      container_exclude_log = ["image:*"]

      exclude_pause_container = true

      ## Removes ANSI escape codes from text strings
      logging_remove_ansi_escape_codes = false

      kubernetes_url = "https://kubernetes.default:443"

      ## Authorization level:
      ##   bearer_token -> bearer_token_string -> TLS
      ## Use bearer token for authorization. ('bearer_token' takes priority)
      ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
      ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
      bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
      # bearer_token_string = "<your-token-string>"

      [inputs.container.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"

    ```

![image](../images/rancher-install-3.png)

Then click **Clone** - **Clone with HTTP**, and obtain the git address [http://120.26.37.252/root/dk-config.git](http://120.26.37.252/root/dk-config.git).

### Step 2: Create Namespace

For easier management, install DataKit in the `datakit` namespace.<br/>
Log in to **Rancher** - **Cluster** - **Projects/Namespaces**, and click **Create Namespace**.

![image](../images/rancher-install-4.png)

Enter `datakit` as the name, and click **Create**.

![image](../images/rancher-install-5.png)

### Step 3: Add Chart Repository

Log in to **Rancher** - **Cluster** - **Marketplace** - **Chart Repositories**, and click **Create**. Enter **datakit** as the name, and input [https://pubrepo.guance.com/chartrepo/datakit](https://pubrepo.guance.com/chartrepo/datakit) as the URL, then click **Create**.

![image](../images/rancher-install-6.png)

### Step 4: Deploy DataKit

Log in to **Rancher** - **Cluster** - **Marketplace** - **Charts**, select **datakit**, and you will see an icon labeled **DataKit**. Click to enter.

![image](../images/rancher-install-7.png)

Click **Install**.

![image](../images/rancher-install-8.png)

Select the `datakit` namespace, and click **Next**.

![image](../images/rancher-install-9.png)

Click **DataKit Configuration**, replace `<your-token>` with <<< custom_key.brand_name >>>'s token. Since we are using a custom container collector configuration, remove `container` from `Enable the default Inputs`.

![image](../images/rancher-install-10.png)

Click **Git Management Configurations** to set up the Git repository information as shown below.

- Select **Enable Use Git Management Configurations**
- Enter the Git URL for `dk-config` [http://120.26.37.252/root/dk-config.git](http://120.26.37.252/root/dk-config.git), and append the Git username root and password xxxxxx after `http://`.
- Enter `main` for **The Git Branch**.

Then click **Install**.

> **Note:** If you select **Enable git SSH key**, it means pulling the Git repository configuration via SSH.

![image](../images/rancher-install-11.png)

Click **Kube-State-Metrics**, and select **Deployment KubeState Metrics Deployment** to install the `kube-state-metrics` component; if not needed, leave it unchecked.

![image](../images/rancher-install-12.png)

Click **metrics-server**, and select **Deployment kubeState Metrics Server Deployment** to install the `metrics-server` component; if not needed, leave it unchecked.

Finally, click **Install**.

![image](../images/rancher-install-13.png)

### Step 5: Resource Limits

To limit the CPU and memory usage of DataKit, you can restrict DataKit's resource consumption through Rancher.

Navigate to **Cluster** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, select **Edit Configuration**, and click **Resource Limits and Reservations**. Allocate resources reasonably based on your server's capacity, then click **Save**.

![image](../images/rancher-install-14.png)

### Step 6: Verify Metric Collection

Log in to **Rancher**, click on the command line icon in the upper-right corner, and execute the following commands to enter datakit.<br/>
Check if there is a `container.conf` file under the `gitrepos` directory, which indicates that the Git repository configuration has been successfully pulled.

```shell
 kubectl get pods -n datakit
 kubectl exec -it datakit-qc58m -n datakit bash
 cd gitrepos/
 ls
```

![image](../images/rancher-install-15.png)

Log in to **[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)** - **Metrics**, select the **kubernetes** Measurement, and verify that the metrics have data, indicating successful metric collection.

![image](../images/rancher-install-16.png)

### Step 7: Upgrade

When a new version of DataKit is available, the Rancher UI will show the upgradeable version.

Navigate to **Rancher** - **Cluster** - **Marketplace** - **Installed Apps**, and in the **Upgrade** column of the datakit row, you will see a pending upgrade version `1.4.6`. Click to enter the upgrade interface.

![image](../images/rancher-install-17.png)

Select version `1.4.6`, and click **Next**.

![image](../images/rancher-install-18.png)

Click **Upgrade**.

![image](../images/rancher-install-19.png)

After the upgrade is complete, you will see that the DataKit version is now `1.4.6`.

![image](../images/rancher-install-20.png)