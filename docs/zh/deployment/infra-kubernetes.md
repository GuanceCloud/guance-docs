# Kubernetes 集群部署

## 简介

sealos 是一个简单的 go 二进制文件，可以安装在大多数 Linux 操作系统中。可用于灵活用于部署 Kubernetes 集群。

## 前提条件

- 每个集群节点应该有不同的主机名。 主机名不要带下划线。
- 所有节点的时间同步。
- 所有节点可以使用root用户互相ssh登陆，而且所有节点root密码相同。
- 在 Kubernetes 集群的第一个节点上运行sealos run命令，目前集群外的节点不支持集群安装。
- 建议使用干净的操作系统来创建集群。不要自己装 Docker。
- 支持大多数 Linux 发行版，例如：Ubuntu CentOS Rocky linux。
- 支持使用 containerd 作为容器运行时。
- 在公有云上请使用私有 IP。


## 基础信息及兼容

|   主机名   |     IP地址      |  角色  |          配置k8          |
| :--------: | :-------------: | :----: | :----------------------: |
| k8s-master | 192.168.100.101 | master | 4 CPU, 16G MEM, 100G DISK |
| K8s-node01 | 192.168.100.102 | node01 | 4 CPU, 16G MEM, 100G DISK |
| K8s-node02 | 192.168.100.103 | node02 | 4 CPU, 16G MEM, 100G DISK |

|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|    是否支离线安装    |                       是                        |
|       支持架构       |                   amd64/arm64                   |




## 安装步骤

### 1、设置主机名

分别执行以下命令：

```shell
hostnamectl set-hostname k8s-master
hostnamectl set-hostname k8s-node01
hostnamectl set-hostname k8s-node02
```

### 2、同步主机时间

每个节点执行以下命令：

```shell
# 安装 ntpdate
yum install ntpdate -y

# 同步本地时间
ntpdate time.windows.com

# 跟网络源做同步
ntpdate cn.pool.ntp.org
```

> 你也可以设置 crontab
> 
> `* */1 * * * /usr/sbin/ntpdate cn.pool.ntp.org`

### 3、 安装 sealos 命令

执行以下命令安装：

=== "amd64"

    ``` shell
    wget https://{{{ custom_key.static_domain }}}/dataflux/package/sealos_4.1.5_linux_amd64.tar.gz \
       && tar zxvf sealos_4.1.5_linux_amd64.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin
    ```
=== "arm64"

    ``` shell
    wget https://{{{ custom_key.static_domain }}}/dataflux/package/sealos_4.1.5_linux_arm64.tar.gz \
       && tar zxvf sealos_4.1.5_linux_arm64.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin
    ```

验证是否部署成功：

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
> 只要在一台机器中安装即可。


### 4、安装集群

```shell
sealos run pubrepo.guance.com/googleimages/kubernetes:v1.24.0 \
    pubrepo.guance.com/googleimages/calico:v3.22.1 \
    --masters 192.168.100.101     \
    --nodes 192.168.100.102,192.168.100.103     \
    --passwd [your-ssh-passwd] 
```

> 注意命令中的 ip 和密码需要修改。

> 请务必是 root 用户，节点环境端口要互通。

参数说明：

|    参数名    |           参数值示例            |            参数说明            |
| :----------: | :-----------------------------: | :----------------------------: |
|  --masters   |         192.168.100.101         | kubernetes master 节点地址列表 |
|   --nodes    | 192.168.100.102,192.168.100.103 |  kubernetes node 节点地址列表  |
|   --passwd   |        [your-ssh-passwd]        |          ssh 登录密码          |
|  kubernetes  |   labring/kubernetes:v1.24.0    |        kubernetes 镜像         |




### 验证安装

```shell
kubectl get nodes
```

## 其他

### 增加节点

#### 增加 node 节点：

```shell
sealos add --nodes 192.168.100.104,192.168.100.105
```

#### 增加 master 节点：

```shell
sealos add --masters 192.168.100.104,192.168.100.105
```

### 删除节点

#### 删除 node 节点：

```shell
sealos delete --nodes 192.168.100.104,192.168.100.105
```

#### 删除 master 节点：

```shell
sealos delete --masters 192.168.100.104,192.168.100.105
```

### 如何卸载

```shell
sealos reset
```
