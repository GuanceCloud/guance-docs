# Best Practices for Deploying DataKit on Rancher

---

> _Author: Liu Yujie_

## Introduction

Rancher is an open-source enterprise-grade platform for managing Kubernetes clusters. To simplify the deployment of DataKit in a Kubernetes cluster, DataKit supports deployment via the application market on the Rancher platform. Additionally, DataKit provides the functionality to manage collector configuration files using a Git repository.

Deploying DataKit using Rancher and managing collector configurations with Git is one of the best ways to deploy DataKit in a Kubernetes cluster. By deploying DataKit via DaemonSet, the Container collector is enabled by default. For more flexible configuration of the Container collector, this article uses a custom approach to enable the Container collector, i.e., managing the `container.conf` file through a Git repository, then deploying DataKit via the Rancher application market, and finally verifying that the collector configuration in the Git repository takes effect by checking the collected metrics.

## Prerequisites

- Install [Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/) 1.18+
- Install [Rancher](https://rancher.com/docs/rancher/v2.6/en/installation/), and have permissions to operate on Kubernetes clusters
- Install [GitLab](https://about.gitlab.com/)
- Install [Helm](https://github.com/helm/helm) 3.0+

## Steps

???+ warning

    The version information used in this example is as follows: DataKit `1.4.5`, Kubernetes `1.22.6`, Rancher `2.6.3`, GitLab `14.9.4`

### Step 1: Create the dk-config Repository

Log in to **GitLab**, click on **Create blank project**

![image](../images/rancher-install-1.png)

Enter `datakit-conf` as the Project name, and click **Create Project**.

![image](../images/rancher-install-2.png)

Enter the dk-config project and create a new `container.conf` file with the following content. The container has metric collection enabled, and all image stdout logs are disabled.

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

Then click **Clone** - **Clone with HTTP**, obtaining the git address [http://120.26.37.252/root/dk-config.git](http://120.26.37.252/root/dk-config.git).

### Step 2: Create Namespace

For easier management, install DataKit into the `datakit` namespace.<br/>
Log in to **Rancher** - **Cluster** - **Projects/Namespaces**, and click **Create Namespace**.

![image](../images/rancher-install-4.png)

Enter the name `datakit`, and click **Create**.

![image](../images/rancher-install-5.png)

### Step 3: Add Chart Repository

Log in to **Rancher** - **Cluster** - **App Market** - **Chart Repositories**, and click **Create**. Enter the name **datakit**, and URL [https://pubrepo.guance.com/chartrepo/datakit](https://pubrepo.guance.com/chartrepo/datakit), then click **Create**.

![image](../images/rancher-install-6.png)

### Step 4: Deploy DataKit

Log in to **Rancher** - **Cluster** - **App Market** - **Charts**, select **datakit**, and you will see the icon labeled **DataKit**. Click to enter.

![image](../images/rancher-install-7.png)

Click **Install**.

![image](../images/rancher-install-8.png)

Select the namespace `datakit`, and click **Next**.

![image](../images/rancher-install-9.png)

Click **DataKit Configuration**, replace `<your-token>` with the Guance token. Since this deployment uses a custom container collector configuration, remove `container` from the `Enable the default Inputs`.

![image](../images/rancher-install-10.png)

Click **Git Management Configurations** to set up the Git repository information as shown below.

- Select **Enable Use Git Management Configurations**
- Enter the Git URL for `dk-config` [http://120.26.37.252/root/dk-config.git](http://120.26.37.252/root/dk-config.git), and append the Git username root and password xxxxxx after `http://`.
- Enter the branch `main`.

Then click **Install**

> **Note:** If you select **Enable git SSH key**, it means pulling the Git repository configuration via SSH.

![image](../images/rancher-install-11.png)

Click **Kube-State-Metrics**, select **Deployment KubeState Metrics Deployment** to install the `kube-state-metrics` component; if not needed, leave it unselected.

![image](../images/rancher-install-12.png)

Click **metrics-server**, select **Deployment kubeState Metrics Server Deployment** to install the `metrics-server` component; if not needed, leave it unselected.

Finally, click **Install**

![image](../images/rancher-install-13.png)

### Step 5: Resource Limits

To limit the CPU and memory usage of DataKit, resource limits can be set using Rancher.

Go to **Cluster** - **Workloads** - **DaemonSets**, click on the right side of the datakit row, choose **Edit Configuration**, then click **Resource Limits and Reservations**. Allocate resources reasonably based on server capacity, then click **Save**.

![image](../images/rancher-install-14.png)

### Step 6: Verify Metric Collection

Log in to **Rancher**, click on the command line icon in the top-right corner, and execute the following commands to enter datakit.<br/>
Check if there is a `container.conf` file under the `gitrepos` directory to confirm that the Git repository configuration was successfully pulled.

```shell
 kubectl get pods -n datakit
 kubectl exec -it datakit-qc58m -n datakit bash
 cd gitrepos/
 ls
```

![image](../images/rancher-install-15.png)

Log in to **[Guance](https://console.guance.com/)** - **Metrics**, select the **kubernetes** Mearsurement, and check if there is data in the metrics, indicating that metric collection is normal.

![image](../images/rancher-install-16.png)

### Step 7: Upgrade

When there is a new version of DataKit available, the Rancher UI will show the upgradable version.

Go to Rancher **Cluster** - **App Market** - **Installed Apps**, in the `datakit` row under the **Upgrade** column, there is a pending upgrade version `1.4.6`. Click to enter the upgrade interface.

![image](../images/rancher-install-17.png)

Select version `1.4.6`, and click **Next**.

![image](../images/rancher-install-18.png)

Click **Upgrade**.

![image](../images/rancher-install-19.png)

After the upgrade is complete, you can see that the DataKit version is now `1.4.6`.

![image](../images/rancher-install-20.png)