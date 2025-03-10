# Quick Deployment Guide for Kubernetes

## 0. Introduction

<u>After successfully deploying Kubernetes according to this document, the following tasks are completed by default</u>
???+ info  "**Coverage of Functional Components**"

    - [x] High availability deployment of Kubernetes 1.24.2

    - [x] Installation of the CoreDNS component

    - [x] Installation of the Node-Local-DNS component

    - [x] Installation of the Ingress-Nginx component

    - [x] Installation of the Metrics-Server component

    - [x] Installation of the OpenEBS-Provisioner component driver

  

  

  Resource List

  ```shell
  1. "Minimum configuration" is suitable for POC scenarios and is only used for functional verification, not recommended for production environments.
  2. For production deployments, evaluate based on actual data volume接入; the more data volume connected, the higher the storage and specification configurations required for TDengine and OpenSearch.  
  ```
  





| **Purpose**                   | **Resource Type**           | **Minimum Specification**   | **Recommended Specification**         | **Quantity** | **Notes**                                                     |
| -------------------------- | ---------------------- | -------------- | -------------------- | -------- | ------------------------------------------------------------ |
| **Kubernetes Master**      | Physical server or virtual machine | 4C8GB 100GB    | 8C16GB  100GB        | 3        | Version: 1.24.2 **Note: If it's a virtual machine, appropriately increase the resource specifications, reuse one master node as the deployment node** |
| **Kubernetes workerload**  | Physical server or virtual machine | 4C8GB 100GB    | 8C16GB  100GB        | 4        | k8s cluster worker nodes, hosting <<< custom_key.brand_name >>> applications, k8s components, basic service Mysql 5.7.18, Redis 6.0.6 |
| **<<< custom_key.brand_name >>> Proxy Service**         | Physical server or virtual machine | 2C4GB  100GB   | 4C8GB    200GB       | 1        | Used to deploy an Nginx reverse proxy server, proxying to ingress edge nodes **Note: For security reasons, do not directly expose the cluster edge nodes** |
| **<<< custom_key.brand_name >>> Network File System Service** | Physical server or virtual machine | 2C4GB 200G     | 4C8GB 1TB high-performance disk | 1        | Deploy network file system, network storage service, default NFS (if an existing NFS service exists, this machine can be canceled) |
| **DataWay**                | Physical server or virtual machine | 2C4GB  100GB   | 4C8GB    100GB       | 1        | User-deployed DataWay                                             |
| **OpenSearch**             | Physical server or virtual machine | 4C8GB 1TB      | 8C16G   1TB          | 3        | OpenSearch version: 2.2.1 **Note: Password authentication must be enabled, install matching version analysis plugin analysis-ik** |
| **TDengine**               | Physical server or virtual machine | 4C8GB  500GB   | 8C16G 1TB            | 3        | TDengine version: 2.6.0.18                |
| **Other**                   | Email server/SMS        | -              | -                    | 1        | SMS gateway, email server, alert channel                               |
|                            | Officially registered wildcard domain   | -              | -                    | 1        | The main domain needs to be registered                                                 |
|                            | SSL/TLS certificate            | Wildcard domain certificate | Wildcard domain certificate       | 1        | To secure the site                                               |

  

## 1. Prerequisites	
???+ warning "Important" 

      - **Basic environment offline resource package uploaded to all cluster nodes and extracted to the /etc directory on the server**
      - **SSH keyless login configured between the deployment node and other cluster nodes (including the deployment node itself)**	
      - **<<< custom_key.brand_name >>> platform offline resource package uploaded to all cluster nodes and imported into the container runtime environment (containerd)**
      
      ```shell
      # Extract the downloaded <<< custom_key.brand_name >>> image package and import it into containerd
         
      gunzip xxx.tar.gz
      ctr -n k8s.io images import xxx.tar
      ```
      

### 1.1 Keyless Login Setup Reference

