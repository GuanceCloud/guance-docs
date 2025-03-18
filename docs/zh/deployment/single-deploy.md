#### 单机部署
???+ warning "注意"
     单机部署只适用于POC环境,生产环境不适用。

##### 1. 先决条件

###### 1.1 使用sealos的前置条件

- 可以配置主机名， 主机名不要带下划线。
- 节点时间同步。
- 在 Kubernetes 集群的第一个节点上运行`sealos run`命令，目前集群外的节点不支持集群安装。
- 建议使用干净的操作系统来创建集群。不要自己装 Docker。
- 支持大多数 Linux 发行版，例如：Ubuntu CentOS Rocky linux。
- 已发布的支持的 Kubernetes 版本。
- 支持使用 containerd 作为容器运行时。
- 在公有云上请使用私有 IP。



##### 2. 安装部署

###### 2.1 配置安装包

2.1.1 下载安装包

=== "arm64"
    
    安装包地址：https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-middleware-arm64.tar.gz
    解压安装包：
    ```shell
    tar -zvxf guance-middleware-arm64.tar.gz
    ```

=== "amd64"
    
    安装包地址：https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-middleware-amd64.tar.gz
    解压安装包：
    ```shell
    tar -zvxf guance-middleware-amd64.tar.gz
    ```
###### 2.2 安装sealos

2.2.1 安装sealos

```shell
tar zxvf sealos_4.3.0_linux.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin && sealos -h
```
sealos常用命令汇总
```shell
sealos save            保存以及集群镜像到文件中
sealos load            从文件中load一个集群镜像
sealos images          查看镜像列表
sealos rmi             删除本地镜像
sealos run imageId     基于镜像运行一个applications
sealos version         查看sealos版本
sealos help            sealos帮助文档
```


###### 2.3 安装Kubernetes集群

2.3.1 安装Kubernetes

```shell
sealos load -i calico_3.22.1.tar.gz && sealos load -i helm_3.8.2.tar.gz && sealos load -i kubernetes_1.24.0.tar.gz && sealos images

sealos run pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/kubernetes:v1.24.0 pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/helm:v3.8.2 pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/calico:v3.22.1 --single

# 验证
kubectl get nodes 
```

2.3.2 修改containerd数据目录

containerd默认的数据目录在/ 下，在Kubernetes 1.16及之后的版本中，默认的根目录使用阈值到达85%后，节点上的pod就会被驱逐，为了避免pod被驱逐，我们需要切换containerd数据目录到数据盘上。
```shell
# 待节点都Ready后，修改containerd的数据目录
vim /etc/containerd/config.toml
root = "/data/containerd"
mkdir -p /data/containerd
cp -r /var/lib/containerd/* /data/containerd
chmod 777 -R /data/containerd
# 重启containerd
sudo systemctl restart containerd
```



###### 2.4 安装NFS

2.4.1 关闭防火墙

=== "CentOS"

    CentOS关闭命令
    ```shell
    systemctl stop firewalld
    systemctl disable firewalld
    ```

=== "Ubuntu"

    Ubuntu关闭命令
    ```shell
    sudo systemctl stop ufw.service
    sudo systemctl disable ufw.service
    ```
2.4.2 安装nfs服务

如果服务器可以访问外网，可按照以下命令部署nfs

=== "CentOS"

    CentOS安装命令
    ```shell
    yum install rpcbind nfs-utils -y
    ```
=== "Ubuntu"

    Ubuntu安装命令
    ```shell
    apt-get install nfs-kernel-server -y
    ```

如果服务器无法访问外网，在解压的文件中找到nfs-package文件夹，找到对应版本的离线包，通过以下命令安装

=== "CentOS"

    CentOS离线安装命令
    ```shell
    tar -zvxf nfs-utils.tar.gz
    cd nfs-utils
    rpm -Uvh *.rpm --nodeps --force
    ```
=== "Ubuntu"

    Ubuntu离线安装命令
    ```shell
    tar -zvxf nfs-utils.tar.gz
    cd nfs-utils
    sudo dpkg -i *.deb    
    ```

2.4.3 配置nfs共享路径

创建共享目录
```shell
mkdir /nfsdata
```
执行命令vim /etc/exports，创建exports文件，文件内容如下：

