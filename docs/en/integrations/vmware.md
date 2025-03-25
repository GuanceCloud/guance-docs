---
title: 'VMware'
summary: 'VMware displays cluster status, host status, VM status, and other Metrics.'
__int_icon: 'icon/vmware'
dashboard:
  - desc: 'VMware'
    path: 'dashboard/en/vmware/'

monitor:
  - desc: 'VMware'
    path: 'monitor/en/vmware/'
---


<!-- markdownlint-disable MD025 -->
# VMware
<!-- markdownlint-enable -->

VMware displays cluster status, host status, VM status, and other Metrics.



## Configuration {#config}

### Preparation

* There is an intranet machine that can access VMware installed with `Datakit` and Python 3+ environment.
* The following dependent libraries are required:
    * requests
    * **pyvmomi** == 7.0
    * **openssl** == 1.1.1w

> Note: Using different package versions will cause package conflicts.

### Deployment Process

1. Enable the `python.d` collector of `Datakit`, go to the *conf.d/pythond* directory under the DataKit installation directory, copy *pythond.conf.sample* and rename it as *pythond.conf*. Example as follows:

    ```toml
    # {"version": "1.16.0", "desc": "do NOT edit this line"}

    [[inputs.pythond]]
      # Python input name
      name = 'some-python-inputs'  # required

      # System environments to run Python
      #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

      # Python path (recommended abstract Python path)
      cmd = "/root/anaconda3/envs/py3.9/bin/python" # required. python3 is recommended.

      # Python scripts relative path
      dirs = ["vm"]
    ```

    > Note: Here cmd should be changed to your own Python environment address, used to execute Python scripts, `dirs` is the script storage directory.

2. Create a directory named after the "Python package name" under the `datakit/python.d` directory, then create a Python script (`*.py`) in that directory. Taking the package name `vm` as an example, its path structure is as follows. Among them, `demo.py` is the Python script, and the filename of the Python script can be customized:

    ```shell
    datakit
       └── python.d
           ├── vm
           │   ├── vm.py
    ```

3. Write the `vm.py` script, fill in the following script example, and change `vcenter_host`, `vcenter_port`, `vcenter_user`, and `vcenter_password` to the corresponding host, port, and user information for collecting VMware data.

    <!-- markdownlint-disable MD046 -->
    ???- note "Python Script Example"

    ```python
    from datakit_framework import DataKitFramework
    from pyVim.connect import SmartConnect, Disconnect
    import requests
    from pyVmomi import vim
    import ssl
    import datetime
    import time
    
    
    class vm(DataKitFramework):
        name = "vm"
        interval = 10
        def run(self):   
            print("vm")
            s = ssl.SSLContext(ssl.PROTOCOL_TLSv1)
            s.verify_mode = ssl.CERT_NONE
    
            datakit_url_object = 'http://0.0.0.0:9529/v1/write/custom_object'
            datakit_url_metric = 'http://0.0.0.0:9529/v1/write/metric'
            vcenter_host = "10.200.14.20"
            vcenter_port = 443
            vcenter_user = "reader@zy.ops"
            vcenter_password = "Zhuyun@0906"
    
            # Data is reported in json format to Datakit so a header must be added to the POST request
            header = {
                "Content-Type": "application/json"
            }
    
            # Report data
            dk_object = []
            dk_metric = []
    
            # Connect to the vCenter Server
            c = SmartConnect(host=vcenter_host, user=vcenter_user, pwd=vcenter_password, port=vcenter_port, sslContext=s)
    
            content = c.RetrieveContent()
    
            container = content.rootFolder  # starting point to look into
            viewType = [vim.HostSystem, vim.VirtualMachine]  # object types to look for
            recursive = True  # whether we should look into it recursively
    
            # Get the number and details of vCenters
            vcenter_data = content.rootFolder.childEntity
            print("vCenter count: ", len(vcenter_data))
            for i in vcenter_data:
                dk_metric.append({
                    "measurement": "vmware",
                    "tags": {
                        "vcenter_name": str(i)
                    },
                    "fields": {
                        "vcenter_total": int(len(vcenter_data))
                    },
                    "time": int(time.time())
                })
    
    
            # Get the number and details of datastores
            datastores = content.rootFolder.childEntity[0].datastore
            for ds in datastores:
                dk_metric.append({
                    "measurement": "vmware",
                    "tags": {
                        "vcenter_datastore_name": str(ds.name)
                    },
                    "fields": {
                        "vcenter_datastore_total_capacity": int(ds.summary.capacity),
                        "vcenter_datastore_total_free_space": int(ds.summary.freeSpace),
                        "vcenter_datastore_utilization_rate": int((ds.summary.capacity - ds.summary.freeSpace) / ds.summary.capacity),
                        "vcenter_datastore_total": int(len(datastores))
                    },
                    "time": int(time.time())
                })
    
            containerView = content.viewManager.CreateContainerView(container, viewType, recursive)
    
            children = containerView.view
            print("Cluster count: ", len(children))
            for child in children:
                if isinstance(child, vim.HostSystem):
                    boot_time = child.runtime.bootTime
                    print("datae", datetime.datetime.now(boot_time.tzinfo) - boot_time)
                    print("date2", int((datetime.datetime.now(boot_time.tzinfo) - boot_time).total_seconds()))
                    dk_object.append({
                        "measurement": "vmware_esxi",
                        "tags": {
                            "name": str(child.name),
                            "model": str(child.hardware.systemInfo.model),
                            "vendor": str(child.hardware.systemInfo.vendor),
                            "uptime": str((datetime.datetime.now(boot_time.tzinfo) - boot_time))
                        },
                        "fields": {
                            "cpu_cores": str(child.hardware.cpuInfo.numCpuCores),
                            "memory": str(child.hardware.memorySize)
                        },
                        "time": int(time.time())
    
                    })
                    dk_metric.append({
                        "measurement": "vmware",
                        "tags": {
                            "esxi_name": str(child.name),
                            "esxi_model": str(child.hardware.systemInfo.model),
                            "esxi_vendor": str(child.hardware.systemInfo.vendor)
                        },
                        "fields": {
                            "cpu_cores": int(child.hardware.cpuInfo.numCpuCores),
                            "memory": int(child.hardware.memorySize),
                            "cpu_usage": int(child.summary.quickStats.overallCpuUsage),
                            "mem_usage": int(child.summary.quickStats.overallMemoryUsage),
                            "mem_utilization_rate": int(child.summary.quickStats.overallMemoryUsage / child.hardware.memorySize),
                            "uptime": int((datetime.datetime.now(boot_time.tzinfo) - boot_time).total_seconds())
                        },
                        "time": int(time.time())
                    })
                elif isinstance(child, vim.VirtualMachine):
                    if child.runtime.powerState == 'poweredOn':  # only print VMs that are powered on
                        boot_time = child.runtime.bootTime
                        dk_object.append({
                            "measurement": "vmware_vm",
                            "tags": {
                                "name": str(child.name),
                                "host_name": str(child.guest.hostName),
                                "guest_os": str(child.config.guestFullName),
                                "ip_address": str(child.guest.ipAddress),
                                "uptime": str((datetime.datetime.now(boot_time.tzinfo) - boot_time))
                            },
                            "fields": {
                                "cpu_cores":  str(child.config.hardware.numCPU),
                                "memory": str(child.config.hardware.memoryMB)
                            },
                            "time": int(time.time())
    
                        })
                        dk_metric.append({
                            "measurement": "vmware",
                            "tags": {
                                "vm_name": str(child.name),
                                "vm_host_name": str(child.guest.hostName),
                                "vm_ip_address": str(child.guest.ipAddress)
                            },
                            "fields": {
                                "cpu_cores": int(child.config.hardware.numCPU),
                                "memory": int(child.config.hardware.memoryMB),
                                "cpu_usage": int(child.summary.quickStats.overallCpuUsage),
                                "mem_usage": int(child.summary.quickStats.guestMemoryUsage),
                                "mem_utilization_rate": int(child.summary.quickStats.guestMemoryUsage / child.config.hardware.memoryMB),
                                "disk_usage": int(child.summary.storage.committed),
                                "uptime": int((datetime.datetime.now(boot_time.tzinfo) - boot_time).total_seconds())
                            },
                            "time": int(time.time())
                        })
    
    
            containerView.Destroy()      
     #       response_object = requests.post(datakit_url_object,  headers=header, json=dk_object)
     #       response_metric = requests.post(datakit_url_metric,  headers=header, json=dk_metric)
            in_data = {
                'CO': dk_object,
                'input': 'vmware_esxi,vmware_vm'
            }
            self.report(in_data)
            in_data2 = {
                'M': dk_metric,
                'input': 'vmware'
            }
            self.report(in_data2)
            Disconnect(c)
            print("--------------Success---------------")
    
    ```
    <!-- markdownlint-enable -->

