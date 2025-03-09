#### Single-Node Deployment
???+ warning "Note"
     Single-node deployment is only suitable for POC environments, not for production environments.

##### 1. Prerequisites

###### 1.1 Prerequisites for Using Sealos

- You can configure the hostname; do not include underscores in the hostname.
- Node time synchronization.
- Run the `sealos run` command on the first node of the Kubernetes cluster; currently, nodes outside the cluster are not supported for cluster installation.
- It is recommended to use a clean operating system to create the cluster. Do not install Docker manually.
- Supports most Linux distributions, such as Ubuntu, CentOS, Rocky Linux.
- Supported Kubernetes versions that have been released.
- Supports using containerd as the container runtime.
- Use private IPs on public clouds.

##### 2. Installation and Deployment

###### 2.1 Configure Installation Packages

2.1.1 Download Installation Packages

=== "arm64"
    
    Package URL: https://<<< custom_key.static_domain >>>/dataflux/package/guance-middleware-arm64.tar.gz
    Extract the package:
    ```shell
    tar -zvxf guance-middleware-arm64.tar.gz
    ```

=== "amd64"
    
    Package URL: https://<<< custom_key.static_domain >>>/dataflux/package/guance-middleware-amd64.tar.gz
    Extract the package:
    ```shell
    tar -zvxf guance-middleware-amd64.tar.gz
    ```

###### 2.2 Install Sealos

2.2.1 Install Sealos

```shell
tar zxvf sealos_4.3.0_linux.tar.gz sealos && chmod +x sealos && mv sealos /usr/bin && sealos -h
```
Summary of common Sealos commands:
```shell
sealos save            Save cluster images to a file
sealos load            Load a cluster image from a file
sealos images          List images
sealos rmi             Remove local images
sealos run imageId     Run an application based on the image
sealos version         Show Sealos version
sealos help            Display Sealos help documentation
```


###### 2.3 Install Kubernetes Cluster

2.3.1 Install Kubernetes

```shell
sealos load -i calico_3.22.1.tar.gz && sealos load -i helm_3.8.2.tar.gz && sealos load -i kubernetes_1.24.0.tar.gz && sealos images

sealos run pubrepo.guance.com/googleimages/kubernetes:v1.24.0 pubrepo.guance.com/googleimages/helm:v3.8.2 pubrepo.guance.com/googleimages/calico:v3.22.1 --single

# Verification
kubectl get nodes 
```

2.3.2 Modify Containerd Data Directory

By default, the containerd data directory is under `/`. In Kubernetes 1.16 and later versions, if the root directory's usage reaches 85%, pods will be evicted from the node. To avoid pod eviction, switch the containerd data directory to a data disk.
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

2.4.1 Disable Firewall

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

2.4.2 Install NFS Service

If the server can access the internet, you can deploy NFS using the following commands:

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

If the server cannot access the internet, find the `nfs-package` folder in the extracted files, locate the offline package for the corresponding version, and install it using the following commands:

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

2.4.3 Configure NFS Shared Path

Create a shared directory
```shell
mkdir /nfsdata
```
Execute the command `vim /etc/exports`, create the `exports` file with the following content:

```shell
#/nfsdata *(insecure,rw,async,no_root_squash)
/nfsdata *(rw,no_root_squash,no_all_squash,insecure) 
```

> Note: The `/nfsdata` directory is configured as the NFS shared directory, which is generally mounted on a separate data disk like `/data/nfsdata`.

2.4.4 Start NFS Service

Execute the following commands to start the NFS service:

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


2.4.5 Verify Configuration

```shell
showmount -e localhost
```



###### 2.5 Install Kubernetes Storage

2.5.1 Install Kubernetes Storage

```shell
sealos load -i nfs_4.0.2.tar.gz
# Get the image ID of the NFS cluster image
sealos images
# Replace the `imagesId` value below with the obtained cluster image ID
sealos run imagesId -e nfs_server=192.168.0.41,nfs_path=/nfsdata
```
> Note: For other components mentioned later, the `imageId` can be obtained and replaced in the same manner.

Parameter Explanation:

| Name       | Description | Value             |
| ---------- | ----------- | ----------------- |
| nfs_server | Server IP   | e.g., 192.168.3.143 |
| nfs_path   | NFS shared path | e.g., /data/nfsdata |



###### 2.6 Install Ingress

2.6.1 Install Ingress

```shell
sealos load -i ingress_1.3.0.tar.gz
sealos run imagesId
```

> Note: If the domain directly resolves to the server, add `hostNetwork: true` to the ingress deployment configuration.



###### 2.7 Install OpenEBS

2.7.1 Install OpenEBS

```shell
sealos load -i localpv-provisioner_3.3.0.tar.gz
sealos run imagesId
```

> Note: Installing OpenEBS is optional; using local storage provides better performance than NFS.


###### 2.8 Create Middleware Namespace

2.8.1 Create Middleware Namespace

```shell
kubectl create ns middleware
```



###### 2.9 Install MySQL

2.9.1 Install MySQL