```shell
# Log in to the deployment machine and execute the command
# Generate public/private key pair 
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

# $IP is the address of all nodes including itself, follow the prompts to input yes and the root password
ssh-copy-id $IP 

# Set up a Python symlink for each node, default not required 【Specific versions using Python 3 may require this action】
# ssh $IP ln -s /usr/bin/python3 /usr/bin/python
```



## 2. Pre-deployment Preparation

### 2.1 Resource Package Download

  Basic environment offline resource package download link [Download]( https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/k8s_offline.tar.gz)

### 2.2 Offline Resource Package Structure Description

  Brief description of the offline package content

- `/etc/kubeasz` is the main kubeasz directory 
- `/etc/kubeasz/example ` contains sample configuration files
-  `/etc/kubeasz/clusters ` contains cluster-related configuration files
- ` /etc/kubeasz/guance` contains <<< custom_key.brand_name >>> related charts, yaml, etc.
- `/etc/kubeasz/bin` contains k8s/etcd/docker/cni binary files
- `/etc/kubeasz/down` contains offline container image packages needed for cluster installation
- `/etc/kubeasz/down/packages` contains system base software needed for cluster installation



## 3. Cluster Installation

### 3.1 Important Notes
???+ warning "Important"
    - Ensure that the time zone settings and time synchronization are consistent across all nodes

    - Commands in the document require root privileges by default
    
    - Ensure you start installation on a clean system, do not use systems with pre-installed kubeadm or other k8s distributions
    
    - Before executing the one-click installation, configure and check the custom-generated cluster configuration files. Mainly `/etc/kubease/clusters/xxx/hosts` and `/etc/kubeasz/clusters/config.yaml`
    
    - Modify hostnames for easy identification 【optional】
    
    ```shell
    # xxx is the hostname to be set
    hostnamectl set-hostname xxx
    ```

  



### 3.2 Cluster Role Planning

Configuration for nodes in a highly available cluster:

| Role               | Quantity | Description                                                    |
| :----------------- | :--- | :------------------------------------------------------ |
| Deploy node | 1    | Runs ansible/ezctl commands, typically reuses the first master node         |
| etcd node           | 3    | Note that etcd clusters need an odd number of nodes (1, 3, 5,...), generally reusing master nodes |
| Master node         | 3    | A highly available cluster requires at least 2 master nodes                             |
| Node node           | N    | Nodes running application workloads, can upgrade machine configurations/increase node count as needed   |

???+ note "Explanation"
    By default, the container runtime and kubelet will occupy disk space under `/var`. If the disk partition is special, you can set the directories for the container runtime and kubelet data before creating the cluster configuration: `CONTAINERD_STORAGE_DIR` `DOCKER_STORAGE_DIR` `KUBELET_ROOT_DIR`

### 3.3 Deployment Steps

#### 3.3.1 Orchestrating k8s Installation on the Deployment Node

Log in to the deployment node server
Navigate to the `/etc/kueasz` directory and run the following commands

```shell
# Install Docker service on the deployment machine
# Start the local registry
# Load the required image packages for the offline environment and push them to the registry repository

./ezdown -D    
./ezdown -X 
```

For more information about ezdown parameters, run `ezdown`.

???+ tip "Tip"

    If it does not run, navigate to the `/etc/kubeasz` directory and execute `./ezdwon -h` to view


#### 3.3.2 Creating Cluster Configuration Instances

```shell
# Run the kubeasz container
./ezdown -S

# Create a new cluster named guancecloud 
# The cluster name can be customized as needed, and a corresponding directory will be generated
docker exec -it kubeasz ezctl new guancecloud
# Result output example
2022-10-19 10:48:23 DEBUG generate custom cluster files in /etc/kubeasz/clusters/guancecloud
2022-10-19 10:48:23 DEBUG set version of common plugins
2022-10-19 10:48:23 DEBUG cluster k8s-01: files successfully created.
2022-10-19 10:48:23 INFO next steps 1: to config '/etc/kubeasz/clusters/guancecloud/hosts'
2022-10-19 10:48:23 INFO next steps 2: to config '/etc/kubeasz/clusters/guancecloud/config.yml'
```

