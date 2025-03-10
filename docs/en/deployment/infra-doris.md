# Doris Deployment

???+ warning "Note"
     Choose either OpenSearch or Doris.

## Description
### Component Description
* Doris Manager: Used for deployment, upgrade, and configuration changes of the Doris cluster.
* Doris FE: Mainly responsible for user request access, query parsing planning, metadata management, and node-related tasks.
* Doris BE: Mainly responsible for data storage and execution of query plans.
* guance-insert: Receives line protocol formatted data, accumulates it locally (usually using tmpfs due to lower space usage), and writes it in batches to Doris BE.
* guance-select: Translates DQL queries into SQL; most queries use Doris FE, while a few use the Doris BE Thrift interface.
* VictoriaMetrics: Stores write volume metrics at the index level, providing auxiliary information for sampling queries and other functions.

### Server Description
Typically, the following three groups of machines are used. Small clusters can be mixed deployments, and the server system OS is preferably Ubuntu.

* doris-fe: CPU to memory ratio 1:2, one data disk of more than 20GB for metadata storage, the first machine can deploy Doris Manager.
* doris-be: CPU to memory ratio 1:8, adjust disk configuration (number) to maximize disk throughput.
* guancedb-logs: CPU to memory ratio 1:2, can be deployed on hosts or containers; the first machine needs a data disk to deploy VictoriaMetrics for storing some Doris metadata metrics.
* CPU must support the AVX2 instruction set.
* Resources should not be preempted by other machines (CPU steal should not be too high).

### Network Description
* Doris Manager is typically deployed on the doris-fe-01 server, which needs to communicate with all Doris machines via SSH and access port 8004.
* The guancedb-logs machine needs to install supervisor through the system package manager (APT).
* MySQL protocol access is required on port 9030 of the FE machine, usually installing mysql-client on the Doris Manager machine.
* The guancedb-logs machine needs to access ports 8030 and 9030 of the doris-fe machines; ports 8040 and 9060 of the doris-be machines; and port 8428 of the first guancedb-logs machine.
* The provided account needs full permissions for the S3 bucket.

### Deployment Description
* Once configured, the S3 bucket cannot be modified. If modification is needed, only clearing the data and reinstalling the Doris cluster is possible.
* Doris is deployed **on hosts**. Regardless of network conditions, the installation package must first be placed in the designated location.

| Category         | Description                                           |
|------------------|-------------------------------------------------------|
| **Host Deployment Components** | be + fe + manager + guancedb-logs            | 
| **Prerequisites**   | 1. Provide root password and support passwordless SSH login as root<br/>2. CPU architecture supports AVX2 instruction set |

## Default Configuration Information for Deployment
| Category        | Description              |
|-----------------|--------------------------|
| **Host Deployment** | Refer to **Host Deployment Instructions** below |

???+ warning "Host Deployment Instructions"

    For <<< custom_key.brand_name >>> business services, if there is only one guancedb-logs machine, the address used is host IP:8480/8481;

    If there are multiple guancedb-logs machines:

    a. ELB capability can be provided, using ELB to listen on multiple guancedb-logs 8480/8481 ports, and the service address used is ELB IP:8480/8481;

    b. If ELB capability cannot be provided, a service can be created in the business cluster, and the service address used is:

    Write: internal-doris-insert.middleware:8480

    Read: internal-doris-select.middleware:8481

    Refer to the following YAML to create the service

???- note "doris-service.yaml (click to expand)"
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

### Preparations
#### Download Installation Package
Install the tool package. Place the installation package on the fe-01 machine.
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/guancedb-doris-deploy-latest.tar.gz
```

After decompressing the downloaded package, it contains the SelectDB + manager installation package. Place the installation package on the fe-01 machine, in the directory specified in inventory/doris-manager.vars.yaml.
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/selectdb-latest.tar.gz
```

After decompressing the downloaded package, it contains the GuanceDB installation package. Place the installation package on all guancedb-logs machines, in the directory specified in inventory/guancedb-logs-doris.vars.yaml.
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/guancedb-cluster-linux-amd64-latest.tar.gz
```

After decompressing the downloaded package, it contains the victoria-metrics + vmutils installation package. Place the installation package on all guancedb-logs machines, in the directory specified in inventory/guancedb-logs-doris.vars.yaml.
```shell
https://static.<<< custom_key.brand_main_domain >>>/guancedb/vmutils-latest.tar.gz
```

#### Configure Passwordless SSH Login Between Machines
On the jump server (usually fe-01), check if the current user has an SSH public key in ~/.ssh. If no public key has been generated, generate it and send it remotely to other role machines using the following commands:
```shell
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub  root@192.168.xxx.xxx
```
???+ warning "Deployment Checkpoints"
     
     Verify that the configurations of be and fe machines are the same;
    
     Network ping between be and fe machines does not exceed 1ms;
    
     The provided data disks should be raw disks (not partitioned or formatted).

### Prepare Hosts File
The inventory directory requires 5 hosts files:

* doris-be.hosts.yaml
* doris-fe.hosts.yaml
* doris-manager.hosts.yaml
* guancedb-logs-doris.hosts.yaml
* guancedb-logs-doris-vm.hosts.yaml

Each host file format is as follows:

The name format must be xxx-doris-fe-01 or xxx-doris-be-01

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

# name:          Mark the cluster, can be poc or prd
# hosts.name:    Mark the server role, can be xxx-doris-be-01, xxx can be poc or prd
# hosts.port:    SSH port, usually 22
# hosts.host:    SSH target machine's IP
# hosts.user:    SSH target machine's user, usually root
# vars.default_ipv4: IP address of be-01
```
???+ warning "Note"

    Generally, the manager is deployed together with fe, so the content of doris-manager.hosts.yaml is the same as doris-fe.hosts.yaml. If doris-fe.hosts.yaml has multiple fe hosts, doris-manager.hosts.yaml only needs to fill in fe-01.

    The content of guancedb-logs-doris-vm.hosts.yaml is the same as guancedb-logs-doris.hosts.yaml. If guancedb-logs-doris.hosts.yaml has multiple hosts, guancedb-logs-doris-vm.hosts.yaml only needs to fill in one.