```shell
#/nfsdata *(insecure,rw,async,no_root_squash)
/nfsdata *(rw,no_root_squash,no_all_squash,insecure) 
```

>注：/nfsdata 这个目录是为nfs配置的共享目录，这个目录一般是在单独挂载的数据盘里，如/data/nfsdata

2.4.4 启动nfs服务

执行以下命令，启动nfs服务

=== "CentOS"

    CentOS启动命令
    ```shell
    systemctl enable rpcbind
    systemctl enable nfs-server
    systemctl restart rpcbind
    systemctl restart nfs-server
    ```
=== "Ubuntu"

    Ubuntu启动命令
    ```shell
    service nfs-kernel-server start   
    ```


2.4.5 验证配置

```shell
showmount -e localhost
```



###### 2.5 安装 Kubernetes Storage

2.5.1 安装 Kubernetes Storage

```shell
sealos load -i nfs_4.0.2.tar.gz
# 获取nfs集群镜像的imageId
sealos images
# 将获取到的集群镜像id替换下边的imagesId值
sealos run imagesId -e nfs_server=192.168.0.41,nfs_path=/nfsdata
```
> 注：下文中其他组件的imageId都可使用相同方式进行获取和替换

参数解释：

| Name       | Description | Value             |
| ---------- | ----------- | ----------------- |
| nfs_server | 服务端ip    | eg：192.168.3.143 |
| nfs_path   | nfs共享路径 | eg：/data/nfsdata |





###### 2.6 安装Ingress

2.6.1 安装 Ingress

```shell
sealos load -i ingress_1.3.0.tar.gz
sealos run imagesId
```

>注：如果域名直接解析到服务器上，可以将ingress deployment加上hostNetwork: true 的配置



###### 2.7 安装Openebs

2.7.1 安装Openebs

```shell
sealos load -i localpv-provisioner_3.3.0.tar.gz
sealos run imagesId
```

> 注：openebs的安装是可选的，使用本地存储，性能优于nfs


###### 2.8 创建middleware namespace

2.8.1 创建middleware namespace

```shell
kubectl create ns middleware
```



###### 2.9 安装MySQL

2.9.1 安装MySQL

sealos安装mysql
```shell
sealos load -i mysql_8.0.tar.gz 
# 样例1: 磁盘类型为nfs，storageclass名称为df-nfs-storage的部署命令
sealos run imageId -e storageclass_type=nfs,openebs_localpath='',nfs_name=df-nfs-storage
# 样例2: 磁盘类型为openebs，本地共享路径为/data/mysql_data的部署命令
sealos run imageId -e storageclass_type=openebs,openebs_localpath='/data/mysql_data',nfs_name=''
```

参数解释：

| Name              | Description                                                  | Value                                                        |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| storageclass_type | 使用sc的类型，可选nfs 或者 openebs                           | nfs 或者 openebs（必填）                                     |
| openebs_localpath | 仅在sc类型选择openebs时，需要指定本地路径                    | eg：/data/mysql_data                                    sc类型为openebs时必填 |
| nfs_name          | 如果sc类型设置为nfs，选项设置了pvc需要绑定的storageclass名称 | eg: df-nfs-storage                                            sc类型为nfs时必填 |

2.9.2 创建MySQL配置用户

```shell
# 创建guance_setup_user
kubectl -n middleware exec -it podname bash
# 键入密码 rootPassw0rd
mysql -uroot -p 
create user 'guance_setup_user'@'%' identified by 'Aa123456';
-- WITH GRANT OPTION 这个选项表示该用户可以将自己拥有的权限授权给别人
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, LOCK TABLES, CREATE TEMPORARY TABLES, TRIGGER, EXECUTE, CREATE VIEW, SHOW VIEW, EVENT, GRANT OPTION, PROCESS, REFERENCES, RELOAD,  CREATE USER, USAGE on *.* TO 'guance_setup_user'@'%' with GRANT OPTION;
FLUSH PRIVILEGES;

# 连接信息
连接地址：mysql.middleware
端口：3306
用户：guance_setup_user
密码：Aa123456
```



###### 2.10 安装Redis

2.10.1 安装Redis