Then modify the cluster configuration files according to the prompts


```shell
# Modify the hosts file according to the previous cluster role planning
'/etc/kubeasz/clusters/xxx/hosts'  

# Other major cluster-level configuration options can be modified in the `config.yml` file 【Use defaults unless you are very clear about the parameters being modified】
'/etc/kubeasz/clusters/xxx/config.yml'

```

Sample configuration file content
???+ note "Explanation"
    Refer to the sample configuration file for custom configuration items

???+ example "Sample Configuration File"
    ```shell
    # config.yaml

    ############################
    # prepare
    ############################
    # Optional offline installation of system software packages (offline|online)
    # Default to "offline" in an offline environment
    INSTALL_SOURCE: "offline"

    # Optional perform system security hardening github.com/dev-sec/ansible-collection-hardening
    OS_HARDEN: false


    ############################
    # role:deploy
    ############################
    # Default: CA will expire in 100 years
    # Default: Certificates issued by the CA will expire in 50 years
    CA_EXPIRY: "876000h"
    CERT_EXPIRY: "438000h"

    # kubeconfig configuration parameters
    CLUSTER_NAME: "cluster1"
    CONTEXT_NAME: "context-{{ CLUSTER_NAME }}"

    # k8s version
    K8S_VER: "__k8s_ver__"

    ############################
    # role:etcd
    ############################
    # Set different WAL directories to avoid disk I/O contention and improve performance 

    # It is recommended to modify to a directory with larger disk space, specific to actual conditions
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

    # It is recommended to modify to a directory with larger disk space, specific to actual conditions
    CONTAINERD_STORAGE_DIR: "/var/lib/containerd" 

    # ------------------------------------------- docker
    # [docker] Container storage directory
    # It is recommended to modify to a directory with larger disk space, specific to actual conditions 
    # Only the deployment machine has the Docker service
    DOCKER_STORAGE_DIR: "/var/lib/docker"

    # [docker] Enable Restful API
    ENABLE_REMOTE_API: false

    # [docker] Trusted HTTP registry
    INSECURE_REG: '["http://easzlab.io.local:5000"]'


    ############################
    # role:kube-master
    ############################
    # k8s cluster master node certificate configuration, multiple IPs and domains can be added (such as adding public IP and domain)
    MASTER_CERT_HOSTS:
      - "10.1.1.1"
      - "k8s.easzlab.io"
      #- "www.test.com"

    # CIDR length for pod subnet mask on node (determines the maximum number of pod IP addresses each node can allocate)
    # If flannel uses the --kube-subnet-mgr parameter, it will read this setting to allocate pod subnets for each node
    # https://github.com/coreos/flannel/issues/847
    NODE_CIDR_LEN: 24


    ############################
    # role:kube-node
    ############################
    # Kubelet root directory
    # It is recommended to modify to a directory with larger disk space, specific to actual conditions 
    KUBELET_ROOT_DIR: "/var/lib/kubelet"

    # Maximum number of pods on a node
    MAX_PODS: 110

    # Configure resources reserved for kube components (kubelet, kube-proxy, dockerd, etc.)
    # Specific values refer to templates/kubelet-config.yaml.j2
    KUBE_RESERVED_ENABLED: "no"

    # k8s officially does not recommend casually enabling system-reserved unless you have long-term monitoring and understand the system's resource usage;
    # And as the system runs over time, appropriate increases in resource reservations are needed, specific values refer to templates/kubelet-config.yaml.j2
    # System reservation settings are based on 4c/8g VMs with minimal system services installed, if using high-performance physical machines, you can appropriately increase the reservation
    # Additionally, during cluster installation, apiserver and other resources consume a lot of memory temporarily, it is recommended to reserve at least 1G of memory
    SYS_RESERVED_ENABLED: "no"


    ############################
    # role:network [flannel,calico,cilium,kube-ovn,kube-router]
    ############################
    # ------------------------------------------- flannel
    # [flannel] Set flannel backend "host-gw", "vxlan", etc.
    FLANNEL_BACKEND: "vxlan"
    DIRECT_ROUTING: false

    # [flannel] flanneld_image: "quay.io/coreos/flannel:v0.10.0-amd64"
    flannelVer: "__flannel__"
    flanneld_image: "easzlab.io.local:5000/easzlab/flannel:{{ flannelVer }}"

    # ------------------------------------------- calico
    # [calico] Setting CALICO_IPV4POOL_IPIP="off" can improve network performance, see docs/setup/calico.md for restrictions
    CALICO_IPV4POOL_IPIP: "Always"

    # [calico] Set the host IP used by calico-node, BGP neighbors establish connections through this address, can be manually specified or automatically discovered
    IP_AUTODETECTION_METHOD: "can-reach={{ groups['kube_master'][0] }}"

    # [calico] Set calico network backend: brid, vxlan, none
    CALICO_NETWORKING_BACKEND: "brid"

    # [calico] Whether calico uses route reflectors
    # If the cluster scale exceeds 50 nodes, it is recommended to enable this feature
    CALICO_RR_ENABLED: false

    # CALICO_RR_NODES configure route reflector nodes, if not set, default to cluster master nodes
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
    # [kube-ovn] Select OVN DB and OVN Control Plane nodes, default to the first master node
    OVN_DB_NODE: "{{ groups['kube_master'][0] }}"

    # [kube-ovn] Offline image tarball
    kube_ovn_ver: "__kube_ovn__"

    # ------------------------------------------- kube-router
    # [kube-router] Public clouds have restrictions, generally ipinip should always be enabled; self-hosted environments can set to "subnet"
    OVERLAY_TYPE: "full"

    # [kube-router] NetworkPolicy support switch
    FIREWALL_ENABLE: true

    # [kube-router] kube-router image version
    kube_router_ver: "__kube_router__"
    busybox_ver: "1.28.4"


    ############################
    # role:cluster-addon
    ############################
    # Automatic installation of coredns
    dns_install: "yes"
    corednsVer: "__coredns__"
    ENABLE_LOCAL_DNS_CACHE: true
    dnsNodeCacheVer: "__dns_node_cache__"
    # Set local DNS cache address
    LOCAL_DNS_CACHE: "169.254.20.10"

    # Automatic installation of metric server
    metricsserver_install: "yes"
    metricsVer: "__metrics__"

    # Automatic installation of dashboard
    dashboard_install: "no"
    dashboardVer: "__dashboard__"
    dashboardMetricsScraperVer: "__dash_metrics__"

    # Automatic installation of prometheus
    prom_install: "no"
    prom_namespace: "monitor"
    prom_chart_ver: "__prom_chart__"

    # Automatic installation of nfs-provisioner
    # If there is an existing nfs, it must be configured as "yes" and correct server information must be configured
    nfs_provisioner_install: "no"
    nfs_provisioner_namespace: "kube-system"
    nfs_provisioner_ver: "__nfs_provisioner__"
    nfs_storage_class: "managed-nfs-storage"
    nfs_server: "192.168.1.10"
    nfs_path: "/data/nfs"

    # Automatic installation of network-check
    network_check_enabled: false
    network_check_schedule: "*/5 * * * *"

    ############################
    # role:harbor
    ############################
    # Harbor version, full version number
    HARBOR_VER: "__harbor__"
    HARBOR_DOMAIN: "harbor.easzlab.io.local"
    HARBOR_TLS_PORT: 8443

    # If set to 'false', you need to put certificates named harbor.pem and harbor-key.pem in the 'down' directory
    HARBOR_SELF_SIGNED_CERT: true

    # Install extra components
    HARBOR_WITH_NOTARY: false
    HARBOR_WITH_TRIVY: false
    HARBOR_WITH_CLAIR: false
    HARBOR_WITH_CHARTMUSEUM: true

    # ingress-nginx related configurations
    ingress_nginx_install: "yes"
    ingressnginxVer: v1.4.0
    certgenVer: v20220916-gd32f8c343
    ```

