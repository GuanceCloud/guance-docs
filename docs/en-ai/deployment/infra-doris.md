# Doris Deployment

???+ warning "Note"
     Choose either OpenSearch or Doris.

## Description
### Component Description
* Doris Manager: Used for deployment, upgrade, and configuration changes of the Doris cluster.
* Doris FE: Primarily responsible for handling user requests, query parsing and planning, metadata management, and node management.
* Doris BE: Primarily responsible for data storage and execution of query plans.
* guance-insert: Receives line protocol formatted data, accumulates locally (usually using tmpfs due to low space usage), and writes in batches to Doris BE.
* guance-select: Translates DQL queries into SQL; most queries use Doris FE, while a few use the Doris BE Thrift interface.
* VictoriaMetrics: Stores write volume metrics at the index level, providing auxiliary information for sampling queries and other functions.

### Server Description
Typically, the following three groups of machines are used. Small clusters can also be co-located, with the server system OS preferably being Ubuntu.

* doris-fe: CPU to memory ratio 1:2, one data disk of over 20GB for metadata storage, the first machine can deploy Doris Manager.
* doris-be: CPU to memory ratio 1:8, adjust disk configuration to maximize disk throughput (number of disks).
* guancedb-logs: CPU to memory ratio 1:2, can be deployed on hosts or containers; the first machine needs a data disk to deploy VictoriaMetrics for storing some Doris metadata metrics.
* CPUs must support the AVX2 instruction set.
* Other machines should not preempt resources (CPU steal should not be too high).

### Network Description
* Doris Manager is typically deployed on the doris-fe-01 server, which needs SSH access to all Doris machines and access to port 8004.
* The guancedb-logs machine needs to install supervisor via the system package manager (APT).
* MySQL protocol access to port 9030 on the FE machine is required, usually by installing mysql-client on the machine where Doris Manager is located.
* The guancedb-logs machine needs access to ports 8030 and 9030 on the doris-fe machines; ports 8040 and 9060 on the doris-be machines; and port 8428 on the first guancedb-logs machine.
* Provided accounts need full permissions for the S3 bucket.

### Deployment Description
* Once configured, the S3 bucket cannot be modified. If modification is needed, data must be cleared and the Doris cluster reinstalled.
* Doris is deployed via **hosts**. Regardless of network availability, the package must first be placed in the designated location.

| Category           | Description                                           |
|--------------|----------------------------------------------| 
| **Components Deployed on Hosts**  | be + fe + manager + guancedb-logs            | | 
| **Prerequisites for Deployment**   | 1. Provide root password and support passwordless SSH login as root<br/>2. CPU architecture supports AVX2 instruction set |

## Default Deployment Configuration Information
| Category          | Description              |
|-------------|-----------------| 
| **Host Deployment**    | Refer to **Host Deployment Instructions** below | |

???+ warning "Host Deployment Instructions"

    There is only one guancedb-logs machine, providing <<< custom_key.brand_name >>> business services at host IP:8480/8481;
    
    Multiple guancedb-logs machines:
    
    a. If ELB capability is available, use ELB to listen on multiple guancedb-logs 8480/8481 ports, and the business service address will be ELB IP:8480/8481;
    
    b. If ELB capability is not available, create a service within the business cluster, and the business service address will be:
    
    Write: internal-doris-insert.middleware:8480
    
    Read: internal-doris-select.middleware:8481
    
    Refer to the following YAML to create the service

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
      # List all guancedb-logs machines here
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
      # List all guancedb-logs machines here
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

### Pre-deployment Preparation
#### Downloading the Package
Install the tool package. Place the installation package on the fe-01 machine.
```shell
https://<<< custom_key.static_domain >>>/guancedb/guancedb-doris-deploy-latest.tar.gz
```

After extracting the downloaded package, it contains SelectDB + manager installation packages. Place the installation package on the fe-01 machine, in the folder path configured in inventory/doris-manager.vars.yaml.
```shell
https://<<< custom_key.static_domain >>>/guancedb/selectdb-latest.tar.gz
```

