# Kubernetes快速部署指南

## 0. 简介

<u>参照本文档部署成功Kubernetes后 默认完成以下工作</u>
???+ info  "**功能组件覆盖情况**"

    - [x] kubernetes 1.24.2 高可用部署

    - [x] coredns 组件安装

    - [x] node-local-dns 组件安装

    - [x] ingress-nginx 组件安装

    - [x] metrics-server 组件安装

    - [x] openebs-provisioner 组件驱动安装

  

  

  资源清单

  ```shell
  1. “最低配置” 适合 POC 场景部署，只作功能验证，不适合作为生产环境使用。
  2. 作为生产部署以实际接入数据量做评估，接入的数据量越多，TDengine、OpenSearch 的存储与规格配置相应也需要越高。  
  ```
  





| **用途**                   | **资源类型**           | **最低规格**   | **推荐规格**         | **数量** | **备注**                                                     |
| -------------------------- | ---------------------- | -------------- | -------------------- | -------- | ------------------------------------------------------------ |
| **Kubernetes Master**      | 物理服务器&#124;虚拟机 | 4C8GB 100GB    | 8C16GB  100GB        | 3        | 版本： 1.24.2 **注：若是为虚拟机需适当提高资源规格，复用一台master节点充当部署节点** |
| **Kubernetes workerload**  | 物理服务器&#124;虚拟机 | 4C8GB 100GB    | 8C16GB  100GB        | 4        | k8s集群worker节点，承载{{{ custom_key.brand_name }}}应用、k8s组件、基础组件服务Mysql 5.7.18、Redis 6.0.6 |
| **{{{ custom_key.brand_name }}}代理服务**         | 物理服务器&#124;虚拟机 | 2C4GB  100GB   | 4C8GB    200GB       | 1        | 用于部署nginx 反向代理服务器部署，代理到ingress 边缘节点 **注： 出于安全考虑不直接将集群边缘节点直接暴露** |
| **{{{ custom_key.brand_name }}}网络文件系统服务** | 物理服务器&#124;虚拟机 | 2C4GB 200G     | 4C8GB 1TB 高性能磁盘 | 1        | 部署网络文件系统、网络存储服务，默认NFS（若已有存在的nfs服务该机器可取消） |
| **DataWay**                | 物理服务器&#124;虚拟机 | 2C4GB  100GB   | 4C8GB    100GB       | 1        | 用户部署 DataWay                                             |
| **OpenSearch**             | 物理服务器&#124;虚拟机 | 4C8GB 1TB      | 8C16G   1TB          | 3        | OpenSearch 版本：2.2.1 **注：需要开启密码认证，安装匹配版本分词插件 analysis-ik** |
| **TDengine**               | 物理服务器&#124;虚拟机 | 4C8GB  500GB   | 8C16G 1TB            | 3        | TDengine 版本：2.6.0.18                |
| **其他**                   | 邮件服务器/短信        | -              | -                    | 1        | 短信网关，邮件服务器，告警通道                               |
|                            | 已备案正式通配符域名   | -              | -                    | 1        | 主域名需备案                                                 |
|                            | SSL/TLS证书            | 通配符域名证书 | 通配符域名证书       | 1        | 保障站点安全                                                 |

  

## 1. 前置条件	
???+ warning "重要" 

      - **基础环境离线资源包上传到所有集群节点，并解压到服务器/etc目录**
      - **部署节点和集群其他节点已配置ssh免密登录(包括部署节点自身)**	
      - **{{{ custom_key.brand_name }}}平台离线资源包上传到所有集群节点，定导入到容器运行时环境(containerd)**
      
      ```shell
      #解压下载的{{{ custom_key.brand_name }}}镜像包，并导入到containerd
         
      gunzip xxx.tar.gz
      ctr -n k8s.io images import xxx.tar
      ```
      

### 1.1 免密登录设置参考

```shell
# 登录到部署机执行命令
# 生成公钥对 
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

# $IP 为所有节点地址包括自身，按照提示输入yes 和root密码
ssh-copy-id $IP 

# 为每个节点设置python软链接，默认不需要执行【针对使用 python3 的某些版本需要执行此操作】
# ssh $IP ln -s /usr/bin/python3 /usr/bin/python
```



## 2. 部署准备

