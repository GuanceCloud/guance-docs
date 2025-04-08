# Doris Deployment

???+ warning "Note"
     Choose either OpenSearch or Doris.

## Description
### Component Description
* Doris Manager: Used for deployment, upgrade, configuration changes of the Doris cluster
* Doris FE: Mainly responsible for user request access, query parsing planning, metadata management, node management related work
* Doris BE: Mainly responsible for data storage and execution of query plans
* guance-insert: Receives line protocol format data, accumulates locally (due to lower space usage usually uses tmpfs), batch writes into Doris BE
* guance-select: Translates DQL queries into SQL; most queries use Doris FE, some queries use Doris BE Thrift interface
* VictoriaMetrics: Stores write volume metrics at the index level, providing auxiliary information for sampling queries and other functions

### Server Description
Typically, the following three groups of machines are used. Small clusters can also be mixed, the server system OS is preferably Ubuntu.

* doris-fe: CPU to memory ratio 1:2, one 20GB+ data disk for storing metadata, the first machine can be used to deploy Doris Manager
* doris-be: CPU to memory ratio 1:8, adjust disk configuration (number) to maximize disk throughput
* guancedb-logs: CPU to memory ratio 1:2, can be deployed on a host or container; the first machine needs a data disk to deploy VictoriaMetrics for storing some Doris metadata metrics
* CPU must support AVX2 instruction set
* Cannot have resources preempted by other machines (CPU steal should not be too high)

### Network Description
* Doris Manager is usually deployed on the doris-fe-01 server, its machine needs to be able to ssh with all oris machines, needs access to port 8004 web page
* guancedb-logs machines need to install supervisor through the system package management tool (APT)
* Needs to access port 9030 of the FE machine via MySQL protocol, typically installing mysql-client on the machine where Doris Manager is located
* guancedb-logs machines need to access: port 8030 and 9030 of doris-fe machines; port 8040 and 9060 of doris-be machines; port 8428 of the first guancedb-logs machine
* The provided account needs full permissions for the s3 bucket

### Deployment Description
* Once an s3 bucket is configured, it cannot be modified. If modification is needed, only clearing the data and reinstalling the Doris cluster is possible
* Doris is deployed via **HOSTS**. Regardless of network availability, the material package must first be placed in the designated location
* RAID purchased for self-procured disk hardware cannot be RAID 0


| Category           | Description                                           |
|--------------|----------------------------------------------| 
| **Components Deployed on Hosts**  | be + fe + manager + guancedb-logs            | | 
| **Pre-deployment Conditions**   | 1. Provide root password and support passwordless login via root ssh<br/>2. CPU architecture supports AVX2 instruction set |

## Default Deployment Configuration Information
| Category          | Description              |
|-------------|-----------------| 
| **Host Deployment**    | Refer to the **Host Deployment Description** below | |

???+ warning "Host Deployment Description"

    guancedb-logs machines only have one unit, the address used for <<< custom_key.brand_name >>> business services is the host ip:8480/8481;
    
    guancedb-logs machines have multiple units:
    
    a. Can provide ELB capability, using ELB to listen on ports 8480/8481 of multiple guancedb-logs machines, business services use the address ELB ip:8480/8481;
    
    b. Unable to provide ELB capability, you can create a service within the business cluster, the business service uses the address:
    
    Write: internal-doris-insert.middleware:8480
    
    Read: internal-doris-select.middleware:8481
    
    Refer to the following yaml to create a service

???- note "doris-service.yaml (click to open)"
    ```yaml

    ---
    apiVersion: v1
    kind: Service
    metadata: 
      name: internal-doris-insert
      namespace: middleware
    spec:
      ports:
        - protocol: TCP
          port: 8480
          targetPort: 8480
    ---
    apiVersion: v1
    kind: Endpoints
    metadata:
      # This name must match the Service name
      name: internal-doris-insert
      namespace: middleware
    subsets:
      # Write as many entries as there are guancedb-logs machines
      - addresses:
          - ip: 10.7.17.250
        ports:
          - port: 8480      
      - addresses:
          - ip: 10.7.17.251
        ports:
          - port: 8480
    
    ---
    apiVersion: v1
    kind: Service
    metadata: 
      name: internal-doris-select
      namespace: middleware
    spec:
      ports:
        - protocol: TCP
          port: 8481
          targetPort: 8481
    ---
    apiVersion: v1
    kind: Endpoints
    metadata:
      # This name must match the Service name
      name: internal-doris-select
      namespace: middleware
    subsets:
      # Write as many entries as there are guancedb-logs machines
      - addresses:
          - ip: 10.7.17.250
        ports:
          - port: 8481      
      - addresses:
          - ip: 10.7.17.251
        ports:
          - port: 8481
    
    ```