### Configure Variables
Modify the inventory/doris-manager.vars.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # Path to the Doris installation package on the machine; e.g., /root/packages/xxx.tar.gz
      doris_local_path: 
      # Path to the Doris Manager installation package on the machine; e.g., /root/packages/xxx.tar.gz
      manager_local_path:

      # Leave blank if cold storage is not used
      oss_endpoint:
      oss_bucket:
      # Can be left blank
      oss_region:
      # When using cloud provider object storage, usually not filled; when using self-built object storage or endpoint is an IP, fill in 'path'
      addressing_style:
```
Modify the inventory/doris.vars.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # Replication factor
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
      # Internal network segment of FE and BE machines
      cidr: 
```
Modify the inventory/guancedb-logs-doris.vars.yaml file
```shell
  - name: xxx
    vars:
      # Version number is no longer used, leave empty
      version: ""
      # Directory where the installation package is located on the machine; e.g., /root/packages
      local_dir:
```
Modify the inventory/secrets.yaml file
```shell
clusters:
  - name: xxx
    vars:
      # zyadmin user password for the operating system, recommend using a strong password
      os_zyadmin_password:
      # doris user password for the operating system, recommend using a strong password
      os_doris_password:
      # root database user password, recommend using a strong password
      doris_root_password:
      # user_read database user password, recommend using a strong password
      doris_user_read_password:
      # Object storage access key, leave blank if cold storage is not used
      oss_ak:
      # Object storage secret key, leave blank if cold storage is not used
      oss_sk:
      # Used for reporting self-monitoring data, usually only one entry is needed, can be left blank
      dataway_urls: []
      # Whether to set hostname, set to false for mixed deployments
      set_hostname: false
```
### Install Python Dependencies
```shell
pip3 install -r requirements.txt
```

### Deploy Doris Manager
Initialize the machine, then check disk mounting after completion.
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-?e.*.yaml' -p playbooks/doris/initialize-machine.yaml
```
???+ warning "Deployment Checkpoints"
     
     Verify correct disk mounting on the server;
    
     Ensure swap is permanently disabled on the server;
    
     Ensure the server's vm.max_map_count parameter is set to 2000000.

Update Datakit configuration for reporting self-monitoring data.
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-?e.*.yaml' -p playbooks/doris/update-datakit.yaml
```

Download and start Doris Manager.
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-manager.*.yaml' -p playbooks/doris/initialize-manager.yaml
```

Configure cgroup for be nodes

Determine whether the server supports cgroup v1 or v2

```shell
If this path exists, cgroup v1 is currently effective
ls /sys/fs/cgroup/cpu/

If this path exists, cgroup v2 is currently effective
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
	# Enable service at boot
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
	# Enable service at boot
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
- BE data storage directory: Enter one input box per data disk, e.g., /data1/doris/data, /data2/doris/data, etc.

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
Render Doris configuration in the doris-conf directory, check if cluster_name-be.conf and cluster_name-fe.conf are generated under the doris-conf folder
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris.vars.yaml' -p playbooks/doris/render-config.yaml
```
???+ warning "Deployment Checkpoints"

     Verify that storage_path is correctly configured in the configuration file;
    
     Verify that priority_networks is correctly configured in the configuration file.

Modify BE configuration: Doris Manager cluster page top right «…» button -> «Parameter Configuration» -> Select all BE nodes -> Top right «Edit Configuration» -> Paste the generated be.conf -> Check «Confirm...» -> «OK»

![](img/be-conf-1.png)
![](img/be-conf-3.png)

Modify FE configuration: Doris Manager cluster page top right «…» button -> «Parameter Configuration» -> Select all FE nodes -> Top right «Edit Configuration» -> Paste the generated fe.conf -> Check «Confirm...» -> «OK»

![](img/be-conf-2.png)

Modify database configuration
```shell
python3 deployer.py -l cluster_name -i 'inventory/doris-manager.*.yaml' -p playbooks/doris/exec-init-sql.yaml
```

In this step, the S3 bucket will be configured. You can verify if files can be uploaded to the bucket as follows:

Switch to the root user on the fe machine and log into the cluster
```shell
mysql -uroot -h127.0.0.1 -P 9030
```
Execute the following SQL and check if files with the prefix `result_` are generated in the default_resource folder of the S3 bucket. If no files are generated, check the permissions.
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

     Confirm that the S3 storage can be used and cannot be modified after configuration;
    
     The S3 endpoint address must be an internal network address.

### Deploy guance-insert, guance-select, and VictoriaMetrics
Initialize the machine
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

Check VictoriaMetrics status, IP is the guance-select deployment machine
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