Configure Hosts
???+ example "Host Configuration Example"
    ```shell
    # 'etcd' cluster should have odd members (1,3,5,...)
    # Must replace IPs according to actual planning
    [etcd]
    192.168.1.1
    192.168.1.2
    192.168.1.3

    # master nodes
    # Must replace IPs according to actual planning
    [kube_master]
    192.168.1.1
    192.168.1.2

    # work nodes
    # Must replace IPs according to actual planning
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
    # Secure port for apiservers
    SECURE_PORT="6443"

    # Cluster container-runtime supported: docker, containerd
    # if k8s version >= 1.24, docker is not supported
    CONTAINER_RUNTIME="containerd"

    # Network plugins supported: calico, flannel, kube-router, cilium, kube-ovn
    # It is recommended to use this default value or change to "flannel"
    CLUSTER_NETWORK="calico"

    # Service proxy mode of kube-proxy: 'iptables' or 'ipvs'
    PROXY_MODE="ipvs"

    # K8S Service CIDR, must not overlap with node(host) networking
    # Cannot conflict with the host IP segment
    SERVICE_CIDR="10.68.0.0/16"

    # Cluster CIDR (Pod CIDR), must not overlap with node(host) networking
    # Cannot conflict with the host IP segment
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

After confirming that the above operations are correctly executed, run the following commands for quick deployment

???+ tip "Tip"
    ```shell
    # Suggest configuring an alias for convenience

    echo "alias dk='docker exec -it kubeasz'" >> /root/.bashrc

    source /root/.bashrc
    ```
    ```shell
    # Suggest configuring command completion, if helm command is not found, please exit and re-login via SSH to the server, check environment variables, and confirm helm command execution

    echo "source <(/etc/kubeasz/bin/helm completion bash)"  >> /root/.bashrc
   
    source /root/.bashrc
    
    ```
```shell
# One-click installation command, equivalent to executing docker exec -it kubeasz ezctl setup xxx all
# xxx represents the created cluster name
dk ezctl setup guancecloud all