### 2.1 资源包下载

  基础环境离线资源包下载地址  [Download]( https://{{{ custom_key.static_domain }}}/dataflux/package/k8s_offline.tar.gz)

### 2.2 离线资源包结构说明

  离线包内容简要说明

- `/etc/kubeasz` 为kubeasz主目录 
- `/etc/kubeasz/example ` 包含示例配置文件
-  `/etc/kubeasz/clusters `包含创建的集群相关配置文件
- ` /etc/kubeasz/guance` 包含{{{ custom_key.brand_name }}}相关的charts、yaml 等信息
- `/etc/kubeasz/bin` 包含 k8s/etcd/docker/cni 等二进制文件
- `/etc/kubeasz/down` 包含集群安装时需要的离线容器镜像包等
- `/etc/kubeasz/down/packages` 包含集群安装时需要的系统基础软件



## 3. 安装集群

### 3.1 注意事项
???+ warning "重要"
    - 确保各节点时区设置一致、时间同步

    - 文档中命令默认都需要root权限运行
    
    - 确保在干净的系统上开始安装，不要使用曾经装过kubeadm或其他k8s发行版
    
    - 执行一键安装前一定要配置并检查自定义集群生成的配置文件。主要是/etc/kubease/clusters/xxx/hosts和/etc/kubeasz/clusters/config.yaml
    
    - 修改方便识别的主机名【可选】
    
    ```shell
    # xxx 为需要设置的主机名
    hostnamectl set-hostname xxx
    ```

  



### 3.2 集群角色规划

高可用集群所需节点配置如下

| 角色               | 数量 | 描述                                                    |
| :----------------- | :--- | :------------------------------------------------------ |
| deploy（部署）节点 | 1    | 运行ansible/ezctl命令，一般复用第一个master节点         |
| etcd节点           | 3    | 注意etcd集群需要1,3,5,...奇数个节点，一般复用master节点 |
| master节点         | 3    | 高可用集群至少2个master节点                             |
| node节点           | N    | 运行应用负载的节点，可根据需要提升机器配置/增加节点数   |

???+ note "说明"
    默认配置下容器运行时和kubelet会占用/var的磁盘空间，如果磁盘分区特殊，可以在创建集群配置前，设置example/config.yml中的容器运行时和kubelet数据目录：`CONTAINERD_STORAGE_DIR` `DOCKER_STORAGE_DIR` `KUBELET_ROOT_DIR`

### 3.3 部署步骤

#### 3.3.1 在部署节点编排k8s安装

登录到部署节点服务器
进入到/etc/kueasz目录，执行下面命令

```shell
# 在部署机器上安装docker服务
# 启动registry本地仓库
# 载入离线环境所需要的镜像包，并push到registry仓库

./ezdown -D    
./ezdown -X 
```

更多关于ezdown的参数，运行ezdown 查看。

???+ tip "小贴士"

    若不能运行请进入到 /etc/kubeasz目录 执行./ezdwon -h 查看


#### 3.3.2 创建集群配置实例

```shell
# 运行kubeasz 容器
./ezdown -S

# 创建新的集群 guancecloud 
# 集群名称可以按需自定义，相应会生成和集群名匹配的目录
docker exec -it kubeasz ezctl new guancecloud
# 结果回显示例
2022-10-19 10:48:23 DEBUG generate custom cluster files in /etc/kubeasz/clusters/guancecloud
2022-10-19 10:48:23 DEBUG set version of common plugins
2022-10-19 10:48:23 DEBUG cluster k8s-01: files successfully created.
2022-10-19 10:48:23 INFO next steps 1: to config '/etc/kubeasz/clusters/guancecloud/hosts'
2022-10-19 10:48:23 INFO next steps 2: to config '/etc/kubeasz/clusters/guancecloud/config.yml'
```

然后根据提示配置修改集群配置文件


```shell
#根据前面集群角色规划修改hosts文件
'/etc/kubeasz/clusters/xxx/hosts'  

#其他集群层面的主要配置选项可以在config.yml 文件中修改【建议使用默认，除非您对修改的参数非常清楚】
'/etc/kubeasz/clusters/xxx/config.yml'

```

配置文件示例内容如下
???+ note "说明"
    需要自定义配置项，请参阅示例配置文件

???+ example "示例配置文件"
    ```shell
    # config.yaml

    ############################
    # prepare
    ############################
    # 可选离线安装系统软件包 (offline|online)
    # 离线环境默认为 "offline"
    INSTALL_SOURCE: "offline"

    # 可选进行系统安全加固 github.com/dev-sec/ansible-collection-hardening
    OS_HARDEN: false


    ############################
    # role:deploy
    ############################
    # default: ca will expire in 100 years
    # default: certs issued by the ca will expire in 50 years
    CA_EXPIRY: "876000h"
    CERT_EXPIRY: "438000h"

    # kubeconfig 配置参数
    CLUSTER_NAME: "cluster1"
    CONTEXT_NAME: "context-{{ CLUSTER_NAME }}"

    # k8s version
    K8S_VER: "__k8s_ver__"

    ############################
    # role:etcd
    ############################
    # 设置不同的wal目录，可以避免磁盘io竞争，提高性能 

    # 建议修改为磁盘空间较大的目录，具体以实际情况为准
    ETCD_DATA_DIR: "/var/lib/etcd"
    ETCD_WAL_DIR: ""


    ############################
    # role:runtime [containerd,docker]
    ############################
    # ------------------------------------------- containerd
    # [.]启用容器仓库镜像
    ENABLE_MIRROR_REGISTRY: true

    # [containerd]基础容器镜像
    SANDBOX_IMAGE: "easzlab.io.local:5000/easzlab/pause:__pause__"

    # [containerd]容器持久化存储目录

    # 建议修改为磁盘空间较大的目录，具体以实际情况为准
    CONTAINERD_STORAGE_DIR: "/var/lib/containerd" 

    # ------------------------------------------- docker
    # [docker]容器存储目录
    # 建议修改为磁盘空间较大的目录，具体以实际情况为准 
    # 只有部署机器上会有docker服务
    DOCKER_STORAGE_DIR: "/var/lib/docker"

    # [docker]开启Restful API
    ENABLE_REMOTE_API: false

    # [docker]信任的HTTP仓库
    INSECURE_REG: '["http://easzlab.io.local:5000"]'


    ############################
    # role:kube-master
    ############################
    # k8s 集群 master 节点证书配置，可以添加多个ip和域名（比如增加公网ip和域名）
    MASTER_CERT_HOSTS:
      - "10.1.1.1"
      - "k8s.easzlab.io"
      #- "www.test.com"

    # node 节点上 pod 网段掩码长度（决定每个节点最多能分配的pod ip地址）
    # 如果flannel 使用 --kube-subnet-mgr 参数，那么它将读取该设置为每个节点分配pod网段
    # https://github.com/coreos/flannel/issues/847
    NODE_CIDR_LEN: 24


    ############################
    # role:kube-node
    ############################
    # Kubelet 根目录
    # 建议修改为磁盘空间较大的目录，具体以实际情况为准 
    KUBELET_ROOT_DIR: "/var/lib/kubelet"

    # node节点最大pod 数
    MAX_PODS: 110

    # 配置为kube组件（kubelet,kube-proxy,dockerd等）预留的资源量
    # 数值设置详见templates/kubelet-config.yaml.j2
    KUBE_RESERVED_ENABLED: "no"

    # k8s 官方不建议草率开启 system-reserved, 除非你基于长期监控，了解系统的资源占用状况；
    # 并且随着系统运行时间，需要适当增加资源预留，数值设置详见templates/kubelet-config.yaml.j2
    # 系统预留设置基于 4c/8g 虚机，最小化安装系统服务，如果使用高性能物理机可以适当增加预留
    # 另外，集群安装时候apiserver等资源占用会短时较大，建议至少预留1g内存
    SYS_RESERVED_ENABLED: "no"


    ############################
    # role:network [flannel,calico,cilium,kube-ovn,kube-router]
    ############################
    # ------------------------------------------- flannel
    # [flannel]设置flannel 后端"host-gw","vxlan"等
    FLANNEL_BACKEND: "vxlan"
    DIRECT_ROUTING: false

    # [flannel] flanneld_image: "quay.io/coreos/flannel:v0.10.0-amd64"
    flannelVer: "__flannel__"
    flanneld_image: "easzlab.io.local:5000/easzlab/flannel:{{ flannelVer }}"

    # ------------------------------------------- calico
    # [calico]设置 CALICO_IPV4POOL_IPIP=“off”,可以提高网络性能，条件限制详见 docs/setup/calico.md
    CALICO_IPV4POOL_IPIP: "Always"

    # [calico]设置 calico-node使用的host IP，bgp邻居通过该地址建立，可手工指定也可以自动发现
    IP_AUTODETECTION_METHOD: "can-reach={{ groups['kube_master'][0] }}"

    # [calico]设置calico 网络 backend: brid, vxlan, none
    CALICO_NETWORKING_BACKEND: "brid"

    # [calico]设置calico 是否使用route reflectors
    # 如果集群规模超过50个节点，建议启用该特性
    CALICO_RR_ENABLED: false

    # CALICO_RR_NODES 配置route reflectors的节点，如果未设置默认使用集群master节点
    # CALICO_RR_NODES: ["192.168.1.1", "192.168.1.2"]
    CALICO_RR_NODES: []

    # [calico]更新支持calico 版本: [v3.3.x] [v3.4.x] [v3.8.x] [v3.15.x]
    calico_ver: "__calico__"

    # [calico]calico 主版本
    calico_ver_main: "{{ calico_ver.split('.')[0] }}.{{ calico_ver.split('.')[1] }}"

    # ------------------------------------------- cilium
    # [cilium]镜像版本
    cilium_ver: "__cilium__"
    cilium_connectivity_check: true
    cilium_hubble_enabled: false
    cilium_hubble_ui_enabled: false

    # ------------------------------------------- kube-ovn
    # [kube-ovn]选择 OVN DB and OVN Control Plane 节点，默认为第一个master节点
    OVN_DB_NODE: "{{ groups['kube_master'][0] }}"

    # [kube-ovn]离线镜像tar包
    kube_ovn_ver: "__kube_ovn__"

    # ------------------------------------------- kube-router
    # [kube-router]公有云上存在限制，一般需要始终开启 ipinip；自有环境可以设置为 "subnet"
    OVERLAY_TYPE: "full"

    # [kube-router]NetworkPolicy 支持开关
    FIREWALL_ENABLE: true

    # [kube-router]kube-router 镜像版本
    kube_router_ver: "__kube_router__"
    busybox_ver: "1.28.4"


    ############################
    # role:cluster-addon
    ############################
    # coredns 自动安装
    dns_install: "yes"
    corednsVer: "__coredns__"
    ENABLE_LOCAL_DNS_CACHE: true
    dnsNodeCacheVer: "__dns_node_cache__"
    # 设置 local dns cache 地址
    LOCAL_DNS_CACHE: "169.254.20.10"

    # metric server 自动安装
    metricsserver_install: "yes"
    metricsVer: "__metrics__"

    # dashboard 自动安装
    dashboard_install: "no"
    dashboardVer: "__dashboard__"
    dashboardMetricsScraperVer: "__dash_metrics__"

    # prometheus 自动安装
    prom_install: "no"
    prom_namespace: "monitor"
    prom_chart_ver: "__prom_chart__"

    # nfs-provisioner 自动安装
    # 若有现存的 nfs 必须配置为 "yes" 并配置正确的 server 信息
    nfs_provisioner_install: "no"
    nfs_provisioner_namespace: "kube-system"
    nfs_provisioner_ver: "__nfs_provisioner__"
    nfs_storage_class: "managed-nfs-storage"
    nfs_server: "192.168.1.10"
    nfs_path: "/data/nfs"

    # network-check 自动安装
    network_check_enabled: false
    network_check_schedule: "*/5 * * * *"

    ############################
    # role:harbor
    ############################
    # harbor version，完整版本号
    HARBOR_VER: "__harbor__"
    HARBOR_DOMAIN: "harbor.easzlab.io.local"
    HARBOR_TLS_PORT: 8443

    # if set 'false', you need to put certs named harbor.pem and harbor-key.pem in directory 'down'
    HARBOR_SELF_SIGNED_CERT: true

    # install extra component
    HARBOR_WITH_NOTARY: false
    HARBOR_WITH_TRIVY: false
    HARBOR_WITH_CLAIR: false
    HARBOR_WITH_CHARTMUSEUM: true

    # ingress-nginx 相关配置
    ingress_nginx_install: "yes"
    ingressnginxVer: v1.4.0
    certgenVer: v20220916-gd32f8c343
    ```

配置主机
???+ example "主机配置示例"
    ```shell
    # 'etcd' cluster should have odd member(s) (1,3,5,...)
    # 必须按照实际规划情况替换ip
    [etcd]
    192.168.1.1
    192.168.1.2
    192.168.1.3

    # master node(s)
    # 必须按照实际规划情况替换ip
    [kube_master]
    192.168.1.1
    192.168.1.2

    # work node(s)
    # 必须按照实际规划情况替换ip
    [kube_node]
    192.168.1.3
    192.168.1.4

    # [optional] harbor server, a private docker registry
    # 'NEW_INSTALL': 'true' to install a harbor server; 'false' to integrate with existed one
    [harbor]
    #192.168.1.8 NEW_INSTALL=false

    # [optional] loadbalance for accessing k8s from outside
    [ex_lb]
    #192.168.1.6 LB_ROLE=backup EX_APISERVER_VIP=192.168.1.250 EX_APISERVER_PORT=8443
    #192.168.1.7 LB_ROLE=master EX_APISERVER_VIP=192.168.1.250 EX_APISERVER_PORT=8443

    # [optional] ntp server for the cluster
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
    # 建议使用该默认值，或者修改为 "flannel"
    CLUSTER_NETWORK="calico"

    # Service proxy mode of kube-proxy: 'iptables' or 'ipvs'
    PROXY_MODE="ipvs"

    # K8S Service CIDR, not overlap with node(host) networking
    # 不能和主机ip段冲突
    SERVICE_CIDR="10.68.0.0/16"

    # Cluster CIDR (Pod CIDR), not overlap with node(host) networking
    # 不能和主机ip段冲突
    CLUSTER_CIDR="172.20.0.0/16"

    # NodePort Range
    NODE_PORT_RANGE="30000-32767"

    # Cluster DNS Domain
    CLUSTER_DNS_DOMAIN="cluster.local"

    # -------- Additional Variables (don't change the default value right now) ---
    # Binaries Directory
    bin_dir="/opt/kube/bin"

    # Deploy Directory (kubeasz workspace)
    base_dir="/etc/kubeasz"

    # Directory for a specific cluster
    cluster_dir="{{ base_dir }}/clusters/_cluster_name_"

    # CA and other components cert/key Directory
    ca_dir="/etc/kubernetes/ssl"
    ```



#### 3.3.3 一键部署

上述操作确认执行无误后执行如下命令进行快速部署

???+ tip "小贴士"
    ```shell
    #建议配置命令alias，方便执行

    echo "alias dk='docker exec -it kubeasz'" >> /root/.bashrc

    source /root/.bashrc
    ```
    ```shell
    #建议配置命令补全,如果报错helm命令找不到,请退出后重新ssh登录到服务,查看环境变量，执行helm命令确认能否执行

    echo "source <(/etc/kubeasz/bin/helm completion bash)"  >> /root/.bashrc
   
    source /root/.bashrc
    
    ```
```shell
# 一键安装命令，等价于执行docker exec -it kubeasz ezctl setup xxx all
# xxx 表示创建的集群名称
dk ezctl setup guancecloud all

# 或者分步安装，具体使用 dk ezctl help setup 查看分步安装帮助信息
# dk ezctl setup guancecloud 01
# dk ezctl setup guancecloud 02
# dk ezctl setup guancecloud 03
# dk ezctl setup guancecloud 04
```
```shell
# 命令跑完后task 不能有错误
TASK [cluster-addon : 准备 DNS的部署文件] *********************************************
changed: [10.200.14.144]

TASK [cluster-addon : 创建coredns部署] *********************************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备dnscache的部署文件] *****************************************
changed: [10.200.14.144]

TASK [cluster-addon : 创建dnscache部署] ********************************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 metrics-server的部署文件] **********************************
changed: [10.200.14.144]

TASK [cluster-addon : 创建 metrics-server部署] *************************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 nfs-provisioner 配置目录] *********************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 nfs-provisioner部署文件] **********************************
changed: [10.200.14.144] => (item=nfs-provisioner.yaml)
changed: [10.200.14.144] => (item=test-pod.yaml)

TASK [cluster-addon : 创建 nfs-provisioner部署] ************************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 openebs-provisioner 配置目录] *****************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 openebs-provisioner 部署文件] *****************************
changed: [10.200.14.144] => (item=openebs-provisioner.yaml)

TASK [cluster-addon : 创建 openebs-provisioner 部署] *******************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 ingress-nginx 配置目录] ***********************************
changed: [10.200.14.144]

TASK [cluster-addon : 准备 ingress-nginx 部署文件] ***********************************
changed: [10.200.14.144] => (item=ingress-nginx.yaml)

TASK [cluster-addon : 创建 ingress-nginx 部署] *************************************
changed: [10.200.14.144]

PLAY RECAP *********************************************************************
10.200.14.144              : ok=110  changed=99   unreachable=0    failed=0    skipped=172  rescued=0    ignored=0
10.200.14.145              : ok=117  changed=106  unreachable=0    failed=0    skipped=199  rescued=0    ignored=0
10.200.14.146              : ok=93   changed=83   unreachable=0    failed=0    skipped=148  rescued=0    ignored=0
localhost                  : ok=33   changed=30   unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
```
???+ warning "重要"
    
    -   必须返回信息全部成功，否者请重置系统，重新执行安装

    -   清理集群 docker exec -it kubeasz ezctl destroy xxx  其中xxx 表示集群名称

    -   重启节点，以确保清理残留的虚拟网卡、路由等信息
    
    ???+ success "成功返回示例"
        ```shell
        PLAY RECAP *********************************************************************
        10.200.14.144              : ok=110  changed=99   unreachable=0    failed=0    skipped=172  rescued=0    ignored=0
        10.200.14.145              : ok=117  changed=106  unreachable=0    failed=0    skipped=199  rescued=0    ignored=0
        10.200.14.146              : ok=93   changed=83   unreachable=0    failed=0    skipped=148  rescued=0    ignored=0
        localhost                  : ok=33   changed=30   unreachable=0    failed=0    skipped=11   rescued=0    ignored=0
        ```
更多关于ezctl的参数，运行ezctl 查看，若不能运行请进入到 /etc/kubeasz目录 执行./ezctl 查看



## 4. 验证安装

### 4.1 集群组件状态
???+ success "集群组件"
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

确认所有返回结果无 ERROR

### 4.2 集群节点状态
???+ success "集群节点"
    ```shell
    [root@k8s-node01 ~]# kubectl  get nodes
    NAME            STATUS   ROLES    AGE   VERSION
    10.200.14.111   Ready    master   22h   v1.24.2
    10.200.14.112   Ready    master   22h   v1.24.2
    10.200.14.113   Ready    master   22h   v1.24.2
    10.200.14.114   Ready    node     22h   v1.24.2
    ```

确认所有返回结果节点状态为 Ready

### 4.3 集群默认pod 状态
???+ success "集群初始pod"
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

确认所有pod状态为 Running 状态为 Ready 

4.4 确认集群info信息
???+ success "集群信息"
    ```shell
    [root@k8s-node01 ~]# kubectl  cluster-info
    Kubernetes control plane is running at https://127.0.0.1:6443
    CoreDNS is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    KubeDNSUpstream is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns-upstream:dns/proxy
    kubernetes-dashboard is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy

    To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
    ```

4.5 确认集群资源使用情况
???+ success "集群资源使用情况"

    ```shell
    [root@k8s-node01 /etc/kubeasz/roles]# kubectl  top nodes
    NAME            CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
    10.200.14.111   191m         9%     1215Mi          33%
    10.200.14.112   278m         6%     5692Mi          36%
    10.200.14.113   276m         6%     5684Mi          36%
    10.200.14.114   115m         2%     4444Mi          28%
    ```

确认能够正常返回集群资源使用情况

## 5. 常见问题
???+ Tips "小贴士"
    验证安装阶段如果提示kubectl: command not found，退出重新ssh登录一下，环境变量生效即可

    如果报错helm命令找不到,请退出后重新ssh登录到服务,查看环境变量，执行helm命令确认能否执行

```shell
[root@k8s-node01 ~]# echo PATH=$PATH
PATH=/etc/kubeasz/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```









