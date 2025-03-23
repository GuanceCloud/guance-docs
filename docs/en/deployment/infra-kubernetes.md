# Kubernetes Cluster Deployment

## Introduction

Sealos is a simple Go binary file that can be installed on most Linux operating systems. It can be flexibly used to deploy Kubernetes clusters.

## Prerequisites

- Each cluster node should have a different hostname. Hostnames should not contain underscores.
- Time synchronization across all nodes.
- All nodes can log in to each other via SSH using the root user, and all nodes must have the same root password.
- Run the `sealos run` command on the first node of the Kubernetes cluster. Currently, external nodes are not supported for cluster installation.
- It is recommended to use a clean operating system to create the cluster. Do not install Docker manually.
- Supports most Linux distributions, such as: Ubuntu CentOS Rocky Linux.
- Supports using containerd as the container runtime.
- Use private IPs on public clouds.


## Basic Information and Compatibility

|   Hostname   |     IP Address      |  Role  |          k8 Configuration          |
| :--------: | :-------------: | :----: | :----------------------: |
| k8s-master | 192.168.100.101 | master | 4 CPUs, 16GB MEM, 100GB DISK |
| K8s-node01 | 192.168.100.102 | node01 | 4 CPUs, 16GB MEM, 100GB DISK |
| K8s-node02 | 192.168.100.103 | node02 | 4 CPUs, 16GB MEM, 100GB DISK |

|     Name     |                   Description                   |
| :------------------: | :---------------------------------------------: |
|    Whether offline installation is supported    |                       Yes                        |
|       Supported architectures       |                   amd64/arm64                   |




## Installation Steps

### 1. Set Hostnames

Run the following commands separately:

```shell
hostnamectl set-hostname k8s-master
hostnamectl set-hostname k8s-node01
hostnamectl set-hostname k8s-node02
```

### 2. Synchronize Host Times

Run the following commands on each node:

```shell
# Install ntpdate
yum install ntpdate -y

# Synchronize local time
ntpdate time.windows.com

# Sync with network source
ntpdate cn.pool.ntp.org
```

> You can also set up crontab
> 
> `* */1 * * * /usr/sbin/ntpdate cn.pool.ntp.org`

### 3. Install sealos Command

Run the following command to install:

=== "amd64"

    ``` shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/sealos_4.1.5_linux_amd64.tar.gz \
       && tar zxvf sealos_4.1.5_linux_amd64.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin
    ```
=== "arm64"

    ``` shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/sealos_4.1.5_linux_arm64.tar.gz \
       && tar zxvf sealos_4.1.5_linux_arm64.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin
    ```

Verify if the deployment was successful:

```shell
$ sealos -h

Simplest way to install Kubernetes tools.

Usage:
  sealos [command]

Available Commands:
  add         add some node
  apply       apply a Kubernetes cluster
  build       build an cloud image from a Kubefile
  completion  Generate the autocompletion script for the specified shell
  create      Create a cluster without running the CMD
  delete      delete some node
  exec        exec a shell command or script on all node.
  gen         Generate a Clusterfile
  help        Help about any command
  images      list cloud image
  load        load cloud image
  login       login image repository
  logout      logout image repository
  prune       prune  image
  pull        pull cloud image
  push        push cloud image
  reset       Simplest way to reset your cluster
  rmi         Remove one or more cloud images
  run         Simplest way to run your Kubernetes HA cluster
  save        save cloud image to a tar file
  scp         copy local file to remote on all node.
  tag         tag a image as a new one
  version     version

Flags:
      --cluster-root string   cluster root directory (default "/var/lib/sealos")
      --debug                 enable debug logger
  -h, --help                  help for sealos

Use "sealos [command] --help" for more information about a command.
```
> You only need to install it on one machine.


### 4. Install Cluster

```shell
sealos run pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/kubernetes:v1.24.0 \
    pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/calico:v3.22.1 \
    --masters 192.168.100.101     \
    --nodes 192.168.100.102,192.168.100.103     \
    --passwd [your-ssh-passwd] 
```

> Note that the IP addresses and passwords in the command need to be modified.

> Make sure you are logged in as the root user, and the ports in the node environment must be accessible to each other.

Parameter descriptions:

|    Parameter Name    |           Parameter Value Example            |            Parameter Description            |
| :----------: | :-----------------------------: | :----------------------------: |
|  --masters   |         192.168.100.101         | Kubernetes master node address list |
|   --nodes    | 192.168.100.102,192.168.100.103 |  Kubernetes node node address list  |
|   --passwd   |        [your-ssh-passwd]        |          SSH login password          |
|  Kubernetes  |   labring/kubernetes:v1.24.0    |        Kubernetes image         |



### Verify Installation

```shell
kubectl get nodes
```

## Others

### Add Nodes

#### Add Node Nodes:

```shell
sealos add --nodes 192.168.100.104,192.168.100.105
```

#### Add Master Nodes:

```shell
sealos add --masters 192.168.100.104,192.168.100.105
```

### Delete Nodes

#### Delete Node Nodes:

```shell
sealos delete --nodes 192.168.100.104,192.168.100.105
```

#### Delete Master Nodes:

```shell
sealos delete --masters 192.168.100.104,192.168.100.105
```

### How to Uninstall

```shell
sealos reset
```