# Or step-by-step installation, use dk ezctl help setup to view step-by-step installation help information
# dk ezctl setup guancecloud 01
# dk ezctl setup guancecloud 02
# dk ezctl setup guancecloud 03
# dk ezctl setup guancecloud 04
```
```shell
# After the command completes, tasks should not have errors
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
    
    -   All return information must be successful, otherwise reset the system and re-execute the installation

    -   Clean up the cluster with `docker exec -it kubeasz ezctl destroy xxx`, where `xxx` represents the cluster name

    -   Restart nodes to ensure cleanup of residual virtual NICs, routes, etc.
    
    ???+ success "Successful Return Example"
        ```shell
        PLAY RECAP *********************************************************************
        10.200.14.144              : ok=110  changed=99   unreachable=0    failed=0    skipped=172  rescued=0    ignored=0
        10.200.14.145              : ok=117  changed=106  unreachable=0    failed=0    skipped=199  rescued=0    ignored=0
        10.200.14.146              : ok=93   changed=83   unreachable=0    failed=0    skipped=148  rescued=0    ignored=0
        localhost                  : ok=33   changed=30   unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
        ```
More information about ezctl parameters can be viewed by running `ezctl`. If it cannot run, enter the `/etc/kubeasz` directory and execute `./ezctl`.



## 4. Verification of Installation

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

Confirm that all returned results have no ERROR

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

Confirm that all returned results show nodes in Ready status

### 4.3 Cluster Default Pod Status
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

Confirm all pods are in Running status and nodes are in Ready status

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
    If prompted with `kubectl: command not found` during the verification stage, log out and re-login via SSH to make the environment variables effective.

    If the helm command is not found, log out and re-login via SSH to the server, check the environment variables, and confirm the execution of the helm command

```shell
[root@k8s-node01 ~]# echo PATH=$PATH
PATH=/etc/kubeasz/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```