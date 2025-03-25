#### Single Machine Deployment
???+ warning "Note"
     Single machine deployment is only applicable for POC environments, not for production environments.

##### 1. Prerequisites

###### 1.1 Pre-requisites for using sealos

- Hostnames can be configured; hostnames should not contain underscores.
- Node time synchronization.
- Run the `sealos run` command on the first node of the Kubernetes cluster. Currently, nodes outside the cluster are not supported for cluster installation.
- It is recommended to use a clean operating system to create a cluster. Do not install Docker manually.
- Supports most Linux distributions, such as: Ubuntu CentOS Rocky Linux.
- Published supported Kubernetes versions.
- Supports using containerd as the container runtime.
- Use private IPs in public clouds.



##### 2. Installation and Deployment

###### 2.1 Configure the installation package

2.1.1 Download the installation package

=== "arm64"
    
    Installation package address: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-middleware-arm64.tar.gz
    Extract the installation package:
    ```shell
    tar -zvxf guance-middleware-arm64.tar.gz
    ```

=== "amd64"
    
    Installation package address: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-middleware-amd64.tar.gz
    Extract the installation package:
    ```shell
    tar -zvxf guance-middleware-amd64.tar.gz
    ```
###### 2.2 Install sealos

2.2.1 Install sealos

```shell
tar zxvf sealos_4.3.0_linux.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin && sealos -h
```
Common sealos commands summary
```shell
sealos save            Save and cluster images to a file
sealos load            Load a cluster image from a file
sealos images          View the list of images
sealos rmi             Delete local images
sealos run imageId     Run an application based on an image
sealos version         View the sealos version
sealos help            Sealos help documentation
```


###### 2.3 Install Kubernetes Cluster

2.3.1 Install Kubernetes

```shell
sealos load -i calico_3.22.1.tar.gz && sealos load -i helm_3.8.2.tar.gz && sealos load -i kubernetes_1.24.0.tar.gz && sealos images

sealos run pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/kubernetes:v1.24.0 pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/helm:v3.8.2 pubrepo.<<< custom_key.brand_main_domain >>>/googleimages/calico:v3.22.1 --single

# Verification
kubectl get nodes 
```

2.3.2 Modify containerd data directory

The default containerd data directory is under `/`. In Kubernetes versions 1.16 and later, the default root directory threshold reaches 85% after which pods on the node will be evicted. To avoid pod eviction, we need to switch the containerd data directory to the data disk.
```shell
# After all nodes are Ready, modify the containerd data directory
vim /etc/containerd/config.toml
root = "/data/containerd"
mkdir -p /data/containerd
cp -r /var/lib/containerd/* /data/containerd
chmod 777 -R /data/containerd
# Restart containerd
sudo systemctl restart containerd
```



###### 2.4 Install NFS

2.4.1 Disable firewall

=== "CentOS"

    CentOS disable command
    ```shell
    systemctl stop firewalld
    systemctl disable firewalld
    ```

=== "Ubuntu"

    Ubuntu disable command
    ```shell
    sudo systemctl stop ufw.service
    sudo systemctl disable ufw.service
    ```
2.4.2 Install nfs service

If the server can access the internet, you can deploy nfs with the following commands

=== "CentOS"

    CentOS installation command
    ```shell
    yum install rpcbind nfs-utils -y
    ```
=== "Ubuntu"

    Ubuntu installation command
    ```shell
    apt-get install nfs-kernel-server -y
    ```

If the server cannot access the internet, find the nfs-package folder in the extracted files, find the corresponding offline package, and install it with the following command

=== "CentOS"

    CentOS offline installation command
    ```shell
    tar -zvxf nfs-utils.tar.gz
    cd nfs-utils
    rpm -Uvh *.rpm --nodeps --force
    ```
=== "Ubuntu"

    Ubuntu offline installation command
    ```shell
    tar -zvxf nfs-utils.tar.gz
    cd nfs-utils
    sudo dpkg -i *.deb    
    ```

2.4.3 Configure nfs shared path

Create the shared directory
```shell
mkdir /nfsdata
```
Execute the command `vim /etc/exports`, create the exports file, with the following content:

```shell
#/nfsdata *(insecure,rw,async,no_root_squash)
/nfsdata *(rw,no_root_squash,no_all_squash,insecure) 
```

> Note: `/nfsdata` is the shared directory configured for nfs. This directory is generally mounted on a separate data disk, such as `/data/nfsdata`.

2.4.4 Start nfs service

Execute the following commands to start the nfs service

=== "CentOS"

    CentOS startup command
    ```shell
    systemctl enable rpcbind
    systemctl enable nfs-server
    systemctl restart rpcbind
    systemctl restart nfs-server
    ```
=== "Ubuntu"

    Ubuntu startup command
    ```shell
    service nfs-kernel-server start   
    ```


2.4.5 Verify configuration

```shell
showmount -e localhost
```



###### 2.5 Install Kubernetes Storage

2.5.1 Install Kubernetes Storage

```shell
sealos load -i nfs_4.0.2.tar.gz
# Get the imageId of the nfs cluster image
sealos images
# Replace the value of the imagesId below with the obtained cluster image id
sealos run imagesId -e nfs_server=192.168.0.41,nfs_path=/nfsdata
```
> Note: The imageId of other components mentioned below can also be obtained and replaced in the same way.

Parameter Explanation:

| Name       | Description | Value             |
| ---------- | ----------- | ----------------- |
| nfs_server | Server IP   | eg: 192.168.3.143 |
| nfs_path   | NFS shared path | eg: /data/nfsdata |





###### 2.6 Install Ingress

2.6.1 Install Ingress

```shell
sealos load -i ingress_1.3.0.tar.gz
sealos run imagesId
```

>Note: If the domain name is directly resolved to the server, you can add the hostNetwork: true configuration to the ingress deployment



###### 2.7 Install OpenEBS

2.7.1 Install OpenEBS

```shell
sealos load -i localpv-provisioner_3.3.0.tar.gz
sealos run imagesId
```

> Note: Installing OpenEBS is optional, using local storage performs better than NFS.


###### 2.8 Create middleware namespace

2.8.1 Create middleware namespace

```shell
kubectl create ns middleware
```



###### 2.9 Install MySQL

2.9.1 Install MySQL

sealos installation for mysql
```shell
sealos load -i mysql_8.0.tar.gz 
# Example 1: Disk type is nfs, storageclass name is df-nfs-storage deployment command
sealos run imageId -e storageclass_type=nfs,openebs_localpath='',nfs_name=df-nfs-storage
# Example 2: Disk type is openebs, local shared path is /data/mysql_data deployment command
sealos run imageId -e storageclass_type=openebs,openebs_localpath='/data/mysql_data',nfs_name=''
```

Parameter Explanation:

| Name              | Description                                                  | Value                                                        |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| storageclass_type | Type of sc used, can choose between nfs or openebs           | nfs or openebs (required)                                     |
| openebs_localpath | Specify the local path when choosing openebs as sc type      | eg: /data/mysql_data                                    required when sc type is openebs |
| nfs_name          | If sc type is set to nfs, specify the pvc-bound storageclass name | eg: df-nfs-storage                                            required when sc type is nfs |

2.9.2 Create MySQL configuration user

```shell
# Create guance_setup_user
kubectl -n middleware exec -it podname bash
# Enter password rootPassw0rd
mysql -uroot -p 
create user 'guance_setup_user'@'%' identified by 'Aa123456';
-- WITH GRANT OPTION indicates that this user can grant their own permissions to others
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, LOCK TABLES, CREATE TEMPORARY TABLES, TRIGGER, EXECUTE, CREATE VIEW, SHOW VIEW, EVENT, GRANT OPTION, PROCESS, REFERENCES, RELOAD,  CREATE USER, USAGE on *.* TO 'guance_setup_user'@'%' with GRANT OPTION;
FLUSH PRIVILEGES;

# Connection information
Connection Address: mysql.middleware
Port: 3306
User: guance_setup_user
Password: Aa123456
```



###### 2.10 Install Redis

2.10.1 Install Redis

