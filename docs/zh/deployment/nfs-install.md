# NFS 服务部署

???+ warning "注意"

    NFS 服务不在 Kubernetes 集群中部署，需要单独机器部署。
## 简介 {#info}

NFS（Network File System）即网络文件系统，它的功能就是可以通过网络，让不同的机器、不同的操作系统可以共享彼此的文件。


## 前提条件

- 可以访问公网

## 基础信息及兼容

|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|      路径      | /nfsdata （确保该目录容量大，并且是数据盘） |
|    是否支离线安装    |                       否                        |
|       支持架构       |                   amd64/arm64                   |
|      部署机器IP      |                 192.168.100.105                 |


## 安装步骤
 
### 1、安装准备

#### 1.1 关闭防火墙服务

```shell
systemctl stop firewalld
systemctl disable firewalld
```

### 2、安装

#### 2.1 安装 nfs 服务

执行以下命令安装 nfs 服务器所需的软件包并创建挂载目录（请设置数据盘，这里以nfsdata位置数据目录）

```shell
yum install -y rpcbind nfs-utils
mkdir	/nfsdata

```

#### 2.2 配置 nfs 共享路径

执行命令 `vim /etc/exports`，创建 exports 文件，文件内容如下：

```shell
#/nfsdata *(insecure,rw,async,no_root_squash)
/nfsdata *(rw,no_root_squash,no_all_squash,insecure) 
```

#### 2.3 启动 nfs 服务

执行以下命令，启动 nfs 服务

```shell
systemctl enable rpcbind
systemctl enable nfs-server
systemctl restart rpcbind
systemctl restart nfs-server
```



#### 2.4 验证配置

检查配置是否生效

```shell
exportfs
```

查询本机nfs共享目录情况

```shell
showmount -e localhost
```

### 3、验证部署

#### 3.1 安装客户端

执行以下命令安装 nfs 客户端所需的软件包

```shell
yum install -y nfs-utils
```

#### 3.2 查看共享目录

???+ warning "注意"

    192.168.100.105 是本篇文章测试 IP，您需要更换你的 nfs 地址。

执行以下命令检查 nfs 服务器端是否有设置共享目录

```shell 
# showmount -e $(nfs服务器的IP)
showmount -e 192.168.100.105
# 输出结果如下所示
Export list for 192.168.100.105:
/nfsdata *
```

#### 3.3 远程挂载测试

???+ warning "注意"

    192.168.100.105 是本篇文章测试 IP，您需要更换你的 nfs 地址。

执行以下命令挂载 nfs 服务器上的共享目录到本机路径 `/data`

```sh
mkdir /data
# mount -t nfs $(nfs服务器的IP):/nfsdata /data
mount -t nfs 192.168.100.105:/nfsdata /data
# 写入一个测试文件
echo "hello nfs server" > /data/test.txt
```

#### 3.4 查看测试结果

在 nfs 服务器上执行以下命令，验证文件写入成功

```sh
cat /nfsdata/test.txt
```

测试成功输出：

```shell
hello nfs server
```