## Doris Deployment

### Preparations
#### Download Material Package
Install the tool package. Place the installation package on the fe-01 machine.
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/guancedb-doris-deploy-latest.tar.gz
```

After extracting the downloaded package, it contains the SelectDB + manager installation package. Place the installation package on the fe-01 machine, folder location same as configured in inventory/doris-manager.vars.yaml
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/selectdb-latest.tar.gz
```

After extracting the downloaded package, it contains the GuanceDB installation package. Place the installation package on all guancedb-logs machines, file location same as configured in inventory/guancedb-logs-doris.vars.yaml
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/guancedb-cluster-linux-amd64-latest.tar.gz
```

After extracting the downloaded package, it contains the victoria-metrics + vmutils installation package. Place the installation package on all guancedb-logs machines, file location same as configured in inventory/guancedb-logs-doris.vars.yaml
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/vmutils-latest.tar.gz
```

#### Configure Passwordless Login Between Machines
On the jump server (usually on fe-01), check if the current user has a public key in ~/.ssh. If no public key exists, generate one and send it remotely to other role machines by executing the following commands:
```shell
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub  root@192.168.xxx.xxx
```
???+ warning "Deployment Check Points"
     
     Verify that be and fe machine configurations are of the same specification;
    
     Network ping between be and fe machines does not exceed 1ms;
    
     Data disks provided by the server are raw disks (not partitioned or formatted).

### Hosts File Preparation
Under the inventory directory, there need to be 5 hosts files:

* doris-be.hosts.yaml
* doris-fe.hosts.yaml
* doris-manager.hosts.yaml
* guancedb-logs-doris.hosts.yaml
* guancedb-logs-doris-vm.hosts.yaml

Each host file format is as follows:

name field format must be xxx-doirs-fe-01 or xxx-doris-be-01

```shell
clusters:
  - name: xxx
    hosts:
      - name: xxx-doris-be-01
        port: xxx
        host: xxx
        user: xxx
        vars:
          default_ipv4: xxx
      - name: xxx-doris-be-02
        port: xxx
        host: xxx
        user: xxx
        vars:
          default_ipv4: xxx

# name:          Marks the cluster, can fill poc or prd
# hosts.name:    Marks the server role, can fill xxx-doris-be-01, xxx can be poc or prd
# hosts.port:    SSH port, generally 22
# hosts.host:    SSH target machine's IP
# hosts.user:    SSH target machine's user, generally root
# vars.default_ipv4: IP address of be-01
```
???+ warning "Description"

    Generally, manager is deployed together with fe, content of doris-manager.hosts.yaml is the same as doris-fe.hosts.yaml. If there are multiple fe hosts in doris-fe.hosts.yaml, content of doris-manager.hosts.yaml only needs to include fe-01
    
    Content of guancedb-logs-doris-vm.hosts.yaml is the same as guancedb-logs-doris.hosts.yaml. If there are multiple hosts in guancedb-logs-doris.hosts.yaml, content of guancedb-logs-doris-vm.hosts.yaml only needs to include one

### Configure Variables
Modify the inventory/doris-manager.vars.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # Fill in the path to the Doris installation package on the machine; such as /root/packages/xxx.tar.gz
      doris_local_path: 
      # Fill in the path to the Doris Manager installation package on the machine; such as /root/packages/xxx.tar.gz
      manager_local_path:

      # Do not fill in the following part if cold storage is not used
      oss_endpoint:
      oss_bucket:
      # Can leave blank
      oss_region:
      # When using cloud vendor object storage, this is usually unnecessary; when using self-built object storage and endpoint is IP, need to fill in 「path」 
      addressing_style:
```
Modify the inventory/doris.vars.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # Replica count configuration. Testing environment can be configured to 1, production environment is recommended to configure 2 or more
      replication_factor: 2
      # FE machine memory GB
      fe_host_mem_gb:
      # Number of FE machines
      fe_num:
      # Number of BE machines
      be_num:
      # Number of cores on BE machine
      be_host_core_num:
      # Number of BE data disks
      be_data_disk_num:
      # Size of single BE data disk GB
      be_data_disk_gb:
      # BE cgroup cpu directory, see below to determine if v1 or v2 is supported, then fill in the corresponding address
      be_cgroup_cpu_path: 
      # fe log retention time
      fe_log_retention: 3d
      # Internal network subnet for FE and BE machines
      cidr: 
```
Modify the inventory/guancedb-logs-doris.vars.yaml file
```shell
  - name: xxx
    vars:
      # Version number is not in use, leave blank
      version: ""
      # Fill in the directory where the installation package is located on the machine; such as /root/packages
      local_dir:
```
Modify the inventory/secrets.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # zyadmin user password for the operating system, to meet security requirements, it is recommended to use a strong password
      os_zyadmin_password:
      # doris user password for the operating system, to meet security requirements, it is recommended to use a strong password
      os_doris_password:
      # root database user password, it is recommended to use a strong password
      doris_root_password:
      # user_read database user password, it is recommended to use a strong password
      doris_user_read_password:
      # Access key for object storage, do not fill in if cold storage is not used
      oss_ak:
      # Secret key for object storage, do not fill in if cold storage is not used
      oss_sk:
      # Used for self-monitoring data reporting, it is an array, usually only one needs to be filled in, can leave blank
      dataway_urls: []
      # Whether to set hostname, set to false when mixed deployment
      set_hostname: false
```
### Install Python Dependency Packages
```shell
pip3 install -r requirements.txt
```

### Deploy Doris Manager
Initialize machines, after completion need to check disk mounting
```shell
python3 deployer.py -l clusrer_name -i 'inventory/doris-?e.*.yaml' -p playbooks/doris/initialize-machine.yaml
```
???+ warning "Deployment Check Points"
     
     Correctness of server disk mounting;
    
     Whether server swap is permanently disabled;
    
     Whether server vm.max_map_count parameter is adjusted to 2000000.

Update Datakit configuration for self-monitoring data reporting
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-?e.*.yaml' -p playbooks/doris/update-datakit.yaml
```

Download and start Doris Manager
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-manager.*.yaml' -p playbooks/doris/initialize-manager.yaml
```

Configure cgroup for be nodes

Need to confirm whether the server supports cgroup v1 or v2

```shell
If this path exists, it means cgroup v1 is currently active
ls /sys/fs/cgroup/cpu/

