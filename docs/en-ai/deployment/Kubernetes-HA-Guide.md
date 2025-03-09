# Quick Deployment Guide for Kubernetes

## 0. Introduction

<u>After successfully deploying Kubernetes according to this document, the following tasks are completed by default</u>
???+ info  "**Feature Component Coverage**"

    - [x] High availability deployment of Kubernetes 1.24.2

    - [x] Installation of CoreDNS component

    - [x] Installation of node-local-dns component

    - [x] Installation of ingress-nginx component

    - [x] Installation of metrics-server component

    - [x] Installation of OpenEBS provisioner driver

  

  

  Resource List

  ```shell
  1. "Minimum configuration" is suitable for POC scenarios, only for functional verification, not suitable for production environments.
  2. For production deployment, evaluate based on actual data volume接入的数据量越多，TDengine、OpenSearch 的存储与规格配置相应也需要越高。  
  ```
  





| **Purpose**                   | **Resource Type**           | **Minimum Specifications**   | **Recommended Specifications**         | **Quantity** | **Notes**                                                     |
| -------------------------- | ---------------------- | -------------- | -------------------- | -------- | ------------------------------------------------------------ |
| **Kubernetes Master**      | Physical server&#124;virtual machine | 4C8GB 100GB    | 8C16GB  100GB        | 3        | Version: 1.24.2 **Note: If it's a virtual machine, increase resource specifications appropriately, reuse one master node as the deployment node** |
| **Kubernetes workerload**  | Physical server&#124;virtual machine | 4C8GB 100GB    | 8C16GB  100GB        | 4        | k8s cluster worker nodes, hosting <<< custom_key.brand_name >>> applications, k8s components, and basic services like MySQL 5.7.18, Redis 6.0.6 |
| **<<< custom_key.brand_name >>> Proxy Service**         | Physical server&#124;virtual machine | 2C4GB  100GB   | 4C8GB    200GB       | 1        | Used for deploying Nginx reverse proxy servers, proxying to ingress edge nodes **Note: For security reasons, do not expose cluster edge nodes directly** |
| **<<< custom_key.brand_name >>> Network File System Service** | Physical server&#124;virtual machine | 2C4GB 200G     | 4C8GB 1TB high-performance disk | 1        | Deploy network file system and network storage service, default NFS (if an existing NFS service exists, this machine can be canceled) |
| **DataWay**                | Physical server&#124;virtual machine | 2C4GB  100GB   | 4C8GB    100GB       | 1        | User deploys DataWay                                             |
| **OpenSearch**             | Physical server&#124;virtual machine | 4C8GB 1TB      | 8C16G   1TB          | 3        | OpenSearch version: 2.2.1 **Note: Enable password authentication, install matching version analysis-ik plugin** |
| **TDengine**               | Physical server&#124;virtual machine | 4C8GB  500GB   | 8C16G 1TB            | 3        | TDengine version: 2.6.0.18                |
| **Others**                   | Email server/SMS        | -              | -                    | 1        | SMS gateway, email server, alert channels                               |
|                            | Officially registered wildcard domain   | -              | -                    | 1        | Main domain must be registered                                                 |
|                            | SSL/TLS certificate            | Wildcard domain certificate | Wildcard domain certificate       | 1        | Ensures site security                                                 |

  

## 1. Prerequisites	
???+ warning "Important" 

      - **Basic environment offline resource package uploaded to all cluster nodes and extracted to the /etc directory on the server**
      - **SSH keyless login configured between the deployment node and other cluster nodes (including the deployment node itself)**	
      - **<<< custom_key.brand_name >>> platform offline resource package uploaded to all cluster nodes and imported into the container runtime environment (containerd)**
      
      ```shell
      # Extract downloaded <<< custom_key.brand_name >>> image package and import into containerd
         
      gunzip xxx.tar.gz
      ctr -n k8s.io images import xxx.tar
      ```
      

### 1.1 Keyless Login Setup Reference