After extracting the downloaded package, it contains GuanceDB installation packages. Place the installation package on all guancedb-logs machines, in the folder path configured in inventory/guancedb-logs-doris.vars.yaml.
```shell
https://<<< custom_key.static_domain >>>/guancedb/guancedb-cluster-linux-amd64-latest.tar.gz
```

After extracting the downloaded package, it contains VictoriaMetrics + vmutils installation packages. Place the installation package on all guancedb-logs machines, in the folder path configured in inventory/guancedb-logs-doris.vars.yaml.
```shell
https://<<< custom_key.static_domain >>>/guancedb/vmutils-latest.tar.gz
```

#### Configure Passwordless SSH Login Between Machines
On the jump server (usually on fe-01), check if the current user has a public key in ~/.ssh. If no public key exists, generate it and send it remotely to other role machines.
```shell
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub  root@192.168.xxx.xxx
```
???+ warning "Deployment Checkpoints"
     
     Verify that the be and fe machine configurations are identical;
    
     Network ping between be and fe machines should not exceed 1ms;
    
     Ensure that the provided data disks are raw (not partitioned or formatted).

### Preparing the hosts File
The inventory directory requires five hosts files:

* doris-be.hosts.yaml
* doris-fe.hosts.yaml
* doris-manager.hosts.yaml
* guancedb-logs-doris.hosts.yaml
* guancedb-logs-doris-vm.hosts.yaml

Each host file format is as follows:

The name field must be in the format xxx-doris-fe-01 or xxx-doris-be-01

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

# name:          Marks the cluster, can be poc or prd
# hosts.name:    Marks the server role, can be xxx-doris-be-01, xxx can be poc or prd
# hosts.port:    SSH port, generally 22
# hosts.host:    SSH target machine's IP
# hosts.user:    SSH target machine's user, generally root
# vars.default_ipv4: IP address of be-01
```
???+ warning "Notes"

    Typically, manager is deployed together with fe, so the content of doris-manager.hosts.yaml is the same as doris-fe.hosts.yaml. If doris-fe.hosts.yaml contains multiple fe hosts, only fill in fe-01 in doris-manager.hosts.yaml.
    
    The content of guancedb-logs-doris-vm.hosts.yaml is the same as guancedb-logs-doris.hosts.yaml. If guancedb-logs-doris.hosts.yaml contains multiple hosts, only fill in one in guancedb-logs-doris-vm.hosts.yaml.

### Configure Variables
Modify the inventory/doris-manager.vars.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # Fill in the path to the Doris installation package on the machine; e.g., /root/packages/xxx.tar.gz
      doris_local_path: 
      # Fill in the path to the Doris Manager installation package on the machine; e.g., /root/packages/xxx.tar.gz
      manager_local_path:

      # Not required if cold storage is not used
      oss_endpoint:
      oss_bucket:
      # Optional
      oss_region:
      # Generally not required when using cloud provider object storage; required when using self-built object storage or endpoint is an IP, fill in 'path'
      addressing_style:
```
Modify the inventory/doris.vars.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # Number of replicas
      replication_factor:
      # FE machine memory GB
      fe_host_mem_gb:
      # Number of FE machines
      fe_num:
      # Number of BE machines
      be_num:
      # Number of cores on BE machines
      be_host_core_num:
      # Number of BE data disks
      be_data_disk_num:
      # Size of single BE data disk in GB
      be_data_disk_gb:
      # FE log retention time
      fe_log_retention: 3d
      # Internal network segment for FE and BE machines
      cidr: 
```
Modify the inventory/guancedb-logs-doris.vars.yaml file
```shell
  - name: xxx
    vars:
      # Version number is no longer used, leave blank
      version: ""
      # Fill in the directory where the installation package is located on the machine; e.g., /root/packages
      local_dir:
```
Modify the inventory/secrets.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # zyadmin user password for the operating system, recommended to use a strong password for security
      os_zyadmin_password:
      # doris user password for the operating system, recommended to use a strong password for security
      os_doris_password:
      # root database user password, recommended to use a strong password
      doris_root_password:
      # user_read database user password, recommended to use a strong password
      doris_user_read_password:
      # Object storage access key, not required if cold storage is not used
      oss_ak:
      # Object storage secret key, not required if cold storage is not used
      oss_sk:
      # URLs for self-monitoring data reporting, usually only one entry is needed, optional
      dataway_urls: []
      # Whether to set hostname, set to false for co-location
      set_hostname: false
```
### Install Python Dependencies
```shell
pip3 install -r requirements.txt
```

### Deploy Doris Manager
Initialize the machines, then check disk mounting.
```shell
python3 deployer.py -l clusrer_name -i 'inventory/doris-?e.*.yaml' -p playbooks/doris/initialize-machine.yaml
```
???+ warning "Deployment Checkpoints"
     
     Verify correct disk mounting on servers;
    
     Ensure swap is permanently disabled on servers;
    
     Ensure the vm.max_map_count parameter on servers is set to 2000000.

Update Datakit configuration for self-monitoring data reporting.
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-?e.*.yaml' -p playbooks/doris/update-datakit.yaml
```

Download and start Doris Manager.
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-manager.*.yaml' -p playbooks/doris/initialize-manager.yaml
```

Configure cgroup for be nodes

Determine whether the server supports cgroup v1 or v2.

```shell
If this path exists, it indicates that cgroup v1 is currently active
ls /sys/fs/cgroup/cpu/

If this path exists, it indicates that cgroup v2 is currently active
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
	# Verify
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
Access URL: http://doris-fe-01:8004

**Create Doris Manager Admin Account**
![](img/doris-manager-1.png)
**Service Configuration**

- Disable monitoring alert service
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
- BE data storage directories: Each data disk corresponds to one input box, /data1/doris/data, /data2/doris/data, etc.

![](img/doris-3.png)
![](img/doris-4.png)

**Deploy Cluster**
![](img/doris-5.png)
![](img/doris-6.png)

#### Configure Doris Cluster

Modify segmentation configuration, parameters need to be changed to the cluster name
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-be.*.yaml' -p playbooks/doris/update-be.yaml
```
Render Doris configuration in the doris-conf directory, check if cluster_name-be.conf and cluster_name-fe.conf are generated under the doris-conf directory
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris.vars.yaml' -p playbooks/doris/render-config.yaml
```
???+ warning "Deployment Checkpoints"

     Verify that the storage_path in the configuration file is correctly configured;
    
     Verify that the priority_networks in the configuration file is correctly configured.

Modify BE configuration: In the Doris Manager cluster page, click the «…» button in the top right corner -> «Parameter Configuration» -> Select all BE nodes -> Click «Edit Configuration» in the top right corner -> Paste the generated be.conf -> Check «Please confirm...» -> «Confirm»

![](img/be-conf-1.png)
![](img/be-conf-3.png)

Modify FE configuration: In the Doris Manager cluster page, click the «…» button in the top right corner -> «Parameter Configuration» -> Select all FE nodes -> Click «Edit Configuration» in the top right corner -> Paste the generated fe.conf -> Check «Please confirm...» -> «Confirm»

![](img/be-conf-2.png)

Modify database configuration
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-manager.*.yaml' -p playbooks/doris/exec-init-sql.yaml
```

This step configures the S3 bucket. You can verify if files can be uploaded to the bucket using the following method:

Switch to the root user on the fe machine and log in to the cluster.
```shell
mysql -uroot -h127.0.0.1 -P 9030
```
Execute the following SQL to check if files with the prefix `result_` are created in the `default_resource` folder of the S3 bucket. If no files are generated, check the permissions.
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
???+ warning "Deployment Checkpoints"

     Ensure that the S3 storage can be used and that the configuration cannot be changed after setup;
    
     The S3 endpoint address must be an internal network address.

### Deploy guance-insert, guance-select, and VictoriaMetrics
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

Check VictoriaMetrics status, IP is the machine where guance-select is deployed.
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