If this path exists, it means cgroup v2 is currently active
ls /sys/fs/cgroup/cgroup.controllers
```

=== "cgroup v1"
	
	```shell
	# Create service file
	sudo vi /etc/systemd/system/doris-cgroup-v1.service
	
	# File content
	[Unit]
	Description=Create Doris CGroup V1
	After=remote-fs.target
	
	[Service]
	Type=oneshot
	RemainAfterExit=yes
	ExecStart=/bin/bash -c '\
	    mkdir -p /sys/fs/cgroup/cpu/doris && \
	    mkdir -p /sys/fs/cgroup/memory/doris && \
	    chmod 770 /sys/fs/cgroup/cpu/doris && \
	    chmod 770 /sys/fs/cgroup/memory/doris && \
	    chown -R doris:doris /sys/fs/cgroup/cpu/doris && \
	    chown -R doris:doris /sys/fs/cgroup/memory/doris'
	
	[Install]
	WantedBy=multi-user.target
	# Reload systemd configuration
	sudo systemctl daemon-reload
	# Enable service on boot
	sudo systemctl enable doris-cgroup-v1.service
	# Start service
	sudo systemctl start doris-cgroup-v1.service
	# Check service status
	sudo systemctl status doris-cgroup-v1.service
	# Check
	ls -l /sys/fs/cgroup/cpu/doris
	```

=== "cgroup v2"

	```shell
	# Create service file
	sudo vi /etc/systemd/system/doris-cgroup-v2.service
	
	# File content
	[Unit]
	Description=Create Doris CGroup V2
	After=remote-fs.target
	
	[Service]
	Type=oneshot
	RemainAfterExit=yes
	ExecStart=/bin/bash -c '\
	    mkdir -p /sys/fs/cgroup/doris && \
	    chmod 770 /sys/fs/cgroup/doris && \
	    chown -R doris:doris /sys/fs/cgroup/doris && \
	    chmod a+w /sys/fs/cgroup/cgroup.procs'
	
	[Install]
	WantedBy=multi-user.target
	# Reload systemd configuration
	sudo systemctl daemon-reload
	# Enable service on boot
	sudo systemctl enable doris-cgroup-v2.service
	# Start service
	sudo systemctl start doris-cgroup-v2.service
	# Check service status
	sudo systemctl status doris-cgroup-v2.service
	
	# Verify
	ls -l /sys/fs/cgroup/doris
	cat /sys/fs/cgroup/cgroup.subtree_control
	```

### Deploy Doris FE and BE

#### Create Doris Cluster
Access address: http://doris-fe-01:8004

**Create Doris Manager Administrator Account**
![](img/doris-manager-1.png)
**Service Configuration**

- Disable monitoring alert services
- Doris local installation package path: /data1/doris/manager/downloads/doris
- Doris Manager local installation package path: /data1/doris/manager/downloads/manager


![](img/doris-manager-2.png)

**Start Doris Manager**
![](img/doris-manager-3.png)

**Create New Cluster**

- Cluster Name: Customer abbreviation_test/prd Example: guance_prd
- Database root user password: Fill in the doris_root_password from inventory/secrets.yaml

![](img/doris-manager-4.png)

**Node Configuration**

- Node username: doris
- Node password: Fill in the os_doris_password from inventory/secrets.yaml

![](img/doris-1.png)

- FE installation path: /home/doris/
- FE metadata storage directory: /data1/doris/meta

![](img/doris-2.png)


- BE installation path: /home/doris/
- BE data storage directory: Fill in one input box per data disk, /data1/doris/data, /data2/doris/data, etc.

![](img/doris-3.png)
![](img/doris-4.png)

**Deploy Cluster**
![](img/doris-5.png)
![](img/doris-6.png)

#### Configure Doris Cluster

Modify tokenizer configuration, parameters need to be changed to the cluster name
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-be.*.yaml' -p playbooks/doris/update-be.yaml
```
Render Doris configuration in the doris-conf directory, check if cluster_name-be.conf and cluster_name-fe.conf are generated under the doris-conf folder
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris.vars.yaml' -p playbooks/doris/render-config.yaml
```
???+ warning "Deployment Check Points"

     Whether the storage_path in the configuration file is correctly configured;
    
     Whether the priority_networks in the configuration file is correctly configured.

Modify BE configuration: In the upper right corner of the Doris Manager cluster page, click the 「…」 button -> 「Parameter Configuration」 -> Select all BE nodes -> Upper right corner 「Edit Configuration」 -> Paste the generated be.conf -> Check 「Please Confirm...」 -> 「OK」

![](img/be-conf-1.png)
![](img/be-conf-3.png)

Modify FE configuration: In the upper right corner of the Doris Manager cluster page, click the 「…」 button -> 「Parameter Configuration」 -> Select all FE nodes -> Upper right corner 「Edit Configuration」 -> Paste the generated fe.conf -> Check 「Please Confirm...」 -> 「OK」

![](img/be-conf-2.png)

Modify database configuration
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-manager.*.yaml' -p playbooks/doris/exec-init-sql.yaml
```

In this step, the s3 bucket will be configured, the following method can verify whether uploading files to the bucket is possible

Switch to root user on the fe machine, log in to the cluster
```shell
mysql -uroot -h127.0.0.1 -P 9030
```
After executing the following sql, check if a file with prefix result_ is generated in the default_resource folder of the s3 bucket. If no file is generated, please check the permissions
```shell
use information_schema;
SELECT * FROM files
INTO OUTFILE "s3://bucket_name/default_resource/result_"
FORMAT AS ORC
PROPERTIES(
    "s3.endpoint" = "https://xxx",
    "s3.access_key"= "your-ak",
    "s3.secret_key" = "your-sk"
);
```
???+ warning "Deployment Check Points"

     Confirm whether s3 storage can be used, and once configured, it cannot be changed;
    
     The s3 endpoint address must be an internal network address.

### Deploy guance-insert, guance-select and VictoriaMetrics
Initialize machines
```shell
python3 deployer.py -l cluster_name -i 'inventory/guancedb-logs-doris.*.yaml' -p playbooks/guancedb/initialize-machine.yaml 
```
Deploy VictoriaMetrics
```shell
 python3 deployer.py -l cluster_name -i 'inventory/guancedb-logs-doris-vm.*.yaml' -p playbooks/doris/init-victoria-metrics.yaml
```
Deploy guance-insert and guance-select
```shell
python3 deployer.py -l cluster_name -i 'inventory/guancedb-logs-doris.*.yaml' -p playbooks/guancedb/update-config.yaml
```


### Check Cluster Status

Check VictoriaMetrics status, IP is the machine where guance-select is deployed
```shell
guancedb-logs-doris-api-test -ip xxx -ip yyy -ip zzz
```
Check Doris components
```shell
# Check components
supervisorctl

# View logs
/var/log/supervisor/guance-select-stderr.log 
```