```shell
# Log in to the deployment machine and execute the command
# Generate public key pair 
[root@k8s-node01 ~]# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:vruHbsWUUL5M9k0dg15zhIX5Y9MZVJ+enf0JhzF5lP0 root@k8s-node02
The key's randomart image is:
+---[RSA 2048]----+
|         ..   o@B|
|        ..   .**B|
|         .+..+o+X|
|         +oo +*=E|
|        Soo .oo==|
|       .  o   o o|
|        .o     ..|
|        o..      |
|       o=+       |
+----[SHA256]-----+

# $IP is the address of all nodes including itself, enter yes and the root password as prompted
ssh-copy-id $IP 

# Set up Python symbolic link for each node, default is not required 【For certain versions using Python 3, this operation needs to be performed】
# ssh $IP ln -s /usr/bin/python3 /usr/bin/python
```



## 2. Deployment Preparation

### 2.1 Download Resource Package

  Offline resource package download address  [Download]( https://<<< custom_key.static_domain >>>/dataflux/package/k8s_offline.tar.gz)

### 2.2 Offline Resource Package Structure Description

  Brief description of the offline package contents

- `/etc/kubeasz` is the main kubeasz directory 
- `/etc/kubeasz/example ` contains sample configuration files
-  `/etc/kubeasz/clusters ` contains configuration files related to created clusters
- ` /etc/kubeasz/guance` contains <<< custom_key.brand_name >>> related charts, YAML, etc.
- `/etc/kubeasz/bin` contains k8s/etcd/docker/CNI binary files
- `/etc/kubeasz/down` contains offline container image packages needed for cluster installation
- `/etc/kubeasz/down/packages` contains system base software needed for cluster installation



## 3. Install Cluster

### 3.1 Precautions
???+ warning "Important"
    - Ensure time zones are set consistently across all nodes and time synchronization is done

    - Commands in the document need root privileges by default
    
    - Ensure installation starts on a clean system without any previous installations of kubeadm or other Kubernetes distributions
    
    - Before executing one-click installation, configure and check the custom-generated cluster configuration files. Mainly `/etc/kubease/clusters/xxx/hosts` and `/etc/kubeasz/clusters/config.yaml`
    
    - Modify hostnames for easier identification【Optional】
    
    ```shell
    # xxx is the hostname to be set
    hostnamectl set-hostname xxx
    ```

  



### 3.2 Cluster Role Planning

High availability cluster requires the following node configurations:

| Role               | Quantity | Description                                                    |
| :----------------- | :--- | :------------------------------------------------------ |
| deploy（deployment）node | 1    | Runs ansible/ezctl commands, generally reuses the first master node         |
| etcd nodes           | 3    | Note that an etcd cluster requires 1, 3, 5,... odd number of nodes, generally reusing master nodes |
| master nodes         | 3    | High availability cluster requires at least 2 master nodes                             |
| node nodes           | N    | Nodes running application workloads, machine configurations can be upgraded or more nodes added as needed   |

???+ note "Description"
    By default, the container runtime and kubelet will occupy disk space under `/var`. If the disk partition is special, you can set the container runtime and kubelet data directories in the `example/config.yml` before creating the cluster configuration: `CONTAINERD_STORAGE_DIR` `DOCKER_STORAGE_DIR` `KUBELET_ROOT_DIR`

### 3.3 Deployment Steps

#### 3.3.1 Orchestrate k8s Installation on Deployment Node

Log in to the deployment node server
Navigate to the `/etc/kueasz` directory and execute the following commands

```shell
# Install Docker service on the deployment machine
# Start the local registry repository
# Load the necessary offline environment image packages and push them to the registry repository

./ezdown -D    
./ezdown -X 
```

More information about ezdown parameters can be obtained by running ezdown.

???+ tip "Tip"

    If unable to run, navigate to the `/etc/kubeasz` directory and execute `./ezdwon -h`


#### 3.3.2 Create Cluster Configuration Instance

```shell
# Run kubeasz container
./ezdown -S

# Create a new cluster guancecloud 
# The cluster name can be customized, and corresponding directories will be generated
docker exec -it kubeasz ezctl new guancecloud
# Result display example
2022-10-19 10:48:23 DEBUG generate custom cluster files in /etc/kubeasz/clusters/guancecloud
2022-10-19 10:48:23 DEBUG set version of common plugins
2022-10-19 10:48:23 DEBUG cluster k8s-01: files successfully created.
2022-10-19 10:48:23 INFO next steps 1: to config '/etc/kubeasz/clusters/guancecloud/hosts'
2022-10-19 10:48:23 INFO next steps 2: to config '/etc/kubeasz/clusters/guancecloud/config.yml'
```

Then modify the cluster configuration files according to the prompts


```shell
# Modify hosts file according to the previously planned cluster roles
'/etc/kubeasz/clusters/xxx/hosts'  

# Other main cluster-level configuration options can be modified in the config.yml file【It is recommended to use the default unless you are very clear about the parameters being modified】
'/etc/kubeasz/clusters/xxx/config.yml'

```

Example configuration file content
???+ note "Description"
    For custom configuration items, please refer to the example configuration file

???+ example "Sample Configuration File"
    ```shell
    # config.yaml

    ############################
    # prepare
    ############################
    # Optional offline installation of system software packages (offline|online)
    # Default is "offline" for offline environments
    INSTALL_SOURCE: "offline"

    # Optional system hardening with github.com/dev-sec/ansible-collection-hardening
    OS_HARDEN: false


    ############################
    # role:deploy
    ############################
    # Default: CA will expire in 100 years
    # Default: Certificates issued by the CA will expire in 50 years
    CA_EXPIRY: "876000h"
    CERT_EXPIRY: "438000h"

    # Kubeconfig configuration parameters
    CLUSTER_NAME: "cluster1"
    CONTEXT_NAME: "context-{{ CLUSTER_NAME }}"

    # k8s version
    K8S_VER: "__k8s_ver__"

    ############################
    # role:etcd
    ############################
    # Set different WAL directories to avoid disk I/O contention and improve performance 

    # It is recommended to modify to a directory with larger disk space, depending on the actual situation
    ETCD_DATA_DIR: "/var/lib/etcd"
    ETCD_WAL_DIR: ""


    ############################
    # role:runtime [containerd,docker]
    ############################
    # ------------------------------------------- containerd
    # [.] Enable container registry mirror
    ENABLE_MIRROR_REGISTRY: true

    # [containerd] Base container image
    SANDBOX_IMAGE: "easzlab.io.local:5000/easzlab/pause:__pause__"

    # [containerd] Container persistent storage directory

    # It is recommended to modify to a directory with larger disk space, depending on the actual situation
    CONTAINERD_STORAGE_DIR: "/var/lib/containerd" 

    # ------------------------------------------- docker
    # [docker] Container storage directory
    # It is recommended to modify to a directory with larger disk space, depending on the actual situation 
    # Only deployment machines have Docker services
    DOCKER_STORAGE_DIR: "/var/lib/docker"

    # [docker] Enable Restful API
    ENABLE_REMOTE_API: false

    # [docker] Trusted HTTP registry
    INSECURE_REG: '["http://easzlab.io.local:5000"]'


    ############################
    # role:kube-master
    ############################
    # k8s cluster master node certificate configuration, multiple IPs and domains can be added (such as adding public IPs and domains)
    MASTER_CERT_HOSTS:
      - "10.1.1.1"
      - "k8s.easzlab.io"
      #- "www.test.com"

    # Pod subnet mask length on node (determines the maximum number of pod IP addresses per node)
    # If flannel uses --kube-subnet-mgr parameter, it will read this setting to allocate pod subnets for each node
    # https://github.com/coreos/flannel/issues/847
    NODE_CIDR_LEN: 24


    ############################
    # role:kube-node
    ############################
    # Kubelet root directory
    # It is recommended to modify to a directory with larger disk space, depending on the actual situation 
    KUBELET_ROOT_DIR: "/var/lib/kubelet"

    # Maximum number of pods on node
    MAX_PODS: 110

    # Configure resources reserved for kube components (kubelet, kube-proxy, dockerd, etc.)
    # Values are set as per templates/kubelet-config.yaml.j2
    KUBE_RESERVED_ENABLED: "no"

    # k8s does not recommend enabling system-reserved lightly unless you understand the system's resource usage through long-term monitoring;
    # And with system runtime, appropriate increases in resource reservation are needed, values are set as per templates/kubelet-config.yaml.j2
    # System reservation settings are based on 4c/8g VMs with minimal installed system services, if using high-performance physical machines, reservations can be increased appropriately
    # Additionally, during cluster installation, apiserver resources consume significantly, so it is recommended to reserve at least 1GB of memory
    SYS_RESERVED_ENABLED: "no"


    ############################
    # role:network [flannel,calico,cilium,kube-ovn,kube-router]
    ############################
    # ------------------------------------------- flannel
    # [flannel] Set flannel backend "host-gw","vxlan", etc.
    FLANNEL_BACKEND: "vxlan"
    DIRECT_ROUTING: false

    # [flannel] flanneld_image: "quay.io/coreos/flannel:v0.10.0-amd64"
    flannelVer: "__flannel__"
    flanneld_image: "easzlab.io.local:5000/easzlab/flannel:{{ flannelVer }}"

    # ------------------------------------------- calico
    # [calico] Setting CALICO_IPV4POOL_IPIP="off" can improve network performance, see restrictions in docs/setup/calico.md
    CALICO_IPV4POOL_IPIP: "Always"

    # [calico] Specify the host IP used by calico-node, bgp neighbors establish connections via this address, can be manually specified or auto-detected
    IP_AUTODETECTION_METHOD: "can-reach={{ groups['kube_master'][0] }}"

    # [calico] Set calico network backend: brid, vxlan, none
    CALICO_NETWORKING_BACKEND: "brid"

    # [calico] Enable route reflectors if the cluster size exceeds 50 nodes
    CALICO_RR_ENABLED: false

    # CALICO_RR_NODES configure route reflector nodes, defaults to master nodes if not set
    # CALICO_RR_NODES: ["192.168.1.1", "192.168.1.2"]
    CALICO_RR_NODES: []

    # [calico] Update supported calico version: [v3.3.x] [v3.4.x] [v3.8.x] [v3.15.x]
    calico_ver: "__calico__"

    # [calico] Calico main version
    calico_ver_main: "{{ calico_ver.split('.')[0] }}.{{ calico_ver.split('.')[1] }}"

    # ------------------------------------------- cilium
    # [cilium] Image version
    cilium_ver: "__cilium__"
    cilium_connectivity_check: true
    cilium_hubble_enabled: false
    cilium_hubble_ui_enabled: false

    # ------------------------------------------- kube-ovn
    # [kube-ovn] Select OVN DB and OVN Control Plane nodes, defaults to the first master node
    OVN_DB_NODE: "{{ groups['kube_master'][0] }}"

    # [kube-ovn] Offline image tarball
    kube_ovn_ver: "__kube_ovn__"

    # ------------------------------------------- kube-router
    # [kube-router] Public clouds have limitations, ipinip should always be enabled; private environments can set to "subnet"
    OVERLAY_TYPE: "full"

    # [kube-router] NetworkPolicy support switch
    FIREWALL_ENABLE: true

    # [kube-router] kube-router image version
    kube_router_ver: "__kube_router__"
    busybox_ver: "1.28.4"


    ############################
    # role:cluster-addon
    ############################
    # coredns automatic installation
    dns_install: "yes"
    corednsVer: "__coredns__"
    ENABLE_LOCAL_DNS_CACHE: true
    dnsNodeCacheVer: "__dns_node_cache__"
    # Set local DNS cache address
    LOCAL_DNS_CACHE: "169.254.20.10"

    # metric server automatic installation
    metricsserver_install: "yes"
    metricsVer: "__metrics__"

    # dashboard automatic installation
    dashboard_install: "no"
    dashboardVer: "__dashboard__"
    dashboardMetricsScraperVer: "__dash_metrics__"

    # prometheus automatic installation
    prom_install: "no"
    prom_namespace: "monitor"
    prom_chart_ver: "__prom_chart__"

    # nfs-provisioner automatic installation
    # If an existing NFS must be configured as "yes" and correct server information provided
    nfs_provisioner_install: "no"
    nfs_provisioner_namespace: "kube-system"
    nfs_provisioner_ver: "__nfs_provisioner__"
    nfs_storage_class: "managed-nfs-storage"
    nfs_server: "192.168.1.10"
    nfs_path: "/data/nfs"

    # network-check automatic installation
    network_check_enabled: false
    network_check_schedule: "*/5 * * * *"

    ############################
    # role:harbor
    ############################
    # harbor version, full version number
    HARBOR_VER: "__harbor__"
    HARBOR_DOMAIN: "harbor.easzlab.io.local"
    HARBOR_TLS_PORT: 8443

    # If set to 'false', you need to place certificates named harbor.pem and harbor-key.pem in the 'down' directory
    HARBOR_SELF_SIGNED_CERT: true

    # Install extra components
    HARBOR_WITH_NOTARY: false
    HARBOR_WITH_TRIVY: false
    HARBOR_WITH_CLAIR: false
    HARBOR_WITH_CHARTMUSEUM: true

    # ingress-nginx related configuration
    ingress_nginx_install: "yes"
    ingressnginxVer: v1.4.0
    certgenVer: v20220916-gd32f8c343
    ```

Configure Hosts
???+ example "Host Configuration Example"
    ```shell
    # 'etcd' cluster should have odd members (1,3,5,...)
    # Must replace IP according to actual planning
    [etcd]
    192.168.1.1
    192.168.1.2
    192.168.1.3

    # master nodes
    # Must replace IP according to actual planning
    [kube_master]
    192.168.1.1
    192.168.1.2

    # work nodes
    # Must replace IP according to actual planning
    [kube_node]
    192.168.1.3
    192.168.1.4

    # [optional] Harbor server, a private Docker registry
    # 'NEW_INSTALL': 'true' to install a Harbor server; 'false' to integrate with an existing one
    [harbor]
    #192.168.1.8 NEW_INSTALL=false

    # [optional] Load balancer for accessing k8s from outside
    [ex_lb]
    #192.168.1.6 LB_ROLE=backup EX_APISERVER_VIP=192.168.1.250 EX_APISERVER_PORT=8443
    #192.168.1.7 LB_ROLE=master EX_APISERVER_VIP=192.168.1.250 EX_APISERVER_PORT=8443

    # [optional] NTP server for the cluster
    [chrony]
    #192.168.1.1

    [all:vars]
    # --------- Main Variables ---------------
    # Secure port for APIservers
    SECURE_PORT="6443"

    # Cluster container-runtime supported: docker, containerd
    # if k8s version >= 1.24, docker is not supported
    CONTAINER_RUNTIME="containerd"

    # Network plugins supported: calico, flannel, kube-router, cilium, kube-ovn
    # Suggest using the default value or change to "flannel"
    CLUSTER_NETWORK="calico"

    # Service proxy mode of kube-proxy: 'iptables' or 'ipvs'
    PROXY_MODE="ipvs"

    # K8S Service CIDR, must not overlap with node(host) networking
    # Must not conflict with host IP segments
    SERVICE_CIDR="10.68.0.0/16"

    # Cluster CIDR (Pod CIDR), must not overlap with node(host) networking
    # Must not conflict with host IP segments
    CLUSTER_CIDR="172.20.0.0/16"

    # NodePort Range
    NODE_PORT_RANGE="30000-32767"

    # Cluster DNS Domain
    CLUSTER_DNS_DOMAIN="cluster.local"

    # -------- Additional Variables (do not change the default value right now) ---
    # Binaries Directory
    bin_dir="/opt/kube/bin"

    # Deploy Directory (kubeasz workspace)
    base_dir="/etc/kubeasz"

    # Directory for a specific cluster
    cluster_dir="{{ base_dir }}/clusters/_cluster_name_"

    # CA and other components cert/key Directory
    ca_dir="/etc/kubernetes/ssl"
    ```



#### 3.3.3 One-click Deployment

After confirming the above operations are correct, execute the following commands for quick deployment

???+ tip "Tip"
    ```shell
    # It is recommended to configure command aliases for convenience

    echo "alias dk='docker exec -it kubeasz'" >> /root/.bashrc

    source /root/.bashrc
    ```
    ```shell
    # It is recommended to configure command completion. If helm command is not found, exit and log back in to the server to check environment variables and confirm helm execution

    echo "source <(/etc/kubeasz/bin/helm completion bash)"  >> /root/.bashrc
   
    source /root/.bashrc
    
    ```
```shell
# One-click installation command, equivalent to executing docker exec -it kubeasz ezctl setup xxx all
# xxx represents the created cluster name
dk ezctl setup guancecloud all

# Or install step-by-step, see step-by-step installation help information using dk ezctl help setup
# dk ezctl setup guancecloud 01
# dk ezctl setup guancecloud 02
# dk ezctl setup guancecloud 03
# dk ezctl setup guancecloud 04
```
```shell
# After the command runs, there should be no errors in the task
TASK [cluster-addon : Prepare DNS deployment files] *********************************************
changed: [10.200.14.144]

TASK [cluster-addon : Create coredns deployment] *********************************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare dnscache deployment files] *****************************************
changed: [10.200.14.144]

TASK [cluster-addon : Create dnscache deployment] ********************************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare metrics-server deployment files] **********************************
changed: [10.200.14.144]

TASK [cluster-addon : Create metrics-server deployment] *************************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare nfs-provisioner configuration directory] *********************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare nfs-provisioner deployment files] **********************************
changed: [10.200.14.144] => (item=nfs-provisioner.yaml)
changed: [10.200.14.144] => (item=test-pod.yaml)

TASK [cluster-addon : Create nfs-provisioner deployment] ************************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare openebs-provisioner configuration directory] *****************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare openebs-provisioner deployment files] *****************************
changed: [10.200.14.144] => (item=openebs-provisioner.yaml)

TASK [cluster-addon : Create openebs-provisioner deployment] *******************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare ingress-nginx configuration directory] ***********************************
changed: [10.200.14.144]

TASK [cluster-addon : Prepare ingress-nginx deployment files] ***********************************
changed: [10.200.14.144] => (item=ingress-nginx.yaml)

TASK [cluster-addon : Create ingress-nginx deployment] *************************************
changed: [10.200.14.144]

PLAY RECAP *********************************************************************
10.200.14.144              : ok=110  changed=99   unreachable=0    failed=0    skipped=172  rescued=0    ignored=0
10.200.14.145              : ok=117  changed=106  unreachable=0    failed=0    skipped=199  rescued=0    ignored=0
10.200.14.146              : ok=93   changed=83   unreachable=0    failed=0    skipped=148  rescued=0    ignored=0
localhost                  : ok=33   changed=30   unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
```
???+ warning "Important"
    
    -   All returned information must be successful, otherwise reset the system and reinstall

    -   Clean up the cluster `docker exec -it kubeasz ezctl destroy xxx` where xxx is the cluster name

    -   Restart nodes to ensure cleanup of residual virtual NICs, routes, etc.
    
    ???+ success "Successful Return Example"
        ```shell
        PLAY RECAP *********************************************************************
        10.200.14.144              : ok=110  changed=99   unreachable=0    failed=0    skipped=172  rescued=0    ignored=0
        10.200.14.145              : ok=117  changed=106  unreachable=0    failed=0    skipped=199  rescued=0    ignored=0
        10.200.14.146              : ok=93   changed=83   unreachable=0    failed=0    skipped=148  rescued=0    ignored=0
        localhost                  : ok=33   changed=30   unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
        ```
For more ezctl parameters, run ezctl. If it cannot be executed, navigate to the `/etc/kubeasz` directory and run `./ezctl`.



## 4. Verify Installation

### 4.1 Cluster Component Status
???+ success "Cluster Components"
    ```shell
    [root@k8s-node01 ~]# kubectl  get cs
    Warning: v1 ComponentStatus is deprecated in v1.19+
    NAME                 STATUS    MESSAGE                         ERROR
    controller-manager   Healthy   ok
    scheduler            Healthy   ok
    etcd-0               Healthy   {"health":"true","reason":""}
    etcd-2               Healthy   {"health":"true","reason":""}
    etcd-1               Healthy   {"health":"true","reason":""}
    ```

Confirm all returned results have no ERROR

### 4.2 Cluster Node Status
???+ success "Cluster Nodes"
    ```shell
    [root@k8s-node01 ~]# kubectl  get nodes
    NAME            STATUS   ROLES    AGE   VERSION
    10.200.14.111   Ready    master   22h   v1.24.2
    10.200.14.112   Ready    master   22h   v1.24.2
    10.200.14.113   Ready    master   22h   v1.24.2
    10.200.14.114   Ready    node     22h   v1.24.2
    ```

Confirm all returned results show nodes in Ready status

### 4.3 Default Cluster Pod Status
???+ success "Initial Cluster Pods"
    ```shell
    [root@k8s-node01 ~]# kubectl  get pods -A
    NAMESPACE       NAME                                           READY   STATUS      RESTARTS   AGE
    ingress-nginx   ingress-nginx-admission-create-sh5gb           0/1     Completed   0          22h
    ingress-nginx   ingress-nginx-admission-patch-dhsvl            0/1     Completed   0          22h
    ingress-nginx   ingress-nginx-controller-6d799ccc9c-rhgx5      1/1     Running     0          22h
    kube-system     calico-kube-controllers-5c8bb696bb-srlmd       1/1     Running     0          22h
    kube-system     calico-node-4rwfj                              1/1     Running     0          22h
    kube-system     calico-node-lcm44                              1/1     Running     0          22h
    kube-system     calico-node-nbc5w                              1/1     Running     0          22h
    kube-system     calico-node-qfnw2                              1/1     Running     0          22h
    kube-system     coredns-84b58f6b4-zgkvb                        1/1     Running     0          22h
    kube-system     kubernetes-dashboard-5fc74cf5c6-kcpc7          1/1     Running     0          22h
    kube-system     metrics-server-69797698d4-nqfqf                1/1     Running     0          22h
    kube-system     node-local-dns-7w2kt                           1/1     Running     0          22h
    kube-system     node-local-dns-gb4zp                           1/1     Running     0          22h
    kube-system     node-local-dns-mw9pt                           1/1     Running     0          22h
    kube-system     node-local-dns-zr5d9                           1/1     Running     0          22h


    ```

Confirm all pods are in Running status and nodes are Ready

4.4 Confirm Cluster Info
???+ success "Cluster Information"
    ```shell
    [root@k8s-node01 ~]# kubectl  cluster-info
    Kubernetes control plane is running at https://127.0.0.1:6443
    CoreDNS is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    KubeDNSUpstream is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns-upstream:dns/proxy
    kubernetes-dashboard is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy

    To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
    ```

4.5 Confirm Cluster Resource Usage
???+ success "Cluster Resource Usage"

    ```shell
    [root@k8s-node01 /etc/kubeasz/roles]# kubectl  top nodes
    NAME            CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
    10.200.14.111   191m         9%     1215Mi          33%
    10.200.14.112   278m         6%     5692Mi          36%
    10.200.14.113   276m         6%     5684Mi          36%
    10.200.14.114   115m         2%     4444Mi          28%
    ```

Confirm normal return of cluster resource usage

## 5. Common Issues
???+ Tips "Tips"
    If the installation verification stage prompts `kubectl: command not found`, exit and log back in via SSH, environment variables will take effect

    If helm command is not found, exit and log back in to the server, check environment variables, and confirm helm execution

```shell
[root@k8s-node01 ~]# echo PATH=$PATH
PATH=/etc/kubeasz/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```