4. Restart DataKit:

    ```shell
    sudo datakit service -R
    ```

## Metrics {#metric}
After configuring VMware monitoring, the default Measurement set is as follows

| Metric         |        Metric Name        | Unit         |
| ---- | :----: | ---- |
| `vcenter_total` |         Center Count        | Units       |
| `vcenter_datastore_total_capacity` |     Center Disk Total Capacity     | B      |
| `vcenter_datastore_total_free_space` | Center Disk Free Space | B      |
| `vcenter_datastore_total` | Center Disk Count | Units           |
| `cpu_cores` | CPU Core Count   | Units      |
| `memory` | Memory Size   | MB      |
| `cpu_usage` |      CPU Usage      | MHz     |
| `mem_usage` |       Memory Usage       | MB       |
| `uptime` | Uptime | Seconds       |
| `disk_usage` |     Disk Usage     | B        |

## Objects {#object}

```json
"measurement": "vmware_esxi",
            "tags": {
                "name":  "10.200.14.10",
                "model": "PowerEdge R740",
                "vendor": "Dell Inc.",
                "uptime": "120 days, 6:04:50.399418"
            },
            "fields": {
                "cpu_cores": "20",
                "memory": "410686889984"
            }
```

```json
"measurement": "vmware_vm",
                "tags": {
                    "name":  "fanjun-test",
                    "host_name": "zy-infra-sh-vm-fanjun",
                    "guest_os": "CentOS 7 (64-bit)",
                    "ip_address": "10.200.14.178",
                    "uptime": "104 days, 5:02:26.586303"
                },
                "fields": {
                    "cpu_cores":  "2",
                    "memory": "4096"
                }
```

Explanation of some fields:

| Field         | Type   | Description                |
| :----------- | :----- | :------------------ |
| `name`       | String | Hostname              |
| `model`      | String | Hardware model.          |
| `vendor`     | String | Hardware vendor          |
| `uptime`     | String | Uptime            |
| `guest_os`   | String | Virtual machine version.      |
| `ip_address` | String | Virtual machine IP address.    |
| `cpu_cores`  | String | CPU core count.      |
| `memory`     | String | Memory size (Byte). |