Sealos installation of MySQL
```shell
sealos load -i mysql_8.0.tar.gz 
# Example 1: Disk type is NFS, storage class name is df-nfs-storage
sealos run imageId -e storageclass_type=nfs,openebs_localpath='',nfs_name=df-nfs-storage
# Example 2: Disk type is OpenEBS, local shared path is /data/mysql_data
sealos run imageId -e storageclass_type=openebs,openebs_localpath='/data/mysql_data',nfs_name=''
```

Parameter Explanation:

| Name              | Description                                                  | Value                                                        |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| storageclass_type | Type of storage class used, options are `nfs` or `openebs`   | `nfs` or `openebs` (required)                                |
| openebs_localpath | Specify the local path when choosing OpenEBS                 | e.g., `/data/mysql_data` (required if sc type is OpenEBS)     |
| nfs_name          | Set the storage class name for PVC binding if sc type is NFS | e.g., `df-nfs-storage` (required if sc type is NFS)           |

2.9.2 Create MySQL Configuration User

```shell
# Create guance_setup_user
kubectl -n middleware exec -it podname bash
# Enter password rootPassw0rd
mysql -uroot -p 
create user 'guance_setup_user'@'%' identified by 'Aa123456';
-- WITH GRANT OPTION allows this user to grant its own permissions to others
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, LOCK TABLES, CREATE TEMPORARY TABLES, TRIGGER, EXECUTE, CREATE VIEW, SHOW VIEW, EVENT, GRANT OPTION, PROCESS, REFERENCES, RELOAD, CREATE USER, USAGE on *.* TO 'guance_setup_user'@'%' with GRANT OPTION;
FLUSH PRIVILEGES;

# Connection Information
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

# Connection Information
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

# Connection Information
Connection Address: influxdb.middleware
Port: 8086
User: admin
Password: admin@influxdb
```

Parameter Explanation:

| Name              | Description                                                  | Value                                                        |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| storageclass_type | Type of storage class used, options are `nfs` or `openebs`   | `nfs` or `openebs` (required)                                |
| openebs_localpath | Specify the local path when choosing OpenEBS                 | e.g., `/data/mysql_data` (required if sc type is OpenEBS)     |
| nfs_name          | Set the storage class name for PVC binding if sc type is NFS | e.g., `df-nfs-storage` (required if sc type is NFS)           |



###### 2.12 Install OpenSearch

2.12.1 Install OpenSearch

```shell
sealos load -i opensearch_2.3.0.tar.gz
sealos run imagesId -e nfs_name=df-nfs-storage
```
> Note: Currently, OpenSearch disk types only support NFS.

Parameter Explanation:

| Name     | Description                                                  | Value                      |
| -------- | ------------------------------------------------------------ | -------------------------- |
| nfs_name | Set the storage class name for PVC binding if sc type is NFS | e.g., `df-nfs-storage` (required) |

2.12.2 Change Default OpenSearch Password

```shell
# Change password
kubectl exec -ti -n middleware opensearch-single-0 -- curl -u admin:admin \
       -XPUT "http://localhost:9200/_plugins/_security/api/internalusers/elastic" \
       -H 'Content-Type: application/json' \
       -d '{
            "password": "4dIv4VJQG5t5dcJOL8R5",
            "opendistro_security_roles": ["all_access"]
        }'


# Connection Information
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
> Note: Currently, GuanceDB disk types only support NFS.

Parameter Explanation:

| Name     | Description                                                  | Value                      |
| -------- | ------------------------------------------------------------ | -------------------------- |
| nfs_name | Set the storage class name for PVC binding if sc type is NFS | e.g., `df-nfs-storage` (required) |



###### 2.14 Deploy Launcher

2.14.1 Download Business Service Installation Package

=== "arm64"
    
    Image package download URL: https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-latest.tar.gz

=== "amd64"
    
    Image package download URL: https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-latest.tar.gz


2.14.2 Download Launcher Chart Package

Chart package download URL: https://<<< custom_key.static_domain >>>/dataflux/package/launcher-helm-latest.tgz

2.14.3 Import Business Service Images

```shell
# For containerd environment
gunzip guance-amd64-latest.tar.gz
ctr -n=k8s.io images import guance-amd64-latest.tar
```

2.14.4 Install Launcher

```shell
helm install launcher launcher-*.tgz -n launcher --create-namespace  \
  --set ingress.hostName=launcher.dataflux.cn \
  --set storageClassName=df-nfs-storage
```

2.14.5 Configure Single Replica for Business Services (Optional)

For POC environments where you want to use a single replica, configure as follows:
```shell
kubectl edit cm launcher-settings -n launcher
# Add the following configuration
settings.yaml: 'debug: True'
# After adding, restart the launcher service
kubectl -n launcher rollout restart deploy launcher
```

2.14.6 Access Launcher

```shell
# Modify the network method of ingress, add to ingress deployment
hostNetwork: true
# After successful modification, configure local settings. 8.130.126.215 is the server IP, and port 80 needs to be opened externally
8.130.126.215 launcher.dataflux.cn
```



###### 2.15 Deploy Business Services via Launcher

After completing the launcher deployment, refer to [Start Installation](launcher-install.md) for deploying business services.