```shell
sealos load -i redis_6.0.20.tar.gz
sealos run imagesId

# Connection information
Connection Address: redis.middleware
Port: 6379
Password: viFRKZiZkoPmXnyF
```



###### 2.11 Install InfluxDB

2.11.1 Install InfluxDB

```shell
sealos load -i influxdb_1.7.8.tar.gz
# Refer to MySQL example
sealos run imagesId -e storageclass_type=nfs,openebs_localpath='',nfs_name=df-nfs-storage

# Connection information
Connection Address: influxdb.middleware
Port: 8086
User: admin
Password: admin@influxdb
```

Parameter Explanation:

| Name              | Description                                                  | Value                                                        |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| storageclass_type | Type of sc used, can choose between nfs or openebs           | nfs or openebs (required)                                     |
| openebs_localpath | Specify the local path when choosing openebs as sc type      | eg: /data/mysql_data                                    required when sc type is openebs |
| nfs_name          | If sc type is set to nfs, specify the pvc-bound storageclass name | eg: df-nfs-storage                                            required when sc type is nfs |



###### 2.12 Install OpenSearch

2.12.1 Install OpenSearch

```shell
sealos load -i opensearch_2.3.0.tar.gz
sealos run imagesId -e nfs_name=df-nfs-storage
```
> Note: OpenSearch disk type currently only supports nfs

Parameter Explanation:

| Name     | Description                                                  | Value                      |
| -------- | ------------------------------------------------------------ | -------------------------- |
| nfs_name | If sc type is set to nfs, specify the pvc-bound storageclass name | eg: df-nfs-storage  (required) |

2.12.2 Modify OpenSearch default password

```shell
# Change password
kubectl exec -ti -n middleware opensearch-single-0 -- curl -u admin:admin \
       -XPUT "http://localhost:9200/_plugins/_security/api/internalusers/elastic" \
       -H 'Content-Type: application/json' \
       -d '{
            "password": "4dIv4VJQG5t5dcJOL8R5",
            "opendistro_security_roles": ["all_access"]
        }'


# Connection information
Connection Address: opensearch-single.middleware
Port: 9200
User: elastic
Password: 4dIv4VJQG5t5dcJOL8R5
```



###### 2.13 Install GuanceDB

2.13.1 Install GuanceDB

```shll
sealos load -i guancedb.tar.gz
sealos run imagesId -e nfs_name=df-nfs-storage
```
> Note: GuanceDB disk type currently only supports nfs

Parameter Explanation:

| Name     | Description                                                  | Value                      |
| -------- | ------------------------------------------------------------ | -------------------------- |
| nfs_name | If sc type is set to nfs, specify the pvc-bound storageclass name | eg: df-nfs-storage  (required) |



###### 2.14 Deploy launcher

2.14.1 Business service installation package download

=== "arm64"
    
    Image package download address: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz

=== "amd64"
    
    Image package download address: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz


2.14.2 launcher chart package download

Chart package download address: https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/launcher-helm-latest.tgz

2.14.3 Business service image import

```shell
# Import under containerd environment
gunzip guance-amd64-latest.tar.gz
ctr -n=k8s.io images import guance-amd64-latest.tar
```

2.14.4 Install launcher

```shell
helm install launcher launcher-*.tgz -n launcher --create-namespace  \
  --set ingress.hostName=launcher.dataflux.cn \
  --set storageClassName=df-nfs-storage
```

2.14.5 Configure business service single replica (optional)

If it's a POC environment and you want to use a single replica, you can configure it as follows:
```shell
kubectl edit cm launcher-settings -n launcher
# Add the following configuration
settings.yaml: 'debug: True'
# After adding, restart the launcher service
kubectl -n launcher rollout restart deploy launcher
```

2.14.6 Access launcher

```shell
# Modify the network method of ingress, add to ingress deployment
hostNetwork: true
# After successful modification, configure the local settings 8.130.126.215 as the server IP, and port 80 needs to be opened externally
8.130.126.215 launcher.dataflux.cn
```



###### 2.15 Deploy business services via launcher

After the launcher deployment is completed, refer to [Start Installation](launcher-install.md) to deploy business services