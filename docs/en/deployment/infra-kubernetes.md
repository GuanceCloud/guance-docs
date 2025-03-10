# Kubernetes Cluster Deployment

## Introduction

Sealos is a simple Go binary that can be installed on most Linux operating systems. It can be flexibly used to deploy Kubernetes clusters.

## Prerequisites

- Each cluster node should have a different hostname. Hostnames should not contain underscores.
- Time synchronization across all nodes.
- All nodes must be able to SSH into each other using the root user, and all nodes must have the same root password.
- Run the `sealos run` command on the first node of the Kubernetes cluster; currently, external nodes do not support cluster installation.
- It is recommended to use a clean operating system to create the cluster. Do not install Docker manually.
- Supports most Linux distributions, such as Ubuntu, CentOS, Rocky Linux.
- Supports using containerd as the container runtime.
- Use private IPs in public clouds.

## Basic Information and Compatibility

|   Hostname   |     IP Address      |  Role  |          Configuration         |
| :----------: | :-----------------: | :----: | :----------------------------: |
| k8s-master   | 192.168.100.101     | master | 4 CPU, 16G MEM, 100G DISK       |
| K8s-node01   | 192.168.100.102     | node01 | 4 CPU, 16G MEM, 100G DISK       |
| K8s-node02   | 192.168.100.103     | node02 | 4 CPU, 16G MEM, 100G DISK       |

|     Name     |                   Description                  |
| :-----------: | :--------------------------------------------: |
| Offline Installation Support |                        Yes                         |
| Supported Architectures |                 amd64/arm64                  |


## Installation Steps

### 1. Set Hostnames

Run the following commands respectively:

```shell
hostnamectl set-hostname k8s-master
hostnamectl set-hostname k8s-node01
hostnamectl set-hostname k8s-node02
```

### 2. Synchronize Host Time

Run the following commands on each node:

```shell
# Install ntpdate
yum install ntpdate -y

# Synchronize local time
ntpdate time.windows.com

# Synchronize with network source
ntpdate cn.pool.ntp.org
```

> You can also set up crontab:
> 
> `* */1 * * * /usr/sbin/ntpdate cn.pool.ntp.org`

### 3. Install Sealos Command

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

Verify the installation:

```shell
$ sealos -h

simplest way install kubernetes tools.

Usage:
  sealos [command]

Available Commands:
  add         add some node
  apply       apply a kubernetes cluster
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
  run         Simplest way to run your kubernetes HA cluster
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
> Installation is only required on one machine.


### 4. Install the Cluster

```shell
sealos run pubrepo.guance.com/googleimages/kubernetes:v1.24.0 \
    pubrepo.guance.com/googleimages/calico:v3.22.1 \
    --masters 192.168.100.101     \
    --nodes 192.168.100.102,192.168.100.103     \
    --passwd [your-ssh-passwd] 
```

> Note: Modify the IP addresses and password in the command.

> Ensure you are logged in as the root user, and ensure ports are open between nodes.

Parameter Description:

| Parameter Name |           Example Value            |            Parameter Description            |
| :------------: | :--------------------------------: | :----------------------------------------: |
|  --masters    |         192.168.100.101         | List of Kubernetes master node IP addresses |
|   --nodes     | 192.168.100.102,192.168.100.103 | List of Kubernetes node IP addresses        |
|   --passwd    |        [your-ssh-passwd]        |              SSH login password             |
|  kubernetes   |   pubrepo.guance.com/googleimages/kubernetes:v1.24.0 | Kubernetes image                           |



### Verify Installation

```shell
kubectl get nodes
```

## Additional Operations

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

### Uninstall

```shell
sealos reset
```