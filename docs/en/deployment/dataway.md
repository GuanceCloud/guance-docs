# Data Gateway
---

## Introduction 

DataWay is the data gateway of Guance. When the collector reports data to Guance, it needs to pass through the DataWay gateway. The DataWay gateway has two main functions: 

- Receive the data sent by the collector, and then report it to Guance for storage, which is mostly used for the scene reported by the data agent;  
- The collected data are processed and then sent to Guance for storage, which is mostly used in the scene of data cleaning.  

Note: Guance Deployment DataWay needs to be installed on the local server before it can be used. 
## New DataWay

On the "Data Gateway" page in the Guance management background, click "New DataWay". 

![](img/19.deployment_1.png)

Enter "Name", "Binding Address" and click "Create". 

- Binding address: that is, DataWay gateway address, complete HTTP address must be filled in, such as http(s)://1.2.3.4:9528, including protocol, host address and port. Generally, the host address can use the IP address of the DataWay machine deployed, or it can be specified as a domain name, which needs to be resolved. **Note: Make sure the collector can access this address, otherwise the data collection would not be successful.**

![](img/19.deployment_2.png)

After successful creation, a new DataWay is automatically created and a DataWay installation script is generated.

![](img/19.deployment_3.png)

## Installing DataWay

The newly created DataWay supports Linux and Docker installation methods, and copies the installation script to the server where the DataWay needs to be deployed. Successful installation would prompt the information shown in the following figure. At this time, DataWay would run automatically by default. 

![](img/19.deployment_4.png)

After installation, wait for a moment to refresh the "Data Gateway" page. If you see the version number in the "Version Information" column of the newly added data gateway, it means that this DataWay has been successfully connected with Guance center, and foreground users can access data through it. 

![](img/19.deployment_6.png)

### Notes

-  Only run on Linux systems. Do not execute installation scripts on non-Linux machines such as Mac/Windows
-  About Docker form installation
   -  DataWay supports running in DOCKER mode by adding `DOCKER=1` in the execution command header 
   -  In addition to adding the setting `DOCKER=1`, you can also add the following options (**in non-Docker installations, you can also specify**)
      - `DW_BIND=<port>`: : This is the bound port of the **inside the container** (**does not exceed 50000**), which takes up the host's `10000 + <port>` port. If not specified, the port defaults to `9528`, that is, the `19528` port on the host machine is used. It is important to ensure that this port is available on the host machine. If it is not running in Docker mode, the port specified there is **the port that the host will occupy**.
      - `DW_KODO=<http://your-kodo-host:port>`: Used to specify a specific kodo server address
      - `DW_UPGRADE=1`: When upgrading, specify this option. In addition, even if it is just an upgrade, you need to specify the option `DOCKER=1` if the upgraded DataWay is running in DOCKER.
   -  It is recommended **to not install with Docker in non-Linux environments** (although Docker is already supported in mainstream Windows/Mac) 
   -  Install with Docker, **execute the installation instructions directly on the host machine instead of logging in to the Docker container and then installing**
   -  Execute `docker ps -a |grep <your-agent-uuid>` to see the container where DataWay is running (**root permissions required**)
   -  After installation, the data files, including programs, configuration files, data files and logs fall into the host directory `/dataway-data/<your-agent-uuid>/`. If you want to update the configuration file and license file, please update it in this directory of the host machine. After the update, remember to restart the container: `docker restart <dataway-container-id>`. 

## Using DataWay 

After DataWay is successfully connected with Guance center, log in to the Guance console, view all DataWay addresses on the "Integration"-"DataKit" page, select the required DataWay gateway address, obtain the DataKit installation instruction and execute it on the server, and then start collecting data. 

![](img/19.deployment_6.png)

## Manage DataWay

### Delete DataWay

On the "Data Gateway" page in the Guance management background, select the DataWay to be deleted, click "Configure", and click the "Delete" button in the lower left corner of the pop-up Edit DataWay dialog box. 

**Note:** After deleting the DataWay, you need to log in to the server where the DataWay gateway is deployed to stop the running of the DataWay, and then delete the installation directory to completely delete the DataWay. 

![](img/19.deployment_7.png)

### Upgrade DataWay

On the "Data Gateway" page in the background of Guance management, if there is an upgradeable version of DataWay, there would be an upgrade prompt at the version information office. Select the DataWay to be upgraded, click "Configure", open the DataWay pop-up box in the edit DataWay dialog box, click "Get Upgrade Script", and copy the upgrade script to the host where the DataWay is deployed for execution. 

![](img/19.deployment_8.png)

### Moify DataWay Settings

Open configuration file `dataway.yaml`：

```
bind             : ":9528"                                       # Bind address and port. If you want to adjust to 1.2.3.4, port 9538, you can configure it to 1.2.3.4:9538
remote_host      : "https://kodo.dataflux.cn/"                   # kodo service address
ws_bind:         : ":9530"                                       # datakit websocket proxy bind 
remote_ws_host   : "wss://kodo.dataflux.cn"                      # ws service address
log       : /usr/local/cloudcare/dataflux/dataway/log            # log file location
log_level : info                                                 # log level
gin_log   : /usr/local/cloudcare/dataflux/dataway/gin.log        # gin log file location

enable_internal_token : true                                     # Allow the token __internal__, where data is typed into the system workspace
enable_empty_token    : true                                     # Allow token to be empty, and then the data will be typed into the system workspace
```

### DataWay Status Management Command

**systemd**

```
Start: systemctl start dataway
Restart: systemctl restart dataway
Stop: systemctl stop dataway
```

**upstart**

```
Start: start dataway
Restart: restart dataway
Stop: stop dataway
```

**Others**

For other status management commands, please refer to the terminal prompt after successful installation.

### DataWay Related Path

The default DataWay data reporting path is `/v1/write/metrics`.

The default installation path for dataway is  `/usr/local/cloudcare/dataflux/dataway`.

DataWay default gateway address: `绑定地址/v1/write/metrics`

```
dataway.yaml： DataWay configuration file
install.log：DataWay installation log
log：DataWay running log
```


