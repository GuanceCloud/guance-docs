---
title: 'VMware'
summary: 'VMware 展示集群状态、宿主机状态、VM状态等指标。'
__int_icon: 'icon/vmware'
dashboard:
  - desc: 'VMware'
    path: 'dashboard/zh/vmware/'

monitor:
  - desc: 'VMware'
    path: 'monitor/zh/vmware/'
---


<!-- markdownlint-disable MD025 -->
# VMware
<!-- markdownlint-enable -->

VMware 展示集群状态、宿主机状态、VM状态等指标



## 配置 {#config}

### 准备工作

* 有一台能够访问 VMware 的内网机器装有 `Datakit` 和 Python 3+ 环境
* 需要以下依赖库：
    * requests
    * **pyvmomi** == 7.0
    * **openssl** == 1.1.1w

> 注意：使用不同的包版本会出现包冲突的问题

### 部署流程

1. 开启 `Datakit` 的 `python.d` 采集器，进入 DataKit 安装目录下的 *conf.d/pythond* 目录，复制 *pythond.conf.sample* 并命名为 *pythond.conf*。示例如下：

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

    > 注意： 这里 cmd 要改为自己的 Python 环境地址，用于执行 Python 脚本，`dirs` 为脚本存放目录

2. 在 `datakit/python.d` 目录下创建以 "Python 包名" 命名的目录，然后在该目录下创建 Python 脚本(`.py`)。以包名 `vm` 为例，其路径结构如下。其中 `demo.py` 为 Python 脚本，Python 脚本的文件名可以自定义：

    ```shell
    datakit
       └── python.d
           ├── vm
           │   ├── vm.py
    ```

3. 编写 `vm.py` 脚本，填入如下脚本示例并更改 `vcenter_host`、 `vcenter_port`、 `vcenter_user` 、`vcenter_password` 填入相应采集 VMware 的主机、端口及用户信息。

    <!-- markdownlint-disable MD046 -->
    ???- note "Python 脚本示例"

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
    
            # 数据以 json 方式上报至 Datakit 所以 POST 请求需要加一个 head
            header = {
                "Content-Type": "application/json"
            }
    
            # 上报数据
            dk_object = []
            dk_metric = []
    
            # Connect to the vCenter Server
            c = SmartConnect(host=vcenter_host, user=vcenter_user, pwd=vcenter_password, port=vcenter_port, sslContext=s)
    
            content = c.RetrieveContent()
    
            container = content.rootFolder  # starting point to look into
            viewType = [vim.HostSystem, vim.VirtualMachine]  # object types to look for
            recursive = True  # whether we should look into it recursively
    
            # 获取 vCenter 的数量及详情
            vcenter_data = content.rootFolder.childEntity
            print("vCenter数量: ", len(vcenter_data))
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
    
    
            # 获取 datastore 的数量及详情
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
            print("Cluster数量: ", len(children))
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

4. 重启 DataKit:

    ```shell
    sudo datakit service -R
    ```

## 指标 {#metric}
配置好 VMware 监控, 默认的指标集如下

| 指标         |        指标名称        | 单位         |
| ---- | :----: | ---- |
| `vcenter_total` |         中心数量        | 个       |
| `vcenter_datastore_total_capacity` |     中心磁盘总容量     | B      |
| `vcenter_datastore_total_free_space` | 中心磁盘剩余容量 | B      |
| `vcenter_datastore_total` | 中心磁盘个数 | 个           |
| `cpu_cores` | CPU 核心数量   | 个      |
| `memory` | 内存大小   | MB      |
| `cpu_usage` |      CPU 使用量      | MHz     |
| `mem_usage` |       内存使用量       | MB       |
| `uptime` | 运行时间 | 秒       |
| `disk_usage` |     磁盘使用量     | B        |

## 对象 {#object}

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

部分字段说明如下：

| 字段         | 类型   | 说明                |
| :----------- | :----- | :------------------ |
| `name`       | String | 主机名              |
| `model`      | String | 硬件模型。          |
| `vendor`     | String | 硬件供应商          |
| `uptime`     | String | 运行时间            |
| `guest_os`   | String | 虚拟机的版本。      |
| `ip_address` | String | 虚拟机的IP地址。    |
| `cpu_cores`  | String | CPU 核心数量。      |
| `memory`     | String | 内存大小（ Byte）。 |

