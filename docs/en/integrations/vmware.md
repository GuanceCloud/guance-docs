---
title: 'VMware'
summary: 'VMware displays metrics such as cluster status, host status, VM status, etc.'
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

VMware displays metrics such as cluster status, host status, VM status, etc.



## Configuration {#config}

### Preparation

* A machine with `Datakit` and Python 3+ environment installed that can access VMware
* The following dependencies are required:
    * requests
    * **pyvmomi** == 7.0
    * **openssl** == 1.1.1w

> Note: Using different package versions will cause package conflicts

### Deployment process

1. Turn on the `python.d` collector of `Datakit`, enter the *conf.d/pythond* directory under the DataKit installation directory, copy *pythond.conf.sample* and rename it to *pythond.conf*. The example is as follows:

    ```toml
    # {"version": "1.16.0", "desc": "do NOT edit this line"}

    [[inputs.pythond]]
      # Python input name
      name = 'some-python-inputs'  # required

      # System environments to run Python
      #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

      # Python path(recomment abstract Python path)
      cmd = "/root/anaconda3/envs/py3.9/bin/python" # required. python3 is recommended.

      # Python scripts relative path
      dirs = ["vm"]
    ```

    > Note: Here cmd needs to be changed to your own Python environment address, which is used to execute Python scripts, and `dirs` is the directory where the scripts are stored.

2. Create a directory named after the "Python package name" under the `datakit/python.d` directory, and then create a Python script (`.py`) in this directory. For example, the package name `vm`, its path structure is as follows. Where `demo.py` is a Python script, the file name of the Python script can be customized:

    ```shell
    datakit
       └── python.d
           ├── vm
           │   ├── vm.py
    ```

3. Write the `vm.py` script, fill in the following script example and change `vcenter_host`, `vcenter_port`, `vcenter_user`, `vcenter_password` to fill in the corresponding VMware host, port and user information.

    <!-- markdownlint-disable MD046 -->
    ???- note "Python script example"

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

            vcenter_host = "{your vcenter host}"
            vcenter_port = "{your vcenter port}"
            vcenter_user = "{your vcenter username}"
            vcenter_password = "{your vcenter password}"

            # The data is reported to Datakit in json format, so the POST request needs to add a head
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

            # Get the number and details of vCenter
            vcenter_data = content.rootFolder.childEntity
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


            # Get the number and details of datastore
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

4. Restart DataKit

    ```shell
    sudo datakit service -R
    ```

## Metrics {#metric}

After configuring VMware monitoring, the default set of metrics is as follows

| Metric                               |              Metric Name              | Unit |
| ------------------------------------ | :-----------------------------------: | ---- |
| `vcenter_total`                      |           Number of centers           | pcs  |
| `vcenter_datastore_total_capacity`   |   Total disk capacity of the center   | B    |
| `vcenter_datastore_total_free_space` | Remaining disk capacity of the center | B    |
| `vcenter_datastore_total`            |        Number of center disks         | pcs  |
| `cpu_cores`                          |          Number of CPU cores          | pcs  |
| `memory`                             |              Memory size              | MB   |
| `cpu_usage`                          |               CPU usage               | MHz  |
| `mem_usage`                          |             Memory usage              | MB   |
| `uptime`                             |             Running time              | sec  |
| `disk_usage`                         |              Disk usage               | B    |

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

Some field descriptions are as follows:

| Field        | Type   | Description                        |
| :----------- | :----- | :--------------------------------- |
| `name`       | String | Host name                          |
| `model`      | String | Hardware model.                    |
| `vendor`     | String | Hardware vendor                    |
| `uptime`     | String | Running time                       |
| `guest_os`   | String | Version of the virtual machine.    |
| `ip_address` | String | IP address of the virtual machine. |
| `cpu_cores`  | String | Number of CPU cores.               |
| `memory`     | String | Memory size ( Byte).               |