```shell
sealos load -i redis_6.0.20.tar.gz
sealos run imagesId

# 连接信息
连接地址：redis.middleware
端口：6379
密码：viFRKZiZkoPmXnyF
```



###### 2.11 安装Influxdb

2.11.1 安装Influxdb

```shell
sealos load -i influxdb_1.7.8.tar.gz
# 样例参考MySQL
sealos run imagesId -e storageclass_type=nfs,openebs_localpath='',nfs_name=df-nfs-storage

# 连接信息
连接地址：influxdb.middleware
端口：8086
用户：admin
密码：admin@influxdb
```

参数解释：

| Name              | Description                                                  | Value                                                        |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| storageclass_type | 使用sc的类型，可选nfs 或者 openebs                           | nfs 或者 openebs（必填）                                     |
| openebs_localpath | 仅在sc类型选择openebs时，需要指定本地路径                    | eg：/data/mysql_data                                    sc类型为openebs时必填 |
| nfs_name          | 如果sc类型设置为nfs，选项设置了pvc需要绑定的storageclass名称 | eg: df-nfs-storage                                            sc类型为nfs时必填 |



###### 2.12 安装OpenSearch

2.12.1 安装OpenSearch

```shell
sealos load -i opensearch_2.3.0.tar.gz
sealos run imagesId -e nfs_name=df-nfs-storage
```
> 注：opensearch磁盘类型目前只支持nfs

参数解释：

| Name     | Description                                                  | Value                      |
| -------- | ------------------------------------------------------------ | -------------------------- |
| nfs_name | 如果sc类型设置为nfs，选项设置了pvc需要绑定的storageclass名称 | eg: df-nfs-storage  (必填) |

2.12.2 修改opensearch默认密码

```shell
# 修改密码
kubectl exec -ti -n middleware opensearch-single-0 -- curl -u admin:admin \
       -XPUT "http://localhost:9200/_plugins/_security/api/internalusers/elastic" \
       -H 'Content-Type: application/json' \
       -d '{
            "password": "4dIv4VJQG5t5dcJOL8R5",
            "opendistro_security_roles": ["all_access"]
        }'


# 连接信息
连接地址：opensearch-single.middleware
端口：9200
用户：elastic
密码：4dIv4VJQG5t5dcJOL8R5
```



###### 2.13 安装GuanceDB

2.13.1 安装GuanceDB

```shll
sealos load -i guancedb.tar.gz
sealos run imagesId -e nfs_name=df-nfs-storage
```
> 注：GuanceDB磁盘类型目前只支持nfs

参数解释：

| Name     | Description                                                  | Value                      |
| -------- | ------------------------------------------------------------ | -------------------------- |
| nfs_name | 如果sc类型设置为nfs，选项设置了pvc需要绑定的storageclass名称 | eg: df-nfs-storage  (必填) |



###### 2.14 部署launcher

2.14.1 业务服务安装包下载

=== "arm64"
    
    镜像包下载地址：https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz

=== "amd64"
    
    镜像包下载地址：https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz


2.14.2 launcher chart包下载

chart包下载地址：https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/launcher-helm-latest.tgz

2.14.3 业务服务镜像导入

```shell
# containerd环境导入
gunzip guance-amd64-latest.tar.gz
ctr -n=k8s.io images import guance-amd64-latest.tar
```

2.14.4 安装launcher

```shell
helm install launcher launcher-*.tgz -n launcher --create-namespace  \
  --set ingress.hostName=launcher.dataflux.cn \
  --set storageClassName=df-nfs-storage
```

2.14.5 配置业务服务单副本(可选)

如果是poc环境只想使用单副本，可按照如下方式配置
```shell
kubectl edit cm launcher-settings -n launcher
# 添加如下配置
settings.yaml: 'debug: True'
# 添加完成后重启launcher服务
kubectl -n launcher rollout restart deploy launcher
```

2.14.6 访问launcher

```shell
# 修改ingress的network方式，修改ingress deployment 添加
hostNetwork: true
# 修改成功后配置本地配置 8.130.126.215为服务器ip，需要对外放开80端口
8.130.126.215 launcher.dataflux.cn
```



###### 2.15 通过launcher部署业务服务

launcher部署完成后，可以参考 [开始安装](launcher-install.md) 进行业务服务部署